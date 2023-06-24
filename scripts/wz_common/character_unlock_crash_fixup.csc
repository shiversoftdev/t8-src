// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_crash_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_crash_fixup
	Checksum: 0xDD7BFC45
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_crash_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_crash_fixup
	Checksum: 0xE907D8B2
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"crash_unlock", #"hash_7a9842f6bec0e568", #"hash_6e170d3f9454d08a", &function_d95e620c, #"hash_7ccc9c0240fd010e", #"hash_7ccc9b0240fcff5b");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_crash_fixup
	Checksum: 0x6A6A4267
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_da8a21a0 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4c66b817adba935c")) ? getgametypesetting(#"hash_4c66b817adba935c") : 0);
	return var_da8a21a0;
}

