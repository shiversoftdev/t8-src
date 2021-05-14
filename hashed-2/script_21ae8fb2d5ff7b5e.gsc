// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_d7e924ce;

/*
	Name: function_89f2df9
	Namespace: namespace_d7e924ce
	Checksum: 0x2F16565F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1bfbd9bd8caea5b8", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d7e924ce
	Checksum: 0x570C7E90
	Offset: 0xC0
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
	zm_trial::register_challenge(#"hash_45315239305b1f03", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_d7e924ce
	Checksum: 0xDB340493
	Offset: 0x128
	Size: 0x62
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	level.var_6d8a8e47 = 1;
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	level.var_5e45f817 = 1;
	level.var_d1b3ec4e = level.var_9b91564e;
	level.var_9b91564e = undefined;
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_d7e924ce
	Checksum: 0xC91FE998
	Offset: 0x198
	Size: 0x5E
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_6d8a8e47 = 0;
	level.var_153e9058 = 0;
	level.var_fe2bb2ac = 0;
	level.var_5e45f817 = 0;
	level.var_9b91564e = level.var_d1b3ec4e;
	level.var_d1b3ec4e = undefined;
}

