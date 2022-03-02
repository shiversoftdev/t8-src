// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_444bc5b4fa0fe14f;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_10ecac2c;

/*
	Name: function_89f2df9
	Namespace: namespace_10ecac2c
	Checksum: 0x1B3A55CB
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6850ba7908370033", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_10ecac2c
	Checksum: 0x8BA725E7
	Offset: 0xD8
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
	zm_trial::register_challenge(#"hash_647805dc769488c2", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_10ecac2c
	Checksum: 0xA103F0AF
	Offset: 0x140
	Size: 0x6E
	Parameters: 0
	Flags: Private
*/
function private function_d1de6a85()
{
	level.var_43fb4347 = "sprint";
	level.var_102b1301 = "sprint";
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	if(!namespace_c56530a8::is_active())
	{
		level.var_5e45f817 = 1;
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_10ecac2c
	Checksum: 0xB558038C
	Offset: 0x1B8
	Size: 0x46
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	level.var_43fb4347 = undefined;
	level.var_102b1301 = undefined;
	level.var_153e9058 = 0;
	level.var_fe2bb2ac = 0;
	level.var_5e45f817 = 0;
}

