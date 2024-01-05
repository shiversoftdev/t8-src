// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_nikolai_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_nikolai_fixup
	Checksum: 0x86921238
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_nikolai_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_nikolai_fixup
	Checksum: 0x8769B6F7
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"nikolai_unlock", #"hash_1d718be46a94371f", #"cu16_item", &function_d95e620c, #"hash_6a5c9e02cc60e87e");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_nikolai_fixup
	Checksum: 0xB732F2DB
	Offset: 0x138
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_bca69f36 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2574d482086ec9d8")) ? getgametypesetting(#"hash_2574d482086ec9d8") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
	return var_bca69f36;
}

