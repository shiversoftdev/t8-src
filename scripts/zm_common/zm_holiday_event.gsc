// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_homunculus.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_transformation.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_maptable.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace zm_holiday_event;

/*
	Name: __init__system__
	Namespace: zm_holiday_event
	Checksum: 0x5E1F8766
	Offset: 0x128
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_holiday_event", &__init__, &__main__, #"zm_loadout");
}

/*
	Name: __init__
	Namespace: zm_holiday_event
	Checksum: 0x56BE0873
	Offset: 0x188
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"zm_holiday_event", 0))
	{
		clientfield::register("actor", "" + #"hash_59e8c30d5e28dad3", 14000, 1, "int");
		clientfield::register("scriptmover", "" + #"hash_d260ef4191c5b3d", 14000, 1, "int");
		zm_loadout::register_lethal_grenade_for_level(#"homunculus_leprechaun");
	}
}

/*
	Name: __main__
	Namespace: zm_holiday_event
	Checksum: 0x8094419B
	Offset: 0x258
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(getdvarint(#"zm_holiday_event", 0) && zm_utility::is_classic() && (!(isdefined(level.var_aa2d5655) && level.var_aa2d5655)) && zm_maptable::get_story() == 2)
	{
		level.var_3b96ad73 = getweapon(#"homunculus_leprechaun");
		if(!isdefined(level.var_fe96a4c4))
		{
			level.var_fe96a4c4 = [];
		}
		else if(!isarray(level.var_fe96a4c4))
		{
			level.var_fe96a4c4 = array(level.var_fe96a4c4);
		}
		if(!isinarray(level.var_fe96a4c4, level.var_3b96ad73))
		{
			level.var_fe96a4c4[level.var_fe96a4c4.size] = level.var_3b96ad73;
		}
		zm_weapons::register_zombie_weapon_callback(level.var_3b96ad73, &zm_weap_homunculus::function_91b8863c);
		level thread function_e95f47c2();
		/#
			level thread devgui();
		#/
	}
}

/*
	Name: function_e95f47c2
	Namespace: zm_holiday_event
	Checksum: 0x31934452
	Offset: 0x410
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_e95f47c2()
{
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"start_of_round");
		if(s_result.n_round_number == 17)
		{
			level thread function_da29ac13();
			return;
		}
	}
}

/*
	Name: function_da29ac13
	Namespace: zm_holiday_event
	Checksum: 0xA32A1F98
	Offset: 0x488
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_da29ac13()
{
	array::run_all(level.zombie_spawners, &spawner::add_spawn_function, &function_e12bc077);
	zm_spawner::register_zombie_death_event_callback(&function_cfe06357);
	level waittill(#"shamrock_finished");
	array::run_all(level.zombie_spawners, &spawner::remove_spawn_function, &function_e12bc077);
	zm_spawner::deregister_zombie_death_event_callback(&function_cfe06357);
}

/*
	Name: function_e12bc077
	Namespace: zm_holiday_event
	Checksum: 0xE5FF85BB
	Offset: 0x560
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function function_e12bc077()
{
	if(isdefined(level.var_17bf15ba) || (isdefined(level.var_c94d8a40) && level.var_c94d8a40) || self.archetype !== #"zombie")
	{
		return;
	}
	if(randomint(100) < 100)
	{
		level.var_17bf15ba = self;
		zm_transform::function_5db4f2f5(self, 1);
		while(isalive(self) && !self clientfield::get("zombie_eye_glow"))
		{
			wait(1);
		}
		if(isalive(self))
		{
			self clientfield::set("" + #"hash_59e8c30d5e28dad3", 1);
		}
		else
		{
			level.var_17bf15ba = undefined;
		}
	}
}

/*
	Name: function_cfe06357
	Namespace: zm_holiday_event
	Checksum: 0x85BEFD5C
	Offset: 0x6A0
	Size: 0x10E
	Parameters: 1
	Flags: Linked
*/
function function_cfe06357(attacker)
{
	if(!isdefined(level.var_17bf15ba) || self != level.var_17bf15ba)
	{
		return;
	}
	level.var_17bf15ba clientfield::set("" + #"hash_59e8c30d5e28dad3", 0);
	if(isplayer(attacker) && (!(isdefined(attacker.var_ccd959e1) && attacker.var_ccd959e1)))
	{
		if(!isdefined(level.var_1cd9760e))
		{
			level.var_1cd9760e = attacker;
		}
		if(attacker == level.var_1cd9760e)
		{
			self function_a33a15c();
		}
		else
		{
			level function_1443aaa();
		}
	}
	level.var_17bf15ba = undefined;
}

/*
	Name: function_a33a15c
	Namespace: zm_holiday_event
	Checksum: 0x8F5BA084
	Offset: 0x7B8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_a33a15c()
{
	if(!isdefined(level.var_d64e4374))
	{
		level.var_d64e4374 = 0;
	}
	level.var_d64e4374++;
	/#
		if(isdefined(level.var_fa38e985) && level.var_fa38e985)
		{
			iprintlnbold((("" + level.var_d64e4374) + "") + 7);
		}
	#/
	if(level.var_d64e4374 >= 7)
	{
		self thread function_ded808d5();
		level thread function_4634a866();
		level.var_1cd9760e function_efe5c28();
		level function_1443aaa(1);
	}
	else
	{
		level thread function_23287dd();
	}
}

/*
	Name: function_23287dd
	Namespace: zm_holiday_event
	Checksum: 0x92F66B07
	Offset: 0x8D0
	Size: 0x40C
	Parameters: 0
	Flags: Linked
*/
function function_23287dd()
{
	if(!isdefined(level.var_23d44713))
	{
		level.var_23d44713 = util::spawn_model("tag_origin", level.var_17bf15ba.origin + vectorscale((0, 0, 1), 60));
		level.var_23d44713 clientfield::set("" + #"hash_d260ef4191c5b3d", 1);
		level.var_c94d8a40 = 1;
	}
	a_ai_zombies = getaiteamarray(level.zombie_team);
	a_ai_zombies = array::randomize(a_ai_zombies);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(ai_zombie.archetype === #"zombie" && ai_zombie !== level.var_17bf15ba)
		{
			n_move_time = 1.5;
			zm_transform::function_5db4f2f5(ai_zombie, 1);
			while(isalive(ai_zombie))
			{
				if(100 > distancesquared(ai_zombie.origin + vectorscale((0, 0, 1), 60), level.var_23d44713.origin))
				{
					break;
				}
				level.var_23d44713 moveto(ai_zombie.origin + vectorscale((0, 0, 1), 60), n_move_time);
				wait(0.1);
				if(n_move_time > 0.1)
				{
					n_move_time = n_move_time - 0.1;
				}
			}
			if(isalive(ai_zombie))
			{
				level.var_23d44713.origin = ai_zombie.origin + vectorscale((0, 0, 1), 60);
				while(isalive(ai_zombie) && !ai_zombie clientfield::get("zombie_eye_glow"))
				{
					wait(1);
				}
				if(isalive(ai_zombie))
				{
					level.var_23d44713 playsound(#"zmb_sq_souls_impact");
					ai_zombie clientfield::set("" + #"hash_59e8c30d5e28dad3", 1);
					level.var_17bf15ba = ai_zombie;
				}
				else
				{
					level thread function_23287dd();
					return;
				}
			}
			else
			{
				level thread function_23287dd();
				return;
			}
			level.var_c94d8a40 = undefined;
			if(isdefined(level.var_23d44713))
			{
				level.var_23d44713 delete();
			}
			return;
		}
	}
	level function_1443aaa();
}

/*
	Name: function_1443aaa
	Namespace: zm_holiday_event
	Checksum: 0x69D76420
	Offset: 0xCE8
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_1443aaa(b_success = 0)
{
	/#
		if(isdefined(level.var_fa38e985) && level.var_fa38e985 && !b_success)
		{
			if(!isdefined(level.var_d64e4374))
			{
				level.var_d64e4374 = 0;
			}
			iprintlnbold(((("" + level.var_d64e4374) + "") + 7) + "");
		}
	#/
	level.var_17bf15ba = undefined;
	level.var_1cd9760e = undefined;
	level.var_d64e4374 = undefined;
	level.var_c94d8a40 = undefined;
	if(isdefined(level.var_23d44713))
	{
		level.var_23d44713 delete();
	}
}

/*
	Name: function_ded808d5
	Namespace: zm_holiday_event
	Checksum: 0xB0D11D83
	Offset: 0xDF0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_ded808d5()
{
	var_e71cdd2c = util::spawn_model("tag_origin", self.origin + vectorscale((0, 0, 1), 60));
	var_e71cdd2c clientfield::set("" + #"hash_d260ef4191c5b3d", 1);
	n_move_dist = 10;
	for(i = 0; i < 6; i++)
	{
		var_e71cdd2c movez(n_move_dist, 0.1);
		var_e71cdd2c waittill(#"movedone");
		n_move_dist = n_move_dist * -1;
	}
	var_e71cdd2c movez(9999, 4);
	var_e71cdd2c waittill(#"movedone");
	var_e71cdd2c delete();
}

/*
	Name: function_4634a866
	Namespace: zm_holiday_event
	Checksum: 0x164B564B
	Offset: 0xF40
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_4634a866()
{
	if(isdefined(level.var_47cc5401) && level.var_47cc5401)
	{
		return;
	}
	level.var_47cc5401 = 1;
	level flag::wait_till("magicbox_initialized");
	level._effect[#"hash_2ff87d61167ea531"] = #"hash_4bd4c9b0fb97f425";
	level._effect[#"hash_21167096dfea3409"] = #"hash_4bd4c9b0fb97f425";
	foreach(s_chest in level.chests)
	{
		if(isdefined(s_chest.pandora_light))
		{
			s_chest.pandora_light delete();
			s_chest thread [[level.pandora_show_func]]();
		}
		wait(0.1);
	}
}

/*
	Name: function_efe5c28
	Namespace: zm_holiday_event
	Checksum: 0x7A0D0D86
	Offset: 0x10A8
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function function_efe5c28()
{
	self.var_c21099c0 = 1;
	self.var_16fc6934 = level.var_3b96ad73;
	self.var_61c96978 = &function_55f8e11e;
	self.var_ccd959e1 = 1;
	foreach(e_player in getplayers())
	{
		if(!(isdefined(e_player.var_ccd959e1) && e_player.var_ccd959e1))
		{
			return;
		}
	}
	level notify(#"shamrock_finished");
}

/*
	Name: function_55f8e11e
	Namespace: zm_holiday_event
	Checksum: 0xB3FDD68F
	Offset: 0x1198
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_55f8e11e(e_box)
{
	self endon(#"death");
	e_box waittill(#"randomization_done");
	a_str_lines = array(#"hash_2f00ed381261784b", #"hash_2f00ec3812617698", #"hash_2f00ef3812617bb1");
	playsoundatposition(array::random(a_str_lines), e_box.origin);
	self.var_c21099c0 = 0;
	self.var_16fc6934 = undefined;
	self.var_61c96978 = undefined;
}

/*
	Name: devgui
	Namespace: zm_holiday_event
	Checksum: 0x17BDE6F5
	Offset: 0x1268
	Size: 0x1C8
	Parameters: 0
	Flags: Private
*/
function private devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"hash_83ca4038b5f2453", "");
			switch(str_command)
			{
				case "green_eyes":
				{
					level thread function_705afbf2();
					break;
				}
				case "transfer_soul":
				{
					level thread function_cf9e485();
					break;
				}
				case "hash_9411b0f797691e1":
				{
					level thread function_74441f15();
					break;
				}
				case "toggle_debug":
				{
					if(!isdefined(level.var_fa38e985))
					{
						level.var_fa38e985 = 1;
					}
					else
					{
						level.var_fa38e985 = undefined;
					}
					break;
				}
				default:
				{
					break;
				}
			}
			setdvar(#"hash_83ca4038b5f2453", "");
		}
	#/
}

/*
	Name: function_705afbf2
	Namespace: zm_holiday_event
	Checksum: 0x30BA709A
	Offset: 0x1438
	Size: 0x148
	Parameters: 0
	Flags: None
*/
function function_705afbf2()
{
	/#
		a_ai_zombies = getaiteamarray(level.zombie_team);
		e_host = getplayers()[0];
		if(!isalive(e_host))
		{
			return;
		}
		a_ai_zombies = arraysortclosest(a_ai_zombies, e_host.origin);
		foreach(ai_zombie in a_ai_zombies)
		{
			if(ai_zombie.archetype === #"zombie")
			{
				ai_zombie clientfield::set("" + #"hash_59e8c30d5e28dad3", 1);
				level.var_17bf15ba = ai_zombie;
				return;
			}
		}
	#/
}

/*
	Name: function_cf9e485
	Namespace: zm_holiday_event
	Checksum: 0xCDAC62BF
	Offset: 0x1588
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function function_cf9e485()
{
	/#
		if(!isdefined(level.var_17bf15ba))
		{
			return;
		}
		function_23287dd();
	#/
}

/*
	Name: function_74441f15
	Namespace: zm_holiday_event
	Checksum: 0x3AEB2849
	Offset: 0x15C0
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function function_74441f15()
{
	/#
		level thread function_4634a866();
		foreach(player in util::get_players())
		{
			player thread function_efe5c28();
		}
	#/
}

