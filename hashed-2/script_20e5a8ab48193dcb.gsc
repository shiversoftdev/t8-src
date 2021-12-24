// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_35598499769dbb3d;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_aeac0f57;

/*
	Name: function_89f2df9
	Namespace: namespace_aeac0f57
	Checksum: 0x6659B773
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"snowball", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_aeac0f57
	Checksum: 0x16E9A33
	Offset: 0x158
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_ad5d43cf = getweapon(#"snowball");
	level.var_f8934665 = getweapon(#"hash_1ecb90ddb44096f4");
	level.var_bf70d56c = getweapon(#"hash_7b1ab4354f6a9ef4");
	level.var_d879215 = getweapon(#"hash_4d50a2c4ff4e615d");
	zm::function_84d343d(#"snowball", &function_5ff12a45);
	zm::function_84d343d(#"hash_1ecb90ddb44096f4", &function_5ff12a45);
	zm::function_84d343d(#"hash_7b1ab4354f6a9ef4", &function_ee240a8e);
	zm::function_84d343d(#"hash_4d50a2c4ff4e615d", &function_ee240a8e);
	callback::function_20263b9e(&function_20263b9e);
	zm_loadout::register_lethal_grenade_for_level(#"snowball");
	zm_loadout::register_lethal_grenade_for_level(#"hash_1ecb90ddb44096f4");
	zm_loadout::register_lethal_grenade_for_level(#"hash_7b1ab4354f6a9ef4");
	zm_loadout::register_lethal_grenade_for_level(#"hash_4d50a2c4ff4e615d");
	clientfield::register("toplayer", "" + #"hash_78aa1dc141a3e27", 24000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_2fafddfa9f85b8aa", 24000, 1, "int");
}

/*
	Name: function_20263b9e
	Namespace: namespace_aeac0f57
	Checksum: 0xF127ADC0
	Offset: 0x3E8
	Size: 0x418
	Parameters: 1
	Flags: Linked
*/
function function_20263b9e(s_params)
{
	self endon(#"death");
	level endon(#"end_game");
	if(s_params.weapon != level.var_ad5d43cf && s_params.weapon != level.var_f8934665 && s_params.weapon != level.var_bf70d56c && s_params.weapon != level.var_d879215)
	{
		return;
	}
	var_be17187b = undefined;
	var_be17187b = s_params.projectile waittill(#"projectile_impact_explode", #"explode");
	a_e_players = getplayers();
	a_e_players = arraysortclosest(a_e_players, var_be17187b.position, 4, 0, 64);
	foreach(e_player in a_e_players)
	{
		if(s_params.weapon == level.var_ad5d43cf || s_params.weapon == level.var_f8934665)
		{
			e_player thread function_6e2124f7();
			continue;
		}
		e_player thread function_2291fc03();
	}
	var_566b3847 = getentitiesinradius(var_be17187b.position, 5);
	foreach(var_c006f5e9 in var_566b3847)
	{
		if(isdefined(var_c006f5e9))
		{
			if(var_c006f5e9.targetname === "sos_snowball" || var_c006f5e9.targetname === "soup_pot")
			{
				var_c006f5e9 dodamage(1, var_c006f5e9.origin, self, undefined, undefined, "MOD_PROJECTILE", 0, s_params.weapon);
			}
			if(isplayer(var_c006f5e9) && var_c006f5e9 != self)
			{
				self thread zm_audio::create_and_play_dialog(#"snowball", #"friendly");
			}
		}
	}
	var_d87c5b04 = array::get_all_closest(var_be17187b.position, trigger::get_all(), undefined, undefined, 64);
	foreach(var_32835396 in var_d87c5b04)
	{
		var_32835396 dodamage(1, var_c006f5e9.origin, self, undefined, undefined, "MOD_PROJECTILE", 0, s_params.weapon);
	}
}

/*
	Name: function_6e2124f7
	Namespace: namespace_aeac0f57
	Checksum: 0x8F5B662
	Offset: 0x808
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6e2124f7()
{
	self endon(#"disconnect");
	clientfield::set_to_player("" + #"hash_78aa1dc141a3e27", 1);
	wait(0.5);
	clientfield::set_to_player("" + #"hash_78aa1dc141a3e27", 0);
}

/*
	Name: function_2291fc03
	Namespace: namespace_aeac0f57
	Checksum: 0x101071C2
	Offset: 0x888
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2291fc03()
{
	self endon(#"disconnect");
	clientfield::set_to_player("" + #"hash_2fafddfa9f85b8aa", 1);
	wait(0.5);
	clientfield::set_to_player("" + #"hash_2fafddfa9f85b8aa", 0);
}

/*
	Name: function_5ff12a45
	Namespace: namespace_aeac0f57
	Checksum: 0xB54D6640
	Offset: 0x908
	Size: 0x14E
	Parameters: 12
	Flags: Linked
*/
function function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath != "MOD_IMPACT")
	{
		return damage;
	}
	if(zm_utility::is_headshot(weapon, shitloc, meansofdeath, 1))
	{
		damage = self.maxhealth;
		if(self.no_gib !== 1)
		{
			gibserverutils::gibhead(self);
		}
		self.water_damage = 1;
	}
	else
	{
		damage = (ceil(self.maxhealth / 3)) + 1;
		if(self.health <= damage)
		{
			self.water_damage = 1;
		}
	}
	if(attacker zm_powerups::is_insta_kill_active())
	{
		self.water_damage = 1;
	}
	return damage;
}

/*
	Name: function_ee240a8e
	Namespace: namespace_aeac0f57
	Checksum: 0x2F4F4DA9
	Offset: 0xA60
	Size: 0xDE
	Parameters: 12
	Flags: Linked
*/
function function_ee240a8e(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	damage = self.maxhealth;
	self.water_damage = 1;
	if(zm_utility::is_headshot(weapon, shitloc, meansofdeath, 1))
	{
		gibserverutils::gibhead(self);
	}
	if(attacker zm_powerups::is_insta_kill_active())
	{
		self.water_damage = 1;
	}
	return damage;
}

