// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_287e05a2;

/*
	Name: function_89f2df9
	Namespace: namespace_287e05a2
	Checksum: 0xE13B5CD9
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_73d9e3978f860555", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_287e05a2
	Checksum: 0xF5343F06
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_69bf786a279d4ca6", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_287e05a2
	Checksum: 0xCF9C488C
	Offset: 0x140
	Size: 0x248
	Parameters: 8
	Flags: Private
*/
function private function_d1de6a85(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef, var_11ec7b7b, var_cac66d30)
{
	if(str_zone1 == #"hash_13aa327bb61b59de")
	{
		if(str_zone2 == #"hash_3c64caae70d6af41")
		{
			level.var_da1e5199 = array(#"zone_river_upper", #"zone_river_lower", #"zone_serpent_pass_upper", #"zone_serpent_pass_center", #"zone_serpent_pass_lower", #"zone_serpent_pass_bridge", #"zone_drakaina_arena", #"zone_cliff_tombs_upper", #"zone_cliff_tombs_forge", #"zone_cliff_tombs_center", #"zone_cliff_tombs_lower", #"zone_cliff_tombs_bridge", #"zone_ww_quest_death", #"zone_ww_quest_air");
		}
	}
	else
	{
		level.var_da1e5199 = array(str_zone1, str_zone2, var_588808b1, var_91e2fb66, var_84245fe9, var_a7a5a6ef, var_11ec7b7b, var_cac66d30);
		arrayremovevalue(level.var_da1e5199, undefined);
	}
	foreach(player in getplayers())
	{
		player thread function_c465c67f();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_287e05a2
	Checksum: 0xA7C454C7
	Offset: 0x390
	Size: 0x1A2
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	if(!round_reset)
	{
		var_696c3b4 = [];
		foreach(player in getplayers())
		{
			if(!player.b_in_zone)
			{
				if(!isdefined(var_696c3b4))
				{
					var_696c3b4 = [];
				}
				else if(!isarray(var_696c3b4))
				{
					var_696c3b4 = array(var_696c3b4);
				}
				var_696c3b4[var_696c3b4.size] = player;
			}
		}
		if(var_696c3b4.size)
		{
			zm_trial::fail(#"hash_10a895033b20c705", var_696c3b4);
		}
	}
	foreach(player in getplayers())
	{
		player.b_in_zone = undefined;
		player namespace_b22c99a5::function_f3aacffb();
	}
	level.var_da1e5199 = undefined;
}

/*
	Name: function_c465c67f
	Namespace: namespace_287e05a2
	Checksum: 0x565F8B76
	Offset: 0x540
	Size: 0x110
	Parameters: 0
	Flags: Private
*/
function private function_c465c67f()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.b_in_zone = 0;
	self namespace_b22c99a5::function_63060af4(0);
	while(true)
	{
		if(!self.b_in_zone && self zm_zonemgr::is_player_in_zone(level.var_da1e5199))
		{
			self namespace_b22c99a5::function_63060af4(1);
			self.b_in_zone = 1;
		}
		else if(self.b_in_zone && !self zm_zonemgr::is_player_in_zone(level.var_da1e5199))
		{
			self namespace_b22c99a5::function_63060af4(0);
			self.b_in_zone = 0;
		}
		waitframe(1);
	}
}

