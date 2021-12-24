// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_2f9a68261f6a17be;
#using script_35598499769dbb3d;
#using script_6951ea86fdae9ae0;
#using script_db06eb511bd9b36;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_ec6b032;

/*
	Name: function_89f2df9
	Namespace: namespace_ec6b032
	Checksum: 0x423BC892
	Offset: 0x210
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4f9f7fa7527fb431", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ec6b032
	Checksum: 0x63FF1933
	Offset: 0x258
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_1c1a8ed8d0bf271c", 0))
	{
		function_27473e44();
		namespace_9ff9f642::function_9d45c058(#"hash_773d5ce33dd7cde9", 1, 6);
	}
}

/*
	Name: function_27473e44
	Namespace: namespace_ec6b032
	Checksum: 0x1CE91DBE
	Offset: 0x2C8
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"hash_377149a415143f1b", #"hash_773d5ce33dd7cde9", 2000, #"hash_2f712a7c17494226", getweapon("zombie_perk_bottle_death_dash"), getweapon("zombie_perk_totem_death_dash"), #"hash_544b157a9fa6573d");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_377149a415143f1b", #"hash_773d5ce33dd7cde9", 2000, #"hash_3cadaccb6765492", getweapon("zombie_perk_bottle_death_dash"), getweapon("zombie_perk_totem_death_dash"), #"hash_544b157a9fa6573d");
	}
	zm_perks::register_perk_clientfields(#"hash_377149a415143f1b", &register_clientfield, &function_b0c4e363);
	zm_perks::register_perk_threads(#"hash_377149a415143f1b", &give_perk, &take_perk, &function_9227a4d8);
	zm_perks::register_perk_damage_override_func(&function_4492525b);
}

/*
	Name: register_clientfield
	Namespace: namespace_ec6b032
	Checksum: 0xC92C557
	Offset: 0x4A0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function register_clientfield()
{
	clientfield::register("allplayers", "death_dash_charging", 24000, 1, "int");
	clientfield::register("allplayers", "death_dash_charged", 24000, 1, "int");
	clientfield::register("allplayers", "death_dash_charged_mod", 24000, 1, "int");
	clientfield::register("allplayers", "death_dash_trail", 24000, 1, "int");
	clientfield::register("toplayer", "death_dash_charging_postfx", 24000, 1, "int");
	clientfield::register("toplayer", "death_dash_dash_postfx", 24000, 1, "int");
	clientfield::register("toplayer", "death_dash_charged_mod_postfx", 24000, 1, "int");
}

/*
	Name: function_b0c4e363
	Namespace: namespace_ec6b032
	Checksum: 0x9B369365
	Offset: 0x600
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_b0c4e363(state)
{
}

/*
	Name: give_perk
	Namespace: namespace_ec6b032
	Checksum: 0xFF1B1CEF
	Offset: 0x618
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
	if(!isdefined(self.var_d675d730))
	{
		self.var_d675d730 = spawnstruct();
	}
	self.var_d675d730.var_775a4a2a = zm_perks::function_c1efcc57(#"hash_377149a415143f1b");
	self.var_d675d730.var_d566ea4 = 0;
	self.var_d675d730.var_ec50ac8e = 0;
	self.var_d675d730.var_f658b938 = 0;
	self.var_d675d730.n_kill_count = 0;
	if(!isdefined(self.var_72755c0))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		self.var_72755c0 = object;
		[[ self.var_72755c0 ]]->initialize(4, 0.05);
	}
	self thread function_9227a4d8();
	self thread function_3b2d1c3e();
}

/*
	Name: take_perk
	Namespace: namespace_ec6b032
	Checksum: 0xD101A344
	Offset: 0x730
	Size: 0x4C
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_34c48ce219158e58");
	self function_3d5b29a6();
}

/*
	Name: function_3b2d1c3e
	Namespace: namespace_ec6b032
	Checksum: 0x16F0FD0A
	Offset: 0x788
	Size: 0x88
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3b2d1c3e()
{
	self endon(#"hash_34c48ce219158e58", #"death");
	self thread function_607b1eb0();
	while(true)
	{
		self waittill(#"hash_1790edc896f02840");
		if(!self.var_d675d730.var_d566ea4)
		{
			self thread function_b1d12202();
		}
	}
}

/*
	Name: function_607b1eb0
	Namespace: namespace_ec6b032
	Checksum: 0xE9DCD23B
	Offset: 0x818
	Size: 0x46E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_607b1eb0()
{
	level endon(#"end_game");
	self endon(#"hash_34c48ce219158e58", #"death");
	self.var_d675d730.var_af84e9df = 0;
	while(true)
	{
		if(self.var_d675d730.var_d566ea4 === 1 || !function_69153101())
		{
			self function_3d5b29a6();
			waitframe(1);
		}
		else if(self.var_d675d730.var_af84e9df)
		{
			if(self.var_d675d730.var_ec50ac8e < 1)
			{
				var_77aee2d6 = (gettime() - self.var_d675d730.var_40cb1997) / 1000;
				self.var_d675d730.var_ec50ac8e = math::clamp(var_77aee2d6 / 3, 0, 1);
				if(self.var_d675d730.var_ec50ac8e >= 1)
				{
					self clientfield::set("death_dash_charged", 1);
					self clientfield::set_to_player("death_dash_charging_postfx", 1);
				}
			}
			if(self hasperk(#"hash_1b2d5c9444ac98f2") && self.var_d675d730.var_f658b938 < 1)
			{
				var_77aee2d6 = (gettime() - self.var_d675d730.var_40cb1997) / 1000;
				self.var_d675d730.var_f658b938 = math::clamp(var_77aee2d6 / 6, 0, 1);
				if(self.var_d675d730.var_f658b938 >= 1)
				{
					self clientfield::set("death_dash_charged_mod", 1);
					self clientfield::set_to_player("death_dash_charged_mod_postfx", 1);
				}
			}
		}
		if(!self.var_d675d730.var_af84e9df && self getstance() === "crouch" && !self zm_utility::is_jumping() && !self stancebuttonpressed())
		{
			self.var_d675d730.var_af84e9df = 1;
			self.var_d675d730.var_40cb1997 = gettime();
			self.var_d675d730.var_ec50ac8e = 0;
			self.var_d675d730.var_f658b938 = 0;
			self clientfield::set("death_dash_charging", 1);
			self clientfield::set_to_player("death_dash_charging_postfx", 1);
		}
		if(self.var_d675d730.var_af84e9df && self getstance() != "crouch")
		{
			self.var_d675d730.var_af84e9df = 0;
			self function_3d5b29a6();
		}
		if(self.var_d675d730.var_af84e9df && self stancebuttonpressed())
		{
			self.var_d675d730.var_af84e9df = self function_f3d1b75c();
			if(self.var_d675d730.var_af84e9df && self.var_d675d730.var_ec50ac8e > 0.2)
			{
				self notify(#"hash_1790edc896f02840");
			}
			else
			{
				self.var_d675d730.var_af84e9df = 0;
			}
			self function_3d5b29a6();
		}
		waitframe(1);
	}
}

/*
	Name: function_3d5b29a6
	Namespace: namespace_ec6b032
	Checksum: 0x3D8A8AA9
	Offset: 0xC90
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3d5b29a6()
{
	self clientfield::set("death_dash_charging", 0);
	self clientfield::set("death_dash_charged", 0);
	self clientfield::set("death_dash_charged_mod", 0);
	self clientfield::set_to_player("death_dash_charging_postfx", 0);
	self clientfield::set_to_player("death_dash_charged_mod_postfx", 0);
}

/*
	Name: function_f3d1b75c
	Namespace: namespace_ec6b032
	Checksum: 0x3B326820
	Offset: 0xD40
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f3d1b75c()
{
	level endon(#"end_game");
	self endon(#"hash_34c48ce219158e58", #"death");
	while(self getstance() === "crouch")
	{
		waitframe(1);
	}
	if(self getstance() === "stand")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b1d12202
	Namespace: namespace_ec6b032
	Checksum: 0xC5C87DA2
	Offset: 0xDD8
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_b1d12202()
{
	self endon(#"hash_34c48ce219158e58", #"death");
	self clientfield::set("death_dash_trail", 1);
	self clientfield::set_to_player("death_dash_dash_postfx", 1);
	self.var_d675d730.n_kill_count = 0;
	var_8e317f6c = vectornormalize(anglestoforward(self.angles) + (vectorscale((0, 0, -1), 0.66)));
	var_8e317f6c = var_8e317f6c * 1500;
	self thread function_aeda9580(var_8e317f6c);
	self thread function_749be7c5();
	var_23322f89 = lerpfloat(0.1, 0.5, self.var_d675d730.var_ec50ac8e);
	if(self hasperk(#"hash_1b2d5c9444ac98f2") && self.var_d675d730.var_f658b938 >= 1)
	{
		var_23322f89 = 5;
	}
	self waittill_timeout(var_23322f89, #"hash_ba882779cc9c10d");
	self function_38139f98();
}

/*
	Name: function_aeda9580
	Namespace: namespace_ec6b032
	Checksum: 0x5CB28A32
	Offset: 0xF98
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_aeda9580(var_8e317f6c)
{
	if(!isdefined(var_8e317f6c))
	{
		return;
	}
	self endon(#"hash_6e2a731bbdb686b8", #"hash_34c48ce219158e58", #"death", #"disconnect", #"bled_out");
	level endon(#"end_game");
	self.var_d675d730.var_4aee0032 = 1;
	self.var_d675d730.var_e09a4919 = gettime();
	var_fa1d6773 = cos(15);
	var_63883896 = 0;
	while(true)
	{
		var_405918e8 = lerpfloat(0.2, 1, var_63883896 / 3);
		self setvelocity(var_8e317f6c * var_405918e8);
		self setplayerangles(vectortoangles(var_8e317f6c * (1, 1, 0)));
		var_63883896++;
		waitframe(1);
		v_player_velocity = self getvelocity();
		if(gettime() - self.var_d675d730.var_e09a4919 > 200)
		{
			var_982948b3 = vectornormalize(var_8e317f6c * (1, 1, 0));
			var_cd10168d = vectornormalize(v_player_velocity * (1, 1, 0));
			n_dot = vectordot(var_982948b3, var_cd10168d);
			if(n_dot < var_fa1d6773)
			{
				self notify(#"hash_ba882779cc9c10d");
			}
		}
		var_44cc0c10 = self function_d5fc01cc();
		if(var_44cc0c10 > 0)
		{
			self notify(#"hash_ba882779cc9c10d");
		}
	}
}

/*
	Name: function_d5fc01cc
	Namespace: namespace_ec6b032
	Checksum: 0xB91B6B92
	Offset: 0x1210
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_d5fc01cc()
{
	s_trace = groundtrace(self.origin, self.origin + (vectorscale((0, 0, -1), 96)), 0, self);
	v_pos = s_trace[#"position"];
	n_dist = self.origin[2] - v_pos[2];
	if(n_dist >= 48)
	{
		return n_dist;
	}
	return 0;
}

/*
	Name: function_749be7c5
	Namespace: namespace_ec6b032
	Checksum: 0xA0CCD87C
	Offset: 0x12B8
	Size: 0x1EA
	Parameters: 0
	Flags: Linked
*/
function function_749be7c5()
{
	self endon(#"hash_6e2a731bbdb686b8", #"hash_34c48ce219158e58", #"death", #"disconnect", #"bled_out");
	level endon(#"end_game");
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
				ai_zombie thread function_c1c51837(self);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_c1c51837
	Namespace: namespace_ec6b032
	Checksum: 0x38419368
	Offset: 0x14B0
	Size: 0x3DE
	Parameters: 1
	Flags: Linked
*/
function function_c1c51837(e_player)
{
	self endon(#"hash_34c48ce219158e58", #"death", #"disconnect", #"bled_out");
	self.var_48a548c1 = 1;
	[[ e_player.var_72755c0 ]]->waitinqueue(self);
	self namespace_9ff9f642::burn(#"hash_773d5ce33dd7cde9", e_player, undefined, undefined);
	self.var_b364c165 = 1;
	e_player.var_d675d730.n_kill_count++;
	if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"popcorn" || self.var_6f84b820 == #"enhanced")
	{
		if(self.no_gib !== 1)
		{
			var_d3876bb9 = [6:&gibserverutils::annihilate, 5:&gibserverutils::gibrightleg, 4:&gibserverutils::gibrightarm, 3:&gibserverutils::giblegs, 2:&gibserverutils::gibleftleg, 1:&gibserverutils::gibleftarm, 0:&gibserverutils::gibhead];
			var_d3876bb9 = array::randomize(var_d3876bb9);
			[[var_d3876bb9[0]]](self);
		}
		if(e_player.var_d675d730.n_kill_count > 10)
		{
			self zm_cleanup::function_23621259();
			self zm_score::function_acaab828(1);
		}
		if(e_player hasperk(#"hash_1b2d5c9444ac98f2") && e_player.var_d675d730.var_f658b938 >= 1)
		{
			n_damage = 4400;
		}
		else
		{
			n_damage = 1700;
		}
		self dodamage(self.health + 666, e_player.origin, e_player, undefined, undefined, "MOD_BURNED", 0, level.weaponnone);
	}
	else
	{
		n_damage = 1700;
		switch(self.var_6f84b820)
		{
			case "heavy":
			{
				n_damage = 0.2 * self.maxhealth;
				break;
			}
			case "miniboss":
			{
				n_damage = 0.1 * self.maxhealth;
				break;
			}
			case "boss":
			{
				n_damage = 0.05 * self.maxhealth;
				break;
			}
		}
		self dodamage(n_damage, e_player.origin, e_player, undefined, undefined, "MOD_BURNED", 0, level.weaponnone);
	}
	self.var_48a548c1 = undefined;
}

/*
	Name: function_38139f98
	Namespace: namespace_ec6b032
	Checksum: 0x1B7B4958
	Offset: 0x1898
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_38139f98()
{
	self endon(#"hash_34c48ce219158e58", #"death", #"disconnect", #"bled_out");
	self clientfield::set("death_dash_trail", 0);
	self clientfield::set_to_player("death_dash_dash_postfx", 0);
	self notify(#"hash_6e2a731bbdb686b8");
	self setvelocity((0, 0, 0));
	self.var_d675d730.var_4aee0032 = 0;
	n_cooldown_time = (level.var_969fe3f1 === 1 ? 1 : 60);
	self thread function_1dbd75d3(n_cooldown_time);
}

/*
	Name: function_1dbd75d3
	Namespace: namespace_ec6b032
	Checksum: 0xA56D028E
	Offset: 0x19A0
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_1dbd75d3(var_85dcb56c)
{
	self endon(#"hash_21b3435b159fa349", #"disconnect");
	self.var_d675d730.var_d566ea4 = 1;
	if(self hasperk(#"hash_377149a415143f1b") && isdefined(self.var_d675d730.var_775a4a2a))
	{
		self zm_perks::function_2ac7579(self.var_d675d730.var_775a4a2a, 2, #"hash_773d5ce33dd7cde9");
	}
	self thread function_7d72c6f9(var_85dcb56c);
	wait(var_85dcb56c);
	self thread function_9227a4d8();
}

/*
	Name: function_7d72c6f9
	Namespace: namespace_ec6b032
	Checksum: 0x13581673
	Offset: 0x1A90
	Size: 0x1A0
	Parameters: 1
	Flags: Linked
*/
function function_7d72c6f9(var_85dcb56c)
{
	self endon(#"hash_21b3435b159fa349", #"disconnect");
	self.var_d675d730.var_471d9402 = var_85dcb56c;
	self zm_perks::function_13880aa5(self.var_d675d730.var_775a4a2a, 0, #"hash_e58ff2df5bfd9b3");
	while(true)
	{
		wait(0.1);
		self.var_d675d730.var_471d9402 = self.var_d675d730.var_471d9402 - 0.1;
		self.var_d675d730.var_471d9402 = math::clamp(self.var_d675d730.var_471d9402, 0, var_85dcb56c);
		n_percentage = 1 - (self.var_d675d730.var_471d9402 / var_85dcb56c);
		n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);
		if(self hasperk(#"hash_377149a415143f1b") && isdefined(self.var_d675d730.var_775a4a2a))
		{
			self zm_perks::function_13880aa5(self.var_d675d730.var_775a4a2a, n_percentage, #"hash_773d5ce33dd7cde9");
		}
	}
}

/*
	Name: function_9227a4d8
	Namespace: namespace_ec6b032
	Checksum: 0x14EB5E19
	Offset: 0x1C38
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_9227a4d8()
{
	self notify(#"hash_21b3435b159fa349");
	if(isdefined(self.var_d675d730))
	{
		self.var_d675d730.var_d566ea4 = 0;
	}
	if(self hasperk(#"hash_377149a415143f1b"))
	{
		/#
			assert(isdefined(self.var_d675d730.var_775a4a2a), "");
		#/
		if(isdefined(self.var_d675d730.var_775a4a2a))
		{
			self zm_perks::function_2ac7579(self.var_d675d730.var_775a4a2a, 1, #"hash_773d5ce33dd7cde9");
			self zm_perks::function_13880aa5(self.var_d675d730.var_775a4a2a, 1, #"hash_773d5ce33dd7cde9");
		}
	}
}

/*
	Name: function_69153101
	Namespace: namespace_ec6b032
	Checksum: 0xA0264094
	Offset: 0x1D50
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
private function function_69153101()
{
	if(namespace_6b49f66b::is_active())
	{
		return 0;
	}
	if(namespace_fcd611c3::is_active())
	{
		return 0;
	}
	if(namespace_b28d86fd::is_active())
	{
		return 0;
	}
	if(isdefined(level.var_e501f3b5) && level.var_e501f3b5)
	{
		return 0;
	}
	if(level.var_2439365b === #"turret")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_4492525b
	Namespace: namespace_ec6b032
	Checksum: 0xE4452747
	Offset: 0x1DE8
	Size: 0x13E
	Parameters: 10
	Flags: Linked
*/
function function_4492525b(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	has_perk = self hasperk(#"hash_377149a415143f1b");
	var_656a2751 = isdefined(self.var_d675d730) && (isdefined(self.var_d675d730.var_4aee0032) && self.var_d675d730.var_4aee0032);
	var_2d419edd = smeansofdeath === "MOD_FALLING";
	var_c241fbf4 = isplayer(eattacker) || isplayer(einflictor);
	if(has_perk && var_656a2751 && (var_2d419edd || var_c241fbf4))
	{
		return 0;
	}
	return idamage;
}

