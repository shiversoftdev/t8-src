// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_ix_bruno_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0x1AD48513
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_bruno_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0x8D1BFDC1
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"hash_f1156c5f8b9f0e8", #"hash_677a722d85cbd06", #"hash_2662e8abf5c359e7", &function_d95e620c, #"hash_1493c49bbdfb17ad");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ix_bruno_fixup
	Checksum: 0xF0F034B7
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_bda4e460 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_4547b7ecb49469f0")) ? getgametypesetting(#"hash_4547b7ecb49469f0") : 0);
	return var_bda4e460;
}

