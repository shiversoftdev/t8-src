// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_2c74a7b5eea1ec89;
#using script_3738f84821de194e;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_452cf453bf79907b;
#using script_45decd627aedfc09;
#using script_489b835a247c990e;
#using script_49d5f69a3ac4a923;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_5e918923a121b594;
#using script_6c8abe14025b47c4;
#using script_751513c609504a42;
#using script_caf007e2a98afa2;
#using script_ebc09732f6544a3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_c3527dc1;

/*
	Name: init
	Namespace: namespace_c3527dc1
	Checksum: 0x4D7A5ACF
	Offset: 0x2C8
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function init()
{
	spawner::add_archetype_spawn_function(#"mp_dog", &function_ef4b81af);
	registerbehaviorscriptfunctions();
	if(!isdefined(level.extra_screen_electricity_))
	{
		level.extra_screen_electricity_ = spawnstruct();
		level.extra_screen_electricity_.functions = [];
		clientfield::register("actor", "ks_dog_bark", 1, 1, "int");
		clientfield::register("actor", "ks_shocked", 1, 1, "int");
	}
	ai_patrol::init();
	namespace_9f91adfa::init();
	namespace_300327a7::init();
}

#namespace lookaround;

/*
	Name: __constructor
	Namespace: lookaround
	Checksum: 0x1785EA7
	Offset: 0x3E8
	Size: 0x2E
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	self.var_268b3fe5 = gettime() + randomintrange(4500, 6500);
}

/*
	Name: __destructor
	Namespace: lookaround
	Checksum: 0x80F724D1
	Offset: 0x420
	Size: 0x4
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
}

#namespace namespace_c3527dc1;

/*
	Name: lookaround
	Namespace: namespace_c3527dc1
	Checksum: 0xAA4CF98B
	Offset: 0x430
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function lookaround()
{
	classes.lookaround[0] = spawnstruct();
	classes.lookaround[0].__vtable[913321084] = &lookaround::__destructor;
	classes.lookaround[0].__vtable[674154906] = &lookaround::__constructor;
}

#namespace namespace_bd3490ad;

/*
	Name: __constructor
	Namespace: namespace_bd3490ad
	Checksum: 0x80F724D1
	Offset: 0x4C0
	Size: 0x4
	Parameters: 0
	Flags: 8, 128
*/
function __constructor()
{
}

/*
	Name: __destructor
	Namespace: namespace_bd3490ad
	Checksum: 0x80F724D1
	Offset: 0x4D0
	Size: 0x4
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
}

#namespace namespace_c3527dc1;

/*
	Name: function_bd3490ad
	Namespace: namespace_c3527dc1
	Checksum: 0xE0EDC5BB
	Offset: 0x4E0
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_bd3490ad()
{
	classes.var_bd3490ad[0] = spawnstruct();
	classes.var_bd3490ad[0].__vtable[913321084] = &namespace_bd3490ad::__destructor;
	classes.var_bd3490ad[0].__vtable[674154906] = &namespace_bd3490ad::__constructor;
}

/*
	Name: function_ef4b81af
	Namespace: namespace_c3527dc1
	Checksum: 0x9B3F6E4C
	Offset: 0x570
	Size: 0x214
	Parameters: 0
	Flags: Private
*/
private function function_ef4b81af()
{
	function_ae45f57b();
	self setplayercollision(0);
	self allowpitchangle(1);
	self setpitchorient();
	self setavoidancemask("avoid none");
	self collidewithactors(0);
	self function_11578581(30);
	self.ai.var_8a9efbb6 = 1;
	self.var_259f6c17 = 1;
	self.ignorepathenemyfightdist = 1;
	self.jukemaxdistance = 1800;
	self.highlyawareradius = 350;
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.maxsightdistsqrd = 900 * 900;
	self.sightlatency = 150;
	self.var_8908e328 = 1;
	self.ai.reacquire_state = 0;
	self.ai.var_54b19f55 = 1;
	object = new lookaround();
	[[ object ]]->__constructor();
	self.ai.lookaround = object;
	object = new var_bd3490ad();
	[[ object ]]->__constructor();
	self.ai.var_bd3490ad = object;
	self thread namespace_14c38db0::function_7e1a12ce(4000);
	self thread function_8f876521();
	self callback::function_d8abfc3d(#"hash_c3f225c9fa3cb25", &function_3fb68a86);
	aiutility::addaioverridedamagecallback(self, &function_d6d0a32e);
}

/*
	Name: function_3fb68a86
	Namespace: namespace_c3527dc1
	Checksum: 0x8D18740D
	Offset: 0x790
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_3fb68a86()
{
	self clientfield::set("ks_dog_bark", 0);
}

/*
	Name: function_a543b380
	Namespace: namespace_c3527dc1
	Checksum: 0x870EEAAA
	Offset: 0x7C0
	Size: 0x236
	Parameters: 1
	Flags: None
*/
function function_a543b380(player)
{
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(self.owner === player)
	{
		return 0;
	}
	if(!player util::isenemyteam(self.team))
	{
		return 0;
	}
	if(player.team == #"spectator")
	{
		return 0;
	}
	if(!player playerads())
	{
		return 0;
	}
	weapon = player getcurrentweapon();
	if(!isdefined(weapon) || !isdefined(weapon.rootweapon))
	{
		return 0;
	}
	if(weapon.rootweapon != getweapon(#"shotgun_semiauto_t8"))
	{
		return 0;
	}
	if(!weaponhasattachment(weapon, "uber"))
	{
		return 0;
	}
	distsq = distancesquared(self.origin, player.origin);
	if(distsq > 900 * 900)
	{
		return 0;
	}
	if(!util::within_fov(self.origin, self.angles, player.origin, cos(45)))
	{
		return 0;
	}
	if(!util::within_fov(player.origin, player getplayerangles(), self.origin, cos(45)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8f876521
	Namespace: namespace_c3527dc1
	Checksum: 0x404395C8
	Offset: 0xA00
	Size: 0x1D4
	Parameters: 0
	Flags: None
*/
function function_8f876521()
{
	self endon(#"death");
	self.ai.var_e90b47c1 = gettime();
	while(isalive(self))
	{
		if(isdefined(self.ai.var_e90b47c1) && gettime() <= self.ai.var_e90b47c1)
		{
			wait(1);
			continue;
		}
		players = getplayers();
		foreach(player in players)
		{
			if(!function_a543b380(player))
			{
				continue;
			}
			if(self cansee(player))
			{
				self.health = self.health + 1;
				self dodamage(1, player.origin, undefined, undefined, "torso_lower", "MOD_UNKNOWN", 0, getweapon("eq_swat_grenade"), 0, 1);
				self.ai.var_e90b47c1 = gettime() + randomintrange(6000, 13000);
				break;
			}
		}
		wait(1);
	}
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_c3527dc1
	Checksum: 0xA02A7B85
	Offset: 0xBE0
	Size: 0x91C
	Parameters: 0
	Flags: None
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&dogtargetservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_346d9603dd579196", &dogtargetservice, 1);
	/#
		assert(isscriptfunctionptr(&dogshouldwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5a5b637516edb780", &dogshouldwalk);
	/#
		assert(isscriptfunctionptr(&dogshouldwalk));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5a5b637516edb780", &dogshouldwalk);
	/#
		assert(isscriptfunctionptr(&dogshouldrun));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7c8ec1f94da8bb5a", &dogshouldrun);
	/#
		assert(isscriptfunctionptr(&dogshouldrun));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7c8ec1f94da8bb5a", &dogshouldrun);
	/#
		assert(isscriptfunctionptr(&function_e382db1f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4178f7c4c6cfaeb6", &function_e382db1f);
	/#
		assert(isscriptfunctionptr(&function_6c2426d3));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7aaa666497426ef4", &function_6c2426d3);
	/#
		assert(isscriptfunctionptr(&function_6c2426d3));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7aaa666497426ef4", &function_6c2426d3);
	/#
		assert(isscriptfunctionptr(&dogjukeinitialize));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5b809967bd59e019", &dogjukeinitialize);
	/#
		assert(isscriptfunctionptr(&dogpreemptivejuketerminate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5339b835490562e3", &dogpreemptivejuketerminate);
	/#
		assert(isscriptfunctionptr(&function_3089bb44));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_366c0b2c4164cc87", &function_3089bb44);
	/#
		assert(isscriptfunctionptr(&function_3089bb44));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_366c0b2c4164cc87", &function_3089bb44);
	/#
		assert(isscriptfunctionptr(&function_b2e0da2));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_65dc8904419628da", &function_b2e0da2);
	/#
		assert(isscriptfunctionptr(&function_3b9e385c));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4066108355410b7a", &function_3b9e385c);
	/#
		assert(isscriptfunctionptr(&function_ac9765d1));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3fdd4a9f016c4ba4", &function_ac9765d1);
	/#
		assert(isscriptfunctionptr(&function_d338afb8));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_28582743cd920a21", &function_d338afb8);
	/#
		assert(isscriptfunctionptr(&function_bcd7b170));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3349a77142623d80", &function_bcd7b170);
	/#
		assert(isscriptfunctionptr(&function_4f9ebad6));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_bb74fb159118080", &function_4f9ebad6);
	/#
		assert(isscriptfunctionptr(&function_81c29086));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34183bbd11db144", &function_81c29086);
	/#
		assert(isscriptfunctionptr(&function_c34253a9));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d584bfcad6c773d", &function_c34253a9);
	animationstatenetwork::registernotetrackhandlerfunction("dog_melee", &function_cebd576f);
	animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_juke", &function_475a38e6, &function_75068028, &function_13978732);
	animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_charge_melee", &function_b1eb29d8, &function_a5923bea, &function_668f9379);
	animationstatenetwork::registeranimationmocomp("mocomp_mp_dog_bark", &function_b17821dd, undefined, &function_92620306);
}

/*
	Name: function_d6d0a32e
	Namespace: namespace_c3527dc1
	Checksum: 0x696D8C6B
	Offset: 0x1508
	Size: 0xEA
	Parameters: 12
	Flags: None
*/
function function_d6d0a32e(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	chargelevel = 0;
	weapon_damage = killstreak_bundles::get_weapon_damage("dog", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
	}
	return weapon_damage;
}

/*
	Name: function_4f9ebad6
	Namespace: namespace_c3527dc1
	Checksum: 0xCA889E57
	Offset: 0x1600
	Size: 0x56
	Parameters: 1
	Flags: Private
*/
private function function_4f9ebad6(entity)
{
	var_14e113b = entity.var_40543c03;
	return var_14e113b === "concussion" || var_14e113b === "electrical" || var_14e113b === "flash";
}

/*
	Name: function_81c29086
	Namespace: namespace_c3527dc1
	Checksum: 0x3C7A3135
	Offset: 0x1660
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
private function function_81c29086(entity)
{
	if(entity.var_40543c03 === "electrical")
	{
		clientfield::set("ks_shocked", 1);
	}
	entity clientfield::set("ks_dog_bark", 0);
}

/*
	Name: function_c34253a9
	Namespace: namespace_c3527dc1
	Checksum: 0x10ED41A8
	Offset: 0x16D0
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function function_c34253a9(entity)
{
	clientfield::set("ks_shocked", 0);
}

/*
	Name: function_d338afb8
	Namespace: namespace_c3527dc1
	Checksum: 0xE9273C34
	Offset: 0x1700
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d338afb8(entity)
{
	return entity function_d68af34c() == "patrol";
}

/*
	Name: function_d68af34c
	Namespace: namespace_c3527dc1
	Checksum: 0x6F9F23F1
	Offset: 0x1738
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function function_d68af34c()
{
	if(self.ai.state == 0)
	{
		return "patrol";
	}
	return "escort";
}

/*
	Name: function_1eda333b
	Namespace: namespace_c3527dc1
	Checksum: 0x7F57DFEF
	Offset: 0x1770
	Size: 0x302
	Parameters: 0
	Flags: None
*/
function function_1eda333b()
{
	var_da7abcda = function_d68af34c();
	if(var_da7abcda == "escort" && self haspath() && isdefined(self.pathgoalpos))
	{
		goalpos = self.pathgoalpos;
		if(isdefined(self.ai.var_bd3490ad) && self.ai.var_bd3490ad.goalpos === goalpos)
		{
			/#
				recordsphere(self.ai.var_bd3490ad.facepoint, 4, (1, 0.5, 0), "");
				recordline(self.ai.var_bd3490ad.facepoint, goalpos, (1, 0.5, 0), "");
			#/
			return self.ai.var_bd3490ad.arrivalyaw;
		}
		var_e5eff04f = self predictarrival();
		if(var_e5eff04f[#"path_prediction_status"] === 2)
		{
			tacpoints = tacticalquery("mp_dog_arrival", goalpos);
			if(isdefined(tacpoints) && tacpoints.size)
			{
				facepoint = tacpoints[0].origin;
				var_514ffbc7 = vectornormalize(goalpos - self.origin);
				var_62724777 = vectornormalize(facepoint - goalpos);
				var_616967d2 = vectortoangles(var_514ffbc7)[1];
				var_238f4f40 = vectortoangles(var_62724777)[1];
				arrivalyaw = absangleclamp360(var_616967d2 - var_238f4f40);
				self.ai.var_bd3490ad.goalpos = goalpos;
				self.ai.var_bd3490ad.arrivalyaw = arrivalyaw;
				self.ai.var_bd3490ad.facepoint = facepoint;
				return arrivalyaw;
			}
		}
	}
	arrivalyaw = self bb_getlocomotionarrivalyaw();
	return arrivalyaw;
}

/*
	Name: function_a3708944
	Namespace: namespace_c3527dc1
	Checksum: 0x933477E1
	Offset: 0x1A80
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function function_a3708944(entity)
{
	if(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy && isdefined(self.enemy))
	{
		return 0;
	}
	var_da7abcda = function_d68af34c();
	if(var_da7abcda == "escort" && gettime() > self.ai.lookaround.var_268b3fe5)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c2bf7f10
	Namespace: namespace_c3527dc1
	Checksum: 0x65089071
	Offset: 0x1B30
	Size: 0x2D2
	Parameters: 0
	Flags: None
*/
function function_c2bf7f10()
{
	if(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy && isdefined(self.enemy))
	{
		predictedpos = self function_18c9035f(self.enemy);
		if(isdefined(predictedpos))
		{
			turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
			return turnyaw;
		}
	}
	if(self.ai.lookaround.var_894c8373 === gettime() && isdefined(self.ai.lookaround.var_d166ed3d))
	{
		return self.ai.lookaround.var_d166ed3d;
	}
	if(function_a3708944(self))
	{
		tacpoints = tacticalquery("mp_dog_arrival", self.origin);
		if(isdefined(tacpoints) && tacpoints.size)
		{
			tacpoints = array::randomize(tacpoints);
			facepoint = tacpoints[0].origin;
			lookdir = anglestoforward(self.angles);
			var_62724777 = vectornormalize(facepoint - self.origin);
			var_3de41380 = vectortoangles(lookdir)[1];
			var_ba54da4 = vectortoangles(var_62724777)[1];
			turnyaw = absangleclamp360(var_3de41380 - var_ba54da4);
			if(turnyaw >= 90 && turnyaw <= 270)
			{
				self.ai.lookaround.var_d166ed3d = turnyaw;
				self.ai.lookaround.var_894c8373 = gettime();
				self.ai.lookaround.var_268b3fe5 = gettime() + randomintrange(4500, 6500);
				return turnyaw;
			}
		}
	}
	return undefined;
}

/*
	Name: function_cebd576f
	Namespace: namespace_c3527dc1
	Checksum: 0x4391D59D
	Offset: 0x1E10
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_cebd576f(entity)
{
	entity melee();
	entity playsound(#"aml_dog_attack_jump");
	/#
		record3dtext("", self.origin, (1, 0, 0), "", entity);
	#/
}

/*
	Name: function_ae45f57b
	Namespace: namespace_c3527dc1
	Checksum: 0x27F074BA
	Offset: 0x1E90
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function function_ae45f57b()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_cb274b5;
}

/*
	Name: function_cb274b5
	Namespace: namespace_c3527dc1
	Checksum: 0x2C276C0E
	Offset: 0x1EE8
	Size: 0x2C
	Parameters: 1
	Flags: Private
*/
private function function_cb274b5(entity)
{
	entity.__blackboard = undefined;
	entity function_ae45f57b();
}

/*
	Name: getyaw
	Namespace: namespace_c3527dc1
	Checksum: 0x2CFB296F
	Offset: 0x1F20
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function getyaw(org)
{
	angles = vectortoangles(org - self.origin);
	return angles[1];
}

/*
	Name: absyawtoenemy
	Namespace: namespace_c3527dc1
	Checksum: 0x13D8F0E1
	Offset: 0x1F68
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function absyawtoenemy(enemy)
{
	/#
		assert(isdefined(enemy));
	#/
	yaw = self.angles[1] - getyaw(enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: can_see_enemy
	Namespace: namespace_c3527dc1
	Checksum: 0xE4EF4B3A
	Offset: 0x2000
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function can_see_enemy(enemy)
{
	if(!isdefined(enemy))
	{
		return 0;
	}
	if(self function_ce6d3545(enemy))
	{
		return 0;
	}
	if(!self namespace_14c38db0::function_1c169b3a(enemy, 0))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a78474f2
	Namespace: namespace_c3527dc1
	Checksum: 0x319AEE9E
	Offset: 0x2060
	Size: 0x1A
	Parameters: 0
	Flags: Private
*/
private function function_a78474f2()
{
	return self ai_state::function_a78474f2();
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_c3527dc1
	Checksum: 0x1545DF58
	Offset: 0x2088
	Size: 0x64
	Parameters: 0
	Flags: Private
*/
private function get_favorite_enemy()
{
	var_edc20efd = self ai_state::function_4af1ff64();
	var_ff716a93 = self function_a78474f2();
	if(isdefined(var_ff716a93))
	{
		return ai_target::function_84235351(var_ff716a93, var_edc20efd);
	}
}

/*
	Name: get_last_valid_position
	Namespace: namespace_c3527dc1
	Checksum: 0x1A555F96
	Offset: 0x20F8
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function get_last_valid_position()
{
	if(isplayer(self) && isdefined(self.last_valid_position))
	{
		return self.last_valid_position;
	}
	return self.origin;
}

/*
	Name: function_3b9e385c
	Namespace: namespace_c3527dc1
	Checksum: 0xE3D1772A
	Offset: 0x2140
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function function_3b9e385c(entity)
{
	aiutility::cleararrivalpos(entity);
	entity function_a57c34b7(entity.origin);
	entity.ai.lookaround.var_268b3fe5 = gettime() + randomintrange(4500, 6500);
}

/*
	Name: function_b2e0da2
	Namespace: namespace_c3527dc1
	Checksum: 0x98C36B69
	Offset: 0x21C8
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_b2e0da2(entity)
{
	if(isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy)
	{
		return 1;
	}
	return 0;
}

/*
	Name: lid_closedpositionservicee
	Namespace: namespace_c3527dc1
	Checksum: 0x2E925DF1
	Offset: 0x2218
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
private function lid_closedpositionservicee(entity)
{
	entity.ai.reacquire_state = 0;
}

/*
	Name: function_bcd7b170
	Namespace: namespace_c3527dc1
	Checksum: 0xB7F7D905
	Offset: 0x2248
	Size: 0x236
	Parameters: 1
	Flags: Private
*/
private function function_bcd7b170(entity)
{
	if(!isdefined(entity.ai.reacquire_state))
	{
		entity.ai.reacquire_state = 0;
	}
	if(!isdefined(entity.enemy))
	{
		entity.ai.reacquire_state = 0;
		return 0;
	}
	if(!isalive(entity.enemy))
	{
		entity.ai.reacquire_state = 0;
		return;
	}
	if(entity function_ce6d3545(entity.enemy))
	{
		entity.ai.reacquire_state = 4;
		return;
	}
	var_27cd0f02 = entity cansee(entity.enemy, 20000);
	hasattackedenemyrecently = entity attackedrecently(entity.enemy, 3);
	var_fef47407 = entity.enemy attackedrecently(entity, 3);
	var_3b82352c = isdefined(function_9cc082d2(entity.enemy.origin, 30));
	if(var_3b82352c && (var_27cd0f02 || hasattackedenemyrecently || var_fef47407))
	{
		entity.ai.reacquire_state = 0;
		return 0;
	}
	entity.ai.reacquire_state++;
	if(entity.ai.reacquire_state >= 4)
	{
		entity flagenemyunattackable(randomintrange(4000, 4500));
	}
	return 0;
}

/*
	Name: function_dc0b544b
	Namespace: namespace_c3527dc1
	Checksum: 0x45F615C3
	Offset: 0x2488
	Size: 0x36
	Parameters: 2
	Flags: None
*/
function function_dc0b544b(entity, enemy)
{
	if(entity function_ce6d3545(enemy))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_last_attacker
	Namespace: namespace_c3527dc1
	Checksum: 0xC372A17B
	Offset: 0x24C8
	Size: 0x82
	Parameters: 0
	Flags: Private
*/
private function get_last_attacker()
{
	if(isdefined(self.attacker))
	{
		if(issentient(self.attacker))
		{
			return self.attacker;
		}
		if(isdefined(self.attacker.script_owner) && issentient(self.attacker.script_owner))
		{
			return self.attacker.script_owner;
		}
	}
	return undefined;
}

/*
	Name: target_enemy
	Namespace: namespace_c3527dc1
	Checksum: 0xD4380F29
	Offset: 0x2558
	Size: 0x4A4
	Parameters: 1
	Flags: None
*/
function target_enemy(entity)
{
	if(!isdefined(self.ai.state))
	{
		return;
	}
	if(isdefined(self.ignoreall) && self.ignoreall)
	{
		return;
	}
	self.script_owner tracking::track();
	last_enemy = entity.favoriteenemy;
	var_dc0b544b = 0;
	var_fe3bf748 = 1;
	if(isdefined(last_enemy))
	{
		var_dc0b544b = entity function_dc0b544b(entity, last_enemy);
		if(!var_dc0b544b && isdefined(entity.ai.var_4520deec) && gettime() >= entity.ai.var_4520deec + 15000)
		{
			newenemy = entity get_favorite_enemy();
			if(isdefined(newenemy) && newenemy != last_enemy)
			{
				var_dc0b544b = 1;
				var_fe3bf748 = 0;
			}
		}
	}
	if(var_dc0b544b || entity.ai.state == 2 || (isdefined(entity.favoriteenemy) && !entity ai_target::is_target_valid(entity.favoriteenemy)))
	{
		if(isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy.hunted_by) && entity.favoriteenemy.hunted_by > 0)
		{
			entity.favoriteenemy.hunted_by--;
		}
		entity clearenemy();
		entity.favoriteenemy = undefined;
		entity.ai.hasseenfavoriteenemy = 0;
		entity.ai.var_4520deec = undefined;
		entity ai_state::function_e0e1a7fc();
		lid_closedpositionservicee(entity);
		return;
	}
	if(!entity ai_target::is_target_valid(entity.favoriteenemy))
	{
		entity.favoriteenemy = entity get_favorite_enemy();
		entity namespace_14c38db0::function_a4d6d6d8(entity.favoriteenemy, 0);
	}
	if(!(isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy))
	{
		if(isdefined(entity.favoriteenemy) && entity can_see_enemy(entity.favoriteenemy))
		{
			entity.ai.hasseenfavoriteenemy = 1;
			entity.ai.var_4520deec = gettime();
			entity ai_state::function_e0e1a7fc();
			lid_closedpositionservicee(entity);
			level thread function_df8cb62a(entity);
		}
	}
	if(isdefined(entity.favoriteenemy) && (isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy))
	{
		if(gettime() >= entity.ai.var_4520deec + 50)
		{
			enemypos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, 1.2 * entity getpathfindingradius());
			if(isdefined(enemypos))
			{
				entity function_a57c34b7(enemypos);
			}
			else
			{
				entity function_a57c34b7(entity.favoriteenemy.origin);
			}
		}
	}
}

/*
	Name: function_df8cb62a
	Namespace: namespace_c3527dc1
	Checksum: 0x5A73E6
	Offset: 0x2A08
	Size: 0x170
	Parameters: 1
	Flags: None
*/
function function_df8cb62a(entity)
{
	entity endon(#"death");
	wait(1);
	while(entity.ai.state != 2 && (isdefined(entity.ai.hasseenfavoriteenemy) && entity.ai.hasseenfavoriteenemy))
	{
		if(isdefined(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) <= 400 * 400 && entity cansee(entity.enemy))
		{
			entity clientfield::set("ks_dog_bark", 1);
			entity playsound(#"hash_21775fa77c0df395");
			wait(1.2);
			entity clientfield::set("ks_dog_bark", 0);
		}
		wait(randomfloatrange(2, 4));
	}
}

/*
	Name: dogtargetservice
	Namespace: namespace_c3527dc1
	Checksum: 0x76B258EA
	Offset: 0x2B80
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function dogtargetservice(entity)
{
	if(!isdefined(self.script_owner))
	{
		return;
	}
	target_enemy(entity);
	entity ai_state::function_e8e7cf45();
}

/*
	Name: dogshouldwalk
	Namespace: namespace_c3527dc1
	Checksum: 0x12405CED
	Offset: 0x2BD0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function dogshouldwalk(entity)
{
	return !dogshouldrun(entity);
}

/*
	Name: dogshouldrun
	Namespace: namespace_c3527dc1
	Checksum: 0x9A7A7D9A
	Offset: 0x2C00
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function dogshouldrun(entity)
{
	if(isdefined(self.ai.state))
	{
		if(self.ai.state == 0 && self.ai.patrol.state == 1)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_e382db1f
	Namespace: namespace_c3527dc1
	Checksum: 0x9043F65B
	Offset: 0x2C70
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_e382db1f(entity)
{
	if(!(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy))
	{
		return 0;
	}
	lastattacker = get_last_attacker();
	if(isdefined(lastattacker) && self.favoriteenemy === lastattacker)
	{
		if(lastattacker attackedrecently(self, 0.1) && entity.ai.var_4520deec === gettime())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_ac9765d1
	Namespace: namespace_c3527dc1
	Checksum: 0xE1655CA3
	Offset: 0x2D38
	Size: 0x36
	Parameters: 1
	Flags: Private
*/
private function function_ac9765d1(entity)
{
	entity.nextpreemptivejuke = gettime() + randomintrange(4500, 6000);
}

/*
	Name: dogjukeinitialize
	Namespace: namespace_c3527dc1
	Checksum: 0x71497191
	Offset: 0x2D78
	Size: 0x10
	Parameters: 1
	Flags: Private
*/
private function dogjukeinitialize(entity)
{
	return 1;
}

/*
	Name: dogpreemptivejuketerminate
	Namespace: namespace_c3527dc1
	Checksum: 0x672AE9D4
	Offset: 0x2D90
	Size: 0x36
	Parameters: 1
	Flags: Private
*/
private function dogpreemptivejuketerminate(entity)
{
	entity.nextpreemptivejuke = gettime() + randomintrange(4500, 6000);
}

/*
	Name: function_6c2426d3
	Namespace: namespace_c3527dc1
	Checksum: 0x6E15DD31
	Offset: 0x2DD0
	Size: 0x29A
	Parameters: 1
	Flags: None
*/
function function_6c2426d3(entity)
{
	if(!isdefined(entity.enemy) || !isplayer(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime())
	{
		return 0;
	}
	disttoenemysq = distancesquared(entity.origin, entity.enemy.origin);
	if(disttoenemysq < 1800 * 1800 && disttoenemysq >= 400 * 400)
	{
		if(util::within_fov(entity.origin, entity.angles, entity.enemy.origin, cos(30)))
		{
			if(util::within_fov(entity.enemy.origin, entity.enemy.angles, entity.origin, cos(30)))
			{
				enemyangles = entity.enemy.angles;
				toenemy = entity.enemy.origin - entity.origin;
				forward = anglestoforward(enemyangles);
				dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
				/#
					record3dtext(acos(dotproduct), entity.origin + vectorscale((0, 0, 1), 10), (0, 1, 0), "");
				#/
				if(dotproduct > 0.766)
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: dogmeleeaction
	Namespace: namespace_c3527dc1
	Checksum: 0x9301C602
	Offset: 0x3078
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function dogmeleeaction(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: function_303397b0
	Namespace: namespace_c3527dc1
	Checksum: 0x7341BBC7
	Offset: 0x30B0
	Size: 0x18
	Parameters: 2
	Flags: None
*/
function function_303397b0(entity, asmstatename)
{
	return 4;
}

/*
	Name: function_475a38e6
	Namespace: namespace_c3527dc1
	Checksum: 0xBA57FEB6
	Offset: 0x30D0
	Size: 0x84
	Parameters: 5
	Flags: None
*/
function function_475a38e6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("zonly_physics", 0);
	entity.blockingpain = 1;
	entity.usegoalanimweight = 1;
	entity pathmode("dont move");
}

/*
	Name: function_75068028
	Namespace: namespace_c3527dc1
	Checksum: 0x5C825369
	Offset: 0x3160
	Size: 0x2C
	Parameters: 5
	Flags: None
*/
function function_75068028(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
}

/*
	Name: function_13978732
	Namespace: namespace_c3527dc1
	Checksum: 0xAA034506
	Offset: 0x3198
	Size: 0x84
	Parameters: 5
	Flags: None
*/
function function_13978732(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
	entity.usegoalanimweight = 0;
	entity pathmode("move allowed");
	entity orientmode("face default");
}

/*
	Name: function_3089bb44
	Namespace: namespace_c3527dc1
	Checksum: 0x7913F88E
	Offset: 0x3228
	Size: 0x26C
	Parameters: 1
	Flags: None
*/
function function_3089bb44(entity)
{
	if(isdefined(entity.enemy))
	{
		predictedenemypos = entity.enemy.origin;
		distancesq = distancesquared(entity.origin, entity.enemy.origin);
		if(isplayer(entity.enemy) && distancesq >= 100 * 100)
		{
			if(entity.enemy issprinting())
			{
				enemyvelocity = vectornormalize(entity.enemy getvelocity());
				var_7a61ad67 = vectornormalize(entity getvelocity());
				if(vectordot(var_7a61ad67, enemyvelocity) > cos(20))
				{
					/#
						record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
					#/
					return 0;
				}
			}
		}
		if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64)
		{
			return 0;
		}
		if(!entity cansee(entity.enemy))
		{
			return 0;
		}
		if(!tracepassedonnavmesh(entity.origin, entity.enemy.origin, entity getpathfindingradius()))
		{
			return 0;
		}
		return 1;
	}
	return 1;
}

#namespace namespace_9fa5eb75;

/*
	Name: __constructor
	Namespace: namespace_9fa5eb75
	Checksum: 0xAC3EEE2D
	Offset: 0x34A0
	Size: 0x1A
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	self.adjustmentstarted = 0;
	self.var_425c4c8b = 1;
}

/*
	Name: __destructor
	Namespace: namespace_9fa5eb75
	Checksum: 0x80F724D1
	Offset: 0x34C8
	Size: 0x4
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
}

#namespace namespace_c3527dc1;

/*
	Name: function_9fa5eb75
	Namespace: namespace_c3527dc1
	Checksum: 0x2DA8C559
	Offset: 0x34D8
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_9fa5eb75()
{
	classes.var_9fa5eb75[0] = spawnstruct();
	classes.var_9fa5eb75[0].__vtable[913321084] = &namespace_9fa5eb75::__destructor;
	classes.var_9fa5eb75[0].__vtable[674154906] = &namespace_9fa5eb75::__constructor;
}

/*
	Name: function_b17821dd
	Namespace: namespace_c3527dc1
	Checksum: 0x473612E4
	Offset: 0x3568
	Size: 0x6C
	Parameters: 5
	Flags: None
*/
function function_b17821dd(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face current");
	entity animmode("zonly_physics", 1);
}

/*
	Name: function_92620306
	Namespace: namespace_c3527dc1
	Checksum: 0x96F714DA
	Offset: 0x35E0
	Size: 0x4C
	Parameters: 5
	Flags: None
*/
function function_92620306(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face default");
}

/*
	Name: function_b1eb29d8
	Namespace: namespace_c3527dc1
	Checksum: 0xD981EDA6
	Offset: 0x3638
	Size: 0x31C
	Parameters: 5
	Flags: None
*/
function function_b1eb29d8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("gravity", 1);
	entity orientmode("face angle", entity.angles[1]);
	entity.usegoalanimweight = 1;
	entity pathmode("dont move");
	entity collidewithactors(0);
	entity pushplayer(0);
	if(isdefined(entity.enemy))
	{
		dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
		entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
	}
	if(!isdefined(entity.var_cd8354e0))
	{
		object = new var_9fa5eb75();
		[[ object ]]->__constructor();
		entity.var_cd8354e0 = object;
		entity.var_cd8354e0.var_9bfa8497 = entity.origin;
		entity.var_cd8354e0.var_98bc84b7 = getnotetracktimes(mocompanim, "start_adjust")[0];
		entity.var_cd8354e0.var_6392c3a2 = getnotetracktimes(mocompanim, "end_adjust")[0];
		var_e397f54c = getmovedelta(mocompanim, 0, 1, entity);
		entity.var_cd8354e0.var_cb28f380 = entity localtoworldcoords(var_e397f54c);
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
	Name: function_a5923bea
	Namespace: namespace_c3527dc1
	Checksum: 0xD0B2BD62
	Offset: 0x3960
	Size: 0xB34
	Parameters: 5
	Flags: None
*/
function function_a5923bea(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	/#
		assert(isdefined(entity.var_cd8354e0));
	#/
	var_e72a224a = entity getanimtime(mocompanim);
	if(isdefined(entity.enemy) && !entity.var_cd8354e0.adjustmentstarted && entity.var_cd8354e0.var_425c4c8b && var_e72a224a >= entity.var_cd8354e0.var_98bc84b7)
	{
		predictedenemypos = entity.enemy.origin;
		if(isplayer(entity.enemy))
		{
			velocity = entity.enemy getvelocity();
			if(length(velocity) > 0)
			{
				predictedenemypos = predictedenemypos + vectorscale(velocity, 0.25);
			}
		}
		entity.var_cd8354e0.var_736d2cce = predictedenemypos;
		var_cf699df5 = distancesquared(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_cb28f380);
		var_776ddabf = distancesquared(entity.var_cd8354e0.var_cb28f380, entity.var_cd8354e0.var_736d2cce);
		var_65cbfb52 = distancesquared(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_736d2cce);
		var_201660e6 = tracepassedonnavmesh(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_736d2cce, entity getpathfindingradius());
		traceresult = bullettrace(entity.origin, entity.var_cd8354e0.var_736d2cce + vectorscale((0, 0, 1), 30), 0, entity);
		isvisible = traceresult[#"fraction"] == 1;
		var_535d098c = 0;
		if(isdefined(traceresult[#"hitloc"]) && traceresult[#"hitloc"] == "riotshield")
		{
			var_cc075bd0 = vectornormalize(entity.origin - entity.var_cd8354e0.var_736d2cce);
			entity.var_cd8354e0.var_736d2cce = entity.var_cd8354e0.var_736d2cce + vectorscale(var_cc075bd0, 50);
			var_535d098c = 1;
		}
		if(!var_201660e6)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			entity.var_cd8354e0.var_425c4c8b = 0;
		}
		else if(var_cf699df5 > var_65cbfb52 && var_776ddabf >= 90 * 90)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			entity.var_cd8354e0.var_425c4c8b = 0;
		}
		else if(var_65cbfb52 >= 300 * 300)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			entity.var_cd8354e0.var_425c4c8b = 0;
		}
		if(var_535d098c)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			entity.var_cd8354e0.var_425c4c8b = 1;
		}
		if(entity.var_cd8354e0.var_425c4c8b)
		{
			var_776ddabf = distancesquared(entity.var_cd8354e0.var_cb28f380, entity.var_cd8354e0.var_736d2cce);
			var_beabc994 = anglestoforward(entity.angles);
			var_1c3641f2 = (entity.enemy.origin[0], entity.enemy.origin[1], entity.origin[2]);
			dirtoenemy = vectornormalize(var_1c3641f2 - entity.origin);
			zdiff = entity.var_cd8354e0.var_cb28f380[2] - entity.enemy.origin[2];
			var_6738a702 = abs(zdiff) <= 45;
			var_175919d1 = vectordot(var_beabc994, dirtoenemy) > cos(30);
			var_7948b2f3 = var_6738a702 && var_175919d1;
			var_425c4c8b = isvisible || var_535d098c && var_7948b2f3;
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
				var_90c3cdd2 = length(entity.var_cd8354e0.var_736d2cce - entity.var_cd8354e0.var_cb28f380);
				timestep = function_60d95f53();
				animlength = getanimlength(mocompanim) * 1000;
				starttime = entity.var_cd8354e0.var_98bc84b7 * animlength;
				stoptime = entity.var_cd8354e0.var_6392c3a2 * animlength;
				starttime = floor(starttime / timestep);
				stoptime = floor(stoptime / timestep);
				adjustduration = stoptime - starttime;
				entity.var_cd8354e0.var_10b8b6d1 = vectornormalize(entity.var_cd8354e0.var_736d2cce - entity.var_cd8354e0.var_cb28f380);
				entity.var_cd8354e0.var_8b9a15a6 = var_90c3cdd2 / adjustduration;
				entity.var_cd8354e0.var_425c4c8b = 1;
				entity.var_cd8354e0.adjustmentstarted = 1;
			}
			else
			{
				entity.var_cd8354e0.var_425c4c8b = 0;
			}
		}
	}
	if(entity.var_cd8354e0.adjustmentstarted && var_e72a224a <= entity.var_cd8354e0.var_6392c3a2)
	{
		/#
			assert(isdefined(entity.var_cd8354e0.var_10b8b6d1) && isdefined(entity.var_cd8354e0.var_8b9a15a6));
		#/
		/#
			recordsphere(entity.var_cd8354e0.var_cb28f380, 3, (0, 1, 0), "");
			recordsphere(entity.var_cd8354e0.var_736d2cce, 3, (0, 0, 1), "");
		#/
		adjustedorigin = entity.origin + entity.var_cd8354e0.var_10b8b6d1 * entity.var_cd8354e0.var_8b9a15a6;
		entity forceteleport(adjustedorigin);
	}
}

/*
	Name: function_668f9379
	Namespace: namespace_c3527dc1
	Checksum: 0x8D4C5A8E
	Offset: 0x44A0
	Size: 0xAE
	Parameters: 5
	Flags: None
*/
function function_668f9379(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.usegoalanimweight = 0;
	entity pathmode("move allowed");
	entity orientmode("face default");
	entity collidewithactors(1);
	entity pushplayer(1);
	entity.var_cd8354e0 = undefined;
}

/*
	Name: function_df9abf31
	Namespace: namespace_c3527dc1
	Checksum: 0xF4381CFE
	Offset: 0x4558
	Size: 0x6C
	Parameters: 1
	Flags: Event
*/
event function_df9abf31(eventstruct)
{
	if(isdefined(self.archetype) && self.archetype == #"mp_dog")
	{
		if(eventstruct.action == "bark")
		{
			self playsound(#"hash_21775fa77c0df395");
		}
	}
}

