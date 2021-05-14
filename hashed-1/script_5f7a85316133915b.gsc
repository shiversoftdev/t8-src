// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_3f9e0dc8454d98e1;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_e7c67ece;

/*
	Name: function_89f2df9
	Namespace: namespace_e7c67ece
	Checksum: 0xFA3B6A25
	Offset: 0x230
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_145b120e873ea191", &__init__, undefined, #"load");
}

/*
	Name: __init__
	Namespace: namespace_e7c67ece
	Checksum: 0x63B383E9
	Offset: 0x280
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int");
	/#
		level thread function_5d55ce5f();
	#/
	level thread function_542725a1();
}

/*
	Name: function_542725a1
	Namespace: namespace_e7c67ece
	Checksum: 0x4E9680E0
	Offset: 0x2F0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_542725a1()
{
	level flag::wait_till("all_players_connected");
	if(!level.enable_magic || (!(isdefined(namespace_59ff1d6c::function_901b751c(#"hash_3d18f84f48bd5d1f")) && namespace_59ff1d6c::function_901b751c(#"hash_3d18f84f48bd5d1f"))))
	{
		return;
	}
	level.perk_bottle_weapon_array = arraycombine(level.machine_assets, level._custom_perks, 0, 1);
	level.var_93995710 = struct::get_array("vapor_random_altar");
	level.var_8feb4083 = [];
	function_7d881772();
}

/*
	Name: function_7d881772
	Namespace: namespace_e7c67ece
	Checksum: 0x4B8B9EC0
	Offset: 0x3F0
	Size: 0x1D2
	Parameters: 0
	Flags: Linked
*/
function function_7d881772()
{
	if(isdefined(level.var_12351917) && level.var_12351917)
	{
		return;
	}
	foreach(struct in level.var_93995710)
	{
		if(isdefined(struct.var_839c2cb5) && struct.var_839c2cb5)
		{
			var_eed5ca85 = struct;
			break;
		}
	}
	array::thread_all(level.var_93995710, &function_8dd97732);
	if(!isdefined(var_eed5ca85))
	{
		var_eed5ca85 = array::random(level.var_93995710);
	}
	if(isdefined(var_eed5ca85))
	{
		if(!isdefined(level.var_8feb4083))
		{
			level.var_8feb4083 = [];
		}
		else if(!isarray(level.var_8feb4083))
		{
			level.var_8feb4083 = array(level.var_8feb4083);
		}
		if(!isinarray(level.var_8feb4083, var_eed5ca85))
		{
			level.var_8feb4083[level.var_8feb4083.size] = var_eed5ca85;
		}
		var_eed5ca85 thread function_1a038e0b();
		var_eed5ca85.var_3c4b2051 = 1;
	}
}

/*
	Name: function_1a038e0b
	Namespace: namespace_e7c67ece
	Checksum: 0x66FEF27A
	Offset: 0x5D0
	Size: 0x302
	Parameters: 0
	Flags: Linked
*/
function function_1a038e0b()
{
	self.var_bee7fa0b = 0;
	self.var_756caeac = randomintrange(3, 7);
	unitrigger_stub = spawnstruct();
	unitrigger_stub.origin = self.origin;
	unitrigger_stub.angles = self.angles;
	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	unitrigger_stub.script_height = 32;
	unitrigger_stub.script_width = 64;
	unitrigger_stub.script_length = 72;
	unitrigger_stub.require_look_at = 0;
	unitrigger_stub.targetname = "random_vapor_altar_stub";
	unitrigger_stub.hint_string = #"hash_71158766520dc432";
	unitrigger_stub.script_struct = self;
	zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
	unitrigger_stub.prompt_and_visibility_func = &function_6842bdd7;
	zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_20fe0559);
	zm_unitrigger::function_c4a5fdf5(unitrigger_stub, 1);
	self.unitrigger_stub = unitrigger_stub;
	if(!isdefined(self.var_73bd396b))
	{
		self.var_73bd396b = util::spawn_model("tag_origin", self.origin, self.angles);
	}
	self.var_73bd396b clientfield::set("random_vapor_altar_available", 1);
	var_ade6ee77 = getentarray(self.target, "targetname");
	array::run_all(var_ade6ee77, &show);
	var_e866a143 = struct::get_array(self.target);
	foreach(s_interact in var_e866a143)
	{
		if(s_interact.script_int === 3)
		{
			s_interact.n_cost = 5000;
			continue;
		}
		s_interact.n_cost = 2000;
	}
}

/*
	Name: function_8dd97732
	Namespace: namespace_e7c67ece
	Checksum: 0x37DB092A
	Offset: 0x8E0
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_8dd97732()
{
	var_e866a143 = struct::get_array(self.target);
	var_ade6ee77 = getentarray(self.target, "targetname");
	var_ade6ee77 = getentarray(self.target, "targetname");
	array::run_all(var_ade6ee77, &ghost);
	foreach(s_interact in var_e866a143)
	{
		zm_unitrigger::unregister_unitrigger(s_interact.unitrigger_stub);
		s_interact.unitrigger_stub = undefined;
	}
	zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
	self.var_3c4b2051 = undefined;
	if(isdefined(self.var_73bd396b))
	{
		self.var_73bd396b delete();
	}
}

/*
	Name: function_6842bdd7
	Namespace: namespace_e7c67ece
	Checksum: 0x17AC4007
	Offset: 0xA48
	Size: 0x788
	Parameters: 1
	Flags: Linked
*/
function function_6842bdd7(player)
{
	s_altar = self.stub.script_struct;
	finalfight_raid = struct::get_array(s_altar.target);
	if(namespace_59ff1d6c::function_8b8fa6e5(player))
	{
		player.var_e07e301b = undefined;
		return 0;
	}
	if(!(isdefined(s_altar.b_in_use) && s_altar.b_in_use) && isdefined(player.perks_active) && player.perks_active.size > 4)
	{
		finalfight_raid = arraysortclosest(finalfight_raid, player util::get_eye(), undefined, 0, 64);
		foreach(s_interact in finalfight_raid)
		{
			n_dist = distancesquared(player util::get_eye(), s_interact.origin);
			var_b03ef6de = player zm_utility::is_player_looking_at(s_interact.origin, 0.94, 0);
			if(n_dist < 4096 && var_b03ef6de)
			{
				var_e308e3ba = s_interact.script_int;
				break;
			}
		}
		if(isdefined(var_e308e3ba))
		{
			switch(var_e308e3ba)
			{
				case 0:
				{
					if(function_8b1a219a())
					{
						var_4a186601 = #"hash_17ff339e7f75ae18";
					}
					else
					{
						var_4a186601 = #"hash_7e97aa53c3038fb4";
					}
					break;
				}
				case 1:
				{
					if(function_8b1a219a())
					{
						var_4a186601 = #"hash_5eaee5bec056161d";
					}
					else
					{
						var_4a186601 = #"hash_133c9b7b564b707f";
					}
					break;
				}
				case 2:
				{
					if(function_8b1a219a())
					{
						var_4a186601 = #"hash_2599dfad21d29341";
					}
					else
					{
						var_4a186601 = #"hash_726a5f9b0d18c78b";
					}
					break;
				}
				case 3:
				{
					if(function_8b1a219a())
					{
						var_4a186601 = #"hash_497917c49187deea";
					}
					else
					{
						var_4a186601 = #"hash_228c88065496b9fe";
					}
					break;
				}
			}
			player.var_e07e301b = s_interact;
			self sethintstringforplayer(player, var_4a186601, s_interact.n_cost);
			return 1;
		}
		player.var_e07e301b = undefined;
		return 0;
	}
	if(!(isdefined(s_altar.b_in_use) && s_altar.b_in_use))
	{
		self sethintstringforplayer(player, #"hash_5d7144cc16556865", 4);
		player.var_e07e301b = undefined;
		return 1;
	}
	if(isdefined(s_altar.var_46fe01e2) && s_altar.var_46fe01e2 && s_altar.var_125b20f8 === player && isdefined(s_altar.var_62fef0f1))
	{
		switch(s_altar.var_62fef0f1)
		{
			case "specialty_additionalprimaryweapon":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_7a82d19279cc6daf";
				}
				else
				{
					var_5137b086 = #"hash_481e84e3d5747771";
				}
				break;
			}
			case "specialty_armorvest":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_58febf66d0aaf436";
				}
				else
				{
					var_5137b086 = #"hash_514ee426b54c1122";
				}
				break;
			}
			case "hash_37aa3a5919757781":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_279db126c954111";
				}
				else
				{
					var_5137b086 = #"hash_c5eaf038e40129b";
				}
				break;
			}
			case "specialty_deadshot":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_2f89c70e07ddab1c";
				}
				else
				{
					var_5137b086 = #"hash_554eba058d6a7c30";
				}
				break;
			}
			case "specialty_electriccherry":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_5fc8f9fbce3e5074";
				}
				else
				{
					var_5137b086 = #"hash_2d6886135fa75f38";
				}
				break;
			}
			case "specialty_fastreload":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_1589f4207559932b";
				}
				else
				{
					var_5137b086 = #"hash_1c530c71188469b5";
				}
				break;
			}
			case "specialty_quickrevive":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_1c6b895369b478b4";
				}
				else
				{
					var_5137b086 = #"hash_45143147d543f878";
				}
				break;
			}
			case "specialty_staminup":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_307615269eadecab";
				}
				else
				{
					var_5137b086 = #"hash_461fdf40d1afda35";
				}
				break;
			}
			case "specialty_widowswine":
			{
				if(function_8b1a219a())
				{
					var_5137b086 = #"hash_4d8ca83f86b22f28";
				}
				else
				{
					var_5137b086 = #"hash_62a4738313dcd9c4";
				}
				break;
			}
		}
		self sethintstringforplayer(player, var_5137b086);
		return 1;
	}
	player.var_e07e301b = undefined;
	return 0;
}

/*
	Name: function_20fe0559
	Namespace: namespace_e7c67ece
	Checksum: 0x1D647E86
	Offset: 0x11D8
	Size: 0x4CA
	Parameters: 0
	Flags: Linked
*/
function function_20fe0559()
{
	self endon(#"death");
	s_altar = self.stub.script_struct;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(!isdefined(player.var_e07e301b) || !isdefined(player.var_e07e301b.script_int) || !isdefined(player.var_e07e301b.n_cost))
		{
			waitframe(1);
			continue;
		}
		if(!zm_perks::vending_trigger_can_player_use(player, 1))
		{
			waitframe(1);
			continue;
		}
		if(namespace_59ff1d6c::function_8b8fa6e5(player))
		{
			continue;
		}
		n_slot = player.var_e07e301b.script_int;
		n_cost = player.var_e07e301b.n_cost;
		if(!player zm_score::can_player_purchase(n_cost))
		{
			self playsound(#"evt_perk_deny");
			player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
			continue;
		}
		if(!isdefined(player.perks_active) || (isdefined(player.perks_active) && player.perks_active.size < 4))
		{
			continue;
		}
		s_altar.b_in_use = 1;
		s_altar.var_bee7fa0b++;
		s_altar.var_125b20f8 = player;
		sound = "evt_bottle_dispense";
		playsoundatposition(sound, self.origin);
		player zm_score::minus_to_player_score(n_cost);
		var_cc1db3c1 = array::exclude(level.var_b8be892e, player.perks_active);
		var_62fef0f1 = array::random(var_cc1db3c1);
		if(!isdefined(var_62fef0f1))
		{
			continue;
		}
		s_altar.var_62fef0f1 = var_62fef0f1;
		s_altar function_2cc4144b(var_62fef0f1);
		var_5c3cde58 = self function_42171e41(player);
		level.bottle_spawn_location setmodel(#"tag_origin");
		if(isdefined(var_5c3cde58) && var_5c3cde58)
		{
			if(n_slot == 3 && isdefined(level.var_5355c665))
			{
				player notify(level.var_5355c665[player.var_c27f1e90[n_slot]] + "_stop");
			}
			player notify(player.var_c27f1e90[n_slot] + "_stop");
			player thread function_bb1ac745(s_altar);
			player.var_c27f1e90[n_slot] = var_62fef0f1;
			player notify(#"perk_purchased", {#perk:var_62fef0f1});
			player thread zm_perks::function_4acf7b43(n_slot, var_62fef0f1);
			self thread zm_perks::taking_cover_tanks_(player, var_62fef0f1, n_slot);
		}
		else
		{
			s_altar.b_in_use = 0;
		}
		s_altar.var_125b20f8 = undefined;
		s_altar.var_62fef0f1 = undefined;
		if(s_altar.var_bee7fa0b >= s_altar.var_756caeac && level.var_93995710.size > 1)
		{
			level thread function_44481969();
			return;
		}
	}
}

/*
	Name: function_44481969
	Namespace: namespace_e7c67ece
	Checksum: 0x57AB0CB7
	Offset: 0x16B0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_44481969()
{
	/#
		iprintlnbold("");
	#/
	array::thread_all(level.var_93995710, &function_8dd97732);
	var_8dd5d69f = array::exclude(level.var_93995710, level.var_8feb4083);
	if(var_8dd5d69f.size)
	{
		var_eed5ca85 = array::random(var_8dd5d69f);
		var_eed5ca85 thread function_1a038e0b();
		var_eed5ca85.var_3c4b2051 = 1;
		if(!isdefined(level.var_8feb4083))
		{
			level.var_8feb4083 = [];
		}
		else if(!isarray(level.var_8feb4083))
		{
			level.var_8feb4083 = array(level.var_8feb4083);
		}
		if(!isinarray(level.var_8feb4083, var_eed5ca85))
		{
			level.var_8feb4083[level.var_8feb4083.size] = var_eed5ca85;
		}
	}
	else
	{
		level.var_8feb4083 = [];
		function_7d881772();
	}
}

/*
	Name: function_2cc4144b
	Namespace: namespace_e7c67ece
	Checksum: 0xF56819BE
	Offset: 0x1840
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_2cc4144b(var_83225a27)
{
	if(isdefined(level.bottle_spawn_location))
	{
		level.bottle_spawn_location delete();
	}
	level.bottle_spawn_location = util::spawn_model("tag_origin", self.origin, self.angles);
	if(isdefined(level.bottle_spawn_location))
	{
		level.bottle_spawn_location.origin = level.bottle_spawn_location.origin + vectorscale((0, 0, 1), 15);
		wait(1);
		self notify(#"bottle_spawned");
		self thread start_perk_bottle_cycling();
		self thread perk_bottle_motion();
		var_ceb50987 = zm_perks::get_perk_weapon_model(var_83225a27);
		wait(3);
		self notify(#"done_cycling");
		if(isdefined(level.bottle_spawn_location))
		{
			level.bottle_spawn_location setmodel(var_ceb50987);
		}
	}
}

/*
	Name: start_perk_bottle_cycling
	Namespace: namespace_e7c67ece
	Checksum: 0xCFDCBB26
	Offset: 0x19A0
	Size: 0x162
	Parameters: 0
	Flags: Linked
*/
function start_perk_bottle_cycling()
{
	self endon(#"done_cycling");
	var_f0f641ad = level.var_b8be892e;
	var_f0f641ad = array::exclude(var_f0f641ad, #"hash_66e6fbe3cc2aff65");
	if(!var_f0f641ad.size)
	{
		return;
	}
	if(var_f0f641ad.size == 1)
	{
		level.bottle_spawn_location setmodel(zm_perks::get_perk_weapon_model(var_f0f641ad[0]));
		return;
	}
	var_77bb17ca = undefined;
	while(true)
	{
		for(i = 0; i < var_f0f641ad.size; i++)
		{
			str_model = zm_perks::get_perk_weapon_model(var_f0f641ad[i]);
			if(str_model === var_77bb17ca)
			{
				continue;
			}
			var_77bb17ca = str_model;
			if(isdefined(str_model) && isdefined(level.bottle_spawn_location))
			{
				level.bottle_spawn_location setmodel(str_model);
			}
			wait(0.1);
		}
	}
}

/*
	Name: perk_bottle_motion
	Namespace: namespace_e7c67ece
	Checksum: 0x5C133C94
	Offset: 0x1B10
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function perk_bottle_motion()
{
	if(!isdefined(self) || !isdefined(level.bottle_spawn_location))
	{
		return;
	}
	self endon(#"death");
	level.bottle_spawn_location endon(#"death");
	level.bottle_spawn_location dontinterpolate();
	level.bottle_spawn_location.origin = self.origin;
	level.bottle_spawn_location.angles = self.angles;
	level.bottle_spawn_location moveto(level.bottle_spawn_location.origin + (0, 0, 30), 3, 3 * 0.5);
	level.bottle_spawn_location.angles = level.bottle_spawn_location.angles + (0, 0, 10);
	level.bottle_spawn_location rotateyaw(720, 3, 3 * 0.5);
	self waittill(#"done_cycling");
	level.bottle_spawn_location.angles = self.angles;
	level.bottle_spawn_location moveto(level.bottle_spawn_location.origin - (0, 0, 30), 10, 10 * 0.5);
	level.bottle_spawn_location rotateyaw(90, 10, 10 * 0.5);
}

/*
	Name: function_42171e41
	Namespace: namespace_e7c67ece
	Checksum: 0x1EBCB1D8
	Offset: 0x1D28
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function function_42171e41(player)
{
	s_altar = self.stub.script_struct;
	s_altar.var_46fe01e2 = 1;
	s_result = undefined;
	s_result = self waittill_timeout(10, #"trigger");
	s_altar.var_46fe01e2 = 0;
	if(s_result._notify == "trigger" && s_result.activator === player)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_bb1ac745
	Namespace: namespace_e7c67ece
	Checksum: 0x64B75443
	Offset: 0x1DE0
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_bb1ac745(s_altar)
{
	self waittill(#"perk_acquired", #"death", #"disconnect", #"player_downed");
	s_altar.b_in_use = 0;
}

/*
	Name: function_5d55ce5f
	Namespace: namespace_e7c67ece
	Checksum: 0xC648264C
	Offset: 0x1E48
	Size: 0xE4
	Parameters: 0
	Flags: Private
*/
private function function_5d55ce5f()
{
	/#
		level waittill(#"start_zombie_round_logic");
		adddebugcommand("");
		while(true)
		{
			cmd = getdvarstring(#"hash_655adfd9dc05d377", "");
			setdvar(#"hash_655adfd9dc05d377", "");
			switch(cmd)
			{
				case "hash_53632aca73d631fe":
				{
					function_44481969();
					wait(1);
					break;
				}
			}
			waitframe(1);
		}
	#/
}

