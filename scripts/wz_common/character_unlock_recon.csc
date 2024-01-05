// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_recon;

/*
	Name: __init__system__
	Namespace: character_unlock_recon
	Checksum: 0xCE9CE0A0
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_recon", &__init__, undefined, #"character_unlock_recon_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_recon
	Checksum: 0xECED5268
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"recon_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_recon
	Checksum: 0x29FB2538
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
			item_world_fixup::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d245e711188e065", 1);
		}
		else
		{
			item_world_fixup::function_e70fa91c(#"supply_stash_parent_dlc1", #"hash_d245e711188e065", 6);
		}
	}
}

