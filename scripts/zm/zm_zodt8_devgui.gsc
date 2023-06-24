// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using script_311952573639271c;
#using script_733222d63341ad58;
#using script_7893277eec698972;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm\zm_zodt8.gsc;
#using scripts\zm\zm_zodt8_pap_quest.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace zm_zodt8_devgui;

/*
	Name: function_5d346946
	Namespace: zm_zodt8_devgui
	Checksum: 0x9F8F583F
	Offset: 0xC0
	Size: 0x1C6
	Parameters: 0
	Flags: None
*/
function function_5d346946()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_78c32556);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		level.var_b9714a5d = &function_51855e65;
	#/
}

/*
	Name: function_78c32556
	Namespace: zm_zodt8_devgui
	Checksum: 0xA098CFF2
	Offset: 0x290
	Size: 0x3F2
	Parameters: 1
	Flags: None
*/
function function_78c32556(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_50d92ca3c6c7c2a8":
			{
				level thread function_4110a06f();
				return true;
			}
			case "gear_up":
			{
				level thread namespace_74905749::gear_up();
				return true;
			}
			case "hash_672373a99384fb53":
			{
				level thread function_853d8116();
				return true;
			}
			case "hash_5634a634a8ffec47":
			{
				level thread function_1d9dddd0();
				return true;
			}
			case "move_pap":
			{
				level thread function_10dafedb();
				return true;
			}
			case "hash_74823c0e0a29545b":
			{
				give_flare("");
				return true;
			}
			case "hash_130280144168a5e7":
			{
				give_flare("");
				return true;
			}
			case "hash_2972e55f40fe8050":
			{
				give_flare("");
				return true;
			}
			case "hash_59b568ce3fe548b6":
			{
				level thread function_649d5f75();
				return true;
			}
			case "hash_be17a68845640e4":
			{
				level thread function_a368f5ed("");
				return true;
			}
			case "hash_5c17aed53086a4e8":
			{
				level thread function_a368f5ed("");
				return true;
			}
			case "hash_2474089e18afbc3":
			{
				level thread function_a368f5ed("");
				return true;
			}
			case "hash_515fa2d180024bd3":
			{
				level thread function_a368f5ed("");
				return true;
			}
			case "hash_687e53bfcb79ec3b":
			{
				if(isdefined(level.chests) && isdefined(level.chest_index) && isdefined(level.chests[level.chest_index].zbarrier))
				{
					level.chests[level.chest_index].zbarrier thread namespace_b45e3f05::function_8baed388();
				}
				break;
			}
			case "hide_chests":
			{
				function_7edbb38();
				if(level.chest_index != -1)
				{
					chest = level.chests[level.chest_index];
					chest zm_magicbox::hide_chest(0);
				}
				break;
			}
			case "show_chests":
			{
				function_7edbb38();
				if(level.chest_index != -1)
				{
					chest = level.chests[level.chest_index];
					chest zm_magicbox::show_chest();
				}
				break;
			}
		}
	#/
}

/*
	Name: function_7edbb38
	Namespace: zm_zodt8_devgui
	Checksum: 0xA3DA8976
	Offset: 0x690
	Size: 0x30
	Parameters: 0
	Flags: None
*/
function function_7edbb38()
{
	/#
		while(level flag::get(""))
		{
			waitframe(1);
		}
	#/
}

/*
	Name: function_4110a06f
	Namespace: zm_zodt8_devgui
	Checksum: 0x6F8E0301
	Offset: 0x6C8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_4110a06f()
{
	/#
		zm_devgui::zombie_devgui_open_sesame();
		level thread zodt8_pap_quest::function_765118cf();
		level flag::set(#"open_lore_room");
		level thread zm_zodt8::change_water_height_fore(1);
		level thread zm_zodt8::change_water_height_aft(1);
	#/
}

/*
	Name: function_10dafedb
	Namespace: zm_zodt8_devgui
	Checksum: 0xEAAEE5C5
	Offset: 0x758
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_10dafedb()
{
	/#
		if(!level flag::get(""))
		{
			level.s_pap_quest.var_4ee2e2ab = 0;
			level flag::set("");
			return;
		}
		level zodt8_pap_quest::function_306b4f35();
	#/
}

/*
	Name: function_1d9dddd0
	Namespace: zm_zodt8_devgui
	Checksum: 0xE59167EB
	Offset: 0x7D0
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_1d9dddd0()
{
	/#
		if(level flag::get(""))
		{
			if(level.e_clip_water_aft clientfield::get("") != 0)
			{
				iprintlnbold("");
			}
			else
			{
				zm_zodt8::change_water_height_aft(0);
			}
		}
		else
		{
			if(level.e_clip_water_aft clientfield::get("") != 0)
			{
				iprintlnbold("");
			}
			else
			{
				zm_zodt8::change_water_height_aft(1);
			}
		}
	#/
}

/*
	Name: function_853d8116
	Namespace: zm_zodt8_devgui
	Checksum: 0x267EDDA8
	Offset: 0x8B8
	Size: 0xDC
	Parameters: 0
	Flags: None
*/
function function_853d8116()
{
	/#
		if(level flag::get(""))
		{
			if(level.e_clip_water_fore clientfield::get("") != 0)
			{
				iprintlnbold("");
			}
			else
			{
				zm_zodt8::change_water_height_fore(0);
			}
		}
		else
		{
			if(level.e_clip_water_fore clientfield::get("") != 0)
			{
				iprintlnbold("");
			}
			else
			{
				zm_zodt8::change_water_height_fore(1);
			}
		}
	#/
}

/*
	Name: function_649d5f75
	Namespace: zm_zodt8_devgui
	Checksum: 0x12987A31
	Offset: 0x9A0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_649d5f75()
{
	/#
		a_e_players = getplayers();
		namespace_4a807bff::function_8498110e(a_e_players[0]);
	#/
}

/*
	Name: function_a368f5ed
	Namespace: zm_zodt8_devgui
	Checksum: 0xAA07871B
	Offset: 0x9F0
	Size: 0x13E
	Parameters: 1
	Flags: None
*/
function function_a368f5ed(var_99416cd7)
{
	/#
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			switch(var_99416cd7)
			{
				case "decay":
				{
					namespace_4a807bff::function_ca37502d(e_player);
					break;
				}
				case "plasma":
				{
					namespace_4a807bff::function_1b182e8c(e_player);
					break;
				}
				case "purity":
				{
					namespace_4a807bff::function_b9b7b8c(e_player);
					break;
				}
				case "radiance":
				{
					namespace_4a807bff::function_b3695700(e_player);
					break;
				}
			}
		}
	#/
}

/*
	Name: give_flare
	Namespace: zm_zodt8_devgui
	Checksum: 0xA011337D
	Offset: 0xB38
	Size: 0x12E
	Parameters: 1
	Flags: None
*/
function give_flare(str_color)
{
	/#
		a_e_players = getplayers();
		foreach(e_player in a_e_players)
		{
			switch(str_color)
			{
				case "red":
				{
					namespace_b45e3f05::give_flare("");
					break;
				}
				case "green":
				{
					namespace_b45e3f05::give_flare("");
					break;
				}
				case "blue":
				{
					namespace_b45e3f05::give_flare("");
					break;
				}
			}
		}
	#/
}

/*
	Name: function_51855e65
	Namespace: zm_zodt8_devgui
	Checksum: 0xC0BE3DD6
	Offset: 0xC70
	Size: 0x3D4
	Parameters: 1
	Flags: Private
*/
function private function_51855e65(round_number)
{
	/#
		var_efac84b3 = array(0, 500, 1000, 1000, 1400, 4000, 5000, 5500, 5500, 5500, 8000, 8000, 8000, 8000, 9000, 9000, 9000, 9500, 9500, 9500, 9500, 11000, 11000, 11000, 11000, 13000, 13000, 13000, 13000, 14000);
		var_ef0a371f = round_number - 1;
		/#
			assert(var_ef0a371f >= 0 && var_ef0a371f < 30);
		#/
		foreach(player in getplayers())
		{
			player zm_score::function_c1f146ff(var_efac84b3[var_ef0a371f]);
		}
		if(round_number >= 7)
		{
			level flag::set("");
			level flag::set(#"hash_3e80d503318a5674");
		}
		if(round_number >= 8)
		{
			/#
				assert(isdefined(level.var_4fe2f84d[#"zblueprint_shield_dual_wield"]));
			#/
			foreach(trigger in level.var_4fe2f84d[#"zblueprint_shield_dual_wield"])
			{
				trigger.crafted = 1;
				trigger.blueprint = trigger.craftfoundry;
				if(isdefined(trigger.model))
				{
					trigger.model notsolid();
					trigger.model show();
				}
			}
			foreach(player in getplayers())
			{
				player zm_devgui::zombie_devgui_weapon_give("");
			}
		}
		if(round_number >= 9)
		{
			zm_trial_util::function_3e209fb6();
		}
		if(round_number >= 13)
		{
			level.s_pap_quest.var_4ee2e2ab = 0;
			level flag::set("");
		}
		if(round_number >= 24)
		{
			zm_trial_util::function_9c71b46f();
		}
	#/
}

