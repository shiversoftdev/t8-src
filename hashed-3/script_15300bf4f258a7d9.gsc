// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_7dd6557e89e9840b;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace remotemissile;

/*
	Name: function_89f2df9
	Namespace: remotemissile
	Checksum: 0xFC44242E
	Offset: 0xD0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"remotemissile", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: remotemissile
	Checksum: 0x51836AE5
	Offset: 0x120
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	level.var_5951cb24 = &function_5951cb24;
	level.var_dab39bb8 = &function_dab39bb8;
	level.var_feddd85a = &function_feddd85a;
}

/*
	Name: function_5951cb24
	Namespace: remotemissile
	Checksum: 0xDD628092
	Offset: 0x188
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_5951cb24(killstreak_id, team)
{
	if(!isdefined(self.currentkillstreakdialog) && isdefined(level.var_cb4eb1d1))
	{
		self thread [[level.var_cb4eb1d1]]("callInRemoteMissile", "callInFutzRemoteMissile");
	}
}

/*
	Name: function_dab39bb8
	Namespace: remotemissile
	Checksum: 0xCE6714D2
	Offset: 0x1E8
	Size: 0x180
	Parameters: 1
	Flags: Linked
*/
function function_dab39bb8(rocket)
{
	self endon(#"remotemissile_done");
	rocket endon(#"death");
	var_b5e50364 = 0;
	while(!var_b5e50364)
	{
		enemy = self.owner battlechatter::get_closest_player_enemy(self.origin, 1);
		if(!isdefined(enemy))
		{
			return 0;
		}
		eyepoint = enemy geteye();
		relativepos = vectornormalize(self.origin - eyepoint);
		dir = anglestoforward(enemy getplayerangles());
		dotproduct = vectordot(relativepos, dir);
		if(dotproduct > 0 && sighttracepassed(self.origin, eyepoint, 1, enemy, self))
		{
			enemy thread battlechatter::play_killstreak_threat("remote_missile");
			var_b5e50364 = 1;
		}
		wait(0.1);
	}
}

/*
	Name: function_feddd85a
	Namespace: remotemissile
	Checksum: 0x2E21287B
	Offset: 0x370
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_feddd85a(attacker, weapon)
{
	attacker battlechatter::function_dd6a6012("remote_missile", weapon);
}

