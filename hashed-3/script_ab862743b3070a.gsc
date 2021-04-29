// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_58c342edd81589fb;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_c402654;

/*
	Name: function_89f2df9
	Namespace: namespace_c402654
	Checksum: 0x33CFD6C2
	Offset: 0x318
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_29467933d0da473b", &__init__, undefined, #"aat");
}

/*
	Name: __init__
	Namespace: namespace_c402654
	Checksum: 0xCDA09F4D
	Offset: 0x368
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "dog_fx", 1, 1, "int");
	clientfield::register("actor", "dog_spawn_fx", 1, 1, "counter");
	clientfield::register("world", "dog_round_fog_bank", 1, 1, "int");
	level.dogs_enabled = 1;
	level.dog_rounds_enabled = 0;
	level.dog_round_count = 1;
	level.dog_spawners = [];
	level flag::init("dog_clips");
	zombie_utility::set_zombie_var(#"dog_fire_trail_percent", 50);
	level thread aat::register_immunity("zm_aat_brain_decay", #"zombie_dog", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"zombie_dog", 0, 0, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"blight_father", 0, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"zombie_dog", 0, 1, 1);
	dog_spawner_init();
	level thread dog_clip_monitor();
	namespace_c3287616::register_archetype(#"zombie_dog", &function_b168b424, &function_abc64f33, &function_62db7b1c, 25);
	zm_score::function_e5d6e6dd(#"zombie_dog", 60);
	callback::function_74872db6(&function_81f9083e);
}

/*
	Name: function_aec3446d
	Namespace: namespace_c402654
	Checksum: 0x9EE88C84
	Offset: 0x610
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_aec3446d(b_ignore_cleanup = 1)
{
	if(!namespace_59ff1d6c::function_901b751c(#"hash_4deb3ae7a73c87f3") || (isdefined(level.var_15747fb1) && level.var_15747fb1))
	{
		return;
	}
	level.dog_rounds_enabled = 1;
	level.var_dc50acfa = b_ignore_cleanup;
	if(!isdefined(level.dog_round_track_override))
	{
		level.dog_round_track_override = &dog_round_tracker;
	}
	level thread [[level.dog_round_track_override]]();
}

/*
	Name: dog_spawner_init
	Namespace: namespace_c402654
	Checksum: 0x76B2F9BC
	Offset: 0x6D8
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function dog_spawner_init()
{
	level.dog_spawners = getentarray("zombie_dog_spawner", "script_noteworthy");
	later_dogs = getentarray("later_round_dog_spawners", "script_noteworthy");
	level.dog_spawners = arraycombine(level.dog_spawners, later_dogs, 1, 0);
	if(level.dog_spawners.size == 0)
	{
		return;
	}
	for(i = 0; i < level.dog_spawners.size; i++)
	{
		if(zm_spawner::is_spawner_targeted_by_blocker(level.dog_spawners[i]))
		{
			level.dog_spawners[i].is_enabled = 0;
			continue;
		}
		level.dog_spawners[i].is_enabled = 1;
		level.dog_spawners[i].script_forcespawn = 1;
	}
	/#
		assert(level.dog_spawners.size > 0);
	#/
	level.dog_health = 100;
	array::thread_all(level.dog_spawners, &spawner::add_spawn_function, &dog_init);
}

/*
	Name: function_dd162858
	Namespace: namespace_c402654
	Checksum: 0x47B279E9
	Offset: 0x890
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_dd162858()
{
	a_e_players = getplayers();
	if(level.dog_round_count < 3)
	{
		n_max = a_e_players.size * 6;
	}
	else
	{
		n_max = a_e_players.size * 8;
	}
	return n_max;
}

/*
	Name: function_20aadb5e
	Namespace: namespace_c402654
	Checksum: 0x999FF6
	Offset: 0x8F8
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_20aadb5e()
{
	a_e_players = getplayers();
	n_max = namespace_a28acff3::get_zombie_count_for_round(level.round_number, a_e_players.size);
	return int(n_max * 0.6);
}

/*
	Name: waiting_for_next_dog_spawn
	Namespace: namespace_c402654
	Checksum: 0x6FC6F890
	Offset: 0x968
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function waiting_for_next_dog_spawn(count, max)
{
	default_wait = 0.75;
	if(level.dog_round_count == 1)
	{
		default_wait = 2;
	}
	else if(level.dog_round_count == 2)
	{
		default_wait = 1.5;
	}
	else if(level.dog_round_count == 3)
	{
		default_wait = 1;
	}
	else
	{
		default_wait = 0.75;
	}
	if(isdefined(count) && isdefined(max))
	{
		wait(max(default_wait - count / max, 0.05));
	}
	else
	{
		wait(max(default_wait - 0.5, 0.05));
	}
}

/*
	Name: function_d544de30
	Namespace: namespace_c402654
	Checksum: 0xA101C50C
	Offset: 0xA70
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function function_d544de30()
{
	wait(0.25);
}

/*
	Name: function_ed67c5e7
	Namespace: namespace_c402654
	Checksum: 0x6BFEAF78
	Offset: 0xA88
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_ed67c5e7(s_params)
{
	if(isdefined(self) && !zm_utility::is_standard())
	{
		level thread zm_powerups::specific_powerup_drop("full_ammo", self.origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
	}
}

/*
	Name: dog_spawn_fx
	Namespace: namespace_c402654
	Checksum: 0x52F10FF2
	Offset: 0xAF8
	Size: 0x368
	Parameters: 2
	Flags: Linked
*/
function dog_spawn_fx(ai, ent)
{
	ai endon(#"death");
	ai val::set(#"dog_spawn", "allowdeath", 0);
	ai setfreecameralockonallowed(0);
	ai pathmode("dont move", 1);
	playsoundatposition(#"zmb_hellhound_prespawn", ent.origin);
	ai clientfield::increment("dog_spawn_fx");
	wait(1.5);
	playsoundatposition(#"zmb_hellhound_bolt", ent.origin);
	ai pathmode("move allowed", 1);
	earthquake(0.5, 0.75, ent.origin, 1000);
	playsoundatposition(#"zmb_hellhound_spawn", ent.origin);
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
	/#
		assert(isdefined(ai), "");
	#/
	/#
		assert(isalive(ai), "");
	#/
	ai zombie_setup_attack_properties_dog();
	ai val::reset(#"dog_spawn", "allowdeath");
	wait(0.1);
	ai show();
	ai setfreecameralockonallowed(1);
	ai val::reset(#"dog_spawn", "ignoreme");
	ai notify(#"visible");
	ai.completed_emerging_into_playable_area = 1;
	ai notify(#"completed_emerging_into_playable_area");
}

/*
	Name: dog_spawn_factory_logic
	Namespace: namespace_c402654
	Checksum: 0x4CC25A54
	Offset: 0xE68
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function dog_spawn_factory_logic(favorite_enemy)
{
	dog_locs = array::randomize(level.zm_loc_types[#"dog_location"]);
	for(i = 0; i < dog_locs.size; i++)
	{
		if(isdefined(level.old_dog_spawn) && level.old_dog_spawn == dog_locs[i])
		{
			continue;
		}
		dist_squared = distancesquared(dog_locs[i].origin, favorite_enemy.origin);
		if(dist_squared > 160000 && dist_squared < 1000000)
		{
			level.old_dog_spawn = dog_locs[i];
			return dog_locs[i];
		}
	}
	return dog_locs[0];
}

/*
	Name: function_81f9083e
	Namespace: namespace_c402654
	Checksum: 0x14976062
	Offset: 0xF88
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_81f9083e()
{
	players = getplayers();
	foreach(player in players)
	{
		player.var_230becc2 = 0;
		player.hunted_by = 0;
	}
}

/*
	Name: function_a5abd591
	Namespace: namespace_c402654
	Checksum: 0xC9E46491
	Offset: 0x1028
	Size: 0x132
	Parameters: 0
	Flags: Linked
*/
function function_a5abd591()
{
	dog_targets = getplayers();
	var_d6c885ef = dog_targets[0];
	for(i = 0; i < dog_targets.size; i++)
	{
		if(!isdefined(dog_targets[i].var_230becc2))
		{
			dog_targets[i].var_230becc2 = 0;
			dog_targets[i].hunted_by = 0;
		}
		if(!zm_utility::is_player_valid(dog_targets[i]))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(var_d6c885ef))
		{
			var_d6c885ef = dog_targets[i];
		}
		if(dog_targets[i].var_230becc2 < var_d6c885ef.var_230becc2)
		{
			var_d6c885ef = dog_targets[i];
		}
	}
	if(!zm_utility::is_player_valid(var_d6c885ef))
	{
		return undefined;
	}
	return var_d6c885ef;
}

/*
	Name: get_favorite_enemy
	Namespace: namespace_c402654
	Checksum: 0x170DE508
	Offset: 0x1168
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function get_favorite_enemy()
{
	dog_targets = getplayers();
	least_hunted = undefined;
	foreach(player in dog_targets)
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(!zm_utility::is_player_valid(player))
		{
			continue;
		}
		if(!isdefined(player.hunted_by))
		{
			player.hunted_by = 0;
		}
		if(!isdefined(least_hunted))
		{
			least_hunted = player;
			continue;
		}
		if(player.hunted_by < least_hunted.hunted_by)
		{
			least_hunted = player;
		}
	}
	return least_hunted;
}

/*
	Name: dog_health_increase
	Namespace: namespace_c402654
	Checksum: 0x192DD65F
	Offset: 0x1280
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function dog_health_increase()
{
	players = getplayers();
	if(level.dog_round_count == 1)
	{
		level.dog_health = 800;
	}
	else if(level.dog_round_count == 2)
	{
		level.dog_health = 1200;
	}
	else if(level.dog_round_count == 3)
	{
		level.dog_health = 1600;
	}
	else if(level.dog_round_count == 4)
	{
		level.dog_health = 2000;
	}
	if(level.dog_health > 2000)
	{
		level.dog_health = 2000;
	}
}

/*
	Name: dog_round_tracker
	Namespace: namespace_c402654
	Checksum: 0xFDA15081
	Offset: 0x1358
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function dog_round_tracker(var_634c65f0)
{
	level.dog_round_count = 1;
	if(isdefined(level.var_973488a5))
	{
		level.next_dog_round = level.var_973488a5;
	}
	else
	{
		level.next_dog_round = level.round_number + randomintrange(4, 7);
	}
	namespace_c3287616::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_dd162858, &waiting_for_next_dog_spawn, level.var_dc50acfa);
	if(!(isdefined(var_634c65f0) && var_634c65f0))
	{
		namespace_c3287616::function_df803678(&function_ed67c5e7);
	}
	if(isdefined(level.var_3ef0606f) && level.var_3ef0606f)
	{
		namespace_c3287616::function_376e51ef(#"zombie_dog", level.next_dog_round + 1);
	}
	/#
		level thread function_de0a6ae4();
	#/
}

/*
	Name: function_246a0760
	Namespace: namespace_c402654
	Checksum: 0x12FE1DBA
	Offset: 0x14E0
	Size: 0x16C
	Parameters: 0
	Flags: None
*/
function function_246a0760()
{
	level endon(#"game_ended");
	level.dog_round_count = 1;
	level.next_dog_round = 6;
	namespace_c3287616::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &function_5f1ef789, &function_20aadb5e, &function_d544de30, level.var_dc50acfa);
	zm_utility::function_fdb0368(7);
	level.dog_round_count = 3;
	level.next_dog_round = 24;
	namespace_c3287616::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &function_5f1ef789, &function_20aadb5e, &function_d544de30, level.var_dc50acfa);
	/#
		level thread function_de0a6ae4();
	#/
}

/*
	Name: function_de0a6ae4
	Namespace: namespace_c402654
	Checksum: 0x9D399B3A
	Offset: 0x1658
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function function_de0a6ae4()
{
	/#
		while(true)
		{
			level waittill(#"between_round_over");
			if(getdvarint(#"force_dogs", 0) > 0)
			{
				level.next_dog_round = level.round_number;
			}
		}
	#/
}

/*
	Name: dog_round_start
	Namespace: namespace_c402654
	Checksum: 0x2CF6D6AE
	Offset: 0x16C8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function dog_round_start()
{
	level flag::set("dog_round");
	level flag::set("dog_clips");
	level thread zm_audio::sndmusicsystem_playstate("dog_start");
	level thread clientfield::set("dog_round_fog_bank", 1);
	dog_health_increase();
	players = getplayers();
	array::thread_all(players, &play_dog_round);
	wait(5);
	level thread function_c5ab118d();
}

/*
	Name: function_c5ab118d
	Namespace: namespace_c402654
	Checksum: 0x2AAD5430
	Offset: 0x17C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_c5ab118d()
{
	zm_audio::sndannouncerplayvox(#"dogstart");
}

/*
	Name: dog_round_stop
	Namespace: namespace_c402654
	Checksum: 0x595CFA42
	Offset: 0x17F0
	Size: 0x1CC
	Parameters: 1
	Flags: Linked
*/
function dog_round_stop(var_d25bbdd5)
{
	level flag::clear("dog_round");
	level flag::clear("dog_clips");
	level thread zm_audio::sndmusicsystem_playstate("dog_end");
	zm::increment_dog_round_stat("finished");
	level.dog_round_count = level.dog_round_count + 1;
	wait(5);
	if(isdefined(level.var_539f36cd))
	{
		[[level.var_539f36cd]]();
	}
	else
	{
		level.next_dog_round = level.round_number + randomintrange(5, 7);
	}
	namespace_c3287616::function_b4a8f95a(#"zombie_dog", level.next_dog_round, &dog_round_start, &dog_round_stop, &function_dd162858, &waiting_for_next_dog_spawn, level.var_dc50acfa);
	/#
		getplayers()[0] iprintln("" + level.next_dog_round);
	#/
	level thread clientfield::set("dog_round_fog_bank", 0);
}

/*
	Name: function_5f1ef789
	Namespace: namespace_c402654
	Checksum: 0xC067A33D
	Offset: 0x19C8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_5f1ef789(var_d25bbdd5)
{
	level flag::clear("dog_round");
	level flag::clear("dog_clips");
	level thread zm_audio::sndmusicsystem_playstate("dog_end");
	zm::increment_dog_round_stat("finished");
	wait(5);
	level thread clientfield::set("dog_round_fog_bank", 0);
}

/*
	Name: play_dog_round
	Namespace: namespace_c402654
	Checksum: 0x103D20E3
	Offset: 0x1A80
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function play_dog_round()
{
	variation_count = 5;
	wait(4.5);
	players = getplayers();
	num = randomintrange(0, players.size);
	players[num] zm_audio::create_and_play_dialog(#"general", #"dog_spawn");
}

/*
	Name: dog_init
	Namespace: namespace_c402654
	Checksum: 0x85EC1CAA
	Offset: 0x1B18
	Size: 0x430
	Parameters: 0
	Flags: Linked
*/
function dog_init()
{
	self.targetname = "zombie_dog";
	self.script_noteworthy = undefined;
	self.animname = "zombie_dog";
	self val::set(#"dog_spawn", "ignoreall", 1);
	self val::set(#"dog_spawn", "ignoreme", 1);
	self.allowdeath = 1;
	self.allowpain = 0;
	self.force_gib = 1;
	self.is_zombie = 1;
	self.gibbed = 0;
	self.head_gibbed = 0;
	self.default_goalheight = 40;
	self.ignore_inert = 1;
	self.holdfire = 1;
	self.grenadeawareness = 0;
	self.badplaceawareness = 0;
	self.ignoresuppression = 1;
	self.suppressionthreshold = 1;
	self.nododgemove = 1;
	self.dontshootwhilemoving = 1;
	self.pathenemylookahead = 0;
	self.badplaceawareness = 0;
	self.chatinitialized = 0;
	self.team = level.zombie_team;
	self.heroweapon_kill_power = 2;
	self allowpitchangle(1);
	self setpitchorient();
	self setavoidancemask("avoid none");
	self collidewithactors(1);
	health_multiplier = getdvarfloat(#"scr_dog_health_walk_multiplier", 4);
	health_multiplier = health_multiplier * (isdefined(level.var_570d178a) ? level.var_570d178a : 1);
	self.maxhealth = int(level.dog_health * health_multiplier);
	self.health = int(level.dog_health * health_multiplier);
	self.freezegun_damage = 0;
	self.zombie_move_speed = "sprint";
	if(self.var_9fde8624 != #"zombie_wolf")
	{
		self.a.nodeath = 1;
	}
	self zm_score::function_82732ced();
	self thread dog_run_think();
	self thread dog_stalk_audio();
	self thread zombie_utility::round_spawn_failsafe();
	self ghost();
	self thread dog_death();
	level thread zm_spawner::zombie_death_event(self);
	self thread zm_audio::zmbaivox_notifyconvert();
	self zm_utility::disable_react();
	self cleargoalvolume();
	self.flame_damage_time = 0;
	self.thundergun_knockdown_func = &dog_thundergun_knockdown;
	/#
		self zm_spawner::zombie_history("" + self.origin);
	#/
	if(isdefined(level.achievement_monitor_func))
	{
		self [[level.achievement_monitor_func]]();
	}
}

/*
	Name: dog_death
	Namespace: namespace_c402654
	Checksum: 0xE0633BE7
	Offset: 0x1F50
	Size: 0x44E
	Parameters: 0
	Flags: Linked
*/
function dog_death()
{
	self waittill(#"death");
	if(zombie_utility::get_current_zombie_count() == 0 && level.zombie_total == 0)
	{
		level.last_dog_origin = self.origin;
		level notify(#"last_dog_down");
	}
	if(isplayer(self.attacker))
	{
		event = "death";
		if(!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given))
		{
			self.attacker zm_score::player_add_points(event, self.damagemod, self.damagelocation, self, self.team, self.damageweapon);
		}
		if(isdefined(level.hero_power_update))
		{
			[[level.hero_power_update]](self.attacker, self, event);
		}
		if(randomintrange(0, 100) >= 80)
		{
			self.attacker zm_audio::create_and_play_dialog(#"kill", #"hellhound");
		}
		self.attacker zm_stats::increment_client_stat("zdogs_killed");
		self.attacker zm_stats::increment_player_stat("zdogs_killed");
	}
	if(isdefined(self.attacker) && isai(self.attacker))
	{
		self.attacker notify(#"killed", {#victim:self});
	}
	if(!isdefined(self))
	{
		return;
	}
	self stoploopsound();
	if(self.var_9fde8624 != #"zombie_wolf" && (!(isdefined(self.a.nodeath) && self.a.nodeath)))
	{
		trace = groundtrace(self.origin + vectorscale((0, 0, 1), 10), self.origin - vectorscale((0, 0, 1), 30), 0, self);
		if(trace[#"fraction"] < 1)
		{
			pitch = acos(vectordot(trace[#"normal"], (0, 0, 1)));
			if(pitch > 10)
			{
				self.a.nodeath = 1;
			}
		}
	}
	if(self.var_9fde8624 != #"zombie_wolf" && isdefined(self.a.nodeath))
	{
		if(self.var_c39323b5 !== 1)
		{
			level thread dog_explode_fx(self, self.origin);
			self ghost();
			self notsolid();
			wait(1);
		}
		if(isdefined(self))
		{
			self delete();
		}
	}
	else
	{
		function_6eac4ca1(self, "death");
		self notify(#"bhtn_action_notify", {#action:"death"});
	}
}

/*
	Name: dog_explode_fx
	Namespace: namespace_c402654
	Checksum: 0xAF13756F
	Offset: 0x23A8
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function dog_explode_fx(dog, origin)
{
	dog clientfield::set("dog_fx", 0);
	pos = getclosestpointonnavmesh(origin, 500, 30);
	if(isdefined(pos))
	{
		playsoundatposition(#"zmb_hellhound_explode", origin);
	}
}

/*
	Name: zombie_setup_attack_properties_dog
	Namespace: namespace_c402654
	Checksum: 0xB32458CC
	Offset: 0x2440
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function zombie_setup_attack_properties_dog()
{
	/#
		self zm_spawner::zombie_history("");
	#/
	self thread dog_behind_audio();
	self val::reset(#"dog_spawn", "ignoreall");
	self val::reset(#"dog_spawn", "ignoreme");
	self.meleeattackdist = 64;
	self.disablearrivals = 1;
	self.disableexits = 1;
	if(isdefined(level.dog_setup_func))
	{
		self [[level.dog_setup_func]]();
	}
}

/*
	Name: stop_dog_sound_on_death
	Namespace: namespace_c402654
	Checksum: 0xBE367CCA
	Offset: 0x2520
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function stop_dog_sound_on_death()
{
	self waittill(#"death");
	if(isdefined(self))
	{
		self stopsounds();
	}
}

/*
	Name: dog_behind_audio
	Namespace: namespace_c402654
	Checksum: 0x9D853873
	Offset: 0x2560
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function dog_behind_audio()
{
	self thread stop_dog_sound_on_death();
	self endon(#"death");
	self waittill(#"dog_running", #"dog_combat");
	function_6eac4ca1(self, "close");
	self notify(#"bhtn_action_notify", {#action:"close"});
	wait(3);
	while(true)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			dogangle = angleclamp180(vectortoangles(self.origin - players[i].origin)[1] - players[i].angles[1]);
			if(isalive(players[i]) && !isdefined(players[i].revivetrigger))
			{
				if(abs(dogangle) > 90 && distance2d(self.origin, players[i].origin) > 100)
				{
					function_6eac4ca1(self, "close");
					self notify(#"bhtn_action_notify", {#action:"close"});
					wait(3);
				}
			}
		}
		wait(0.75);
	}
}

/*
	Name: dog_clip_monitor
	Namespace: namespace_c402654
	Checksum: 0x5630AD70
	Offset: 0x2798
	Size: 0x206
	Parameters: 0
	Flags: Linked
*/
function dog_clip_monitor()
{
	clips_on = 0;
	while(true)
	{
		for(i = 0; i < level.dog_clips.size; i++)
		{
			level.dog_clips[i] connectpaths();
		}
		level flag::wait_till("dog_clips");
		if(isdefined(level.no_dog_clip) && level.no_dog_clip == 1)
		{
			return;
		}
		for(i = 0; i < level.dog_clips.size; i++)
		{
			level.dog_clips[i] disconnectpaths();
			util::wait_network_frame();
		}
		while(dog_is_alive || level flag::get("dog_round"))
		{
			dog_is_alive = 0;
			dogs = getentarray("zombie_dog", "targetname");
			for(i = 0; i < dogs.size; i++)
			{
				if(isalive(dogs[i]))
				{
					dog_is_alive = 1;
				}
			}
			wait(1);
		}
		level flag::clear("dog_clips");
		wait(1);
	}
}

/*
	Name: dog_run_think
	Namespace: namespace_c402654
	Checksum: 0xDD8AE0D0
	Offset: 0x29A8
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function dog_run_think()
{
	self endon(#"death");
	self waittill(#"visible");
	if(self.health > level.dog_health)
	{
		self.maxhealth = level.dog_health;
		self.health = level.dog_health;
	}
	if(self.aitype !== "spawner_zm_wolf")
	{
		self clientfield::set("dog_fx", 1);
		self playloopsound(#"zmb_hellhound_loop_fire");
	}
	while(true)
	{
		if(!zm_utility::is_player_valid(self.favoriteenemy))
		{
			self.favoriteenemy = get_favorite_enemy();
		}
		if(isdefined(level.custom_dog_target_validity_check))
		{
			self [[level.custom_dog_target_validity_check]]();
		}
		wait(0.2);
	}
}

/*
	Name: dog_stalk_audio
	Namespace: namespace_c402654
	Checksum: 0x68846B40
	Offset: 0x2AD0
	Size: 0xA8
	Parameters: 0
	Flags: Linked
*/
function dog_stalk_audio()
{
	self endon(#"death", #"dog_running", #"dog_combat");
	while(true)
	{
		function_6eac4ca1(self, "ambient");
		self notify(#"bhtn_action_notify", {#action:"ambient"});
		wait(randomfloatrange(3, 6));
	}
}

/*
	Name: dog_thundergun_knockdown
	Namespace: namespace_c402654
	Checksum: 0x14582371
	Offset: 0x2B80
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function dog_thundergun_knockdown(player, gib)
{
	self endon(#"death");
	damage = int(self.maxhealth * 0.5);
	self dodamage(damage, player.origin, player);
}

/*
	Name: function_b168b424
	Namespace: namespace_c402654
	Checksum: 0xDA192A69
	Offset: 0x2C08
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_b168b424(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 25));
	if(level.round_number < 20)
	{
		var_23c888e1 = 0.02;
	}
	else if(level.round_number < 30)
	{
		var_23c888e1 = 0.03;
	}
	else
	{
		var_23c888e1 = 0.04;
	}
	return min(var_8cf00d40, int(ceil(level.zombie_total * var_23c888e1)));
}

/*
	Name: function_abc64f33
	Namespace: namespace_c402654
	Checksum: 0x7F9747C3
	Offset: 0x2CF8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_abc64f33()
{
	ai = function_62db7b1c();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return 1;
	}
	return 0;
}

/*
	Name: function_62db7b1c
	Namespace: namespace_c402654
	Checksum: 0xD5E55241
	Offset: 0x2D40
	Size: 0x900
	Parameters: 2
	Flags: Linked
*/
function function_62db7b1c(b_force_spawn = 0, var_eb3a8721)
{
	if(!b_force_spawn && !function_c1faf4d5())
	{
		return undefined;
	}
	e_target = function_a5abd591();
	if(!isdefined(e_target))
	{
		return undefined;
	}
	players = getplayers();
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else if(isdefined(level.dog_spawn_func))
	{
		s_spawn_loc = [[level.dog_spawn_func]]();
	}
	else if(level.zm_loc_types[#"dog_location"].size > 0)
	{
		var_5f3b05e8 = e_target zm_zonemgr::get_player_zone();
		if(!isdefined(var_5f3b05e8))
		{
			return undefined;
		}
		var_24f5d9f8 = [];
		if(!isdefined(var_24f5d9f8))
		{
			var_24f5d9f8 = [];
		}
		else if(!isarray(var_24f5d9f8))
		{
			var_24f5d9f8 = array(var_24f5d9f8);
		}
		if(!isinarray(var_24f5d9f8, var_5f3b05e8))
		{
			var_24f5d9f8[var_24f5d9f8.size] = var_5f3b05e8;
		}
		var_4cb112e = level.zones[var_5f3b05e8];
		adj_zone_names = getarraykeys(var_4cb112e.adjacent_zones);
		foreach(str_zone in adj_zone_names)
		{
			if(var_4cb112e.adjacent_zones[str_zone].is_connected)
			{
				if(!isdefined(var_24f5d9f8))
				{
					var_24f5d9f8 = [];
				}
				else if(!isarray(var_24f5d9f8))
				{
					var_24f5d9f8 = array(var_24f5d9f8);
				}
				if(!isinarray(var_24f5d9f8, level.zones[str_zone].name))
				{
					var_24f5d9f8[var_24f5d9f8.size] = level.zones[str_zone].name;
				}
				continue;
			}
			arrayremovevalue(adj_zone_names, level.zones[str_zone].name);
		}
		foreach(str_zone in adj_zone_names)
		{
			s_zone = level.zones[str_zone];
			var_dca08900 = getarraykeys(s_zone.adjacent_zones);
			foreach(str_adj_zone in var_dca08900)
			{
				if(s_zone.adjacent_zones[str_adj_zone].is_connected)
				{
					if(!isdefined(var_24f5d9f8))
					{
						var_24f5d9f8 = [];
					}
					else if(!isarray(var_24f5d9f8))
					{
						var_24f5d9f8 = array(var_24f5d9f8);
					}
					if(!isinarray(var_24f5d9f8, level.zones[str_adj_zone].name))
					{
						var_24f5d9f8[var_24f5d9f8.size] = level.zones[str_adj_zone].name;
					}
				}
			}
		}
		var_5adfb389 = struct::get_array("dog_location", "script_noteworthy");
		var_5adfb389 = arraysortclosest(var_5adfb389, e_target.origin, undefined, 1024);
		var_e99dec8e = [];
		var_22b984bd = [];
		foreach(v_loc in var_5adfb389)
		{
			if(isinarray(var_24f5d9f8, v_loc.zone_name))
			{
				var_a46b11c1 = distancesquared(v_loc.origin, e_target.origin);
				if(173056 < var_a46b11c1 && var_a46b11c1 < 376996)
				{
					if(!isdefined(var_e99dec8e))
					{
						var_e99dec8e = [];
					}
					else if(!isarray(var_e99dec8e))
					{
						var_e99dec8e = array(var_e99dec8e);
					}
					var_e99dec8e[var_e99dec8e.size] = v_loc;
					continue;
				}
				if(var_a46b11c1 > 376996)
				{
					if(!isdefined(var_22b984bd))
					{
						var_22b984bd = [];
					}
					else if(!isarray(var_22b984bd))
					{
						var_22b984bd = array(var_22b984bd);
					}
					var_22b984bd[var_22b984bd.size] = v_loc;
				}
			}
		}
		if(var_e99dec8e.size < 6)
		{
			var_22b984bd = arraysort(var_22b984bd, e_target.origin, 1);
			n_spawns_needed = 6 - var_e99dec8e.size;
			for(i = 0; i < n_spawns_needed; i++)
			{
				if(!isdefined(var_e99dec8e))
				{
					var_e99dec8e = [];
				}
				else if(!isarray(var_e99dec8e))
				{
					var_e99dec8e = array(var_e99dec8e);
				}
				var_e99dec8e[var_e99dec8e.size] = var_22b984bd[i];
			}
		}
		if(var_e99dec8e.size < 1 && level.zm_loc_types[#"dog_location"].size > 0)
		{
			var_e99dec8e = arraycopy(level.zm_loc_types[#"dog_location"]);
		}
		s_spawn_loc = array::random(var_e99dec8e);
	}
	if(!isdefined(s_spawn_loc))
	{
		return undefined;
	}
	ai = zombie_utility::spawn_zombie(level.dog_spawners[0]);
	if(isdefined(ai))
	{
		ai.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		ai thread zombie_utility::round_spawn_failsafe();
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_6189feaf))
		{
			ai thread [[level.var_6189feaf]](s_spawn_loc);
		}
		else
		{
			s_spawn_loc thread dog_spawn_fx(ai, s_spawn_loc);
		}
		s_spawn_loc.var_d51f4e2d = gettime();
		ai.favoriteenemy = e_target;
		ai.favoriteenemy.hunted_by++;
		ai.favoriteenemy.var_230becc2++;
	}
	return ai;
}

/*
	Name: function_c1faf4d5
	Namespace: namespace_c402654
	Checksum: 0xC891F5BC
	Offset: 0x3648
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_c1faf4d5()
{
	var_d881b102 = function_bb101706();
	var_672d3c4 = function_71e3c90d();
	if(!(isdefined(level.var_2b94ce72) && level.var_2b94ce72) && (isdefined(level.var_15747fb1) && level.var_15747fb1 || var_d881b102 >= var_672d3c4))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_71e3c90d
	Namespace: namespace_c402654
	Checksum: 0x42208EF5
	Offset: 0x36E8
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function function_71e3c90d()
{
	switch(level.players.size)
	{
		case 1:
		{
			if(zm_utility::function_3bff983f())
			{
				return 6;
			}
			return 3;
		}
		case 2:
		{
			if(zm_utility::function_3bff983f())
			{
				return 10;
			}
			return 5;
		}
		case 3:
		{
			if(zm_utility::function_3bff983f())
			{
				return 14;
			}
			return 7;
		}
		case 4:
		{
			if(zm_utility::function_3bff983f())
			{
				return 20;
			}
			return 10;
		}
	}
}

/*
	Name: function_bb101706
	Namespace: namespace_c402654
	Checksum: 0xF9FC6F0C
	Offset: 0x37D8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_bb101706()
{
	var_cbfe0149 = getaiarchetypearray(#"zombie_dog");
	var_d881b102 = var_cbfe0149.size;
	foreach(ai_dog in var_cbfe0149)
	{
		if(!isalive(ai_dog))
		{
			var_d881b102--;
		}
	}
	return var_d881b102;
}

