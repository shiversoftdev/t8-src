// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_spectre_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_spectre_fixup
	Checksum: 0x39D5DA05
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_spectre_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_spectre_fixup
	Checksum: 0xD27F5395
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"spectre_unlock", #"hash_1ee2659e8dff07d8", #"cu34_item", &function_d95e620c, #"hash_27023afb3f91aba5");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_spectre_fixup
	Checksum: 0xA18A57F0
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_4c72e3da = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_6fe34e77ba14d86f")) ? getgametypesetting(#"hash_6fe34e77ba14d86f") : 0);
	return var_4c72e3da;
}

