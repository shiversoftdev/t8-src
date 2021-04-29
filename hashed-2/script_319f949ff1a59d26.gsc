// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_7e59d7bba853fe4b;
#using script_d8b1f4ee30e5fc5;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_983c37ea;

/*
	Name: function_89f2df9
	Namespace: namespace_983c37ea
	Checksum: 0x8A353D1A
	Offset: 0x150
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6c20d49019c685c7", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_983c37ea
	Checksum: 0xB9862C60
	Offset: 0x1A0
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_14c746e550d9f3ca", 1, 2, "counter");
	function_d5ccdca1();
	zm_player::register_player_damage_callback(&function_9808e44f);
	spawner::add_archetype_spawn_function(#"tiger", &function_9e36d009);
	/#
		spawner::add_archetype_spawn_function(#"tiger", &zombie_utility::function_27ba8249);
	#/
	/#
		if(!zm_score::function_e5ca5733(#"tiger"))
		{
			zm_score::function_e5d6e6dd(#"tiger", 60);
		}
	#/
}

/*
	Name: __main__
	Namespace: namespace_983c37ea
	Checksum: 0x80F724D1
	Offset: 0x2D8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_d5ccdca1
	Namespace: namespace_983c37ea
	Checksum: 0x710542D1
	Offset: 0x2E8
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d5ccdca1()
{
	/#
		assert(isscriptfunctionptr(&function_10687511));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_61f243f0abc94839", &function_10687511, 1);
	/#
		assert(isscriptfunctionptr(&function_8709c761));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3f99b564459b7db8", &function_8709c761);
	/#
		assert(isscriptfunctionptr(&function_6c513e36));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_70607ec85c34b86f", &function_6c513e36);
}

/*
	Name: function_10687511
	Namespace: namespace_983c37ea
	Checksum: 0xCE093700
	Offset: 0x438
	Size: 0x572
	Parameters: 1
	Flags: Linked, Private
*/
private function function_10687511(entity)
{
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
	if(isdefined(entity.disabletargetservice) && entity.disabletargetservice)
	{
		return 0;
	}
	if(entity.team == #"allies")
	{
		entity function_cd6f239();
		if(isdefined(entity.favoriteenemy))
		{
			return entity zm_utility::function_64259898(entity.favoriteenemy.origin, 128);
		}
		return 0;
	}
	zombie_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
	entity zombie_utility::run_ignore_player_handler();
	entity.favoriteenemy = entity.var_93a62fe;
	if(isdefined(zombie_poi) && isdefined(zombie_poi[1]))
	{
		goalpos = zombie_poi[0];
		return entity zm_utility::function_64259898(goalpos, 128);
	}
	if(isdefined(entity.var_4dc477c) && entity.var_4dc477c)
	{
		entity.favoriteenemy = undefined;
	}
	if(!isdefined(entity.favoriteenemy) || zm_behavior::zombieshouldmoveawaycondition(entity))
	{
		zone = zm_utility::get_current_zone();
		if(isdefined(zone))
		{
			wait_locations = level.zones[zone].a_loc_types[#"wait_location"];
			if(isdefined(wait_locations) && wait_locations.size > 0)
			{
				return entity zm_utility::function_64259898(wait_locations[0].origin, 128);
			}
		}
		entity setgoal(entity.origin);
		return 0;
	}
	if(!(isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy))
	{
		if(isdefined(entity.favoriteenemy) && entity namespace_dea34b6a::need_to_run())
		{
			entity.hasseenfavoriteenemy = 1;
			entity setblackboardattribute("_seen_enemy", "has_seen");
		}
	}
	/#
		if(entity.favoriteenemy isnotarget())
		{
			entity setgoal(entity.origin);
			return 0;
		}
	#/
	var_eef1279d = 0;
	if(distancesquared(entity.origin, entity.favoriteenemy.origin) >= 400 * 400)
	{
		var_eef1279d = 1;
	}
	if(var_eef1279d && entity function_8d4da9d6() && (!(isdefined(entity.var_cc94acec) && entity.var_cc94acec)) && (isdefined(entity.hasseenfavoriteenemy) && entity.hasseenfavoriteenemy))
	{
		if(!isdefined(entity.var_aaeee932))
		{
			entity.var_aaeee932 = 0;
			if(math::cointoss())
			{
				entity.var_aaeee932 = 2;
			}
		}
		entity function_4703be8a();
	}
	if(isdefined(entity.var_cc94acec) && entity.var_cc94acec && (!(isdefined(entity.var_b11272e3) && entity.var_b11272e3)))
	{
		self function_a57c34b7(entity.var_826049b6);
		if(distancesquared(entity.origin, entity.var_826049b6) <= 64 * 64)
		{
			entity.var_b11272e3 = 1;
			self function_d4c687c9();
		}
		return 1;
	}
	goalent = entity.favoriteenemy;
	if(isplayer(goalent))
	{
		goalent = namespace_e0710ee6::function_a2e8fd7b(entity, entity.favoriteenemy);
	}
	return entity zm_utility::function_64259898(goalent.origin, 128);
}

/*
	Name: function_4703be8a
	Namespace: namespace_983c37ea
	Checksum: 0xB17C44F6
	Offset: 0x9B8
	Size: 0x224
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4703be8a()
{
	var_77f4782e = 45;
	if(isdefined(self.var_aaeee932))
	{
		if(self.var_aaeee932 == 0)
		{
			var_77f4782e = -45;
		}
		else if(self.var_aaeee932 == 1)
		{
			var_77f4782e = -22.5;
		}
		else if(self.var_aaeee932 == 3)
		{
			var_77f4782e = 22.5;
		}
		self.var_aaeee932++;
		if(self.var_aaeee932 > 3)
		{
			self.var_aaeee932 = 0;
		}
	}
	enemy = self.favoriteenemy;
	var_4a8dc744 = vectortoangles(self.origin - self.favoriteenemy.origin)[1];
	var_36294491 = absangleclamp360(var_4a8dc744 + var_77f4782e);
	var_ef2595f9 = anglestoforward((0, var_36294491, 0));
	var_9b0fde6d = enemy.origin + var_ef2595f9 * 400;
	var_b4a11ac2 = getclosestpointonnavmesh(var_9b0fde6d, 128, self getpathfindingradius());
	if(isdefined(var_b4a11ac2))
	{
		var_3af6337 = self findpath(self.origin, var_b4a11ac2, 1, 0);
		if(var_3af6337)
		{
			self.var_826049b6 = var_b4a11ac2;
			self.var_cc94acec = 1;
			/#
				recordsphere(self.var_826049b6, 3, (0, 1, 0), "");
			#/
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_8d4da9d6
	Namespace: namespace_983c37ea
	Checksum: 0x988F071D
	Offset: 0xBE8
	Size: 0x1A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8d4da9d6()
{
	if(gettime() > self.var_86152978)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_cd6f239
	Namespace: namespace_983c37ea
	Checksum: 0x9DF33898
	Offset: 0xC10
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function function_cd6f239()
{
	zombies = getaispeciesarray(level.zombie_team, "all");
	zombie_enemy = undefined;
	closest_dist = undefined;
	foreach(zombie in zombies)
	{
		if(isalive(zombie) && (isdefined(zombie.completed_emerging_into_playable_area) && zombie.completed_emerging_into_playable_area) && !zm_utility::is_magic_bullet_shield_enabled(zombie) && (isdefined(zombie.canbetargetedbyturnedzombies) && zombie.canbetargetedbyturnedzombies || (isdefined(zombie.var_8c28b842) && zombie.var_8c28b842)))
		{
			dist = distancesquared(self.origin, zombie.origin);
			if(!isdefined(closest_dist) || dist < closest_dist)
			{
				closest_dist = dist;
				zombie_enemy = zombie;
			}
		}
	}
	self.favoriteenemy = zombie_enemy;
}

/*
	Name: function_8709c761
	Namespace: namespace_983c37ea
	Checksum: 0x6E9DA1D1
	Offset: 0xDC8
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function function_8709c761(entity)
{
	if(isdefined(entity.var_d96b3fd4) && entity.var_d96b3fd4)
	{
		return 0;
	}
	if(!entity namespace_dea34b6a::function_8de56915(102 * 102))
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
	Name: function_6c513e36
	Namespace: namespace_983c37ea
	Checksum: 0x16F8F8AE
	Offset: 0xE48
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function function_6c513e36(entity)
{
	if(!entity namespace_dea34b6a::function_8de56915(180 * 180))
	{
		return 0;
	}
	if(isdefined(entity.var_d96b3fd4) && entity.var_d96b3fd4)
	{
		entity.var_d96b3fd4 = 0;
		return 1;
	}
	if(!entity cansee(entity.favoriteenemy))
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.favoriteenemy.origin) < 40 * 40)
	{
		return 1;
	}
	if(namespace_e0710ee6::function_54054394(entity))
	{
		return 0;
	}
	if(!tracepassedonnavmesh(entity.origin, (isdefined(entity.favoriteenemy.favoriteenemy.last_valid_position) ? entity.favoriteenemy.last_valid_position : entity.favoriteenemy.origin), entity.favoriteenemy getpathfindingradius()))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_9e36d009
	Namespace: namespace_983c37ea
	Checksum: 0x46C50CFD
	Offset: 0xFC0
	Size: 0x23A
	Parameters: 0
	Flags: Linked
*/
function function_9e36d009()
{
	self.allowdeath = 1;
	self.allowpain = 0;
	self.force_gib = 1;
	self.is_zombie = 1;
	self.gibbed = 0;
	self.head_gibbed = 0;
	self.default_goalheight = 40;
	self.ignore_inert = 1;
	self.holdfire = 1;
	self.var_11b4c057 = 1;
	self.grenadeawareness = 0;
	self.badplaceawareness = 0;
	self.ignoresuppression = 1;
	self.suppressionthreshold = 1;
	self.dontshootwhilemoving = 1;
	self.pathenemylookahead = 0;
	self.badplaceawareness = 0;
	self.chatinitialized = 0;
	self.b_ignore_cleanup = 1;
	self.team = level.zombie_team;
	self.var_8c28b842 = 1;
	self.var_7672fb41 = 1;
	self.ignorepathenemyfightdist = 1;
	self allowpitchangle(1);
	self setpitchorient();
	self setavoidancemask("avoid ai");
	self collidewithactors(1);
	self.closest_player_override = &zm_utility::function_c52e1749;
	self thread zombie_utility::round_spawn_failsafe();
	level thread zm_spawner::zombie_death_event(self);
	self callback::function_d8abfc3d(#"on_ai_killed", &function_5c8b8bef);
	self thread zm_audio::zmbaivox_notifyconvert();
	self thread zm_audio::play_ambient_zombie_vocals();
	self.deathfunction = &zm_spawner::zombie_death_animscript;
}

/*
	Name: function_5c8b8bef
	Namespace: namespace_983c37ea
	Checksum: 0x5A50845E
	Offset: 0x1208
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_5c8b8bef(params)
{
	self val::set(#"hash_6c20d49019c685c7", "hide", 1);
	self notsolid();
}

/*
	Name: function_9808e44f
	Namespace: namespace_983c37ea
	Checksum: 0x165414B1
	Offset: 0x1268
	Size: 0xE8
	Parameters: 10
	Flags: Linked
*/
function function_9808e44f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && isai(eattacker) && eattacker.archetype == #"tiger" && eattacker.team != self.team)
	{
		if(isdefined(eattacker.var_d6c43d9b))
		{
			self function_8fc19416(eattacker.var_d6c43d9b);
		}
	}
	return -1;
}

/*
	Name: function_8fc19416
	Namespace: namespace_983c37ea
	Checksum: 0x30EBE2C6
	Offset: 0x1358
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function function_8fc19416(notetrack)
{
	switch(notetrack)
	{
		case "tiger_melee_left":
		{
			self clientfield::increment_to_player("" + #"hash_14c746e550d9f3ca", 2);
			break;
		}
		case "tiger_melee_right":
		{
			self clientfield::increment_to_player("" + #"hash_14c746e550d9f3ca", 1);
			break;
		}
	}
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_983c37ea
	Checksum: 0x72ADE929
	Offset: 0x1408
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function get_favorite_enemy()
{
	var_7c746996 = getplayers();
	least_hunted = var_7c746996[0];
	for(i = 0; i < var_7c746996.size; i++)
	{
		if(!isdefined(var_7c746996[i].hunted_by))
		{
			var_7c746996[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(var_7c746996[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(least_hunted))
		{
			least_hunted = var_7c746996[i];
		}
		if(var_7c746996[i].hunted_by < least_hunted.hunted_by)
		{
			least_hunted = var_7c746996[i];
		}
	}
	if(!zm_utility::is_player_valid(least_hunted))
	{
		return undefined;
	}
	least_hunted.hunted_by = least_hunted.hunted_by + 1;
	return least_hunted;
}

/*
	Name: function_c436ab98
	Namespace: namespace_983c37ea
	Checksum: 0xD958CC7E
	Offset: 0x1548
	Size: 0x68
	Parameters: 0
	Flags: None
*/
function function_c436ab98()
{
	self endon(#"death");
	while(true)
	{
		if(!zm_utility::is_player_valid(self.favoriteenemy))
		{
			self.favoriteenemy = get_favorite_enemy();
		}
		wait(0.2);
	}
}

