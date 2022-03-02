// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_ba16273b;

/*
	Name: function_89f2df9
	Namespace: namespace_ba16273b
	Checksum: 0x4A29C8F7
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2a6a60ff4e0bd9d1", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ba16273b
	Checksum: 0x488985FD
	Offset: 0x110
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "" + #"hash_681de2aa531ffcd0", 20000, 1, "int", &function_a1ee0828, 0, 0);
}

/*
	Name: __main__
	Namespace: namespace_ba16273b
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_a1ee0828
	Namespace: namespace_ba16273b
	Checksum: 0xC41FB4C9
	Offset: 0x188
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_a1ee0828(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		forcestreamxmodel("c_t8_zmb_dlc3_mannequin_male_damage_ally_ready_pose");
	}
	else
	{
		stopforcestreamingxmodel("c_t8_zmb_dlc3_mannequin_male_damage_ally_ready_pose");
	}
}

