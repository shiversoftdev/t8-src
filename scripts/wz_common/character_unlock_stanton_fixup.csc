// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_stanton_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_stanton_fixup
	Checksum: 0x8E9D5B54
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_stanton_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_stanton_fixup
	Checksum: 0x22C50114
	Offset: 0xD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"stanton_unlock", #"hash_4f0c567012b33fd9", #"cu14_item", &function_d95e620c, #"hash_5495584ec5e9f348");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_stanton_fixup
	Checksum: 0xC099ABCE
	Offset: 0x140
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_8d597b54 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_5ea56d63c68b4396")) ? getgametypesetting(#"hash_5ea56d63c68b4396") : 0);
	return var_8d597b54;
}

