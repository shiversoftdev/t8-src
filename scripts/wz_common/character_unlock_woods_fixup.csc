// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_woods_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_woods_fixup
	Checksum: 0x572F920C
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_woods_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_woods_fixup
	Checksum: 0x5E48A99F
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"woods_unlock", #"hash_3f01badbd66b2962", #"cu22_item", &function_d95e620c, #"hash_17a4baf5ec553be7", #"hash_17a4bbf5ec553d9a");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_woods_fixup
	Checksum: 0x88B06437
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_fca3d7af = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_265bdda9362c5a35")) ? getgametypesetting(#"hash_265bdda9362c5a35") : 0);
	return var_fca3d7af;
}

