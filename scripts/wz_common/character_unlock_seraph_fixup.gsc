// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\mp_common\item_world_fixup.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_seraph_fixup;

/*
	Name: __init__system__
	Namespace: character_unlock_seraph_fixup
	Checksum: 0x60495BE2
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_seraph_fixup", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: function_f031a77f
	Namespace: character_unlock_seraph_fixup
	Checksum: 0x7D80CC4E
	Offset: 0xD0
	Size: 0x1C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_f031a77f()
{
	waitframe(1);
	function_f5a58e15();
}

/*
	Name: __init__
	Namespace: character_unlock_seraph_fixup
	Checksum: 0xE221E5A3
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::register_character_unlock(#"seraph_unlock", #"hash_17c02481305f0e24", #"annihilator_wz_item", &function_d95e620c, #"hash_633d185cd2140f1a", #"hash_633d175cd2140d67");
}

/*
	Name: function_d95e620c
	Namespace: character_unlock_seraph_fixup
	Checksum: 0xFEB83A64
	Offset: 0x178
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e02cd092 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_183bcc0f6737224a")) ? getgametypesetting(#"hash_183bcc0f6737224a") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isdefined(getgametypesetting(#"hash_4a035e3775089f40")) ? getgametypesetting(#"hash_4a035e3775089f40") : 0);
	return var_e02cd092;
}

/*
	Name: function_f5a58e15
	Namespace: character_unlock_seraph_fixup
	Checksum: 0xEEEC17C2
	Offset: 0x2D8
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f5a58e15()
{
	var_a6762160 = getscriptbundle(#"annihilator_wz_item");
	if(isdefined(var_a6762160))
	{
		item_world_fixup::function_96ff7b88(#"annihilator_wz_item");
	}
}

