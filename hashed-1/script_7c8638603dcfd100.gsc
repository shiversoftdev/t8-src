// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2590a7d3d152c500;
#using script_2c5daa95f8fec03c;
#using script_35598499769dbb3d;
#using script_3657077a08b7f19e;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_567f1ada8fe29a1c;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_7b7ed6e4bc963a51;
#using script_7e59d7bba853fe4b;
#using script_bd2b8aaa388dcce;
#using script_caf007e2a98afa2;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_bd668ff;

/*
	Name: function_89f2df9
	Namespace: namespace_bd668ff
	Checksum: 0x3DC794FA
	Offset: 0x628
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5ecf1967e7cb0189", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bd668ff
	Checksum: 0x971B73C
	Offset: 0x678
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"gegenees", &function_aad04bcc);
	registerbehaviorscriptfunctions();
	namespace_7bed886b::function_ce64b76b();
	spawner::add_archetype_spawn_function(#"gegenees", &function_7a9d4231);
	clientfield::register("actor", "gegenees_shield_blast_effect", 16000, 1, "counter");
	clientfield::register("actor", "gegenees_shield_guard_effect", 16000, 1, "int");
	clientfield::register("actor", "gegenees_spear_tip_effect", 16000, 1, "int");
	clientfield::register("actor", "gegenees_spear_tip_tell_effect", 16000, 1, "int");
	clientfield::register("toplayer", "gegenees_damage_cf", 16000, 1, "counter");
	clientfield::register("scriptmover", "gegenees_spear_miss_cf", 16000, 1, "counter");
	clientfield::register("actor", "gegenees_helmet_explosion_cf", 16000, 1, "int");
	level thread aat::register_immunity("zm_aat_brain_decay", #"gegenees", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"gegenees", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"gegenees", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"gegenees", 1, 1, 1);
	/#
		if(isarchetypeloaded(#"gegenees"))
		{
			level thread function_c03e8d05();
		}
		spawner::add_archetype_spawn_function(#"gegenees", &zombie_utility::function_27ba8249);
	#/
}

/*
	Name: __main__
	Namespace: namespace_bd668ff
	Checksum: 0xA9753A27
	Offset: 0x9A8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.var_8c5f46f1 = [];
	for(i = 0; i < 8; i++)
	{
		level.var_8c5f46f1[level.var_8c5f46f1.size] = spawn("script_model", (0, 0, 0));
	}
}

/*
	Name: function_aad04bcc
	Namespace: namespace_bd668ff
	Checksum: 0x6097AC9
	Offset: 0xA20
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_aad04bcc()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_a6dba7fd;
}

/*
	Name: function_a6dba7fd
	Namespace: namespace_bd668ff
	Checksum: 0xE5D4344B
	Offset: 0xA78
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a6dba7fd(entity)
{
	entity.__blackboard = undefined;
	entity function_aad04bcc();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_bd668ff
	Checksum: 0x8820018F
	Offset: 0xAB0
	Size: 0x91C
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_1ee28008));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5bc9e3d90931788", &function_1ee28008, 1);
	/#
		assert(isscriptfunctionptr(&function_d5d3aa77));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2bc0d801acaee9a4", &function_d5d3aa77);
	/#
		assert(isscriptfunctionptr(&function_4334cc3b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4053e75ff0301438", &function_4334cc3b);
	/#
		assert(isscriptfunctionptr(&function_a953d80d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1075ab617f39c601", &function_a953d80d);
	/#
		assert(isscriptfunctionptr(&function_7f34a57c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1e595daa404c5a3d", &function_7f34a57c);
	/#
		assert(isscriptfunctionptr(&function_75db4aba));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7e22610d7293179e", &function_75db4aba);
	/#
		assert(isscriptfunctionptr(&function_d344063a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d6949a6c9ec0081", &function_d344063a);
	/#
		assert(isscriptfunctionptr(&function_e0b648bb));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f89573df60550e1", &function_e0b648bb);
	/#
		assert(isscriptfunctionptr(&function_3133f922));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6f4458058e881523", &function_3133f922);
	/#
		assert(isscriptfunctionptr(&function_d82de95f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_16cf6fd0904e492f", &function_d82de95f);
	/#
		assert(isscriptfunctionptr(&function_564b9cf5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_74ab5c3ab4cbfdda", &function_564b9cf5);
	/#
		assert(isscriptfunctionptr(&function_7505908b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_572453d6d6540a73", &function_7505908b);
	/#
		assert(isscriptfunctionptr(&function_9175e656));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1f9cdbd55afb3860", &function_9175e656);
	/#
		assert(isscriptfunctionptr(&function_c81af561));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2c97edb3312da9c6", &function_c81af561);
	/#
		assert(isscriptfunctionptr(&function_47fdaf31));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_471802b111fa1af0", &function_47fdaf31);
	/#
		assert(isscriptfunctionptr(&function_ebf730ee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e737f26ad26044", &function_ebf730ee);
	/#
		assert(isscriptfunctionptr(&function_3839537e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3246ea8d9722e46e", &function_3839537e);
	/#
		assert(!isdefined(&function_2301c0a7) || isscriptfunctionptr(&function_2301c0a7));
	#/
	/#
		assert(!isdefined(&function_c2155e05) || isscriptfunctionptr(&function_c2155e05));
	#/
	/#
		assert(!isdefined(&function_15502a5) || isscriptfunctionptr(&function_15502a5));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_49454f4516c40e65", &function_2301c0a7, &function_c2155e05, &function_15502a5);
	animationstatenetwork::registeranimationmocomp("mocomp_gegenees_shield", &function_d645d2ec, &function_f6bb8a07, &function_64c4573);
	animationstatenetwork::registernotetrackhandlerfunction("gegenees_melee", &function_c3c86ec1);
	animationstatenetwork::registernotetrackhandlerfunction("geg_throw_spear", &function_7fe60e9e);
	animationstatenetwork::registernotetrackhandlerfunction("geg_grab_spear", &function_4d6e95b6);
	animationstatenetwork::registernotetrackhandlerfunction("gegenees_weapon_drop", &function_43104218);
}

/*
	Name: function_d4f5b993
	Namespace: namespace_bd668ff
	Checksum: 0xCB5E3093
	Offset: 0x13D8
	Size: 0xE4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d4f5b993(entity, eventname)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	var_b3a11ca1 = blackboard::getblackboardevents(eventname);
	if(isdefined(var_b3a11ca1) && var_b3a11ca1.size)
	{
		foreach(var_8d7c592b in var_b3a11ca1)
		{
			if(var_8d7c592b.data.favoriteenemy === entity.favoriteenemy)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_697a9b7f
	Namespace: namespace_bd668ff
	Checksum: 0xF79FC5B2
	Offset: 0x14C8
	Size: 0xF8
	Parameters: 3
	Flags: Linked, Private
*/
private function function_697a9b7f(entity, minrange, maxrange)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(isdefined(entity.var_b491d096))
	{
		return 0;
	}
	if(!isdefined(minrange))
	{
		minrange = 200;
	}
	if(!isdefined(maxrange))
	{
		maxrange = 1000;
	}
	withinrange = distancesquared(entity.origin, entity.favoriteenemy.origin) <= maxrange * maxrange;
	withinrange = withinrange && distancesquared(entity.origin, entity.favoriteenemy.origin) >= minrange * minrange;
	return withinrange;
}

/*
	Name: function_180db9a7
	Namespace: namespace_bd668ff
	Checksum: 0x9F722305
	Offset: 0x15C8
	Size: 0x9A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_180db9a7(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(isdefined(entity.var_b491d096))
	{
		return 0;
	}
	can_see = bullettracepassed(entity.origin + vectorscale((0, 0, 1), 36), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 36), 0, undefined);
	return can_see;
}

/*
	Name: function_4b8e0aab
	Namespace: namespace_bd668ff
	Checksum: 0xE1740985
	Offset: 0x1670
	Size: 0x10E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4b8e0aab(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(isdefined(entity.var_b491d096))
	{
		return 0;
	}
	can_see = 0;
	trace = physicstrace(entity.origin + vectorscale((0, 0, 1), 48), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 36), (-16, -16, -12), (16, 16, 12), entity);
	if(trace[#"fraction"] == 1 || trace[#"entity"] === entity.favoriteenemy)
	{
		can_see = 1;
	}
	return can_see;
}

/*
	Name: function_7f34a57c
	Namespace: namespace_bd668ff
	Checksum: 0x456845D6
	Offset: 0x1788
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_7f34a57c(entity)
{
	if(function_697a9b7f(entity) && function_4b8e0aab(entity) && function_d4f5b993(entity, "geg_spear_attack"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_7fe60e9e
	Namespace: namespace_bd668ff
	Checksum: 0x3E70D155
	Offset: 0x17F8
	Size: 0x4E4
	Parameters: 1
	Flags: Linked
*/
function function_7fe60e9e(entity)
{
	var_d86ae1c4 = spawnstruct();
	var_d86ae1c4.favoriteenemy = entity.favoriteenemy;
	blackboard::addblackboardevent("geg_spear_attack", var_d86ae1c4, randomintrange(8500, 10000));
	if(!isactor(entity) || !isdefined(entity.favoriteenemy))
	{
		return;
	}
	targetpos = entity.favoriteenemy.origin;
	launchpos = entity gettagorigin("tag_inhand");
	var_ad804014 = 5;
	if(distancesquared(targetpos, entity.origin) > 250 * 250)
	{
		velocity = entity.favoriteenemy getvelocity();
		targetpos = targetpos + velocity * 0.5;
		var_a76a363d = math::randomsign() * randomint(var_ad804014);
		var_9b241db1 = math::randomsign() * randomint(var_ad804014);
		targetpos = targetpos + (var_a76a363d, var_9b241db1, 0);
		speed = length(velocity);
		if(speed > 0)
		{
			var_7ee6937e = vectornormalize((targetpos[0], targetpos[1], 0) - (launchpos[0], launchpos[1], 0));
			dot = vectordot(-1 * var_7ee6937e, velocity / speed);
			if(dot >= 0.8)
			{
				targetpos = targetpos + var_7ee6937e * dot * speed * 0.5;
			}
		}
	}
	targetpos = targetpos + vectorscale((0, 0, 1), 36);
	var_872c6826 = vectortoangles(targetpos - launchpos);
	angles = function_cc68801f(launchpos, targetpos, 1110, getdvarfloat(#"bg_lowgravity", 0));
	if(isdefined(angles) && angles[#"hash_1d5798eaa3bed36c"] > 0)
	{
		dir = anglestoforward((-1 * angles[#"hash_1d5798eaa3bed36c"], var_872c6826[1], var_872c6826[2]));
	}
	else
	{
		dir = anglestoforward(var_872c6826);
	}
	velocity = dir * 1110;
	var_1a3b2274 = "gegenees_spear_projectile";
	if(isdefined(entity.var_e946c8e8) && entity.var_e946c8e8)
	{
		var_1a3b2274 = "gegenees_golden_spear_projectile";
	}
	var_ed782d5 = getweapon(var_1a3b2274);
	var_a137cb9f = entity gettagorigin("tag_inhand");
	var_eb549b4f = entity.favoriteenemy.origin;
	projectile = magicbullet(var_ed782d5, var_a137cb9f, var_eb549b4f, entity, entity.favoriteenemy);
	projectile thread function_7d162bd0(projectile, entity);
	entity function_59e9f77b();
}

/*
	Name: function_61d12301
	Namespace: namespace_bd668ff
	Checksum: 0xFA1A3262
	Offset: 0x1CE8
	Size: 0x56
	Parameters: 1
	Flags: Private
*/
private function function_61d12301(projectile)
{
	projectile endon(#"death");
	result = undefined;
	result = projectile waittill(#"damage");
	projectile.isdamaged = 1;
}

/*
	Name: watch_for_death
	Namespace: namespace_bd668ff
	Checksum: 0x9C6C6747
	Offset: 0x1D48
	Size: 0x38
	Parameters: 1
	Flags: Private
*/
private function watch_for_death(projectile)
{
	projectile waittill(#"death");
	waittillframeend();
	projectile notify(#"hash_2f76a2bbdf38f407");
}

/*
	Name: function_a1fce938
	Namespace: namespace_bd668ff
	Checksum: 0x8DAFB75C
	Offset: 0x1D88
	Size: 0x9E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a1fce938()
{
	foreach(var_b12a43cc in level.var_8c5f46f1)
	{
		if(!(isdefined(var_b12a43cc.in_use) && var_b12a43cc.in_use))
		{
			var_b12a43cc.in_use = 1;
			return var_b12a43cc;
		}
	}
	return undefined;
}

/*
	Name: function_7e633e59
	Namespace: namespace_bd668ff
	Checksum: 0x6802A51B
	Offset: 0x1E30
	Size: 0x138
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7e633e59()
{
	zombies = getaiteamarray(level.zombie_team);
	var_86bf21bc = self.origin;
	foreach(zombie in zombies)
	{
		if(!isalive(zombie))
		{
			continue;
		}
		if(zombie.archetype === #"gegenees")
		{
			continue;
		}
		dist_sq = distancesquared(var_86bf21bc, zombie.origin);
		if(dist_sq < 10000)
		{
			zombie thread zombie_utility::setup_zombie_knockdown(var_86bf21bc);
			util::wait_network_frame();
		}
	}
}

/*
	Name: function_7d162bd0
	Namespace: namespace_bd668ff
	Checksum: 0x3D15FDF5
	Offset: 0x1F70
	Size: 0x19C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_7d162bd0(projectile, entity)
{
	projectile endon(#"hash_2f76a2bbdf38f407");
	result = undefined;
	result = projectile waittill(#"projectile_impact_player", #"death");
	if(result._notify != "projectile_impact_player")
	{
		var_b12a43cc = function_a1fce938();
		if(isdefined(var_b12a43cc))
		{
			if(isdefined(projectile.origin))
			{
				projectile thread function_7e633e59();
				var_b12a43cc.origin = projectile.origin;
			}
			else if(isdefined(entity) && isdefined(entity.favoriteenemy))
			{
				var_b12a43cc.origin = entity.favoriteenemy.origin;
			}
			util::wait_network_frame();
			var_b12a43cc clientfield::increment("gegenees_spear_miss_cf");
			wait(0.25);
			var_b12a43cc.in_use = 0;
		}
	}
	else if(isdefined(result.player))
	{
		result.player clientfield::increment_to_player("gegenees_damage_cf");
	}
}

/*
	Name: function_4d6e95b6
	Namespace: namespace_bd668ff
	Checksum: 0x4A322DD0
	Offset: 0x2118
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4d6e95b6(entity)
{
	entity function_d06af584();
}

/*
	Name: function_43104218
	Namespace: namespace_bd668ff
	Checksum: 0xD2E09726
	Offset: 0x2148
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_43104218(entity)
{
	destructserverutils::function_9885f550(entity, "left_hand", "tag_weapon_left");
	destructserverutils::function_9885f550(entity, "right_hand", "tag_weapon_right");
	destructserverutils::function_9885f550(entity, "right_arm_upper", "tag_inhand");
}

/*
	Name: function_e0b648bb
	Namespace: namespace_bd668ff
	Checksum: 0xCD50153A
	Offset: 0x21D8
	Size: 0xCA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e0b648bb(entity)
{
	if(isdefined(entity.var_d7e69143) && entity.var_d7e69143)
	{
		if(isdefined(entity.zombie_poi) && isdefined(entity.zombie_poi[1]))
		{
			dist_sq = distancesquared(entity.origin, entity.zombie_poi[1].origin);
			melee_dist_sq = zombiebehavior::function_997f1224(entity);
			if(dist_sq < melee_dist_sq)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_d344063a
	Namespace: namespace_bd668ff
	Checksum: 0x19947BF2
	Offset: 0x22B0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d344063a(entity)
{
	if(isdefined(entity.var_d64b7af0) && entity.var_d64b7af0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_47fdaf31
	Namespace: namespace_bd668ff
	Checksum: 0x792A9775
	Offset: 0x22F0
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_47fdaf31(entity)
{
	entity.var_d64b7af0 = 0;
}

/*
	Name: function_ebf730ee
	Namespace: namespace_bd668ff
	Checksum: 0xD3DF58C0
	Offset: 0x2318
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ebf730ee(entity)
{
	entity function_d06af584();
	zm_behavior::function_bdedea72(entity);
}

/*
	Name: function_3839537e
	Namespace: namespace_bd668ff
	Checksum: 0x7AE309FC
	Offset: 0x2360
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3839537e(entity)
{
	if(!isdefined(entity.zombie_poi))
	{
		return;
	}
	poi_ent = entity.zombie_poi[1];
	if(isdefined(poi_ent.damagearea))
	{
		poi_ent.damagearea delete();
	}
	poi_ent delete();
}

/*
	Name: function_75db4aba
	Namespace: namespace_bd668ff
	Checksum: 0x8F127CD4
	Offset: 0x23E8
	Size: 0x100
	Parameters: 1
	Flags: Linked, Private
*/
private function function_75db4aba(entity)
{
	/#
		if(isdefined(entity.var_89b5e1e) && entity.var_89b5e1e)
		{
			return 1;
		}
	#/
	var_98c55679 = 0;
	var_a4017acd = 0.1 * entity.maxhealth;
	if(isdefined(entity.shielddamage))
	{
		if(entity.shielddamage > var_a4017acd)
		{
			var_98c55679 = 1;
		}
	}
	if(!var_98c55679)
	{
		return 0;
	}
	if(function_697a9b7f(entity, 300, 1200) && function_180db9a7(entity) && function_d4f5b993(entity, "geg_shield_attack"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_3133f922
	Namespace: namespace_bd668ff
	Checksum: 0xB86FDFB7
	Offset: 0x24F0
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3133f922(entity)
{
	entity.var_7b0667d9 = 1;
	entity.var_8a43ee27 = entity.favoriteenemy;
}

/*
	Name: function_d82de95f
	Namespace: namespace_bd668ff
	Checksum: 0x2DAA7C75
	Offset: 0x2530
	Size: 0x286
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d82de95f(entity)
{
	var_d7c9d429 = spawnstruct();
	var_d7c9d429.favoriteenemy = entity.var_8a43ee27;
	blackboard::addblackboardevent("geg_shield_attack", var_d7c9d429, randomintrange(2000, 3000));
	entity notify(#"hash_10501c0a873461f9");
	entity clientfield::increment("gegenees_shield_blast_effect");
	if(isdefined(entity.var_8a43ee27))
	{
		var_336c515d = 1;
		blast_origin = entity gettagorigin("j_gegenees_shield");
		forward_angles = anglestoforward(entity.angles);
		if(isdefined(blast_origin) && isdefined(forward_angles))
		{
			end_pos = blast_origin + forward_angles * 1200;
			test_origin = entity.var_8a43ee27 getcentroid();
			radial_origin = pointonsegmentnearesttopoint(blast_origin, end_pos, test_origin);
			var_caf24228 = distancesquared(test_origin, radial_origin);
			if(var_caf24228 > 4096)
			{
				var_336c515d = 0;
			}
			var_336c515d = bullettracepassed(blast_origin, test_origin, 0, undefined);
			if(var_336c515d)
			{
				entity.var_8a43ee27 status_effect::status_effect_apply(function_4d1e7b48(#"hash_706608d269d2fefc"), undefined, entity, undefined, 2000);
				entity.var_8a43ee27 thread function_60164697();
				entity.var_8a43ee27 clientfield::increment_to_player("gegenees_damage_cf");
			}
		}
	}
	entity.shielddamage = 0;
	entity.var_8a43ee27 = undefined;
}

/*
	Name: function_60164697
	Namespace: namespace_bd668ff
	Checksum: 0x4A234442
	Offset: 0x27C0
	Size: 0x76
	Parameters: 0
	Flags: Linked, Private
*/
private function function_60164697()
{
	self endon(#"death", #"disconnect");
	while(true)
	{
		if(gettime() > time)
		{
			break;
		}
		self playrumbleonentity("damage_heavy");
		waitframe(1);
	}
}

/*
	Name: function_564b9cf5
	Namespace: namespace_bd668ff
	Checksum: 0x35C1A9EB
	Offset: 0x2840
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_564b9cf5(entity)
{
	entity.var_7b0667d9 = 0;
}

/*
	Name: function_2301c0a7
	Namespace: namespace_bd668ff
	Checksum: 0xEA062710
	Offset: 0x2868
	Size: 0xF0
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2301c0a7(entity, asmstatename)
{
	entity.track_enemy = 1;
	entity.var_1ec6ea5d = gettime() + int(entity ai::function_9139c839().var_3422adfd * 1000);
	entity.var_292d3a3b = gettime() + int(entity ai::function_9139c839().var_5d9f2696 * 1000);
	entity clientfield::set("gegenees_shield_guard_effect", 1);
	/#
		entity.var_89b5e1e = 0;
	#/
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: function_c2155e05
	Namespace: namespace_bd668ff
	Checksum: 0x8B1677DA
	Offset: 0x2960
	Size: 0x90
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c2155e05(entity, asmstatename)
{
	if(isdefined(entity.track_enemy) && entity.track_enemy)
	{
		if(isdefined(entity.var_292d3a3b))
		{
			if(gettime() > entity.var_292d3a3b)
			{
				entity.track_enemy = 0;
			}
		}
	}
	if(isdefined(entity.var_1ec6ea5d))
	{
		if(gettime() < entity.var_1ec6ea5d)
		{
			return 5;
		}
	}
	return 4;
}

/*
	Name: function_15502a5
	Namespace: namespace_bd668ff
	Checksum: 0x70B3B612
	Offset: 0x29F8
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function function_15502a5(entity, asmstatename)
{
	entity clientfield::set("gegenees_shield_guard_effect", 0);
	return 4;
}

/*
	Name: function_7505908b
	Namespace: namespace_bd668ff
	Checksum: 0x5F22889F
	Offset: 0x2A38
	Size: 0x5E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7505908b(entity)
{
	entity.var_7b0667d9 = 1;
	entity clientfield::set("gegenees_spear_tip_tell_effect", 1);
	entity.var_5613e89f = 1;
	entity.var_378ab780 = gettime() + 250;
}

/*
	Name: function_9175e656
	Namespace: namespace_bd668ff
	Checksum: 0xDB01F801
	Offset: 0x2AA0
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9175e656(entity)
{
	if(isdefined(entity.var_5613e89f) && entity.var_5613e89f)
	{
		if(gettime() > entity.var_378ab780)
		{
			entity.var_5613e89f = 0;
			entity clientfield::set("gegenees_spear_tip_tell_effect", 0);
		}
	}
}

/*
	Name: function_c81af561
	Namespace: namespace_bd668ff
	Checksum: 0xB1A29B80
	Offset: 0x2B18
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c81af561(entity)
{
	entity.var_7b0667d9 = 0;
}

/*
	Name: function_1ee28008
	Namespace: namespace_bd668ff
	Checksum: 0x76DF42DF
	Offset: 0x2B40
	Size: 0x3AA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1ee28008(entity)
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
	/#
		if(isdefined(entity.var_7671b967) && entity.var_7671b967)
		{
			entity setgoal(entity.origin);
			return 0;
		}
	#/
	entity.zombie_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
	entity zombie_utility::run_ignore_player_handler();
	entity.favoriteenemy = entity.var_93a62fe;
	entity.var_d7e69143 = 0;
	if(isdefined(entity.zombie_poi) && isdefined(entity.zombie_poi[1]))
	{
		var_eee191fa = 1;
		if(isdefined(entity.zombie_poi[1].var_8305fd51))
		{
			if(entity.zombie_poi[1].var_8305fd51 == #"hash_27e4878539bc7f72" || entity.zombie_poi[1].var_8305fd51 == #"charon_pool")
			{
				var_eee191fa = 0;
				entity.zombie_poi = undefined;
			}
		}
		if(var_eee191fa)
		{
			entity.var_d7e69143 = 1;
			entity.var_b491d096 = entity.zombie_poi[1];
			goalpos = entity.zombie_poi[0];
			return entity zm_utility::function_64259898(goalpos);
		}
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
	goalent = entity.favoriteenemy;
	if(isplayer(goalent))
	{
		goalent = namespace_e0710ee6::function_a2e8fd7b(entity, entity.favoriteenemy);
	}
	return entity zm_utility::function_64259898(goalent.origin);
}

/*
	Name: function_d5d3aa77
	Namespace: namespace_bd668ff
	Checksum: 0x99B6F250
	Offset: 0x2EF8
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d5d3aa77(entity)
{
	enemy = entity.favoriteenemy;
	if(isdefined(enemy) && isalive(enemy))
	{
		dist_sq = distancesquared(entity.origin, enemy.origin);
		if(dist_sq > 302500)
		{
			entity setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
		}
		if(dist_sq < 202500)
		{
			entity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
		}
	}
}

/*
	Name: function_4334cc3b
	Namespace: namespace_bd668ff
	Checksum: 0xDA2B721A
	Offset: 0x2FD8
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4334cc3b(entity)
{
	if(self.var_c63e2811 > gettime())
	{
		self setblackboardattribute("_gegenees_shield", "shield_up");
	}
	else
	{
		self setblackboardattribute("_gegenees_shield", "shield_down");
	}
}

/*
	Name: function_a953d80d
	Namespace: namespace_bd668ff
	Checksum: 0x6EF45336
	Offset: 0x3048
	Size: 0x12A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a953d80d(entity)
{
	enemies = getaiarchetypearray(#"zombie");
	enemies = arraycombine(enemies, getaiarchetypearray(#"hash_1bab8a0ba811401e"), 0, 0);
	enemies = array::filter(enemies, 0, &function_3d752709, entity);
	foreach(enemy in enemies)
	{
		enemy zombie_utility::setup_zombie_knockdown(entity);
		enemy.knockdown_type = "knockdown_shoved";
	}
}

/*
	Name: function_3d752709
	Namespace: namespace_bd668ff
	Checksum: 0xDAAECA5D
	Offset: 0x3180
	Size: 0x1A8
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3d752709(enemy, target)
{
	if(isdefined(enemy.knockdown) && enemy.knockdown)
	{
		return 0;
	}
	if(gibserverutils::isgibbed(enemy, 384))
	{
		return 0;
	}
	if(distancesquared(enemy.origin, target.origin) > self ai::function_9139c839().var_ef908ac8 * self ai::function_9139c839().var_ef908ac8)
	{
		return 0;
	}
	var_f2fb414f = anglestoforward(target.angles);
	var_9349139f = enemy.origin - target.origin;
	var_3e3c8075 = (var_9349139f[0], var_9349139f[1], 0);
	var_c2ee8451 = (var_f2fb414f[0], var_f2fb414f[1], 0);
	var_3e3c8075 = vectornormalize(var_3e3c8075);
	var_c2ee8451 = vectornormalize(var_c2ee8451);
	var_34e02165 = vectordot(var_c2ee8451, var_3e3c8075);
	if(var_34e02165 < 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_d645d2ec
	Namespace: namespace_bd668ff
	Checksum: 0x9BBA916F
	Offset: 0x3330
	Size: 0xC4
	Parameters: 5
	Flags: Linked
*/
function function_d645d2ec(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.var_8a43ee27))
	{
		to_enemy = entity.var_8a43ee27.origin - entity.origin;
		angles_to_enemy = vectortoangles(to_enemy);
		entity orientmode("face angle", angles_to_enemy);
	}
	else
	{
		entity orientmode("face current");
	}
}

/*
	Name: function_f6bb8a07
	Namespace: namespace_bd668ff
	Checksum: 0x73163FB2
	Offset: 0x3400
	Size: 0xE4
	Parameters: 5
	Flags: Linked
*/
function function_f6bb8a07(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.track_enemy) && entity.track_enemy)
	{
		if(isdefined(entity.var_8a43ee27))
		{
			to_enemy = entity.var_8a43ee27.origin - entity.origin;
			angles_to_enemy = vectortoangles(to_enemy);
			entity orientmode("face angle", angles_to_enemy);
		}
		return;
	}
	entity orientmode("face current");
}

/*
	Name: function_64c4573
	Namespace: namespace_bd668ff
	Checksum: 0x6FBD2400
	Offset: 0x34F0
	Size: 0x4C
	Parameters: 5
	Flags: Linked
*/
function function_64c4573(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face default");
}

/*
	Name: function_c3c86ec1
	Namespace: namespace_bd668ff
	Checksum: 0x7CF130AE
	Offset: 0x3548
	Size: 0x13A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c3c86ec1(entity)
{
	hitent = entity melee();
	/#
		record3dtext("", self.origin, (1, 0, 0), "", entity);
	#/
	if(isdefined(hitent) && isplayer(hitent))
	{
		entity function_376a5549(hitent);
		hitent clientfield::increment_to_player("gegenees_damage_cf");
	}
	if(isdefined(entity.var_d7e69143) && entity.var_d7e69143)
	{
		if(isdefined(entity.zombie_poi) && isdefined(entity.zombie_poi[1]))
		{
			entity.zombie_poi[1] notify(#"hash_90cfd38343f41f2");
		}
		entity.var_d7e69143 = 0;
	}
}

/*
	Name: function_376a5549
	Namespace: namespace_bd668ff
	Checksum: 0xA583A576
	Offset: 0x3690
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_376a5549(enemy)
{
	forward = anglestoforward(self.angles);
	velocity = enemy getvelocity();
	var_886d7387 = 500;
	var_886d7387 = 200 + randomint(var_886d7387 - 200);
	enemy setvelocity(velocity + forward * var_886d7387);
}

/*
	Name: function_7a9d4231
	Namespace: namespace_bd668ff
	Checksum: 0x1A0C36F3
	Offset: 0x3740
	Size: 0x276
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7a9d4231()
{
	self.var_126d7bef = 1;
	self.ignore_nuke = 1;
	if(!(isdefined(level.var_a2831281) && level.var_a2831281) && !namespace_32192f7::is_active() && !namespace_5869722f::function_ff2a74e7(#"blight_father") && (!(isdefined(level.var_f300b600) && level.var_f300b600)))
	{
		self.ignore_enemy_count = 1;
	}
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.cant_move_cb = &zombiebehavior::function_79fe956f;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self setblackboardattribute("_gegenees_shield", "shield_down");
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
	self.zombie_move_speed = "walk";
	self collidewithactors(1);
	self.ignorepathenemyfightdist = 1;
	level thread zm_spawner::zombie_death_event(self);
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	self thread zm_audio::zmbaivox_notifyconvert();
	self thread zm_audio::play_ambient_zombie_vocals();
	aiutility::addaioverridedamagecallback(self, &function_ca5688e3);
	self callback::on_ai_killed(&function_a231dd3b);
	target_set(self);
	self function_3f8833df();
	self.var_cc7959e1 = 1;
	self.var_a9716e54 = 0;
	self.var_c63e2811 = 0;
	self.var_68139d12 = 1;
}

/*
	Name: function_3f8833df
	Namespace: namespace_bd668ff
	Checksum: 0x6F58CDB2
	Offset: 0x39C0
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3f8833df()
{
	self attach("c_t8_zmb_dlc2_gegenees_shield", "tag_weapon_left");
	self attach("c_t8_zmb_dlc2_gegenees_sword", "tag_weapon_right");
	self attach("c_t8_zmb_dlc2_gegenees_helmet1", "j_head");
	self function_d06af584();
}

/*
	Name: function_59e9f77b
	Namespace: namespace_bd668ff
	Checksum: 0xFA0D7768
	Offset: 0x3A60
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_59e9f77b()
{
	if(isdefined(self.var_cc7959e1) && self.var_cc7959e1)
	{
		self clientfield::set("gegenees_spear_tip_effect", 0);
		var_1a3b2274 = "c_t8_zmb_dlc2_gegenees_spear";
		if(isdefined(self.var_e946c8e8) && self.var_e946c8e8)
		{
			var_1a3b2274 = "c_t8_zmb_dlc2_gegenees_spear_golden";
		}
		self detach(var_1a3b2274, "tag_inhand");
		self.var_cc7959e1 = 0;
	}
}

/*
	Name: function_d06af584
	Namespace: namespace_bd668ff
	Checksum: 0xBE4BD0AB
	Offset: 0x3B08
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_d06af584()
{
	if(!(isdefined(self.var_cc7959e1) && self.var_cc7959e1))
	{
		var_1a3b2274 = "c_t8_zmb_dlc2_gegenees_spear";
		if(isdefined(self.var_e946c8e8) && self.var_e946c8e8)
		{
			var_1a3b2274 = "c_t8_zmb_dlc2_gegenees_spear_golden";
		}
		self attach(var_1a3b2274, "tag_inhand");
		self.var_cc7959e1 = 1;
		self clientfield::set("gegenees_spear_tip_effect", 1);
	}
}

/*
	Name: function_ca5688e3
	Namespace: namespace_bd668ff
	Checksum: 0x20FA68A8
	Offset: 0x3BB8
	Size: 0x568
	Parameters: 12
	Flags: Linked, Private
*/
private function function_ca5688e3(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(boneindex))
	{
		bonename = getpartname(self, boneindex);
		if(bonename === "j_gegenees_shield")
		{
			if(isdefined(dir))
			{
				playfx("impacts/fx8_bul_impact_metal_sm", point, dir * -1);
				if(isdefined(point))
				{
					playsoundatposition(#"hash_72db6f3f0e602a33", point);
				}
			}
			return 0;
		}
	}
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point);
	var_dd54fdb1 = var_786d7e06.var_84ed9a13;
	var_88e794fb = var_786d7e06.var_7d87f2d4;
	adjusted_damage = int(damage * var_786d7e06.damage_scale);
	if(isdefined(var_dd54fdb1))
	{
		if(isdefined(var_dd54fdb1.var_8223b0cf) && var_dd54fdb1.var_8223b0cf > 0)
		{
			adjusted_damage = int(damage * var_786d7e06.damage_scale * var_dd54fdb1.var_8223b0cf);
		}
		if(var_88e794fb)
		{
			namespace_81245006::function_ef87b7e8(var_dd54fdb1, adjusted_damage);
			/#
				if(getdvarint(#"hash_50608e24a3f5f666", 0) > 0)
				{
					iprintlnbold("" + var_dd54fdb1.health);
				}
			#/
			if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
			{
				/#
					if(getdvarint(#"hash_50608e24a3f5f666", 0) > 0)
					{
						iprintlnbold("");
					}
				#/
				self destructserverutils::handledamage(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
				if(var_dd54fdb1.hitloc === "helmet")
				{
					var_465efe42 = namespace_81245006::function_37e3f011(self, "j_head", 2);
					namespace_81245006::function_6c64ebd3(var_465efe42, 1);
					self.var_d64b7af0 = 1;
					if(self isattached("c_t8_zmb_dlc2_gegenees_helmet1", "j_head"))
					{
						self detach("c_t8_zmb_dlc2_gegenees_helmet1", "j_head");
					}
					self clientfield::set("gegenees_helmet_explosion_cf", 1);
				}
				if(isdefined(var_dd54fdb1.var_641ce20e) && var_dd54fdb1.var_641ce20e)
				{
					namespace_81245006::function_6742b846(self, var_dd54fdb1);
				}
			}
			if(var_dd54fdb1.type === #"armor")
			{
				attacker util::show_hit_marker(!isalive(self));
				if(isdefined(dir))
				{
					playfx("impacts/fx8_bul_impact_metal_sm", point, dir * -1);
				}
				return 0;
			}
			if(isdefined(var_dd54fdb1.var_e37acc23) && var_dd54fdb1.var_e37acc23)
			{
				if(isdefined(dir))
				{
					playfx("zm_ai/fx8_gegenees_weakpoint_impact", point, dir * -1);
				}
			}
		}
	}
	if(!isdefined(self.shielddamage))
	{
		self.shielddamage = adjusted_damage;
	}
	else
	{
		self.shielddamage = self.shielddamage + adjusted_damage;
	}
	self.var_a9716e54 = self.var_a9716e54 + adjusted_damage;
	if(self.var_a9716e54 >= 500)
	{
		self.var_a9716e54 = 0;
		self function_9a05389e();
	}
	return adjusted_damage;
}

/*
	Name: function_a231dd3b
	Namespace: namespace_bd668ff
	Checksum: 0x15057BBF
	Offset: 0x4128
	Size: 0x288
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a231dd3b(s_params)
{
	if(self.archetype != #"gegenees")
	{
		return;
	}
	if(!self zm_zonemgr::entity_in_active_zone())
	{
		return;
	}
	n_time = gettime() / 1000;
	if(!isdefined(level.var_51c8013a))
	{
		level.var_51c8013a = 0;
	}
	dt = n_time - level.var_51c8013a;
	if(dt < 180)
	{
		return;
	}
	self val::set(#"hash_3c0685f1a63892e5", "takedamage", 0);
	if(level flag::get("zombie_drop_powerups") && !zm_utility::is_standard() && (!(isdefined(self.no_powerups) && self.no_powerups)))
	{
		var_67a1b262 = 1;
		if(isdefined(level.var_aebef29d))
		{
			dt = n_time - level.var_aebef29d;
			if(dt < 360)
			{
				var_67a1b262 = 0;
			}
		}
		self.var_d0686fde = [];
		self.var_d0686fde[self.var_d0686fde.size] = #"fire_sale";
		self.var_d0686fde[self.var_d0686fde.size] = #"nuke";
		if(var_67a1b262)
		{
			self.var_d0686fde[self.var_d0686fde.size] = #"full_ammo";
			self.var_d0686fde[self.var_d0686fde.size] = #"full_ammo";
		}
		level.var_51c8013a = n_time;
		self.no_powerups = 1;
		level thread zm_powerups::specific_powerup_drop(self.var_d0686fde, self.origin, undefined, undefined, undefined, undefined, undefined, undefined, 0, 1);
	}
	if(!isplayer(s_params.eattacker))
	{
		return;
	}
}

/*
	Name: function_9a05389e
	Namespace: namespace_bd668ff
	Checksum: 0x3A3499E1
	Offset: 0x43B8
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_9a05389e()
{
	self.var_c63e2811 = gettime() + 4000;
}

/*
	Name: function_c03e8d05
	Namespace: namespace_bd668ff
	Checksum: 0x9651E635
	Offset: 0x43D8
	Size: 0x278
	Parameters: 0
	Flags: Private
*/
private function function_c03e8d05()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			string = getdvarstring(#"hash_6e55ca7eb0bc5180", "");
			cmd = strtok(string, "");
			gegenees = getaiarchetypearray(#"gegenees");
			if(cmd.size > 0)
			{
				switch(cmd[0])
				{
					case "spawn":
					{
						zm_devgui::function_fc475b3b("");
						break;
					}
					case "kill":
					{
						zm_devgui::function_2422a10c(#"gegenees");
						break;
					}
					case "shield_attack":
					{
						if(isdefined(gegenees[0]))
						{
							gegenees[0].var_89b5e1e = 1;
						}
						break;
					}
					case "stop_move":
					{
						if(isdefined(gegenees[0]))
						{
							if(!isdefined(gegenees[0].var_7671b967))
							{
								gegenees[0].var_7671b967 = 1;
							}
							else
							{
								gegenees[0].var_7671b967 = !gegenees[0].var_7671b967;
							}
						}
						break;
					}
					default:
					{
						break;
					}
				}
			}
			setdvar(#"hash_6e55ca7eb0bc5180", "");
		}
	#/
}

