// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_50c040e371c1c35f;
#using script_52c6c2d1a2ef1b46;
#using script_5660bae5b402a1eb;
#using script_57f7003580bb15e0;
#using script_6ce38ab036223e6e;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm\zm_towers_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_9861c5bc;

/*
	Name: function_89f2df9
	Namespace: namespace_9861c5bc
	Checksum: 0x847931CA
	Offset: 0x3D8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_24e2aab3e479f70e", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9861c5bc
	Checksum: 0x473F962E
	Offset: 0x428
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_7cc8a854();
	callback::on_finalize_initialization(&init);
}

/*
	Name: __main__
	Namespace: namespace_9861c5bc
	Checksum: 0x80F724D1
	Offset: 0x470
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_9861c5bc
	Checksum: 0x54E79BE4
	Offset: 0x480
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::wait_till("all_players_spawned");
	zm_crafting::function_d1f16587(#"zblueprint_trap_hellpools", &function_55d14d78);
}

/*
	Name: function_7cc8a854
	Namespace: namespace_9861c5bc
	Checksum: 0xF427FA9C
	Offset: 0x4E0
	Size: 0x3D4
	Parameters: 0
	Flags: Linked
*/
function function_7cc8a854()
{
	level.var_4a4e3bdc = getentarray("mdl_hellpool_lava_grate", "targetname");
	foreach(var_bcdc2fe7 in level.var_4a4e3bdc)
	{
		var_bcdc2fe7 flag::init("activated");
		var_bcdc2fe7 notsolid();
	}
	level.a_s_hellpool_cauldron = struct::get_array("s_hellpool_cauldron", "targetname");
	level.var_c07e6d20 = getentarray("zm_towers_hellpool_ghost", "script_label");
	foreach(part in level.var_c07e6d20)
	{
		if(part trigger::is_trigger_of_type("trigger_use_new"))
		{
			part triggerenable(0);
			continue;
		}
		part hide();
	}
	mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
	mdl_clip notsolid();
	var_d58ee8b5 = getweapon(#"hash_72cba96681a7af18");
	zm_items::function_4d230236(var_d58ee8b5, &function_b54b9d5e);
	var_9a2f8aa = getentarray("zombie_trap", "targetname");
	level.var_482bcfef = array::filter(var_9a2f8aa, 0, &function_9cc4d7b9);
	foreach(var_299f1fa2 in level.var_482bcfef)
	{
		var_299f1fa2 function_586dd237();
	}
	zm_traps::register_trap_basic_info("hellpool", &function_1d86d117, &function_722def57);
	zm_traps::register_trap_damage("hellpool", &function_506285c3, &function_db9410fa);
	level thread function_b589dae1();
	level thread function_a3661fef();
}

/*
	Name: function_b589dae1
	Namespace: namespace_9861c5bc
	Checksum: 0xF4BA534A
	Offset: 0x8C0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_b589dae1()
{
	level endon(#"end_game");
	level notify(#"hash_4cb0ebfa7040a193");
	level endon(#"hash_4cb0ebfa7040a193");
	while(true)
	{
		level waittill(#"host_migration_end");
		foreach(var_bcdc2fe7 in level.var_4a4e3bdc)
		{
			var_bcdc2fe7 notify(#"hash_5aa6001392300725");
		}
	}
}

/*
	Name: function_a3661fef
	Namespace: namespace_9861c5bc
	Checksum: 0xDBBB001F
	Offset: 0x9A8
	Size: 0x122
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a3661fef()
{
	level waittill(#"start_zombie_round_logic");
	var_6645c992 = zm_crafting::function_b18074d0(#"zblueprint_trap_hellpools");
	while(true)
	{
		level waittill(#"hash_78451720bf647f70");
		foreach(e_player in getplayers())
		{
			if(zm_crafting::function_6d1e4410(e_player, var_6645c992))
			{
				level scene::function_27f5972e(#"p8_fxanim_zm_towers_trap_acid_bundle");
				level notify(#"hash_476cae376318f3d5");
				return;
			}
		}
	}
}

/*
	Name: function_55d14d78
	Namespace: namespace_9861c5bc
	Checksum: 0xA83918EC
	Offset: 0xAD8
	Size: 0x89C
	Parameters: 0
	Flags: Linked
*/
function function_55d14d78()
{
	var_f6e18b6c = self.script_noteworthy;
	switch(var_f6e18b6c)
	{
		case "odin":
		{
			level.var_15783f81 = struct::get("zm_towers_hellpool_odin_scene", "script_noteworthy");
			level.var_15783f81 scene::init();
			var_c65eed8e = getentarray("zm_towers_hellpool_odin", "script_noteworthy");
			foreach(part in var_c65eed8e)
			{
				if(part trigger::is_trigger_of_type("trigger_use_new"))
				{
					part triggerenable(1);
					part.script_string = "its_a_trap";
					namespace_cb42c6c0::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
					continue;
				}
				part show();
			}
			foreach(s_trap_button in level.var_96471be)
			{
				if(s_trap_button.script_int === 3)
				{
					s_trap_button.scene_ents[#"hash_7aff0ee60ddd937b"] clientfield::set("trap_switch_green", 1);
				}
			}
			break;
		}
		case "zeus":
		{
			level.var_15783f81 = struct::get("zm_towers_hellpool_zeus_scene", "script_noteworthy");
			level.var_15783f81 scene::init();
			var_c65eed8e = getentarray("zm_towers_hellpool_zeus", "script_noteworthy");
			foreach(part in var_c65eed8e)
			{
				if(part trigger::is_trigger_of_type("trigger_use_new"))
				{
					part triggerenable(1);
					part.script_string = "its_a_trap";
					namespace_cb42c6c0::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
					continue;
				}
				part show();
			}
			foreach(s_trap_button in level.var_96471be)
			{
				if(s_trap_button.script_int === 4)
				{
					s_trap_button.scene_ents[#"hash_7aff0ee60ddd937b"] clientfield::set("trap_switch_green", 1);
				}
			}
			break;
		}
		case "danu":
		{
			level.var_15783f81 = struct::get("zm_towers_hellpool_danu_scene", "script_noteworthy");
			level.var_15783f81 scene::init();
			var_c65eed8e = getentarray("zm_towers_hellpool_danu", "script_noteworthy");
			foreach(part in var_c65eed8e)
			{
				if(part trigger::is_trigger_of_type("trigger_use_new"))
				{
					part triggerenable(1);
					part.script_string = "its_a_trap";
					namespace_cb42c6c0::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
					continue;
				}
				part show();
			}
			foreach(s_trap_button in level.var_96471be)
			{
				if(s_trap_button.script_int === 1)
				{
					s_trap_button.scene_ents[#"hash_7aff0ee60ddd937b"] clientfield::set("trap_switch_green", 1);
				}
			}
			break;
		}
		case "ra":
		{
			level.var_15783f81 = struct::get("zm_towers_hellpool_ra_scene", "script_noteworthy");
			level.var_15783f81 scene::init();
			var_c65eed8e = getentarray("zm_towers_hellpool_ra", "script_noteworthy");
			foreach(part in var_c65eed8e)
			{
				if(part trigger::is_trigger_of_type("trigger_use_new"))
				{
					part triggerenable(1);
					part.script_string = "its_a_trap";
					namespace_cb42c6c0::function_d67bafb5(part, "lockdown_stub_type_crafting_tables");
					continue;
				}
				part show();
			}
			foreach(s_trap_button in level.var_96471be)
			{
				if(s_trap_button.script_int === 2)
				{
					s_trap_button.scene_ents[#"hash_7aff0ee60ddd937b"] clientfield::set("trap_switch_green", 1);
				}
			}
			break;
		}
	}
	level thread zm_crafting::function_ca244624("zblueprint_trap_hellpools");
	level scene::function_f81475ae(#"p8_fxanim_zm_towers_trap_acid_bundle");
}

/*
	Name: function_b54b9d5e
	Namespace: namespace_9861c5bc
	Checksum: 0xE5998B1
	Offset: 0x1380
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_b54b9d5e(e_holder, var_9c95ad05)
{
	mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
	if(isdefined(mdl_clip))
	{
		mdl_clip delete();
	}
}

/*
	Name: function_9cc4d7b9
	Namespace: namespace_9861c5bc
	Checksum: 0x7640E9F0
	Offset: 0x13E8
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function function_9cc4d7b9(e_ent)
{
	return e_ent.script_noteworthy == "hellpool";
}

/*
	Name: function_586dd237
	Namespace: namespace_9861c5bc
	Checksum: 0xF93EACB3
	Offset: 0x1410
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_586dd237()
{
	self flag::init("activated");
}

/*
	Name: function_722def57
	Namespace: namespace_9861c5bc
	Checksum: 0x80F724D1
	Offset: 0x1440
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_722def57()
{
}

/*
	Name: function_1d86d117
	Namespace: namespace_9861c5bc
	Checksum: 0xA60EFB1A
	Offset: 0x1450
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_1d86d117()
{
	self._trap_duration = 15;
	self._trap_cooldown_time = 60;
	if(isdefined(level.sndtrapfunc))
	{
		level thread [[level.sndtrapfunc]](self, 1);
	}
	self notify(#"trap_activate");
	level notify(#"trap_activate", self);
	wait(1);
	self.activated_by_player thread function_45a2294f(self.script_string);
	foreach(e_trap in level.var_482bcfef)
	{
		if(e_trap.script_string === self.script_string)
		{
			e_trap thread zm_traps::trap_damage();
		}
	}
	self waittilltimeout(self._trap_duration, #"trap_deactivate");
	foreach(e_trap in level.var_482bcfef)
	{
		if(e_trap.script_string === self.script_string)
		{
			e_trap notify(#"trap_done");
		}
	}
}

/*
	Name: function_45a2294f
	Namespace: namespace_9861c5bc
	Checksum: 0x4AC2BE9B
	Offset: 0x1630
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_45a2294f(str_id)
{
	if(!isdefined(self))
	{
		return;
	}
	self.b_activated = 1;
	foreach(var_bcdc2fe7 in level.var_4a4e3bdc)
	{
		if(var_bcdc2fe7.script_string === str_id)
		{
			var_bcdc2fe7 thread activate_trap(self);
		}
	}
	level notify(#"traps_activated", {#hash_be3f58a:str_id});
	wait(15);
	level notify(#"hash_3c662e7b29cfc3dd", {#hash_be3f58a:str_id});
	n_cooldown = zm_traps::function_da13db45(60, self);
	wait(n_cooldown);
	level notify(#"traps_available", {#hash_be3f58a:str_id});
}

/*
	Name: activate_trap
	Namespace: namespace_9861c5bc
	Checksum: 0x3F2144E1
	Offset: 0x1798
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function activate_trap(e_player)
{
	if(!self flag::get("activated"))
	{
		if(isdefined(e_player))
		{
			self.activated_by_player = e_player;
		}
		self flag::set("activated");
		self thread function_692db12();
		self waittilltimeout(15, #"hash_5aa6001392300725");
		self function_b97c8553();
	}
}

/*
	Name: function_b97c8553
	Namespace: namespace_9861c5bc
	Checksum: 0x629E34A7
	Offset: 0x1848
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_b97c8553()
{
	if(self flag::get("activated"))
	{
		self function_efd16da2();
		self flag::clear("activated");
		self notify(#"deactivate");
	}
}

/*
	Name: function_692db12
	Namespace: namespace_9861c5bc
	Checksum: 0xC773F327
	Offset: 0x18C0
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_692db12()
{
	foreach(s_cauldron in level.a_s_hellpool_cauldron)
	{
		if(s_cauldron.script_string === self.script_string)
		{
			self thread function_b327ce68(s_cauldron);
		}
	}
}

/*
	Name: function_efd16da2
	Namespace: namespace_9861c5bc
	Checksum: 0x2A215385
	Offset: 0x1960
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_efd16da2()
{
	foreach(s_cauldron in level.a_s_hellpool_cauldron)
	{
		if(s_cauldron.script_string === self.script_string)
		{
			self thread function_2e78a71b(s_cauldron);
		}
	}
}

/*
	Name: function_b327ce68
	Namespace: namespace_9861c5bc
	Checksum: 0xBBFED10A
	Offset: 0x1A00
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_b327ce68(s_cauldron)
{
	s_cauldron thread scene::play("shot 1");
	level waittill(#"hash_189e686c493a2a23");
	s_cauldron thread function_4c1fe94b();
}

/*
	Name: function_2e78a71b
	Namespace: namespace_9861c5bc
	Checksum: 0x8413EA19
	Offset: 0x1A68
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_2e78a71b(s_cauldron)
{
	s_cauldron thread scene::play("shot 3");
}

/*
	Name: function_4c1fe94b
	Namespace: namespace_9861c5bc
	Checksum: 0x328D9FD2
	Offset: 0x1AA0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_4c1fe94b()
{
	self thread scene::play("shot 2");
}

/*
	Name: function_db9410fa
	Namespace: namespace_9861c5bc
	Checksum: 0xFA011FB9
	Offset: 0x1AD0
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_db9410fa(e_trap)
{
	if(isactor(self) && (!(isdefined(self.marked_for_death) && self.marked_for_death)))
	{
		self.marked_for_death = 1;
		if(isplayer(e_trap.activated_by_player))
		{
			e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			e_trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		}
		if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"heavy")
		{
			self.marked_for_death = 0;
			return;
		}
		self clientfield::set("acid_trap_death_fx", 1);
		wait(0.75);
		if(isalive(self))
		{
			level notify(#"trap_kill", {#e_trap:e_trap, #e_victim:self});
			self dodamage(self.health + 666, self.origin, e_trap);
		}
	}
}

/*
	Name: function_506285c3
	Namespace: namespace_9861c5bc
	Checksum: 0x9CB7DAA1
	Offset: 0x1C88
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_506285c3(t_damage)
{
	self endoncallback(&function_6f5e73b5, #"death", #"disconnect");
	if(isalive(self) && (!(isdefined(self.var_62b59590) && self.var_62b59590)))
	{
		self.var_62b59590 = 1;
		if(isplayer(self))
		{
			if(!self laststand::player_is_in_laststand() && !level flag::get("round_reset"))
			{
				params = function_4d1e7b48(#"hash_baee445ed1d9b99");
				if(zm_utility::is_standard())
				{
					params.var_9f648d82 = int(params.var_9f648d82 / 4);
				}
				if(zm_utility::function_e51dc2d8() && self flag::get(#"hash_6757075afacfc1b4"))
				{
					params.var_9f648d82 = int(params.var_9f648d82 * 0.1);
				}
				self status_effect::status_effect_apply(params);
				self clientfield::set_to_player("acid_trap_postfx", 1);
			}
			self function_6f5e73b5();
		}
	}
}

/*
	Name: function_6f5e73b5
	Namespace: namespace_9861c5bc
	Checksum: 0x5AF47502
	Offset: 0x1E90
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_6f5e73b5(var_c34665fc)
{
	wait(1);
	if(isdefined(self))
	{
		self.var_62b59590 = 0;
		self clientfield::set_to_player("acid_trap_postfx", 0);
	}
}

