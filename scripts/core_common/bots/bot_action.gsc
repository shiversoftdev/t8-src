// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_6158278c8647d8a9;
#using script_68d2ee1489345a1d;
#using script_ee56e8b680377b6;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace bot_action;

/*
	Name: function_89f2df9
	Namespace: bot_action
	Checksum: 0xA153AE7D
	Offset: 0x4B8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"bot_action", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bot_action
	Checksum: 0x11DBCCB
	Offset: 0x500
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.botactions = [];
	level.botweapons = [];
}

/*
	Name: function_66dacac1
	Namespace: bot_action
	Checksum: 0x79A8E4CC
	Offset: 0x528
	Size: 0x5F4
	Parameters: 0
	Flags: Linked
*/
function function_66dacac1()
{
	register_action(#"revive_player", &rank_priority, &revive_player_weight, &revive_player);
	register_action(#"hash_70b84fb088f2cab0", &rank_priority, &function_3cb4c00e, &function_29904346);
	register_action(#"switch_to_weapon", &best_stowed_primary_weapon_rank, &switch_to_weapon_weight, &switch_to_weapon);
	register_action(#"hash_78881ac649c38041", &rank_priority, &function_5647e838, &function_40aa6f87);
	register_action(#"hash_7a6c10e55fac2c60", &current_melee_weapon_rank, &function_abf40e98, &function_c8ae6981);
	register_action(#"melee_enemy", &current_melee_weapon_rank, &melee_enemy_weight, &melee_enemy);
	register_action(#"reload_weapon", &current_weapon_rank, &reload_weapon_weight, &reload_weapon);
	register_action(#"look_for_enemy", &current_weapon_rank, &look_for_enemy_weight, &look_for_enemy);
	register_action(#"hash_55fc6b6e868ae6c3", &current_weapon_rank, &function_1176a20b, &function_e0dcb8c1);
	register_action(#"hash_2bbb309be663cb4c", &function_728212e8, &scan_for_threats_weight, &function_9e1d8dfe);
	register_action(#"scan_for_threats", &function_728212e8, &scan_for_threats_weight, &scan_for_threats);
	register_action(#"bleed_out", &rank_priority, &bleed_out_weight, &bleed_out);
	register_action(#"hash_7aaeac32a4e1bf84", &weapon_rank, &function_36505c2d, &function_a314673);
	register_action(#"hash_434716893aa869f3", &weapon_rank, &function_294f4909, &function_e73c8946);
	register_action(#"hash_4c707ba80bf09cec", &weapon_rank, &function_294f4909, &function_22e2ba8c);
	register_action(#"hash_3d7dd2878425bcce", &weapon_rank, &function_2bc7472b, &function_36ca6d92);
	register_action(#"fire_grenade", &weapon_rank, &registersndrampend_death, &fire_grenade);
	register_action(#"fire_rocketlauncher", &weapon_rank, &function_a365f27e, &fire_rocketlauncher);
	register_action(#"fire_locked_rocketlauncher", &weapon_rank, &function_4de5fcc3, &fire_locked_rocketlauncher);
}

/*
	Name: register_weapons
	Namespace: bot_action
	Checksum: 0x6C2B1998
	Offset: 0xB28
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function register_weapons()
{
	register_weapon(#"none", &function_d9c35bee);
	function_ab03ca93(#"ar_accurate_t8");
	function_ab03ca93(#"ar_damage_t8");
	function_ab03ca93(#"ar_fastfire_t8");
	function_ab03ca93(#"ar_modular_t8");
	function_ab03ca93(#"ar_stealth_t8");
	function_ab03ca93(#"lmg_double_t8");
	function_ab03ca93(#"lmg_heavy_t8");
	function_ab03ca93(#"lmg_spray_t8");
	function_ab03ca93(#"lmg_standard_t8");
	function_ab03ca93(#"pistol_burst_t8");
	function_ab03ca93(#"pistol_standard_t8");
	function_ab03ca93(#"pistol_revolver_t8");
	function_ab03ca93(#"shotgun_pump_t8");
	function_ab03ca93(#"shotgun_semiauto_t8");
	function_ab03ca93(#"smg_accurate_t8");
	function_ab03ca93(#"smg_capacity_t8");
	function_ab03ca93(#"smg_fastfire_t8");
	function_ab03ca93(#"smg_handling_t8");
	function_ab03ca93(#"smg_standard_t8");
	function_1c642d2c(#"sniper_fastrechamber_t8");
	function_1c642d2c(#"sniper_powerbolt_t8");
	function_1c642d2c(#"sniper_powersemi_t8");
	function_1c642d2c(#"sniper_quickscope_t8");
	function_ab03ca93(#"tr_leveraction_t8");
	function_ab03ca93(#"tr_longburst_t8");
	function_ab03ca93(#"tr_midburst_t8");
	function_ab03ca93(#"tr_powersemi_t8");
	register_weapon(#"launcher_standard_t8", &function_317d4797);
}

/*
	Name: function_25f1e3c1
	Namespace: bot_action
	Checksum: 0x1FB0A170
	Offset: 0xEF8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_25f1e3c1()
{
	function_a2c83569(#"launcher_standard_t8", "fire_rocketlauncher");
	function_a2c83569(#"launcher_standard_t8", "fire_locked_rocketlauncher");
}

/*
	Name: start
	Namespace: bot_action
	Checksum: 0x12D1969
	Offset: 0xF58
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function start()
{
	self function_42907fd4();
}

/*
	Name: function_42907fd4
	Namespace: bot_action
	Checksum: 0xC7BAB538
	Offset: 0xF80
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_42907fd4()
{
	self.bot.var_469cfe53 = {#isfavoriteenemy:0, #istarget:0, #distsq:1000000, #maxhealth:100};
}

/*
	Name: stop
	Namespace: bot_action
	Checksum: 0xFB4AE047
	Offset: 0xFE8
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function stop()
{
	self notify(#"hash_5b4f399c08222e2");
}

/*
	Name: reset
	Namespace: bot_action
	Checksum: 0x41E5015B
	Offset: 0x1008
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function reset()
{
	if(isdefined(self.bot))
	{
		self.bot.var_bdbba2cd = 0;
	}
}

/*
	Name: update
	Namespace: bot_action
	Checksum: 0x6E2756AB
	Offset: 0x1038
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function update()
{
	if(isdefined(self.bot.action))
	{
		self notify(#"hash_347a612b61067eb3");
		/#
			var_2b41fd19 = (self.bot.var_b594a2cd.forced ? "" : "");
			record3dtext(("" + function_9e72a96(self.bot.action.name)) + var_2b41fd19, self.origin, (1, 0, 1), "", self, 0.5);
		#/
		return;
	}
	self thread execution_loop();
}

/*
	Name: force
	Namespace: bot_action
	Checksum: 0xA2B48867
	Offset: 0x1148
	Size: 0x70
	Parameters: 3
	Flags: None
*/
function force(actionname, weapon, target)
{
	action = get_action(actionname);
	if(!isdefined(action))
	{
		return false;
	}
	self function_fced7d8a(action, weapon, target);
	return true;
}

/*
	Name: function_ee2eaccc
	Namespace: bot_action
	Checksum: 0x86B89C44
	Offset: 0x11C0
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_ee2eaccc(slot)
{
	gadgetweapon = undefined;
	weapons = self getweaponslist();
	foreach(weapon in weapons)
	{
		if(self gadgetgetslot(weapon) == slot)
		{
			gadgetweapon = weapon;
			break;
		}
	}
	if(!isdefined(gadgetweapon))
	{
		return;
	}
	var_13e42e18 = gadgetweapon.rootweapon.var_791bc2f7;
	if(!isdefined(var_13e42e18) || var_13e42e18.size <= 0)
	{
		/#
			self botprinterror("" + function_9e72a96(weapon.name));
		#/
		return;
	}
	self gadgetpowerset(slot, 100);
	self gadgetcharging(slot, 0);
	self function_fced7d8a(var_13e42e18[0], gadgetweapon, self.enemy);
}

/*
	Name: function_4a53ae1f
	Namespace: bot_action
	Checksum: 0xCD6DAB1A
	Offset: 0x1368
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_4a53ae1f()
{
	scorestreakweapon = undefined;
	weapons = self getweaponslist();
	for(i = 5; i < weapons.size; i++)
	{
		if(killstreaks::is_killstreak_weapon(weapons[i]))
		{
			scorestreakweapon = weapons[i];
			break;
		}
	}
	if(!isdefined(scorestreakweapon))
	{
		return;
	}
	var_13e42e18 = scorestreakweapon.rootweapon.var_791bc2f7;
	if(!isdefined(var_13e42e18) || var_13e42e18.size <= 0)
	{
		/#
			self botprinterror("" + function_9e72a96(weapons[i].name));
		#/
		return;
	}
	self function_fced7d8a(var_13e42e18[0], scorestreakweapon, self.enemy);
}

/*
	Name: function_fced7d8a
	Namespace: bot_action
	Checksum: 0x30B838DF
	Offset: 0x14A0
	Size: 0x84
	Parameters: 3
	Flags: Linked, Private
*/
function private function_fced7d8a(action, weapon, target)
{
	self.bot.var_e6a1f475 = {#forced:1, #target:target, #weapon:weapon, #action:action};
	self reset();
}

/*
	Name: register_action
	Namespace: bot_action
	Checksum: 0x1CDC59E4
	Offset: 0x1530
	Size: 0x7E
	Parameters: 4
	Flags: Linked
*/
function register_action(name, rankfunc, weightfunc, executefunc)
{
	level.botactions[name] = {#executefunc:executefunc, #weightfunc:weightfunc, #rankfunc:rankfunc, #name:name};
}

/*
	Name: register_weapon
	Namespace: bot_action
	Checksum: 0xC60FF221
	Offset: 0x15B8
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function register_weapon(weaponname, rankfunc)
{
	weapon = getweapon(weaponname);
	if(weapon.name == #"none")
	{
		return;
	}
	level.botweapons[weaponname] = weapon;
	weapon.var_ede647ad = rankfunc;
}

/*
	Name: function_36052a7f
	Namespace: bot_action
	Checksum: 0x102103E5
	Offset: 0x1648
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_36052a7f(weaponname)
{
	/#
		if(!isdefined(level.botweapons[weaponname]))
		{
			/#
				assertmsg(("" + function_9e72a96(weaponname)) + "");
			#/
		}
	#/
}

/*
	Name: function_ab03ca93
	Namespace: bot_action
	Checksum: 0xA99C6C5A
	Offset: 0x16B0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_ab03ca93(weaponname)
{
	register_weapon(weaponname, &function_22991a48);
	function_a2c83569(weaponname, #"hash_7aaeac32a4e1bf84");
	function_a2c83569(weaponname, #"hash_434716893aa869f3");
}

/*
	Name: function_1c642d2c
	Namespace: bot_action
	Checksum: 0xD80AAF55
	Offset: 0x1728
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_1c642d2c(weaponname)
{
	register_weapon(weaponname, &function_22991a48);
	function_a2c83569(weaponname, #"hash_4c707ba80bf09cec");
}

/*
	Name: function_f4302f2a
	Namespace: bot_action
	Checksum: 0x3DFB1B9B
	Offset: 0x1780
	Size: 0x6A
	Parameters: 3
	Flags: None
*/
function function_f4302f2a(weaponname, rankfunc, activatefunc)
{
	register_weapon(weaponname, rankfunc);
	weapon = level.botweapons[weaponname];
	if(!isdefined(weapon))
	{
		return;
	}
	weapon.var_c7e8f553 = activatefunc;
}

/*
	Name: function_c67ea19e
	Namespace: bot_action
	Checksum: 0x79E91C7
	Offset: 0x17F8
	Size: 0x6A
	Parameters: 3
	Flags: None
*/
function function_c67ea19e(weaponname, rankfunc, activatefunc)
{
	register_weapon(weaponname, rankfunc);
	weapon = level.botweapons[weaponname];
	if(!isdefined(weapon))
	{
		return;
	}
	weapon.var_c75f000 = activatefunc;
}

/*
	Name: function_a2c83569
	Namespace: bot_action
	Checksum: 0x118E0AB
	Offset: 0x1870
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function function_a2c83569(weaponname, actionname)
{
	weapon = level.botweapons[weaponname];
	if(!isdefined(weapon))
	{
		return;
	}
	action = get_action(actionname);
	if(!isdefined(action))
	{
		return;
	}
	if(!isdefined(weapon.var_e2f5d985))
	{
		weapon.var_e2f5d985 = [];
	}
	weapon.var_e2f5d985[weapon.var_e2f5d985.size] = action;
}

/*
	Name: function_7e847a84
	Namespace: bot_action
	Checksum: 0x1117BA3B
	Offset: 0x1918
	Size: 0x9E
	Parameters: 2
	Flags: None
*/
function function_7e847a84(weaponname, actionname)
{
	weapon = level.botweapons[weaponname];
	if(!isdefined(weapon))
	{
		return;
	}
	action = get_action(actionname);
	if(!isdefined(action))
	{
		return;
	}
	if(!isdefined(weapon.var_791bc2f7))
	{
		weapon.var_791bc2f7 = [];
	}
	weapon.var_791bc2f7[weapon.var_791bc2f7.size] = action;
}

/*
	Name: get_action
	Namespace: bot_action
	Checksum: 0x6CA057E1
	Offset: 0x19C0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function get_action(name)
{
	return level.botactions[name];
}

/*
	Name: function_10723c01
	Namespace: bot_action
	Checksum: 0xCD88E315
	Offset: 0x19E8
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function function_10723c01(weapon, var_3f4e87bd)
{
	if(!isdefined(var_3f4e87bd))
	{
		return;
	}
	paramslist = self.bot.paramslist;
	foreach(action in var_3f4e87bd)
	{
		var_b594a2cd = {#weapon:weapon, #action:action};
		/#
			var_b594a2cd.debug = [];
		#/
		paramslist[paramslist.size] = var_b594a2cd;
	}
}

/*
	Name: function_fd9117cc
	Namespace: bot_action
	Checksum: 0x2A48440
	Offset: 0x1AE0
	Size: 0x28A
	Parameters: 0
	Flags: Linked
*/
function function_fd9117cc()
{
	currentweapon = self getcurrentweapon();
	var_c300ee65 = self.bot.var_469cfe53;
	if(self function_3094610b(self.bot.tacbundle.var_82aa37d8))
	{
		var_c300ee65 = spawnstruct();
		var_c300ee65.maxhealth = self.enemy get_max_health();
		var_c300ee65.distsq = distancesquared(self.origin, self.enemy.origin);
		var_c300ee65.istarget = target_istarget(self.enemy);
		var_c300ee65.isfavoriteenemy = isdefined(self.favoriteenemy) && self.favoriteenemy == self.enemy;
	}
	if(isdefined(self.revivetrigger))
	{
		self rank_weapon(currentweapon, var_c300ee65);
		self function_10723c01(currentweapon, currentweapon.rootweapon.var_e2f5d985);
		return;
	}
	weapons = self getweaponslist();
	foreach(weapon in weapons)
	{
		self rank_weapon(weapon, var_c300ee65);
		if(weapon == currentweapon)
		{
			self function_10723c01(weapon, weapon.rootweapon.var_e2f5d985);
			continue;
		}
		self function_10723c01(weapon, weapon.rootweapon.var_791bc2f7);
	}
	self.bot.var_469cfe53 = var_c300ee65;
}

/*
	Name: function_9480d296
	Namespace: bot_action
	Checksum: 0xF8B369A0
	Offset: 0x1D78
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function function_9480d296()
{
	actionlist = self.bot.tacbundle.actionlist;
	if(!isdefined(actionlist))
	{
		return;
	}
	paramslist = self.bot.paramslist;
	for(i = 0; i < actionlist.size; i++)
	{
		if(!isdefined(actionlist[i]))
		{
			continue;
		}
		actionname = actionlist[i].name;
		if(!isdefined(actionname))
		{
			continue;
		}
		action = get_action(actionname);
		if(!isdefined(action))
		{
			/#
				self botprinterror("" + function_9e72a96(actionname));
			#/
			continue;
		}
		var_b594a2cd = {#action:action};
		/#
			var_b594a2cd.debug = [];
		#/
		paramslist[paramslist.size] = var_b594a2cd;
	}
}

/*
	Name: execution_loop
	Namespace: bot_action
	Checksum: 0x65FDCE51
	Offset: 0x1EC8
	Size: 0x138
	Parameters: 0
	Flags: Linked, Private
*/
function private execution_loop()
{
	self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
	level endon(#"game_ended");
	while(self bot::initialized())
	{
		var_b594a2cd = self function_9e181b0f();
		if(isdefined(self.bot.var_211ab18e) && !self.bot.var_211ab18e)
		{
			self namespace_b20b4885::start();
		}
		if(!isdefined(var_b594a2cd))
		{
			/#
				self botprintwarning("");
			#/
			return;
		}
		self function_e7b123e8(var_b594a2cd);
		self bot::function_ffbfd83b();
	}
}

/*
	Name: function_e7b123e8
	Namespace: bot_action
	Checksum: 0x5D2E3C7C
	Offset: 0x2008
	Size: 0x1F2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e7b123e8(var_b594a2cd)
{
	self endoncallback(&function_7a456ee0, #"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start");
	level endon(#"game_ended");
	action = var_b594a2cd.action;
	self.bot.action = action;
	self.bot.var_b594a2cd = var_b594a2cd;
	self thread action_timeout(action.name);
	executetime = gettime();
	self function_fef5423c(self.bot.tacbundle.var_5eaa9e02, self.bot.tacbundle.var_bc0b2a06);
	self [[action.executefunc]](var_b594a2cd);
	self notify(#"hash_1728f8b5de3bde13");
	finishtime = gettime();
	if(executetime == finishtime)
	{
		/#
			self botprinterror(("" + function_9e72a96(action.name)) + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
	}
	self.bot.action = undefined;
	self.bot.var_b594a2cd = undefined;
}

/*
	Name: function_7a456ee0
	Namespace: bot_action
	Checksum: 0x39CA3BB9
	Offset: 0x2208
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7a456ee0(notifyhash)
{
	if(!self bot::initialized())
	{
		return;
	}
	self.bot.action = undefined;
	self.bot.var_b594a2cd = undefined;
}

/*
	Name: action_timeout
	Namespace: bot_action
	Checksum: 0x589C25F1
	Offset: 0x2258
	Size: 0xFE
	Parameters: 1
	Flags: Linked, Private
*/
function private action_timeout(actionname)
{
	self endon(#"hash_5b4f399c08222e2", #"death", #"entering_last_stand", #"enter_vehicle", #"animscripted_start", #"hash_1728f8b5de3bde13");
	level endon(#"game_ended");
	wait(10);
	if(!isbot(self))
	{
		return;
	}
	/#
		self botprintwarning(((("" + function_9e72a96(actionname)) + "") + 10) + "");
	#/
	self notify(#"hash_5b4f399c08222e2");
}

/*
	Name: function_fef5423c
	Namespace: bot_action
	Checksum: 0xC3CA3442
	Offset: 0x2360
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_fef5423c(smin, smax)
{
	self.bot.var_bdbba2cd = bot::function_7aeb27f1(smin, smax);
}

/*
	Name: function_cf788c22
	Namespace: bot_action
	Checksum: 0x82AE1E70
	Offset: 0x23A8
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_cf788c22()
{
	return gettime() > self.bot.var_bdbba2cd;
}

/*
	Name: function_9e181b0f
	Namespace: bot_action
	Checksum: 0xB69B34A5
	Offset: 0x23C8
	Size: 0x600
	Parameters: 0
	Flags: Linked
*/
function function_9e181b0f()
{
	self.bot.var_20ba0819 = [];
	self.bot.paramslist = [];
	/#
		self.bot.var_c4fbaffc = [];
	#/
	var_e6a1f475 = function_54449420();
	if(isdefined(var_e6a1f475))
	{
		/#
			if(self bot::should_record(""))
			{
				record3dtext("" + function_9e72a96(var_e6a1f475.action.name), self.origin, (1, 0, 1), "", self, 0.5);
			}
		#/
		return var_e6a1f475;
	}
	/#
		if(self bot::should_record(""))
		{
			record3dtext("", self.origin, (1, 0, 1), "", self, 0.5);
		}
	#/
	self function_bf21ead1();
	self function_fd9117cc();
	self function_9480d296();
	pixbeginevent(#"bot_pick_action");
	aiprofile_beginentry("bot_pick_action");
	self rank_actions();
	var_3a4035f3 = self weight_actions();
	pixendevent();
	aiprofile_endentry();
	/#
		if(self bot::should_record(""))
		{
			pixbeginevent(#"bot_record_action_eval");
			aiprofile_beginentry("");
			foreach(var_b594a2cd in self.bot.paramslist)
			{
				color = vectorscale((1, 1, 1), 0.75);
				headerstr = "";
				recordrank = "";
				recordweight = "";
				if(isdefined(var_b594a2cd.rank))
				{
					recordrank = var_b594a2cd.rank;
					if(isdefined(var_b594a2cd.weight))
					{
						color = (1, 1, 1);
						headerstr = "";
						recordweight = var_b594a2cd.weight;
						if(isdefined(var_3a4035f3))
						{
							if(var_b594a2cd.rank >= var_3a4035f3.rank)
							{
								color = utility_color(var_b594a2cd.weight, 100);
								headerstr = (var_b594a2cd == var_3a4035f3 ? "" : "");
							}
						}
					}
				}
				record3dtext(((((headerstr + function_9e72a96(var_b594a2cd.action.name)) + "") + recordrank) + "") + recordweight, self.origin, color, "", self, 0.5);
				if(isdefined(var_b594a2cd.weapon) && isdefined(self.bot.var_c4fbaffc[var_b594a2cd.weapon]))
				{
					foreach(str in self.bot.var_c4fbaffc[var_b594a2cd.weapon])
					{
						record3dtext("" + str, self.origin, color, "", self, 0.5);
					}
				}
				foreach(entry in var_b594a2cd.debug)
				{
					record3dtext("" + entry, self.origin, color, "", self, 0.5);
				}
			}
			pixendevent();
			aiprofile_endentry();
		}
	#/
	return var_3a4035f3;
}

/*
	Name: function_54449420
	Namespace: bot_action
	Checksum: 0xEC3B9BCD
	Offset: 0x29D0
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_54449420()
{
	if(!isdefined(self.bot.var_e6a1f475))
	{
		return undefined;
	}
	var_b594a2cd = self.bot.var_e6a1f475;
	self.bot.var_e6a1f475 = undefined;
	if(!isdefined(var_b594a2cd))
	{
		return undefined;
	}
	return var_b594a2cd;
}

/*
	Name: weight_actions
	Namespace: bot_action
	Checksum: 0x7277527D
	Offset: 0x2A30
	Size: 0x260
	Parameters: 0
	Flags: Linked
*/
function weight_actions()
{
	pixbeginevent(#"bot_weight_actions");
	aiprofile_beginentry("bot_weight_actions");
	var_3a4035f3 = undefined;
	bestrank = undefined;
	bestweight = undefined;
	paramslist = self.bot.paramslist;
	foreach(var_b594a2cd in paramslist)
	{
		if(!isdefined(var_b594a2cd.rank))
		{
			continue;
		}
		action = var_b594a2cd.action;
		pixbeginevent("bot_weight_" + action.name);
		aiprofile_beginentry("bot_weight_" + action.name);
		var_b594a2cd.weight = self [[action.weightfunc]](var_b594a2cd);
		pixendevent();
		aiprofile_endentry();
		if(!isdefined(var_b594a2cd.weight))
		{
			continue;
		}
		if(isdefined(var_3a4035f3) && var_b594a2cd.rank < bestrank)
		{
			continue;
		}
		if(!isdefined(var_3a4035f3) || var_b594a2cd.rank > bestrank || var_b594a2cd.weight > bestweight)
		{
			var_3a4035f3 = var_b594a2cd;
			bestrank = var_b594a2cd.rank;
			bestweight = var_b594a2cd.weight;
		}
	}
	pixendevent();
	aiprofile_endentry();
	return var_3a4035f3;
}

/*
	Name: rank_actions
	Namespace: bot_action
	Checksum: 0x98DCD003
	Offset: 0x2C98
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function rank_actions()
{
	pixbeginevent(#"bot_rank_actions");
	aiprofile_beginentry("bot_rank_actions");
	paramslist = self.bot.paramslist;
	foreach(var_b594a2cd in paramslist)
	{
		action = var_b594a2cd.action;
		pixbeginevent("bot_rank_" + action.name);
		aiprofile_beginentry("bot_rank_" + action.name);
		var_b594a2cd.rank = self [[action.rankfunc]](var_b594a2cd);
		pixendevent();
		aiprofile_endentry();
	}
	pixendevent();
	aiprofile_endentry();
}

/*
	Name: rank_priority
	Namespace: bot_action
	Checksum: 0xAA1B24F7
	Offset: 0x2E28
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function rank_priority(var_b594a2cd)
{
	return 1000;
}

/*
	Name: function_b85d4a92
	Namespace: bot_action
	Checksum: 0xCA8EDD5C
	Offset: 0x2E40
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_b85d4a92(var_b594a2cd)
{
	return -1000;
}

/*
	Name: current_melee_weapon_rank
	Namespace: bot_action
	Checksum: 0x9DF636B7
	Offset: 0x2E58
	Size: 0x1A6
	Parameters: 1
	Flags: Linked
*/
function current_melee_weapon_rank(var_b594a2cd)
{
	weapon = self getcurrentweapon();
	var_b594a2cd.weapon = weapon;
	if(sessionmodeiszombiesgame())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 1000;
	}
	if(!weapon.ismeleeweapon)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = weapon.name + "";
		#/
		return undefined;
	}
	return 1000;
}

/*
	Name: current_weapon_rank
	Namespace: bot_action
	Checksum: 0x186FF341
	Offset: 0x3008
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function current_weapon_rank(var_b594a2cd)
{
	weapon = self getcurrentweapon();
	var_b594a2cd.weapon = weapon;
	if(weapon == level.weaponnone)
	{
		return -1000;
	}
	return weapon_rank(var_b594a2cd);
}

/*
	Name: best_stowed_primary_weapon_rank
	Namespace: bot_action
	Checksum: 0x212B8F03
	Offset: 0x3080
	Size: 0x1F2
	Parameters: 1
	Flags: Linked
*/
function best_stowed_primary_weapon_rank(var_b594a2cd)
{
	currentweapon = self getcurrentweapon();
	weapons = self getweaponslistprimaries();
	bestweapon = undefined;
	bestweaponrank = undefined;
	foreach(weapon in weapons)
	{
		if(weapon == currentweapon)
		{
			continue;
		}
		weaponrank = self function_30e579d5(weapon);
		if(!isdefined(weaponrank))
		{
			continue;
		}
		if(!isdefined(bestweapon) || bestweaponrank < weaponrank)
		{
			bestweapon = weapon;
			bestweaponrank = weaponrank;
		}
	}
	if(!isdefined(bestweapon))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.weapon = bestweapon;
	return weapon_rank(var_b594a2cd);
}

/*
	Name: weapon_rank
	Namespace: bot_action
	Checksum: 0x314996DD
	Offset: 0x3280
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function weapon_rank(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	return self function_30e579d5(weapon);
}

/*
	Name: function_30e579d5
	Namespace: bot_action
	Checksum: 0xA827CFD3
	Offset: 0x32C8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_30e579d5(weapon)
{
	ammo = self getammocount(weapon);
	if(ammo <= 0)
	{
		return -1000;
	}
	return self.bot.var_20ba0819[weapon];
}

/*
	Name: function_3df363bf
	Namespace: bot_action
	Checksum: 0xF281550A
	Offset: 0x3328
	Size: 0x38
	Parameters: 1
	Flags: None
*/
function function_3df363bf(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	return self.bot.var_20ba0819[weapon];
}

/*
	Name: rank_weapon
	Namespace: bot_action
	Checksum: 0x7CD170C3
	Offset: 0x3368
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function rank_weapon(weapon, var_c300ee65)
{
	rankfunc = weapon.rootweapon.var_ede647ad;
	if(!isdefined(rankfunc))
	{
		return;
	}
	self [[rankfunc]](weapon, var_c300ee65);
}

/*
	Name: function_d31777fa
	Namespace: bot_action
	Checksum: 0xE8F4D039
	Offset: 0x33C0
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_d31777fa(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 0);
}

/*
	Name: function_22991a48
	Namespace: bot_action
	Checksum: 0xCB40D7E5
	Offset: 0x33F8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_22991a48(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 1);
	self factor_damage_range(weapon, var_c300ee65);
	if(weapon.weapclass == "pistol" || weapon.weapclass == "pistol spread")
	{
		self set_weapon_rank(weapon, 0.8, "Pistol");
	}
	self factor_ammo(weapon);
}

/*
	Name: function_317d4797
	Namespace: bot_action
	Checksum: 0xE61C4A07
	Offset: 0x34C0
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_317d4797(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 0);
	self factor_lockon(weapon, var_c300ee65);
	self factor_dumbfire_range(weapon, var_c300ee65);
	self factor_rocketlauncher_overkill(weapon, var_c300ee65);
	self factor_ammo(weapon);
}

/*
	Name: registermus_gramophone_electricreactidgunterminate
	Namespace: bot_action
	Checksum: 0xB843615C
	Offset: 0x3558
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function registermus_gramophone_electricreactidgunterminate(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 998, "Secondary offhand weapon");
	self factor_ammo(weapon, var_c300ee65);
}

/*
	Name: function_1879a202
	Namespace: bot_action
	Checksum: 0x6EBE15B5
	Offset: 0x35B8
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function function_1879a202(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 999, "Special offhand weapon");
	self factor_ammo(weapon, var_c300ee65);
}

/*
	Name: function_791f5097
	Namespace: bot_action
	Checksum: 0x1220968E
	Offset: 0x3618
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function function_791f5097(weapon, var_c300ee65)
{
	if(self getcurrentweapon() != weapon)
	{
		self set_weapon_rank(weapon, 999, "Scorestreak weapon");
	}
	else
	{
		self set_weapon_rank(weapon, -1000, "Don't use scorestreak weapon that is already equipped");
	}
}

/*
	Name: function_2c39b990
	Namespace: bot_action
	Checksum: 0x47EC950C
	Offset: 0x36A8
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function function_2c39b990(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, 1000, "This weapon is a priority");
	self factor_ammo(weapon, var_c300ee65);
}

/*
	Name: function_d9c35bee
	Namespace: bot_action
	Checksum: 0x17EE35E8
	Offset: 0x3708
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d9c35bee(weapon, var_c300ee65)
{
	self set_weapon_rank(weapon, -1000, "This weapon is unusable");
}

/*
	Name: set_weapon_rank
	Namespace: bot_action
	Checksum: 0xCD225F96
	Offset: 0x3750
	Size: 0xE8
	Parameters: 3
	Flags: Linked
*/
function set_weapon_rank(weapon, rank, reason)
{
	self.bot.var_20ba0819[weapon] = rank;
	/#
		rankstr = (isdefined(rank) ? rank : "");
		self.bot.var_c4fbaffc[weapon] = array((weapon.name + "") + rankstr);
		if(isdefined(reason))
		{
			self.bot.var_c4fbaffc[weapon][self.bot.var_c4fbaffc[weapon].size] = "" + reason;
		}
	#/
}

/*
	Name: modify_weapon_rank
	Namespace: bot_action
	Checksum: 0xD9BA1D71
	Offset: 0x3840
	Size: 0xEC
	Parameters: 3
	Flags: Linked
*/
function modify_weapon_rank(weapon, amount, reason)
{
	if(!isdefined(self.bot.var_20ba0819[weapon]))
	{
		return;
	}
	self.bot.var_20ba0819[weapon] = self.bot.var_20ba0819[weapon] + amount;
	/#
		sign = (amount > 0 ? "" : "");
		self.bot.var_c4fbaffc[weapon][self.bot.var_c4fbaffc[weapon].size] = ((("" + sign) + amount) + "") + reason;
	#/
}

/*
	Name: factor_ammo
	Namespace: bot_action
	Checksum: 0x652EB45
	Offset: 0x3938
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function factor_ammo(weapon, var_c300ee65)
{
	clipammo = self clip_ammo(weapon);
	stockammo = self getweaponammostock(weapon);
	if((clipammo + stockammo) <= 0)
	{
		if(weapon.isgadget)
		{
			slot = self gadgetgetslot(weapon);
			if(!self gadgetisready(slot))
			{
				self set_weapon_rank(weapon, undefined, "Gadget not ready");
			}
		}
		else
		{
			self set_weapon_rank(weapon, -1000, "No ammo");
		}
	}
}

/*
	Name: factor_damage_range
	Namespace: bot_action
	Checksum: 0xE2FB61A8
	Offset: 0x3A38
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function factor_damage_range(weapon, var_c300ee65)
{
	if(!isdefined(self.enemy))
	{
		return;
	}
	if(var_c300ee65.distsq < weapon.maxdamagerange * weapon.maxdamagerange)
	{
		self modify_weapon_rank(weapon, 1, "In max damage range");
	}
	else if(var_c300ee65.distsq >= (weapon.mindamagerange * weapon.mindamagerange))
	{
		if(weapon.weapclass == "spread")
		{
			self set_weapon_rank(weapon, undefined, "Outside of spread min damage range");
			return;
		}
		self modify_weapon_rank(weapon, -1, "In min damage range");
	}
}

/*
	Name: factor_lockon
	Namespace: bot_action
	Checksum: 0x41CA6249
	Offset: 0x3B48
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function factor_lockon(weapon, var_c300ee65)
{
	if(var_c300ee65.istarget)
	{
		if(weapon.lockontype != "None")
		{
			self modify_weapon_rank(weapon, 3, "Lockon Target");
		}
	}
	else if(weapon.requirelockontofire)
	{
		self set_weapon_rank(weapon, undefined, "Requires Lockon");
	}
}

/*
	Name: factor_dumbfire_range
	Namespace: bot_action
	Checksum: 0x1C3C5891
	Offset: 0x3BE8
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function factor_dumbfire_range(weapon, var_c300ee65)
{
	if(var_c300ee65.istarget && weapon.lockontype != "None")
	{
		return;
	}
	if(var_c300ee65.distsq < 2250000)
	{
		self modify_weapon_rank(weapon, 1, "In Dumbfire Range");
	}
	else
	{
		self modify_weapon_rank(weapon, -1, "Outside Dumbfire Range");
	}
}

/*
	Name: factor_rocketlauncher_overkill
	Namespace: bot_action
	Checksum: 0x15E3B295
	Offset: 0x3C98
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function factor_rocketlauncher_overkill(weapon, var_c300ee65)
{
	if(var_c300ee65.istarget && weapon.lockontype != "None")
	{
		return;
	}
	if(!isdefined(var_c300ee65.maxhealth))
	{
		self set_weapon_rank(weapon, undefined, "Max Health is undefined");
	}
	else
	{
		if(var_c300ee65.maxhealth >= 400)
		{
			self modify_weapon_rank(weapon, 2, ("Enemy Max Health " + var_c300ee65.maxhealth) + (" >= ") + 400);
		}
		else
		{
			self modify_weapon_rank(weapon, -1, ("Enemy Max Health " + var_c300ee65.maxhealth) + (" < ") + 400);
		}
	}
}

/*
	Name: utility_color
	Namespace: bot_action
	Checksum: 0xB866686C
	Offset: 0x3DB8
	Size: 0x12A
	Parameters: 2
	Flags: None
*/
function utility_color(utility, targetutility)
{
	/#
		colorscale = array((1, 0, 0), (1, 0.5, 0), (1, 1, 0), (0, 1, 0));
		if(utility >= targetutility)
		{
			return colorscale[colorscale.size - 1];
		}
		if(utility <= 0)
		{
			return colorscale[0];
		}
		utilityindex = (utility * colorscale.size) / targetutility;
		utilityindex = utilityindex - 1;
		colorindex = int(utilityindex);
		colorfrac = utilityindex - colorindex;
		utilitycolor = vectorlerp(colorscale[colorindex], colorscale[colorindex + 1], colorfrac);
		return utilitycolor;
	#/
}

/*
	Name: look_for_enemy_weight
	Namespace: bot_action
	Checksum: 0x8A8095BB
	Offset: 0x3EF0
	Size: 0x260
	Parameters: 1
	Flags: Linked
*/
function look_for_enemy_weight(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self bot::in_combat())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self function_3094610b(self.bot.tacbundle.var_82aa37d8))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 0;
}

/*
	Name: look_for_enemy
	Namespace: bot_action
	Checksum: 0x593A9BCC
	Offset: 0x4158
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function look_for_enemy(var_b594a2cd)
{
	var_47851891 = self.enemy;
	weapon = self getcurrentweapon();
	while(!self function_cf788c22() && self function_ab4c3550() && self bot::in_combat() && self function_bb2a8f1b(var_b594a2cd) && !self is_target_visible(var_b594a2cd))
	{
		self function_d273d4e7();
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_1176a20b
	Namespace: bot_action
	Checksum: 0xEA422B05
	Offset: 0x4248
	Size: 0x246
	Parameters: 1
	Flags: Linked
*/
function function_1176a20b(var_b594a2cd)
{
	if(self.ignoreall)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = self ai::function_31a31a25(0);
	if(!isdefined(target))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = target;
	self function_6d30e629(var_b594a2cd);
	return 0;
}

/*
	Name: function_e0dcb8c1
	Namespace: bot_action
	Checksum: 0xBAA22EC
	Offset: 0x4498
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function function_e0dcb8c1(var_b594a2cd)
{
	target = var_b594a2cd.target;
	self setentitytarget(target);
	self.bot.var_2a98e9ea = 1;
	while(!self function_cf788c22() && !self.ignoreall && isdefined(target) && self function_bb2a8f1b(var_b594a2cd) && isalive(target) && !self is_target_visible(var_b594a2cd))
	{
		self function_8a2b82ad(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_728212e8
	Namespace: bot_action
	Checksum: 0x3907942A
	Offset: 0x45B8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_728212e8(var_b594a2cd)
{
	var_cfb25645 = self current_weapon_rank(var_b594a2cd);
	if(isdefined(var_cfb25645))
	{
		return var_cfb25645;
	}
	return -1000;
}

/*
	Name: scan_for_threats_weight
	Namespace: bot_action
	Checksum: 0x9C61B516
	Offset: 0x4600
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function scan_for_threats_weight(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	self function_6d30e629(var_b594a2cd);
	return false;
}

/*
	Name: scan_for_threats
	Namespace: bot_action
	Checksum: 0x79331B7E
	Offset: 0x4640
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function scan_for_threats(var_b594a2cd)
{
	var_fdfb592e = self is_target_visible(var_b594a2cd);
	var_b594a2cd.var_fdfb592e = var_fdfb592e;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && var_b594a2cd.var_fdfb592e == var_fdfb592e)
	{
		if(var_fdfb592e && self function_ee402bf6(var_b594a2cd))
		{
			self function_8a2b82ad(var_b594a2cd);
			self function_e69a1e2e(var_b594a2cd);
		}
		else
		{
			if(!var_fdfb592e && self function_ee402bf6(var_b594a2cd))
			{
				self function_8a2b82ad(var_b594a2cd);
				self function_e69a1e2e(var_b594a2cd);
			}
			else
			{
				if(self function_4fbd6cf1())
				{
					self function_3b98ad10();
				}
				else
				{
					if(var_fdfb592e)
					{
						self function_8a2b82ad(var_b594a2cd);
						self aim_at_target(var_b594a2cd);
					}
					else
					{
						self function_2b8f7067();
					}
				}
			}
		}
		self waittill(#"hash_347a612b61067eb3");
		var_fdfb592e = self is_target_visible(var_b594a2cd);
	}
}

/*
	Name: function_9e1d8dfe
	Namespace: bot_action
	Checksum: 0x218CC68B
	Offset: 0x4830
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function function_9e1d8dfe(var_b594a2cd)
{
	var_fdfb592e = self is_target_visible(var_b594a2cd);
	var_b594a2cd.var_fdfb592e = var_fdfb592e;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && var_b594a2cd.var_fdfb592e == var_fdfb592e)
	{
		if(var_fdfb592e && self function_ee402bf6(var_b594a2cd))
		{
			self function_8a2b82ad(var_b594a2cd);
			self function_e69a1e2e(var_b594a2cd);
		}
		else
		{
			if(!var_fdfb592e && self function_ee402bf6(var_b594a2cd))
			{
				self function_8a2b82ad(var_b594a2cd);
				self function_e69a1e2e(var_b594a2cd);
			}
			else
			{
				if(self function_4fbd6cf1())
				{
					self function_3b98ad10();
				}
				else
				{
					self function_2b8f7067();
				}
			}
		}
		self waittill(#"hash_347a612b61067eb3");
		var_fdfb592e = self is_target_visible(var_b594a2cd);
	}
}

/*
	Name: revive_player_weight
	Namespace: bot_action
	Checksum: 0x8AFC43E7
	Offset: 0x49E8
	Size: 0x592
	Parameters: 1
	Flags: Linked
*/
function revive_player_weight(var_b594a2cd)
{
	if(!self ai::get_behavior_attribute("revive"))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	revivetarget = self bot::get_revive_target();
	if(!isdefined(revivetarget))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.revivetarget = revivetarget;
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + revivetarget.name;
	#/
	if(!isdefined(revivetarget.revivetrigger))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self istouching(revivetarget.revivetrigger))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(isdefined(revivetarget.revivetrigger.beingrevived) && revivetarget.revivetrigger.beingrevived)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return;
	}
	pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;
	if(!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isdefined(self.enemy) && isdefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < (pathenemyfightdist * pathenemyfightdist))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: revive_player
	Namespace: bot_action
	Checksum: 0x2E8BD41A
	Offset: 0x4F88
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function revive_player(var_b594a2cd)
{
	player = var_b594a2cd.revivetarget;
	if(!isdefined(player))
	{
		/#
			self botprinterror("" + "");
		#/
		return;
	}
	self.attackeraccuracy = 0.01;
	while(isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger))
	{
		if(isdefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived)
		{
			function_e0c89027();
			return;
		}
		self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));
		if(self botgetlookdot() >= 0)
		{
			self botsetlookcurrent();
			break;
		}
		self namespace_9c817acd::crouch();
		self waittill(#"hash_347a612b61067eb3");
	}
	while(isalive(player) && isdefined(player.revivetrigger) && self istouching(player.revivetrigger))
	{
		self look_at_point(player.revivetrigger.origin, "Revive Trigger", (1, 1, 1));
		self namespace_9c817acd::crouch();
		self bottapbutton(3);
		self waittill(#"hash_347a612b61067eb3");
	}
	self function_e0c89027();
}

/*
	Name: function_e0c89027
	Namespace: bot_action
	Checksum: 0x587A48C0
	Offset: 0x5210
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_e0c89027(notifyhash)
{
	self.attackeraccuracy = 1;
	self namespace_9c817acd::reset();
}

/*
	Name: function_3cb4c00e
	Namespace: bot_action
	Checksum: 0xA54E39D8
	Offset: 0x5248
	Size: 0x25A
	Parameters: 1
	Flags: Linked
*/
function function_3cb4c00e(var_b594a2cd)
{
	if(!self bot::function_dd750ead())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	gameobject = self bot::function_f47bf51d();
	var_b594a2cd.gameobject = gameobject;
	if(self haspath())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self istouching(gameobject.trigger))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_29904346
	Namespace: bot_action
	Checksum: 0xB822E114
	Offset: 0x54B0
	Size: 0x212
	Parameters: 1
	Flags: Linked
*/
function function_29904346(var_b594a2cd)
{
	gameobject = var_b594a2cd.gameobject;
	lookpoint = gameobject.trigger.origin;
	while(isdefined(gameobject) && gameobject === self bot::function_f47bf51d() && self istouching(gameobject.trigger))
	{
		self look_at_point(lookpoint, "Gameobject Trigger", (1, 1, 1));
		if(self botgetlookdot() >= 0.76)
		{
			self botsetlookcurrent();
			break;
		}
		waitframe(1);
	}
	while(isdefined(gameobject) && gameobject === self bot::function_f47bf51d() && self istouching(gameobject.trigger) && !isdefined(self.claimtrigger))
	{
		self bottapbutton(3);
		waitframe(1);
	}
	if(isdefined(gameobject) && gameobject === self bot::function_f47bf51d() && (isdefined(gameobject.inuse) && gameobject.inuse) && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger)
	{
		self bottapbutton(3);
		waitframe(1);
	}
}

/*
	Name: function_5647e838
	Namespace: bot_action
	Checksum: 0x48A3621E
	Offset: 0x56D0
	Size: 0x242
	Parameters: 1
	Flags: Linked
*/
function function_5647e838(var_b594a2cd)
{
	if(!isdefined(self.bot.traversal))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(isdefined(self.bot.traversal.mantlenode))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self.bot.traversal.targetheight < 40)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = ("" + self.bot.traversal.targetheight) + "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_40aa6f87
	Namespace: bot_action
	Checksum: 0xBBA63F64
	Offset: 0x5920
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_40aa6f87(var_b594a2cd)
{
	while(isdefined(self.bot.traversal))
	{
		self botsetlookpoint(self.bot.traversal.endpos);
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: switch_to_weapon_weight
	Namespace: bot_action
	Checksum: 0x8E0449DB
	Offset: 0x5990
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function switch_to_weapon_weight(var_b594a2cd)
{
	currentweapon = self getcurrentweapon();
	var_cfb25645 = self function_30e579d5(currentweapon);
	if(isdefined(var_cfb25645) && var_b594a2cd.rank <= var_cfb25645)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + var_cfb25645;
		#/
		return undefined;
	}
	return 0;
}

/*
	Name: switch_to_weapon
	Namespace: bot_action
	Checksum: 0xDD84317A
	Offset: 0x5AA8
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function switch_to_weapon(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self botswitchtoweapon(weapon);
	self waittill(#"hash_347a612b61067eb3");
	while(self isswitchingweapons())
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: reload_weapon_weight
	Namespace: bot_action
	Checksum: 0x36E34332
	Offset: 0x5B30
	Size: 0x3A0
	Parameters: 1
	Flags: Linked
*/
function reload_weapon_weight(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	var_b594a2cd.target = self.enemy;
	self function_6d30e629(var_b594a2cd);
	stockammo = self getweaponammostock(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + stockammo;
	#/
	if(stockammo <= 0)
	{
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo >= weapon.clipsize)
	{
		return undefined;
	}
	if(self bot::in_combat() && clipammo > (weapon.clipsize * 0.2))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self isreloading())
	{
		return 100;
	}
	if(!self function_a39f313c())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 0;
}

/*
	Name: reload_weapon
	Namespace: bot_action
	Checksum: 0xC1867892
	Offset: 0x5ED8
	Size: 0x1D6
	Parameters: 1
	Flags: Linked
*/
function reload_weapon(var_b594a2cd)
{
	weapon = self getcurrentweapon();
	if(!self isreloading())
	{
		self bottapbutton(4);
	}
	self waittill(#"hash_347a612b61067eb3");
	while(self isreloading())
	{
		if(self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd))
		{
			self function_8a2b82ad(var_b594a2cd);
			self function_e69a1e2e(var_b594a2cd);
		}
		else
		{
			if(self function_bb2a8f1b(var_b594a2cd) && self function_3094610b(self.bot.tacbundle.var_82aa37d8))
			{
				if(self function_ca71ffdb())
				{
					self function_d273d4e7();
				}
				else
				{
					self function_c17972fc();
				}
			}
			else
			{
				if(self function_4fbd6cf1())
				{
					self function_3b98ad10();
				}
				else
				{
					self function_2b8f7067();
				}
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_4d9b6e04
	Namespace: bot_action
	Checksum: 0x6C5B5D8
	Offset: 0x60B8
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_4d9b6e04()
{
	if(level.script == "mp_mountain2")
	{
		return true;
	}
	if(level.script == "mp_slums2")
	{
		return true;
	}
	return false;
}

/*
	Name: function_abf40e98
	Namespace: bot_action
	Checksum: 0x3651AD84
	Offset: 0x6100
	Size: 0x392
	Parameters: 1
	Flags: Linked
*/
function function_abf40e98(var_b594a2cd)
{
	if(!function_4d9b6e04())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self haspath())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	eye = self geteye();
	forwarddir = anglestoforward(self getplayerangles());
	traceend = eye + (forwarddir * var_b594a2cd.weapon.var_bfbec33f);
	trace = bullettrace(eye, traceend, 0, self);
	if(trace[#"fraction"] >= 1)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!isdefined(trace[#"surfacetype"]) || trace[#"surfacetype"] != "glass")
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_c8ae6981
	Namespace: bot_action
	Checksum: 0xA5EBB960
	Offset: 0x64A0
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_c8ae6981(var_b594a2cd)
{
	self look_along_path();
	self bottapbutton(2);
	self waittill(#"hash_347a612b61067eb3");
	if(self ismeleeing())
	{
		self look_along_path();
		while(self ismeleeing())
		{
			self waittill(#"hash_347a612b61067eb3");
		}
	}
}

/*
	Name: melee_enemy_weight
	Namespace: bot_action
	Checksum: 0xCCA62C6F
	Offset: 0x6558
	Size: 0x408
	Parameters: 1
	Flags: Linked
*/
function melee_enemy_weight(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	meleerange = var_b594a2cd.weapon.var_bfbec33f;
	if(distancesquared(self.origin, self.enemy.origin) > meleerange * meleerange)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self bot::fwd_dot(self.enemy.origin) < 0.5)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!isdefined(self.bot.var_d8397b2) || (gettime() - self.bot.var_d8397b2) > 1000)
	{
		self.bot.var_d8397b2 = gettime();
		self.bot.var_9a77751a = randomfloat(1) < (isdefined(self.bot.tacbundle.var_ecf6111e) ? self.bot.tacbundle.var_ecf6111e : 0);
	}
	if(!self.bot.var_9a77751a)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self function_6d30e629(var_b594a2cd);
	return 100;
}

/*
	Name: melee_enemy
	Namespace: bot_action
	Checksum: 0x2ADE5942
	Offset: 0x6968
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function melee_enemy(var_b594a2cd)
{
	self function_8a2b82ad(var_b594a2cd);
	self function_e69a1e2e(var_b594a2cd);
	self bottapbutton(2);
	if(sessionmodeiszombiesgame())
	{
		wait(0.5);
		return;
	}
	self waittill(#"hash_347a612b61067eb3");
	if(self ismeleeing())
	{
		while(self ismeleeing())
		{
			self waittill(#"hash_347a612b61067eb3");
		}
	}
}

/*
	Name: function_36505c2d
	Namespace: bot_action
	Checksum: 0xD3C86747
	Offset: 0x6A40
	Size: 0x290
	Parameters: 1
	Flags: Linked
*/
function function_36505c2d(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	if(!self function_ee402bf6(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self function_6d30e629(var_b594a2cd);
	return 100;
}

/*
	Name: function_a314673
	Namespace: bot_action
	Checksum: 0xA1F8E0EF
	Offset: 0x6CD8
	Size: 0x10E
	Parameters: 1
	Flags: Linked
*/
function function_a314673(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self function_e69a1e2e(var_b594a2cd);
		if(self function_31a76186(var_b594a2cd))
		{
			self bot::function_e2c892a5();
			self bot::function_e2c892a5(1);
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_294f4909
	Namespace: bot_action
	Checksum: 0x6F5B24EA
	Offset: 0x6DF0
	Size: 0x420
	Parameters: 1
	Flags: Linked
*/
function function_294f4909(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!weapon.aimdownsight)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self haspath() && (!(isdefined(self.bot.tacbundle.var_abf895b5) && self.bot.tacbundle.var_abf895b5)))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	if(!self function_679b5b7a(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self function_6d30e629(var_b594a2cd);
	return 100;
}

/*
	Name: function_e73c8946
	Namespace: bot_action
	Checksum: 0xE2677703
	Offset: 0x7218
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function function_e73c8946(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		if(self function_55d5a581(var_b594a2cd))
		{
			self bottapbutton(11);
			if(self function_bacb1c08(var_b594a2cd) && self playerads() >= 1)
			{
				self bot::function_e2c892a5();
				self bot::function_e2c892a5(1);
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_22e2ba8c
	Namespace: bot_action
	Checksum: 0x8DFE4AC7
	Offset: 0x7380
	Size: 0x33E
	Parameters: 1
	Flags: Linked
*/
function function_22e2ba8c(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	weaponclass = util::getweaponclass(weapon);
	/#
		assert(weaponclass == #"weapon_sniper");
	#/
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		if(self function_55d5a581(var_b594a2cd))
		{
			self bottapbutton(11);
			if(self function_bacb1c08(var_b594a2cd) && self playerads() >= 1)
			{
				if(!isdefined(self.bot.var_ddc0e12b))
				{
					self.bot.var_ddc0e12b = randomfloat(1) < (isdefined(self.bot.tacbundle.var_6ef48dfa) ? self.bot.tacbundle.var_6ef48dfa : 0);
				}
				if(!isdefined(self.bot.var_f2b47a08))
				{
					if(self.bot.var_ddc0e12b)
					{
						self.bot.var_f2b47a08 = gettime();
					}
					else
					{
						delaytimesec = randomfloatrange((isdefined(self.bot.tacbundle.var_b9f05fc) ? self.bot.tacbundle.var_b9f05fc : 0), (isdefined(self.bot.tacbundle.var_c850085f) ? self.bot.tacbundle.var_c850085f : 0));
						self.bot.var_f2b47a08 = gettime() + (int(delaytimesec * 1000));
					}
				}
				if(gettime() >= self.bot.var_f2b47a08)
				{
					self bot::function_e2c892a5();
					self bot::function_e2c892a5(1);
				}
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_2bc7472b
	Namespace: bot_action
	Checksum: 0xA4E06B4
	Offset: 0x76C8
	Size: 0x378
	Parameters: 1
	Flags: Linked
*/
function function_2bc7472b(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self haspath() && (!(isdefined(self.bot.tacbundle.var_abf895b5) && self.bot.tacbundle.var_abf895b5)))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	if(!self function_679b5b7a(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self function_6d30e629(var_b594a2cd);
	return 100;
}

/*
	Name: function_36ca6d92
	Namespace: bot_action
	Checksum: 0x93231F43
	Offset: 0x7A48
	Size: 0x1BE
	Parameters: 1
	Flags: Linked
*/
function function_36ca6d92(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self function_b74c1de4();
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		self bottapbutton(11);
		self bottapbutton(24);
		if(self function_55d5a581(var_b594a2cd))
		{
			if(self function_bacb1c08(var_b594a2cd))
			{
				self bot::function_e2c892a5();
				self bot::function_e2c892a5(1);
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
	self function_b74c1de4();
	wait(0.1);
	while(self isswitchingweapons())
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: registersndrampend_death
	Namespace: bot_action
	Checksum: 0xC64AAB23
	Offset: 0x7C10
	Size: 0x412
	Parameters: 1
	Flags: Linked
*/
function registersndrampend_death(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self haspath())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	self function_8a2b82ad(var_b594a2cd);
	self function_a3dfc4aa(var_b594a2cd);
	if(!isdefined(var_b594a2cd.var_cb785841))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self function_9004d3ca(var_b594a2cd);
	if(!self function_ade341c(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: fire_grenade
	Namespace: bot_action
	Checksum: 0x4622BCD3
	Offset: 0x8030
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function fire_grenade(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self function_a3dfc4aa(var_b594a2cd);
		self function_9004d3ca(var_b594a2cd);
		self function_3a2f51fd(var_b594a2cd);
		if(self function_ade341c(var_b594a2cd))
		{
			if(self botgetlookdot() >= 1 && self bot::function_a7106162())
			{
				self bot::function_b78e1ebf();
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_4de5fcc3
	Namespace: bot_action
	Checksum: 0x57F8F691
	Offset: 0x8198
	Size: 0x352
	Parameters: 1
	Flags: Linked
*/
function function_4de5fcc3(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self function_daa4968(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	distsq = distancesquared(self.origin, self.enemy.origin);
	if(distsq < 2250000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 0;
	}
	return 100;
}

/*
	Name: fire_locked_rocketlauncher
	Namespace: bot_action
	Checksum: 0x75DD54F7
	Offset: 0x84F8
	Size: 0x25E
	Parameters: 1
	Flags: Linked
*/
function fire_locked_rocketlauncher(var_b594a2cd)
{
	target = var_b594a2cd.target;
	weapon = var_b594a2cd.weapon;
	lockedflag = 1 << self getentitynumber();
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self function_daa4968(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_ab6b1fc9(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		if(self function_55d5a581(var_b594a2cd))
		{
			self bottapbutton(11);
			if(self playerads() >= 1 && isdefined(self.stingertarget) && isdefined(self.stingertarget.locked_on) && self.stingertarget.locked_on & lockedflag)
			{
				self bottapbutton(0);
			}
		}
		self waittill(#"hash_347a612b61067eb3");
		if(self isfiring())
		{
			break;
		}
	}
	while(self isfiring())
	{
		if(self is_target_visible(var_b594a2cd))
		{
			self function_8a2b82ad(var_b594a2cd);
			self aim_at_target(var_b594a2cd);
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_a365f27e
	Namespace: bot_action
	Checksum: 0xA116727
	Offset: 0x8760
	Size: 0x2A2
	Parameters: 1
	Flags: Linked
*/
function function_a365f27e(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	weapon = var_b594a2cd.weapon;
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	clipammo = self clip_ammo(weapon);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = (("" + clipammo) + "") + weapon.clipsize;
	#/
	if(clipammo <= 0)
	{
		return undefined;
	}
	distsq = distancesquared(self.origin, self.enemy.origin);
	if(distsq > 2250000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: fire_rocketlauncher
	Namespace: bot_action
	Checksum: 0xB10A925
	Offset: 0x8A10
	Size: 0x23E
	Parameters: 1
	Flags: Linked
*/
function fire_rocketlauncher(var_b594a2cd)
{
	target = var_b594a2cd.target;
	weapon = var_b594a2cd.weapon;
	while(!self function_cf788c22() && self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd) && self bot::function_828da7a9(weapon))
	{
		self function_8a2b82ad(var_b594a2cd);
		self aim_at_target(var_b594a2cd);
		if(self function_55d5a581(var_b594a2cd))
		{
			if(self function_bacb1c08(var_b594a2cd))
			{
				if(!self haspath())
				{
					self bottapbutton(11);
					if(self playerads() >= 1)
					{
						self bottapbutton(0);
						self waittill(#"hash_347a612b61067eb3");
						break;
					}
				}
				else
				{
					self bottapbutton(0);
				}
			}
		}
		self waittill(#"hash_347a612b61067eb3");
		if(self isfiring())
		{
			break;
		}
	}
	while(self isfiring())
	{
		if(self is_target_visible(var_b594a2cd))
		{
			self function_8a2b82ad(var_b594a2cd);
			self aim_at_target(var_b594a2cd);
		}
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_ccdcc5d9
	Namespace: bot_action
	Checksum: 0xD76C6F85
	Offset: 0x8C58
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_ccdcc5d9(weapon)
{
	activatefunc = weapon.rootweapon.var_c7e8f553;
	if(!isdefined(activatefunc))
	{
		/#
			self botprinterror(weapon.name + "");
		#/
		return;
	}
	self [[activatefunc]](weapon);
}

/*
	Name: function_c27fa689
	Namespace: bot_action
	Checksum: 0x31E81229
	Offset: 0x8CD0
	Size: 0xAE
	Parameters: 1
	Flags: None
*/
function function_c27fa689(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self function_ccdcc5d9(weapon);
	while(self isthrowinggrenade() || !self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_5aa9dd1b
	Namespace: bot_action
	Checksum: 0xC3DDADFB
	Offset: 0x8D88
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_5aa9dd1b(var_b594a2cd)
{
	if(self function_bb2a8f1b(var_b594a2cd) && self is_target_visible(var_b594a2cd))
	{
		var_b4843bc3 = var_b594a2cd.aimpoint;
		var_7c23d596 = var_b594a2cd.var_97065630;
		var_66c8d0f4 = var_b594a2cd.var_cb785841;
		self function_8a2b82ad(var_b594a2cd);
		self function_a3dfc4aa(var_b594a2cd);
		self function_9004d3ca(var_b594a2cd);
		if(!self function_ade341c(var_b594a2cd))
		{
			var_b594a2cd.aimpoint = var_b4843bc3;
			var_b594a2cd.var_97065630 = var_7c23d596;
			var_b594a2cd.var_cb785841 = var_66c8d0f4;
		}
	}
	self function_3a2f51fd(var_b594a2cd);
}

/*
	Name: function_90c011d5
	Namespace: bot_action
	Checksum: 0xF907344
	Offset: 0x8EC0
	Size: 0x296
	Parameters: 1
	Flags: None
*/
function function_90c011d5(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self function_ccdcc5d9(weapon);
	slot = self gadgetgetslot(weapon);
	button = self function_c6e02c38(weapon);
	self function_5aa9dd1b(var_b594a2cd);
	self waittill(#"hash_347a612b61067eb3");
	while(!self function_d911b948())
	{
		self function_5aa9dd1b(var_b594a2cd);
		self bottapbutton(button);
		self waittill(#"hash_347a612b61067eb3");
	}
	holding = 1;
	while(!self function_cf788c22() && self isthrowinggrenade())
	{
		self function_5aa9dd1b(var_b594a2cd);
		if(holding)
		{
			self bottapbutton(button);
			if(self botgetlookdot() >= 1)
			{
				holding = 0;
			}
		}
		self waittill(#"hash_347a612b61067eb3");
	}
	if(holding)
	{
		while(self isthrowinggrenade())
		{
			self bottapbutton(71);
			self bottapbutton(49);
			self function_c17972fc();
			self waittill(#"hash_347a612b61067eb3");
		}
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: bleed_out_weight
	Namespace: bot_action
	Checksum: 0x1C36D5F0
	Offset: 0x9160
	Size: 0x366
	Parameters: 1
	Flags: Linked
*/
function bleed_out_weight(var_b594a2cd)
{
	if(!isdefined(self.owner))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self.owner.sessionstate == "playing")
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!isdefined(self.revivetrigger))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + self.owner.sessionstate;
	#/
	return 100;
}

/*
	Name: bleed_out
	Namespace: bot_action
	Checksum: 0xD824E1C6
	Offset: 0x94D0
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function bleed_out(var_b594a2cd)
{
	while(!isdefined(self.revivetrigger) && (!(isdefined(self.revivetrigger.beingrevived) && self.revivetrigger.beingrevived)))
	{
		self bottapbutton(3);
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_6d30e629
	Namespace: bot_action
	Checksum: 0xDF4D3B8B
	Offset: 0x9558
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_6d30e629(var_b594a2cd)
{
	if(!isdefined(self.bot.var_67b4ea54))
	{
		self.bot.var_67b4ea54 = randomfloat(1) < (isdefined(self.bot.tacbundle.var_fc299ded) ? self.bot.tacbundle.var_fc299ded : 0);
	}
	if(self.bot.var_67b4ea54)
	{
		function_d4102d11(var_b594a2cd);
	}
	else
	{
		function_9c6ca396(var_b594a2cd);
	}
}

/*
	Name: function_9c6ca396
	Namespace: bot_action
	Checksum: 0x2AD48982
	Offset: 0x9630
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_9c6ca396(var_b594a2cd)
{
	self function_26c2bce7(var_b594a2cd, self.bot.tacbundle.var_a78526b8);
}

/*
	Name: function_d4102d11
	Namespace: bot_action
	Checksum: 0x137F9C7E
	Offset: 0x9678
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_d4102d11(var_b594a2cd)
{
	self function_26c2bce7(var_b594a2cd, self.bot.tacbundle.var_b6b1339c);
}

/*
	Name: function_26c2bce7
	Namespace: bot_action
	Checksum: 0xC7EF8093
	Offset: 0x96C0
	Size: 0xF2
	Parameters: 2
	Flags: Linked
*/
function function_26c2bce7(var_b594a2cd, var_210136db)
{
	target = var_b594a2cd.target;
	if(!isentity(target))
	{
		return;
	}
	if(self.scriptenemy === target && isdefined(self.scriptenemytag))
	{
		var_b594a2cd.var_210136db = self.scriptenemytag;
	}
	else
	{
		if(isdefined(target.shootattag))
		{
			var_b594a2cd.var_210136db = target.shootattag;
		}
		else
		{
			var_b594a2cd.var_210136db = var_210136db;
		}
	}
	var_b594a2cd.var_5b865e5e = var_b594a2cd.var_210136db;
	if(isdefined(target.aimattag))
	{
		var_b594a2cd.var_5b865e5e = target.aimattag;
	}
}

/*
	Name: function_627e3d2c
	Namespace: bot_action
	Checksum: 0x12B15135
	Offset: 0x97C0
	Size: 0x80
	Parameters: 3
	Flags: Linked, Private
*/
function private function_627e3d2c(tag, target, var_c8e8809e)
{
	if(!isdefined(tag))
	{
		return var_c8e8809e;
	}
	if(tag == "tag_origin")
	{
		return target.origin;
	}
	tagorigin = target gettagorigin(tag);
	if(isdefined(tagorigin))
	{
		return tagorigin;
	}
	return var_c8e8809e;
}

/*
	Name: function_8a2b82ad
	Namespace: bot_action
	Checksum: 0xE7731538
	Offset: 0x9848
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function function_8a2b82ad(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(isdefined(target))
	{
		if(isvec(target))
		{
			var_b594a2cd.aimpoint = target;
		}
		else
		{
			if(function_ffa5b184(target))
			{
				var_b594a2cd.aimpoint = target.var_88f8feeb;
			}
			else if(isentity(target))
			{
				centroid = target getcentroid();
				var_b594a2cd.aimpoint = function_627e3d2c(var_b594a2cd.var_210136db, target, centroid);
				var_b594a2cd.var_97065630 = function_627e3d2c(var_b594a2cd.var_5b865e5e, target, centroid);
			}
		}
	}
	else
	{
		eyes = self geteye();
		angles = self getplayerangles();
		fwd = anglestoforward(angles);
		var_b594a2cd.aimpoint = eyes + (fwd * 300);
	}
	if(!isdefined(var_b594a2cd.var_97065630))
	{
		var_b594a2cd.var_97065630 = var_b594a2cd.aimpoint;
	}
	if(isdefined(var_b594a2cd.aimpoint))
	{
		self function_7355c240(var_b594a2cd);
	}
}

/*
	Name: function_7355c240
	Namespace: bot_action
	Checksum: 0xD8C069AA
	Offset: 0x9A38
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_7355c240(var_b594a2cd)
{
	if(!isdefined(self.bot.var_d7771ac3) || gettime() >= self.bot.var_d7771ac3)
	{
		eyes = self geteye();
		angles = self getplayerangles();
		fwd = anglestoforward(angles);
		right = anglestoright(angles);
		up = anglestoup(angles);
		aimoffset = function_d2e41376(var_b594a2cd.aimpoint, eyes, fwd, right, up, self.bot.var_ea5b64df, 0);
		if(isdefined(aimoffset))
		{
			self.bot.aimoffset = aimoffset;
		}
		var_9492fdcb = function_d2e41376(var_b594a2cd.var_97065630, eyes, fwd, right, up, self.bot.var_ea5b64df, 1);
		if(isdefined(var_9492fdcb))
		{
			self.bot.var_9492fdcb = var_9492fdcb;
		}
		if(isdefined(aimoffset) || isdefined(var_9492fdcb))
		{
			self.bot.var_ea5b64df = self.bot.var_ea5b64df * randomfloatrange(0.8, 0.9);
			self.bot.var_d7771ac3 = gettime() + randomintrange(300, 600);
		}
	}
	var_b594a2cd.aimpoint = var_b594a2cd.aimpoint + self.bot.aimoffset;
	var_b594a2cd.var_97065630 = var_b594a2cd.var_97065630 + self.bot.var_9492fdcb;
}

/*
	Name: function_d2e41376
	Namespace: bot_action
	Checksum: 0x3030C6BB
	Offset: 0x9CB0
	Size: 0x2A8
	Parameters: 7
	Flags: Linked
*/
function function_d2e41376(var_9d9ae85, eyes, fwd, right, up, var_ea5b64df, close)
{
	var_24e5c8be = var_9d9ae85 - eyes;
	var_df4809a5 = vectornormalize(var_24e5c8be);
	aimoffset = undefined;
	if(vectordot(fwd, var_df4809a5) > 0.7)
	{
		var_dafe1813 = min(var_ea5b64df, length(var_24e5c8be) * 0.25);
		if(close)
		{
			var_dafe1813 = var_dafe1813 * 0.5;
		}
		if(var_dafe1813 == 0)
		{
			return (0, 0, 0);
		}
		var_18451fac = var_dafe1813 * 0.25;
		var_d83e24eb = var_dafe1813;
		/#
			assert(var_18451fac > 0);
		#/
		/#
			assert(var_d83e24eb > 0);
		#/
		var_b91ee594 = vectordot(var_24e5c8be, right) < 0;
		if(var_b91ee594)
		{
			aimoffset = right * (randomfloatrange(var_d83e24eb * -1, var_18451fac));
		}
		else
		{
			aimoffset = right * (randomfloatrange(var_18451fac * -1, var_d83e24eb));
		}
		var_7bbaffc = vectordot(var_24e5c8be, up) < 0;
		if(var_7bbaffc)
		{
			aimoffset = (aimoffset[0], aimoffset[1], (randomfloatrange(var_d83e24eb * -1, var_18451fac)) * 0.5);
		}
		else
		{
			aimoffset = (aimoffset[0], aimoffset[1], (randomfloatrange(var_18451fac * -1, var_d83e24eb)) * 0.5);
		}
	}
	return aimoffset;
}

/*
	Name: function_ab6b1fc9
	Namespace: bot_action
	Checksum: 0x1705B5A8
	Offset: 0x9F60
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_ab6b1fc9(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(!isentity(target))
	{
		return;
	}
	subtargets = target_getsubtargets(target);
	if(subtargets[0] != 0)
	{
		var_b594a2cd.aimpoint = target_getorigin(target, subtargets[0]);
	}
	else
	{
		var_b594a2cd.aimpoint = target_getorigin(target);
	}
}

/*
	Name: function_a3dfc4aa
	Namespace: bot_action
	Checksum: 0xAD6F563A
	Offset: 0xA018
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function function_a3dfc4aa(var_b594a2cd)
{
	aimpoint = var_b594a2cd.aimpoint;
	weapon = var_b594a2cd.weapon;
	if(isdefined(aimpoint) && isdefined(weapon))
	{
		var_b594a2cd.var_cb785841 = self botgetprojectileaimangles(weapon, aimpoint);
	}
	else
	{
		var_b594a2cd.var_cb785841 = undefined;
	}
}

/*
	Name: function_d136dabe
	Namespace: bot_action
	Checksum: 0x45E38CEB
	Offset: 0xA0A0
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_d136dabe(var_b594a2cd)
{
	aimpoint = var_b594a2cd.aimpoint;
	if(isdefined(aimpoint))
	{
		var_b594a2cd.bullettrace = bullettrace(self geteye(), aimpoint, 1, self);
	}
	else
	{
		var_b594a2cd.bullettrace = undefined;
	}
}

/*
	Name: function_9004d3ca
	Namespace: bot_action
	Checksum: 0x23E2072F
	Offset: 0xA120
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_9004d3ca(var_b594a2cd)
{
	var_cb785841 = var_b594a2cd.var_cb785841;
	weapon = var_b594a2cd.weapon;
	if(isdefined(var_cb785841) && isdefined(weapon))
	{
		var_b594a2cd.var_e6ba3ec9 = self function_6e8a2d86(weapon, var_cb785841.var_478aeacd);
	}
	else
	{
		var_b594a2cd.var_e6ba3ec9 = undefined;
	}
}

/*
	Name: is_target_visible
	Namespace: bot_action
	Checksum: 0xB0F734B2
	Offset: 0xA1B0
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function is_target_visible(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(!isdefined(target))
	{
		return 0;
	}
	if(isentity(target))
	{
		return isalive(target) && self cansee(target, self.bot.tacbundle.var_82aa37d8);
	}
	if(isvec(target))
	{
		return sighttracepassed(self geteye(), target, 1, self);
	}
	return 0;
}

/*
	Name: function_ecf6dc7a
	Namespace: bot_action
	Checksum: 0xB2C105C9
	Offset: 0xA290
	Size: 0x172
	Parameters: 1
	Flags: None
*/
function function_ecf6dc7a(var_b594a2cd)
{
	if(!self bot::in_combat())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return false;
	}
	if(!self is_target_visible(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return false;
	}
	return true;
}

/*
	Name: function_b70a8fcf
	Namespace: bot_action
	Checksum: 0x81BFCEBD
	Offset: 0xA410
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function function_b70a8fcf(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(!isdefined(target))
	{
		return 0;
	}
	if(isplayer(target))
	{
		return isdefined(target.revivetrigger);
	}
	return 0;
}

/*
	Name: function_bb2a8f1b
	Namespace: bot_action
	Checksum: 0x26BEDAF0
	Offset: 0xA470
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_bb2a8f1b(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(isvec(target))
	{
		return 1;
	}
	return self.enemy === target;
}

/*
	Name: function_daa4968
	Namespace: bot_action
	Checksum: 0x83237433
	Offset: 0xA4C0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_daa4968(var_b594a2cd)
{
	target = var_b594a2cd.target;
	if(!isdefined(target))
	{
		return 0;
	}
	return target_istarget(target);
}

/*
	Name: function_ee402bf6
	Namespace: bot_action
	Checksum: 0xD195B11
	Offset: 0xA510
	Size: 0x12A
	Parameters: 1
	Flags: Linked
*/
function function_ee402bf6(var_b594a2cd)
{
	target = var_b594a2cd.target;
	weapon = var_b594a2cd.weapon;
	if(!isdefined(target) || !isdefined(weapon))
	{
		return 0;
	}
	if(issentient(target) && (self lastknowntime(target) + 5000) < gettime())
	{
		return 0;
	}
	targetorigin = (isvec(target) ? target : target.origin);
	targetdistsq = distancesquared(self.origin, targetorigin);
	var_1d4ad8f2 = self.bot.tacbundle.var_bda90bb9;
	return targetdistsq <= (var_1d4ad8f2 * var_1d4ad8f2);
}

/*
	Name: function_679b5b7a
	Namespace: bot_action
	Checksum: 0x5838690B
	Offset: 0xA648
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_679b5b7a(var_b594a2cd)
{
	target = var_b594a2cd.target;
	weapon = var_b594a2cd.weapon;
	if(!isdefined(target) || !isdefined(weapon))
	{
		return 0;
	}
	targetorigin = (isvec(target) ? target : target.origin);
	targetdistsq = distancesquared(self.origin, targetorigin);
	var_97c37e78 = self.bot.tacbundle.maxrange;
	return targetdistsq <= (var_97c37e78 * var_97c37e78);
}

/*
	Name: function_faa6a59d
	Namespace: bot_action
	Checksum: 0xDF9663BE
	Offset: 0xA740
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function function_faa6a59d(var_b594a2cd, range)
{
	target = var_b594a2cd.target;
	if(!isdefined(target))
	{
		return 0;
	}
	if(issentient(target) && (self lastknowntime(target) + 5000) < gettime())
	{
		return 0;
	}
	targetorigin = (isvec(target) ? target : target.origin);
	targetdistsq = distancesquared(self.origin, targetorigin);
	return targetdistsq <= (range * range);
}

/*
	Name: function_43505382
	Namespace: bot_action
	Checksum: 0xF327EEF
	Offset: 0xA830
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_43505382(var_b594a2cd)
{
	target = var_b594a2cd.target;
	bullettrace = var_b594a2cd.bullettrace;
	if(!isdefined(target) || !isdefined(bullettrace))
	{
		return 0;
	}
	if(isentity(target))
	{
		return target === bullettrace[#"entity"];
	}
	if(isvec(target))
	{
		return bullettrace[#"fraction"] >= 1;
	}
	return 0;
}

/*
	Name: function_ade341c
	Namespace: bot_action
	Checksum: 0xA15DCDD7
	Offset: 0xA900
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_ade341c(var_b594a2cd)
{
	target = var_b594a2cd.target;
	var_e6ba3ec9 = var_b594a2cd.var_e6ba3ec9;
	if(!isdefined(target) || !isdefined(var_e6ba3ec9))
	{
		return 0;
	}
	if(isentity(target))
	{
		return target === var_e6ba3ec9[#"entity"];
	}
	if(isvec(target))
	{
		return distancesquared(var_e6ba3ec9[#"position"], target) < 100;
	}
	return 0;
}

/*
	Name: aim_at_target
	Namespace: bot_action
	Checksum: 0xD63B727C
	Offset: 0xA9E8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function aim_at_target(var_b594a2cd)
{
	aimpoint = var_b594a2cd.aimpoint;
	if(!isdefined(aimpoint))
	{
		return;
	}
	self look_at_point(aimpoint, "Aim", (1, 0, 0));
	return aimpoint;
}

/*
	Name: function_e69a1e2e
	Namespace: bot_action
	Checksum: 0xABA68166
	Offset: 0xAA48
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_e69a1e2e(var_b594a2cd)
{
	aimpoint = var_b594a2cd.var_97065630;
	if(!isdefined(aimpoint))
	{
		return;
	}
	self look_at_point(aimpoint, "Aim", (1, 0, 0));
	return aimpoint;
}

/*
	Name: function_3a2f51fd
	Namespace: bot_action
	Checksum: 0xCDEE250B
	Offset: 0xAAA8
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_3a2f51fd(var_b594a2cd)
{
	var_cb785841 = var_b594a2cd.var_cb785841;
	if(isdefined(var_cb785841))
	{
		self botsetlookangles(var_cb785841.var_478aeacd);
	}
	/#
		if(self bot::should_record("") && isdefined(var_b594a2cd.aimpoint))
		{
			recordsphere(var_b594a2cd.aimpoint, 4, (1, 0, 0), "");
			record3dtext("", var_b594a2cd.aimpoint + vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.5);
		}
	#/
}

/*
	Name: function_31a76186
	Namespace: bot_action
	Checksum: 0xE26D55E6
	Offset: 0xABA8
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_31a76186(var_b594a2cd)
{
	var_f5842481 = (self haspath() ? self.bot.tacbundle.var_19019506 : self.bot.tacbundle.var_d5bf8f0d);
	if(!isdefined(var_f5842481))
	{
		var_f5842481 = 0;
	}
	return self botgetlookdot() >= var_f5842481;
}

/*
	Name: function_bacb1c08
	Namespace: bot_action
	Checksum: 0xA6FB73AB
	Offset: 0xAC40
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_bacb1c08(var_b594a2cd)
{
	var_b4c8298c = (isdefined(self.bot.tacbundle.var_b4c8298c) ? self.bot.tacbundle.var_b4c8298c : 0);
	return self botgetlookdot() >= var_b4c8298c;
}

/*
	Name: function_55d5a581
	Namespace: bot_action
	Checksum: 0x3C5062DD
	Offset: 0xACB0
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_55d5a581(var_b594a2cd)
{
	var_f80f8551 = (isdefined(self.bot.tacbundle.var_f80f8551) ? self.bot.tacbundle.var_f80f8551 : 0);
	return self botgetlookdot() >= var_f80f8551;
}

/*
	Name: get_max_health
	Namespace: bot_action
	Checksum: 0x6B640349
	Offset: 0xAD20
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function get_max_health()
{
	if(isvehicle(self))
	{
		return self.healthdefault;
	}
	return self.maxhealth;
}

/*
	Name: look_along_path
	Namespace: bot_action
	Checksum: 0xE7FA8D17
	Offset: 0xAD58
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function look_along_path()
{
	var_e125ba43 = "Path";
	debugcolor = (1, 1, 1);
	var_8be65bb9 = self function_f04bd922();
	if(isdefined(var_8be65bb9) && isdefined(var_8be65bb9.var_2cfdc66d))
	{
		var_104d463 = var_8be65bb9.var_2cfdc66d;
		var_e125ba43 = "Corner";
		if(isdefined(var_8be65bb9.var_b7af6731))
		{
			distsq = distance2dsquared(self.origin, var_104d463);
			if(distsq < 4096)
			{
				var_104d463 = var_8be65bb9.var_b7af6731;
				var_e125ba43 = "Next Corner";
			}
		}
		lookpoint = var_104d463;
		debugcolor = (1, 1, 0);
	}
	else
	{
		if(isdefined(self.overridegoalpos))
		{
			lookpoint = self.overridegoalpos;
			var_e125ba43 = "Override Goal Pos";
			debugcolor = (1, 0, 1);
		}
		else
		{
			lookpoint = self.goalpos;
			var_e125ba43 = (self.goalforced ? "Goal Pos (Forced)" : "Goal Pos");
			debugcolor = (self.goalforced ? (0, 1, 1) : (0, 1, 0));
		}
	}
	viewheight = self getplayerviewheight();
	lookpoint = lookpoint + (0, 0, viewheight);
	self look_at_point(lookpoint, var_e125ba43, debugcolor);
}

/*
	Name: function_412e04fa
	Namespace: bot_action
	Checksum: 0x86F672B4
	Offset: 0xAF40
	Size: 0x23C
	Parameters: 1
	Flags: Linked
*/
function function_412e04fa(node)
{
	var_208965cf = node.spawnflags & 262144;
	var_a26a51ba = node.spawnflags & 524288;
	if(!var_208965cf && !var_a26a51ba)
	{
		self botsetlookangles(node.angles);
		return;
	}
	var_831c15e5 = anglestoright(node.angles);
	rotation = (function_9ccb67a3(node) ? 20 : 45);
	if(var_208965cf && var_a26a51ba)
	{
		if(function_9ccb67a3(node))
		{
			if((vectordot(var_831c15e5, self.origin - node.origin)) >= 0)
			{
				rotation = rotation * -1;
			}
		}
		else
		{
			if(isdefined(self.enemylastseenpos))
			{
				if((vectordot(var_831c15e5, self.enemylastseenpos - self.origin)) >= 0)
				{
					rotation = rotation * -1;
				}
			}
			else if(randomint(2) > 0)
			{
				rotation = rotation * -1;
			}
		}
	}
	else if(var_a26a51ba)
	{
		rotation = rotation * -1;
	}
	lookangles = (node.angles[0], node.angles[1] + rotation, node.angles[2]);
	self botsetlookangles(lookangles);
}

/*
	Name: look_at_point
	Namespace: bot_action
	Checksum: 0x999CE25B
	Offset: 0xB188
	Size: 0xBC
	Parameters: 3
	Flags: Linked
*/
function look_at_point(point, var_e125ba43, debugcolor)
{
	self botsetlookpoint(point);
	/#
		if(self bot::should_record(""))
		{
			recordsphere(point, 4, debugcolor, "");
			record3dtext(var_e125ba43, point + vectorscale((0, 0, 1), 5), debugcolor, "", undefined, 0.5);
		}
	#/
}

/*
	Name: function_2b8f7067
	Namespace: bot_action
	Checksum: 0xC58209F1
	Offset: 0xB250
	Size: 0x5C4
	Parameters: 0
	Flags: Linked
*/
function function_2b8f7067()
{
	if(self haspath())
	{
		self look_along_path();
		return;
	}
	if(isdefined(self.ignoreall) && self.ignoreall || (isdefined(self.var_911100f4) && self.var_911100f4))
	{
		self function_c17972fc();
		return;
	}
	if(length(self getvelocity()) > 10)
	{
		self function_c17972fc();
		return;
	}
	var_4f1e4d22 = !isdefined(self.var_b6b6a5d9) || distancesquared(self.origin, self.var_b6b6a5d9) > 256;
	if(var_4f1e4d22)
	{
		self.var_83867a22 = undefined;
		self.var_b6b6a5d9 = self.origin;
		var_7607a546 = function_ad6356f5(self.origin);
		if(!isdefined(var_7607a546))
		{
			return;
		}
		var_7607a546.searched = 1;
		var_b43277fd = [0:var_7607a546];
		var_d56aeea7 = [0:var_7607a546];
		v_start_hardpoint_navmesh_collision = [];
		var_4a39f740 = [];
		self.var_77ae9678 = [];
		while(var_b43277fd.size > 0)
		{
			currentpoint = var_b43277fd[0];
			var_e8f2a3ea = function_9086d9a4(currentpoint);
			foreach(point in var_e8f2a3ea)
			{
				if(!(isdefined(point.searched) && point.searched))
				{
					point.searched = 1;
					var_d56aeea7[var_d56aeea7.size] = point;
					if(var_7607a546.region != point.region)
					{
						if(!array::contains(v_start_hardpoint_navmesh_collision, currentpoint))
						{
							v_start_hardpoint_navmesh_collision[v_start_hardpoint_navmesh_collision.size] = currentpoint;
						}
						continue;
					}
					if(!function_96c81b85(var_7607a546, point.origin + vectorscale((0, 0, 1), 60)))
					{
						if(!array::contains(var_4a39f740, currentpoint))
						{
							var_4a39f740[var_4a39f740.size] = currentpoint;
						}
						continue;
					}
					var_b43277fd[var_b43277fd.size] = point;
				}
			}
			var_b43277fd = array::remove_index(var_b43277fd, 0);
		}
		foreach(point in var_d56aeea7)
		{
			point.searched = undefined;
		}
		self.var_77ae9678 = arraycombine(v_start_hardpoint_navmesh_collision, var_4a39f740, 0, 0);
	}
	if(isdefined(self.var_77ae9678) && self.var_77ae9678.size > 0)
	{
		if(!isdefined(self.var_83867a22) || !isdefined(self.var_fa107838) || gettime() >= self.var_fa107838)
		{
			self.var_fa107838 = gettime() + randomintrange(2000, 4000);
			pointsarray = self.var_77ae9678;
			if(isdefined(self.var_83867a22) && pointsarray.size >= 2)
			{
				arrayremovevalue(pointsarray, self.var_83867a22);
			}
			self.var_83867a22 = array::random(pointsarray);
		}
	}
	if(isdefined(self.var_83867a22))
	{
		viewheight = self getplayerviewheight();
		lookpoint = self.var_83867a22.origin + (0, 0, viewheight);
		var_e125ba43 = "Neighboring Region Entrance";
		debugcolor = (1, 0, 0);
		self look_at_point(lookpoint, var_e125ba43, debugcolor);
	}
	else
	{
		node = self bot::get_position_node();
		if(isdefined(node))
		{
			self function_412e04fa(node);
		}
		else
		{
			self function_c17972fc();
		}
	}
}

/*
	Name: function_c17972fc
	Namespace: bot_action
	Checksum: 0x6CE1E8A5
	Offset: 0xB820
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_c17972fc()
{
	self botsetlookangles(self.angles);
}

/*
	Name: function_ab4c3550
	Namespace: bot_action
	Checksum: 0x6B912608
	Offset: 0xB850
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_ab4c3550()
{
	return isdefined(self.enemylastseenpos);
}

/*
	Name: function_3094610b
	Namespace: bot_action
	Checksum: 0x7C9EF8A
	Offset: 0xB868
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_3094610b(limit = 0)
{
	return isdefined(self.enemylastseenpos) && isdefined(self.enemylastseentime) && gettime() < (self.enemylastseentime + limit);
}

/*
	Name: function_ca71ffdb
	Namespace: bot_action
	Checksum: 0xB2EE710E
	Offset: 0xB8B8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_ca71ffdb()
{
	return sighttracepassed(self geteye(), self.enemylastseenpos, 0, self);
}

/*
	Name: function_d273d4e7
	Namespace: bot_action
	Checksum: 0xD7FEB905
	Offset: 0xB8F8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_d273d4e7()
{
	self look_at_point(self.enemylastseenpos, "EnemyLastSeenPos", (1, 0.5, 0));
}

/*
	Name: function_4fbd6cf1
	Namespace: bot_action
	Checksum: 0x790F633C
	Offset: 0xB938
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_4fbd6cf1()
{
	return isdefined(self.var_2925fedc);
}

/*
	Name: function_3b98ad10
	Namespace: bot_action
	Checksum: 0x110150F9
	Offset: 0xB950
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_3b98ad10()
{
	self look_at_point(self.var_2925fedc, "LikelyEnemyPosition", (1, 0.5, 0));
}

/*
	Name: clip_ammo
	Namespace: bot_action
	Checksum: 0x8FD69221
	Offset: 0xB990
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function clip_ammo(weapon)
{
	return self getweaponammoclip(weapon) + self getweaponammoclip(weapon.dualwieldweapon);
}

/*
	Name: function_39317d6e
	Namespace: bot_action
	Checksum: 0x8C6B8FA1
	Offset: 0xB9E0
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function function_39317d6e(var_b594a2cd)
{
	if(self.ignoreall)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!self function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	return 100;
}

/*
	Name: function_30636b1c
	Namespace: bot_action
	Checksum: 0x19F332BA
	Offset: 0xBAB8
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function function_30636b1c(var_b594a2cd)
{
	if(!self function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(!self bot::in_combat())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_38d0d1df
	Namespace: bot_action
	Checksum: 0x674FD86D
	Offset: 0xBBA0
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function function_38d0d1df(var_b594a2cd)
{
	if(!self function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_a9847723
	Namespace: bot_action
	Checksum: 0xFD840CF5
	Offset: 0xBC88
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function function_a9847723(weapon)
{
	slot = self gadgetgetslot(weapon);
	button = self function_c6e02c38(weapon);
	if(!isdefined(button))
	{
		return;
	}
	self bottapbutton(button);
	self waittill(#"hash_347a612b61067eb3");
}

/*
	Name: function_8171a298
	Namespace: bot_action
	Checksum: 0x6694426D
	Offset: 0xBD18
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function function_8171a298(weapon)
{
	slot = self gadgetgetslot(weapon);
	button = self function_c6e02c38(weapon);
	if(!isdefined(button))
	{
		return;
	}
	self botswitchtoweapon(weapon);
	self waittill(#"hash_347a612b61067eb3");
	self bottapbutton(button);
	self waittill(#"hash_347a612b61067eb3");
}

/*
	Name: function_ec16df22
	Namespace: bot_action
	Checksum: 0x90E05D7B
	Offset: 0xBDD8
	Size: 0x9A
	Parameters: 1
	Flags: None
*/
function function_ec16df22(weapon)
{
	slot = self gadgetgetslot(weapon);
	button = self function_c6e02c38(weapon);
	if(!isdefined(button))
	{
		return;
	}
	self bottapbutton(button);
	self botswitchtoweapon(weapon);
	self waittill(#"hash_347a612b61067eb3");
}

/*
	Name: test_gadget
	Namespace: bot_action
	Checksum: 0x1CCE020D
	Offset: 0xBE80
	Size: 0xF6
	Parameters: 1
	Flags: None
*/
function test_gadget(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self function_ccdcc5d9(weapon);
	while(self isthrowinggrenade() || !self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_fe0b0c29
	Namespace: bot_action
	Checksum: 0xF494314E
	Offset: 0xBF80
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_fe0b0c29(slot)
{
	switch(slot)
	{
		case 0:
		{
			return self ai::get_behavior_attribute("allowprimaryoffhand");
		}
		case 1:
		{
			return self ai::get_behavior_attribute("allowsecondaryoffhand");
		}
		case 2:
		{
			return self ai::get_behavior_attribute("allowspecialoffhand");
		}
	}
	return 0;
}

/*
	Name: function_5de4c088
	Namespace: bot_action
	Checksum: 0x3D0A1068
	Offset: 0xC038
	Size: 0x1AA
	Parameters: 1
	Flags: Linked
*/
function function_5de4c088(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	slot = self gadgetgetslot(weapon);
	if(!self function_fe0b0c29(slot))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return false;
	}
	if(!self gadgetisready(slot))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return false;
	}
	return true;
}

/*
	Name: function_49161e05
	Namespace: bot_action
	Checksum: 0x497C345
	Offset: 0xC1F0
	Size: 0x10E
	Parameters: 2
	Flags: Linked
*/
function function_49161e05(var_b594a2cd, var_6813ed6a)
{
	weapon = var_b594a2cd.weapon;
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self function_ccdcc5d9(weapon);
	while(isdefined(var_6813ed6a) && var_6813ed6a && self isthrowinggrenade() || !self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_94f96101
	Namespace: bot_action
	Checksum: 0xF2427427
	Offset: 0xC308
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_94f96101(var_b594a2cd)
{
	self function_49161e05(var_b594a2cd, 1);
}

/*
	Name: function_e7fa3d0
	Namespace: bot_action
	Checksum: 0x44B4BB89
	Offset: 0xC340
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_e7fa3d0()
{
	return self ai::get_behavior_attribute("allowscorestreak");
}

/*
	Name: function_29163ca5
	Namespace: bot_action
	Checksum: 0x66C94F3D
	Offset: 0xC370
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_29163ca5(weapon)
{
	self botswitchtoweapon(weapon);
	self waittill(#"hash_347a612b61067eb3");
}

/*
	Name: function_11c3d810
	Namespace: bot_action
	Checksum: 0x15A4E0CE
	Offset: 0xC3B8
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function function_11c3d810(weapon)
{
	activatefunc = weapon.rootweapon.var_c75f000;
	if(!isdefined(activatefunc))
	{
		/#
			self botprinterror(weapon.name + "");
		#/
		return;
	}
	self [[activatefunc]](weapon);
}

/*
	Name: function_bf21ead1
	Namespace: bot_action
	Checksum: 0xABD5951B
	Offset: 0xC430
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function function_bf21ead1()
{
	if(!isdefined(self.bot.tacbundle.var_d1fb2f1a) || (isdefined(self.bot.tacbundle.var_d1fb2f1a) ? self.bot.tacbundle.var_d1fb2f1a : 0) == 0)
	{
		return;
	}
	if(!self function_37256a9b())
	{
		return;
	}
	if(!isdefined(self.var_3ec95cb4) || gettime() >= self.var_3ec95cb4)
	{
		if(self bot::has_visible_enemy() && self.enemy.classname == "player")
		{
			self.favoriteenemy = undefined;
			self clearentitytarget();
			return;
		}
		self.favoriteenemy = self function_2a24a928();
		if(isdefined(self.favoriteenemy))
		{
			self setentitytarget(self.favoriteenemy);
		}
		else
		{
			self clearentitytarget();
		}
		if(!isdefined(self.favoriteenemy) && !isdefined(self.enemy) && self.bot.var_469cfe53.isfavoriteenemy)
		{
			self function_42907fd4();
		}
		self.var_3ec95cb4 = gettime() + randomintrange(1000, 10000);
	}
}

/*
	Name: function_37256a9b
	Namespace: bot_action
	Checksum: 0xF814394F
	Offset: 0xC618
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_37256a9b()
{
	weapons = self getweaponslist();
	foreach(weapon in weapons)
	{
		if(weapon.lockontype != "None")
		{
			clipammo = self clip_ammo(weapon);
			stockammo = self getweaponammostock(weapon);
			if(clipammo + stockammo > 0)
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_2a24a928
	Namespace: bot_action
	Checksum: 0xE3477B58
	Offset: 0xC718
	Size: 0x586
	Parameters: 0
	Flags: Linked
*/
function function_2a24a928()
{
	potentialtargets = [];
	if(isdefined(level.spawneduavs))
	{
		foreach(uav in level.spawneduavs)
		{
			if(isdefined(uav) && util::function_fbce7263(uav.team, self.team))
			{
				potentialtargets[potentialtargets.size] = uav;
			}
		}
	}
	if(isdefined(level.counter_uav_entities))
	{
		foreach(cuav in level.counter_uav_entities)
		{
			if(isdefined(cuav) && util::function_fbce7263(cuav.team, self.team))
			{
				potentialtargets[potentialtargets.size] = cuav;
			}
		}
	}
	choppers = getentarray("chopper", "targetName");
	if(isdefined(choppers))
	{
		foreach(chopper in choppers)
		{
			if(isdefined(chopper) && util::function_fbce7263(chopper.team, self.team))
			{
				potentialtargets[potentialtargets.size] = chopper;
			}
		}
	}
	planes = getentarray("strafePlane", "targetName");
	if(isdefined(planes))
	{
		foreach(plane in planes)
		{
			if(isdefined(plane) && util::function_fbce7263(plane.team, self.team))
			{
				potentialtargets[potentialtargets.size] = plane;
			}
		}
	}
	if(isdefined(level.ac130) && util::function_fbce7263(level.ac130.team, self.team))
	{
		potentialtargets[potentialtargets.size] = level.ac130;
	}
	if(potentialtargets.size == 0)
	{
		return undefined;
	}
	var_137299d = [];
	var_7607a546 = function_ad6356f5(self.origin);
	if(isdefined(var_7607a546))
	{
		foreach(target in potentialtargets)
		{
			if(issentient(target))
			{
				if(!isdefined(target.var_e38e137f) || !isdefined(target.var_e38e137f[self getentitynumber()]))
				{
					target.var_e38e137f[self getentitynumber()] = randomfloat(1) < (isdefined(self.bot.tacbundle.var_d1fb2f1a) ? self.bot.tacbundle.var_d1fb2f1a : 0);
				}
				if(!target.var_e38e137f[self getentitynumber()])
				{
					continue;
				}
				if(function_96c81b85(var_7607a546, target.origin))
				{
					var_137299d[var_137299d.size] = target;
				}
			}
		}
	}
	if(var_137299d.size == 0)
	{
		return undefined;
	}
	var_1f5c2eac = util::get_array_of_closest(self.origin, var_137299d);
	return var_1f5c2eac[0];
}

