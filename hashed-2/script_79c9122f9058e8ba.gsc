// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_11fc94bfd4e99341;
#using script_14f4a3c583c77d4b;
#using script_178024232e91b0a1;
#using script_1b10fdf0addd52e;
#using script_1e72c148eb0b32d2;
#using script_1f0e83e43bf9c3b9;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_6e3c826b1814cab6;
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
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2fa8319f;

/*
	Name: function_89f2df9
	Namespace: namespace_2fa8319f
	Checksum: 0xB7237B8B
	Offset: 0x410
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_657c0745e2102243", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2fa8319f
	Checksum: 0xFF33D7C0
	Offset: 0x460
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	init();
	level.var_d040fb05 = &function_6502a84d;
	spawner::add_archetype_spawn_function(#"hash_50f4e0eea9f4e4a4", &function_c12f7b53);
	namespace_57ff8cbb::function_cdf5a512(#"hash_50f4e0eea9f4e4a4", &function_4c71848e);
	callback::on_player_damage(&function_8dc028ba);
	clientfield::register("toplayer", "nosferatu_damage_fx", 8000, 1, "counter");
	clientfield::register("actor", "nosferatu_spawn_fx", 8000, 1, "counter");
	clientfield::register("actor", "nfrtu_silver_hit_fx", 8000, 1, "counter");
	clientfield::register("actor", "summon_nfrtu", 8000, 1, "int");
	clientfield::register("actor", "nfrtu_move_dash", 8000, 1, "int");
	zm_score::function_e5d6e6dd(#"hash_50f4e0eea9f4e4a4", 60);
	zm_score::function_e5d6e6dd(#"hash_69eff09684574252", 80);
	namespace_c3287616::register_archetype(#"hash_50f4e0eea9f4e4a4", &function_cf877849, &round_spawn, &function_74f25f8a, 25);
	namespace_c3287616::register_archetype(#"hash_69eff09684574252", &function_97f1f86e, &function_a8a8c2fb, undefined, 100);
	namespace_c3287616::function_306ce518(#"hash_69eff09684574252", &function_57abef39);
	level.var_243137e = getentarray("zombie_nosferatu_spawner", "script_noteworthy");
	level.var_13bc407f = getentarray("zombie_crimson_nosferatu_spawner", "script_noteworthy");
	/#
		zm_devgui::function_c7dd7a17("");
	#/
}

/*
	Name: __main__
	Namespace: namespace_2fa8319f
	Checksum: 0x80F724D1
	Offset: 0x7A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_2fa8319f
	Checksum: 0x80F724D1
	Offset: 0x7B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_2fa8319f
	Checksum: 0x3EBFE253
	Offset: 0x7C8
	Size: 0x3F4
	Parameters: 0
	Flags: Linked, Private
*/
private function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_7d874447));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a6e15c62c2e1958", &function_7d874447);
	/#
		assert(isscriptfunctionptr(&function_7fef620b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_258bd98449804a29", &function_7fef620b);
	/#
		assert(isscriptfunctionptr(&function_82785646));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50f7728355042178", &function_82785646);
	/#
		assert(isscriptfunctionptr(&function_7856b311));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6bf97c8d416da898", &function_7856b311);
	/#
		assert(isscriptfunctionptr(&function_abf11998));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3addb79d5fb2e4a3", &function_abf11998);
	/#
		assert(isscriptfunctionptr(&function_81c78981));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3a2582998db5774b", &function_81c78981);
	/#
		assert(isscriptfunctionptr(&function_475a698c));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3c518f78c393482e", &function_475a698c);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_344a0412) || isscriptfunctionptr(&function_344a0412));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4a2ea3c9e174122a", undefined, &function_344a0412, undefined);
	animationstatenetwork::registernotetrackhandlerfunction("summon_nfrtu", &function_76d6482e);
}

/*
	Name: function_abf11998
	Namespace: namespace_2fa8319f
	Checksum: 0x2392A03B
	Offset: 0xBC8
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_abf11998(entity)
{
	if(zm_behavior::zombieshouldstun(entity) && function_e060c994(entity))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e060c994
	Namespace: namespace_2fa8319f
	Checksum: 0x8F581BB9
	Offset: 0xC18
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e060c994(entity)
{
	var_7a69f7e9 = blackboard::getblackboardevents("nfrtu_stun");
	if(isdefined(var_7a69f7e9) && var_7a69f7e9.size)
	{
		foreach(event in var_7a69f7e9)
		{
			if(event.var_81270d79 === entity)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_7856b311
	Namespace: namespace_2fa8319f
	Checksum: 0x30020034
	Offset: 0xCE0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_7856b311(entity)
{
	zm_behavior::function_bdedea72(entity);
	var_268f1415 = spawnstruct();
	var_268f1415.var_81270d79 = entity;
	blackboard::addblackboardevent("nfrtu_stun", var_268f1415, randomintrange(10000, 12000));
}

/*
	Name: function_344a0412
	Namespace: namespace_2fa8319f
	Checksum: 0x34B7A55D
	Offset: 0xD70
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
private function function_344a0412(entity, asmstatename)
{
	if(entity ai::is_stunned())
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_81c78981
	Namespace: namespace_2fa8319f
	Checksum: 0x73F566A0
	Offset: 0xDB0
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_81c78981(entity)
{
	entity clientfield::set("nfrtu_move_dash", 1);
	return 1;
}

/*
	Name: function_475a698c
	Namespace: namespace_2fa8319f
	Checksum: 0x1B2CEE8A
	Offset: 0xDE8
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_475a698c(entity)
{
	entity clientfield::set("nfrtu_move_dash", 0);
	return 1;
}

/*
	Name: function_c12f7b53
	Namespace: namespace_2fa8319f
	Checksum: 0x26770570
	Offset: 0xE20
	Size: 0x2D4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c12f7b53()
{
	self.zombie_move_speed = "sprint";
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
	self.completed_emerging_into_playable_area = 1;
	self.ignorepathenemyfightdist = 1;
	var_eb297ead = namespace_e0710ee6::function_8d44707e(0);
	var_eb297ead = var_eb297ead * (isdefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1);
	self.health = int(var_eb297ead);
	self.maxhealth = int(var_eb297ead);
	self.is_zombie = 1;
	self.var_fad2bca9 = 1;
	self.var_ccb2e201 = 0;
	if(self.var_9fde8624 === #"hash_69eff09684574252")
	{
		self.var_dd6fe31f = 1;
		self.var_f46fbf3f = 1;
		self.var_126d7bef = 1;
		self.instakill_func = &zm_powerups::function_16c2586a;
		self zm_powerup_nuke::function_9a79647b(0.5);
	}
	else
	{
		self.var_2f68be48 = 1;
	}
	self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
	aiutility::addaioverridedamagecallback(self, &function_a13721f);
	self callback::function_d8abfc3d(#"on_ai_killed", &function_8a2cb5ed);
	self zm_score::function_82732ced();
	self thread zm_audio::play_ambient_zombie_vocals();
	self thread zm_audio::zmbaivox_notifyconvert();
	self.var_b467f3a1 = &function_201862b;
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	level thread zm_spawner::zombie_death_event(self);
	self.var_2e5407fc = gettime() + int(self ai::function_9139c839().var_e61d73b0 * 1000);
	/#
		self thread function_cd801084();
	#/
}

/*
	Name: function_8a2cb5ed
	Namespace: namespace_2fa8319f
	Checksum: 0x91740224
	Offset: 0x1100
	Size: 0x17C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8a2cb5ed(params)
{
	if(self.archetype === #"hash_50f4e0eea9f4e4a4")
	{
		attackerdistance = 0;
		isexplosive = 0;
		iscloseexplosive = 0;
		if(isdefined(params.eattacker) && isdefined(params.smeansofdeath) && isdefined(params.einflictor))
		{
			attackerdistance = distancesquared(params.eattacker.origin, self.origin);
			isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), params.smeansofdeath);
			iscloseexplosive = distancesquared(params.einflictor.origin, self.origin) <= 300 * 300;
			if(isexplosive && iscloseexplosive)
			{
				gibserverutils::annihilate(self);
			}
		}
	}
}

/*
	Name: function_a13721f
	Namespace: namespace_2fa8319f
	Checksum: 0xE0DD5DFD
	Offset: 0x1288
	Size: 0x128
	Parameters: 12
	Flags: Linked, Private
*/
private function function_a13721f(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && self === attacker)
	{
		damage = 0;
	}
	if(isdefined(attacker) && isplayer(attacker) && isdefined(weapon) && attacker zm_utility::function_aa45670f(weapon, 0))
	{
		if(gettime() >= self.ai.var_9465ce93)
		{
			self.ai.var_9465ce93 = gettime() + randomintrange(4500, 5500);
			self clientfield::increment("nfrtu_silver_hit_fx");
		}
	}
	return damage;
}

/*
	Name: function_cd801084
	Namespace: namespace_2fa8319f
	Checksum: 0x761650B3
	Offset: 0x13B8
	Size: 0x3A
	Parameters: 0
	Flags: Private
*/
private function function_cd801084()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.pathgoalpos))
		{
			/#
			#/
		}
		waitframe(1);
	}
}

/*
	Name: function_2b35beda
	Namespace: namespace_2fa8319f
	Checksum: 0x6A652B0E
	Offset: 0x1400
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2b35beda()
{
	self clientfield::increment_to_player("nosferatu_damage_fx");
}

/*
	Name: function_c59b482e
	Namespace: namespace_2fa8319f
	Checksum: 0x969D8643
	Offset: 0x1430
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c59b482e()
{
	self.health = self.maxhealth;
}

/*
	Name: function_c9a2941c
	Namespace: namespace_2fa8319f
	Checksum: 0xEA8CF80B
	Offset: 0x1450
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c9a2941c(notifyhash)
{
	if(isdefined(self) && isdefined(self.heal))
	{
		self val::reset(#"hash_50f4e0eea9f4e4a4", "health_regen");
	}
}

/*
	Name: function_e05b2c36
	Namespace: namespace_2fa8319f
	Checksum: 0xF18D478E
	Offset: 0x14A8
	Size: 0xC6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e05b2c36()
{
	self notify("1aeb0156174acfac");
	self endon("1aeb0156174acfac");
	self endon_callback(&function_c9a2941c, #"death");
	self.var_1c152654 = 1;
	self val::set(#"hash_50f4e0eea9f4e4a4", "health_regen", 0);
	wait(self.var_cd35302f);
	self val::reset(#"hash_50f4e0eea9f4e4a4", "health_regen");
	waitframe(5);
	self.var_cd35302f = undefined;
	self.var_1c152654 = 0;
}

/*
	Name: function_8dc028ba
	Namespace: namespace_2fa8319f
	Checksum: 0x1EBF3910
	Offset: 0x1578
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_8dc028ba(s_params)
{
	attacker = s_params.eattacker;
	if(isdefined(attacker) && isdefined(attacker.archetype) && attacker.archetype == #"hash_50f4e0eea9f4e4a4" && s_params.idamage > 0)
	{
		self function_2b35beda();
		attacker function_c59b482e();
		if(namespace_59ff1d6c::function_901b751c(#"hash_5c47775ddd2e17dd") == 2 && namespace_59ff1d6c::function_901b751c(#"hash_5fbcaf0a1daae566") == 1)
		{
			self.var_cd35302f = attacker ai::function_9139c839().var_52a41524 + 1.1;
			self thread function_e05b2c36();
		}
	}
}

/*
	Name: function_cf877849
	Namespace: namespace_2fa8319f
	Checksum: 0xE0B388AB
	Offset: 0x16C0
	Size: 0x10A
	Parameters: 1
	Flags: Linked
*/
function function_cf877849(var_dbce0c44)
{
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	var_f1f220b9 = 1;
	if(level.round_number >= 15)
	{
		var_f1f220b9 = 3;
	}
	else if(level.round_number >= 10)
	{
		var_f1f220b9 = 2;
	}
	var_a87aeae6 = 30;
	var_a1737466 = randomfloatrange(0.02, 0.03);
	n_spawn = max(var_f1f220b9, int(level.zombie_total * var_a1737466));
	return min(var_a87aeae6, n_spawn);
}

/*
	Name: function_57abef39
	Namespace: namespace_2fa8319f
	Checksum: 0xCA9A9A4B
	Offset: 0x17D8
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_57abef39(n_round_number)
{
	level endon(#"end_game");
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"hash_69eff09684574252"))
		{
			level.var_da92f51a = level.round_number + function_21a3a673(2, 3);
		}
	}
}

/*
	Name: function_97f1f86e
	Namespace: namespace_2fa8319f
	Checksum: 0x93C38741
	Offset: 0x1880
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_97f1f86e(var_dbce0c44)
{
	if(isdefined(level.var_da92f51a) && level.round_number < level.var_da92f51a || (isdefined(level.var_5e45f817) && level.var_5e45f817))
	{
		return 0;
	}
	var_a87aeae6 = 20;
	var_a1737466 = randomfloatrange(0.01, 0.02);
	return min(var_a87aeae6, int(level.zombie_total * var_a1737466));
}

/*
	Name: round_spawn
	Namespace: namespace_2fa8319f
	Checksum: 0x625EFDAC
	Offset: 0x1958
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	ai = function_74f25f8a();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_a8a8c2fb
	Namespace: namespace_2fa8319f
	Checksum: 0x741192AF
	Offset: 0x19A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_a8a8c2fb()
{
	ai = function_74f25f8a(0, undefined, 1);
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_74f25f8a
	Namespace: namespace_2fa8319f
	Checksum: 0x8A68DCEB
	Offset: 0x19F0
	Size: 0x248
	Parameters: 4
	Flags: Linked
*/
function function_74f25f8a(b_force_spawn = 0, var_eb3a8721, var_950c7b6b = 0, round_number)
{
	if(!b_force_spawn && !function_1c0cad2c())
	{
		return undefined;
	}
	players = getplayers();
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else if(isdefined(level.var_d040fb05))
	{
		s_spawn_loc = [[level.var_d040fb05]]();
	}
	else if(level.zm_loc_types[#"nosferatu_location"].size > 0)
	{
		s_spawn_loc = array::random(level.zm_loc_types[#"nosferatu_location"]);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	if(var_950c7b6b)
	{
		e_spawner = level.var_13bc407f[0];
	}
	else
	{
		e_spawner = level.var_243137e[0];
	}
	ai = zombie_utility::spawn_zombie(e_spawner, undefined, undefined, round_number);
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_ae4acb3f))
		{
			ai thread [[level.var_ae4acb3f]](s_spawn_loc);
		}
		var_46d2ec35 = get_favorite_enemy();
		if(isdefined(var_46d2ec35))
		{
			ai.favoriteenemy = var_46d2ec35;
			ai.favoriteenemy.hunted_by++;
		}
	}
	return ai;
}

/*
	Name: function_1c0cad2c
	Namespace: namespace_2fa8319f
	Checksum: 0x12D61DC9
	Offset: 0x1C40
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_1c0cad2c()
{
	var_e02fe4cb = function_853b43e8();
	var_72385dbc = function_fc977dee();
	if(isdefined(level.var_5e45f817) && level.var_5e45f817 || var_e02fe4cb >= var_72385dbc || !level flag::get("spawn_zombies"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_fc977dee
	Namespace: namespace_2fa8319f
	Checksum: 0x55E8D8A
	Offset: 0x1CE8
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_fc977dee()
{
	switch(getplayers().size)
	{
		case 1:
		{
			return 3;
			break;
		}
		case 2:
		{
			return 5;
			break;
		}
		case 3:
		{
			return 7;
			break;
		}
		case 4:
		{
			return 10;
			break;
		}
	}
}

/*
	Name: function_853b43e8
	Namespace: namespace_2fa8319f
	Checksum: 0xF48CFE03
	Offset: 0x1D80
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_853b43e8()
{
	var_219a33e2 = getaiarchetypearray(#"hash_50f4e0eea9f4e4a4");
	var_e02fe4cb = var_219a33e2.size;
	foreach(var_7afd04dc in var_219a33e2)
	{
		if(!isalive(var_7afd04dc))
		{
			var_e02fe4cb--;
		}
	}
	return var_e02fe4cb;
}

/*
	Name: function_6502a84d
	Namespace: namespace_2fa8319f
	Checksum: 0xED303618
	Offset: 0x1E48
	Size: 0x22A
	Parameters: 1
	Flags: Linked
*/
function function_6502a84d(entity)
{
	if(isdefined(level.zm_loc_types[#"nosferatu_location"]) && level.zm_loc_types[#"nosferatu_location"].size >= 1)
	{
		a_locs = array::randomize(level.zm_loc_types[#"nosferatu_location"]);
	}
	if(!isdefined(a_locs) || a_locs.size == 0)
	{
		return;
	}
	if(isdefined(entity) && isdefined(entity.favoriteenemy) && zm_utility::is_player_valid(entity.favoriteenemy))
	{
		var_46d2ec35 = entity.favoriteenemy;
	}
	else
	{
		var_46d2ec35 = get_favorite_enemy();
	}
	if(!isdefined(var_46d2ec35) || !isalive(var_46d2ec35))
	{
		return array::random(a_locs);
	}
	var_3ca1175 = 3600 * 3600;
	for(i = 0; i < a_locs.size; i++)
	{
		if(isdefined(level.var_445185e3) && level.var_445185e3 == a_locs[i])
		{
			continue;
		}
		n_dist_squared = distancesquared(a_locs[i].origin, var_46d2ec35.origin);
		if(n_dist_squared < var_3ca1175)
		{
			level.var_445185e3 = a_locs[i];
			return a_locs[i];
		}
	}
	return arraygetclosest(var_46d2ec35.origin, a_locs);
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_2fa8319f
	Checksum: 0x92C46259
	Offset: 0x2080
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function get_favorite_enemy()
{
	var_8637c743 = getplayers();
	e_least_hunted = var_8637c743[0];
	for(i = 0; i < var_8637c743.size; i++)
	{
		if(!isdefined(var_8637c743[i].hunted_by))
		{
			var_8637c743[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(var_8637c743[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(e_least_hunted))
		{
			e_least_hunted = var_8637c743[i];
		}
		if(var_8637c743[i].hunted_by < e_least_hunted.hunted_by)
		{
			e_least_hunted = var_8637c743[i];
		}
	}
	if(!zm_utility::is_player_valid(e_least_hunted))
	{
		return undefined;
	}
	e_least_hunted.hunted_by = e_least_hunted.hunted_by + 1;
	return e_least_hunted;
}

/*
	Name: function_4c71848e
	Namespace: namespace_2fa8319f
	Checksum: 0x87C944A8
	Offset: 0x21C0
	Size: 0x308
	Parameters: 0
	Flags: Linked
*/
function function_4c71848e()
{
	self endon(#"death");
	a_s_spawn_locs = level.zm_loc_types[#"nosferatu_location"];
	if(isarray(a_s_spawn_locs))
	{
		while(i < a_s_spawn_locs.size)
		{
			if(isdefined(a_s_spawn_locs[i].scriptbundlename))
			{
				arrayremoveindex(a_s_spawn_locs, i);
			}
			else
			{
				i++;
			}
		}
		if(a_s_spawn_locs.size < 1)
		{
			self.b_ignore_cleanup = 1;
			return 1;
		}
	}
	else
	{
		self.b_ignore_cleanup = 1;
		return 1;
	}
	if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area"))
	{
		self.b_ignore_cleanup = 1;
		return 1;
	}
	var_31f7011a = arraycopy(getplayers());
	var_31f7011a = arraysortclosest(var_31f7011a, self.origin);
	i = 0;
	var_b2aa54a9 = a_s_spawn_locs[0];
	var_56feeec4 = distancesquared(var_31f7011a[0].origin, var_b2aa54a9.origin);
	foreach(var_d7eff26a in a_s_spawn_locs)
	{
		if(!zm_utility::is_player_valid(var_31f7011a[i]))
		{
			i++;
			if(i >= var_31f7011a.size)
			{
				i = 0;
				util::wait_network_frame();
			}
			continue;
		}
		var_e8ab126e = distancesquared(var_31f7011a[i].origin, var_d7eff26a.origin);
		if(var_e8ab126e < var_56feeec4)
		{
			var_56feeec4 = var_e8ab126e;
			var_b2aa54a9 = var_d7eff26a;
		}
	}
	self namespace_e0710ee6::function_a8dc3363(var_b2aa54a9);
	return 1;
}

/*
	Name: function_82785646
	Namespace: namespace_2fa8319f
	Checksum: 0xFA0F86E2
	Offset: 0x24D0
	Size: 0x17E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_82785646(entity)
{
	if(isdefined(level.var_5e45f817) && level.var_5e45f817)
	{
		return 0;
	}
	if(!isdefined(self.var_9fde8624) || self.var_9fde8624 != #"hash_69eff09684574252")
	{
		return 0;
	}
	if(entity.health / entity.maxhealth > entity ai::function_9139c839().var_23f04a87 / 100)
	{
		return 0;
	}
	if(isdefined(entity.var_85480576) && entity.var_85480576)
	{
		return 0;
	}
	if(entity.var_2e5407fc > gettime())
	{
		return 0;
	}
	if(!(isdefined(level.var_9dc5ff5d) && level.var_9dc5ff5d) && zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit)
	{
		return 0;
	}
	if(!function_c16e1ca1(entity))
	{
		return 0;
	}
	if(function_21a3a673(0, 100) < entity ai::function_9139c839().var_3b66f582)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c16e1ca1
	Namespace: namespace_2fa8319f
	Checksum: 0xB8206CBC
	Offset: 0x2658
	Size: 0x82
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c16e1ca1(entity)
{
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(entity.var_9fde8624 !== #"hash_69eff09684574252")
	{
		return 0;
	}
	var_847b3ac1 = blackboard::getblackboardevents("nfrtu_summon");
	if(isdefined(var_847b3ac1) && var_847b3ac1.size)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_7d874447
	Namespace: namespace_2fa8319f
	Checksum: 0x7E2229E8
	Offset: 0x26E8
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7d874447(entity)
{
	var_e47d78cb = spawnstruct();
	blackboard::addblackboardevent("nfrtu_summon", var_e47d78cb, randomintrange(50000, 100000));
	entity.var_2e5407fc = gettime() + int(entity ai::function_9139c839().var_e61d73b0 * 1000);
	entity clientfield::set("summon_nfrtu", 1);
}

/*
	Name: function_7fef620b
	Namespace: namespace_2fa8319f
	Checksum: 0xB251EE58
	Offset: 0x27B0
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7fef620b(entity)
{
	entity.var_2e5407fc = gettime() + int(entity ai::function_9139c839().var_e61d73b0 * 1000);
	entity clientfield::set("summon_nfrtu", 0);
}

/*
	Name: function_76d6482e
	Namespace: namespace_2fa8319f
	Checksum: 0xD325F755
	Offset: 0x2828
	Size: 0x3D4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_76d6482e(entity)
{
	if(isdefined(level.zm_loc_types[#"nosferatu_location"]) && level.zm_loc_types[#"nosferatu_location"].size >= 1)
	{
		a_locs = array::randomize(level.zm_loc_types[#"nosferatu_location"]);
	}
	if(!isdefined(a_locs))
	{
		return;
	}
	var_c9528359 = int(max(0, min(3, level.zombie_ai_limit - zombie_utility::get_current_zombie_count())));
	var_4a07738f = entity getpathfindingradius() + 25;
	queryresult = positionquery_source_navigation(entity.origin, var_4a07738f, 300, 64, 25, entity);
	if(queryresult.data.size == 0)
	{
		/#
			iprintlnbold("");
		#/
		return;
	}
	if(!var_c9528359)
	{
		a_ai_zombies = getaiarchetypearray(#"zombie");
		foreach(e_player in util::get_active_players(#"allies"))
		{
			var_77696b51 = array::get_all_closest(e_player.origin, a_ai_zombies, undefined, undefined, 640);
			a_ai_zombies = array::exclude(a_ai_zombies, var_77696b51);
		}
		var_c9528359 = int(max(0, min(3, a_ai_zombies.size)));
		/#
			iprintln("" + var_c9528359 + "");
		#/
		for(i = 0; i < var_c9528359; i++)
		{
			a_ai_zombies[i] thread namespace_57ff8cbb::cleanup_zombie();
		}
	}
	if(var_c9528359)
	{
		/#
			iprintln("" + var_c9528359 + "");
		#/
		entity thread function_13b48cdd(var_c9528359, queryresult);
	}
	iprintlnbold("");
}

/*
	Name: function_13b48cdd
	Namespace: namespace_2fa8319f
	Checksum: 0x29DD7E64
	Offset: 0x2C08
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function function_13b48cdd(var_c9528359, queryresult)
{
	self endon(#"death");
	while(var_c9528359 > 0)
	{
		var_18f8f237 = 5;
		point = queryresult.data[point_index];
		point_index++;
		if(isdefined(point))
		{
			do
			{
				ai = function_74f25f8a(1, undefined);
				var_18f8f237--;
				waitframe(1);
			}
			while(!isdefined(ai) && var_18f8f237);
		}
		/#
			if(!var_18f8f237 && !isdefined(ai))
			{
				iprintlnbold("");
			}
		#/
		if(isdefined(ai) && isdefined(point))
		{
			ai thread function_b2a2b29e();
			ai.favoriteenemy = zm_utility::get_closest_valid_player(ai.origin, []);
			point thread nosferatu_spawn_fx(ai, {#angles:self.angles, #origin:point.origin});
			wait(0.2);
		}
		var_c9528359--;
		waitframe(1);
	}
}

/*
	Name: function_b2a2b29e
	Namespace: namespace_2fa8319f
	Checksum: 0xC9A10C4C
	Offset: 0x2DC0
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_b2a2b29e()
{
	self endon(#"death");
	self.var_126d7bef = 1;
	self.ignore_round_spawn_failsafe = 1;
	self.ignore_enemy_count = 1;
	self.b_ignore_cleanup = 1;
	self waittill(#"completed_emerging_into_playable_area");
	self.no_powerups = 1;
}

/*
	Name: nosferatu_spawn_fx
	Namespace: namespace_2fa8319f
	Checksum: 0x9C1A448D
	Offset: 0x2E38
	Size: 0x278
	Parameters: 2
	Flags: Linked
*/
function nosferatu_spawn_fx(ai, ent)
{
	ai endon(#"death");
	ai val::set(#"hash_3cb0026a111e57dc", "allowdeath", 0);
	ai setfreecameralockonallowed(0);
	wait(1.5);
	earthquake(0.5, 0.75, ent.origin, 1000);
	if(isdefined(ai.favoriteenemy))
	{
		angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
		angles = (ai.angles[0], angle[1], ai.angles[2]);
	}
	else
	{
		angles = ent.angles;
	}
	ai dontinterpolate();
	ai forceteleport(ent.origin, angles);
	ai clientfield::increment("nosferatu_spawn_fx");
	/#
		assert(isdefined(ai), "");
	#/
	/#
		assert(isalive(ai), "");
	#/
	ai val::reset(#"hash_3cb0026a111e57dc", "allowdeath");
	wait(0.1);
	ai show();
	ai setfreecameralockonallowed(1);
	ai val::reset(#"hash_3cb0026a111e57dc", "ignoreme");
	ai notify(#"visible");
}

/*
	Name: function_201862b
	Namespace: namespace_2fa8319f
	Checksum: 0x379B472B
	Offset: 0x30B8
	Size: 0x212
	Parameters: 1
	Flags: Linked
*/
function function_201862b(eventstruct)
{
	notify_string = eventstruct.action;
	switch(notify_string)
	{
		case "death":
		{
			if(isdefined(self.bgb_tone_death) && self.bgb_tone_death)
			{
				level thread zm_audio::zmbaivox_playvox(self, "death_whimsy", 1, 4);
			}
			else
			{
				level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 4);
			}
			break;
		}
		case "pain":
		{
			level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 3);
			break;
		}
		case "scream":
		{
			level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 3, 1);
			break;
		}
		case "leap":
		case "attack_melee":
		case "hash_68d6e0a573aa2c1c":
		{
			level thread zm_audio::zmbaivox_playvox(self, notify_string, 1, 2, 1);
			break;
		}
		case "sprint":
		case "ambient":
		{
			level thread zm_audio::zmbaivox_playvox(self, notify_string, 0, 1);
			break;
		}
		default:
		{
			level thread zm_audio::zmbaivox_playvox(self, notify_string, 0, 2);
			break;
		}
	}
}

