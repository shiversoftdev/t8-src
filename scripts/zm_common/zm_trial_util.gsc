// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using script_1de6f3c239229d19;
#using script_2595527427ea71eb;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\trials\zm_trial_disable_perks.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_trial_util;

/*
	Name: __init__system__
	Namespace: zm_trial_util
	Checksum: 0xB1A36A0A
	Offset: 0x500
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_util", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_util
	Checksum: 0x840A2A82
	Offset: 0x548
	Size: 0x5E
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	callback::on_finalize_initialization(&finalize_clientfields);
	level.var_f995ece6 = zm_trial_timer::register("zm_trial_timer");
}

/*
	Name: function_97444b02
	Namespace: zm_trial_util
	Checksum: 0x5D043660
	Offset: 0x5B0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_97444b02()
{
	self clientfield::increment_to_player("zm_trials_weapon_locked");
	self playsoundtoplayer(#"hash_5590bcb35a1c2562", self);
}

/*
	Name: function_9bf8e274
	Namespace: zm_trial_util
	Checksum: 0xB91E6E8F
	Offset: 0x600
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_9bf8e274()
{
	self.var_b6840ea0 = 1;
	self disableweaponswitchhero();
	self function_21ea8f2b(1);
	foreach(var_5a1e3e5b in level.hero_weapon)
	{
		foreach(w_hero in var_5a1e3e5b)
		{
			self function_28602a03(w_hero, 1, 1);
		}
	}
}

/*
	Name: function_73ff0096
	Namespace: zm_trial_util
	Checksum: 0x5D23C2BF
	Offset: 0x728
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function function_73ff0096()
{
	self.var_b6840ea0 = undefined;
	self enableweaponswitchhero();
	self function_21ea8f2b(0);
	foreach(var_5a1e3e5b in level.hero_weapon)
	{
		foreach(w_hero in var_5a1e3e5b)
		{
			self unlockweapon(w_hero);
		}
	}
}

/*
	Name: function_2ee2d021
	Namespace: zm_trial_util
	Checksum: 0x236BDC1F
	Offset: 0x848
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_2ee2d021()
{
	if(!level flag::get(#"trial_failed") && clientfield::get_world_uimodel("ZMHudGlobal.trials.gameState") != 2)
	{
		clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", 0);
		clientfield::set_world_uimodel("ZMHudGlobal.trials.failureReason", #"hash_cd63faed592da03");
		set_game_state(3);
	}
}

/*
	Name: function_f79b96ac
	Namespace: zm_trial_util
	Checksum: 0x7C803975
	Offset: 0x900
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_f79b96ac()
{
	wait(1);
	clientfield::set_world_uimodel("ZMHudGlobal.trials.showScoreboard", 1);
}

/*
	Name: finalize_clientfields
	Namespace: zm_trial_util
	Checksum: 0x566D42BC
	Offset: 0x938
	Size: 0x68C
	Parameters: 0
	Flags: Linked, Private
*/
function private finalize_clientfields()
{
	clientfield::register("world", "ZMHudGlobal.trials.trialIndex", 1, getminbitcountfornum(15), "int");
	clientfield::register("toplayer", "" + #"hash_6536ca4fb2858a9f", 16000, 1, "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundNumber", 1, getminbitcountfornum(30), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.roundSuccess", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.strikes", 1, getminbitcountfornum(3), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.disablePerks", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableGun", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableEquip", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableSpecial", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.disableAbilities", 1, getminbitcountfornum(1), "int");
	clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(540), "int");
	clientfield::register("toplayer", "zm_trials_weapon_locked", 1, 1, "counter");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.playerCounterMax", 1, getminbitcountfornum(1000), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameState", 1, 2, "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.failurePlayer", 1, 4, "int");
	clientfield::function_78175813("worlduimodel", "string", "ZMHudGlobal.trials.failureReason", 1, 1);
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.showScoreboard", 1, getminbitcountfornum(1), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCheckState", 1, getminbitcountfornum(2), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterValue", 1, getminbitcountfornum(1000), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.globalCounterMax", 1, getminbitcountfornum(1000), "int");
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.hudDeactivated", 1, 1, "int");
	clientfield::register("clientuimodel", "zmhud.currentWeaponLocked", 1, 1, "int");
	clientfield::register("clientuimodel", "zmhud.currentEquipmentLocked", 16000, 1, "int");
	clientfield::register("clientuimodel", "zmhud.currentSpecialLocked", 16000, 1, "int");
	for(i = 0; i < 4; i++)
	{
		clientfield::register("worlduimodel", (("PlayerList.client" + i) + ".") + "trialsCheckState", 1, 2, "int");
		clientfield::register("worlduimodel", (("PlayerList.client" + i) + ".") + "trialsCounterValue", 1, getminbitcountfornum(1000), "int");
	}
	level thread function_8f7e46db();
}

/*
	Name: function_8f7e46db
	Namespace: zm_trial_util
	Checksum: 0xA07E5E0D
	Offset: 0xFD0
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8f7e46db()
{
	level flag::wait_till("start_zombie_round_logic");
	/#
		assert(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.index));
	#/
	if(isdefined(level.var_6d87ac05) && isdefined(level.var_6d87ac05.index))
	{
		level clientfield::set("ZMHudGlobal.trials.trialIndex", level.var_6d87ac05.index);
	}
	clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", 0);
}

/*
	Name: function_eaa44cea
	Namespace: zm_trial_util
	Checksum: 0xCB65B6EC
	Offset: 0x10A8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_eaa44cea()
{
	/#
		assert(isdefined(level.var_21e22beb));
	#/
	clientfield::set_world_uimodel("ZMHudGlobal.trials.gameStartTime", level.var_21e22beb);
}

/*
	Name: function_e47f4e66
	Namespace: zm_trial_util
	Checksum: 0xAE525F99
	Offset: 0x10F8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_e47f4e66(islocked)
{
	self clientfield::set_player_uimodel("zmhud.currentWeaponLocked", islocked);
}

/*
	Name: function_88805385
	Namespace: zm_trial_util
	Checksum: 0x77FEF564
	Offset: 0x1130
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_88805385(b_locked)
{
	self clientfield::set_player_uimodel("zmhud.currentEquipmentLocked", b_locked);
}

/*
	Name: function_21ea8f2b
	Namespace: zm_trial_util
	Checksum: 0xAB9A0092
	Offset: 0x1168
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_21ea8f2b(b_locked)
{
	self clientfield::set_player_uimodel("zmhud.currentSpecialLocked", b_locked);
}

/*
	Name: start_timer
	Namespace: zm_trial_util
	Checksum: 0x8DF0E267
	Offset: 0x11A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function start_timer(seconds)
{
	/#
		assert(seconds <= 540);
	#/
	self clientfield::set_to_player("zm_trials_timer", seconds);
}

/*
	Name: stop_timer
	Namespace: zm_trial_util
	Checksum: 0xB4ED670B
	Offset: 0x11F8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function stop_timer()
{
	self clientfield::set_to_player("zm_trials_timer", 0);
}

/*
	Name: function_128378c9
	Namespace: zm_trial_util
	Checksum: 0x8A682E6
	Offset: 0x1228
	Size: 0xDC
	Parameters: 3
	Flags: Linked
*/
function function_128378c9(n_timer, var_97fd1b64 = 1, var_779bd906 = #"")
{
	if(!level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::open(self);
		level.var_f995ece6 zm_trial_timer::set_under_round_rules(self, var_97fd1b64);
		level.var_f995ece6 zm_trial_timer::set_timer_text(self, var_779bd906);
		self start_timer(n_timer);
	}
}

/*
	Name: function_885fb2c8
	Namespace: zm_trial_util
	Checksum: 0xE19F78C2
	Offset: 0x1310
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_885fb2c8()
{
	if(level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::close(self);
		self stop_timer();
	}
}

/*
	Name: function_2976fa44
	Namespace: zm_trial_util
	Checksum: 0xF044123
	Offset: 0x1378
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_2976fa44(var_71fbbf01)
{
	/#
		assert(var_71fbbf01 >= 0 && var_71fbbf01 <= 1000);
	#/
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterMax", var_71fbbf01);
}

/*
	Name: function_dace284
	Namespace: zm_trial_util
	Checksum: 0x4E7DC24
	Offset: 0x13E0
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_dace284(var_96936cca, b_mute = 0)
{
	/#
		assert(var_96936cca >= 0 && var_96936cca <= 1000);
	#/
	if(var_96936cca >= 1 && !b_mute)
	{
		foreach(e_player in level.players)
		{
			e_player playsoundtoplayer(#"hash_2ef2e5af521e9817", e_player);
		}
	}
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 1);
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterValue", var_96936cca);
}

/*
	Name: function_7d32b7d0
	Namespace: zm_trial_util
	Checksum: 0xCF1C78C6
	Offset: 0x1518
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_7d32b7d0(var_acc46b81)
{
	/#
		assert(var_acc46b81 == 0 || var_acc46b81 == 1);
	#/
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCounterValue", 0);
	if(var_acc46b81 == 0)
	{
		level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 2);
	}
	else
	{
		foreach(e_player in level.players)
		{
			e_player playsoundtoplayer(#"hash_2ef2e5af521e9817", e_player);
		}
		level clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 3);
	}
}

/*
	Name: function_f3dbeda7
	Namespace: zm_trial_util
	Checksum: 0x77A8F3F0
	Offset: 0x1660
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_f3dbeda7()
{
	clientfield::set_world_uimodel("ZMHudGlobal.trials.globalCheckState", 0);
}

/*
	Name: function_c2cd0cba
	Namespace: zm_trial_util
	Checksum: 0xD1C6A8C2
	Offset: 0x1688
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_c2cd0cba(var_71fbbf01)
{
	/#
		assert(var_71fbbf01 >= 0 && var_71fbbf01 <= 1000);
	#/
	level clientfield::set_world_uimodel("ZMHudGlobal.trials.playerCounterMax", var_71fbbf01);
}

/*
	Name: function_2190356a
	Namespace: zm_trial_util
	Checksum: 0x4A1F984B
	Offset: 0x16F0
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_2190356a(var_96936cca, b_mute = 0)
{
	/#
		assert(isplayer(self), "");
	#/
	/#
		assert(var_96936cca >= 0 && var_96936cca <= 1000);
	#/
	if(var_96936cca >= 1 && !b_mute)
	{
		self playsoundtoplayer(#"hash_1377aa36d8ba27e1", self);
	}
	clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCheckState", 1);
	clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCounterValue", var_96936cca);
}

/*
	Name: function_63060af4
	Namespace: zm_trial_util
	Checksum: 0x90063CF8
	Offset: 0x1830
	Size: 0x164
	Parameters: 2
	Flags: None
*/
function function_63060af4(var_acc46b81, b_mute = 0)
{
	/#
		assert(isplayer(self));
	#/
	/#
		assert(var_acc46b81 == 0 || var_acc46b81 == 1);
	#/
	clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCounterValue", 0);
	if(var_acc46b81 == 0)
	{
		clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCheckState", 2);
	}
	else
	{
		if(!b_mute)
		{
			self playsoundtoplayer(#"hash_1377aa36d8ba27e1", self);
		}
		clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCheckState", 3);
	}
}

/*
	Name: function_f3aacffb
	Namespace: zm_trial_util
	Checksum: 0x2BE97E7C
	Offset: 0x19A0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_f3aacffb()
{
	/#
		assert(isplayer(self));
	#/
	clientfield::set_world_uimodel((("PlayerList.client" + self.entity_num) + ".") + "trialsCheckState", 0);
}

/*
	Name: set_game_state
	Namespace: zm_trial_util
	Checksum: 0xC8C9648D
	Offset: 0x1A10
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function set_game_state(game_state)
{
	clientfield::set_world_uimodel("ZMHudGlobal.trials.gameState", game_state);
}

/*
	Name: function_58292c4a
	Namespace: zm_trial_util
	Checksum: 0xBCF51595
	Offset: 0x1A40
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_58292c4a(reason, var_eeb30248 = undefined)
{
	/#
		assert(clientfield::get_world_uimodel("") == 1);
	#/
	var_ccabdce8 = 0;
	if(isdefined(var_eeb30248))
	{
		var_ccabdce8 = function_1e223bce(var_eeb30248);
	}
	clientfield::set_world_uimodel("ZMHudGlobal.trials.failurePlayer", var_ccabdce8);
	clientfield::set_world_uimodel("ZMHudGlobal.trials.failureReason", reason);
}

/*
	Name: function_3f8a4145
	Namespace: zm_trial_util
	Checksum: 0x40D1BFAB
	Offset: 0x1B08
	Size: 0x396
	Parameters: 1
	Flags: Linked
*/
function function_3f8a4145(var_26f4f16d)
{
	/#
		assert(isdefined(self.var_c27f1e90));
	#/
	/#
		assert(self.var_c27f1e90.size >= 4);
	#/
	var_806e2de0 = {};
	var_806e2de0.var_149ec45c = [];
	var_806e2de0.var_8f0c164f = [];
	for(slot = 0; slot < 4; slot++)
	{
		vapor = self.var_c27f1e90[slot];
		var_bf4e9328 = isinarray(self.var_466b927f, vapor);
		var_d84249cb = var_26f4f16d && zm_perks::function_e56d8ef4(vapor);
		if(var_bf4e9328 && !var_d84249cb)
		{
			if(self.var_c4193958[slot] !== "")
			{
				var_806e2de0.var_c4193958[slot] = vapor;
			}
			self notify(vapor + "_stop", {#hash_fe7072f6:1, #hash_613b7621:!var_d84249cb});
			/#
				assert(isdefined(level.var_5355c665));
			#/
			if(isdefined(level.var_5355c665[vapor]))
			{
				var_e6aaa1c2 = level.var_5355c665[vapor];
				self notify(var_e6aaa1c2 + "_stop", {#hash_613b7621:!var_d84249cb});
			}
			if(vapor == #"specialty_additionalprimaryweapon")
			{
				var_806e2de0.additional_primary_weapon = self.var_2a62e678;
			}
			var_806e2de0.var_149ec45c[slot] = 1;
			var_806e2de0.var_8f0c164f[slot] = vapor;
			continue;
		}
		var_806e2de0.var_149ec45c[slot] = 0;
	}
	if(self.var_67ba1237.size)
	{
		var_806e2de0.var_724d826b = arraycopy(self.var_67ba1237);
		var_806e2de0.var_8dee79a9 = self.var_1eba264f;
		var_806e2de0.var_d3f0257d = self.var_b773066d;
		foreach(var_6cbabb29 in self.var_67ba1237)
		{
			self notify(var_6cbabb29 + "_stop", {#hash_fe7072f6:1, #hash_613b7621:1});
		}
		if(isdefined(self.var_64f51f65))
		{
			var_806e2de0.additional_primary_weapon = self.var_64f51f65;
			var_806e2de0.var_1596d94c = self.var_64f51f65;
		}
	}
	return var_806e2de0;
}

/*
	Name: function_d37a769
	Namespace: zm_trial_util
	Checksum: 0xBD802A0B
	Offset: 0x1EA8
	Size: 0x2C2
	Parameters: 1
	Flags: Linked
*/
function function_d37a769(var_806e2de0)
{
	/#
		assert(isdefined(self.var_c27f1e90));
	#/
	/#
		assert(self.var_c27f1e90.size >= 4);
	#/
	/#
		assert(var_806e2de0.var_149ec45c.size == 4);
	#/
	level.var_bd1e770b = 1;
	for(slot = 0; slot < 4; slot++)
	{
		if(isdefined(var_806e2de0.var_8f0c164f[slot]))
		{
			self.var_c27f1e90[slot] = var_806e2de0.var_8f0c164f[slot];
		}
		vapor = self.var_c27f1e90[slot];
		if(var_806e2de0.var_149ec45c[slot] || (self zm_perks::function_e56d8ef4(vapor) && !zm_trial_disable_perks::is_active(1)))
		{
			if(isdefined(var_806e2de0.var_c4193958) && isdefined(var_806e2de0.var_c4193958[slot]))
			{
				vapor = var_806e2de0.var_c4193958[slot];
				self.var_c4193958[slot] = vapor;
				self.var_c27f1e90[slot] = vapor;
			}
			self zm_perks::function_81bc6765(slot, level._custom_perks[vapor].alias);
			self zm_perks::function_9bdf581f(vapor, slot);
		}
	}
	if(isarray(var_806e2de0.var_724d826b))
	{
		self.var_1eba264f = var_806e2de0.var_8dee79a9;
		self.var_b773066d = var_806e2de0.var_d3f0257d;
		foreach(var_16c042b8 in var_806e2de0.var_724d826b)
		{
			self zm_perks::function_a7ae070c(var_16c042b8);
		}
	}
	level.var_bd1e770b = undefined;
}

/*
	Name: function_7f999aa0
	Namespace: zm_trial_util
	Checksum: 0xBEBA0BAA
	Offset: 0x2178
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function function_7f999aa0(var_806e2de0)
{
	slot = self zm_perks::function_c1efcc57(#"specialty_additionalprimaryweapon");
	var_4493e3e1 = isarray(var_806e2de0.var_724d826b) && isinarray(var_806e2de0.var_724d826b, #"specialty_additionalprimaryweapon");
	if(var_4493e3e1 || slot != -1 && (var_4493e3e1 || var_806e2de0.var_149ec45c[slot] || zm_perks::function_e56d8ef4(#"specialty_additionalprimaryweapon")) && isdefined(var_806e2de0.additional_primary_weapon))
	{
		if(var_4493e3e1 || isinarray(self.var_466b927f, #"specialty_additionalprimaryweapon"))
		{
			if(self hasweapon(var_806e2de0.additional_primary_weapon))
			{
				self notify(#"hash_29c66728ccd27f03", {#weapon:var_806e2de0.additional_primary_weapon});
			}
		}
	}
}

/*
	Name: function_8036c103
	Namespace: zm_trial_util
	Checksum: 0xC558D2B5
	Offset: 0x22F8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_8036c103()
{
	a_structs = struct::get_array("perk_vapor_altar");
	foreach(s_struct in a_structs)
	{
		s_struct zm_perks::function_efd2c9e6();
	}
}

/*
	Name: function_302c6014
	Namespace: zm_trial_util
	Checksum: 0x2A1EEC92
	Offset: 0x2398
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_302c6014()
{
	a_structs = struct::get_array("perk_vapor_altar");
	foreach(s_struct in a_structs)
	{
		s_struct zm_perks::function_1e721859();
	}
}

/*
	Name: function_eea26e56
	Namespace: zm_trial_util
	Checksum: 0x33D7DF78
	Offset: 0x2438
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_eea26e56()
{
	if(!(isdefined(level.var_a8d3f80b) && level.var_a8d3f80b) && isdefined(level.pap_machine) && level flag::get("pap_machine_active"))
	{
		level.var_a8d3f80b = 1;
		if(isdefined(level.var_2d96b859))
		{
			self [[level.var_2d96b859]](0);
		}
	}
	else
	{
		level.var_a8d3f80b = 0;
	}
}

/*
	Name: function_ef1fce77
	Namespace: zm_trial_util
	Checksum: 0x33AD8C33
	Offset: 0x24E0
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_ef1fce77()
{
	if(isdefined(level.pap_machine) && (isdefined(level.var_a8d3f80b) && level.var_a8d3f80b))
	{
		if(isdefined(level.var_2d96b859))
		{
			[[level.var_2d96b859]](1);
		}
		level.var_a8d3f80b = undefined;
	}
}

/*
	Name: function_8cdbf9f0
	Namespace: zm_trial_util
	Checksum: 0xF26866ED
	Offset: 0x2550
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_8cdbf9f0()
{
	luinotifyevent(#"hash_6b83e3eca730e165", 0);
}

/*
	Name: function_96e10d88
	Namespace: zm_trial_util
	Checksum: 0xFA05AA5
	Offset: 0x2580
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_96e10d88(successful)
{
	clientfield::set_world_uimodel("ZMHudGlobal.trials.roundSuccess", successful);
}

/*
	Name: function_1e223bce
	Namespace: zm_trial_util
	Checksum: 0x678F31B4
	Offset: 0x25B0
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_1e223bce(players)
{
	var_10991f64 = 0;
	foreach(player in players)
	{
		var_10991f64 = var_10991f64 | (1 << player getentitynumber());
	}
	return var_10991f64;
}

/*
	Name: function_85d088ed
	Namespace: zm_trial_util
	Checksum: 0xE349B6A7
	Offset: 0x2660
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function function_85d088ed(player)
{
	var_10991f64 = 0;
	var_10991f64 = var_10991f64 | (1 << player getentitynumber());
	return var_10991f64;
}

/*
	Name: function_7dbb1712
	Namespace: zm_trial_util
	Checksum: 0x70BBF392
	Offset: 0x26A8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_7dbb1712(forceupdate)
{
	weapon = self getcurrentweapon();
	if(self function_635f9c02(weapon))
	{
		self function_e47f4e66(1);
	}
	else if(isdefined(forceupdate) && forceupdate || (!(isdefined(self.var_16735873) && self.var_16735873)))
	{
		self function_e47f4e66(0);
	}
}

/*
	Name: function_79518194
	Namespace: zm_trial_util
	Checksum: 0xF202D303
	Offset: 0x2758
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_79518194(eventstruct)
{
	function_7dbb1712(0);
}

/*
	Name: function_dc9ab223
	Namespace: zm_trial_util
	Checksum: 0x84CA9449
	Offset: 0x2788
	Size: 0x3C8
	Parameters: 2
	Flags: Linked
*/
function function_dc9ab223(b_locked = 1, var_1d9fd2ff = 0)
{
	if(b_locked)
	{
		foreach(weapon in zm_loadout::function_5a5a742a("lethal_grenade"))
		{
			self function_28602a03(weapon, 1, 1);
			self function_88805385(1);
		}
		if(var_1d9fd2ff)
		{
			foreach(weapon in zm_loadout::function_5a5a742a("tactical_grenade"))
			{
				if(isdefined(weapon.ismeleeweapon) && weapon.ismeleeweapon)
				{
					self function_28602a03(weapon, 0, 1);
				}
				if(weapon.dualwieldweapon != level.weaponnone && (isdefined(weapon.dualwieldweapon.ismeleeweapon) && weapon.dualwieldweapon.ismeleeweapon))
				{
					self function_28602a03(weapon.dualwieldweapon, 0, 1);
				}
			}
		}
		self thread function_d0348c2c();
	}
	else
	{
		foreach(weapon in zm_loadout::function_5a5a742a("lethal_grenade"))
		{
			self unlockweapon(weapon);
			self function_88805385(0);
		}
		if(var_1d9fd2ff)
		{
			foreach(weapon in zm_loadout::function_5a5a742a("tactical_grenade"))
			{
				if(isdefined(weapon.ismeleeweapon) && weapon.ismeleeweapon)
				{
					self unlockweapon(weapon);
				}
				if(weapon.dualwieldweapon != level.weaponnone && (isdefined(weapon.dualwieldweapon.ismeleeweapon) && weapon.dualwieldweapon.ismeleeweapon))
				{
					self unlockweapon(weapon.dualwieldweapon);
				}
			}
		}
	}
}

/*
	Name: function_8677ce00
	Namespace: zm_trial_util
	Checksum: 0xD46649CB
	Offset: 0x2B58
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function function_8677ce00(b_locked = 1)
{
	a_weapons = self getweaponslist(1);
	if(b_locked)
	{
		foreach(weapon in a_weapons)
		{
			if(!self function_635f9c02(weapon))
			{
				self function_28602a03(weapon, 0, 1);
			}
		}
	}
	else
	{
		foreach(weapon in a_weapons)
		{
			self unlockweapon(weapon);
		}
	}
}

/*
	Name: function_d0348c2c
	Namespace: zm_trial_util
	Checksum: 0x60700C2B
	Offset: 0x2CA8
	Size: 0x344
	Parameters: 1
	Flags: Linked
*/
function function_d0348c2c(var_69cbd99d = 0)
{
	self endon(#"disconnect");
	if(var_69cbd99d)
	{
		while(self isthrowinggrenade() || self isusingoffhand() || self function_55acff10() && !self fragbuttonpressed())
		{
			waitframe(1);
		}
	}
	if(self isusingoffhand())
	{
		if(!isdefined(level.w_homunculus) || !self zm_loadout::function_393977df("lethal_grenade", level.w_homunculus) && (!isdefined(level.w_homunculus_upgraded) || !self zm_loadout::function_393977df("lethal_grenade", level.w_homunculus_upgraded)))
		{
			self forceoffhandend();
		}
	}
	if(isarray(self.mini_turrets))
	{
		arrayremovevalue(self.mini_turrets, undefined);
		foreach(mini_turret in self.mini_turrets)
		{
			mini_turret dodamage(mini_turret.health + 100, mini_turret.origin);
		}
	}
	if(isarray(self.activeproximitygrenades))
	{
		arrayremovevalue(self.activeproximitygrenades, undefined);
		foreach(e_claymore in self.activeproximitygrenades)
		{
			e_claymore dodamage(e_claymore.var_966835e3, e_claymore.origin);
		}
	}
	var_b9721d87 = self offhandweaponsenabled();
	self disableoffhandweapons();
	wait(0.25);
	if(var_b9721d87)
	{
		self enableoffhandweapons();
	}
}

/*
	Name: function_b142d49f
	Namespace: zm_trial_util
	Checksum: 0x6A1B40EC
	Offset: 0x2FF8
	Size: 0x138
	Parameters: 2
	Flags: Linked
*/
function function_b142d49f(weapon, var_ef2d79a9 = 1)
{
	self endon(#"disconnect");
	w_current = self getcurrentweapon();
	if(var_ef2d79a9)
	{
		while(weapon === w_current && self isfiring() && !self ismeleeing() && (isdefined(weapon.isburstfire) && weapon.isburstfire))
		{
			waitframe(1);
		}
	}
	else
	{
		while(self isfiring() && !self ismeleeing() && (isdefined(weapon.isburstfire) && weapon.isburstfire))
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_bf710271
	Namespace: zm_trial_util
	Checksum: 0x27034656
	Offset: 0x3138
	Size: 0x21C
	Parameters: 5
	Flags: Linked
*/
function function_bf710271(var_ef2d79a9 = 1, var_88ebd569 = 1, var_fdb73f9e = 1, var_af33418e = 1, var_3bd29f5e = 1)
{
	self endon(#"disconnect");
	foreach(weapon in self getweaponslist(1))
	{
		if(zm_loadout::function_2ff6913(weapon))
		{
			continue;
		}
		self function_b142d49f(weapon, var_ef2d79a9);
		self function_28602a03(weapon, var_af33418e, var_3bd29f5e);
		if(weapon.dualwieldweapon != level.weaponnone)
		{
			self function_28602a03(weapon.dualwieldweapon, var_af33418e, var_3bd29f5e);
		}
	}
	if(var_88ebd569)
	{
		self thread function_d0348c2c(1);
	}
	self function_88805385(1);
	if(var_fdb73f9e)
	{
		self function_9bf8e274();
		self notify(#"hash_62fb3ab92a1f20cd");
	}
	self function_7dbb1712(1);
}

/*
	Name: function_dc0859e
	Namespace: zm_trial_util
	Checksum: 0x3325E7C5
	Offset: 0x3360
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_dc0859e(var_b5434dd5 = 1)
{
	foreach(weapon in self getweaponslist(1))
	{
		self unlockweapon(weapon);
		if(weapon.dualwieldweapon != level.weaponnone)
		{
			self unlockweapon(weapon.dualwieldweapon);
		}
	}
	self function_7dbb1712(1);
	self function_88805385(0);
	if(var_b5434dd5)
	{
		self function_73ff0096();
	}
}

/*
	Name: function_3e209fb6
	Namespace: zm_trial_util
	Checksum: 0xD3039C58
	Offset: 0x3498
	Size: 0x1CE
	Parameters: 0
	Flags: None
*/
function function_3e209fb6()
{
	/#
		a_zombie_doors = getentarray("", "");
		for(i = 0; i < a_zombie_doors.size; i++)
		{
			if(!(isdefined(a_zombie_doors[i].has_been_opened) && a_zombie_doors[i].has_been_opened))
			{
				a_zombie_doors[i] notify(#"trigger", {#is_forced:1});
			}
			waitframe(1);
		}
		var_38a6b7d0 = getentarray("", "");
		for(i = 0; i < var_38a6b7d0.size; i++)
		{
			var_38a6b7d0[i] notify(#"trigger", {#is_forced:1});
			waitframe(1);
		}
		a_zombie_debris = getentarray("", "");
		for(i = 0; i < a_zombie_debris.size; i++)
		{
			if(isdefined(a_zombie_debris[i]))
			{
				a_zombie_debris[i] notify(#"trigger", {#is_forced:1});
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_9c71b46f
	Namespace: zm_trial_util
	Checksum: 0x434B419
	Offset: 0x3670
	Size: 0x16A
	Parameters: 0
	Flags: None
*/
function function_9c71b46f()
{
	/#
		foreach(player in getplayers())
		{
			for(i = 0; i < player.var_c27f1e90.size; i++)
			{
				perk = player.var_c27f1e90[i];
				if(isdefined(player.perk_purchased) && player.perk_purchased == perk)
				{
					continue;
				}
				if(!player hasperk(perk) && !player zm_perks::has_perk_paused(perk))
				{
					n_index = player zm_perks::function_c1efcc57(perk);
					player zm_perks::function_9bdf581f(perk, n_index);
				}
			}
		}
	#/
}

/*
	Name: function_9c1092f6
	Namespace: zm_trial_util
	Checksum: 0xB1C43315
	Offset: 0x37E8
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_9c1092f6()
{
	/#
		iprintlnbold("");
		if(getgametypesetting(#"zmshowtimer", 0) == 1)
		{
			setgametypesetting(#"zmshowtimer", 0);
		}
		else
		{
			setgametypesetting(#"zmshowtimer", 1);
		}
	#/
}

