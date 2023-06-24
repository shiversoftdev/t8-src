// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_prophet_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_prophet_fixup
	Checksum: 0x30C0325F
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_prophet_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_prophet_fixup
	Checksum: 0x4CB5FD44
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"prophet_unlock", #"hash_62361c68e083d401", #"hash_2cedfb261e2b473a", &function_d95e620c, #"hash_63b7bd67a959fc47", #"hash_63b7be67a959fdfa");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_prophet_fixup
	Checksum: 0x33A31FBE
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_53490e75 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_7cf82cc41c0f0d5")) ? getgametypesetting(#"hash_7cf82cc41c0f0d5") : 0);
	return var_53490e75;
}

