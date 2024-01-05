// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_spectre;

/*
	Name: __init__system__
	Namespace: character_unlock_spectre
	Checksum: 0x6493BCB7
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_spectre", &__init__, undefined, #"character_unlock_spectre_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_spectre
	Checksum: 0xB51E165E
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"spectre_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_spectre
	Checksum: 0x3152780D
	Offset: 0x120
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_453c77a41df1963c", &function_27709af9);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_spectre
	Checksum: 0xA1791132
	Offset: 0x1A0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu34_item")
	{
		if(self character_unlock::function_f0406288(#"spectre_unlock"))
		{
			if(self stats::get_stat_global(#"hash_41f134c3e727d877") >= 20)
			{
				self character_unlock::function_c8beca5e(#"spectre_unlock", #"hash_27023afb3f91aba5", 1);
			}
		}
	}
}

/*
	Name: function_27709af9
	Namespace: character_unlock_spectre
	Checksum: 0x8E559929
	Offset: 0x270
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_27709af9()
{
	if(self character_unlock::function_f0406288(#"spectre_unlock"))
	{
		if(self stats::get_stat_global(#"hash_41f134c3e727d877") >= 20)
		{
			self character_unlock::function_c8beca5e(#"spectre_unlock", #"hash_27023afb3f91aba5", 1);
		}
	}
}

