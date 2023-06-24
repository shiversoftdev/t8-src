// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_bruno_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_bruno_fixup
	Checksum: 0x940414B
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_bruno_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_bruno_fixup
	Checksum: 0xC5398F02
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"bruno_unlock", #"hash_4815f130a1c1d840", #"hash_7ed229d63a11e187", &function_d95e620c, #"hash_21c5510d64c20b71");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_bruno_fixup
	Checksum: 0x946ED4BA
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_808a2a47 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_2dfb36064be05f03")) ? getgametypesetting(#"hash_2dfb36064be05f03") : 0);
	return var_808a2a47;
}

