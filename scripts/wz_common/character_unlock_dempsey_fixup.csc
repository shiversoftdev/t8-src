// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_dempsey_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_dempsey_fixup
	Checksum: 0xA3C17A3B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_dempsey_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_dempsey_fixup
	Checksum: 0x7F4B0B12
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"dempsey_unlock", #"hash_23d5f8566508f9f5", #"hash_4da28db320e11353", &function_d95e620c, #"hash_557b228047615fb0");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_dempsey_fixup
	Checksum: 0xC93F688C
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_182a6f93 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1d4c395693ce04fe")) ? getgametypesetting(#"hash_1d4c395693ce04fe") : 0);
	return var_182a6f93;
}

