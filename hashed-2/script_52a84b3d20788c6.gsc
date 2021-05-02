// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_1b10fdf0addd52e;
#using script_34bde5579203fa3;
#using script_35598499769dbb3d;
#using script_3657077a08b7f19e;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_444bc5b4fa0fe14f;
#using script_4d85e8de54b02198;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_6ce38ab036223e6e;
#using script_7e59d7bba853fe4b;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_83bc53d2;

/*
	Name: function_89f2df9
	Namespace: namespace_83bc53d2
	Checksum: 0x9DDDEEBE
	Offset: 0x688
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4bca7168ca976d7f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_83bc53d2
	Checksum: 0x84EC580F
	Offset: 0x6D0
	Size: 0x554
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	if(!isarchetypeloaded(#"hash_1bab8a0ba811401e"))
	{
		return;
	}
	namespace_a216c96::function_8f9b9d24(0, &function_d422ab54);
	namespace_a216c96::function_8f9b9d24(1, &function_19287ba5);
	namespace_a216c96::function_8f9b9d24(3, &function_30b33bc4);
	namespace_a216c96::function_8f9b9d24(2, &function_57285eec);
	namespace_a216c96::function_8f9b9d24(4, &function_f9f8d9e6);
	spawner::add_archetype_spawn_function(#"zombie", &function_49d71e38);
	zm_utility::function_d0f02e71(#"hash_1bab8a0ba811401e");
	zm_player::register_player_damage_callback(&function_22e12b7);
	namespace_57ff8cbb::function_39553a7c(#"hash_1bab8a0ba811401e", &function_5ea7ae19);
	namespace_57ff8cbb::function_cdf5a512(#"hash_1bab8a0ba811401e", &function_3eaa8337);
	namespace_32192f7::function_95c1dd81(#"hash_1bab8a0ba811401e", &function_52ce9654);
	level.var_3ecc60fc[0] = 1;
	level.var_3ecc60fc[2] = 3;
	level.var_3ecc60fc[1] = 2;
	level.var_3ecc60fc[3] = 4;
	clientfield::register("actor", "catalyst_aura_clientfield", 1, 3, "int");
	clientfield::register("actor", "catalyst_damage_explosion_clientfield", 1, 1, "counter");
	clientfield::register("actor", "corrosive_death_clientfield", 1, 1, "int");
	clientfield::register("actor", "corrosive_miasma_clientfield", 1, 1, "int");
	clientfield::register("actor", "water_catalyst_purified", 1, 1, "int");
	clientfield::register("actor", "electricity_catalyst_blast", 1, 1, "int");
	clientfield::register("actor", "plasma_catalyst_blast", 1, 1, "int");
	level thread aat::register_immunity("zm_aat_brain_decay", #"hash_1bab8a0ba811401e", 1, 1, 0);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"hash_1bab8a0ba811401e", 1, 1, 0);
	zm_spawner::register_zombie_death_event_callback(&function_4c2c69ab);
	namespace_c3287616::register_archetype(#"hash_1bab8a0ba811401e", &function_55f82550, &round_spawn, undefined, 25);
	namespace_c3287616::function_306ce518(#"hash_1bab8a0ba811401e", &function_587a3171);
	/#
		spawner::add_archetype_spawn_function(#"hash_1bab8a0ba811401e", &zombie_utility::function_27ba8249);
	#/
	spawner::add_archetype_spawn_function(#"zombie", &function_59e10bc5);
	spawner::function_89a2cd87(#"hash_1bab8a0ba811401e", &function_47fdbfbb);
	function_6e75e858();
	function_25f308e2();
	/#
		level thread function_1a0ae193();
	#/
}

/*
	Name: function_52ce9654
	Namespace: namespace_83bc53d2
	Checksum: 0xD09B4D56
	Offset: 0xC30
	Size: 0x284
	Parameters: 0
	Flags: Linked, Private
*/
private function function_52ce9654()
{
	if(isarray(level.zm_loc_types) && level.zm_loc_types[#"zombie_location"].size > 0)
	{
		a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
		var_31b16a0 = [];
		foreach(s_spawn_loc in a_s_spawn_locs)
		{
			if(isdefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location"))
			{
				continue;
			}
			if(!isdefined(var_31b16a0))
			{
				var_31b16a0 = [];
			}
			else if(!isarray(var_31b16a0))
			{
				var_31b16a0 = array(var_31b16a0);
			}
			var_31b16a0[var_31b16a0.size] = s_spawn_loc;
		}
		if(isarray(level.zm_loc_types[#"blight_father_location"]) && level.zm_loc_types[#"blight_father_location"].size > 0)
		{
			var_31b16a0 = arraycombine(var_31b16a0, level.zm_loc_types[#"blight_father_location"], 0, 0);
		}
		var_47c2dcf7 = zombie_utility::spawn_zombie(array::random(level.var_aa069b5), undefined, array::random(var_31b16a0));
		if(isdefined(var_47c2dcf7))
		{
			var_47c2dcf7 namespace_3fffba66::function_bbaec2fd();
			if(var_47c2dcf7.var_62e81e47 == 1)
			{
				level thread function_4329a51b(var_47c2dcf7);
			}
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_25f308e2
	Namespace: namespace_83bc53d2
	Checksum: 0x242C59B3
	Offset: 0xEC0
	Size: 0x1E4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_25f308e2()
{
	namespace_3fffba66::function_cfca77a7(function_bbb2bab5(1), #"hash_78ca8e8e6bdbc8ab", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_corrosive_spawn_pre_split", "aib_vign_zm_zod_catalyst_corrosive_spawn_post_split");
	namespace_3fffba66::function_cfca77a7(function_bbb2bab5(3), #"hash_266b62e342076a90", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_electric_spawn_pre_split", "aib_vign_zm_zod_catalyst_electric_spawn_post_split");
	namespace_3fffba66::function_cfca77a7(function_bbb2bab5(2), #"hash_5cfa99582cc66c59", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_plasma_spawn_pre_split", "aib_vign_zm_zod_catalyst_plasma_spawn_post_split");
	namespace_3fffba66::function_cfca77a7(function_bbb2bab5(4), #"hash_5d6b55906fc82ff2", &function_39212989, 5, &function_f4043bc8, &function_2ed1300e, "aib_vign_zm_zod_catalyst_water_spawn_pre_split", "aib_vign_zm_zod_catalyst_water_spawn_post_split");
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_83bc53d2
	Checksum: 0x3FD173A5
	Offset: 0x10B0
	Size: 0x50C
	Parameters: 0
	Flags: Linked, Private
*/
private function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_177aa69d));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_6e732e3940240c58", &function_177aa69d);
	/#
		assert(isscriptfunctionptr(&function_f4e7fd8f));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_69f8b2358092c7d2", &function_f4e7fd8f);
	/#
		assert(isscriptfunctionptr(&function_787ce068));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5ff2f90caf2f463d", &function_787ce068);
	/#
		assert(!isdefined(&function_21cbb589) || isscriptfunctionptr(&function_21cbb589));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_6c92ebda) || isscriptfunctionptr(&function_6c92ebda));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7b47cc66161f357c", &function_21cbb589, undefined, &function_6c92ebda);
	/#
		assert(isscriptfunctionptr(&function_1043897a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1430ed09cf5c6db5", &function_1043897a);
	/#
		assert(isscriptfunctionptr(&function_dec8327a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1747a785a62d469f", &function_dec8327a);
	/#
		assert(isscriptfunctionptr(&function_554a7c58));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_55c082fcd22cf9d7", &function_554a7c58);
	/#
		assert(isscriptfunctionptr(&function_d647a79d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3891bbe2c51e97c9", &function_d647a79d);
	animationstatenetwork::registernotetrackhandlerfunction("tag_fx_electric_attack", &function_d697a1e3);
	animationstatenetwork::registernotetrackhandlerfunction("tag_fx_electric_attack_stop", &function_aef521f5);
	animationstatenetwork::registernotetrackhandlerfunction("tag_fx_plasma_death", &function_3b07d86e);
	animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_model", &function_4329a51b);
	animationstatenetwork::registernotetrackhandlerfunction("corrosive_hide_gas", &function_247a46c1);
	animationstatenetwork::registernotetrackhandlerfunction("tag_fx_corrosive_death", &function_cda81e65);
	animationstatenetwork::registernotetrackhandlerfunction("ghost_catalyst", &function_c8f01c4b);
}

/*
	Name: function_49d71e38
	Namespace: namespace_83bc53d2
	Checksum: 0x80F724D1
	Offset: 0x15C8
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_49d71e38()
{
}

/*
	Name: function_47fdbfbb
	Namespace: namespace_83bc53d2
	Checksum: 0x18750D68
	Offset: 0x15D8
	Size: 0x2C4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_47fdbfbb()
{
	if(!isdefined(self.var_9fde8624))
	{
		return;
	}
	health_multiplier = 1;
	switch(self.var_9fde8624)
	{
		case "hash_78ca8e8e6bdbc8ab":
		{
			health_multiplier = self ai::function_9139c839().var_51ce117f;
			self.var_17a22c08 = self ai::function_9139c839().var_57140ac3;
			break;
		}
		case "hash_266b62e342076a90":
		{
			health_multiplier = self ai::function_9139c839().var_6e7acfb4;
			self.var_17a22c08 = self ai::function_9139c839().var_fe586e50;
			break;
		}
		case "hash_5cfa99582cc66c59":
		{
			health_multiplier = self ai::function_9139c839().var_33236cb0;
			self.var_17a22c08 = self ai::function_9139c839().var_145b14e6;
			break;
		}
		case "hash_5d6b55906fc82ff2":
		{
			health_multiplier = self ai::function_9139c839().var_bacb0199;
			self.var_17a22c08 = self ai::function_9139c839().var_ead9d81d;
			break;
		}
	}
	health_multiplier = health_multiplier * (isdefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1);
	var_ab9f2e38 = zombie_utility::ai_calculate_health(zombie_utility::function_d2dfacfd(#"zombie_health_start"), (isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number));
	self.maxhealth = int(max(var_ab9f2e38 * health_multiplier, 1));
	self.health = int(max(self.maxhealth * (isdefined(self.var_d67de8a4) ? self.var_d67de8a4 : 1), 1));
	self zm_score::function_82732ced();
}

/*
	Name: function_befab5d9
	Namespace: namespace_83bc53d2
	Checksum: 0x4478CB2F
	Offset: 0x18A8
	Size: 0x3A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_befab5d9()
{
	if(math::cointoss())
	{
		self.zombie_arms_position = "up";
	}
	else
	{
		self.zombie_arms_position = "down";
	}
}

/*
	Name: function_d422ab54
	Namespace: namespace_83bc53d2
	Checksum: 0x64B95B35
	Offset: 0x18F0
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d422ab54()
{
	self clientfield::set("catalyst_aura_clientfield", self.var_62e81e47);
	self.canbetargetedbyturnedzombies = 1;
	self.var_6d23c054 = 1;
	self.ignorepathenemyfightdist = 1;
	self.custom_location = &function_bbe2a1d2;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self.var_2f68be48 = 1;
	self.var_7cc959b1 = 1;
	self.var_1731eda3 = 1;
	self.var_2c628c0f = 1;
	self thread function_734195be();
	self.var_d1c70689 = &function_439c457c;
	self thread zm_spawner::zombie_think();
	level thread zm_spawner::zombie_death_event(self);
	self thread zm_utility::function_13cc9756();
	self pushplayer(0);
}

/*
	Name: function_734195be
	Namespace: namespace_83bc53d2
	Checksum: 0x4D9241C0
	Offset: 0x1A30
	Size: 0xCE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_734195be()
{
	self endon(#"death");
	self.var_69a981e6 = 1;
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = level waittill(#"transformation_complete");
		if(isdefined(var_385703b7.var_944250d2) && isarray(var_385703b7.var_944250d2) && isinarray(var_385703b7.var_944250d2, self))
		{
			self.var_69a981e6 = 0;
			self.zombie_think_done = 1;
			self.completed_emerging_into_playable_area = 1;
		}
	}
}

/*
	Name: function_4c2c69ab
	Namespace: namespace_83bc53d2
	Checksum: 0xE82B19AC
	Offset: 0x1B08
	Size: 0x224
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4c2c69ab(e_attacker)
{
	if(!isdefined(self.var_62e81e47))
	{
		return;
	}
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(isdefined(self.var_85387c5b) && self.var_85387c5b)
	{
		e_attacker zm_stats::increment_challenge_stat(#"hash_564d41c1808857c7");
		self thread function_d0673f24(e_attacker, self getcentroid());
	}
	else if(isdefined(self.damageweapon) && isdefined(e_attacker.var_b01de37))
	{
		var_e5088518 = aat::function_702fb333(self.damageweapon);
		a_keys = getarraykeys(e_attacker.var_b01de37);
		if(isinarray(a_keys, var_e5088518))
		{
			if(self.var_62e81e47 === e_attacker.var_b01de37[var_e5088518])
			{
				e_attacker zm_stats::increment_challenge_stat(#"hash_564d41c1808857c7");
				self thread function_d0673f24(e_attacker, self getcentroid());
			}
		}
	}
	if(isdefined(e_attacker))
	{
		if(isdefined(self.var_69a981e6) && self.var_69a981e6)
		{
			if(isdefined(self.var_6a4ce3f7))
			{
				e_attacker zm_score::player_add_points("transform_kill", self.var_6a4ce3f7);
			}
			else
			{
				e_attacker zm_score::player_add_points("transform_kill");
			}
		}
		scoreevents::processscoreevent("kill_catalyst", e_attacker, undefined, self.damageweapon);
	}
}

/*
	Name: function_c8f01c4b
	Namespace: namespace_83bc53d2
	Checksum: 0xF3BC27BE
	Offset: 0x1D38
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c8f01c4b(behaviortreeentity)
{
	behaviortreeentity ghost();
	behaviortreeentity notsolid();
}

/*
	Name: function_f4e7fd8f
	Namespace: namespace_83bc53d2
	Checksum: 0xC523AE55
	Offset: 0x1D80
	Size: 0x182
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f4e7fd8f(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1]))
	{
		return 1;
	}
	if(!isdefined(behaviortreeentity.enemy))
	{
		return 1;
	}
	if(isdefined(behaviortreeentity.marked_for_death))
	{
		return 1;
	}
	if(isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee)
	{
		return 1;
	}
	if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > behaviortreeentity ai::function_9139c839().var_c9e47b3f * behaviortreeentity ai::function_9139c839().var_c9e47b3f)
	{
		return 1;
	}
	yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_3eaa8337
	Namespace: namespace_83bc53d2
	Checksum: 0xC324C23C
	Offset: 0x1F10
	Size: 0x3E0
	Parameters: 0
	Flags: Linked
*/
function function_3eaa8337()
{
	a_s_spawn_locs = level.zm_loc_types[#"zombie_location"];
	var_91562d8c = [];
	var_f2a95155 = [];
	foreach(s_spawn_loc in a_s_spawn_locs)
	{
		if(isdefined(s_spawn_loc.script_noteworthy) && (s_spawn_loc.script_noteworthy == "riser_location" || s_spawn_loc.script_noteworthy == "faller_location"))
		{
			continue;
		}
		if(s_spawn_loc.script_string == "find_flesh")
		{
			if(!isdefined(var_91562d8c))
			{
				var_91562d8c = [];
			}
			else if(!isarray(var_91562d8c))
			{
				var_91562d8c = array(var_91562d8c);
			}
			var_91562d8c[var_91562d8c.size] = s_spawn_loc;
			continue;
		}
		if(!isdefined(var_f2a95155))
		{
			var_f2a95155 = [];
		}
		else if(!isarray(var_f2a95155))
		{
			var_f2a95155 = array(var_f2a95155);
		}
		var_f2a95155[var_f2a95155.size] = s_spawn_loc;
	}
	if(isdefined(level.zm_loc_types[#"blight_father_location"]) && level.zm_loc_types[#"blight_father_location"].size > 0)
	{
		var_91562d8c = arraycombine(var_91562d8c, level.zm_loc_types[#"blight_father_location"], 0, 0);
	}
	if(isdefined(level.var_78a428fe))
	{
		points = [[level.var_78a428fe]]();
		if(isdefined(points) && points.size > 0)
		{
			var_91562d8c = arraycombine(var_91562d8c, points, 0, 0);
		}
	}
	if(var_91562d8c.size)
	{
		var_d7eff26a = zm_spawner::function_20e7d186(var_91562d8c);
	}
	else if(var_f2a95155.size)
	{
		var_d7eff26a = zm_spawner::function_20e7d186(var_f2a95155);
	}
	else
	{
		/#
		#/
		return 0;
	}
	if(isdefined(self) && isentity(self))
	{
		self clientfield::set("catalyst_aura_clientfield", 0);
		if(self.var_62e81e47 == 1)
		{
			self clientfield::set("corrosive_miasma_clientfield", 0);
		}
		self namespace_e0710ee6::function_a8dc3363(var_d7eff26a);
		if(isdefined(self))
		{
			self clientfield::set("catalyst_aura_clientfield", self.var_62e81e47);
			if(self.var_62e81e47 == 1)
			{
				self clientfield::set("corrosive_miasma_clientfield", 1);
			}
		}
	}
	return 1;
}

/*
	Name: function_5ea7ae19
	Namespace: namespace_83bc53d2
	Checksum: 0x83ECEA8C
	Offset: 0x22F8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_5ea7ae19(var_3a145c54)
{
	if(var_3a145c54)
	{
		level thread function_616468cb(self.var_9fde8624);
	}
}

/*
	Name: function_616468cb
	Namespace: namespace_83bc53d2
	Checksum: 0x4160CB7E
	Offset: 0x2338
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_616468cb(var_56c95dd4)
{
	level endon(#"game_ended");
	level waittill(#"start_of_round");
	namespace_3fffba66::function_bdd8aba6(var_56c95dd4);
}

/*
	Name: function_19287ba5
	Namespace: namespace_83bc53d2
	Checksum: 0x131D1B03
	Offset: 0x2398
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
private function function_19287ba5()
{
	self setblackboardattribute("_catalyst_type", "corrosive");
	self thread zm_audio::play_ambient_zombie_vocals();
	self thread zm_audio::zmbaivox_notifyconvert();
	self function_befab5d9();
	self zombie_utility::set_zombie_run_cycle("run");
}

/*
	Name: function_d647a79d
	Namespace: namespace_83bc53d2
	Checksum: 0x26D519DE
	Offset: 0x2438
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d647a79d(entity)
{
	return self.var_9fde8624 === #"hash_78ca8e8e6bdbc8ab";
}

/*
	Name: function_cda81e65
	Namespace: namespace_83bc53d2
	Checksum: 0x25ADB478
	Offset: 0x2468
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_cda81e65(entity)
{
	entity clientfield::set("corrosive_death_clientfield", 1);
	entity ghost();
	entity notsolid();
}

/*
	Name: function_4329a51b
	Namespace: namespace_83bc53d2
	Checksum: 0x1A123039
	Offset: 0x24D0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_4329a51b(entity)
{
	if(isalive(entity))
	{
		entity thread function_e13aa91c();
	}
}

/*
	Name: function_247a46c1
	Namespace: namespace_83bc53d2
	Checksum: 0x1F3DC3EB
	Offset: 0x2518
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_247a46c1(entity)
{
	entity clientfield::set("corrosive_miasma_clientfield", 0);
}

/*
	Name: function_d4953883
	Namespace: namespace_83bc53d2
	Checksum: 0x984CD25B
	Offset: 0x2550
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d4953883(notifyhash)
{
	self clientfield::set("corrosive_miasma_clientfield", 0);
}

/*
	Name: function_e13aa91c
	Namespace: namespace_83bc53d2
	Checksum: 0x663E5279
	Offset: 0x2588
	Size: 0x30A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e13aa91c()
{
	self notify("734b0571937e2a76");
	self endon("734b0571937e2a76");
	self endon(#"death");
	self endon_callback(&function_d4953883, #"hash_11d4cfae418fcfe1");
	self clientfield::set("corrosive_miasma_clientfield", 1);
	var_7a79774b = function_4d1e7b48("dot_corrosive_catalyst");
	while(true)
	{
		var_319aa551 = self.origin + (0, 0, self ai::function_9139c839().var_2a523c14 / 2);
		foreach(player in level.players)
		{
			if(isalive(player) && (!(isdefined(player.var_a0a1475c) && player.var_a0a1475c)) && !player scene::is_igc_active() && distancesquared(player.origin, self.origin) <= self ai::function_9139c839().var_f3af70e6 * self ai::function_9139c839().var_f3af70e6 && (abs(player.origin[2] - var_319aa551[2]) <= self ai::function_9139c839().var_2a523c14 / 2 || abs(player geteye()[2] - var_319aa551[2]) <= self ai::function_9139c839().var_2a523c14 / 2))
			{
				player status_effect::status_effect_apply(var_7a79774b, undefined, self, 0);
				player thread zm_audio::create_and_play_dialog(#"hash_50660c7d730b03a1", #"react");
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_30b33bc4
	Namespace: namespace_83bc53d2
	Checksum: 0xD1740637
	Offset: 0x28A0
	Size: 0xCA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_30b33bc4()
{
	self setblackboardattribute("_catalyst_type", "electric");
	self function_befab5d9();
	self zombie_utility::set_zombie_run_cycle("run");
	self thread zm_audio::play_ambient_zombie_vocals();
	self thread zm_audio::zmbaivox_notifyconvert();
	self.var_51f067e3 = gettime() + self ai::function_9139c839().var_65b97e5e;
	self.var_eaa92291 = gettime();
}

/*
	Name: function_787ce068
	Namespace: namespace_83bc53d2
	Checksum: 0x48BCA6F5
	Offset: 0x2978
	Size: 0x312
	Parameters: 1
	Flags: Linked, Private
*/
private function function_787ce068(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.var_62e81e47) || behaviortreeentity.var_62e81e47 != 3)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.var_529093ee) && behaviortreeentity.var_529093ee)
	{
		behaviortreeentity.var_529093ee = 0;
		return 1;
	}
	if(behaviortreeentity.var_eaa92291 > gettime())
	{
		return 0;
	}
	behaviortreeentity.var_eaa92291 = gettime() + 500;
	if(isdefined(behaviortreeentity.missinglegs) && behaviortreeentity.missinglegs)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.traversal))
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.barricade_enter) && behaviortreeentity.barricade_enter)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.is_leaping) && behaviortreeentity.is_leaping)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.var_a85128a4) && behaviortreeentity.var_a85128a4)
	{
		return 0;
	}
	if(behaviortreeentity.var_51f067e3 > gettime())
	{
		return 0;
	}
	var_55edeb64 = 0;
	foreach(player in level.players)
	{
		if(!zm_utility::is_player_valid(player, 1, 1))
		{
			continue;
		}
		if(isdefined(player.var_6b8f84c7) || (isdefined(player.var_a0a1475c) && player.var_a0a1475c))
		{
			continue;
		}
		if(player scene::is_igc_active())
		{
			continue;
		}
		if(distancesquared(player.origin, behaviortreeentity.origin) > self ai::function_9139c839().var_cbf14156 * self ai::function_9139c839().var_cbf14156)
		{
			continue;
		}
		if(player sightconetrace(behaviortreeentity.origin, behaviortreeentity, anglestoforward(behaviortreeentity.angles), self ai::function_9139c839().var_95922bb3))
		{
			behaviortreeentity.var_529093ee = 1;
			var_55edeb64 = 1;
			break;
		}
	}
	return var_55edeb64;
}

/*
	Name: function_21cbb589
	Namespace: namespace_83bc53d2
	Checksum: 0x131BC7F3
	Offset: 0x2C98
	Size: 0x3E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_21cbb589(behaviortreeentity, asmstatename)
{
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	behaviortreeentity.var_a85128a4 = 1;
	return 5;
}

/*
	Name: function_d697a1e3
	Namespace: namespace_83bc53d2
	Checksum: 0x3B8D4297
	Offset: 0x2CE0
	Size: 0x20A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d697a1e3()
{
	self endon(#"hash_321b8431208f19bd", #"death");
	self clientfield::set("electricity_catalyst_blast", 1);
	wait(self ai::function_9139c839().var_ce7e1def);
	while(true)
	{
		foreach(player in level.players)
		{
			if(isdefined(player.var_6b8f84c7) || (isdefined(player.var_a0a1475c) && player.var_a0a1475c))
			{
				continue;
			}
			if(player laststand::player_is_in_laststand())
			{
				continue;
			}
			if(player scene::is_igc_active())
			{
				continue;
			}
			if(distancesquared(player.origin, self.origin) > self ai::function_9139c839().var_cbf14156 * self ai::function_9139c839().var_cbf14156)
			{
				continue;
			}
			if(player sightconetrace(self.origin, self, anglestoforward(self.angles), self ai::function_9139c839().var_95922bb3))
			{
				player thread function_e7a0424c(self);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_aef521f5
	Namespace: namespace_83bc53d2
	Checksum: 0x4CC0703
	Offset: 0x2EF8
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_aef521f5(behaviortreeentity)
{
	self notify(#"hash_321b8431208f19bd");
	self clientfield::set("electricity_catalyst_blast", 0);
}

/*
	Name: function_6c92ebda
	Namespace: namespace_83bc53d2
	Checksum: 0x69564BDB
	Offset: 0x2F40
	Size: 0xD2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_6c92ebda(behaviortreeentity, asmstatename)
{
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	behaviortreeentity notify(#"hash_321b8431208f19bd");
	behaviortreeentity clientfield::set("electricity_catalyst_blast", 0);
	var_12588ac8 = randomfloatrange(behaviortreeentity ai::function_9139c839().var_984d7701, behaviortreeentity ai::function_9139c839().var_58ac6ec4);
	behaviortreeentity.var_51f067e3 = gettime() + var_12588ac8;
	behaviortreeentity.var_a85128a4 = 0;
	return 4;
}

/*
	Name: function_e137506e
	Namespace: namespace_83bc53d2
	Checksum: 0xC782A288
	Offset: 0x3020
	Size: 0x66
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e137506e(var_ee511b7d)
{
	self endon(#"death", #"disconnect", #"hash_7283e5f17e4fa10a");
	var_ee511b7d waittill(#"death");
	self notify(#"hash_6407608db0e465ec");
}

/*
	Name: function_73961a38
	Namespace: namespace_83bc53d2
	Checksum: 0xA01CF1A6
	Offset: 0x3090
	Size: 0x106
	Parameters: 1
	Flags: Linked, Private
*/
private function function_73961a38(notifyhash)
{
	var_80841b2c = function_4d1e7b48("blind_zm_catalyst");
	var_f4addf92 = function_4d1e7b48("deaf_electricity_catalyst");
	if(self status_effect::function_4617032e(var_80841b2c.var_67e2281d))
	{
		self status_effect::function_408158ef(var_80841b2c.var_67e2281d, var_80841b2c.var_18d16a6b);
	}
	if(self status_effect::function_4617032e(var_f4addf92.var_67e2281d))
	{
		self status_effect::function_408158ef(var_f4addf92.var_67e2281d, var_f4addf92.var_18d16a6b);
	}
	self.var_6b8f84c7 = undefined;
	self notify(#"hash_7283e5f17e4fa10a");
}

/*
	Name: function_e7a0424c
	Namespace: namespace_83bc53d2
	Checksum: 0x57373B4C
	Offset: 0x31A0
	Size: 0x254
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e7a0424c(behaviortreeentity)
{
	self.var_6b8f84c7 = behaviortreeentity;
	var_116cfaae = behaviortreeentity ai::function_9139c839().var_10a535a6;
	var_a7594ae8 = behaviortreeentity ai::function_9139c839().var_ea39f524;
	self endon_callback(&function_73961a38, #"death", #"disconnect", #"hash_6407608db0e465ec", #"hash_11d4cfae418fcfe1");
	self thread function_e137506e(self.var_6b8f84c7);
	var_80841b2c = function_4d1e7b48("blind_zm_catalyst");
	self status_effect::status_effect_apply(var_80841b2c, undefined, self.var_6b8f84c7, 0, var_116cfaae);
	self util::delay(1.3, undefined, &zm_audio::create_and_play_dialog, #"hash_4c7748b237c6fcbe", #"react");
	wait(float(var_116cfaae) / 1000);
	if(self status_effect::function_4617032e(var_80841b2c.var_67e2281d))
	{
		self status_effect::function_408158ef(var_80841b2c.var_67e2281d, var_80841b2c.var_18d16a6b);
	}
	util::wait_network_frame();
	self status_effect::status_effect_apply(function_4d1e7b48("deaf_electricity_catalyst"), undefined, self.var_6b8f84c7, 0, var_a7594ae8);
	wait(float(var_a7594ae8) / 1000);
	self function_73961a38();
}

/*
	Name: function_57285eec
	Namespace: namespace_83bc53d2
	Checksum: 0x7438D15
	Offset: 0x3400
	Size: 0xDE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_57285eec()
{
	self setblackboardattribute("_catalyst_type", "plasma");
	self function_befab5d9();
	self zombie_utility::set_zombie_run_cycle("walk");
	self.var_146fbd4b = gettime() + self ai::function_9139c839().var_c7d67645 + self ai::function_9139c839().var_65b97e5e;
	self thread zm_audio::zmbaivox_notifyconvert();
	self.var_ab8f2b90 = 2;
	self.b_override_explosive_damage_cap = 1;
}

/*
	Name: function_1043897a
	Namespace: namespace_83bc53d2
	Checksum: 0xA8895FD0
	Offset: 0x34E8
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1043897a(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.var_62e81e47) || behaviortreeentity.var_62e81e47 != 2)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.is_exploding) && behaviortreeentity.is_exploding)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_dec8327a
	Namespace: namespace_83bc53d2
	Checksum: 0xF6106C51
	Offset: 0x3558
	Size: 0x1A6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dec8327a(behaviortreeentity)
{
	if(behaviortreeentity.var_62e81e47 !== 2)
	{
		return 0;
	}
	if(behaviortreeentity.var_146fbd4b > gettime())
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.is_exploding) && behaviortreeentity.is_exploding)
	{
		return 1;
	}
	foreach(player in level.players)
	{
		if(!zombie_utility::is_player_valid(player))
		{
			continue;
		}
		if(isdefined(player.var_a0a1475c) && player.var_a0a1475c)
		{
			continue;
		}
		if(player scene::is_igc_active())
		{
			continue;
		}
		if(isdefined(player.bgb_in_plain_sight_active) && player.bgb_in_plain_sight_active)
		{
			continue;
		}
		if(distancesquared(player.origin, behaviortreeentity.origin) <= behaviortreeentity ai::function_9139c839().var_febbf56f * behaviortreeentity ai::function_9139c839().var_febbf56f)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_de076722
	Namespace: namespace_83bc53d2
	Checksum: 0x59069415
	Offset: 0x3708
	Size: 0xCA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_de076722(entity)
{
	origins = spawnstruct();
	origins.eye = entity geteye();
	origins.feet = entity.origin + vectorscale((0, 0, 1), 8);
	origins.mid = (origins.feet[0], origins.feet[1], origins.feet[2] + origins.eye[2] / 2);
	return origins;
}

/*
	Name: function_554a7c58
	Namespace: namespace_83bc53d2
	Checksum: 0xBF7C1B23
	Offset: 0x37E0
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_554a7c58(behaviortreeentity)
{
	behaviortreeentity.is_exploding = 1;
}

/*
	Name: function_49248f23
	Namespace: namespace_83bc53d2
	Checksum: 0x7AFE5A48
	Offset: 0x3808
	Size: 0x156
	Parameters: 2
	Flags: Linked, Private
*/
private function function_49248f23(v_blast_origin, var_84dd3dd)
{
	level endon(#"game_ended");
	var_109e8af9 = 0;
	a_ai = zombie_utility::get_round_enemy_array();
	foreach(entity in a_ai)
	{
		if(!isalive(entity))
		{
			continue;
		}
		if(entity === self)
		{
			continue;
		}
		if(distancesquared(v_blast_origin, entity.origin) > var_84dd3dd)
		{
			continue;
		}
		entity zombie_utility::setup_zombie_knockdown(v_blast_origin);
		var_109e8af9++;
		if(var_109e8af9 >= 6)
		{
			util::wait_network_frame();
			var_109e8af9 = 0;
		}
	}
}

/*
	Name: function_3b07d86e
	Namespace: namespace_83bc53d2
	Checksum: 0x46FFD63F
	Offset: 0x3968
	Size: 0x3D4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3b07d86e()
{
	var_f152d0cc = function_de076722(self);
	self clientfield::set("plasma_catalyst_blast", 1);
	v_blast_origin = self.origin;
	var_84dd3dd = self ai::function_9139c839().var_c30a9dc5 * self ai::function_9139c839().var_c30a9dc5;
	var_2ffdfebc = self ai::function_9139c839().var_35692434;
	level notify(#"hash_528115ad9eebc84f");
	if(!self isragdoll())
	{
		foreach(player in getplayers())
		{
			if(!zombie_utility::is_player_valid(player, undefined, undefined, 0))
			{
				continue;
			}
			if(distancesquared(v_blast_origin, player.origin) > var_84dd3dd)
			{
				continue;
			}
			var_d2b8d08a = function_de076722(player);
			if(!bullettracepassed(var_f152d0cc.eye, var_d2b8d08a.eye, 0, undefined))
			{
				if(!bullettracepassed(var_f152d0cc.mid, var_d2b8d08a.mid, 0, undefined))
				{
					if(!bullettracepassed(var_f152d0cc.feet, var_d2b8d08a.feet, 0, undefined))
					{
						continue;
					}
				}
			}
			player dodamage(var_2ffdfebc, v_blast_origin, self, self, "none", "MOD_EXPLOSIVE");
			var_6826a387 = function_4d1e7b48(#"hash_528115ad9eebc84f");
			player status_effect::status_effect_apply(var_6826a387, undefined, self, 0, undefined, undefined, v_blast_origin);
			player thread zm_audio::create_and_play_dialog(#"hash_695932a4ae89574f", #"react");
		}
		level thread function_49248f23(v_blast_origin, var_84dd3dd);
	}
	if(isdefined(self))
	{
		if(zm_utility::is_magic_bullet_shield_enabled(self))
		{
			self util::stop_magic_bullet_shield();
		}
		self val::set(#"hash_1bab8a0ba811401e", "hide", 2);
		if(isalive(self))
		{
			self.takedamage = 1;
			self.allowdeath = 1;
			self kill();
		}
	}
}

/*
	Name: function_72a1933a
	Namespace: namespace_83bc53d2
	Checksum: 0x84826BB6
	Offset: 0x3D48
	Size: 0x11E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_72a1933a(zombie, var_b2571463)
{
	if(!isdefined(var_b2571463.last_closest_player) || !isdefined(var_b2571463.last_closest_player.cached_zone) || !isdefined(var_b2571463.cached_zone) || !isdefined(zombie.cached_zone))
	{
		return 0;
	}
	if(zombie.completed_emerging_into_playable_area !== 1)
	{
		return 0;
	}
	if(zombie.var_d53c2370 !== 1)
	{
		return 0;
	}
	if(zombie.var_5c8ac43e === 1)
	{
		return 0;
	}
	if(zombie.cached_zone != var_b2571463.last_closest_player.cached_zone && !isdefined(var_b2571463.last_closest_player.cached_zone.adjacent_zones[zombie.cached_zone.name]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_d9d6e939
	Namespace: namespace_83bc53d2
	Checksum: 0x3229932C
	Offset: 0x3E70
	Size: 0x23C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d9d6e939(entity)
{
	if(isdefined(self.var_8020a7f2))
	{
		self.need_closest_player = 0;
		if(isalive(self.var_8020a7f2) && function_72a1933a(self.var_8020a7f2, self))
		{
			self setgoal(self.var_8020a7f2.origin);
			return;
		}
	}
	zombies = getaiarchetypearray(#"zombie");
	var_31a419e0 = [];
	foreach(zombie in zombies)
	{
		if(function_72a1933a(zombie, self))
		{
			if(!isdefined(var_31a419e0))
			{
				var_31a419e0 = [];
			}
			else if(!isarray(var_31a419e0))
			{
				var_31a419e0 = array(var_31a419e0);
			}
			var_31a419e0[var_31a419e0.size] = zombie;
		}
	}
	if(var_31a419e0.size == 0)
	{
		self.var_8020a7f2 = undefined;
		self.b_ignore_cleanup = undefined;
		self.should_zigzag = undefined;
		zm_behavior::zombiefindflesh(entity);
		return;
	}
	self.need_closest_player = 0;
	var_31a419e0 = arraysortclosest(var_31a419e0, entity.origin);
	self.var_8020a7f2 = var_31a419e0[0];
	self.b_ignore_cleanup = 1;
	self.should_zigzag = 0;
	self setgoal(self.var_8020a7f2.origin);
}

/*
	Name: function_177aa69d
	Namespace: namespace_83bc53d2
	Checksum: 0xE59E6D2E
	Offset: 0x40B8
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
private function function_177aa69d(behaviortreeentity)
{
	if(behaviortreeentity.var_62e81e47 === 4 && behaviortreeentity ai::has_behavior_attribute("gravity") && behaviortreeentity ai::get_behavior_attribute("gravity") == "normal")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_59e10bc5
	Namespace: namespace_83bc53d2
	Checksum: 0x22E03B8A
	Offset: 0x4138
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
private function function_59e10bc5()
{
	self.var_d53c2370 = 1;
}

/*
	Name: function_f49b9b11
	Namespace: namespace_83bc53d2
	Checksum: 0x807D7C8F
	Offset: 0x4158
	Size: 0x54
	Parameters: 1
	Flags: Private
*/
private function function_f49b9b11(var_3a145c54)
{
	if(isdefined(self.var_5c8ac43e) && self.var_5c8ac43e)
	{
		if(!isdefined(level.var_53b28340))
		{
			level.var_53b28340 = 1;
		}
		else
		{
			level.var_53b28340++;
		}
	}
}

/*
	Name: function_304eef2e
	Namespace: namespace_83bc53d2
	Checksum: 0x610C6A3
	Offset: 0x41B8
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_304eef2e()
{
	self thread function_e5e8cbd2(1);
}

/*
	Name: function_f9f8d9e6
	Namespace: namespace_83bc53d2
	Checksum: 0xCDAE77CB
	Offset: 0x41E0
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f9f8d9e6()
{
	self setblackboardattribute("_catalyst_type", "water");
	self function_befab5d9();
	self zombie_utility::set_zombie_run_cycle("sprint");
	self.var_72411ccf = &function_d9d6e939;
	level.var_1ea3f886 = self ai::function_9139c839().var_803e192e;
	level.var_e1ade08 = self ai::function_9139c839().var_f00dd43c;
	self thread zm_audio::play_ambient_zombie_vocals();
	self thread zm_audio::zmbaivox_notifyconvert();
	wait(self ai::function_9139c839().var_65b97e5e);
	if(isdefined(self))
	{
		self function_12cb11ca();
	}
}

/*
	Name: function_12cb11ca
	Namespace: namespace_83bc53d2
	Checksum: 0x26FE59A8
	Offset: 0x4320
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
private function function_12cb11ca()
{
	if(isalive(self))
	{
		self thread function_75070c6();
	}
}

/*
	Name: function_75070c6
	Namespace: namespace_83bc53d2
	Checksum: 0xDD0E1AB1
	Offset: 0x4360
	Size: 0x228
	Parameters: 0
	Flags: Linked, Private
*/
private function function_75070c6()
{
	self endon(#"death");
	while(true)
	{
		trigger_height = self ai::function_9139c839().var_1803b87d;
		var_a00ff069 = self ai::function_9139c839().var_baa0ac60 * self ai::function_9139c839().var_baa0ac60;
		foreach(zombie in zombie_utility::get_round_enemy_array())
		{
			if(isalive(zombie) && (isdefined(zombie.var_d53c2370) && zombie.var_d53c2370) && (!(isdefined(zombie.var_5c8ac43e) && zombie.var_5c8ac43e)))
			{
				if(zombie.origin[2] >= self.origin[2] && abs(zombie.origin[2] - self.origin[2]) <= trigger_height && distancesquared(zombie.origin, self.origin) <= var_a00ff069)
				{
					zombie thread function_e5e8cbd2(0);
					wait(2);
				}
			}
		}
		wait(randomfloatrange(0.1, 0.2));
	}
}

/*
	Name: function_e5e8cbd2
	Namespace: namespace_83bc53d2
	Checksum: 0x7AFED76A
	Offset: 0x4590
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_e5e8cbd2(var_2df73abb)
{
	self notify(#"hash_25ca29da51a78702");
	self endon(#"hash_25ca29da51a78702");
	self.var_5c8ac43e = 1;
	if(isdefined(level.var_e1ade08))
	{
		self.var_9b416b35 = level.var_e1ade08;
	}
	if(!var_2df73abb && isdefined(level.var_1ea3f886))
	{
		self.health = int(self.health * level.var_1ea3f886);
	}
	self.var_bd2c55ef = 1;
	if(!isdefined(self.var_e0d660f6))
	{
		self.var_e0d660f6 = [];
	}
	else if(!isarray(self.var_e0d660f6))
	{
		self.var_e0d660f6 = array(self.var_e0d660f6);
	}
	if(!isinarray(self.var_e0d660f6, &function_304eef2e))
	{
		self.var_e0d660f6[self.var_e0d660f6.size] = &function_304eef2e;
	}
	self clientfield::set("water_catalyst_purified", 1);
	self thread zm_audio::function_ef9ba49c(#"hash_4433242e2d225df8");
	self waittill(#"death");
	if(isdefined(self))
	{
		self clientfield::set("water_catalyst_purified", 0);
	}
}

/*
	Name: function_50a8406d
	Namespace: namespace_83bc53d2
	Checksum: 0x2F11BD76
	Offset: 0x4770
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_50a8406d()
{
	return isdefined(self.var_5c8ac43e) && self.var_5c8ac43e;
}

/*
	Name: function_22e12b7
	Namespace: namespace_83bc53d2
	Checksum: 0xB4FED6A8
	Offset: 0x4790
	Size: 0xE0
	Parameters: 10
	Flags: Linked, Private
*/
private function function_22e12b7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && eattacker function_50a8406d() && isdefined(eattacker.var_9b416b35) && (!(isdefined(self.var_a0a1475c) && self.var_a0a1475c)))
	{
		return int(ceil(idamage * eattacker.var_9b416b35));
	}
	return -1;
}

/*
	Name: function_55c235fa
	Namespace: namespace_83bc53d2
	Checksum: 0x4C8EB36A
	Offset: 0x4878
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_55c235fa(s_spot)
{
	if(isdefined(level.var_c97f9f06))
	{
		self thread [[level.var_c97f9f06]](s_spot);
	}
	if(isdefined(level.var_ce7b374c))
	{
		self thread [[level.var_ce7b374c]]();
	}
}

/*
	Name: function_6e75e858
	Namespace: namespace_83bc53d2
	Checksum: 0xFFB5FD36
	Offset: 0x48D8
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_6e75e858()
{
	level.var_aa069b5 = getentarray("zombie_catalyst_spawner", "script_noteworthy");
	if(level.var_aa069b5.size == 0)
	{
		return;
	}
	foreach(var_c1da220b in level.var_aa069b5)
	{
		var_c1da220b.is_enabled = 1;
		var_c1da220b.script_forcespawn = 1;
		var_c1da220b spawner::add_spawn_function(&function_4581397c);
	}
}

/*
	Name: function_4581397c
	Namespace: namespace_83bc53d2
	Checksum: 0x80F724D1
	Offset: 0x49C0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_4581397c()
{
}

/*
	Name: function_da7cd6ce
	Namespace: namespace_83bc53d2
	Checksum: 0x71B51242
	Offset: 0x49D0
	Size: 0xAA
	Parameters: 0
	Flags: None
*/
function function_da7cd6ce()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			return 1;
			break;
		}
		case 2:
		{
			return 2;
			break;
		}
		case 3:
		{
			return 3;
			break;
		}
		case 4:
		{
			return 4;
			break;
		}
	}
}

/*
	Name: function_bbb2bab5
	Namespace: namespace_83bc53d2
	Checksum: 0xEFB13E4A
	Offset: 0x4A88
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_bbb2bab5(var_3d9951bb)
{
	var_b62aefe1 = function_e1763259(var_3d9951bb);
	foreach(e_spawner in level.var_aa069b5)
	{
		if(e_spawner.var_9fde8624 == var_b62aefe1)
		{
			return e_spawner;
		}
	}
	return undefined;
}

/*
	Name: function_39212989
	Namespace: namespace_83bc53d2
	Checksum: 0x10A3F7F8
	Offset: 0x4B40
	Size: 0x23A
	Parameters: 0
	Flags: Linked
*/
function function_39212989()
{
	if(!level flag::get("spawn_zombies") && (!(isdefined(level.var_c9f5947d) && level.var_c9f5947d)))
	{
		return 0;
	}
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	if(namespace_e0710ee6::function_db610082() == 0)
	{
		return 0;
	}
	if(isdefined(level.var_4a03b294) && level.var_4a03b294)
	{
		return 1;
	}
	if(isdefined(self.var_641025d6) && self.var_641025d6 > gettime())
	{
		return 0;
	}
	if(isdefined(self.var_9528ba7a) && self.var_9528ba7a)
	{
		return 1;
	}
	var_57bb4de2 = 0;
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(distancesquared(player.origin, self.origin) < 147456)
		{
			continue;
		}
		if(distancesquared(player.origin, self.origin) > 589824)
		{
			continue;
		}
		var_57bb4de2 = self sightconetrace(player geteye(), player, anglestoforward(player.angles));
		if(var_57bb4de2)
		{
			break;
		}
	}
	return var_57bb4de2;
}

/*
	Name: function_f4043bc8
	Namespace: namespace_83bc53d2
	Checksum: 0x954A6134
	Offset: 0x4D88
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_f4043bc8()
{
	self.b_ignore_cleanup = 1;
	self thread zm_audio::function_ef9ba49c(#"hash_3a2923869483d05");
}

/*
	Name: function_2ed1300e
	Namespace: namespace_83bc53d2
	Checksum: 0x5E377765
	Offset: 0x4DC8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_2ed1300e(n_health_percent)
{
	self.var_d67de8a4 = n_health_percent;
}

/*
	Name: function_bbe2a1d2
	Namespace: namespace_83bc53d2
	Checksum: 0x97F020CA
	Offset: 0x4DF0
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function function_bbe2a1d2(var_3b720eb2)
{
	if(isdefined(self))
	{
		self notify(#"risen");
	}
}

/*
	Name: function_e1763259
	Namespace: namespace_83bc53d2
	Checksum: 0x2B28EFD9
	Offset: 0x4E20
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function function_e1763259(var_3d9951bb)
{
	switch(var_3d9951bb)
	{
		case 1:
		{
			var_b62aefe1 = #"hash_78ca8e8e6bdbc8ab";
			break;
		}
		case 3:
		{
			var_b62aefe1 = #"hash_266b62e342076a90";
			break;
		}
		case 2:
		{
			var_b62aefe1 = #"hash_5cfa99582cc66c59";
			break;
		}
		case 4:
		{
			var_b62aefe1 = #"hash_5d6b55906fc82ff2";
			break;
		}
	}
	return var_b62aefe1;
}

/*
	Name: function_b2090194
	Namespace: namespace_83bc53d2
	Checksum: 0xA5BA2EA8
	Offset: 0x4EF0
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_b2090194(var_3d9951bb)
{
	if(!isdefined(var_3d9951bb))
	{
		namespace_3fffba66::function_d2374144(self, function_e1763259(randomintrange(1, 5)));
	}
	else
	{
		var_b62aefe1 = function_e1763259(var_3d9951bb);
		namespace_3fffba66::function_d2374144(self, var_b62aefe1);
	}
}

/*
	Name: function_439c457c
	Namespace: namespace_83bc53d2
	Checksum: 0x93D5849A
	Offset: 0x4F88
	Size: 0x13A
	Parameters: 12
	Flags: Linked
*/
function function_439c457c(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker) && isplayer(attacker) && isdefined(self.var_62e81e47) && isdefined(weapon) && isdefined(attacker.var_b01de37))
	{
		var_e5088518 = aat::function_702fb333(weapon);
		if(self.var_62e81e47 === attacker.var_b01de37[var_e5088518])
		{
			damage = damage * 2;
			if(damage >= self.health || attacker zm_powerups::is_insta_kill_active())
			{
				self.var_85387c5b = 1;
			}
		}
	}
	return damage;
}

/*
	Name: function_d0673f24
	Namespace: namespace_83bc53d2
	Checksum: 0x70CAB664
	Offset: 0x50D0
	Size: 0x18C
	Parameters: 2
	Flags: Linked
*/
function function_d0673f24(player, v_loc)
{
	self clientfield::increment("catalyst_damage_explosion_clientfield");
	a_ai_zombies = array::get_all_closest(v_loc, getaiteamarray(level.zombie_team), array(self), undefined, self ai::function_9139c839().var_746e06db);
	level notify(#"hash_166cac102910cdb3");
	if(a_ai_zombies.size == 0)
	{
		return;
	}
	foreach(ai_zombie in a_ai_zombies)
	{
		if(!isalive(ai_zombie))
		{
			continue;
		}
		ai_zombie function_3f664506(self, player, v_loc);
		waitframe(1);
	}
	if(isalive(self))
	{
		self thread function_27a8f02d();
	}
}

/*
	Name: function_3f664506
	Namespace: namespace_83bc53d2
	Checksum: 0x5F2C9ED2
	Offset: 0x5268
	Size: 0x294
	Parameters: 3
	Flags: Linked
*/
function function_3f664506(var_b8bbcd96, player, v_loc)
{
	if(!isalive(self) || zm_utility::is_magic_bullet_shield_enabled(self))
	{
		return;
	}
	if(isdefined(self.var_69a981e6) && self.var_69a981e6)
	{
		return;
	}
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	if(!isdefined(self.var_6f84b820))
	{
		return;
	}
	var_806d3869 = 0;
	switch(self.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		case "enhanced":
		{
			var_103da188 = self.health;
			if(self.archetype === #"zombie" || self.archetype === #"hash_1bab8a0ba811401e")
			{
				self function_27a8f02d();
			}
			break;
		}
		case "heavy":
		{
			var_103da188 = self.maxhealth * 0.5;
			var_806d3869 = 1;
			break;
		}
		case "miniboss":
		{
			var_103da188 = self.maxhealth * 0.2;
			var_806d3869 = 1;
			break;
		}
		case "boss":
		{
			var_103da188 = 2700;
			break;
		}
		default:
		{
			var_103da188 = self.health;
		}
	}
	if(isalive(self))
	{
		self dodamage(var_103da188, v_loc, player, var_b8bbcd96, "none", "MOD_EXPLOSIVE", 0, player getcurrentweapon());
		if(isalive(self) && var_806d3869)
		{
			self thread ai::stun();
		}
	}
}

/*
	Name: function_27a8f02d
	Namespace: namespace_83bc53d2
	Checksum: 0x69B83C88
	Offset: 0x5508
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_27a8f02d()
{
	gibserverutils::gibhead(self);
	gibserverutils::gibleftarm(self);
	gibserverutils::gibrightarm(self);
	gibserverutils::giblegs(self);
}

/*
	Name: function_587a3171
	Namespace: namespace_83bc53d2
	Checksum: 0x4C84903E
	Offset: 0x5578
	Size: 0x1C8
	Parameters: 1
	Flags: Linked
*/
function function_587a3171(n_round_number)
{
	level endon(#"end_game");
	var_f31e767a = array::randomize(array(1, 3, 2, 4));
	/#
		var_47099258 = level.round_number - n_round_number;
		if(var_47099258 >= 4)
		{
			var_f31e767a = undefined;
		}
		else if(var_47099258 > 0)
		{
			for(i = 0; i < var_47099258; i++)
			{
				arrayremoveindex(var_f31e767a, 0);
			}
		}
	#/
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"hash_1bab8a0ba811401e"))
		{
			if(isdefined(var_f31e767a))
			{
				level.var_1643d0d = array(array::pop(var_f31e767a));
				if(!var_f31e767a.size)
				{
					var_f31e767a = undefined;
				}
			}
			else
			{
				level.var_1643d0d = arraycopy(level.var_3ecc60fc);
				arrayremoveindex(level.var_1643d0d, randomint(level.var_1643d0d.size));
			}
		}
	}
}

/*
	Name: function_55f82550
	Namespace: namespace_83bc53d2
	Checksum: 0x1EBF1690
	Offset: 0x5748
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_55f82550(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 25));
	var_a1737466 = randomfloatrange(0.08, 0.12);
	return min(var_8cf00d40, int(level.zombie_total * var_a1737466));
}

/*
	Name: round_spawn
	Namespace: namespace_83bc53d2
	Checksum: 0x4CEAF861
	Offset: 0x57F8
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	if(!isdefined(level.var_1643d0d))
	{
		level.var_1643d0d = arraycopy(level.var_3ecc60fc);
		arrayremoveindex(level.var_1643d0d, randomint(level.var_1643d0d.size));
	}
	var_3d9951bb = array::random(level.var_1643d0d);
	if(isdefined(level.var_ed006fe8))
	{
		if(!isdefined(level.var_ed006fe8))
		{
			level.var_ed006fe8 = [];
		}
		else if(!isarray(level.var_ed006fe8))
		{
			level.var_ed006fe8 = array(level.var_ed006fe8);
		}
		var_3d9951bb = array::random(level.var_ed006fe8);
	}
	namespace_3fffba66::function_bdd8aba6(function_e1763259(var_3d9951bb));
	return 0;
}

/*
	Name: function_255c7194
	Namespace: namespace_83bc53d2
	Checksum: 0x22FD5931
	Offset: 0x5950
	Size: 0xAC
	Parameters: 0
	Flags: Private
*/
private function function_255c7194()
{
	/#
		player = getplayers()[0];
		queryresult = positionquery_source_navigation(player.origin, 256, 512, 128, 20);
		if(isdefined(queryresult) && queryresult.data.size > 0)
		{
			return queryresult.data[0];
		}
		return {#origin:player.origin};
	#/
}

/*
	Name: function_fa69f8d2
	Namespace: namespace_83bc53d2
	Checksum: 0x3010F7A8
	Offset: 0x5A08
	Size: 0x36C
	Parameters: 1
	Flags: Private
*/
private function function_fa69f8d2(type)
{
	/#
		var_7a56405a = [];
		var_7a56405a[1] = #"hash_78ca8e8e6bdbc8ab";
		var_7a56405a[3] = #"hash_266b62e342076a90";
		var_7a56405a[2] = #"hash_5cfa99582cc66c59";
		var_7a56405a[4] = #"hash_5d6b55906fc82ff2";
		player = getplayers()[0];
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		var_7f972dff = undefined;
		var_16805a00 = getspawnerarray("", "");
		if(var_16805a00.size == 0)
		{
			iprintln("");
			return;
		}
		if(!isdefined(var_7a56405a[type]))
		{
			iprintln("" + type);
			return;
		}
		foreach(spawner in var_16805a00)
		{
			if(spawner.var_9fde8624 === var_7a56405a[type])
			{
				var_dc478ee7 = spawner;
				break;
			}
		}
		if(!isdefined(var_dc478ee7))
		{
			iprintln("" + var_7a56405a[type]);
			return;
		}
		var_7f972dff = zombie_utility::spawn_zombie(var_dc478ee7, undefined, var_dc478ee7);
		if(isdefined(var_7f972dff))
		{
			wait(0.5);
			var_7f972dff namespace_3fffba66::function_bbaec2fd();
			var_7f972dff forceteleport(trace[#"position"], player.angles + vectorscale((0, 1, 0), 180));
			if(var_7f972dff.var_62e81e47 == 1)
			{
				level thread function_4329a51b(var_7f972dff);
			}
		}
	#/
}

/*
	Name: function_1a0ae193
	Namespace: namespace_83bc53d2
	Checksum: 0x6E55F0C1
	Offset: 0x5D80
	Size: 0x178
	Parameters: 0
	Flags: Private
*/
private function function_1a0ae193()
{
	/#
		mapname = util::function_53bbf9d2();
		adddebugcommand("" + 1 + "");
		adddebugcommand("" + 3 + "");
		adddebugcommand("" + 2 + "");
		adddebugcommand("" + 4 + "");
		while(true)
		{
			waitframe(1);
			if(getdvarstring(#"hash_403368b958977fcb", "") != "")
			{
				function_fa69f8d2(int(getdvarstring(#"hash_403368b958977fcb")));
				setdvar(#"hash_403368b958977fcb", "");
			}
		}
	#/
}

