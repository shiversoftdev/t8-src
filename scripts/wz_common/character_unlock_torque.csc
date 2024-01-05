// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_torque;

/*
	Name: __init__system__
	Namespace: character_unlock_torque
	Checksum: 0xD4DC92B
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_torque", &__init__, undefined, #"character_unlock_torque_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_torque
	Checksum: 0x7373FB73
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"torque_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_torque
	Checksum: 0xCADA640
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
			item_world_fixup::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 2);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"hash_5d3928f724e1cadf", #"hash_2b1e613a3cc4bf97", 6);
		}
	}
}

