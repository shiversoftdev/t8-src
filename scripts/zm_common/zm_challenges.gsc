// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_47fb62300ac0bd60;
#using script_6e3c826b1814cab6;
#using script_7133a4d461308099;
#using script_ab890501c40b73c;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_ff457ca2;

/*
	Name: function_89f2df9
	Namespace: namespace_ff457ca2
	Checksum: 0xFCAA4555
	Offset: 0x1B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_22fb2773f81126ff", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ff457ca2
	Checksum: 0x759C6CE5
	Offset: 0x200
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_connect);
	callback::on_spawned(&on_spawned);
	callback::on_player_damage(&on_damaged);
	callback::on_laststand(&on_laststand);
	callback::on_bleedout(&on_bleedout);
	callback::on_challenge_complete(&on_challenge_complete);
	zm_spawner::register_zombie_death_event_callback(&death_check_for_challenge_updates);
}

/*
	Name: __main__
	Namespace: namespace_ff457ca2
	Checksum: 0x4CC8B0FE
	Offset: 0x2F0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread spent_points_tracking();
	level thread function_a9f6b8ef();
}

/*
	Name: on_connect
	Namespace: namespace_ff457ca2
	Checksum: 0x75EDE271
	Offset: 0x330
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self thread round_tracking();
	self thread perk_drink_tracking();
	self thread function_73696786();
	self thread function_12a35616();
	self thread function_a3cd4521();
	self thread function_f9ce6f88();
	self.var_152810ff = [];
	self.var_152810ff[0] = 0;
	self.var_152810ff[1] = 0;
	self.var_152810ff[2] = 0;
	self.var_152810ff[3] = 0;
	self.var_152810ff[4] = 0;
}

/*
	Name: on_spawned
	Namespace: namespace_ff457ca2
	Checksum: 0x80F724D1
	Offset: 0x438
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_spawned()
{
}

/*
	Name: on_damaged
	Namespace: namespace_ff457ca2
	Checksum: 0xBB6ADF9D
	Offset: 0x448
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function on_damaged(params)
{
	self.var_152810ff[1] = 1;
	self.var_152810ff[4] = 1;
}

/*
	Name: on_laststand
	Namespace: namespace_ff457ca2
	Checksum: 0x98165960
	Offset: 0x488
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function on_laststand()
{
	self.var_152810ff[2] = 1;
}

/*
	Name: on_bleedout
	Namespace: namespace_ff457ca2
	Checksum: 0xA7AB82A5
	Offset: 0x4B0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function on_bleedout()
{
	self.var_152810ff[3] = 1;
}

/*
	Name: round_tracking
	Namespace: namespace_ff457ca2
	Checksum: 0xCBB8CDC
	Offset: 0x4D8
	Size: 0x2F6
	Parameters: 0
	Flags: Linked
*/
function round_tracking()
{
	self endon(#"disconnect");
	while(true)
	{
		level waittill(#"end_of_round");
		if(zm_utility::function_3bff983f() && level flag::get("round_reset"))
		{
			continue;
		}
		/#
			self debug_print("");
		#/
		self zm_stats::function_c0c6ab19(#"hash_6f06db90c603f9f", 1, 1);
		if(level.round_number == 20 && zm_utility::is_classic() && !self.var_152810ff[4])
		{
			/#
				self debug_print("");
			#/
			self function_979f4cc0(#"hash_758b3285de8999f", undefined, 1);
		}
		if(level.onlinegame && level.round_number == 15 && zm_utility::is_classic() && (!(isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats)))
		{
			if(getdvarint(#"hash_2a028881d1835421", 0) == 1 && getdvarint(#"hash_21ab8e9a7fb70179", 0) != 1)
			{
				self function_cce105c8(#"hash_53d1279e51b610a9", 1, 1, 2, 3);
			}
		}
		if(!self.var_152810ff[1])
		{
			/#
				self debug_print("");
			#/
			self zm_stats::increment_challenge_stat(#"hash_4905ff3bfcad436e", undefined, 1);
		}
		if(!self.var_152810ff[2])
		{
			/#
				self debug_print("");
			#/
			self zm_stats::increment_challenge_stat(#"hash_2325c4e9d9c8568", undefined, 1);
		}
		self.var_152810ff[1] = 0;
		self.var_152810ff[2] = 0;
	}
}

/*
	Name: death_check_for_challenge_updates
	Namespace: namespace_ff457ca2
	Checksum: 0x346057C7
	Offset: 0x7D8
	Size: 0x2466
	Parameters: 1
	Flags: Linked
*/
function death_check_for_challenge_updates(e_attacker)
{
	if(!isdefined(e_attacker))
	{
		return;
	}
	if(!isplayer(e_attacker))
	{
		return;
	}
	/#
		e_attacker debug_print("");
	#/
	e_attacker function_979f4cc0(#"hash_7d03e7c8a85eec7d", undefined, 1);
	e_attacker zm_stats::function_c0c6ab19(#"kills");
	e_attacker contracts::function_5b88297d(#"hash_759f87f4e42ffcd3");
	e_attacker contracts::function_dff4c02f();
	if(isvehicle(self))
	{
		str_damagemod = self.str_damagemod;
		w_damage = self.w_damage;
	}
	else
	{
		str_damagemod = self.damagemod;
		w_damage = self.damageweapon;
	}
	var_7050de53 = w_damage.inventorytype;
	switch(w_damage.inventorytype)
	{
		case "dwlefthand":
		{
			w_damage = w_damage.dualwieldweapon;
			break;
		}
		case "primary":
		{
			if(!e_attacker playerads())
			{
				e_attacker contracts::function_5b88297d(#"hash_35f2db5e4f5935be");
			}
			break;
		}
	}
	w_damage = zm_weapons::get_nonalternate_weapon(w_damage);
	if(isdefined(self.var_6f84b820))
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_100c68ad4d261fb6");
				e_attacker stats::function_e24eec31(w_damage, #"hash_e2912dd096cfdc9", 1);
				e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_e2912dd096cfdc9", #"statvalue", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_100c68ad4d261fb6", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
				e_attacker contracts::function_5b88297d(#"hash_442b84244ca6a613");
				break;
			}
			case "miniboss":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_4fce5ab108357eb8");
				e_attacker stats::function_e24eec31(w_damage, #"hash_5bc2650d1682f530", 1);
				e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_5bc2650d1682f530", #"statvalue", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_4fce5ab108357eb8", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
				e_attacker contracts::function_5b88297d(#"hash_126eeecb48b8db2e");
				break;
			}
			case "popcorn":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker stats::function_e24eec31(w_damage, #"hash_7c40f14330df4e0b", 1);
				e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_7c40f14330df4e0b", #"statvalue", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_2c39375eacf54fa8", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
				e_attacker contracts::function_5b88297d(#"hash_2eccd05bcbd822f");
				break;
			}
			case "enhanced":
			{
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
				e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_3d1b41e5f303d731", 1);
				break;
			}
		}
	}
	switch(self.archetype)
	{
		case "hash_1bab8a0ba811401e":
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_3d1b41e5f303d731", 1);
			e_attacker thread namespace_bd02cf1::function_896ac347(w_damage, #"hash_39ab7cda18fd5c74", 1);
			e_attacker contracts::function_5b88297d(#"hash_2277f12631eb5323");
			if(isdefined(self.var_69a981e6) && self.var_69a981e6)
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_27474bb0ff47386d");
			}
			break;
		}
	}
	if(e_attacker zm_perks::function_9a0e9d65())
	{
		e_attacker stats::function_e24eec31(w_damage, #"hash_3b3dff9287f4dda9", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_3b3dff9287f4dda9", #"statvalue", 1);
	}
	else if(e_attacker zm_perks::function_80514167())
	{
		e_attacker stats::function_e24eec31(w_damage, #"hash_1469d727cf2ce4db", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_1469d727cf2ce4db", #"statvalue", 1);
	}
	if(self zm_utility::is_headshot(w_damage, self.damagelocation, str_damagemod))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::function_c0c6ab19(#"headshots");
		e_attacker contracts::function_5b88297d(#"hash_33c68058207bfb41");
		if(w_damage === e_attacker.var_2a62e678)
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_e5e9f9a250abfb0");
		}
		if(isdefined(e_attacker.var_807f94d7) && e_attacker.var_807f94d7 > 0)
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_552a925ded7df134");
		}
	}
	if(str_damagemod == "MOD_MELEE" && !namespace_2ba51478::is_hero_weapon(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_melee");
		e_attacker zm_stats::increment_challenge_stat(#"zm_daily_kills_melee");
		e_attacker zm_stats::function_c0c6ab19(#"hash_64f1bee62ae76b65");
		e_attacker contracts::function_5b88297d(#"hash_5aa9aaa3efcc8c08");
	}
	if(str_damagemod === "MOD_GRENADE" || str_damagemod === "MOD_GRENADE_SPLASH" || str_damagemod === "MOD_EXPLOSIVE" || zm_weapons::function_e17d0760(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_explosives");
		e_attacker zm_stats::function_c0c6ab19(#"explosions");
		e_attacker contracts::function_5b88297d(#"hash_6cde879eb969cfbb");
		if(w_damage == getweapon(#"hash_790eab2239858f5d"))
		{
			e_attacker function_d35a50c6();
		}
	}
	if(isdefined(self.missinglegs) && self.missinglegs)
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_crawler");
		e_attacker stats::function_e24eec31(w_damage, #"hash_b7261a853cfb61c", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_b7261a853cfb61c", #"statvalue", 1);
	}
	if(e_attacker zm_pap_util::function_b81da3fd(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_45681118c2f2a280", undefined, 1);
		e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
		e_attacker zm_stats::function_c0c6ab19(#"hash_47f7f0952495877e");
		e_attacker contracts::function_5b88297d(#"hash_3178840f53beab88");
		var_27b9587 = zm_weapons::get_base_weapon(w_damage);
		e_attacker stats::function_e24eec31(w_damage, #"hash_289883e2f7a6af52", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_289883e2f7a6af52", #"statvalue", 1);
	}
	else if(zm_weapons::is_weapon_upgraded(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_kill_packapunch");
		e_attacker zm_stats::function_c0c6ab19(#"hash_5d3dce1c38a95835");
		e_attacker contracts::function_5b88297d(#"hash_3178840f53beab88");
		var_27b9587 = zm_weapons::get_base_weapon(w_damage);
		e_attacker stats::function_e24eec31(w_damage, #"hash_289883e2f7a6af52", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_289883e2f7a6af52", #"statvalue", 1);
	}
	else
	{
		var_27b9587 = zm_weapons::function_386dacbc(w_damage);
	}
	if(zm_weapons::is_wonder_weapon(w_damage))
	{
		e_attacker contracts::function_5b88297d(#"hash_1db0aaefc2baceb4");
	}
	if(isdefined(level.zombie_weapons[var_27b9587]))
	{
		switch(level.zombie_weapons[var_27b9587].weapon_classname)
		{
			case "ar":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_58b00abb84f19b74");
				e_attacker zm_stats::function_c0c6ab19(#"hash_4b7cd30475a320ec");
				e_attacker contracts::function_5b88297d(#"hash_6887bad7ad79485b");
				break;
			}
			case "lmg":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_15c2f8dd431370f9");
				e_attacker zm_stats::function_c0c6ab19(#"hash_580e2094234e5ac5");
				e_attacker contracts::function_5b88297d(#"hash_475aacbeb2b4fe0c");
				break;
			}
			case "pistol":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_394fe6e6b6ef8b48");
				e_attacker zm_stats::function_c0c6ab19(#"hash_5ddac928c4d4e8cc");
				e_attacker contracts::function_5b88297d(#"hash_4d1e895f9313c6b");
				break;
			}
			case "shotgun":
			{
				e_attacker function_d35a50c6();
				break;
			}
			case "smg":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_4c9d106b9054e930");
				e_attacker zm_stats::function_c0c6ab19(#"hash_4cba49938c3ab570");
				e_attacker contracts::function_5b88297d(#"hash_7dfd3b61c51584fd");
				break;
			}
			case "sniper":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_5f487e6a2cc330c8");
				e_attacker zm_stats::function_c0c6ab19(#"hash_2333d2f2b7271a56");
				e_attacker contracts::function_5b88297d(#"hash_b47dacccdb18663");
				break;
			}
			case "tr":
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_264de6064dd27a15");
				e_attacker zm_stats::function_c0c6ab19(#"hash_26d8f2fa0846a614");
				e_attacker contracts::function_5b88297d(#"hash_4974be997d299342");
				break;
			}
		}
	}
	if(e_attacker zm_powerups::is_insta_kill_active())
	{
		e_attacker stats::function_e24eec31(w_damage, #"hash_3d631fcd6c99a321", 1);
		e_attacker stats::inc_stat(#"hash_162f9b6a10fa7d66", w_damage.name, #"hash_3d631fcd6c99a321", #"statvalue", 1);
	}
	if(w_damage.rootweapon.name == #"hash_1b055fadc5573c29" || w_damage.rootweapon.name == #"hash_1aea58adc540688c" || w_damage.rootweapon.name == #"hash_3b34bf98ebd70d14" || w_damage.rootweapon.name == #"hash_3b19c698ebc05141")
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_2a72be53205a8db3");
		return;
	}
	if(weaponhasattachment(w_damage, "uber"))
	{
		var_4709221d = w_damage.statname;
		if(str_damagemod == "MOD_MELEE" && (var_4709221d == #"ar_stealth_t8" || var_4709221d == #"pistol_standard_t8"))
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_3a43a56f5f2aeacc");
			return;
		}
		if(var_4709221d == #"sniper_quickscope_t8" || var_4709221d == #"smg_capacity_t8" || var_4709221d == #"lmg_spray_t8")
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_63e3f06d30760b7e");
			return;
		}
		if(var_4709221d == #"lmg_heavy_t8" || var_4709221d == #"shotgun_pump_t8" || var_4709221d == #"pistol_revolver_t8")
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_2a72be53205a8db3");
			return;
		}
		if(var_4709221d == #"tr_midburst_t8" || var_4709221d == #"smg_fastfire_t8" || var_4709221d == #"ar_fastfire_t8")
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_733f619bc1c13bdd");
			return;
		}
		if(var_4709221d == #"tr_powersemi_t8" || var_4709221d == #"tr_longburst_t8" || var_4709221d == #"sniper_fastrechamber_t8" || var_4709221d == #"smg_accurate_t8")
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_7ac3980eb0c9f12d");
			return;
		}
		if(var_4709221d == #"lmg_standard_t8" || var_4709221d == #"shotgun_semiauto_t8")
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_d0eb45f997dadf0");
			return;
		}
	}
	if(w_damage.statname === #"bowie_knife")
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_2a5699203eb6eeef");
		return;
	}
	if(isdefined(w_damage.var_ff0b00ba) && w_damage.var_ff0b00ba)
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::function_c0c6ab19(#"hash_3e934a4d2ecdedfd");
		e_attacker contracts::function_5b88297d(#"hash_47a744f5c776d978");
	}
	if(zm_utility::is_frag_grenade(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_127a105903cdac43");
		return;
	}
	if(zm_utility::function_5616854c(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_133bbb2db120c3ef");
		return;
	}
	if(zm_utility::function_b6208d7f(w_damage, 1))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"sentry_kills");
		return;
	}
	if(zm_utility::function_b797694c(w_damage))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_39a70a2d418f6a87");
		return;
	}
	if(zm_utility::function_850e7499(w_damage, 1))
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_4e95db8d75052f1");
		return;
	}
	if(isdefined(w_damage.isriotshield) && w_damage.isriotshield)
	{
		/#
			e_attacker debug_print("");
		#/
		e_attacker zm_stats::increment_challenge_stat(#"hash_79cc5aee66351e26");
		e_attacker contracts::function_5b88297d(#"hash_7af98643fc22ffd5");
		return;
	}
	if(namespace_2ba51478::is_hero_weapon(w_damage) || zm_hero_weapon::function_6a32b8f(w_damage))
	{
		e_attacker zm_stats::function_c0c6ab19(#"hash_3aa06a6c00e61474");
		e_attacker contracts::function_5b88297d(#"hash_4f442f95b647960b");
		e_attacker contracts::function_ac03f21e();
		if(w_damage == getweapon(#"hero_chakram_lv1") || w_damage == getweapon(#"hero_chakram_lv2") || w_damage == getweapon(#"hero_chakram_lv3") || w_damage == getweapon(#"hash_18829d56b3fbd75b") || w_damage == getweapon(#"hash_18829e56b3fbd90e") || w_damage == getweapon(#"hash_18829f56b3fbdac1"))
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_4aa750e907d2acba");
			if(w_damage == getweapon(#"hero_chakram_lv3") || w_damage == getweapon(#"hash_18829f56b3fbdac1"))
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_7d8e97afa865c9a7");
			}
			return;
		}
		if(w_damage == getweapon(#"hero_hammer_lv1") || w_damage == getweapon(#"hero_hammer_lv2") || w_damage == getweapon(#"hero_hammer_lv3") || w_damage == getweapon(#"hash_74dd67dd8a46d144") || w_damage == getweapon(#"hash_74dd6add8a46d65d") || w_damage == getweapon(#"hash_74dd69dd8a46d4aa") || w_damage == getweapon(#"hash_492e530f9862f6cc") || w_damage == getweapon(#"hash_628d99860c78650f"))
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_3e5b9b81d573d194");
			if(w_damage == getweapon(#"hero_hammer_lv3") || w_damage == getweapon(#"hash_74dd69dd8a46d4aa") || w_damage == getweapon(#"hash_628d99860c78650f") || (w_damage == getweapon(#"hash_492e530f9862f6cc") && e_attacker hasweapon(getweapon(#"hash_74dd69dd8a46d4aa"))))
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_7d8e97afa865c9a7");
			}
			return;
		}
		if(w_damage == getweapon(#"hero_sword_pistol_lv1") || w_damage == getweapon(#"hero_sword_pistol_lv2") || w_damage == getweapon(#"hero_sword_pistol_lv3") || w_damage == getweapon(#"hash_6627879099b8a337") || w_damage == getweapon(#"hash_6627889099b8a4ea") || w_damage == getweapon(#"hash_6627899099b8a69d"))
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_43bd32b7705f38fd");
			if(w_damage == getweapon(#"hero_sword_pistol_lv3") || w_damage == getweapon(#"hash_6627899099b8a69d"))
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_7d8e97afa865c9a7");
			}
			return;
		}
		if(w_damage == getweapon(#"hash_50f35e4cfb775e02") || w_damage == getweapon(#"hash_50f35d4cfb775c4f") || w_damage == getweapon(#"hash_50f35c4cfb775a9c") || w_damage == getweapon(#"hash_1d3a5509fa2c9ee6") || w_damage == getweapon(#"hash_1d3a5409fa2c9d33") || w_damage == getweapon(#"hash_1d3a5309fa2c9b80"))
		{
			/#
				e_attacker debug_print("");
			#/
			e_attacker zm_stats::increment_challenge_stat(#"hash_35c05a1d6c5fb3e1");
			if(w_damage == getweapon(#"hash_50f35c4cfb775a9c") || w_damage == getweapon(#"hash_1d3a5309fa2c9b80"))
			{
				/#
					e_attacker debug_print("");
				#/
				e_attacker zm_stats::increment_challenge_stat(#"hash_7d8e97afa865c9a7");
			}
			return;
		}
	}
}

/*
	Name: spent_points_tracking
	Namespace: namespace_ff457ca2
	Checksum: 0x1490ECE0
	Offset: 0x2C48
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function spent_points_tracking()
{
	level endon(#"end_game");
	while(true)
	{
		result = undefined;
		result = level waittill(#"spent_points");
		player = result.player;
		n_points = result.points;
		player.var_152810ff[0] = player.var_152810ff[0] + n_points;
		/#
			player debug_print("");
		#/
		player zm_stats::increment_challenge_stat(#"hash_c7f076298b8f2cd", n_points, 1);
	}
}

/*
	Name: increment_magic_box
	Namespace: namespace_ff457ca2
	Checksum: 0x3BF97691
	Offset: 0x2D38
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function increment_magic_box()
{
	/#
		self debug_print("");
	#/
}

/*
	Name: perk_drink_tracking
	Namespace: namespace_ff457ca2
	Checksum: 0xC9635E26
	Offset: 0x2D68
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function perk_drink_tracking()
{
	self endon(#"disconnect");
	while(true)
	{
		self waittill(#"perk_bought");
		/#
			self debug_print("");
		#/
	}
}

/*
	Name: function_73696786
	Namespace: namespace_ff457ca2
	Checksum: 0x3992A346
	Offset: 0x2DC8
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function function_73696786()
{
	self endon(#"disconnect");
	var_c0e0819a = 1;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"hash_13948ef3726b968f");
		if(isdefined(var_c0e0819a) && var_c0e0819a)
		{
			/#
				self debug_print("");
			#/
			self zm_stats::increment_challenge_stat(#"hash_6f2c378eee6730ea");
			var_c0e0819a = undefined;
		}
		self function_b892d1da();
	}
}

/*
	Name: function_12a35616
	Namespace: namespace_ff457ca2
	Checksum: 0xF4CCB701
	Offset: 0x2E90
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_12a35616()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_656719782f57ca1a");
		if(isdefined(waitresult.produced) && (isdefined(waitresult.produced.isriotshield) && waitresult.produced.isriotshield))
		{
			/#
				self debug_print("");
			#/
			return;
		}
	}
}

/*
	Name: function_a9f6b8ef
	Namespace: namespace_ff457ca2
	Checksum: 0x18A5F17A
	Offset: 0x2F50
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function function_a9f6b8ef()
{
	level endon(#"end_game");
	if(namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 2 || namespace_59ff1d6c::function_901b751c(#"hash_19d48a0d4490b0a2") == 0)
	{
		return;
	}
	level flag::wait_till("pap_machine_active");
	foreach(player in level.players)
	{
		/#
			player debug_print("");
		#/
		player zm_stats::increment_challenge_stat(#"hash_2f8c66f4c58f068b", undefined, 1);
	}
}

/*
	Name: debug_print
	Namespace: namespace_ff457ca2
	Checksum: 0x6DEC8294
	Offset: 0x3090
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function debug_print(str_line)
{
	/#
		if(getdvarint(#"zombie_debug", 0) > 0)
		{
			println("" + self.entity_num + "" + str_line);
		}
	#/
}

/*
	Name: on_challenge_complete
	Namespace: namespace_ff457ca2
	Checksum: 0x62D2A038
	Offset: 0x3108
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function on_challenge_complete(params)
{
	n_challenge_index = params.challenge_index;
}

/*
	Name: function_cbb67d20
	Namespace: namespace_ff457ca2
	Checksum: 0xF7DF1096
	Offset: 0x3148
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_cbb67d20(n_challenge_index)
{
	return 0;
}

/*
	Name: function_9a9ab6f6
	Namespace: namespace_ff457ca2
	Checksum: 0xA8091AEC
	Offset: 0x3160
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_9a9ab6f6(var_1c48b665)
{
	self zm_stats::increment_challenge_stat(var_1c48b665);
	foreach(var_6c7a7f72 in array(#"darkops_zod_ee", #"hash_6d5340d9e43ed73d", #"hash_ad3a508a80a0e6e"))
	{
		if(!self stats::function_441050ca(var_6c7a7f72))
		{
			return;
		}
	}
	/#
		self debug_print("");
	#/
	self function_979f4cc0(#"hash_405387fd6efe78b3");
}

/*
	Name: function_b892d1da
	Namespace: namespace_ff457ca2
	Checksum: 0x4F937F7D
	Offset: 0x3280
	Size: 0x1DC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b892d1da()
{
	var_684d09cd = array(#"perk_additional_primary_weapon", #"hash_420c7fd6609f0966", #"hash_69fcf7d746edeeaf", #"perk_dead_shot", #"hash_53548db163b3a77e", #"hash_e58ff2df5bfd9b3", #"perk_electric_cherry", #"perk_quick_revive", #"hash_63e46074d37d524b", #"perk_staminup", #"hash_452086e4c25a6fe4", #"hash_2d1dfb82ebcbdb7d", #"perk_widows_wine");
	foreach(var_9b9f4901 in var_684d09cd)
	{
		if(!self stats::get_stat(#"hash_409332e5f180ebd", var_9b9f4901, #"hash_3665254f9bca8d1e", #"statvalue"))
		{
			return;
		}
	}
	/#
		self debug_print("");
	#/
	self function_979f4cc0(#"hash_34f185c936027147", undefined, 1);
}

/*
	Name: function_bf0be8f1
	Namespace: namespace_ff457ca2
	Checksum: 0xDF63765E
	Offset: 0x3468
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_bf0be8f1()
{
	foreach(var_b1cb18f1 in array("zm_zodt8", "zm_towers", "zm_escape"))
	{
		if(!self stats::get_stat(#"playerstatsbymap", var_b1cb18f1, #"hash_74e26ca9652802fb", level.gametype, #"stats", "FASTEST_TIME_TO_COMPLETE_ROUND_30", #"statvalue"))
		{
			return;
		}
	}
	/#
		self debug_print("");
	#/
	self function_979f4cc0(#"hash_c59a95e3be43538");
}

/*
	Name: function_e40c9d13
	Namespace: namespace_ff457ca2
	Checksum: 0x59CBA356
	Offset: 0x35A0
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_e40c9d13()
{
	var_b361a853 = array(#"hash_4dfeb08c20a14b8b", #"hash_478e71d96c16eb50", #"hash_2b648e8ce3814bbb", #"hash_55330e258be3e3cc", #"hash_e1311542f5782b5", #"hash_2c8e9cd5fbd53e70", #"hash_7f6a3674177103f1", #"hash_2721c688766673fb", #"hash_6aadfdc58af04635", #"hash_1efb82c43276a4e3", #"hash_1fc7843987e89a83", #"hash_2df0835a53060b95", #"hash_c2a620242d1636a", #"hash_cd53ea4d4ee864c", #"hash_6a0c4101e88a4707", #"hash_459f15018585edda", #"hash_713d1e36bd254b65", #"shotgun_trenchgun_t8_upgraded", #"hash_757d19cbfbeb94b7", #"hash_354b896513d0581d", #"hash_3477cc89337a5ea5", #"hash_435dd4ea9f2fd1bf", #"hash_514128f7d058cde0", #"hash_fcb8798a7354324", #"hash_16044c4b951b7bdd", #"hash_173040967fe4f754", #"sniper_quickscope_t8_upgraded", #"hash_7f8028bb8adc966c", #"hash_4bf5a2219b1a65d2", #"hash_44f95b73da64d7ee", #"hash_81c373345c076c1");
	foreach(var_5f8b3585 in var_b361a853)
	{
		if(!self stats::get_stat(#"hash_162f9b6a10fa7d66", var_5f8b3585, #"hash_5d5a976d59876880", #"statvalue"))
		{
			return;
		}
	}
	/#
		self debug_print("");
	#/
	self function_979f4cc0(#"hash_40d2ff74fd37a2ab", undefined, 1);
}

/*
	Name: function_a3cd4521
	Namespace: namespace_ff457ca2
	Checksum: 0x3899D4AA
	Offset: 0x38A8
	Size: 0x1354
	Parameters: 0
	Flags: Linked
*/
function function_a3cd4521()
{
	if(self stats::get_stat(#"playerstatslist", #"hash_516183f89adeace1"))
	{
		return;
	}
	if(!level.onlinegame || (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats))
	{
		return;
	}
	self endon(#"disconnect");
	self waittill(#"spawned");
	level flag::wait_till("gameplay_started");
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"kills") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"zombie_hunter_kill_melee") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"zombie_hunter_kill_headshot") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"zombie_hunter_kill_crawler") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"zombie_hunter_kill_packapunch") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_45681118c2f2a280") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"zombie_hunter_kill_explosives") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_100c68ad4d261fb6") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4fce5ab108357eb8") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"catalysts_killed") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_564d41c1808857c7") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_27474bb0ff47386d") == 3)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"zombie_hunter_mastery");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"zombie_hunter_mastery", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"survivalist_buy_magic_box") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_buy_perk") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_buy_wallbuy") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_buy_door") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_revive") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_survive_rounds") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_2325c4e9d9c8568") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4905ff3bfcad436e") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"survivalist_powerup") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_c7f076298b8f2cd") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_2f0fbad6ce68f465") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_6f2c378eee6730ea") == 3)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"survivalist_mastery");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"survivalist_mastery", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_2f8c66f4c58f068b") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_203688d7883cf38c") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_300fdf15a515feda") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_79cc5aee66351e26") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7199c0c1e12de89a") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_3e5b9b81d573d194") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4aa750e907d2acba") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_43bd32b7705f38fd") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_35c05a1d6c5fb3e1") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_5f629a09731f538c") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4182a6e5bc52ba9") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7d8e97afa865c9a7") == 3)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"hash_24ccc77cf1df2b49");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"hash_24ccc77cf1df2b49", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_41d41d501c70fb30") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_133575f669ffc55c") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"gum_gobbler_burned_out") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_19d6a97f1553f96f") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_3ebae93ea866519c") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_1f20f53b7084fdcb") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_733e96c5baacb1da") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_108042c8bd6693fb") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_5d098efca02f7c99") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_54f005134489c6d") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_47646e52fcbb190e") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_6a8397235f934872") == 3)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"hash_394c19e7ac92098c");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"hash_394c19e7ac92098c", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_394fe6e6b6ef8b48") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_61df9bce444b2483") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_58b00abb84f19b74") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_15c2f8dd431370f9") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_5f487e6a2cc330c8") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4c9d106b9054e930") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_264de6064dd27a15") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_127a105903cdac43") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_39a70a2d418f6a87") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_4e95db8d75052f1") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"sentry_kills") == 3)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_133bbb2db120c3ef") == 3)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"hash_452e07bec3b77c8e");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"hash_452e07bec3b77c8e", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_2a5699203eb6eeef") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_63e3f06d30760b7e") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_2a72be53205a8db3") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_3a43a56f5f2aeacc") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_733f619bc1c13bdd") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7ac3980eb0c9f12d") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_d0eb45f997dadf0") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_e5e9f9a250abfb0") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_783ec74bf31f604d") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_13d0e9e764b1b52") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_76650a0cbe2993ad") == 5)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_552a925ded7df134") == 5)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"hash_4b011cd0269a8502");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"hash_4b011cd0269a8502", var_a9d7bd6 - var_76f39460);
	}
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_16aa183f2c51f999") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_69f53cb2579fba3e") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_6d551a71b5461906") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_405387fd6efe78b3") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7d03e7c8a85eec7d") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_47685630580f6b5f") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_34f185c936027147") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_2eed193144ed0fee") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_c59a95e3be43538") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7a406e363a7db141") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_758b3285de8999f") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_40d2ff74fd37a2ab") == 1)
	{
		var_a9d7bd6++;
	}
	var_76f39460 = self stats::function_222de31d(#"hash_72a217263c8a78f");
	if(var_76f39460 < var_a9d7bd6)
	{
		self stats::function_dad108fa(#"hash_72a217263c8a78f", var_a9d7bd6 - var_76f39460);
	}
	self stats::set_stat(#"playerstatslist", #"hash_516183f89adeace1", 1);
}

/*
	Name: function_d35a50c6
	Namespace: namespace_ff457ca2
	Checksum: 0xF727673D
	Offset: 0x4C08
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_d35a50c6()
{
	/#
		self debug_print("");
	#/
	self zm_stats::increment_challenge_stat(#"hash_61df9bce444b2483");
	self zm_stats::function_c0c6ab19(#"hash_2624733be0c73be4");
	self contracts::function_5b88297d(#"hash_354e673137b60582");
}

/*
	Name: function_f9ce6f88
	Namespace: namespace_ff457ca2
	Checksum: 0xB06F2D56
	Offset: 0x4C98
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_f9ce6f88()
{
	if(self stats::get_stat(#"playerstatslist", #"hash_4ff2cd40a877db2f"))
	{
		return;
	}
	if(!level.onlinegame || (isdefined(level.zm_disable_recording_stats) && level.zm_disable_recording_stats))
	{
		return;
	}
	self endon(#"disconnect");
	self waittill(#"spawned");
	level flag::wait_till("gameplay_started");
	var_a9d7bd6 = function_6cc59b84();
	if(var_a9d7bd6 >= 6)
	{
		self zm_stats::increment_challenge_stat(#"hash_2eed193144ed0fee");
	}
	self stats::set_stat(#"playerstatslist", #"hash_4ff2cd40a877db2f", 1);
}

/*
	Name: function_979f4cc0
	Namespace: namespace_ff457ca2
	Checksum: 0xC338BB0
	Offset: 0x4DD0
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_979f4cc0(var_38f795c7, n_amount, b_disable = 0)
{
	self zm_stats::increment_challenge_stat(var_38f795c7, n_amount, b_disable);
	var_a9d7bd6 = function_6cc59b84();
	if(var_a9d7bd6 == 6)
	{
		self zm_stats::increment_challenge_stat(#"hash_2eed193144ed0fee");
	}
}

/*
	Name: function_6cc59b84
	Namespace: namespace_ff457ca2
	Checksum: 0x6ECC471F
	Offset: 0x4E70
	Size: 0x226
	Parameters: 0
	Flags: Linked
*/
function function_6cc59b84()
{
	var_a9d7bd6 = 0;
	if(self stats::function_af5584ca(#"hash_16aa183f2c51f999") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_69f53cb2579fba3e") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_6d551a71b5461906") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_405387fd6efe78b3") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7d03e7c8a85eec7d") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_47685630580f6b5f") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_34f185c936027147") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_c59a95e3be43538") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_7a406e363a7db141") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_758b3285de8999f") == 1)
	{
		var_a9d7bd6++;
	}
	if(self stats::function_af5584ca(#"hash_40d2ff74fd37a2ab") == 1)
	{
		var_a9d7bd6++;
	}
	return var_a9d7bd6;
}

