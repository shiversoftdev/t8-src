// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using script_59f07c660e6710a5;
#using script_7b7ed6e4bc963a51;
#using script_caf007e2a98afa2;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace archetype_avogadro;

/*
	Name: __init__system__
	Namespace: archetype_avogadro
	Checksum: 0x26F7FD59
	Offset: 0x1F0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"archetype_avogadro", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: archetype_avogadro
	Checksum: 0x3941B480
	Offset: 0x240
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	function_6bb82ac9();
	clientfield::register("scriptmover", "" + #"hash_699d5bb1a9339a93", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_4466de6137f54b59", 16000, 1, "int");
	clientfield::register("actor", "" + #"hash_2eec8fc21495a18c", 16000, 2, "int");
	spawner::add_archetype_spawn_function(#"avogadro", &function_ee579eb5);
	spawner::function_89a2cd87(#"avogadro", &function_d1359818);
	callback::on_player_damage(&function_99ce086a);
}

/*
	Name: __main__
	Namespace: archetype_avogadro
	Checksum: 0x7830522E
	Offset: 0x3B0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level.var_2ea60515 = getstatuseffect(#"hash_3a1f530cdb5f75f4");
}

/*
	Name: function_6bb82ac9
	Namespace: archetype_avogadro
	Checksum: 0xCA9346E7
	Offset: 0x3E8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_6bb82ac9()
{
	level.avogadrobolts = [];
	for(i = 0; i < 3; i++)
	{
		bolt = spawn("script_model", (0, 0, 0));
		bolt setmodel("tag_origin");
		if(!isdefined(level.avogadrobolts))
		{
			level.avogadrobolts = [];
		}
		else if(!isarray(level.avogadrobolts))
		{
			level.avogadrobolts = array(level.avogadrobolts);
		}
		level.avogadrobolts[level.avogadrobolts.size] = bolt;
	}
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetype_avogadro
	Checksum: 0x55088365
	Offset: 0x4F8
	Size: 0x44C
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_f8e8c129));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_520d52c557d9427", &function_f8e8c129);
	/#
		assert(isscriptfunctionptr(&function_7e5905cd));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a8b7da6a91d85f3", &function_7e5905cd);
	/#
		assert(isscriptfunctionptr(&function_6cf71c35));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_166fe23bafc2408", &function_6cf71c35);
	/#
		assert(isscriptfunctionptr(&function_1169b184));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e8335833e76fa0e", &function_1169b184);
	/#
		assert(isscriptfunctionptr(&function_9ab1c000));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1d3ff4cb570ac40", &function_9ab1c000);
	/#
		assert(isscriptfunctionptr(&function_3b8d314c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_75ba4163e4512e01", &function_3b8d314c);
	/#
		assert(isscriptfunctionptr(&function_dbba31c1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a0a227cda451796", &function_dbba31c1);
	/#
		assert(isscriptfunctionptr(&function_95141921));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_177974191a99d4ac", &function_95141921);
	/#
		assert(isscriptfunctionptr(&function_a495d71f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_49880776aa68a310", &function_a495d71f, 1);
	/#
		assert(isscriptfunctionptr(&function_a495d71f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2b76cd8d945e7de7", &function_a495d71f, 1);
	animationstatenetwork::registernotetrackhandlerfunction("avogadro_shoot_bolt", &shoot_bolt_wait);
}

/*
	Name: function_ee579eb5
	Namespace: archetype_avogadro
	Checksum: 0xD3F54384
	Offset: 0x950
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_ee579eb5()
{
	self callback::function_d8abfc3d(#"on_ai_killed", &function_8886bcc4);
	self callback::function_d8abfc3d(#"on_actor_damage", &function_50a86206);
	self.shield = 1;
	self.hit_by_melee = 0;
	self.phase_time = 0;
	self.var_1ce249af = 0;
	self.var_15aa1ae0 = 2000;
	self.var_f3bbe853 = 1;
	self.var_7fde19e8 = 0;
	self.var_9bff71aa = 0;
	self function_8a404313();
}

/*
	Name: function_8a404313
	Namespace: archetype_avogadro
	Checksum: 0xDC9C496D
	Offset: 0xA38
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8a404313()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_c7791d22;
}

/*
	Name: function_c7791d22
	Namespace: archetype_avogadro
	Checksum: 0xD9C2E93A
	Offset: 0xA90
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c7791d22(entity)
{
	entity.__blackboard = undefined;
	entity function_8a404313();
}

/*
	Name: function_d1359818
	Namespace: archetype_avogadro
	Checksum: 0xDEA697A5
	Offset: 0xAC8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_d1359818()
{
	function_dbc638a8(self);
}

/*
	Name: function_8886bcc4
	Namespace: archetype_avogadro
	Checksum: 0x5238D9F3
	Offset: 0xAF0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_8886bcc4(params)
{
	if(isdefined(self.bolt))
	{
		function_cbdce009(self.bolt);
	}
	self show();
}

/*
	Name: function_99ce086a
	Namespace: archetype_avogadro
	Checksum: 0x502B55E9
	Offset: 0xB48
	Size: 0xC8
	Parameters: 12
	Flags: Linked
*/
function function_99ce086a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(inflictor) && inflictor.archetype === #"avogadro" && meansofdeath == "MOD_MELEE")
	{
		self status_effect::status_effect_apply(level.var_2ea60515, undefined, inflictor, 0);
	}
	return -1;
}

/*
	Name: function_dbc638a8
	Namespace: archetype_avogadro
	Checksum: 0x5E49BB67
	Offset: 0xC18
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_dbc638a8(entity)
{
	if(entity.health < entity.maxhealth * 0.33)
	{
		entity clientfield::set("" + #"hash_2eec8fc21495a18c", 1);
	}
	else
	{
		if(entity.health < entity.maxhealth * 0.66)
		{
			entity clientfield::set("" + #"hash_2eec8fc21495a18c", 2);
		}
		else
		{
			entity clientfield::set("" + #"hash_2eec8fc21495a18c", 3);
		}
	}
}

/*
	Name: function_50a86206
	Namespace: archetype_avogadro
	Checksum: 0x7F195033
	Offset: 0xD20
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_50a86206(params)
{
	function_dbc638a8(self);
}

/*
	Name: function_80fc1a78
	Namespace: archetype_avogadro
	Checksum: 0xD3B082AE
	Offset: 0xD50
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function function_80fc1a78(time)
{
	self notify("3a74e555d7969d08");
	self endon(#"death", #"hash_7d29584dcbbe7d67", "4c2f097babffd515");
	self show();
	wait(time);
}

/*
	Name: function_66dd488a
	Namespace: archetype_avogadro
	Checksum: 0xB8E074EB
	Offset: 0xDC0
	Size: 0xC6
	Parameters: 0
	Flags: Linked, Private
*/
function private function_66dd488a()
{
	foreach(bolt in level.avogadrobolts)
	{
		if(isalive(bolt.owner) || (bolt clientfield::get("" + #"hash_699d5bb1a9339a93")) == 1)
		{
			continue;
		}
		return bolt;
	}
	return undefined;
}

/*
	Name: function_7e03184e
	Namespace: archetype_avogadro
	Checksum: 0x55DFE276
	Offset: 0xE90
	Size: 0x5A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7e03184e(bolt, entity)
{
	/#
		/#
			assert(!isalive(bolt.owner));
		#/
	#/
	bolt.owner = entity;
}

/*
	Name: function_cbdce009
	Namespace: archetype_avogadro
	Checksum: 0xAC0151A4
	Offset: 0xEF8
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cbdce009(bolt)
{
	bolt.owner = undefined;
}

/*
	Name: function_f8e8c129
	Namespace: archetype_avogadro
	Checksum: 0xD1DD5840
	Offset: 0xF18
	Size: 0x382
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f8e8c129(entity)
{
	if(isdefined(entity.can_shoot) && !entity.can_shoot)
	{
		return false;
	}
	var_99387d40 = blackboard::getblackboardevents(#"hash_27bee30b37f7debe");
	if(var_99387d40.size > 0)
	{
		return false;
	}
	if(isdefined(level.var_a35afcb2) && ![[level.var_a35afcb2]](entity))
	{
		return false;
	}
	if(isdefined(entity.bolt))
	{
		return true;
	}
	bolt = function_66dd488a();
	if(!isdefined(bolt))
	{
		return false;
	}
	enemy = (isdefined(self.attackable) ? self.attackable : self.favoriteenemy);
	if(isdefined(enemy))
	{
		vec_enemy = enemy.origin - self.origin;
		dist_sq = lengthsquared(vec_enemy);
		if(dist_sq > 14400 && dist_sq < 360000)
		{
			vec_facing = anglestoforward(self.angles);
			norm_facing = vectornormalize(vec_facing);
			norm_enemy = vectornormalize(vec_enemy);
			dot = vectordot(norm_facing, norm_enemy);
			var_482d3bba = (vec_facing[0], vec_facing[1], 0);
			var_45ed4f50 = vectornormalize((vec_facing[0], vec_facing[1], 0));
			var_9743030a = vectornormalize((vec_enemy[0], vec_enemy[1], 0));
			var_5e958f82 = vectordot(var_45ed4f50, var_9743030a);
			if(dot > 0.707 && var_5e958f82 > 0.99)
			{
				var_f6a4b2f3 = enemy getcentroid();
				if(issentient(enemy))
				{
					var_f6a4b2f3 = enemy geteye();
				}
				eye_pos = self geteye();
				passed = bullettracepassed(eye_pos, var_f6a4b2f3, 0, undefined);
				if(passed)
				{
					function_7e03184e(bolt, entity);
					entity.bolt = bolt;
					return true;
				}
			}
		}
	}
	return false;
}

/*
	Name: function_7e5905cd
	Namespace: archetype_avogadro
	Checksum: 0xAE7FDD10
	Offset: 0x12A8
	Size: 0xCC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7e5905cd(entity)
{
	enemy = self.favoriteenemy;
	if(isdefined(enemy))
	{
		self.shield = 1;
		self notify(#"hash_7d29584dcbbe7d67");
		self show();
	}
	var_8706203c = 500;
	if(isdefined(entity.var_fffac33))
	{
		var_8706203c = [[entity.var_fffac33]](entity);
	}
	blackboard::addblackboardevent(#"hash_27bee30b37f7debe", {#entity:self}, var_8706203c);
}

/*
	Name: function_6cf71c35
	Namespace: archetype_avogadro
	Checksum: 0xCBE2AB39
	Offset: 0x1380
	Size: 0x3E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6cf71c35(entity)
{
	if(isdefined(entity.bolt))
	{
		function_cbdce009(entity.bolt);
		entity.bolt = undefined;
	}
}

/*
	Name: shoot_bolt_wait
	Namespace: archetype_avogadro
	Checksum: 0x6FF2DFA8
	Offset: 0x13C8
	Size: 0x21C
	Parameters: 1
	Flags: Linked, Private
*/
function private shoot_bolt_wait(entity)
{
	bolt = entity.bolt;
	entity.bolt = undefined;
	if(!isdefined(entity.favoriteenemy))
	{
		function_cbdce009(bolt);
		return;
	}
	enemy = entity.favoriteenemy;
	self.shield = 0;
	self notify(#"stop_health");
	self clientfield::set("" + #"hash_2eec8fc21495a18c", 0);
	source_pos = self gettagorigin("tag_weapon_right");
	target_pos = enemy geteye();
	bolt.origin = source_pos;
	bolt endon(#"death");
	wait(0.1);
	bolt clientfield::set("" + #"hash_699d5bb1a9339a93", 1);
	bolt moveto(target_pos, 0.2);
	bolt waittill(#"movedone");
	bolt check_bolt_impact(entity, enemy);
	bolt clientfield::set("" + #"hash_699d5bb1a9339a93", 0);
	if(isdefined(bolt.owner))
	{
		function_cbdce009(bolt);
	}
}

/*
	Name: check_bolt_impact
	Namespace: archetype_avogadro
	Checksum: 0xB8667912
	Offset: 0x15F0
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function check_bolt_impact(entity, enemy)
{
	if(zombie_utility::is_player_valid(enemy))
	{
		enemy_eye_pos = enemy geteye();
		dist_sq = distancesquared(self.origin, enemy_eye_pos);
		if(dist_sq < 4096)
		{
			passed = bullettracepassed(self.origin, enemy_eye_pos, 0, undefined);
			if(passed)
			{
				enemy status_effect::status_effect_apply(level.var_2ea60515, undefined, self, 0);
				enemy dodamage((isdefined(level.var_c01b1042) ? level.var_c01b1042 : 60), enemy.origin, entity, undefined, undefined, "MOD_PROJECTILE");
			}
		}
	}
}

/*
	Name: function_95141921
	Namespace: archetype_avogadro
	Checksum: 0xFC36C5A2
	Offset: 0x1728
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_95141921(entity)
{
	function_dbc638a8(entity);
	self.phase_time = gettime() - 1;
}

/*
	Name: function_a495d71f
	Namespace: archetype_avogadro
	Checksum: 0x6446A726
	Offset: 0x1768
	Size: 0x38E
	Parameters: 1
	Flags: Linked
*/
function function_a495d71f(entity)
{
	var_2d734075 = !isdefined(level.var_8791f7c5) || [[level.var_8791f7c5]](entity);
	if(gettime() > entity.phase_time && var_2d734075)
	{
		if(entity function_dd070839() || isdefined(entity.traversestartnode))
		{
			entity.phase_time = gettime() + self.var_15aa1ae0;
			entity.var_1ce249af = 0;
			return;
		}
		var_cfa253f9 = array("back", "forward", "left", "right");
		var_160337aa = array("long", "medium", "short");
		var_160337aa = array::randomize(var_160337aa);
		direction = array::random(var_cfa253f9);
		foreach(distance in var_160337aa)
		{
			entity setblackboardattribute("_phase_direction", direction);
			entity setblackboardattribute("_phase_distance", distance);
			result = entity astsearch("phase@avogadro");
			animation = animationstatenetworkutility::searchanimationmap(entity, result[#"animation"]);
			if(isdefined(animation))
			{
				localdeltavector = getmovedelta(animation, 0, 1, entity);
				endpoint = entity localtoworldcoords(localdeltavector);
				if(ispointonnavmesh(endpoint, entity) && self maymovefrompointtopoint(entity.origin, endpoint, 1, 1))
				{
					/#
						recordline(entity.origin, endpoint, (0, 1, 0));
						recordsphere(endpoint, 15, (0, 1, 0));
					#/
					entity.var_1ce249af = 1;
					return true;
				}
				/#
					recordline(entity.origin, endpoint, (1, 0, 0));
					recordsphere(endpoint, 15, (1, 0, 0));
				#/
			}
		}
	}
	entity.var_1ce249af = 0;
}

/*
	Name: function_9ab1c000
	Namespace: archetype_avogadro
	Checksum: 0x8EF6B5EB
	Offset: 0x1B00
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_9ab1c000(entity)
{
	if(isdefined(entity.var_97a22974) && !entity.var_97a22974)
	{
		return 0;
	}
	return entity.var_1ce249af;
}

/*
	Name: function_3b8d314c
	Namespace: archetype_avogadro
	Checksum: 0xCAB2FC54
	Offset: 0x1B48
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_3b8d314c(entity)
{
	entity thread function_80fc1a78(0.1);
	entity.blockingpain = 1;
	entity.var_1ce249af = 0;
	entity.is_phasing = 1;
	if(isdefined(self.var_f3bbe853) && self.var_f3bbe853)
	{
		entity clientfield::set("" + #"hash_4466de6137f54b59", 1);
	}
	if(gettime() - entity.var_7fde19e8 > 1000)
	{
		entity.var_9bff71aa = 0;
	}
	else
	{
		entity.var_9bff71aa++;
	}
}

/*
	Name: function_36f6a838
	Namespace: archetype_avogadro
	Checksum: 0x78EF5853
	Offset: 0x1C30
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_36f6a838(entity)
{
	entity.phase_time = gettime() + self.var_15aa1ae0;
	entity.var_1ce249af = 0;
}

/*
	Name: function_dbba31c1
	Namespace: archetype_avogadro
	Checksum: 0x27936E21
	Offset: 0x1C68
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_dbba31c1(entity)
{
	entity thread function_80fc1a78(0.1);
	entity.blockingpain = 0;
	entity.phase_time = gettime() + self.var_15aa1ae0;
	entity.is_phasing = undefined;
	entity.var_7fde19e8 = gettime();
	if(isdefined(self.var_f3bbe853) && self.var_f3bbe853)
	{
		entity clientfield::set("" + #"hash_4466de6137f54b59", 0);
	}
}

/*
	Name: function_1169b184
	Namespace: archetype_avogadro
	Checksum: 0xBE8E297E
	Offset: 0x1D28
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_1169b184(entity)
{
	function_dbc638a8(entity);
}

