// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_178024232e91b0a1;
#using script_2c5daa95f8fec03c;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_48853aeba204de7c;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_52a84b3d20788c6;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
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
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
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
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_c49f9e2b;

/*
	Name: function_89f2df9
	Namespace: namespace_c49f9e2b
	Checksum: 0x605DBC29
	Offset: 0x738
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_770f240f9e25a58d", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c49f9e2b
	Checksum: 0x47DB280E
	Offset: 0x788
	Size: 0x2D4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"gladiator", &function_5b145800);
	registerbehaviorscriptfunctions();
	zm_player::register_player_damage_callback(&function_83ac16b5);
	namespace_ec52743e::registergladiatorinterfaceattributes();
	spawner::add_archetype_spawn_function(#"gladiator", &function_caed4d61);
	clientfield::register("toplayer", "gladiator_melee_effect", 1, 1, "counter");
	clientfield::register("actor", "gladiator_arm_effect", 1, 2, "int");
	clientfield::register("scriptmover", "gladiator_axe_effect", 1, 1, "int");
	level thread aat::register_immunity("zm_aat_brain_decay", #"gladiator", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"gladiator", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"gladiator", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"gladiator", 1, 1, 1);
	/#
		if(isarchetypeloaded(#"gladiator"))
		{
			level thread function_24a38427();
		}
		spawner::add_archetype_spawn_function(#"gladiator", &zombie_utility::function_27ba8249);
	#/
	animationstatenetwork::registernotetrackhandlerfunction("dropgun_left", &function_ce148f14);
	animationstatenetwork::registernotetrackhandlerfunction("dropgun_right", &function_80a0580b);
}

/*
	Name: function_ce148f14
	Namespace: namespace_c49f9e2b
	Checksum: 0x9F9EF4E0
	Offset: 0xA68
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_ce148f14(entity)
{
	if(isdefined(self.var_fe593357) && self.var_fe593357)
	{
		destructserverutils::function_9885f550(entity, "left_hand", "tag_weapon_left");
	}
}

/*
	Name: function_80a0580b
	Namespace: namespace_c49f9e2b
	Checksum: 0xBD191EBB
	Offset: 0xAC0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_80a0580b(entity)
{
	if(isdefined(self.var_88d88318) && self.var_88d88318)
	{
		destructserverutils::function_9885f550(entity, "right_hand", "tag_weapon_right");
	}
}

/*
	Name: __main__
	Namespace: namespace_c49f9e2b
	Checksum: 0x80F724D1
	Offset: 0xB18
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_5b145800
	Namespace: namespace_c49f9e2b
	Checksum: 0x52921DC5
	Offset: 0xB28
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_5b145800()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_a19a24bf;
}

/*
	Name: function_a19a24bf
	Namespace: namespace_c49f9e2b
	Checksum: 0x67761A11
	Offset: 0xB80
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a19a24bf(entity)
{
	entity.__blackboard = undefined;
	entity function_5b145800();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_c49f9e2b
	Checksum: 0x4C5BE1D
	Offset: 0xBB8
	Size: 0xEE4
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&gladiatortargetservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"gladiatortargetservice", &gladiatortargetservice);
	/#
		assert(isscriptfunctionptr(&function_4f73587a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2f31066d04316712", &function_4f73587a);
	/#
		assert(isscriptfunctionptr(&function_4660925e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_19f5dddb53541f2f", &function_4660925e);
	/#
		assert(isscriptfunctionptr(&function_edd0777f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d538371b59fc4ce", &function_edd0777f);
	/#
		assert(isscriptfunctionptr(&function_154454e8));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_205614b8bf4014e6", &function_154454e8);
	/#
		assert(isscriptfunctionptr(&function_154454e8));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_205614b8bf4014e6", &function_154454e8);
	/#
		assert(isscriptfunctionptr(&function_2b6f49c8));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_48c3fc4eec7605", &function_2b6f49c8);
	/#
		assert(isscriptfunctionptr(&function_2b6f49c8));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_48c3fc4eec7605", &function_2b6f49c8);
	/#
		assert(isscriptfunctionptr(&function_d2ab62ae));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4aefcc750ed27716", &function_d2ab62ae);
	/#
		assert(isscriptfunctionptr(&function_a3329afd));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e62e0f93339aad3", &function_a3329afd);
	/#
		assert(isscriptfunctionptr(&function_13f886a2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4038d6d7b731c1de", &function_13f886a2);
	/#
		assert(isscriptfunctionptr(&function_61e7d5f5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d96f193711e7602", &function_61e7d5f5);
	/#
		assert(isscriptfunctionptr(&function_6bbfa1a0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_753bdf09b9b21d9a", &function_6bbfa1a0);
	/#
		assert(isscriptfunctionptr(&function_dd674e3c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_649ab6146cce9955", &function_dd674e3c);
	/#
		assert(isscriptfunctionptr(&function_7468904d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_19966227fe912af8", &function_7468904d);
	/#
		assert(isscriptfunctionptr(&function_a7bbb8e4));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_359e69141220779c", &function_a7bbb8e4);
	/#
		assert(isscriptfunctionptr(&function_c1b97472));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5934d511f3d43e76", &function_c1b97472);
	/#
		assert(isscriptfunctionptr(&function_fe0ecd9f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7114ad7e891644ce", &function_fe0ecd9f);
	/#
		assert(isscriptfunctionptr(&function_ceea5a43));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e4e8836668c7ddd", &function_ceea5a43);
	/#
		assert(isscriptfunctionptr(&function_ceea5a43));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3e4e8836668c7ddd", &function_ceea5a43);
	/#
		assert(isscriptfunctionptr(&function_7891bd9b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ec3db12905e5ef2", &function_7891bd9b);
	/#
		assert(isscriptfunctionptr(&function_490a290d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_324b5266aa732357", &function_490a290d);
	/#
		assert(isscriptfunctionptr(&function_6719445a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7a99cf7ed75b85d4", &function_6719445a);
	/#
		assert(isscriptfunctionptr(&function_fced00e1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_84d084fea1afb67", &function_fced00e1);
	/#
		assert(isscriptfunctionptr(&function_3963581d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72578a0bdaf6cabc", &function_3963581d);
	/#
		assert(isscriptfunctionptr(&function_dfbf9d5e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1c6cfcf6fdb404ff", &function_dfbf9d5e);
	/#
		assert(isscriptfunctionptr(&function_8d49edfa));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50e5d4b2634f5877", &function_8d49edfa);
	/#
		assert(isscriptfunctionptr(&function_990c9627));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_52aa25564f02b9a1", &function_990c9627);
	/#
		assert(isscriptfunctionptr(&function_6ba071ff));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d6fdeb321d8ce80", &function_6ba071ff);
	/#
		assert(isscriptfunctionptr(&function_3ca98f5a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed731cb43b72ab7", &function_3ca98f5a);
	/#
		assert(isscriptfunctionptr(&function_e217245a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_51d4a260f5e68d32", &function_e217245a);
	/#
		assert(isscriptfunctionptr(&function_c6c44df1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3378ea427701f557", &function_c6c44df1);
	/#
		assert(isscriptfunctionptr(&function_c6c44df1));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3378ea427701f557", &function_c6c44df1);
	animationstatenetwork::registeranimationmocomp("mocomp_gladiator_leap", &registerhud_message_electricity_, &function_3f15e557, &function_96f1cbf6);
	animationstatenetwork::registeranimationmocomp("mocomp_gladiator_throw", &function_3137174f, &function_64cd870, &function_d9e4ebc8);
	animationstatenetwork::registeranimationmocomp("mocomp_gladiator_run_melee", &function_37d33f09, &function_3f7c46a, &function_2bc1ffb8);
	animationstatenetwork::registernotetrackhandlerfunction("gladiator_melee", &function_cdef55f0);
	animationstatenetwork::registernotetrackhandlerfunction("axe_throw_start", &function_f3c02dbf);
	animationstatenetwork::registernotetrackhandlerfunction("axe_reload", &function_14ff2d78);
	animationstatenetwork::registernotetrackhandlerfunction("detach_limb", &function_894d3d57);
}

/*
	Name: function_83ac16b5
	Namespace: namespace_c49f9e2b
	Checksum: 0x65227606
	Offset: 0x1AA8
	Size: 0x130
	Parameters: 10
	Flags: Linked, Private
*/
private function function_83ac16b5(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && isai(eattacker) && eattacker.archetype == #"gladiator" && eattacker.team != self.team)
	{
		if(eattacker ai::has_behavior_attribute("damage_multiplier"))
		{
			damage_multiplier = eattacker ai::get_behavior_attribute("damage_multiplier");
			if(damage_multiplier != 1)
			{
				damage_mod = idamage * damage_multiplier;
				return damage_mod;
			}
		}
	}
	return -1;
}

/*
	Name: gladiatortargetservice
	Namespace: namespace_c49f9e2b
	Checksum: 0x9D0EAC14
	Offset: 0x1BE0
	Size: 0x672
	Parameters: 1
	Flags: Linked, Private
*/
private function gladiatortargetservice(entity)
{
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
	/#
		if(isdefined(entity.ispuppet) && entity.ispuppet)
		{
			return 0;
		}
	#/
	entity.zombie_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
	entity zombie_utility::run_ignore_player_handler();
	if(isdefined(entity.var_4f1b8d2b) && entity.var_4f1b8d2b && isdefined(entity.favoriteenemy) && isplayer(entity.favoriteenemy) && !isdefined(zm_zonemgr::function_54fc7938(entity.favoriteenemy, entity)))
	{
		entity.var_4f1b8d2b = 0;
	}
	if(entity.var_9fde8624 == #"gladiator_marauder" && (!(isdefined(entity.var_4f1b8d2b) && entity.var_4f1b8d2b)))
	{
		entity.favoriteenemy = entity.var_93a62fe;
	}
	else if(entity.var_9fde8624 == #"gladiator_destroyer")
	{
		entity.favoriteenemy = entity.var_93a62fe;
	}
	if(isdefined(entity.zombie_poi) && isdefined(entity.zombie_poi[1]))
	{
		goalpos = entity.zombie_poi[0];
		return entity zm_utility::function_64259898(goalpos);
	}
	if(!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity))
	{
		zone = zm_utility::get_current_zone();
		if(isdefined(zone))
		{
			wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
			if(isdefined(wait_locations) && wait_locations.size > 0)
			{
				return zm_utility::function_64259898(wait_locations[0].origin);
			}
		}
		entity setgoal(entity.origin);
		return 0;
	}
	/#
		if(entity.favoriteenemy isnotarget())
		{
			entity setgoal(entity.origin);
			return 0;
		}
	#/
	if(!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy))
	{
		if(entity cansee(entity.favoriteenemy) || isdefined(entity.var_cb89528d))
		{
			entity.var_cb89528d = undefined;
			entity.hasseenfavoriteenemy = 1;
			entity.var_908a5d30 = 1;
			if(entity.var_9fde8624 == #"gladiator_destroyer")
			{
				entity setblackboardattribute("_gladiator_react", "idle");
				if(entity haspath())
				{
					entity setblackboardattribute("_gladiator_react", "walk");
				}
			}
			else
			{
				var_2ddabcd3 = anglestoforward(entity.angles);
				var_2ddabcd3 = (var_2ddabcd3[0], var_2ddabcd3[1], 0);
				gladiator_right = anglestoright(entity.angles);
				gladiator_right = (gladiator_right[0], gladiator_right[1], 0);
				to_enemy = entity.favoriteenemy.origin - entity.origin;
				to_enemy = (to_enemy[0], to_enemy[1], 0);
				var_f67f7d03 = vectordot(var_2ddabcd3, to_enemy);
				dot_right = vectordot(gladiator_right, to_enemy);
				if(abs(var_f67f7d03) > abs(dot_right))
				{
					dot = var_f67f7d03;
					directions = array("front", "back");
				}
				else
				{
					dot = dot_right;
					directions = array("right", "left");
				}
				if(dot >= 0)
				{
					entity setblackboardattribute("_gladiator_react", directions[0]);
				}
				else
				{
					entity setblackboardattribute("_gladiator_react", directions[1]);
				}
			}
			if(entity.var_9fde8624 == #"gladiator_marauder")
			{
				entity ai::set_behavior_attribute("run", 1);
			}
		}
	}
	return entity function_831dd6bd();
}

/*
	Name: function_4f73587a
	Namespace: namespace_c49f9e2b
	Checksum: 0xE8FA2919
	Offset: 0x2260
	Size: 0x1BC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4f73587a(entity)
{
	enemy = entity.favoriteenemy;
	/#
		if(isdefined(entity.var_ff56e34c))
		{
			return 0;
		}
	#/
	if(entity ai::has_behavior_attribute("run"))
	{
		if(entity ai::get_behavior_attribute("run"))
		{
			entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
			return 1;
		}
	}
	if(!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy))
	{
		entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
		return 0;
	}
	if(isdefined(enemy) && isalive(enemy))
	{
		dist_sq = distancesquared(entity.origin, enemy.origin);
		if(dist_sq > 360000)
		{
			entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
			return 1;
		}
		if(dist_sq < 160000)
		{
			entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_4660925e
	Namespace: namespace_c49f9e2b
	Checksum: 0x4213FA20
	Offset: 0x2428
	Size: 0x30
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4660925e(entity)
{
	if(entity.var_9fde8624 == #"gladiator_destroyer")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ceea5a43
	Namespace: namespace_c49f9e2b
	Checksum: 0x120564BA
	Offset: 0x2460
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ceea5a43(entity)
{
	if(math::cointoss())
	{
		entity.var_34cc44de = "left";
	}
	else
	{
		entity.var_34cc44de = "right";
	}
}

/*
	Name: function_104b8cc1
	Namespace: namespace_c49f9e2b
	Checksum: 0xD63A1E15
	Offset: 0x24B8
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
private function function_104b8cc1()
{
	self.var_844453ff = gettime() + 3000;
}

/*
	Name: function_d1242576
	Namespace: namespace_c49f9e2b
	Checksum: 0x14412C49
	Offset: 0x24D8
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1242576()
{
	self.next_leap_time = gettime() + 3000;
}

/*
	Name: function_edd0777f
	Namespace: namespace_c49f9e2b
	Checksum: 0xC57FE49F
	Offset: 0x24F8
	Size: 0x21E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_edd0777f(entity)
{
	if(!entity ai::get_behavior_attribute("axe_throw"))
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(entity.var_9fde8624 != #"gladiator_destroyer")
	{
		return 0;
	}
	if(!entity.var_d9b1cc0e || !entity.var_4e00bc1)
	{
		return 0;
	}
	if(entity.var_ba481973)
	{
		return 0;
	}
	if(isdefined(entity.zombie_poi))
	{
		return 0;
	}
	if(gettime() < entity.var_844453ff)
	{
		return 0;
	}
	dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
	if(dist_sq < 57600)
	{
		return 0;
	}
	if(dist_sq > 360000)
	{
		return 0;
	}
	yaw = abs(zombie_utility::getyawtoenemy());
	if(yaw > 22.5)
	{
		return 0;
	}
	if(namespace_e0710ee6::function_54054394(entity))
	{
		return 0;
	}
	can_see = bullettracepassed(entity.origin + vectorscale((0, 0, 1), 36), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 36), 0, undefined);
	if(!can_see)
	{
		return 0;
	}
	/#
		if(entity.favoriteenemy isnotarget())
		{
			return 0;
		}
	#/
	return 1;
}

/*
	Name: function_154454e8
	Namespace: namespace_c49f9e2b
	Checksum: 0xAC1A1503
	Offset: 0x2720
	Size: 0x28
	Parameters: 1
	Flags: Linked, Private
*/
private function function_154454e8(entity)
{
	if(self.var_34cc44de === "left")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_2b6f49c8
	Namespace: namespace_c49f9e2b
	Checksum: 0xF9CF299D
	Offset: 0x2750
	Size: 0x28
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2b6f49c8(entity)
{
	if(self.var_34cc44de === "right")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a3329afd
	Namespace: namespace_c49f9e2b
	Checksum: 0xB18C4671
	Offset: 0x2780
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a3329afd(entity)
{
	if(self.var_34cc44de === "left")
	{
		if(isdefined(self.var_d5e9528) && self.var_d5e9528)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_d2ab62ae
	Namespace: namespace_c49f9e2b
	Checksum: 0x3C2A9A46
	Offset: 0x27C8
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d2ab62ae(entity)
{
	if(self.var_34cc44de === "right")
	{
		if(isdefined(self.var_d5e9528) && self.var_d5e9528)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_c6c44df1
	Namespace: namespace_c49f9e2b
	Checksum: 0xE4098DA8
	Offset: 0x2810
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_c6c44df1(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 1;
	}
	z_diff = abs(entity.origin[2] - entity.favoriteenemy.origin[2]);
	var_4ea3ded6 = 48;
	if(isdefined(entity.favoriteenemy.zone_name) && entity.favoriteenemy.zone_name == #"zone_starting_area_center")
	{
		var_4ea3ded6 = 8;
	}
	if(z_diff > var_4ea3ded6)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_13f886a2
	Namespace: namespace_c49f9e2b
	Checksum: 0x9841B479
	Offset: 0x28F0
	Size: 0x346
	Parameters: 1
	Flags: Linked
*/
function function_13f886a2(entity)
{
	if(!(isdefined(entity.completed_emerging_into_playable_area) && entity.completed_emerging_into_playable_area))
	{
		return 0;
	}
	if(entity.ignoreall)
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(!self.var_d9b1cc0e || !self.var_4e00bc1)
	{
		return 0;
	}
	if(isdefined(entity.zombie_poi))
	{
		return 0;
	}
	var_17c3916f = 128 * 128;
	if(self.var_9fde8624 == #"gladiator_marauder")
	{
		if(gettime() < entity.next_leap_time)
		{
			return 0;
		}
		enemy_dist_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
		if(enemy_dist_sq < 128 * 128)
		{
			return 0;
		}
		var_17c3916f = 240 * 240;
		z_diff = abs(entity.origin[2] - entity.favoriteenemy.origin[2]);
		if(z_diff > 72)
		{
			return 0;
		}
	}
	else if(self.var_9fde8624 == #"gladiator_destroyer")
	{
		z_diff = abs(entity.origin[2] - entity.favoriteenemy.origin[2]);
		var_4ea3ded6 = 48;
		if(isdefined(entity.favoriteenemy.zone_name) && entity.favoriteenemy.zone_name == #"zone_starting_area_center")
		{
			var_4ea3ded6 = 8;
		}
		if(z_diff > var_4ea3ded6)
		{
			return 0;
		}
	}
	if(!(isdefined(level.intermission) && level.intermission))
	{
		if(distancesquared(entity.origin, entity.favoriteenemy.origin) > var_17c3916f)
		{
			return 0;
		}
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	if(namespace_e0710ee6::function_54054394(entity))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_61e7d5f5
	Namespace: namespace_c49f9e2b
	Checksum: 0x4F818D7B
	Offset: 0x2C40
	Size: 0x1F6
	Parameters: 1
	Flags: Linked
*/
function function_61e7d5f5(entity)
{
	if(!(isdefined(entity.completed_emerging_into_playable_area) && entity.completed_emerging_into_playable_area))
	{
		return 0;
	}
	if(entity.ignoreall)
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(self.var_9fde8624 != #"gladiator_destroyer")
	{
		return 0;
	}
	if(self.var_d9b1cc0e && self.var_4e00bc1)
	{
		return 0;
	}
	var_ff38566a = lengthsquared(entity.favoriteenemy getvelocity());
	var_17c3916f = 100 * 100;
	if(var_ff38566a < 175 * 175)
	{
		var_17c3916f = 190 * 190;
	}
	if(!(isdefined(level.intermission) && level.intermission))
	{
		if(distancesquared(entity.origin, entity.favoriteenemy.origin) > var_17c3916f)
		{
			return 0;
		}
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	if(namespace_e0710ee6::function_54054394(entity))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_7891bd9b
	Namespace: namespace_c49f9e2b
	Checksum: 0xC2016ED7
	Offset: 0x2E40
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7891bd9b(entity)
{
	entity pathmode("dont move", 1);
}

/*
	Name: function_490a290d
	Namespace: namespace_c49f9e2b
	Checksum: 0x132B15C7
	Offset: 0x2E78
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_490a290d(entity)
{
	entity pathmode("move allowed");
}

/*
	Name: function_8d49edfa
	Namespace: namespace_c49f9e2b
	Checksum: 0x5CF19E74
	Offset: 0x2EB0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8d49edfa(entity)
{
	if(isdefined(entity.knockdown) && entity.knockdown)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_6bbfa1a0
	Namespace: namespace_c49f9e2b
	Checksum: 0xAF0F7D1C
	Offset: 0x2EF0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6bbfa1a0(entity)
{
	if(isdefined(entity.var_9b959f19) && entity.var_9b959f19)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_dd674e3c
	Namespace: namespace_c49f9e2b
	Checksum: 0x2EB3B0F1
	Offset: 0x2F30
	Size: 0x50
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dd674e3c(entity)
{
	locomotionspeed = entity getblackboardattribute("_locomotion_speed");
	if(locomotionspeed === "locomotion_speed_run")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_7468904d
	Namespace: namespace_c49f9e2b
	Checksum: 0x19666803
	Offset: 0x2F88
	Size: 0x58
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7468904d(entity)
{
	if(entity getblackboardattribute("_locomotion_speed") === "locomotion_speed_run" && entity haspath())
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a7bbb8e4
	Namespace: namespace_c49f9e2b
	Checksum: 0xD40AC10D
	Offset: 0x2FE8
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a7bbb8e4(entity)
{
	if(isdefined(entity.var_908a5d30) && entity.var_908a5d30)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c1b97472
	Namespace: namespace_c49f9e2b
	Checksum: 0xFA135191
	Offset: 0x3028
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c1b97472(entity)
{
	entity function_104b8cc1();
}

/*
	Name: function_fe0ecd9f
	Namespace: namespace_c49f9e2b
	Checksum: 0xBBE994A8
	Offset: 0x3058
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_fe0ecd9f(entity)
{
	entity.var_d5e9528 = 0;
	entity function_104b8cc1();
}

/*
	Name: function_6719445a
	Namespace: namespace_c49f9e2b
	Checksum: 0xCF482E9C
	Offset: 0x3090
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6719445a(entity)
{
	if(entity.var_9fde8624 == #"gladiator_marauder")
	{
		entity.var_5dd07a80 = 1;
		entity.var_c2986b66 = 1;
		entity function_d1242576();
		entity.var_b736fc8b = 1;
		entity pathmode("dont move", 1);
	}
}

/*
	Name: function_fced00e1
	Namespace: namespace_c49f9e2b
	Checksum: 0x495CA067
	Offset: 0x3128
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_fced00e1(entity)
{
	if(entity.var_9fde8624 == #"gladiator_marauder")
	{
		entity.var_5dd07a80 = undefined;
		entity.var_c2986b66 = undefined;
		entity function_d1242576();
		entity.var_b736fc8b = 0;
		entity pathmode("move allowed");
	}
}

/*
	Name: function_3963581d
	Namespace: namespace_c49f9e2b
	Checksum: 0x5B9DE3B4
	Offset: 0x31B0
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3963581d(entity)
{
	if(entity.var_9fde8624 == #"gladiator_marauder")
	{
		entity.var_5dd07a80 = 1;
		entity.var_c2986b66 = 1;
	}
}

/*
	Name: function_dfbf9d5e
	Namespace: namespace_c49f9e2b
	Checksum: 0xE1C8861
	Offset: 0x3200
	Size: 0x3E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dfbf9d5e(entity)
{
	if(entity.var_9fde8624 == #"gladiator_marauder")
	{
		entity.var_5dd07a80 = undefined;
		entity.var_c2986b66 = undefined;
	}
}

/*
	Name: function_990c9627
	Namespace: namespace_c49f9e2b
	Checksum: 0x2ECB368C
	Offset: 0x3248
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_990c9627(entity)
{
	entity pathmode("dont move", 1);
}

/*
	Name: function_6ba071ff
	Namespace: namespace_c49f9e2b
	Checksum: 0xBE73D570
	Offset: 0x3280
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6ba071ff(entity)
{
	entity.var_9b959f19 = 0;
	entity pathmode("move allowed");
}

/*
	Name: function_3ca98f5a
	Namespace: namespace_c49f9e2b
	Checksum: 0x8C38C978
	Offset: 0x32C0
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3ca98f5a(entity)
{
	entity pathmode("dont move", 1);
	if(entity.var_9fde8624 == #"gladiator_marauder")
	{
		entity.var_4f1b8d2b = 1;
	}
}

/*
	Name: function_e217245a
	Namespace: namespace_c49f9e2b
	Checksum: 0xB7468314
	Offset: 0x3320
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e217245a(entity)
{
	entity pathmode("move allowed");
	entity.var_908a5d30 = 0;
}

#namespace namespace_52f0d01d;

/*
	Name: __constructor
	Namespace: namespace_52f0d01d
	Checksum: 0x8E073AB9
	Offset: 0x3368
	Size: 0x1A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.adjustmentstarted = 0;
	self.var_425c4c8b = 1;
}

/*
	Name: __destructor
	Namespace: namespace_52f0d01d
	Checksum: 0x80F724D1
	Offset: 0x3390
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_c49f9e2b;

/*
	Name: function_52f0d01d
	Namespace: namespace_c49f9e2b
	Checksum: 0x6FA17414
	Offset: 0x33A0
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_52f0d01d()
{
	classes.var_52f0d01d[0] = spawnstruct();
	classes.var_52f0d01d[0].__vtable[913321084] = &namespace_52f0d01d::__destructor;
	classes.var_52f0d01d[0].__vtable[674154906] = &namespace_52f0d01d::__constructor;
}

/*
	Name: registerhud_message_electricity_
	Namespace: namespace_c49f9e2b
	Checksum: 0xB203AF0D
	Offset: 0x3430
	Size: 0x324
	Parameters: 5
	Flags: Linked
*/
function registerhud_message_electricity_(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("gravity", 1);
	entity orientmode("face angle", entity.angles[1]);
	entity.blockingpain = 1;
	entity.var_5dd07a80 = 1;
	entity.var_c2986b66 = 1;
	entity.usegoalanimweight = 1;
	entity pathmode("dont move");
	entity collidewithactors(0);
	if(isdefined(entity.favoriteenemy))
	{
		dirtoenemy = vectornormalize(entity.favoriteenemy.origin - entity.origin);
		entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
	}
	if(!isdefined(self.var_cd8354e0))
	{
		object = new var_52f0d01d();
		[[ object ]]->__constructor();
		self.var_cd8354e0 = object;
		self.var_cd8354e0.var_9bfa8497 = entity.origin;
		self.var_cd8354e0.var_98bc84b7 = getnotetracktimes(mocompanim, "start_procedural")[0];
		self.var_cd8354e0.var_6392c3a2 = getnotetracktimes(mocompanim, "stop_procedural")[0];
		var_e397f54c = getmovedelta(mocompanim, 0, 1, entity);
		self.var_cd8354e0.var_cb28f380 = entity localtoworldcoords(var_e397f54c);
		/#
			movedelta = getmovedelta(mocompanim, 0, 1, entity);
			var_6b8f735f = entity localtoworldcoords(movedelta);
			distance = distance(entity.origin, var_6b8f735f);
			recordcircle(var_6b8f735f, 3, (0, 1, 0), "");
			record3dtext("" + distance, var_6b8f735f, (0, 1, 0), "");
		#/
	}
}

/*
	Name: function_3f15e557
	Namespace: namespace_c49f9e2b
	Checksum: 0xC95DA36A
	Offset: 0x3760
	Size: 0x914
	Parameters: 5
	Flags: Linked
*/
function function_3f15e557(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	/#
		assert(isdefined(self.var_cd8354e0));
	#/
	var_e72a224a = entity getanimtime(mocompanim);
	if(isdefined(self.favoriteenemy) && !self.var_cd8354e0.adjustmentstarted && self.var_cd8354e0.var_425c4c8b && var_e72a224a >= self.var_cd8354e0.var_98bc84b7)
	{
		predictedenemypos = entity.favoriteenemy.origin;
		if(isplayer(entity.favoriteenemy))
		{
			velocity = entity.favoriteenemy getvelocity();
			if(length(velocity) >= 0)
			{
				predictedenemypos = predictedenemypos + vectorscale(velocity, 0.25);
			}
		}
		var_83fd29ee = vectornormalize(predictedenemypos - entity.origin);
		var_1efb2395 = predictedenemypos - var_83fd29ee * entity getpathfindingradius();
		self.var_cd8354e0.var_736d2cce = var_1efb2395;
		var_776ddabf = distancesquared(self.var_cd8354e0.var_cb28f380, self.var_cd8354e0.var_736d2cce);
		var_65cbfb52 = distancesquared(self.var_cd8354e0.var_9bfa8497, self.var_cd8354e0.var_736d2cce);
		if(var_776ddabf <= 20 * 20)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			self.var_cd8354e0.var_425c4c8b = 0;
		}
		else if(var_65cbfb52 <= 90 * 90)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			self.var_cd8354e0.var_425c4c8b = 0;
		}
		else if(var_65cbfb52 >= 400 * 400)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			self.var_cd8354e0.var_425c4c8b = 0;
		}
		if(self.var_cd8354e0.var_425c4c8b)
		{
			var_776ddabf = distancesquared(self.var_cd8354e0.var_cb28f380, self.var_cd8354e0.var_736d2cce);
			var_beabc994 = anglestoforward(self.angles);
			var_1c3641f2 = (entity.favoriteenemy.origin[0], entity.favoriteenemy.origin[1], entity.origin[2]);
			dirtoenemy = vectornormalize(var_1c3641f2 - entity.origin);
			zdiff = self.var_cd8354e0.var_cb28f380[2] - entity.favoriteenemy.origin[2];
			var_6738a702 = abs(zdiff) <= 45;
			var_175919d1 = vectordot(var_beabc994, dirtoenemy) > cos(30);
			var_7948b2f3 = var_6738a702 && var_175919d1;
			isvisible = bullettracepassed(entity.origin, entity.favoriteenemy.origin, 0, self);
			var_425c4c8b = isvisible && var_7948b2f3;
			/#
				reasons = "" + isvisible + "" + var_6738a702 + "" + var_175919d1;
				if(var_425c4c8b)
				{
					record3dtext(reasons, entity.origin + vectorscale((0, 0, 1), 60), (0, 1, 0), "");
				}
				else
				{
					record3dtext(reasons, entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
				}
			#/
			if(var_425c4c8b)
			{
				var_90c3cdd2 = length(self.var_cd8354e0.var_736d2cce - self.var_cd8354e0.var_cb28f380);
				timestep = function_60d95f53();
				animlength = getanimlength(mocompanim) * 1000;
				starttime = self.var_cd8354e0.var_98bc84b7 * animlength;
				stoptime = self.var_cd8354e0.var_6392c3a2 * animlength;
				starttime = floor(starttime / timestep);
				stoptime = floor(stoptime / timestep);
				adjustduration = stoptime - starttime;
				self.var_cd8354e0.var_10b8b6d1 = vectornormalize(self.var_cd8354e0.var_736d2cce - self.var_cd8354e0.var_cb28f380);
				self.var_cd8354e0.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
				self.var_cd8354e0.var_425c4c8b = 1;
				self.var_cd8354e0.adjustmentstarted = 1;
			}
			else
			{
				self.var_cd8354e0.var_425c4c8b = 0;
			}
		}
	}
	if(self.var_cd8354e0.adjustmentstarted && var_e72a224a <= self.var_cd8354e0.var_6392c3a2)
	{
		/#
			assert(isdefined(self.var_cd8354e0.var_10b8b6d1) && isdefined(self.var_cd8354e0.var_8b9a15a6));
		#/
		/#
			recordsphere(self.var_cd8354e0.var_cb28f380, 3, (0, 1, 0), "");
			recordsphere(self.var_cd8354e0.var_736d2cce, 3, (0, 0, 1), "");
		#/
		adjustedorigin = entity.origin + entity.var_cd8354e0.var_10b8b6d1 * self.var_cd8354e0.var_8b9a15a6;
		entity forceteleport(adjustedorigin);
	}
}

/*
	Name: function_96f1cbf6
	Namespace: namespace_c49f9e2b
	Checksum: 0x6D797814
	Offset: 0x4080
	Size: 0xBE
	Parameters: 5
	Flags: Linked
*/
function function_96f1cbf6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
	entity.var_5dd07a80 = undefined;
	entity.var_c2986b66 = undefined;
	entity.usegoalanimweight = 0;
	entity pathmode("move allowed");
	entity orientmode("face default");
	entity collidewithactors(1);
	entity.var_cd8354e0 = undefined;
}

/*
	Name: function_3137174f
	Namespace: namespace_c49f9e2b
	Checksum: 0x2BBAE58A
	Offset: 0x4148
	Size: 0xBC
	Parameters: 5
	Flags: Linked
*/
function function_3137174f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.favoriteenemy))
	{
		to_enemy = vectornormalize(entity.favoriteenemy.origin - entity.origin);
		angles_to_enemy = vectortoangles(to_enemy);
		entity orientmode("face angle", angles_to_enemy[1]);
	}
}

/*
	Name: function_64cd870
	Namespace: namespace_c49f9e2b
	Checksum: 0xE38E599D
	Offset: 0x4210
	Size: 0xDC
	Parameters: 5
	Flags: Linked
*/
function function_64cd870(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.favoriteenemy))
	{
		if(!(isdefined(entity.var_ba481973) && entity.var_ba481973))
		{
			to_enemy = vectornormalize(entity.favoriteenemy.origin - entity.origin);
			angles_to_enemy = vectortoangles(to_enemy);
			entity orientmode("face angle", angles_to_enemy[1]);
		}
	}
}

/*
	Name: function_d9e4ebc8
	Namespace: namespace_c49f9e2b
	Checksum: 0x53A97AFA
	Offset: 0x42F8
	Size: 0x2C
	Parameters: 5
	Flags: Linked
*/
function function_d9e4ebc8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
}

/*
	Name: function_37d33f09
	Namespace: namespace_c49f9e2b
	Checksum: 0x24E24237
	Offset: 0x4330
	Size: 0x6C
	Parameters: 5
	Flags: Linked
*/
function function_37d33f09(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("normal");
	entity orientmode("face motion");
}

/*
	Name: function_3f7c46a
	Namespace: namespace_c49f9e2b
	Checksum: 0x320735E8
	Offset: 0x43A8
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function function_3f7c46a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.favoriteenemy))
	{
		if(distancesquared(entity.origin, entity.favoriteenemy.origin) <= 50 * 50)
		{
			entity animmode("angle deltas");
		}
		else
		{
			entity animmode("normal");
		}
	}
}

/*
	Name: function_2bc1ffb8
	Namespace: namespace_c49f9e2b
	Checksum: 0x31FCD6F2
	Offset: 0x4468
	Size: 0x4C
	Parameters: 5
	Flags: Linked
*/
function function_2bc1ffb8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("normal");
}

/*
	Name: function_cdef55f0
	Namespace: namespace_c49f9e2b
	Checksum: 0x113AFB6F
	Offset: 0x44C0
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_cdef55f0(entity)
{
	hitent = entity melee();
	/#
		record3dtext("", self.origin, (1, 0, 0), "", entity);
	#/
	entity.var_4f1b8d2b = 0;
	if(isplayer(hitent))
	{
		hitent clientfield::increment_to_player("gladiator_melee_effect");
	}
}

/*
	Name: function_f3c02dbf
	Namespace: namespace_c49f9e2b
	Checksum: 0x444DEF75
	Offset: 0x4570
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f3c02dbf(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return;
	}
	entity function_5be18f96(0);
	entity function_8a8841b0();
}

/*
	Name: function_14ff2d78
	Namespace: namespace_c49f9e2b
	Checksum: 0xDF0AB82F
	Offset: 0x45C8
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function function_14ff2d78(entity)
{
	entity function_5be18f96();
}

/*
	Name: function_894d3d57
	Namespace: namespace_c49f9e2b
	Checksum: 0x1AE6426
	Offset: 0x45F8
	Size: 0x30C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_894d3d57(entity)
{
	if(!isdefined(entity))
	{
		return;
	}
	if(!isdefined(entity.damage_info) || !isdefined(entity.damage_info.hitloc))
	{
		return;
	}
	var_34cc44de = "right";
	hand = "right_hand";
	if(entity.damage_info.hitloc == "left_arm_lower")
	{
		var_34cc44de = "left";
		hand = "left_hand";
	}
	entity destructserverutils::handledamage(entity.damage_info.inflictor, entity.damage_info.attacker, entity.damage_info.damage, entity.damage_info.idflags, entity.damage_info.meansofdeath, entity.damage_info.weapon, entity.damage_info.point, entity.damage_info.dir, entity.damage_info.hitloc, entity.damage_info.offsettime, entity.damage_info.boneindex, entity.damage_info.modelindex);
	if(entity.var_ba481973 && entity.var_34cc44de == var_34cc44de)
	{
		if(isdefined(entity.axe_model))
		{
			entity notify(#"hash_78e94482c724d141");
			entity.axe_model delete();
		}
	}
	else
	{
		entity destructserverutils::handledamage(entity.damage_info.inflictor, entity.damage_info.attacker, entity.damage_info.damage, entity.damage_info.idflags, entity.damage_info.meansofdeath, entity.damage_info.weapon, entity.damage_info.point, entity.damage_info.dir, hand, entity.damage_info.offsettime, entity.damage_info.boneindex, entity.damage_info.modelindex);
	}
}

/*
	Name: function_caed4d61
	Namespace: namespace_c49f9e2b
	Checksum: 0x2428B33E
	Offset: 0x4910
	Size: 0x244
	Parameters: 0
	Flags: Linked, Private
*/
private function function_caed4d61()
{
	self.b_ignore_cleanup = 1;
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.var_f46fbf3f = 1;
	self.cant_move_cb = &zombiebehavior::function_79fe956f;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
	self collidewithactors(1);
	if(self.var_9fde8624 == #"gladiator_destroyer")
	{
		self function_f6a04c04();
	}
	else if(self.var_9fde8624 == #"gladiator_marauder")
	{
		self function_2617ff14();
		self.next_leap_time = gettime() + 3000;
	}
	self function_104b8cc1();
	self.var_844453ff = gettime() + 3000;
	self.var_d9b1cc0e = 1;
	self.var_4e00bc1 = 1;
	self.var_ba481973 = 0;
	self.var_8c28b842 = 1;
	self.var_7672fb41 = 1;
	self.ignorepathenemyfightdist = 1;
	self.allowdeath = 1;
	level thread zm_spawner::zombie_death_event(self);
	self thread zombie_utility::zombie_eye_glow();
	self thread zm_audio::zmbaivox_notifyconvert();
	self thread zm_audio::play_ambient_zombie_vocals();
	aiutility::addaioverridedamagecallback(self, &function_75f32da6);
	self callback::on_ai_killed(&function_3b8907b9);
	target_set(self);
}

/*
	Name: function_75f32da6
	Namespace: namespace_c49f9e2b
	Checksum: 0x96D9AAAE
	Offset: 0x4B60
	Size: 0xB94
	Parameters: 12
	Flags: Linked, Private
*/
private function function_75f32da6(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && attacker.team === self.team)
	{
		return 0;
	}
	if(isdefined(attacker) && !isplayer(attacker) && (!(isdefined(attacker.var_594b7855) && attacker.var_594b7855)))
	{
		return 0;
	}
	if(isdefined(attacker) && isplayer(attacker) && self.var_9fde8624 == #"gladiator_marauder" && !isdefined(self.var_4f1b8d2b) && isdefined(zm_zonemgr::function_54fc7938(attacker, self)))
	{
		self.favoriteenemy = attacker;
		self.var_4f1b8d2b = 1;
		self.var_cb89528d = 1;
	}
	var_ae30c5b0 = 0;
	if(isdefined(weapon) && (zm_loadout::is_hero_weapon(weapon) || (isdefined(weapon.ignorespowerarmor) && weapon.ignorespowerarmor)))
	{
		var_ae30c5b0 = 1;
	}
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point);
	var_dd54fdb1 = var_786d7e06.var_84ed9a13;
	var_88e794fb = var_786d7e06.registerzombie_bgb_used_reinforce;
	if(!isdefined(var_dd54fdb1) && var_ae30c5b0)
	{
		weakpoints = namespace_81245006::function_fab3ee3e(self);
		foreach(var_3a1904d3 in weakpoints)
		{
			if(namespace_81245006::function_f29756fe(var_3a1904d3) === 1 && var_3a1904d3.type === #"armor")
			{
				var_dd54fdb1 = var_3a1904d3;
				var_88e794fb = 1;
				break;
			}
		}
	}
	adjusted_damage = int(damage * var_786d7e06.damage_scale);
	if(var_ae30c5b0)
	{
		if(!isdefined(self.var_5dc26e42) || self.var_5dc26e42 >= 1000)
		{
			self.var_5dc26e42 = 0;
		}
		self.var_5dc26e42 = self.var_5dc26e42 + adjusted_damage;
	}
	if(isdefined(var_dd54fdb1))
	{
		if(isdefined(var_dd54fdb1.var_8223b0cf) && var_dd54fdb1.var_8223b0cf > 0)
		{
			adjusted_damage = damage * var_786d7e06.damage_scale * var_dd54fdb1.var_8223b0cf;
		}
		adjusted_damage = int(adjusted_damage);
		if(var_88e794fb)
		{
			namespace_81245006::function_ef87b7e8(var_dd54fdb1, adjusted_damage);
			/#
				if(getdvarint(#"hash_50608e24a3f5f666", 0) > 0)
				{
					iprintlnbold("" + var_dd54fdb1.health);
				}
			#/
			if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3 || (var_ae30c5b0 && self.var_5dc26e42 >= 1000))
			{
				/#
					if(getdvarint(#"hash_50608e24a3f5f666", 0) > 0)
					{
						iprintlnbold("");
					}
				#/
				var_a7d0fdac = 0;
				if(var_dd54fdb1.hitloc == "left_arm_lower" || var_dd54fdb1.hitloc == "right_arm_lower")
				{
					var_a7d0fdac = 1;
					self.damage_info = {#modelindex:modelindex, #boneindex:boneindex, #offsettime:offsettime, #hitloc:var_dd54fdb1.hitloc, #dir:dir, #point:point, #weapon:weapon, #meansofdeath:meansofdeath, #idflags:idflags, #damage:damage, #attacker:attacker, #inflictor:inflictor};
				}
				self destructserverutils::handledamage(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, var_dd54fdb1.hitloc, offsettime, boneindex, modelindex);
				self.gibbed = 1;
				if(isdefined(level.var_36fff581) && !var_a7d0fdac)
				{
					self [[level.var_36fff581]](attacker);
					playsoundatposition(#"hash_10711c56d7aa52d5", self.origin + vectorscale((0, 0, 1), 30));
				}
				if(var_dd54fdb1.hitloc == "helmet")
				{
					var_465efe42 = namespace_81245006::function_37e3f011(self, "j_head", 2);
					namespace_81245006::function_6c64ebd3(var_465efe42, 1);
					self.var_9b959f19 = 1;
					self setblackboardattribute("_gladiator_weakpoint", "head");
				}
				else if(var_dd54fdb1.hitloc == "left_arm_upper")
				{
					var_449bfcd3 = namespace_81245006::function_37e3f011(self, "j_shoulder_le");
				}
				else if(var_dd54fdb1.hitloc == "right_arm_upper")
				{
					var_449bfcd3 = namespace_81245006::function_37e3f011(self, "j_shoulder_ri");
				}
				else if(var_dd54fdb1.hitloc == "left_arm_lower")
				{
					self.var_d9b1cc0e = 0;
					if(!self.var_4e00bc1)
					{
						if(!(isdefined(self.allowdeath) && self.allowdeath))
						{
							self notify(#"hash_63c1fbea5263c4f8");
						}
						else
						{
							self kill(point, attacker, inflictor, weapon, 0, 1);
						}
					}
					else
					{
						self ai::set_behavior_attribute("run", 1);
						self setblackboardattribute("_gladiator_arm", "right_arm");
					}
					if(!self isattached(#"hash_3634f266929240d1"))
					{
						self attach(#"hash_3634f266929240d1");
					}
					self.var_9b959f19 = 1;
					self clientfield::set("gladiator_arm_effect", 1);
					self setblackboardattribute("_gladiator_weakpoint", "left_arm");
					self ai::set_behavior_attribute("run", 1);
				}
				else if(var_dd54fdb1.hitloc == "right_arm_lower")
				{
					self.var_4e00bc1 = 0;
					if(!self.var_d9b1cc0e)
					{
						if(!(isdefined(self.allowdeath) && self.allowdeath))
						{
							self notify(#"hash_63c1fbea5263c4f8");
						}
						else
						{
							self kill(point, attacker, inflictor, weapon, 0, 1);
						}
					}
					else
					{
						self setblackboardattribute("_gladiator_arm", "left_arm");
					}
					if(!self isattached(#"hash_2c9ad2bed0d2bcdf"))
					{
						self attach(#"hash_2c9ad2bed0d2bcdf");
					}
					self.var_9b959f19 = 1;
					self clientfield::set("gladiator_arm_effect", 2);
					self setblackboardattribute("_gladiator_weakpoint", "right_arm");
					self ai::set_behavior_attribute("run", 1);
				}
				if(isdefined(var_449bfcd3))
				{
					namespace_81245006::function_6c64ebd3(var_449bfcd3, 1);
				}
				if(isdefined(var_dd54fdb1.var_641ce20e) && var_dd54fdb1.var_641ce20e)
				{
					namespace_81245006::function_6742b846(self, var_dd54fdb1);
				}
			}
			if(var_dd54fdb1.type === #"armor" && !var_ae30c5b0)
			{
				attacker util::show_hit_marker(!isalive(self));
				return 0;
			}
		}
	}
	return adjusted_damage;
}

/*
	Name: function_3b8907b9
	Namespace: namespace_c49f9e2b
	Checksum: 0x71F01AC3
	Offset: 0x5700
	Size: 0xB8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3b8907b9(s_params)
{
	if(self.archetype != #"gladiator")
	{
		return;
	}
	self val::set(#"gladiator_death", "takedamage", 0);
	if(isdefined(self.axe_model))
	{
		self.axe_model clientfield::set("gladiator_axe_effect", 0);
		self.axe_model delete();
	}
	if(!isplayer(s_params.eattacker))
	{
		return;
	}
}

/*
	Name: function_fbc2806e
	Namespace: namespace_c49f9e2b
	Checksum: 0x69359C37
	Offset: 0x57C0
	Size: 0x6E4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_fbc2806e(var_a4388d06, var_9e7687f8)
{
	self endon(#"death", #"hash_78e94482c724d141");
	var_23f0c5b3 = self gettagorigin(var_a4388d06);
	var_ecc54f32 = self gettagangles(var_a4388d06);
	invert = 1;
	if(isdefined(var_9e7687f8))
	{
		invert = invert * var_9e7687f8;
	}
	var_ecc54f32 = (0, self.angles[1], 0);
	axe = util::spawn_model("tag_origin", var_23f0c5b3, var_ecc54f32);
	level notify(#"hash_27a9b4863f38ef7c", {#hash_90db0e3c:axe});
	self.axe_model = axe;
	axe clientfield::set("gladiator_axe_effect", 1);
	/#
		recordent(axe);
	#/
	enemy = self.favoriteenemy;
	var_6a774ef = self.favoriteenemy geteye();
	dist_to_target = distance(var_23f0c5b3, var_6a774ef);
	var_bb95ea0c = 600;
	interval_dist = var_bb95ea0c * 0.1;
	time_to_target = dist_to_target / var_bb95ea0c;
	total_dist = 0;
	max_dist = 500;
	var_7900b267 = vectornormalize(var_6a774ef - var_23f0c5b3);
	axe playloopsound(#"zmb_ai_gladiator_axe_lp");
	var_6b72740e = undefined;
	var_1fed6c4e = undefined;
	var_285f5e05 = vectortoangles(var_7900b267);
	while(true)
	{
		enemy = self.favoriteenemy;
		if(isdefined(enemy) && isplayer(enemy) && enemy issliding() && (!(isdefined(var_6b72740e) && var_6b72740e)))
		{
			if(distance2dsquared(enemy.origin, axe.origin) <= 45 * 45)
			{
				/#
					recordsphere(enemy.origin, 3, (0, 0, 1), "");
					var_b013c31 = distance2d(enemy.origin, axe.origin);
					record3dtext("" + var_b013c31, enemy.origin + vectorscale((0, 0, 1), 60), (0, 0, 1), "");
				#/
				var_6b72740e = 1;
			}
		}
		move_pos = axe.origin + var_7900b267 * interval_dist;
		if(isdefined(var_6b72740e) && var_6b72740e && !isdefined(var_1fed6c4e))
		{
			if(isdefined(enemy))
			{
				if(distance2dsquared(enemy.origin, move_pos) > 45 * 45)
				{
					/#
						recordsphere(enemy.origin, 3, (0, 1, 0), "");
						var_b013c31 = distance2d(enemy.origin, move_pos);
						record3dtext("" + var_b013c31, enemy.origin + vectorscale((0, 0, 1), 60), (0, 1, 0), "");
					#/
					var_1fed6c4e = 1;
				}
				else if(!enemy issliding())
				{
					/#
						recordsphere(enemy.origin, 3, (1, 0, 0), "");
						record3dtext("", enemy.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
					#/
					var_1fed6c4e = 0;
				}
			}
		}
		else if(self function_88d65504(axe, var_7900b267, move_pos))
		{
			break;
		}
		axe moveto(move_pos, 0.1);
		wait(0.1);
		total_dist = total_dist + interval_dist;
		if(total_dist >= max_dist)
		{
			break;
		}
		if(isdefined(enemy))
		{
			enemy_eye_pos = enemy geteye();
			var_8a2a3f91 = vectornormalize(enemy_eye_pos - var_23f0c5b3);
			var_61443c36 = vectortoangles(var_8a2a3f91);
			yaw_diff = abs(angleclamp180(var_285f5e05[1] - var_61443c36[1]));
			if(yaw_diff <= 10)
			{
				var_7900b267 = vectornormalize(enemy_eye_pos - axe.origin);
			}
		}
	}
	self function_137ed431(axe, var_a4388d06, var_9e7687f8);
}

/*
	Name: function_78b33d6c
	Namespace: namespace_c49f9e2b
	Checksum: 0x86EC8BE5
	Offset: 0x5EB0
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_78b33d6c(var_9e7687f8 = 1)
{
	self endon(#"death");
	while(true)
	{
		var_ef1542c2 = 0.2;
		self rotateyaw(360 * var_9e7687f8, var_ef1542c2);
		wait(var_ef1542c2);
	}
}

/*
	Name: function_88d65504
	Namespace: namespace_c49f9e2b
	Checksum: 0xCBDEC85E
	Offset: 0x5F30
	Size: 0x340
	Parameters: 3
	Flags: Linked, Private
*/
private function function_88d65504(axe, var_7900b267, move_pos)
{
	trace = physicstrace(axe.origin, move_pos, (-16, -16, -12), (16, 16, 12), self);
	if(trace[#"fraction"] < 1)
	{
		hit_ent = trace[#"entity"];
		level notify(#"hash_435816ec8f13c19b", {#hit_ent:hit_ent, #hash_90db0e3c:axe, #hash_ba14b770:self, #hash_f1445bd6:trace});
		if(isdefined(hit_ent))
		{
			if(isplayer(hit_ent))
			{
				if(isdefined(hit_ent.hasriotshield) && hit_ent.hasriotshield)
				{
					if(isdefined(hit_ent.hasriotshieldequipped) && hit_ent.hasriotshieldequipped)
					{
						if(hit_ent hasperk(#"specialty_shield") || hit_ent zm_utility::is_facing(axe, 0.2))
						{
							return 1;
						}
					}
					else if(!isdefined(hit_ent.riotshieldentity))
					{
						if(!hit_ent zm_utility::is_facing(axe, -0.2))
						{
							return 1;
						}
					}
				}
				hit_ent dodamage(50, axe.origin, self, self);
				hit_ent playsoundtoplayer(#"evt_player_swiped", hit_ent);
				return 1;
			}
			if(isai(hit_ent))
			{
				if(hit_ent.archetype === #"zombie")
				{
					if(isalive(hit_ent) && (!(isdefined(hit_ent.magic_bullet_shield) && hit_ent.magic_bullet_shield)) && !zm_utility::is_magic_bullet_shield_enabled(hit_ent))
					{
						gibserverutils::gibhead(hit_ent);
						hit_ent zm_cleanup::function_23621259();
						hit_ent kill();
						function_6eac4ca1(hit_ent, "attack_melee_notetrack");
					}
				}
			}
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_c3712093
	Namespace: namespace_c49f9e2b
	Checksum: 0x63241DED
	Offset: 0x6278
	Size: 0xD6
	Parameters: 3
	Flags: Linked, Private
*/
private function function_c3712093(axe, var_a4388d06, var_bb95ea0c)
{
	self endon(#"death");
	axe endon(#"death");
	while(true)
	{
		tag_pos = self gettagorigin(var_a4388d06);
		dist = distance(axe.origin, tag_pos);
		time = dist / var_bb95ea0c;
		if(time < 0.7)
		{
			break;
		}
		waitframe(1);
	}
	self.var_d5e9528 = 1;
}

/*
	Name: function_137ed431
	Namespace: namespace_c49f9e2b
	Checksum: 0xA606D119
	Offset: 0x6358
	Size: 0x2CE
	Parameters: 3
	Flags: Linked, Private
*/
private function function_137ed431(axe, var_a4388d06, var_9e7687f8)
{
	tag_pos = self gettagorigin(var_a4388d06);
	var_c6488229 = self gettagangles(var_a4388d06);
	var_bf72b943 = distance(axe.origin, tag_pos);
	var_bb95ea0c = 1200;
	interval_dist = var_bb95ea0c * 0.1;
	var_6cdcefc1 = interval_dist * interval_dist;
	total_dist = 0;
	max_dist = 500;
	var_7900b267 = vectornormalize(tag_pos - axe.origin);
	new_yaw = absangleclamp360(axe.angles[1] + 180);
	axe.angles = (0, new_yaw, 0);
	self thread function_c3712093(axe, var_a4388d06, var_bb95ea0c);
	while(true)
	{
		tag_pos = self gettagorigin(var_a4388d06);
		var_7900b267 = vectornormalize(tag_pos - axe.origin);
		move_pos = axe.origin + var_7900b267 * interval_dist;
		self function_88d65504(axe, var_7900b267, move_pos);
		axe moveto(move_pos, 0.1);
		wait(0.1);
		var_8abea022 = distancesquared(axe.origin, tag_pos);
		if(var_8abea022 < var_6cdcefc1)
		{
			break;
		}
	}
	axe clientfield::set("gladiator_axe_effect", 0);
	axe delete();
	self function_5be18f96();
	self.var_ba481973 = 0;
	self.axe_model = undefined;
}

/*
	Name: function_f6a04c04
	Namespace: namespace_c49f9e2b
	Checksum: 0xAC42B2E5
	Offset: 0x6630
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function function_f6a04c04()
{
	self attach("c_t8_zmb_dlc0_zombie_destroyer_le_arm1", "j_shoulder_le");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_ri_arm1", "j_clavicle_ri");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_helmet1", "j_head");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_le_pauldron1", "tag_pauldron_le");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_ri_pauldron1", "tag_pauldron_ri");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
	self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
	self.var_88d88318 = 1;
	self.var_fe593357 = 1;
}

/*
	Name: function_2617ff14
	Namespace: namespace_c49f9e2b
	Checksum: 0xC07E78D5
	Offset: 0x6770
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_2617ff14()
{
	self attach("c_t8_zmb_dlc0_zombie_marauder_helmet1");
}

/*
	Name: function_5be18f96
	Namespace: namespace_c49f9e2b
	Checksum: 0x615F1729
	Offset: 0x67A0
	Size: 0x236
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5be18f96(display = 1)
{
	if(self.var_34cc44de === "left")
	{
		if(display)
		{
			self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
			self.var_fe593357 = 1;
		}
		else if(isdefined(self.var_fe593357) && self.var_fe593357)
		{
			if(self isattached("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left"))
			{
				self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
			}
			self.var_fe593357 = 0;
		}
	}
	else if(display)
	{
		if(self.var_d9b1cc0e && self.var_fe593357)
		{
			if(self isattached("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left"))
			{
				self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
			}
			self.var_fe593357 = 0;
		}
		self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
		self.var_88d88318 = 1;
		if(self.var_d9b1cc0e)
		{
			self attach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_left");
			self.var_fe593357 = 1;
		}
	}
	else if(self.var_88d88318)
	{
		if(self isattached("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right"))
		{
			self detach("c_t8_zmb_dlc0_zombie_destroyer_axe1", "tag_weapon_right");
		}
		self.var_88d88318 = 0;
	}
}

/*
	Name: function_8a8841b0
	Namespace: namespace_c49f9e2b
	Checksum: 0x3B2E18A9
	Offset: 0x69E0
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8a8841b0()
{
	self.var_ba481973 = 1;
	if(self.var_34cc44de === "left")
	{
		self thread function_fbc2806e("tag_weapon_left", -1);
	}
	else
	{
		self thread function_fbc2806e("tag_weapon_right");
	}
}

/*
	Name: function_36fff581
	Namespace: namespace_c49f9e2b
	Checksum: 0xC9DCB5ED
	Offset: 0x6A58
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function function_36fff581(func)
{
	level.var_36fff581 = func;
}

/*
	Name: function_dfcfc03b
	Namespace: namespace_c49f9e2b
	Checksum: 0xC71485C1
	Offset: 0x6A80
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_dfcfc03b()
{
	if(isdefined(self.favoriteenemy))
	{
		predictedpos = self lastknownpos(self.favoriteenemy);
		if(isdefined(predictedpos))
		{
			turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
			return turnyaw;
		}
	}
	return undefined;
}

/*
	Name: function_831dd6bd
	Namespace: namespace_c49f9e2b
	Checksum: 0x59675F4A
	Offset: 0x6B18
	Size: 0x96E
	Parameters: 0
	Flags: Linked
*/
function function_831dd6bd()
{
	shouldrepath = 0;
	zigzag_activation_distance = level.zigzag_activation_distance;
	if(isdefined(self.zigzag_activation_distance))
	{
		zigzag_activation_distance = self.zigzag_activation_distance;
	}
	if(!shouldrepath && isdefined(self.favoriteenemy))
	{
		pathgoalpos = self.pathgoalpos;
		if(!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime())
		{
			shouldrepath = 1;
		}
		else if(distancesquared(self.origin, self.favoriteenemy.origin) <= zigzag_activation_distance * zigzag_activation_distance)
		{
			shouldrepath = 1;
		}
		else if(isdefined(pathgoalpos))
		{
			distancetogoalsqr = distancesquared(self.origin, pathgoalpos);
			shouldrepath = distancetogoalsqr < 72 * 72;
		}
	}
	if(isdefined(level.validate_on_navmesh) && level.validate_on_navmesh)
	{
		if(!ispointonnavmesh(self.origin, self))
		{
			shouldrepath = 0;
		}
	}
	if(isdefined(self.keep_moving) && self.keep_moving)
	{
		if(gettime() > self.keep_moving_time)
		{
			self.keep_moving = 0;
		}
	}
	if(self function_dd070839())
	{
		shouldrepath = 0;
	}
	if(shouldrepath)
	{
		if(isplayer(self.favoriteenemy))
		{
			goalent = namespace_e0710ee6::function_a2e8fd7b(self, self.favoriteenemy);
			if(isdefined(goalent.last_valid_position))
			{
				goalpos = getclosestpointonnavmesh(goalent.last_valid_position, 64, self getpathfindingradius());
				if(!isdefined(goalpos))
				{
					goalpos = goalent.origin;
				}
			}
			else
			{
				goalpos = goalent.origin;
			}
		}
		else
		{
			goalpos = getclosestpointonnavmesh(self.favoriteenemy.origin, 64, self getpathfindingradius());
			if(!isdefined(goalpos) && self.favoriteenemy function_dd070839() && isdefined(self.favoriteenemy.traversestartnode))
			{
				goalpos = self.favoriteenemy.traversestartnode.origin;
			}
			if(!isdefined(goalpos))
			{
				goalpos = self.origin;
			}
		}
		self zm_utility::function_64259898(goalpos);
		should_zigzag = 1;
		if(isdefined(level.should_zigzag))
		{
			should_zigzag = self [[level.should_zigzag]]();
		}
		else if(isdefined(self.should_zigzag))
		{
			should_zigzag = self.should_zigzag;
		}
		if(isdefined(self.var_592a8227))
		{
			should_zigzag = should_zigzag && self.var_592a8227;
		}
		var_eb1c6f1c = 0;
		if(isdefined(level.do_randomized_zigzag_path) && level.do_randomized_zigzag_path && should_zigzag)
		{
			if(distancesquared(self.origin, goalpos) > zigzag_activation_distance * zigzag_activation_distance)
			{
				self.keep_moving = 1;
				self.keep_moving_time = gettime() + 250;
				path = self calcapproximatepathtoposition(goalpos, 0);
				/#
					if(getdvarint(#"ai_debugzigzag", 0))
					{
						for(index = 1; index < path.size; index++)
						{
							recordline(path[index - 1], path[index], (1, 0.5, 0), "", self);
							record3dtext(abs(path[index - 1][2] - path[index][2]), path[index - 1], (1, 0, 0));
						}
					}
				#/
				deviationdistance = randomintrange(level.zigzag_distance_min, level.zigzag_distance_max);
				if(isdefined(self.zigzag_distance_min) && isdefined(self.zigzag_distance_max))
				{
					deviationdistance = randomintrange(self.zigzag_distance_min, self.zigzag_distance_max);
				}
				segmentlength = 0;
				for(index = 1; index < path.size; index++)
				{
					if(isdefined(level.var_562c8f67) && abs(path[index - 1][2] - path[index][2]) > level.var_562c8f67)
					{
						break;
					}
					currentseglength = distance(path[index - 1], path[index]);
					var_570a7c72 = segmentlength + currentseglength > deviationdistance;
					if(index == path.size - 1 && !var_570a7c72)
					{
						deviationdistance = segmentlength + currentseglength - 1;
						var_eb1c6f1c = 1;
					}
					if(var_570a7c72 || var_eb1c6f1c)
					{
						remaininglength = deviationdistance - segmentlength;
						seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
						/#
							recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
						#/
						innerzigzagradius = level.inner_zigzag_radius;
						if(var_eb1c6f1c)
						{
							innerzigzagradius = 0;
						}
						else if(isdefined(self.inner_zigzag_radius))
						{
							innerzigzagradius = self.inner_zigzag_radius;
						}
						outerzigzagradius = level.outer_zigzag_radius;
						if(var_eb1c6f1c)
						{
							outerzigzagradius = 48;
						}
						else if(isdefined(self.outer_zigzag_radius))
						{
							outerzigzagradius = self.outer_zigzag_radius;
						}
						queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, self, 16);
						positionquery_filter_inclaimedlocation(queryresult, self);
						if(queryresult.data.size > 0)
						{
							a_data = array::randomize(queryresult.data);
							for(i = 0; i < a_data.size; i++)
							{
								point = a_data[i];
								n_z_diff = seedposition[2] - point.origin[2];
								if(abs(n_z_diff) < 32)
								{
									self zm_utility::function_64259898(point.origin);
									break;
								}
							}
						}
						break;
					}
					segmentlength = segmentlength + currentseglength;
				}
			}
		}
		self.nextgoalupdate = gettime() + randomintrange(500, 1000);
		return 1;
	}
	return 0;
}

/*
	Name: function_24a38427
	Namespace: namespace_c49f9e2b
	Checksum: 0x80FC7019
	Offset: 0x7490
	Size: 0x358
	Parameters: 0
	Flags: Private
*/
private function function_24a38427()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			string = getdvarstring(#"hash_1a45d40a78c47d72", "");
			cmd = strtok(string, "");
			gladiators = getaiarchetypearray(#"gladiator");
			if(cmd.size > 0)
			{
				switch(cmd[0])
				{
					case "spawn_marauder":
					{
						zm_devgui::spawn_archetype("");
						break;
					}
					case "spawn_destroyer":
					{
						zm_devgui::spawn_archetype("");
						break;
					}
					case "kill":
					{
						zm_devgui::kill_archetype(#"gladiator");
						break;
					}
					case "spread":
					{
						if(getdvarint(#"ai_debugzigzag", 0))
						{
							setdvar(#"ai_debugzigzag", 0);
						}
						else
						{
							setdvar(#"ai_debugzigzag", 1);
						}
						break;
					}
					case "hash_740a35d058f71a4c":
					{
						break;
					}
					case "hash_250613ea7c45ec3e":
					{
						gladiators[0] hidepart("", "", 1);
						name = getpartname(gladiators[0], 83);
						break;
					}
					case "attach_right":
					{
						break;
					}
					case "detach_right":
					{
						gladiators[0] hidepart("", "", 1);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			setdvar(#"hash_1a45d40a78c47d72", "");
		}
	#/
}

