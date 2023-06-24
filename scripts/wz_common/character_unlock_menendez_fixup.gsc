// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_menendez_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_menendez_fixup
	Checksum: 0x5A98430B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_menendez_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_menendez_fixup
	Checksum: 0x10CF8D28
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"menendez_unlock", #"hash_77118b5dbb73e0b6", #"hash_76e7c2dc8672414f", &function_d95e620c, #"hash_4bc3134998048aa7");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_menendez_fixup
	Checksum: 0x2EBBDFFE
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e9462a7e = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1d50c09e8021ab1")) ? getgametypesetting(#"hash_1d50c09e8021ab1") : 0);
	return var_e9462a7e;
}

