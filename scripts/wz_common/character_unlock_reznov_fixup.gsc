// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_reznov_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_reznov_fixup
	Checksum: 0xE1096041
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_reznov_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_reznov_fixup
	Checksum: 0x8D92D3B
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"reznov_unlock", #"hash_44599132bf7320e8", #"hash_3a617537cefaff42", &function_d95e620c, #"hash_1cd3eb5d2d22f647", #"hash_1cd3ec5d2d22f7fa");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_reznov_fixup
	Checksum: 0x10359241
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_a4904ac0 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_47242abeaa29479b")) ? getgametypesetting(#"hash_47242abeaa29479b") : 0);
	return var_a4904ac0;
}

