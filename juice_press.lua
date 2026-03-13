-- ia_drinks/juice_press.lua
--Craft Recipes
-- TODO bulk storage compat

minetest.register_craft({
      output = 'drinks:juice_press',
      recipe = {
         {'default:stick', 'default:steel_ingot', 'default:stick'},
         {'default:stick', 'bucket:bucket_empty', 'default:stick'},
         {'stairs:slab_wood', 'stairs:slab_wood', 'vessels:drinking_glass'},
         }
})

local press_idle_formspec =
   'size[8,7]'..
   'label[1.5,0;Organic juice is just a squish away.]' ..
   'label[4.3,.75;Put fruit here ->]'..
   'label[3.5,1.75;Put container here ->]'..
   'label[0.2,1.8;4 fruits to a glass,]'..
   'label[0.2,2.1;8 fruits to a bottle,]'..
   'label[0.2,2.4;16 fruits to a bucket.]'..
   'button[1,1;2,1;press;Start Juicing]'..
   'list[current_name;src;6.5,.5;1,1;]'..
   --'list[current_name;dst;6.5,1.5;1,1;]'..
   'list[current_name;dst;6.5,1.5;2,1;]'..
   'list[current_player;main;0,3;8,4;]'

local press_running_formspec =
   'size[8,7]'..
   'label[1.5,0;Organic juice coming right up.]' ..
   'label[4.3,.75;Put fruit here ->]'..
   'label[3.5,1.75;Put container here ->]'..
   'label[0.2,1.8;4 fruits to a glass,]'..
   'label[0.2,2.1;8 fruits to a bottle,]'..
   'label[0.2,2.4;16 fruits to a bucket.]'..
   'button[1,1;2,1;press;Start Juicing]'..
   'list[current_name;src;6.5,.5;1,1;]'..
   --'list[current_name;dst;6.5,1.5;1,1;]'..
   'list[current_name;dst;6.5,1.5;2,1;]'..
   'list[current_player;main;0,3;8,4;]'

local press_error_formspec =
   'size[8,7]'..
   'label[1.5,0;You need to add more fruit.]' ..
   'label[4.3,.75;Put fruit here ->]'..
   'label[3.5,1.75;Put container here ->]'..
   'label[0.2,1.8;4 fruits to a glass,]'..
   'label[0.2,2.1;8 fruits to a bottle,]'..
   'label[0.2,2.4;16 fruits to a bucket.]'..
   'button[1,1;2,1;press;Start Juicing]'..
   'list[current_name;src;6.5,.5;1,1;]'..
   --'list[current_name;dst;6.5,1.5;1,1;]'..
   'list[current_name;dst;6.5,1.5;2,1;]'..
   'list[current_player;main;0,3;8,4;]'

local function juice_press_on_receive_fields_need_more_fruit(meta)
	meta:set_string('infotext', 'You need more fruit.')
	meta:set_string('formspec', press_error_formspec)
	return false
end

local function juice_press_on_receive_fields_drinking_glass(instack, meta, timer)
	if instack:get_count() < 4 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	meta:set_string('container', 'jcu_')
	meta:set_string('fruitnumber', 4)
	meta:set_string('infotext', 'Juicing...')
	meta:set_string('formspec', press_running_formspec)
	timer:start(4)
	return true
end

local function juice_press_on_receive_fields_glass_bottle(instack, meta, timer)
	if instack:get_count() < 8 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	meta:set_string('container', 'jbo_')
	meta:set_string('fruitnumber', 8)
	meta:set_string('infotext', 'Juicing...')
	meta:set_string('formspec', press_running_formspec)
	timer:start(8)
	return true
end

local function juice_press_on_receive_fields_steel_bottle(instack, meta, timer)
	if instack:get_count() < 8 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	meta:set_string('container', 'jsb_')
	meta:set_string('fruitnumber', 8)
	meta:set_string('infotext', 'Juicing...')
	meta:set_string('formspec', press_running_formspec)
	timer:start(8)
	return true
end

local function juice_press_on_receive_fields_bucket(instack, meta, timer)
	if instack:get_count() < 16 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	meta:set_string('container', 'jbu_')
	meta:set_string('fruitnumber', 16)
	meta:set_string('infotext', 'Juicing...')
	meta:set_string('formspec', press_running_formspec)
	timer:start(16)
	return true
end

local function juice_press_on_receive_fields_wooden_bucket(instack, meta, timer)
	if instack:get_count() < 16 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	meta:set_string('container', 'jbw_')
	meta:set_string('fruitnumber', 16)
	meta:set_string('infotext', 'Juicing...')
	meta:set_string('formspec', press_running_formspec)
	timer:start(16)
	return true
end

local function juice_press_on_receive_fields_papyrus(instack, meta, timer)
	if instack:get_count() < 2 then
		return juice_press_on_receive_fields_need_more_fruit(meta)
	end
	local under_node = {x=pos.x, y=pos.y-1, z=pos.z}
	local under_node_name = minetest.get_node_or_nil(under_node)
	local under_node_2 = {x=pos.x, y=pos.y-2, z=pos.z}
	local under_node_name_2 = minetest.get_node_or_nil(under_node_2)
	if under_node_name.name == 'drinks:liquid_barrel' then
		local meta_u = minetest.get_meta(under_node)
		local stored_fruit = meta_u:get_string('fruit')
		if fruit == stored_fruit or stored_fruit == 'empty' then
			meta:set_string('container', 'tube')
			meta:set_string('fruitnumber', 2)
			meta:set_string('infotext', 'Juicing...')
			meta_u:set_string('fruit', fruit)
			timer:start(4)
		else
			meta:set_string('infotext', "You can't mix juices.")
		end
		return true
	end
	if under_node_name_2.name == 'drinks:liquid_silo' then
		local meta_u = minetest.get_meta(under_node_2)
		local stored_fruit = meta_u:get_string('fruit')
		if fruit == stored_fruit or stored_fruit == 'empty' then
			meta:set_string('container', 'tube')
			meta:set_string('fruitnumber', 2)
			meta:set_string('infotext', 'Juicing...')
			meta_u:set_string('fruit', fruit)
			timer:start(4)
		else
			meta:set_string('infotext', "You can't mix juices.")
		end
		return true
	end
	-- NOTE the original displayed the 'need more fruit' path
	meta:set_string('infotext', 'When using papyrus in the output stack (dst), you must place a barrel or silo below this node')
	meta:set_string('formspec', press_error_formspec)
	return false
end

local juice_press_on_receive_fields_dispatch_table = {
    ['vessels:drinking_glass']                                                        = juice_press_on_receive_fields_drinking_glass,
    ['vessels:glass_bottle']                                                          = juice_press_on_receive_fields_glass_bottle,
    ['vessels:steel_bottle']                                                          = juice_press_on_receive_fields_steel_bottle,
    ['bucket:bucket_empty']                                                           = juice_press_on_receive_fields_bucket,
    ['default:papyrus']                                                               = juice_press_on_receive_fields_papyrus,
}
if ia_util.has_wooden_bucket_redo() then
    juice_press_on_receive_fields_dispatch_table['wooden_bucket:bucket_wood_empty'] = juice_press_on_receive_fields_wooden_bucket
end

minetest.register_node('drinks:juice_press', {
   description = 'Juice Press',
   _doc_items_longdesc = "A machine for creating drinks out of various fruits and vegetables.",
   _doc_items_usagehelp = "Right-click the press to access inventory and begin juicing.",
   drawtype = 'mesh',
   mesh = 'drinks_press.obj',
   tiles = {name='drinks_press.png'},
   groups = {choppy=2, dig_immediate=2,},
   paramtype = 'light',
   paramtype2 = 'facedir',
   selection_box = {
      type = 'fixed',
      fixed = {-.5, -.5, -.5, .5, .5, .5},
      },
   collision_box = {
      type = 'fixed',
      fixed = {-.5, -.5, -.5, .5, .5, .5},
      },
   on_construct = function(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      inv:set_size('main', 8*4)
      inv:set_size('src', 1)
      --inv:set_size('dst', 1)
      inv:set_size('dst', 2) -- slot 1: juice, slot 2: mash
      meta:set_string('infotext', 'Empty Juice Press')
      meta:set_string('formspec', press_idle_formspec)
   end,
   on_receive_fields = function(pos, formname, fields, sender)
      minetest.log('on_receive_fields')
      if not fields ['press'] then return end
      minetest.log('pressed')
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local timer = minetest.get_node_timer(pos)
      assert(not timer:is_started())
      local instack = inv:get_stack("src", 1)
      local fruitstack = instack:get_name()
      local mod, fruit = fruitstack:match("([^:]+):([^:]+)")
      --minetest.log('mod      : '..tostring(mod))
      --minetest.log('fruit    : '..tostring(fruit))
      --minetest.log('juiceable: '..tostring(drinks.juiceable[fruit]))
      --if not drinks.juiceable[fruit] then return end
      if not drinks.juiceable[fruitstack] then return end
      minetest.log('juiceable')

      local mash_item = "drinks:mash_" .. fruit
      local mash_out = inv:get_stack("dst", 2)

      if not mash_out:is_empty() then
          if mash_out:get_name() ~= mash_item then
              meta:set_string('infotext', 'Clear the previous fruit mash first!')
              return
          end
          if mash_out:get_free_space() == 0 then
              meta:set_string('infotext', 'Mash output slot is full!')
              return
          end
      end

      if string.find(fruit, '_') then
         local fruit, junk = fruit:match('([^_]+)_([^_]+)')
         meta:set_string('fruit', fruit)
      else
         meta:set_string('fruit', fruit)
      end
      local outstack  = inv:get_stack("dst", 1)
      local vessel = outstack:get_name()
      local dispatch  = juice_press_on_receive_fields_dispatch_table[vessel]
      local result
      if dispatch ~= nil then
         local result = dispatch(instack, meta, timer)
	 minetest.log('result: '..tostring(result))
	 return
      end
      minetest.log('no dispatch')
      meta:set_string('infotext', 'Unsupported vessel: '..vessel)
      meta:set_string('formspec', press_error_formspec)
   end,
   on_timer = function(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      local container = meta:get_string('container')
      local instack = inv:get_stack("src", 1)
      --local outstack = inv:get_stack("dst", 1) -- not used
      local fruit = meta:get_string('fruit')
      local fruitnumber = tonumber(meta:get_string('fruitnumber'))
      if container == 'tube' then
         local timer = minetest.get_node_timer(pos)
         local under_node = {x=pos.x, y=pos.y-1, z=pos.z}
         local under_node_name = minetest.get_node_or_nil(under_node)
         local under_node_2 = {x=pos.x, y=pos.y-2, z=pos.z}
         local under_node_name_2 = minetest.get_node_or_nil(under_node_2)
         if under_node_name.name == 'drinks:liquid_barrel' then

	    local mash_item = "drinks:mash_" .. fruit
            local mash_out = inv:get_stack('dst', 2)
            local mash_to_add = math.max(1, math.floor(fruitnumber / 4)) -- 1 mash per 4 fruits

            -- If someone obstructed the slot while juicing was in progress
            if not mash_out:is_empty() and mash_out:get_name() ~= mash_item then
               meta:set_string('infotext', 'Halted: Output obstructed by different item!')
               minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
               return
            end

            if mash_out:get_count() + mash_to_add > mash_out:get_stack_max() then
               meta:set_string('infotext', 'Halted: Mash output is full!')
               minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
               return
            end

            local meta_u = minetest.get_meta(under_node)
            local fullness = tonumber(meta_u:get_string('fullness'))
            instack:take_item(tonumber(fruitnumber))
            inv:set_stack('src', 1, instack)
            if fullness + 2 > 128 then
               timer:stop()
               meta:set_string('infotext', 'Barrel is full of juice.')
               return
            else
               local fullness = fullness + 2
               meta_u:set_string('fullness', fullness)
               meta_u:set_string('infotext', (math.floor((fullness/128)*100))..' % full of '..fruit..' juice.')
               meta_u:set_string('formspec', drinks.liquid_storage_formspec(fruit, fullness, 128))
               if instack:get_count() >= 2 then
                  timer:start(4)
               else
                  meta:set_string('infotext', 'You need more fruit.')
               end
            end
         elseif under_node_name_2.name == 'drinks:liquid_silo' then

	    local mash_item = "drinks:mash_" .. fruit
            local mash_out = inv:get_stack('dst', 2)
            local mash_to_add = math.max(1, math.floor(fruitnumber / 4)) -- 1 mash per 4 fruits

            -- If someone obstructed the slot while juicing was in progress
            if not mash_out:is_empty() and mash_out:get_name() ~= mash_item then
               meta:set_string('infotext', 'Halted: Output obstructed by different item!')
               minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
               return
            end

            if mash_out:get_count() + mash_to_add > mash_out:get_stack_max() then
               meta:set_string('infotext', 'Halted: Mash output is full!')
               minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
               return
            end

            local meta_u = minetest.get_meta(under_node_2)
            local fullness = tonumber(meta_u:get_string('fullness'))
            instack:take_item(tonumber(fruitnumber))
            inv:set_stack('src', 1, instack)
            if fullness + 2 > 256 then
               timer:stop()
               meta:set_string('infotext', 'Silo is full of juice.')
               return
            else
               local fullness = fullness + 2
               meta_u:set_string('fullness', fullness)
               meta_u:set_string('infotext', (math.floor((fullness/256)*100))..' % full of '..fruit..' juice.')
               meta_u:set_string('formspec', drinks.liquid_storage_formspec(fruit, fullness, 256))
               if instack:get_count() >= 2 then
                  timer:start(4)
               else
                  meta:set_string('infotext', 'You need more fruit.')
               end
            end
         end
      else

	 local mash_item = "drinks:mash_" .. fruit
         local mash_out = inv:get_stack('dst', 2)
         local mash_to_add = math.max(1, math.floor(fruitnumber / 4)) -- 1 mash per 4 fruits

         -- If someone obstructed the slot while juicing was in progress
         if not mash_out:is_empty() and mash_out:get_name() ~= mash_item then
             meta:set_string('infotext', 'Halted: Output obstructed by different item!')
             minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
             return
         end

         if mash_out:get_count() + mash_to_add > mash_out:get_stack_max() then
             meta:set_string('infotext', 'Halted: Mash output is full!')
             minetest.get_node_timer(pos):start(2) -- Wait 2 seconds and try again
             return
         end

         meta:set_string('infotext', 'Collect your juice.')
         meta:set_string('formspec', press_idle_formspec)
         instack:take_item(tonumber(fruitnumber))
         inv:set_stack('src', 1, instack)
         inv:set_stack('dst', 1 ,'drinks:'..container..fruit) -- 

         -- Output 2: Mash (The new addition)
	 local final_mash = ItemStack(mash_item .. " " .. mash_to_add)
         if mash_out:is_empty() then
             inv:set_stack('dst', 2, final_mash)
         else
             mash_out:add_item(final_mash)
             inv:set_stack('dst', 2, mash_out)
         end
      end
   end,
   on_metadata_inventory_take = function(pos, listname, index, stack, player)
      local timer = minetest.get_node_timer(pos)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      timer:stop()
      meta:set_string('infotext', 'Ready for more juicing.')
      meta:set_string('formspec', press_idle_formspec)
   end,
   on_metadata_inventory_put = function(pos, listname, index, stack, player)
      local meta = minetest.get_meta(pos)
      local inv = meta:get_inventory()
      meta:set_string('infotext', 'Ready for juicing.')
   end,
   can_dig = function(pos)
      local meta = minetest.get_meta(pos);
      local inv = meta:get_inventory()
      if inv:is_empty("src") and
         inv:is_empty("dst") then
         return true
      else
         return false
      end
   end,
   allow_metadata_inventory_put = function(pos, listname, index, stack, player)
      if listname ~= 'dst' then return 99 end
      if index ~= 1 then return 0 end
      if stack:get_name() == ('bucket:bucket_empty') then
         return 1
      elseif stack:get_name() == ('wooden_bucket:bucket_wood_empty') then
         return 1
      elseif stack:get_name() == ('vessels:drinking_glass') then
         return 1
      elseif stack:get_name() == ('vessels:glass_bottle') then
         return 1
      elseif stack:get_name() == ('vessels:steel_bottle') then
         return 1
      elseif stack:get_name() == ('default:papyrus') then
         return 1
      else
         return 0
      end
   end,
})

-- Automated Juice Press (LV-Powered)
-- Ported to Appliances API for Technic/Pipeworks support

if minetest.get_modpath("appliances") and minetest.get_modpath("pipeworks") and minetest.get_modpath("technic") then
    local S = minetest.get_translator("drinks")

    -- 1. Create the Appliance Object
    local juice_press_lv = appliances.appliance:new({
        node_name_inactive = "drinks:juice_press_lv",
        node_name_active   = "drinks:juice_press_lv_active",

        node_description   = S("Automated Juice Press"),
        node_help          = S("An LV-powered juice press with Pipeworks support."),

        input_stack        = "input",
        input_stack_size   = 2, -- Slot 1: Fruit, Slot 2: Vessel
        input_stack_width  = 2,

        have_usage         = false,

        output_stack       = "output",
        output_stack_size  = 2,
        output_stack_width = 2,
    })

    -- 2. Data Registration
    juice_press_lv:item_data_register({
        ["tube_item"] = {}, -- Pipeworks support
    })

    juice_press_lv:power_data_register({
        ["no_power"] = {
            disable = {}
        },
        ["LV_power"] = {
            demand = 150, run_speed = 1, disable = {"no_power"}
        },
    })

    -- Fix: Ensure the appliance outputs ALL items in the recipe (Juice + Mash)
    -- instead of selecting just one at random.
    function juice_press_lv:recipe_select_output(timer_step, outputs)
        -- If the output is a function (dynamic), resolve it
        if type(outputs) == "function" then
            return outputs(self, timer_step)
        end

        -- Return the entire outputs table
        -- This ensures both juice (index 1) and mash (index 2) are produced
        return outputs
    end

    -- 3. Recipe Registration Helper
    -- We map the manual juicing logic (fruit count + vessel) to the automated system
    --local function add_juice_recipe(fruit, vessel, fruit_count, result_prefix, time)
    local function add_juice_recipe(fruit_item, vessel, fruit_count, result_prefix, time)
        local mod, fruit = fruit_item:match("([^:]+):([^:]+)")
        --local fruit_item = "default:" .. fruit -- Assumes default mod for simplicity; adjust if needed -- FIXED compat; see init
        -- Note: drinks: prefixes the output based on container type (jcu_, jbo_, etc)
        local output_item = "drinks:" .. result_prefix .. fruit

        local mash_item = "drinks:mash_" .. fruit -- Define the mash item based on the fruit name
        local mash_count = math.max(1, math.floor(fruit_count / 4)) -- 1 mash per 4 fruits, matching manual logic

        if minetest.registered_items[fruit_item] and minetest.registered_items[vessel] then
            juice_press_lv:recipe_register_input("", {
                inputs = {
                    [1] = fruit_item .. " " .. fruit_count,
                    [2] = vessel
                },
                outputs = {
		    output_item,
		    mash_item .. " " .. mash_count
	        },
                production_time = time,
                consumption_step_size = 1,
            })
        end
    end

    -- 4. Port Recipes from drinks.juiceable
    -- Iterate through known juiceable fruits and register for all supported vessels
    for fruit, _ in pairs(drinks.juiceable) do
        -- Glass (4 fruit)
        add_juice_recipe(fruit, "vessels:drinking_glass", 4, "jcu_", 4)
        -- Glass Bottle (8 fruit)
        add_juice_recipe(fruit, "vessels:glass_bottle", 8, "jbo_", 8)
        -- Steel Bottle (8 fruit)
        add_juice_recipe(fruit, "vessels:steel_bottle", 8, "jsb_", 8)
        -- Bucket (16 fruit)
        add_juice_recipe(fruit, "bucket:bucket_empty", 16, "jbu_", 16)

        if minetest.get_modpath("wooden_bucket") then
            add_juice_recipe(fruit, "wooden_bucket:bucket_wood_empty", 16, "jbw_", 16)
        end
    end

    -- 5. Integration with ia_util for formspecs/callbacks
    if minetest.get_modpath('ia_util') then
        function juice_press_lv:cb_on_production(timer_step)
            return ia_util.appliances_cb_on_production(self, timer_step)
        end
        function juice_press_lv:get_formspec(meta, production_percent, consumption_percent)
            return ia_util.appliances_get_formspec(self, meta, production_percent, consumption_percent)
        end
    end

    -- 6. Node Registration
    local orig_def = minetest.registered_nodes["drinks:juice_press"]
    assert(orig_def, "Base Juice Press not found!")

    local auto_node_def = table.copy(orig_def)
    -- Remove manual logic
    auto_node_def.on_construct = nil
    auto_node_def.on_receive_fields = nil
    auto_node_def.on_timer = nil
    auto_node_def.allow_metadata_inventory_put = nil
    auto_node_def.on_metadata_inventory_put = nil
    auto_node_def.on_metadata_inventory_take = nil

    local visuals_inactive = {
        tiles = table.copy(orig_def.tiles),
    }
    local visuals_active = {
        tiles = table.copy(orig_def.tiles),
        -- You could add a color overlay here to indicate power
    }

    juice_press_lv:register_nodes(auto_node_def, visuals_inactive, visuals_active)

    -- 7. Upgrade Craft
    minetest.register_craft({
        output = "drinks:juice_press_lv",
        recipe = {
            {"default:copper_ingot", "default:mese_crystal",    "default:copper_ingot"},
            {"default:steel_ingot",  "drinks:juice_press",     "default:steel_ingot"},
            {"default:copper_ingot", "technic:lv_transformer", "default:copper_ingot"},
        }
    })
end
