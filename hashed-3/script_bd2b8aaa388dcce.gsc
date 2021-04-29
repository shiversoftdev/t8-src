// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_1fd28440161f280e;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_7b7ed6e4bc963a51;
#using script_caf007e2a98afa2;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;

#namespace zombiebehavior;

/*
	Name: init
	Namespace: zombiebehavior
	Checksum: 0x20B0D717
	Offset: 0x4A0
	Size: 0x17C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init()
{
	initzombiebehaviorsandasm();
	spawner::add_archetype_spawn_function(#"zombie", &archetypezombieblackboardinit);
	spawner::add_archetype_spawn_function(#"zombie", &archetypezombiedeathoverrideinit);
	spawner::add_archetype_spawn_function(#"zombie", &archetypezombiespecialeffectsinit);
	spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::zombiespawnsetup);
	/#
		spawner::add_archetype_spawn_function(#"zombie", &zombie_utility::function_27ba8249);
	#/
	clientfield::register("actor", "zombie", 1, 1, "int");
	clientfield::register("actor", "zombie_special_day", 1, 1, "counter");
	zombieinterface::registerzombieinterfaceattributes();
}

/*
	Name: initzombiebehaviorsandasm
	Namespace: zombiebehavior
	Checksum: 0x552DF4A8
	Offset: 0x628
	Size: 0x14CC
	Parameters: 0
	Flags: Linked, Private
*/
private function initzombiebehaviorsandasm()
{
	/#
		assert(!isdefined(&function_c6787767) || isscriptfunctionptr(&function_c6787767));
	#/
	/#
		assert(!isdefined(&zombiemoveactionupdate) || isscriptfunctionptr(&zombiemoveactionupdate));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"zombiemoveaction", &function_c6787767, &zombiemoveactionupdate, undefined);
	/#
		assert(!isdefined(&function_9b6830c9) || isscriptfunctionptr(&function_9b6830c9));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_fbdc2cc4) || isscriptfunctionptr(&function_fbdc2cc4));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_6b3df7eab00d9e03", &function_9b6830c9, undefined, &function_fbdc2cc4);
	/#
		assert(isscriptfunctionptr(&zombietargetservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietargetservice", &zombietargetservice);
	/#
		assert(isscriptfunctionptr(&zombiecrawlercollision));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiecrawlercollisionservice", &zombiecrawlercollision);
	/#
		assert(isscriptfunctionptr(&zombietraversalservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombietraversalservice", &zombietraversalservice);
	/#
		assert(isscriptfunctionptr(&zombieisatattackobject));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieisatattackobject", &zombieisatattackobject);
	/#
		assert(isscriptfunctionptr(&zombieshouldattackobject));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldattackobject", &zombieshouldattackobject);
	/#
		assert(isscriptfunctionptr(&zombieshouldmeleecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmelee", &zombieshouldmeleecondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldjumpmeleecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpmelee", &zombieshouldjumpmeleecondition);
	/#
		assert(isscriptfunctionptr(&zombieshouldjumpunderwatermelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjumpunderwatermelee", &zombieshouldjumpunderwatermelee);
	/#
		assert(isscriptfunctionptr(&zombiegiblegscondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiegiblegscondition", &zombiegiblegscondition);
	/#
		assert(isscriptfunctionptr(&zombieshoulddisplaypain));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshoulddisplaypain", &zombieshoulddisplaypain);
	/#
		assert(isscriptfunctionptr(&iszombiewalking));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"iszombiewalking", &iszombiewalking);
	/#
		assert(isscriptfunctionptr(&function_8cd8819b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_521713e6e7c89ff6", &function_8cd8819b);
	/#
		assert(isscriptfunctionptr(&function_ff3245d3));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_13ad697f9b7a1e13", &function_ff3245d3);
	/#
		assert(isscriptfunctionptr(&function_a716a3af));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4ba5bc2aba9e7670", &function_a716a3af);
	/#
		assert(isscriptfunctionptr(&function_1b8c9407));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4136381d29600bc", &function_1b8c9407);
	/#
		assert(isscriptfunctionptr(&function_ecba5a44));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1732367c7f780c76", &function_ecba5a44);
	/#
		assert(isscriptfunctionptr(&zombieshouldmeleesuicide));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldmeleesuicide", &zombieshouldmeleesuicide);
	/#
		assert(isscriptfunctionptr(&zombiemeleesuicidestart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicidestart", &zombiemeleesuicidestart);
	/#
		assert(isscriptfunctionptr(&zombiemeleesuicideupdate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideupdate", &zombiemeleesuicideupdate);
	/#
		assert(isscriptfunctionptr(&zombiemeleesuicideterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiemeleesuicideterminate", &zombiemeleesuicideterminate);
	/#
		assert(isscriptfunctionptr(&zombieshouldjukecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldjuke", &zombieshouldjukecondition);
	/#
		assert(isscriptfunctionptr(&zombiejukeactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionstart", &zombiejukeactionstart);
	/#
		assert(isscriptfunctionptr(&zombiejukeactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeactionterminate", &zombiejukeactionterminate);
	/#
		assert(isscriptfunctionptr(&zombiedeathaction));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedeathaction", &zombiedeathaction);
	/#
		assert(isscriptfunctionptr(&zombiejuke));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiejukeservice", &zombiejuke);
	/#
		assert(isscriptfunctionptr(&zombiestumble));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleservice", &zombiestumble);
	/#
		assert(isscriptfunctionptr(&zombieshouldstumblecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumblecondition", &zombieshouldstumblecondition);
	/#
		assert(isscriptfunctionptr(&zombiestumbleactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiestumbleactionstart", &zombiestumbleactionstart);
	/#
		assert(isscriptfunctionptr(&zombieattackobjectstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectstart", &zombieattackobjectstart);
	/#
		assert(isscriptfunctionptr(&zombieattackobjectterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieattackobjectterminate", &zombieattackobjectterminate);
	/#
		assert(isscriptfunctionptr(&waskilledbyinterdimensionalguncondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"waskilledbyinterdimensionalgun", &waskilledbyinterdimensionalguncondition);
	/#
		assert(isscriptfunctionptr(&wascrushedbyinterdimensionalgunblackholecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"wascrushedbyinterdimensionalgunblackhole", &wascrushedbyinterdimensionalgunblackholecondition);
	/#
		assert(isscriptfunctionptr(&zombieidgundeathupdate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieidgundeathupdate", &zombieidgundeathupdate);
	/#
		assert(isscriptfunctionptr(&zombieidgundeathupdate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombievortexpullupdate", &zombieidgundeathupdate);
	/#
		assert(isscriptfunctionptr(&zombiehaslegs));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiehaslegs", &zombiehaslegs);
	/#
		assert(isscriptfunctionptr(&zombieshouldproceduraltraverse));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldproceduraltraverse", &zombieshouldproceduraltraverse);
	/#
		assert(isscriptfunctionptr(&function_33ab7991));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_3940e25f9e65e404", &function_33ab7991);
	/#
		assert(isscriptfunctionptr(&function_f937377));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31cc70f275702cf6", &function_f937377);
	/#
		assert(isscriptfunctionptr(&function_a82068d7));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a6e9a34d9a8290", &function_a82068d7);
	/#
		assert(isscriptfunctionptr(&function_626edd6b));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"zombiemoveactionupdate", &function_626edd6b);
	animationstatenetwork::registernotetrackhandlerfunction("zombie_melee", &zombienotetrackmeleefire);
	animationstatenetwork::registernotetrackhandlerfunction("crushed", &zombienotetrackcrushfire);
	animationstatenetwork::registeranimationmocomp("mocomp_death_idgun@zombie", &zombieidgundeathmocompstart, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_vortex_pull@zombie", &zombieidgundeathmocompstart, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_death_idgun_hole@zombie", &zombieidgunholedeathmocompstart, undefined, &zombieidgunholedeathmocompterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_turn@zombie", &zombieturnmocompstart, &zombieturnmocompupdate, &zombieturnmocompterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_melee_jump@zombie", &zombiemeleejumpmocompstart, &zombiemeleejumpmocompupdate, &zombiemeleejumpmocompterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_zombie_idle@zombie", &zombiezombieidlemocompstart, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_attack_object@zombie", &zombieattackobjectmocompstart, &zombieattackobjectmocompupdate, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_cbbae5cb, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_zombie_melee@zombie", &function_54d75299, &function_d1474842, &function_b6d297bb);
}

/*
	Name: archetypezombieblackboardinit
	Namespace: zombiebehavior
	Checksum: 0xF01D0C6C
	Offset: 0x1B00
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function archetypezombieblackboardinit()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &archetypezombieonanimscriptedcallback;
}

/*
	Name: archetypezombieonanimscriptedcallback
	Namespace: zombiebehavior
	Checksum: 0x36EFE4D9
	Offset: 0x1B58
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function archetypezombieonanimscriptedcallback(entity)
{
	entity.__blackboard = undefined;
	entity archetypezombieblackboardinit();
}

/*
	Name: archetypezombiespecialeffectsinit
	Namespace: zombiebehavior
	Checksum: 0xA988D04D
	Offset: 0x1B90
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function archetypezombiespecialeffectsinit()
{
	aiutility::addaioverridedamagecallback(self, &archetypezombiespecialeffectscallback);
}

/*
	Name: archetypezombiespecialeffectscallback
	Namespace: zombiebehavior
	Checksum: 0x5CDD99C4
	Offset: 0x1BC0
	Size: 0x100
	Parameters: 13
	Flags: Linked, Private
*/
private function archetypezombiespecialeffectscallback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname)
{
	specialdayeffectchance = getdvarint(#"tu6_ffotd_zombiespecialdayeffectschance", 0);
	if(specialdayeffectchance && randomint(100) < specialdayeffectchance)
	{
		if(isdefined(eattacker) && isplayer(eattacker))
		{
			self clientfield::increment("zombie_special_day");
		}
	}
	return idamage;
}

/*
	Name: bb_getvarianttype
	Namespace: zombiebehavior
	Checksum: 0xF7C00C2F
	Offset: 0x1CC8
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function bb_getvarianttype()
{
	if(isdefined(self.variant_type))
	{
		return self.variant_type;
	}
	return 0;
}

/*
	Name: bb_getlowgravityvariant
	Namespace: zombiebehavior
	Checksum: 0xDCBA1380
	Offset: 0x1CF0
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function bb_getlowgravityvariant()
{
	if(isdefined(self.low_gravity_variant))
	{
		return self.low_gravity_variant;
	}
	return 0;
}

/*
	Name: iszombiewalking
	Namespace: zombiebehavior
	Checksum: 0xA9DB3FE1
	Offset: 0x1D18
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function iszombiewalking(entity)
{
	return !(isdefined(entity.missinglegs) && entity.missinglegs);
}

/*
	Name: zombieshoulddisplaypain
	Namespace: zombiebehavior
	Checksum: 0xE72F6351
	Offset: 0x1D50
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function zombieshoulddisplaypain(entity)
{
	if(isdefined(entity.suicidaldeath) && entity.suicidaldeath)
	{
		return 0;
	}
	if(!hasasm(entity) || entity function_ebbebf56() < 1)
	{
		return 0;
	}
	return !(isdefined(entity.missinglegs) && entity.missinglegs);
}

/*
	Name: zombieshouldjukecondition
	Namespace: zombiebehavior
	Checksum: 0xD54D491E
	Offset: 0x1DE8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function zombieshouldjukecondition(entity)
{
	if(isdefined(entity.juke) && (entity.juke == "left" || entity.juke == "right"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: zombieshouldstumblecondition
	Namespace: zombiebehavior
	Checksum: 0x75A8A35C
	Offset: 0x1E48
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function zombieshouldstumblecondition(entity)
{
	if(isdefined(entity.stumble))
	{
		return 1;
	}
	return 0;
}

/*
	Name: zombiejukeactionstart
	Namespace: zombiebehavior
	Checksum: 0x3AD9F368
	Offset: 0x1E78
	Size: 0xAA
	Parameters: 1
	Flags: Linked, Private
*/
private function zombiejukeactionstart(entity)
{
	entity setblackboardattribute("_juke_direction", entity.juke);
	if(isdefined(entity.jukedistance))
	{
		entity setblackboardattribute("_juke_distance", entity.jukedistance);
	}
	else
	{
		entity setblackboardattribute("_juke_distance", "short");
	}
	entity.jukedistance = undefined;
	entity.juke = undefined;
}

/*
	Name: zombiejukeactionterminate
	Namespace: zombiebehavior
	Checksum: 0x15C2CA93
	Offset: 0x1F30
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function zombiejukeactionterminate(entity)
{
	entity clearpath();
}

/*
	Name: zombiestumbleactionstart
	Namespace: zombiebehavior
	Checksum: 0x55D7061A
	Offset: 0x1F60
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
private function zombiestumbleactionstart(entity)
{
	entity.stumble = undefined;
}

/*
	Name: zombieattackobjectstart
	Namespace: zombiebehavior
	Checksum: 0xFD20938E
	Offset: 0x1F80
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function zombieattackobjectstart(entity)
{
	entity.is_inert = 1;
}

/*
	Name: zombieattackobjectterminate
	Namespace: zombiebehavior
	Checksum: 0x81EB252A
	Offset: 0x1FA8
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function zombieattackobjectterminate(entity)
{
	entity.is_inert = 0;
}

/*
	Name: zombiegiblegscondition
	Namespace: zombiebehavior
	Checksum: 0x856AD35B
	Offset: 0x1FD0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function zombiegiblegscondition(entity)
{
	return gibserverutils::isgibbed(entity, 256) || gibserverutils::isgibbed(entity, 128);
}

/*
	Name: function_f937377
	Namespace: zombiebehavior
	Checksum: 0x63C65E1A
	Offset: 0x2020
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_f937377(entity)
{
	entity.ai.var_80045105 = gettime();
}

/*
	Name: zombienotetrackmeleefire
	Namespace: zombiebehavior
	Checksum: 0xB5BAE003
	Offset: 0x2050
	Size: 0x5B4
	Parameters: 1
	Flags: Linked
*/
function zombienotetrackmeleefire(entity)
{
	if(isdefined(entity.marked_for_death) && entity.marked_for_death)
	{
		return;
	}
	entity.var_88bd96a9 = gettime() + getdvarfloat(#"hash_6182e0a57e0b549f", 1) * 1000;
	if(isdefined(entity.aat_turned) && entity.aat_turned)
	{
		if(isdefined(entity.enemy) && isalive(entity.enemy) && !isplayer(entity.enemy))
		{
			if(isdefined(entity.var_16d0eb06) && (isdefined(entity.enemy.var_6d23c054) && entity.enemy.var_6d23c054))
			{
				if(isdefined(entity.var_443d78cc))
				{
					e_attacker = entity.var_443d78cc;
				}
				else
				{
					e_attacker = entity;
				}
				entity.enemy dodamage(entity.var_16d0eb06, entity.origin, e_attacker, entity);
				if(!isalive(entity.enemy))
				{
					gibserverutils::gibhead(entity.enemy);
					entity.enemy zombie_utility::gib_random_parts();
					entity.enemy.var_7105092c = 1;
					entity.n_aat_turned_zombie_kills++;
				}
			}
			else if(isdefined(entity.enemy.var_6d23c054) && entity.enemy.var_6d23c054 && (isdefined(entity.enemy.allowdeath) && entity.enemy.allowdeath))
			{
				if(isdefined(entity.var_443d78cc))
				{
					e_attacker = entity.var_443d78cc;
				}
				else
				{
					e_attacker = entity;
				}
				gibserverutils::gibhead(entity.enemy);
				entity.enemy zombie_utility::gib_random_parts();
				entity.enemy.var_7105092c = 1;
				entity.enemy kill(entity.enemy.origin, e_attacker, entity, undefined, undefined, 1);
				entity.n_aat_turned_zombie_kills++;
			}
			else if(isdefined(entity.enemy.canbetargetedbyturnedzombies) && entity.enemy.canbetargetedbyturnedzombies)
			{
				entity melee();
			}
			entity callback::callback(#"hash_11aa32ad6d527054");
		}
	}
	else if(isdefined(entity.enemy) && (isdefined(entity.enemy.ignoreme) && entity.enemy.ignoreme))
	{
		return;
	}
	if(isdefined(entity.ai.var_80045105))
	{
		/#
			record3dtext("" + gettime() - entity.ai.var_80045105, self.origin, (1, 0, 0), "", entity);
		#/
	}
	if(isdefined(level.var_847ab632))
	{
		entity [[level.var_847ab632]]();
	}
	else
	{
		entity melee();
	}
	/#
		record3dtext("", entity.origin, (1, 0, 0), "", entity);
		if(isdefined(entity.enemy))
		{
			eyepos = entity geteye();
			record3dtext("" + distance2d(eyepos, entity.enemy.origin), entity.origin, (1, 0, 0), "", entity);
		}
	#/
	if(zombieshouldattackobject(entity))
	{
		if(isdefined(level.attackablecallback))
		{
			entity.attackable [[level.attackablecallback]](entity);
		}
	}
	entity callback::callback(#"hash_11aa32ad6d527054");
}

/*
	Name: zombienotetrackcrushfire
	Namespace: zombiebehavior
	Checksum: 0x3C2E24F9
	Offset: 0x2610
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function zombienotetrackcrushfire(entity)
{
	entity delete();
}

/*
	Name: zombietargetservice
	Namespace: zombiebehavior
	Checksum: 0xB8E17CF6
	Offset: 0x2640
	Size: 0x258
	Parameters: 1
	Flags: Linked
*/
function zombietargetservice(entity)
{
	if(isdefined(entity.enablepushtime))
	{
		if(gettime() >= entity.enablepushtime)
		{
			entity collidewithactors(1);
			entity.enablepushtime = undefined;
		}
	}
	if(isdefined(entity.disabletargetservice) && entity.disabletargetservice)
	{
		return 0;
	}
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
	specifictarget = undefined;
	if(isdefined(level.zombielevelspecifictargetcallback))
	{
		specifictarget = [[level.zombielevelspecifictargetcallback]]();
	}
	if(isdefined(specifictarget))
	{
		entity setgoal(specifictarget.origin);
	}
	else
	{
		player = zombie_utility::get_closest_valid_player(self.origin, self.ignore_player);
		if(!isdefined(player))
		{
			if(isdefined(self.ignore_player))
			{
				if(isdefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]())
				{
					return 0;
				}
				self.ignore_player = [];
			}
			self setgoal(self.origin);
			return 0;
		}
		if(isdefined(player.last_valid_position))
		{
			if(!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal))
			{
				if(isdefined(level.zombie_use_zigzag_path) && level.zombie_use_zigzag_path)
				{
					entity zombieupdatezigzaggoal();
				}
				else
				{
					entity setgoal(player.last_valid_position);
				}
			}
			return 1;
		}
		if(!(isdefined(self.zombie_do_not_update_goal) && self.zombie_do_not_update_goal))
		{
			entity setgoal(entity.origin);
		}
		return 0;
	}
}

/*
	Name: zombieupdatezigzaggoal
	Namespace: zombiebehavior
	Checksum: 0x72FD0703
	Offset: 0x28A0
	Size: 0x5CC
	Parameters: 0
	Flags: Linked
*/
function zombieupdatezigzaggoal()
{
	aiprofile_beginentry("zombieUpdateZigZagGoal");
	shouldrepath = 0;
	if(!shouldrepath && isdefined(self.favoriteenemy))
	{
		if(!isdefined(self.nextgoalupdate) || self.nextgoalupdate <= gettime())
		{
			shouldrepath = 1;
		}
		else if(distancesquared(self.origin, self.favoriteenemy.origin) <= 250 * 250)
		{
			shouldrepath = 1;
		}
		else if(isdefined(self.pathgoalpos))
		{
			distancetogoalsqr = distancesquared(self.origin, self.pathgoalpos);
			shouldrepath = distancetogoalsqr < 72 * 72;
		}
	}
	if(isdefined(self.keep_moving) && self.keep_moving)
	{
		if(gettime() > self.keep_moving_time)
		{
			self.keep_moving = 0;
		}
	}
	if(shouldrepath)
	{
		goalpos = self.favoriteenemy.origin;
		if(isdefined(self.favoriteenemy.last_valid_position))
		{
			goalpos = self.favoriteenemy.last_valid_position;
		}
		self setgoal(goalpos);
		if(distancesquared(self.origin, goalpos) > 250 * 250)
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
					}
				}
			#/
			if(isdefined(level._zombiezigzagdistancemin) && isdefined(level._zombiezigzagdistancemax))
			{
				min = level._zombiezigzagdistancemin;
				max = level._zombiezigzagdistancemax;
			}
			else
			{
				min = 240;
				max = 600;
			}
			deviationdistance = randomintrange(min, max);
			segmentlength = 0;
			for(index = 1; index < path.size; index++)
			{
				currentseglength = distance(path[index - 1], path[index]);
				if(segmentlength + currentseglength > deviationdistance)
				{
					remaininglength = deviationdistance - segmentlength;
					seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
					/#
						recordcircle(seedposition, 2, (1, 0.5, 0), "", self);
					#/
					innerzigzagradius = 0;
					outerzigzagradius = 96;
					queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 0.5 * 72, 16, self, 16);
					positionquery_filter_inclaimedlocation(queryresult, self);
					if(queryresult.data.size > 0)
					{
						point = queryresult.data[randomint(queryresult.data.size)];
						self setgoal(point.origin);
					}
					break;
				}
				segmentlength = segmentlength + currentseglength;
			}
		}
		if(isdefined(level._zombiezigzagtimemin) && isdefined(level._zombiezigzagtimemax))
		{
			mintime = level._zombiezigzagtimemin;
			maxtime = level._zombiezigzagtimemax;
		}
		else
		{
			mintime = 2500;
			maxtime = 3500;
		}
		self.nextgoalupdate = gettime() + randomintrange(mintime, maxtime);
	}
	aiprofile_endentry();
}

/*
	Name: zombiecrawlercollision
	Namespace: zombiebehavior
	Checksum: 0x10115CBB
	Offset: 0x2E78
	Size: 0x1FE
	Parameters: 1
	Flags: Linked
*/
function zombiecrawlercollision(entity)
{
	if(!(isdefined(entity.missinglegs) && entity.missinglegs) && (!(isdefined(entity.knockdown) && entity.knockdown)))
	{
		return 0;
	}
	if(isdefined(entity.dontpushtime))
	{
		if(gettime() < entity.dontpushtime)
		{
			return 1;
		}
	}
	if(!isdefined(level.zombie_team))
	{
		return 0;
	}
	zombies = getaiteamarray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(zombie == entity)
		{
			continue;
		}
		if(isdefined(zombie.missinglegs) && zombie.missinglegs || (isdefined(zombie.knockdown) && zombie.knockdown))
		{
			continue;
		}
		dist_sq = distancesquared(entity.origin, zombie.origin);
		if(dist_sq < 14400)
		{
			entity collidewithactors(0);
			entity.dontpushtime = gettime() + 2000;
			return 1;
		}
	}
	entity collidewithactors(1);
	return 0;
}

/*
	Name: zombietraversalservice
	Namespace: zombiebehavior
	Checksum: 0xE65D6FB4
	Offset: 0x3080
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function zombietraversalservice(entity)
{
	if(isdefined(entity.traversestartnode))
	{
		entity collidewithactors(0);
		return 1;
	}
	return 0;
}

/*
	Name: zombieisatattackobject
	Namespace: zombiebehavior
	Checksum: 0xB0DE05EA
	Offset: 0x30C8
	Size: 0x1CA
	Parameters: 1
	Flags: Linked
*/
function zombieisatattackobject(entity)
{
	if(isdefined(entity.missinglegs) && entity.missinglegs)
	{
		return 0;
	}
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return 0;
	}
	if(isdefined(entity.favoriteenemy) && (isdefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target))
	{
		return 0;
	}
	if(isdefined(entity.aat_turned) && entity.aat_turned)
	{
		return 0;
	}
	if(isdefined(entity.attackable) && (isdefined(entity.attackable.is_active) && entity.attackable.is_active))
	{
		if(!isdefined(entity.attackable_slot))
		{
			return 0;
		}
		dist = distance2dsquared(entity.origin, entity.attackable_slot.origin);
		if(dist < 256)
		{
			height_offset = abs(entity.origin[2] - entity.attackable_slot.origin[2]);
			if(height_offset < 32)
			{
				entity.is_at_attackable = 1;
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: zombieshouldattackobject
	Namespace: zombiebehavior
	Checksum: 0x7C9E2315
	Offset: 0x32A0
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function zombieshouldattackobject(entity)
{
	if(isdefined(entity.missinglegs) && entity.missinglegs)
	{
		return 0;
	}
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return 0;
	}
	if(isdefined(entity.favoriteenemy) && (isdefined(entity.favoriteenemy.b_is_designated_target) && entity.favoriteenemy.b_is_designated_target))
	{
		return 0;
	}
	if(isdefined(entity.aat_turned) && entity.aat_turned)
	{
		return 0;
	}
	if(isdefined(entity.attackable) && (isdefined(entity.attackable.is_active) && entity.attackable.is_active))
	{
		if(isdefined(entity.is_at_attackable) && entity.is_at_attackable)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_997f1224
	Namespace: zombiebehavior
	Checksum: 0x974F1AE
	Offset: 0x33E0
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_997f1224(entity)
{
	if(entity.archetype == #"zombie" && !isdefined(entity.var_9fde8624) && (!(isdefined(self.missinglegs) && self.missinglegs)))
	{
		if(entity.zombie_move_speed == "walk")
		{
			return 100 * 100;
		}
		if(entity.zombie_move_speed == "run")
		{
			return 120 * 120;
		}
		return 90 * 90;
	}
	if(isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone)
	{
		meleedistsq = entity.meleeweapon.var_d3cafde6 * entity.meleeweapon.var_d3cafde6;
	}
	if(!isdefined(meleedistsq))
	{
		return 100 * 100;
	}
	return meleedistsq;
}

/*
	Name: zombieshouldmeleecondition
	Namespace: zombiebehavior
	Checksum: 0x3DFAB6B1
	Offset: 0x3510
	Size: 0x396
	Parameters: 1
	Flags: Linked
*/
function zombieshouldmeleecondition(entity)
{
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return 0;
	}
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.marked_for_death) && entity.marked_for_death)
	{
		return 0;
	}
	if(isdefined(entity.ignoremelee) && entity.ignoremelee)
	{
		return 0;
	}
	if(abs(entity.origin[2] - entity.enemy.origin[2]) > (isdefined(entity.var_737e8510) ? entity.var_737e8510 : 64))
	{
		return 0;
	}
	meleedistsq = function_997f1224(entity);
	if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq)
	{
		return 0;
	}
	var_7b871a7d = 1;
	dist2d = distance2dsquared(entity.origin, entity.enemy.origin);
	if(dist2d < 576)
	{
		height = entity.origin[2] - entity.enemy.origin[2];
		if(height < 64)
		{
			var_7b871a7d = 0;
		}
	}
	if(var_7b871a7d)
	{
		yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
		if(abs(yawtoenemy) > (isdefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60))
		{
			return 0;
		}
		if(!entity cansee(entity.enemy))
		{
			return 0;
		}
	}
	if(distancesquared(entity.origin, entity.enemy.origin) < 40 * 40)
	{
		return 1;
	}
	if(var_7b871a7d)
	{
		if(!tracepassedonnavmesh(entity.origin, (isdefined(entity.enemy.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin), entity.enemy getpathfindingradius()))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_1b8c9407
	Namespace: zombiebehavior
	Checksum: 0xF8540693
	Offset: 0x38B0
	Size: 0xA6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1b8c9407(entity)
{
	/#
		if(getdvarint(#"hash_1a5939d8c37a2e07", 0))
		{
			return 0;
		}
	#/
	var_9fce1294 = blackboard::getblackboardevents("zombie_full_pain");
	if(isdefined(var_9fce1294) && var_9fce1294.size)
	{
		return 0;
	}
	if(isdefined(level.var_eeb66e64) && ![[level.var_eeb66e64]](entity))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_ecba5a44
	Namespace: zombiebehavior
	Checksum: 0xA3A99B1A
	Offset: 0x3960
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ecba5a44(entity)
{
	var_1e466fbb = spawnstruct();
	var_1e466fbb.enemy = entity.enemy;
	blackboard::addblackboardevent("zombie_full_pain", var_1e466fbb, randomintrange(6000, 9000));
}

/*
	Name: function_8cd8819b
	Namespace: zombiebehavior
	Checksum: 0x8703B0D
	Offset: 0x39E0
	Size: 0x28
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8cd8819b(entity)
{
	return isdefined(entity.low_gravity) && entity.low_gravity;
}

/*
	Name: function_ff3245d3
	Namespace: zombiebehavior
	Checksum: 0xE6198D00
	Offset: 0x3A10
	Size: 0x30
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ff3245d3(entity)
{
	return !isdefined(entity.var_40f848c3) || entity.var_40f848c3 < gettime();
}

/*
	Name: function_a716a3af
	Namespace: zombiebehavior
	Checksum: 0xEBEAAE92
	Offset: 0x3A48
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a716a3af(entity)
{
	entity.var_40f848c3 = gettime() + 1000;
	return 1;
}

/*
	Name: zombieshouldjumpmeleecondition
	Namespace: zombiebehavior
	Checksum: 0x35835F06
	Offset: 0x3A78
	Size: 0x390
	Parameters: 1
	Flags: Linked
*/
function zombieshouldjumpmeleecondition(entity)
{
	if(!(isdefined(entity.low_gravity) && entity.low_gravity))
	{
		return 0;
	}
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return 0;
	}
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
	if(entity.enemy isonground())
	{
		if(isplayer(entity.enemy) && entity.enemy isplayerswimming())
		{
			waterheight = getwaterheight(entity.enemy.origin);
			if(waterheight - entity.enemy.origin[2] < 24)
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}
	jumpchance = getdvarfloat(#"zmmeleejumpchance", 0.5);
	if(entity getentitynumber() % 10 / 10 > jumpchance)
	{
		return 0;
	}
	predictedposition = entity.enemy.origin + entity.enemy getvelocity() * float(function_60d95f53()) / 1000 * 2;
	jumpdistancesq = pow(getdvarint(#"zmmeleejumpdistance", 180), 2);
	if(distance2dsquared(entity.origin, predictedposition) > jumpdistancesq)
	{
		return 0;
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	heighttoenemy = entity.enemy.origin[2] - entity.origin[2];
	if(heighttoenemy <= getdvarint(#"zmmeleejumpheightdifference", 60))
	{
		return 0;
	}
	return 1;
}

/*
	Name: zombieshouldjumpunderwatermelee
	Namespace: zombiebehavior
	Checksum: 0x99711B0B
	Offset: 0x3E10
	Size: 0x250
	Parameters: 1
	Flags: Linked
*/
function zombieshouldjumpunderwatermelee(entity)
{
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return 0;
	}
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
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
	if(entity.enemy isonground())
	{
		return 0;
	}
	if(entity depthinwater() < 48)
	{
		return 0;
	}
	jumpdistancesq = pow(getdvarint(#"zmmeleewaterjumpdistance", 64), 2);
	if(distance2dsquared(entity.origin, entity.enemy.origin) > jumpdistancesq)
	{
		return 0;
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	heighttoenemy = entity.enemy.origin[2] - entity.origin[2];
	if(heighttoenemy <= getdvarint(#"zmmeleejumpunderwaterheightdifference", 48))
	{
		return 0;
	}
	return 1;
}

/*
	Name: zombiestumble
	Namespace: zombiebehavior
	Checksum: 0x785920B2
	Offset: 0x4068
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function zombiestumble(entity)
{
	if(isdefined(entity.missinglegs) && entity.missinglegs)
	{
		return 0;
	}
	if(!(isdefined(entity.canstumble) && entity.canstumble))
	{
		return 0;
	}
	if(!isdefined(entity.zombie_move_speed) || entity.zombie_move_speed != "sprint")
	{
		return 0;
	}
	if(isdefined(entity.stumble))
	{
		return 0;
	}
	if(!isdefined(entity.next_stumble_time))
	{
		entity.next_stumble_time = gettime() + randomintrange(9000, 12000);
	}
	if(gettime() > entity.next_stumble_time)
	{
		if(randomint(100) < 5)
		{
			closestplayer = arraygetclosest(entity.origin, level.players);
			if(distancesquared(closestplayer.origin, entity.origin) > 50000)
			{
				if(isdefined(entity.next_juke_time))
				{
					entity.next_juke_time = undefined;
				}
				entity.next_stumble_time = undefined;
				entity.stumble = 1;
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: zombiejuke
	Namespace: zombiebehavior
	Checksum: 0xBC8506FC
	Offset: 0x4218
	Size: 0x3C2
	Parameters: 1
	Flags: Linked
*/
function zombiejuke(entity)
{
	if(!entity ai::has_behavior_attribute("can_juke"))
	{
		return 0;
	}
	if(!entity ai::get_behavior_attribute("can_juke"))
	{
		return 0;
	}
	if(isdefined(entity.missinglegs) && entity.missinglegs)
	{
		return 0;
	}
	if(entity aiutility::function_cc26899f() != "locomotion_speed_walk")
	{
		if(entity ai::has_behavior_attribute("spark_behavior") && !entity ai::get_behavior_attribute("spark_behavior"))
		{
			return 0;
		}
	}
	if(isdefined(entity.juke))
	{
		return 0;
	}
	if(!isdefined(entity.next_juke_time))
	{
		entity.next_juke_time = gettime() + randomintrange(7500, 9500);
	}
	if(gettime() > entity.next_juke_time)
	{
		entity.next_juke_time = undefined;
		if(randomint(100) < 25 || (entity ai::has_behavior_attribute("spark_behavior") && entity ai::get_behavior_attribute("spark_behavior")))
		{
			if(isdefined(entity.next_stumble_time))
			{
				entity.next_stumble_time = undefined;
			}
			forwardoffset = 15;
			entity.ignorebackwardposition = 1;
			if(math::cointoss())
			{
				jukedistance = 101;
				entity.jukedistance = "long";
				switch(entity aiutility::function_cc26899f())
				{
					case "locomotion_speed_run":
					case "locomotion_speed_walk":
					{
						forwardoffset = 122;
						break;
					}
					case "locomotion_speed_sprint":
					{
						forwardoffset = 129;
						break;
					}
				}
				entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
			}
			if(!isdefined(entity.juke) || entity.juke == "forward")
			{
				jukedistance = 69;
				entity.jukedistance = "short";
				switch(entity aiutility::function_cc26899f())
				{
					case "locomotion_speed_run":
					case "locomotion_speed_walk":
					{
						forwardoffset = 127;
						break;
					}
					case "locomotion_speed_sprint":
					{
						forwardoffset = 148;
						break;
					}
				}
				entity.juke = aiutility::calculatejukedirection(entity, forwardoffset, jukedistance);
				if(entity.juke == "forward")
				{
					entity.juke = undefined;
					entity.jukedistance = undefined;
					return 0;
				}
			}
		}
	}
}

/*
	Name: zombiedeathaction
	Namespace: zombiebehavior
	Checksum: 0x46571BB9
	Offset: 0x45E8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function zombiedeathaction(entity)
{
}

/*
	Name: waskilledbyinterdimensionalguncondition
	Namespace: zombiebehavior
	Checksum: 0x496F3687
	Offset: 0x4600
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function waskilledbyinterdimensionalguncondition(entity)
{
	if(isdefined(entity.interdimensional_gun_kill) && !isdefined(entity.killby_interdimensional_gun_hole) && isalive(entity))
	{
		return 1;
	}
	return 0;
}

/*
	Name: wascrushedbyinterdimensionalgunblackholecondition
	Namespace: zombiebehavior
	Checksum: 0xE80B6140
	Offset: 0x4658
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function wascrushedbyinterdimensionalgunblackholecondition(entity)
{
	if(isdefined(entity.killby_interdimensional_gun_hole))
	{
		return 1;
	}
	return 0;
}

/*
	Name: zombieidgundeathmocompstart
	Namespace: zombiebehavior
	Checksum: 0xAF28DCE0
	Offset: 0x4688
	Size: 0xC2
	Parameters: 5
	Flags: Linked
*/
function zombieidgundeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("noclip");
	entity.pushable = 0;
	entity.blockingpain = 1;
	entity pathmode("dont move");
	entity.hole_pull_speed = 0;
}

/*
	Name: zombiemeleejumpmocompstart
	Namespace: zombiebehavior
	Checksum: 0x23410A42
	Offset: 0x4758
	Size: 0xC2
	Parameters: 5
	Flags: Linked
*/
function zombiemeleejumpmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face enemy");
	entity animmode("noclip", 0);
	entity.pushable = 0;
	entity.blockingpain = 1;
	entity.clamptonavmesh = 0;
	entity collidewithactors(0);
	entity.jumpstartposition = entity.origin;
}

/*
	Name: zombiemeleejumpmocompupdate
	Namespace: zombiebehavior
	Checksum: 0x40D205CF
	Offset: 0x4828
	Size: 0x32C
	Parameters: 5
	Flags: Linked
*/
function zombiemeleejumpmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	normalizedtime = entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime / mocompduration;
	if(normalizedtime > 0.5)
	{
		entity orientmode("face angle", entity.angles[1]);
	}
	speed = 5;
	if(isdefined(entity.zombie_move_speed))
	{
		switch(entity.zombie_move_speed)
		{
			case "walk":
			{
				speed = 5;
				break;
			}
			case "run":
			{
				speed = 6;
				break;
			}
			case "sprint":
			{
				speed = 7;
				break;
			}
		}
	}
	newposition = entity.origin + anglestoforward(entity.angles) * speed;
	newtestposition = (newposition[0], newposition[1], entity.jumpstartposition[2]);
	newvalidposition = getclosestpointonnavmesh(newtestposition, 12, 20);
	if(isdefined(newvalidposition))
	{
		newvalidposition = (newvalidposition[0], newvalidposition[1], entity.origin[2]);
	}
	else
	{
		newvalidposition = entity.origin;
	}
	if(!(isdefined(entity.var_7c16e514) && entity.var_7c16e514))
	{
		waterheight = getwaterheight(entity.origin);
		if(newvalidposition[2] + entity function_6a9ae71() > waterheight)
		{
			newvalidposition = (newvalidposition[0], newvalidposition[1], waterheight - entity function_6a9ae71());
		}
	}
	groundpoint = getclosestpointonnavmesh(newvalidposition, 12, 20);
	if(isdefined(groundpoint) && groundpoint[2] > newvalidposition[2])
	{
		newvalidposition = (newvalidposition[0], newvalidposition[1], groundpoint[2]);
	}
	entity forceteleport(newvalidposition);
}

/*
	Name: zombiemeleejumpmocompterminate
	Namespace: zombiebehavior
	Checksum: 0x8531D3A1
	Offset: 0x4B60
	Size: 0xBC
	Parameters: 5
	Flags: Linked
*/
function zombiemeleejumpmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.pushable = 1;
	entity.blockingpain = 0;
	entity.clamptonavmesh = 1;
	entity collidewithactors(1);
	groundpoint = getclosestpointonnavmesh(entity.origin, 12);
	if(isdefined(groundpoint))
	{
		entity forceteleport(groundpoint);
	}
}

/*
	Name: zombieidgundeathupdate
	Namespace: zombiebehavior
	Checksum: 0x26A86AC2
	Offset: 0x4C28
	Size: 0x334
	Parameters: 5
	Flags: Linked
*/
function zombieidgundeathupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(!isdefined(entity.killby_interdimensional_gun_hole))
	{
		entity_eye = entity geteye();
		if(entity.b_vortex_repositioned !== 1)
		{
			entity.b_vortex_repositioned = 1;
			v_nearest_navmesh_point = getclosestpointonnavmesh(entity.damageorigin, 36, 15);
			if(isdefined(v_nearest_navmesh_point))
			{
				f_distance = distance(entity.damageorigin, v_nearest_navmesh_point);
				if(f_distance < 41)
				{
					entity.damageorigin = entity.damageorigin + vectorscale((0, 0, 1), 36);
				}
			}
		}
		entity_center = entity.origin + entity_eye - entity.origin / 2;
		flyingdir = entity.damageorigin - entity_center;
		lengthfromhole = length(flyingdir);
		if(lengthfromhole < entity.hole_pull_speed)
		{
			entity.killby_interdimensional_gun_hole = 1;
			entity.allowdeath = 1;
			entity.takedamage = 1;
			entity.aioverridedamage = undefined;
			entity.magic_bullet_shield = 0;
			level notify(#"interdimensional_kill", {#entity:entity});
			if(isdefined(entity.interdimensional_gun_weapon) && isdefined(entity.interdimensional_gun_attacker))
			{
				entity kill(entity.origin, entity.interdimensional_gun_attacker, entity.interdimensional_gun_attacker, entity.interdimensional_gun_weapon);
			}
			else
			{
				entity kill(entity.origin);
			}
		}
		else if(entity.hole_pull_speed < 12)
		{
			entity.hole_pull_speed = entity.hole_pull_speed + 0.5;
			if(entity.hole_pull_speed > 12)
			{
				entity.hole_pull_speed = 12;
			}
		}
		flyingdir = vectornormalize(flyingdir);
		entity forceteleport(entity.origin + flyingdir * entity.hole_pull_speed);
	}
}

/*
	Name: zombieidgunholedeathmocompstart
	Namespace: zombiebehavior
	Checksum: 0xC999174D
	Offset: 0x4F68
	Size: 0x8A
	Parameters: 5
	Flags: Linked
*/
function zombieidgunholedeathmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("noclip");
	entity.pushable = 0;
}

/*
	Name: zombieidgunholedeathmocompterminate
	Namespace: zombiebehavior
	Checksum: 0xF9ECC6D2
	Offset: 0x5000
	Size: 0x64
	Parameters: 5
	Flags: Linked
*/
function zombieidgunholedeathmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(!(isdefined(entity.interdimensional_gun_kill_vortex_explosion) && entity.interdimensional_gun_kill_vortex_explosion))
	{
		entity hide();
	}
}

/*
	Name: zombieturnmocompstart
	Namespace: zombiebehavior
	Checksum: 0x9153A10B
	Offset: 0x5070
	Size: 0x7C
	Parameters: 5
	Flags: Linked, Private
*/
private function zombieturnmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("angle deltas", 0);
}

/*
	Name: zombieturnmocompupdate
	Namespace: zombiebehavior
	Checksum: 0xEE2103CC
	Offset: 0x50F8
	Size: 0xA4
	Parameters: 5
	Flags: Linked, Private
*/
private function zombieturnmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	normalizedtime = entity getanimtime(mocompanim) + mocompanimblendouttime / mocompduration;
	if(normalizedtime > 0.25)
	{
		entity orientmode("face motion");
		entity animmode("normal", 0);
	}
}

/*
	Name: zombieturnmocompterminate
	Namespace: zombiebehavior
	Checksum: 0x5A401D0F
	Offset: 0x51A8
	Size: 0x6C
	Parameters: 5
	Flags: Linked, Private
*/
private function zombieturnmocompterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face motion");
	entity animmode("normal", 0);
}

/*
	Name: zombiehaslegs
	Namespace: zombiebehavior
	Checksum: 0xC8331031
	Offset: 0x5220
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function zombiehaslegs(entity)
{
	if(entity.missinglegs === 1)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_33ab7991
	Namespace: zombiebehavior
	Checksum: 0x7B8870B4
	Offset: 0x5250
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_33ab7991(entity)
{
	return !zombiehaslegs(entity);
}

/*
	Name: zombieshouldproceduraltraverse
	Namespace: zombiebehavior
	Checksum: 0xBB293893
	Offset: 0x5280
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function zombieshouldproceduraltraverse(entity)
{
	return isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode) && entity.traversestartnode.spawnflags & 1024 && entity.traverseendnode.spawnflags & 1024;
}

/*
	Name: zombieshouldmeleesuicide
	Namespace: zombiebehavior
	Checksum: 0xDEDA550A
	Offset: 0x52F8
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function zombieshouldmeleesuicide(entity)
{
	if(!entity ai::get_behavior_attribute("suicidal_behavior"))
	{
		return 0;
	}
	if(isdefined(entity.magic_bullet_shield) && entity.magic_bullet_shield)
	{
		return 0;
	}
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.marked_for_death))
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) > 40000)
	{
		return 0;
	}
	return 1;
}

/*
	Name: zombiemeleesuicidestart
	Namespace: zombiebehavior
	Checksum: 0x91A81CB3
	Offset: 0x53C0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function zombiemeleesuicidestart(entity)
{
	entity.blockingpain = 1;
	if(isdefined(level.zombiemeleesuicidecallback))
	{
		entity thread [[level.zombiemeleesuicidecallback]](entity);
	}
}

/*
	Name: zombiemeleesuicideupdate
	Namespace: zombiebehavior
	Checksum: 0x7A3FEE5
	Offset: 0x5408
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function zombiemeleesuicideupdate(entity)
{
}

/*
	Name: zombiemeleesuicideterminate
	Namespace: zombiebehavior
	Checksum: 0x9B0ED661
	Offset: 0x5420
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function zombiemeleesuicideterminate(entity)
{
	if(isalive(entity) && zombieshouldmeleesuicide(entity))
	{
		entity.takedamage = 1;
		entity.allowdeath = 1;
		if(isdefined(level.zombiemeleesuicidedonecallback))
		{
			entity thread [[level.zombiemeleesuicidedonecallback]](entity);
		}
	}
}

/*
	Name: function_c6787767
	Namespace: zombiebehavior
	Checksum: 0x7CB6515C
	Offset: 0x54B0
	Size: 0xEA
	Parameters: 2
	Flags: Linked
*/
function function_c6787767(entity, asmstatename)
{
	function_ec25b529(entity);
	animationstatenetworkutility::requeststate(entity, asmstatename);
	if(isdefined(entity.stumble) && !isdefined(entity.move_anim_end_time))
	{
		stumbleactionresult = entity astsearch(asmstatename);
		stumbleactionanimation = animationstatenetworkutility::searchanimationmap(entity, stumbleactionresult[#"animation"]);
		entity.move_anim_end_time = entity.movetime + getanimlength(stumbleactionanimation);
	}
	return 5;
}

/*
	Name: function_a82068d7
	Namespace: zombiebehavior
	Checksum: 0x320D372A
	Offset: 0x55A8
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function function_a82068d7(entity)
{
	function_ec25b529(entity);
	return 1;
}

/*
	Name: function_ec25b529
	Namespace: zombiebehavior
	Checksum: 0x5F9620D3
	Offset: 0x55D8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_ec25b529(entity)
{
	entity.movetime = gettime();
	entity.moveorigin = entity.origin;
}

/*
	Name: zombiemoveactionupdate
	Namespace: zombiebehavior
	Checksum: 0xC18B103F
	Offset: 0x5618
	Size: 0xC2
	Parameters: 2
	Flags: Linked
*/
function zombiemoveactionupdate(entity, asmstatename)
{
	if(isdefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time)
	{
		entity.move_anim_end_time = undefined;
		return 4;
	}
	function_26f9b8b1(entity);
	if(entity asmgetstatus() == "asm_status_complete")
	{
		if(entity iscurrentbtactionlooping())
		{
			return function_c6787767(entity, asmstatename);
		}
		return 4;
	}
	return 5;
}

/*
	Name: function_626edd6b
	Namespace: zombiebehavior
	Checksum: 0xD323C056
	Offset: 0x56E8
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function function_626edd6b(entity)
{
	function_26f9b8b1(entity);
	return 1;
}

/*
	Name: function_26f9b8b1
	Namespace: zombiebehavior
	Checksum: 0x934E1FEA
	Offset: 0x5718
	Size: 0x186
	Parameters: 1
	Flags: Linked
*/
function function_26f9b8b1(entity)
{
	if(!(isdefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000)
	{
		distsq = distance2dsquared(entity.origin, entity.moveorigin);
		if(distsq < 144)
		{
			entity setavoidancemask("avoid all");
			entity.cant_move = 1;
			/#
				record3dtext("", entity.origin, (0, 0, 1), "", entity);
			#/
			if(isdefined(entity.cant_move_cb))
			{
				entity thread [[entity.cant_move_cb]]();
			}
		}
		else
		{
			entity setavoidancemask("avoid none");
			entity.cant_move = 0;
			if(isdefined(entity.var_63d2fce2))
			{
				entity thread [[entity.var_63d2fce2]]();
			}
		}
		entity.movetime = gettime();
		entity.moveorigin = entity.origin;
	}
}

/*
	Name: zombiemoveactionterminate
	Namespace: zombiebehavior
	Checksum: 0xE23CB828
	Offset: 0x58A8
	Size: 0x58
	Parameters: 2
	Flags: None
*/
function zombiemoveactionterminate(entity, asmstatename)
{
	if(!(isdefined(entity.missinglegs) && entity.missinglegs))
	{
		entity setavoidancemask("avoid none");
	}
	return 4;
}

/*
	Name: function_79fe956f
	Namespace: zombiebehavior
	Checksum: 0xF66EB459
	Offset: 0x5908
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function function_79fe956f()
{
	self notify("2360c9f36a377896");
	self endon("2360c9f36a377896");
	self endon(#"death");
	if(!isdefined(self.var_9ed3cc11))
	{
		self.var_9ed3cc11 = self function_e827fc0e();
	}
	self pushplayer(1);
	wait(2);
	if(isdefined(self.var_9ed3cc11))
	{
		self pushplayer(self.var_9ed3cc11);
		self.var_9ed3cc11 = undefined;
	}
}

/*
	Name: function_22762653
	Namespace: zombiebehavior
	Checksum: 0x8116515F
	Offset: 0x59C0
	Size: 0x17E
	Parameters: 0
	Flags: Linked
*/
function function_22762653()
{
	self notify("333a3e1bcad60a56");
	self endon("333a3e1bcad60a56");
	self endon(#"death");
	var_159fa617 = 0;
	foreach(player in getplayers())
	{
		if(player laststand::player_is_in_laststand())
		{
			if(distancesquared(self.origin, player.origin) < 14400)
			{
				var_159fa617 = 1;
				break;
			}
		}
	}
	if(!var_159fa617)
	{
		return;
	}
	if(!isdefined(self.var_9ed3cc11))
	{
		self.var_9ed3cc11 = self function_e827fc0e();
	}
	self pushplayer(1);
	wait(2);
	if(isdefined(self.var_9ed3cc11))
	{
		self pushplayer(self.var_9ed3cc11);
		self.var_9ed3cc11 = undefined;
	}
}

/*
	Name: function_9b6830c9
	Namespace: zombiebehavior
	Checksum: 0x6D0D2112
	Offset: 0x5B48
	Size: 0x50
	Parameters: 2
	Flags: Linked
*/
function function_9b6830c9(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	entity pathmode("dont move", 1);
	return 5;
}

/*
	Name: function_fbdc2cc4
	Namespace: zombiebehavior
	Checksum: 0x1F1CD8F7
	Offset: 0x5BA0
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function function_fbdc2cc4(entity, asmstatename)
{
	entity pathmode("move allowed");
	return 4;
}

/*
	Name: archetypezombiedeathoverrideinit
	Namespace: zombiebehavior
	Checksum: 0x7BE27C59
	Offset: 0x5BE0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function archetypezombiedeathoverrideinit()
{
	aiutility::addaioverridekilledcallback(self, &zombiegibkilledanhilateoverride);
}

/*
	Name: zombiegibkilledanhilateoverride
	Namespace: zombiebehavior
	Checksum: 0x3B82873
	Offset: 0x5C10
	Size: 0x2F8
	Parameters: 8
	Flags: Linked, Private
*/
private function zombiegibkilledanhilateoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime)
{
	if(!(isdefined(level.zombieanhilationenabled) && level.zombieanhilationenabled))
	{
		return damage;
	}
	if(isdefined(self.forceanhilateondeath) && self.forceanhilateondeath)
	{
		self zombie_utility::gib_random_parts();
		gibserverutils::annihilate(self);
		return damage;
	}
	if(isdefined(attacker) && isplayer(attacker) && (isdefined(attacker.forceanhilateondeath) && attacker.forceanhilateondeath || (isdefined(level.forceanhilateondeath) && level.forceanhilateondeath)))
	{
		self zombie_utility::gib_random_parts();
		gibserverutils::annihilate(self);
		return damage;
	}
	attackerdistance = 0;
	if(isdefined(attacker))
	{
		attackerdistance = distancesquared(attacker.origin, self.origin);
	}
	isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
	if(isdefined(weapon.weapclass) && weapon.weapclass == "turret")
	{
		if(isdefined(inflictor))
		{
			isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
			iscloseexplosive = distancesquared(inflictor.origin, self.origin) <= 60 * 60;
			if(isdirectexplosive && iscloseexplosive)
			{
				self zombie_utility::gib_random_parts();
				gibserverutils::annihilate(self);
			}
		}
	}
	return damage;
}

/*
	Name: zombiezombieidlemocompstart
	Namespace: zombiebehavior
	Checksum: 0x19292679
	Offset: 0x5F10
	Size: 0x114
	Parameters: 5
	Flags: Linked, Private
*/
private function zombiezombieidlemocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]) && entity != entity.enemyoverride[1])
	{
		entity orientmode("face direction", entity.enemyoverride[1].origin - entity.origin);
		entity animmode("zonly_physics", 0);
	}
	else
	{
		entity orientmode("face current");
		entity animmode("zonly_physics", 0);
	}
}

/*
	Name: zombieattackobjectmocompstart
	Namespace: zombiebehavior
	Checksum: 0x3FC01BB9
	Offset: 0x6030
	Size: 0xD4
	Parameters: 5
	Flags: Linked, Private
*/
private function zombieattackobjectmocompstart(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.attackable_slot))
	{
		entity orientmode("face angle", entity.attackable_slot.angles[1]);
		entity animmode("zonly_physics", 0);
	}
	else
	{
		entity orientmode("face current");
		entity animmode("zonly_physics", 0);
	}
}

/*
	Name: zombieattackobjectmocompupdate
	Namespace: zombiebehavior
	Checksum: 0xC56869E
	Offset: 0x6110
	Size: 0x64
	Parameters: 5
	Flags: Linked, Private
*/
private function zombieattackobjectmocompupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.attackable_slot))
	{
		entity forceteleport(entity.attackable_slot.origin);
	}
}

/*
	Name: function_54d75299
	Namespace: zombiebehavior
	Checksum: 0x240812D0
	Offset: 0x6180
	Size: 0x1A4
	Parameters: 5
	Flags: Linked, Private
*/
private function function_54d75299(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.enemy))
	{
		entity orientmode("face enemy");
	}
	entity animmode("zonly_physics", 1);
	entity pathmode("dont move");
	localdeltahalfvector = getmovedelta(mocompanim, 0, 0.9, entity);
	endpoint = entity localtoworldcoords(localdeltahalfvector);
	/#
		recordcircle(endpoint, 3, (1, 0, 0), "");
		recordline(entity.origin, endpoint, (1, 0, 0), "");
		record3dtext("" + distance(entity.origin, endpoint) + "" + function_9e72a96(mocompanim), endpoint, (1, 0, 0), "");
	#/
}

/*
	Name: function_d1474842
	Namespace: zombiebehavior
	Checksum: 0x253C0002
	Offset: 0x6330
	Size: 0x4C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_d1474842(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity pathmode("dont move");
}

/*
	Name: function_b6d297bb
	Namespace: zombiebehavior
	Checksum: 0xAF0B1403
	Offset: 0x6388
	Size: 0x4C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_b6d297bb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity pathmode("move allowed");
}

/*
	Name: function_cbbae5cb
	Namespace: zombiebehavior
	Checksum: 0x9451831B
	Offset: 0x63E0
	Size: 0x194
	Parameters: 5
	Flags: Linked, Private
*/
private function function_cbbae5cb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("normal");
	if(isdefined(entity.traverseendnode))
	{
		/#
			print3d(entity.traversestartnode.origin, "", (1, 0, 0), 1, 1, 60);
			print3d(entity.traverseendnode.origin, "", (0, 1, 0), 1, 1, 60);
			line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
		#/
		entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
	}
}

/*
	Name: function_db26137a
	Namespace: zombiebehavior
	Checksum: 0xA76821D5
	Offset: 0x6580
	Size: 0x11C
	Parameters: 4
	Flags: Linked
*/
function function_db26137a(entity, attribute, oldvalue, value)
{
	if(value == "low")
	{
		self.low_gravity = 1;
		if(!isdefined(self.low_gravity_variant) && isdefined(level.var_d9ffddf4))
		{
			if(isdefined(self.missinglegs) && self.missinglegs)
			{
				self.low_gravity_variant = randomint(level.var_d9ffddf4[#"crawl"]);
			}
			else
			{
				self.low_gravity_variant = randomint(level.var_d9ffddf4[self.zombie_move_speed]);
			}
		}
	}
	else if(value == "normal")
	{
		self.low_gravity = 0;
	}
	entity setblackboardattribute("_low_gravity", value);
}

