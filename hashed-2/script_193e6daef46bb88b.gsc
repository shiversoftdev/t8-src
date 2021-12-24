// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\perks.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;

#namespace namespace_32e300a;

/*
	Name: function_89f2df9
	Namespace: namespace_32e300a
	Checksum: 0xC37F4E75
	Offset: 0x1B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_20ba676676b7bccf", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_32e300a
	Checksum: 0xF0AC11AE
	Offset: 0x1F8
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_55539d0cf92a8855", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_13ccfca7b26cec97", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_7e2af117e18cb9fa", 1, 1, "int");
	level.hero_weapon[#"katana"][0] = getweapon(#"hash_6627879099b8a337");
	level.hero_weapon[#"katana"][1] = getweapon(#"hash_6627889099b8a4ea");
	level.hero_weapon[#"katana"][2] = getweapon(#"hash_6627899099b8a69d");
	zm_loadout::register_hero_weapon_for_level(#"hash_6627879099b8a337");
	zm_loadout::register_hero_weapon_for_level(#"hash_6627889099b8a4ea");
	zm_loadout::register_hero_weapon_for_level(#"hash_6627899099b8a69d");
	level.var_9ea358cc = 0;
	if(!isdefined(level.var_3594d33a))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_3594d33a = object;
		[[ level.var_3594d33a ]]->initialize(3, 0.1);
	}
	callback::on_connect(&function_9a0f234b);
	zm::function_84d343d(#"hash_6627879099b8a337", &function_4e81317c);
	zm::function_84d343d(#"hash_6627889099b8a4ea", &function_4e81317c);
	zm::function_84d343d(#"hash_6627899099b8a69d", &function_4e81317c);
}

/*
	Name: function_c740060f
	Namespace: namespace_32e300a
	Checksum: 0x292DD19
	Offset: 0x4F0
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_c740060f(weapon, var_e7c11b0c = 1)
{
	if(weapon == level.hero_weapon[#"katana"][2])
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"katana"][1] && var_e7c11b0c < 3)
	{
		return 1;
	}
	if(weapon == level.hero_weapon[#"katana"][0] && var_e7c11b0c < 2)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_9a0f234b
	Namespace: namespace_32e300a
	Checksum: 0x309B900B
	Offset: 0x5C8
	Size: 0x358
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9a0f234b()
{
	self endon(#"disconnect");
	self thread function_756560e3();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		wpn_cur = waitresult.weapon;
		wpn_prev = waitresult.last_weapon;
		if(isinarray(level.hero_weapon[#"katana"], wpn_cur))
		{
			self clientfield::increment_to_player("" + #"hash_55539d0cf92a8855");
			self function_c43691a9(1);
			self thread function_8d02f57b(wpn_cur);
		}
		else if(isinarray(level.hero_weapon[#"katana"], wpn_prev))
		{
			self function_c43691a9(0);
			self notify(#"hash_36afc85dcef683d2");
			self.var_5605c31e = undefined;
		}
		if(wpn_cur == level.hero_weapon[#"katana"][0])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_648a5b1eedae58b9");
			self thread function_9fdcf13f();
		}
		else if(wpn_cur == level.hero_weapon[#"katana"][1])
		{
			zm_hero_weapon::show_hint(wpn_cur, #"hash_52cddac894472d22");
			self thread function_119af40d(wpn_cur);
			self thread function_478a4910(wpn_cur);
			self thread function_9fdcf13f();
		}
		else if(wpn_cur == level.hero_weapon[#"katana"][2])
		{
			if(!self gamepadusedlast())
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_4bf673fe684c7bcd");
			}
			else
			{
				self zm_hero_weapon::show_hint(wpn_cur, #"hash_33116738f78d04b3");
			}
			self thread function_119af40d(wpn_cur);
			self thread function_fcc26273(wpn_cur);
			self thread function_68ff89f7(wpn_cur);
			self thread function_9fdcf13f();
		}
	}
}

/*
	Name: function_9fdcf13f
	Namespace: namespace_32e300a
	Checksum: 0xFBD7B080
	Offset: 0x928
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9fdcf13f()
{
	self endon(#"disconnect");
	wait(1);
	callback::on_ai_damage(&function_af221ee1);
	self waittill(#"death", #"hash_36afc85dcef683d2");
	callback::remove_on_ai_damage(&function_af221ee1);
}

/*
	Name: function_756560e3
	Namespace: namespace_32e300a
	Checksum: 0xAF6F2E2C
	Offset: 0x9C0
	Size: 0xA0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_756560e3()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_3ea6a76d799083d6");
		var_cad4df8e = waitresult.weapon;
		if(function_c740060f(var_cad4df8e, 2))
		{
			self clientfield::increment_to_player("" + #"hash_55539d0cf92a8855");
		}
	}
}

/*
	Name: function_4e81317c
	Namespace: namespace_32e300a
	Checksum: 0x9B3BBC88
	Offset: 0xA68
	Size: 0x1C6
	Parameters: 12
	Flags: Linked
*/
function function_4e81317c(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!isdefined(self.var_6f84b820))
	{
		return idamage;
	}
	if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"popcorn" || self.var_6f84b820 == #"enhanced")
	{
		return self.health + 100;
	}
	if(self.var_6f84b820 == #"heavy" || self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"boss")
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				return 0.2 * self.maxhealth;
				break;
			}
			case "miniboss":
			{
				return 0.1 * self.maxhealth;
				break;
			}
			case "boss":
			{
				return 0.05 * self.maxhealth;
				break;
			}
		}
	}
	return idamage;
}

/*
	Name: function_af221ee1
	Namespace: namespace_32e300a
	Checksum: 0xDC8708C0
	Offset: 0xC38
	Size: 0x44C
	Parameters: 1
	Flags: Linked
*/
function function_af221ee1(s_params)
{
	if(!isdefined(s_params.weapon))
	{
		return;
	}
	if(isplayer(s_params.eattacker))
	{
		if(function_c740060f(s_params.weapon, 1))
		{
			if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"enhanced")
			{
				if(isdefined(level.no_gib_in_wolf_area) && (isdefined(self [[level.no_gib_in_wolf_area]]()) && self [[level.no_gib_in_wolf_area]]()))
				{
					var_bec5660f = 1;
				}
				if(level.var_9ea358cc >= 6)
				{
					var_bec5660f = 1;
				}
				if(isdefined(s_params.shitloc) && self.archetype === #"zombie")
				{
					if(!(isdefined(var_bec5660f) && var_bec5660f))
					{
						if(s_params.shitloc === "head" || s_params.shitloc === "helmet")
						{
							self thread function_1475944a();
							gibserverutils::gibhead(self);
							self playsound(#"hash_762b44e67bc3761f");
						}
						else if(isdefined(s_params.vpoint))
						{
							self zombie_utility::derive_damage_refs(s_params.vpoint);
							self playsound(#"hash_762b44e67bc3761f");
						}
					}
				}
				waitframe(1);
				if(isdefined(self) && (math::cointoss() || (isdefined(self.missinglegs) && self.missinglegs)))
				{
					if(isdefined(s_params.vdir) && self.health <= 0 && (!(isdefined(var_bec5660f) && var_bec5660f)))
					{
						var_eb0d0f20 = 75 * vectornormalize(s_params.vdir);
						var_eb0d0f20 = (var_eb0d0f20[0], var_eb0d0f20[1], 20);
						self startragdoll();
						self launchragdoll(var_eb0d0f20);
					}
					else
					{
						self thread zombie_utility::setup_zombie_knockdown(s_params.eattacker.origin);
					}
				}
			}
			else if(self.var_6f84b820 == #"miniboss")
			{
				if(s_params.shitloc === "head" || (s_params.shitloc === "helmet" && (isdefined(self.hashelmet) && self.hashelmet)))
				{
					if(isdefined(self.var_deee6e55 && isdefined(self.var_905e4ce2)))
					{
						self.var_deee6e55 = self.var_905e4ce2;
						waitframe(1);
						if(isalive(self))
						{
							self dodamage(1, self.origin, s_params.eattacker, s_params.eattacker, s_params.shitloc, s_params.smeansofdeath, 0, undefined);
							self playsound(#"hash_762b44e67bc3761f");
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_1475944a
	Namespace: namespace_32e300a
	Checksum: 0x6B2E035B
	Offset: 0x1090
	Size: 0x40
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1475944a()
{
	level.var_9ea358cc++;
	self waittill(#"death", #"hash_36afc85dcef683d2");
	level.var_9ea358cc--;
}

/*
	Name: function_8d02f57b
	Namespace: namespace_32e300a
	Checksum: 0x22277C2C
	Offset: 0x10D8
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function function_8d02f57b(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2");
	while(true)
	{
		if(var_c1ed7977.name == #"hash_6627899099b8a69d")
		{
			s_result = undefined;
			s_result = self waittill(#"weapon_melee_power");
		}
		else
		{
			s_result = undefined;
			s_result = self waittill(#"weapon_melee_power", #"weapon_melee");
		}
		if(s_result.weapon == var_c1ed7977)
		{
			self thread function_269ad6a5(var_c1ed7977);
		}
	}
}

/*
	Name: function_119af40d
	Namespace: namespace_32e300a
	Checksum: 0x461DA56C
	Offset: 0x11D8
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_119af40d(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee_juke");
		if(s_result.weapon == var_c1ed7977)
		{
			self playsound(#"wpn_katana_dash");
			self thread flagsys::set_for_time(1, "katana_dash");
			self.var_5605c31e = 1;
			self thread function_7903608c(var_c1ed7977);
			wait(1);
			self notify(#"hash_50c324a04c7e0b09");
			self.var_5605c31e = undefined;
			while(self adsbuttonpressed())
			{
				wait(0.1);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_7903608c
	Namespace: namespace_32e300a
	Checksum: 0x7799452F
	Offset: 0x1330
	Size: 0x1FA
	Parameters: 1
	Flags: Linked
*/
function function_7903608c(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2", #"hash_50c324a04c7e0b09");
	str_hitloc = "head";
	while(true)
	{
		var_baf7d060 = getaiteamarray(level.zombie_team);
		var_a812a69b = self.origin + (anglestoforward(self.angles) * 40);
		a_ai_zombies = array::get_all_closest(var_a812a69b, var_baf7d060, undefined, undefined, 80);
		foreach(ai_zombie in a_ai_zombies)
		{
			if(!isalive(ai_zombie) || (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death))
			{
				continue;
			}
			if(!isdefined(ai_zombie.var_6f84b820))
			{
				continue;
			}
			if(!(isdefined(ai_zombie.var_48a548c1) && ai_zombie.var_48a548c1))
			{
				ai_zombie thread function_bbe55589(self, var_c1ed7977, str_hitloc);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_bbe55589
	Namespace: namespace_32e300a
	Checksum: 0x4536BF0A
	Offset: 0x1538
	Size: 0x25E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_bbe55589(e_player, var_c1ed7977, str_hitloc)
{
	self endon(#"death");
	n_base_damage = 50;
	if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"popcorn" || self.var_6f84b820 == #"enhanced")
	{
		self.var_48a548c1 = 1;
		[[ level.var_3594d33a ]]->waitinqueue(self);
		self dodamage(self.health + 100, e_player.origin, e_player, e_player, str_hitloc, "MOD_MELEE", 0, var_c1ed7977);
		self playsound(#"hash_762b44e67bc3761f");
	}
	else
	{
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				n_base_damage = 0.2 * self.maxhealth;
				break;
			}
			case "miniboss":
			{
				n_base_damage = 0.1 * self.maxhealth;
				break;
			}
			case "boss":
			{
				n_base_damage = 0.05 * self.maxhealth;
				break;
			}
		}
		self.var_48a548c1 = 1;
		[[ level.var_3594d33a ]]->waitinqueue(self);
		n_damage = (750 > n_base_damage ? 750 : n_base_damage);
		self dodamage(n_damage, e_player.origin, e_player, e_player, str_hitloc, "MOD_MELEE", 0, var_c1ed7977);
		self playsound(#"hash_762b44e67bc3761f");
		self.var_48a548c1 = undefined;
	}
}

/*
	Name: function_fcc26273
	Namespace: namespace_32e300a
	Checksum: 0xEEF45E43
	Offset: 0x17A0
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_fcc26273(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee");
		if(s_result.weapon == var_c1ed7977)
		{
			self thread function_bed1fd9f();
		}
	}
}

/*
	Name: function_bed1fd9f
	Namespace: namespace_32e300a
	Checksum: 0x1D23DDFD
	Offset: 0x1850
	Size: 0x1FE
	Parameters: 0
	Flags: Linked
*/
function function_bed1fd9f()
{
	self endon(#"disconnect");
	self playsound(#"hash_58397a948dd38b37");
	if(isdefined(self.var_4e6b62c3) && self.var_4e6b62c3)
	{
		self notify(#"hash_6c803e34b0b06d90");
		return;
	}
	self val::set(#"hash_6b725a8367e0178a", "ignoreme");
	self.var_4e6b62c3 = 1;
	self clientfield::set("" + #"hash_7e2af117e18cb9fa", 1);
	self clientfield::set("" + #"hash_13ccfca7b26cec97", 1);
	waitresult = undefined;
	waitresult = self waittill(#"hash_36afc85dcef683d2", #"hash_6c803e34b0b06d90");
	if(waitresult._notify == #"hash_36afc85dcef683d2")
	{
		self playsound(#"hash_58397a948dd38b37");
	}
	self clientfield::set("" + #"hash_7e2af117e18cb9fa", 0);
	self clientfield::set("" + #"hash_13ccfca7b26cec97", 0);
	self val::reset(#"hash_6b725a8367e0178a", "ignoreme");
	self.var_4e6b62c3 = undefined;
}

/*
	Name: function_269ad6a5
	Namespace: namespace_32e300a
	Checksum: 0xED181F00
	Offset: 0x1A58
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_269ad6a5(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death");
	if(isdefined(self.var_5605c31e))
	{
		return;
	}
	self.var_5605c31e = 0;
	var_f1149aba = 100;
	str_hitloc = array::random(array("torso_lower", "left_arm_upper", "right_arm_upper", "left_leg_upper", "right_leg_upper"));
	waitframe(4);
	self thread function_8520d1c9(var_f1149aba, str_hitloc, var_c1ed7977);
	waitframe(10);
	self thread function_8520d1c9(var_f1149aba, str_hitloc, var_c1ed7977);
	wait(0.1);
	self.var_5605c31e = undefined;
}

/*
	Name: function_8520d1c9
	Namespace: namespace_32e300a
	Checksum: 0x1A62B22C
	Offset: 0x1B80
	Size: 0x148
	Parameters: 3
	Flags: Linked
*/
function function_8520d1c9(var_f1149aba, str_hitloc, var_c1ed7977)
{
	var_a812a69b = self.origin + (anglestoforward(self.angles) * (var_f1149aba / 2));
	a_ai_zombies = array::get_all_closest(var_a812a69b, getaiteamarray(level.zombie_team), undefined, undefined, var_f1149aba);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(!isalive(ai_zombie) || (isdefined(ai_zombie.marked_for_death) && ai_zombie.marked_for_death))
		{
			continue;
		}
		ai_zombie thread function_bbe55589(self, var_c1ed7977, str_hitloc);
	}
}

/*
	Name: function_c43691a9
	Namespace: namespace_32e300a
	Checksum: 0x9803FA18
	Offset: 0x1CD0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_c43691a9(var_2e56d8e5)
{
	self.var_2e56d8e5 = var_2e56d8e5;
}

/*
	Name: function_478a4910
	Namespace: namespace_32e300a
	Checksum: 0x9C32DCA9
	Offset: 0x1CF8
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_478a4910(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee_juke");
		if(s_result.weapon == var_c1ed7977)
		{
			if(1 === zm_audio::create_and_play_dialog(#"hash_6a87ca13e3ecd52d", #"katana"))
			{
				break;
			}
		}
	}
}

/*
	Name: function_68ff89f7
	Namespace: namespace_32e300a
	Checksum: 0xFA9A38E1
	Offset: 0x1DD0
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_68ff89f7(var_c1ed7977)
{
	self endon(#"disconnect", #"bled_out", #"death", #"hash_36afc85dcef683d2");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"weapon_melee");
		if(s_result.weapon == var_c1ed7977)
		{
			if(1 === zm_audio::create_and_play_dialog(#"hash_6a87c913e3ecd37a", #"katana"))
			{
				break;
			}
		}
	}
}

