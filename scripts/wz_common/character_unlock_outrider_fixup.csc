// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_outrider_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_outrider_fixup
	Checksum: 0x829D1400
	Offset: 0x78
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_outrider_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_outrider_fixup
	Checksum: 0xFFCD7AC1
	Offset: 0xC8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"outrider_unlock", #"hash_1dc888eecacf65d4", #"hash_447ad6b75cf77f8b", &function_d95e620c, #"hash_28966e441535b733");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_outrider_fixup
	Checksum: 0xDEEAB91F
	Offset: 0x138
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_f8bc8610 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_52d705a46da9e55f")) ? getgametypesetting(#"hash_52d705a46da9e55f") : 0);
	return var_f8bc8610;
}

