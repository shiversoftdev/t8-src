// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_diego_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_diego_fixup
	Checksum: 0xD4532244
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_diego_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_diego_fixup
	Checksum: 0x11A58DE5
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"diego_unlock", #"hash_7fc15da2c5864d3c", #"hash_4eb6471e45f165a8", &function_d95e620c, #"hash_7d0b41a17f2e9a9");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_diego_fixup
	Checksum: 0x72FFAF4B
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_32ce41fd = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_7fc2867a4b8594bf")) ? getgametypesetting(#"hash_7fc2867a4b8594bf") : 0);
	return var_32ce41fd;
}

