---- drinks/drinks3.lua
---- NOTE if the loop can be encapsulated in a helper function and parametrized with the correct on_use and add the hunger_ng data when appropriate, then drinks{,2,3}.lua can be consolidated
----Parse Table
--for i in ipairs (drinks.drink_table) do
--   local desc = drinks.drink_table[i][1]
--   local craft = drinks.drink_table[i][2]
--   local color = drinks.drink_table[i][3]
--   local health = drinks.drink_table[i][4]
--   health = health or 1
--   -- The color of the drink is all done in code, so we don't need to have multiple images.
--
--   -- TODO also add to drinks.lua and drinks2.lua
--   -- TODO use ia_bucket
--   -- Inside your loop:
---- Register the Source Liquid
--minetest.register_node("drinks:flowspec_" .. desc .. "_source", {
--    description = craft .. " Juice Source",
--    drawtype = "liquid",
--    tiles = {
--        {
--            name = "default_water_source_animated.png^[colorize:" .. color .. ":120",
--            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
--        },
--    },
--    special_tiles = {
--        {
--            name = "default_water_source_animated.png^[colorize:" .. color .. ":120",
--            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0},
--            backface_culling = false,
--        },
--    },
--    alpha = 160,
--    paramtype = "light",
--    walkable = false,
--    pointable = false,
--    diggable = false,
--    buildable_to = true,
--    drop = "",
--    drowning = 1,
--    liquidtype = "source",
--    liquid_alternative_flowing = "drinks:flowspec_" .. desc .. "_flowing",
--    liquid_alternative_source = "drinks:flowspec_" .. desc .. "_source",
--    liquid_viscosity = 1,
--    groups = {liquid = 3, juice = 1},
--})
--
---- Register Flowing Liquid
--   -- TODO use ia_bucket
--minetest.register_node("drinks:flowspec_" .. desc .. "_flowing", {
--    drawtype = "flowingliquid",
--    tiles = {"default_water_flowing_animated.png^[colorize:" .. color .. ":120"},
--    special_tiles = {
--        {
--            name = "default_water_flowing_animated.png^[colorize:" .. color .. ":120",
--            backface_culling = false,
--            animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.8},
--        },
--    },
--    alpha = 160,
--    paramtype = "light",
--    walkable = false,
--    pointable = false,
--    diggable = false,
--    buildable_to = true,
--    drop = "",
--    drowning = 1,
--    liquidtype = "flowing",
--    liquid_alternative_flowing = "drinks:flowspec_" .. desc .. "_flowing",
--    liquid_alternative_source = "drinks:flowspec_" .. desc .. "_source",
--    liquid_viscosity = 1,
--    groups = {liquid = 3, juice = 1, not_in_creative_inventory = 1},
--})
--
--   -- TODO use ia_bucket
----Actual Node registration
--minetest.register_node('drinks:jbu_'..desc..'', {
--	description = 'Bucket of '..craft..' Juice',
--	drawtype = "plantlike",
--	tiles = {'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)'},
--	inventory_image = 'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)',
--	wield_image = 'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)',
--	paramtype = "light",
--   juice_type = craft,
--	is_ground_content = false,
--	walkable = false,
--	selection_box = {
--		type = "fixed",
--		fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25}
--	},
--	groups = {vessel=1,dig_immediate=3,attached_node=1, drink = 1},
--	sounds = default.node_sound_defaults(),
--
--	on_place = function(itemstack, placer, pointed_thing) -- make pourable & placeable
--            if not pointed_thing or pointed_thing.type ~= "node" then return end
--
--            -- SHIFT+CLICK: Place the bucket as a decorative node
--            if placer and placer:get_player_control().sneak then
--                return minetest.item_place(itemstack, placer, pointed_thing)
--            end
--
--            -- NORMAL CLICK: Pour the liquid
--            local pos = pointed_thing.above
--            local node = minetest.get_node(pos)
--            local def = minetest.registered_nodes[node.name]
--
--            if def and def.buildable_to then
--                minetest.set_node(pos, {name = "drinks:flowspec_" .. desc .. "_source"})
--                return ItemStack("bucket:bucket_empty")
--            end
--        end
--})
--   -- TODO use ia_bucket
--if minetest.get_modpath('bucket') and bucket.register_liquid then
--    -- bucket.register_liquid(source, flowing, itemname, inventory_image, name, groups, force_renew)
--    bucket.register_liquid(
--        "drinks:flowspec_" .. desc .. "_source",                             -- source
--        "drinks:flowspec_" .. desc .. "_flowing",                            -- flowing
--        "drinks:jbu_" .. desc,                                               -- itemname
--        --"drinks_bucket_contents.png^[colorize:" .. color .. ":200",        -- inventory_image
--	'bucket.png^(drinks_bucket_contents.png^[colorize:'..color..':200)', -- inventory_image
--        "Bucket of " .. craft .. " Juice",                                   -- name
--        {juice = 1}                                                          -- groups
--    )
--    -- TODO make bucket pourable & placeable
--end
--
--drinks.register_item('drinks:jcu_'..desc,  'vessels:drinking_glass', {
--   description = 'Cup of '..craft..' Juice',
--   groups = {drink=1},
--   juice_type = craft,
--   inventory_image = 'drinks_glass_contents.png^[colorize:'..color..':200^drinks_drinking_glass.png',
--   on_use = function(itemstack, user, pointed_thing) -- NOTE hunger_ng/interoperability/*.lua don't often override on_use
--      --thirsty.drink(user, 4, 20)
--      --local eat_func = minetest.item_eat(health, 'vessels:drinking_glass')
--      local eat_func = minetest.item_eat(0, 'vessels:drinking_glass')
--      return eat_func(itemstack, user, pointed_thing)
--   end,
--})
--
--drinks.register_item('drinks:jbo_'..desc, 'vessels:glass_bottle',{
--   description = 'Bottle of '..craft..' Juice',
--   groups = {drink = 1},
--   juice_type = craft,
--   inventory_image = 'drinks_bottle_contents.png^[colorize:'..color..':200^drinks_glass_bottle.png',
--   on_use = function(itemstack, user, pointed_thing) -- NOTE hunger_ng/interoperability/*.lua don't often override on_use
--      --thirsty.drink(user, 8, 20)
--      --local eat_func = minetest.item_eat((health*2), 'vessels:glass_bottle')
--      local eat_func = minetest.item_eat(0, 'vessels:glass_bottle')
--      return eat_func(itemstack, user, pointed_thing)
--   end,
--})
--
--drinks.register_item('drinks:jsb_'..desc, 'vessels:steel_bottle',{
--   description = 'Heavy Steel Bottle ('..craft..' Juice)',
--   groups = {drink = 1},
--   juice_type = craft,
--   inventory_image = 'vessels_steel_bottle.png',
--   on_use = function(itemstack, user, pointed_thing) -- NOTE hunger_ng/interoperability/*.lua don't often override on_use
--      --thirsty.drink(user, 8, 20)
--      --local eat_func = minetest.item_eat((health*2), 'vessels:steel_bottle')
--      local eat_func = minetest.item_eat(0, 'vessels:steel_bottle')
--      return eat_func(itemstack, user, pointed_thing)
--   end,
--})
--
--local satiates = 2
--local quenches = 3
----hunger_ng.add_hunger_data('drinks:jbu_'..desc..'', {
----  -- ['jbu'] = {size = 16, name = 'bucket:bucket_empty'}
----  satiates =  satiates * 8,
----  heals    =  0,
----  quenches =  quenches * 8,
----  returns  = 'bucket:bucket_empty',
----})
--hunger_ng.add_hunger_data('drinks:jcu_'..desc..'', {
--  -- glass of water quenches 1
--  -- apple satiates 4
--  -- ['jcu'] = {size = 2, name = 'vessels:drinking_glass'},
--  satiates =  satiates,
--  heals    =  0,
--  quenches =  quenches,
--  returns  = 'vessels:drinking_glass',
--})
--hunger_ng.add_hunger_data('drinks:jbo_'..desc..'', {
--  -- ['jbo'] = {size = 4, name = 'vessels:glass_bottle'},
--  satiates =  satiates * 2,
--  heals    =  0,
--  quenches =  quenches * 2,
--  returns  = 'vessels:glass_bottle',
--})
--hunger_ng.add_hunger_data('drinks:jsb_'..desc..'', {
--  -- ['jsb'] = {size = 4, name = 'vessels:steel_bottle'},
--  satiates =  satiates * 2,
--  heals    =  0,
--  quenches =  quenches * 2,
--  returns  = 'vessels:steel_bottle',
--})
--
--end














-- drinks/drinks3.lua

local function get_on_use(satiates, quenches, return_item)
    local heals             = satiates
    if minetest.get_modpath('thirsty')   then
        return function(itemstack, user, pointed_thing)
            thirsty.drink(user, quenches, 20)
            local  eat_func = minetest.item_eat(heals, return_item)
            return eat_func(itemstack, user, pointed_thing)
        end
    end
    if minetest.get_modpath('hunger_ng') then
        return function(itemstack, user, pointed_thing)
            -- hunger_ng handles the actual restoration logic; 0 prevents vanilla healing
            local  eat_func = minetest.item_eat(0,     return_item)
            return eat_func(itemstack, user, pointed_thing)
        end
    end
    -- vanilla
    return function(itemstack, user, pointed_thing)
        local      eat_func = minetest.item_eat(heals, return_item)
        return     eat_func(itemstack, user, pointed_thing)
    end
end

-- Helper to register various drink vessels and their hunger/thirst stats
local function register_drink_vessel(id, craft, desc, inventory_image, return_item, multiplier)
    --minetest.log('drinks.register_drink_vessel(id='..id..')')
    local satiates = 2 * multiplier
    local quenches = 3 * multiplier
    local on_use   = get_on_use(satiates, quenches, return_item)

    drinks.register_item(id, return_item, {
        description = desc,
        groups = {drink = 1},
        juice_type = craft,
        inventory_image = inventory_image,
        on_use = on_use,
    })

    if minetest.get_modpath("hunger_ng") then
        hunger_ng.add_hunger_data(id, {
            satiates = satiates,
            heals    = 0,
            quenches = quenches,
            returns  = return_item,
        })
    end
end

-- Main Registration Loop
minetest.log('ENTER drinks/drinks.lua')
for i in ipairs(drinks.drink_table) do
    local id    = drinks.drink_table[i][1] -- e.g., "apple"
    local craft = drinks.drink_table[i][2] -- e.g., "Apple"
    local color = drinks.drink_table[i][3]

    -- 1. Handle Bucket & Liquid (using the lower-level register_liquid0)
    -- This preserves the drinks mod's specific naming conventions
    local source_name  = "drinks:flowspec_" .. id .. "_source"
    local flowing_name = "drinks:flowspec_" .. id .. "_flowing"
    local bucket_name  = "drinks:jbu_" .. id
    local name_str     = craft .. " Juice"

    minetest.log('drinks id          : '..id)
    --minetest.log('drinks source_name : '..source_name)
    --minetest.log('drinks flowing_name: '..flowing_name)
    --minetest.log('drinks bucket_name : '..bucket_name)
    assert(minetest.registered_nodes[source_name]  == nil, source_name)
    assert(minetest.registered_nodes[flowing_name] == nil, flowing_name)
    assert(minetest.registered_nodes[bucket_name]  == nil, bucket_name)
    assert(minetest.registered_items[bucket_name]  == nil, bucket_name)

    ia_bucket.register_liquid0(
        source_name,
        flowing_name,
        bucket_name,
        color,
	100,                           -- node_alpha (should be more transparent)
        120,                           -- alpha      (should be more opaque)
        "drinks_bucket_contents.png",  -- inventory_image (inner mask)
        name_str,
        {juice = 1, drink = 1}         -- groups
    )

    -- 2. Add hunger_ng data for the Bucket (Large capacity)
    --if minetest.get_modpath("hunger_ng") then
    --    hunger_ng.add_hunger_data(bucket_name, {
    --        satiates = 16, -- 2 * 8
    --        heals    = 0,
    --        quenches = 24, -- 3 * 8
    --        returns  = 'bucket:bucket_empty',
    --    })
    --end

    -- 3. Register Cup (jcu)
    register_drink_vessel(
        'drinks:jcu_' .. id,
        craft,
        'Cup of ' .. craft .. ' Juice',
        'drinks_glass_contents.png^[colorize:' .. color .. ':200^drinks_drinking_glass.png',
        'vessels:drinking_glass',
        1
    )

    -- 4. Register Bottle (jbo)
    register_drink_vessel(
        'drinks:jbo_' .. id,
        craft,
        'Bottle of ' .. craft .. ' Juice',
        'drinks_bottle_contents.png^[colorize:' .. color .. ':200^drinks_glass_bottle.png',
        'vessels:glass_bottle',
        2
    )

    -- 5. Register Steel Bottle (jsb)
    register_drink_vessel(
        'drinks:jsb_' .. id,
        craft,
        'Heavy Steel Bottle (' .. craft .. ' Juice)',
        'vessels_steel_bottle.png',
        'vessels:steel_bottle',
        2
    )
end
minetest.log('LEAVE drinks/drinks.lua')
