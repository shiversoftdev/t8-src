// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5a63672f07149a55;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace spawning;

/*
	Name: function_89f2df9
	Namespace: spawning
	Checksum: 0x23D53D98
	Offset: 0x220
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"spawning_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: spawning
	Checksum: 0xAB0E1C76
	Offset: 0x268
	Size: 0x3AC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level init_spawn_system();
	level.spawnprotectiontime = getgametypesetting(#"spawnprotectiontime");
	level.spawnprotectiontimems = int(int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000));
	level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");
	level.var_f220c297 = getgametypesetting(#"hash_19400c3e10b77e6b");
	level.var_c2cc011f = getgametypesetting(#"hash_4bdd1bd86b610871");
	level.players = [];
	level.numplayerswaitingtoenterkillcam = 0;
	if(!isdefined(level.requirespawnpointstoexistinlevel))
	{
		level.requirespawnpointstoexistinlevel = 1;
	}
	level.convert_spawns_to_structs = getdvarint(#"spawnsystem_convert_spawns_to_structs", 0);
	level.spawnmins = (0, 0, 0);
	level.spawnmaxs = (0, 0, 0);
	level.spawnminsmaxsprimed = 0;
	if(!isdefined(level.default_spawn_lists))
	{
		level.default_spawn_lists = [];
	}
	if(!isdefined(level.default_spawn_lists))
	{
		level.default_spawn_lists = [];
	}
	else if(!isarray(level.default_spawn_lists))
	{
		level.default_spawn_lists = array(level.default_spawn_lists);
	}
	level.default_spawn_lists[level.default_spawn_lists.size] = "normal";
	foreach(team, _ in level.teams)
	{
		level.teamspawnpoints[team] = [];
		level.spawn_point_team_class_names[team] = [];
	}
	callback::on_spawned(&on_player_spawned);
	callback::on_laststand(&on_player_laststand);
	callback::on_revived(&on_player_revived);
	callback::on_player_killed(&on_player_killed);
	level thread update_spawn_points();
	level thread update_explored_spawn_points();
	/#
		level.spawnpoint_triggers = [];
		level thread spawnpoint_debug();
	#/
}

/*
	Name: add_default_spawnlist
	Namespace: spawning
	Checksum: 0x8604628C
	Offset: 0x620
	Size: 0x92
	Parameters: 1
	Flags: None
*/
function add_default_spawnlist(spawnlist)
{
	if(!isdefined(level.default_spawn_lists))
	{
		level.default_spawn_lists = [];
	}
	else if(!isarray(level.default_spawn_lists))
	{
		level.default_spawn_lists = array(level.default_spawn_lists);
	}
	level.default_spawn_lists[level.default_spawn_lists.size] = spawnlist;
}

/*
	Name: on_player_spawned
	Namespace: spawning
	Checksum: 0xD4BBF3
	Offset: 0x6C0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	if(!self flag::exists("spawn_exploration_active"))
	{
		self flag::init("spawn_exploration_active", 1);
	}
	self flag::set("spawn_exploration_active");
}

/*
	Name: on_player_laststand
	Namespace: spawning
	Checksum: 0xE9A93D42
	Offset: 0x730
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function on_player_laststand()
{
	if(self flag::exists("spawn_exploration_active"))
	{
		self flag::clear("spawn_exploration_active");
	}
}

/*
	Name: on_player_revived
	Namespace: spawning
	Checksum: 0x84EBFC0B
	Offset: 0x780
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function on_player_revived(params)
{
	if(self flag::exists("spawn_exploration_active"))
	{
		self flag::set("spawn_exploration_active");
	}
}

/*
	Name: on_player_killed
	Namespace: spawning
	Checksum: 0x6E007186
	Offset: 0x7D8
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function on_player_killed()
{
	if(self flag::exists("spawn_exploration_active"))
	{
		self flag::clear("spawn_exploration_active");
	}
}

/*
	Name: init_spawn_system
	Namespace: spawning
	Checksum: 0xD3DD2709
	Offset: 0x828
	Size: 0x124
	Parameters: 0
	Flags: Private
*/
private function init_spawn_system()
{
	level.spawnsystem = spawnstruct();
	spawnsystem = level.spawnsystem;
	if(!isdefined(spawnsystem.var_3709dc53))
	{
		spawnsystem.var_3709dc53 = 1;
	}
	spawnsystem.objective_facing_bonus = 0;
	spawnsystem.ispawn_teammask = [];
	spawnsystem.ispawn_teammask_free = 1;
	spawnsystem.ispawn_teammask_free = 1;
	spawnsystem.ispawn_teammask[#"free"] = spawnsystem.ispawn_teammask_free;
	spawnsystem.ispawn_teammask[#"neutral"] = spawnsystem.var_146943ea;
	function_44c8af7f();
	callback::add_callback(#"hash_79b2aab11c0a9902", &function_44c8af7f);
}

/*
	Name: function_44c8af7f
	Namespace: spawning
	Checksum: 0x242C617
	Offset: 0x958
	Size: 0x122
	Parameters: 0
	Flags: None
*/
function function_44c8af7f()
{
	spawnsystem = level.spawnsystem;
	all = spawnsystem.ispawn_teammask_free;
	count = 1;
	if(!isdefined(level.teams))
	{
		level.teams = [];
	}
	foreach(team, _ in level.teams)
	{
		spawnsystem.ispawn_teammask[team] = 1 << count;
		all = all | spawnsystem.ispawn_teammask[team];
		count++;
	}
	spawnsystem.ispawn_teammask[#"all"] = all;
}

/*
	Name: updateallspawnpoints
	Namespace: spawning
	Checksum: 0x8326D6DE
	Offset: 0xA88
	Size: 0x198
	Parameters: 0
	Flags: None
*/
function updateallspawnpoints()
{
	clearspawnpoints("normal");
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			addspawnpoints(team, level.teamspawnpoints[team], "normal");
			enablespawnpointlist("normal", util::getteammask(team));
		}
	}
	else
	{
		foreach(team, _ in level.teams)
		{
			addspawnpoints("free", level.teamspawnpoints[team], "normal");
			enablespawnpointlist("normal", util::getteammask(team));
		}
	}
}

/*
	Name: update_fallback_spawnpoints
	Namespace: spawning
	Checksum: 0xBB7081D7
	Offset: 0xC28
	Size: 0x148
	Parameters: 0
	Flags: None
*/
function update_fallback_spawnpoints()
{
	clearspawnpoints("fallback");
	if(!isdefined(level.player_fallback_points))
	{
		return;
	}
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			addspawnpoints(team, level.player_fallback_points[team], "fallback");
		}
	}
	else
	{
		foreach(team, _ in level.teams)
		{
			addspawnpoints("free", level.player_fallback_points[team], "fallback");
		}
	}
}

/*
	Name: add_fallback_spawnpoints
	Namespace: spawning
	Checksum: 0x6C813C13
	Offset: 0xD78
	Size: 0x1C4
	Parameters: 2
	Flags: None
*/
function add_fallback_spawnpoints(team, point_class)
{
	if(!isdefined(level.player_fallback_points))
	{
		level.player_fallback_points = [];
		foreach(level_team, _ in level.teams)
		{
			level.player_fallback_points[level_team] = [];
		}
	}
	add_spawn_point_classname(point_class);
	spawnpoints = get_spawnpoint_array(point_class);
	for(i = spawnpoints.size - 1; i >= 0; i--)
	{
		if(!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects))
		{
			spawnpoints[i] = undefined;
		}
	}
	arrayremovevalue(spawnpoints, undefined);
	str_team = util::get_team_mapping(team);
	level.player_fallback_points[str_team] = spawnpoints;
	enablespawnpointlist("fallback", util::getteammask(str_team));
}

/*
	Name: function_1bc642b7
	Namespace: spawning
	Checksum: 0x9F5A18AF
	Offset: 0xF48
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function function_1bc642b7()
{
	if(game.switchedsides == 0)
	{
		return 0;
	}
	if(level.spawnsystem.var_3709dc53 == 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: add_start_spawn_points
	Namespace: spawning
	Checksum: 0xD8A832DA
	Offset: 0xF90
	Size: 0x10E
	Parameters: 2
	Flags: None
*/
function add_start_spawn_points(str_team, classname)
{
	str_team = util::get_team_mapping(str_team);
	if(!isdefined(level.spawn_start))
	{
		level.spawn_start = [];
	}
	if(!isdefined(level.spawn_start[str_team]))
	{
		level.spawn_start[str_team] = [];
	}
	spawnpoints = get_spawnpoint_array(classname);
	teamforspawns = (function_1bc642b7() ? util::getotherteam(str_team) : str_team);
	level.spawn_start[str_team] = arraycombine(level.spawn_start[str_team], spawnpoints, 0, 0);
}

/*
	Name: is_spawn_trapped
	Namespace: spawning
	Checksum: 0xFF5A858A
	Offset: 0x10A8
	Size: 0xD2
	Parameters: 1
	Flags: Private
*/
private function is_spawn_trapped(team)
{
	/#
		level.spawntraptriggertime = getgametypesetting(#"spawntraptriggertime");
	#/
	if(!level.rankedmatch)
	{
		return 0;
	}
	if(isdefined(level.alivetimesaverage) && isdefined(level.alivetimesaverage[team]) && level.alivetimesaverage[team] != 0 && level.alivetimesaverage[team] < int(level.spawntraptriggertime * 1000))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e1a7c3d9
	Namespace: spawning
	Checksum: 0x312E0991
	Offset: 0x1188
	Size: 0x5E
	Parameters: 2
	Flags: Private
*/
private function function_e1a7c3d9(spawn_origin, spawn_angles)
{
	self predictspawnpoint(spawn_origin, spawn_angles);
	self.predicted_spawn_point = {#angles:spawn_angles, #origin:spawn_origin};
}

/*
	Name: use_start_spawns
	Namespace: spawning
	Checksum: 0x303AF7B7
	Offset: 0x11F0
	Size: 0x172
	Parameters: 1
	Flags: Private
*/
private function use_start_spawns(predictedspawn)
{
	if(isdefined(level.alwaysusestartspawns) && level.alwaysusestartspawns)
	{
		return 1;
	}
	if(!(isdefined(level.usestartspawns) && level.usestartspawns))
	{
		return 0;
	}
	if(level.teambased)
	{
		spawnteam = self.pers[#"team"];
		if(level.aliveplayers[spawnteam].size + level.spawningplayers[self.team].size >= level.spawn_start[spawnteam].size)
		{
			if(!predictedspawn)
			{
				level.usestartspawns = 0;
			}
			return 0;
		}
	}
	else if(isdefined(level.spawn_start[#"free"]) && level.aliveplayers[#"free"].size + level.spawningplayers[#"free"].size >= level.spawn_start[#"free"].size)
	{
		if(!predictedspawn)
		{
			level.usestartspawns = 0;
		}
		return 0;
	}
	return 1;
}

/*
	Name: onspawnplayer
	Namespace: spawning
	Checksum: 0x2D1B761B
	Offset: 0x1370
	Size: 0x45C
	Parameters: 1
	Flags: None
*/
function onspawnplayer(predictedspawn = 0)
{
	spawnoverride = self tacticalinsertion::overridespawn(predictedspawn);
	spawnresurrect = 0;
	if(isdefined(level.resurrect_override_spawn))
	{
		spawnresurrect = self [[level.resurrect_override_spawn]](predictedspawn);
	}
	/#
		if(isdefined(self.devguilockspawn) && self.devguilockspawn)
		{
			spawnresurrect = 1;
		}
	#/
	spawn_origin = undefined;
	spawn_angles = undefined;
	if(spawnresurrect)
	{
		spawn_origin = self.resurrect_origin;
		spawn_angles = self.resurrect_angles;
	}
	else if(spawnoverride)
	{
		if(predictedspawn && isdefined(self.tacticalinsertion))
		{
			self function_e1a7c3d9(self.tacticalinsertion.origin, self.tacticalinsertion.angles);
		}
		return;
	}
	if(self use_start_spawns(predictedspawn))
	{
		spawnpoint = undefined;
		if(!predictedspawn)
		{
			if(level.teambased)
			{
				array::add(level.spawningplayers[self.team], self);
			}
			else
			{
				array::add(level.spawningplayers[#"free"], self);
			}
		}
		if(level.teambased)
		{
			spawnteam = self.pers[#"team"];
			if(game.switchedsides && level.spawnsystem.var_3709dc53)
			{
				spawnteam = util::getotherteam(spawnteam);
			}
			var_c162f039 = undefined;
			if(isdefined(level.var_b8622956))
			{
				var_c162f039 = self [[level.var_b8622956]](level.spawn_start[spawnteam]);
			}
			if(!isdefined(var_c162f039) || !var_c162f039.size)
			{
				var_c162f039 = level.spawn_start[spawnteam];
			}
			spawnpoint = get_spawnpoint_random(var_c162f039, predictedspawn);
		}
		else
		{
			spawnpoint = get_spawnpoint_random(level.spawn_start[#"free"], predictedspawn);
		}
		if(isdefined(spawnpoint))
		{
			spawn_origin = spawnpoint.origin;
			spawn_angles = spawnpoint.angles;
		}
	}
	else
	{
		spawn_point = getspawnpoint(self, predictedspawn);
		if(isdefined(spawn_point))
		{
			spawn_origin = spawn_point[#"origin"];
			spawn_angles = spawn_point[#"angles"];
		}
	}
	if(!isdefined(spawn_origin))
	{
		/#
			println("");
		#/
		callback::abort_level();
	}
	if(predictedspawn)
	{
		self function_e1a7c3d9(spawn_origin, spawn_angles);
	}
	else
	{
		self spawn(spawn_origin, spawn_angles);
		self.lastspawntime = gettime();
		if(!flag::exists("spawn_exploration_active"))
		{
			self flag::init("spawn_exploration_active", 1);
		}
		if(!spawnresurrect && !spawnoverride)
		{
			influencers::create_player_spawn_influencers(spawn_origin);
		}
	}
}

/*
	Name: getspawnpoint
	Namespace: spawning
	Checksum: 0x7B6C9612
	Offset: 0x17D8
	Size: 0x1CE
	Parameters: 2
	Flags: Private
*/
private function getspawnpoint(player_entity, predictedspawn = 0)
{
	if(function_f99d2668())
	{
		point_team = "free";
		influencer_team = player_entity.pers[#"team"];
	}
	else if(level.teambased)
	{
		point_team = player_entity.pers[#"team"];
		influencer_team = player_entity.pers[#"team"];
	}
	else
	{
		point_team = "free";
		influencer_team = "free";
	}
	if(level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53)
	{
		point_team = util::getotherteam(point_team);
	}
	use_fallback_points = 0;
	spawn_trapped = is_spawn_trapped(point_team);
	if(spawn_trapped)
	{
		use_fallback_points = 1;
	}
	best_spawn = get_best_spawnpoint(point_team, influencer_team, player_entity, predictedspawn, use_fallback_points);
	if(!predictedspawn)
	{
		player_entity.last_spawn_origin = best_spawn[#"origin"];
	}
	return best_spawn;
}

/*
	Name: get_best_spawnpoint
	Namespace: spawning
	Checksum: 0xA147197C
	Offset: 0x19B0
	Size: 0x450
	Parameters: 5
	Flags: None
*/
function get_best_spawnpoint(point_team, influencer_team, player, predictedspawn, use_fallback_points)
{
	if(level.teambased)
	{
		vis_team_mask = util::getotherteamsmask(player.pers[#"team"]);
	}
	else
	{
		vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
	}
	lists = [];
	if(isdefined(level.var_811300ad) && level.var_811300ad.size)
	{
		lists = function_a782529(player);
	}
	if(!lists.size)
	{
		foreach(spawnlist in level.default_spawn_lists)
		{
			if(!isdefined(lists))
			{
				lists = [];
			}
			else if(!isarray(lists))
			{
				lists = array(lists);
			}
			lists[lists.size] = spawnlist;
		}
		if(use_fallback_points)
		{
			if(!isdefined(lists))
			{
				lists = [];
			}
			else if(!isarray(lists))
			{
				lists = array(lists);
			}
			lists[lists.size] = "fallback";
		}
	}
	spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, lists);
	/#
		/#
			assert(isdefined(spawn_point), "");
		#/
	#/
	if(!isdefined(spawn_point))
	{
		spawn_point = getbestspawnpoint(point_team, influencer_team, vis_team_mask, player, predictedspawn, level.default_spawn_lists);
		/#
			/#
				assert(isdefined(spawn_point), "");
			#/
		#/
		if(!isdefined(spawn_point))
		{
			spawn_point = [];
			spawn_point[#"origin"] = (0, 0, 0);
			spawn_point[#"angles"] = (0, 0, 0);
		}
	}
	if(!predictedspawn)
	{
		var_c1c41f09 = 0;
		if(isdefined(level.var_abb55703))
		{
			var_c1c41f09 = [[level.var_abb55703]](player);
		}
		if(sessionmodeismultiplayergame())
		{
			mpspawnpointsused = {#hash_50641dd5:var_c1c41f09, #z:spawn_point[#"origin"][2], #y:spawn_point[#"origin"][1], #x:spawn_point[#"origin"][0], #hash_c734ddf2:getplayerspawnid(player), #reason:"point used"};
			function_92d1707f(#"hash_608dde355fff78f5", mpspawnpointsused);
		}
	}
	return spawn_point;
}

/*
	Name: spawn_point_class_name_being_used
	Namespace: spawning
	Checksum: 0xD8B787F4
	Offset: 0x1E08
	Size: 0x46
	Parameters: 1
	Flags: Private
*/
private function spawn_point_class_name_being_used(name)
{
	if(!isdefined(level.spawn_point_class_names))
	{
		return 0;
	}
	if(isinarray(level.spawn_point_class_names, name))
	{
		return 1;
	}
	return 0;
}

/*
	Name: codecallback_updatespawnpoints
	Namespace: spawning
	Checksum: 0x4DD29DE8
	Offset: 0x1E58
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event codecallback_updatespawnpoints(eventstruct)
{
	foreach(team, _ in level.teams)
	{
		rebuild_spawn_points(team);
	}
	updateallspawnpoints();
}

/*
	Name: add_spawn_points_internal
	Namespace: spawning
	Checksum: 0x944424A8
	Offset: 0x1F00
	Size: 0x25E
	Parameters: 3
	Flags: Private
*/
private function add_spawn_points_internal(team, spawnpoints, list = 0)
{
	oldspawnpoints = [];
	if(level.teamspawnpoints[team].size)
	{
		oldspawnpoints = level.teamspawnpoints[team];
	}
	for(i = spawnpoints.size - 1; i >= 0; i--)
	{
		if(!gameobjects::entity_is_allowed(spawnpoints[i], level.allowedgameobjects))
		{
			spawnpoints[i] = undefined;
		}
	}
	arrayremovevalue(spawnpoints, undefined);
	level.teamspawnpoints[team] = spawnpoints;
	if(!isdefined(level.spawnpoints))
	{
		level.spawnpoints = [];
	}
	for(index = 0; index < level.teamspawnpoints[team].size; index++)
	{
		spawnpoint = level.teamspawnpoints[team][index];
		if(!isdefined(spawnpoint.inited))
		{
			spawnpoint spawnpoint_init();
		}
		array::add(level.spawnpoints, spawnpoint, 0);
	}
	for(index = 0; index < oldspawnpoints.size; index++)
	{
		origin = oldspawnpoints[index].origin;
		level.spawnmins = math::expand_mins(level.spawnmins, origin);
		level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
		array::add(level.teamspawnpoints[team], oldspawnpoints[index]);
	}
}

/*
	Name: clear_and_add_spawn_points
	Namespace: spawning
	Checksum: 0x2670E03A
	Offset: 0x2168
	Size: 0x238
	Parameters: 3
	Flags: Variadic
*/
function clear_and_add_spawn_points(str_team, classnames, vararg)
{
	str_team = util::get_team_mapping(str_team);
	/#
		assert(vararg.size % 2 == 0, "");
	#/
	clear_spawn_points();
	team_array = array(str_team);
	classnames_array = array(classnames);
	for(index = 0; index < vararg.size; index++)
	{
		if(index % 2 == 0)
		{
			if(!isdefined(team_array))
			{
				team_array = [];
			}
			else if(!isarray(team_array))
			{
				team_array = array(team_array);
			}
			team_array[team_array.size] = util::get_team_mapping(vararg[index]);
			continue;
		}
		if(!isdefined(classnames_array))
		{
			classnames_array = [];
		}
		else if(!isarray(classnames_array))
		{
			classnames_array = array(classnames_array);
		}
		classnames_array[classnames_array.size] = vararg[index];
	}
	for(team_index = 0; team_index < team_array.size; team_index++)
	{
		for(classname_index = 0; classname_index < classnames_array[team_index].size; classname_index++)
		{
			add_spawn_points(team_array[team_index], classnames_array[team_index][classname_index]);
		}
	}
}

/*
	Name: clear_spawn_points
	Namespace: spawning
	Checksum: 0xB57CD51F
	Offset: 0x23A8
	Size: 0xB2
	Parameters: 0
	Flags: None
*/
function clear_spawn_points()
{
	foreach(team, _ in level.teams)
	{
		level.teamspawnpoints[team] = [];
		level.spawn_start[team] = [];
		level.spawn_point_team_class_names[team] = [];
	}
	level.spawnpoints = [];
}

/*
	Name: update_spawn_points
	Namespace: spawning
	Checksum: 0x4B0916EC
	Offset: 0x2468
	Size: 0xE6
	Parameters: 0
	Flags: Private
*/
private function update_spawn_points()
{
	while(true)
	{
		level flagsys::wait_till("spawnpoints_dirty");
		foreach(team, _ in level.teams)
		{
			rebuild_spawn_points(team);
		}
		updateallspawnpoints();
		level flagsys::clear(#"spawnpoints_dirty");
		waitframe(1);
	}
}

/*
	Name: update_explored_spawn_points
	Namespace: spawning
	Checksum: 0xCB30AE4A
	Offset: 0x2558
	Size: 0x100
	Parameters: 0
	Flags: Private
*/
private function update_explored_spawn_points()
{
	level flagsys::wait_till("spawn_point_exploration_enabled");
	explored_radius = getdvarfloat(#"spawnsystem_player_explored_radius", 0);
	explored_radius_sq = explored_radius * explored_radius;
	foreach(team, _ in level.teams)
	{
		level thread update_explored_start_spawn_points_for_team(team);
		level thread update_explored_spawn_points_for_team(team, explored_radius_sq);
	}
}

/*
	Name: update_explored_start_spawn_points_for_team
	Namespace: spawning
	Checksum: 0x898E86A1
	Offset: 0x2660
	Size: 0x250
	Parameters: 1
	Flags: Private
*/
private function update_explored_start_spawn_points_for_team(team)
{
	level notify("update_explored_start_spawn_points_for_team" + string(team));
	level endon("update_explored_start_spawn_points_for_team" + string(team));
	while(true)
	{
		if(!isdefined(level.spawn_start[team]))
		{
			wait(0.5);
			continue;
		}
		players = getplayers();
		allplayersspawned = 0;
		if(players.size >= getdvarint(#"com_maxclients", 0))
		{
			allplayersspawned = 1;
		}
		foreach(spawnpoint in level.spawn_start[team])
		{
			if(!isdefined(spawnpoint.explored))
			{
				spawnpoint.explored = 0;
			}
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(player.team === team)
				{
					set_player_explored_spawn_point(spawnpoint, player);
					continue;
				}
				clear_spawn_point_explored_for_player(spawnpoint, player);
			}
			spawn_exploration_wait_for_one_frame();
		}
		if(allplayersspawned)
		{
			break;
		}
		wait(0.5);
	}
}

/*
	Name: update_explored_spawn_points_for_team
	Namespace: spawning
	Checksum: 0x1FB12BA4
	Offset: 0x28B8
	Size: 0x252
	Parameters: 2
	Flags: Private
*/
private function update_explored_spawn_points_for_team(team, explored_radius_sq)
{
	level notify("update_explored_spawn_points_for_team" + string(team));
	level endon("update_explored_spawn_points_for_team" + string(team));
	while(true)
	{
		if(!isdefined(level.teamspawnpoints[team]))
		{
			wait(1);
			continue;
		}
		players = getplayers();
		foreach(spawnpoint in level.teamspawnpoints[team])
		{
			if(!isdefined(spawnpoint.explored))
			{
				spawnpoint.explored = 0;
			}
			foreach(player in players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(!should_update_exploration_for_player(spawnpoint, player))
				{
					continue;
				}
				if(abs(player.origin[2] - spawnpoint.origin[2]) < 100 && distancesquared(spawnpoint.origin, player.origin) <= explored_radius_sq)
				{
					set_player_explored_spawn_point(spawnpoint, player);
				}
			}
			spawn_exploration_wait_for_one_frame();
		}
		wait(1);
	}
}

/*
	Name: should_update_exploration_for_player
	Namespace: spawning
	Checksum: 0xF183D37E
	Offset: 0x2B18
	Size: 0xAE
	Parameters: 2
	Flags: Private
*/
private function should_update_exploration_for_player(spawnpoint, player)
{
	if(!player flag::exists("spawn_exploration_active"))
	{
		return 0;
	}
	if(!player flag::get("spawn_exploration_active") || player isplayinganimscripted() || player.sessionstate != "playing")
	{
		return 0;
	}
	if(has_player_explored_spawn_point(spawnpoint, player))
	{
		return 0;
	}
	return 1;
}

/*
	Name: spawn_exploration_wait_for_one_frame
	Namespace: spawning
	Checksum: 0x2181D1B
	Offset: 0x2BD0
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function spawn_exploration_wait_for_one_frame()
{
	waitframe(1);
}

/*
	Name: has_player_explored_spawn_point
	Namespace: spawning
	Checksum: 0x6DE68A8C
	Offset: 0x2BE8
	Size: 0x36
	Parameters: 2
	Flags: Private
*/
private function has_player_explored_spawn_point(spawnpoint, player)
{
	return spawnpoint.explored & 1 << player getentitynumber();
}

/*
	Name: set_player_explored_spawn_point
	Namespace: spawning
	Checksum: 0x70E18CC7
	Offset: 0x2C28
	Size: 0x8A
	Parameters: 2
	Flags: Private
*/
private function set_player_explored_spawn_point(spawnpoint, player)
{
	spawnpoint.explored = spawnpoint.explored | 1 << player getentitynumber();
	if(isdefined(player.companion))
	{
		spawnpoint.explored = spawnpoint.explored | 1 << player.companion getentitynumber();
	}
}

/*
	Name: clear_all_spawn_point_explored
	Namespace: spawning
	Checksum: 0x847CF70F
	Offset: 0x2CC0
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function clear_all_spawn_point_explored()
{
	foreach(team, _ in level.teams)
	{
		foreach(spawnpoint in level.teamspawnpoints[team])
		{
			spawnpoint.explored = 0;
		}
	}
}

/*
	Name: clear_spawn_point_explored_for_player
	Namespace: spawning
	Checksum: 0xA7CF914C
	Offset: 0x2DA8
	Size: 0x9A
	Parameters: 2
	Flags: None
*/
function clear_spawn_point_explored_for_player(spawnpoint, player)
{
	if(isdefined(spawnpoint.explored))
	{
		~spawnpoint;
		spawnpoint.explored = spawnpoint.explored & 1 << player getentitynumber();
	}
	if(isdefined(player.companion))
	{
		~player;
		spawnpoint.explored = spawnpoint.explored & 1 << player.companion getentitynumber();
	}
}

/*
	Name: enable_spawn_point_exploration
	Namespace: spawning
	Checksum: 0x80389699
	Offset: 0x2E50
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function enable_spawn_point_exploration()
{
	level flagsys::set(#"spawn_point_exploration_enabled");
}

/*
	Name: disable_spawn_point_exploration
	Namespace: spawning
	Checksum: 0xDD53D7BC
	Offset: 0x2E80
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function disable_spawn_point_exploration(clear = 1)
{
	level flagsys::clear(#"spawn_point_exploration_enabled");
	if(isdefined(clear) && clear)
	{
		clear_all_spawn_point_explored();
	}
}

/*
	Name: set_spawn_point_exploration_radius
	Namespace: spawning
	Checksum: 0x4C191EDC
	Offset: 0x2EF0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function set_spawn_point_exploration_radius(radius)
{
	setdvar(#"spawnsystem_player_explored_radius", radius);
}

/*
	Name: add_spawn_points
	Namespace: spawning
	Checksum: 0x45429023
	Offset: 0x2F28
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function add_spawn_points(team, spawnpointname)
{
	team = util::get_team_mapping(team);
	add_spawn_point_classname(spawnpointname);
	add_spawn_point_team_classname(team, spawnpointname);
	enabled_spawn_points = setup_trigger_enabled_spawn_points(get_spawnpoint_array(spawnpointname, 1));
	enabled_spawn_points = remove_disabled_on_start_spawn_points(enabled_spawn_points);
	add_spawn_points_internal(team, enabled_spawn_points);
	level flagsys::set(#"spawnpoints_dirty");
}

/*
	Name: remove_disabled_on_start_spawn_points
	Namespace: spawning
	Checksum: 0x42A2FDE0
	Offset: 0x3018
	Size: 0x172
	Parameters: 1
	Flags: Private
*/
private function remove_disabled_on_start_spawn_points(spawn_points)
{
	disable_spawn_points = [];
	foreach(spawn_point in spawn_points)
	{
		if(isdefined(spawn_point.script_start_disabled) && spawn_point.script_start_disabled)
		{
			if(getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0)
			{
				spawn_point.disabled = 1;
				if(!isdefined(disable_spawn_points))
				{
					disable_spawn_points = [];
				}
				else if(!isarray(disable_spawn_points))
				{
					disable_spawn_points = array(disable_spawn_points);
				}
				disable_spawn_points[disable_spawn_points.size] = spawn_point;
			}
			spawn_point.var_dbb9d994 = 0;
			spawn_point function_8807475c();
		}
	}
	enabled_spawn_points = array::exclude(spawn_points, disable_spawn_points);
	return enabled_spawn_points;
}

/*
	Name: setup_trigger_enabled_spawn_points
	Namespace: spawning
	Checksum: 0xA40E5332
	Offset: 0x3198
	Size: 0x330
	Parameters: 1
	Flags: Private
*/
private function setup_trigger_enabled_spawn_points(spawn_points)
{
	enabled_spawn_points = [];
	foreach(spawn_point in spawn_points)
	{
		if(isdefined(spawn_point.script_spawn_disable))
		{
			triggers = getentarray(spawn_point.script_spawn_disable, "script_spawn_disable", 1);
			foreach(trig in triggers)
			{
				if(!isdefined(trig.spawn_points_to_disable))
				{
					trig.spawnpoints_enabled = 1;
					trig.spawn_points_to_disable = [];
					trig thread _disable_spawn_points();
				}
				array::add(trig.spawn_points_to_disable, spawn_point, 0);
				spawn_point.disabled = undefined;
				/#
					array::add(level.spawnpoint_triggers, trig, 0);
				#/
			}
		}
		if(isdefined(spawn_point.script_spawn_enable))
		{
			triggers = getentarray(spawn_point.script_spawn_enable, "script_spawn_enable", 1);
			foreach(trig in triggers)
			{
				if(!isdefined(trig.spawn_points_to_enable))
				{
					trig.spawnpoints_enabled = undefined;
					trig.spawn_points_to_enable = [];
					trig thread _enable_spawn_points();
				}
				array::add(trig.spawn_points_to_enable, spawn_point, 0);
				/#
					array::add(level.spawnpoint_triggers, trig, 0);
				#/
			}
		}
		if(!(isdefined(spawn_point.disabled) && spawn_point.disabled))
		{
			if(!isdefined(enabled_spawn_points))
			{
				enabled_spawn_points = [];
			}
			else if(!isarray(enabled_spawn_points))
			{
				enabled_spawn_points = array(enabled_spawn_points);
			}
			enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
		}
	}
	return enabled_spawn_points;
}

/*
	Name: _disable_spawn_points
	Namespace: spawning
	Checksum: 0xEACC4D89
	Offset: 0x34D0
	Size: 0x16C
	Parameters: 0
	Flags: Private
*/
private function _disable_spawn_points()
{
	self endon(#"death");
	self notify(#"end_disable_spawn_points");
	self endon(#"end_disable_spawn_points");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		self.spawnpoints_enabled = undefined;
		foreach(spawn_point in self.spawn_points_to_disable)
		{
			if(spawn_point.disabled !== 1 && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0)
			{
				level flagsys::set(#"spawnpoints_dirty");
			}
			spawn_point.disabled = 1;
			spawn_point.var_dbb9d994 = 0;
			spawn_point function_8807475c();
		}
	}
}

/*
	Name: _enable_spawn_points
	Namespace: spawning
	Checksum: 0x34562058
	Offset: 0x3648
	Size: 0x17C
	Parameters: 0
	Flags: Private
*/
private function _enable_spawn_points()
{
	self endon(#"death");
	self notify(#"end_enable_spawn_points");
	self endon(#"end_enable_spawn_points");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		self.spawnpoints_enabled = 1;
		foreach(spawn_point in self.spawn_points_to_enable)
		{
			if(isdefined(spawn_point.disabled) && spawn_point.disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0)
			{
				level flagsys::set(#"spawnpoints_dirty");
			}
			spawn_point.disabled = undefined;
			spawn_point.var_dbb9d994 = 1;
			spawn_point function_8807475c();
		}
	}
}

/*
	Name: function_8807475c
	Namespace: spawning
	Checksum: 0x41CD3FCC
	Offset: 0x37D0
	Size: 0x72
	Parameters: 0
	Flags: Private
*/
private function function_8807475c()
{
	self.enabled = 1;
	self.enabled = self.enabled && (!isdefined(self.var_dbb9d994) || self.var_dbb9d994);
	self.enabled = self.enabled && (!isdefined(self.var_bb915a97) || self.var_bb915a97);
}

/*
	Name: rebuild_spawn_points
	Namespace: spawning
	Checksum: 0x257E3916
	Offset: 0x3850
	Size: 0x8E
	Parameters: 1
	Flags: Private
*/
private function rebuild_spawn_points(team)
{
	level.teamspawnpoints[team] = [];
	for(index = 0; index < level.spawn_point_team_class_names[team].size; index++)
	{
		add_spawn_points_internal(team, get_spawnpoint_array(level.spawn_point_team_class_names[team][index]));
	}
}

/*
	Name: place_spawn_points
	Namespace: spawning
	Checksum: 0x7C2CFE8B
	Offset: 0x38E8
	Size: 0x116
	Parameters: 1
	Flags: None
*/
function place_spawn_points(spawnpointname)
{
	add_spawn_point_classname(spawnpointname);
	spawnpoints = get_spawnpoint_array(spawnpointname);
	if(!spawnpoints.size && level.requirespawnpointstoexistinlevel)
	{
		/#
			println("" + spawnpointname + "");
		#/
		/#
			assert(spawnpoints.size, "" + spawnpointname + "");
		#/
		callback::abort_level();
		wait(1);
		return;
	}
	for(index = 0; index < spawnpoints.size; index++)
	{
		spawnpoints[index] spawnpoint_init();
	}
}

/*
	Name: drop_spawn_points
	Namespace: spawning
	Checksum: 0xF601795E
	Offset: 0x3A08
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function drop_spawn_points(spawnpointname)
{
	spawnpoints = get_spawnpoint_array(spawnpointname);
	if(!spawnpoints.size)
	{
		/#
			println("" + spawnpointname + "");
		#/
		return;
	}
	for(index = 0; index < spawnpoints.size; index++)
	{
		placespawnpoint(spawnpoints[index]);
	}
}

/*
	Name: add_spawn_point_classname
	Namespace: spawning
	Checksum: 0xBE288152
	Offset: 0x3AB8
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
private function add_spawn_point_classname(spawnpointclassname)
{
	if(!isdefined(level.spawn_point_class_names))
	{
		level.spawn_point_class_names = [];
	}
	array::add(level.spawn_point_class_names, spawnpointclassname, 0);
}

/*
	Name: add_spawn_point_team_classname
	Namespace: spawning
	Checksum: 0xB614FD4B
	Offset: 0x3B10
	Size: 0x3C
	Parameters: 2
	Flags: Private
*/
private function add_spawn_point_team_classname(team, spawnpointclassname)
{
	array::add(level.spawn_point_team_class_names[team], spawnpointclassname, 0);
}

/*
	Name: get_spawnpoint_array
	Namespace: spawning
	Checksum: 0x247DA62B
	Offset: 0x3B58
	Size: 0x168
	Parameters: 2
	Flags: None
*/
function get_spawnpoint_array(classname, include_disabled = 0)
{
	spawn_points = struct::get_array(classname, "targetname");
	if(!include_disabled && getdvarint(#"spawnsystem_use_code_point_enabled", 0) == 0)
	{
		enabled_spawn_points = [];
		foreach(spawn_point in spawn_points)
		{
			if(!(isdefined(spawn_point.disabled) && spawn_point.disabled))
			{
				if(!isdefined(enabled_spawn_points))
				{
					enabled_spawn_points = [];
				}
				else if(!isarray(enabled_spawn_points))
				{
					enabled_spawn_points = array(enabled_spawn_points);
				}
				enabled_spawn_points[enabled_spawn_points.size] = spawn_point;
			}
		}
		spawn_points = enabled_spawn_points;
	}
	return spawn_points;
}

/*
	Name: spawnpoint_init
	Namespace: spawning
	Checksum: 0xE30B07F3
	Offset: 0x3CC8
	Size: 0x146
	Parameters: 0
	Flags: Private
*/
private function spawnpoint_init()
{
	spawnpoint = self;
	origin = spawnpoint.origin;
	if(!level.spawnminsmaxsprimed)
	{
		level.spawnmins = origin;
		level.spawnmaxs = origin;
		level.spawnminsmaxsprimed = 1;
	}
	else
	{
		level.spawnmins = math::expand_mins(level.spawnmins, origin);
		level.spawnmaxs = math::expand_maxs(level.spawnmaxs, origin);
	}
	placespawnpoint(spawnpoint);
	spawnpoint.forward = anglestoforward(spawnpoint.angles);
	spawnpoint.sighttracepoint = spawnpoint.origin + vectorscale((0, 0, 1), 50);
	if(!isdefined(spawnpoint.enabled))
	{
		spawnpoint.enabled = 1;
	}
	spawnpoint.inited = 1;
}

/*
	Name: get_spawnpoint_final
	Namespace: spawning
	Checksum: 0x9D43BE3F
	Offset: 0x3E18
	Size: 0x270
	Parameters: 3
	Flags: None
*/
function get_spawnpoint_final(spawnpoints, predictedspawn, isintermmissionspawn = 0)
{
	var_e627dced = &positionwouldtelefrag;
	if(isdefined(level.var_79f19f00))
	{
		var_e627dced = level.var_79f19f00;
	}
	bestspawnpoint = undefined;
	if(!isdefined(spawnpoints) || spawnpoints.size == 0)
	{
		return undefined;
	}
	if(!isdefined(predictedspawn))
	{
		predictedspawn = 0;
	}
	if(isdefined(self.lastspawnpoint) && self.lastspawnpoint.lastspawnpredicted && !predictedspawn && !isintermmissionspawn && (!isdefined(self.var_7007b746) || !self.var_7007b746))
	{
		if(![[var_e627dced]](self.lastspawnpoint.origin))
		{
			bestspawnpoint = self.lastspawnpoint;
		}
	}
	if(!isdefined(bestspawnpoint))
	{
		for(i = 0; i < spawnpoints.size; i++)
		{
			if(isdefined(self.lastspawnpoint) && self.lastspawnpoint == spawnpoints[i] && !self.lastspawnpoint.lastspawnpredicted)
			{
				continue;
			}
			if([[var_e627dced]](spawnpoints[i].origin))
			{
				continue;
			}
			bestspawnpoint = spawnpoints[i];
			break;
		}
	}
	if(!isdefined(bestspawnpoint))
	{
		if(isdefined(self.lastspawnpoint) && ![[var_e627dced]](self.lastspawnpoint.origin))
		{
			for(i = 0; i < spawnpoints.size; i++)
			{
				if(spawnpoints[i] == self.lastspawnpoint)
				{
					bestspawnpoint = spawnpoints[i];
					break;
				}
			}
		}
	}
	if(!isdefined(bestspawnpoint))
	{
		bestspawnpoint = spawnpoints[0];
	}
	self finalize_spawnpoint_choice(bestspawnpoint, predictedspawn);
	return bestspawnpoint;
}

/*
	Name: finalize_spawnpoint_choice
	Namespace: spawning
	Checksum: 0xB1DDC8
	Offset: 0x4090
	Size: 0x72
	Parameters: 2
	Flags: None
*/
function finalize_spawnpoint_choice(spawnpoint, predictedspawn)
{
	time = gettime();
	self.lastspawnpoint = spawnpoint;
	self.lastspawntime = time;
	self.var_7007b746 = 0;
	spawnpoint.lastspawnedplayer = self;
	spawnpoint.lastspawntime = time;
	spawnpoint.lastspawnpredicted = predictedspawn;
}

/*
	Name: get_spawnpoint_random
	Namespace: spawning
	Checksum: 0x9DCEA30B
	Offset: 0x4110
	Size: 0xDA
	Parameters: 3
	Flags: None
*/
function get_spawnpoint_random(spawnpoints, predictedspawn, isintermissionspawn = 0)
{
	if(!isdefined(spawnpoints))
	{
		return undefined;
	}
	for(i = 0; i < spawnpoints.size; i++)
	{
		j = randomint(spawnpoints.size);
		spawnpoint = spawnpoints[i];
		spawnpoints[i] = spawnpoints[j];
		spawnpoints[j] = spawnpoint;
	}
	return get_spawnpoint_final(spawnpoints, predictedspawn, isintermissionspawn);
}

/*
	Name: get_random_intermission_point
	Namespace: spawning
	Checksum: 0x5BABF5EB
	Offset: 0x41F8
	Size: 0xC2
	Parameters: 0
	Flags: None
*/
function get_random_intermission_point()
{
	spawnpoints = get_spawnpoint_array("mp_global_intermission");
	if(!spawnpoints.size)
	{
		spawnpoints = get_spawnpoint_array("cp_global_intermission");
	}
	if(!spawnpoints.size)
	{
		spawnpoints = get_spawnpoint_array("info_player_start");
	}
	/#
		assert(spawnpoints.size);
	#/
	spawnpoint = get_spawnpoint_random(spawnpoints, undefined, 1);
	return spawnpoint;
}

/*
	Name: move_spawn_point
	Namespace: spawning
	Checksum: 0x9F18F076
	Offset: 0x42C8
	Size: 0x1A8
	Parameters: 4
	Flags: None
*/
function move_spawn_point(var_75347e0b, start_point, new_point, new_angles)
{
	var_690d7ade = [];
	if(isarray(var_75347e0b))
	{
		var_690d7ade = var_75347e0b;
	}
	else if(!isdefined(var_690d7ade))
	{
		var_690d7ade = [];
	}
	else if(!isarray(var_690d7ade))
	{
		var_690d7ade = array(var_690d7ade);
	}
	var_690d7ade[var_690d7ade.size] = var_75347e0b;
	foreach(targetname in var_690d7ade)
	{
		spawn_points = get_spawnpoint_array(targetname);
		for(i = 0; i < spawn_points.size; i++)
		{
			if(distancesquared(spawn_points[i].origin, start_point) < 1)
			{
				spawn_points[i].origin = new_point;
				if(isdefined(new_angles))
				{
					spawn_points[i].angles = new_angles;
				}
			}
		}
	}
}

/*
	Name: function_754c78a6
	Namespace: spawning
	Checksum: 0xF6065D15
	Offset: 0x4478
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_754c78a6(func_callback)
{
	if(!isdefined(level.var_811300ad))
	{
		level.var_811300ad = [];
	}
	array::add(level.var_811300ad, func_callback);
}

/*
	Name: function_4c00b132
	Namespace: spawning
	Checksum: 0x95994444
	Offset: 0x44C8
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function function_4c00b132(func_callback)
{
	/#
		assert(isdefined(level.var_811300ad) && level.var_811300ad.size, "");
	#/
	foreach(index, func in level.var_811300ad)
	{
		if(func == func_callback)
		{
			arrayremoveindex(level.var_811300ad, index, 0);
			return;
		}
	}
}

/*
	Name: function_a782529
	Namespace: spawning
	Checksum: 0x17DCE9E4
	Offset: 0x45B0
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_a782529(e_player)
{
	var_8bfdbbee = [];
	foreach(func in level.var_811300ad)
	{
		var_ee69d92d = [[func]](e_player);
		if(isdefined(var_ee69d92d))
		{
			array::add(var_8bfdbbee, var_ee69d92d);
		}
	}
	return var_8bfdbbee;
}

/*
	Name: spawnpoint_debug
	Namespace: spawning
	Checksum: 0xDFE68043
	Offset: 0x4678
	Size: 0x4DC
	Parameters: 0
	Flags: None
*/
function spawnpoint_debug()
{
	/#
		a_spawnlists = getspawnlists();
		index = 0;
		foreach(s_list in a_spawnlists)
		{
			adddebugcommand("" + s_list + "" + index + "");
			index++;
		}
		adddebugcommand("" + "" + "");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			spawnsystem_debug_command = getdvarstring(#"spawnsystem_debug_command");
			switch(spawnsystem_debug_command)
			{
				case "next_best":
				{
					selectedplayerindex = getdvarint(#"spawnsystem_debug_current_player", 0);
					foreach(player in level.players)
					{
						if(player getentitynumber() == selectedplayerindex)
						{
							selectedplayer = player;
							break;
						}
					}
					if(!isdefined(selectedplayer))
					{
						continue;
					}
					if(level.teambased)
					{
						point_team = selectedplayer.pers[#"team"];
						influencer_team = selectedplayer.pers[#"team"];
						vis_team_mask = util::getotherteamsmask(selectedplayer.pers[#"team"]);
					}
					else
					{
						point_team = "";
						influencer_team = "";
						vis_team_mask = level.spawnsystem.ispawn_teammask[#"all"];
					}
					nextbestspawnpoint = getbestspawnpoint(point_team, influencer_team, vis_team_mask, selectedplayer, 0);
					selectedplayer setorigin(nextbestspawnpoint[#"origin"]);
					selectedplayer setplayerangles(nextbestspawnpoint[#"angles"]);
					break;
				}
				case "refresh":
				{
					level flagsys::set(#"spawnpoints_dirty");
					break;
				}
			}
			setdvar(#"spawnsystem_debug_command", "");
			if(isdefined(getdvarint(#"spawnsystem_debug_triggers", 0)) && getdvarint(#"spawnsystem_debug_triggers", 0))
			{
				foreach(trig in level.spawnpoint_triggers)
				{
					render_spawnpoints_triggers(trig);
				}
			}
			wait(0.5);
		}
	#/
}

/*
	Name: render_spawnpoints_triggers
	Namespace: spawning
	Checksum: 0x85345851
	Offset: 0x4B60
	Size: 0x288
	Parameters: 1
	Flags: None
*/
function render_spawnpoints_triggers(trig)
{
	/#
		box(trig.origin, trig getmins(), trig getmaxs(), 0, (0, 0, 1), 1, 0, 10);
		if(isdefined(trig.spawn_points_to_enable))
		{
			foreach(spawn_point in trig.spawn_points_to_enable)
			{
				box(spawn_point.origin, vectorscale((-1, -1, 0), 4), (4, 4, 8), 0, isdefined(spawn_point.disabled) && (spawn_point.disabled ? (1, 0, 0) : (0, 1, 0)), 1, 0, 10);
				line(trig.origin, spawn_point.origin, (0, 1, 0), 1, 0, 10);
			}
		}
		if(isdefined(trig.spawn_points_to_disable))
		{
			foreach(spawn_point in trig.spawn_points_to_disable)
			{
				box(spawn_point.origin, vectorscale((-1, -1, 0), 4), (4, 4, 8), 0, isdefined(spawn_point.disabled) && (spawn_point.disabled ? (1, 0, 0) : (0, 1, 0)), 1, 0, 10);
				line(trig.origin, spawn_point.origin, (1, 0, 0), 1, 0, 10);
			}
		}
	#/
}

