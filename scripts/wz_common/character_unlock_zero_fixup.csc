// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_zero_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_zero_fixup
	Checksum: 0x10033272
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_zero_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_zero_fixup
	Checksum: 0xFB9710CB
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"zero_unlock", #"hash_303d7717027a0f92", #"hash_71890d1ecc35f71e", &function_d95e620c, #"hash_178b421c5b67b4d5");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_zero_fixup
	Checksum: 0x68C0A311
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_a703ffba = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_19c58d35b2ea8d15")) ? getgametypesetting(#"hash_19c58d35b2ea8d15") : 0);
	return var_a703ffba;
}

