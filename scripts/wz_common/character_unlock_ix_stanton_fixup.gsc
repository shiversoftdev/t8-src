// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_ix_stanton_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ix_stanton_fixup
	Checksum: 0xF699F36D
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ix_stanton_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ix_stanton_fixup
	Checksum: 0x51EFCDAE
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"hash_518e05d31b55dfe7", #"hash_8bb7d93747987a1", #"hash_3fd471201d49cc19", &function_d95e620c, #"hash_9eef158b72b6ff4", #"hash_9eef458b72b750d");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ix_stanton_fixup
	Checksum: 0x11EC2D43
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_a6df6d8d = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_1ec2d38a40e97c55")) ? getgametypesetting(#"hash_1ec2d38a40e97c55") : 0);
	return var_a6df6d8d;
}

