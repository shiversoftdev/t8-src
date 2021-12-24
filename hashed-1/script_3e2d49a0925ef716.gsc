// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_175bdf559cba9248;
#using script_2118e128407b7acb;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_6809bf766eba194a;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;

#namespace namespace_598c63f4;

/*
	Name: function_89f2df9
	Namespace: namespace_598c63f4
	Checksum: 0xAB4EC432
	Offset: 0x1B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_71cd66f517d8bc47", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_598c63f4
	Checksum: 0x882D267E
	Offset: 0x200
	Size: 0x3EC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"zombie_dog", &function_7728abc3);
	/#
		assert(isscriptfunctionptr(&function_ba0f4046));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_618060e9f5751d51", &function_ba0f4046);
	/#
		assert(isscriptfunctionptr(&function_4e970354));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_147f534982ab5107", &function_4e970354);
	/#
		assert(isscriptfunctionptr(&function_87660c12));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_495c48ce4f6ff5d5", &function_87660c12);
	/#
		assert(isscriptfunctionptr(&function_14a8c157));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_37e69fc4aa586d70", &function_14a8c157);
	/#
		assert(isscriptfunctionptr(&function_af59b7a5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_27d92cd57ceec9c5", &function_af59b7a5, 2);
	/#
		assert(isscriptfunctionptr(&function_dba8e076));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4a484f874e45e3a2", &function_dba8e076, 1);
	/#
		assert(isscriptfunctionptr(&function_3e4b2405));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ecf1cdbc4b0917c", &function_3e4b2405, 1);
	animationstatenetwork::registernotetrackhandlerfunction("wolf_ally_melee", &function_f7c7a416);
	animationstatenetwork::registeranimationmocomp("mocomp_zm_wolf_ally_charge_melee", &function_26fcd34f, &function_e023eac9, &function_643e9ba3);
	/#
		zm_devgui::function_c7dd7a17("", "");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: __main__
	Namespace: namespace_598c63f4
	Checksum: 0x80F724D1
	Offset: 0x5F8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_7728abc3
	Namespace: namespace_598c63f4
	Checksum: 0xFA6E0874
	Offset: 0x608
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7728abc3()
{
	if(isdefined(self.var_9fde8624) && self.var_9fde8624 == #"hash_44aa977896e18e7f")
	{
		aiutility::addaioverridedamagecallback(self, &function_462df450);
		self allowpitchangle(1);
		self setpitchorient();
		self.ignore_nuke = 1;
		self.ignore_all_poi = 1;
		self.instakill_func = &zm_powerups::function_16c2586a;
		self.var_84f9cc2e = 0;
		self.var_1dddf9ab = &function_18da2db6;
		self.var_951e8469 = 0;
		self.next_move_time = 0;
		self.var_594b7855 = 1;
		/#
			self thread function_6ca1cd82();
		#/
	}
}

/*
	Name: function_6ca1cd82
	Namespace: namespace_598c63f4
	Checksum: 0xFCC5C3A3
	Offset: 0x718
	Size: 0x250
	Parameters: 4
	Flags: Private
*/
private function function_6ca1cd82(entity, player, duration, color)
{
	self endon(#"death");
	while(true)
	{
		waitframe(1);
		enabled = getdvarint(#"hash_41b3d8e4a16a265e", 0);
		if(enabled)
		{
			var_bf50a54d = self getcentroid();
			player_owner = function_f00b611e();
			if(isdefined(player_owner))
			{
				var_748152f4 = player_owner getcentroid();
				color = (1, 0, 0);
				if(gettime() > self.var_84f9cc2e)
				{
					color = (0, 1, 0);
				}
				/#
					line(var_748152f4, var_bf50a54d, color);
					sphere(var_bf50a54d, 2, color, 1, 0, 4, 1);
					distance = distance(var_748152f4, var_bf50a54d);
					print3d(var_bf50a54d + vectorscale((0, 0, 1), 30), "" + distance, color, 1, 1, 1);
				#/
				locomotion_target = namespace_5eb9b9b6::get_locomotion_target(self);
				if(isdefined(locomotion_target))
				{
					/#
						line(locomotion_target, var_bf50a54d, (1, 1, 0));
					#/
				}
				else if(isdefined(self.favoriteenemy))
				{
					/#
						line(self.favoriteenemy getcentroid(), var_bf50a54d, (1, 1, 0));
					#/
				}
			}
		}
	}
}

/*
	Name: function_462df450
	Namespace: namespace_598c63f4
	Checksum: 0x902F6697
	Offset: 0x970
	Size: 0x66
	Parameters: 12
	Flags: Linked, Private
*/
private function function_462df450(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	return 0;
}

/*
	Name: function_bd0a9007
	Namespace: namespace_598c63f4
	Checksum: 0xFF7DE26E
	Offset: 0x9E0
	Size: 0xE6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_bd0a9007(entity, target)
{
	result = 1;
	if(!namespace_5eb9b9b6::is_target_valid(entity, target) || (!(isdefined(target.completed_emerging_into_playable_area) && target.completed_emerging_into_playable_area)) || (isdefined(target.in_gravity_trap) && target.in_gravity_trap) || (isdefined(target.var_105c6f35) && target.var_105c6f35) || (isdefined(target.archetype) && target.archetype == #"hash_3b41c3299f47fb7f"))
	{
		result = 0;
	}
	return result;
}

/*
	Name: function_e0b49b0b
	Namespace: namespace_598c63f4
	Checksum: 0x3D2F9788
	Offset: 0xAD0
	Size: 0x102
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e0b49b0b(left, right)
{
	if(isdefined(left.var_15da7e3f) && !isdefined(right.var_15da7e3f))
	{
		return 1;
	}
	if(!isdefined(left.var_15da7e3f) && isdefined(right.var_15da7e3f))
	{
		return 0;
	}
	if(isdefined(left.var_15da7e3f) && isdefined(right.var_15da7e3f) && left.var_15da7e3f > right.var_15da7e3f)
	{
		return 1;
	}
	if(isdefined(left.var_eadd94e6) && isdefined(right.var_eadd94e6) && left.var_eadd94e6 > right.var_eadd94e6)
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_598c63f4
	Checksum: 0x3CCC07B0
	Offset: 0xBE0
	Size: 0x28A
	Parameters: 1
	Flags: Linked, Private
*/
private function get_favorite_enemy(entity)
{
	targets = [];
	targets = getaiteamarray(level.zombie_team);
	valid_targets = [];
	for(i = 0; i < targets.size; i++)
	{
		if(isdefined(targets[i].var_6f84b820) && targets[i].var_6f84b820 == #"boss")
		{
			continue;
		}
		player_owner = function_f00b611e();
		if(isdefined(player_owner))
		{
			var_53a7e303 = distancesquared(player_owner.origin, targets[i].origin);
			height_difference = abs(player_owner.origin[2] - targets[i].origin[2]);
			if(var_53a7e303 > 202500 || height_difference > 180)
			{
				continue;
			}
		}
		if(!function_bd0a9007(entity, targets[i]))
		{
			continue;
		}
		if(isdefined(targets[i].var_15da7e3f) && gettime() < (targets[i].var_15da7e3f + 1000))
		{
			continue;
		}
		targets[i].var_eadd94e6 = distancesquared(entity.origin, targets[i].origin);
		valid_targets[valid_targets.size] = targets[i];
	}
	if(valid_targets.size > 0)
	{
		if(valid_targets.size > 1)
		{
			array::function_b63fcb3(valid_targets, &function_e0b49b0b);
		}
		return valid_targets[valid_targets.size - 1];
	}
	return undefined;
}

/*
	Name: function_af59b7a5
	Namespace: namespace_598c63f4
	Checksum: 0xB44184D5
	Offset: 0xE78
	Size: 0x634
	Parameters: 1
	Flags: Linked, Private
*/
private function function_af59b7a5(entity)
{
	player_owner = function_f00b611e();
	if(!isdefined(player_owner))
	{
		return;
	}
	if(isdefined(entity.favoriteenemy) && !function_bd0a9007(entity, entity.favoriteenemy))
	{
		entity.favoriteenemy = undefined;
	}
	if(!isdefined(entity.favoriteenemy) || isdefined(entity.favoriteenemy.var_15da7e3f))
	{
		entity.favoriteenemy = get_favorite_enemy(entity);
	}
	if(gettime() > entity.var_84f9cc2e && isdefined(entity.favoriteenemy) && isalive(entity.favoriteenemy))
	{
		if(isdefined(level.enemy_location_override_func))
		{
			goalpos = [[level.enemy_location_override_func]](entity, entity.favoriteenemy);
			if(isdefined(goalpos))
			{
				entity setgoal(goalpos);
				return;
			}
		}
		locomotion_target = namespace_5eb9b9b6::get_locomotion_target(entity);
		if(isdefined(locomotion_target) && (!isdefined(entity.lasttargetposition) || distancesquared(entity.lasttargetposition, locomotion_target) > (16 * 16) || !entity haspath()))
		{
			path = generatenavmeshpath(entity.origin, locomotion_target, entity);
			if(isdefined(path) && isdefined(path.pathdistance) && isdefined(player_owner) && path.pathdistance > 3000)
			{
				player_owner.var_772b4ad2 = int(5) + 1;
			}
			else if(!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0)
			{
				entity.favoriteenemy.var_15da7e3f = gettime();
			}
			else
			{
				entity.lasttargetposition = locomotion_target;
				entity.favoriteenemy.var_15da7e3f = undefined;
				entity setgoal(locomotion_target);
			}
		}
	}
	else if(isdefined(player_owner.last_valid_position))
	{
		var_3050773c = distance2d(entity.origin, player_owner.last_valid_position);
		var_7f215628 = abs(entity.origin[2] - player_owner.last_valid_position[2]);
		var_b270b65e = 450 / 2;
		if(var_7f215628 > 200 || var_3050773c > 300 || (var_3050773c > var_b270b65e && !entity isingoal(entity.origin)))
		{
			entity.var_951e8469 = 0;
			if(!isdefined(player_owner.var_15da7e3f) || gettime() > (player_owner.var_15da7e3f + 300))
			{
				path = generatenavmeshpath(entity.origin, player_owner.last_valid_position, entity);
				if(isdefined(path) && isdefined(path.pathdistance) && isdefined(player_owner) && path.pathdistance > 3000)
				{
					player_owner.var_772b4ad2 = int(5) + 1;
				}
				else if(!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0)
				{
					player_owner.var_15da7e3f = gettime();
					if(!isdefined(player_owner.var_772b4ad2))
					{
						player_owner.var_772b4ad2 = 0;
					}
					player_owner.var_772b4ad2 = player_owner.var_772b4ad2 + 1;
				}
				else
				{
					player_owner.var_15da7e3f = undefined;
					player_owner.var_772b4ad2 = undefined;
					entity setgoal(player_owner.last_valid_position);
				}
			}
		}
		else if(var_3050773c <= 300 && entity.var_951e8469 < 1.5)
		{
			player_owner.var_15da7e3f = undefined;
			entity.var_951e8469 = entity.var_951e8469 + (float(function_60d95f53()) / 1000);
			entity setgoal(entity.origin);
		}
		else if(gettime() > entity.next_move_time)
		{
			entity pick_new_movement_point();
		}
	}
}

/*
	Name: function_dba8e076
	Namespace: namespace_598c63f4
	Checksum: 0x7AF2F05A
	Offset: 0x14B8
	Size: 0x96
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dba8e076(entity)
{
	player_owner = function_f00b611e();
	if(!isdefined(player_owner))
	{
		players = getplayers();
		if(players.size > 0)
		{
			entity.var_93a62fe = arraygetclosest(entity.origin, players);
		}
		else
		{
			entity.var_93a62fe = undefined;
		}
	}
}

/*
	Name: function_3e4b2405
	Namespace: namespace_598c63f4
	Checksum: 0x4B14F764
	Offset: 0x1558
	Size: 0x268
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3e4b2405(entity)
{
	var_1f2328d0 = entity function_4794d6a3();
	isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal;
	if(!isatgoal)
	{
		zombies = getaiteamarray(level.zombie_team);
		zombies = arraysortclosest(zombies, entity.origin, undefined, 0, entity getpathfindingradius() + 25);
		var_31a419e0 = [];
		foreach(zombie in zombies)
		{
			if(zombie.var_6f84b820 === #"basic" || zombie.var_6f84b820 === #"popcorn")
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
		foreach(zombie in var_31a419e0)
		{
			if(isdefined(entity.favoriteenemy) && entity.favoriteenemy == zombie)
			{
				continue;
			}
			zombie zombie_utility::setup_zombie_knockdown(entity);
		}
	}
}

/*
	Name: function_f00b611e
	Namespace: namespace_598c63f4
	Checksum: 0xBC827D0B
	Offset: 0x17C8
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f00b611e()
{
	result = undefined;
	if(isdefined(self.player_owner))
	{
		result = self.player_owner;
	}
	else if(isdefined(self.var_93a62fe))
	{
		result = self.var_93a62fe;
	}
	return result;
}

/*
	Name: function_18da2db6
	Namespace: namespace_598c63f4
	Checksum: 0xB78C9711
	Offset: 0x1820
	Size: 0xAA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_18da2db6()
{
	result = "walk";
	player_owner = function_f00b611e();
	if(function_804dd716(self) && isdefined(self.favoriteenemy) || (isdefined(player_owner) && distance2dsquared(self.origin, player_owner.origin) > 250000))
	{
		result = "run";
	}
	return result;
}

/*
	Name: function_804dd716
	Namespace: namespace_598c63f4
	Checksum: 0x3E7AA94
	Offset: 0x18D8
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_804dd716(entity)
{
	return gettime() > entity.var_84f9cc2e;
}

/*
	Name: function_ba0f4046
	Namespace: namespace_598c63f4
	Checksum: 0xE427273
	Offset: 0x1900
	Size: 0x128
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ba0f4046(entity)
{
	result = 0;
	if(gettime() > entity.var_84f9cc2e && (!(isdefined(entity.ignoreall) && entity.ignoreall)) && (!(isdefined(level.intermission) && level.intermission)) && function_bd0a9007(entity, entity.favoriteenemy))
	{
		var_7e0e6341 = entity ai::function_9139c839();
		distance_sq = distancesquared(entity.origin, entity.favoriteenemy.origin);
		if(isdefined(var_7e0e6341) && distance_sq <= (var_7e0e6341.var_23bae7cc * var_7e0e6341.var_23bae7cc))
		{
			result = 1;
		}
	}
	return result;
}

/*
	Name: function_f7c7a416
	Namespace: namespace_598c63f4
	Checksum: 0xB5371596
	Offset: 0x1A30
	Size: 0x47C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f7c7a416(entity)
{
	entity.var_88bd96a9 = gettime() + (getdvarfloat(#"hash_6182e0a57e0b549f", 1) * 1000);
	if(isdefined(entity.enemy) && (!(isdefined(entity.marked_for_death) && entity.marked_for_death)) && (!(isdefined(entity.enemy.ignoreme) && entity.enemy.ignoreme)))
	{
		hit_enemy = entity melee();
		if(isdefined(hit_enemy))
		{
			if(isalive(hit_enemy) && isdefined(hit_enemy.maxhealth))
			{
				var_743a2772 = entity function_f00b611e();
				n_base_damage = hit_enemy.maxhealth;
				var_7e0e6341 = hit_enemy ai::function_9139c839();
				if(isdefined(var_7e0e6341) && isdefined(var_7e0e6341.var_54c33ecd))
				{
					var_b1c1c5cf = var_7e0e6341.var_54c33ecd;
					if(var_b1c1c5cf > 0 && var_b1c1c5cf < 1)
					{
						var_64cc5e50 = 1 / var_b1c1c5cf;
						n_base_damage = n_base_damage * var_64cc5e50;
					}
				}
				if(isdefined(hit_enemy.var_6f84b820))
				{
					switch(hit_enemy.var_6f84b820)
					{
						case "heavy":
						{
							n_base_damage = n_base_damage * 0.2;
							break;
						}
						case "miniboss":
						{
							n_base_damage = n_base_damage * 0.1;
							break;
						}
						case "boss":
						{
							n_base_damage = n_base_damage * 0.05;
							break;
						}
						default:
						{
							break;
						}
					}
				}
				hit_enemy dodamage(n_base_damage, entity.origin, var_743a2772, entity, undefined, "MOD_MELEE", 0, level.var_78032351);
				if(!isalive(hit_enemy))
				{
					if(randomfloat(1) <= 0.8)
					{
						hit_enemy zombie_utility::function_3ab2b4eb();
					}
					force = vectornormalize((hit_enemy.origin - entity.origin) * (1, 1, 0));
					if(isdefined(entity.var_cd8354e0))
					{
						force = anglestoforward(entity.angles * (0, 1, 0));
					}
					if(force != (0, 0, 1) && force != (0, 0, -1))
					{
						side = vectorcross(force, (0, 0, 1));
						force = rotatepointaroundaxis(force, side, randomfloatrange(0, 75));
						force = force * randomfloatrange(30, 85);
					}
					hit_enemy startragdoll();
					hit_enemy launchragdoll(force);
				}
			}
			self.var_84f9cc2e = gettime() + 500;
		}
		entity callback::callback(#"hash_11aa32ad6d527054");
	}
}

/*
	Name: pick_new_movement_point
	Namespace: namespace_598c63f4
	Checksum: 0x292208A4
	Offset: 0x1EB8
	Size: 0x19E
	Parameters: 0
	Flags: Linked, Private
*/
private function pick_new_movement_point()
{
	var_bc03597b = self.origin;
	player_owner = function_f00b611e();
	if(isdefined(player_owner))
	{
		var_bc03597b = player_owner.origin;
	}
	queryresult = positionquery_source_navigation(var_bc03597b, 96, 256, 128, 20, self);
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
	if(isdefined(self.companion_destination))
	{
		self setgoal(self.companion_destination);
	}
	self.next_move_time = gettime() + randomintrange(3000, 8000);
}

/*
	Name: function_4e970354
	Namespace: namespace_598c63f4
	Checksum: 0xCD3A711B
	Offset: 0x2060
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4e970354(entity)
{
	result = 0;
	player_owner = function_f00b611e();
	if(isdefined(player_owner) && isdefined(player_owner.var_772b4ad2) && (player_owner.var_772b4ad2 * 300) >= 1500)
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_87660c12
	Namespace: namespace_598c63f4
	Checksum: 0x8287C38C
	Offset: 0x20E8
	Size: 0xA6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_87660c12(entity)
{
	player_owner = function_f00b611e();
	if(isdefined(player_owner))
	{
		spawn_location = player_owner namespace_96bb7ff1::function_562ade9e();
		if(isdefined(spawn_location))
		{
			entity forceteleport(spawn_location);
			entity setgoal(entity.origin);
		}
	}
	player_owner.var_15da7e3f = undefined;
	player_owner.var_772b4ad2 = undefined;
	return 5;
}

#namespace namespace_b382833a;

/*
	Name: __constructor
	Namespace: namespace_b382833a
	Checksum: 0x4B76996C
	Offset: 0x2198
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
	Namespace: namespace_b382833a
	Checksum: 0x80F724D1
	Offset: 0x21C0
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_598c63f4;

/*
	Name: function_b382833a
	Namespace: namespace_598c63f4
	Checksum: 0x6F7C559C
	Offset: 0x21D0
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_b382833a()
{
	classes.var_b382833a[0] = spawnstruct();
	classes.var_b382833a[0].__vtable[913321084] = &namespace_b382833a::__destructor;
	classes.var_b382833a[0].__vtable[674154906] = &namespace_b382833a::__constructor;
}

/*
	Name: function_14a8c157
	Namespace: namespace_598c63f4
	Checksum: 0xB10A34EC
	Offset: 0x2260
	Size: 0x2EA
	Parameters: 1
	Flags: Linked
*/
function function_14a8c157(entity)
{
	if(isdefined(entity.enemy) && gettime() > entity.var_84f9cc2e)
	{
		if(!btapi_shouldchargemelee(entity))
		{
			return 0;
		}
		predictedenemypos = entity.enemy.origin;
		distancesq = distancesquared(entity.origin, entity.enemy.origin);
		var_7e0e6341 = entity ai::function_9139c839();
		if(isdefined(var_7e0e6341) && distancesq < (var_7e0e6341.var_23bae7cc * var_7e0e6341.var_23bae7cc))
		{
			return 0;
		}
		if(isplayer(entity.enemy) && distancesq >= (100 * 100))
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
	return 0;
}

/*
	Name: function_26fcd34f
	Namespace: namespace_598c63f4
	Checksum: 0x57534057
	Offset: 0x2558
	Size: 0x45C
	Parameters: 5
	Flags: Linked
*/
function function_26fcd34f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	/#
		record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
	#/
	entity animmode("gravity", 1);
	entity orientmode("face angle", entity.angles[1]);
	entity.usegoalanimweight = 1;
	entity pathmode("dont move");
	entity collidewithactors(0);
	entity.pushable = 0;
	entity pushplayer(0);
	if(isdefined(entity.enemy))
	{
		dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
		entity forceteleport(entity.origin, vectortoangles(dirtoenemy));
	}
	if(!isdefined(entity.var_cd8354e0))
	{
		object = new var_b382833a();
		[[ object ]]->__constructor();
		entity.var_cd8354e0 = object;
		entity.var_cd8354e0.var_9bfa8497 = entity.origin;
		entity.var_cd8354e0.var_98bc84b7 = getnotetracktimes(mocompanim, "start_adjust")[0];
		entity.var_cd8354e0.var_6392c3a2 = getnotetracktimes(mocompanim, "end_adjust")[0];
		var_e397f54c = getmovedelta(mocompanim, 0, 1, entity);
		if(isdefined(entity.enemy))
		{
			entity.var_cd8354e0.var_cb28f380 = entity.enemy.origin;
			enemy_distance = distance(entity.origin, entity.enemy.origin);
			/#
				recordcircle(entity.enemy.origin, 8, (1, 0, 0), "");
			#/
		}
		else
		{
			entity.var_cd8354e0.var_cb28f380 = entity localtoworldcoords(var_e397f54c);
		}
		/#
			movedelta = getmovedelta(mocompanim, 0, 1, entity);
			var_6b8f735f = entity localtoworldcoords(movedelta);
			distance = distance(entity.origin, var_6b8f735f);
			recordcircle(entity.var_cd8354e0.var_9bfa8497, 8, (0, 1, 0), "");
			recordcircle(var_6b8f735f, 8, (0, 1, 0), "");
			record3dtext("" + distance, var_6b8f735f, (0, 1, 0), "");
		#/
	}
}

/*
	Name: function_e023eac9
	Namespace: namespace_598c63f4
	Checksum: 0xED8A56C1
	Offset: 0x29C0
	Size: 0xD4C
	Parameters: 5
	Flags: Linked
*/
function function_e023eac9(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	/#
		assert(isdefined(entity.var_cd8354e0));
	#/
	var_e72a224a = entity getanimtime(mocompanim);
	offset = (1, 1, 1);
	if(isdefined(entity.enemy) && !entity.var_cd8354e0.adjustmentstarted && entity.var_cd8354e0.var_425c4c8b && var_e72a224a >= entity.var_cd8354e0.var_98bc84b7)
	{
		predictedenemypos = entity.enemy.origin;
		velocity = entity.enemy getvelocity();
		if(length(velocity) > 0)
		{
			animlength = getanimlength(mocompanim) * 1000;
			var_16c6aa5b = (entity.var_cd8354e0.var_6392c3a2 * animlength) - (entity.var_cd8354e0.var_98bc84b7 * animlength);
			var_b1145e11 = vectorscale(velocity, var_16c6aa5b / 1000);
			predictedenemypos = predictedenemypos + var_b1145e11;
		}
		entity.var_cd8354e0.var_736d2cce = predictedenemypos;
		/#
			recordsphere(entity.var_cd8354e0.var_cb28f380 + offset, 2, (1, 0, 1), "");
			recordsphere(entity.var_cd8354e0.var_736d2cce + offset, 4, (1, 0, 1), "");
			recordline(entity.var_cd8354e0.var_cb28f380 + offset, entity.var_cd8354e0.var_736d2cce + offset, (1, 0, 1), "");
		#/
		var_283a081d = distance(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_cb28f380);
		var_cf699df5 = distancesquared(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_cb28f380);
		var_5eef8d2d = distance(entity.var_cd8354e0.var_cb28f380, entity.var_cd8354e0.var_736d2cce);
		var_776ddabf = distancesquared(entity.var_cd8354e0.var_cb28f380, entity.var_cd8354e0.var_736d2cce);
		var_62670629 = distance(entity.var_cd8354e0.var_9bfa8497, entity.var_cd8354e0.var_736d2cce);
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
		else if(var_cf699df5 > var_65cbfb52 && var_776ddabf >= 0)
		{
			/#
				record3dtext("", entity.origin + vectorscale((0, 0, 1), 60), (1, 0, 0), "");
			#/
			entity.var_cd8354e0.var_425c4c8b = 0;
		}
		else if(var_65cbfb52 >= (300 * 300))
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
				reasons = (((("" + isvisible) + "") + var_6738a702) + "") + var_175919d1;
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
		adjustedorigin = entity.origin + (entity.var_cd8354e0.var_10b8b6d1 * entity.var_cd8354e0.var_8b9a15a6);
		/#
			recordsphere(entity.var_cd8354e0.var_cb28f380, 3, (0, 1, 0), "");
			recordsphere(adjustedorigin + offset, 1, (0, 0, 1), "");
			recordline(entity.origin + offset, adjustedorigin + offset, (0, 0, 1), "");
		#/
		entity forceteleport(adjustedorigin);
	}
}

/*
	Name: function_643e9ba3
	Namespace: namespace_598c63f4
	Checksum: 0xF8284498
	Offset: 0x3718
	Size: 0xBE
	Parameters: 5
	Flags: Linked
*/
function function_643e9ba3(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.usegoalanimweight = 0;
	entity pathmode("move allowed");
	entity orientmode("face default");
	entity collidewithactors(1);
	entity pushplayer(1);
	entity.pushable = 1;
	entity.var_cd8354e0 = undefined;
}

