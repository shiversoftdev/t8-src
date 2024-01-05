// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_scarlett_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_scarlett_fixup
	Checksum: 0xB3076B51
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_scarlett_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_scarlett_fixup
	Checksum: 0xF6C55278
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"scarlett_unlock", #"hash_6f105a897d64112", #"cu13_item", &function_d95e620c, #"hash_698918780b4406f1");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_scarlett_fixup
	Checksum: 0xA2B131B9
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_9a07aee8 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_7049c01d7ddf9b35")) ? getgametypesetting(#"hash_7049c01d7ddf9b35") : 0);
	return var_9a07aee8;
}

