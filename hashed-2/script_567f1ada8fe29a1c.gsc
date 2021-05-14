// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_5869722f;

/*
	Name: function_89f2df9
	Namespace: namespace_5869722f
	Checksum: 0xDCE73886
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_12075e5736a83384", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5869722f
	Checksum: 0x80D17FF8
	Offset: 0xC8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_148571995bbd7ec1", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_5869722f
	Checksum: 0x2A92B1FD
	Offset: 0x130
	Size: 0xE6
	Parameters: 4
	Flags: Linked, Private
*/
private function function_d1de6a85(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c)
{
	archetypes = array::remove_undefined(array(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c), 0);
	self.var_c54c0d81 = [];
	foreach(archetype in archetypes)
	{
		self.var_c54c0d81[archetype] = 1;
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_5869722f
	Checksum: 0x6F532B18
	Offset: 0x220
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	self.var_c54c0d81 = undefined;
}

/*
	Name: function_ff2a74e7
	Namespace: namespace_5869722f
	Checksum: 0x11D91DE
	Offset: 0x240
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function function_ff2a74e7(archetype)
{
	challenge = zm_trial::function_a36e8c38(#"hash_148571995bbd7ec1");
	if(!isdefined(challenge))
	{
		return 0;
	}
	return isdefined(challenge.var_c54c0d81[archetype]);
}

