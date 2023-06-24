// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_torque_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_torque_fixup
	Checksum: 0x37E6D01C
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_torque_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_torque_fixup
	Checksum: 0xE7AB069A
	Offset: 0xC8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"torque_unlock", #"hash_6999516e5e35a515", #"hash_400a089fa8ccd917", &function_d95e620c, #"hash_a9ec4883fd0293d", #"hash_3843c83850f09a08", #"hash_b47463756c6a60f");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_torque_fixup
	Checksum: 0x1282A41D
	Offset: 0x158
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_fb9571a = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_3d719d86f2f3f14d")) ? getgametypesetting(#"hash_3d719d86f2f3f14d") : 0);
	return var_fb9571a;
}

