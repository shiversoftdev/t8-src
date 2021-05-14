// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace namespace_34cc3243;

/*
	Name: function_89f2df9
	Namespace: namespace_34cc3243
	Checksum: 0x584F26BC
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_76d53a060efc848a", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_34cc3243
	Checksum: 0xE7F40035
	Offset: 0x108
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
	zm_trial::register_challenge(#"hash_424659e6cfcc0905", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_34cc3243
	Checksum: 0x1678FC6D
	Offset: 0x170
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	foreach(player in getplayers())
	{
		player val::set("trials_disable_regen", "health_regen", 0);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_34cc3243
	Checksum: 0xC1DDD899
	Offset: 0x208
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player val::reset("trials_disable_regen", "health_regen");
	}
}

/*
	Name: is_active
	Namespace: namespace_34cc3243
	Checksum: 0x148765F9
	Offset: 0x2A8
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function is_active(var_34f09024 = 0)
{
	challenge = zm_trial::function_a36e8c38(#"hash_424659e6cfcc0905");
	return isdefined(challenge);
}

