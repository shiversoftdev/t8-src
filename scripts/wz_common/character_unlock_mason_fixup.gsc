// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_mason_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_mason_fixup
	Checksum: 0xF80BE4A1
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_mason_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_mason_fixup
	Checksum: 0x122EC45F
	Offset: 0xC8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"mason_unlock", #"hash_72350169be9133ae", #"cu19_item", &function_d95e620c, #"hash_7334970069e5e147", #"hash_7334980069e5e2fa");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_mason_fixup
	Checksum: 0xB5BA2B5F
	Offset: 0x148
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_2fcdec4f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_20f3ff8fbb8d8295")) ? getgametypesetting(#"hash_20f3ff8fbb8d8295") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isdefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);
	return var_2fcdec4f;
}

