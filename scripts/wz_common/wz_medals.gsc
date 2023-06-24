// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\loot_tracking.gsc;
#using script_1d29de500c266470;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\wz_common\gametypes\warzone.gsc;
#using scripts\mp_common\player\player_record.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace wz_medals;

/*
	Name: __init__system__
	Namespace: wz_medals
	Checksum: 0x218717CE
	Offset: 0xF8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_medals", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: wz_medals
	Checksum: 0xACF45832
	Offset: 0x148
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_revived(&function_843da215);
	callback::on_player_killed_with_params(&function_f4837321);
}

/*
	Name: __main__
	Namespace: wz_medals
	Checksum: 0x80F724D1
	Offset: 0x198
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_843da215
	Namespace: wz_medals
	Checksum: 0x4265F897
	Offset: 0x1A8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_843da215(params)
{
	if(!gamestate::is_state("playing") || !isplayer(params.reviver) || !isdefined(params.attacker))
	{
		return;
	}
	if(params.attacker.team === params.reviver.team)
	{
		return;
	}
	weapon = getweapon(#"bare_hands");
	scoreevents::processscoreevent(#"revives", params.reviver, undefined, weapon);
}

/*
	Name: function_f4837321
	Namespace: wz_medals
	Checksum: 0xF6408D57
	Offset: 0x2A0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_f4837321(params)
{
	if(!isdefined(self.laststandparams) || !isdefined(self.var_a1d415ee))
	{
		return;
	}
	original_attacker = self.laststandparams.attacker;
	var_8efbdcbb = self.var_a1d415ee.attacker;
	weapon = self.laststandparams.sweapon;
	if(!isdefined(original_attacker) || !isplayer(var_8efbdcbb) || !isdefined(weapon))
	{
		return;
	}
	if(var_8efbdcbb.team === self.team)
	{
		return;
	}
	if(original_attacker != var_8efbdcbb)
	{
		scoreevents::processscoreevent(#"assists", var_8efbdcbb, undefined, weapon);
	}
}

