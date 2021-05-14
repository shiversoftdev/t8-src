// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_67797245;

/*
	Name: function_89f2df9
	Namespace: namespace_67797245
	Checksum: 0x9C7532D0
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6f183f9fa707c247", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_67797245
	Checksum: 0x1A56212D
	Offset: 0xE0
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
	zm_trial::register_challenge(#"hash_29ed25a648820a10", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_67797245
	Checksum: 0xC2663EF1
	Offset: 0x148
	Size: 0xA6
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	self.var_42fe565a = level.var_c739ead9;
	self.var_8271882d = level.var_4d7e8b66;
	self.var_ecdf7fbe = level.var_1bb1a2fb;
	self.var_103c25d7 = level.var_5db2341c;
	self.var_97881ccb = level.var_53c7ca1d;
	level.var_c739ead9 = 2;
	level.var_4d7e8b66 = 2;
	level.var_1bb1a2fb = 2;
	level.var_5db2341c = 2;
	level.var_53c7ca1d = 2;
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_67797245
	Checksum: 0xA552D361
	Offset: 0x1F8
	Size: 0x6E
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_c739ead9 = self.var_42fe565a;
	level.var_4d7e8b66 = self.var_8271882d;
	level.var_1bb1a2fb = self.var_ecdf7fbe;
	level.var_5db2341c = self.var_103c25d7;
	level.var_53c7ca1d = self.var_97881ccb;
}

/*
	Name: is_active
	Namespace: namespace_67797245
	Checksum: 0x2F9E6846
	Offset: 0x270
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_29ed25a648820a10");
	return isdefined(challenge);
}

