// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6e3c826b1814cab6;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_6a81d072;

/*
	Name: init
	Namespace: namespace_6a81d072
	Checksum: 0x2A61B067
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._pentagon_no_power = "n";
	level._pentagon_fire_sale = "f";
	level flag::wait_till("magicbox_initialized");
	level thread magic_box_update();
}

/*
	Name: get_location_from_chest_index
	Namespace: namespace_6a81d072
	Checksum: 0xCD296CB7
	Offset: 0x160
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function get_location_from_chest_index(chest_index)
{
	if(isdefined(chest_index) && isdefined(level.chests) && isdefined(level.chests[chest_index]) && isdefined(level.open_chest_location))
	{
		chest_loc = level.chests[chest_index].script_noteworthy;
		for(i = 0; i < level.open_chest_location.size; i++)
		{
			if(level.open_chest_location[i] == chest_loc)
			{
				return i;
			}
		}
	}
	/#
		/#
			assertmsg("" + chest_index);
		#/
	#/
}

/*
	Name: magic_box_update
	Namespace: namespace_6a81d072
	Checksum: 0xD06BC572
	Offset: 0x250
	Size: 0x338
	Parameters: 0
	Flags: Linked
*/
function magic_box_update()
{
	self endon(#"end_game");
	util::registerclientsys("box_indicator");
	util::setclientsysstate("box_indicator", level._pentagon_no_power);
	if(namespace_59ff1d6c::function_901b751c(#"hash_4e0ec3fe56f08b47") == 0)
	{
		return;
	}
	while(true)
	{
		if(!level flag::get("power_on") || level flag::get("moving_chest_now") && level.zombie_vars[#"zombie_powerup_fire_sale_on"] === 0)
		{
			box_mode = "no_power";
		}
		else if(level.zombie_vars[#"zombie_powerup_fire_sale_on"] === 1)
		{
			box_mode = "fire_sale";
		}
		else
		{
			box_mode = "box_available";
		}
		switch(box_mode)
		{
			case "no_power":
			{
				util::setclientsysstate("box_indicator", level._pentagon_no_power);
				while(!level flag::get("power_on") && level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 0)
				{
					wait(0.1);
				}
				break;
			}
			case "fire_sale":
			{
				util::setclientsysstate("box_indicator", level._pentagon_fire_sale);
				while(level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 1)
				{
					wait(0.1);
				}
				break;
			}
			case "box_available":
			{
				var_7aa396b9 = get_location_from_chest_index(level.chest_index);
				if(isdefined(var_7aa396b9))
				{
					util::setclientsysstate("box_indicator", var_7aa396b9);
				}
				while(!flag::get("moving_chest_now") && level.zombie_vars[#"zombie_powerup_fire_sale_on"] == 0)
				{
					wait(0.1);
				}
				break;
			}
			default:
			{
				util::setclientsysstate("box_indicator", level._pentagon_no_power);
				break;
			}
		}
		wait(1);
	}
}

