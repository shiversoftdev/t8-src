// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_50dc2248b1a1cde;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_towers_challenges;

/*
	Name: __init__system__
	Namespace: zm_towers_challenges
	Checksum: 0xFBCDF57E
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_towers_challenges", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_towers_challenges
	Checksum: 0x5756DE63
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "" + #"hash_2e38cc453c5ecb9c", 16000, 2, "int", &function_a45824f, 0, 0);
}

/*
	Name: __main__
	Namespace: zm_towers_challenges
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_a45824f
	Namespace: zm_towers_challenges
	Checksum: 0x84A7FD41
	Offset: 0x170
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_a45824f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		forcestreamxmodel(#"wpn_t8_pistol_standard_world");
	}
	else
	{
		if(newval == 2)
		{
			forcestreamxmodel(#"hash_31af613fbbe465cf");
		}
		else
		{
			stopforcestreamingxmodel(#"wpn_t8_pistol_standard_world");
			stopforcestreamingxmodel(#"hash_31af613fbbe465cf");
		}
	}
}

