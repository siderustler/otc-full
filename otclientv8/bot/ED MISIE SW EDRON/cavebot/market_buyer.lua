-- CaveBot extensions function, add it to cavebot/ folder and in cavebot.lua add line dofile("/cavebot/market_buyer.lua")

CaveBot.Extensions.MarketBuyer = {}
-- actually buy from specified player only
    
    local itemsToBuy = {
    
        [9685] = 50, -- "vampire teeth"

        [9633] = 30, -- "bloody pincers",

        [9663] = 10, -- "piece of dead brain"

        [11492] = 50, -- "rope belt"

        [20200] = 50, -- "silencer claws"

        [22730] = 10, -- "some grimeleech wings"

        [11444] = 20, -- "protective charm"

        [10311] = 25, -- "sabretooth"

        [22728] = 5, -- "vexclaw talon"

    }
    
    local market = modules.game_market

    local marketConstants = modules.gamelib
    
    local marketWindowRef = market.marketWindow

    
    MarketResolver = {}

    function MarketResolver.ReachAndOpenMarket()
    
        function openMarket()
    
            if marketWindowRef:isHidden() then
    
                print("market window hidden")
    
                local locker = getContainerByName("Locker")
    
                if not locker then
    
                    print("opening locker")
    
                    CaveBot.OpenLocker()
    
                    -- return false to check is locker opened by getContainerByName func
    
                    return false
    
                end
    
                for i, item in pairs(locker:getItems()) do
    
                    if item:getId() == 12903 then
    
                        print("opening market")
    
                        use(item)
    
                    end
    
                end
    
            end
    
            if marketWindowRef:isVisible() then
    
                print("market opened")
    
                return true
    
            end
    
            print("market is still closed")
    
            return false
    
        end
    
        if CaveBot.ReachDepot() and openMarket() then
    
            return true
    
        end
    
        return false
    
    end
    
    function MarketResolver.GetBuyAmount(itemId)
    
        local minCount = itemsToBuy[itemId] or 0
    
        print('itemId' .. itemId .. "min count " .. minCount)
    
        local currentCount = market.Market.getDepotCount(itemId) or 0
    
        print('itemId' .. itemId .. "current count " .. currentCount)
    
        local countToBuy = minCount - currentCount
    
        print('itemId' .. itemId .. "current count " .. countToBuy)
    
        -- FIXME for testing purposes
    
        local finalCount = countToBuy > 0 and countToBuy or 0
    
        print('itemId' .. itemId .. "final count " .. finalCount)
    
        return finalCount
    
    end
    
    function MarketResolver.GetMarketItem(itemId)
    
        function isItemValid(item, category)
    
            if not item or not item.marketData then
    
                return false
    
            end
    
        
    
            if not category then
    
                category = marketConstants.MarketCategory.All
    
            end
    
            if item.marketData.category ~= category and category ~= marketConstants.MarketCategory.All then
    
                return false
    
            end
    
            return true
    
        end
    
        for category = marketConstants.MarketCategory.First, marketConstants.MarketCategory.Last do
    
            if market.marketItems[category] then
    
              for i = 1, #market.marketItems[category] do
    
                local item = market.marketItems[category][i]
    
                if isItemValid(item, category) and item.marketData.tradeAs == itemId then
    
                    print("item with name " .. item.marketData.name .. " is valid ... returning item")
    
                    return item
    
                end
    
              end
    
            end
    
        end
    
        -- market item not found
    
        print("market item not found returning 0")
    
        return 0
    
    end
    
    function MarketResolver.GetMarketItemOffers(item)
    
        local itemName = item.marketData.name
    
        local spriteId = item.marketData.tradeAs
    
        if not market.searchEdit:getText():match(itemName) then
    
            print("set input state to empty")
    
            market.searchEdit:setText("")
    
            CaveBot.delay(500)
    
            market.searchEdit:setText(itemName)
    
            print("set input state to itemname " .. itemName)
    
            CaveBot.delay(500)
    
            print("return emptty table")
    
            return {}
    
        end

        CaveBot.delay(500)

        local offers = market.marketOffers[marketConstants.MarketAction.Sell]
    
        print("offers count before item widget refresh: " .. #offers)
    
        if #offers < 1 then
    
            CaveBot.delay(1000)
    
            print("offers count after item widget refresh: " .. #offers)
    
            market.Market.refreshItemsWidget(spriteId)

            CaveBot.delay(1000)
    
            print("returning offers which coutn is " .. #offers)

            return offers
    
        end

        -- reset offers if offer id is another than specified in param
        if offers[1]:getItem():getId() ~= spriteId then 
            offers = {} 
            market.Market.refreshItemsWidget(spriteId)
        end
        CaveBot.delay(500)
    
        return offers
    
     
    
    end
    
    function MarketResolver.BuyMarketItem(amount, fromPlayer, offers)
    
        for i = 1, #offers do
    
            local offer = offers[i]
    
            if offer:getPlayer():lower() == fromPlayer:lower() then
    
                print("found offer with player name " .. fromPlayer)
    
                market.selectedOffer[marketConstants.MarketAction.Sell] = offer
    
                local timestamp = offer:getTimeStamp()
    
                local counter = offer:getCounter()
    
                CaveBot.delay(1000)
                market.Market.acceptMarketOffer(amount, timestamp, counter)

    
                print("accepting market offer" .. fromPlayer)
    
                return
    
            end
    
            print("found offer but not for specified player name: " .. fromPlayer)
    
        end
    
        print("item not bought... continuing")
    
    end

CaveBot.Extensions.MarketBuyer.setup = function()
  CaveBot.registerAction("MarketBuyer", "#C300FF", function(value, retries)

    local val = string.split(value, ",")

    local buyFromPlayer = val[1]:trim():lower()
    local id = tonumber(val[2]:trim())
    local amount = tonumber(val[3]:trim())
    local respectStashed = #val > 3 and val[4]:trim():lower() == "false" and false or true968

    -- resume when too much retries
    if retries >= 200 then return false end

    if not MarketResolver.ReachAndOpenMarket() then
    
        return "retry"
    
    end
    
    -- get valid market item

    local marketItem = MarketResolver.GetMarketItem(id)

    -- market item not found
    if marketItem == 0 then
        print("provided item is not valid market item")
        return false
    end

    local offers = MarketResolver.GetMarketItemOffers(marketItem)

    if #offers < 1 then
        return "retry"
    end

    if respectStashed then
        amount = MarketResolver.GetBuyAmount(marketItem.marketData.tradeAs)
    end

    if amount == 0 then
        print("Min amount reached, continuing...")
        return true
    end
    MarketResolver.BuyMarketItem(amount, buyFromPlayer, offers)

    -- action done leave

    CaveBot.delay(1000)
    market.Market.reset()
    CaveBot.delay(1000)
    market.Market.close()

    return true
 end)

 CaveBot.Editor.registerAction("marketbuyer", "market buyer", {
  value="funbwoy,3155,100,true",
  title="Market Buyer",
  description="from, itemId, amount,\nrespectStashed (true|false)\n\nif respectStashed = true specify minAmount in itemsToBuy table\ntable in file: market_buyer.lua\n\nrespectStashed, stashInbox default value is true",
  validation = [[^[a-z\s]+,\d+,\d+,?(true|false)?$]]
 })
end