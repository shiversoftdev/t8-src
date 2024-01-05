// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_red_tribute.gsc;
#using script_39347d985163e17;
#using scripts\zm\zm_red_util.gsc;
#using script_6c983b627f4a3d51;
#using scripts\zm\zm_red_challenges.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\bgbs\zm_bgb_bullet_boost.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace namespace_f8f28e08;

/*
	Name: init
	Namespace: namespace_f8f28e08
	Checksum: 0x4ADA6114
	Offset: 0x2A8
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	function_a8243f37();
	namespace_c8efdadc::init();
	level.var_6463d67c = 100;
	level.var_48e2ab90 = 0.3;
	level.var_b4ff4ec = &function_529e8585;
	level.var_50ce2afd = &function_50ce2afd;
	level.var_bec5bf67 = &function_bec5bf67;
}

/*
	Name: function_ab6fd86c
	Namespace: namespace_f8f28e08
	Checksum: 0x3525E66B
	Offset: 0x358
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function function_ab6fd86c(e_player, s_bowl)
{
	e_player.var_4a25bda8 = s_bowl zm_unitrigger::create(&function_4909d78c, 64, &function_2c76782d);
	zm_unitrigger::unitrigger_force_per_player_triggers(e_player.var_4a25bda8, 1);
	e_player.var_4a25bda8.e_player = e_player;
}

/*
	Name: function_4909d78c
	Namespace: namespace_f8f28e08
	Checksum: 0x7C926F4
	Offset: 0x3E8
	Size: 0x428
	Parameters: 1
	Flags: Linked
*/
function function_4909d78c(e_player)
{
	if(e_player != self.stub.e_player)
	{
		self sethintstringforplayer(e_player, "");
		return false;
	}
	if(!e_player zm_red_util::can_see(self.origin, 0, 0))
	{
		self sethintstringforplayer(e_player, "");
		return false;
	}
	if(e_player flag::exists(#"hash_8cdde8e6a8607f1") && e_player flag::get(#"hash_8cdde8e6a8607f1"))
	{
		self sethintstringforplayer(e_player, "");
		return false;
	}
	if(level.var_2dffd020 == 0)
	{
		self sethintstringforplayer(e_player, #"hash_4aa00a9bc891ac28");
		return true;
	}
	if(isdefined(e_player.var_ccc18354))
	{
		n_time = gettime() / 1000;
		if(n_time >= e_player.var_ccc18354)
		{
			e_player.var_ccc18354 = undefined;
		}
		self sethintstringforplayer(e_player, "");
		return false;
	}
	if(isdefined(e_player.var_a7b66476) && e_player.var_a7b66476)
	{
		self sethintstringforplayer(e_player, #"hash_70048eaa02800fdb");
		return true;
	}
	if(e_player.var_9e09931e != 0)
	{
		str_prompt = zm_utility::function_d6046228(#"hash_57948661b0f24299", #"hash_5e5a534b4a1e00a7");
		self sethintstringforplayer(e_player, str_prompt);
		return true;
	}
	if(isdefined(e_player.var_43300e) && e_player.var_43300e)
	{
		if(e_player function_324787f7())
		{
			str_prompt = zm_utility::function_d6046228(#"hash_42cb69becded0870", #"hash_648ba551adc3865c");
			self sethintstringforplayer(e_player, str_prompt);
			return true;
		}
		self sethintstringforplayer(e_player, #"hash_19e66c91a9933726");
		return true;
	}
	if(e_player.var_9e09931e == 0)
	{
		self sethintstringforplayer(e_player, #"hash_11d1636b778203d5");
		return true;
	}
	if(e_player function_324787f7())
	{
		str_prompt = zm_utility::function_d6046228(#"hash_10c127acbe34c506", #"hash_4597718560da3ea2");
		self sethintstringforplayer(e_player, str_prompt);
		return true;
	}
	self sethintstringforplayer(e_player, #"hash_19e66c91a9933726");
	return true;
}

/*
	Name: function_324787f7
	Namespace: namespace_f8f28e08
	Checksum: 0xB585D1E3
	Offset: 0x820
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function function_324787f7()
{
	wpn_current = self getcurrentweapon();
	if(zm_loadout::is_hero_weapon(wpn_current) || (isdefined(wpn_current.isriotshield) && wpn_current.isriotshield))
	{
		return false;
	}
	return true;
}

/*
	Name: function_2c76782d
	Namespace: namespace_f8f28e08
	Checksum: 0xB7035DB1
	Offset: 0x898
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_2c76782d()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		if(self.stub.e_player !== e_player)
		{
			continue;
		}
		if(!namespace_5c5619de::is_active() && e_player.var_9e09931e != 0)
		{
			e_player function_123bcbcf();
			e_player function_53a333a8(undefined);
		}
		else
		{
			if(isdefined(e_player.var_43300e) && e_player.var_43300e && !e_player function_324787f7())
			{
				continue;
			}
			else if(isdefined(e_player.var_4373c66b) && e_player.var_4373c66b)
			{
				e_player.var_4373c66b = undefined;
				e_player notify(#"hash_3cd13a6cb08bba96");
			}
		}
	}
}

/*
	Name: function_3165516b
	Namespace: namespace_f8f28e08
	Checksum: 0x9A6509AA
	Offset: 0xA18
	Size: 0x1D4
	Parameters: 2
	Flags: Linked
*/
function function_3165516b(var_1e2067f4, n_phase)
{
	self endon(#"death");
	n_color = 1;
	switch(n_phase)
	{
		case 1:
		{
			n_color = 1;
			var_a3f33bc5 = 1;
			break;
		}
		case 2:
		{
			n_color = 2;
			var_a3f33bc5 = 2;
			break;
		}
		case 3:
		{
			n_color = 3;
			var_a3f33bc5 = 4;
			break;
		}
		case 4:
		default:
		{
			n_color = 4;
			var_a3f33bc5 = 8;
			break;
		}
	}
	self clientfield::set("" + #"hash_47490b879090eb55", n_color);
	util::wait_network_frame();
	self clientfield::set("" + #"hash_7b1dd5c08e2585c", var_1e2067f4);
	util::wait_network_frame();
	self clientfield::set("" + #"hash_47490b879090eb55", 0);
	self clientfield::set("" + #"hash_7b1dd5c08e2585c", 0);
	wait(1.3);
	level thread namespace_c8efdadc::function_9c8540b4(self, var_a3f33bc5);
}

/*
	Name: function_123bcbcf
	Namespace: namespace_f8f28e08
	Checksum: 0x5F13A361
	Offset: 0xBF8
	Size: 0xA6C
	Parameters: 0
	Flags: Linked
*/
function function_123bcbcf()
{
	b_reward = 1;
	switch(self.var_9e09931e)
	{
		case 0:
		{
			b_reward = 0;
			break;
		}
		case 1:
		{
			a_str_rewards = [];
			if(zm_custom::function_901b751c(#"zmpowerupsactive"))
			{
				a_str_rewards[a_str_rewards.size] = #"double_points";
				a_str_rewards[a_str_rewards.size] = #"insta_kill";
			}
			a_players = getplayers();
			if(a_players.size == 1 && (!(isdefined(self.var_6482c679) && self.var_6482c679)) && !zm_utility::is_trials())
			{
				a_str_rewards[a_str_rewards.size] = #"extra_life";
			}
			wpn_bowie = getweapon(#"bowie_knife");
			if(!self hasweapon(wpn_bowie) && zm_custom::function_901b751c(#"zmweaponsknife"))
			{
				a_str_rewards[a_str_rewards.size] = #"bowie_knife";
			}
			str_reward = function_56c888ce(a_str_rewards);
			switch(str_reward)
			{
				case "double_points":
				{
					self thread function_d36fb590("double_points", 6, 1);
					break;
				}
				case "insta_kill":
				{
					self thread function_d36fb590("insta_kill", 6, 1);
					break;
				}
				case "extra_life":
				{
					self thread function_d36fb590("self_revive", 6, 1);
					self.var_6482c679 = 1;
					break;
				}
				case "bowie_knife":
				{
					self thread function_11be5095(undefined, 6, 0, #"bowie_knife");
					break;
				}
			}
			break;
		}
		case 2:
		{
			a_str_rewards = array(#"weapon");
			if(zm_custom::function_901b751c(#"zmpowerupsactive"))
			{
				a_str_rewards[a_str_rewards.size] = #"full_ammo";
				a_str_rewards[a_str_rewards.size] = #"fire_sale";
			}
			wpn_bn = getweapon(#"bowie_knife");
			if(!self hasweapon(wpn_bn) && zm_custom::function_901b751c(#"zmweaponsknife"))
			{
				a_str_rewards[a_str_rewards.size] = #"bowie_knife";
			}
			str_reward = function_56c888ce(a_str_rewards);
			switch(str_reward)
			{
				case "full_ammo":
				{
					self thread function_d36fb590("full_ammo", 15, 1);
					break;
				}
				case "fire_sale":
				{
					self thread function_d36fb590("fire_sale", 15, 1);
					break;
				}
				case "weapon":
				{
					self thread function_11be5095(1, 15, 1, undefined);
					break;
				}
				case "bowie_knife":
				{
					self thread function_11be5095(undefined, 15, 0, #"bowie_knife");
					break;
				}
			}
			break;
		}
		case 3:
		{
			a_str_rewards = array(#"weapon");
			wpn_current = self getcurrentweapon();
			if(zm_weapons::is_weapon_upgraded(wpn_current))
			{
				a_str_rewards[a_str_rewards.size] = #"aat";
			}
			if(zm_custom::function_901b751c(#"zmspecweaponisenabled") && zm_custom::function_901b751c(#"zmpowerupsactive"))
			{
				a_str_rewards[a_str_rewards.size] = #"weapon_power";
			}
			str_reward = function_56c888ce(a_str_rewards);
			switch(str_reward)
			{
				case "aat":
				{
					self thread function_7dc3dfdb(15);
					break;
				}
				case "weapon_power":
				{
					self thread function_d36fb590("hero_weapon_power", 15, 2);
					break;
				}
				case "weapon":
				{
					self thread function_11be5095(2, 15, 1, undefined);
					break;
				}
			}
			break;
		}
		case 4:
		{
			if(!isdefined(self.var_123836f9))
			{
				self.var_123836f9 = 0;
			}
			a_str_rewards = array(#"weapon");
			if(zm_custom::function_901b751c(#"zmperksactive") && self.var_123836f9 < 2)
			{
				a_str_rewards[a_str_rewards.size] = #"free_perk";
			}
			a_players = getplayers();
			if(a_players.size == 1 && (!(isdefined(self.var_17d719b9) && self.var_17d719b9)) && zm_custom::function_901b751c(#"zmpowerupsactive") && !zm_utility::is_trials())
			{
				a_str_rewards[a_str_rewards.size] = #"extra_life";
			}
			var_b42aa272 = 1;
			wpn_pegasus = getweapon(#"thunderstorm");
			if(self hasweapon(wpn_pegasus))
			{
				n_ammo = self getammocount(wpn_pegasus);
				if(n_ammo)
				{
					var_b42aa272 = 0;
				}
			}
			if(var_b42aa272 && zm_custom::function_901b751c(#"zmequipmentisenabled") && zm_weapons::get_is_in_box(level.var_49d60273))
			{
				a_str_rewards[a_str_rewards.size] = #"pegasus";
			}
			str_reward = function_56c888ce(a_str_rewards);
			switch(str_reward)
			{
				case "weapon":
				{
					self thread function_11be5095(3, 15, 1, undefined);
					break;
				}
				case "free_perk":
				{
					self thread function_8665509b(15);
					self.var_123836f9++;
					break;
				}
				case "extra_life":
				{
					self thread function_d36fb590("self_revive", 15, 1);
					self.var_17d719b9 = 1;
					break;
				}
				case "pegasus":
				{
					self thread function_11be5095(undefined, 15, 0, #"thunderstorm");
					break;
				}
			}
			break;
		}
	}
	if(b_reward)
	{
		self thread function_3165516b(self.s_tribute_bowl.var_e668d197, self.var_9e09931e);
		self thread function_6c62f074(self.var_9e09931e);
	}
	self set_tribute(0);
}

/*
	Name: set_tribute
	Namespace: namespace_f8f28e08
	Checksum: 0x746EA457
	Offset: 0x1670
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function set_tribute(n_amount)
{
	self.n_tribute = n_amount;
	n_index = self getentitynumber();
	level.var_edbe6a7f[n_index] = self.n_tribute;
}

/*
	Name: function_56c888ce
	Namespace: namespace_f8f28e08
	Checksum: 0xF8F3BB04
	Offset: 0x16D0
	Size: 0x120
	Parameters: 1
	Flags: Linked
*/
function function_56c888ce(a_str_rewards)
{
	if(!a_str_rewards.size)
	{
		return #"empty";
	}
	n_max = a_str_rewards.size;
	if(n_max > 5)
	{
		n_max = 5;
	}
	var_c481f7e6 = randomint(n_max * 1000);
	if(var_c481f7e6 <= 1000)
	{
		str_reward = a_str_rewards[0];
	}
	else
	{
		if(var_c481f7e6 <= (1000 * 2))
		{
			str_reward = a_str_rewards[1];
		}
		else
		{
			if(var_c481f7e6 <= (1000 * 3))
			{
				str_reward = a_str_rewards[2];
			}
			else
			{
				if(var_c481f7e6 <= (1000 * 4))
				{
					str_reward = a_str_rewards[3];
				}
				else
				{
					str_reward = a_str_rewards[4];
				}
			}
		}
	}
	return str_reward;
}

/*
	Name: function_29e6dc49
	Namespace: namespace_f8f28e08
	Checksum: 0x3A9D35F0
	Offset: 0x17F8
	Size: 0x16A
	Parameters: 2
	Flags: Linked
*/
function function_29e6dc49(var_be164210 = 1, var_6c9485fc = 15)
{
	self endon(#"death");
	if(!zm_custom::function_901b751c(#"zmpowerupsactive"))
	{
		return;
	}
	v_loc = level.var_d5ba7324.origin + (vectorscale((0, 0, -1), 8));
	v_dir = anglestoforward(level.var_d5ba7324.angles);
	level.var_b3556b34 = level.var_d5ba7324.origin + (v_dir * 150);
	level thread zm_utility::function_4a25b584(v_loc, var_6c9485fc, 100, 1, 0.25, 200, level.var_b3556b34);
	if(isdefined(var_be164210) && var_be164210)
	{
		self.var_a7b66476 = 1;
		wait(5);
		self.var_a7b66476 = undefined;
	}
}

/*
	Name: function_d36fb590
	Namespace: namespace_f8f28e08
	Checksum: 0x275938DE
	Offset: 0x1970
	Size: 0x24C
	Parameters: 3
	Flags: Linked
*/
function function_d36fb590(var_aa4f9213, var_6c9485fc = 15, n_fx_type = 1)
{
	self endon(#"death");
	if(!zm_custom::function_901b751c(#"zmpowerupsactive"))
	{
		return;
	}
	if(var_6c9485fc)
	{
		self thread function_29e6dc49(0, var_6c9485fc);
	}
	var_8b84b3ce = self.s_tribute_bowl.var_1a34d8e;
	v_spawn_angles = self.s_tribute_bowl.var_7b63dcba;
	v_forward = anglestoforward(v_spawn_angles);
	var_8b84b3ce = var_8b84b3ce + (v_forward * 7) + (vectorscale((0, 0, -1), 3));
	var_24a867e4 = function_ed4a5d52(var_aa4f9213);
	if(!isdefined(var_24a867e4))
	{
		return;
	}
	var_4d0b3b87 = util::spawn_model(var_24a867e4, var_8b84b3ce, v_spawn_angles);
	var_4d0b3b87 playsound(#"zmb_spawn_powerup");
	var_4d0b3b87 playloopsound(#"zmb_spawn_powerup_loop");
	b_give_reward = self function_dcda5d87(var_4d0b3b87, 1, 1, n_fx_type);
	if(b_give_reward)
	{
		level thread zm_audio::sndannouncerplayvox(var_aa4f9213);
		if(var_aa4f9213 == "self_revive")
		{
			self zm_laststand::function_3a00302e();
		}
		else
		{
			level [[level._custom_powerups[var_aa4f9213].grab_powerup]](self);
		}
	}
	self stoploopsound();
}

/*
	Name: function_ed4a5d52
	Namespace: namespace_f8f28e08
	Checksum: 0x86463164
	Offset: 0x1BC8
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function function_ed4a5d52(var_f0de9b92)
{
	var_24a867e4 = undefined;
	switch(var_f0de9b92)
	{
		case "double_points":
		{
			var_24a867e4 = "p7_zm_power_up_double_points";
			break;
		}
		case "carpenter":
		{
			var_24a867e4 = "p7_zm_power_up_carpenter";
			break;
		}
		case "insta_kill":
		{
			var_24a867e4 = "p7_zm_power_up_insta_kill";
			break;
		}
		case "full_ammo":
		{
			var_24a867e4 = "p7_zm_power_up_max_ammo";
			break;
		}
		case "fire_sale":
		{
			var_24a867e4 = "p7_zm_power_up_firesale";
			break;
		}
		case "self_revive":
		{
			var_24a867e4 = "p8_zm_gla_heart_zombie";
			break;
		}
		case "hero_weapon_power":
		{
			var_24a867e4 = "p8_zm_powerup_full_power";
			break;
		}
	}
	return var_24a867e4;
}

/*
	Name: function_f152b354
	Namespace: namespace_f8f28e08
	Checksum: 0x107FFF0F
	Offset: 0x1CE8
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function function_f152b354(str_bgb, var_6c9485fc = 15)
{
	self endon(#"death");
	if(var_6c9485fc)
	{
		self thread function_29e6dc49(0, var_6c9485fc);
	}
	var_8b84b3ce = self.s_tribute_bowl.var_1a34d8e + (vectorscale((0, 0, -1), 6));
	v_spawn_angles = self.s_tribute_bowl.var_7b63dcba;
	var_4d0b3b87 = util::spawn_model(#"wpn_t8_zm_elixir_bottle_world", var_8b84b3ce, v_spawn_angles);
	b_taken = self function_dcda5d87(var_4d0b3b87, 1, 0, 1);
	if(b_taken)
	{
		self thread give_bgb(str_bgb);
	}
}

/*
	Name: function_11be5095
	Namespace: namespace_f8f28e08
	Checksum: 0xEF17C6A1
	Offset: 0x1E18
	Size: 0x24C
	Parameters: 4
	Flags: Linked
*/
function function_11be5095(var_7ed75e97, var_6c9485fc = 15, b_upgraded = 0, var_5876e0e2 = undefined)
{
	self endon(#"death");
	if(var_6c9485fc)
	{
		self thread function_29e6dc49(0, var_6c9485fc);
	}
	if(isdefined(var_5876e0e2))
	{
		str_weapon_name = var_5876e0e2;
	}
	else
	{
		str_weapon_name = get_weapon(var_7ed75e97);
		if(!isdefined(str_weapon_name))
		{
			return;
		}
		if(isdefined(b_upgraded) && b_upgraded)
		{
			str_weapon_name = str_weapon_name + "_upgraded";
		}
	}
	v_loc = self.s_tribute_bowl.var_1a34d8e + (vectorscale((0, 0, -1), 8));
	v_angles = self.s_tribute_bowl.var_7b63dcba + (0, 0, 0);
	if(isdefined(level.var_592fbce6[str_weapon_name]))
	{
		n_amount = level.var_592fbce6[str_weapon_name];
		v_forward = anglestoforward(v_angles);
		v_loc = v_loc + (v_forward * n_amount);
	}
	var_4d0b3b87 = zm_utility::spawn_buildkit_weapon_model(self, getweapon(str_weapon_name), undefined, v_loc, v_angles);
	b_rotate = 1;
	if(str_weapon_name == #"thunderstorm")
	{
		b_rotate = 0;
	}
	b_give_reward = self function_dcda5d87(var_4d0b3b87, b_rotate, 0, 1);
	if(b_give_reward)
	{
		self function_e2a25377(str_weapon_name);
	}
}

/*
	Name: function_e2a25377
	Namespace: namespace_f8f28e08
	Checksum: 0xEBD7B72F
	Offset: 0x2070
	Size: 0xFA
	Parameters: 1
	Flags: Linked
*/
function function_e2a25377(str_weapon_name)
{
	var_498a708 = getweapon(str_weapon_name);
	if(self hasweapon(zm_weapons::get_base_weapon(var_498a708), 1))
	{
		self takeweapon(zm_weapons::get_base_weapon(var_498a708), 1);
	}
	if(isdefined(var_498a708.ismeleeweapon) && var_498a708.ismeleeweapon)
	{
		self zm_melee_weapon::award_melee_weapon(str_weapon_name);
		weapon_given = var_498a708;
	}
	else
	{
		weapon_given = self zm_weapons::weapon_give(var_498a708, 1);
	}
	return weapon_given;
}

/*
	Name: function_53a333a8
	Namespace: namespace_f8f28e08
	Checksum: 0x1DB8C41D
	Offset: 0x2178
	Size: 0x324
	Parameters: 3
	Flags: Linked
*/
function function_53a333a8(var_ecffa2a8, var_41f9c5ff = undefined, var_893baaf = undefined)
{
	if(isbot(self))
	{
		return;
	}
	if(self laststand::player_is_in_laststand())
	{
		return;
	}
	if(isdefined(var_41f9c5ff))
	{
		if(!(isdefined(self.var_4373c66b) && self.var_4373c66b))
		{
			var_41f9c5ff = self function_73fda38e(var_41f9c5ff);
			self set_tribute(self.n_tribute + var_41f9c5ff);
			self.var_6b3806e8 = self.var_6b3806e8 + (var_41f9c5ff / level.var_8b7ab859);
			self playsoundtoplayer(#"hash_51923ec42cdda138", self);
		}
	}
	else if(isdefined(var_ecffa2a8))
	{
		n_amount = self function_955b59b2(var_ecffa2a8, var_893baaf);
		if(isdefined(self.var_4373c66b) && self.var_4373c66b)
		{
			n_amount = 0;
		}
		else
		{
			set_tribute(self.n_tribute + n_amount);
			self.var_6b3806e8 = self.var_6b3806e8 + (n_amount / level.var_8b7ab859);
			self playsoundtoplayer(#"hash_51923ec42cdda138", self);
		}
	}
	var_1f5eb74c = self.var_9e09931e;
	self function_ae2c0ba5();
	if(var_1f5eb74c != self.var_9e09931e)
	{
		switch(self.var_9e09931e)
		{
			case 1:
			{
				self playsoundtoplayer(#"hash_15350c3643360459", self);
				break;
			}
			case 2:
			{
				self playsoundtoplayer(#"hash_15350c3643360459", self);
				break;
			}
			case 3:
			{
				self playsoundtoplayer(#"hash_15350c3643360459", self);
				break;
			}
			case 4:
			{
				self playsoundtoplayer(#"hash_15350c3643360459", self);
				break;
			}
		}
		self notify(#"hash_24326081081c2468", {#hash_9e09931e:self.var_9e09931e});
		self thread function_b858f95a();
	}
}

/*
	Name: function_73fda38e
	Namespace: namespace_f8f28e08
	Checksum: 0xAAFA2B8B
	Offset: 0x24A8
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_73fda38e(n_amount)
{
	if(!n_amount)
	{
		return 0;
	}
	switch(self.var_9e09931e)
	{
		case 0:
		{
			n_amount = n_amount * 1.5;
			break;
		}
		case 1:
		{
			n_amount = n_amount * 0.7;
			break;
		}
		case 2:
		{
			n_amount = n_amount * 0.5;
			break;
		}
		case 3:
		case 4:
		{
			n_amount = n_amount * 0.35;
			break;
		}
	}
	if(zm_trial_red_tribute::is_active())
	{
		n_amount = n_amount * 1.5;
	}
	if(n_amount == 0)
	{
		n_amount = 1;
	}
	return n_amount;
}

/*
	Name: function_b858f95a
	Namespace: namespace_f8f28e08
	Checksum: 0x8CFDF3BE
	Offset: 0x25C0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_b858f95a()
{
	self endon(#"death");
	if(isplayer(self) && isdefined(self.s_tribute_bowl))
	{
		s_bowl = self.s_tribute_bowl;
		if(isdefined(s_bowl.var_9d32404) && isdefined(self.var_9e09931e))
		{
			s_bowl.var_9d32404 clientfield::set("" + #"hash_21f5fab6a3d22093", self.var_9e09931e);
		}
	}
}

/*
	Name: function_955b59b2
	Namespace: namespace_f8f28e08
	Checksum: 0x1285F15B
	Offset: 0x2678
	Size: 0x30A
	Parameters: 2
	Flags: Linked
*/
function function_955b59b2(var_5436555f, var_893baaf)
{
	n_amount = 0;
	switch(var_5436555f)
	{
		case 0:
		{
			n_amount = level.var_8b7ab859 * 0.02;
			break;
		}
		case 11:
		{
			n_amount = level.var_8b7ab859 * 0.01;
			break;
		}
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		{
			n_scale = function_9275b11b();
			n_amount = level.var_8b7ab859 * n_scale;
			break;
		}
		case 13:
		{
			n_amount = level.var_8b7ab859 * 0.015;
			break;
		}
		case 10:
		{
			n_frac = var_893baaf / self.maxhealth;
			n_amount = (level.var_8b7ab859 * 0.15) * n_frac;
			break;
		}
		case 9:
		{
			n_amount = (level.var_8b7ab859 * 0.025) * var_893baaf;
			break;
		}
		case 12:
		{
			n_amount = level.var_8b7ab859 * 0.05;
			break;
		}
		case 14:
		{
			n_amount = level.var_8b7ab859 * 0.02;
			break;
		}
		case 8:
		{
			n_amount = level.var_8b7ab859 * 0.05;
			break;
		}
		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		{
			n_amount = level.var_8b7ab859 * 0.014;
			break;
		}
		default:
		{
			n_amount = 0;
			break;
		}
	}
	n_amount = self function_73fda38e(n_amount);
	return n_amount;
}

/*
	Name: function_9275b11b
	Namespace: namespace_f8f28e08
	Checksum: 0x479DC653
	Offset: 0x2990
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function function_9275b11b()
{
	if(level.round_number < 10)
	{
		var_a2afabbf = 10 - level.round_number;
		n_scale = 0.007 + (0.018 * (var_a2afabbf / 10));
	}
	else
	{
		if(level.round_number < 20)
		{
			n_scale = 0.007;
		}
		else
		{
			if(level.round_number < 40)
			{
				var_a2afabbf = level.round_number - 20;
				n_scale = 0.007 + -0.005 * (var_a2afabbf / 20);
			}
			else
			{
				n_scale = 0.002;
			}
		}
	}
	return n_scale;
}

/*
	Name: function_ae2c0ba5
	Namespace: namespace_f8f28e08
	Checksum: 0xEF665C63
	Offset: 0x2A70
	Size: 0x1BC
	Parameters: 0
	Flags: Linked
*/
function function_ae2c0ba5()
{
	var_1f5eb74c = self.var_9e09931e;
	n_step = level.var_8b7ab859 / 4;
	if(self.n_tribute >= (n_step * 4))
	{
		set_tribute(level.var_8b7ab859);
		self.var_9e09931e = 4;
	}
	else
	{
		if(self.n_tribute >= (n_step * 3))
		{
			self.var_9e09931e = 3;
		}
		else
		{
			if(self.n_tribute >= (n_step * 2))
			{
				self.var_9e09931e = 2;
			}
			else
			{
				if(self.n_tribute >= (n_step * 1))
				{
					self.var_9e09931e = 1;
				}
				else
				{
					self.var_9e09931e = 0;
				}
			}
		}
	}
	var_f3ffdc3e = 0;
	if(self.n_tribute > 0)
	{
		var_f3ffdc3e = math::clamp(self.var_9e09931e + 1, 0, 4);
	}
	self zm_red_util::function_a6d4b55e(self.var_9e09931e);
	if(var_1f5eb74c < 4)
	{
		zm_red_util::function_34a533b1();
	}
	if(self.var_9e09931e == 4)
	{
		return 1;
	}
	return (self.n_tribute - (n_step * self.var_9e09931e)) / n_step;
}

/*
	Name: function_a8243f37
	Namespace: namespace_f8f28e08
	Checksum: 0xBFE548F2
	Offset: 0x2C38
	Size: 0x422
	Parameters: 0
	Flags: Linked
*/
function function_a8243f37()
{
	level.var_30641602 = [];
	level.var_30641602[level.var_30641602.size] = #"pistol_standard_t8";
	level.var_30641602[level.var_30641602.size] = #"pistol_burst_t8";
	if(zm_custom::function_901b751c(#"zmweaponssmg"))
	{
		level.var_30641602[level.var_30641602.size] = #"smg_drum_pistol_t8";
	}
	level.var_30641602 = array::randomize(level.var_30641602);
	level.var_8e5c4768 = 0;
	level.var_fc2d4a2 = [];
	if(zm_custom::function_901b751c(#"zmweaponsar"))
	{
		level.var_fc2d4a2[level.var_fc2d4a2.size] = #"ar_galil_t8";
	}
	if(zm_custom::function_901b751c(#"zmweaponsshotgun"))
	{
		level.var_fc2d4a2[level.var_fc2d4a2.size] = #"shotgun_fullauto_t8";
	}
	if(zm_custom::function_901b751c(#"zmweaponssmg"))
	{
		level.var_fc2d4a2[level.var_fc2d4a2.size] = #"smg_folding_t8";
	}
	level.var_e3d39f70 = 0;
	level.var_24b50714 = [];
	if(zm_custom::function_901b751c(#"zmweaponssmg"))
	{
		level.var_24b50714[level.var_24b50714.size] = #"smg_fastburst_t8";
	}
	if(zm_custom::function_901b751c(#"zmweaponsar"))
	{
		level.var_24b50714[level.var_24b50714.size] = #"ar_standard_t8";
	}
	if(zm_custom::function_901b751c(#"zmweaponssniper"))
	{
		level.var_24b50714[level.var_24b50714.size] = #"sniper_powersemi_t8";
	}
	level.var_de18c954 = 0;
	level.var_592fbce6 = [];
	level.var_592fbce6[#"bowie_knife"] = 0;
	level.var_592fbce6[#"pistol_standard_t8_upgraded"] = 5;
	level.var_592fbce6[#"pistol_burst_t8_upgraded"] = 5;
	level.var_592fbce6[#"smg_drum_pistol_t8_upgraded"] = 5;
	level.var_592fbce6[#"ar_galil_t8_upgraded"] = -1;
	level.var_592fbce6[#"shotgun_fullauto_t8_upgraded"] = -1;
	level.var_592fbce6[#"smg_folding_t8_upgraded"] = 9;
	level.var_592fbce6[#"smg_fastburst_t8_upgraded"] = 4;
	level.var_592fbce6[#"ar_standard_t8_upgraded"] = 0;
	level.var_592fbce6[#"thunderstorm"] = 8;
	level.var_592fbce6[#"sniper_powersemi_t8"] = 0;
}

/*
	Name: get_weapon
	Namespace: namespace_f8f28e08
	Checksum: 0x587BFF92
	Offset: 0x3068
	Size: 0x1FE
	Parameters: 1
	Flags: Linked
*/
function get_weapon(var_7ed75e97)
{
	str_weapon = undefined;
	switch(var_7ed75e97)
	{
		case 1:
		{
			if(level.var_30641602.size > 0)
			{
				level.var_8e5c4768 = function_566c19d5(level.var_30641602, level.var_8e5c4768);
				str_weapon = level.var_30641602[level.var_8e5c4768];
				level.var_8e5c4768++;
				if(level.var_8e5c4768 >= level.var_30641602.size)
				{
					level.var_8e5c4768 = 0;
				}
			}
			break;
		}
		case 2:
		{
			if(level.var_fc2d4a2.size > 0)
			{
				level.var_e3d39f70 = function_566c19d5(level.var_fc2d4a2, level.var_e3d39f70);
				str_weapon = level.var_fc2d4a2[level.var_e3d39f70];
				level.var_e3d39f70++;
				if(level.var_e3d39f70 >= level.var_fc2d4a2.size)
				{
					level.var_e3d39f70 = 0;
				}
			}
			break;
		}
		case 3:
		{
			if(level.var_24b50714.size > 0)
			{
				level.var_f2a057b1 = function_566c19d5(level.var_24b50714, level.var_de18c954);
				str_weapon = level.var_24b50714[level.var_de18c954];
				level.var_de18c954++;
				if(level.var_de18c954 >= level.var_24b50714.size)
				{
					level.var_de18c954 = 0;
				}
			}
			break;
		}
	}
	return str_weapon;
}

/*
	Name: function_566c19d5
	Namespace: namespace_f8f28e08
	Checksum: 0x1B2E15B1
	Offset: 0x3270
	Size: 0x16A
	Parameters: 2
	Flags: Linked
*/
function function_566c19d5(var_3d01acc1, n_index)
{
	n_start_index = n_index;
	a_player_weapons = self getweaponslist();
	for(var_70eb710b = 0; var_70eb710b < var_3d01acc1.size; var_70eb710b++)
	{
		str_weapon = var_3d01acc1[n_index];
		var_b2425ef = str_weapon + "_upgraded";
		b_found = 0;
		foreach(wpn in a_player_weapons)
		{
			if(wpn.name == str_weapon || wpn.name == var_b2425ef)
			{
				b_found = 1;
				break;
			}
		}
		if(!b_found)
		{
			return n_index;
		}
		n_index++;
		if(n_index >= var_3d01acc1.size)
		{
			n_index = 0;
		}
	}
	return n_start_index;
}

/*
	Name: give_perk_reward
	Namespace: namespace_f8f28e08
	Checksum: 0x95F5EE30
	Offset: 0x33E8
	Size: 0x19C
	Parameters: 2
	Flags: Linked
*/
function give_perk_reward(var_16c042b8, var_6c9485fc = 15)
{
	self endon(#"death");
	if(var_6c9485fc)
	{
		self thread function_29e6dc49(0, var_6c9485fc);
	}
	var_8b84b3ce = self.s_tribute_bowl.var_9d32404.origin + vectorscale((0, 0, 1), 35);
	v_spawn_angles = self.s_tribute_bowl.var_9d32404.angles;
	v_forward = anglestoforward(v_spawn_angles);
	var_8b84b3ce = var_8b84b3ce + (v_forward * 7) + (vectorscale((0, 0, -1), 9));
	var_fb2313c1 = zm_perks::get_perk_weapon_model(var_16c042b8);
	var_4d0b3b87 = util::spawn_model(var_fb2313c1, var_8b84b3ce, v_spawn_angles);
	self thread function_545834dc(var_16c042b8);
	b_taken = self function_dcda5d87(var_4d0b3b87, 1, 1, 1);
	if(b_taken)
	{
		self zm_perks::function_29387491(var_16c042b8);
	}
}

/*
	Name: function_545834dc
	Namespace: namespace_f8f28e08
	Checksum: 0x5D7DD0D7
	Offset: 0x3590
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_545834dc(var_16c042b8)
{
	self endon(#"death", #"hash_358f065cca50b2a7");
	while(true)
	{
		if(self hasperk(var_16c042b8))
		{
			if(isdefined(self.var_7a281a7e))
			{
				self.var_7a281a7e.b_timeout = 1;
			}
			self notify(#"challenge_reward_timeout");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_8665509b
	Namespace: namespace_f8f28e08
	Checksum: 0x1DAD7A47
	Offset: 0x3628
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_8665509b(var_6c9485fc = 15)
{
	var_62fef0f1 = self zm_perks::function_5ea0c6cf(array(#"specialty_quickrevive"));
	if(!isdefined(var_62fef0f1))
	{
		return;
	}
	self thread give_perk_reward(var_62fef0f1, var_6c9485fc);
}

/*
	Name: function_7dc3dfdb
	Namespace: namespace_f8f28e08
	Checksum: 0x24435548
	Offset: 0x36B0
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_7dc3dfdb(var_6c9485fc = 0)
{
	self endon(#"death");
	if(var_6c9485fc)
	{
		self thread function_29e6dc49(0, var_6c9485fc);
	}
	var_8b84b3ce = self.s_tribute_bowl.var_1a34d8e + (vectorscale((0, 0, -1), 6));
	v_spawn_angles = self.s_tribute_bowl.var_7b63dcba;
	v_forward = anglestoforward(v_spawn_angles);
	var_8b84b3ce = var_8b84b3ce + (v_forward * 7);
	var_4d0b3b87 = util::spawn_model("p8_zm_powerup_aat", var_8b84b3ce, v_spawn_angles);
	b_taken = self function_dcda5d87(var_4d0b3b87, 1, 1, 1);
	if(b_taken)
	{
		weapon = self getcurrentweapon();
		self thread function_fc6ae19f();
	}
}

/*
	Name: function_fc6ae19f
	Namespace: namespace_f8f28e08
	Checksum: 0x1CB299B9
	Offset: 0x3820
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_fc6ae19f()
{
	if(self zm_bgb_bullet_boost::validation())
	{
		current_weapon = self getcurrentweapon();
		current_weapon = self zm_weapons::switch_from_alt_weapon(current_weapon);
		var_9a9544b8 = self aat::getaatonweapon(current_weapon, 1);
		self aat::acquire(current_weapon, undefined, var_9a9544b8);
	}
}

/*
	Name: get_weapon_upgrade
	Namespace: namespace_f8f28e08
	Checksum: 0x91FB8BF2
	Offset: 0x38C8
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function get_weapon_upgrade(weapon)
{
	if(isdefined(level.zombie_weapons[weapon]) && isdefined(level.zombie_weapons[weapon].upgrade_name))
	{
		return zm_weapons::get_upgrade_weapon(weapon, 0);
	}
	return zm_weapons::get_upgrade_weapon(weapon, 1);
}

/*
	Name: function_dcda5d87
	Namespace: namespace_f8f28e08
	Checksum: 0x77091587
	Offset: 0x3948
	Size: 0x208
	Parameters: 4
	Flags: Linked
*/
function function_dcda5d87(var_4d0b3b87, b_rotate = 1, var_b9b24 = 1, n_fx_type = 1)
{
	self endon(#"death");
	self.var_7a281a7e = var_4d0b3b87;
	var_4d0b3b87 thread pickup_timeout(self, "challenge_reward_timeout");
	var_4d0b3b87 thread function_f7cdf2f7(n_fx_type);
	if(isdefined(b_rotate) && b_rotate)
	{
		var_4d0b3b87 thread function_51fd2597(var_b9b24);
	}
	self.var_4373c66b = 1;
	self.var_43300e = 1;
	self.var_ccc18354 = (gettime() / 1000) + 0.5;
	self waittill(#"hash_3cd13a6cb08bba96", #"challenge_reward_timeout");
	self.var_ccc18354 = (gettime() / 1000) + 0.5;
	self.var_43300e = undefined;
	self.var_4373c66b = undefined;
	b_timeout = var_4d0b3b87.b_timeout;
	var_4d0b3b87 delete();
	self notify(#"hash_358f065cca50b2a7");
	if(isdefined(b_timeout) && b_timeout)
	{
		return false;
	}
	self playsound(#"hash_3a681f400deb121b");
	self thread zm_audio::create_and_play_dialog(#"tribute", #"boon");
	return true;
}

/*
	Name: function_51fd2597
	Namespace: namespace_f8f28e08
	Checksum: 0xDE3D0E77
	Offset: 0x3B58
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function function_51fd2597(var_b9b24 = 1)
{
	self endon(#"death");
	v_center = self getcentroid();
	var_4e7cc086 = util::spawn_model(#"tag_origin", v_center, self.angles);
	self linkto(var_4e7cc086);
	var_4e7cc086 thread function_57b8a4e9(self);
	while(isdefined(self))
	{
		if(var_b9b24)
		{
			waittime = randomfloatrange(2.5, 5);
			yaw = randomint(360);
			if(yaw > 300)
			{
				yaw = 300;
			}
			else if(yaw < 60)
			{
				yaw = 60;
			}
			yaw = self.angles[1] + yaw;
			new_angles = (-60 + randomint(120), yaw, -45 + randomint(90));
			var_4e7cc086 rotateto(new_angles, waittime, waittime * 0.5, waittime * 0.5);
			wait(randomfloat(waittime - 0.1));
		}
		else
		{
			new_angles = (self.angles[0], self.angles[1] + 45, self.angles[2]);
			var_4e7cc086 rotateto(new_angles, 2, 2 * 0.05, 2 * 0.05);
			wait(2);
		}
	}
}

/*
	Name: function_57b8a4e9
	Namespace: namespace_f8f28e08
	Checksum: 0xED27D497
	Offset: 0x3DD0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_57b8a4e9(e_pickup)
{
	e_pickup waittill(#"death");
	self delete();
}

/*
	Name: function_f7cdf2f7
	Namespace: namespace_f8f28e08
	Checksum: 0x9F25F045
	Offset: 0x3E18
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_f7cdf2f7(n_fx_type = 1)
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	self clientfield::set("powerup_fx", n_fx_type);
}

/*
	Name: pickup_timeout
	Namespace: namespace_f8f28e08
	Checksum: 0x3D2E9EC
	Offset: 0x3E80
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function pickup_timeout(e_player, var_cbfbd48a, var_22b0e42b = 15)
{
	self endon(#"death");
	if(isdefined(e_player))
	{
		e_player endon(#"death");
	}
	wait(var_22b0e42b);
	for(i = 0; i < 40; i++)
	{
		if(i % 2)
		{
			self ghost();
		}
		else
		{
			self show();
		}
		if(i < 15)
		{
			wait(0.5);
			continue;
		}
		if(i < 25)
		{
			wait(0.25);
			continue;
		}
		wait(0.1);
	}
	self ghost();
	self.b_timeout = 1;
	if(isdefined(e_player))
	{
		e_player notify(var_cbfbd48a);
	}
}

/*
	Name: function_6c62f074
	Namespace: namespace_f8f28e08
	Checksum: 0xACE5B284
	Offset: 0x3FB8
	Size: 0x27A
	Parameters: 1
	Flags: Linked
*/
function function_6c62f074(var_9e09931e)
{
	switch(var_9e09931e)
	{
		case 2:
		{
			if(math::cointoss() && zm_custom::function_901b751c(#"zmpowerupsactive"))
			{
				if(math::cointoss())
				{
					level thread function_445c5623("double_points", self.s_tribute_bowl.var_8f683ef8, 1);
				}
				else
				{
					level thread function_445c5623("carpenter", self.s_tribute_bowl.var_8f683ef8, 1);
				}
			}
			break;
		}
		case 3:
		{
			function_4071e6d();
			break;
		}
		case 4:
		{
			if(zm_custom::function_901b751c(#"zmspecweaponisenabled") && zm_custom::function_901b751c(#"zmpowerupsactive"))
			{
				var_c481f7e6 = randomint(1000);
				if(var_c481f7e6 <= 250)
				{
					level thread function_445c5623("hero_weapon_power", self.s_tribute_bowl.var_8f683ef8, 2);
					break;
				}
			}
			wpn_current = self getcurrentweapon();
			if(zm_weapons::is_weapon_upgraded(wpn_current))
			{
				var_c481f7e6 = randomint(1000);
				if(var_c481f7e6 <= 250)
				{
					self thread function_ae58bd73(self.s_tribute_bowl.var_8f683ef8);
					break;
				}
			}
			function_4071e6d();
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_4071e6d
	Namespace: namespace_f8f28e08
	Checksum: 0x1EDB6269
	Offset: 0x4240
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function function_4071e6d()
{
	var_c481f7e6 = randomint(1000);
	if(var_c481f7e6 < 166 && zm_custom::function_901b751c(#"zmequipmentisenabled"))
	{
		self thread function_e08e4c9c(#"zm_bgb_equip_mint", self.s_tribute_bowl.var_8f683ef8);
	}
	else
	{
		var_c481f7e6 = 1250;
		if(!zm_custom::function_901b751c(#"zmpowerupsactive"))
		{
			var_c481f7e6 = 250;
		}
		var_c481f7e6 = randomint(var_c481f7e6);
		if(var_c481f7e6 <= 250)
		{
			self thread function_e08e4c9c(#"zm_bgb_shields_up", self.s_tribute_bowl.var_8f683ef8);
		}
		else
		{
			if(var_c481f7e6 <= 500)
			{
				level thread function_445c5623("double_points", self.s_tribute_bowl.var_8f683ef8, 1);
			}
			else
			{
				if(var_c481f7e6 <= 750)
				{
					level thread function_445c5623("full_ammo", self.s_tribute_bowl.var_8f683ef8, 1);
				}
				else
				{
					if(var_c481f7e6 <= 1000)
					{
						level thread function_445c5623("fire_sale", self.s_tribute_bowl.var_8f683ef8, 1);
					}
					else
					{
						level thread function_445c5623("carpenter", self.s_tribute_bowl.var_8f683ef8, 1);
					}
				}
			}
		}
	}
}

/*
	Name: function_abd417dc
	Namespace: namespace_f8f28e08
	Checksum: 0x51C6E62C
	Offset: 0x4460
	Size: 0x25C
	Parameters: 3
	Flags: None
*/
function function_abd417dc(var_7ed75e97, var_5876e0e2 = undefined, b_upgraded = 1)
{
	self endon(#"death");
	if(isdefined(var_5876e0e2))
	{
		str_weapon_name = var_5876e0e2;
	}
	else
	{
		str_weapon_name = get_weapon(var_7ed75e97);
		if(!isdefined(str_weapon_name))
		{
			return;
		}
		if(isdefined(b_upgraded) && b_upgraded)
		{
			str_weapon_name = str_weapon_name + "_upgraded";
		}
	}
	var_78e5d9d1 = level.var_d5ba7324.origin + (vectorscale((0, 0, -1), 8));
	v_angles = (0, 0, 0);
	var_4d0b3b87 = zm_utility::spawn_buildkit_weapon_model(self, getweapon(str_weapon_name), undefined, var_78e5d9d1, v_angles);
	var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
	var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
	var_20abc870 = self.s_tribute_bowl.var_8f683ef8;
	n_power = length(var_4d0b3b87.origin - var_20abc870);
	var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(var_20abc870 + vectorscale((0, 0, 1), 50), n_power);
	wait(var_cef149e8);
	b_give_reward = self function_cdb9fba6(var_4d0b3b87, 0, 0, 1);
	if(b_give_reward)
	{
		self playsound(#"hash_1c696244a9a3dbbf");
		self function_e2a25377(str_weapon_name);
	}
}

/*
	Name: function_e08e4c9c
	Namespace: namespace_f8f28e08
	Checksum: 0x15BAE5CE
	Offset: 0x46C8
	Size: 0x2EC
	Parameters: 2
	Flags: Linked
*/
function function_e08e4c9c(str_bgb, var_8b84b3ce)
{
	if(!zm_custom::function_901b751c(#"zmelixirsenabled"))
	{
		return;
	}
	var_78e5d9d1 = level.var_d5ba7324.origin + (vectorscale((0, 0, -1), 8));
	v_angles = (0, 0, 0);
	switch(str_bgb)
	{
		case "zm_bgb_shields_up":
		{
			str_model = #"p8_zm_red_powerup_free_shield";
			n_scale = 0.3;
			break;
		}
		case "zm_bgb_equip_mint":
		default:
		{
			str_model = #"p8_zm_red_powerup_free_equiptment";
			n_scale = 0.45;
			break;
		}
	}
	var_4d0b3b87 = util::spawn_model(str_model, var_78e5d9d1, v_angles);
	var_4d0b3b87 setscale(n_scale);
	var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
	var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
	if(!isdefined(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = [];
	}
	else if(!isarray(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = array(level.var_d1c9bbc4);
	}
	level.var_d1c9bbc4[level.var_d1c9bbc4.size] = var_4d0b3b87;
	n_power = length(var_4d0b3b87.origin - var_8b84b3ce);
	var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(var_8b84b3ce, n_power);
	wait(var_cef149e8);
	e_player = level function_c45635c7(var_4d0b3b87, 1, 1, 1);
	if(isplayer(e_player))
	{
		e_player thread give_bgb(str_bgb);
		e_player playsound(#"hash_1c696244a9a3dbbf");
	}
}

/*
	Name: give_bgb
	Namespace: namespace_f8f28e08
	Checksum: 0xA9D36AEF
	Offset: 0x49C0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function give_bgb(var_de21c97b)
{
	if(isdefined(level.bgb[var_de21c97b].activation_func))
	{
		self thread bgb::run_activation_func(var_de21c97b);
	}
}

/*
	Name: function_445c5623
	Namespace: namespace_f8f28e08
	Checksum: 0xF8B0E698
	Offset: 0x4A08
	Size: 0x2D4
	Parameters: 3
	Flags: Linked
*/
function function_445c5623(var_aa4f9213, var_8b84b3ce, n_fx_type = 1)
{
	if(!zm_custom::function_901b751c(#"zmpowerupsactive"))
	{
		return;
	}
	var_78e5d9d1 = level.var_d5ba7324.origin + (vectorscale((0, 0, -1), 8));
	v_angles = (0, 0, 0);
	var_24a867e4 = function_ed4a5d52(var_aa4f9213);
	if(!isdefined(var_24a867e4))
	{
		return;
	}
	var_4d0b3b87 = util::spawn_model(var_24a867e4, var_78e5d9d1, v_angles);
	var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
	var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
	if(!isdefined(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = [];
	}
	else if(!isarray(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = array(level.var_d1c9bbc4);
	}
	level.var_d1c9bbc4[level.var_d1c9bbc4.size] = var_4d0b3b87;
	n_power = length(var_4d0b3b87.origin - var_8b84b3ce);
	var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(var_8b84b3ce + vectorscale((0, 0, 1), 50), n_power);
	wait(var_cef149e8);
	e_player = level function_c45635c7(var_4d0b3b87, 0, 1, n_fx_type);
	if(isplayer(e_player))
	{
		level thread zm_audio::sndannouncerplayvox(var_aa4f9213);
		e_player playsound(#"hash_1c696244a9a3dbbf");
		if(var_aa4f9213 == "self_revive")
		{
			e_player zm_laststand::function_3a00302e();
		}
		else
		{
			level [[level._custom_powerups[var_aa4f9213].grab_powerup]](e_player);
		}
	}
}

/*
	Name: function_ae58bd73
	Namespace: namespace_f8f28e08
	Checksum: 0x8D9D03EF
	Offset: 0x4CE8
	Size: 0x244
	Parameters: 1
	Flags: Linked
*/
function function_ae58bd73(var_8b84b3ce)
{
	self endon(#"death");
	var_78e5d9d1 = level.var_d5ba7324.origin + (vectorscale((0, 0, -1), 8));
	v_angles = (0, 0, 0);
	var_4d0b3b87 = util::spawn_model("p8_zm_powerup_aat", var_78e5d9d1, v_angles);
	var_4d0b3b87 playsound(#"hash_e3e5f7c83015171");
	var_4d0b3b87 playloopsound(#"hash_2adfa98b79668366");
	if(!isdefined(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = [];
	}
	else if(!isarray(level.var_d1c9bbc4))
	{
		level.var_d1c9bbc4 = array(level.var_d1c9bbc4);
	}
	level.var_d1c9bbc4[level.var_d1c9bbc4.size] = var_4d0b3b87;
	n_power = length(var_4d0b3b87.origin - var_8b84b3ce);
	var_cef149e8 = var_4d0b3b87 zm_utility::fake_physicslaunch(var_8b84b3ce, n_power);
	wait(var_cef149e8);
	e_player = level function_c45635c7(var_4d0b3b87, 1, 1, 1);
	if(isplayer(e_player))
	{
		weapon = e_player getcurrentweapon();
		e_player thread function_fc6ae19f();
		e_player playsound(#"hash_1c696244a9a3dbbf");
	}
}

/*
	Name: function_c45635c7
	Namespace: namespace_f8f28e08
	Checksum: 0x35919B32
	Offset: 0x4F38
	Size: 0x1E6
	Parameters: 4
	Flags: Linked
*/
function function_c45635c7(var_4d0b3b87, b_rotate, var_b9b24, n_fx_type = 1)
{
	var_4d0b3b87 thread pickup_timeout(undefined, "spew_reward_picked_up");
	var_4d0b3b87 thread function_f7cdf2f7(n_fx_type);
	if(isdefined(b_rotate) && b_rotate)
	{
		var_4d0b3b87 thread function_51fd2597(var_b9b24);
	}
	wait(2);
	while(!(isdefined(var_4d0b3b87.b_timeout) && var_4d0b3b87.b_timeout))
	{
		e_collision = undefined;
		a_players = getplayers();
		foreach(player in a_players)
		{
			n_dist = distance2d(player.origin, var_4d0b3b87.origin);
			if(n_dist < 25)
			{
				e_collision = player;
				break;
			}
		}
		if(isdefined(e_collision))
		{
			break;
		}
		waitframe(1);
	}
	b_timeout = var_4d0b3b87.b_timeout;
	var_4d0b3b87 delete();
	if(isdefined(b_timeout) && b_timeout)
	{
		return undefined;
	}
	return e_collision;
}

/*
	Name: function_cdb9fba6
	Namespace: namespace_f8f28e08
	Checksum: 0xBF8C4CD7
	Offset: 0x5128
	Size: 0x176
	Parameters: 4
	Flags: Linked
*/
function function_cdb9fba6(var_4d0b3b87, b_rotate, var_b9b24, n_fx_type = 1)
{
	self endon(#"death");
	var_4d0b3b87 thread pickup_timeout(self, "spew_reward_picked_up");
	if(isdefined(var_b9b24) && var_b9b24)
	{
		var_4d0b3b87 thread function_f7cdf2f7(n_fx_type);
	}
	if(isdefined(b_rotate) && b_rotate)
	{
		var_4d0b3b87 thread function_51fd2597(var_b9b24);
	}
	s_interact = var_4d0b3b87 zm_unitrigger::create(&function_3413bcb8, 64, &function_8b1e1959);
	self waittill(#"hash_543c12110d2418a8", #"spew_reward_picked_up");
	b_timeout = var_4d0b3b87.b_timeout;
	var_4d0b3b87 delete();
	zm_unitrigger::unregister_unitrigger(s_interact);
	if(isdefined(b_timeout) && b_timeout)
	{
		return false;
	}
	return true;
}

/*
	Name: function_3413bcb8
	Namespace: namespace_f8f28e08
	Checksum: 0x4DF96BBC
	Offset: 0x52A8
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_3413bcb8(e_player)
{
	if(!e_player zm_red_util::can_see(self.origin, 0, 0))
	{
		self sethintstringforplayer(e_player, "");
		return false;
	}
	str_prompt = zm_utility::function_d6046228(#"hash_42cb69becded0870", #"hash_648ba551adc3865c");
	self sethintstringforplayer(e_player, str_prompt);
	return true;
}

/*
	Name: function_8b1e1959
	Namespace: namespace_f8f28e08
	Checksum: 0x3B77139F
	Offset: 0x5368
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_8b1e1959()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		e_player notify(#"spew_reward_picked_up");
	}
}

/*
	Name: function_529e8585
	Namespace: namespace_f8f28e08
	Checksum: 0x92700E25
	Offset: 0x5400
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_529e8585(var_fd6264f6)
{
	self endon(#"powerup_timedout", #"powerup_stolen", #"death");
	self playsound(#"hash_e3e5f7c83015171");
	self playloopsound(#"hash_2adfa98b79668366");
	wait(var_fd6264f6);
	waitresult = undefined;
	waitresult = self waittill(#"powerup_grabbed");
	if(isdefined(waitresult.e_grabber) && isplayer(waitresult.e_grabber))
	{
		waitresult.e_grabber playsound(#"hash_1c696244a9a3dbbf");
	}
}

/*
	Name: function_50ce2afd
	Namespace: namespace_f8f28e08
	Checksum: 0x46EAC9B3
	Offset: 0x5510
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_50ce2afd()
{
	if(zm_red_challenges::is_challenge_active(8))
	{
		level notify(#"kill_with_god_hand", {#e_player:self});
	}
}

/*
	Name: function_bec5bf67
	Namespace: namespace_f8f28e08
	Checksum: 0x9B9F5592
	Offset: 0x5560
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_bec5bf67(type)
{
	if(#"bonus_points_player" === type)
	{
		return true;
	}
	return false;
}

