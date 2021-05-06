// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace deathicons;

/*
	Name: function_89f2df9
	Namespace: deathicons
	Checksum: 0x725DE01F
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"deathicons", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: deathicons
	Checksum: 0xD4559993
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	callback::on_connect(&on_player_connect);
}

/*
	Name: init
	Namespace: deathicons
	Checksum: 0xD3A2C9F2
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!isdefined(level.ragdoll_override))
	{
		level.ragdoll_override = &ragdoll_override;
	}
	if(!level.teambased)
	{
		return;
	}
}

/*
	Name: on_player_connect
	Namespace: deathicons
	Checksum: 0x234CB8C1
	Offset: 0x188
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.selfdeathicons = [];
}

/*
	Name: update_enabled
	Namespace: deathicons
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function update_enabled()
{
}

/*
	Name: add
	Namespace: deathicons
	Checksum: 0x591D8044
	Offset: 0x1B0
	Size: 0x234
	Parameters: 3
	Flags: Linked
*/
function add(entity, dyingplayer, team)
{
	if(!level.teambased)
	{
		return;
	}
	timeout = getdvarfloat(#"scr_deathicon_time", 5);
	iconorg = entity.origin;
	dyingplayer endon(#"spawned_player", #"disconnect");
	waitframe(1);
	util::waittillslowprocessallowed();
	/#
		assert(isdefined(level.teams[team]));
	#/
	/#
		assert(isdefined(level.teamindex[team]));
	#/
	if(getdvarint(#"ui_hud_showdeathicons", 1) == 0)
	{
		return;
	}
	if(level.hardcoremode)
	{
		return;
	}
	if(function_f99d2668())
	{
		return;
	}
	objectivename = (function_f99d2668() ? #"hash_2fc33ea98b703187" : #"headicon_dead");
	deathiconobjid = gameobjects::get_next_obj_id();
	objective_add(deathiconobjid, "active", iconorg, objectivename, dyingplayer);
	objective_setteam(deathiconobjid, team);
	function_3ae6fa3(deathiconobjid, team, 1);
	level thread destroy_slowly(timeout, deathiconobjid);
}

/*
	Name: destroy_slowly
	Namespace: deathicons
	Checksum: 0xAAA7298B
	Offset: 0x3F0
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function destroy_slowly(timeout, deathiconobjid)
{
	wait(timeout);
	objective_setstate(deathiconobjid, "done");
	wait(1);
	objective_delete(deathiconobjid);
	gameobjects::release_obj_id(deathiconobjid);
}

/*
	Name: ragdoll_override
	Namespace: deathicons
	Checksum: 0x2533A974
	Offset: 0x468
	Size: 0xD4
	Parameters: 10
	Flags: Linked
*/
function ragdoll_override(idamage, smeansofdeath, sweapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, ragdoll_jib, body)
{
	if(smeansofdeath == "MOD_FALLING" && self isonground() == 1)
	{
		body startragdoll();
		if(!isdefined(self.switching_teams))
		{
			thread add(body, self, self.team);
		}
		return 1;
	}
	return 0;
}

