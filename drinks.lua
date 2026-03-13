-- ia_drinks/drinks.lua
--assert(ia_util.has_placeable_buckets_redo())
--
----local function get_on_use(satiates, quenches, return_item)
----    local heals             = satiates
----    if minetest.get_modpath('thirsty')   then
----        return function(itemstack, user, pointed_thing)
----            thirsty.drink(user, quenches, 20)
----            local  eat_func = minetest.item_eat(heals, return_item)
----            return eat_func(itemstack, user, pointed_thing)
----        end
----    end
----    if minetest.get_modpath('hunger_ng') then
----        return function(itemstack, user, pointed_thing)
----            -- hunger_ng handles the actual restoration logic; 0 prevents vanilla healing
----            local  eat_func = minetest.item_eat(0,     return_item)
----            return eat_func(itemstack, user, pointed_thing)
----        end
----    end
----    -- vanilla
----    return function(itemstack, user, pointed_thing)
----        local      eat_func = minetest.item_eat(heals, return_item)
----        return     eat_func(itemstack, user, pointed_thing)
----    end
----end
----
------ Helper to register various drink vessels and their hunger/thirst stats
----local function register_drink_vessel(id, craft, desc, inventory_image, return_item, multiplier)
----    --minetest.log('drinks.register_drink_vessel(id='..id..')')
----    local satiates = 2 * multiplier
----    local quenches = 3 * multiplier
----    local on_use   = get_on_use(satiates, quenches, return_item)
----
----    drinks.register_item(id, return_item, {
----        description = desc,
----        groups = {drink = 1},
----        juice_type = craft,
----        inventory_image = inventory_image,
----        on_use = on_use,
----    })
----
----    if minetest.get_modpath("hunger_ng") then
----        hunger_ng.add_hunger_data(id, {
----            satiates = satiates,
----            heals    = 0,
----            quenches = quenches,
----            returns  = return_item,
----        })
----    end
----end
--
---- Main Registration Loop
--minetest.log('ENTER drinks/drinks.lua')
--for i in ipairs(drinks.drink_table) do
--    local id    = drinks.drink_table[i][1] -- e.g., "apple"
--    local craft = drinks.drink_table[i][2] -- e.g., "Apple"
--    local color = drinks.drink_table[i][3]
--
--    -- 1. Handle Bucket & Liquid (using the lower-level register_liquid0)
--    -- This preserves the drinks mod's specific naming conventions
--    local source_name  = "drinks:flowspec_" .. id .. "_source"
--    local flowing_name = "drinks:flowspec_" .. id .. "_flowing"
--    local bucket_name  = "drinks:jbu_" .. id
--    local name_str     = craft .. " Juice"
--
--    minetest.log('drinks id          : '..id)
--    --minetest.log('drinks source_name : '..source_name)
--    --minetest.log('drinks flowing_name: '..flowing_name)
--    --minetest.log('drinks bucket_name : '..bucket_name)
--    assert(minetest.registered_nodes[source_name]  == nil, source_name)
--    assert(minetest.registered_nodes[flowing_name] == nil, flowing_name)
--    assert(minetest.registered_nodes[bucket_name]  == nil, bucket_name)
--    assert(minetest.registered_items[bucket_name]  == nil, bucket_name)
--
--    placeable_buckets.register_liquid0(
--        source_name,
--        flowing_name,
--        bucket_name,
--        color,
--	100,                           -- node_alpha (should be more transparent)
--        120,                           -- alpha      (should be more opaque)
--        "drinks_bucket_contents.png",  -- inventory_image (inner mask)
--        name_str,
--        {juice = 1, drink = 1}         -- groups
--    )
--    placeable_buckets.register_drink_vessels('drinks', color, id, craft)
--
----    -- 2. Add hunger_ng data for the Bucket (Large capacity)
----    --if minetest.get_modpath("hunger_ng") then
----    --    hunger_ng.add_hunger_data(bucket_name, {
----    --        satiates = 16, -- 2 * 8
----    --        heals    = 0,
----    --        quenches = 24, -- 3 * 8
----    --        returns  = 'bucket:bucket_empty',
----    --    })
----    --end
----
----    -- 3. Register Cup (jcu)
----    register_drink_vessel(
----        'drinks:jcu_' .. id,
----        craft,
----        'Cup of ' .. craft .. ' Juice',
----        'drinks_glass_contents.png^[colorize:' .. color .. ':200^drinks_drinking_glass.png',
----        'vessels:drinking_glass',
----        1
----    )
----
----    -- 4. Register Bottle (jbo)
----    register_drink_vessel(
----        'drinks:jbo_' .. id,
----        craft,
----        'Bottle of ' .. craft .. ' Juice',
----        'drinks_bottle_contents.png^[colorize:' .. color .. ':200^drinks_glass_bottle.png',
----        'vessels:glass_bottle',
----        2
----    )
----
----    -- 5. Register Steel Bottle (jsb)
----    register_drink_vessel(
----        'drinks:jsb_' .. id,
----        craft,
----        'Heavy Steel Bottle (' .. craft .. ' Juice)',
----        'vessels_steel_bottle.png',
----        'vessels:steel_bottle',
----        2
----    )
--end
--minetest.log('LEAVE drinks/drinks.lua')
-- drinks/drinks.lua
assert(ia_util.has_placeable_buckets_redo())

minetest.log('ENTER drinks/drinks.lua')

for i in ipairs(drinks.drink_table) do
    local id    = drinks.drink_table[i][1] -- e.g., "apple"
    local craft = drinks.drink_table[i][2] -- e.g., "Apple"
    local color = drinks.drink_table[i][3]
    
    local name_str = craft .. " Juice"
    
    -- Parameters common to all vessels for this liquid
    local shared_params = {
        color = color,
        is_juice = true,
        description = name_str,
        groups = {juice = 1, drink = 1}
    }

    -- 1. Register Liquid & Bucket
    -- This handles Source, Flowing, and the Bucket Item/Node
    -- old api: placeable_buckets.register_liquid0(source_name, flowing_name, bucket_name, color, 100, 120, "drinks_bucket_contents.png", name_str, {juice = 1, drink = 1})
    -- new api: placeable_buckets.register_liquid(modname, color, node_alpha, alpha, item_id, name, groups)
    --placeable_buckets.register_liquid('drinks', id, shared_params)
    --placeable_buckets.register_liquid('drinks', color, id, shared_params)
    --placeable_buckets.register_liquid('drinks', color, id, shared_params)
    --placeable_buckets.register_liquid('drinks', color, id, shared_params) 
    --local modname    = 'drinks'
    local color      = color
    --local node_alpha = 100
    --local alpha      = 120
    --local item_id    = id -- TODO
    --local name       = name_str
    --local groups     = {juice = 1, drink = 1}
--    -- 'drinks:jcu_' .. id, -- NOTE cup                of juice MUST match this format or `drinks` (and downstreams) will break
--    -- 'drinks:jbo_' .. id, -- NOTE glass       bottle of juice MUST match this format or `drinks` (and downstreams) will break
--    -- 'drinks:jsb_' .. id, -- NOTE heavy steel bottle of juice MUST match this format or `drinks` (and downstreams) will break
--    placeable_buckets.register_liquid(modname, color, node_alpha, alpha, item_id, name, groups)
--
--    -- 2. Register Cup (jcu_...)
--    -- Uses vessels:drinking_glass as return
--    placeable_buckets.register_glass_complete('drinks', id, {
--        color = color,
--        is_juice = true,
--        description = 'Cup of ' .. name_str,
--        groups = {juice = 1},
--        satiates = 2,
--        quenches = 3,
--        return_item = 'vessels:drinking_glass'
--    })
--
--    -- 3. Register Bottle (jbo_...)
--    -- Uses vessels:glass_bottle as return
--    placeable_buckets.register_bottle_complete('drinks', id, {
--        color = color,
--        is_juice = true,
--        description = 'Bottle of ' .. name_str,
--        groups = {juice = 1},
--        satiates = 4, -- 2 * 2 (multiplier handled by bottle logic)
--        quenches = 6, -- 3 * 2
--        return_item = 'vessels:glass_bottle'
--    })
--
--    -- 4. Register Heavy Steel Bottle (jsb_...)
--    -- Uses vessels:steel_bottle as return
--    placeable_buckets.register_heavy_bottle_complete('drinks', id, {
--        is_juice = true,
--        description = name_str, -- Logic appends "Heavy Steel Bottle"
--        groups = {juice = 1},
--        satiates = 4,
--        quenches = 6,
--        return_item = 'vessels:steel_bottle'
--    })
      -- Single call to register Source, Flowing, Bucket, Glass, Bottle, and Steel Bottle
    assert(color ~= nil)
    assert(id ~= nil)
    assert(name_str ~= nil)
    placeable_buckets.register_liquid(
        'drinks',      -- modname
        color,         -- color
        100,           -- node_alpha
        120,           -- alpha
        id,            -- item_id (used to generate :jcu_id, :jbo_id, etc.)
        name_str,      -- name
        {juice = 1, drink = 1}, -- groups
        'default:water_source', 'default:water_flowing', 'drinks:jbu_'..id, 'drinks:jbw_'..id)
    placeable_buckets.register_drink_vessels('drinks', color, id, name_str, 1, 0,
        --'drinks:'..id..'_source', 'drinks:'..id..'_flowing', 'drinks:bucket_'..id, 'drinks:bucket_wooden_'..id)
        'drinks:'..id..'_source', 'drinks:'..id..'_flowing', 'drinks:jbu_'..id, 'drinks:jbw_'..id)
        --'default:water_source', 'default:water_flowing')
end

minetest.log('LEAVE drinks/drinks.lua')
