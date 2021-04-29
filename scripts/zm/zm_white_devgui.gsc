// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10956a741a7e186e;
#using script_52c6c2d1a2ef1b46;
#using script_62a0cb1167067152;
#using script_724752ab26bff81b;
#using script_ab862743b3070a;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\zm_devgui.gsc;

#namespace namespace_db259423;

/*
	Name: init
	Namespace: namespace_db259423
	Checksum: 0x3BE8B162
	Offset: 0xA0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function init()
{
	/#
		level thread devgui();
	#/
}

/*
	Name: function_3552f301
	Namespace: namespace_db259423
	Checksum: 0x4BF26068
	Offset: 0xC8
	Size: 0x1C
	Parameters: 0
	Flags: Private
*/
private function function_3552f301()
{
	/#
		namespace_b9fd696c::function_6af32608();
	#/
}

/*
	Name: function_2639784
	Namespace: namespace_db259423
	Checksum: 0xF8F7F3EF
	Offset: 0xF0
	Size: 0x6C
	Parameters: 0
	Flags: Private
*/
private function function_2639784()
{
	/#
		if(!level flag::get(""))
		{
			zm_devgui::zombie_devgui_open_sesame();
		}
		level.old_dog_spawn = &namespace_c402654::function_62db7b1c;
		namespace_5c160465::function_6acd363d(1);
	#/
}

/*
	Name: function_3db5079
	Namespace: namespace_db259423
	Checksum: 0x96D0A16C
	Offset: 0x168
	Size: 0x108
	Parameters: 0
	Flags: Private
*/
private function function_3db5079()
{
	/#
		if(!level flag::get(#"hash_40856b65dff0f6eb"))
		{
			function_2639784();
		}
		foreach(var_ab611263 in level.var_d4a0b9f4)
		{
			if(var_ab611263[#"hash_5ec516364540f76a"] == #"active")
			{
				var_ab611263[#"gas_cloud"] namespace_5c160465::function_27a8604b(var_ab611263[#"group"]);
			}
		}
	#/
}

/*
	Name: devgui
	Namespace: namespace_db259423
	Checksum: 0x31B3069F
	Offset: 0x278
	Size: 0x470
	Parameters: 0
	Flags: Private
*/
private function devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			str_command = getdvarstring(#"hash_5c54f97f1540dbad", "");
			switch(str_command)
			{
				case "perk1":
				{
					function_3552f301();
					break;
				}
				case "hash_247b9e41efaa41a9":
				{
					function_2639784();
					break;
				}
				case "hash_247b9b41efaa3c90":
				{
					function_3db5079();
					break;
				}
				case "hash_247b9c41efaa3e43":
				{
					function_3db5079();
					namespace_a01a2431::function_256cc56e();
					break;
				}
				case "hash_429bdbdfaae45ca7":
				{
					iprintlnbold("" + level.var_276bd207[0] + level.var_276bd207[1] + level.var_276bd207[2] + level.var_276bd207[3]);
					break;
				}
				case "hash_67d502f654392103":
				{
					e_player = getplayers()[0];
					namespace_6747c550::function_7df6bb60("", 0, e_player);
					namespace_6747c550::function_7df6bb60("", 2, e_player);
					e_player.var_f7694097 = 0;
					break;
				}
				case "hash_67d510f6543938cd":
				{
					e_player = getplayers()[0];
					namespace_6747c550::function_7df6bb60("", 1, e_player);
					namespace_6747c550::function_7df6bb60("", 2, e_player);
					e_player.var_f7694097 = 1;
					break;
				}
				case "hash_67d50ff65439371a":
				{
					e_player = getplayers()[0];
					namespace_6747c550::function_7df6bb60("", 2, e_player);
					namespace_6747c550::function_7df6bb60("", 2, e_player);
					e_player.var_f7694097 = 2;
					break;
				}
				case "hash_67d50ef654393567":
				{
					e_player = getplayers()[0];
					namespace_6747c550::function_7df6bb60("", 3, e_player);
					namespace_6747c550::function_7df6bb60("", 2, e_player);
					e_player.var_f7694097 = 3;
					break;
				}
			}
			setdvar(#"hash_5c54f97f1540dbad", "");
		}
	#/
}

