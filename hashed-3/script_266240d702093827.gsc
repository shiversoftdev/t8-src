// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_3f9e0dc8454d98e1;
#using script_42ac6fc8b2ff0f3e;
#using script_4d000493c57bb851;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_52d8d460;

/*
	Name: function_89f2df9
	Namespace: namespace_52d8d460
	Checksum: 0x960C2568
	Offset: 0x258
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7ca2cbd84515aff1", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_52d8d460
	Checksum: 0xA5851AED
	Offset: 0x2A0
	Size: 0x62E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"hash_26af481b9a9d41ce", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_18fc1da5f1785e6b", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_58757f4a64fedf21", 1, 2, "int");
	clientfield::register("allplayers", "" + #"hash_275debebcd185ea1", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_dc971935944f005", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_6b725eefec5d09d1", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_73e9280f74528e8f", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_21ff5b4eccea85ff", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_64a830301c1adbf3", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_4f32455c6a0286cd", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_32ef1785f4e55e5c", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_2cd1bb15f71aedb8", 1, 1, "counter");
	clientfield::register("toplayer", "" + #"hash_1769e95fdb10dfae", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_333e3741e6552db3", 1, 1, "int");
	level._effect[#"hash_3ecc995bb97331ac"] = #"hash_266633b36a852fd5";
	level.var_c9d375dc = spawnstruct();
	level.var_c9d375dc.var_c3fb4199 = getweapon(#"hash_237b6756a81881cb");
	level.var_c9d375dc.melee_weapon = getweapon(#"zhield_zword_dw");
	level.var_c9d375dc.var_e9ffbbed = getweapon(#"hash_2f351450f2e936dc");
	level.var_c9d375dc.var_2039b8da = getweapon(#"hash_68bfa6918dc2eb81");
	level.var_70f7eb75 = level.var_c9d375dc.var_2039b8da;
	callback::on_connect(&player_init);
	level.riotshield_melee = &function_fbe77fa4;
	callback::function_34dea974(level.var_c9d375dc.var_c3fb4199, &function_618e1db4);
	callback::function_34dea974(level.var_c9d375dc.var_e9ffbbed, &function_618e1db4);
	callback::on_ai_killed(&function_f3137e13);
	zm::register_zombie_damage_override_callback(&function_2a9a30bb);
	zm::register_zombie_damage_override_callback(&function_3c6df289);
	namespace_9ff9f642::function_9d45c058(#"hash_237b6756a81881cb", 100, 5);
	if(namespace_59ff1d6c::function_901b751c(#"hash_3c5363541b97ca3e"))
	{
		level thread function_646d73c3();
		level.var_f7d93c4e = &function_22d79d55;
		level.var_932a1afb = &function_28f576a9;
	}
}

/*
	Name: function_65a59ce0
	Namespace: namespace_52d8d460
	Checksum: 0x6E259B0D
	Offset: 0x8D8
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function function_65a59ce0(w_current, var_5738ae72 = 0)
{
	if(var_5738ae72)
	{
		if(w_current == level.var_c9d375dc.var_2039b8da)
		{
			return 1;
		}
		if(w_current == level.var_c9d375dc.var_e9ffbbed)
		{
			return 1;
		}
		return 0;
	}
	if(w_current == level.var_c9d375dc.melee_weapon || w_current == level.var_c9d375dc.var_2039b8da)
	{
		return 1;
	}
	if(w_current == level.var_c9d375dc.var_c3fb4199 || w_current == level.var_c9d375dc.var_e9ffbbed)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ed81d8f5
	Namespace: namespace_52d8d460
	Checksum: 0xBEB04FFC
	Offset: 0x9D0
	Size: 0x8E
	Parameters: 2
	Flags: Linked
*/
function function_ed81d8f5(w_current, var_5738ae72 = 0)
{
	if(var_5738ae72)
	{
		if(w_current == level.var_c9d375dc.var_2039b8da)
		{
			return 1;
		}
		return 0;
	}
	if(w_current == level.var_c9d375dc.melee_weapon || w_current == level.var_c9d375dc.var_2039b8da)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a57b8fca
	Namespace: namespace_52d8d460
	Checksum: 0xD0BAA24C
	Offset: 0xA68
	Size: 0x8E
	Parameters: 2
	Flags: Linked
*/
function function_a57b8fca(w_current, var_5738ae72 = 0)
{
	if(var_5738ae72)
	{
		if(w_current == level.var_c9d375dc.var_e9ffbbed)
		{
			return 1;
		}
		return 0;
	}
	if(w_current == level.var_c9d375dc.var_c3fb4199 || w_current == level.var_c9d375dc.var_e9ffbbed)
	{
		return 1;
	}
	return 0;
}

/*
	Name: player_init
	Namespace: namespace_52d8d460
	Checksum: 0x32E6F811
	Offset: 0xB00
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function player_init()
{
	self.var_c9d375dc = spawnstruct();
	self.var_c9d375dc.var_6c90fb3f = 0;
	self.var_c9d375dc.n_charge_level = 0;
	self.var_c9d375dc.var_276d45bf = 0;
	self.var_c9d375dc.var_d0f03d3f = 0;
	self thread function_4591fd41();
	self thread function_982a8c76();
}

/*
	Name: function_28f576a9
	Namespace: namespace_52d8d460
	Checksum: 0x27635B5F
	Offset: 0xB90
	Size: 0x2C0
	Parameters: 1
	Flags: Linked
*/
function function_28f576a9(player)
{
	var_710873d9 = getweapon(#"hash_68bfa6918dc2eb81");
	if(!player hasweapon(var_710873d9) && (isdefined(player.var_5ba94c1e) && player.var_5ba94c1e))
	{
		self.hint_string = zm_utility::function_d6046228(#"hash_33e05a25f080d845", #"hash_c69465e0b5ec27b");
		self.cost = self namespace_a1d9b01d::function_ceac3bf9(player);
	}
	else if(!player hasweapon(var_710873d9) && player flag::get(#"hash_4246a36eeaccdedb") && player flag::get(#"hash_1e11ea0627c40424") && player flag::get(#"hash_15ea02b45ed633fa"))
	{
		self.hint_string = zm_utility::function_d6046228(#"hash_4c3385a49cb47a2c", #"hash_7f0c14b967f871a0");
		self.cost = undefined;
	}
	else if(player hasweapon(var_710873d9))
	{
		if(isdefined(self.blueprint.var_54a97edd.isriotshield) && self.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			self.cost = self namespace_a1d9b01d::function_ceac3bf9(player, 1);
			self.hint_string = zm_utility::function_d6046228(#"hash_4b00caebf5058f14", #"hash_5db3ede8aef13738");
			var_5435aca = 1;
		}
		else
		{
			self.hint_string = #"hash_53fd856df9288be7";
			self.cost = undefined;
			return 1;
		}
	}
}

/*
	Name: function_22d79d55
	Namespace: namespace_52d8d460
	Checksum: 0x1066910F
	Offset: 0xE58
	Size: 0x5D6
	Parameters: 1
	Flags: Linked
*/
function function_22d79d55(player)
{
	if(!(player flag::get(#"hash_4246a36eeaccdedb") && player flag::get(#"hash_1e11ea0627c40424") && player flag::get(#"hash_15ea02b45ed633fa")))
	{
		return 1;
	}
	var_54cae2d8 = getweapon(#"zhield_zword_dw");
	var_710873d9 = getweapon(#"hash_68bfa6918dc2eb81");
	if(player != self.parent_player)
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(player))
	{
		player thread zm_utility::ignore_triggers(0.5);
		return 0;
	}
	if(player hasweapon(var_54cae2d8))
	{
		player zm_weapons::weapon_take(var_54cae2d8);
		player zm_weapons::weapon_give(var_710873d9);
		player.weaponriotshield = var_710873d9;
		player.var_5ba94c1e = 1;
		var_e9e88745 = getent(self.target, "targetname");
		var_e9e88745 setinvisibletoplayer(player);
		if(!isdefined(self.var_824b5a74))
		{
			self.var_824b5a74 = [];
		}
		n_ent_num = player getentitynumber();
		if(!isdefined(self.var_824b5a74[n_ent_num]))
		{
			self.var_824b5a74[n_ent_num] = util::spawn_model(#"hash_4223616c6451bb89", var_e9e88745.origin, var_e9e88745.angles);
		}
		self.var_824b5a74[n_ent_num] setinvisibletoall();
		self.var_824b5a74[n_ent_num] setvisibletoplayer(player);
		return 0;
	}
	if(player namespace_a1d9b01d::function_2d53738e(var_710873d9))
	{
		if(isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			var_d97673ff = 1;
		}
		else
		{
			return 0;
		}
	}
	if(isdefined(var_d97673ff) && var_d97673ff)
	{
		var_f66d1847 = self.stub namespace_a1d9b01d::function_ceac3bf9(player, 1);
		if(isdefined(var_f66d1847) && var_f66d1847 > 0)
		{
			if(player zm_score::can_player_purchase(var_f66d1847))
			{
				player thread namespace_a1d9b01d::function_fccf9f0d();
				player zm_score::minus_to_player_score(var_f66d1847);
				player zm_utility::play_sound_on_ent("purchase");
			}
			else
			{
				zm_utility::play_sound_on_ent("no_purchase");
				player thread zm_audio::create_and_play_dialog("general", "outofmoney");
				return 0;
			}
		}
		player [[player.player_shield_reset_health]](var_710873d9, 1);
	}
	else
	{
		var_f66d1847 = self.stub namespace_a1d9b01d::function_ceac3bf9(player);
		if(isdefined(var_f66d1847) && var_f66d1847 > 0)
		{
			if(player zm_score::can_player_purchase(var_f66d1847))
			{
				player thread namespace_a1d9b01d::function_fccf9f0d();
				player zm_score::minus_to_player_score(var_f66d1847);
				player zm_utility::play_sound_on_ent("purchase");
			}
			else
			{
				zm_utility::play_sound_on_ent("no_purchase");
				player thread zm_audio::create_and_play_dialog("general", "outofmoney");
				return 0;
			}
		}
		if(isdefined(player.hasriotshield) && player.hasriotshield && isdefined(player.weaponriotshield))
		{
			player zm_weapons::weapon_take(player.weaponriotshield);
		}
		player thread zm_weapons::weapon_give(var_710873d9);
	}
	return 0;
}

/*
	Name: function_4591fd41
	Namespace: namespace_52d8d460
	Checksum: 0x14B05A8F
	Offset: 0x1438
	Size: 0x30A
	Parameters: 0
	Flags: Linked
*/
function function_4591fd41()
{
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"destroy_riotshield", #"flame_off", #"weapon_change", #"fake_death");
		if(var_be17187b._notify == "weapon_change")
		{
			if(function_ed81d8f5(var_be17187b.last_weapon))
			{
				self clientfield::set("" + #"hash_58757f4a64fedf21", 0);
				self clientfield::increment("" + #"hash_18fc1da5f1785e6b", 1);
			}
			else if(function_ed81d8f5(var_be17187b.weapon))
			{
				self clientfield::set("" + #"hash_58757f4a64fedf21", self.var_c9d375dc.n_charge_level);
			}
			if(function_a57b8fca(var_be17187b.weapon) && self.var_c9d375dc.var_276d45bf)
			{
				self clientfield::set("" + #"hash_275debebcd185ea1", 1);
			}
			else if(function_a57b8fca(var_be17187b.last_weapon) && self.var_c9d375dc.var_276d45bf)
			{
				self clientfield::set("" + #"hash_275debebcd185ea1", 0);
			}
		}
		else if(var_be17187b._notify == "destroy_riotshield" || var_be17187b._notify == "flame_off" || var_be17187b._notify == "fake_death")
		{
			self clientfield::set("" + #"hash_58757f4a64fedf21", 0);
			self clientfield::set("" + #"hash_275debebcd185ea1", 0);
			self.var_c9d375dc.var_6c90fb3f = 0;
			self.var_c9d375dc.n_charge_level = 0;
			self.var_c9d375dc.var_276d45bf = 0;
			self.var_c9d375dc.var_d0f03d3f = 0;
		}
	}
}

/*
	Name: function_fbe77fa4
	Namespace: namespace_52d8d460
	Checksum: 0x8CD279A5
	Offset: 0x1750
	Size: 0x264
	Parameters: 1
	Flags: Linked
*/
function function_fbe77fa4(weapon)
{
	if(!isdefined(level.riotshield_knockdown_enemies))
	{
		level.riotshield_knockdown_enemies = [];
		level.riotshield_knockdown_gib = [];
		level.riotshield_fling_enemies = [];
		level.riotshield_fling_vecs = [];
	}
	self riotshield::riotshield_get_enemies_in_range();
	shield_damage = 0;
	for(i = 0; i < level.riotshield_fling_enemies.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_fling_enemies[i]);
		if(isdefined(level.riotshield_fling_enemies[i]))
		{
			level.riotshield_fling_enemies[i] thread riotshield::riotshield_fling_zombie(self, level.riotshield_fling_vecs[i], i);
			shield_damage = shield_damage + zombie_utility::function_d2dfacfd(#"riotshield_fling_damage_shield");
		}
	}
	for(i = 0; i < level.riotshield_knockdown_enemies.size; i++)
	{
		[[ level.var_2677b8bb ]]->waitinqueue(level.riotshield_knockdown_enemies[i]);
		if(!isdefined(level.riotshield_knockdown_enemies[i]))
		{
			continue;
		}
		level.riotshield_knockdown_enemies[i] thread riotshield::riotshield_knockdown_zombie(self, level.riotshield_knockdown_gib[i], weapon);
		shield_damage = shield_damage + zombie_utility::function_d2dfacfd(#"riotshield_knockdown_damage_shield");
	}
	level.riotshield_knockdown_enemies = [];
	level.riotshield_knockdown_gib = [];
	level.riotshield_fling_enemies = [];
	level.riotshield_fling_vecs = [];
	if(shield_damage && !self.var_c9d375dc.var_276d45bf)
	{
		self riotshield::player_damage_shield(shield_damage, 0);
	}
}

/*
	Name: function_982a8c76
	Namespace: namespace_52d8d460
	Checksum: 0x49E193D
	Offset: 0x19C0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_982a8c76()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_melee");
		waitframe(9);
		if(waitresult.weapon.isriotshield)
		{
			self [[level.riotshield_melee]](waitresult.weapon);
		}
	}
}

/*
	Name: function_618e1db4
	Namespace: namespace_52d8d460
	Checksum: 0xE6F5E91D
	Offset: 0x1A50
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_618e1db4(weapon)
{
	if(!isdefined(self.var_e2c32bbb) || !self.var_e2c32bbb)
	{
		self.var_e2c32bbb = 1;
		self clientfield::increment("" + #"hash_26af481b9a9d41ce", 1);
		self waittill(#"end_firing");
		self.var_e2c32bbb = 0;
	}
}

/*
	Name: function_f3137e13
	Namespace: namespace_52d8d460
	Checksum: 0x8F24207B
	Offset: 0x1AE0
	Size: 0x238
	Parameters: 1
	Flags: Linked
*/
function function_f3137e13(s_params)
{
	e_attacker = s_params.eattacker;
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(function_ed81d8f5(s_params.weapon) && !e_attacker.var_c9d375dc.var_276d45bf)
	{
		e_attacker.var_c9d375dc.var_6c90fb3f++;
		n_charge = e_attacker.var_c9d375dc.var_6c90fb3f;
		if(n_charge >= 3)
		{
			e_attacker.var_c9d375dc.var_6c90fb3f = 0;
			e_attacker.var_c9d375dc.n_charge_level++;
			e_attacker clientfield::set("" + #"hash_58757f4a64fedf21", e_attacker.var_c9d375dc.n_charge_level);
			if(e_attacker.var_c9d375dc.n_charge_level >= 3)
			{
				e_attacker notify(#"flame_on", {#ai_killed:self});
				e_attacker thread function_1f1bc829();
			}
		}
	}
	if(function_ed81d8f5(s_params.weapon) && e_attacker.var_c9d375dc.var_276d45bf)
	{
		e_attacker.var_c9d375dc.var_d0f03d3f++;
		if(function_ed81d8f5(s_params.weapon, 1))
		{
			var_117c8c43 = 13;
		}
		else
		{
			var_117c8c43 = 9;
		}
		if(e_attacker.var_c9d375dc.var_d0f03d3f >= var_117c8c43)
		{
			e_attacker notify(#"flame_off");
		}
	}
}

/*
	Name: function_1f1bc829
	Namespace: namespace_52d8d460
	Checksum: 0x2B563592
	Offset: 0x1D20
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_1f1bc829()
{
	self.var_c9d375dc.var_276d45bf = 1;
}

/*
	Name: function_2a9a30bb
	Namespace: namespace_52d8d460
	Checksum: 0x1754CE3E
	Offset: 0x1D40
	Size: 0x25E
	Parameters: 13
	Flags: Linked
*/
function function_2a9a30bb(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!function_ed81d8f5(weapon))
	{
		return;
	}
	if(!isplayer(attacker))
	{
		return;
	}
	if(!(isdefined(attacker.var_c9d375dc.var_276d45bf) && attacker.var_c9d375dc.var_276d45bf))
	{
		return;
	}
	if(!isdefined(self.var_6f84b820))
	{
		return;
	}
	n_damage = damage;
	var_bb6709b6 = zm_equipment::function_379f6b5d(100);
	self namespace_9ff9f642::burn(#"hash_237b6756a81881cb", attacker, weapon, var_bb6709b6);
	switch(self.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		{
			if(level.round_number >= 30)
			{
				n_damage = self.maxhealth * 0.75;
			}
			else
			{
				n_damage = self.maxhealth + 666;
				if(self.archetype === #"zombie")
				{
					self.var_b364c165 = 1;
				}
			}
			break;
		}
		case "heavy":
		{
			n_damage = self.maxhealth * 0.3;
			break;
		}
		case "miniboss":
		{
			n_damage = self.maxhealth * 0.15;
			break;
		}
		case "boss":
		{
			n_damage = self.maxhealth * 0.05;
			break;
		}
	}
	return n_damage;
}

/*
	Name: function_3c6df289
	Namespace: namespace_52d8d460
	Checksum: 0x2831622C
	Offset: 0x1FA8
	Size: 0x1E6
	Parameters: 13
	Flags: Linked
*/
function function_3c6df289(death, inflictor, attacker, damage, flags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(!function_a57b8fca(weapon))
	{
		return;
	}
	if(!isplayer(attacker))
	{
		return;
	}
	if(!(isdefined(attacker.var_c9d375dc.var_276d45bf) && attacker.var_c9d375dc.var_276d45bf))
	{
		return;
	}
	if(!isdefined(self.var_6f84b820))
	{
		return;
	}
	n_damage = damage;
	switch(self.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		{
			if(level.round_number >= 30)
			{
				n_damage = self.maxhealth * 0.5;
			}
			else
			{
				n_damage = self.maxhealth + 666;
			}
			break;
		}
		case "heavy":
		{
			n_damage = self.maxhealth * 0.05;
			break;
		}
		case "miniboss":
		{
			n_damage = self.maxhealth * 0.035;
			break;
		}
		case "boss":
		{
			n_damage = self.maxhealth * 0.003;
			break;
		}
	}
	return n_damage;
}

/*
	Name: function_646d73c3
	Namespace: namespace_52d8d460
	Checksum: 0x7C65D8CB
	Offset: 0x2198
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_646d73c3()
{
	callback::on_connect(&function_f6c6cf23);
	level flag::init(#"hash_3551c4ab09311644");
	level flag::init(#"hash_392f20a71becaec7");
	level flag::init(#"hash_17425b597c04b9c3");
	var_6bb46490 = getentarray("t_shield_quest_hit", "targetname");
	array::thread_all(var_6bb46490, &function_a9311397);
	var_2922542c = struct::get(#"hash_727d8b7a91c0b9ba");
	var_6e14b651 = struct::get(#"hash_6ef4fc9a0ac3e3bc");
	var_3902fb90 = struct::get(#"hash_6dcfc8c42587d50d");
	var_2922542c thread function_693527ec(#"lower");
	var_6e14b651 thread function_693527ec(#"hash_d2864cf09010378");
	var_3902fb90 thread function_693527ec(#"upper");
}

/*
	Name: function_693527ec
	Namespace: namespace_52d8d460
	Checksum: 0xFEBFDC86
	Offset: 0x2348
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function function_693527ec(str_piece)
{
	level endon(#"end_game");
	self endon(#"death");
	switch(str_piece)
	{
		case "lower":
		{
			var_f4c9f09a = #"hash_4752663d0689d2c2";
			var_f00b4f9f = #"hash_4246a36eeaccdedb";
			break;
		}
		case "hash_d2864cf09010378":
		{
			var_f4c9f09a = #"hash_3c5ef4492a237f89";
			var_f00b4f9f = #"hash_1e11ea0627c40424";
			break;
		}
		case "upper":
		{
			var_f4c9f09a = #"hash_5be88bdaaf36eedf";
			var_f00b4f9f = #"hash_15ea02b45ed633fa";
			break;
		}
	}
	self.var_7788a78c = var_f4c9f09a;
	self.var_5cff93b1 = var_f00b4f9f;
	s_unitrigger = self zm_unitrigger::create(&function_fb466de8, 96);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_player = var_be17187b.e_who;
		if(e_player flag::get(var_f4c9f09a))
		{
			e_player flag::set(var_f00b4f9f);
		}
	}
}

/*
	Name: function_fb466de8
	Namespace: namespace_52d8d460
	Checksum: 0xF5686F24
	Offset: 0x2510
	Size: 0x1B0
	Parameters: 1
	Flags: Linked
*/
function function_fb466de8(e_player)
{
	s_loc = self.stub.related_parent;
	var_f4c9f09a = s_loc.var_7788a78c;
	var_f00b4f9f = s_loc.var_5cff93b1;
	b_enable = 0;
	if(e_player flag::get(var_f4c9f09a) && !e_player flag::get(var_f00b4f9f))
	{
		var_39b20ef6 = e_player zm_utility::is_player_looking_at(s_loc.origin, 0.9, 0);
		b_is_valid = zm_utility::is_player_valid(e_player, 0, 0);
		if(var_39b20ef6 && b_is_valid)
		{
			b_enable = 1;
		}
	}
	if(b_enable)
	{
		if(function_8b1a219a())
		{
			self sethintstringforplayer(e_player, #"hash_12f48f7fb7e1a8fb");
		}
		else
		{
			self sethintstringforplayer(e_player, #"hash_6f823e80320927c5");
		}
	}
	else
	{
		self sethintstringforplayer(e_player, "");
	}
	return b_enable;
}

/*
	Name: function_f6c6cf23
	Namespace: namespace_52d8d460
	Checksum: 0x7D3D38A3
	Offset: 0x26C8
	Size: 0x30C
	Parameters: 0
	Flags: Linked
*/
function function_f6c6cf23()
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self flag::init(#"hash_3551c4ab09311644");
	self flag::init(#"hash_392f20a71becaec7");
	self flag::init(#"hash_17425b597c04b9c3");
	self flag::init(#"hash_3c9852bec865f6b3");
	self flag::init(#"hash_320a1da5bf925c8b");
	self flag::init(#"hash_1d380d2c916018c9");
	self flag::init(#"hash_1e015d048e504d45");
	self flag::init(#"hash_4752663d0689d2c2");
	self flag::init(#"hash_3c5ef4492a237f89");
	self flag::init(#"hash_5be88bdaaf36eedf");
	self flag::init(#"hash_4246a36eeaccdedb");
	self flag::init(#"hash_1e11ea0627c40424");
	self flag::init(#"hash_15ea02b45ed633fa");
	/#
		self thread function_8391ad40();
	#/
	self function_cf5cc33b(level flag::get(#"hash_3551c4ab09311644"));
	self function_aa1e87dd(level flag::get(#"hash_3551c4ab09311644"));
	self function_9bf405ce(level flag::get(#"hash_392f20a71becaec7"));
	self function_8b0b5fb(level flag::get(#"hash_392f20a71becaec7"));
	self function_4284585f(level flag::get(#"hash_17425b597c04b9c3"));
	self function_d4de505d(level flag::get(#"hash_17425b597c04b9c3"));
}

/*
	Name: function_cf5cc33b
	Namespace: namespace_52d8d460
	Checksum: 0xD744954E
	Offset: 0x29E0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_cf5cc33b(var_77104def = 0)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	if(var_77104def)
	{
		return;
	}
	self.var_12c9426e = [];
	while(true)
	{
		waitframe(1);
		if(self flag::get_any(array(#"hash_320a1da5bf925c8b", #"hash_3551c4ab09311644")))
		{
			return;
		}
	}
}

/*
	Name: function_aa1e87dd
	Namespace: namespace_52d8d460
	Checksum: 0x70C1A4D9
	Offset: 0x2AA0
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_aa1e87dd(var_77104def = 0, var_19e802fa = 0)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self flag::set(#"hash_320a1da5bf925c8b");
	playsoundatposition(#"hash_3a5be037b504d0f0", (0, 0, 0));
	self thread function_3624f8c8(#"lower");
}

/*
	Name: function_a9311397
	Namespace: namespace_52d8d460
	Checksum: 0x26B7E0FA
	Offset: 0x2B70
	Size: 0x228
	Parameters: 0
	Flags: Linked
*/
function function_a9311397()
{
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		e_attacker = var_be17187b.attacker;
		w_weapon = var_be17187b.weapon;
		if(isplayer(e_attacker) && w_weapon === level.var_c9d375dc.var_c3fb4199)
		{
			if(!isdefined(e_attacker.var_12c9426e))
			{
				e_attacker.var_12c9426e = [];
			}
			else if(!isarray(e_attacker.var_12c9426e))
			{
				e_attacker.var_12c9426e = array(e_attacker.var_12c9426e);
			}
			if(!isinarray(e_attacker.var_12c9426e, self))
			{
				e_attacker.var_12c9426e[e_attacker.var_12c9426e.size] = self;
			}
			e_attacker playsoundtoplayer(#"hash_64323339bdb3dfdf", e_attacker);
			self playsound("zmb_bull_hit_ping");
			var_2634b46 = getent(self.target, "targetname");
			var_2634b46 clientfield::set("" + #"hash_333e3741e6552db3", 1);
			if(e_attacker.var_12c9426e.size >= 3)
			{
				e_attacker flag::set(#"hash_320a1da5bf925c8b");
			}
		}
	}
}

/*
	Name: function_9bf405ce
	Namespace: namespace_52d8d460
	Checksum: 0x94D0E8E7
	Offset: 0x2DA0
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_9bf405ce(var_77104def = 0)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	if(var_77104def)
	{
		return;
	}
	self.var_75cd1b31 = [];
	self thread function_4e59dd4b();
	while(true)
	{
		waitframe(1);
		if(self flag::get_any(array(#"hash_1d380d2c916018c9", #"hash_392f20a71becaec7")))
		{
			return;
		}
	}
}

/*
	Name: function_8b0b5fb
	Namespace: namespace_52d8d460
	Checksum: 0x60F0701
	Offset: 0x2E78
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_8b0b5fb(var_77104def = 0, var_19e802fa = 0)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	self flag::set(#"hash_1d380d2c916018c9");
	self thread function_3624f8c8(#"hash_d2864cf09010378");
}

/*
	Name: function_4e59dd4b
	Namespace: namespace_52d8d460
	Checksum: 0x972E1899
	Offset: 0x2F20
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_4e59dd4b()
{
	self notify("6c12dc135f714c68");
	self endon("6c12dc135f714c68");
	level endon(#"end_game");
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"flame_on");
		ai_killed = var_be17187b.ai_killed;
		if(isdefined(ai_killed))
		{
			if(isdefined(self.var_75cd1b31))
			{
				if(!isdefined(self.var_75cd1b31))
				{
					self.var_75cd1b31 = [];
				}
				else if(!isarray(self.var_75cd1b31))
				{
					self.var_75cd1b31 = array(self.var_75cd1b31);
				}
				if(!isinarray(self.var_75cd1b31, ai_killed.var_9fde8624))
				{
					self.var_75cd1b31[self.var_75cd1b31.size] = ai_killed.var_9fde8624;
				}
				if(self.var_75cd1b31.size >= 4)
				{
					self flag::set(#"hash_1d380d2c916018c9");
				}
			}
		}
	}
}

/*
	Name: function_4284585f
	Namespace: namespace_52d8d460
	Checksum: 0x4E5C84ED
	Offset: 0x3098
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_4284585f(var_77104def = 0)
{
	level endon(#"end_game", #"hash_4a06aa98c6c7b671");
	self endon(#"disconnect");
	if(var_77104def)
	{
		return;
	}
	self.var_2f4d7df0 = [];
	callback::on_ai_killed(&function_a11cc995);
	while(true)
	{
		waitframe(1);
		if(self flag::get_any(array(#"hash_1e015d048e504d45", #"hash_17425b597c04b9c3")))
		{
			return;
		}
	}
}

/*
	Name: function_a11cc995
	Namespace: namespace_52d8d460
	Checksum: 0x45DBD3F4
	Offset: 0x3188
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_a11cc995(s_params)
{
	e_attacker = s_params.eattacker;
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(isdefined(self.archetype != #"gladiator") && self.archetype != #"gladiator")
	{
		return;
	}
	if(function_ed81d8f5(s_params.weapon) && e_attacker.var_c9d375dc.var_276d45bf)
	{
		if(isdefined(e_attacker.var_2f4d7df0))
		{
			if(!isdefined(e_attacker.var_2f4d7df0))
			{
				e_attacker.var_2f4d7df0 = [];
			}
			else if(!isarray(e_attacker.var_2f4d7df0))
			{
				e_attacker.var_2f4d7df0 = array(e_attacker.var_2f4d7df0);
			}
			if(!isinarray(e_attacker.var_2f4d7df0, self.var_9fde8624))
			{
				e_attacker.var_2f4d7df0[e_attacker.var_2f4d7df0.size] = self.var_9fde8624;
			}
			if(e_attacker.var_2f4d7df0.size >= 2)
			{
				e_attacker flag::set(#"hash_1e015d048e504d45");
			}
		}
	}
}

/*
	Name: function_d4de505d
	Namespace: namespace_52d8d460
	Checksum: 0xB66A0071
	Offset: 0x3338
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_d4de505d(var_77104def = 0, var_19e802fa = 0)
{
	level endon(#"end_game");
	self endon(#"disconnect");
	callback::remove_on_ai_killed(&function_a11cc995);
	self flag::set(#"hash_1e015d048e504d45");
	self thread function_3624f8c8(#"upper");
}

/*
	Name: function_3624f8c8
	Namespace: namespace_52d8d460
	Checksum: 0x1ADEA0A1
	Offset: 0x3400
	Size: 0x2EC
	Parameters: 1
	Flags: Linked
*/
function function_3624f8c8(str_piece)
{
	self endon(#"disconnect");
	switch(str_piece)
	{
		case "lower":
		{
			var_4f1671d8 = "" + #"hash_dc971935944f005";
			var_73f25fd = "" + #"hash_6b725eefec5d09d1";
			var_3299d066 = "" + #"hash_73e9280f74528e8f";
			str_trigger = "t_shield_quest_lower_drop";
			var_f4c9f09a = #"hash_4752663d0689d2c2";
			var_f00b4f9f = #"hash_4246a36eeaccdedb";
			n_drop_time = 1;
			break;
		}
		case "hash_d2864cf09010378":
		{
			var_4f1671d8 = "" + #"hash_21ff5b4eccea85ff";
			var_73f25fd = "" + #"hash_64a830301c1adbf3";
			var_3299d066 = "" + #"hash_4f32455c6a0286cd";
			str_trigger = "t_shield_quest_katar_drop";
			var_f4c9f09a = #"hash_3c5ef4492a237f89";
			var_f00b4f9f = #"hash_1e11ea0627c40424";
			n_drop_time = 0;
			break;
		}
		case "upper":
		{
			var_4f1671d8 = "" + #"hash_32ef1785f4e55e5c";
			var_73f25fd = "" + #"hash_2cd1bb15f71aedb8";
			var_3299d066 = "" + #"hash_1769e95fdb10dfae";
			str_trigger = "t_shield_quest_upper_drop";
			var_f4c9f09a = #"hash_5be88bdaaf36eedf";
			var_f00b4f9f = #"hash_15ea02b45ed633fa";
			n_drop_time = 0.5;
			break;
		}
	}
	self clientfield::increment_to_player(var_4f1671d8);
	if(str_piece != #"hash_d2864cf09010378")
	{
		trigger::wait_till(str_trigger, "targetname", self);
	}
	self clientfield::increment_to_player(var_73f25fd);
	if(n_drop_time > 0)
	{
		wait(n_drop_time);
	}
	self flag::set(var_f4c9f09a);
	self flag::wait_till(var_f00b4f9f);
	self clientfield::increment_to_player(var_3299d066);
}

/*
	Name: function_8391ad40
	Namespace: namespace_52d8d460
	Checksum: 0xB19CB8F6
	Offset: 0x36F8
	Size: 0xF4
	Parameters: 0
	Flags: Private
*/
private function function_8391ad40()
{
	/#
		level endon(#"end_game");
		self endon(#"disconnect");
		level flag::wait_till(#"hash_3551c4ab09311644");
		self flag::set(#"hash_3551c4ab09311644");
		level flag::wait_till(#"hash_392f20a71becaec7");
		self flag::set(#"hash_392f20a71becaec7");
		level flag::wait_till(#"hash_17425b597c04b9c3");
		self flag::set(#"hash_17425b597c04b9c3");
	#/
}

