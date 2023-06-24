// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_stanton_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_stanton_fixup
	Checksum: 0x7F84C6F1
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
	Checksum: 0xE06F66F8
	Offset: 0xD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"stanton_unlock", #"hash_4f0c567012b33fd9", #"hash_3a19a30df0f60aa6", &function_d95e620c, #"hash_5495584ec5e9f348");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_stanton_fixup
	Checksum: 0xCAB99194
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

