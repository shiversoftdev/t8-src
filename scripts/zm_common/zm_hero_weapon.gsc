// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_2dc48f46bfeac894;
#using script_301f64a4090c381a;
#using script_35d3717bf2cbee8f;
#using script_3f9e0dc8454d98e1;
#using script_47fb62300ac0bd60;
#using script_6e3c826b1814cab6;
#using script_9e4105ea1798ccc;
#using script_db06eb511bd9b36;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_hero_weapon;

/*
	Name: function_89f2df9
	Namespace: zm_hero_weapon
	Checksum: 0xC7E6F661
	Offset: 0x280
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_hero_weapons", &__init__, undefined, #"gadget_hero_weapon");
}

/*
	Name: __init__
	Namespace: zm_hero_weapon
	Checksum: 0x15973C56
	Offset: 0x2D0
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_c15ad546 = 1;
	level.var_a53a05b5 = 2;
	level.hero_power_update = &function_3fe4a02e;
	clientfield::register("clientuimodel", "zmhud.weaponLevel", 1, 2, "int");
	clientfield::register("clientuimodel", "zmhud.weaponProgression", 1, 5, "float");
	clientfield::register("clientuimodel", "zmhud.swordEnergy", 1, 7, "float");
	clientfield::register("clientuimodel", "zmhud.swordState", 1, 4, "int");
	clientfield::register("clientuimodel", "zmhud.swordChargeUpdate", 1, 1, "counter");
	level.var_5ee61f18 = [];
	level.var_2d52e9af = [];
	level.var_d5075025 = [];
	level.var_a1feaa28 = 1;
	if(namespace_59ff1d6c::function_901b751c(#"hash_2f03c6055447a6b1") == 2)
	{
		level.var_a1feaa28 = 2;
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_2f03c6055447a6b1") == 0)
	{
		level.var_a1feaa28 = 0.5;
	}
	ability_player::register_gadget_activation_callbacks(11, &hero_weapon_on, &hero_weapon_off);
	ability_player::register_gadget_ready_callbacks(11, &function_dec6d32d);
	/#
		level thread function_281b4073();
		level.var_124446e = &function_124446e;
	#/
	level.var_ff96c5e4 = 0;
	zm_armor::register(#"hash_5c9caf0397b30f1e", 0);
}

/*
	Name: function_281b4073
	Namespace: zm_hero_weapon
	Checksum: 0xA16A7CDB
	Offset: 0x560
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_281b4073()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_124446e
	Namespace: zm_hero_weapon
	Checksum: 0x6679C6D2
	Offset: 0x5A8
	Size: 0x20A
	Parameters: 1
	Flags: None
*/
function function_124446e(weapon_name)
{
	/#
		self.var_fd05e363 = getweapon(weapon_name);
		var_b4b7833b = getsubstr(weapon_name, weapon_name.size - 1, weapon_name.size);
		weapon_level = int(var_b4b7833b) - 1;
		self.var_72d6f15d = weapon_level;
		self function_23978edd();
		self clientfield::set_player_uimodel("", self.var_72d6f15d);
		self function_2264d131(self.var_fd05e363, 1);
		self.var_c9279111 = 0;
		self.var_821c9bf3 = 0;
		self.var_1bcf6a9e = 0;
		self.var_dc37311e = 0;
		self.var_da2f5f0b = 0;
		switch(self.var_72d6f15d)
		{
			case 0:
			{
				self.var_c09adff0 = 0;
				self.var_e77eadb7 = 0;
				self.var_ec334996 = 0;
				break;
			}
			case 1:
			{
				self.var_c09adff0 = 0;
				self.var_e77eadb7 = 1;
				self.var_ec334996 = function_c49bf808(2800);
				break;
			}
			case 2:
			{
				self.var_c09adff0 = 1;
				self.var_e77eadb7 = 1;
				self.var_ec334996 = function_c49bf808(8000);
				break;
			}
		}
	#/
}

/*
	Name: function_76505465
	Namespace: zm_hero_weapon
	Checksum: 0xA1DD8B8C
	Offset: 0x7C0
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_76505465(slot, enabled)
{
	if(isdefined(level.var_697a556f) && level.var_697a556f)
	{
		self function_19ed70ca(slot, 1);
	}
	else
	{
		self function_19ed70ca(slot, enabled);
	}
}

/*
	Name: function_416eaaa2
	Namespace: zm_hero_weapon
	Checksum: 0x5C6C0AD2
	Offset: 0x840
	Size: 0x1E4
	Parameters: 2
	Flags: Linked
*/
function function_416eaaa2(var_deaf10fb, var_ef230d21)
{
	if(self gadgetisactive(level.var_a53a05b5))
	{
		if(isdefined(self.talisman_special_xp_rate))
		{
			n_scalar = self.talisman_special_xp_rate;
		}
		else
		{
			n_scalar = 1;
		}
		if(isdefined(var_ef230d21))
		{
			self.var_821c9bf3 = self.var_821c9bf3 + (var_ef230d21 * n_scalar);
			self.var_41183060 = self.var_41183060 + (var_ef230d21 * n_scalar);
		}
		else
		{
			self.var_821c9bf3 = self.var_821c9bf3 + (1 * n_scalar);
			self.var_41183060 = self.var_41183060 + (1 * n_scalar);
		}
	}
	if(isdefined(level.var_697a556f) && level.var_697a556f && var_deaf10fb > 0 && !self gadgetisactive(level.var_a53a05b5))
	{
		current_power = self gadgetpowerget(level.var_a53a05b5);
		if(self hasperk(#"hash_301aaa36fae44a5c"))
		{
			var_deaf10fb = 0.15 * var_deaf10fb;
		}
		current_power = current_power + (level.var_a1feaa28 * (100 / var_deaf10fb));
		if(current_power > 100)
		{
			current_power = 100;
		}
		self gadgetpowerset(level.var_a53a05b5, current_power);
	}
}

/*
	Name: function_29f19e9a
	Namespace: zm_hero_weapon
	Checksum: 0x1D9B5994
	Offset: 0xA30
	Size: 0x2C4
	Parameters: 2
	Flags: Linked
*/
function function_29f19e9a(var_deaf10fb, n_points)
{
	if(self gadgetisactive(level.var_a53a05b5) || (isdefined(level.var_373ced84) && level.var_373ced84))
	{
		self.var_dc37311e = self.var_dc37311e + n_points;
		self.var_ec334996 = self.var_ec334996 + n_points;
	}
	if(isdefined(level.var_c15ad546) && level.var_c15ad546 && var_deaf10fb > 0 && !self gadgetisactive(level.var_a53a05b5))
	{
		current_power = self gadgetpowerget(level.var_a53a05b5);
		if(current_power == 100)
		{
			return;
		}
		var_f032086a = 0;
		if(self hasperk(#"hash_301aaa36fae44a5c"))
		{
			var_f032086a = var_f032086a + 0.15;
		}
		if(self bgb::is_enabled(#"zm_bgb_arsenal_accelerator"))
		{
			var_f032086a = var_f032086a + 0.15;
		}
		if(self namespace_e38c57c1::function_6a7a1533(5))
		{
			var_f032086a = var_f032086a + -0.2;
		}
		n_points = n_points + (n_points * var_f032086a);
		n_points = max(1, n_points);
		if(current_power == 0)
		{
			self.var_da2f5f0b = level.var_a1feaa28 * n_points;
		}
		else
		{
			var_d526977b = current_power / 100;
			self.var_da2f5f0b = var_deaf10fb * var_d526977b;
			self.var_da2f5f0b = self.var_da2f5f0b + (level.var_a1feaa28 * n_points);
		}
		self thread function_56d2c5d0(n_points);
		var_d526977b = self.var_da2f5f0b / var_deaf10fb;
		current_power = 100 * var_d526977b;
		if(current_power > 100)
		{
			current_power = 100;
		}
		self gadgetpowerset(level.var_a53a05b5, current_power);
	}
}

/*
	Name: function_56d2c5d0
	Namespace: zm_hero_weapon
	Checksum: 0x6F986DD4
	Offset: 0xD00
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function function_56d2c5d0(n_points)
{
	if(self.var_d11656b < 100)
	{
		self.var_184a3854 = self.var_184a3854 + n_points;
		if(self.var_184a3854 >= self.var_9f176816)
		{
			self.var_184a3854 = 0;
			level notify(#"hash_159486ad4746f53e", {#e_player:self});
			switch(self.var_72d6f15d)
			{
				case 1:
				{
					if(isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d]))
					{
						self.var_9f176816 = self.var_9f176816 + level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
					}
					else
					{
						self.var_9f176816 = self.var_9f176816 + 100;
					}
					break;
				}
				case 2:
				{
					if(isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d]))
					{
						self.var_9f176816 = self.var_9f176816 + level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
					}
					else
					{
						self.var_9f176816 = self.var_9f176816 + 150;
					}
					break;
				}
				default:
				{
					if(isdefined(level.var_d5075025[self.var_b708af7b]) && isdefined(level.var_d5075025[self.var_b708af7b][self.var_72d6f15d]))
					{
						self.var_9f176816 = self.var_9f176816 + level.var_d5075025[self.var_b708af7b][self.var_72d6f15d];
					}
					else
					{
						self.var_9f176816 = self.var_9f176816 + 50;
					}
					break;
				}
			}
			self.var_d11656b++;
		}
	}
}

/*
	Name: function_21c786cf
	Namespace: zm_hero_weapon
	Checksum: 0x68FC3AA3
	Offset: 0xF78
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_21c786cf()
{
	if(!isdefined(self.var_fd05e363))
	{
		self.var_fd05e363 = self zm_loadout::function_439b009a("herogadget");
		self.var_72d6f15d = 0;
		self.var_ec334996 = 0;
		if(isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3)
		{
			self function_45b7d6c1(2);
			self.var_c09adff0 = 1;
		}
		if(isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2)
		{
			self function_45b7d6c1(1);
			self.var_e77eadb7 = 1;
		}
		self function_23978edd();
		if(isdefined(self.talisman_special_startlv2) && self.talisman_special_startlv2)
		{
			if(isdefined(level.var_5ee61f18[self.var_b708af7b]))
			{
				self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][1];
			}
			else
			{
				self.var_ec334996 = function_c49bf808(2800);
			}
		}
		if(isdefined(self.talisman_special_startlv3) && self.talisman_special_startlv3)
		{
			if(isdefined(level.var_5ee61f18[self.var_b708af7b]))
			{
				self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][2];
			}
			else
			{
				self.var_ec334996 = function_c49bf808(8000);
			}
		}
		self.var_41183060 = 0;
		self.var_821c9bf3 = 0;
		self.var_c9279111 = 0;
		self.var_dc37311e = 0;
		self.var_1bcf6a9e = 0;
		self.var_da2f5f0b = 0;
		self.var_184a3854 = 0;
		self.var_d11656b = 0;
		self.var_9cef1b1e = 0;
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_b066c34278e6394"))
	{
		self function_2264d131(self.var_fd05e363, 0);
		if(self.var_fd05e363.isgadget)
		{
			slot = self gadgetgetslot(self.var_fd05e363);
			var_aabc1f49 = (isdefined(self.firstspawn) ? self.firstspawn : 1);
			if(slot >= 0 && var_aabc1f49)
			{
				self gadgetpowerreset(slot, 1);
			}
		}
	}
}

/*
	Name: function_f8bf706f
	Namespace: zm_hero_weapon
	Checksum: 0x2A458A27
	Offset: 0x1280
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function function_f8bf706f()
{
	self.var_41183060 = 0;
	self.var_821c9bf3 = 0;
	self.var_c9279111 = 0;
	self.var_dc37311e = 0;
	self.var_1bcf6a9e = 0;
	self.var_da2f5f0b = 0;
	self.var_184a3854 = 0;
	self.var_d11656b = 0;
	self.var_9cef1b1e = 0;
	if(namespace_59ff1d6c::function_901b751c(#"hash_b066c34278e6394"))
	{
		self function_2264d131(self.var_fd05e363, 0);
		if(self.var_fd05e363.isgadget)
		{
			n_slot = self gadgetgetslot(self.var_fd05e363);
			self gadgetpowerreset(n_slot, 0);
		}
	}
}

/*
	Name: function_fecb38dd
	Namespace: zm_hero_weapon
	Checksum: 0x843E03FC
	Offset: 0x1390
	Size: 0xFA
	Parameters: 1
	Flags: None
*/
function function_fecb38dd(n_level = 3)
{
	if(isdefined(level.var_5ee61f18[self.var_b708af7b]))
	{
		self.var_ec334996 = level.var_5ee61f18[self.var_b708af7b][n_level - 1];
	}
	else
	{
		switch(n_level)
		{
			case 3:
			{
				self.var_ec334996 = function_c49bf808(8000);
				break;
			}
			case 2:
			{
				self.var_ec334996 = function_c49bf808(2800);
				break;
			}
			case 1:
			default:
			{
				self.var_ec334996 = 0;
			}
		}
	}
}

/*
	Name: function_23978edd
	Namespace: zm_hero_weapon
	Checksum: 0x818CC32B
	Offset: 0x1498
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function function_23978edd()
{
	foreach(var_809d5856, a_weaponlist in level.hero_weapon)
	{
		if(isinarray(a_weaponlist, self.var_fd05e363))
		{
			self.var_fd05e363 = a_weaponlist[self.var_72d6f15d];
			self.var_b708af7b = var_809d5856;
			return;
		}
	}
	if(zm_utility::function_166646a6() == 1)
	{
		self.var_fd05e363 = level.hero_weapon[#"gravityspikes"][self.var_72d6f15d];
		self.var_b708af7b = "gravityspikes";
	}
	else
	{
		self.var_fd05e363 = level.hero_weapon[#"chakram"][self.var_72d6f15d];
		self.var_b708af7b = "chakram";
	}
}

/*
	Name: function_2264d131
	Namespace: zm_hero_weapon
	Checksum: 0xF09F6B86
	Offset: 0x15E8
	Size: 0x356
	Parameters: 3
	Flags: Linked
*/
function function_2264d131(weapon, enabled, var_b94ec3d9 = 0)
{
	if(!isdefined(self) || !isdefined(weapon))
	{
		return;
	}
	if(!self hasweapon(weapon))
	{
		if(isdefined(self._gadgets_player) && isdefined(self._gadgets_player[level.var_a53a05b5]))
		{
			self notify(#"hash_479bfafd386e9994", {#weapon:self._gadgets_player[level.var_a53a05b5]});
			self takeweapon(self._gadgets_player[level.var_a53a05b5]);
		}
		self zm_loadout::set_player_hero_weapon(weapon);
		self.var_fd05e363 = weapon;
		self notify(#"hash_3ea6a76d799083d6", {#weapon:weapon});
		self giveweapon(weapon);
		self thread function_ac9f4b22();
		if(isdefined(level.var_373ced84) && level.var_373ced84)
		{
		}
		else
		{
			if(enabled)
			{
				self gadgetpowerset(level.var_a53a05b5, 100);
				self gadgetcharging(level.var_a53a05b5, 0);
				self function_76505465(level.var_a53a05b5, 0);
			}
			else
			{
				if(isdefined(var_b94ec3d9) && var_b94ec3d9)
				{
					level thread function_3fe4a02e(self, 1);
				}
				else
				{
					self gadgetpowerset(level.var_a53a05b5, 0);
				}
				self gadgetcharging(level.var_a53a05b5, 0);
				self function_76505465(level.var_a53a05b5, 0);
			}
		}
		function_1297aefe(weapon);
	}
	else if(enabled && (!(isdefined(level.var_373ced84) && level.var_373ced84)))
	{
		self gadgetpowerset(level.var_a53a05b5, 100);
		self gadgetcharging(level.var_a53a05b5, 0);
		self function_76505465(level.var_a53a05b5, 0);
		self.var_821c9bf3 = 0;
		self.var_dc37311e = 0;
		self.var_da2f5f0b = 0;
	}
}

/*
	Name: function_1297aefe
	Namespace: zm_hero_weapon
	Checksum: 0xE0A0BAD9
	Offset: 0x1948
	Size: 0x2B4
	Parameters: 1
	Flags: Linked
*/
function function_1297aefe(weapon)
{
	var_328c1d6e = array(#"hero_chakram_lv3", #"hero_hammer_lv3", #"hash_50f35c4cfb775a9c", #"hero_sword_pistol_lv3", #"hash_18829f56b3fbdac1", #"hash_1d3a5309fa2c9b80", #"hash_6627899099b8a69d", #"hash_74dd69dd8a46d4aa");
	i = 0;
	var_8e233987 = [];
	do
	{
		weapon_name = self stats::get_stat(#"hash_3da32e638bd332a5", i);
		if(isdefined(weapon_name) && weapon_name)
		{
			if(!isdefined(var_8e233987))
			{
				var_8e233987 = [];
			}
			else if(!isarray(var_8e233987))
			{
				var_8e233987 = array(var_8e233987);
			}
			if(!isinarray(var_8e233987, hash(weapon_name)))
			{
				var_8e233987[var_8e233987.size] = hash(weapon_name);
			}
			i++;
		}
		else
		{
			break;
		}
	}
	while(i < 8);
	if(isinarray(var_328c1d6e, weapon.name))
	{
		if(!isinarray(var_8e233987, weapon.name))
		{
			if(!isdefined(var_8e233987))
			{
				var_8e233987 = [];
			}
			else if(!isarray(var_8e233987))
			{
				var_8e233987 = array(var_8e233987);
			}
			var_8e233987[var_8e233987.size] = weapon.name;
			stats::set_stat(#"hash_3da32e638bd332a5", i, weapon.name);
		}
	}
	var_a3cdb465 = array::exclude(var_328c1d6e, var_8e233987);
	if(!var_a3cdb465.size)
	{
		self zm_utility::giveachievement_wrapper("zm_trophy_jack_of_all_blades");
	}
}

/*
	Name: hero_weapon_on
	Namespace: zm_hero_weapon
	Checksum: 0xCF130782
	Offset: 0x1C08
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function hero_weapon_on(n_slot, w_hero)
{
	self notify(#"hero_weapon_power_on");
	self addweaponstat(w_hero, #"used", 1);
	level.var_ff96c5e4 = 1;
	self.var_479965f7 = 1;
	level notify(#"hash_2eed9998dba1b252", {#weapon:w_hero, #e_player:self});
	self notify(#"hash_2eed9998dba1b252");
	self thread zm_audio::function_cb8103f6(w_hero);
	self thread function_60878f7f(w_hero);
	self zm_stats::increment_client_stat("special_weapon_used");
	self zm_stats::increment_player_stat("special_weapon_used");
	self zm_stats::function_8f10788e("boas_special_weapon_used");
}

/*
	Name: hero_weapon_off
	Namespace: zm_hero_weapon
	Checksum: 0x1F3445A
	Offset: 0x1D60
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function hero_weapon_off(n_slot, w_hero)
{
	self endon(#"death", #"hero_weapon_power_on");
	self.var_479965f7 = undefined;
	wait(2);
	self notify(#"hero_weapon_power_off");
	w_current = self getcurrentweapon();
	self zm_weapons::switch_back_primary_weapon(w_current, 0, 1);
}

/*
	Name: function_dec6d32d
	Namespace: zm_hero_weapon
	Checksum: 0xCC310A0D
	Offset: 0x1E08
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function function_dec6d32d(n_slot, w_hero)
{
	self thread zm_audio::function_2d93d659(w_hero);
	if(bgb::is_enabled(#"zm_bgb_arsenal_accelerator"))
	{
		self zm_stats::increment_challenge_stat(#"hash_1f20f53b7084fdcb");
	}
	if(zm_utility::is_standard())
	{
		level thread zm_audio::sndannouncerplayvox(#"hash_3fee8792a6abec06", self, undefined, undefined, 1);
	}
}

/*
	Name: function_9a100883
	Namespace: zm_hero_weapon
	Checksum: 0xA6EAAAE8
	Offset: 0x1EC0
	Size: 0x1CE
	Parameters: 2
	Flags: Linked
*/
function function_9a100883(weapon_level, enabled)
{
	self notify(#"hash_6b01968912321cc5");
	self endon(#"hash_6b01968912321cc5", #"disconnect");
	self.var_39b77a76 = 1;
	self.var_c9279111 = 0;
	self.var_821c9bf3 = 0;
	self.var_dc37311e = 0;
	while(self gadgetisactive(level.var_a53a05b5) || (isdefined(self.var_fbe120be) && self.var_fbe120be) || (isdefined(self.var_61950f95) && self.var_61950f95))
	{
		wait(1);
	}
	self waittilltimeout(2, #"weapon_change_complete");
	self playsound("zmb_weapon_upgrade_to_lvl_" + (weapon_level + 1));
	self function_45b7d6c1(weapon_level);
	self function_2264d131(level.hero_weapon[self.var_b708af7b][weapon_level], enabled, 1);
	self.var_da2f5f0b = 0;
	/#
		self zm_challenges::debug_print("");
	#/
	self zm_stats::increment_challenge_stat(#"hash_4182a6e5bc52ba9");
	self.var_39b77a76 = undefined;
}

/*
	Name: function_6bba3829
	Namespace: zm_hero_weapon
	Checksum: 0xACFECC10
	Offset: 0x2098
	Size: 0x4A4
	Parameters: 2
	Flags: None
*/
function function_6bba3829(e_player, ai_enemy)
{
	/#
		var_ea65bd9c = getdvarstring(#"hash_16e05c0b86ebb83d", "");
		if(var_ea65bd9c == "")
		{
			return;
		}
	#/
	if(isdefined(e_player.var_80612bea) && e_player.var_80612bea)
	{
		return;
	}
	if(isdefined(ai_enemy) && isdefined(ai_enemy.var_ab8f2b90))
	{
		var_ef230d21 = ai_enemy.var_ab8f2b90;
	}
	if(isdefined(e_player.var_b708af7b) && isdefined(level.var_5ee61f18[e_player.var_b708af7b]))
	{
		var_4c37bfce = level.var_5ee61f18[e_player.var_b708af7b][0];
		var_c4937b1a = level.var_5ee61f18[e_player.var_b708af7b][1];
		var_75f1042 = level.var_5ee61f18[e_player.var_b708af7b][2];
	}
	else
	{
		var_4c37bfce = 0;
		var_c4937b1a = 2;
		var_75f1042 = 4;
	}
	if(isdefined(e_player.var_b708af7b) && isdefined(level.var_2d52e9af[e_player.var_b708af7b]))
	{
		var_7b0b50c2 = level.var_2d52e9af[e_player.var_b708af7b][0];
		var_9e2d281a = level.var_2d52e9af[e_player.var_b708af7b][1];
		var_ad6f4a1 = level.var_2d52e9af[e_player.var_b708af7b][2];
	}
	else
	{
		var_7b0b50c2 = 25;
		var_9e2d281a = 40;
		var_ad6f4a1 = 60;
	}
	if(e_player.var_41183060 >= var_75f1042)
	{
		e_player function_416eaaa2(var_ad6f4a1, var_ef230d21);
	}
	else
	{
		if(e_player.var_41183060 >= var_c4937b1a)
		{
			e_player function_416eaaa2(var_9e2d281a, var_ef230d21);
			e_player.var_c9279111 = e_player.var_821c9bf3 / (var_75f1042 - var_c4937b1a);
		}
		else
		{
			if(e_player.var_41183060 >= var_4c37bfce)
			{
				e_player function_416eaaa2(var_7b0b50c2, var_ef230d21);
				e_player.var_c9279111 = e_player.var_821c9bf3 / (var_c4937b1a - var_4c37bfce);
			}
			else
			{
				e_player function_416eaaa2(0, var_ef230d21);
				e_player.var_c9279111 = e_player.var_821c9bf3 / var_4c37bfce;
			}
		}
	}
	if(!isdefined(e_player.var_c09adff0))
	{
		e_player.var_c09adff0 = 0;
	}
	if(!isdefined(e_player.var_e77eadb7))
	{
		e_player.var_e77eadb7 = 0;
	}
	if(e_player.var_41183060 >= var_75f1042 && !e_player.var_c09adff0 && e_player.var_e77eadb7)
	{
		e_player.var_c09adff0 = 1;
		e_player function_9a100883(2, 0);
	}
	else if(e_player.var_41183060 >= var_c4937b1a && !e_player.var_c09adff0 && !e_player.var_e77eadb7)
	{
		e_player.var_e77eadb7 = 1;
		e_player function_9a100883(1, 0);
	}
	e_player function_1164ba7b(e_player.var_c9279111);
	e_player clientfield::set_player_uimodel("zmhud.swordState", 1);
}

/*
	Name: function_3fe4a02e
	Namespace: zm_hero_weapon
	Checksum: 0xB9845255
	Offset: 0x2548
	Size: 0x644
	Parameters: 3
	Flags: Linked
*/
function function_3fe4a02e(e_player, n_points, str_event)
{
	/#
		var_ea65bd9c = getdvarstring(#"hash_16e05c0b86ebb83d", "");
		if(var_ea65bd9c == "")
		{
			return;
		}
	#/
	if(!isdefined(e_player))
	{
		return;
	}
	if(isdefined(e_player.var_80612bea) && e_player.var_80612bea || isentity(n_points))
	{
		return;
	}
	if(isdefined(str_event) && (!(isdefined(level.var_f03084a6) && level.var_f03084a6)))
	{
		switch(str_event)
		{
			case "carpenter_powerup":
			case "nuke_powerup":
			case "bonus_points_powerup_shared":
			case "bonus_points_powerup":
			{
				return;
			}
		}
	}
	var_3b6d16dd = zm_score::get_points_multiplier(e_player);
	if(!(isdefined(level.var_f03084a6) && level.var_f03084a6) && var_3b6d16dd > 1)
	{
		n_points = n_points / var_3b6d16dd;
	}
	if(isdefined(e_player.talisman_special_xp_rate))
	{
		n_scalar = e_player.talisman_special_xp_rate;
	}
	else
	{
		n_scalar = 1;
	}
	if(isdefined(e_player.var_b708af7b) && isdefined(level.var_5ee61f18) && isdefined(level.var_5ee61f18[e_player.var_b708af7b]))
	{
		var_8fcb23d5 = floor(level.var_5ee61f18[e_player.var_b708af7b][0] / n_scalar);
		var_43877f76 = floor(level.var_5ee61f18[e_player.var_b708af7b][1] / n_scalar);
		var_e058d658 = floor(level.var_5ee61f18[e_player.var_b708af7b][2] / n_scalar);
	}
	else
	{
		var_8fcb23d5 = floor(0 / n_scalar);
		var_43877f76 = floor(function_c49bf808(2800) / n_scalar);
		var_e058d658 = floor(function_c49bf808(8000) / n_scalar);
	}
	if(isdefined(e_player.var_b708af7b) && isdefined(level.var_33ab792f) && isdefined(level.var_2d52e9af[e_player.var_b708af7b]))
	{
		if(!isdefined(e_player.var_9f176816))
		{
			e_player.var_9f176816 = level.var_2d52e9af[e_player.var_b708af7b];
		}
	}
	else if(!isdefined(e_player.var_9f176816))
	{
		e_player.var_9f176816 = 3000;
	}
	if(!isdefined(e_player.var_ec334996))
	{
		e_player.var_ec334996 = 0;
	}
	if(!isdefined(e_player.var_dc37311e))
	{
		e_player.var_dc37311e = 0;
	}
	if(e_player.var_ec334996 >= var_43877f76)
	{
		e_player.var_1bcf6a9e = e_player.var_dc37311e / (var_e058d658 - var_43877f76);
	}
	else
	{
		if(e_player.var_ec334996 >= var_8fcb23d5)
		{
			e_player.var_1bcf6a9e = e_player.var_dc37311e / (var_43877f76 - var_8fcb23d5);
		}
		else
		{
			e_player.var_1bcf6a9e = e_player.var_dc37311e / var_8fcb23d5;
		}
	}
	var_cf7a6381 = e_player.var_9f176816;
	e_player function_29f19e9a(var_cf7a6381, n_points);
	if(!isdefined(e_player.var_c09adff0))
	{
		e_player.var_c09adff0 = 0;
	}
	if(!isdefined(e_player.var_e77eadb7))
	{
		e_player.var_e77eadb7 = 0;
	}
	if(e_player.var_ec334996 >= var_e058d658 && !e_player.var_c09adff0 && e_player.var_e77eadb7)
	{
		e_player.var_c09adff0 = 1;
		e_player function_9a100883(2, 0);
	}
	else if(e_player.var_ec334996 >= var_43877f76 && !e_player.var_c09adff0 && !e_player.var_e77eadb7)
	{
		e_player.var_e77eadb7 = 1;
		e_player function_9a100883(1, 0);
	}
	if(!(isdefined(e_player.var_39b77a76) && e_player.var_39b77a76))
	{
		e_player function_1164ba7b(e_player.var_1bcf6a9e);
		e_player clientfield::set_player_uimodel("zmhud.swordState", 1);
	}
}

/*
	Name: function_1164ba7b
	Namespace: zm_hero_weapon
	Checksum: 0xC8DB8A01
	Offset: 0x2B98
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_1164ba7b(n_progress)
{
	if(self.var_72d6f15d === 2)
	{
		self clientfield::set_player_uimodel("zmhud.weaponProgression", 1);
	}
	else
	{
		self clientfield::set_player_uimodel("zmhud.weaponProgression", n_progress);
	}
}

/*
	Name: function_45b7d6c1
	Namespace: zm_hero_weapon
	Checksum: 0x1877D3E1
	Offset: 0x2C08
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_45b7d6c1(n_level)
{
	if(self.var_72d6f15d < n_level)
	{
		self.var_72d6f15d = n_level;
		self clientfield::set_player_uimodel("zmhud.weaponLevel", n_level);
	}
}

/*
	Name: function_7a394ec4
	Namespace: zm_hero_weapon
	Checksum: 0x2F734CA4
	Offset: 0x2C58
	Size: 0x8C
	Parameters: 4
	Flags: Linked
*/
function function_7a394ec4(str_name, var_1a4d3b35, var_1cf44083, var_9d17c0c8)
{
	level.var_5ee61f18[str_name] = [];
	level.var_5ee61f18[str_name][0] = var_1a4d3b35;
	level.var_5ee61f18[str_name][1] = var_1cf44083;
	level.var_5ee61f18[str_name][2] = var_9d17c0c8;
}

/*
	Name: function_53cdfacf
	Namespace: zm_hero_weapon
	Checksum: 0xD4456814
	Offset: 0x2CF0
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function function_53cdfacf(str_name, var_75025dbf)
{
	level.var_2d52e9af[str_name] = [];
	level.var_2d52e9af[str_name] = var_75025dbf;
}

/*
	Name: function_5ccf482
	Namespace: zm_hero_weapon
	Checksum: 0xDB80207C
	Offset: 0x2D40
	Size: 0x8C
	Parameters: 4
	Flags: None
*/
function function_5ccf482(str_name, var_a986aaed, var_f2bbbd56, var_503e1e6)
{
	level.var_d5075025[str_name] = [];
	level.var_d5075025[str_name][0] = var_a986aaed;
	level.var_d5075025[str_name][1] = var_f2bbbd56;
	level.var_d5075025[str_name][2] = var_503e1e6;
}

/*
	Name: function_60878f7f
	Namespace: zm_hero_weapon
	Checksum: 0x6855C310
	Offset: 0x2DD8
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_60878f7f(w_weapon)
{
	self notify(#"hash_5ef1cf6d910b343b");
	self endon(#"hash_5ef1cf6d910b343b", #"hash_479bfafd386e9994", #"disconnect", #"weapon_change");
	var_a01a1f92 = w_weapon.var_e4109b63;
	var_bcf2cdde = w_weapon.var_fb22040b;
	if(isdefined(var_a01a1f92) && var_a01a1f92 > 0)
	{
		var_e3108f57 = self gadgetpowerget(level.var_a53a05b5);
		while(true)
		{
			var_a5be660b = self gadgetpowerget(level.var_a53a05b5);
			if(var_e3108f57 > var_a01a1f92 && var_a5be660b <= var_a01a1f92)
			{
				self playsound(var_bcf2cdde);
				return;
			}
			var_e3108f57 = var_a5be660b;
			wait(0.1);
		}
	}
}

/*
	Name: function_ac9f4b22
	Namespace: zm_hero_weapon
	Checksum: 0x8CF71E95
	Offset: 0x2F30
	Size: 0x372
	Parameters: 0
	Flags: Linked
*/
function function_ac9f4b22()
{
	self endon(#"hash_479bfafd386e9994", #"disconnect");
	while(true)
	{
		s_notify = undefined;
		s_notify = self waittill(#"weapon_change");
		w_current = s_notify.weapon;
		w_previous = s_notify.last_weapon;
		if(isdefined(self.var_479965f7) && self.var_479965f7 && (w_current == level.weaponnone || w_previous == level.weaponnone))
		{
			if(w_current == level.weaponnone && zm_loadout::is_hero_weapon(w_previous))
			{
				var_a88b79c6 = w_previous;
			}
			else
			{
				var_a88b79c6 = undefined;
			}
			continue;
		}
		if(zm_loadout::is_hero_weapon(w_current))
		{
			self thread function_cab29b9f();
			self.var_45ce0c21 = 0;
			a_ai_targets = getaispeciesarray(level.zombie_team, "all");
			a_ai_targets = arraysortclosest(a_ai_targets, self getorigin(), a_ai_targets.size, 0, 160);
			a_ai_targets = array::remove_dead(a_ai_targets);
			a_ai_targets = array::remove_undefined(a_ai_targets);
			array::thread_all(a_ai_targets, &function_c2dea172, self, w_current);
			if(isdefined(self.var_bacee63b) && self.var_bacee63b)
			{
				self thread zm_armor::add(#"hash_5c9caf0397b30f1e", 100, 100);
			}
			else
			{
				self thread zm_armor::add(#"hash_5c9caf0397b30f1e", 50, 50);
			}
		}
		else if(zm_loadout::is_hero_weapon(w_previous) || (w_previous == level.weaponnone && isdefined(var_a88b79c6)))
		{
			if(isdefined(var_a88b79c6))
			{
				w_previous = var_a88b79c6;
			}
			var_a88b79c6 = undefined;
			if(!(isdefined(self.var_bacee63b) && self.var_bacee63b))
			{
				self thread zm_armor::remove(#"hash_5c9caf0397b30f1e", 1);
			}
			if(w_current != level.weaponnone)
			{
				self thread function_a1004d47();
			}
		}
		self notify(#"hash_219c7081783c2153", {#last_weapon:w_previous, #weapon:w_current});
	}
}

/*
	Name: function_a1004d47
	Namespace: zm_hero_weapon
	Checksum: 0xBAB6272E
	Offset: 0x32B0
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a1004d47()
{
	self endon(#"death");
	self.var_1f23fe79 = 1;
	self function_29e4516d();
	self waittilltimeout(2, #"weapon_change_complete");
	self notify(#"hash_3eaa776332738598");
	self.var_1f23fe79 = undefined;
}

/*
	Name: function_29e4516d
	Namespace: zm_hero_weapon
	Checksum: 0x6C6245DD
	Offset: 0x3338
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_29e4516d()
{
	if(isdefined(self.var_c09e6d59) && self.var_c09e6d59)
	{
		return;
	}
	n_power = self gadgetpowerget(level.var_a53a05b5);
	is_deployed = self function_36dfc05f(level.var_a53a05b5);
	if(n_power > 50 && !is_deployed)
	{
		self gadgetpowerset(level.var_a53a05b5, 50);
	}
}

/*
	Name: function_9f3a3d48
	Namespace: zm_hero_weapon
	Checksum: 0x2460D360
	Offset: 0x33F0
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9f3a3d48()
{
	return namespace_6b49f66b::is_active(1) || namespace_fc5170d1::is_active();
}

/*
	Name: function_cab29b9f
	Namespace: zm_hero_weapon
	Checksum: 0x821DEEBD
	Offset: 0x3430
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_cab29b9f()
{
	self endon(#"disconnect");
	if(function_9f3a3d48())
	{
		return;
	}
	self val::set(#"hash_558d809e7921fa79", "takedamage", 0);
	wait(0.5);
	self val::reset(#"hash_558d809e7921fa79", "takedamage");
}

/*
	Name: function_c2dea172
	Namespace: zm_hero_weapon
	Checksum: 0xE7E457AC
	Offset: 0x34C8
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_c2dea172(player, w_hero)
{
	self endon(#"death");
	if(function_9f3a3d48() || (isdefined(self.marked_for_death) && self.marked_for_death))
	{
		return;
	}
	if(self.var_6f84b820 === #"popcorn")
	{
		self zm_cleanup::function_23621259();
		self.var_2f68be48 = 1;
		self dodamage(self.health + 100, player.origin, player, player, "torso_lower", "MOD_IMPACT", 0, w_hero);
	}
	else
	{
		if(isdefined(self.var_2f68be48) && self.var_2f68be48)
		{
			self.marked_for_death = 1;
			self zm_cleanup::function_23621259();
			v_fling = ((self.origin - player.origin) * 1.5) + ((0, 0, 1) * 64);
			self zm_utility::function_ffc279(v_fling, player, undefined, w_hero);
		}
		else
		{
			self thread function_acee2761();
		}
	}
}

/*
	Name: show_hint
	Namespace: zm_hero_weapon
	Checksum: 0xD422A5DA
	Offset: 0x3668
	Size: 0x11E
	Parameters: 3
	Flags: Linked
*/
function show_hint(w_hero, str_hint, var_bdc24d5f = 0)
{
	if(!isdefined(self.var_2a2832c6))
	{
		self.var_2a2832c6 = [];
	}
	if(!(isdefined(self.var_2a2832c6[w_hero.name]) && self.var_2a2832c6[w_hero.name]))
	{
		/#
			if(isdefined(self.hintelem))
			{
				self.hintelem settext("");
				self.hintelem destroy();
			}
		#/
		if(var_bdc24d5f)
		{
			n_hint_time = 5;
		}
		else
		{
			n_hint_time = 3;
		}
		self thread zm_equipment::show_hint_text(str_hint, n_hint_time);
		self.var_2a2832c6[w_hero.name] = 1;
	}
}

/*
	Name: function_acee2761
	Namespace: zm_hero_weapon
	Checksum: 0xFE8E1A33
	Offset: 0x3790
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_acee2761(n_cooldown = 4)
{
	if(!isalive(self))
	{
		return;
	}
	self endon(#"death");
	if(!(isdefined(self.var_28aab32a) && self.var_28aab32a))
	{
		return;
	}
	if(isdefined(self.var_9c494830) && self.var_9c494830)
	{
		return;
	}
	self.var_9c494830 = 1;
	self ai::stun();
	wait(n_cooldown);
	self.var_9c494830 = 0;
}

/*
	Name: function_4e984e83
	Namespace: zm_hero_weapon
	Checksum: 0x4A5384FE
	Offset: 0x3848
	Size: 0xCE
	Parameters: 3
	Flags: Linked
*/
function function_4e984e83(w_hero, var_cd2d38a0 = 0.35, var_7ebb048f = 0.15)
{
	self endon(#"death");
	self ability_player::function_c22f319e(w_hero);
	wait(var_cd2d38a0);
	self.var_1d940ef6 = 1;
	self hideviewmodel();
	self waittill(#"weapon_change");
	wait(var_7ebb048f);
	self showviewmodel();
	self.var_1d940ef6 = undefined;
}

/*
	Name: function_c49bf808
	Namespace: zm_hero_weapon
	Checksum: 0x25428E33
	Offset: 0x3920
	Size: 0xCE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c49bf808(var_14d0b7ab)
{
	switch(level.players.size)
	{
		case 1:
		{
			var_a7041269 = var_14d0b7ab * 1.4;
			break;
		}
		case 2:
		{
			var_a7041269 = var_14d0b7ab * 1.3;
			break;
		}
		case 3:
		{
			var_a7041269 = var_14d0b7ab * 1.2;
			break;
		}
		case 4:
		default:
		{
			var_a7041269 = var_14d0b7ab;
			break;
		}
	}
	return var_a7041269;
}

/*
	Name: function_1bb7f7b1
	Namespace: zm_hero_weapon
	Checksum: 0xCDEB012D
	Offset: 0x39F8
	Size: 0x1AC
	Parameters: 1
	Flags: None
*/
function function_1bb7f7b1(n_level)
{
	if(!isdefined(self.var_fd05e363))
	{
		self.var_fd05e363 = self zm_loadout::function_439b009a("herogadget");
	}
	self function_45b7d6c1(n_level - 1);
	self function_23978edd();
	self.var_c9279111 = 0;
	self.var_821c9bf3 = 0;
	self.var_1bcf6a9e = 0;
	self.var_dc37311e = 0;
	self.var_da2f5f0b = 0;
	switch(self.var_72d6f15d)
	{
		case 0:
		{
			self.var_c09adff0 = 0;
			self.var_e77eadb7 = 0;
			self.var_ec334996 = 0;
			break;
		}
		case 1:
		{
			self.var_c09adff0 = 0;
			self.var_e77eadb7 = 1;
			self.var_ec334996 = function_c49bf808(2800);
			break;
		}
		case 2:
		{
			self.var_c09adff0 = 1;
			self.var_e77eadb7 = 1;
			self.var_ec334996 = function_c49bf808(8000);
			break;
		}
	}
	self function_2264d131(self.var_fd05e363, 1);
}

/*
	Name: function_7c3681f7
	Namespace: zm_hero_weapon
	Checksum: 0xA09C5357
	Offset: 0x3BB0
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_7c3681f7()
{
	var_25e2354 = function_4d8c71ce();
	var_72714481 = getaispeciesarray(level.zombie_team, "all");
	a_e_targets = arraycombine(var_72714481, var_25e2354, 0, 0);
	if(isarray(level.var_2c19331b))
	{
		arrayremovevalue(level.var_2c19331b, undefined);
		a_e_targets = arraycombine(level.var_2c19331b, a_e_targets, 0, 0);
	}
	var_f7c84239 = [];
	foreach(target in a_e_targets)
	{
		if(!(isdefined(target.var_6353e3f1) && target.var_6353e3f1))
		{
			if(!isdefined(var_f7c84239))
			{
				var_f7c84239 = [];
			}
			else if(!isarray(var_f7c84239))
			{
				var_f7c84239 = array(var_f7c84239);
			}
			var_f7c84239[var_f7c84239.size] = target;
		}
	}
	return var_f7c84239;
}

/*
	Name: function_7eabd65d
	Namespace: zm_hero_weapon
	Checksum: 0xF7BFF8C2
	Offset: 0x3D68
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function function_7eabd65d(weapon)
{
	if(!isdefined(level.var_25d0c843))
	{
		level.var_25d0c843 = [];
	}
	else if(!isarray(level.var_25d0c843))
	{
		level.var_25d0c843 = array(level.var_25d0c843);
	}
	if(!isinarray(level.var_25d0c843, weapon))
	{
		level.var_25d0c843[level.var_25d0c843.size] = weapon;
	}
}

/*
	Name: function_6a32b8f
	Namespace: zm_hero_weapon
	Checksum: 0xC423471
	Offset: 0x3E28
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_6a32b8f(weapon)
{
	return isarray(level.var_25d0c843) && isinarray(level.var_25d0c843, weapon);
}

