// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_7499819f;

/*
	Name: __init__system__
	Namespace: namespace_7499819f
	Checksum: 0x22CD055B
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_3887e77731340f48", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_7499819f
	Checksum: 0x34CEB065
	Offset: 0xD0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_b143bd998abdd27", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_7499819f
	Checksum: 0xEA4628D0
	Offset: 0x138
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	foreach(player in getplayers())
	{
		player callback::on_laststand(&on_player_laststand);
	}
}

/*
	Name: on_end
	Namespace: namespace_7499819f
	Checksum: 0x9457520A
	Offset: 0x1D0
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::remove_on_laststand(&on_player_laststand);
	}
}

/*
	Name: on_player_laststand
	Namespace: namespace_7499819f
	Checksum: 0xC66497EB
	Offset: 0x270
	Size: 0x4C
	Parameters: 0
	Flags: Private
*/
function private on_player_laststand()
{
	var_57807cdc = [];
	array::add(var_57807cdc, self, 0);
	zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
}

