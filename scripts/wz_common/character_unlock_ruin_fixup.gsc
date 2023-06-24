// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_ruin_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ruin_fixup
	Checksum: 0x9924A8D7
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ruin_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ruin_fixup
	Checksum: 0x955F63B
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"ruin_unlock", #"hash_63b894fa4d634238", #"hash_6d7d534b5d46d8dd", &function_d95e620c, #"hash_4e9ba934add76371");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ruin_fixup
	Checksum: 0xEE032B33
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e2bea9cf = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4f0a6d1e98cdbf81")) ? getgametypesetting(#"hash_4f0a6d1e98cdbf81") : 0);
	return var_e2bea9cf;
}

