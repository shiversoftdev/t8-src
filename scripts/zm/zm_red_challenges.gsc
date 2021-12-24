// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1254ac024174d9c0;
#using script_14af1fd264ffe8cc;
#using script_14f4a3c583c77d4b;
#using script_5bb072c3abf4652c;
#using script_6e3c826b1814cab6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_red_util.gsc;
#using scripts\zm\zm_red_zones.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_14104b98;

/*
	Name: init
	Namespace: namespace_14104b98
	Checksum: 0xDFDF7626
	Offset: 0x4A0
	Size: 0xCF2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	clientfield::register("scriptmover", "" + #"hash_74fc30de57a0657a", 16000, 3, "int");
	clientfield::register("scriptmover", "" + #"hash_21f5fab6a3d22093", 16000, 3, "int");
	clientfield::register("scriptmover", "" + #"keyline_model", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_565760e2c7c1e5cb", 16000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_8b48433c3fe40e4", 16000, 3, "int");
	clientfield::register("toplayer", "" + #"hash_4bde11d71410ea67", 16000, 3, "int");
	clientfield::register("world", "" + #"hash_34bdcd0feba3d912", 16000, 1, "int");
	clientfield::register("allplayers", "" + #"hash_47490b879090eb55", 16000, 3, "int");
	clientfield::register("allplayers", "" + #"hash_7b1dd5c08e2585c", 16000, 3, "int");
	clientfield::register("scriptmover", "" + #"hash_118e9445b028d4bf", 16000, 1, "int");
	level flag::init("fl_challenge_phase_1");
	level flag::init("fl_challenge_phase_2");
	level flag::init("fl_challenge_phase_3");
	level.var_c540c875 = struct::get_array("s_challenge_loc_x", "targetname");
	level.var_c540c875 = array::randomize(level.var_c540c875);
	level.var_e3a16c1e = 0;
	level.var_f7c11d3b = [];
	for(i = 0; i < 21; i++)
	{
		level.var_f7c11d3b[i] = 0;
	}
	level flag::init("fl_challenges_initialized");
	level flag::init("fl_challenges_active");
	level thread function_e3f96252();
	level thread function_756c88b7();
	level thread function_8ff7b0bb();
	callback::on_connecting(&on_player_connect);
	callback::on_ai_killed(&on_ai_killed);
	level.var_857878e6 = &function_857878e6;
	zm::register_actor_damage_callback(&function_43359b2f);
	level.var_45420301 = [];
	level.var_45420301[level.var_45420301.size] = #"weapon_pistol";
	level.var_45420301[level.var_45420301.size] = #"weapon_cqb";
	level.var_45420301[level.var_45420301.size] = #"weapon_assault";
	level.var_45420301[level.var_45420301.size] = #"weapon_tactical";
	level.var_45420301[level.var_45420301.size] = #"weapon_lmg";
	level.var_45420301[level.var_45420301.size] = #"weapon_sniper";
	level.var_45420301[level.var_45420301.size] = #"weapon_knife";
	level.var_45420301 = array::randomize(level.var_45420301);
	level.var_b95f226e = 0;
	level.var_54800463 = [];
	level.var_54800463[level.var_54800463.size] = #"torso";
	level.var_54800463[level.var_54800463.size] = #"arms";
	level.var_54800463[level.var_54800463.size] = #"hands";
	level.var_54800463[level.var_54800463.size] = #"legs";
	level.var_54800463[level.var_54800463.size] = #"feet";
	level.var_7ccd49a7 = 0;
	level.var_529bdc63 = [];
	level.var_529bdc63[0] = struct::spawn();
	level.var_529bdc63[0].var_d8d19100 = #"gegenees";
	level.var_529bdc63[0].str_msg = #"hash_7d3a87af11535537";
	level.var_529bdc63[0].var_18f2b3cb = 0.05;
	level.var_529bdc63[0].str_zone = undefined;
	level.var_529bdc63[1] = struct::spawn();
	level.var_529bdc63[1].var_d8d19100 = #"blight_father";
	level.var_529bdc63[1].str_msg = #"hash_33f17c3034f8da74";
	level.var_529bdc63[1].var_18f2b3cb = 0.08;
	level.var_529bdc63[1].str_zone = undefined;
	level.var_529bdc63[2] = struct::spawn();
	level.var_529bdc63[2].var_d8d19100 = #"skeleton";
	level.var_529bdc63[2].str_msg = #"hash_2e51dfa0a7d98b5a";
	level.var_529bdc63[2].var_18f2b3cb = 0.07;
	level.var_529bdc63[2].str_zone = undefined;
	level.var_529bdc63[3] = struct::spawn();
	level.var_529bdc63[3].var_d8d19100 = #"catalyst";
	level.var_529bdc63[3].str_msg = #"hash_30c2fa2ab04f1d99";
	level.var_529bdc63[3].var_18f2b3cb = 0.07;
	level.var_529bdc63[3].str_zone = undefined;
	level.var_529bdc63 = array::randomize(level.var_529bdc63);
	level.var_848df2ac = 0;
	namespace_f8f28e08::init();
	level.var_fb3a9df0 = 0;
	level.var_c6ab748f = 0;
	level.var_8b7ab859 = 1000;
	level.var_e8503818 = [];
	level.var_e8503818[1] = #"hash_725802b808e14c76";
	level.var_e8503818[2] = #"hash_725802b808e14c76";
	level.var_e8503818[3] = #"hash_725802b808e14c76";
	level.var_e8503818[4] = #"hash_725802b808e14c76";
	level.var_e8503818[5] = #"hash_725802b808e14c76";
	level.var_e8503818[6] = #"hash_725802b808e14c76";
	level.var_e8503818[7] = #"hash_725802b808e14c76";
	level.var_e8503818[13] = #"hash_6401bc0ff0d3db94";
	level.var_e8503818[10] = #"hash_73d3851d119f51a4";
	level.var_e8503818[11] = #"hash_6b8b6df4e4c161a7";
	level.var_e8503818[14] = #"hash_25b9a3d3430aa158";
	level.var_e8503818[15] = #"hash_59056a7b92714e58";
	level.var_e8503818[16] = #"hash_59056a7b92714e58";
	level.var_e8503818[17] = #"hash_59056a7b92714e58";
	level.var_e8503818[18] = #"hash_59056a7b92714e58";
	level.var_e8503818[19] = #"hash_59056a7b92714e58";
	level.var_e8503818[20] = #"hash_59056a7b92714e58";
	level.var_e8503818[12] = #"hash_5440bf458877a7e2";
	level.var_e8503818[0] = #"hash_1517f0bbb322181e";
	level.var_e8503818[9] = #"hash_3cdcae60e7ea21e7";
	level.var_e8503818[8] = #"hash_62cbc1e881d872fb";
	level.var_edbe6a7f = [];
	level.var_edbe6a7f[0] = 0;
	level.var_edbe6a7f[1] = 0;
	level.var_edbe6a7f[2] = 0;
	level.var_edbe6a7f[3] = 0;
}

/*
	Name: on_player_connect
	Namespace: namespace_14104b98
	Checksum: 0xF87E1CA0
	Offset: 0x11A0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(!isbot(self))
	{
		self.s_tribute_bowl = undefined;
		self thread function_fddf3397();
		self thread player_damage_watcher();
		self thread player_death_watcher();
	}
}

/*
	Name: function_857878e6
	Namespace: namespace_14104b98
	Checksum: 0x2DA066C
	Offset: 0x1218
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_857878e6()
{
	self on_player_connect();
}

/*
	Name: function_fddf3397
	Namespace: namespace_14104b98
	Checksum: 0x1101DF97
	Offset: 0x1240
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_fddf3397()
{
	self endon(#"death");
	level flag::wait_till("fl_challenges_initialized");
	self.var_9e09931e = 0;
	n_index = self getentitynumber();
	n_tribute = level.var_edbe6a7f[n_index];
	namespace_f8f28e08::function_71c9ab64(n_tribute);
	if(n_tribute > 0 || is_active())
	{
		util::wait_network_frame();
		if(is_active())
		{
			self namespace_159b5b5b::function_b4759cf8();
		}
		if(n_tribute > 0)
		{
			self function_2bb8d916();
		}
	}
	self.var_6b3806e8 = 0;
	level flag::wait_till("fl_challenges_active");
	self.s_tribute_bowl = self function_7e8e23a6();
	namespace_f8f28e08::function_ab6fd86c(self, self.s_tribute_bowl.s_interact);
	exploder::exploder("exp_lgt_oracle_offering_bowl");
}

/*
	Name: function_2bb8d916
	Namespace: namespace_14104b98
	Checksum: 0xD3D0CB1E
	Offset: 0x13D8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_2bb8d916()
{
	self namespace_f8f28e08::function_ae2c0ba5();
	self namespace_f8f28e08::function_b858f95a();
}

/*
	Name: player_damage_watcher
	Namespace: namespace_14104b98
	Checksum: 0x960C7DB8
	Offset: 0x1418
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function player_damage_watcher()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		n_damage = waitresult.amount;
		self.var_d5e64932 = gettime() / 1000;
		if(is_challenge_active(10))
		{
			self thread function_bf582bc8(10, n_damage);
		}
	}
}

/*
	Name: player_death_watcher
	Namespace: namespace_14104b98
	Checksum: 0xA63FE32C
	Offset: 0x14C8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function player_death_watcher(a_params)
{
	s_bowl = self.s_tribute_bowl;
	self waittill(#"death");
	if(isdefined(s_bowl) && isdefined(s_bowl.var_9d32404))
	{
		s_bowl.var_9d32404 clientfield::set("" + #"hash_21f5fab6a3d22093", 0);
	}
}

/*
	Name: function_43359b2f
	Namespace: namespace_14104b98
	Checksum: 0xA5949FF5
	Offset: 0x1558
	Size: 0xA8
	Parameters: 12
	Flags: Linked
*/
function function_43359b2f(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(zm_utility::is_player_valid(attacker, 0, 1))
	{
		function_4ca8c034(attacker, weapon, shitloc, meansofdeath);
	}
	return damage;
}

/*
	Name: on_ai_killed
	Namespace: namespace_14104b98
	Checksum: 0x9DC55882
	Offset: 0x1608
	Size: 0x504
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	e_player = s_params.eattacker;
	str_hit_loc = s_params.shitloc;
	weapon = s_params.weapon;
	means_of_death = s_params.smeansofdeath;
	if(isplayer(e_player) && isdefined(weapon) && weapon.name == #"zhield_zpear_turret")
	{
		if(!isdefined(e_player.var_53ce87a7))
		{
			e_player.var_53ce87a7 = 0;
			e_player.var_822346e9 = 0;
		}
		if(e_player.var_822346e9 < 3)
		{
			if(e_player.var_53ce87a7 != level.round_number)
			{
				e_player thread zm_audio::create_and_play_dialog(#"hash_772ca93255e7605", #"kill");
				e_player.var_53ce87a7 = level.round_number;
				e_player.var_822346e9++;
			}
		}
	}
	if(isplayer(e_player))
	{
		if(is_challenge_active(14) && (!(isdefined(self.var_45bfef99) && self.var_45bfef99)))
		{
			if(isdefined(str_hit_loc))
			{
				if(str_hit_loc == #"helmet" || str_hit_loc == #"head")
				{
					level notify(#"zombie_challenge_kill", {#e_player:s_params.eattacker});
				}
			}
		}
		else if(is_challenge_active(12))
		{
			if(zm_loadout::is_hero_weapon(weapon))
			{
				level notify(#"kill_with_hero_weapon", {#weapon:weapon, #e_player:e_player});
			}
		}
		else if(is_challenge_active(8))
		{
			if(isdefined(weapon) && zm_weapons::is_wonder_weapon(weapon))
			{
				level notify(#"kill_with_god_hand", {#e_player:e_player});
			}
		}
		else if(is_challenge_active(9))
		{
			if(isdefined(weapon) && weapon.inventorytype == #"offhand")
			{
				level notify(#"kill_with_equipment", {#means_of_death:means_of_death, #e_player:e_player});
			}
		}
		else if(is_challenge_active(13))
		{
			if(means_of_death == "MOD_MELEE" || (isdefined(weapon) && #"zhield_zpear_dw" === weapon.name && "MOD_IMPACT" === means_of_death))
			{
				level notify(#"player_melees_zombie", {#e_player:e_player});
			}
		}
		else if(is_challenge_active(1) || is_challenge_active(2) || is_challenge_active(3) || is_challenge_active(4) || is_challenge_active(5) || is_challenge_active(6) || is_challenge_active(7))
		{
			level thread function_5e882c6f(e_player, self.origin);
		}
		else
		{
			function_4ca8c034(e_player, weapon, str_hit_loc, means_of_death);
		}
	}
}

/*
	Name: function_4ca8c034
	Namespace: namespace_14104b98
	Checksum: 0x8E6132D8
	Offset: 0x1B18
	Size: 0x168
	Parameters: 4
	Flags: Linked
*/
function function_4ca8c034(attacker, weapon, hit_loc, means_of_death)
{
	if(!isplayer(attacker))
	{
		return;
	}
	if(is_challenge_active(13))
	{
		if(means_of_death == "MOD_MELEE" || (isdefined(weapon) && #"zhield_zpear_dw" === weapon.name && "MOD_IMPACT" === means_of_death))
		{
			level notify(#"player_melees_zombie", {#e_player:attacker});
		}
	}
	else if(is_challenge_active(0))
	{
		if(isdefined(weapon))
		{
			if(weapon.name == #"zhield_zpear_dw" || weapon.name == #"zhield_zpear_turret")
			{
				level notify(#"shield_and_spear_damage", {#e_player:attacker});
			}
		}
	}
}

/*
	Name: function_e3f96252
	Namespace: namespace_14104b98
	Checksum: 0xFF545778
	Offset: 0x1C88
	Size: 0x7A4
	Parameters: 0
	Flags: Linked
*/
function function_e3f96252()
{
	level flag::wait_till("all_players_spawned");
	level.var_12080390 = [];
	level.var_12080390[0] = function_cd7f17dd(1, 1, 120, &function_572ece72, "zone_temple_of_apollo");
	level.var_12080390[1] = function_cd7f17dd(2, 1, 120, &function_572ece72, "zone_amphitheater");
	level.var_12080390[2] = function_cd7f17dd(3, 2, 120, &function_572ece72, "zone_drakaina_arena");
	level.var_12080390[3] = function_cd7f17dd(4, 1, 120, &function_572ece72, "zone_spartan_monument_west");
	level.var_12080390[4] = function_cd7f17dd(5, 1, 120, &function_572ece72, "zone_stoa_of_the_athenians_east");
	level.var_12080390[5] = function_cd7f17dd(6, 1, 120, &function_572ece72, "zone_offering");
	level.var_12080390[6] = function_cd7f17dd(7, 2, 120, &function_572ece72, "zone_river_upper");
	level.var_12080390[7] = function_cd7f17dd(13, 0, 120, &function_2dcc7ade, undefined);
	level.var_12080390[8] = function_cd7f17dd(10, 0, 120, &function_a987b682, 2);
	level.var_12080390[9] = function_cd7f17dd(11, 0, 120, &function_2dcc7ade, undefined);
	level.var_12080390[10] = function_cd7f17dd(14, 0, 120, &function_2dcc7ade, undefined);
	level.var_12080390[11] = function_cd7f17dd(15, 2, 120, &function_c0539e40, "zone_cliff_tombs_upper");
	level.var_12080390[12] = function_cd7f17dd(16, 1, 120, &function_c0539e40, "zone_bathhouse_inside");
	level.var_12080390[13] = function_cd7f17dd(17, 1, 120, &function_c0539e40, "zone_eastern_plaza");
	level.var_12080390[14] = function_cd7f17dd(18, 2, 120, &function_c0539e40, "zone_serpent_pass_bridge");
	level.var_12080390[15] = function_cd7f17dd(19, 1, 120, &function_c0539e40, "zone_spartan_monument_west");
	level.var_12080390[16] = function_cd7f17dd(20, 1, 120, &function_c0539e40, "zone_spartan_monument_west");
	if(namespace_59ff1d6c::function_901b751c(#"hash_b066c34278e6394"))
	{
		level.var_12080390[17] = function_cd7f17dd(12, 0, 120, &function_69a721d, 4);
	}
	if(namespace_59ff1d6c::function_901b751c(#"zmshieldisenabled"))
	{
		level.var_12080390[18] = function_cd7f17dd(0, 0, 120, &function_40ccb2dc, undefined);
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_65a1298089d361f1"))
	{
		level.var_12080390[19] = function_cd7f17dd(9, 0, 120, &function_2dcc7ade, undefined);
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_541a4d5c476468f4"))
	{
		level.var_12080390[20] = function_cd7f17dd(8, 0, 120, &function_6e07042a, undefined);
	}
	level.var_12080390 = array::randomize(level.var_12080390);
	level.var_2dffd020 = 0;
	level.var_ead4c5d4 = struct::get_array("s_oracle_challenge_interact", "targetname");
	foreach(s_interact in level.var_ead4c5d4)
	{
		s_interact zm_unitrigger::create(&function_f3059d3b, 64, &function_5804d6ff);
	}
	level flag::wait_till("all_players_connected");
	level thread setup_models();
	wait(1);
	level flag::set("fl_challenges_initialized");
	level flag::wait_till("power_on");
	level flag::set("fl_challenges_active");
	level.var_2dffd020 = 1;
	level thread game_over();
}

/*
	Name: game_over
	Namespace: namespace_14104b98
	Checksum: 0xFB6AB601
	Offset: 0x2438
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function game_over()
{
	level waittill(#"end_game");
	function_304fb042();
}

/*
	Name: function_cd7f17dd
	Namespace: namespace_14104b98
	Checksum: 0x65DA8ACD
	Offset: 0x2470
	Size: 0xE6
	Parameters: 5
	Flags: Linked
*/
function function_cd7f17dd(n_challenge, n_zone, var_6346e7b, var_12af4e08 = &function_2dcc7ade, var_893baaf = undefined)
{
	s_challenge = spawnstruct();
	s_challenge.n_id = n_challenge;
	s_challenge.str_msg = level.var_e8503818[n_challenge];
	s_challenge.var_12af4e08 = var_12af4e08;
	s_challenge.var_893baaf = var_893baaf;
	s_challenge.n_count = 0;
	s_challenge.var_6346e7b = var_6346e7b;
	s_challenge.n_zone = n_zone;
	return s_challenge;
}

/*
	Name: function_49e4f4ca
	Namespace: namespace_14104b98
	Checksum: 0x20267144
	Offset: 0x2560
	Size: 0x92
	Parameters: 1
	Flags: None
*/
function function_49e4f4ca(var_ecffa2a8)
{
	foreach(s_challenge in level.var_12080390)
	{
		if(s_challenge.n_id == var_ecffa2a8)
		{
			return s_challenge.var_893baaf;
		}
	}
	return undefined;
}

/*
	Name: function_f3059d3b
	Namespace: namespace_14104b98
	Checksum: 0xC95F8E
	Offset: 0x2600
	Size: 0x2F6
	Parameters: 1
	Flags: Linked
*/
function function_f3059d3b(e_player)
{
	wpn_current = e_player getcurrentweapon();
	if(!e_player namespace_159b5b5b::can_see(self.origin, 0, -1))
	{
		self sethintstringforplayer(e_player, "");
		return 0;
	}
	if(isdefined(wpn_current.isriotshield) && wpn_current.isriotshield)
	{
		self sethintstringforplayer(e_player, "");
		return 0;
	}
	if(level.var_2dffd020 == 0)
	{
		self sethintstringforplayer(e_player, #"hash_4aa00a9bc891ac28");
		return 1;
	}
	if(namespace_497ab7da::is_active())
	{
		self sethintstringforplayer(e_player, #"hash_55d25caf8f7bbb2f");
		return 1;
	}
	if(level.var_2dffd020 == 1)
	{
		str_prompt = zm_utility::function_d6046228(#"hash_6219013948376d70", #"hash_27cdd9110057055c");
		self sethintstringforplayer(e_player, str_prompt, level.var_d3a8f03b);
		return 1;
	}
	if(level.var_2dffd020 == 2)
	{
		if(level.var_c6ab748f < 0)
		{
			if(e_player zm_score::can_player_purchase(level.var_48442709))
			{
				str_prompt = zm_utility::function_d6046228(#"hash_7b3248a20689a28d", #"hash_10f3f07d744bca73");
				self sethintstringforplayer(e_player, str_prompt, level.var_48442709);
			}
			else
			{
				self sethintstringforplayer(e_player, #"hash_1631121fed1a7edf", level.var_48442709);
			}
		}
		else
		{
			self sethintstringforplayer(e_player, #"hash_21bb55a0a8972155");
		}
		return 1;
	}
	self sethintstringforplayer(e_player, "");
	return 0;
}

/*
	Name: function_5804d6ff
	Namespace: namespace_14104b98
	Checksum: 0x84FFE54D
	Offset: 0x2900
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_5804d6ff()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player, 0))
		{
			continue;
		}
		if(!level flag::get("power_on") || namespace_497ab7da::is_active())
		{
			continue;
		}
		if(!e_player zm_score::can_player_purchase(level.var_d3a8f03b))
		{
			if(!isdefined(e_player.var_e41784d5))
			{
				e_player.var_e41784d5 = 0;
			}
			n_time = gettime() / 1000;
			dt = n_time - e_player.var_e41784d5;
			if(dt > 12)
			{
				e_player thread zm_audio::create_and_play_dialog(#"generic", #"nomoney");
				e_player.var_e41784d5 = n_time;
			}
			continue;
		}
		if(level.var_2dffd020 == 1)
		{
			if(e_player zm_score::can_player_purchase(level.var_d3a8f03b))
			{
				e_player playsound(#"hash_73188c838e8d29c7");
				e_player thread zm_score::minus_to_player_score(level.var_d3a8f03b);
				level thread start_challenge();
				level.var_c6ab748f = 0;
				e_player thread zm_audio::create_and_play_dialog(#"tribute", #"initiate");
			}
		}
		else if(level.var_2dffd020 == 2 && level.var_c6ab748f < 0)
		{
			if(e_player zm_score::can_player_purchase(level.var_48442709))
			{
				e_player playsound(#"hash_73188c838e8d29c7");
				e_player thread zm_score::minus_to_player_score(level.var_48442709);
				level thread start_challenge();
				level.var_c6ab748f++;
			}
		}
	}
}

/*
	Name: setup_models
	Namespace: namespace_14104b98
	Checksum: 0xEC4CB0A4
	Offset: 0x2BF8
	Size: 0x36E
	Parameters: 0
	Flags: Linked
*/
function setup_models()
{
	var_8b17a3d1 = struct::get_array("s_tribute_bowl", "targetname");
	level.var_c37fe7bc = 0;
	level.var_3e72dc3c = [];
	foreach(s_bowl in var_8b17a3d1)
	{
		s_info = struct::spawn();
		n_index = level.var_3e72dc3c.size;
		level.var_3e72dc3c[n_index] = s_info;
		s_info.s_interact = s_bowl;
		s_info.var_126ddafe = getent(s_bowl.target, "targetname");
		v_pos = s_bowl.origin;
		if(!(isdefined(s_bowl.var_b4a48463) && s_bowl.var_b4a48463))
		{
			v_dir = anglestoforward(s_info.angles);
			v_pos = v_pos + (v_dir * -9);
		}
		s_info.var_9d32404 = util::spawn_model(#"tag_origin", v_pos, s_bowl.angles);
		s_info.var_1a34d8e = level.var_3e72dc3c[n_index].var_9d32404.origin + vectorscale((0, 0, 1), 35);
		s_info.var_7b63dcba = (0, 0, 0);
		v_dir = anglestoforward(s_info.angles);
		v_pos = s_info.var_1a34d8e + (v_dir * 85);
		s_info.var_8f683ef8 = groundtrace(v_pos, v_pos + (vectorscale((0, 0, -1), 400)), 0, s_info.var_99f92cf4)[#"position"];
	}
	waitframe(1);
	var_e668d197 = 1;
	foreach(s_info in level.var_3e72dc3c)
	{
		s_info.var_e668d197 = var_e668d197;
		s_info.var_126ddafe clientfield::set("" + #"hash_8b48433c3fe40e4", s_info.var_e668d197);
		var_e668d197++;
	}
}

/*
	Name: function_756c88b7
	Namespace: namespace_14104b98
	Checksum: 0xFC323DE9
	Offset: 0x2F70
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_756c88b7()
{
	level endon(#"game_ended");
	function_9e7dc4fb();
	function_895a4ebf();
	while(true)
	{
		level waittill(#"end_of_round");
		function_9e7dc4fb();
		function_895a4ebf();
	}
}

/*
	Name: function_895a4ebf
	Namespace: namespace_14104b98
	Checksum: 0x83D640F3
	Offset: 0x2FF8
	Size: 0x1B8
	Parameters: 0
	Flags: Linked
*/
function function_895a4ebf()
{
	var_4d0cb1b1 = level.var_1044e9e1;
	if(!isdefined(level.round_number))
	{
		n_round_number = 1;
	}
	else
	{
		n_round_number = level.round_number;
	}
	if(isdefined(level.var_6e5099bb))
	{
		switch(level.var_6e5099bb)
		{
			case 1:
			{
				n_round_number = 10;
				break;
			}
			case 2:
			{
				n_round_number = 20;
				break;
			}
			case 3:
			{
				n_round_number = 21;
				break;
			}
		}
	}
	if(n_round_number <= 10)
	{
		level.var_1044e9e1 = 1;
		level flag::set("fl_challenge_phase_1");
	}
	else if(n_round_number <= 20)
	{
		level.var_1044e9e1 = 2;
		level flag::set("fl_challenge_phase_2");
	}
	else
	{
		level.var_1044e9e1 = 3;
		level flag::set("fl_challenge_phase_3");
	}
	if(level.var_1044e9e1 > 1)
	{
		if(!isdefined(var_4d0cb1b1) || var_4d0cb1b1 != level.var_1044e9e1)
		{
			level notify(#"hash_58de66439e1aa5a2");
		}
	}
}

/*
	Name: function_9e7dc4fb
	Namespace: namespace_14104b98
	Checksum: 0x58A8FB26
	Offset: 0x31B8
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_9e7dc4fb()
{
	if(isdefined(level.round_number) && level.round_number >= 10)
	{
		if(!isdefined(level.var_572d28a8))
		{
			level.var_572d28a8 = 0;
		}
		level.var_572d28a8--;
		if(level.var_572d28a8 <= 0)
		{
			level.var_d3a8f03b = int(level.var_d3a8f03b + 500);
			level.var_572d28a8 = 5;
		}
	}
	else
	{
		level.var_d3a8f03b = 500;
	}
	level.var_48442709 = 500;
}

/*
	Name: function_7e8e23a6
	Namespace: namespace_14104b98
	Checksum: 0xD865674D
	Offset: 0x3290
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function function_7e8e23a6()
{
	if(1)
	{
		n_index = self getentitynumber();
		s_bowl = level.var_3e72dc3c[n_index];
		self clientfield::set_to_player("" + #"hash_4bde11d71410ea67", s_bowl.var_e668d197);
		return s_bowl;
	}
	while(true)
	{
		s_bowl = level.var_3e72dc3c[level.var_c37fe7bc];
		level.var_c37fe7bc++;
		if(level.var_c37fe7bc >= level.var_3e72dc3c.size)
		{
			level.var_c37fe7bc = 0;
		}
		if(!maxis_quest_(s_bowl))
		{
			self clientfield::set_to_player("" + #"hash_4bde11d71410ea67", s_bowl.var_e668d197);
			return s_bowl;
		}
	}
	return undefined;
}

/*
	Name: maxis_quest_
	Namespace: namespace_14104b98
	Checksum: 0x35391E3B
	Offset: 0x33C8
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function maxis_quest_(s_bowl)
{
	a_players = getplayers();
	foreach(player in a_players)
	{
		if(player.s_tribute_bowl === s_bowl)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_be1cda91
	Namespace: namespace_14104b98
	Checksum: 0x74CAA931
	Offset: 0x3470
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function function_be1cda91()
{
	var_99d6574b = undefined;
	if(isdefined(level.var_656c1a37))
	{
		foreach(s_challenge in level.var_12080390)
		{
			if(s_challenge.n_id == level.var_656c1a37)
			{
				var_99d6574b = s_challenge;
				level.var_656c1a37 = undefined;
				break;
			}
		}
	}
	else
	{
		var_881d9045 = 1000;
		foreach(s_challenge in level.var_12080390)
		{
			if(s_challenge.n_count < var_881d9045 && s_challenge [[s_challenge.var_12af4e08]](s_challenge.var_893baaf))
			{
				var_881d9045 = s_challenge.n_count;
				var_99d6574b = s_challenge;
			}
		}
	}
	var_99d6574b.n_count++;
	return var_99d6574b;
}

/*
	Name: start_challenge
	Namespace: namespace_14104b98
	Checksum: 0xDAA7515A
	Offset: 0x35F8
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function start_challenge()
{
	if(isdefined(level.var_51d3a718))
	{
		stop_challenge(0);
		waitframe(1);
	}
	foreach(player in getplayers())
	{
		player namespace_159b5b5b::function_76f2fea0(1);
	}
	foreach(player in getplayers())
	{
		player namespace_159b5b5b::function_9ab191d3(0);
	}
	s_challenge = function_be1cda91();
	if(!isdefined(s_challenge))
	{
		return;
	}
	foreach(player in getplayers())
	{
		player notify(#"start_challenge");
	}
	waitframe(1);
	level thread function_8f0594cb(s_challenge);
}

/*
	Name: stop_challenge
	Namespace: namespace_14104b98
	Checksum: 0x5376A866
	Offset: 0x3800
	Size: 0x18E
	Parameters: 1
	Flags: Linked
*/
function stop_challenge(var_c91a0fe1)
{
	namespace_159b5b5b::stop_timer();
	level [[level.var_51d3a718.var_3e17832]]();
	level.var_fb3a9df0++;
	foreach(player in getplayers())
	{
		player notify(#"stop_challenge");
	}
	wait(0.1);
	foreach(player in getplayers())
	{
		player namespace_159b5b5b::function_7e30f24c();
	}
	if(var_c91a0fe1)
	{
		level thread function_836d2b5b();
	}
	level.var_2dffd020 = 1;
	level.var_51d3a718 = undefined;
	level notify(#"hash_61075af70fbd9082");
	waitframe(1);
}

/*
	Name: function_8f0594cb
	Namespace: namespace_14104b98
	Checksum: 0x122E1A56
	Offset: 0x3998
	Size: 0x5D4
	Parameters: 1
	Flags: Linked
*/
function function_8f0594cb(s_challenge)
{
	level endon(#"hash_61075af70fbd9082");
	level.var_51d3a718 = s_challenge;
	level.var_2dffd020 = 2;
	level.var_62ecc169 = gettime() / 1000;
	switch(level.var_51d3a718.n_id)
	{
		case 0:
		{
			level.var_51d3a718.var_c376bcd5 = &function_7f470031;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
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
			level.var_51d3a718.var_c376bcd5 = &function_f51adffa;
			level.var_51d3a718.var_3e17832 = &function_9742c28f;
			break;
		}
		case 9:
		{
			level.var_51d3a718.var_c376bcd5 = &function_77d6b526;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 10:
		{
			level.var_51d3a718.var_c376bcd5 = &function_1398b789;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 12:
		{
			level.var_51d3a718.var_c376bcd5 = &function_8d1fd2d8;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 11:
		{
			level.var_51d3a718.var_c376bcd5 = &function_4a88eb80;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 13:
		{
			level.var_51d3a718.var_c376bcd5 = &function_727cdea9;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 14:
		{
			level.var_51d3a718.var_c376bcd5 = &function_c106ffd8;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 8:
		{
			level.var_51d3a718.var_c376bcd5 = &function_7d77dbd6;
			level.var_51d3a718.var_3e17832 = &function_1398b789;
			break;
		}
		case 15:
		case 16:
		case 17:
		case 18:
		case 19:
		case 20:
		{
			level.var_51d3a718.var_c376bcd5 = &function_1d60215;
			level.var_51d3a718.var_3e17832 = &function_6be352fc;
			break;
		}
	}
	foreach(player in getplayers())
	{
		player thread namespace_159b5b5b::show_text(level.var_51d3a718.str_msg, 0, "stop_challenge");
		player.var_6b3806e8 = 0;
	}
	level thread [[level.var_51d3a718.var_c376bcd5]]();
	namespace_159b5b5b::start_timer(s_challenge.var_6346e7b + 1);
	var_be17187b = undefined;
	var_be17187b = level waittill_timeout(s_challenge.var_6346e7b + 1, #"round_reset");
	while(isdefined(level.var_dc6fce4f) && level.var_dc6fce4f)
	{
		waitframe(1);
	}
	var_c304d266 = var_be17187b._notify === "timeout";
	stop_challenge(var_c304d266);
}

/*
	Name: function_7f470031
	Namespace: namespace_14104b98
	Checksum: 0xA63C9C1C
	Offset: 0x3F78
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7f470031()
{
	self thread function_9ffc76ea("shield_and_spear_damage");
}

/*
	Name: function_8d1fd2d8
	Namespace: namespace_14104b98
	Checksum: 0xB517DC06
	Offset: 0x3FA8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_8d1fd2d8()
{
	self thread function_9ffc76ea("kill_with_hero_weapon");
}

/*
	Name: function_4a88eb80
	Namespace: namespace_14104b98
	Checksum: 0xBC23559B
	Offset: 0x3FD8
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_4a88eb80()
{
	level endon(#"hash_61075af70fbd9082");
	var_53a794b0 = gettime() / 1000;
	while(true)
	{
		wait(2);
		n_time = gettime() / 1000;
		foreach(player in getplayers())
		{
			b_reward = 0;
			if(!isdefined(player.var_d5e64932))
			{
				b_reward = 1;
			}
			else
			{
				n_time_since_last_damage = n_time - player.var_d5e64932;
				if(n_time_since_last_damage > 15)
				{
					b_reward = 1;
				}
			}
			if(b_reward)
			{
				player namespace_159b5b5b::function_9ab191d3(0);
				player namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id);
				continue;
			}
			player namespace_159b5b5b::function_9ab191d3(1);
		}
		var_53a794b0 = n_time;
	}
}

/*
	Name: function_f51adffa
	Namespace: namespace_14104b98
	Checksum: 0x9F69FFDE
	Offset: 0x4170
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function function_f51adffa()
{
	switch(level.var_51d3a718.n_id)
	{
		case 1:
		{
			level.var_80ec74ca = #"hash_792c0919250a07e";
			break;
		}
		case 2:
		{
			level.var_80ec74ca = #"hash_4691be55f6b2f7fb";
			break;
		}
		case 3:
		{
			level.var_80ec74ca = #"hash_4ee0858a78847ce8";
			break;
		}
		case 4:
		{
			level.var_80ec74ca = #"hash_19886b94618ff9a4";
			break;
		}
		case 5:
		{
			level.var_80ec74ca = #"hash_474e7ba807dd9646";
			break;
		}
		case 6:
		{
			level.var_80ec74ca = #"hash_395eaaa6ebb3ceb7";
			break;
		}
		case 7:
		{
			level.var_80ec74ca = #"hash_756f97bb7e6ff36d";
			break;
		}
	}
	level.var_be2ff8ca = zm_utility::function_d7db256e(level.var_80ec74ca, undefined, 1);
	level.var_2c5f83d = namespace_a409d261::function_27028b8e(level.var_4427ebb1);
	foreach(player in getplayers())
	{
		player thread namespace_159b5b5b::show_text(level.var_2c5f83d, 0, "stop_challenge", 0);
		player thread function_173c3ce8(level.var_51d3a718.n_id, level.var_2c5f83d, undefined);
	}
}

/*
	Name: function_9742c28f
	Namespace: namespace_14104b98
	Checksum: 0xB566AE34
	Offset: 0x4408
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_9742c28f()
{
	zm_utility::function_b1f3be5c(level.var_be2ff8ca, level.var_80ec74ca);
}

/*
	Name: function_727cdea9
	Namespace: namespace_14104b98
	Checksum: 0x78558741
	Offset: 0x4438
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_727cdea9()
{
	self thread function_9ffc76ea("player_melees_zombie");
}

/*
	Name: function_77d6b526
	Namespace: namespace_14104b98
	Checksum: 0xDDA316F3
	Offset: 0x4468
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_77d6b526()
{
	self thread function_9ffc76ea("kill_with_equipment");
}

/*
	Name: function_7d77dbd6
	Namespace: namespace_14104b98
	Checksum: 0x3F66BCE7
	Offset: 0x4498
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7d77dbd6()
{
	self thread function_9ffc76ea("kill_with_god_hand");
}

/*
	Name: function_1d60215
	Namespace: namespace_14104b98
	Checksum: 0x744FCBD7
	Offset: 0x44C8
	Size: 0x454
	Parameters: 0
	Flags: Linked
*/
function function_1d60215()
{
	level endon(#"hash_61075af70fbd9082");
	switch(level.var_51d3a718.n_id)
	{
		case 15:
		{
			level.var_c699da9d = #"hash_3ae778d55ad6e8e4";
			var_9862b6f2 = #"hash_787fa78858071ba9";
			break;
		}
		case 16:
		{
			level.var_c699da9d = #"hash_7fce9e20e92e7a3d";
			var_9862b6f2 = #"hash_50663d02f6b02c16";
			break;
		}
		case 17:
		{
			level.var_c699da9d = #"hash_12d624b76e928e2a";
			var_9862b6f2 = #"hash_224b2f96e6aeef3d";
			break;
		}
		case 18:
		{
			level.var_c699da9d = #"hash_503d347bb0f6c1ad";
			var_9862b6f2 = #"hash_365d2b268bbfd068";
			break;
		}
		case 19:
		{
			level.var_c699da9d = #"hash_3221d4665aec6c07";
			var_9862b6f2 = #"hash_5b07fa123f86d7e0";
			break;
		}
		case 20:
		{
			level.var_c699da9d = #"hash_7a9a40ca466c3b4d";
			var_9862b6f2 = #"hash_666d2ebd0b7eb112";
			break;
		}
		default:
		{
			return;
			break;
		}
	}
	s_info = struct::get(level.var_c699da9d, "targetname");
	vol_area = getent(s_info.script_noteworthy, "targetname");
	foreach(player in getplayers())
	{
		player thread namespace_159b5b5b::show_text(var_9862b6f2, 0, "stop_challenge", 0);
		player thread function_173c3ce8(level.var_51d3a718.n_id, undefined, vol_area);
	}
	level.var_ae2ad596 = zm_utility::function_d7db256e(level.var_c699da9d, undefined, 1);
	while(true)
	{
		n_time = gettime() / 1000;
		foreach(player in getplayers())
		{
			if(!isdefined(player.var_f94035ca))
			{
				player.var_f94035ca = 0;
			}
			dt = n_time - player.var_f94035ca;
			if(isdefined(player.var_b05f25ad) && player.var_b05f25ad && dt <= 2)
			{
				player namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id);
				continue;
			}
			player.var_f94035ca = n_time;
		}
		wait(2);
	}
}

/*
	Name: function_6be352fc
	Namespace: namespace_14104b98
	Checksum: 0x72B6031B
	Offset: 0x4928
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_6be352fc()
{
	zm_utility::function_b1f3be5c(level.var_acc31847, level.var_c699da9d);
}

/*
	Name: function_c106ffd8
	Namespace: namespace_14104b98
	Checksum: 0x5F12C982
	Offset: 0x4958
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_c106ffd8()
{
	level thread function_9ffc76ea("zombie_challenge_kill");
}

/*
	Name: function_2dcc7ade
	Namespace: namespace_14104b98
	Checksum: 0xFB959854
	Offset: 0x4988
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_2dcc7ade(var_893baaf = undefined)
{
	return 1;
}

/*
	Name: function_40ccb2dc
	Namespace: namespace_14104b98
	Checksum: 0xA62CA36D
	Offset: 0x49B0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_40ccb2dc(var_893baaf = undefined)
{
	if(isdefined(level.var_f9e5f55a) && level.var_f9e5f55a)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_6e07042a
	Namespace: namespace_14104b98
	Checksum: 0x8E203326
	Offset: 0x49F8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_6e07042a(var_893baaf = undefined)
{
	foreach(player in getplayers())
	{
		if(player flag::exists(#"hash_664c4b8d9b3d0237") && player flag::get(#"hash_664c4b8d9b3d0237"))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_69a721d
	Namespace: namespace_14104b98
	Checksum: 0xCE3E0E73
	Offset: 0x4AD8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_69a721d(var_893baaf = undefined)
{
	if(level.round_number >= var_893baaf)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a987b682
	Namespace: namespace_14104b98
	Checksum: 0x6B0FF2F9
	Offset: 0x4B18
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_a987b682(var_893baaf = undefined)
{
	if(level.gamedifficulty > var_893baaf)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_572ece72
	Namespace: namespace_14104b98
	Checksum: 0xEFD3AB0F
	Offset: 0x4B58
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_572ece72(var_893baaf = undefined)
{
	if(!function_863d38d3(self.n_zone))
	{
		return 0;
	}
	if(!isdefined(level.var_9376b4fc))
	{
		level.var_9376b4fc = 0;
	}
	var_4d94b079 = level.var_fb3a9df0 - level.var_9376b4fc;
	if(var_4d94b079 <= 1)
	{
		return 0;
	}
	b_available = function_7fcc1087(var_893baaf);
	if(b_available)
	{
		level.var_9376b4fc = level.var_fb3a9df0;
	}
	return b_available;
}

/*
	Name: function_863d38d3
	Namespace: namespace_14104b98
	Checksum: 0xA634711D
	Offset: 0x4C28
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_863d38d3(n_zone)
{
	switch(n_zone)
	{
		case 1:
		{
			if(function_5c5cb67b() && !function_2d371444())
			{
				return 0;
			}
			break;
		}
		case 2:
		{
			if(!function_5c5cb67b())
			{
				return 0;
			}
			break;
		}
		case 0:
		default:
		{
			break;
		}
	}
	return 1;
}

/*
	Name: function_c0539e40
	Namespace: namespace_14104b98
	Checksum: 0xDA91ED3D
	Offset: 0x4CF0
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_c0539e40(var_893baaf = undefined)
{
	if(!function_863d38d3(self.n_zone))
	{
		return 0;
	}
	if(!isdefined(level.var_9050c9b4))
	{
		level.var_9050c9b4 = 0;
	}
	var_52547a9a = level.var_fb3a9df0 - level.var_9050c9b4;
	if(var_52547a9a <= 1)
	{
		return 0;
	}
	b_available = function_7fcc1087(var_893baaf);
	if(b_available)
	{
		level.var_9050c9b4 = level.var_fb3a9df0;
	}
	return b_available;
}

/*
	Name: function_7fcc1087
	Namespace: namespace_14104b98
	Checksum: 0x3292C0D3
	Offset: 0x4DC0
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_7fcc1087(var_893baaf = undefined)
{
	level.var_4427ebb1 = var_893baaf;
	if(isdefined(level.var_4427ebb1) && isdefined(level.zones[level.var_4427ebb1]))
	{
		if(level.zones[level.var_4427ebb1].is_enabled)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_2d371444
	Namespace: namespace_14104b98
	Checksum: 0xCAFF5B3A
	Offset: 0x4E48
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_2d371444(var_893baaf = undefined)
{
	if(level flag::get(#"pap_quest_completed"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_challenge_active
	Namespace: namespace_14104b98
	Checksum: 0xD3159F6D
	Offset: 0x4E98
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function is_challenge_active(var_ecffa2a8)
{
	if(isdefined(level.var_51d3a718) && level.var_51d3a718.n_id == var_ecffa2a8)
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_active
	Namespace: namespace_14104b98
	Checksum: 0x3E208B1D
	Offset: 0x4EE8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	if(isdefined(level.var_51d3a718))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_94bdb104
	Namespace: namespace_14104b98
	Checksum: 0xD65077C
	Offset: 0x4F10
	Size: 0x5A
	Parameters: 2
	Flags: None
*/
function function_94bdb104(s_struct, ai_killed)
{
	n_distance = distance(level.var_cf9c7fdc.origin, ai_killed.origin);
	if(n_distance > 400)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_305e672f
	Namespace: namespace_14104b98
	Checksum: 0xB0E9C91D
	Offset: 0x4F78
	Size: 0x64
	Parameters: 2
	Flags: None
*/
function function_305e672f(s_struct, ai_killed)
{
	if(zm_utility::is_player_valid(ai_killed.attacker, 0, 1))
	{
		ai_killed.attacker namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id);
	}
}

/*
	Name: function_5ee56208
	Namespace: namespace_14104b98
	Checksum: 0xE8C6D23B
	Offset: 0x4FE8
	Size: 0x100
	Parameters: 1
	Flags: None
*/
function function_5ee56208(var_5acfb6d)
{
	self endon(#"death");
	level endon(#"hash_61075af70fbd9082");
	while(true)
	{
		var_bdf9e3c2 = zm_zonemgr::get_zone_from_position(self.origin);
		if(isdefined(var_bdf9e3c2))
		{
			var_72192bfa = namespace_a409d261::function_27028b8e(var_bdf9e3c2);
			if(isdefined(var_72192bfa))
			{
				if(var_72192bfa === var_5acfb6d)
				{
					self namespace_159b5b5b::function_76f2fea0(1);
					self namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id);
				}
				else
				{
					self namespace_159b5b5b::function_76f2fea0(0);
				}
			}
		}
		wait(2);
	}
}

/*
	Name: function_9ffc76ea
	Namespace: namespace_14104b98
	Checksum: 0x423BDF8D
	Offset: 0x50F0
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function function_9ffc76ea(str_notify)
{
	level endon(#"hash_61075af70fbd9082");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(str_notify);
		e_player = waitresult.e_player;
		var_c4979a70 = 1;
		if(level.var_51d3a718.n_id == 9)
		{
			means_of_death = waitresult.means_of_death;
			if("MOD_GRENADE" === means_of_death || "MOD_GRENADE_SPLASH" === means_of_death)
			{
				var_c4979a70 = 8;
			}
		}
		e_player namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id, undefined, var_c4979a70);
	}
}

/*
	Name: function_bf582bc8
	Namespace: namespace_14104b98
	Checksum: 0x4A811D96
	Offset: 0x51F8
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_bf582bc8(var_ecffa2a8, n_damage)
{
	self notify("406b5cd97f3e3fe");
	self endon("406b5cd97f3e3fe");
	self endon(#"death");
	level endon(#"hash_61075af70fbd9082");
	n_start_health = self.health;
	while(is_challenge_active(var_ecffa2a8))
	{
		if(self laststand::player_is_in_laststand())
		{
			break;
		}
		if(self.sessionstate === "spectator")
		{
			break;
		}
		if(self.health == self.maxhealth)
		{
			self namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id, undefined, n_damage);
			break;
		}
		else
		{
			n_delta = self.health - n_start_health;
			if(n_delta >= 50)
			{
				self namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id, undefined, n_damage);
				n_start_health = n_start_health + 50;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_5e882c6f
	Namespace: namespace_14104b98
	Checksum: 0x50CD908E
	Offset: 0x5368
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_5e882c6f(e_player, var_2b625b6e)
{
	str_zone = zm_zonemgr::get_zone_from_position(var_2b625b6e);
	if(isdefined(str_zone))
	{
		var_a24af036 = namespace_a409d261::function_27028b8e(str_zone);
		if(level.var_2c5f83d === var_a24af036)
		{
			e_player namespace_f8f28e08::function_53a333a8(level.var_51d3a718.n_id);
		}
	}
}

/*
	Name: function_836d2b5b
	Namespace: namespace_14104b98
	Checksum: 0x717184A
	Offset: 0x5408
	Size: 0x1B0
	Parameters: 0
	Flags: Linked
*/
function function_836d2b5b()
{
	foreach(player in getplayers())
	{
		if(!isdefined(player.var_6b3806e8))
		{
			player.var_6b3806e8 = 0;
		}
		if(player.var_6b3806e8 == 0)
		{
			player thread zm_vo::function_8e0f4696(#"hash_52ef2f977320c648", 0, 1, 9999, 1, 1, 1);
			continue;
		}
		if(player.var_6b3806e8 <= 0.05)
		{
			player thread zm_vo::function_8e0f4696(#"hash_dc8a9f0c8308e91", 0, 1, 9999, 1, 1, 1);
			continue;
		}
		if(player.var_6b3806e8 <= 0.3)
		{
			player thread zm_vo::function_8e0f4696(#"hash_5cf9d72bd1aa0071", 0, 1, 9999, 1, 1, 1);
			continue;
		}
		player thread zm_vo::function_8e0f4696(#"hash_2d2de7c6c02699d2", 0, 1, 9999, 1, 1, 1);
	}
}

/*
	Name: function_1398b789
	Namespace: namespace_14104b98
	Checksum: 0x80F724D1
	Offset: 0x55C0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_1398b789()
{
}

/*
	Name: player_progress_bar
	Namespace: namespace_14104b98
	Checksum: 0x57391149
	Offset: 0x55D0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function player_progress_bar()
{
	level flag::wait_till("power_on");
	self thread namespace_159b5b5b::show_text(#"hash_18137f65a42bc186", 0, "start_challenge");
}

/*
	Name: function_a17a600
	Namespace: namespace_14104b98
	Checksum: 0xA4C82EA6
	Offset: 0x5628
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function function_a17a600()
{
	level endon(#"hash_61075af70fbd9082");
	while(true)
	{
		wait(60);
		level.var_c94140cf = level.var_8f94c541[level.var_fe19836];
		level.var_fe19836++;
		if(level.var_fe19836 >= level.var_8f94c541.size)
		{
			level.var_fe19836 = 0;
		}
		foreach(player in getplayers())
		{
			player namespace_159b5b5b::function_f0d355fc(level.var_c94140cf);
		}
	}
}

/*
	Name: function_5c5cb67b
	Namespace: namespace_14104b98
	Checksum: 0xBEA87C74
	Offset: 0x5738
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function function_5c5cb67b()
{
	if(level.round_number >= 10)
	{
		return 1;
	}
	if(level flag::get(#"hash_7943879f3be8ccc6"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_173c3ce8
	Namespace: namespace_14104b98
	Checksum: 0x502D2EAA
	Offset: 0x5788
	Size: 0x1D6
	Parameters: 3
	Flags: Linked
*/
function function_173c3ce8(var_ecffa2a8, var_2c5f83d, vol_override = undefined)
{
	self notify(#"hash_6daf8e8dc22cab08");
	self endon(#"hash_6daf8e8dc22cab08", #"death");
	self.var_95cfa01d = 1;
	self.var_b05f25ad = 0;
	while(is_challenge_active(var_ecffa2a8))
	{
		if(isdefined(vol_override))
		{
			if(self istouching(vol_override))
			{
				self.var_b05f25ad = 1;
			}
			else
			{
				self.var_b05f25ad = 0;
			}
		}
		else
		{
			str_zone = zm_zonemgr::get_zone_from_position(self.origin);
			var_d56f1604 = namespace_a409d261::function_27028b8e(str_zone);
			if(var_2c5f83d === var_d56f1604)
			{
				self.var_b05f25ad = 1;
			}
			else
			{
				self.var_b05f25ad = 0;
			}
		}
		if(isdefined(self.var_95cfa01d) && self.var_95cfa01d && (isdefined(self.var_b05f25ad) && self.var_b05f25ad))
		{
			self namespace_159b5b5b::function_76f2fea0(1);
			self.var_f94035ca = gettime() / 1000;
		}
		else
		{
			self namespace_159b5b5b::function_76f2fea0(0);
		}
		waitframe(1);
	}
	self.var_95cfa01d = 0;
	self.var_b05f25ad = 0;
}

/*
	Name: function_33565c6e
	Namespace: namespace_14104b98
	Checksum: 0x88A3E0B4
	Offset: 0x5968
	Size: 0x1C6
	Parameters: 1
	Flags: Linked
*/
function function_33565c6e(b_pause)
{
	a_players = getplayers();
	if(b_pause && (!(isdefined(level.var_dc6fce4f) && level.var_dc6fce4f)))
	{
		foreach(player in a_players)
		{
			if(is_active())
			{
				player namespace_159b5b5b::function_7e30f24c();
			}
			player namespace_159b5b5b::function_7e617e33(0);
		}
		level.var_dc6fce4f = 1;
	}
	else if(isdefined(level.var_dc6fce4f) && level.var_dc6fce4f)
	{
		foreach(player in a_players)
		{
			if(is_active())
			{
				player namespace_159b5b5b::function_b4759cf8();
			}
			player namespace_159b5b5b::function_7e617e33(1);
		}
		level.var_dc6fce4f = 0;
	}
}

/*
	Name: function_304fb042
	Namespace: namespace_14104b98
	Checksum: 0xC2AEDF38
	Offset: 0x5B38
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function function_304fb042()
{
	if(!(isdefined(level.var_7aec13aa) && level.var_7aec13aa))
	{
		level clientfield::set("" + #"hash_34bdcd0feba3d912", 1);
		level.var_483180c5 clientfield::set("" + #"hash_118e9445b028d4bf", 0);
		level.var_d5ba7324 clientfield::set("" + #"hash_74fc30de57a0657a", 0);
		foreach(player in getplayers())
		{
			player namespace_159b5b5b::function_7e30f24c();
			player namespace_159b5b5b::function_7e617e33(0);
			s_bowl = player.s_tribute_bowl;
			if(isdefined(s_bowl) && isdefined(s_bowl.var_9d32404))
			{
				s_bowl.var_9d32404 clientfield::set("" + #"hash_21f5fab6a3d22093", 0);
			}
		}
		level.var_7aec13aa = 1;
	}
}

/*
	Name: function_8ff7b0bb
	Namespace: namespace_14104b98
	Checksum: 0x71E240D
	Offset: 0x5D08
	Size: 0x200
	Parameters: 0
	Flags: Linked
*/
function function_8ff7b0bb()
{
	level flag::wait_till("all_players_connected");
	level flag::wait_till("power_on");
	var_6a5f8169 = struct::get("s_apollo_bowl_vo", "targetname");
	b_play_vo = 0;
	while(!b_play_vo)
	{
		foreach(player in getplayers())
		{
			n_dist = distance(player.origin, var_6a5f8169.origin);
			if(n_dist <= 550)
			{
				if(player namespace_159b5b5b::can_see(var_6a5f8169.origin, 0, 0.5))
				{
					b_play_vo = 1;
					break;
				}
			}
		}
		wait(0.5);
	}
	foreach(player in getplayers())
	{
		player thread zm_vo::function_8e0f4696(#"hash_3d7811c8269d75cf", 0, 1, 9999, 1, 1, 1);
	}
}

