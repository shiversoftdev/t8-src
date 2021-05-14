// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_7499819f;

/*
	Name: function_89f2df9
	Namespace: namespace_7499819f
	Checksum: 0x22CD055B
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_b143bd998abdd27", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_7499819f
	Checksum: 0xEA4628D0
	Offset: 0x138
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	foreach(player in getplayers())
	{
		player callback::on_laststand(&on_player_laststand);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_7499819f
	Checksum: 0x9457520A
	Offset: 0x1D0
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::function_53888e7f(&on_player_laststand);
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
private function on_player_laststand()
{
	var_57807cdc = [];
	array::add(var_57807cdc, self, 0);
	zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
}

