-- mod support (moreblocks/technic_worldgen)
local slab_str = "stairs:slab_wood"
local modname  = minetest.get_current_modname() or 'drinks'
local modpath  = minetest.get_modpath(modname)

function applyModSupport()
   local moreblocks_found = false
   local technic_worldgen = false

   local modnames = minetest.get_modnames()

   for i, name in ipairs(modnames) do
      -- minetest.log("[Mod] " .. name)
      if name == "moreblocks" then
         moreblocks_found = true
      end

      if name == "technic_worldgen" then
         technic_worldgen = true
      end
   end

   if moreblocks_found == true and technic_worldgen == true then
      minetest.log("applying patch to mod " .. minetest.get_current_modname())
      minetest.log("converting '" .. slab_str .. "' to 'moreblocks:slab_wood'")
      slab_str = "moreblocks:slab_wood"
   end
end
--applyModSupport()

--Craft Recipes

-- added mod-support
minetest.register_craft({
      output = 'drinks:juice_press',
      recipe = {
         {'default:stick', 'default:steel_ingot', 'default:stick'},
         {'default:stick', 'bucket:bucket_empty', 'default:stick'},
         {slab_str, slab_str, 'vessels:drinking_glass'},
         }
})

-- added mod-support
minetest.register_craft({
      output = 'drinks:liquid_barrel',
      recipe = {
         {'group:wood', 'group:wood', 'group:wood'},
         {'group:wood', 'group:wood', 'group:wood'},
         {slab_str, '', slab_str},
         }
})

drinks = {
drink_table = {},
juiceable = {},
shortname = {
   ['jcu'] = {size = 2, name = 'vessels:drinking_glass'},
   ['jbo'] = {size = 4, name = 'vessels:glass_bottle'},
   ['jsb'] = {size = 4, name = 'vessels:steel_bottle'},
   ['jbu'] = {size = 16, name = 'bucket:bucket_empty'}
},
longname = {
   ['vessels:drinking_glass'] = {size = 2, name = 'jcu'},
   ['vessels:glass_bottle'] = {size = 4, name = 'jbo'},
   ['vessels:steel_bottle'] = {size = 4, name = 'jsb'},
   ['bucket:bucket_empty'] = {size = 16, name = 'jbu'},
   ['thirsty:steel_canteen'] = {size = 20, name = 'thirsty:steel_canteen'},
   ['thirsty:bronze_canteen'] = {size = 30, name = 'thirsty:bronze_canteen'},
},
}
drinks.mod = 'ia'


-- Honestly not needed for default, but used as an example to add support to other mods.
-- Basically to use this all you need to do is add the name of the fruit to make juiceable (see line 14 for example)
-- Add the new fruit to a table like I've done in line 16.
-- The table should follow this scheme: internal name, Displayed name, colorize code.
-- Check out the drinks.lua file for more info how how the colorize code is used.

local priority     = {
	"ethereal",
	'fruit',
	"farming",
	"crops",
	'farming_plus',
	"bushes_classic",
	"default",
}

local juice_config = {
    apple        = {
        label   = "Apple",
        color   = "#ECFF56",
        sources = {
	    default        = "default:apple",
	    ethereal       = "ethereal:apple",
	},
    },
    banana       = {
	label   = 'Banana',
        color   = '#ECED9F',
	sources = {
	    ethereal       = 'ethereal:banana',
	    farming_plus   = 'farming_plus:banana',
	},
    },
    blackberries = {
	label   = 'Blackberry',
	color   = '#581845',
	sources = {
	    bushes_classic = 'bushes_classic:blackberry',
	    farming        = 'farming:blackberry',
        },
    },
    blueberries  = {
        label   = "Blueberry",
        color   = "#521DCB",
        sources = {
            bushes_classic = "bushes_classic:blueberry",
            default        = "default:blueberries",
            farming        = "farming:blueberries",
        },
    },
    cactus       = {
        label   = 'Cactus',
	color   = '#96F97B',
	sources = {
	    default        = "default:cactus",
        },
    },
    carrot       = {
	label   = 'Carrot',
	color   = '#ED9121',
	sources = {
	    farming        = 'farming:carrot',
	},
    },
    coconut      = {
	label   = 'Coconut',
	color   = '#FFFFFF',
	sources = {
	    ethereal       = 'ethereal:coconut',
	},
    },
    cucumber     = {
	label   = 'Cucumber',
	color   = '#73AF59',
	sources = {
	    farming        = 'farming:cucumber',
	},
    },
    gooseberry   = {
        label   = 'Gooseberry',
	color   = '#9CF57C',
	sources = {
	    bushes_classic = 'bushes_classic:gooseberry',
        },
    },
    grapes       = {
	label   = 'Grape',
	color   = '#B20056',
	sources = {
	    farming        = 'farming:grapes',
	},
    },
    lemon        = {
	label   = 'Lemon',
	color   = '#FEFFAA',
	sources = {
	    farming_plus   = 'farming_plus:lemon',
	},
    },
    melon        = {
        label   = 'Melon',
	color   = '#EF4646',
	sources = {
	    crops          = 'crops:melon',
	    farming        = 'farming:melon',
	    farming_plus   = 'farming_plus:melon',
        },
    },
    orange      = {
        label   = 'Orange',
	color   = '#FFC417',
	sources = {
	    ethereal       = 'ethereal:orange',
	    farming_plus   = 'farming_plus:orange',
	    fruit          = 'fruit:orange',
	},
    },
    peach        = {
	label   = 'Peach',
	color   = '#F2BC1E',
	sources = {
	    farming_plus   = 'farming_plus:peach',
	    fruit          = 'fruit:peach',
	},
    },
    pear         = {
	label   = 'Pear',
	color   = 'ECFF56',
	sources = {
	    fruit          = 'fruit:pear',
	},
    },
    pineapple    = {
	label   = 'Pineapple',
	color   = '#DCD611',
	sources = {
	    farming        = 'farming:pineapple',
	},
    },
    plum         = {
	label   = 'Plum',
	color   = '#8E4585',
	sources = {
	    fruit          = 'fruit:plum',
	},
    },
    pumpkin      = {
	label   = 'Pumpkin',
	color   = '#FFC04C',
	sources = {
	    crops          = 'crops:pumpkin',
	    farming        = 'farming:pumpkin',
	},
    },
    raspberry    = {
	label   = 'Raspberry',
	color   = '#C70039',
	sources = {
	    bushes_classic = 'bushes_classic:raspberry',
	    farming        = 'farming:raspberries',
	    farming_plus   = 'farming_plus:raspberry',
	},
    },
    rhubarb      = {
	label   = 'Rhubarb',
	color   = '#FB8461',
	sources = {
            farming        = 'farming:rhubarb',
	    farming_plus   = 'farming_plus:rhubarb',
	},
    },
    strawberry   = {
        label   = "Strawberry",
        color   = "#FF3636",
        sources = {
            bushes_classic = "bushes_classic:strawberry",
            ethereal       = "ethereal:strawberry",
            farming        = "farming:strawberry",
            farming_plus   = "farming_plus:strawberry" -- 
        }
    },
    tomato       = {
        label   = 'Tomato',
	color   = '#D03A0E', -- #990000
	sources = {
	    crops          = 'crops:tomato',
	    farming        = 'farming:tomato',
	    farming_plus   = 'farming_plus:tomato',
	},
    },
}

for flavor_id, data in pairs(juice_config) do
    local winner, mod = ia_util.resolve_authority(data.sources, priority)

    if winner then
        -- Only one entry per flavor_id is possible here
        drinks.juiceable[winner] = true
        table.insert(drinks.drink_table, {flavor_id, data.label, data.color})
    end
end

if minetest.get_modpath('farming') then
   minetest.register_alias_force('farming:carrot_juice',    'drinks:jcu_carrot')
   minetest.register_alias_force('farming:pineapple_juice', 'drinks:jcu_pineapple')
end

-- replace craftitem to node definition
-- use existing node as template (e.g. 'vessel:glass_bottle')
--drinks.register_item = function( name, template, def )
--   local template_def = minetest.registered_nodes[template]
--   assert(template_def                    ~= nil)
--   assert(minetest.registered_nodes[name] == nil)
--   --if template_def then
--   local drinks_def = table.copy(template_def)
--
--   -- replace/add values
--   for k,v in pairs(def) do
--      if k == "groups" then
--         -- special handling for groups: merge instead replace
--         for g,n in pairs(v) do
--            drinks_def[k][g] = n
--         end
--      else
--         drinks_def[k]=v
--      end
--   end
--
--   if def.inventory_image then
--      drinks_def.wield_image = drinks_def.inventory_image
--      drinks_def.tiles = { drinks_def.inventory_image }
--   end
--
--   minetest.register_node( name, drinks_def )
--   --end
--end


--if minetest.get_modpath('thirsty') then
--   dofile(minetest.get_modpath('drinks')..'/drinks.lua')
--else
--   dofile(minetest.get_modpath('drinks')..'/drinks2.lua')
--end
dofile(modpath..DIR_DELIM..'drinks.lua')
dofile(modpath..DIR_DELIM..'drink_machines.lua')
dofile(modpath..DIR_DELIM..'formspecs.lua')
