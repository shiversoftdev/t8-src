// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace music;

/*
	Name: __init__system__
	Namespace: music
	Checksum: 0x45ADBF53
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"music", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: music
	Checksum: 0x5A38A709
	Offset: 0xF0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.musicstate = "";
	util::registerclientsys("musicCmd");
	if(sessionmodeiscampaigngame())
	{
		callback::on_spawned(&on_player_spawned);
	}
	if(sessionmodeiswarzonegame())
	{
		callback::on_connect(&function_cbeeecf);
	}
}

/*
	Name: setmusicstate
	Namespace: music
	Checksum: 0xB7838B21
	Offset: 0x188
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function setmusicstate(state, player)
{
	if(isdefined(level.musicstate))
	{
		if(isdefined(player))
		{
			util::setclientsysstate("musicCmd", state, player);
			return;
		}
		if(level.musicstate != state)
		{
			util::setclientsysstate("musicCmd", state);
		}
	}
	level.musicstate = state;
}

/*
	Name: setmusicstatebyteam
	Namespace: music
	Checksum: 0x1FDB8436
	Offset: 0x220
	Size: 0xB8
	Parameters: 2
	Flags: Linked
*/
function setmusicstatebyteam(state, str_teamname)
{
	foreach(player in level.players)
	{
		if(isdefined(player.team) && player.team == str_teamname)
		{
			setmusicstate(state, player);
		}
	}
}

/*
	Name: on_player_spawned
	Namespace: music
	Checksum: 0xD8C3FACB
	Offset: 0x2E0
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(isdefined(level.musicstate))
	{
		if(issubstr(level.musicstate, "_igc") || issubstr(level.musicstate, "igc_"))
		{
			return;
		}
		if(isdefined(self))
		{
		}
	}
}

/*
	Name: function_cbeeecf
	Namespace: music
	Checksum: 0xC9BDCEA6
	Offset: 0x350
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_cbeeecf()
{
	if(isdefined(self))
	{
		setmusicstate("none", self);
	}
}

