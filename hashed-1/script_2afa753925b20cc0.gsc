// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1b10fdf0addd52e;
#using script_1dafe158a70189fd;
#using script_1e72c148eb0b32d2;
#using script_24c32478acf44108;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_4ee0ccb42a9d88f5;
#using script_50c040e371c1c35f;
#using script_522aeb6ae906391e;
#using script_5660bae5b402a1eb;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
#using script_7c62f55ce3a557ff;
#using script_7e59d7bba853fe4b;
#using script_bd2b8aaa388dcce;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_ai_brutus;

/*
	Name: function_89f2df9
	Namespace: zm_ai_brutus
	Checksum: 0x32898D92
	Offset: 0x588
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_ai_brutus", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_brutus
	Checksum: 0xE037498C
	Offset: 0x5D8
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"brutus", &function_debbd9da);
	spawner::function_89a2cd87(#"brutus", &function_6090f71a);
	level._effect[#"brutus"] = [];
	level._effect[#"brutus"][#"lockdown_stub_type_pap"] = "maps/zm_escape/fx8_alcatraz_perk_lock";
	level._effect[#"brutus"][#"lockdown_stub_type_perks"] = "maps/zm_escape/fx8_alcatraz_perk_s_lock";
	level._effect[#"brutus"][#"lockdown_stub_type_crafting_tables"] = "maps/zm_escape/fx8_alcatraz_w_bench_lock";
	level thread aat::register_immunity("zm_aat_brain_decay", #"brutus", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"brutus", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"brutus", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"brutus", 1, 1, 1);
	clientfield::register("actor", "brutus_shock_attack", 1, 1, "counter");
	clientfield::register("actor", "brutus_spawn_clientfield", 1, 1, "int");
	clientfield::register("toplayer", "brutus_shock_attack_player", 1, 1, "counter");
	callback::on_actor_killed(&function_fc5aa54d);
	zm_cleanup::function_cdf5a512(#"brutus", &function_88efcb);
	/#
		zm_devgui::function_c7dd7a17("");
	#/
}

/*
	Name: __main__
	Namespace: zm_ai_brutus
	Checksum: 0x80F724D1
	Offset: 0x900
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_debbd9da
	Namespace: zm_ai_brutus
	Checksum: 0x7C4FAF
	Offset: 0x910
	Size: 0x23E
	Parameters: 0
	Flags: Linked
*/
function function_debbd9da()
{
	self zombie_utility::set_zombie_run_cycle("run");
	aiutility::addaioverridedamagecallback(self, &function_83a6d3ae);
	self.hashelmet = 1;
	self.var_deee6e55 = 0;
	self.var_96b5e3f1 = 0;
	self.var_71ab4927 = 0;
	self.var_905e4ce2 = self ai::function_9139c839().var_267bc182;
	self.meleedamage = self ai::function_9139c839().var_da7f4645;
	self.instakill_func = &function_eb0f90bf;
	self.var_f46fbf3f = 1;
	self.var_126d7bef = 1;
	self.var_e38eaee5 = 0;
	self.var_72411ccf = &brutustargetservice;
	self.cant_move_cb = &zombiebehavior::function_79fe956f;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self zm_powerup_nuke::function_9a79647b(0.25);
	self thread zm_audio::zmbaivox_notifyconvert();
	self thread zm_audio::play_ambient_zombie_vocals();
	self callback::function_d8abfc3d(#"hash_6f9c2499f805be2f", &function_f2f4ced8);
	if(!isdefined(self.var_9fde8624))
	{
		self attach("c_t8_zmb_mob_brutus_baton", "tag_weapon_right");
	}
	self setavoidancemask("avoid none");
	self.cant_move_cb = &function_188c83c7;
	self.var_63d2fce2 = &function_7b6e791e;
	self.ignorepathenemyfightdist = 1;
}

/*
	Name: function_7b6e791e
	Namespace: zm_ai_brutus
	Checksum: 0x34666D1E
	Offset: 0xB58
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7b6e791e()
{
	self.var_67faa700 = 0;
	self collidewithactors(1);
}

/*
	Name: function_188c83c7
	Namespace: zm_ai_brutus
	Checksum: 0x1974CEF6
	Offset: 0xB88
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_188c83c7()
{
	self endon(#"death");
	self notify(#"hash_74044076f321434a");
	self endon(#"hash_74044076f321434a");
	self clearpath();
	self collidewithactors(0);
	if(isdefined(self.var_ece4a895))
	{
		var_b378abd6 = self [[self.var_ece4a895]]();
		if(isdefined(var_b378abd6))
		{
			self.var_67faa700 = 1;
			self setgoal(var_b378abd6, 1);
		}
	}
}

/*
	Name: function_f2f4ced8
	Namespace: zm_ai_brutus
	Checksum: 0xA28D7655
	Offset: 0xC58
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_f2f4ced8()
{
	self clientfield::set("brutus_spawn_clientfield", 1);
	if(isdefined(level.var_779eb5f5) && level.var_779eb5f5)
	{
		return;
	}
	playsoundatposition(#"zmb_ai_brutus_spawn", self.origin);
	if(!isdefined(level.var_b491030) || level flag::get(#"hash_4b00aa230ebbe82b"))
	{
		self playsound(#"hash_5d69a47fd8c0e9e5");
	}
}

/*
	Name: function_c7ea6c73
	Namespace: zm_ai_brutus
	Checksum: 0xED4FCDCF
	Offset: 0xD28
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_c7ea6c73()
{
	if(!isdefined(level.brutus_last_spawn_round))
	{
		level.brutus_last_spawn_round = 0;
	}
	if(!isdefined(level.brutus_round_count))
	{
		level.brutus_round_count = 0;
	}
	if(level.round_number > level.brutus_last_spawn_round)
	{
		level.brutus_round_count++;
		level.brutus_last_spawn_round = level.round_number;
	}
}

/*
	Name: function_24c1b38f
	Namespace: zm_ai_brutus
	Checksum: 0x42562D76
	Offset: 0xDA8
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function function_24c1b38f()
{
	a_players = getplayers();
	n_player_modifier = 1;
	if(a_players.size > 1)
	{
		n_player_modifier = a_players.size * self ai::function_9139c839().var_854eebd;
	}
	var_eb6e4e3a = self ai::function_9139c839().var_544b0295 * n_player_modifier * level.brutus_round_count;
	var_eb6e4e3a = int(min(var_eb6e4e3a, self ai::function_9139c839().var_d0d2e3ce * n_player_modifier));
	return var_eb6e4e3a;
}

/*
	Name: function_6090f71a
	Namespace: zm_ai_brutus
	Checksum: 0xE4313191
	Offset: 0xEA0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_6090f71a()
{
	if(!isdefined(self.starting_health))
	{
		function_c7ea6c73();
		self.maxhealth = int(self namespace_e0710ee6::function_8d44707e(1, level.brutus_round_count) * (isdefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
		self.health = int(self namespace_e0710ee6::function_8d44707e(1, level.brutus_round_count) * (isdefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
	}
	else
	{
		self.maxhealth = self.starting_health;
		self.health = self.starting_health;
	}
	self.starting_health = undefined;
	self.explosive_dmg_req = self function_24c1b38f();
	starting_round = (isdefined(self._starting_round_number) ? self._starting_round_number : level.round_number);
	ai::set_behavior_attribute("can_ground_slam", starting_round > self ai::function_9139c839().var_af3fff17);
}

/*
	Name: function_fc5aa54d
	Namespace: zm_ai_brutus
	Checksum: 0xC99D4D35
	Offset: 0x1030
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_fc5aa54d(params)
{
	if(self.archetype !== #"brutus")
	{
		return;
	}
	self clientfield::set("brutus_spawn_clientfield", 0);
	playsoundatposition(#"zmb_ai_brutus_death", self.origin);
	self destructserverutils::togglespawngibs(self, 1);
	self destructserverutils::function_629a8d54(self, "tag_weapon_right");
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: zm_ai_brutus
	Checksum: 0xAEAE119A
	Offset: 0x10E8
	Size: 0x494
	Parameters: 0
	Flags: Linked, Private
*/
private function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_fbb311db));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68d081058095794", &function_fbb311db);
	/#
		assert(isscriptfunctionptr(&function_3006441d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_df1d28cebbb75f6", &function_3006441d);
	/#
		assert(isscriptfunctionptr(&function_3bda3c55));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d8653062b32a601", &function_3bda3c55);
	/#
		assert(isscriptfunctionptr(&function_20fa0d4c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_691307470629f20e", &function_20fa0d4c);
	/#
		assert(isscriptfunctionptr(&function_3536f675));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_526dcca6d6d76bfe", &function_3536f675);
	/#
		assert(isscriptfunctionptr(&function_ebaa334b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4ba406776e5d28c3", &function_ebaa334b);
	/#
		assert(isscriptfunctionptr(&function_4ec678fe));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643443bf9243e4ff", &function_4ec678fe);
	/#
		assert(isscriptfunctionptr(&function_f4a61e6a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5800441474109ca6", &function_f4a61e6a);
	animationstatenetwork::registernotetrackhandlerfunction("hit_ground", &function_85e8940a);
	animationstatenetwork::registernotetrackhandlerfunction("locked", &function_ebaa334b);
	animationstatenetwork::registeranimationmocomp("mocomp_purchase_lockdown@brutus", &function_14ed6be, undefined, undefined);
	/#
		assert(isscriptfunctionptr(&function_3c3e6f4a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1ba2ab8d76e1cd9b", &function_3c3e6f4a);
	/#
		assert(isscriptfunctionptr(&function_eb1f805));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_cc119947efb49cf", &function_eb1f805);
}

/*
	Name: function_943e4c08
	Namespace: zm_ai_brutus
	Checksum: 0xCF681549
	Offset: 0x1588
	Size: 0x1F2
	Parameters: 2
	Flags: Linked, Private
*/
private function function_943e4c08(entity, minplayerdist)
{
	playerpositions = [];
	foreach(player in getplayers())
	{
		if(!isdefined(playerpositions))
		{
			playerpositions = [];
		}
		else if(!isarray(playerpositions))
		{
			playerpositions = array(playerpositions);
		}
		if(!isinarray(playerpositions, (isdefined(player.last_valid_position) ? player.last_valid_position : player.origin)))
		{
			playerpositions[playerpositions.size] = (isdefined(player.last_valid_position) ? player.last_valid_position : player.origin);
		}
	}
	var_6f59ec8b = getclosestpointonnavmesh(entity.origin, entity getpathfindingradius());
	if(isdefined(var_6f59ec8b))
	{
		var_f67d1ba2 = generatenavmeshpath(var_6f59ec8b, playerpositions, entity);
		if(isdefined(var_f67d1ba2) && var_f67d1ba2.status === "succeeded" && var_f67d1ba2.pathdistance < minplayerdist)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: brutustargetservice
	Namespace: zm_ai_brutus
	Checksum: 0xD3EDEBC6
	Offset: 0x1788
	Size: 0x392
	Parameters: 1
	Flags: Linked, Private
*/
private function brutustargetservice(entity)
{
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
	entity.favoriteenemy = entity.var_93a62fe;
	if(!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity))
	{
		zone = zm_utility::get_current_zone();
		if(isdefined(zone))
		{
			wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
			if(isdefined(wait_locations) && wait_locations.size > 0)
			{
				entity zm_utility::function_64259898(wait_locations[0].origin, 200);
				return 1;
			}
		}
		entity setgoal(entity.origin);
		return 1;
	}
	/#
		namespace_cb42c6c0::function_f3cff6ff(entity);
	#/
	if(!isdefined(entity.var_722a34a3))
	{
		entity.var_52e3b294 = undefined;
		pointofinterest = entity zm_utility::get_zombie_point_of_interest(entity.origin);
		if(isdefined(pointofinterest) && pointofinterest.size > 0)
		{
			foreach(poi in pointofinterest)
			{
				if(isdefined(poi) && isentity(poi) && isdefined(poi.classname) && poi.classname == "grenade")
				{
					goalpos = getclosestpointonnavmesh(poi.origin, 10, self getpathfindingradius());
					if(isdefined(goalpos))
					{
						entity.var_722a34a3 = poi;
						entity.var_52e3b294 = goalpos;
					}
				}
			}
		}
	}
	if(isdefined(entity.var_52e3b294) && entity zm_utility::function_64259898(entity.var_52e3b294))
	{
		return 1;
	}
	if(isdefined(entity.var_d646708c))
	{
		entity function_a57c34b7(entity.var_d646708c);
		return 1;
	}
	goalent = entity.favoriteenemy;
	if(isplayer(goalent))
	{
		goalent = namespace_e0710ee6::function_a2e8fd7b(entity, entity.favoriteenemy);
	}
	return entity zm_utility::function_64259898(goalent.origin);
}

/*
	Name: function_3c3e6f4a
	Namespace: zm_ai_brutus
	Checksum: 0x91253EC8
	Offset: 0x1B28
	Size: 0x500
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3c3e6f4a(entity)
{
	var_65ba9602 = namespace_cb42c6c0::function_87c1193e(entity);
	if(isdefined(entity.var_722a34a3) || !isdefined(var_65ba9602) || !namespace_cb42c6c0::function_c9105448(entity, var_65ba9602))
	{
		namespace_cb42c6c0::function_77caff8b(var_65ba9602);
		entity.var_d646708c = undefined;
	}
	if(isdefined(entity.var_722a34a3) || isdefined(var_65ba9602))
	{
		return;
	}
	if(entity.var_e38eaee5 > gettime())
	{
		return 0;
	}
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		return 0;
	}
	if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area"))
	{
		entity.var_d646708c = undefined;
		return 0;
	}
	/#
		namespace_cb42c6c0::function_f3cff6ff(entity);
	#/
	var_c0c93f86 = [];
	array::add(var_c0c93f86, "lockdown_stub_type_crafting_tables");
	array::add(var_c0c93f86, "lockdown_stub_type_perks");
	array::add(var_c0c93f86, "lockdown_stub_type_pap");
	array::add(var_c0c93f86, "lockdown_stub_type_magic_box");
	array::add(var_c0c93f86, "lockdown_stub_type_boards");
	array::add(var_c0c93f86, "lockdown_stub_type_traps");
	registerlotus_right = namespace_cb42c6c0::function_9b84bb88(entity, var_c0c93f86, entity ai::function_9139c839().var_58b424ec, entity ai::function_9139c839().var_e81712d);
	entity.var_e38eaee5 = gettime() + 500;
	if(registerlotus_right.size == 0)
	{
		return 0;
	}
	stub = registerlotus_right[0];
	if(!function_943e4c08(entity, entity ai::function_9139c839().var_78a5f50))
	{
		/#
			namespace_cb42c6c0::function_78eae22a(entity, stub, 9);
		#/
		return 0;
	}
	var_801b2d64 = undefined;
	var_f1591c10 = namespace_cb42c6c0::function_dab6d796(entity, stub);
	if(!isdefined(var_f1591c10))
	{
		var_7162cf15 = zm_utility::function_b0eeaada(stub.origin);
		halfheight = 32;
		if(!isdefined(var_7162cf15))
		{
			var_7162cf15 = [];
			var_7162cf15[#"point"] = stub.origin;
			halfheight = stub.origin - zm_utility::groundpos(stub.origin)[2] + 1;
		}
		var_239124a9 = positionquery_source_navigation(var_7162cf15[#"point"], 0, 256, halfheight, 20, 1);
		if(var_239124a9.data.size == 0)
		{
			return 0;
		}
		var_801b2d64 = var_239124a9.data[0].origin;
	}
	else
	{
		var_801b2d64 = getclosestpointonnavmesh(var_f1591c10.origin, 200, 24);
	}
	if(!isdefined(var_801b2d64))
	{
		return 0;
	}
	entity.var_d646708c = var_801b2d64;
	namespace_cb42c6c0::function_50ba1eb0(entity, stub);
	entity setblackboardattribute("_lockdown_type", namespace_cb42c6c0::function_22aeb4e9(stub.var_895b6b));
	/#
		namespace_cb42c6c0::function_f3cff6ff(entity);
	#/
	return 1;
}

/*
	Name: function_eb1f805
	Namespace: zm_ai_brutus
	Checksum: 0x1E1C14EE
	Offset: 0x2030
	Size: 0x1D0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_eb1f805(entity)
{
	velocity = entity getvelocity();
	velocitymag = length(velocity);
	predicttime = 0.2;
	movevector = velocity * predicttime;
	predictedpos = entity.origin + movevector;
	var_a5a1f99c = getaiarchetypearray(#"zombie");
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"catalyst"), 0, 0);
	var_86476d47 = array::filter(var_a5a1f99c, 0, &namespace_9ff9f642::function_865a83f8, entity, predictedpos, ai::function_9139c839().var_b7366094);
	if(var_86476d47.size > 0)
	{
		foreach(zombie in var_86476d47)
		{
			zombie zombie_utility::function_fc0cb93d(entity);
		}
	}
}

/*
	Name: function_3006441d
	Namespace: zm_ai_brutus
	Checksum: 0xA2B4BFA0
	Offset: 0x2208
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3006441d(entity)
{
	if(!isdefined(entity.var_722a34a3) || !isdefined(entity.var_52e3b294) || distancesquared(entity.var_52e3b294, entity.origin) > 10 * 10)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_4ec678fe
	Namespace: zm_ai_brutus
	Checksum: 0x91F88588
	Offset: 0x2288
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4ec678fe(entity)
{
	if(!isdefined(entity.var_722a34a3))
	{
		return;
	}
	monkeybomb = entity.var_722a34a3;
	level notify(#"hash_79c0225ea09cd215", {#hash_569d804d:monkeybomb.angles, #hash_cee6bd0b:monkeybomb.origin, #brutus:self});
	if(isdefined(monkeybomb.damagearea))
	{
		monkeybomb.damagearea delete();
	}
	monkeybomb delete();
}

/*
	Name: function_20fa0d4c
	Namespace: zm_ai_brutus
	Checksum: 0x70D6C5B
	Offset: 0x2368
	Size: 0x2AE
	Parameters: 1
	Flags: Linked
*/
function function_20fa0d4c(entity)
{
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.marked_for_death))
	{
		return 0;
	}
	if(isdefined(entity.ignoremelee) && entity.ignoremelee)
	{
		return 0;
	}
	if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64)
	{
		return 0;
	}
	if(isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone)
	{
		meleedistsq = entity.meleeweapon.var_d3cafde6 * entity.meleeweapon.var_d3cafde6;
	}
	if(!isdefined(meleedistsq))
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq)
	{
		return 0;
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	if(!entity cansee(entity.enemy))
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) < 40 * 40)
	{
		return 1;
	}
	if(!tracepassedonnavmesh(entity.origin, (isdefined(entity.enemy.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin), entity getpathfindingradius()))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_3536f675
	Namespace: zm_ai_brutus
	Checksum: 0x6C485D90
	Offset: 0x2620
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3536f675(entity)
{
	return entity ai::has_behavior_attribute("scripted_mode") && entity ai::get_behavior_attribute("scripted_mode") === 1;
}

/*
	Name: function_3bda3c55
	Namespace: zm_ai_brutus
	Checksum: 0xECE71865
	Offset: 0x2680
	Size: 0x140
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3bda3c55(entity)
{
	if(!entity ai::get_behavior_attribute("can_ground_slam"))
	{
		return 0;
	}
	if(entity.var_96b5e3f1 > gettime())
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(!(isdefined(entity.favoriteenemy.am_i_valid) && entity.favoriteenemy.am_i_valid))
	{
		return 0;
	}
	if(abs(entity.origin[2] - entity.favoriteenemy.origin[2]) > 72)
	{
		return 0;
	}
	if(distance2dsquared(entity.origin, entity.favoriteenemy.origin) > entity ai::function_9139c839().var_b4c77cfb * entity ai::function_9139c839().var_b4c77cfb)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_f4a61e6a
	Namespace: zm_ai_brutus
	Checksum: 0x7DE46A4E
	Offset: 0x27C8
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f4a61e6a(entity)
{
	entity.var_96b5e3f1 = gettime() + int(entity ai::function_9139c839().var_d5427206 * 1000);
}

/*
	Name: function_85e8940a
	Namespace: zm_ai_brutus
	Checksum: 0x3DDCF9B9
	Offset: 0x2820
	Size: 0x3A0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_85e8940a(entity)
{
	players = getplayers();
	zombies = getaiteamarray(level.zombie_team);
	ents = arraycombine(players, zombies, 0, 0);
	ents = arraysortclosest(ents, entity.origin, undefined, 0, entity ai::function_9139c839().var_1709a39);
	var_5b857980 = function_4d1e7b48(#"hash_19533caf858a9f3b");
	entity clientfield::increment("brutus_shock_attack", 1);
	level notify(#"hash_7a4ba7676000c3c6", {#brutus:self});
	foreach(ent in ents)
	{
		if(isplayer(ent))
		{
			if(!zombie_utility::is_player_valid(ent, 0, 0))
			{
				continue;
			}
			if(!bullettracepassed(entity.origin, ent gettagorigin("j_spine4"), 0, entity, ent))
			{
				continue;
			}
			damage = mapfloat(entity getpathfindingradius() + 15, entity ai::function_9139c839().var_1709a39, entity ai::function_9139c839().var_7ea758e1, 0, distance(entity.origin, ent.origin));
			damage = int(max(10, damage));
			ent dodamage(damage, entity.origin, entity, entity, "none");
			ent status_effect::status_effect_apply(var_5b857980, undefined, self, 0);
			ent clientfield::increment_to_player("brutus_shock_attack_player", 1);
			continue;
		}
		if(isai(ent))
		{
			if(ent.var_6f84b820 === #"basic")
			{
				ent zombie_utility::setup_zombie_knockdown(entity);
			}
		}
	}
}

/*
	Name: function_fbb311db
	Namespace: zm_ai_brutus
	Checksum: 0xE67D3554
	Offset: 0x2BC8
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_fbb311db(entity)
{
	if(!isdefined(entity.var_d646708c) || !namespace_cb42c6c0::function_7bfa8895(entity))
	{
		return 0;
	}
	if(distancesquared(entity.var_d646708c, entity.origin) > entity ai::function_9139c839().var_98d0b358 * entity ai::function_9139c839().var_98d0b358)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c1844128
	Namespace: zm_ai_brutus
	Checksum: 0xC70F218F
	Offset: 0x2C70
	Size: 0x112
	Parameters: 1
	Flags: Linked
*/
function function_c1844128(player)
{
	if(zm_utility::is_standard())
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_43bfefdaa25b6b9c");
		}
		else
		{
			self sethintstring(#"hash_41048087f44fc9b0");
		}
	}
	else if(function_8b1a219a())
	{
		self sethintstring(#"hash_451dc9a0469e39ff", self.stub.var_534571f);
	}
	else
	{
		self sethintstring(#"hash_5bdb56428055a4c1", self.stub.var_534571f);
	}
	return namespace_cb42c6c0::function_b5dd9241(self.stub);
}

/*
	Name: function_30afd2be
	Namespace: zm_ai_brutus
	Checksum: 0x219B7467
	Offset: 0x2D90
	Size: 0x140
	Parameters: 2
	Flags: Linked, Private
*/
private function function_30afd2be(type, stub)
{
	if(!isdefined(stub.var_50a8d231))
	{
		stub.var_50a8d231 = 0;
	}
	var_b8576908 = 2000;
	switch(type)
	{
		case "lockdown_stub_type_crafting_tables":
		{
			var_491c5d62 = 1;
			break;
		}
		case "lockdown_stub_type_magic_box":
		{
			var_491c5d62 = 1;
			break;
		}
		case "lockdown_stub_type_pap":
		{
			var_491c5d62 = 3;
			break;
		}
		case "lockdown_stub_type_perks":
		{
			var_491c5d62 = 3;
			break;
		}
		default:
		{
			var_491c5d62 = 1;
			break;
		}
	}
	stub.var_50a8d231 = int(min(stub.var_50a8d231 + 1, var_491c5d62));
	return var_b8576908 * stub.var_50a8d231;
}

/*
	Name: function_32551326
	Namespace: zm_ai_brutus
	Checksum: 0x508ECCB9
	Offset: 0x2ED8
	Size: 0x1C0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_32551326()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(!isdefined(waitresult.activator) || !zm_utility::is_player_valid(waitresult.activator) || (isdefined(self.stub) && (isdefined(self.stub.var_6156031a) && self.stub.var_6156031a)))
		{
			continue;
		}
		player = waitresult.activator;
		if(!player zm_score::can_player_purchase(self.stub.var_534571f))
		{
			continue;
		}
		player zm_score::minus_to_player_score(self.stub.var_534571f);
		level notify(#"hash_6a9b254ddc7d0e93", {#s_stub:self.stub});
		if(!isdefined(self.stub.var_6f08706b))
		{
			if(self.stub.var_895b6b == "lockdown_stub_type_magic_box")
			{
				self.stub.trigger_target.zbarrier thread zm_magicbox::set_magic_box_zbarrier_state("unlocking");
			}
		}
		self.stub thread namespace_cb42c6c0::function_61a9bc58();
	}
}

/*
	Name: function_ebaa334b
	Namespace: zm_ai_brutus
	Checksum: 0x856ED5B5
	Offset: 0x30A0
	Size: 0x194
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ebaa334b(entity)
{
	stub = namespace_cb42c6c0::function_87c1193e(entity);
	if(isdefined(stub))
	{
		if(!namespace_cb42c6c0::function_c9105448(entity, stub))
		{
			namespace_cb42c6c0::function_77caff8b(stub);
			entity.var_d646708c = undefined;
			return;
		}
		if(stub.var_895b6b == "lockdown_stub_type_magic_box")
		{
			stub.trigger_target.zbarrier zm_magicbox::set_magic_box_zbarrier_state("locking");
		}
		if(isdefined(stub.var_895b6b))
		{
			var_80f22b97 = function_30afd2be(stub.var_895b6b, stub);
		}
		else
		{
			var_80f22b97 = 2000;
		}
		stub.var_534571f = var_80f22b97;
		level notify(#"hash_1f4ca5309de396c3", {#s_stub:stub});
		namespace_cb42c6c0::function_7258b5cc(entity, &function_c1844128, &function_32551326);
		entity setblackboardattribute("_lockdown_type", "INVALID");
	}
}

/*
	Name: function_14ed6be
	Namespace: zm_ai_brutus
	Checksum: 0x1AFDCA79
	Offset: 0x3240
	Size: 0x7C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_14ed6be(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	stub = namespace_cb42c6c0::function_87c1193e(entity);
	if(isdefined(stub))
	{
		entity orientmode("face point", stub.origin);
	}
}

/*
	Name: function_97f51aa3
	Namespace: zm_ai_brutus
	Checksum: 0xF807DFC4
	Offset: 0x32C8
	Size: 0x62
	Parameters: 1
	Flags: Linked, Private
*/
private function function_97f51aa3(v_org)
{
	grenade = self magicgrenadetype(getweapon(#"willy_pete"), v_org, (0, 0, 0), 0.4);
	grenade.owner = self;
}

/*
	Name: function_530c54e3
	Namespace: zm_ai_brutus
	Checksum: 0xA3D43D6E
	Offset: 0x3338
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_530c54e3()
{
	self.hashelmet = 0;
	self zombie_utility::set_zombie_run_cycle("sprint");
	self.var_71ab4927 = gettime() + int(self ai::function_9139c839().var_d463e760 * 1000);
	destructserverutils::function_9885f550(self, "helmet");
	self playsound(#"evt_brutus_helmet");
	self thread zm_audio::zmbaivox_playvox(self, "roar", 1, 3);
	if(isalive(self))
	{
		function_97f51aa3(self gettagorigin("TAG_WEAPON_LEFT"));
		function_97f51aa3(self gettagorigin("TAG_WEAPON_RIGHT"));
		if(math::cointoss(50))
		{
			level thread smoke_vo(self.origin);
		}
	}
}

/*
	Name: smoke_vo
	Namespace: zm_ai_brutus
	Checksum: 0x4745004D
	Offset: 0x34C8
	Size: 0x148
	Parameters: 1
	Flags: Linked
*/
function smoke_vo(v_pos)
{
	var_55c47118 = spawn("trigger_radius", v_pos, 0, 200, 80);
	var_55c47118 endon(#"death");
	var_55c47118 thread function_9a4a6d02();
	while(true)
	{
		waitresult = undefined;
		waitresult = var_55c47118 waittill(#"trigger");
		if(isplayer(waitresult.activator))
		{
			b_played = waitresult.activator zm_audio::create_and_play_dialog(#"brutus", #"hash_ab5f4c79d856526");
			if(isdefined(b_played) && b_played)
			{
				var_55c47118 notify(#"hash_617485dc39ba3f5e");
			}
		}
		wait(randomfloatrange(0.6666666, 1.333333));
	}
}

/*
	Name: function_9a4a6d02
	Namespace: zm_ai_brutus
	Checksum: 0xE7FCDCDC
	Offset: 0x3618
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_9a4a6d02()
{
	self waittill_timeout(20, #"hash_617485dc39ba3f5e");
	self delete();
}

/*
	Name: function_55bb9c72
	Namespace: zm_ai_brutus
	Checksum: 0xBCAE5D0E
	Offset: 0x3658
	Size: 0x242
	Parameters: 6
	Flags: Linked, Private
*/
private function function_55bb9c72(attacker, damage, weapon, var_81dcad68, damagemultiplier, damageoverride)
{
	if(!(isdefined(self.hashelmet) && self.hashelmet))
	{
		if(isdefined(attacker) && isplayer(attacker) && attacker hasperk(#"hash_6afc24062d2515a2"))
		{
			if(self.var_6f84b820 === #"boss")
			{
				damage = damage * 1.1;
			}
			else
			{
				damage = damage * 1.2;
			}
		}
		return damage * (damageoverride ? damagemultiplier : var_81dcad68);
	}
	if(weaponhasattachment(weapon, "fmj2"))
	{
		if(self.var_6f84b820 === #"boss")
		{
			damagemultiplier = damagemultiplier * 1.1;
		}
		else
		{
			damagemultiplier = min(1, damagemultiplier + 0.1);
		}
	}
	self.var_deee6e55++;
	if(self.var_deee6e55 >= self.var_905e4ce2)
	{
		self function_530c54e3();
		if(isdefined(attacker) && isplayer(attacker) && isdefined(level.brutus_points_for_helmet))
		{
			attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
			attacker notify(#"hash_1413599b710f10bd");
		}
	}
	return damage * damagemultiplier;
}

/*
	Name: function_83a6d3ae
	Namespace: zm_ai_brutus
	Checksum: 0x4FDEA8EB
	Offset: 0x38A8
	Size: 0x42A
	Parameters: 11
	Flags: Linked, Private
*/
private function function_83a6d3ae(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex)
{
	var_9000ab2 = (isdefined(level.brutus_damage_percent) ? level.brutus_damage_percent : 0.1);
	var_127e9e7d = 1.5;
	var_81dcad68 = 1;
	if(self.var_71ab4927 > gettime())
	{
		if(isplayer(attacker))
		{
			attacker util::show_hit_marker();
		}
		return 0;
	}
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex, shitloc, vpoint);
	var_9000ab2 = var_786d7e06.damage_scale;
	var_58640bc4 = self namespace_e0710ee6::function_94d76123(weapon);
	if(isdefined(attacker) && isalive(attacker) && isplayer(attacker) && attacker zm_powerups::is_insta_kill_active())
	{
		var_81dcad68 = 2;
	}
	if(isdefined(weapon) && weapon.weapclass == "spread")
	{
		var_9000ab2 = var_9000ab2 * var_127e9e7d;
		var_81dcad68 = var_81dcad68 * var_127e9e7d;
	}
	if(zm_utility::is_explosive_damage(meansofdeath))
	{
		if(!isdefined(self.var_e24f0ce1))
		{
			self.var_e24f0ce1 = 0;
		}
		self.var_e24f0ce1 = self.var_e24f0ce1 + damage;
		scaler = var_9000ab2;
		if(self.var_e24f0ce1 >= self.explosive_dmg_req && (isdefined(self.hashelmet) && self.hashelmet))
		{
			self function_530c54e3();
			if(isdefined(attacker) && isplayer(attacker) && isdefined(level.brutus_points_for_helmet))
			{
				attacker zm_score::add_to_player_score(zm_score::get_points_multiplier(attacker) * zm_utility::round_up_score(level.brutus_points_for_helmet, 5));
				attacker notify(#"hash_1413599b710f10bd");
			}
		}
		return damage * scaler;
	}
	if(shitloc !== "head" && shitloc !== "helmet")
	{
		if(weaponhasattachment(weapon, "fmj") && var_9000ab2 < 1)
		{
			if(self.var_6f84b820 == #"boss")
			{
				var_9000ab2 = var_9000ab2 * 1.1;
			}
			else
			{
				var_9000ab2 = min(1, var_9000ab2 + 0.1);
			}
		}
		return damage * var_9000ab2;
	}
	return int(self function_55bb9c72(attacker, damage, weapon, var_81dcad68, var_9000ab2, var_58640bc4));
}

/*
	Name: function_eb0f90bf
	Namespace: zm_ai_brutus
	Checksum: 0x640F2CE6
	Offset: 0x3CE0
	Size: 0x40
	Parameters: 3
	Flags: Linked
*/
function function_eb0f90bf(player, mod, shitloc)
{
	if(self.archetype === #"brutus")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_88efcb
	Namespace: zm_ai_brutus
	Checksum: 0x21CAC9EE
	Offset: 0x3D28
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_88efcb()
{
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		return 1;
	}
	if(isdefined(level.var_f47ae5da))
	{
		s_spawn_loc = [[level.var_f47ae5da]]();
	}
	else if(level.zm_loc_types[#"brutus_location"].size > 0)
	{
		s_spawn_loc = namespace_961cf978::get_best_brutus_spawn_pos();
	}
	if(!isdefined(s_spawn_loc))
	{
		return 1;
	}
	var_38007f6f = namespace_cb42c6c0::function_87c1193e(self);
	if(isdefined(var_38007f6f) && namespace_cb42c6c0::function_c9105448(self, var_38007f6f))
	{
		namespace_cb42c6c0::function_77caff8b(var_38007f6f);
		self.var_d646708c = undefined;
	}
	self namespace_e0710ee6::function_a8dc3363(s_spawn_loc);
	if(isdefined(self))
	{
		self thread namespace_961cf978::brutus_lockdown_client_effects();
		self playsound(#"zmb_ai_brutus_spawn_2d");
	}
	return 1;
}

