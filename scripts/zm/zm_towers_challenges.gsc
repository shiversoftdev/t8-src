// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm\ai\zm_ai_gladiator.gsc;
#using scripts\zm\zm_towers_crowd.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_vapor_random.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\weapons\zm_weap_crossbow.gsc;
#using scripts\core_common\ai\archetype_tiger.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_towers_challenges;

/*
	Name: __init__system__
	Namespace: zm_towers_challenges
	Checksum: 0xCFDDA3A6
	Offset: 0x648
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_towers_challenges", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_towers_challenges
	Checksum: 0xD1726A9
	Offset: 0x698
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "" + #"hash_2e38cc453c5ecb9c", 16000, 2, "int");
	callback::on_finalize_initialization(&init);
}

/*
	Name: __main__
	Namespace: zm_towers_challenges
	Checksum: 0x80F724D1
	Offset: 0x708
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: zm_towers_challenges
	Checksum: 0x8071F67A
	Offset: 0x718
	Size: 0x88C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"first_player_completed_3rd_challenge");
	level flag::init(#"challenge_trap_piece_spawned");
	level flag::init(#"hash_7e6d1a215978eac4");
	if(zm_utility::is_standard() || zm_trial::function_b47f6aba())
	{
		function_3e23c5c0(0);
		level function_99cdcc10();
		return;
	}
	level flag::wait_till("all_players_spawned");
	level._effect[#"brazier_fire"] = #"hash_387c78244f5f45e5";
	level._effect[#"energy_soul"] = #"hash_24eb30a2d07ae5a9";
	level._effect[#"energy_soul_target"] = #"hash_6f5f4eb9267613e3";
	level.var_edaf085e = array(&function_15280d13, &function_75b0f76a, &function_2cf8fe6a);
	level.var_4c2f3e2 = array(&function_ce7b3715, &function_1abdfaa6);
	level.var_171c81ae = array(&function_d9ed4d25, &function_8b70fc31, &function_45396550);
	if(!zm_custom::function_901b751c(#"zmshieldisenabled"))
	{
		level.var_171c81ae = array(&function_8b70fc31, &function_d9ed4d25);
	}
	level.var_9f50bc60 = array(&function_89f10652, &function_43020320);
	level.var_24230bcd = array(&function_99f8f485, &function_e50d2a3d, &function_b1a2d509);
	level.var_93527b27 = array(&function_2bdfb862, &function_1e0efdcd, &function_cd3a4ff5);
	level.var_b56b2097 = getent("zm_towers_trap_piece_3", "targetname");
	level.var_b56b2097 hide();
	level.var_38935e23 = getentarray("t_challenge_brazier_trigger", "script_noteworthy");
	array::run_all(level.var_38935e23, &sethintstring, #"hash_37fe206ef8f70207");
	function_3e23c5c0();
	level.var_98c5753b = getentarray("zm_towers_challenge_heads", "script_noteworthy");
	foreach(head in level.var_98c5753b)
	{
		head hide();
	}
	var_ae9f0595 = array(#"ar_mg1909_t8", #"lmg_standard_t8", #"tr_midburst_t8");
	var_ae9f0595 = array::randomize(var_ae9f0595);
	level.var_5d1e28ac = array(#"self_revive", #"bonus_points_player", #"pistol_standard_t8_upgraded", #"full_ammo", #"hero_weapon_power", var_ae9f0595[0], #"free_perk", #"full_ammo", #"lmg_spray_t8_upgraded");
	zm_spawner::register_zombie_death_event_callback(&function_edf51f63);
	zm_spawner::register_zombie_death_event_callback(&function_4f3835a0);
	zm_spawner::register_zombie_death_event_callback(&function_82437bf6);
	zm_spawner::register_zombie_death_event_callback(&function_bbfef448);
	zm_spawner::register_zombie_death_event_callback(&function_347efe7c);
	zm_spawner::register_zombie_death_event_callback(&function_49bc2885);
	zm_spawner::register_zombie_death_event_callback(&function_c80d863f);
	zm_spawner::register_zombie_death_event_callback(&function_2d026236);
	zm_spawner::register_zombie_death_event_callback(&function_20d01751);
	zm_spawner::register_zombie_death_event_callback(&function_2cd047f4);
	callback::on_ai_damage(&function_fb326fd3);
	zm_ai_gladiator::function_36fff581(&function_b5c10847);
	level.get_player_perk_purchase_limit = &function_3c4fc73;
	var_6eaa1749 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
	foreach(var_986431d3 in var_6eaa1749)
	{
		if(!level flag::get(#"hash_7e6d1a215978eac4"))
		{
			var_394c506d = getent(var_986431d3.targetname + "_hint", "targetname");
			thread function_ea1042c6(getent(var_986431d3.targetname, "targetname"), var_394c506d);
		}
	}
	callback::on_connect(&function_99cdcc10);
}

/*
	Name: function_3e23c5c0
	Namespace: zm_towers_challenges
	Checksum: 0xEF8EE043
	Offset: 0xFB0
	Size: 0x314
	Parameters: 1
	Flags: Linked
*/
function function_3e23c5c0(var_2a0eed37 = 1)
{
	level.var_286b00eb = array();
	level.var_286b00eb[0] = "tag_easy_1";
	level.var_286b00eb[1] = "tag_easy_2";
	level.var_286b00eb[2] = "tag_easy_3";
	level.var_286b00eb[3] = "tag_medium_1";
	level.var_286b00eb[4] = "tag_medium_2";
	level.var_286b00eb[5] = "tag_medium_3";
	level.var_286b00eb[6] = "tag_hard_1";
	level.var_286b00eb[7] = "tag_hard_2";
	level.var_286b00eb[8] = "tag_hard_3";
	level.a_mdl_challenge_banners = getentarray("mdl_challenge_banners", "script_noteworthy");
	foreach(banner in level.a_mdl_challenge_banners)
	{
		str_color = function_7e61f202(banner);
		if(var_2a0eed37)
		{
			banner scene::init(("p8_fxanim_zm_towers_banner_achievement_" + str_color) + "_bundle", banner);
		}
		else
		{
			banner thread scene::play(("p8_fxanim_zm_towers_banner_achievement_" + str_color) + "_bundle", banner);
		}
		foreach(tag in level.var_286b00eb)
		{
			if(!isdefined(tag))
			{
				continue;
			}
			if(!banner haspart(tag))
			{
				continue;
			}
			if(var_2a0eed37)
			{
				banner hidepart(tag);
				continue;
			}
			banner showpart(tag);
		}
	}
}

/*
	Name: function_7e61f202
	Namespace: zm_towers_challenges
	Checksum: 0x220FBB37
	Offset: 0x12D0
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function function_7e61f202(mdl_banner)
{
	switch(mdl_banner.targetname)
	{
		case "hash_5485fa3ed2c27d5c":
		{
			return "green";
		}
		case "hash_3aae7b52deb2f625":
		{
			return "red";
		}
		case "hash_4772c04fac27f2fa":
		{
			return "blue";
		}
		case "hash_3534013e54dbaff5":
		{
			return "purple";
		}
	}
}

/*
	Name: function_99cdcc10
	Namespace: zm_towers_challenges
	Checksum: 0x1EDD7962
	Offset: 0x1368
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function function_99cdcc10()
{
	var_d65b49c5 = getentarray("t_challenge_brazier_trigger", "script_noteworthy");
	var_155201f2 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
	var_b2966463 = getentarray("t_challenge_cleat_hint_trig", "script_noteworthy");
	a_t_challenges = arraycombine(var_d65b49c5, var_155201f2, 0, 0);
	a_t_challenges = arraycombine(a_t_challenges, var_b2966463, 0, 0);
	level flag::set(#"hash_7e6d1a215978eac4");
	foreach(t_challenge in a_t_challenges)
	{
		if(isplayer(self))
		{
			if(t_challenge.var_da61c116 === 1)
			{
				t_challenge setinvisibletoplayer(self);
			}
			continue;
		}
		t_challenge setinvisibletoall();
	}
}

/*
	Name: function_fd8a137e
	Namespace: zm_towers_challenges
	Checksum: 0x94033FCC
	Offset: 0x1510
	Size: 0x178
	Parameters: 1
	Flags: Linked
*/
function function_fd8a137e(n_time = 0)
{
	self notify(#"hash_b296fe3ccb7d273");
	self endon(#"disconnect", #"hash_b296fe3ccb7d273");
	if(n_time > 0)
	{
		wait(n_time);
	}
	level zm_ui_inventory::function_7df6bb60(#"zm_towers_challenges", 0, self);
	level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", 0, self);
	if(isdefined(self.challenge_struct))
	{
		foreach(var_6bf81b9d in self.challenge_struct function_876f93aa())
		{
			level zm_ui_inventory::function_7df6bb60(#"zm_towers_challenges", 0, var_6bf81b9d);
			level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", 0, var_6bf81b9d);
		}
	}
}

/*
	Name: function_1583001a
	Namespace: zm_towers_challenges
	Checksum: 0xFA43F8DE
	Offset: 0x1690
	Size: 0x3C8
	Parameters: 2
	Flags: Linked
*/
function function_1583001a(e_player, var_986431d3)
{
	e_player endon(#"disconnect");
	e_player flag::init(#"hash_5a74f9da0718c63d");
	e_player flag::init(#"flag_player_completed_all_challenges");
	e_trig = self;
	e_trig flag::set(#"hash_19856658ee6e4f3a");
	e_trig.banner = getent(e_trig.target, "targetname");
	e_trig.banner.var_d412a3e6 = getent(e_trig.banner.target, "targetname");
	var_986431d3.challenge_struct.e_trig = e_trig;
	e_trig.challenge_struct = var_986431d3.challenge_struct;
	switch(e_trig.challenge_struct.targetname)
	{
		case "odin_brazier":
		{
			level clientfield::set("brazier_fire_blue", 1);
			var_38e7a8be = #"hash_78c79ed7fe5a14e6";
			break;
		}
		case "zeus_brazier":
		{
			level clientfield::set("brazier_fire_purple", 1);
			var_38e7a8be = #"hash_2865f19fb8f73873";
			break;
		}
		case "ra_brazier":
		{
			level clientfield::set("brazier_fire_red", 1);
			var_38e7a8be = #"hash_260c83bb9470b";
			break;
		}
		case "danu_brazier":
		{
			level clientfield::set("brazier_fire_green", 1);
			var_38e7a8be = #"hash_7ff858c269b8be00";
			break;
		}
	}
	level thread zm_audio::sndannouncerplayvox(var_38e7a8be);
	var_986431d3.challenge_struct thread function_702ac990(e_player, e_trig);
	wait(0.1);
	foreach(player in getplayers())
	{
		if(player != e_player)
		{
			if(player flag::exists(#"flag_player_completed_all_challenges") && player flag::get(#"flag_player_completed_all_challenges"))
			{
				player function_11e35de5(e_trig);
				continue;
			}
			e_trig.banner.var_d412a3e6 setinvisibletoplayer(player);
		}
	}
}

/*
	Name: function_702ac990
	Namespace: zm_towers_challenges
	Checksum: 0x81864B25
	Offset: 0x1A60
	Size: 0xB98
	Parameters: 2
	Flags: Linked
*/
function function_702ac990(e_player, e_trig)
{
	e_player endon(#"disconnect");
	if(!e_player flag::get(#"flag_player_completed_all_challenges"))
	{
		self flag::init(#"hash_5a7dfe069f4cbcec");
		e_player flag::init(#"flag_player_initialized_reward");
		e_player flag::init(#"hash_6534297bbe7e180d");
		level.var_edaf085e = array::randomize(level.var_edaf085e);
		level.var_4c2f3e2 = array::randomize(level.var_4c2f3e2);
		level.var_171c81ae = array::randomize(level.var_171c81ae);
		level.var_9f50bc60 = array::randomize(level.var_9f50bc60);
		level.var_24230bcd = array::randomize(level.var_24230bcd);
		level.var_93527b27 = array::randomize(level.var_93527b27);
		self.var_62368fa4 = array();
		self.var_62368fa4[0] = level.var_edaf085e[0];
		self.var_62368fa4[1] = level.var_edaf085e[1];
		self.var_62368fa4[2] = level.var_4c2f3e2[0];
		self.var_62368fa4[3] = level.var_171c81ae[0];
		self.var_62368fa4[4] = level.var_171c81ae[1];
		self.var_62368fa4[5] = level.var_9f50bc60[0];
		self.var_62368fa4[6] = level.var_24230bcd[0];
		self.var_62368fa4[7] = level.var_24230bcd[1];
		self.var_62368fa4[8] = level.var_93527b27[0];
		self.var_860b8f1e = 0;
		var_5f06d3f8 = 0;
		self.n_challenges_complete = 0;
	}
	while(self.n_challenges_complete < self.var_62368fa4.size)
	{
		self flag::set(#"hash_5a7dfe069f4cbcec");
		self.var_4931480f setvisibletoplayer(e_player);
		foreach(var_ae7b1d33 in self function_876f93aa())
		{
			self.var_4931480f setvisibletoplayer(var_ae7b1d33);
		}
		if(isdefined(self.var_25276720) && e_player != self.var_25276720 && self.var_25276720 flag::get(#"flag_player_initialized_reward") && !self.var_25276720 flag::get(#"hash_6534297bbe7e180d"))
		{
			self.var_4931480f sethintstringforplayer(e_player, #"hash_5501784aa04e0df2");
			var_a9bf0d0d = self.n_challenges_complete;
			while(isdefined(self.var_25276720) && self.var_25276720 flag::get(#"flag_player_initialized_reward") && !self.var_25276720 flag::get(#"hash_6534297bbe7e180d"))
			{
				wait(0.5);
			}
			while(var_a9bf0d0d == self.n_challenges_complete)
			{
				wait(0.5);
			}
			continue;
		}
		while(self flag::get(#"hash_5a7dfe069f4cbcec"))
		{
			/#
				level.var_9276b18a = 1;
				self.var_97467803 = 1;
			#/
			if(var_5f06d3f8 === 1)
			{
				[[self.var_62368fa4[self.n_challenges_complete]]](e_player, e_trig, var_5f06d3f8);
				var_5f06d3f8 = 0;
			}
			else
			{
				e_player thread function_ae982bb9(#"challenge_available");
				[[self.var_62368fa4[self.n_challenges_complete]]](e_player, e_trig, var_5f06d3f8);
				if(self.n_challenges_complete == 2 && level flag::get("first_player_completed_3rd_challenge") && !level flag::get("challenge_trap_piece_spawned"))
				{
					level thread function_45f9a547();
				}
			}
		}
		wait(2.75);
		if(!isdefined(e_trig) || !isdefined(e_trig.banner) || !isdefined(e_player))
		{
			continue;
		}
		if(!isdefined(self.n_challenges_complete) || self.n_challenges_complete >= level.var_286b00eb.size)
		{
			continue;
		}
		if(e_player !== self.var_25276720)
		{
			wait(0.1);
			continue;
		}
		if(e_trig.banner haspart(level.var_286b00eb[self.n_challenges_complete]))
		{
			e_trig.banner showpart(level.var_286b00eb[self.n_challenges_complete]);
		}
		self.n_challenges_complete++;
		if(self.n_challenges_complete <= 3)
		{
			e_player zm_towers_crowd::function_b8dfa139(#"hash_300454c11a18ae03");
		}
		else
		{
			if(self.n_challenges_complete > 3 && self.n_challenges_complete <= 6)
			{
				e_player zm_towers_crowd::function_b8dfa139(#"hash_39efd1a80488c531");
			}
			else if(self.n_challenges_complete > 6 && self.n_challenges_complete <= 9)
			{
				e_player zm_towers_crowd::function_b8dfa139(#"hash_69fc3ba948618464");
			}
		}
		if(self.n_challenges_complete == self.var_62368fa4.size)
		{
			e_player notify(#"challenges_complete");
			arrayremovevalue(level.var_38935e23, self.var_4931480f);
		}
	}
	e_trig sethintstring(#"hash_6a6563f3b19ad5bd");
	switch(e_trig.challenge_struct.targetname)
	{
		case "odin_brazier":
		{
			level clientfield::set("brazier_fire_blue", 2);
			var_38e7a8be = #"hash_5bbde3b2770c9e6a";
			break;
		}
		case "zeus_brazier":
		{
			level clientfield::set("brazier_fire_purple", 2);
			var_38e7a8be = #"hash_3b388348c6fa1fd3";
			break;
		}
		case "ra_brazier":
		{
			level clientfield::set("brazier_fire_red", 2);
			var_38e7a8be = #"hash_1c9809895527844b";
			break;
		}
		case "danu_brazier":
		{
			level clientfield::set("brazier_fire_green", 2);
			var_38e7a8be = #"hash_7e9f4297d7232ab0";
			break;
		}
	}
	e_player.var_bf95bf40 = undefined;
	if(!e_player flag::get(#"flag_player_completed_all_challenges"))
	{
		e_player flag::set(#"flag_player_completed_all_challenges");
		e_player thread function_c3158242(var_38e7a8be);
		if(level.players.size > 1)
		{
			foreach(var_ab63b3ec in level.var_38935e23)
			{
				if(var_ab63b3ec != e_trig && var_ab63b3ec flag::exists(#"hash_19856658ee6e4f3a"))
				{
					e_player function_11e35de5(var_ab63b3ec);
				}
			}
		}
	}
	else if(level.players.size > 1)
	{
		foreach(var_ab63b3ec in level.var_38935e23)
		{
			if(var_ab63b3ec flag::exists(#"hash_19856658ee6e4f3a"))
			{
				var_ab63b3ec setvisibletoplayer(e_player);
			}
		}
	}
}

/*
	Name: function_ae982bb9
	Namespace: zm_towers_challenges
	Checksum: 0xDCA6DEBD
	Offset: 0x2600
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function function_ae982bb9(str_type)
{
	self endon(#"disconnect");
	if(str_type == #"challenge_completed")
	{
		if(!isdefined(self.var_907d9581))
		{
			self.var_907d9581 = 0;
		}
		var_69836136 = #"hash_7e0b3bf6d477a92f";
		n_vo = self.var_907d9581;
		var_a1effcd = 9;
	}
	else
	{
		if(!isdefined(self.var_f87a90d4))
		{
			self.var_f87a90d4 = 0;
		}
		var_69836136 = #"hash_2a8f3ff63eb265a9";
		n_vo = self.var_f87a90d4;
		var_a1effcd = 9;
	}
	level thread zm_audio::sndannouncerplayvox(var_69836136, self, undefined, n_vo);
	n_vo++;
	if(n_vo > var_a1effcd)
	{
		n_vo = 0;
	}
	if(str_type == #"challenge_completed")
	{
		self.var_907d9581 = n_vo;
	}
	else
	{
		self.var_f87a90d4 = n_vo;
	}
}

/*
	Name: function_c3158242
	Namespace: zm_towers_challenges
	Checksum: 0xB835FC02
	Offset: 0x2740
	Size: 0x228
	Parameters: 1
	Flags: Linked
*/
function function_c3158242(var_38e7a8be)
{
	self endon(#"disconnect");
	level zm_audio::sndannouncerplayvox(var_38e7a8be);
	a_e_players = getplayers(#"allies");
	arrayremovevalue(a_e_players, self);
	foreach(e_player in a_e_players)
	{
		if(isdefined(e_player) && isdefined(e_player.challenge_struct) && e_player flag::exists("flag_player_completed_all_challenges") && !e_player flag::get("flag_player_completed_all_challenges"))
		{
			var_26c18935 = e_player.challenge_struct.targetname;
			switch(var_26c18935)
			{
				case "danu_brazier":
				{
					var_4bceacc8 = #"hash_597c4173f2fd41a4";
					break;
				}
				case "ra_brazier":
				{
					var_4bceacc8 = #"hash_550bed5125d97a89";
					break;
				}
				case "odin_brazier":
				{
					var_4bceacc8 = #"hash_31347fc188da1db6";
					break;
				}
				case "zeus_brazier":
				{
					var_4bceacc8 = #"hash_6c9a2587a2563721";
					break;
				}
			}
			level zm_audio::sndannouncerplayvox(var_4bceacc8);
		}
	}
}

/*
	Name: function_45f9a547
	Namespace: zm_towers_challenges
	Checksum: 0x79B71B0
	Offset: 0x2970
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_45f9a547()
{
	level flag::set("challenge_trap_piece_spawned");
	fx_model = util::spawn_model("tag_origin", level.var_b56b2097.origin);
	fx_model clientfield::set("blue_glow", 1);
	wait(1);
	level.var_b56b2097 show();
	mdl_clip = getent("mdl_acid_trap_cauldron_piece_clip", "targetname");
	mdl_clip solid();
	wait(1);
	if(isdefined(fx_model))
	{
		fx_model clientfield::set("blue_glow", 0);
		wait(1);
		fx_model delete();
	}
}

/*
	Name: function_11e35de5
	Namespace: zm_towers_challenges
	Checksum: 0x14AEA6E7
	Offset: 0x2A98
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_11e35de5(var_a2d4cf99)
{
	self endon(#"disconnect");
	level endon(#"end_game");
	if(!(isdefined(self.var_bf95bf40) && self.var_bf95bf40))
	{
		var_a2d4cf99 setvisibletoplayer(self);
	}
	var_a2d4cf99.banner.var_d412a3e6 setvisibletoplayer(self);
	if(function_8b1a219a())
	{
		var_a2d4cf99 sethintstringforplayer(self, #"hash_b83e894faf4d112");
	}
	else
	{
		var_a2d4cf99 sethintstringforplayer(self, #"hash_9b98137ec7cd136");
	}
	var_a2d4cf99 thread function_5ef70b0b(self);
}

/*
	Name: function_5ef70b0b
	Namespace: zm_towers_challenges
	Checksum: 0x257C6AC9
	Offset: 0x2BB0
	Size: 0x29C
	Parameters: 1
	Flags: Linked
*/
function function_5ef70b0b(e_player)
{
	level endon(#"end_game");
	e_player endon(#"disconnect");
	while(true)
	{
		s_info = undefined;
		s_info = self waittill(#"trigger");
		if(s_info.activator == e_player && e_player flag::get(#"flag_player_completed_all_challenges"))
		{
			if(e_player zm_score::can_player_purchase(2500))
			{
				e_player zm_score::minus_to_player_score(2500);
				break;
			}
		}
	}
	e_player.challenge_struct = self.challenge_struct;
	if(!isdefined(e_player.challenge_struct.var_6432be9b))
	{
		e_player.challenge_struct.var_6432be9b = [];
	}
	else if(!isarray(e_player.challenge_struct.var_6432be9b))
	{
		e_player.challenge_struct.var_6432be9b = array(e_player.challenge_struct.var_6432be9b);
	}
	if(!isinarray(e_player.challenge_struct.var_6432be9b, e_player))
	{
		e_player.challenge_struct.var_6432be9b[e_player.challenge_struct.var_6432be9b.size] = e_player;
	}
	e_player.var_bf95bf40 = 1;
	foreach(var_ab63b3ec in level.var_38935e23)
	{
		if(var_ab63b3ec != self)
		{
			var_ab63b3ec setinvisibletoplayer(e_player);
		}
	}
	e_player.challenge_struct function_702ac990(e_player, self);
}

/*
	Name: function_2ae8eabe
	Namespace: zm_towers_challenges
	Checksum: 0xE7CCE6F
	Offset: 0x2E58
	Size: 0x324
	Parameters: 2
	Flags: Linked
*/
function function_2ae8eabe(n_current_progress, var_8d9da2cd)
{
	var_9667b963 = n_current_progress / var_8d9da2cd;
	var_9667b963 = var_9667b963 * 100;
	var_9134e5d2 = self.targetname;
	switch(var_9134e5d2)
	{
		case "odin_brazier":
		{
			var_fe02dade = "head_fire_blue";
			break;
		}
		case "danu_brazier":
		{
			var_fe02dade = "head_fire_green";
			break;
		}
		case "zeus_brazier":
		{
			var_fe02dade = "head_fire_purple";
			break;
		}
		case "ra_brazier":
		{
			var_fe02dade = "head_fire_red";
			break;
		}
	}
	if(var_9667b963 >= 20)
	{
		var_c0f2a5df = getent(self.targetname + "_head1", "targetname");
		var_c0f2a5df show();
		var_c0f2a5df clientfield::set(var_fe02dade, 1);
	}
	if(var_9667b963 >= 40)
	{
		var_c0f2a5df = getent(self.targetname + "_head2", "targetname");
		var_c0f2a5df show();
		var_c0f2a5df clientfield::set(var_fe02dade, 1);
	}
	if(var_9667b963 >= 60)
	{
		var_c0f2a5df = getent(self.targetname + "_head3", "targetname");
		var_c0f2a5df show();
		var_c0f2a5df clientfield::set(var_fe02dade, 1);
	}
	if(var_9667b963 >= 80)
	{
		var_c0f2a5df = getent(self.targetname + "_head4", "targetname");
		var_c0f2a5df show();
		var_c0f2a5df clientfield::set(var_fe02dade, 1);
	}
	if(var_9667b963 == 100)
	{
		var_c0f2a5df = getent(self.targetname + "_head5", "targetname");
		var_c0f2a5df show();
		var_c0f2a5df clientfield::set(var_fe02dade, 1);
	}
}

/*
	Name: function_c6d050e9
	Namespace: zm_towers_challenges
	Checksum: 0x5CFCEE38
	Offset: 0x3188
	Size: 0x1F8
	Parameters: 1
	Flags: Linked
*/
function function_c6d050e9(b_success = 0)
{
	var_aaa62784 = getentarray(self.targetname + "_heads", "script_banner_ref");
	foreach(mdl_head in var_aaa62784)
	{
		if(b_success)
		{
			var_5ede77cf = struct::get(mdl_head.target, "targetname");
			var_77b96e63 = struct::get(var_5ede77cf.target, "targetname");
			var_239145db = util::spawn_model("tag_origin", var_5ede77cf.origin, var_5ede77cf.angles);
			var_bb6e466c = util::spawn_model("tag_origin", var_77b96e63.origin, var_77b96e63.angles);
			var_239145db clientfield::set("energy_soul", 1);
			var_bb6e466c clientfield::set("energy_soul_target", 1);
			thread function_6c97a983(mdl_head, var_239145db, var_bb6e466c);
			continue;
		}
		mdl_head hide();
	}
}

/*
	Name: function_6c97a983
	Namespace: zm_towers_challenges
	Checksum: 0x5BC1B15E
	Offset: 0x3388
	Size: 0xA4
	Parameters: 4
	Flags: Linked
*/
function function_6c97a983(mdl_head, var_e7f5e1c1, var_64ddce5c, n_time = 2.25)
{
	wait(n_time);
	var_e7f5e1c1 delete();
	var_64ddce5c clientfield::increment("banner_soul_burst");
	var_64ddce5c delete();
	mdl_head hide();
}

/*
	Name: function_15280d13
	Namespace: zm_towers_challenges
	Checksum: 0xF3AB277F
	Offset: 0x3438
	Size: 0x1B4
	Parameters: 3
	Flags: Linked
*/
function function_15280d13(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	if(var_5f06d3f8 === 1)
	{
		e_trig sethintstring(#"hash_9b98137ec7cd136");
		e_trig waittill(#"trigger");
	}
	e_trig.hint_string = #"hash_172f6f29aaee2d0";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 6);
	if(!isdefined(self.var_2d8a5fb9))
	{
		self.var_2d8a5fb9 = 0;
	}
	self function_bce7e59b(e_player, 1, self.var_2d8a5fb9);
	/#
		self.var_5630d868 = 6;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_7c2dd12641ed6bf5");
	self function_544b63c0(6);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_2d8a5fb9 = undefined;
	e_trig function_d2103a80(e_player, 6);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_2cd047f4
	Namespace: zm_towers_challenges
	Checksum: 0x29959ACC
	Offset: 0x35F8
	Size: 0x248
	Parameters: 1
	Flags: Linked
*/
function function_2cd047f4(e_attacker)
{
	if(!isdefined(e_attacker))
	{
		return;
	}
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(!isalive(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_2d8a5fb9))
	{
		return;
	}
	var_5a20091 = self.damageweapon;
	if(isarray(e_player._gadgets_player) && e_player._gadgets_player[1] === var_5a20091 || (zm_utility::is_mini_turret(e_player._gadgets_player[1]) && zm_utility::is_mini_turret(var_5a20091, 1)) || (zm_utility::function_850e7499(e_player._gadgets_player[1]) && zm_utility::function_850e7499(var_5a20091, 1)))
	{
		e_player.challenge_struct.var_2d8a5fb9++;
		n_progress = e_player.challenge_struct.var_2d8a5fb9;
		if(n_progress >= 6)
		{
			e_player.challenge_struct.var_2d8a5fb9 = 6;
			n_progress = 6;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 6);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else
	{
		return;
	}
	if(n_progress >= 6)
	{
		e_player.challenge_struct notify(#"hash_7c2dd12641ed6bf5");
	}
}

/*
	Name: function_1abdfaa6
	Namespace: zm_towers_challenges
	Checksum: 0x8C40A0DA
	Offset: 0x3848
	Size: 0x1F4
	Parameters: 3
	Flags: Linked
*/
function function_1abdfaa6(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	if(var_5f06d3f8 === 1)
	{
		e_trig sethintstring(#"hash_9b98137ec7cd136");
		e_trig waittill(#"trigger");
	}
	e_trig.hint_string = #"hash_51397dc3d51e150c";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 10);
	if(!isdefined(self.var_fa64a47b))
	{
		self.var_fa64a47b = 0;
	}
	self function_bce7e59b(e_player, 2, self.var_fa64a47b);
	/#
		self.var_5630d868 = 10;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_7731445a0fb80df");
	self function_544b63c0(10);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_fa64a47b = undefined;
	e_trig function_d2103a80(e_player, 10);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
	if(!level flag::get(#"first_player_completed_3rd_challenge"))
	{
		level flag::set(#"first_player_completed_3rd_challenge");
	}
}

/*
	Name: function_c80d863f
	Namespace: zm_towers_challenges
	Checksum: 0xD1DA8320
	Offset: 0x3A48
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_c80d863f(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_fa64a47b))
	{
		return;
	}
	n_progress = 0;
	var_5a20091 = self.damageweapon;
	if(zm_loadout::is_hero_weapon(var_5a20091))
	{
		e_player.challenge_struct.var_fa64a47b++;
		n_progress = e_player.challenge_struct.var_fa64a47b;
		if(n_progress >= 10)
		{
			e_player.challenge_struct.var_fa64a47b = 10;
			n_progress = 10;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 10);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	if(n_progress >= 10)
	{
		e_player.challenge_struct notify(#"hash_7731445a0fb80df");
	}
}

/*
	Name: function_75b0f76a
	Namespace: zm_towers_challenges
	Checksum: 0x624007A9
	Offset: 0x3BB8
	Size: 0x1B4
	Parameters: 3
	Flags: Linked
*/
function function_75b0f76a(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	if(var_5f06d3f8 === 1)
	{
		e_trig sethintstring(#"hash_9b98137ec7cd136");
		e_trig waittill(#"trigger");
	}
	e_trig.hint_string = #"hash_1b26db34a1fb9d5f";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 13);
	if(!isdefined(self.var_dd287f97))
	{
		self.var_dd287f97 = 0;
	}
	self function_bce7e59b(e_player, 3, self.var_dd287f97);
	/#
		self.var_5630d868 = 13;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_76251ea6bc659497");
	self function_544b63c0(13);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_dd287f97 = undefined;
	e_trig function_d2103a80(e_player, 13);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_49bc2885
	Namespace: zm_towers_challenges
	Checksum: 0x8B5F15ED
	Offset: 0x3D78
	Size: 0x208
	Parameters: 1
	Flags: Linked
*/
function function_49bc2885(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_dd287f97))
	{
		return;
	}
	w_knife = getweapon("knife");
	w_bowie_knife = getweapon("bowie_knife");
	n_progress = 0;
	if(isdefined(self.damageweapon.ismeleeweapon) && self.damageweapon.ismeleeweapon && self.damagemod == "MOD_MELEE" && !zm_loadout::is_hero_weapon(self.damageweapon) || zm_weapons::function_35746b9c(self.damageweapon, self.damagemod))
	{
		e_player.challenge_struct.var_dd287f97++;
		n_progress = e_player.challenge_struct.var_dd287f97;
		if(n_progress >= 13)
		{
			e_player.challenge_struct.var_dd287f97 = 13;
			n_progress = 13;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 13);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	if(n_progress >= 13)
	{
		e_attacker.challenge_struct notify(#"hash_76251ea6bc659497");
	}
}

/*
	Name: function_2cf8fe6a
	Namespace: zm_towers_challenges
	Checksum: 0x452C9483
	Offset: 0x3F88
	Size: 0x1B4
	Parameters: 3
	Flags: Linked
*/
function function_2cf8fe6a(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	if(var_5f06d3f8 === 1)
	{
		e_trig sethintstring(#"hash_9b98137ec7cd136");
		e_trig waittill(#"trigger");
	}
	e_trig.hint_string = #"hash_110075b9efe67cd0";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 5);
	if(!isdefined(self.var_6c499d))
	{
		self.var_6c499d = 0;
	}
	self function_bce7e59b(e_player, 4, self.var_6c499d);
	/#
		self.var_5630d868 = 5;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_5a396dde8622e0e3");
	self function_544b63c0(5);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_6c499d = undefined;
	e_trig function_d2103a80(e_player, 5);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_edf51f63
	Namespace: zm_towers_challenges
	Checksum: 0x5FA6E444
	Offset: 0x4148
	Size: 0x1E8
	Parameters: 1
	Flags: Linked
*/
function function_edf51f63(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_6c499d))
	{
		return;
	}
	n_progress = 0;
	if(self zm_utility::is_headshot(self.damageweapon, self.damagelocation, self.damagemod))
	{
		e_player.challenge_struct.var_6c499d++;
		n_progress = e_player.challenge_struct.var_6c499d;
		if(n_progress >= 5)
		{
			e_player.challenge_struct.var_6c499d = 5;
			n_progress = 5;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 5);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else if(e_player.challenge_struct.var_25276720 === e_player)
	{
		e_player.challenge_struct.var_6c499d = 0;
		n_progress = 0;
		e_player.challenge_struct function_c6d050e9();
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	if(n_progress >= 5)
	{
		e_attacker.challenge_struct notify(#"hash_5a396dde8622e0e3");
	}
}

/*
	Name: function_ce7b3715
	Namespace: zm_towers_challenges
	Checksum: 0x611521CD
	Offset: 0x4338
	Size: 0x20C
	Parameters: 3
	Flags: Linked
*/
function function_ce7b3715(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	if(var_5f06d3f8 === 1)
	{
		e_trig sethintstring(#"hash_9b98137ec7cd136");
		e_trig waittill(#"trigger");
	}
	e_trig.hint_string = #"hash_12f9edb86e6ba05d";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 1);
	if(!isdefined(self.var_b0508fbc))
	{
		self.var_b0508fbc = 0;
	}
	self function_bce7e59b(e_player, 5, self.var_b0508fbc);
	/#
		self.var_5630d868 = 1;
		self.initboss_balcony_south = "";
	#/
	e_player thread function_1dd6c24f();
	self waittill(#"hash_1b7d29ca77ce35c");
	self function_544b63c0(1);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_b0508fbc = undefined;
	e_trig function_d2103a80(e_player, 1);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
	if(!level flag::get(#"first_player_completed_3rd_challenge"))
	{
		level flag::set(#"first_player_completed_3rd_challenge");
	}
}

/*
	Name: function_1dd6c24f
	Namespace: zm_towers_challenges
	Checksum: 0x95FCC5AA
	Offset: 0x4550
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_1dd6c24f()
{
	self endon(#"disconnect");
	if(!isplayer(self))
	{
		return;
	}
	e_player = self;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b0508fbc))
	{
		return;
	}
	e_player.challenge_struct endon(#"hash_1b7d29ca77ce35c");
	e_player waittill(#"hash_731c84be18ae9fa3");
	e_player.challenge_struct.var_b0508fbc++;
	n_progress = e_player.challenge_struct.var_b0508fbc;
	if(n_progress >= 1)
	{
		e_player.challenge_struct.var_b0508fbc = 1;
		n_progress = 1;
	}
	e_player.challenge_struct function_2ae8eabe(n_progress, 1);
	e_player.challenge_struct function_544b63c0(n_progress);
	if(n_progress >= 1)
	{
		e_player.challenge_struct notify(#"hash_1b7d29ca77ce35c");
	}
}

/*
	Name: function_43020320
	Namespace: zm_towers_challenges
	Checksum: 0xCD84624A
	Offset: 0x46D0
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_43020320(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_79cb73f346a68dba";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 9);
	if(!isdefined(self.var_a86b6f54))
	{
		self.var_a86b6f54 = 0;
	}
	self function_bce7e59b(e_player, 6, self.var_a86b6f54);
	/#
		self.var_5630d868 = 9;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_6edbb9b7bfeb38a3");
	self function_544b63c0(9);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_a86b6f54 = undefined;
	e_trig function_d2103a80(e_player, 9);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_b5c10847
	Namespace: zm_towers_challenges
	Checksum: 0xC89DAD0D
	Offset: 0x4848
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function function_b5c10847(attacker)
{
	if(!isplayer(attacker))
	{
		return;
	}
	e_player = attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_a86b6f54))
	{
		return;
	}
	e_player.challenge_struct.var_a86b6f54++;
	n_progress = e_player.challenge_struct.var_a86b6f54;
	if(n_progress >= 9)
	{
		e_player.challenge_struct.var_a86b6f54 = 9;
		n_progress = 9;
	}
	e_player.challenge_struct function_2ae8eabe(n_progress, 9);
	e_player.challenge_struct function_544b63c0(n_progress);
	if(n_progress >= 9)
	{
		e_player.challenge_struct notify(#"hash_6edbb9b7bfeb38a3");
	}
}

/*
	Name: function_d9ed4d25
	Namespace: zm_towers_challenges
	Checksum: 0xA9AA866E
	Offset: 0x4988
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_d9ed4d25(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_a3dbb8559be3c1";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 5);
	if(!isdefined(self.var_8c74b626))
	{
		self.var_8c74b626 = 0;
	}
	self function_bce7e59b(e_player, 7, self.var_8c74b626);
	/#
		self.var_5630d868 = 5;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_31d79470abcf1282");
	self function_544b63c0(5);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_8c74b626 = undefined;
	e_trig function_d2103a80(e_player, 5);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_2d026236
	Namespace: zm_towers_challenges
	Checksum: 0xD14BF418
	Offset: 0x4B00
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_2d026236(attacker)
{
	if(!isplayer(attacker))
	{
		return;
	}
	e_player = attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_8c74b626))
	{
		return;
	}
	n_progress = 0;
	if(self.archetype == #"tiger")
	{
		e_player.challenge_struct.var_8c74b626++;
		n_progress = e_player.challenge_struct.var_8c74b626;
		if(n_progress >= 5)
		{
			e_player.challenge_struct.var_8c74b626 = 5;
			n_progress = 5;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 5);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else
	{
		return;
	}
	if(n_progress >= 5)
	{
		e_player.challenge_struct notify(#"hash_31d79470abcf1282");
	}
}

/*
	Name: function_89f10652
	Namespace: zm_towers_challenges
	Checksum: 0xB7BAA496
	Offset: 0x4C68
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_89f10652(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_4071eaa9981c7b75";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 3);
	if(!isdefined(self.var_4423c8ba))
	{
		self.var_4423c8ba = 0;
	}
	self function_bce7e59b(e_player, 8, self.var_4423c8ba);
	/#
		self.var_5630d868 = 3;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_5b6a8d05204c98e1");
	self function_544b63c0(3);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_4423c8ba = undefined;
	e_trig function_d2103a80(e_player, 3);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_347efe7c
	Namespace: zm_towers_challenges
	Checksum: 0x37D35718
	Offset: 0x4DE0
	Size: 0x1B8
	Parameters: 1
	Flags: Linked
*/
function function_347efe7c(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_4423c8ba))
	{
		return;
	}
	n_progress = 0;
	if(isdefined(self.var_e236d061) && (!(isdefined(self.var_e236d061.var_d3dff4f0) && self.var_e236d061.var_d3dff4f0)) && self.var_e236d061.archetype === #"catalyst")
	{
		self.var_e236d061.var_d3dff4f0 = 1;
		e_player.challenge_struct.var_4423c8ba++;
		n_progress = e_player.challenge_struct.var_4423c8ba;
		if(n_progress >= 3)
		{
			e_player.challenge_struct.var_4423c8ba = 3;
			n_progress = 3;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 3);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else
	{
		return;
	}
	if(n_progress >= 3)
	{
		e_attacker.challenge_struct notify(#"hash_5b6a8d05204c98e1");
	}
}

/*
	Name: function_8b70fc31
	Namespace: zm_towers_challenges
	Checksum: 0x7C8DB19F
	Offset: 0x4FA0
	Size: 0x194
	Parameters: 3
	Flags: Linked
*/
function function_8b70fc31(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_d1a6fe737f0b6e6";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 1);
	if(!isdefined(self.var_edf07bbf))
	{
		self.var_edf07bbf = 0;
	}
	self function_bce7e59b(e_player, 9, self.var_edf07bbf);
	/#
		self.var_5630d868 = 1;
		self.initboss_balcony_south = "";
	#/
	if(e_player === self.var_25276720)
	{
		self thread function_347214f4(e_player);
	}
	self waittill(#"hash_2818df4f7bf04998");
	self function_544b63c0(1);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_edf07bbf = undefined;
	e_trig function_d2103a80(e_player, 1);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_347214f4
	Namespace: zm_towers_challenges
	Checksum: 0xFD3C8F02
	Offset: 0x5140
	Size: 0x1A6
	Parameters: 1
	Flags: Linked
*/
function function_347214f4(e_player)
{
	self endon(#"hash_2818df4f7bf04998");
	e_player endon(#"disconnect");
	var_24f5d9f8 = array("zone_pap_room", "zone_pap_room_balcony_flooded_crypt");
	while(true)
	{
		level waittill(#"start_of_round");
		str_zone = e_player zm_zonemgr::get_player_zone();
		if(!isinarray(var_24f5d9f8, str_zone))
		{
			continue;
		}
		e_player thread function_29c490cf(self);
		e_player thread function_789f4d85(self);
		var_29b8f3d0 = undefined;
		var_29b8f3d0 = e_player waittill(#"death", #"hash_7df55853368e6305", #"left_temple");
		if(var_29b8f3d0._notify == #"hash_7df55853368e6305")
		{
			break;
		}
	}
	self function_2ae8eabe(1, 1);
	self function_544b63c0(1);
	self notify(#"hash_2818df4f7bf04998");
}

/*
	Name: function_29c490cf
	Namespace: zm_towers_challenges
	Checksum: 0x7B195903
	Offset: 0x52F0
	Size: 0xCE
	Parameters: 1
	Flags: Linked
*/
function function_29c490cf(var_31e6bd22)
{
	self endon(#"death", #"hash_7df55853368e6305");
	var_31e6bd22 endon(#"hash_2818df4f7bf04998");
	var_24f5d9f8 = array("zone_pap_room", "zone_pap_room_balcony_flooded_crypt");
	while(true)
	{
		str_zone = self zm_zonemgr::get_player_zone();
		if(!isinarray(var_24f5d9f8, str_zone))
		{
			break;
		}
		waitframe(1);
	}
	self notify(#"left_temple");
}

/*
	Name: function_789f4d85
	Namespace: zm_towers_challenges
	Checksum: 0xE0345B87
	Offset: 0x53C8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_789f4d85(var_31e6bd22)
{
	self endon(#"death", #"left_temple");
	var_31e6bd22 endon(#"hash_2818df4f7bf04998");
	level waittill(#"end_of_round");
	self notify(#"hash_7df55853368e6305");
}

/*
	Name: function_b1a2d509
	Namespace: zm_towers_challenges
	Checksum: 0x3194530C
	Offset: 0x5440
	Size: 0x194
	Parameters: 3
	Flags: Linked
*/
function function_b1a2d509(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_1e2e0e1f2879db9f";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 120);
	if(!isdefined(self.var_4b213d1b))
	{
		self.var_4b213d1b = 0;
	}
	self function_bce7e59b(e_player, 10, self.var_4b213d1b);
	n_required = int(2);
	/#
		self.var_5630d868 = n_required;
		self.initboss_balcony_south = "";
	#/
	if(e_player === self.var_25276720)
	{
		self thread function_1fe5e1a3(e_player);
	}
	self waittill(#"hash_60b65dbde4aab0c8");
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	e_player.var_4b213d1b = undefined;
	e_trig function_d2103a80(e_player, 120);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_1fe5e1a3
	Namespace: zm_towers_challenges
	Checksum: 0xEBC94906
	Offset: 0x55E0
	Size: 0x19E
	Parameters: 1
	Flags: Linked
*/
function function_1fe5e1a3(e_player)
{
	e_player endon(#"disconnect");
	self endon(#"hash_60b65dbde4aab0c8");
	if(!isplayer(e_player))
	{
		return;
	}
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_4b213d1b))
	{
		return;
	}
	n_progress = 0;
	while(self.var_4b213d1b < 120)
	{
		n_amount = e_player.var_7df228aa.var_def266a8;
		if(e_player zm_towers_crowd::function_aa0b6eb())
		{
			self.var_4b213d1b++;
			n_progress = self.var_4b213d1b;
			if(n_progress >= 120)
			{
				self.var_4b213d1b = 120;
				n_progress = 120;
			}
			self function_2ae8eabe(n_progress, 120);
		}
		else
		{
			self.var_4b213d1b = 0;
			n_progress = 0;
			self function_c6d050e9();
		}
		self function_544b63c0(n_progress);
		wait(1);
	}
	self function_544b63c0(n_progress);
	self notify(#"hash_60b65dbde4aab0c8");
}

/*
	Name: function_45396550
	Namespace: zm_towers_challenges
	Checksum: 0xFAC0717E
	Offset: 0x5788
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_45396550(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_2cf00f3e51c59d63";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 9);
	if(!isdefined(self.var_6c499d))
	{
		self.var_d7571058 = 0;
	}
	self function_bce7e59b(e_player, 11, self.var_d7571058);
	/#
		self.var_5630d868 = 9;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_34fea1fe34962ee4");
	self function_544b63c0(9);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_d7571058 = undefined;
	e_trig function_d2103a80(e_player, 9);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_4f3835a0
	Namespace: zm_towers_challenges
	Checksum: 0x6083F90D
	Offset: 0x5900
	Size: 0x158
	Parameters: 1
	Flags: Linked
*/
function function_4f3835a0(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_d7571058))
	{
		return;
	}
	n_progress = 0;
	if(isdefined(self))
	{
		if(function_b3114574(self.damageweapon))
		{
			e_player.challenge_struct.var_d7571058++;
			n_progress = e_player.challenge_struct.var_d7571058;
			if(n_progress >= 9)
			{
				n_progress = 9;
			}
			e_player.challenge_struct function_2ae8eabe(n_progress, 9);
			e_player.challenge_struct function_544b63c0(n_progress);
		}
		else
		{
			return;
		}
		if(n_progress >= 9)
		{
			e_attacker.challenge_struct notify(#"hash_34fea1fe34962ee4");
		}
	}
}

/*
	Name: function_b3114574
	Namespace: zm_towers_challenges
	Checksum: 0x5270C167
	Offset: 0x5A60
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function function_b3114574(weapon_type)
{
	switch(weapon_type.name)
	{
		case "hash_237b6756a81881cb":
		case "zhield_zword_dw":
		case "hash_2f351450f2e936dc":
		case "zhield_zword_dw_upgraded":
		{
			return true;
			break;
		}
		default:
		{
			return false;
			break;
		}
	}
}

/*
	Name: function_99f8f485
	Namespace: zm_towers_challenges
	Checksum: 0x785139A5
	Offset: 0x5AF8
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_99f8f485(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_5d5686795cc21d24";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 9);
	if(!isdefined(self.var_b6cfe237))
	{
		self.var_b6cfe237 = 0;
	}
	self function_bce7e59b(e_player, 12, self.var_b6cfe237);
	/#
		self.var_5630d868 = 9;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_47170980360105a8");
	self function_544b63c0(9);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_b6cfe237 = undefined;
	e_trig function_d2103a80(e_player, 9);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_20d01751
	Namespace: zm_towers_challenges
	Checksum: 0xEB791C3B
	Offset: 0x5C70
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_20d01751(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b6cfe237))
	{
		return;
	}
	n_progress = 0;
	if(self.var_6f84b820 == #"heavy")
	{
		e_player.challenge_struct.var_b6cfe237++;
		n_progress = e_player.challenge_struct.var_b6cfe237;
		if(n_progress >= 9)
		{
			e_player.challenge_struct.var_b6cfe237 = 9;
			n_progress = 9;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 9);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else
	{
		return;
	}
	if(n_progress >= 9)
	{
		e_player.challenge_struct notify(#"hash_47170980360105a8");
	}
}

/*
	Name: function_e50d2a3d
	Namespace: zm_towers_challenges
	Checksum: 0x9A910DEF
	Offset: 0x5DD8
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_e50d2a3d(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_36019120b3e88151";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 9);
	if(!isdefined(self.var_b11d9e23))
	{
		self.var_b11d9e23 = 0;
	}
	self function_bce7e59b(e_player, 13, self.var_b11d9e23);
	/#
		self.var_5630d868 = 9;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_b7f3e44410f5062");
	self function_544b63c0(9);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_b11d9e23 = undefined;
	e_trig function_d2103a80(e_player, 9);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_fb326fd3
	Namespace: zm_towers_challenges
	Checksum: 0xB486BBC2
	Offset: 0x5F50
	Size: 0x1C8
	Parameters: 1
	Flags: Linked
*/
function function_fb326fd3(params)
{
	if(!isdefined(params) || !isdefined(params.eattacker) || !isplayer(params.eattacker))
	{
		return;
	}
	e_player = params.eattacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_b11d9e23))
	{
		return;
	}
	if(zm_weap_crossbow::is_crossbow(params.weapon) && isarray(e_player.var_d382ba7a))
	{
		e_player.challenge_struct.var_b11d9e23 = e_player.var_d382ba7a.size;
		if(e_player.challenge_struct.var_b11d9e23 > 0)
		{
			e_player.challenge_struct.var_b11d9e23++;
		}
		e_player.challenge_struct function_2ae8eabe(e_player.challenge_struct.var_b11d9e23, 9);
		e_player.challenge_struct function_544b63c0(e_player.challenge_struct.var_b11d9e23);
		if(e_player.challenge_struct.var_b11d9e23 >= 9)
		{
			e_player.challenge_struct notify(#"hash_b7f3e44410f5062");
		}
	}
}

/*
	Name: function_1e0efdcd
	Namespace: zm_towers_challenges
	Checksum: 0xAAA7C899
	Offset: 0x6120
	Size: 0x184
	Parameters: 3
	Flags: Linked
*/
function function_1e0efdcd(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_1eafdb1b0b12fa11";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 1);
	if(!isdefined(self.var_8bafcbf3))
	{
		self.var_8bafcbf3 = 0;
	}
	self function_bce7e59b(e_player, 14, self.var_8bafcbf3);
	/#
		self.var_5630d868 = 1;
		self.initboss_balcony_south = "";
	#/
	e_player thread function_295948b2();
	self waittill(#"hash_5d7c0e41aec8535e");
	self function_544b63c0(1);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_8bafcbf3 = undefined;
	e_trig function_d2103a80(e_player, 1);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_295948b2
	Namespace: zm_towers_challenges
	Checksum: 0xE7455DEB
	Offset: 0x62B0
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function function_295948b2()
{
	self endon(#"disconnect", #"hash_5d7c0e41aec8535e");
	e_player = self;
	n_progress = 0;
	while(true)
	{
		waitresult = undefined;
		waitresult = e_player waittill(#"hash_46064b6c2cb5cf20");
		if(!isdefined(e_player) || !isplayer(e_player) || !isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_8bafcbf3))
		{
			return;
		}
		if(e_player.challenge_struct.var_8bafcbf3 < 1)
		{
			if(waitresult.blight_father.attacker === e_player)
			{
				if(isalive(waitresult.blight_father))
				{
					var_650f2d5e = undefined;
					var_650f2d5e = waitresult.blight_father waittilltimeout(0.75, #"death");
					if(var_650f2d5e._notify == #"timeout")
					{
						continue;
					}
					else if(waitresult.blight_father.attacker === e_player)
					{
						e_player.challenge_struct.var_8bafcbf3++;
					}
				}
				else
				{
					e_player.challenge_struct.var_8bafcbf3++;
				}
			}
			n_progress = e_player.challenge_struct.var_8bafcbf3;
		}
		if(n_progress >= 1)
		{
			e_player.challenge_struct.var_8bafcbf3 = 1;
			n_progress = 1;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 1);
		e_player.challenge_struct function_544b63c0(n_progress);
		if(n_progress >= 1)
		{
			e_player.challenge_struct notify(#"hash_5d7c0e41aec8535e");
		}
	}
}

/*
	Name: function_cd3a4ff5
	Namespace: zm_towers_challenges
	Checksum: 0xDC99B932
	Offset: 0x6540
	Size: 0x16C
	Parameters: 3
	Flags: Linked
*/
function function_cd3a4ff5(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_241698a67ac1d9d0";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 1);
	if(!isdefined(self.var_ea6db531))
	{
		self.var_ea6db531 = 0;
	}
	self function_bce7e59b(e_player, 15, self.var_ea6db531);
	/#
		self.var_5630d868 = 1;
		self.initboss_balcony_south = "";
	#/
	self waittill(#"hash_93d348ce67aaf63");
	self function_544b63c0(1);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_ea6db531 = undefined;
	e_trig function_d2103a80(e_player, 1);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_bbfef448
	Namespace: zm_towers_challenges
	Checksum: 0xBC6DE31E
	Offset: 0x66B8
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function function_bbfef448(e_attacker)
{
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_ea6db531))
	{
		return;
	}
	n_progress = 0;
	if(self.archetype == #"blight_father")
	{
		e_player.challenge_struct.var_ea6db531++;
		n_progress = e_player.challenge_struct.var_ea6db531;
		if(e_player.challenge_struct.var_ea6db531 >= 1)
		{
			e_player.challenge_struct.var_ea6db531 = 1;
			n_progress = 1;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 1);
		e_player.challenge_struct function_544b63c0(n_progress);
		if(n_progress >= 1)
		{
			e_attacker.challenge_struct notify(#"hash_93d348ce67aaf63");
		}
	}
}

/*
	Name: function_2bdfb862
	Namespace: zm_towers_challenges
	Checksum: 0xEFBE724
	Offset: 0x6828
	Size: 0x19C
	Parameters: 3
	Flags: Linked
*/
function function_2bdfb862(e_player, e_trig, var_5f06d3f8)
{
	e_player endon(#"disconnect");
	e_trig.hint_string = #"hash_16eb46dabae1c0ae";
	e_trig sethintstringforplayer(e_player, e_trig.hint_string, 20);
	if(!isdefined(self.var_83798eab))
	{
		self.var_83798eab = 0;
	}
	self function_bce7e59b(e_player, 16, self.var_83798eab);
	/#
		self.var_5630d868 = 20;
		self.initboss_balcony_south = "";
		e_player.initboss_balcony_south = self.initboss_balcony_south;
	#/
	self thread function_fc8ff5f4(e_player);
	self waittill(#"hash_3c4a9ff92127458d");
	self function_544b63c0(20);
	playsoundatposition(#"zmb_challenges_complete", (0, 0, 0));
	self.var_83798eab = undefined;
	e_trig function_d2103a80(e_player, 20);
	self flag::clear(#"hash_5a7dfe069f4cbcec");
}

/*
	Name: function_82437bf6
	Namespace: zm_towers_challenges
	Checksum: 0xF6316849
	Offset: 0x69D0
	Size: 0x200
	Parameters: 1
	Flags: Linked
*/
function function_82437bf6(e_attacker)
{
	if(!isdefined(e_attacker) || !isplayer(e_attacker))
	{
		return;
	}
	e_player = e_attacker;
	if(!isdefined(e_player.challenge_struct) || !isdefined(e_player.challenge_struct.var_83798eab))
	{
		return;
	}
	e_player.challenge_struct endon(#"hash_3c4a9ff92127458d");
	n_progress = 0;
	if(e_player.var_29f318bb === 1)
	{
		e_player.challenge_struct.var_83798eab++;
		n_progress = e_player.challenge_struct.var_83798eab;
		if(e_player.challenge_struct.var_83798eab >= 20)
		{
			e_player.challenge_struct.var_83798eab = 20;
			n_progress = 20;
		}
		e_player.challenge_struct function_2ae8eabe(n_progress, 20);
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	else if(e_player === e_player.challenge_struct.var_25276720)
	{
		e_player.challenge_struct.var_83798eab = 0;
		n_progress = 0;
		e_player.challenge_struct function_c6d050e9();
		e_player.challenge_struct function_544b63c0(n_progress);
	}
	if(n_progress >= 20)
	{
		e_player.challenge_struct notify(#"hash_3c4a9ff92127458d");
	}
}

/*
	Name: function_fc8ff5f4
	Namespace: zm_towers_challenges
	Checksum: 0xDB8307D6
	Offset: 0x6BD8
	Size: 0x200
	Parameters: 1
	Flags: Linked
*/
function function_fc8ff5f4(e_player)
{
	e_player endon(#"disconnect");
	self endon(#"hash_3c4a9ff92127458d");
	if(!isplayer(e_player))
	{
		return;
	}
	if(!isdefined(self) || !isdefined(self.var_83798eab))
	{
		return;
	}
	e_player.var_29f318bb = 0;
	var_9b5260f3 = getent("e_challenge_center_stage", "targetname");
	while(self.var_83798eab < 20)
	{
		if(e_player === self.var_25276720)
		{
			if(e_player istouching(var_9b5260f3))
			{
				e_player.var_29f318bb = 1;
			}
			else
			{
				e_player.var_29f318bb = 0;
				self.var_83798eab = 0;
				self function_c6d050e9();
				self function_544b63c0(self.var_83798eab);
			}
		}
		foreach(var_6bf81b9d in self function_876f93aa())
		{
			if(var_6bf81b9d istouching(var_9b5260f3))
			{
				var_6bf81b9d.var_29f318bb = 1;
				continue;
			}
			var_6bf81b9d.var_29f318bb = 0;
		}
		wait(0.5);
	}
}

/*
	Name: function_ea1042c6
	Namespace: zm_towers_challenges
	Checksum: 0x1C350826
	Offset: 0x6DE0
	Size: 0x5E4
	Parameters: 2
	Flags: Linked
*/
function function_ea1042c6(var_986431d3, var_394c506d)
{
	var_986431d3.challenge_struct = struct::get(var_986431d3.target);
	var_394c506d sethintstring(#"hash_685d7c68f4c511a7");
	while(true)
	{
		s_info = undefined;
		s_info = var_986431d3 waittill(#"trigger");
		e_player = s_info.activator;
		if(isplayer(e_player))
		{
			break;
		}
	}
	e_player.challenge_struct = var_986431d3.challenge_struct;
	e_player.challenge_struct.var_25276720 = e_player;
	e_player.challenge_struct.var_4931480f = getent(var_986431d3.challenge_struct.target, "targetname");
	e_player.challenge_struct.var_4931480f flag::init(#"hash_19856658ee6e4f3a");
	var_394c506d setinvisibletoall();
	foreach(player in getplayers())
	{
		if(player != e_player)
		{
			var_394c506d setvisibletoplayer(player);
			var_394c506d sethintstringforplayer(player, #"hash_1705b54e6528bc52");
			var_394c506d.var_da61c116 = 1;
			e_player.challenge_struct.var_4931480f setinvisibletoplayer(player);
			continue;
		}
		var_394c506d setvisibletoplayer(e_player);
		var_394c506d sethintstringforplayer(e_player, #"hash_4af8c1464e537f6");
		var_986431d3 setinvisibletoall();
		var_986431d3.var_da61c116 = 1;
	}
	var_284d45c2 = getentarray("t_challenge_cleat_hint_trig", "script_noteworthy");
	foreach(trig in var_284d45c2)
	{
		if(trig != var_394c506d)
		{
			trig sethintstringforplayer(e_player, #"hash_3e2be45acfa798cd");
		}
	}
	foreach(var_682f5a89 in level.var_38935e23)
	{
		if(var_682f5a89 != e_player.challenge_struct.var_4931480f)
		{
			var_682f5a89 setinvisibletoplayer(e_player, 1);
			continue;
		}
		var_682f5a89 setinvisibletoall();
		var_682f5a89 setvisibletoplayer(e_player);
		var_682f5a89.var_da61c116 = 1;
	}
	e_player thread function_67ffec1d();
	var_6eaa1749 = getentarray("t_zm_towers_cleat_damage_trig", "script_noteworthy");
	foreach(var_ed4ae98 in var_6eaa1749)
	{
		var_ed4ae98 setinvisibletoplayer(e_player, 1);
	}
	e_player.challenge_struct.var_4931480f function_1583001a(e_player, var_986431d3);
	var_20e5c3e2 = var_986431d3.target + "_banner";
	var_c1c87772 = getent(var_20e5c3e2, "targetname");
	str_color = function_7e61f202(var_c1c87772);
	var_c1c87772 scene::play(("p8_fxanim_zm_towers_banner_achievement_" + str_color) + "_bundle");
}

/*
	Name: function_67ffec1d
	Namespace: zm_towers_challenges
	Checksum: 0xB8BD121A
	Offset: 0x73D0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_67ffec1d()
{
	self endon(#"disconnect");
	level waittill(#"end_game");
	self function_fd8a137e();
}

/*
	Name: function_d2103a80
	Namespace: zm_towers_challenges
	Checksum: 0xF891649
	Offset: 0x7420
	Size: 0x38E
	Parameters: 2
	Flags: Linked
*/
function function_d2103a80(e_player, n_required_goal)
{
	e_player endon(#"disconnect", #"hash_4ac0558a94ba3fd7");
	self endon(#"hash_4ac0558a94ba3fd7", #"hash_6f7fd591a005844d");
	e_player flag::clear(#"hash_6534297bbe7e180d");
	self.var_f2e7f46a = 0;
	if(!e_player gamepadusedlast())
	{
		self sethintstring(#"hash_63302e97b05d8fc4");
	}
	else
	{
		self sethintstring(#"hash_710531ce6bfa48c8");
	}
	foreach(var_6bf81b9d in e_player.challenge_struct function_876f93aa())
	{
		var_6bf81b9d flag::clear(#"hash_6534297bbe7e180d");
		self sethintstringforplayer(var_6bf81b9d, #"hash_5501784aa04e0df2");
	}
	if(e_player == e_player.challenge_struct.var_25276720)
	{
		var_8efcfa9f = e_player.challenge_struct _good_door_opened(e_player, self);
	}
	if(function_8b1a219a())
	{
		self usetriggerignoreuseholdtime();
	}
	while(!e_player flag::get(#"hash_6534297bbe7e180d"))
	{
		e_player thread function_51aa96c6(var_8efcfa9f);
		s_info = undefined;
		s_info = self waittill(#"trigger");
		if(s_info.activator !== e_player.challenge_struct.var_25276720)
		{
			continue;
		}
		if(!zm_utility::can_use(e_player.challenge_struct.var_25276720, self.var_f2e7f46a))
		{
			self.banner.var_d412a3e6 thread function_577792a1(self, e_player);
			continue;
		}
		if(e_player flag::get(#"flag_player_initialized_reward"))
		{
			e_player player_give_reward(self);
			if(isdefined(e_player.challenge_struct.var_4d0b3b87))
			{
				e_player.challenge_struct.var_4d0b3b87 delete();
			}
		}
	}
	self notify(#"hash_6f7fd591a005844d");
}

/*
	Name: function_51aa96c6
	Namespace: zm_towers_challenges
	Checksum: 0xBED48AE5
	Offset: 0x77B8
	Size: 0x30A
	Parameters: 1
	Flags: Linked
*/
function function_51aa96c6(var_8efcfa9f)
{
	self endon(#"hash_6e1565b413e5e0f4", #"disconnect");
	if(self flag::get(#"flag_player_completed_all_challenges"))
	{
		return;
	}
	self.var_561f7ea3 = 0;
	while(true)
	{
		self.var_561f7ea3 = 0;
		if(isdefined(var_8efcfa9f) && self util::is_looking_at(var_8efcfa9f))
		{
			self.var_561f7ea3 = 1;
		}
		if(self meleebuttonpressed() && self.var_561f7ea3 && self istouching(self.challenge_struct.var_4931480f) && !self flag::get(#"flag_player_completed_all_challenges"))
		{
			self notify(#"hash_4ac0558a94ba3fd7");
			self.challenge_struct notify(#"hash_4ac0558a94ba3fd7");
			self.challenge_struct notify(#"hash_4ac0558a94ba3fd7");
			if(isdefined(self.challenge_struct.var_4d0b3b87))
			{
				self.challenge_struct.var_4d0b3b87 delete();
			}
			self function_fd8a137e();
			self.challenge_struct function_c6d050e9(1);
			self.challenge_struct.var_4931480f setinvisibletoall();
			self flag::set(#"hash_6534297bbe7e180d");
			foreach(var_6bf81b9d in self.challenge_struct function_876f93aa())
			{
				var_6bf81b9d flag::set(#"hash_6534297bbe7e180d");
			}
			self flag::clear(#"flag_player_initialized_reward");
			self.var_3e49c037 = undefined;
			self.challenge_struct.var_860b8f1e++;
			self thread function_e2e90905();
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_577792a1
	Namespace: zm_towers_challenges
	Checksum: 0x34C684CA
	Offset: 0x7AD0
	Size: 0x140
	Parameters: 2
	Flags: Linked
*/
function function_577792a1(e_trig, e_player)
{
	self endon(#"death");
	e_player endon(#"disconnect");
	self notify("4ae4a2c5e07fca53");
	self endon("4ae4a2c5e07fca53");
	while(!e_player flag::get(#"hash_6534297bbe7e180d"))
	{
		if(!zm_utility::can_use(e_player, e_trig.var_f2e7f46a) && e_player == e_player.challenge_struct.var_25276720)
		{
			e_trig sethintstringforplayer(e_player, "");
		}
		else
		{
			if(!e_player gamepadusedlast())
			{
				self sethintstring(#"hash_63302e97b05d8fc4");
			}
			else
			{
				self sethintstring(#"hash_710531ce6bfa48c8");
			}
		}
		wait(0.25);
	}
}

/*
	Name: _good_door_opened
	Namespace: zm_towers_challenges
	Checksum: 0xB5D9B064
	Offset: 0x7C18
	Size: 0x78A
	Parameters: 2
	Flags: Linked
*/
function _good_door_opened(e_player, e_trig)
{
	e_player endon(#"disconnect");
	var_50ed6de = (0, 90, 0);
	var_aa4f9213 = level.var_5d1e28ac[self.var_860b8f1e];
	e_player thread function_ae982bb9(#"challenge_completed");
	e_player clientfield::increment_to_player("" + #"hash_2bbcb9e09bd7bb26");
	switch(var_aa4f9213)
	{
		case "self_revive":
		{
			self.var_f7d17867 = (0, 0, 0);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = #"p8_zm_gla_heart_zombie";
			e_player clientfield::set("force_challenge_model", 1);
			break;
		}
		case "full_ammo":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_max_ammo";
			break;
		}
		case "double_points":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_double_points";
			break;
		}
		case "insta_kill":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 12);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "p7_zm_power_up_insta_kill";
			break;
		}
		case "hero_weapon_power":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 6);
			self.var_14172483 = (0, 0, 0);
			self.var_3ff570f3 = "p8_zm_powerup_full_power";
			break;
		}
		case "bonus_points_player":
		{
			self.var_f7d17867 = vectorscale((0, 0, 1), 10);
			self.var_14172483 = var_50ed6de;
			self.var_3ff570f3 = "zombie_z_money_icon";
			break;
		}
		case "ar_mg1909_t8":
		{
			e_trig.var_f2e7f46a = 1;
			self.var_f7d17867 = vectorscale((0, 0, 1), 9);
			self.var_14172483 = var_50ed6de;
			break;
		}
		case "lmg_standard_t8":
		{
			e_trig.var_f2e7f46a = 1;
			self.var_f7d17867 = vectorscale((0, 0, 1), 9);
			self.var_14172483 = var_50ed6de;
			break;
		}
		case "tr_midburst_t8":
		{
			e_trig.var_f2e7f46a = 1;
			self.var_f7d17867 = vectorscale((0, 0, 1), 9);
			self.var_14172483 = var_50ed6de;
			break;
		}
		case "pistol_standard_t8_upgraded":
		{
			e_trig.var_f2e7f46a = 1;
			self.var_f7d17867 = vectorscale((0, 0, 1), 7);
			self.var_14172483 = var_50ed6de;
			break;
		}
		case "lmg_spray_t8_upgraded":
		{
			e_trig.var_f2e7f46a = 1;
			self.var_f7d17867 = vectorscale((0, 0, 1), 7);
			self.var_14172483 = var_50ed6de;
			break;
		}
		case "free_perk":
		{
			sound = "evt_bottle_dispense";
			playsoundatposition(sound, self.origin);
			var_62fef0f1 = e_player zm_perks::function_5ea0c6cf();
			if(!isdefined(var_62fef0f1))
			{
				self.var_f7d17867 = vectorscale((0, 0, -1), 40);
				self.var_14172483 = (0, 90 * -1, 0);
				break;
			}
			self.var_62fef0f1 = var_62fef0f1;
			self zm_vapor_random::function_2cc4144b(var_62fef0f1);
			var_d9973a01 = anglestoforward(self.angles) * -2;
			self.var_f7d17867 = var_d9973a01 + vectorscale((0, 0, 1), 7);
			self.var_14172483 = var_50ed6de;
			break;
		}
	}
	var_e18247ac = self.origin + self.var_f7d17867;
	var_9ac46b0e = self.angles + self.var_14172483;
	if(var_aa4f9213 == #"ar_mg1909_t8" || var_aa4f9213 == #"lmg_standard_t8" || var_aa4f9213 == #"tr_midburst_t8" || var_aa4f9213 == #"lmg_spray_t8_upgraded" || var_aa4f9213 == #"pistol_standard_t8_upgraded")
	{
		self.var_4d0b3b87 = zm_utility::spawn_buildkit_weapon_model(e_player, getweapon(var_aa4f9213), undefined, var_e18247ac, var_9ac46b0e);
		self.var_4d0b3b87.str_weapon_name = var_aa4f9213;
		self.var_4d0b3b87 movez(5, 1);
	}
	else
	{
		if(var_aa4f9213 == "free_perk")
		{
			if(!isdefined(self.var_62fef0f1))
			{
				self.var_4d0b3b87 = util::spawn_model(level.chest_joker_model, var_e18247ac, var_9ac46b0e);
				self.var_4d0b3b87 movez(5, 1);
			}
			else
			{
				mdl_temp = zm_perks::get_perk_weapon_model(self.var_62fef0f1);
				self.var_4d0b3b87 = level.bottle_spawn_location;
				if(isdefined(self.var_4d0b3b87))
				{
					self.var_4d0b3b87 setmodel(mdl_temp);
				}
				self thread registerlove_mountain_(e_player);
			}
		}
		else
		{
			self.var_4d0b3b87 = util::spawn_model(self.var_3ff570f3, var_e18247ac, var_9ac46b0e);
			self.var_4d0b3b87 movez(5, 1);
		}
	}
	e_player.var_3e49c037 = 1;
	e_player flag::set(#"flag_player_initialized_reward");
	return self.var_4d0b3b87;
}

/*
	Name: registerlove_mountain_
	Namespace: zm_towers_challenges
	Checksum: 0xA635AEBA
	Offset: 0x83B0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function registerlove_mountain_(e_player)
{
	e_player endon(#"disconnect", #"hash_4ac0558a94ba3fd7", #"hash_5a74f9da0718c63d", #"hash_6534297bbe7e180d");
	level endon(#"end_game");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = e_player waittill(#"perk_acquired");
		if(var_be17187b.var_16c042b8 === self.var_62fef0f1)
		{
			var_f26e01e4 = e_player zm_perks::function_5ea0c6cf();
			if(!isdefined(var_f26e01e4))
			{
				self.var_4d0b3b87 setmodel(level.chest_joker_model);
				return;
			}
			self.var_62fef0f1 = var_f26e01e4;
			if(isdefined(self.var_4d0b3b87))
			{
				mdl_temp = zm_perks::get_perk_weapon_model(self.var_62fef0f1);
				self.var_4d0b3b87 setmodel(mdl_temp);
			}
		}
	}
}

/*
	Name: player_give_reward
	Namespace: zm_towers_challenges
	Checksum: 0xF1303348
	Offset: 0x8518
	Size: 0x3CC
	Parameters: 1
	Flags: Linked
*/
function player_give_reward(e_trig)
{
	self endon(#"disconnect");
	self notify(#"hash_6e1565b413e5e0f4");
	self.challenge_struct function_c6d050e9(1);
	e_trig setinvisibletoall();
	var_aa4f9213 = level.var_5d1e28ac[self.challenge_struct.var_860b8f1e];
	switch(var_aa4f9213)
	{
		case "self_revive":
		{
			self zm_laststand::function_3a00302e();
			self clientfield::set("force_challenge_model", 0);
			break;
		}
		case "free_perk":
		{
			if(isdefined(self.challenge_struct.var_62fef0f1))
			{
				self flag::set(#"hash_5a74f9da0718c63d");
				if(!self zm_perks::function_80cb4982())
				{
					self zm_perks::function_a7ae070c(self.challenge_struct.var_62fef0f1);
				}
			}
			break;
		}
		case "hero_weapon_power":
		case "bonus_points_player":
		case "full_ammo":
		case "insta_kill":
		case "double_points":
		{
			level thread zm_powerups::specific_powerup_drop(var_aa4f9213, self.origin, undefined, undefined, undefined, undefined, 1, 1);
			break;
		}
		case "tr_midburst_t8":
		case "pistol_standard_t8_upgraded":
		case "lmg_spray_t8_upgraded":
		case "ar_mg1909_t8":
		case "lmg_standard_t8":
		{
			if(isdefined(self.challenge_struct.var_4d0b3b87.str_weapon_name))
			{
				var_498a708 = getweapon(self.challenge_struct.var_4d0b3b87.str_weapon_name);
			}
			self thread swap_weapon(var_498a708);
			break;
		}
	}
	self function_fd8a137e();
	self flag::set(#"hash_6534297bbe7e180d");
	foreach(var_6bf81b9d in self.challenge_struct function_876f93aa())
	{
		var_6bf81b9d flag::set(#"hash_6534297bbe7e180d");
	}
	self flag::clear(#"flag_player_initialized_reward");
	self.var_3e49c037 = undefined;
	self.challenge_struct.var_860b8f1e++;
	self thread function_e2e90905();
}

/*
	Name: function_e2e90905
	Namespace: zm_towers_challenges
	Checksum: 0x7D846F28
	Offset: 0x88F0
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e2e90905()
{
	var_aa4f9213 = level.var_5d1e28ac[self.challenge_struct.var_860b8f1e];
	if(var_aa4f9213 === #"pistol_standard_t8_upgraded")
	{
		level clientfield::set("" + #"hash_2e38cc453c5ecb9c", 1);
	}
	else
	{
		if(var_aa4f9213 === #"lmg_spray_t8_upgraded")
		{
			level clientfield::set("" + #"hash_2e38cc453c5ecb9c", 2);
		}
		else if(level clientfield::get("" + #"hash_2e38cc453c5ecb9c"))
		{
			level clientfield::set("" + #"hash_2e38cc453c5ecb9c", 0);
		}
	}
}

/*
	Name: swap_weapon
	Namespace: zm_towers_challenges
	Checksum: 0x29F5FDC3
	Offset: 0x8A30
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function swap_weapon(var_498a708)
{
	var_6822257f = self getweaponslist();
	foreach(w_gun in var_6822257f)
	{
		if(w_gun.rootweapon === var_498a708)
		{
			self zm_weapons::function_7c5dd4bd(w_gun);
			return;
		}
	}
	if(!self hasweapon(var_498a708, 1))
	{
		self function_e2a25377(var_498a708);
	}
}

/*
	Name: function_e2a25377
	Namespace: zm_towers_challenges
	Checksum: 0x3F18F21
	Offset: 0x8B28
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_e2a25377(var_498a708)
{
	if(self hasweapon(zm_weapons::get_base_weapon(var_498a708), 1))
	{
		self takeweapon(zm_weapons::get_base_weapon(var_498a708), 1);
	}
	self zm_weapons::weapon_give(var_498a708, 1);
}

/*
	Name: function_3c4fc73
	Namespace: zm_towers_challenges
	Checksum: 0x7450C334
	Offset: 0x8BB8
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_3c4fc73()
{
	var_381a90f6 = level.perk_purchase_limit;
	if(self flag::get(#"hash_5a74f9da0718c63d"))
	{
		var_381a90f6++;
	}
	return var_381a90f6;
}

/*
	Name: function_bce7e59b
	Namespace: zm_towers_challenges
	Checksum: 0xF4ABB23E
	Offset: 0x8C08
	Size: 0x150
	Parameters: 3
	Flags: Linked
*/
function function_bce7e59b(e_player, n_challenge_index, n_current_progress)
{
	if(isdefined(e_player) && isdefined(self.var_25276720) && e_player == self.var_25276720)
	{
		level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", n_current_progress, e_player);
		level zm_ui_inventory::function_7df6bb60(#"zm_towers_challenges", n_challenge_index, e_player);
	}
	foreach(var_6bf81b9d in self function_876f93aa())
	{
		level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", n_current_progress, var_6bf81b9d);
		level zm_ui_inventory::function_7df6bb60(#"zm_towers_challenges", n_challenge_index, var_6bf81b9d);
	}
}

/*
	Name: function_544b63c0
	Namespace: zm_towers_challenges
	Checksum: 0x9FF61998
	Offset: 0x8D60
	Size: 0xD8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_544b63c0(n_progress)
{
	if(isdefined(self.var_25276720))
	{
		level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", n_progress, self.var_25276720);
	}
	foreach(var_6bf81b9d in self function_876f93aa())
	{
		level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", n_progress, var_6bf81b9d);
	}
}

/*
	Name: function_876f93aa
	Namespace: zm_towers_challenges
	Checksum: 0xD85353CA
	Offset: 0x8E40
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_876f93aa()
{
	if(!isdefined(self.var_6432be9b))
	{
		return array();
	}
	self.var_6432be9b = array::remove_undefined(self.var_6432be9b);
	return self.var_6432be9b;
}

/*
	Name: function_a83b406a
	Namespace: zm_towers_challenges
	Checksum: 0x56F24F1
	Offset: 0x8E98
	Size: 0x160
	Parameters: 0
	Flags: None
*/
function function_a83b406a()
{
	/#
		if(isdefined(self.var_9276b18a) && self.var_9276b18a)
		{
			foreach(e_player in getplayers())
			{
				if(isdefined(e_player.challenge_struct))
				{
					if(isdefined(e_player.challenge_struct.var_97467803) && e_player.challenge_struct.var_97467803)
					{
						if(e_player.challenge_struct flag::get(#"hash_5a7dfe069f4cbcec"))
						{
							e_player.challenge_struct function_e4b04738(e_player.challenge_struct.var_5630d868, e_player, e_player.challenge_struct.e_trig.hint_string, e_player.challenge_struct.initboss_balcony_south);
						}
					}
				}
			}
		}
	#/
}

/*
	Name: function_e4b04738
	Namespace: zm_towers_challenges
	Checksum: 0xA390355
	Offset: 0x9000
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function function_e4b04738(var_5630d868, e_player, str_hint_text, var_2597a9f0)
{
	/#
		level zm_ui_inventory::function_7df6bb60(#"hash_4b82dc3b7c860360", var_5630d868, e_player);
		self function_2ae8eabe(var_5630d868, var_5630d868);
		self notify(var_2597a9f0);
	#/
}

