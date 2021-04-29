// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_56ca01b3b31455b5;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace gadget_combat_efficiency;

/*
	Name: function_89f2df9
	Namespace: gadget_combat_efficiency
	Checksum: 0xE561A3CA
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"gadget_combat_efficiency", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_combat_efficiency
	Checksum: 0x1FA2E33C
	Offset: 0x150
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	ability_player::register_gadget_activation_callbacks(12, &gadget_combat_efficiency_on_activate, &gadget_combat_efficiency_on_off);
	ability_player::register_gadget_is_inuse_callbacks(12, &gadget_combat_efficiency_is_inuse);
	ability_player::register_gadget_is_flickering_callbacks(12, &gadget_combat_efficiency_is_flickering);
	ability_player::register_gadget_ready_callbacks(12, &gadget_combat_efficiency_ready);
	clientfield::register("clientuimodel", "hudItems.combatEfficiencyActive", 1, 1, "int");
}

/*
	Name: gadget_combat_efficiency_is_inuse
	Namespace: gadget_combat_efficiency
	Checksum: 0xEFBEB200
	Offset: 0x220
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function gadget_combat_efficiency_is_inuse(slot)
{
	return self gadgetisactive(slot);
}

/*
	Name: gadget_combat_efficiency_is_flickering
	Namespace: gadget_combat_efficiency
	Checksum: 0x607EF7F1
	Offset: 0x250
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function gadget_combat_efficiency_is_flickering(slot)
{
	return self gadgetflickering(slot);
}

/*
	Name: function_5bfd1343
	Namespace: gadget_combat_efficiency
	Checksum: 0x53D08ACD
	Offset: 0x280
	Size: 0xF4
	Parameters: 5
	Flags: None
*/
function function_5bfd1343(attacker, var_f231d134, var_6ba675bd, capturedobjective, var_77cc3ee4)
{
	if(!isdefined(attacker) || !isdefined(var_f231d134) || !isdefined(var_77cc3ee4) || !isdefined(attacker.var_649d2b1f))
	{
		return;
	}
	if(function_db4ccff2(attacker, undefined, var_f231d134) && (isdefined(attacker.var_bc9d778c) && attacker.var_bc9d778c) && attacker != attacker.var_649d2b1f)
	{
		scoreevents::processscoreevent(#"hash_5a93aa54c5f5213f", attacker.var_649d2b1f, undefined, var_77cc3ee4);
	}
}

/*
	Name: function_57b485b3
	Namespace: gadget_combat_efficiency
	Checksum: 0x9AEE5056
	Offset: 0x380
	Size: 0xFC
	Parameters: 5
	Flags: None
*/
function function_57b485b3(attacker, time, var_f231d134, var_77cc3ee4, var_f205bc2b)
{
	if(!isdefined(attacker) || !isdefined(var_f231d134) || !isdefined(var_77cc3ee4) || !isdefined(attacker.var_649d2b1f) || !isdefined(var_f205bc2b))
	{
		return;
	}
	if(function_db4ccff2(attacker, undefined, var_f231d134))
	{
		if(var_f205bc2b)
		{
			scoreevents::processscoreevent(#"battle_command_ultimate_command", attacker, undefined, var_77cc3ee4);
		}
		else if(attacker == attacker.var_649d2b1f)
		{
			scoreevents::processscoreevent(#"hash_1c12195e708977c5", attacker, undefined, var_77cc3ee4);
		}
	}
}

/*
	Name: function_a30493ef
	Namespace: gadget_combat_efficiency
	Checksum: 0xCB6942BF
	Offset: 0x488
	Size: 0xD4
	Parameters: 4
	Flags: None
*/
function function_a30493ef(attacker, lastkilltime, var_f231d134, var_77cc3ee4)
{
	if(!isdefined(attacker) || !isdefined(var_f231d134) || !isdefined(var_77cc3ee4) || !isdefined(attacker.var_649d2b1f))
	{
		return;
	}
	if(function_db4ccff2(attacker, undefined, var_f231d134) && (isdefined(attacker.var_bc9d778c) && attacker.var_bc9d778c))
	{
		scoreevents::processscoreevent(#"hash_3d7b27350807786b", attacker.var_649d2b1f, undefined, var_77cc3ee4);
	}
}

/*
	Name: function_db4ccff2
	Namespace: gadget_combat_efficiency
	Checksum: 0x8901546F
	Offset: 0x568
	Size: 0xCE
	Parameters: 5
	Flags: None
*/
function function_db4ccff2(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(attacker) || !isdefined(weapon))
	{
		return 0;
	}
	if(isdefined(attacker.playerrole) && isdefined(attacker.playerrole.var_ec20b2a))
	{
		var_266391e6 = getweapon(attacker.playerrole.var_ec20b2a);
		if(attacker ability_util::function_43cda488() && weapon == var_266391e6)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_92308e92
	Namespace: gadget_combat_efficiency
	Checksum: 0xE8B3B299
	Offset: 0x640
	Size: 0x6A
	Parameters: 4
	Flags: None
*/
function function_92308e92(attacker, victim, weapon, attackerweapon)
{
	if(!isdefined(attacker))
	{
		return 0;
	}
	attacker.var_bc9d778c = attacker ability_util::function_43cda488();
	return function_db4ccff2(attacker, victim, weapon, attackerweapon);
}

/*
	Name: gadget_combat_efficiency_on_activate
	Namespace: gadget_combat_efficiency
	Checksum: 0xB8343DB8
	Offset: 0x6B8
	Size: 0xA6
	Parameters: 2
	Flags: None
*/
function gadget_combat_efficiency_on_activate(slot, weapon)
{
	self._gadget_combat_efficiency = 1;
	self._gadget_combat_efficiency_success = 0;
	self.scorestreaksearnedperuse = 0;
	self.combatefficiencylastontime = gettime();
	self function_f53ac86e();
	self thread function_6a9d7105(slot, weapon);
	result = self gestures::function_56e00fbf(#"hash_7ad077e650ead562", undefined, 0);
}

/*
	Name: gadget_combat_efficiency_on_off
	Namespace: gadget_combat_efficiency
	Checksum: 0x119DFB62
	Offset: 0x768
	Size: 0x10C
	Parameters: 2
	Flags: None
*/
function gadget_combat_efficiency_on_off(slot, weapon)
{
	self._gadget_combat_efficiency = 0;
	self.combatefficiencylastontime = gettime();
	self function_f53ac86e();
	self stats::function_e24eec31(self.heroability, #"scorestreaks_earned_2", int(self.scorestreaksearnedperuse / 2));
	self stats::function_e24eec31(self.heroability, #"scorestreaks_earned_3", int(self.scorestreaksearnedperuse / 3));
	if(isalive(self) && isdefined(level.playgadgetsuccess))
	{
		self [[level.playgadgetsuccess]](weapon);
	}
}

/*
	Name: function_6a9d7105
	Namespace: gadget_combat_efficiency
	Checksum: 0xCD16060F
	Offset: 0x880
	Size: 0x156
	Parameters: 2
	Flags: None
*/
function function_6a9d7105(slot, weapon)
{
	if(self function_91224c49() == 0)
	{
		return;
	}
	self notify("1da58f971e958838");
	self endon("1da58f971e958838");
	self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	var_122b9df7 = weapon.gadget_power_usage_rate * 0.5 * float(function_60d95f53()) / 1000;
	do
	{
		current_power = self gadgetpowerget(slot);
		self gadgetpowerset(slot, min(current_power + var_122b9df7, 100));
		waitframe(1);
	}
	while(self._gadget_combat_efficiency);
}

/*
	Name: gadget_combat_efficiency_ready
	Namespace: gadget_combat_efficiency
	Checksum: 0x3863906C
	Offset: 0x9E0
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function gadget_combat_efficiency_ready(slot, weapon)
{
}

/*
	Name: set_gadget_combat_efficiency_status
	Namespace: gadget_combat_efficiency
	Checksum: 0x940326E2
	Offset: 0xA00
	Size: 0xBC
	Parameters: 3
	Flags: None
*/
function set_gadget_combat_efficiency_status(weapon, status, time)
{
	timestr = "";
	if(isdefined(time))
	{
		timestr = "^3" + ", time: " + time;
	}
	/#
		if(getdvarint(#"scr_cpower_debug_prints", 0) > 0)
		{
			self iprintlnbold("" + weapon.name + "" + status + timestr);
		}
	#/
}

/*
	Name: function_f53ac86e
	Namespace: gadget_combat_efficiency
	Checksum: 0xAF4A458B
	Offset: 0xAC8
	Size: 0xF6
	Parameters: 0
	Flags: None
*/
function function_f53ac86e()
{
	enabled = self ability_util::function_43cda488();
	if(isdefined(self.team))
	{
		teammates = getplayers(self.team);
		foreach(player in teammates)
		{
			player clientfield::set_player_uimodel("hudItems.combatEfficiencyActive", enabled);
			if(enabled)
			{
				player.var_649d2b1f = self;
				continue;
			}
			player.var_649d2b1f = undefined;
		}
	}
}

