// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_reaper_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_reaper_fixup
	Checksum: 0x1DF7AF5E
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_reaper_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_reaper_fixup
	Checksum: 0xF4751478
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"reaper_unlock", #"hash_76cce42bfc9866cd", #"cu35_item", &function_d95e620c, #"hash_555c37b28c4a770c", #"hash_555c3ab28c4a7c25");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_reaper_fixup
	Checksum: 0xD7A8BB55
	Offset: 0x148
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_17805812 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_6b1ec01fa78af670")) ? getgametypesetting(#"hash_6b1ec01fa78af670") : 0);
	return var_17805812;
}

