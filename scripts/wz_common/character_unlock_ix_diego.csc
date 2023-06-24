// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_ix_diego;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_diego
	Checksum: 0x114BE3D0
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_diego", &__init__, undefined, #"character_unlock_ix_diego_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_diego
	Checksum: 0xDC5A6627
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ix_diego_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ix_diego
	Checksum: 0xA526E553
	Offset: 0x110
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 3);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_24bfa16ffb71fe9f", 6);
		}
	}
}

