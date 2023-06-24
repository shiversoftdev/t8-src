// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_battery_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_battery_fixup
	Checksum: 0x45905D39
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_battery_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_battery_fixup
	Checksum: 0x7301D56F
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"battery_unlock", #"hash_7f410b145dce17bd", #"warmachine_wz_item", &function_d95e620c, #"hash_c5713430b8fb888");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_battery_fixup
	Checksum: 0xD1D7D0D2
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_7801126f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2cd26947d8f311fa")) ? getgametypesetting(#"hash_2cd26947d8f311fa") : 0);
	return var_7801126f;
}

