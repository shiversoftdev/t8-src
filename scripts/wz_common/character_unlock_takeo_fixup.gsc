// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_takeo_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_takeo_fixup
	Checksum: 0x37E75260
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_takeo_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_takeo_fixup
	Checksum: 0x746D050C
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"takeo_unlock", #"hash_36157750ed7c6584", #"cu18_item", &function_d95e620c, #"hash_56b5eb94fb75cbed", #"hash_56b5e894fb75c6d4");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_takeo_fixup
	Checksum: 0x814808DE
	Offset: 0x148
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_913db062 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_26186b4e5dc9bb6f")) ? getgametypesetting(#"hash_26186b4e5dc9bb6f") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0);
	return var_913db062;
}

