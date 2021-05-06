// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_3f142cad;

/*
	Name: function_89f2df9
	Namespace: namespace_3f142cad
	Checksum: 0xEB7EE462
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_710022810de6d77", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3f142cad
	Checksum: 0x8F3D22F3
	Offset: 0xF8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("missile", "decoy_grenade_footsteps", 1, 1, "int", &function_52b6cd8b, 0, 0);
}

/*
	Name: function_52b6cd8b
	Namespace: namespace_3f142cad
	Checksum: 0x1253DCA7
	Offset: 0x150
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_52b6cd8b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue == 1 && newvalue !== oldvalue)
	{
		self monitor_footsteps(localclientnum);
	}
}

/*
	Name: monitor_footsteps
	Namespace: namespace_3f142cad
	Checksum: 0xABE72F71
	Offset: 0x1D0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function monitor_footsteps(localclientnum)
{
	while(clientfield::get("decoy_grenade_footsteps") === 1)
	{
		self playsound(localclientnum, #"hash_4990634cec4a1aff");
		wait(0.23);
	}
}

