// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\ai\strategic_command.gsc;
#using scripts\core_common\ai\planner_squad.gsc;
#using scripts\core_common\ai\planner_commander.gsc;
#using script_30e0aa25775a6927;
#using script_31e56101095f174b;
#using script_522aeb6ae906391e;

#namespace namespace_e4f52212;

/*
	Name: __init__system__
	Namespace: namespace_e4f52212
	Checksum: 0xF89033D0
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_44a6f2632e19a5c3", &namespace_526571f4::__init__, undefined, undefined);
}

#namespace namespace_526571f4;

/*
	Name: __init__
	Namespace: namespace_526571f4
	Checksum: 0x7079EA14
	Offset: 0x150
	Size: 0x154
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	plannercommanderutility::registerutilityapi(#"commanderscoreage", &_monkey_water_corvus_vo_cleared);
	plannercommanderutility::registerdaemonapi(#"daemonzmaltars", &function_ea95685);
	plannercommanderutility::registerdaemonapi(#"daemonzmblockers", &function_80c4721f);
	plannercommanderutility::registerdaemonapi(#"daemonzmchests", &function_73588006);
	plannercommanderutility::registerdaemonapi(#"daemonzmpowerups", &function_ccdf2c6f);
	plannercommanderutility::registerdaemonapi(#"daemonzmswitches", &function_48fcded4);
	plannercommanderutility::registerdaemonapi(#"daemonzmwallbuys", &function_873b1369);
}

/*
	Name: function_ea95685
	Namespace: namespace_526571f4
	Checksum: 0x7EF8BAE2
	Offset: 0x2B0
	Size: 0x1AC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ea95685(commander)
{
	altars = [];
	if(isarray(level.var_76a7ad28))
	{
		foreach(altar in level.var_76a7ad28)
		{
			if(!isdefined(altar))
			{
				continue;
			}
			var_bc510a14 = array();
			var_bc510a14[#"origin"] = altar.origin;
			var_bc510a14[#"type"] = altar.script_unitrigger_type;
			if(!isdefined(var_bc510a14[#"__unsafe__"]))
			{
				var_bc510a14[#"__unsafe__"] = array();
			}
			var_bc510a14[#"__unsafe__"][#"altar"] = altar;
			altars[altars.size] = var_bc510a14;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_altars", altars);
}

/*
	Name: function_80c4721f
	Namespace: namespace_526571f4
	Checksum: 0x1678D242
	Offset: 0x468
	Size: 0x324
	Parameters: 1
	Flags: Linked, Private
*/
function private function_80c4721f(commander)
{
	blockers = [];
	var_521da80d = array("zombie_door", "zombie_airlock_buy", "zombie_debris");
	foreach(var_b849a5e7 in var_521da80d)
	{
		doorblockers = getentarray(var_b849a5e7, "targetname");
		foreach(doorblocker in doorblockers)
		{
			var_6f43058 = array();
			if(isdefined(doorblocker.purchaser))
			{
				continue;
			}
			if(doorblocker._door_open === 1 || doorblocker.has_been_opened === 1)
			{
				continue;
			}
			if(isdefined(doorblocker.var_1661d836) && doorblocker.var_1661d836)
			{
				continue;
			}
			if(isdefined(doorblocker.var_c947f134) && doorblocker.var_c947f134)
			{
				continue;
			}
			if(isdefined(doorblocker.script_noteworthy))
			{
				switch(doorblocker.script_noteworthy)
				{
					case "electric_door":
					case "local_electric_door":
					case "electric_buyable_door":
					{
						continue;
					}
				}
			}
			var_6f43058[#"cost"] = doorblocker.zombie_cost;
			var_6f43058[#"origin"] = doorblocker.origin;
			if(!isdefined(var_6f43058[#"__unsafe__"]))
			{
				var_6f43058[#"__unsafe__"] = array();
			}
			var_6f43058[#"__unsafe__"][#"blocker"] = doorblocker;
			blockers[blockers.size] = var_6f43058;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_blockers", blockers);
}

/*
	Name: function_73588006
	Namespace: namespace_526571f4
	Checksum: 0x128C936D
	Offset: 0x798
	Size: 0x1FC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_73588006(commander)
{
	chests = [];
	if(isarray(level.chests))
	{
		foreach(chest in level.chests)
		{
			if(!isdefined(chest))
			{
				continue;
			}
			if(isdefined(chest.hidden) && chest.hidden)
			{
				continue;
			}
			var_559e6014 = array();
			var_559e6014[#"origin"] = chest.unitrigger_stub.origin;
			var_559e6014[#"cost"] = chest.zombie_cost;
			var_559e6014[#"type"] = chest.unitrigger_stub.script_unitrigger_type;
			if(!isdefined(var_559e6014[#"__unsafe__"]))
			{
				var_559e6014[#"__unsafe__"] = array();
			}
			var_559e6014[#"__unsafe__"][#"chest"] = chest;
			chests[chests.size] = var_559e6014;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_chests", chests);
}

/*
	Name: function_ccdf2c6f
	Namespace: namespace_526571f4
	Checksum: 0x9A63DA32
	Offset: 0x9A0
	Size: 0x1AC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ccdf2c6f(commander)
{
	powerups = [];
	if(isarray(level.active_powerups))
	{
		foreach(powerup in level.active_powerups)
		{
			if(!isdefined(powerup))
			{
				continue;
			}
			if(powerup.powerup_name == #"nuke")
			{
				continue;
			}
			var_131b0d64 = array();
			var_131b0d64[#"type"] = powerup.powerup_name;
			if(!isdefined(var_131b0d64[#"__unsafe__"]))
			{
				var_131b0d64[#"__unsafe__"] = array();
			}
			var_131b0d64[#"__unsafe__"][#"powerup"] = powerup;
			powerups[powerups.size] = var_131b0d64;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_powerups", powerups);
}

/*
	Name: function_48fcded4
	Namespace: namespace_526571f4
	Checksum: 0xDCDE691C
	Offset: 0xB58
	Size: 0x1CC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_48fcded4(commander)
{
	switches = [];
	switchents = getentarray("use_elec_switch", "targetname");
	if(isarray(switchents))
	{
		foreach(switchent in switchents)
		{
			if(!isdefined(switchent))
			{
				continue;
			}
			var_b353dc21 = array();
			var_b353dc21[#"origin"] = switchent.origin;
			var_b353dc21[#"cost"] = switchent.zombie_cost;
			if(!isdefined(var_b353dc21[#"__unsafe__"]))
			{
				var_b353dc21[#"__unsafe__"] = array();
			}
			var_b353dc21[#"__unsafe__"][#"switch"] = switchent;
			switches[switches.size] = var_b353dc21;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_switches", switches);
}

/*
	Name: function_873b1369
	Namespace: namespace_526571f4
	Checksum: 0x8673E97E
	Offset: 0xD30
	Size: 0x2FC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_873b1369(commander)
{
	wallbuys = [];
	if(isarray(level._spawned_wallbuys))
	{
		foreach(wallbuy in level._spawned_wallbuys)
		{
			if(!isdefined(wallbuy.trigger_stub))
			{
				continue;
			}
			if(wallbuy.weapon.type === "melee")
			{
				continue;
			}
			var_75f73822 = array();
			var_75f73822[#"weapon"] = wallbuy.weapon;
			var_75f73822[#"origin"] = wallbuy.trigger_stub.origin;
			var_75f73822[#"height"] = wallbuy.trigger_stub.script_height;
			var_75f73822[#"length"] = wallbuy.trigger_stub.script_length;
			var_75f73822[#"width"] = wallbuy.trigger_stub.script_width;
			var_75f73822[#"type"] = wallbuy.trigger_stub.script_unitrigger_type;
			zombieweapon = level.zombie_weapons[wallbuy.weapon];
			var_75f73822[#"ammo_cost"] = zombieweapon.ammo_cost;
			var_75f73822[#"cost"] = zombieweapon.cost;
			var_75f73822[#"upgrade_weapon"] = zombieweapon.upgrade;
			if(!isdefined(var_75f73822[#"__unsafe__"]))
			{
				var_75f73822[#"__unsafe__"] = array();
			}
			var_75f73822[#"__unsafe__"][#"wallbuy"] = wallbuy;
			wallbuys[wallbuys.size] = var_75f73822;
		}
	}
	blackboard::setstructblackboardattribute(commander, #"zm_wallbuys", wallbuys);
}

/*
	Name: _monkey_water_corvus_vo_cleared
	Namespace: namespace_526571f4
	Checksum: 0xB1098E6C
	Offset: 0x1038
	Size: 0x9A
	Parameters: 3
	Flags: Linked, Private
*/
function private _monkey_water_corvus_vo_cleared(commander, squad, constants)
{
	/#
		assert(isdefined(constants[#"maxage"]), ("" + "") + "");
	#/
	if(gettime() > squad.createtime + constants[#"maxage"])
	{
		return 0;
	}
	return 1;
}

