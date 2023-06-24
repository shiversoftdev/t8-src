// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\trials\zm_trial_disable_bgbs.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace bgb_pack;

/*
	Name: __init__system__
	Namespace: bgb_pack
	Checksum: 0x17F82F1D
	Offset: 0x260
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"bgb_pack", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: bgb_pack
	Checksum: 0xEB5A10EC
	Offset: 0x2B0
	Size: 0x216
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	/#
		function_72ffe91();
	#/
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::function_a8bbc967("zmhud.bgb_carousel.global_cooldown", 1, 5, "float", 0);
	for(i = 0; i < 4; i++)
	{
		clientfield::function_a8bbc967(("zmhud.bgb_carousel." + i) + ".state", 1, 2, "int", 0);
		clientfield::function_a8bbc967(("zmhud.bgb_carousel." + i) + ".gum_idx", 1, 7, "int", 0);
		clientfield::function_a8bbc967(("zmhud.bgb_carousel." + i) + ".cooldown_perc", 1, 5, "float", 0);
		clientfield::function_a8bbc967(("zmhud.bgb_carousel." + i) + ".lockdown", 1, 1, "float", 0);
		clientfield::function_a8bbc967(("zmhud.bgb_carousel." + i) + ".unavailable", 1, 1, "float", 0);
	}
	/#
		if(!sessionmodeisonlinegame())
		{
			level.var_4af38aa3 = 1;
		}
	#/
}

/*
	Name: __main__
	Namespace: bgb_pack
	Checksum: 0xF8C67D53
	Offset: 0x4D0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private __main__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	/#
		level thread setup_devgui();
	#/
}

/*
	Name: on_player_connect
	Namespace: bgb_pack
	Checksum: 0xA5900AB5
	Offset: 0x520
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_connect()
{
	self.var_2d8082a0 = [];
	for(x = 0; x < 4; x++)
	{
		self.var_2d8082a0[x] = 0;
	}
}

/*
	Name: on_player_spawned
	Namespace: bgb_pack
	Checksum: 0xC8580541
	Offset: 0x570
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_spawned()
{
	self endon(#"disconnect");
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	if(isbot(self))
	{
		return;
	}
	level flagsys::wait_till("start_zombie_round_logic");
	waitframe(1);
	self thread function_efe33e13();
	self thread function_dc818f99();
	self function_4650bb90(1);
	self function_2ca4f95b(1);
	self function_b18274fd();
}

/*
	Name: function_9d4db403
	Namespace: bgb_pack
	Checksum: 0xDEBE80E0
	Offset: 0x660
	Size: 0xB6
	Parameters: 3
	Flags: Linked
*/
function function_9d4db403(name, var_81f8ab0f, var_f1d1c3e6)
{
	/#
		assert(isdefined(level.bgb[name]), ("" + name) + "");
	#/
	/#
		assert(isdefined(var_81f8ab0f), "");
	#/
	level.bgb[name].var_81f8ab0f = var_81f8ab0f;
	level.bgb[name].var_f1d1c3e6 = var_f1d1c3e6;
}

/*
	Name: function_430d063b
	Namespace: bgb_pack
	Checksum: 0xBBEB70A9
	Offset: 0x720
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_430d063b(name)
{
	/#
		assert(isdefined(level.bgb[name]), ("" + name) + "");
	#/
	level.bgb[name].var_58860b3 = 1;
}

/*
	Name: function_a1194b9a
	Namespace: bgb_pack
	Checksum: 0xF342A385
	Offset: 0x798
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_a1194b9a(name)
{
	/#
		assert(isdefined(level.bgb[name]), ("" + name) + "");
	#/
	level.bgb[name].var_8fd0fb47 = 1;
}

/*
	Name: function_4de6c08a
	Namespace: bgb_pack
	Checksum: 0x8DF2F08D
	Offset: 0x810
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_4de6c08a(name)
{
	/#
		assert(isdefined(level.bgb[name]), ("" + name) + "");
	#/
	level.bgb[name].var_8b1ba43c = 1;
}

/*
	Name: function_dc818f99
	Namespace: bgb_pack
	Checksum: 0x145F4E8C
	Offset: 0x888
	Size: 0x3BE
	Parameters: 0
	Flags: Linked
*/
function function_dc818f99()
{
	self notify(#"hash_67100af32a422470");
	self endon(#"hash_67100af32a422470", #"disconnect");
	self.var_bd0d5874 = 0;
	self.var_8ef176f3 = 0;
	self.var_9302665 = 0;
	while(isdefined(self))
	{
		if(function_2ee076a7())
		{
			if(self meleebuttonpressed() || self sprintbuttonpressed() || self isinmovemode("ufo", "noclip") || level flagsys::get(#"menu_open"))
			{
				self.var_7c6f53f9 = 1;
				waitframe(1);
				continue;
			}
			else if(isdefined(self.var_7c6f53f9) && self.var_7c6f53f9)
			{
				self.var_7c6f53f9 = undefined;
				waitframe(1);
			}
		}
		if(self scene::is_igc_active())
		{
			waitframe(1);
			continue;
		}
		if(zm_trial_disable_bgbs::is_active() && (self actionslotonebuttonpressed() || self actionslotfourbuttonpressed() || self actionslottwobuttonpressed() || self actionslotthreebuttonpressed()))
		{
			self zm_trial_util::function_97444b02();
			do
			{
				waitframe(1);
			}
			while(self actionslotonebuttonpressed() || self actionslotfourbuttonpressed() || self actionslottwobuttonpressed() || self actionslotthreebuttonpressed());
			continue;
		}
		n_index = 0;
		if(self actionslotonebuttonpressed() && !self function_6f7d5230(n_index))
		{
			self function_ea17bc2a(n_index);
		}
		n_index = 1;
		if(self actionslotfourbuttonpressed() && !self function_6f7d5230(n_index))
		{
			self function_ea17bc2a(n_index);
		}
		n_index = 2;
		if(self actionslottwobuttonpressed() && !self function_6f7d5230(n_index))
		{
			self function_ea17bc2a(n_index);
		}
		n_index = 3;
		if(self actionslotthreebuttonpressed() && !self function_6f7d5230(n_index))
		{
			self function_ea17bc2a(n_index);
		}
		waitframe(1);
	}
}

/*
	Name: function_ea17bc2a
	Namespace: bgb_pack
	Checksum: 0x3C672C0
	Offset: 0xC50
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_ea17bc2a(n_index)
{
	if(self bgb::get_bgb_available(self.bgb_pack[n_index]))
	{
		self function_763a8a50(n_index);
	}
	else
	{
		self function_23b7cdd8(n_index);
	}
}

/*
	Name: function_763a8a50
	Namespace: bgb_pack
	Checksum: 0xF6B76C77
	Offset: 0xCB8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_763a8a50(n_index)
{
	if(self function_4f8aa77a(n_index))
	{
		self thread function_23b7cdd8(n_index);
	}
	else
	{
		self activate_elixir(n_index);
	}
}

/*
	Name: activate_elixir
	Namespace: bgb_pack
	Checksum: 0x28561D69
	Offset: 0xD18
	Size: 0x310
	Parameters: 1
	Flags: Linked
*/
function activate_elixir(n_index)
{
	self endon(#"disconnect");
	level endon(#"end_game");
	var_fabc88ee = 0;
	if(isdefined(level.var_3c8ad64b) && level.var_3c8ad64b != n_index)
	{
		return var_fabc88ee;
	}
	if(self function_834d35e(n_index) == 0 || (isdefined(level.var_4af38aa3) && level.var_4af38aa3 && self function_834d35e(n_index) == 3) && !self zm_utility::is_drinking() && !self laststand::player_is_in_laststand())
	{
		var_fabc88ee = 0;
		str_bgb = self.bgb_pack[n_index];
		if(!isdefined(str_bgb) || str_bgb == "")
		{
			self thread function_23b7cdd8(n_index);
			return 0;
		}
		if(!self bgb::function_e98aa964(0, str_bgb))
		{
			self thread function_23b7cdd8(n_index);
			return 0;
		}
		self function_91586d27();
		if(level.bgb[str_bgb].limit_type == "activated")
		{
			if(isdefined(level.bgb[str_bgb].var_4a9b0cdc) && level.bgb[str_bgb].var_4a9b0cdc || self bgb::function_e98aa964(1, str_bgb))
			{
				var_fabc88ee = self function_5d618bb4(str_bgb, n_index);
				if(var_fabc88ee)
				{
					self notify(#"hash_27b238d082f65849", str_bgb);
					self bgb::activation_start();
					self thread bgb::run_activation_func(str_bgb);
				}
			}
			else
			{
				self thread function_23b7cdd8(n_index);
				var_fabc88ee = 0;
			}
		}
		else
		{
			self function_5d618bb4(str_bgb, n_index);
		}
		self.var_8ef176f3 = 0;
		if(var_fabc88ee)
		{
			self notify(#"bgb_activation", str_bgb);
		}
	}
	else
	{
		self thread function_23b7cdd8(n_index);
	}
	return var_fabc88ee;
}

/*
	Name: function_5d618bb4
	Namespace: bgb_pack
	Checksum: 0x941B670A
	Offset: 0x1030
	Size: 0x130
	Parameters: 2
	Flags: Linked
*/
function function_5d618bb4(str_bgb, n_index)
{
	b_succeed = self bgb::bgb_gumball_anim(str_bgb);
	b_succeed = isdefined(b_succeed) && b_succeed;
	if(b_succeed)
	{
		if(isdefined(self.bgb_pack[n_index]) && isdefined(level.bgb[self.bgb_pack[n_index]]) && (!(isdefined(level.bgb[self.bgb_pack[n_index]].var_8fd0fb47) && level.bgb[self.bgb_pack[n_index]].var_8fd0fb47)))
		{
			self.var_22fbe1cc++;
		}
		self function_b2308cd(n_index, 1);
		self bgb::sub_consumable_bgb(str_bgb);
		self thread function_fba5f0e1(n_index);
	}
	return b_succeed;
}

/*
	Name: function_23b7cdd8
	Namespace: bgb_pack
	Checksum: 0x4CAF9BC4
	Offset: 0x1168
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function function_23b7cdd8(n_index)
{
	self endon(#"death");
	if(!(isdefined(self.var_7148f2c) && self.var_7148f2c))
	{
		self.var_7148f2c = 1;
		self playlocalsound(#"hash_678b4eee9797e94f");
		switch(n_index)
		{
			case 0:
			{
				while(self actionslotonebuttonpressed())
				{
					waitframe(1);
				}
				break;
			}
			case 1:
			{
				while(self actionslotfourbuttonpressed())
				{
					waitframe(1);
				}
				break;
			}
			case 2:
			{
				while(self actionslottwobuttonpressed())
				{
					waitframe(1);
				}
				break;
			}
			case 3:
			{
				while(self actionslotthreebuttonpressed())
				{
					waitframe(1);
				}
				break;
			}
		}
		self.var_7148f2c = 0;
	}
}

/*
	Name: function_579411ff
	Namespace: bgb_pack
	Checksum: 0x7BAC7C38
	Offset: 0x12D0
	Size: 0x13E
	Parameters: 0
	Flags: None
*/
function function_579411ff()
{
	self disableweaponcycling();
	self allowjump(0);
	str_stance = self getstance();
	switch(str_stance)
	{
		case "crouch":
		{
			self allowstand(0);
			self allowprone(0);
			break;
		}
		case "prone":
		{
			self allowstand(0);
			self allowcrouch(0);
			break;
		}
		default:
		{
			self allowcrouch(0);
			self allowprone(0);
			break;
		}
	}
	self.var_9302665 = 1;
}

/*
	Name: function_91586d27
	Namespace: bgb_pack
	Checksum: 0xF4645643
	Offset: 0x1418
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_91586d27()
{
	self enableweaponcycling();
	self allowjump(1);
	self allowstand(1);
	self allowcrouch(1);
	self allowprone(1);
	self.var_9302665 = 0;
}

/*
	Name: function_c47c57e8
	Namespace: bgb_pack
	Checksum: 0x88CAD408
	Offset: 0x14A8
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function function_c47c57e8()
{
	self notify(#"hash_25f0b773a3164732");
	self endon(#"hash_25f0b773a3164732", #"disconnect");
	for(;;)
	{
		if(!self secondaryoffhandbuttonpressed())
		{
			wait(0.05);
			continue;
		}
		self.var_8ef176f3 = 1;
		for(;;)
		{
			wait(0.05);
			if(!self secondaryoffhandbuttonpressed())
			{
				break;
			}
		}
		self.var_8ef176f3 = 0;
	}
}

/*
	Name: function_619ee0f4
	Namespace: bgb_pack
	Checksum: 0x4BA5230D
	Offset: 0x1558
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function function_619ee0f4()
{
	self notify(#"hash_2ee12d1cd927db0c");
	self endon(#"hash_2ee12d1cd927db0c", #"disconnect");
	self.zmb_weapons_mastery_lmg = 0;
	for(;;)
	{
		if(!self secondaryoffhandbuttonpressed())
		{
			wait(0.05);
			continue;
		}
		self.zmb_weapons_mastery_lmg = 1;
		for(;;)
		{
			wait(0.05);
			if(!self secondaryoffhandbuttonpressed())
			{
				break;
			}
		}
		self.zmb_weapons_mastery_lmg = 0;
	}
}

/*
	Name: function_261a46f4
	Namespace: bgb_pack
	Checksum: 0xC7608CAF
	Offset: 0x1610
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function function_261a46f4()
{
	self notify(#"hash_5f9bde10649db4f9");
	self endon(#"hash_5f9bde10649db4f9", #"disconnect");
	self.var_6e1ea617 = 0;
	for(;;)
	{
		if(!self actionslotfourbuttonpressed())
		{
			wait(0.05);
			continue;
		}
		self.var_6e1ea617 = 1;
		for(;;)
		{
			wait(0.05);
			if(!self actionslotfourbuttonpressed())
			{
				break;
			}
		}
		self.var_6e1ea617 = 0;
	}
}

/*
	Name: function_efe33e13
	Namespace: bgb_pack
	Checksum: 0x6182545A
	Offset: 0x16C8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_efe33e13()
{
	self notify(#"hash_5d9f5eee2722843a");
	self endon(#"hash_5d9f5eee2722843a", #"disconnect");
	self.var_22fbe1cc = 0;
	for(;;)
	{
		level waittill(#"end_of_round");
		self.var_22fbe1cc = 0;
		if(!zm_trial_disable_bgbs::is_active())
		{
			self function_f2173c97(0);
		}
	}
}

/*
	Name: function_fba5f0e1
	Namespace: bgb_pack
	Checksum: 0x19234C0D
	Offset: 0x1768
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_fba5f0e1(n_index)
{
	self thread global_cooldown(n_index);
	self thread slot_cooldown(n_index);
}

/*
	Name: global_cooldown
	Namespace: bgb_pack
	Checksum: 0xFA9A05DC
	Offset: 0x17B0
	Size: 0x24E
	Parameters: 1
	Flags: Linked
*/
function global_cooldown(n_index)
{
	self notify("98904273b43061");
	self endon("98904273b43061");
	self endon(#"disconnect");
	self.var_bd0d5874 = 1;
	self function_a1f97e79(1, n_index);
	n_cooldown = 30;
	if(self hasperk(#"specialty_mod_cooldown"))
	{
		n_cooldown = n_cooldown * 0.9;
	}
	switch(zm_custom::function_901b751c(#"zmelixirscooldown"))
	{
		case 1:
		default:
		{
			break;
		}
		case 2:
		{
			n_cooldown = floor(n_cooldown / 2);
			break;
		}
		case 0:
		{
			n_cooldown = n_cooldown * 2;
			break;
		}
	}
	/#
		if(isdefined(level.var_7c3d4959) && level.var_7c3d4959)
		{
			n_cooldown = function_b29fc421();
		}
	#/
	result = undefined;
	result = self waittilltimeout(n_cooldown, #"hash_738988561a113fac");
	/#
		if(result._notify === "")
		{
			var_10b7b97a = 1;
		}
	#/
	self function_a1f97e79(0, undefined, var_10b7b97a);
	if(self.var_22fbe1cc >= 4)
	{
		self function_f2173c97(1);
	}
	else
	{
		self playlocalsound(#"hash_2a9d100a5cbc7dbe");
	}
	self.var_bd0d5874 = 0;
}

/*
	Name: function_6f7d5230
	Namespace: bgb_pack
	Checksum: 0xA0E1D1E2
	Offset: 0x1A08
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_6f7d5230(n_index)
{
	if(self.var_bd0d5874 && (isdefined(self.bgb_pack[n_index]) && isdefined(level.bgb[self.bgb_pack[n_index]]) && (!(isdefined(level.bgb[self.bgb_pack[n_index]].var_8b1ba43c) && level.bgb[self.bgb_pack[n_index]].var_8b1ba43c))))
	{
		self thread function_23b7cdd8(n_index);
		return true;
	}
	return false;
}

/*
	Name: slot_cooldown
	Namespace: bgb_pack
	Checksum: 0x32B87F8B
	Offset: 0x1AD0
	Size: 0x5DC
	Parameters: 1
	Flags: Linked
*/
function slot_cooldown(n_index)
{
	self endon(#"disconnect");
	var_ce5ed2e9 = self.bgb_pack[n_index];
	self waittill("bgb_update_take_" + var_ce5ed2e9);
	if(!self bgb::get_bgb_available(self.bgb_pack[n_index]))
	{
		if(!isdefined(self.var_82971641) || self.var_82971641.size == 0 || !isdefined(self.var_2b74c8fe) || self.var_2b74c8fe.size == 0)
		{
			self function_b2308cd(n_index, 3);
			return;
		}
		self function_b2308cd(n_index, 2);
	}
	else
	{
		self function_b2308cd(n_index, 2);
	}
	self function_69b5ca2a(n_index, 1);
	function_1d5d39b0(n_index, 0);
	if(zm_utility::is_standard())
	{
		n_cooldown = 180;
	}
	else
	{
		n_rarity = level.bgb[var_ce5ed2e9].rarity;
		switch(n_rarity)
		{
			case 2:
			{
				n_cooldown = 30;
				break;
			}
			case 3:
			{
				n_cooldown = 30;
				break;
			}
			case 5:
			{
				n_cooldown = 30;
				break;
			}
			case 4:
			{
				n_cooldown = 30;
				break;
			}
			case 6:
			{
				n_cooldown = 30;
				break;
			}
			default:
			{
				n_round = zm_round_logic::get_round_number();
				if(n_round >= 21)
				{
					n_cooldown = 1200;
				}
				else
				{
					if(n_round >= 11)
					{
						n_cooldown = 900;
					}
					else
					{
						if(n_round >= 6)
						{
							n_cooldown = 600;
						}
						else
						{
							n_cooldown = 300;
						}
					}
				}
				break;
			}
		}
	}
	switch(zm_custom::function_901b751c(#"zmelixirscooldown"))
	{
		case 1:
		default:
		{
			break;
		}
		case 2:
		{
			n_cooldown = floor(n_cooldown / 2);
			break;
		}
		case 0:
		{
			n_cooldown = n_cooldown * 2;
			break;
		}
	}
	if(self hasperk(#"specialty_mod_cooldown"))
	{
		n_cooldown = n_cooldown * 0.9;
	}
	if(isdefined(level.bgb[var_ce5ed2e9].var_81f8ab0f))
	{
		n_cooldown = level.bgb[var_ce5ed2e9].var_81f8ab0f;
	}
	/#
		if(isdefined(level.var_7c3d4959) && level.var_7c3d4959)
		{
			n_cooldown = 10;
		}
	#/
	self thread function_7dd2a9c9(n_index, n_cooldown);
	wait(0.05);
	result = undefined;
	result = self waittilltimeout(n_cooldown, #"hash_738988561a113fac");
	/#
		if(result._notify === "")
		{
			var_10b7b97a = 1;
		}
	#/
	if(self.var_2d8082a0[n_index] <= 0 || (isdefined(var_10b7b97a) && var_10b7b97a))
	{
		self playsoundtoplayer(#"hash_78bd6c84a567b714", self);
		self notify("end_slot_cooldown" + n_index);
		self function_1d5d39b0(n_index, 1);
		self function_b2308cd(n_index, 0);
		if(!self bgb::get_bgb_available(self.bgb_pack[n_index]) && isdefined(self.var_82971641) && self.var_82971641.size && isdefined(self.var_2b74c8fe) && self.var_2b74c8fe.size)
		{
			zm_stats::function_ea5b4947();
			var_b8c2f693 = self function_be89decb();
			self.bgb_pack[n_index] = var_b8c2f693;
			self function_7b91e81c(n_index, level.bgb[var_b8c2f693].item_index);
		}
	}
}

/*
	Name: function_7dd2a9c9
	Namespace: bgb_pack
	Checksum: 0x5E30858A
	Offset: 0x20B8
	Size: 0x162
	Parameters: 2
	Flags: Linked
*/
function function_7dd2a9c9(n_index, n_cooldown)
{
	self notify("end_slot_cooldown" + n_index);
	self endon("end_slot_cooldown" + n_index, #"disconnect", #"hash_738988561a113fac");
	if(n_cooldown > 0)
	{
		n_percentage = 0.01 * (n_cooldown / 20);
		n_step = 1 / (n_cooldown * 20);
		var_729b3c2f = 0;
		n_count = 0;
		while(var_729b3c2f <= 1)
		{
			wait(0.05);
			n_count++;
			var_729b3c2f = var_729b3c2f + n_step;
			var_729b3c2f = math::clamp(var_729b3c2f, 0, 1);
			self.var_2d8082a0[n_index] = n_cooldown - (n_cooldown * var_729b3c2f);
			if(!self.var_bd0d5874)
			{
				self function_1d5d39b0(n_index, var_729b3c2f);
			}
		}
	}
	self.var_2d8082a0[n_index] = 0;
}

/*
	Name: function_d84ec5ee
	Namespace: bgb_pack
	Checksum: 0xD8B570E5
	Offset: 0x2228
	Size: 0x1A4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d84ec5ee(var_707fd977)
{
	self endon(#"disconnect", #"hash_738988561a113fac");
	n_cooldown = 30;
	if(self hasperk(#"specialty_mod_cooldown"))
	{
		n_cooldown = n_cooldown * 0.9;
	}
	/#
		if(isdefined(level.var_7c3d4959) && level.var_7c3d4959)
		{
			n_cooldown = function_b29fc421();
		}
	#/
	if(n_cooldown > 0 && var_707fd977)
	{
		n_percentage = 0.01 * (n_cooldown / 20);
		n_step = 1 / (n_cooldown * 20);
		var_729b3c2f = 0;
		n_count = 0;
		while(var_729b3c2f < 1)
		{
			wait(0.05);
			n_count++;
			var_729b3c2f = var_729b3c2f + n_step;
			var_729b3c2f = math::clamp(var_729b3c2f, 0, 1);
			self function_4650bb90(var_729b3c2f);
		}
		self function_4650bb90(1);
	}
}

/*
	Name: function_b29fc421
	Namespace: bgb_pack
	Checksum: 0x13E00D47
	Offset: 0x23D8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_b29fc421()
{
	if(isdefined(level.var_7c3d4959) && level.var_7c3d4959)
	{
		return 10;
	}
	return 30;
}

/*
	Name: function_b18274fd
	Namespace: bgb_pack
	Checksum: 0x193D2BE4
	Offset: 0x2418
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function function_b18274fd()
{
	/#
		if(!sessionmodeisonlinegame())
		{
			return;
		}
	#/
	for(x = 0; x < 4; x++)
	{
		if(!self bgb::get_bgb_available(self.bgb_pack[x]))
		{
			if(isdefined(self.var_82971641) && self.var_82971641.size && isdefined(self.var_2b74c8fe) && self.var_2b74c8fe.size)
			{
				var_b8c2f693 = self function_be89decb();
				self.bgb_pack[x] = var_b8c2f693;
				self function_7b91e81c(x, level.bgb[var_b8c2f693].item_index);
				continue;
			}
			self function_b2308cd(x, 3);
		}
	}
}

/*
	Name: function_2ca4f95b
	Namespace: bgb_pack
	Checksum: 0xC91D7408
	Offset: 0x2540
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_2ca4f95b(visible)
{
}

/*
	Name: function_7b91e81c
	Namespace: bgb_pack
	Checksum: 0xE7FFFBE9
	Offset: 0x2558
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_7b91e81c(slot_index, item_index)
{
	self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".gum_idx", item_index);
}

/*
	Name: function_1d5d39b0
	Namespace: bgb_pack
	Checksum: 0xE1599600
	Offset: 0x25A0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_1d5d39b0(slot_index, cooldown_perc)
{
	self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".cooldown_perc", cooldown_perc);
}

/*
	Name: function_4650bb90
	Namespace: bgb_pack
	Checksum: 0xF53BCEA2
	Offset: 0x25E8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_4650bb90(cooldown_perc)
{
	self clientfield::set_player_uimodel("zmhud.bgb_carousel.global_cooldown", cooldown_perc);
}

/*
	Name: function_69b5ca2a
	Namespace: bgb_pack
	Checksum: 0x1D1D43DF
	Offset: 0x2620
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_69b5ca2a(slot_index, var_b23960a)
{
	if(isdefined(self.bgb_pack[slot_index]) && isdefined(level.bgb[self.bgb_pack[slot_index]]) && (!(isdefined(level.bgb[self.bgb_pack[slot_index]].var_58860b3) && level.bgb[self.bgb_pack[slot_index]].var_58860b3)))
	{
		self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".lockdown", var_b23960a);
	}
}

/*
	Name: function_4f8aa77a
	Namespace: bgb_pack
	Checksum: 0xF089EDF1
	Offset: 0x26E8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_4f8aa77a(slot_index)
{
	return self clientfield::get_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".lockdown");
}

/*
	Name: function_da912bff
	Namespace: bgb_pack
	Checksum: 0x1946AB41
	Offset: 0x2728
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_da912bff(slot_index, var_b23960a)
{
	if(isdefined(self.bgb_pack[slot_index]) && isdefined(level.bgb[self.bgb_pack[slot_index]]))
	{
		self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".unavailable", var_b23960a);
	}
}

/*
	Name: function_a9ecc0a0
	Namespace: bgb_pack
	Checksum: 0xEDB646DE
	Offset: 0x27A8
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_a9ecc0a0(slot_index)
{
	return self clientfield::get_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".unavailable");
}

/*
	Name: function_b2308cd
	Namespace: bgb_pack
	Checksum: 0x6DCD3E2C
	Offset: 0x27E8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_b2308cd(slot_index, state)
{
	self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".state", state);
}

/*
	Name: function_834d35e
	Namespace: bgb_pack
	Checksum: 0xA0E1BA85
	Offset: 0x2830
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_834d35e(slot_index)
{
	return self clientfield::get_player_uimodel(("zmhud.bgb_carousel." + slot_index) + ".state");
}

/*
	Name: function_a1f97e79
	Namespace: bgb_pack
	Checksum: 0xDBAA5D7F
	Offset: 0x2870
	Size: 0x1FC
	Parameters: 3
	Flags: Linked
*/
function function_a1f97e79(var_707fd977, n_index, var_10b7b97a)
{
	for(x = 0; x < 4; x++)
	{
		if(!self bgb::get_bgb_available(self.bgb_pack[x]))
		{
			continue;
		}
		if(var_707fd977)
		{
			if(self.var_2d8082a0[x] < function_b29fc421() && x != n_index && (isdefined(self.bgb_pack[x]) && isdefined(level.bgb[self.bgb_pack[x]]) && (!(isdefined(level.bgb[self.bgb_pack[x]].var_8b1ba43c) && level.bgb[self.bgb_pack[x]].var_8b1ba43c))))
			{
				self function_b2308cd(x, 2);
				self function_1d5d39b0(x, 0);
			}
			continue;
		}
		if(self.var_2d8082a0[x] <= 0 || (isdefined(var_10b7b97a) && var_10b7b97a) && self function_834d35e(x) == 2)
		{
			self notify("end_slot_cooldown" + x);
			self function_1d5d39b0(x, 1);
			self function_b2308cd(x, 0);
		}
	}
	self thread function_d84ec5ee(var_707fd977);
}

/*
	Name: function_f2173c97
	Namespace: bgb_pack
	Checksum: 0x9DBE2D7C
	Offset: 0x2A78
	Size: 0x156
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f2173c97(var_607319eb)
{
	if(var_607319eb)
	{
		self playsoundtoplayer(#"hash_54adb87d474be3d2", self);
	}
	else
	{
		self playsoundtoplayer(#"hash_686b41e25622cb04", self);
	}
	for(x = 0; x < 4; x++)
	{
		if(isdefined(self.bgb_pack[x]) && isdefined(level.bgb[self.bgb_pack[x]]) && (!(isdefined(level.bgb[self.bgb_pack[x]].var_58860b3) && level.bgb[self.bgb_pack[x]].var_58860b3)) && self function_834d35e(x) != 3)
		{
			self clientfield::set_player_uimodel(("zmhud.bgb_carousel." + x) + ".lockdown", (var_607319eb ? 1 : 0));
		}
	}
}

/*
	Name: function_73d4ab82
	Namespace: bgb_pack
	Checksum: 0x5737D17A
	Offset: 0x2BD8
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_73d4ab82(slot_index)
{
}

/*
	Name: function_7a00e117
	Namespace: bgb_pack
	Checksum: 0xE18EEB8B
	Offset: 0x2BF0
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function function_7a00e117()
{
	return false;
}

/*
	Name: function_be89decb
	Namespace: bgb_pack
	Checksum: 0xFA7A2B04
	Offset: 0x2C00
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_be89decb()
{
	if(getplayers().size == 1)
	{
		var_b8c2f693 = array::random(self.var_2b74c8fe);
	}
	else
	{
		var_b8c2f693 = array::random(self.var_82971641);
	}
	arrayremovevalue(self.var_82971641, var_b8c2f693);
	arrayremovevalue(self.var_2b74c8fe, var_b8c2f693);
	return var_b8c2f693;
}

/*
	Name: function_ac9cb612
	Namespace: bgb_pack
	Checksum: 0x60BA5A76
	Offset: 0x2CA0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_ac9cb612(b_disable = 1)
{
	self function_da912bff(0, b_disable);
	self function_da912bff(1, b_disable);
	self function_da912bff(2, b_disable);
	self function_da912bff(3, b_disable);
}

/*
	Name: function_59004002
	Namespace: bgb_pack
	Checksum: 0x53F12D95
	Offset: 0x2D28
	Size: 0xC8
	Parameters: 2
	Flags: Linked
*/
function function_59004002(str_bgb, b_disable = 1)
{
	if(isarray(self.bgb_pack))
	{
		foreach(n_slot, var_8024f0e5 in self.bgb_pack)
		{
			if(str_bgb === var_8024f0e5)
			{
				self function_da912bff(n_slot, b_disable);
			}
		}
	}
}

/*
	Name: function_72ffe91
	Namespace: bgb_pack
	Checksum: 0xB64B9503
	Offset: 0x2DF8
	Size: 0x136
	Parameters: 0
	Flags: None
*/
function function_72ffe91()
{
	/#
		level.var_d03d9cf3 = [];
		level.var_d03d9cf3[0] = array("", "", "", "", "");
		level.var_d03d9cf3[1] = array("", "", "", "", "");
		level.var_d03d9cf3[2] = array("", "", "", "", "");
		level.var_d03d9cf3[3] = array("", "", "", "", "");
	#/
}

/*
	Name: setup_devgui
	Namespace: bgb_pack
	Checksum: 0xCC1B6ADB
	Offset: 0x2F38
	Size: 0x268
	Parameters: 0
	Flags: Private
*/
function private setup_devgui()
{
	/#
		level flagsys::wait_till("");
		wait(1);
		bgb_devgui_base = "";
		keys = getarraykeys(level.bgb);
		zm_devgui::add_custom_devgui_callback(&function_c1091a8f);
		adddebugcommand(bgb_devgui_base + "");
		adddebugcommand(bgb_devgui_base + "");
		adddebugcommand(bgb_devgui_base + "");
		adddebugcommand(bgb_devgui_base + "");
		adddebugcommand((bgb_devgui_base + "") + "");
		adddebugcommand((bgb_devgui_base + "") + "");
		adddebugcommand((bgb_devgui_base + "") + "");
		adddebugcommand((bgb_devgui_base + "") + "");
		foreach(key in keys)
		{
			name = function_9e72a96(level.bgb[key].name);
			adddebugcommand((((bgb_devgui_base + name) + "") + name) + "");
		}
	#/
}

/*
	Name: function_c1091a8f
	Namespace: bgb_pack
	Checksum: 0x9C822CFA
	Offset: 0x31A8
	Size: 0x34A
	Parameters: 2
	Flags: Private
*/
function private function_c1091a8f(str_cmd, key)
{
	/#
		var_8327ff7c = getdvarint(#"hash_7877ee182ba11433", 0);
		a_players = getplayers();
		keys = getarraykeys(level.bgb);
		var_6c522f60 = 0;
		switch(str_cmd)
		{
			case "hash_2f68979bf97ad43a":
			{
				level.var_4af38aa3 = 1;
				break;
			}
			case "hash_972ca08eb9fbf0c":
			{
				level.var_4af38aa3 = 0;
				break;
			}
			case "hash_628ffe45aab5f07":
			{
				level.var_7c3d4959 = 1;
				break;
			}
			case "default_cooldowns":
			{
				level.var_7c3d4959 = 0;
				break;
			}
			case "slot0":
			{
				level.var_c20342bc = 0;
				break;
			}
			case "slot1":
			{
				level.var_c20342bc = 1;
				break;
			}
			case "slot2":
			{
				level.var_c20342bc = 2;
				break;
			}
			case "slot3":
			{
				level.var_c20342bc = 3;
				break;
			}
		}
		if(!isdefined(level.var_c20342bc))
		{
			level.var_c20342bc = 0;
		}
		a_keys = getarraykeys(level.bgb);
		b_found = 0;
		foreach(key in a_keys)
		{
			if(key == str_cmd)
			{
				b_found = 1;
			}
		}
		if(b_found)
		{
			for(i = 0; i < a_players.size; i++)
			{
				if(var_8327ff7c != -1 && var_8327ff7c != i)
				{
					continue;
				}
				a_players[i].bgb_pack[level.var_c20342bc] = hash(str_cmd);
				a_players[i] function_7b91e81c(level.var_c20342bc, level.bgb[str_cmd].item_index);
			}
			var_6c522f60 = 1;
		}
		return var_6c522f60;
	#/
}

