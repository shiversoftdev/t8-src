// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_ajax_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_ajax_fixup
	Checksum: 0xC871053B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ajax_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ajax_fixup
	Checksum: 0xE519AABA
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"ajax_unlock", #"hash_69bbe1ec48f79df5", #"cu01_item", &function_d95e620c, #"hash_6e5a10ffa958d875");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_ajax_fixup
	Checksum: 0xB02B0BE0
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_db4d099d = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_d084b5063bb0c55")) ? getgametypesetting(#"hash_d084b5063bb0c55") : 0);
	return var_db4d099d;
}

