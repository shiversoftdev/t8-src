// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_d8d92c8b;

/*
	Name: function_89f2df9
	Namespace: namespace_d8d92c8b
	Checksum: 0xD67E34BB
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_20bcc20891aa8bdd", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d8d92c8b
	Checksum: 0x974DA93C
	Offset: 0xD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
}

/*
	Name: init_clientfields
	Namespace: namespace_d8d92c8b
	Checksum: 0xC4DEB76F
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_61ff06b1f8850806", 1, 1, "int", &function_800c9ffb, 0, 0);
}

/*
	Name: function_800c9ffb
	Namespace: namespace_d8d92c8b
	Checksum: 0xFBA82297
	Offset: 0x160
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function function_800c9ffb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, #"zm_office_drawer_rumble");
	}
}

