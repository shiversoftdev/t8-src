// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock_outrider;

/*
	Name: __init__system__
	Namespace: character_unlock_outrider
	Checksum: 0x5059FCA9
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_outrider", &__init__, undefined, #"character_unlock_outrider_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_outrider
	Checksum: 0x2F57908D
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"outrider_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_outrider
	Checksum: 0x3F8E31F7
	Offset: 0x120
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_7a9bdd3ee0ae95af", &function_c915e2a7);
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_outrider
	Checksum: 0x4EA6B22D
	Offset: 0x1A0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"hash_447ad6b75cf77f8b")
	{
		if(self character_unlock::function_f0406288(#"outrider_unlock"))
		{
			if(self stats::get_stat_global(#"hash_35020c395a89befb") >= 25)
			{
				self character_unlock::function_c8beca5e(#"outrider_unlock", #"hash_28966e441535b733", 1);
			}
		}
	}
}

/*
	Name: function_c915e2a7
	Namespace: character_unlock_outrider
	Checksum: 0xE09047C6
	Offset: 0x270
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_c915e2a7()
{
	if(self character_unlock::function_f0406288(#"outrider_unlock"))
	{
		if(self stats::get_stat_global(#"hash_35020c395a89befb") >= 25)
		{
			self character_unlock::function_c8beca5e(#"outrider_unlock", #"hash_28966e441535b733", 1);
		}
	}
}

