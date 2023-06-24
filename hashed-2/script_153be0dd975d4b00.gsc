// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;

#namespace namespace_3f3f1a00;

/*
	Name: __init__system__
	Namespace: namespace_3f3f1a00
	Checksum: 0x32E15BC5
	Offset: 0x1E8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_d57f57fb8d115ff", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3f3f1a00
	Checksum: 0x6F8E5B0
	Offset: 0x238
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_finalize_initialization(&init);
}

/*
	Name: __main__
	Namespace: namespace_3f3f1a00
	Checksum: 0x80F724D1
	Offset: 0x268
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_3f3f1a00
	Checksum: 0x47E7656E
	Offset: 0x278
	Size: 0x188
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.a_s_trap_buttons = struct::get_array("s_trap_button", "targetname");
	scene::add_scene_func("p8_fxanim_zm_towers_trap_switch_bundle", &function_cb307051, "init");
	level thread function_eac89317();
	var_7febdbb2 = getentarray("trig_buy_bladepillars_to_upper_south", "targetname");
	array::thread_all(var_7febdbb2, &function_ea998c9, 0, 1);
	foreach(t_crafting in level.var_4fe2f84d[#"zblueprint_trap_hellpools"])
	{
		if(t_crafting.script_noteworthy === "danu" || t_crafting.script_noteworthy === "ra")
		{
			t_crafting thread function_ea998c9(1, 0);
		}
	}
}

/*
	Name: function_cb307051
	Namespace: namespace_3f3f1a00
	Checksum: 0xEA5CFC6F
	Offset: 0x408
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_cb307051(a_ents)
{
	if(!isdefined(self.script_int))
	{
		a_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
	}
}

/*
	Name: function_81badccf
	Namespace: namespace_3f3f1a00
	Checksum: 0x79640A0B
	Offset: 0x460
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_81badccf(str_id)
{
	foreach(s_trap_button in level.a_s_trap_buttons)
	{
		if(s_trap_button.script_string === str_id)
		{
			s_trap_button thread function_8cfecd54();
		}
	}
}

/*
	Name: function_6087ebc2
	Namespace: namespace_3f3f1a00
	Checksum: 0xA7F89432
	Offset: 0x500
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_6087ebc2(str_id)
{
	foreach(s_trap_button in level.a_s_trap_buttons)
	{
		if(s_trap_button.script_string === str_id)
		{
			s_trap_button thread function_707cb9a9();
		}
	}
}

/*
	Name: function_1b229077
	Namespace: namespace_3f3f1a00
	Checksum: 0x19BB1BAE
	Offset: 0x5A0
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_1b229077(str_id)
{
	foreach(s_trap_button in level.a_s_trap_buttons)
	{
		if(s_trap_button.script_string === str_id)
		{
			s_trap_button thread function_baf2d8eb();
		}
	}
}

/*
	Name: function_eac89317
	Namespace: namespace_3f3f1a00
	Checksum: 0xADCA0F23
	Offset: 0x640
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_eac89317()
{
	level endon(#"game_ended");
	while(true)
	{
		s_notify = undefined;
		s_notify = level waittill(#"traps_activated", #"traps_available", #"traps_cooldown");
		if(isdefined(s_notify.var_be3f58a))
		{
			switch(s_notify._notify)
			{
				case "traps_activated":
				{
					function_81badccf(s_notify.var_be3f58a);
					break;
				}
				case "traps_available":
				{
					function_6087ebc2(s_notify.var_be3f58a);
					break;
				}
				case "traps_cooldown":
				{
					function_1b229077(s_notify.var_be3f58a);
					break;
				}
			}
		}
	}
}

/*
	Name: function_8cfecd54
	Namespace: namespace_3f3f1a00
	Checksum: 0xFACCDF34
	Offset: 0x770
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_8cfecd54()
{
	self thread scene::play("Shot 1");
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 0);
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 1);
}

/*
	Name: function_707cb9a9
	Namespace: namespace_3f3f1a00
	Checksum: 0x646DAFBC
	Offset: 0x808
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_707cb9a9()
{
	self thread scene::play("Shot 2");
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 0);
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
}

/*
	Name: function_baf2d8eb
	Namespace: namespace_3f3f1a00
	Checksum: 0xA8ECC20B
	Offset: 0x8A0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_baf2d8eb()
{
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_red", 0);
	self.scene_ents[#"prop 1"] clientfield::set("trap_switch_smoke", 1);
}

/*
	Name: function_ea998c9
	Namespace: namespace_3f3f1a00
	Checksum: 0xC474EC3B
	Offset: 0x918
	Size: 0x1E4
	Parameters: 2
	Flags: Linked
*/
function function_ea998c9(b_unitrigger = 0, b_eyes = 0)
{
	self endon(#"death");
	if(b_unitrigger)
	{
		if(self.script_noteworthy === "danu")
		{
			self.script_flag = "connect_starting_area_to_danu_hallway";
		}
		else
		{
			self.script_flag = "connect_starting_area_to_ra_hallway";
		}
		while(!isdefined(self.prompt_and_visibility_func))
		{
			waitframe(1);
		}
		visibility_func = self.prompt_and_visibility_func;
		self.prompt_and_visibility_func = &function_504d501c;
	}
	else
	{
		self triggerenable(0);
	}
	level flag::wait_till("all_players_spawned");
	level flag::wait_till(self.script_flag);
	if(b_eyes)
	{
		var_541193d8 = struct::get_array(#"s_trap_button");
		s_switch = arraygetclosest(self.origin, var_541193d8);
		s_switch.scene_ents[#"prop 1"] clientfield::set("trap_switch_green", 1);
	}
	if(b_unitrigger)
	{
		self.prompt_and_visibility_func = visibility_func;
	}
	else
	{
		self triggerenable(1);
	}
}

/*
	Name: function_504d501c
	Namespace: namespace_3f3f1a00
	Checksum: 0x940BB938
	Offset: 0xB08
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_504d501c(e_player)
{
	return false;
}

