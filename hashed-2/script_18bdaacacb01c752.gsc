// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_d0919546;

/*
	Name: __init__system__
	Namespace: namespace_d0919546
	Checksum: 0xF099E2CD
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_5d70c94021e00856", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: namespace_d0919546
	Checksum: 0x1707314E
	Offset: 0xC8
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"hash_178221dd8299137b", #"hash_3c068bc5135b7df0", #"hash_7b73db9303fddf07", &function_d95e620c, undefined);
	character_unlock_fixup::register_character_unlock(#"hash_263de5e9fa6d16ea", #"hash_1c057428d4e91ae8", #"hash_109da3cfabaa9b8f", &function_d95e620c, undefined);
	character_unlock_fixup::register_character_unlock(#"hash_8c7045e78561cf4", #"hash_2b8f5badea243dda", #"hash_7b76b39303ffd0e6", &function_d95e620c, undefined);
	character_unlock_fixup::register_character_unlock(#"hash_74709eb5a08139fb", #"hash_78ae81c11d646d8b", #"hash_7b69e49303f599cd", &function_d95e620c, undefined);
	character_unlock_fixup::register_character_unlock(#"hash_517bb26004a9c12b", #"hash_1a942f2aeeccb69", #"hash_7b5fb89303ecfa84", &function_d95e620c, undefined);
	character_unlock_fixup::register_character_unlock(#"hash_3532d912b12917c9", #"hash_78ae86c11d64760a", #"hash_7b7dc39304060ac4", &function_d95e620c, undefined);
}

/*
	Name: function_d95e620c
	Namespace: namespace_d0919546
	Checksum: 0x51F52A04
	Offset: 0x2B8
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_be67b2be = (isdefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0);
	return var_be67b2be;
}

