// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_30a4b3e6d6d5e540;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_41fe08c37d53a635;
#using script_489b835a247c990e;
#using script_48f7c4ab73137f8;
#using script_4a3f9b8905878272;
#using script_4bf952f6ba31bb17;
#using script_4c5c4a64a59247a2;
#using script_522aeb6ae906391e;
#using script_5660bae5b402a1eb;
#using script_59f07c660e6710a5;
#using script_67336be3b739af13;
#using script_6809bf766eba194a;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
#using script_caf007e2a98afa2;
#using script_cf8f48e7ee10aa3;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace archetype_zod_companion;

/*
	Name: main
	Namespace: archetype_zod_companion
	Checksum: 0xE7F5D01A
	Offset: 0x6A0
	Size: 0xD4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	clientfield::register("allplayers", "being_robot_revived", 1, 1, "int");
	spawner::add_archetype_spawn_function(#"zod_companion", &zodcompanionbehavior::archetypezodcompanionblackboardinit);
	spawner::add_archetype_spawn_function(#"zod_companion", &zodcompanionserverutils::zodcompanionsoldierspawnsetup);
	zodcompanioninterface::registerzodcompanioninterfaceattributes();
	zodcompanionbehavior::registerbehaviorscriptfunctions();
	/#
		zm_devgui::function_c7dd7a17("");
	#/
}

#namespace zodcompanionbehavior;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: zodcompanionbehavior
	Checksum: 0x56F982B8
	Offset: 0x780
	Size: 0x664
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&zodcompaniontacticalwalkactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTacticalWalkActionStart", &zodcompaniontacticalwalkactionstart);
	/#
		assert(isscriptfunctionptr(&zodcompanionabletoshootcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionAbleToShoot", &zodcompanionabletoshootcondition);
	/#
		assert(isscriptfunctionptr(&zodcompanionshouldtacticalwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionShouldTacticalWalk", &zodcompanionshouldtacticalwalk);
	/#
		assert(isscriptfunctionptr(&zodcompanionmovement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionMovement", &zodcompanionmovement);
	/#
		assert(isscriptfunctionptr(&zodcompaniondelaymovement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionDelayMovement", &zodcompaniondelaymovement);
	/#
		assert(isscriptfunctionptr(&zodcompanionsetdesiredstancetostand));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionSetDesiredStanceToStand", &zodcompanionsetdesiredstancetostand);
	/#
		assert(isscriptfunctionptr(&zodcompanionfinishedsprinttransition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionFinishedSprintTransition", &zodcompanionfinishedsprinttransition);
	/#
		assert(isscriptfunctionptr(&zodcompanionsprinttransitioning));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionSprintTransitioning", &zodcompanionsprinttransitioning);
	/#
		assert(isscriptfunctionptr(&zodcompanionkeepscurrentmovementmode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionKeepsCurrentMovementMode", &zodcompanionkeepscurrentmovementmode);
	/#
		assert(isscriptfunctionptr(&zodcompanioncanjuke));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCanJuke", &zodcompanioncanjuke);
	/#
		assert(isscriptfunctionptr(&zodcompanioncanpreemptivejuke));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCanPreemptiveJuke", &zodcompanioncanpreemptivejuke);
	/#
		assert(isscriptfunctionptr(&zodcompanionjukeinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionJukeInitialize", &zodcompanionjukeinitialize);
	/#
		assert(isscriptfunctionptr(&zodcompanionpreemptivejuketerminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionPreemptiveJukeTerminate", &zodcompanionpreemptivejuketerminate);
	/#
		assert(isscriptfunctionptr(&zodcompaniontargetservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTargetService", &zodcompaniontargetservice);
	/#
		assert(isscriptfunctionptr(&zodcompaniontryreacquireservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionTryReacquireService", &zodcompaniontryreacquireservice);
	/#
		assert(isscriptfunctionptr(&manage_companion_movement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("manage_companion_movement", &manage_companion_movement);
	/#
		assert(isscriptfunctionptr(&zodcompanioncollisionservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("zodCompanionCollisionService", &zodcompanioncollisionservice);
}

/*
	Name: mocompignorepainfaceenemyinit
	Namespace: zodcompanionbehavior
	Checksum: 0x94B82D0C
	Offset: 0xDF0
	Size: 0x74
	Parameters: 5
	Flags: Private
*/
function private mocompignorepainfaceenemyinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 1;
	entity orientmode("face enemy");
	entity animmode("pos deltas");
}

/*
	Name: mocompignorepainfaceenemyterminate
	Namespace: zodcompanionbehavior
	Checksum: 0xD6B21F9D
	Offset: 0xE70
	Size: 0x3A
	Parameters: 5
	Flags: Private
*/
function private mocompignorepainfaceenemyterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
}

/*
	Name: archetypezodcompanionblackboardinit
	Namespace: zodcompanionbehavior
	Checksum: 0xE5729B85
	Offset: 0xEB8
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private archetypezodcompanionblackboardinit()
{
	entity = self;
	entity.pushable = 1;
	blackboard::createblackboardforentity(entity);
	ai::createinterfaceforentity(entity);
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
}

/*
	Name: zodcompaniondelaymovement
	Namespace: zodcompanionbehavior
	Checksum: 0xB72BE6CA
	Offset: 0xF38
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompaniondelaymovement(entity)
{
	entity pathmode("move delayed", 0, randomfloatrange(1, 2));
}

/*
	Name: zodcompanionmovement
	Namespace: zodcompanionbehavior
	Checksum: 0xBCCF21ED
	Offset: 0xF88
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionmovement(entity)
{
	if(entity getblackboardattribute("_stance") != "stand")
	{
		entity setblackboardattribute("_desired_stance", "stand");
	}
}

/*
	Name: zodcompanioncanjuke
	Namespace: zodcompanionbehavior
	Checksum: 0xFBEB460D
	Offset: 0xFF0
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function zodcompanioncanjuke(entity)
{
	if(!(isdefined(entity.steppedoutofcover) && entity.steppedoutofcover) && aiutility::canjuke(entity))
	{
		jukeevents = blackboard::getblackboardevents("robot_juke");
		tooclosejukedistancesqr = 57600;
		foreach(event in jukeevents)
		{
			if(event.data.entity != entity && distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr)
			{
				return false;
			}
		}
		return true;
	}
	return false;
}

/*
	Name: zodcompanioncanpreemptivejuke
	Namespace: zodcompanionbehavior
	Checksum: 0xF0495875
	Offset: 0x1138
	Size: 0x2D6
	Parameters: 1
	Flags: Linked
*/
function zodcompanioncanpreemptivejuke(entity)
{
	if(!isdefined(entity.enemy) || !isplayer(entity.enemy))
	{
		return 0;
	}
	if(entity getblackboardattribute("_stance") == "crouch")
	{
		return 0;
	}
	if(!entity.shouldpreemptivejuke)
	{
		return 0;
	}
	if(isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime())
	{
		return 0;
	}
	if(entity.enemy playerads() < entity.nextpreemptivejukeads)
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) < 360000)
	{
		angledifference = absangleclamp180(entity.angles[1] - entity.enemy.angles[1]);
		/#
			record3dtext(angledifference, entity.origin + vectorscale((0, 0, 1), 5), (0, 1, 0), "");
		#/
		if(angledifference > 135)
		{
			enemyangles = entity.enemy getgunangles();
			toenemy = entity.enemy.origin - entity.origin;
			forward = anglestoforward(enemyangles);
			dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
			/#
				record3dtext(acos(dotproduct), entity.origin + vectorscale((0, 0, 1), 10), (0, 1, 0), "");
			#/
			if(dotproduct > 0.9848)
			{
				return zodcompanioncanjuke(entity);
			}
		}
	}
	return 0;
}

/*
	Name: _isvalidplayer
	Namespace: zodcompanionbehavior
	Checksum: 0xCB0399BB
	Offset: 0x1418
	Size: 0xB0
	Parameters: 1
	Flags: Linked, Private
*/
function private _isvalidplayer(player)
{
	if(!isdefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme)
	{
		return false;
	}
	return true;
}

/*
	Name: _findclosest
	Namespace: zodcompanionbehavior
	Checksum: 0x4E5C9249
	Offset: 0x14D0
	Size: 0x124
	Parameters: 2
	Flags: Linked, Private
*/
function private _findclosest(entity, entities)
{
	closest = spawnstruct();
	if(entities.size > 0)
	{
		closest.entity = entities[0];
		closest.distancesquared = distancesquared(entity.origin, closest.entity.origin);
		for(index = 1; index < entities.size; index++)
		{
			distancesquared = distancesquared(entity.origin, entities[index].origin);
			if(distancesquared < closest.distancesquared)
			{
				closest.distancesquared = distancesquared;
				closest.entity = entities[index];
			}
		}
	}
	return closest;
}

/*
	Name: zodcompaniontargetservice
	Namespace: zodcompanionbehavior
	Checksum: 0x9808C86C
	Offset: 0x1600
	Size: 0x3C6
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompaniontargetservice(entity)
{
	if(zodcompanionabletoshootcondition(entity))
	{
		return false;
	}
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return false;
	}
	aienemies = [];
	playerenemies = [];
	ai = getaiarray();
	players = getplayers();
	positiononnavmesh = getclosestpointonnavmesh(entity.origin, 200);
	if(!isdefined(positiononnavmesh))
	{
		return;
	}
	foreach(value in ai)
	{
		if(value.team != entity.team && isactor(value) && !isdefined(entity.favoriteenemy))
		{
			enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, 200);
			if(isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0))
			{
				aienemies[aienemies.size] = value;
			}
		}
	}
	foreach(value in players)
	{
		if(_isvalidplayer(value))
		{
			enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, 200);
			if(isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0))
			{
				playerenemies[playerenemies.size] = value;
			}
		}
	}
	closestplayer = _findclosest(entity, playerenemies);
	closestai = _findclosest(entity, aienemies);
	if(!isdefined(closestplayer.entity) && !isdefined(closestai.entity))
	{
		return;
	}
	if(!isdefined(closestai.entity))
	{
		entity.favoriteenemy = closestplayer.entity;
	}
	else
	{
		if(!isdefined(closestplayer.entity))
		{
			entity.favoriteenemy = closestai.entity;
		}
		else
		{
			if(closestai.distancesquared < closestplayer.distancesquared)
			{
				entity.favoriteenemy = closestai.entity;
			}
			else
			{
				entity.favoriteenemy = closestplayer.entity;
			}
		}
	}
}

/*
	Name: zodcompaniontacticalwalkactionstart
	Namespace: zodcompanionbehavior
	Checksum: 0xA81C1F87
	Offset: 0x19D0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompaniontacticalwalkactionstart(entity)
{
	entity orientmode("face enemy");
}

/*
	Name: zodcompanionabletoshootcondition
	Namespace: zodcompanionbehavior
	Checksum: 0x2DC39ED3
	Offset: 0x1A08
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionabletoshootcondition(entity)
{
	return entity.weapon.name != level.weaponnone.name && !gibserverutils::isgibbed(entity, 16);
}

/*
	Name: zodcompanionshouldtacticalwalk
	Namespace: zodcompanionbehavior
	Checksum: 0x91799850
	Offset: 0x1A60
	Size: 0x2E
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionshouldtacticalwalk(entity)
{
	if(!entity haspath())
	{
		return false;
	}
	return true;
}

/*
	Name: zodcompanionjukeinitialize
	Namespace: zodcompanionbehavior
	Checksum: 0xA1A87BCE
	Offset: 0x1A98
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionjukeinitialize(entity)
{
	aiutility::choosejukedirection(entity);
	entity clearpath();
	jukeinfo = spawnstruct();
	jukeinfo.origin = entity.origin;
	jukeinfo.entity = entity;
	blackboard::addblackboardevent("robot_juke", jukeinfo, 2000);
}

/*
	Name: zodcompanionpreemptivejuketerminate
	Namespace: zodcompanionbehavior
	Checksum: 0x297FE407
	Offset: 0x1B40
	Size: 0x5E
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionpreemptivejuketerminate(entity)
{
	entity.nextpreemptivejuke = gettime() + randomintrange(4000, 6000);
	entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
}

/*
	Name: zodcompaniontryreacquireservice
	Namespace: zodcompanionbehavior
	Checksum: 0x6333DD31
	Offset: 0x1BA8
	Size: 0x2DA
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompaniontryreacquireservice(entity)
{
	if(!isdefined(entity.reacquire_state))
	{
		entity.reacquire_state = 0;
	}
	if(!isdefined(entity.enemy))
	{
		entity.reacquire_state = 0;
		return false;
	}
	if(entity haspath())
	{
		return false;
	}
	if(!zodcompanionabletoshootcondition(entity))
	{
		return false;
	}
	if(entity cansee(entity.enemy) && entity canshootenemy())
	{
		entity.reacquire_state = 0;
		return false;
	}
	dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
	forward = anglestoforward(entity.angles);
	if(vectordot(dirtoenemy, forward) < 0.5)
	{
		entity.reacquire_state = 0;
		return false;
	}
	switch(entity.reacquire_state)
	{
		case 0:
		case 1:
		case 2:
		{
			step_size = 32 + (entity.reacquire_state * 32);
			reacquirepos = entity reacquirestep(step_size);
			break;
		}
		case 4:
		{
			if(!entity cansee(entity.enemy) || !entity canshootenemy())
			{
				entity flagenemyunattackable();
			}
			break;
		}
		default:
		{
			if(entity.reacquire_state > 15)
			{
				entity.reacquire_state = 0;
				return false;
			}
			break;
		}
	}
	if(isvec(reacquirepos))
	{
		entity function_a57c34b7(reacquirepos);
		return true;
	}
	entity.reacquire_state++;
	return false;
}

/*
	Name: manage_companion_movement
	Namespace: zodcompanionbehavior
	Checksum: 0x5171D024
	Offset: 0x1E90
	Size: 0x774
	Parameters: 1
	Flags: Linked, Private
*/
function private manage_companion_movement(entity)
{
	self endon(#"death");
	if(isdefined(level.var_1a612d42) && level.var_1a612d42.eligible_leader)
	{
		self.leader = level.var_1a612d42;
	}
	if(!isdefined(entity.var_5f694f04))
	{
		entity.var_5f694f04 = 0;
	}
	if(entity.ai.bulletsinclip < entity.weapon.clipsize)
	{
		entity.ai.bulletsinclip = entity.weapon.clipsize;
	}
	if(entity.reviving_a_player === 1)
	{
		return;
	}
	if(entity.time_expired === 1)
	{
		return;
	}
	if(entity.var_8dc43281 === 1 || entity.teleporting === 1)
	{
		return;
	}
	if(isdefined(entity.leader) && entity.leader.teleporting === 1)
	{
		entity thread function_818f64d1(entity.leader.teleport_location);
		return;
	}
	if(entity.var_7e56b71c === 1)
	{
		return;
	}
	if(isdefined(entity.leader) && entity.leader.is_flung === 1)
	{
		entity thread function_d5390a05(entity.leader.var_a76eba5b);
	}
	foreach(player in level.players)
	{
		if(player laststand::player_is_in_laststand() && entity.reviving_a_player === 0 && player.revivetrigger.beingrevived !== 1)
		{
			time = gettime();
			if(distancesquared(entity.origin, player.origin) <= (1024 * 1024) && time >= entity.var_5f694f04)
			{
				entity.reviving_a_player = 1;
				entity zod_companion_revive_player(player);
				return;
			}
		}
	}
	if(!isdefined(entity.var_f4fb31fe))
	{
		entity.var_f4fb31fe = gettime();
	}
	if(gettime() >= entity.var_f4fb31fe && isdefined(level.active_powerups) && level.active_powerups.size > 0)
	{
		if(!isdefined(entity.var_345d40))
		{
			entity.var_345d40 = 0;
		}
		foreach(powerup in level.active_powerups)
		{
			if(isdefined(powerup))
			{
				if(isinarray(entity.var_2f03f56a, powerup.powerup_name))
				{
					dist = distancesquared(entity.origin, powerup.origin);
					if(dist <= 147456 && randomint(100) < (50 + (10 * entity.var_345d40)))
					{
						entity setgoal(powerup.origin, 1);
						entity.var_f4fb31fe = gettime() + randomintrange(2500, 3500);
						entity.next_move_time = gettime() + randomintrange(2500, 3500);
						entity.var_345d40 = 0;
						return;
					}
					entity.var_345d40 = entity.var_345d40 + 1;
				}
			}
		}
		entity.var_f4fb31fe = gettime() + randomintrange(333, 666);
	}
	follow_radius_squared = 256 * 256;
	if(isdefined(entity.leader))
	{
		entity.companion_anchor_point = entity.leader.origin;
	}
	if(isdefined(entity.pathgoalpos))
	{
		dist_check_start_point = entity.pathgoalpos;
	}
	else
	{
		dist_check_start_point = entity.origin;
	}
	if(isdefined(entity.enemy) && isdefined(entity.enemy.archetype) && entity.enemy.archetype == "parasite")
	{
		height_difference = abs(entity.origin[2] - entity.enemy.origin[2]);
		var_3b91e18 = (1.5 * height_difference) * (1.5 * height_difference);
		if(distancesquared(dist_check_start_point, entity.enemy.origin) < var_3b91e18)
		{
			entity pick_new_movement_point();
		}
	}
	if(distancesquared(dist_check_start_point, entity.companion_anchor_point) > follow_radius_squared || distancesquared(dist_check_start_point, entity.companion_anchor_point) < 4096)
	{
		entity pick_new_movement_point();
	}
	if(gettime() >= entity.next_move_time)
	{
		entity pick_new_movement_point();
	}
}

/*
	Name: zodcompanioncollisionservice
	Namespace: zodcompanionbehavior
	Checksum: 0x6CEBA6F6
	Offset: 0x2610
	Size: 0x1AE
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanioncollisionservice(entity)
{
	if(isdefined(entity.dontpushtime))
	{
		if(gettime() < entity.dontpushtime)
		{
			return true;
		}
	}
	var_26cddecd = 0;
	zombies = getaiteamarray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(zombie == entity)
		{
			continue;
		}
		dist_sq = distancesquared(entity.origin, zombie.origin);
		if(dist_sq < 14400)
		{
			if(isdefined(zombie.cant_move) && zombie.cant_move)
			{
				zombie thread function_d0371e1e();
				var_26cddecd = 1;
			}
		}
	}
	if(var_26cddecd)
	{
		entity collidewithactors(0);
		entity.dontpushtime = gettime() + 2000;
		return true;
	}
	entity collidewithactors(1);
	return false;
}

/*
	Name: function_d0371e1e
	Namespace: zodcompanionbehavior
	Checksum: 0xFE4FA8CE
	Offset: 0x27C8
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d0371e1e()
{
	self endon(#"death");
	self collidewithactors(0);
	wait(2);
	self collidewithactors(1);
}

/*
	Name: function_a2ba1ce8
	Namespace: zodcompanionbehavior
	Checksum: 0x50BF03AB
	Offset: 0x2820
	Size: 0x120
	Parameters: 2
	Flags: Private
*/
function private function_a2ba1ce8(target_entity, max_distance)
{
	entity = self;
	var_85e6dc61 = target_entity.origin;
	if(distancesquared(entity.origin, var_85e6dc61) > max_distance * max_distance)
	{
		return false;
	}
	path = entity calcapproximatepathtoposition(var_85e6dc61);
	segmentlength = 0;
	for(index = 1; index < path.size; index++)
	{
		currentseglength = distance(path[index - 1], path[index]);
		if(currentseglength + segmentlength > max_distance)
		{
			return false;
		}
		segmentlength = segmentlength + currentseglength;
	}
	return true;
}

/*
	Name: function_818f64d1
	Namespace: zodcompanionbehavior
	Checksum: 0x7874D8C3
	Offset: 0x2948
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
function private function_818f64d1(var_d2a1361a)
{
	self endon(#"death");
	self.var_8dc43281 = 1;
	self setgoal(var_d2a1361a, 1);
	self waittill(#"goal");
	wait(1);
	self.var_8dc43281 = 0;
}

/*
	Name: function_d5390a05
	Namespace: zodcompanionbehavior
	Checksum: 0xBA0604D2
	Offset: 0x29C8
	Size: 0xC2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d5390a05(var_33d955f9)
{
	self endon(#"death");
	self.var_7e56b71c = 1;
	var_cf5caf08 = getnodearray("flinger_traversal", "script_noteworthy");
	var_b2546f7 = arraygetclosest(var_33d955f9, var_cf5caf08);
	self setgoal(var_b2546f7.origin, 1);
	self waittill(#"goal");
	wait(1);
	self.var_7e56b71c = 0;
}

/*
	Name: pick_new_movement_point
	Namespace: zodcompanionbehavior
	Checksum: 0xBF815030
	Offset: 0x2A98
	Size: 0x1D6
	Parameters: 0
	Flags: Linked, Private
*/
function private pick_new_movement_point()
{
	queryresult = positionquery_source_navigation(self.companion_anchor_point, 96, 256, 256, 20, self);
	if(queryresult.data.size)
	{
		if(isdefined(self.enemy) && isdefined(self.enemy.archetype) && self.enemy.archetype == "parasite")
		{
			array::filter(queryresult.data, 0, &function_bc4cbfe, self.enemy);
		}
	}
	if(queryresult.data.size)
	{
		point = queryresult.data[randomint(queryresult.data.size)];
		pathsuccess = self findpath(self.origin, point.origin, 1, 0);
		if(pathsuccess)
		{
			self.companion_destination = point.origin;
		}
		else
		{
			self.next_move_time = gettime() + randomintrange(500, 1500);
			return;
		}
	}
	self setgoal(self.companion_destination, 1);
	self.next_move_time = gettime() + randomintrange(20000, 30000);
}

/*
	Name: function_bc4cbfe
	Namespace: zodcompanionbehavior
	Checksum: 0x7660D0C3
	Offset: 0x2C78
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bc4cbfe(parasite)
{
	point = self;
	height_difference = abs(point.origin[2] - parasite.origin[2]);
	var_3b91e18 = (1.5 * height_difference) * (1.5 * height_difference);
	return distancesquared(point.origin, parasite.origin) > var_3b91e18;
}

/*
	Name: zodcompanionsetdesiredstancetostand
	Namespace: zodcompanionbehavior
	Checksum: 0x2397FC60
	Offset: 0x2D28
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionsetdesiredstancetostand(behaviortreeentity)
{
	currentstance = behaviortreeentity getblackboardattribute("_stance");
	if(currentstance == "crouch")
	{
		behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	}
}

/*
	Name: zod_companion_revive_player
	Namespace: zodcompanionbehavior
	Checksum: 0x5B47F018
	Offset: 0x2DA0
	Size: 0x4F4
	Parameters: 1
	Flags: Linked
*/
function zod_companion_revive_player(player)
{
	self endon(#"death", #"revive_terminated", #"end_game");
	if(!(isdefined(self.reviving_a_player) && self.reviving_a_player))
	{
		self.reviving_a_player = 1;
	}
	player.being_revived_by_robot = 0;
	self thread zod_companion_monitor_revive_attempt(player);
	self val::set(#"zod_companion", "ignoreall", 1);
	queryresult = positionquery_source_navigation(player.origin, 64, 96, 48, 18, self);
	if(queryresult.data.size)
	{
		point = queryresult.data[randomint(queryresult.data.size)];
		self.companion_destination = point.origin;
	}
	self setgoal(self.companion_destination, 1);
	self waittill(#"goal");
	level.var_ee623e8 = 1;
	player.revivetrigger.beingrevived = 1;
	player.being_revived_by_robot = 1;
	vector = vectornormalize(player.origin - self.origin);
	angles = vectortoangles(vector);
	self teleport(self.origin, angles);
	if(isdefined(self.var_69bfb00a))
	{
		self [[self.var_69bfb00a]](angles);
	}
	else
	{
		self thread animation::play("ai_robot_base_stn_exposed_revive", self, angles, 1.5);
	}
	wait(0.67);
	player clientfield::set("being_robot_revived", 1);
	player thread laststand::revive_hud_show_n_fade(#"hash_3346a327a4a83f8", 3, undefined);
	self waittill(#"robot_revive_complete");
	if(level.players.size == 1 && level flag::get("solo_game"))
	{
		self.var_5f694f04 = gettime() + 10000;
	}
	else
	{
		self.var_5f694f04 = gettime() + 5000;
	}
	if(isdefined(level.a_revive_success_perk_func))
	{
		foreach(func in level.a_revive_success_perk_func)
		{
			self [[func]]();
		}
	}
	level.var_ff482f76 zm_laststand_client::close(player);
	level.var_1c957023 self_revive_visuals::close(player);
	player thread zm_laststand::revive_success(self, 0);
	player notify(#"stop_revive_trigger");
	level.var_ee623e8 = 0;
	players = getplayers();
	if(players.size == 1 && level flag::get("solo_game") && (isdefined(player.waiting_to_revive) && player.waiting_to_revive))
	{
		level.solo_game_free_player_quickrevive = 1;
		player thread zm_perks::function_a7ae070c(#"specialty_quickrevive");
	}
	self zod_companion_revive_cleanup(player);
}

/*
	Name: zod_companion_monitor_revive_attempt
	Namespace: zodcompanionbehavior
	Checksum: 0x1AA125FB
	Offset: 0x32A0
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function zod_companion_monitor_revive_attempt(player)
{
	self endon(#"death", #"revive_terminated");
	while(true)
	{
		if(!isdefined(player))
		{
			self zod_companion_revive_cleanup(player);
		}
		if(isdefined(player.revivetrigger) && player.revivetrigger.beingrevived === 1 && player.being_revived_by_robot !== 1)
		{
			self zod_companion_revive_cleanup(player);
		}
		if(!(isdefined(player laststand::player_is_in_laststand()) && player laststand::player_is_in_laststand()))
		{
			self zod_companion_revive_cleanup(player);
		}
		waitframe(1);
	}
}

/*
	Name: zod_companion_revive_cleanup
	Namespace: zodcompanionbehavior
	Checksum: 0x96CD6226
	Offset: 0x33B0
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function zod_companion_revive_cleanup(player)
{
	self val::reset(#"zod_companion", "ignoreall");
	self.reviving_a_player = 0;
	if(isdefined(player))
	{
		if(player.being_revived_by_robot == 1)
		{
			player.being_revived_by_robot = 0;
		}
		player clientfield::set("being_robot_revived", 0);
	}
	self notify(#"revive_terminated");
}

/*
	Name: zodcompanionfinishedsprinttransition
	Namespace: zodcompanionbehavior
	Checksum: 0x9E6FA6FF
	Offset: 0x3458
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionfinishedsprinttransition(behaviortreeentity)
{
	behaviortreeentity.sprint_transition_happening = 0;
	if(behaviortreeentity getblackboardattribute("_locomotion_speed") == "locomotion_speed_walk")
	{
		behaviortreeentity ai::set_behavior_attribute("sprint", 1);
		behaviortreeentity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
	}
	else
	{
		behaviortreeentity ai::set_behavior_attribute("sprint", 0);
		behaviortreeentity setblackboardattribute("_locomotion_speed", "locomotion_speed_walk");
	}
}

/*
	Name: zodcompanionkeepscurrentmovementmode
	Namespace: zodcompanionbehavior
	Checksum: 0x9671A3AE
	Offset: 0x3538
	Size: 0xEA
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionkeepscurrentmovementmode(behaviortreeentity)
{
	var_202e5b5c = 262144;
	var_c351bd17 = 147456;
	dist = distancesquared(behaviortreeentity.origin, behaviortreeentity.companion_anchor_point);
	if(dist > var_202e5b5c && behaviortreeentity getblackboardattribute("_locomotion_speed") == "locomotion_speed_walk")
	{
		return false;
	}
	if(dist < var_c351bd17 && behaviortreeentity getblackboardattribute("_locomotion_speed") == "locomotion_speed_sprint")
	{
		return false;
	}
	return true;
}

/*
	Name: zodcompanionsprinttransitioning
	Namespace: zodcompanionbehavior
	Checksum: 0x552791
	Offset: 0x3630
	Size: 0x28
	Parameters: 1
	Flags: Linked, Private
*/
function private zodcompanionsprinttransitioning(behaviortreeentity)
{
	if(behaviortreeentity.sprint_transition_happening === 1)
	{
		return true;
	}
	return false;
}

#namespace zodcompanionserverutils;

/*
	Name: _trygibbinghead
	Namespace: zodcompanionserverutils
	Checksum: 0xB08679D8
	Offset: 0x3660
	Size: 0x134
	Parameters: 4
	Flags: Linked, Private
*/
function private _trygibbinghead(entity, damage, hitloc, isexplosive)
{
	if(isexplosive && randomfloatrange(0, 1) <= 0.5)
	{
		gibserverutils::gibhead(entity);
	}
	else
	{
		if(isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1)
		{
			gibserverutils::gibhead(entity);
		}
		else if((entity.health - damage) <= 0 && randomfloatrange(0, 1) <= 0.25)
		{
			gibserverutils::gibhead(entity);
		}
	}
}

/*
	Name: _trygibbinglimb
	Namespace: zodcompanionserverutils
	Checksum: 0x513735B1
	Offset: 0x37A0
	Size: 0x26C
	Parameters: 4
	Flags: Linked, Private
*/
function private _trygibbinglimb(entity, damage, hitloc, isexplosive)
{
	if(gibserverutils::isgibbed(entity, 32) || gibserverutils::isgibbed(entity, 16))
	{
		return;
	}
	if(isexplosive && randomfloatrange(0, 1) <= 0.25)
	{
		if((entity.health - damage) <= 0 && entity.allowdeath && math::cointoss())
		{
			gibserverutils::gibrightarm(entity);
		}
		else
		{
			gibserverutils::gibleftarm(entity);
		}
	}
	else
	{
		if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc))
		{
			gibserverutils::gibleftarm(entity);
		}
		else
		{
			if((entity.health - damage) <= 0 && entity.allowdeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc))
			{
				gibserverutils::gibrightarm(entity);
			}
			else if((entity.health - damage) <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25)
			{
				if(math::cointoss())
				{
					gibserverutils::gibleftarm(entity);
				}
				else
				{
					gibserverutils::gibrightarm(entity);
				}
			}
		}
	}
}

/*
	Name: _trygibbinglegs
	Namespace: zodcompanionserverutils
	Checksum: 0xFE9B2502
	Offset: 0x3A18
	Size: 0x364
	Parameters: 5
	Flags: Linked, Private
*/
function private _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker = entity)
{
	cangiblegs = (entity.health - damage) <= 0 && entity.allowdeath;
	cangiblegs = cangiblegs || (((entity.health - damage) / entity.maxhealth) <= 0.25 && distancesquared(entity.origin, attacker.origin) <= 360000 && entity.allowdeath);
	if((entity.health - damage) <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5)
	{
		gibserverutils::giblegs(entity);
		entity startragdoll();
	}
	else
	{
		if(cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1)
		{
			if(entity.health - damage > 0)
			{
				entity.becomecrawler = 1;
			}
			gibserverutils::gibleftleg(entity);
		}
		else
		{
			if(cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1)
			{
				if(entity.health - damage > 0)
				{
					entity.becomecrawler = 1;
				}
				gibserverutils::gibrightleg(entity);
			}
			else if((entity.health - damage) <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25)
			{
				if(math::cointoss())
				{
					gibserverutils::gibleftleg(entity);
				}
				else
				{
					gibserverutils::gibrightleg(entity);
				}
			}
		}
	}
}

/*
	Name: zodcompaniongibdamageoverride
	Namespace: zodcompanionserverutils
	Checksum: 0x4D7211BE
	Offset: 0x3D88
	Size: 0x180
	Parameters: 12
	Flags: Linked, Private
*/
function private zodcompaniongibdamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity = self;
	if((entity.health - damage) / entity.maxhealth > 0.75)
	{
		return damage;
	}
	gibserverutils::togglespawngibs(entity, 1);
	isexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTIVLE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
	_trygibbinghead(entity, damage, hitloc, isexplosive);
	_trygibbinglimb(entity, damage, hitloc, isexplosive);
	_trygibbinglegs(entity, damage, hitloc, isexplosive, attacker);
	return damage;
}

/*
	Name: zodcompaniondestructdeathoverride
	Namespace: zodcompanionserverutils
	Checksum: 0xF134845A
	Offset: 0x3F10
	Size: 0x218
	Parameters: 12
	Flags: Private
*/
function private zodcompaniondestructdeathoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity = self;
	if((entity.health - damage) <= 0)
	{
		destructserverutils::togglespawngibs(entity, 1);
		piececount = destructserverutils::getpiececount(entity);
		possiblepieces = [];
		for(index = 1; index <= piececount; index++)
		{
			if(!destructserverutils::isdestructed(entity, index) && randomfloatrange(0, 1) <= 0.2)
			{
				possiblepieces[possiblepieces.size] = index;
			}
		}
		gibbedpieces = 0;
		for(index = 0; index < possiblepieces.size && possiblepieces.size > 1 && gibbedpieces < 2; index++)
		{
			randompiece = randomintrange(0, possiblepieces.size - 1);
			if(!destructserverutils::isdestructed(entity, possiblepieces[randompiece]))
			{
				destructserverutils::destructpiece(entity, possiblepieces[randompiece]);
				gibbedpieces++;
			}
		}
	}
	return damage;
}

/*
	Name: zodcompaniondamageoverride
	Namespace: zodcompanionserverutils
	Checksum: 0xA5698F08
	Offset: 0x4130
	Size: 0xD2
	Parameters: 12
	Flags: Linked, Private
*/
function private zodcompaniondamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity = self;
	if(hitloc == "helmet" || hitloc == "head" || hitloc == "neck")
	{
		damage = int(damage * 0.5);
	}
	return damage;
}

/*
	Name: findclosestnavmeshpositiontoenemy
	Namespace: zodcompanionserverutils
	Checksum: 0xEBD44101
	Offset: 0x4210
	Size: 0x78
	Parameters: 1
	Flags: Private
*/
function private findclosestnavmeshpositiontoenemy(enemy)
{
	enemypositiononnavmesh = undefined;
	for(tolerancelevel = 1; tolerancelevel <= 4; tolerancelevel++)
	{
		enemypositiononnavmesh = getclosestpointonnavmesh(enemy.origin, 200 * tolerancelevel);
		if(isdefined(enemypositiononnavmesh))
		{
			break;
		}
	}
	return enemypositiononnavmesh;
}

/*
	Name: zodcompanionsoldierspawnsetup
	Namespace: zodcompanionserverutils
	Checksum: 0x30CE70E8
	Offset: 0x4290
	Size: 0x234
	Parameters: 0
	Flags: Linked, Private
*/
function private zodcompanionsoldierspawnsetup()
{
	entity = self;
	entity.combatmode = "cover";
	entity.fullhealth = entity.health;
	entity.controllevel = 0;
	entity.steppedoutofcover = 0;
	entity.startingweapon = entity.weapon;
	entity.jukedistance = 90;
	entity.jukemaxdistance = 600;
	entity.entityradius = 15;
	entity.base_accuracy = entity.accuracy;
	entity.highlyawareradius = 256;
	entity.treatallcoversasgeneric = 1;
	entity.onlycroucharrivals = 1;
	entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
	entity.shouldpreemptivejuke = math::cointoss();
	entity.reviving_a_player = 0;
	aiutility::addaioverridedamagecallback(entity, &destructserverutils::handledamage);
	aiutility::addaioverridedamagecallback(entity, &zodcompaniondamageoverride);
	aiutility::addaioverridedamagecallback(entity, &zodcompaniongibdamageoverride);
	entity.companion_anchor_point = entity.origin;
	entity.next_move_time = gettime();
	entity.allow_zombie_to_target_ai = 1;
	entity val::set(#"zod_companion", "ignoreme", 1);
	entity thread zodcompanionutility::function_dbd6fcc6();
	entity thread zodcompanionutility::manage_companion();
}

#namespace zodcompanionutility;

/*
	Name: manage_companion
	Namespace: zodcompanionutility
	Checksum: 0x508EE58F
	Offset: 0x44D0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function manage_companion()
{
	self endon(#"death");
	while(true)
	{
		if(!self.reviving_a_player)
		{
			if(!isdefined(self.leader) || !self.leader.eligible_leader)
			{
				self define_new_leader();
			}
		}
		wait(0.5);
	}
}

/*
	Name: function_dbd6fcc6
	Namespace: zodcompanionutility
	Checksum: 0x76773905
	Offset: 0x4548
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_dbd6fcc6()
{
	self.var_2f03f56a = [];
	self.var_2f03f56a[0] = "double_points";
	self.var_2f03f56a[1] = "fire_sale";
	self.var_2f03f56a[2] = "insta_kill";
	self.var_2f03f56a[3] = "nuke";
	self.var_2f03f56a[4] = "full_ammo";
	self.var_2f03f56a[5] = "insta_kill_ug";
}

/*
	Name: define_new_leader
	Namespace: zodcompanionutility
	Checksum: 0x9586C574
	Offset: 0x45F0
	Size: 0x346
	Parameters: 0
	Flags: Linked
*/
function define_new_leader()
{
	if(isdefined(level.var_1a612d42) && level.var_1a612d42.eligible_leader)
	{
		self.leader = level.var_1a612d42;
	}
	else
	{
		a_potential_leaders = get_potential_leaders(self);
		closest_leader = undefined;
		closest_distance = 1000000;
		if(a_potential_leaders.size == 0)
		{
			self.leader = undefined;
		}
		else
		{
			if(getdvarint(#"hash_6d35b5921943876a", 1))
			{
				playerpositions = [];
				foreach(potential_leader in a_potential_leaders)
				{
					if(!isdefined(playerpositions))
					{
						playerpositions = [];
					}
					else if(!isarray(playerpositions))
					{
						playerpositions = array(playerpositions);
					}
					playerpositions[playerpositions.size] = potential_leader.origin;
				}
				var_f67d1ba2 = generatenavmeshpath(self.origin, playerpositions, self);
				if(isdefined(var_f67d1ba2) && var_f67d1ba2.status === "succeeded")
				{
					goalpos = var_f67d1ba2.pathpoints[var_f67d1ba2.pathpoints.size - 1];
					foreach(potential_leader in a_potential_leaders)
					{
						if(distancesquared(potential_leader.origin, goalpos) < 16 * 16)
						{
							self.leader = potential_leader;
							break;
						}
					}
				}
			}
			else
			{
				foreach(potential_leader in a_potential_leaders)
				{
					dist = pathdistance(self.origin, potential_leader.origin);
					if(isdefined(dist) && dist < closest_distance)
					{
						closest_distance = dist;
						self.leader = potential_leader;
					}
				}
			}
		}
	}
}

/*
	Name: get_potential_leaders
	Namespace: zodcompanionutility
	Checksum: 0xFA613527
	Offset: 0x4940
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function get_potential_leaders(companion)
{
	a_potential_leaders = [];
	foreach(player in level.players)
	{
		if(!isdefined(player.eligible_leader))
		{
			player.eligible_leader = 1;
		}
		if(isdefined(player.eligible_leader) && player.eligible_leader && companion findpath(companion.origin, player.origin))
		{
			a_potential_leaders[a_potential_leaders.size] = player;
		}
	}
	return a_potential_leaders;
}

