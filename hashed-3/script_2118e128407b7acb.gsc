// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1fae425933eac79f;
#using script_317aa6153a75c589;
#using script_3aa0f32b70d4f7cb;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_caf007e2a98afa2;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_5eb9b9b6;

/*
	Name: function_89f2df9
	Namespace: namespace_5eb9b9b6
	Checksum: 0xD62B0529
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1bc870c3bcb2ff32", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5eb9b9b6
	Checksum: 0x7382C7B3
	Offset: 0x218
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"zombie_dog", &function_b9d56970);
}

/*
	Name: function_b9d56970
	Namespace: namespace_5eb9b9b6
	Checksum: 0x9EF0372B
	Offset: 0x268
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_b9d56970()
{
	self.var_93a62fe = zm_utility::get_closest_valid_player(self.origin, undefined, 1);
	self.closest_player_override = &zm_utility::function_c52e1749;
	self.var_ef1ed308 = &function_ea61b64a;
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_5eb9b9b6
	Checksum: 0xE15EB97D
	Offset: 0x2D0
	Size: 0x36C
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	spawner::add_archetype_spawn_function(#"zombie_dog", &archetypezombiedogblackboardinit);
	/#
		assert(isscriptfunctionptr(&zombiedogtargetservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogtargetservice", &zombiedogtargetservice, 1);
	/#
		assert(isscriptfunctionptr(&function_5e50d260));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29b43f0d0b6bd4e2", &function_5e50d260, 2);
	/#
		assert(isscriptfunctionptr(&zombiedogshouldmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldmelee", &zombiedogshouldmelee);
	/#
		assert(isscriptfunctionptr(&zombiedogshouldwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldwalk", &zombiedogshouldwalk);
	/#
		assert(isscriptfunctionptr(&zombiedogshouldrun));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombiedogshouldrun", &zombiedogshouldrun);
	/#
		assert(!isdefined(&zombiedogmeleeaction) || isscriptfunctionptr(&zombiedogmeleeaction));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&zombiedogmeleeactionterminate) || isscriptfunctionptr(&zombiedogmeleeactionterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction("zombieDogMeleeAction", &zombiedogmeleeaction, undefined, &zombiedogmeleeactionterminate);
	namespace_8179cac5::registerzombiedoginterfaceattributes();
}

/*
	Name: archetypezombiedogblackboardinit
	Namespace: namespace_5eb9b9b6
	Checksum: 0x806D8C78
	Offset: 0x648
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function archetypezombiedogblackboardinit()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &archetypezombiedogonanimscriptedcallback;
	self.kill_on_wine_coccon = 1;
}

/*
	Name: archetypezombiedogonanimscriptedcallback
	Namespace: namespace_5eb9b9b6
	Checksum: 0xF1B87445
	Offset: 0x6A8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function archetypezombiedogonanimscriptedcallback(entity)
{
	entity.__blackboard = undefined;
	entity archetypezombiedogblackboardinit();
}

/*
	Name: bb_getshouldrunstatus
	Namespace: namespace_5eb9b9b6
	Checksum: 0xDAF15EA2
	Offset: 0x6E0
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function bb_getshouldrunstatus()
{
	if(isdefined(self.var_1dddf9ab))
	{
		return self [[self.var_1dddf9ab]]();
	}
	/#
		if(isdefined(self.ispuppet) && self.ispuppet)
		{
			return "";
		}
	#/
	if(isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy || (ai::hasaiattribute(self, "sprint") && ai::getaiattribute(self, "sprint")))
	{
		return "run";
	}
	return "walk";
}

/*
	Name: bb_getshouldhowlstatus
	Namespace: namespace_5eb9b9b6
	Checksum: 0xC0022994
	Offset: 0x7A0
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function bb_getshouldhowlstatus()
{
	if(self ai::has_behavior_attribute("howl_chance") && (isdefined(self.hasseenfavoriteenemy) && self.hasseenfavoriteenemy))
	{
		if(!isdefined(self.shouldhowl))
		{
			chance = self ai::get_behavior_attribute("howl_chance");
			self.shouldhowl = randomfloat(1) <= chance;
		}
		return (self.shouldhowl ? "howl" : "dont_howl");
	}
	return "dont_howl";
}

/*
	Name: getyaw
	Namespace: namespace_5eb9b9b6
	Checksum: 0xECFC8509
	Offset: 0x870
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function getyaw(org)
{
	angles = vectortoangles(org - self.origin);
	return angles[1];
}

/*
	Name: absyawtoenemy
	Namespace: namespace_5eb9b9b6
	Checksum: 0x277EA56D
	Offset: 0x8B8
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function absyawtoenemy()
{
	/#
		assert(isdefined(self.enemy));
	#/
	yaw = self.angles[1] - getyaw(self.enemy.origin);
	yaw = angleclamp180(yaw);
	if(yaw < 0)
	{
		yaw = -1 * yaw;
	}
	return yaw;
}

/*
	Name: need_to_run
	Namespace: namespace_5eb9b9b6
	Checksum: 0x90E0064A
	Offset: 0x958
	Size: 0x22A
	Parameters: 0
	Flags: Linked
*/
function need_to_run()
{
	run_dist_squared = self ai::get_behavior_attribute("min_run_dist") * self ai::get_behavior_attribute("min_run_dist");
	run_yaw = 20;
	run_pitch = 30;
	run_height = 64;
	if(level.dog_round_count > 1)
	{
		return 1;
	}
	if(self.health < self.maxhealth)
	{
		return 1;
	}
	if(!isdefined(self.enemy) || !isalive(self.enemy))
	{
		return 0;
	}
	if(!self cansee(self.enemy))
	{
		return 0;
	}
	dist = distancesquared(self.origin, self.enemy.origin);
	if(dist > run_dist_squared)
	{
		return 0;
	}
	height = self.origin[2] - self.enemy.origin[2];
	if(abs(height) > run_height)
	{
		return 0;
	}
	yaw = self absyawtoenemy();
	if(yaw > run_yaw)
	{
		return 0;
	}
	pitch = angleclamp180(vectortoangles(self.origin - self.enemy.origin)[0]);
	if(abs(pitch) > run_pitch)
	{
		return 0;
	}
	return 1;
}

/*
	Name: is_target_valid
	Namespace: namespace_5eb9b9b6
	Checksum: 0xA2247111
	Offset: 0xB90
	Size: 0x224
	Parameters: 2
	Flags: Linked
*/
function is_target_valid(dog, target)
{
	if(!isdefined(target))
	{
		return 0;
	}
	if(!isalive(target))
	{
		return 0;
	}
	if(!dog.team == #"allies")
	{
		if(!isplayer(target) && sessionmodeiszombiesgame())
		{
			return 0;
		}
		if(isdefined(target.is_zombie) && target.is_zombie == 1)
		{
			return 0;
		}
	}
	if(isplayer(target) && target.sessionstate == "spectator")
	{
		return 0;
	}
	if(isplayer(target) && target.sessionstate == "intermission")
	{
		return 0;
	}
	if(isdefined(self.intermission) && self.intermission)
	{
		return 0;
	}
	if(isdefined(target.ignoreme) && target.ignoreme)
	{
		return 0;
	}
	if(target isnotarget())
	{
		return 0;
	}
	if(dog.team == target.team)
	{
		return 0;
	}
	if(isplayer(target) && isdefined(level.var_6f6cc58))
	{
		if(!dog [[level.var_6f6cc58]](target))
		{
			return 0;
		}
	}
	if(isplayer(target) && isdefined(level.is_player_valid_override))
	{
		return [[level.is_player_valid_override]](target);
	}
	return 1;
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_5eb9b9b6
	Checksum: 0xE7708B1
	Offset: 0xDC0
	Size: 0x256
	Parameters: 1
	Flags: Linked, Private
*/
private function get_favorite_enemy(dog)
{
	dog_targets = [];
	if(sessionmodeiszombiesgame())
	{
		if(self.team == #"allies")
		{
			dog_targets = getaiteamarray(level.zombie_team);
		}
		else
		{
			dog_targets = getplayers();
		}
	}
	else
	{
		dog_targets = arraycombine(getplayers(), getaiarray(), 0, 0);
	}
	least_hunted = dog_targets[0];
	closest_target_dist_squared = undefined;
	for(i = 0; i < dog_targets.size; i++)
	{
		if(!isdefined(dog_targets[i].hunted_by))
		{
			dog_targets[i].hunted_by = 0;
		}
		if(!is_target_valid(dog, dog_targets[i]))
		{
			continue;
		}
		if(!is_target_valid(dog, least_hunted))
		{
			least_hunted = dog_targets[i];
		}
		dist_squared = distancesquared(dog.origin, dog_targets[i].origin);
		if(dog_targets[i].hunted_by <= least_hunted.hunted_by && (!isdefined(closest_target_dist_squared) || dist_squared < closest_target_dist_squared))
		{
			least_hunted = dog_targets[i];
			closest_target_dist_squared = dist_squared;
		}
	}
	if(!is_target_valid(dog, least_hunted))
	{
		return undefined;
	}
	least_hunted.hunted_by = least_hunted.hunted_by + 1;
	return least_hunted;
}

/*
	Name: get_last_valid_position
	Namespace: namespace_5eb9b9b6
	Checksum: 0xAC75B24E
	Offset: 0x1020
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function get_last_valid_position()
{
	if(isplayer(self))
	{
		return self.last_valid_position;
	}
	return self.origin;
}

/*
	Name: get_locomotion_target
	Namespace: namespace_5eb9b9b6
	Checksum: 0x92101D93
	Offset: 0x1058
	Size: 0x252
	Parameters: 1
	Flags: Linked
*/
function get_locomotion_target(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.favoriteenemy))
	{
		return undefined;
	}
	last_valid_position = behaviortreeentity.favoriteenemy get_last_valid_position();
	if(!isdefined(last_valid_position))
	{
		return undefined;
	}
	locomotion_target = last_valid_position;
	if(ai::has_behavior_attribute("spacing_value"))
	{
		spacing_near_dist = ai::get_behavior_attribute("spacing_near_dist");
		spacing_far_dist = ai::get_behavior_attribute("spacing_far_dist");
		spacing_horz_dist = ai::get_behavior_attribute("spacing_horz_dist");
		spacing_value = ai::get_behavior_attribute("spacing_value");
		to_enemy = behaviortreeentity.favoriteenemy.origin - behaviortreeentity.origin;
		perp = vectornormalize((to_enemy[1] * -1, to_enemy[0], 0));
		offset = (perp * spacing_horz_dist) * spacing_value;
		spacing_dist = math::clamp(length(to_enemy), spacing_near_dist, spacing_far_dist);
		lerp_amount = math::clamp((spacing_dist - spacing_near_dist) / (spacing_far_dist - spacing_near_dist), 0, 1);
		desired_point = last_valid_position + (offset * lerp_amount);
		desired_point = getclosestpointonnavmesh(desired_point, spacing_horz_dist * 1.2, 16);
		if(isdefined(desired_point))
		{
			locomotion_target = desired_point;
		}
	}
	return locomotion_target;
}

/*
	Name: zombiedogtargetservice
	Namespace: namespace_5eb9b9b6
	Checksum: 0xB83B961F
	Offset: 0x12B8
	Size: 0x3BA
	Parameters: 1
	Flags: Linked
*/
function zombiedogtargetservice(behaviortreeentity)
{
	if(isdefined(level.intermission) && level.intermission)
	{
		behaviortreeentity clearpath();
		return;
	}
	/#
		if(isdefined(behaviortreeentity.ispuppet) && behaviortreeentity.ispuppet)
		{
			return;
		}
	#/
	if(behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol"))
	{
		return;
	}
	if(!is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))
	{
		if(isdefined(behaviortreeentity.favoriteenemy))
		{
			function_ea61b64a(behaviortreeentity);
			behaviortreeentity.hasseenfavoriteenemy = 0;
		}
		behaviortreeentity.favoriteenemy = get_favorite_enemy(behaviortreeentity);
	}
	if(behaviortreeentity.ignoreall || behaviortreeentity.pacifist || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))
	{
		if(is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))
		{
			if(isdefined(level.var_d22435d9))
			{
				[[level.var_d22435d9]](behaviortreeentity);
			}
		}
		else if(isdefined(behaviortreeentity function_4794d6a3().overridegoalpos))
		{
			behaviortreeentity function_d4c687c9();
		}
		if(isdefined(level.no_target_override))
		{
			[[level.no_target_override]](behaviortreeentity);
		}
		else
		{
			behaviortreeentity setgoal(behaviortreeentity.origin);
		}
		return;
	}
	if(!(isdefined(behaviortreeentity.hasseenfavoriteenemy) && behaviortreeentity.hasseenfavoriteenemy))
	{
		if(isdefined(behaviortreeentity.favoriteenemy) && behaviortreeentity need_to_run())
		{
			behaviortreeentity.hasseenfavoriteenemy = 1;
		}
	}
	if(isdefined(behaviortreeentity.favoriteenemy))
	{
		if(isdefined(level.enemy_location_override_func))
		{
			goalpos = [[level.enemy_location_override_func]](behaviortreeentity, behaviortreeentity.favoriteenemy);
			if(isdefined(goalpos))
			{
				behaviortreeentity setgoal(goalpos);
				return;
			}
		}
		locomotion_target = get_locomotion_target(behaviortreeentity);
		if(isdefined(locomotion_target))
		{
			repathdist = 16;
			if(!isdefined(behaviortreeentity.lasttargetposition) || distancesquared(behaviortreeentity.lasttargetposition, locomotion_target) > (repathdist * repathdist) || !behaviortreeentity haspath())
			{
				behaviortreeentity function_a57c34b7(locomotion_target);
				behaviortreeentity.lasttargetposition = locomotion_target;
			}
		}
	}
}

/*
	Name: zombiedogshouldmelee
	Namespace: namespace_5eb9b9b6
	Checksum: 0xF6E5E89C
	Offset: 0x1680
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function zombiedogshouldmelee(behaviortreeentity)
{
	if(behaviortreeentity.ignoreall || !is_target_valid(behaviortreeentity, behaviortreeentity.favoriteenemy))
	{
		return 0;
	}
	if(!(isdefined(level.intermission) && level.intermission))
	{
		meleedist = 72;
		if(distancesquared(behaviortreeentity.origin, behaviortreeentity.favoriteenemy.origin) < (meleedist * meleedist) && behaviortreeentity cansee(behaviortreeentity.favoriteenemy))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: zombiedogshouldwalk
	Namespace: namespace_5eb9b9b6
	Checksum: 0xF59B4A2B
	Offset: 0x1768
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function zombiedogshouldwalk(behaviortreeentity)
{
	return bb_getshouldrunstatus() == "walk";
}

/*
	Name: zombiedogshouldrun
	Namespace: namespace_5eb9b9b6
	Checksum: 0xD18B7365
	Offset: 0x1798
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function zombiedogshouldrun(behaviortreeentity)
{
	return bb_getshouldrunstatus() == "run";
}

/*
	Name: use_low_attack
	Namespace: namespace_5eb9b9b6
	Checksum: 0x77103D18
	Offset: 0x17C8
	Size: 0x16E
	Parameters: 0
	Flags: Linked
*/
function use_low_attack()
{
	if(!isdefined(self.enemy) || !isplayer(self.enemy))
	{
		return 0;
	}
	height_diff = self.enemy.origin[2] - self.origin[2];
	low_enough = 30;
	if(height_diff < low_enough && self.enemy getstance() == "prone")
	{
		return 1;
	}
	melee_origin = (self.origin[0], self.origin[1], self.origin[2] + 65);
	enemy_origin = (self.enemy.origin[0], self.enemy.origin[1], self.enemy.origin[2] + 32);
	if(!bullettracepassed(melee_origin, enemy_origin, 0, self))
	{
		return 1;
	}
	return 0;
}

/*
	Name: zombiedogmeleeaction
	Namespace: namespace_5eb9b9b6
	Checksum: 0xBA65696C
	Offset: 0x1940
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function zombiedogmeleeaction(behaviortreeentity, asmstatename)
{
	behaviortreeentity clearpath();
	context = "high";
	if(behaviortreeentity use_low_attack())
	{
		context = "low";
	}
	behaviortreeentity setblackboardattribute("_context", context);
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: zombiedogmeleeactionterminate
	Namespace: namespace_5eb9b9b6
	Checksum: 0x62E32D85
	Offset: 0x19E8
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function zombiedogmeleeactionterminate(behaviortreeentity, asmstatename)
{
	behaviortreeentity setblackboardattribute("_context", undefined);
	return 4;
}

/*
	Name: zombiedoggravity
	Namespace: namespace_5eb9b9b6
	Checksum: 0x9104D1E8
	Offset: 0x1A28
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function zombiedoggravity(entity, attribute, oldvalue, value)
{
	entity setblackboardattribute("_low_gravity", value);
}

/*
	Name: function_5e50d260
	Namespace: namespace_5eb9b9b6
	Checksum: 0xEB4B4754
	Offset: 0x1A78
	Size: 0x18A
	Parameters: 1
	Flags: Linked
*/
function function_5e50d260(dog)
{
	if(!isdefined(dog.favoriteenemy) || !zm_utility::is_player_valid(dog.favoriteenemy))
	{
		return;
	}
	if(!isdefined(dog.var_93a62fe) || dog.favoriteenemy == dog.var_93a62fe)
	{
		return;
	}
	if(!(isdefined(dog.var_2eda3fd0) && dog.var_2eda3fd0))
	{
		dog.var_90957231 = dog zm_utility::approximate_path_dist(dog.favoriteenemy);
		dog.var_2eda3fd0 = 1;
		return;
	}
	new_target_dist = dog zm_utility::approximate_path_dist(dog.var_93a62fe);
	if(isdefined(dog.var_90957231))
	{
		if(isdefined(new_target_dist) && (dog.var_90957231 - new_target_dist) > 200)
		{
			dog function_e856134(dog, dog.var_93a62fe);
		}
	}
	else if(isdefined(new_target_dist))
	{
		dog function_e856134(dog, dog.var_93a62fe);
	}
	dog.var_2eda3fd0 = 0;
}

/*
	Name: function_e856134
	Namespace: namespace_5eb9b9b6
	Checksum: 0x5F184B77
	Offset: 0x1C10
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_e856134(dog, new_target)
{
	function_ea61b64a(dog);
	if(!isdefined(new_target.hunted_by))
	{
		new_target.hunted_by = 0;
	}
	dog.favoriteenemy = new_target;
	dog.favoriteenemy.hunted_by++;
}

/*
	Name: function_ea61b64a
	Namespace: namespace_5eb9b9b6
	Checksum: 0x255EA3F4
	Offset: 0x1C88
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_ea61b64a(dog)
{
	if(isdefined(dog.favoriteenemy) && isdefined(dog.favoriteenemy.hunted_by) && dog.favoriteenemy.hunted_by > 0)
	{
		dog.favoriteenemy.hunted_by--;
	}
	dog.favoriteenemy = undefined;
}

