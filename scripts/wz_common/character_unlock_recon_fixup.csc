// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_recon_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_recon_fixup
	Checksum: 0x2ABE99D
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_recon_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_recon_fixup
	Checksum: 0xD721633
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"recon_unlock", #"hash_78c357c8a5680d67", #"cu04_item", &function_d95e620c, #"hash_91d5ea7b26a8aca", #"hash_91d5da7b26a8917");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_recon_fixup
	Checksum: 0xE5515B19
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_4bbd2b8a = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_34ea44c91776e52c")) ? getgametypesetting(#"hash_34ea44c91776e52c") : 0);
	return var_4bbd2b8a;
}

