// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\util.gsc;
#using scripts\killstreaks\mp\killstreaks.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace player;

/*
	Name: figure_out_friendly_fire
	Namespace: player
	Checksum: 0x347C2899
	Offset: 0xF8
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function figure_out_friendly_fire(victim, attacker)
{
	if(level.hardcoremode && level.friendlyfire > 0 && isdefined(victim) && victim.is_capturing_own_supply_drop === 1)
	{
		return 2;
	}
	if(killstreaks::is_ricochet_protected(victim))
	{
		return 2;
	}
	if(level.friendlyfire == 4 && isplayer(attacker))
	{
		if(attacker.pers[#"teamkills_nostats"] < level.var_fe3ff9c1)
		{
			return 1;
		}
		return 2;
	}
	if(isdefined(level.figure_out_gametype_friendly_fire))
	{
		return [[level.figure_out_gametype_friendly_fire]](victim);
	}
	return level.friendlyfire;
}

/*
	Name: freeze_player_for_round_end
	Namespace: player
	Checksum: 0x9A9AC17E
	Offset: 0x210
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function freeze_player_for_round_end()
{
	self hud_message::clearlowermessage();
	if(!function_8b1a219a())
	{
		self closeingamemenu();
	}
	self val::set(#"freeze_player_for_round_end", "freezecontrols");
	self val::set(#"freeze_player_for_round_end", "disablegadgets");
	currentweapon = self getcurrentweapon();
	if(killstreaks::is_killstreak_weapon(currentweapon) && !currentweapon.iscarriedkillstreak)
	{
		self takeweapon(currentweapon);
	}
}

/*
	Name: function_c49fc862
	Namespace: player
	Checksum: 0x39EE1B99
	Offset: 0x318
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_c49fc862(team)
{
	if(isdefined(level.takelivesondeath) && level.takelivesondeath && (isdefined(level.teambased) && level.teambased) && (!(isdefined(level.var_a5f54d9f) && level.var_a5f54d9f)))
	{
		teamid = "team" + level.teamindex[team];
		if(isdefined(level.var_61952d8b[team]) && level.var_61952d8b[team])
		{
			clientfield::set_world_uimodel(("hudItems." + teamid) + ".livesCount", level.playerlives[team]);
		}
		else
		{
			clientfield::set_world_uimodel(("hudItems." + teamid) + ".livesCount", game.lives[team]);
		}
	}
}

/*
	Name: function_14e61d05
	Namespace: player
	Checksum: 0x495DA658
	Offset: 0x448
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_14e61d05()
{
	return self hasperk(#"specialty_stunprotection") || self hasperk(#"specialty_flashprotection") || self hasperk(#"specialty_proximityprotection");
}

/*
	Name: function_cf3aa03d
	Namespace: player
	Checksum: 0x1CB6BD48
	Offset: 0x4C0
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_cf3aa03d(func, threaded = 1)
{
	array::add(level.var_da2045d0, {#threaded:threaded, #callback:func});
}

/*
	Name: function_3c5cc656
	Namespace: player
	Checksum: 0x19CB8B35
	Offset: 0x530
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_3c5cc656(func, threaded = 1)
{
	array::add(level.var_fa66fada, {#threaded:threaded, #callback:func});
}

