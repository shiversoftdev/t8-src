// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_nomad_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_nomad_fixup
	Checksum: 0x6570F9FE
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_nomad_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_nomad_fixup
	Checksum: 0xBE4BB9B8
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"nomad_unlock", #"hash_4b77f84c47802222", #"hash_2c46bb9444d71ab6", &function_d95e620c, #"hash_7eb32c4c67ae13fe");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_nomad_fixup
	Checksum: 0x9E258DD0
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_1ff787de = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_26843909f5fdef20")) ? getgametypesetting(#"hash_26843909f5fdef20") : 0);
	return var_1ff787de;
}

