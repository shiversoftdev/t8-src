// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_firebreak_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_firebreak_fixup
	Checksum: 0x84981012
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_firebreak_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_firebreak_fixup
	Checksum: 0xC0B9589A
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"firebreak_unlock", #"hash_8596bc069593313", #"cu06_item", &function_d95e620c, #"hash_48b3b84fe88578f2");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_firebreak_fixup
	Checksum: 0x8541243B
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_711ddc0f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_75370c9c920502fc")) ? getgametypesetting(#"hash_75370c9c920502fc") : 0);
	return var_711ddc0f;
}

