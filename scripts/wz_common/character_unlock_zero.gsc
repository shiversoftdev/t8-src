// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_zero;

/*
	Name: __init__system__
	Namespace: character_unlock_zero
	Checksum: 0xCE98A125
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_zero", &__init__, undefined, #"character_unlock_zero_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_zero
	Checksum: 0x27F66CB1
	Offset: 0xE0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::add_callback(#"hash_67dd51a5d529c64c", &function_2a798d57);
	character_unlock_fixup::function_90ee7a97(#"zero_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_zero
	Checksum: 0xF3A32B29
	Offset: 0x150
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_2a798d57
	Namespace: character_unlock_zero
	Checksum: 0x9D80E218
	Offset: 0x1A0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_2a798d57()
{
	if(self character_unlock::function_f0406288(#"zero_unlock"))
	{
		if(self stats::get_stat_global(#"destroy_equipment") >= 50)
		{
			self character_unlock::function_c8beca5e(#"zero_unlock", #"hash_178b421c5b67b4d5", 1);
		}
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_zero
	Checksum: 0xD64F3DE1
	Offset: 0x230
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_71890d1ecc35f71e")
	{
		if(self character_unlock::function_f0406288(#"zero_unlock"))
		{
			if(self stats::get_stat_global(#"destroy_equipment") >= 50)
			{
				self character_unlock::function_c8beca5e(#"zero_unlock", #"hash_178b421c5b67b4d5", 1);
			}
		}
	}
}

