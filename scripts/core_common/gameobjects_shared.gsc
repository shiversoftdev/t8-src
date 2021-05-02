// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_68d2ee1489345a1d;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace gameobjects;

/*
	Name: function_89f2df9
	Namespace: gameobjects
	Checksum: 0xDE25BA0B
	Offset: 0x4A8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"gameobjects", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gameobjects
	Checksum: 0x2AB36E31
	Offset: 0x4F0
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.numgametypereservedobjectives = 1;
	level.releasedobjectives = [];
	level.a_gameobjects = [];
	callback::on_spawned(&function_b737f012);
	callback::on_vehicle_spawned(&function_b737f012);
	callback::on_ai_spawned(&function_b737f012);
	callback::on_disconnect(&on_disconnect);
	callback::on_laststand(&on_player_last_stand);
	level thread function_71699fe2();
}

/*
	Name: main
	Namespace: gameobjects
	Checksum: 0x599DA275
	Offset: 0x5E0
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function main()
{
	level.vehiclesenabled = getgametypesetting(#"vehiclesenabled");
	level.vehiclestimed = getgametypesetting(#"vehiclestimed");
	level.objectivepingdelay = getgametypesetting(#"objectivepingtime");
	level.nonteambasedteam = #"allies";
	if(!isdefined(level.allowedgameobjects))
	{
		level.allowedgameobjects = [];
	}
	if(level.vehiclesenabled)
	{
		level.allowedgameobjects[level.allowedgameobjects.size] = "vehicle";
		filter_script_vehicles_from_vehicle_descriptors(level.allowedgameobjects);
	}
	a_ents = getentarray();
	for(entity_index = a_ents.size - 1; entity_index >= 0; entity_index--)
	{
		entity = a_ents[entity_index];
		if(!entity_is_allowed(entity, level.allowedgameobjects))
		{
			entity delete();
		}
	}
	level thread function_176070dc();
}

/*
	Name: register_allowed_gameobject
	Namespace: gameobjects
	Checksum: 0x5F7B8EDC
	Offset: 0x790
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_allowed_gameobject(gameobject)
{
	if(!isdefined(level.allowedgameobjects))
	{
		level.allowedgameobjects = [];
	}
	level.allowedgameobjects[level.allowedgameobjects.size] = gameobject;
}

/*
	Name: clear_allowed_gameobjects
	Namespace: gameobjects
	Checksum: 0x415FB8E1
	Offset: 0x7E0
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function clear_allowed_gameobjects()
{
	level.allowedgameobjects = [];
}

/*
	Name: entity_is_allowed
	Namespace: gameobjects
	Checksum: 0x9A9AC74C
	Offset: 0x800
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function entity_is_allowed(entity, allowed_game_modes)
{
	allowed = 1;
	if(isdefined(entity.script_gameobjectname) && entity.script_gameobjectname != "[all_modes]")
	{
		allowed = 0;
		gameobjectnames = strtok(entity.script_gameobjectname, " ");
		for(i = 0; i < allowed_game_modes.size && !allowed; i++)
		{
			for(j = 0; j < gameobjectnames.size && !allowed; j++)
			{
				allowed = gameobjectnames[j] == allowed_game_modes[i];
			}
		}
	}
	return allowed;
}

/*
	Name: location_is_allowed
	Namespace: gameobjects
	Checksum: 0x55A55246
	Offset: 0x918
	Size: 0x110
	Parameters: 2
	Flags: None
*/
function location_is_allowed(entity, location)
{
	allowed = 1;
	location_list = undefined;
	if(isdefined(entity.script_noteworthy))
	{
		location_list = entity.script_noteworthy;
	}
	if(isdefined(entity.script_location))
	{
		location_list = entity.script_location;
	}
	if(isdefined(location_list))
	{
		if(location_list == "[all_modes]")
		{
			allowed = 1;
		}
		else
		{
			allowed = 0;
			gameobjectlocations = strtok(location_list, " ");
			for(j = 0; j < gameobjectlocations.size; j++)
			{
				if(gameobjectlocations[j] == location)
				{
					allowed = 1;
					break;
				}
			}
		}
	}
	return allowed;
}

/*
	Name: filter_script_vehicles_from_vehicle_descriptors
	Namespace: gameobjects
	Checksum: 0x9CD535A8
	Offset: 0xA30
	Size: 0x1D6
	Parameters: 1
	Flags: Linked
*/
function filter_script_vehicles_from_vehicle_descriptors(allowed_game_modes)
{
	vehicle_descriptors = getentarray("vehicle_descriptor", "targetname");
	script_vehicles = getentarray("script_vehicle", "classname");
	vehicles_to_remove = [];
	for(descriptor_index = 0; descriptor_index < vehicle_descriptors.size; descriptor_index++)
	{
		descriptor = vehicle_descriptors[descriptor_index];
		closest_distance_sq = 1E+12;
		closest_vehicle = undefined;
		for(vehicle_index = 0; vehicle_index < script_vehicles.size; vehicle_index++)
		{
			vehicle = script_vehicles[vehicle_index];
			dsquared = distancesquared(vehicle getorigin(), descriptor getorigin());
			if(dsquared < closest_distance_sq)
			{
				closest_distance_sq = dsquared;
				closest_vehicle = vehicle;
			}
		}
		if(isdefined(closest_vehicle))
		{
			if(!entity_is_allowed(descriptor, allowed_game_modes))
			{
				vehicles_to_remove[vehicles_to_remove.size] = closest_vehicle;
			}
		}
	}
	for(vehicle_index = 0; vehicle_index < vehicles_to_remove.size; vehicle_index++)
	{
		vehicles_to_remove[vehicle_index] delete();
	}
}

/*
	Name: function_71699fe2
	Namespace: gameobjects
	Checksum: 0xF1077282
	Offset: 0xC10
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_71699fe2()
{
	level.var_c3977917 = struct::get_script_bundle_instances("gameobject");
	n_count = 1;
	foreach(s_radiant in level.var_c3977917)
	{
		if(isdefined(s_radiant.targetname))
		{
			s_radiant.str_identifier = s_radiant.targetname + "_" + n_count;
		}
		else
		{
			s_radiant.str_identifier = "gameobject_" + n_count;
		}
		n_count++;
		s_radiant.var_c65066ad = 1;
		s_radiant init_flags();
	}
}

/*
	Name: function_176070dc
	Namespace: gameobjects
	Checksum: 0xADE5DB3C
	Offset: 0xD28
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function function_176070dc()
{
	waittillframeend();
	foreach(s_radiant in level.var_c3977917)
	{
		if(isdefined(s_radiant.script_team) && s_radiant.script_team != #"none")
		{
			str_team_override = s_radiant.script_team;
		}
		else
		{
			str_team_override = undefined;
		}
		s_radiant init_game_objects(undefined, str_team_override, s_radiant.var_5c8915f4, undefined, undefined, s_radiant.var_17afe51d);
		s_radiant disable_object(1);
		if(isdefined(s_radiant.script_enable_on_start) && s_radiant.script_enable_on_start)
		{
			s_radiant thread enable_object(1);
		}
		if(isdefined(s_radiant.script_carry_object_key_target) && (isdefined(s_radiant.var_91fc94c1) && s_radiant.var_91fc94c1))
		{
			s_radiant function_e7e3d146();
		}
		s_radiant function_71479ff3();
		if(isdefined(s_radiant.script_paired_gameobject))
		{
			s_radiant.var_84d5c09e = struct::get_array(s_radiant.script_paired_gameobject, "script_paired_gameobject");
			s_radiant.mdl_gameobject.b_auto_reenable = 0;
		}
	}
	function_42b34fc3();
	function_2f3ba1ad();
	function_71a1c90f();
	level flagsys::set(#"radiant_gameobjects_initialized");
}

/*
	Name: init_flags
	Namespace: gameobjects
	Checksum: 0x281546F2
	Offset: 0xF80
	Size: 0xE4
	Parameters: 0
	Flags: Linked, Private
*/
private function init_flags()
{
	self flag::init("enabled");
	self flag::init("success");
	if(isdefined(self.script_flag_true))
	{
		util::create_flags_and_return_tokens(self.script_flag_true);
	}
	if(isdefined(self.script_flag_false))
	{
		util::create_flags_and_return_tokens(self.script_flag_false);
	}
	if(isdefined(self.var_fff2f8a8))
	{
		util::create_flags_and_return_tokens(self.var_fff2f8a8);
	}
	if(isdefined(self.script_flag_set))
	{
		util::create_flags_and_return_tokens(self.script_flag_set);
	}
}

/*
	Name: function_35a012bf
	Namespace: gameobjects
	Checksum: 0x4757853A
	Offset: 0x1070
	Size: 0xD4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_35a012bf()
{
	if(self flag::get("enabled"))
	{
		return;
	}
	self.mdl_gameobject endon(#"death");
	if(!(isdefined(self.mdl_gameobject.var_64b8fc93) && self.mdl_gameobject.var_64b8fc93))
	{
		self.mdl_gameobject.var_64b8fc93 = 1;
		self util::function_fb80e9ca();
	}
	self flag::set("enabled");
	if(isdefined(self.var_fff2f8a8))
	{
		util::function_aebdb74f(self.var_fff2f8a8);
	}
}

/*
	Name: function_8dbe8332
	Namespace: gameobjects
	Checksum: 0x355EC620
	Offset: 0x1150
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_8dbe8332(b_success, b_destroyed)
{
	if(level flagsys::get(#"radiant_gameobjects_initialized"))
	{
		self flag::clear("enabled");
	}
}

/*
	Name: function_49184ad0
	Namespace: gameobjects
	Checksum: 0x99AB8C9E
	Offset: 0x11B0
	Size: 0x64
	Parameters: 3
	Flags: Linked, Private
*/
private function function_49184ad0(str_team, e_player, b_success = 0)
{
	if(b_success)
	{
		if(isdefined(self.script_flag_set))
		{
			util::function_aebdb74f(self.script_flag_set);
		}
	}
}

/*
	Name: function_42b34fc3
	Namespace: gameobjects
	Checksum: 0x8431FEED
	Offset: 0x1220
	Size: 0x178
	Parameters: 0
	Flags: Linked, Private
*/
private function function_42b34fc3()
{
	foreach(var_7418aa09 in trigger::get_all())
	{
		var_bf5ad193 = [];
		foreach(e_gameobject in level.a_gameobjects)
		{
			if(isdefined(e_gameobject) && isdefined(e_gameobject.e_object) && isdefined(var_7418aa09.target) && var_7418aa09.target === e_gameobject.e_object.targetname)
			{
				array::add(var_bf5ad193, e_gameobject);
			}
		}
		if(var_bf5ad193.size)
		{
			if(isdefined(var_7418aa09))
			{
				var_7418aa09 thread function_d4107dde(var_bf5ad193);
			}
		}
	}
}

/*
	Name: function_d4107dde
	Namespace: gameobjects
	Checksum: 0x8B5046F3
	Offset: 0x13A0
	Size: 0xD0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d4107dde(var_bf5ad193)
{
	self endon(#"death");
	self trigger::wait_till();
	foreach(e_gameobject in var_bf5ad193)
	{
		if(isdefined(e_gameobject) && isdefined(e_gameobject.e_object))
		{
			e_gameobject.e_object enable_object(1);
		}
	}
}

/*
	Name: function_2f3ba1ad
	Namespace: gameobjects
	Checksum: 0x7E92BD38
	Offset: 0x1478
	Size: 0x248
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2f3ba1ad()
{
	foreach(var_6f1036dd in struct::get_script_bundle_instances("gameobject"))
	{
		if(isdefined(var_6f1036dd.var_51676529))
		{
			var_fac9218d = strtok(var_6f1036dd.var_51676529, " ");
			var_6f1036dd.var_db1edf58 = [];
			foreach(var_9d32a381 in var_fac9218d)
			{
				var_6f1036dd.var_db1edf58 = arraycombine(var_6f1036dd.var_db1edf58, struct::get_array(var_9d32a381, "script_carry_object_key_target"), 0, 0);
			}
			foreach(var_183d2001 in var_6f1036dd.var_db1edf58)
			{
				if(isdefined(var_183d2001.mdl_gameobject))
				{
					var_183d2001 set_key_object(var_6f1036dd);
					continue;
				}
				var_183d2001.var_4cd30731 = var_6f1036dd;
			}
			if(isdefined(var_6f1036dd.var_3a8907ff) && var_6f1036dd.var_3a8907ff && isdefined(var_6f1036dd.var_db1edf58))
			{
				var_6f1036dd thread function_2e028a0e();
			}
		}
	}
}

/*
	Name: function_2e028a0e
	Namespace: gameobjects
	Checksum: 0x12855516
	Offset: 0x16C8
	Size: 0x24A
	Parameters: 0
	Flags: Linked
*/
function function_2e028a0e()
{
	self.mdl_gameobject endon(#"death");
	while(true)
	{
		self.mdl_gameobject waittill(#"pickup_object");
		self hide_waypoint();
		foreach(var_183d2001 in self.var_db1edf58)
		{
			if(isdefined(var_183d2001.mdl_gameobject))
			{
				var_183d2001 show_waypoint();
				continue;
			}
			if(isdefined(var_183d2001.var_4cd30731))
			{
				var_183d2001 notify(#"hash_58b8542ed702b2a5", {#player:self.mdl_gameobject.carrier, #hash_36c9fd16:1});
				var_183d2001.var_459e9174 = 1;
			}
		}
		self.mdl_gameobject waittill(#"dropped");
		self show_waypoint();
		foreach(var_183d2001 in self.var_db1edf58)
		{
			if(isdefined(var_183d2001.mdl_gameobject))
			{
				var_183d2001 function_c59e69d3(var_183d2001 get_owner_team());
				continue;
			}
			if(isdefined(var_183d2001.var_4cd30731))
			{
				var_183d2001 notify(#"hash_58b8542ed702b2a5", {#hash_36c9fd16:0});
				var_183d2001.var_459e9174 = undefined;
			}
		}
	}
}

/*
	Name: function_71a1c90f
	Namespace: gameobjects
	Checksum: 0x8BF46D09
	Offset: 0x1920
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
private function function_71a1c90f()
{
	foreach(var_80ab0aea in struct::get_script_bundle_instances("gameobject"))
	{
		if(isdefined(var_80ab0aea.linkto))
		{
			a_s_structs = struct::get_array(var_80ab0aea.linkto, "linkname");
			var_6e793336 = array::random(a_s_structs);
			if(isdefined(var_6e793336.mdl_gameobject) && var_6e793336.mdl_gameobject.type === "carryObject")
			{
				var_80ab0aea.mdl_gameobject thread function_d85d429b(var_6e793336.mdl_gameobject);
				continue;
			}
		}
	}
}

/*
	Name: function_d85d429b
	Namespace: gameobjects
	Checksum: 0xF1BFFFB9
	Offset: 0x1A60
	Size: 0x3CE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d85d429b(var_7d01398c)
{
	level endon(#"game_ended");
	self.trigger endon(#"destroyed", #"death");
	var_7d01398c.trigger endon(#"destroyed", #"death");
	self endon(#"death");
	var_7d01398c endon(#"death");
	self.trigger unlink();
	self.trigger.origin = var_7d01398c.curorigin;
	self.trigger linkto(var_7d01398c);
	self.e_object.origin = var_7d01398c.curorigin;
	self.e_object.angles = var_7d01398c.e_object.angles;
	self.var_68d8f95e = var_7d01398c;
	if(!isdefined(var_7d01398c.var_bb7aca0c))
	{
		var_7d01398c.var_bb7aca0c = [];
	}
	else if(!isarray(var_7d01398c.var_bb7aca0c))
	{
		var_7d01398c.var_bb7aca0c = array(var_7d01398c.var_bb7aca0c);
	}
	var_7d01398c.var_bb7aca0c[var_7d01398c.var_bb7aca0c.size] = self;
	while(true)
	{
		if(isdefined(var_7d01398c.carrier))
		{
			if(!(isdefined(self.var_2955c864) && self.var_2955c864))
			{
				var_f857ad18 = self.interactteam;
				self.interrupted = 1;
				self allow_use(#"none");
				self set_flags(1);
				self.trigger unlink();
				self.trigger.origin = var_7d01398c.carrier.origin + vectorscale((0, 0, 1), 64);
				self.trigger linkto(var_7d01398c.carrier);
				var_7d01398c waittill(#"dropped", #"reset", #"death");
				self set_flags(0);
				self.interrupted = undefined;
				self.trigger unlink();
				self.trigger.origin = var_7d01398c.curorigin + vectorscale((0, 0, 1), 32);
				self.e_object.origin = var_7d01398c.curorigin;
				self.e_object.angles = var_7d01398c.angles;
				waitframe(2);
				self.trigger linkto(var_7d01398c);
				self allow_use(var_f857ad18);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_e19c7c52
	Namespace: gameobjects
	Checksum: 0x12601621
	Offset: 0x1E38
	Size: 0x124
	Parameters: 2
	Flags: None
*/
function function_e19c7c52(var_7537f028, var_1511a953 = 0)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.trigger unlink();
	if(isvec(var_7537f028))
	{
		mdl_gameobject.trigger.origin = var_7537f028;
	}
	else if(isdefined(var_7537f028.curorigin))
	{
		mdl_gameobject.trigger.origin = var_7537f028.curorigin;
	}
	else
	{
		mdl_gameobject.trigger.origin = var_7537f028.origin;
	}
	if(isentity(var_7537f028) && var_1511a953)
	{
		mdl_gameobject.trigger linkto(var_7537f028);
	}
}

/*
	Name: function_71479ff3
	Namespace: gameobjects
	Checksum: 0x7DC29FFB
	Offset: 0x1F68
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_71479ff3()
{
	if(isdefined(self.target))
	{
		a_s_targets = struct::get_array(self.target);
		foreach(s_target in a_s_targets)
		{
			if(s_target.classname === "scriptbundle_scene")
			{
				if(!isdefined(self.var_abba8d92))
				{
					self.var_abba8d92 = [];
				}
				if(!isdefined(self.var_abba8d92))
				{
					self.var_abba8d92 = [];
				}
				else if(!isarray(self.var_abba8d92))
				{
					self.var_abba8d92 = array(self.var_abba8d92);
				}
				self.var_abba8d92[self.var_abba8d92.size] = s_target;
			}
		}
		if(isdefined(self.var_abba8d92))
		{
			self thread function_9e7fca5f();
		}
	}
}

/*
	Name: function_9e7fca5f
	Namespace: gameobjects
	Checksum: 0x75100CA3
	Offset: 0x20C8
	Size: 0x236
	Parameters: 0
	Flags: Linked
*/
function function_9e7fca5f()
{
	self.mdl_gameobject.trigger endon(#"destroyed");
	self.mdl_gameobject endon(#"death");
	self endon(#"hash_767d05d04b5ba2f6");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self.mdl_gameobject waittill(#"gameobject_end_use_player");
		foreach(s_scene in self.var_abba8d92)
		{
			if(isplayer(var_be17187b.player) && scene::get_player_count(s_scene.scriptbundlename) >= 1)
			{
				var_be17187b.player animation::stop(0);
				s_scene thread scene::play(var_be17187b.player);
				continue;
			}
			s_scene thread scene::play();
		}
		foreach(s_scene in self.var_abba8d92)
		{
			if(isdefined(s_scene.script_play_multiple) && s_scene.script_play_multiple)
			{
				continue;
			}
			arrayremovevalue(self.var_abba8d92, s_scene, 1);
		}
		if(self.var_abba8d92.size == 0)
		{
			return;
		}
	}
}

/*
	Name: set_use_multiplier_callback
	Namespace: gameobjects
	Checksum: 0x8D7FD98A
	Offset: 0x2308
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_use_multiplier_callback(callbackfunction)
{
	self.getuseratemultiplier = callbackfunction;
}

/*
	Name: defaultuseratescalercallback
	Namespace: gameobjects
	Checksum: 0x344C881F
	Offset: 0x2330
	Size: 0x166
	Parameters: 1
	Flags: Linked
*/
function defaultuseratescalercallback(player)
{
	useobj = self;
	characterindex = player getspecialistindex();
	/#
		assert(player_role::is_valid(characterindex));
	#/
	playerrole = getplayerrolecategory(characterindex, currentsessionmode());
	if(isdefined(playerrole) && isdefined(useobj.bundle))
	{
		switch(playerrole)
		{
			case "prc_mp_slayer":
			{
				scaler = useobj.bundle.slayer_userate_scaler;
				break;
			}
			case "prc_mp_objective":
			{
				scaler = useobj.bundle.objective_userate_scaler;
				break;
			}
			case "prc_mp_support":
			{
				scaler = useobj.bundle.support_userate_scaler;
				break;
			}
		}
	}
	if(!isdefined(scaler))
	{
		scaler = 1;
	}
	return scaler;
}

/*
	Name: defaultallowweaponscallback
	Namespace: gameobjects
	Checksum: 0x4C8AF935
	Offset: 0x24A0
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function defaultallowweaponscallback(object)
{
	player = self;
	characterindex = player getspecialistindex();
	/#
		assert(player_role::is_valid(characterindex));
	#/
	playerrole = getplayerrolecategory(characterindex, currentsessionmode());
	if(isdefined(playerrole) && isdefined(object.bundle))
	{
		switch(playerrole)
		{
			case "prc_mp_slayer":
			{
				return isdefined(object.bundle.slayer_allow_weapons) && object.bundle.slayer_allow_weapons;
			}
			case "prc_mp_objective":
			{
				return isdefined(object.bundle.objective_allow_weapons) && object.bundle.objective_allow_weapons;
			}
			case "prc_mp_support":
			{
				return isdefined(object.bundle.support_allow_weapons) && object.bundle.support_allow_weapons;
			}
		}
	}
	return object.allowweapons;
}

/*
	Name: function_b737f012
	Namespace: gameobjects
	Checksum: 0x2F9C1798
	Offset: 0x2640
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_b737f012()
{
	self.touchtriggers = [];
	self.packobject = [];
	self.packicon = [];
	self.carryobject = undefined;
	self.claimtrigger = undefined;
	self.canpickupobject = 1;
	self.disabledweapon = 0;
	self.killedinuse = undefined;
}

/*
	Name: function_19f7be2d
	Namespace: gameobjects
	Checksum: 0x721D841
	Offset: 0x26A0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_19f7be2d(params)
{
	if(game.state != "playing")
	{
		return;
	}
	self thread gameobjects_dropped(params.mod);
}

/*
	Name: on_disconnect
	Namespace: gameobjects
	Checksum: 0x17F8859D
	Offset: 0x26F0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_disconnect()
{
	self thread gameobjects_dropped();
}

/*
	Name: on_player_last_stand
	Namespace: gameobjects
	Checksum: 0x80890DA4
	Offset: 0x2718
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_last_stand()
{
	self thread gameobjects_dropped();
}

/*
	Name: gameobjects_dropped
	Namespace: gameobjects
	Checksum: 0xDFDE1F9F
	Offset: 0x2740
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function gameobjects_dropped(mod)
{
	if(isdefined(self.carryobject))
	{
		self.carryobject.var_8c812e0a = mod === "MOD_META";
		self.carryobject thread set_dropped();
	}
	if(isdefined(self.packobject) && self.packobject.size > 0)
	{
		foreach(item in self.packobject)
		{
			item thread set_dropped();
		}
	}
}

/*
	Name: function_4ea98a09
	Namespace: gameobjects
	Checksum: 0x9A64546B
	Offset: 0x2828
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_4ea98a09()
{
	if(!isdefined(self.trigger.var_a865c2cd))
	{
		return 1;
	}
	if(self.trigger.var_a865c2cd)
	{
		return 1;
	}
	return 0;
}

/*
	Name: create_carry_object
	Namespace: gameobjects
	Checksum: 0xE0C18C3
	Offset: 0x2870
	Size: 0x6A6
	Parameters: 8
	Flags: Linked
*/
function create_carry_object(ownerteam, trigger, visuals, offset, objectivename, hitsound, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0)
{
	carryobject = spawn("script_model", trigger.origin);
	carryobject.type = "carryObject";
	carryobject.curorigin = trigger.origin;
	carryobject.entnum = trigger getentitynumber();
	carryobject.hitsound = hitsound;
	if(issubstr(trigger.classname, "use"))
	{
		carryobject.triggertype = "use";
	}
	else
	{
		carryobject.triggertype = "proximity";
	}
	trigger.baseorigin = trigger.origin;
	carryobject.trigger = trigger;
	trigger enablelinkto();
	carryobject linkto(trigger);
	carryobject.useweapon = undefined;
	if(!isdefined(offset))
	{
		offset = (0, 0, 0);
	}
	for(index = 0; index < visuals.size; index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}
	carryobject.visuals = visuals;
	carryobject _set_team(ownerteam);
	carryobject.compassicons = [];
	carryobject.objidpingfriendly = 0;
	carryobject.objidpingenemy = 0;
	if(carryobject function_4ea98a09())
	{
		/#
			assert(isdefined(objectivename), "");
		#/
		carryobject.objid = [];
		level.objidstart = level.objidstart + 2;
		carryobject.objectiveid = get_next_obj_id();
		objective_add(carryobject.objectiveid, "invisible", carryobject.curorigin, objectivename);
	}
	carryobject.carrier = undefined;
	carryobject.isresetting = 0;
	carryobject.interactteam = #"none";
	carryobject.allowweapons = 0;
	carryobject.visiblecarriermodel = undefined;
	carryobject.dropoffset = 0;
	carryobject.disallowremotecontrol = 0;
	carryobject.var_22389d70 = 1;
	carryobject.worldicons = [];
	carryobject.carriervisible = 0;
	carryobject.visibleteam = #"none";
	carryobject.worldiswaypoint = [];
	carryobject.worldicons_disabled = [];
	carryobject.carryicon = undefined;
	carryobject.setdropped = undefined;
	carryobject.ondrop = undefined;
	carryobject.onpickup = undefined;
	carryobject.onreset = undefined;
	carryobject.usetime = 10000;
	carryobject.decayprogress = 0;
	carryobject.var_98bb0715 = 1;
	carryobject.var_5c196da4 = 0;
	carryobject clear_progress();
	if(carryobject.triggertype == "use")
	{
		carryobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
		carryobject.userate = 1;
		carryobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
		if(!carryobject function_4ea98a09() && isdefined(carryobject.trigger.str_hint))
		{
			carryobject.trigger setcursorhint("HINT_NOICON");
			carryobject.trigger sethintstring(carryobject.trigger.str_hint);
		}
	}
	else
	{
		carryobject setup_touching();
		carryobject.curprogress = 0;
		carryobject.userate = 0;
		carryobject.claimteam = #"none";
		carryobject.claimplayer = undefined;
		carryobject.lastclaimteam = #"none";
		carryobject.lastclaimtime = 0;
		carryobject.claimgraceperiod = 0;
		carryobject.mustmaintainclaim = 0;
		carryobject.cancontestclaim = 0;
		carryobject.teamusetimes = [];
		carryobject.teamusetexts = [];
		carryobject thread use_object_prox_think();
	}
	carryobject.getuseratemultiplier = &defaultuseratescalercallback;
	carryobject.allowweaponscallback = &defaultallowweaponscallback;
	if(carryobject function_4ea98a09())
	{
		carryobject thread update_carry_object_objective_origin();
	}
	array::add(level.a_gameobjects, carryobject, 0);
	carryobject.b_reusable = 1;
	return carryobject;
}

/*
	Name: function_63f73e1d
	Namespace: gameobjects
	Checksum: 0xC13E9BE6
	Offset: 0x2F20
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_63f73e1d(soundalias)
{
	self.var_e810e5f7 = soundalias;
}

/*
	Name: pickup_object_delay
	Namespace: gameobjects
	Checksum: 0x1EC14033
	Offset: 0x2F48
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function pickup_object_delay(origin)
{
	level endon(#"game_ended");
	self endon(#"death", #"disconnect");
	self.canpickupobject = 0;
	for(;;)
	{
		if(distancesquared(self.origin, origin) > 4096)
		{
			break;
		}
		wait(0.2);
	}
	self.canpickupobject = 1;
}

/*
	Name: set_picked_up
	Namespace: gameobjects
	Checksum: 0x71271672
	Offset: 0x2FE8
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function set_picked_up(player)
{
	if(!isalive(player))
	{
		return;
	}
	if(self.type == "carryObject")
	{
		if(isdefined(player.carryobject))
		{
			if(isdefined(player.carryobject.swappable) && player.carryobject.swappable)
			{
				player.carryobject thread set_dropped();
			}
			else if(isdefined(self.onpickupfailed))
			{
				self [[self.onpickupfailed]](player);
			}
			return;
		}
		player give_object(self);
	}
	else if(self.type == "packObject")
	{
		if(isdefined(level.max_packobjects) && level.max_packobjects <= player.packobject.size)
		{
			if(isdefined(self.onpickupfailed))
			{
				self [[self.onpickupfailed]](player);
			}
			return;
		}
		player give_pack_object(self);
	}
	self set_carrier(player);
	self ghost_visuals();
	self.trigger triggerenable(0);
	self notify(#"pickup_object");
	if(isdefined(self.onpickup))
	{
		self [[self.onpickup]](player);
	}
	if(isdefined(self.var_e810e5f7))
	{
		self playsound(self.var_e810e5f7);
	}
	self update_objective();
}

/*
	Name: unlink_grenades
	Namespace: gameobjects
	Checksum: 0xE7025291
	Offset: 0x3208
	Size: 0x1E0
	Parameters: 0
	Flags: Linked
*/
function unlink_grenades()
{
	radius = 32;
	origin = self.origin;
	grenades = getentarray("grenade", "classname");
	radiussq = radius * radius;
	linkedgrenades = [];
	foreach(grenade in grenades)
	{
		if(distancesquared(origin, grenade.origin) < radiussq)
		{
			if(grenade islinkedto(self))
			{
				grenade unlink();
				linkedgrenades[linkedgrenades.size] = grenade;
			}
		}
	}
	waittillframeend();
	foreach(grenade in linkedgrenades)
	{
		grenade launch((randomfloatrange(-5, 5), randomfloatrange(-5, 5), 5));
	}
}

/*
	Name: ghost_visuals
	Namespace: gameobjects
	Checksum: 0x851832B1
	Offset: 0x33F0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function ghost_visuals()
{
	foreach(visual in self.visuals)
	{
		visual ghost();
		visual thread unlink_grenades();
	}
}

/*
	Name: update_carry_object_objective_origin
	Namespace: gameobjects
	Checksum: 0x803AD41B
	Offset: 0x3488
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function update_carry_object_objective_origin()
{
	self endon(#"hash_431541b507a8c588");
	level endon(#"game_ended");
	self.trigger endon(#"destroyed", #"death");
	objpingdelay = level.objectivepingdelay;
	for(;;)
	{
		if(isdefined(self.carrier))
		{
			self.curorigin = self.carrier.origin;
			if(isdefined(self.objectiveid))
			{
				objective_setposition(self.objectiveid, self.curorigin);
			}
			self util::wait_endon(objpingdelay, "dropped", "reset");
			continue;
		}
		if(isdefined(self.objectiveid))
		{
			objective_setposition(self.objectiveid, self.curorigin);
		}
		waitframe(1);
	}
}

/*
	Name: give_object
	Namespace: gameobjects
	Checksum: 0x9A8F18D0
	Offset: 0x35B0
	Size: 0x31C
	Parameters: 1
	Flags: Linked
*/
function give_object(object)
{
	/#
		assert(!isdefined(self.carryobject));
	#/
	self.carryobject = object;
	self callback::on_death(&function_19f7be2d);
	self thread track_carrier(object);
	allowweapons = object.allowweapons;
	if(isdefined(object.allowweaponscallback))
	{
		allowweapons = [[object.allowweaponscallback]](object);
	}
	if(isdefined(object.carryweapon))
	{
		if(isdefined(object.carryweaponthink))
		{
			self thread [[object.carryweaponthink]]();
		}
		for(count = 0; self ismeleeing() && count < 10; count++)
		{
			wait(0.2);
		}
		self giveweapon(object.carryweapon);
		if(self isswitchingweapons())
		{
			self waittill_timeout(2, #"weapon_change");
		}
		self switchtoweaponimmediate(object.carryweapon);
		self setblockweaponpickup(object.carryweapon, 1);
		self disableweaponcycling();
	}
	else if(!allowweapons)
	{
		self val::set(#"carry_object", "disable_weapons");
		if(!(isdefined(object.droponusebutton) && object.droponusebutton))
		{
			self thread manual_drop_think();
		}
	}
	if(isdefined(object.droponusebutton) && object.droponusebutton)
	{
		if(object.droponusehasdelay === 1)
		{
			self thread droponholdusebutton();
		}
		else
		{
			self thread droponusebutton();
		}
	}
	else if(isdefined(object.var_bee2a129) && object.var_bee2a129)
	{
		self thread function_bee2a129();
	}
	self.disallowvehicleusage = 1;
	if(isdefined(object.visiblecarriermodel))
	{
		self weapons::force_stowed_weapon_update();
	}
}

/*
	Name: move_visuals_to_base
	Namespace: gameobjects
	Checksum: 0xC8D1238E
	Offset: 0x38D8
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function move_visuals_to_base()
{
	foreach(visual in self.visuals)
	{
		visual.origin = visual.baseorigin;
		visual.angles = visual.baseangles;
		visual dontinterpolate();
		visual show();
	}
}

/*
	Name: return_home
	Namespace: gameobjects
	Checksum: 0x361254B1
	Offset: 0x39A0
	Size: 0x2DE
	Parameters: 0
	Flags: Linked
*/
function return_home()
{
	self.isresetting = 1;
	prev_origin = self.trigger.origin;
	self notify(#"reset");
	self move_visuals_to_base();
	self.trigger.origin = self.trigger.baseorigin;
	self.curorigin = self.trigger.origin;
	if(isdefined(self.e_object))
	{
		self.e_object.origin = self.curorigin;
	}
	if(isdefined(self.var_bb7aca0c))
	{
		foreach(var_1bae95c8 in self.var_bb7aca0c)
		{
			if(isdefined(var_1bae95c8) && isdefined(var_1bae95c8.e_object))
			{
				var_1bae95c8.e_object.origin = self.curorigin;
			}
		}
	}
	if(isdefined(self.onreset))
	{
		self [[self.onreset]](prev_origin);
	}
	if(self.type == "carryObject" && isdefined(self.droptrigger))
	{
		if(isdefined(self.carrier))
		{
			if(!isdefined(self.ignore_use_time))
			{
				self.ignore_use_time = [];
			}
			self.ignore_use_time[self.carrier getentitynumber()] = level.time + 500;
			self.carrier sethintstring("");
			if(isdefined(self.trigger) && !self function_4ea98a09() && isdefined(self.trigger.str_hint))
			{
				self.trigger setcursorhint("HINT_NOICON");
				self.trigger sethintstring(self.trigger.str_hint);
			}
		}
		self.droptrigger delete();
	}
	self clear_carrier();
	update_objective();
	self.isresetting = 0;
}

/*
	Name: set_new_base_position
	Namespace: gameobjects
	Checksum: 0xDE7DA3B6
	Offset: 0x3C88
	Size: 0xDA
	Parameters: 2
	Flags: None
*/
function set_new_base_position(v_base_pos, v_angles)
{
	mdl_gameobject = self function_fd4a5f2f();
	foreach(visual in mdl_gameobject.visuals)
	{
		visual.baseorigin = v_base_pos;
		if(isdefined(v_angles))
		{
			visual.baseangles = v_angles;
		}
	}
	mdl_gameobject.trigger.baseorigin = v_base_pos;
}

/*
	Name: is_object_away_from_home
	Namespace: gameobjects
	Checksum: 0xC8CA5AD4
	Offset: 0x3D70
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function is_object_away_from_home()
{
	if(isdefined(self.carrier))
	{
		return 1;
	}
	if(distancesquared(self.trigger.origin, self.trigger.baseorigin) > 4)
	{
		return 1;
	}
	return 0;
}

/*
	Name: set_position
	Namespace: gameobjects
	Checksum: 0x46C71646
	Offset: 0x3DD0
	Size: 0x25A
	Parameters: 2
	Flags: None
*/
function set_position(origin, angles)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.isresetting = 1;
	foreach(visual in mdl_gameobject.visuals)
	{
		visual.origin = origin;
		visual.angles = angles;
		visual dontinterpolate();
		visual show();
	}
	mdl_gameobject.trigger set_trigger_origin(origin);
	mdl_gameobject.curorigin = origin;
	if(isdefined(mdl_gameobject.e_object))
	{
		mdl_gameobject.e_object.origin = origin;
		mdl_gameobject.e_object.angles = angles;
	}
	mdl_gameobject clear_carrier();
	mdl_gameobject update_objective();
	mdl_gameobject.isresetting = 0;
	if(isdefined(mdl_gameobject.var_bb7aca0c))
	{
		foreach(var_1bae95c8 in mdl_gameobject.var_bb7aca0c)
		{
			if(isdefined(var_1bae95c8) && isdefined(var_1bae95c8.e_object))
			{
				var_1bae95c8.e_object.origin = origin;
				var_1bae95c8.e_object.angles = angles;
			}
		}
	}
}

/*
	Name: set_drop_offset
	Namespace: gameobjects
	Checksum: 0xA6A32AAD
	Offset: 0x4038
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function set_drop_offset(height)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.dropoffset = height;
}

/*
	Name: set_trigger_origin
	Namespace: gameobjects
	Checksum: 0x92C3A774
	Offset: 0x4078
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function set_trigger_origin(origin)
{
	offset = self.maxs[2] - self.mins[2] / 2;
	self.origin = (origin[0], origin[1], origin[2] + offset);
	if(isvec(self.trigger_offset))
	{
		self.origin = self.origin + self.trigger_offset;
	}
}

/*
	Name: set_dropped
	Namespace: gameobjects
	Checksum: 0x138DB138
	Offset: 0x4120
	Size: 0x79E
	Parameters: 1
	Flags: Linked
*/
function set_dropped(var_e329a2fa)
{
	if(isdefined(self.carrier) && isdefined(self.objectiveid))
	{
		objective_setvisibletoplayer(self.objectiveid, self.carrier);
	}
	if(self.type == "carryObject" && isdefined(self.droptrigger))
	{
		self.droptrigger delete();
	}
	if(isdefined(self.setdropped))
	{
		if([[self.setdropped]]())
		{
			return;
		}
	}
	if(isdefined(self.var_abcd6a7e))
	{
		self thread [[self.var_abcd6a7e]](var_e329a2fa);
		return;
	}
	self.isresetting = 1;
	self notify(#"dropped");
	startorigin = (0, 0, 0);
	endorigin = (0, 0, 0);
	body = undefined;
	if(isdefined(self.carrier) && self.carrier.team != #"spectator")
	{
		startorigin = self.carrier.origin + vectorscale((0, 0, 1), 20);
		endorigin = self.carrier.origin - vectorscale((0, 0, 1), 2000);
		body = self.carrier.body;
	}
	else if(isdefined(self.safeorigin))
	{
		startorigin = self.safeorigin + vectorscale((0, 0, 1), 20);
		endorigin = self.safeorigin - vectorscale((0, 0, 1), 20);
	}
	else
	{
		startorigin = self.curorigin + vectorscale((0, 0, 1), 20);
		endorigin = self.curorigin - vectorscale((0, 0, 1), 20);
	}
	if(isplayer(var_e329a2fa))
	{
		var_88760a3b = var_e329a2fa;
	}
	else
	{
		var_88760a3b = self.carrier;
	}
	trace_size = 10;
	trace = physicstrace(startorigin, endorigin, (trace_size * -1, trace_size * -1, 0), (trace_size, trace_size, 2 * trace_size), var_88760a3b, 32);
	droppingplayer = var_88760a3b;
	self clear_carrier();
	if(isdefined(trace))
	{
		tempangle = randomfloat(360);
		droporigin = trace[#"position"] + (0, 0, self.dropoffset);
		if(trace[#"fraction"] < 1)
		{
			forward = (cos(tempangle), sin(tempangle), 0);
			forward = vectornormalize(forward - vectorscale(trace[#"normal"], vectordot(forward, trace[#"normal"])));
			if(isdefined(trace[#"walkable"]))
			{
				if(trace[#"walkable"] == 0)
				{
					end_reflect = forward * 1000 + trace[#"position"];
					reflect_trace = physicstrace(trace[#"position"], end_reflect, (trace_size * -1, trace_size * -1, trace_size * -1), (trace_size, trace_size, trace_size), self, 32);
					if(isdefined(reflect_trace))
					{
						droporigin = reflect_trace[#"position"] + (0, 0, self.dropoffset);
						if(reflect_trace[#"fraction"] < 1)
						{
							forward = (cos(tempangle), sin(tempangle), 0);
							forward = vectornormalize(forward - vectorscale(reflect_trace[#"normal"], vectordot(forward, reflect_trace[#"normal"])));
						}
					}
				}
			}
			dropangles = vectortoangles(forward);
		}
		else
		{
			dropangles = (0, tempangle, 0);
		}
		foreach(visual in self.visuals)
		{
			visual animation::stop(0);
			visual.origin = droporigin;
			visual.angles = dropangles;
			visual dontinterpolate();
			visual show();
		}
		self.trigger set_trigger_origin(droporigin);
		self.curorigin = droporigin;
		if(isdefined(self.e_object))
		{
			self.e_object.origin = droporigin;
			self.e_object.angles = dropangles;
		}
		self thread pickup_timeout(trace[#"position"][2], startorigin[2]);
	}
	else
	{
		self move_visuals_to_base();
		self.trigger.origin = self.trigger.baseorigin;
		self.curorigin = self.trigger.baseorigin;
	}
	if(isdefined(self.ondrop))
	{
		self [[self.ondrop]](droppingplayer);
	}
	self.trigger triggerenable(1);
	self update_objective();
	self.isresetting = 0;
}

/*
	Name: set_carrier
	Namespace: gameobjects
	Checksum: 0xDCDE6198
	Offset: 0x48C8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function set_carrier(carrier)
{
	self.carrier = carrier;
	self notify(#"reset");
	if(isdefined(self.objectiveid))
	{
		objective_setplayerusing(self.objectiveid, carrier);
	}
}

/*
	Name: get_carrier
	Namespace: gameobjects
	Checksum: 0x13D3F4AB
	Offset: 0x4928
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function get_carrier()
{
	mdl_gameobject = self function_fd4a5f2f();
	return mdl_gameobject.carrier;
}

/*
	Name: clear_carrier
	Namespace: gameobjects
	Checksum: 0x9541E598
	Offset: 0x4968
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function clear_carrier()
{
	if(!isdefined(self.carrier))
	{
		return;
	}
	self.carrier callback::remove_on_death(&function_19f7be2d);
	self.carrier take_object(self);
	if(isdefined(self.objectiveid))
	{
		objective_clearplayerusing(self.objectiveid, self.carrier);
		objective_setvisibletoplayer(self.objectiveid, self.carrier);
	}
	if(isdefined(self.carrier) && isdefined(self.carrier.var_ea1458aa))
	{
		if(!isdefined(self.carrier.var_ea1458aa.var_cba684c2))
		{
			self.carrier.var_ea1458aa.var_cba684c2 = [];
		}
		self.carrier.var_ea1458aa.var_cba684c2[self getentitynumber()] = 1;
	}
	self.carrier = undefined;
	self notify(#"carrier_cleared");
}

/*
	Name: is_touching_any_trigger
	Namespace: gameobjects
	Checksum: 0x55B47ADA
	Offset: 0x4AB8
	Size: 0xFA
	Parameters: 4
	Flags: Linked
*/
function is_touching_any_trigger(triggers, minz, maxz, var_943e96ce)
{
	foreach(trigger in triggers)
	{
		if(trigger istriggerenabled())
		{
			if(isdefined(var_943e96ce) && var_943e96ce)
			{
				if(istouching(self.origin, trigger))
				{
					return 1;
				}
				continue;
			}
			if(self istouchingswept(trigger, minz, maxz))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: is_touching_any_trigger_key_value
	Namespace: gameobjects
	Checksum: 0x24EB3D5A
	Offset: 0x4BC0
	Size: 0x62
	Parameters: 5
	Flags: Linked
*/
function is_touching_any_trigger_key_value(value, key, minz, maxz, var_943e96ce)
{
	return self is_touching_any_trigger(getentarray(value, key), minz, maxz, var_943e96ce);
}

/*
	Name: should_be_reset
	Namespace: gameobjects
	Checksum: 0xB9B5F621
	Offset: 0x4C30
	Size: 0x212
	Parameters: 2
	Flags: Linked
*/
function should_be_reset(minz, maxz)
{
	if(self.visuals[0] is_touching_any_trigger_key_value("minefield", "targetname", minz, maxz, self.var_ac304f56))
	{
		return 1;
	}
	if(self.visuals[0] is_touching_any_trigger_key_value("trigger_hurt_new", "classname", minz, maxz, self.var_ac304f56))
	{
		return 1;
	}
	level.oob_triggers = array::remove_undefined(level.oob_triggers);
	if(self.visuals[0] is_touching_any_trigger(level.oob_triggers, minz, maxz, self.var_ac304f56))
	{
		return 1;
	}
	if(isdefined(self.var_8c812e0a) && self.var_8c812e0a)
	{
		self.var_8c812e0a = 0;
		return 1;
	}
	elevators = getentarray("script_elevator", "targetname");
	foreach(elevator in elevators)
	{
		/#
			assert(isdefined(elevator.occupy_volume));
		#/
		if(self.visuals[0] istouchingswept(elevator.occupy_volume, minz, maxz))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: pickup_timeout
	Namespace: gameobjects
	Checksum: 0x31830998
	Offset: 0x4E50
	Size: 0x2CC
	Parameters: 2
	Flags: Linked
*/
function pickup_timeout(minz, maxz)
{
	self endon(#"pickup_object", #"reset", #"death");
	waitframe(1);
	if(self should_be_reset(minz, maxz))
	{
		self thread return_home();
		return;
	}
	if(self.var_22389d70 && !ispointonnavmesh(self.visuals[0].origin, 32))
	{
		v_pos = getclosestpointonnavmesh(self.visuals[0].origin, 256, 16);
		if(!isdefined(v_pos) || sessionmodeismultiplayergame() || function_f99d2668())
		{
			self thread return_home();
			return;
		}
		var_b82ff340 = v_pos + (0, 0, self.dropoffset);
		foreach(visual in self.visuals)
		{
			visual animation::stop(0);
			visual.origin = var_b82ff340;
			visual dontinterpolate();
			visual show();
		}
		self.trigger set_trigger_origin(var_b82ff340);
		self.curorigin = var_b82ff340;
		if(isdefined(self.e_object))
		{
			self.e_object.origin = var_b82ff340;
		}
	}
	if(isdefined(self.pickuptimeoutoverride))
	{
		self thread [[self.pickuptimeoutoverride]]();
	}
	else if(isdefined(self.autoresettime))
	{
		wait(self.autoresettime);
		if(!isdefined(self.carrier))
		{
			self thread return_home();
		}
	}
}

/*
	Name: take_object
	Namespace: gameobjects
	Checksum: 0xE756C45F
	Offset: 0x5128
	Size: 0x324
	Parameters: 1
	Flags: Linked
*/
function take_object(object)
{
	if(isdefined(object.visiblecarriermodel))
	{
		self weapons::detach_all_weapons();
	}
	shouldenableweapon = 1;
	if(isdefined(object.carryweapon) && !isdefined(self.player_disconnected))
	{
		shouldenableweapon = 0;
		self thread wait_take_carry_weapon(object.carryweapon);
	}
	if(object.type == "carryObject")
	{
		/#
			if(isdefined(self.carryicon))
			{
				self.carryicon hud::destroyelem();
			}
		#/
		self.carryobject = undefined;
	}
	else if(object.type == "packObject")
	{
		if(isdefined(self.packicon) && self.packicon.size > 0)
		{
			for(i = 0; i < self.packicon.size; i++)
			{
				if(isdefined(self.packicon[i].script_string))
				{
					if(self.packicon[i].script_string == object.packicon)
					{
						elem = self.packicon[i];
						arrayremovevalue(self.packicon, elem);
						/#
							elem hud::destroyelem();
						#/
						self thread adjust_remaining_packicons();
					}
				}
			}
		}
		arrayremovevalue(self.packobject, object);
	}
	if(!isalive(self) || isdefined(self.player_disconnected))
	{
		return;
	}
	self notify(#"drop_object");
	self.disallowvehicleusage = 0;
	if(object.triggertype == "proximity")
	{
		self thread pickup_object_delay(object.trigger.origin);
	}
	if(isdefined(object.visiblecarriermodel))
	{
		self weapons::force_stowed_weapon_update();
	}
	allowweapons = object.allowweapons;
	if(isdefined(object.allowweaponscallback))
	{
		allowweapons = [[object.allowweaponscallback]](object);
	}
	if(!allowweapons && shouldenableweapon)
	{
		self val::reset(#"carry_object", "disable_weapons");
	}
}

/*
	Name: wait_take_carry_weapon
	Namespace: gameobjects
	Checksum: 0xA284AD15
	Offset: 0x5458
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function wait_take_carry_weapon(weapon)
{
	self thread take_carry_weapon_on_death(weapon);
	wait(max(0, weapon.firetime - 2 * float(function_60d95f53()) / 1000));
	self take_carry_weapon(weapon);
}

/*
	Name: take_carry_weapon_on_death
	Namespace: gameobjects
	Checksum: 0xECE525E1
	Offset: 0x54F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function take_carry_weapon_on_death(weapon)
{
	self endon(#"take_carry_weapon");
	self waittill(#"death");
	self take_carry_weapon(weapon);
}

/*
	Name: take_carry_weapon
	Namespace: gameobjects
	Checksum: 0x171C6AF5
	Offset: 0x5548
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function take_carry_weapon(weapon)
{
	self notify(#"take_carry_weapon");
	if(self hasweapon(weapon, 1))
	{
		ballweapon = getweapon(#"ball");
		currweapon = self getcurrentweapon();
		if(weapon == ballweapon && currweapon === ballweapon)
		{
			self killstreaks::switch_to_last_non_killstreak_weapon(undefined, 1);
		}
		self setblockweaponpickup(weapon, 0);
		self takeweapon(weapon);
		self enableweaponcycling();
		if(level.gametype == "ball")
		{
			self enableoffhandweapons();
		}
	}
}

/*
	Name: function_6e870d38
	Namespace: gameobjects
	Checksum: 0x853E2808
	Offset: 0x5688
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_6e870d38(weapon)
{
	/#
		assert(isweapon(weapon), "");
	#/
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.carryweapon = weapon;
}

/*
	Name: function_a8c842d6
	Namespace: gameobjects
	Checksum: 0x58BD1F6F
	Offset: 0x5700
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function function_a8c842d6(var_e13b2d32, var_6a769b70)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.droponusebutton = var_e13b2d32;
	mdl_gameobject.droponusehasdelay = var_6a769b70;
}

/*
	Name: function_98c39cbc
	Namespace: gameobjects
	Checksum: 0x6966293F
	Offset: 0x5760
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_98c39cbc(b_enable)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.var_bee2a129 = b_enable;
	if(b_enable)
	{
		if(isdefined(mdl_gameobject.droponusebutton) && mdl_gameobject.droponusebutton)
		{
			mdl_gameobject.droponusebutton = 0;
		}
		if(isdefined(mdl_gameobject.droponusehasdelay) && mdl_gameobject.droponusehasdelay)
		{
			mdl_gameobject.droponusehasdelay = 0;
		}
	}
}

/*
	Name: track_carrier
	Namespace: gameobjects
	Checksum: 0xE187C89D
	Offset: 0x5810
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function track_carrier(object)
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death", #"drop_object");
	waitframe(1);
	while(isdefined(object.carrier) && object.carrier == self && isalive(self))
	{
		if(self isonground())
		{
			trace = bullettrace(self.origin + vectorscale((0, 0, 1), 20), self.origin - vectorscale((0, 0, 1), 20), 0, undefined);
			if(trace[#"fraction"] < 1)
			{
				object.safeorigin = trace[#"position"];
			}
		}
		waitframe(1);
	}
}

/*
	Name: manual_drop_think
	Namespace: gameobjects
	Checksum: 0x613101EA
	Offset: 0x5960
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function manual_drop_think()
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death", #"drop_object");
	for(;;)
	{
		while(self attackbuttonpressed() || self fragbuttonpressed() || self secondaryoffhandbuttonpressed() || self meleebuttonpressed())
		{
			waitframe(1);
		}
		while(!self attackbuttonpressed() && !self fragbuttonpressed() && !self secondaryoffhandbuttonpressed() && !self meleebuttonpressed())
		{
			waitframe(1);
		}
		if(isdefined(self.carryobject) && !self usebuttonpressed())
		{
			self.carryobject thread set_dropped();
		}
	}
}

/*
	Name: droponusebutton
	Namespace: gameobjects
	Checksum: 0xE911EBD6
	Offset: 0x5AD0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function droponusebutton()
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death", #"drop_object");
	while(self usebuttonpressed())
	{
		waitframe(1);
	}
	while(!self usebuttonpressed())
	{
		waitframe(1);
	}
	if(isdefined(self.carryobject))
	{
		self.carryobject thread set_dropped();
	}
}

/*
	Name: watchholdusedrop
	Namespace: gameobjects
	Checksum: 0x1979DAE
	Offset: 0x5B98
	Size: 0x2D8
	Parameters: 0
	Flags: Linked
*/
function watchholdusedrop()
{
	level endon(#"game_ended");
	self endon(#"death", #"disconnect", #"drop_object");
	/#
		assert(isdefined(self.carryobject));
	#/
	/#
		assert(isdefined(self.carryobject.droptrigger));
	#/
	trigger = self.carryobject.droptrigger;
	while(true)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		if(self usebuttonpressed() && !self.throwinggrenade && !self meleebuttonpressed() && !self attackbuttonpressed() && (!(isdefined(self.isplanting) && self.isplanting)) && (!(isdefined(self.isdefusing) && self.isdefusing)) && !self isremotecontrolling())
		{
			if(isdefined(self.carryobject))
			{
				if(!isdefined(self.carryobject.ignore_use_time))
				{
					self.carryobject.ignore_use_time = [];
				}
				self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
				self sethintstring("");
				if(!self.carryobject function_4ea98a09() && isdefined(self.carryobject.trigger.str_hint))
				{
					self.carryobject.trigger setcursorhint("HINT_NOICON");
					self.carryobject.trigger sethintstring(self.carryobject.trigger.str_hint);
				}
				self.carryobject thread set_dropped();
			}
		}
	}
}

/*
	Name: droponholdusebutton
	Namespace: gameobjects
	Checksum: 0x781FCEF9
	Offset: 0x5E78
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function droponholdusebutton()
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death", #"drop_object");
	if(!isdefined(self.carryobject))
	{
		return;
	}
	while(self usebuttonpressed())
	{
		waitframe(1);
	}
	if(!isdefined(self.carryobject.droptrigger))
	{
		pos = self.origin + vectorscale((0, 0, 1), 15);
		self.carryobject.droptrigger = spawn("trigger_radius_use", pos);
	}
	self.carryobject.droptrigger sethintlowpriority(1);
	self.carryobject.droptrigger sethintstring(#"hash_7944e4820b9c7227");
	self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
	self.carryobject.droptrigger enablelinkto();
	self.carryobject.droptrigger linkto(self, "tag_origin", vectorscale((0, 0, 1), 15));
	self.carryobject.droptrigger setteamfortrigger(self.team);
	self.carryobject.droptrigger setinvisibletoall();
	self.carryobject.droptrigger setvisibletoplayer(self);
	self clientclaimtrigger(self.carryobject.droptrigger);
	self thread watchholdusedrop();
}

/*
	Name: function_2544bab6
	Namespace: gameobjects
	Checksum: 0x323694B8
	Offset: 0x60E8
	Size: 0x286
	Parameters: 0
	Flags: Linked
*/
function function_2544bab6()
{
	level endon(#"game_ended");
	self endon(#"death", #"disconnect", #"drop_object");
	/#
		assert(isdefined(self.carryobject));
	#/
	while(true)
	{
		while(!self usebuttonpressed())
		{
			waitframe(1);
		}
		var_f783260f = gettime();
		while(self usebuttonpressed() && var_f783260f + 500 > gettime())
		{
			waitframe(1);
		}
		if(var_f783260f + 500 <= gettime())
		{
			continue;
		}
		while(!self usebuttonpressed() && var_f783260f + 1000 > gettime())
		{
			waitframe(1);
		}
		if(var_f783260f + 1000 <= gettime())
		{
			continue;
		}
		if(isdefined(self.carryobject))
		{
			if(!isdefined(self.carryobject.ignore_use_time))
			{
				self.carryobject.ignore_use_time = [];
			}
			self.carryobject.ignore_use_time[self getentitynumber()] = level.time + 500;
			self sethintstring("");
			if(!self.carryobject function_4ea98a09() && isdefined(self.carryobject.trigger.str_hint))
			{
				self.carryobject.trigger setcursorhint("HINT_NOICON");
				self.carryobject.trigger sethintstring(self.carryobject.trigger.str_hint);
			}
			self.carryobject thread set_dropped();
		}
		waitframe(1);
	}
}

/*
	Name: function_bee2a129
	Namespace: gameobjects
	Checksum: 0x1FC5DB1
	Offset: 0x6378
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_bee2a129()
{
	level endon(#"game_ended");
	self endon(#"disconnect", #"death", #"drop_object");
	if(!isdefined(self.carryobject))
	{
		return;
	}
	if(!isdefined(self.carryobject.droptrigger))
	{
		pos = self.origin + vectorscale((0, 0, 1), 15);
		self.carryobject.droptrigger = spawn("trigger_radius_use", pos);
	}
	self.carryobject.droptrigger sethintlowpriority(1);
	self.carryobject.droptrigger sethintstring(#"hash_50dd3fca372feb35");
	self.carryobject.droptrigger setcursorhint("HINT_NOICON", self.carryobject);
	self.carryobject.droptrigger enablelinkto();
	self.carryobject.droptrigger linkto(self, "tag_origin", vectorscale((0, 0, 1), 15));
	self.carryobject.droptrigger setteamfortrigger(self.team);
	self.carryobject.droptrigger setinvisibletoall();
	self.carryobject.droptrigger setvisibletoplayer(self);
	self clientclaimtrigger(self.carryobject.droptrigger);
	self thread function_2544bab6();
}

/*
	Name: setup_touching
	Namespace: gameobjects
	Checksum: 0x689B8E95
	Offset: 0x65C8
	Size: 0x15C
	Parameters: 0
	Flags: Linked, Private
*/
private function setup_touching()
{
	self.var_a0ff5eb8 = 0;
	self.touchinguserate[#"neutral"] = 0;
	self.touchinguserate[#"none"] = 0;
	self.numtouching[#"neutral"] = 0;
	self.numtouching[#"none"] = 0;
	self.touchlist[#"neutral"] = [];
	self.touchlist[#"none"] = [];
	foreach(team, _ in level.teams)
	{
		self.touchinguserate[team] = 0;
		self.numtouching[team] = 0;
		self.touchlist[team] = [];
	}
	if(self.var_5c196da4)
	{
		self function_2d29e9a4();
	}
}

/*
	Name: function_2d29e9a4
	Namespace: gameobjects
	Checksum: 0x9F485333
	Offset: 0x6730
	Size: 0xAA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2d29e9a4()
{
	self.var_1dbb2b2b[#"neutral"] = [];
	self.var_1dbb2b2b[#"none"] = [];
	foreach(team, _ in level.teams)
	{
		self.var_1dbb2b2b[team] = [];
	}
}

/*
	Name: create_generic_object
	Namespace: gameobjects
	Checksum: 0xB2E531C6
	Offset: 0x67E8
	Size: 0x32E
	Parameters: 4
	Flags: Linked
*/
function create_generic_object(ownerteam, trigger, visuals, offset)
{
	generic_object = spawn("script_model", trigger.origin);
	generic_object.type = "GenericObject";
	generic_object.curorigin = trigger.origin;
	generic_object.entnum = trigger getentitynumber();
	generic_object.keyobject = undefined;
	generic_object.triggertype = "proximity";
	generic_object.trigger = trigger;
	generic_object linkto(trigger);
	for(index = 0; index < visuals.size; index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}
	generic_object.visuals = visuals;
	generic_object _set_team(ownerteam);
	if(!isdefined(offset))
	{
		offset = (0, 0, 0);
	}
	if(sessionmodeiscampaigngame())
	{
		generic_object.keepweapon = 1;
	}
	generic_object.interactteam = #"none";
	generic_object.onuse = undefined;
	generic_object.oncantuse = undefined;
	generic_object.onresumeuse = undefined;
	generic_object.usetime = 10000;
	generic_object.decayprogress = 0;
	generic_object.var_98bb0715 = 1;
	generic_object.var_5c196da4 = 0;
	generic_object clear_progress();
	if(generic_object.triggertype == "proximity")
	{
		generic_object setup_touching();
		generic_object.teamusetimes = [];
		generic_object.teamusetexts = [];
		generic_object.userate = 0;
		generic_object.claimteam = #"none";
		generic_object.claimplayer = undefined;
		generic_object.lastclaimteam = #"none";
		generic_object.lastclaimtime = 0;
		generic_object.claimgraceperiod = 1;
		generic_object.mustmaintainclaim = 0;
		generic_object.cancontestclaim = 0;
	}
	array::add(level.a_gameobjects, generic_object, 0);
	generic_object.b_reusable = 1;
	return generic_object;
}

/*
	Name: create_use_object
	Namespace: gameobjects
	Checksum: 0x7F4BF4B6
	Offset: 0x6B20
	Size: 0x5B6
	Parameters: 8
	Flags: Linked
*/
function create_use_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0, var_be210c3b = 1)
{
	useobject = spawn("script_model", trigger.origin);
	useobject.type = "useObject";
	useobject.curorigin = trigger.origin;
	useobject.entnum = trigger getentitynumber();
	useobject.keyobject = undefined;
	if(issubstr(trigger.classname, "use"))
	{
		useobject.triggertype = "use";
	}
	else
	{
		useobject.triggertype = "proximity";
	}
	if(visuals.size > 0)
	{
		useobject.angles = visuals[0].angles;
	}
	useobject.trigger = trigger;
	useobject linkto(trigger);
	for(index = 0; index < visuals.size; index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}
	useobject.visuals = visuals;
	useobject _set_team(ownerteam);
	if(!isdefined(offset))
	{
		offset = (0, 0, 0);
	}
	if(sessionmodeiscampaigngame())
	{
		useobject.keepweapon = 1;
	}
	useobject.compassicons = [];
	if(useobject function_4ea98a09())
	{
		/#
			assert(isdefined(objectivename), "");
		#/
		useobject.objid = [];
		useobject.var_f23c87bd = objectivename;
		useobject.var_25010336 = &function_4d047b8d;
		if(isdefined(var_be210c3b) && var_be210c3b)
		{
			useobject enable_object();
		}
	}
	else if(isdefined(useobject.trigger.str_hint))
	{
		useobject.trigger setcursorhint("HINT_NOICON");
		useobject.trigger sethintstring(useobject.trigger.str_hint);
	}
	useobject.interactteam = #"none";
	useobject.worldicons = [];
	useobject.visibleteam = #"none";
	useobject.worldiswaypoint = [];
	useobject.worldicons_disabled = [];
	useobject.onuse = undefined;
	useobject.oncantuse = undefined;
	useobject.onresumeuse = undefined;
	useobject.usetext = "default";
	useobject.usetime = 10000;
	useobject.decayprogress = 0;
	useobject.var_98bb0715 = 1;
	useobject.var_5c196da4 = 1;
	useobject.curprogress = 0;
	useobject.decayprogressmin = 0;
	if(useobject.triggertype == "proximity")
	{
		useobject setup_touching();
		useobject.teamusetimes = [];
		useobject.teamusetexts = [];
		useobject.userate = 0;
		useobject.claimteam = #"none";
		useobject.claimplayer = undefined;
		useobject.lastclaimteam = #"none";
		useobject.lastclaimtime = 0;
		useobject.claimgraceperiod = 1;
		useobject.mustmaintainclaim = 0;
		useobject.cancontestclaim = 0;
		useobject thread use_object_prox_think();
	}
	else
	{
		useobject.userate = 1;
		useobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
	}
	useobject clear_progress();
	array::add(level.a_gameobjects, useobject, 0);
	useobject.b_reusable = 1;
	return useobject;
}

/*
	Name: function_4d047b8d
	Namespace: gameobjects
	Checksum: 0x8AD47393
	Offset: 0x70E0
	Size: 0x184
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4d047b8d()
{
	useobject = self;
	/#
		assert(isdefined(useobject.var_f23c87bd));
	#/
	/#
		assert(!isdefined(useobject.objectiveid));
	#/
	useobject.objectiveid = get_next_obj_id();
	objective_add(useobject.objectiveid, "invisible", useobject, useobject.var_f23c87bd);
	requiredspecialty = objective_getrequiredspecialty(useobject.var_f23c87bd);
	if(isdefined(useobject.trigger) && isdefined(requiredspecialty) && requiredspecialty != "None")
	{
		useobject.trigger setperkfortrigger(requiredspecialty);
	}
	var_af6e4895 = function_1fce1758(useobject.objectiveid);
	if(isdefined(var_af6e4895))
	{
		useobject.var_af6e4895 = getweapon(var_af6e4895);
		useobject.trigger function_ca21f900(useobject.var_af6e4895);
	}
}

/*
	Name: set_key_object
	Namespace: gameobjects
	Checksum: 0x9D064455
	Offset: 0x7270
	Size: 0x12E
	Parameters: 1
	Flags: Linked
*/
function set_key_object(object)
{
	mdl_gameobject = self function_fd4a5f2f();
	object = object function_fd4a5f2f();
	if(!isdefined(object))
	{
		mdl_gameobject.keyobject = undefined;
		return;
	}
	if(!isdefined(mdl_gameobject.keyobject))
	{
		mdl_gameobject.keyobject = [];
	}
	if(isarray(object))
	{
		foreach(obj in object)
		{
			mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = obj;
		}
	}
	else
	{
		mdl_gameobject.keyobject[mdl_gameobject.keyobject.size] = object;
	}
}

/*
	Name: function_fe788e71
	Namespace: gameobjects
	Checksum: 0xB02AFB50
	Offset: 0x73A8
	Size: 0x15E
	Parameters: 1
	Flags: None
*/
function function_fe788e71(object)
{
	mdl_gameobject = self function_fd4a5f2f();
	object = object function_fd4a5f2f();
	if(!isdefined(mdl_gameobject.keyobject))
	{
		return;
	}
	mdl_gameobject.keyobject = array::remove_undefined(mdl_gameobject.keyobject, 0);
	if(isarray(object))
	{
		foreach(obj in object)
		{
			arrayremovevalue(mdl_gameobject.keyobject, obj, 0);
		}
	}
	else
	{
		arrayremovevalue(mdl_gameobject.keyobject, object, 0);
	}
	if(!mdl_gameobject.keyobject.size)
	{
		mdl_gameobject.keyobject = undefined;
	}
}

/*
	Name: has_key_object
	Namespace: gameobjects
	Checksum: 0xAE21FDEE
	Offset: 0x7510
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function has_key_object(use)
{
	if(!isdefined(use.keyobject))
	{
		return 0;
	}
	for(x = 0; x < use.keyobject.size; x++)
	{
		if(isdefined(self.carryobject) && self.carryobject == use.keyobject[x])
		{
			return 1;
		}
		if(isdefined(self.packobject))
		{
			for(i = 0; i < self.packobject.size; i++)
			{
				if(self.packobject[i] == use.keyobject[x])
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_e7e3d146
	Namespace: gameobjects
	Checksum: 0x9F96009E
	Offset: 0x7600
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_e7e3d146(b_enable = 1)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.var_c0eeec46 = b_enable;
}

/*
	Name: function_f4ccb04c
	Namespace: gameobjects
	Checksum: 0xC3652A72
	Offset: 0x7658
	Size: 0x90
	Parameters: 2
	Flags: None
*/
function function_f4ccb04c(e_player, var_5098afd6 = 0)
{
	mdl_gameobject = self function_fd4a5f2f();
	e_player.var_17bc9194 = 1;
	mdl_gameobject.trigger notify(#"trigger", {#forced:var_5098afd6, #activator:e_player});
}

/*
	Name: use_object_use_think
	Namespace: gameobjects
	Checksum: 0x926D1C64
	Offset: 0x76F0
	Size: 0x5B8
	Parameters: 2
	Flags: Linked
*/
function use_object_use_think(disableinitialholddelay, disableweaponcyclingduringhold)
{
	self.trigger.mdl_gameobject = self;
	self.trigger endon(#"destroyed", #"death");
	if(self.usetime > 0 && disableinitialholddelay)
	{
		self.trigger usetriggerignoreuseholdtime();
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self.trigger waittill(#"trigger");
		player = waitresult.activator;
		if(level.gameended)
		{
			continue;
		}
		if(!self function_a34c1761(player) && (!(isdefined(waitresult.forced) && waitresult.forced)))
		{
			continue;
		}
		if(!self can_interact_with(player) && (!(isdefined(waitresult.forced) && waitresult.forced)))
		{
			continue;
		}
		if(!(isdefined(self.var_33d50507) && self.var_33d50507))
		{
			if(!player isonground() && !player isplayerswimming() || player iswallrunning() && (!(isdefined(waitresult.forced) && waitresult.forced)))
			{
				continue;
			}
		}
		if(isdefined(self.keyobject) && !player has_key_object(self))
		{
			if(isdefined(self.oncantuse))
			{
				self [[self.oncantuse]](player);
			}
			continue;
		}
		self notify(#"engaged");
		result = 1;
		if(self.usetime > 0)
		{
			self thread play_interact_anim(player);
			self apply_player_use_modifiers(player);
			if(isdefined(self.onbeginuse))
			{
				if(isdefined(self.classobj))
				{
					self.classobj [[self.onbeginuse]](self, player);
				}
				else
				{
					self [[self.onbeginuse]](player);
				}
			}
			team = player.pers[#"team"];
			result = self use_hold_think(player, disableweaponcyclingduringhold);
			self remove_player_use_modifiers(player);
			if(isdefined(self.onenduse))
			{
				if(isdefined(self.classobj))
				{
					self.classobj [[self.onenduse]](self, team, player, result);
				}
				else
				{
					self [[self.onenduse]](team, player, result);
				}
			}
		}
		if(isdefined(self.e_object) && (isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad))
		{
			self.e_object thread function_49184ad0(team, player, result);
		}
		if(!(isdefined(result) && result))
		{
			self notify(#"gameobject_abort");
			if(isdefined(self.e_object))
			{
				self.e_object notify(#"gameobject_abort");
			}
			continue;
		}
		if(isdefined(self.e_object))
		{
			if(!self.e_object flag::exists("gameobject_end_use"))
			{
				self.e_object flag::init("gameobject_end_use");
			}
			self.e_object flag::set("gameobject_end_use");
		}
		potm::bookmark(#"interact", gettime(), player);
		self notify(#"gameobject_end_use_player", {#player:player});
		if(isdefined(self.onuse))
		{
			if(isdefined(self.onuse_thread) && self.onuse_thread)
			{
				self thread use_object_onuse(player);
			}
			else
			{
				self use_object_onuse(player);
			}
		}
		if(self.type == "carryObject" || self.type === "packObject")
		{
			self set_picked_up(player);
		}
		self check_gameobject_reenable();
	}
}

/*
	Name: use_object_onuse
	Namespace: gameobjects
	Checksum: 0x3B2ADAC
	Offset: 0x7CB0
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function use_object_onuse(player)
{
	level endon(#"game_ended");
	self.trigger endon(#"destroyed", #"death");
	if(isdefined(self.classobj))
	{
		self.classobj [[self.onuse]](self, player);
	}
	else
	{
		self [[self.onuse]](player);
	}
}

/*
	Name: get_earliest_claim_player
	Namespace: gameobjects
	Checksum: 0x62C6A4C5
	Offset: 0x7D48
	Size: 0x12A
	Parameters: 0
	Flags: Linked
*/
function get_earliest_claim_player()
{
	/#
		assert(self.claimteam != #"none");
	#/
	team = self.claimteam;
	earliestplayer = self.claimplayer;
	if(self.touchlist[team].size > 0)
	{
		earliesttime = undefined;
		foreach(touchdata in self.touchlist[team])
		{
			if(!isdefined(earliesttime) || touchdata.starttime < earliesttime)
			{
				earliestplayer = touchdata.player;
				earliesttime = touchdata.starttime;
			}
		}
	}
	return earliestplayer;
}

/*
	Name: apply_player_use_modifiers
	Namespace: gameobjects
	Checksum: 0x92B1BBA2
	Offset: 0x7E80
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function apply_player_use_modifiers(e_player)
{
	if(isdefined(level.var_4e3ded37))
	{
		e_player [[level.var_4e3ded37]]();
	}
}

/*
	Name: remove_player_use_modifiers
	Namespace: gameobjects
	Checksum: 0x5BC51E47
	Offset: 0x7EB8
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function remove_player_use_modifiers(e_player)
{
	if(isdefined(level.var_4dbea2a4))
	{
		e_player [[level.var_4dbea2a4]]();
	}
}

/*
	Name: function_76f3a4cd
	Namespace: gameobjects
	Checksum: 0x2A06CA5E
	Offset: 0x7EF0
	Size: 0x68
	Parameters: 0
	Flags: Linked, Private
*/
private function function_76f3a4cd()
{
	if(self.cancontestclaim)
	{
		num = function_740d5aae(self.claimteam);
		numother = get_num_touching_except_team(self.claimteam);
		if(num && numother)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_4783042a
	Namespace: gameobjects
	Checksum: 0x7991FE46
	Offset: 0x7F60
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4783042a()
{
	if(isdefined(self.oncontested))
	{
		self [[self.oncontested]]();
	}
	if(!self.decayprogress || self.curprogress == 0)
	{
		self set_claim_team(#"none");
		self.claimplayer = undefined;
	}
}

/*
	Name: function_72307b09
	Namespace: gameobjects
	Checksum: 0xCE97FE52
	Offset: 0x7FD0
	Size: 0x198
	Parameters: 1
	Flags: Linked, Private
*/
private function function_72307b09(progress)
{
	if(!self.var_5c196da4 || !progress)
	{
		return;
	}
	if(0 > progress)
	{
		foreach(var_e7b2b71b in self.var_1dbb2b2b[self.claimteam])
		{
			var_e7b2b71b.contribution = math::clamp(var_e7b2b71b.contribution + progress, 0, self.usetime);
		}
	}
	else
	{
		keys = getarraykeys(self.touchlist[self.claimteam]);
		for(i = 0; i < keys.size; i++)
		{
			self.var_1dbb2b2b[self.claimteam][keys[i]].contribution = math::clamp(self.var_1dbb2b2b[self.claimteam][keys[i]].contribution + progress, 0, self.usetime);
		}
	}
}

/*
	Name: function_1b4d64d8
	Namespace: gameobjects
	Checksum: 0xD5FA6448
	Offset: 0x8170
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_1b4d64d8(enabled)
{
	self.var_79f2beba = enabled;
}

/*
	Name: use_object_prox_think
	Namespace: gameobjects
	Checksum: 0x3F25086D
	Offset: 0x8198
	Size: 0xF08
	Parameters: 0
	Flags: Linked
*/
function use_object_prox_think()
{
	level endon(#"game_ended");
	self.trigger endon(#"destroyed", #"death");
	self thread prox_trigger_think();
	while(true)
	{
		if(self.usetime && self.curprogress >= self.usetime || (self.usetime <= 0 && self.numtouching[self.claimteam] > 0))
		{
			creditplayer = get_earliest_claim_player();
			if(isdefined(self.onenduse))
			{
				if(isdefined(self.classobj))
				{
					self.classobj [[self.onenduse]](self, self get_claim_team(), creditplayer, isdefined(creditplayer));
				}
				else
				{
					self [[self.onenduse]](self get_claim_team(), creditplayer, isdefined(creditplayer));
				}
			}
			if(isdefined(self.e_object))
			{
				if(!self.e_object flag::exists("gameobject_end_use"))
				{
					self.e_object flag::init("gameobject_end_use");
				}
				self.e_object flag::set("gameobject_end_use");
				if(isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad)
				{
					self.e_object thread function_49184ad0(self get_claim_team(), creditplayer, isdefined(creditplayer));
				}
			}
			if(isdefined(creditplayer))
			{
				self notify(#"gameobject_end_use_player", {#player:creditplayer});
			}
			if(isdefined(creditplayer) && isdefined(self.onuse))
			{
				if(isdefined(self.classobj))
				{
					self.classobj [[self.onuse]](self, creditplayer);
				}
				else
				{
					self [[self.onuse]](creditplayer);
				}
			}
			self clear_progress();
			if(!self.mustmaintainclaim)
			{
				self set_claim_team(#"none");
				self.claimplayer = undefined;
			}
			self thread check_gameobject_reenable();
			if(isdefined(creditplayer) && (self.type == "carryObject" || self.type === "packObject"))
			{
				self set_picked_up(creditplayer);
			}
		}
		previousprogress = self.curprogress;
		if(self.claimteam != #"none")
		{
			if(self use_object_locked_for_team(self.claimteam))
			{
				if(isdefined(self.onenduse))
				{
					if(isdefined(self.classobj))
					{
						self.classobj [[self.onenduse]](self, self get_claim_team(), self.claimplayer, 0);
					}
					else
					{
						self [[self.onenduse]](self get_claim_team(), self.claimplayer, 0);
					}
				}
				if(isdefined(self.e_object) && (isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad))
				{
					self.e_object thread function_49184ad0(self get_claim_team(), self.claimplayer, 0);
				}
				self clear_progress();
				self set_claim_team(#"none");
				self.claimplayer = undefined;
			}
			else if(self.usetime && (!self.mustmaintainclaim || self get_owner_team() != self get_claim_team()))
			{
				if(self.decayprogress && !self.numtouching[self.claimteam])
				{
					if(isdefined(self.var_5fefcd28) && self.var_5fefcd28 > 0 && self.curprogress > 0)
					{
						self.curprogress = self.curprogress - level.var_9fee970c * self.usetime / int(self.var_5fefcd28 * 1000);
						deltaprogress = self.curprogress - previousprogress;
						function_72307b09(deltaprogress);
						self update_current_progress();
						if(self.curprogress <= 0)
						{
							self clear_progress();
						}
						previousprogress = self.curprogress;
					}
					self.inuse = 0;
					hadprogress = self.curprogress > 0;
					if(isdefined(self.claimplayer))
					{
						if(isdefined(self.onenduse))
						{
							if(isdefined(self.classobj))
							{
								self.classobj [[self.onenduse]](self, self get_claim_team(), self.claimplayer, 0);
							}
							else
							{
								self [[self.onenduse]](self get_claim_team(), self.claimplayer, 0);
							}
						}
						if(isdefined(self.e_object) && (isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad))
						{
							self.e_object thread function_49184ad0(self get_claim_team(), self.claimplayer, 0);
						}
						self.claimplayer = undefined;
					}
					decayscale = 0;
					if(self.var_98bb0715 && isdefined(self.decaytime) && self.decaytime > 0)
					{
						decayscale = self.usetime / self.decaytime;
					}
					self.curprogress = self.curprogress - level.var_9fee970c * self.userate * decayscale;
					deltaprogress = self.curprogress - previousprogress;
					function_72307b09(deltaprogress);
					if(isdefined(self.decayprogressmin) && self.curprogress < self.decayprogressmin)
					{
						self.curprogress = self.decayprogressmin;
					}
					if(self.curprogress <= 0)
					{
						self clear_progress();
					}
					self update_current_progress();
					if(isdefined(self.onuseupdate))
					{
						self [[self.onuseupdate]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
					}
					if(isdefined(self.var_ff74c7e9))
					{
						self [[self.var_ff74c7e9]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
					}
					if(self.curprogress == 0)
					{
						if(self.claimteam != #"none")
						{
							self set_claim_team(#"none");
						}
					}
					if(isdefined(hadprogress) && hadprogress && isdefined(self.ondecaycomplete) && self.curprogress <= (isdefined(self.decayprogressmin) ? self.decayprogressmin : 0))
					{
						self [[self.ondecaycomplete]]();
					}
				}
				else if(!self.numtouching[self.claimteam])
				{
					self.inuse = 0;
					if(isdefined(self.onenduse))
					{
						if(isdefined(self.classobj))
						{
							self.classobj [[self.onenduse]](self, self get_claim_team(), self.claimplayer, 0);
						}
						else
						{
							self [[self.onenduse]](self get_claim_team(), self.claimplayer, 0);
						}
					}
					if(isdefined(self.e_object) && (isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad))
					{
						self.e_object thread function_49184ad0(self get_claim_team(), self.claimplayer, 0);
					}
					self set_claim_team(#"none");
					self.claimplayer = undefined;
				}
				else if(function_76f3a4cd())
				{
					function_4783042a();
				}
				else
				{
					self.inuse = 1;
					self.curprogress = self.curprogress + level.var_9fee970c * self.userate;
					deltaprogress = self.curprogress - previousprogress;
					function_72307b09(deltaprogress);
					self update_current_progress();
					if(isdefined(self.onuseupdate))
					{
						self [[self.onuseupdate]](self get_claim_team(), self.curprogress / self.usetime, level.var_9fee970c * self.userate / self.usetime);
					}
					if(isdefined(self.var_ff74c7e9))
					{
						self [[self.var_ff74c7e9]](self get_claim_team(), self.curprogress / self.usetime, level.var_9fee970c * self.userate / self.usetime);
					}
				}
			}
			else if(!self.mustmaintainclaim)
			{
				if(isdefined(self.onuse))
				{
					self use_object_onuse(self.claimplayer);
				}
				if(!self.mustmaintainclaim && self.claimteam != #"none")
				{
					self set_claim_team(#"none");
					self.claimplayer = undefined;
				}
			}
			else if(!self.numtouching[self.claimteam])
			{
				self.inuse = 0;
				if(isdefined(self.onunoccupied))
				{
					self [[self.onunoccupied]]();
				}
				self set_claim_team(#"none");
				self.claimplayer = undefined;
			}
			else if(function_76f3a4cd())
			{
				function_4783042a();
			}
		}
		else if(!self.decayprogress && self.curprogress > 0 && self.var_79f2beba !== 1 && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000))
		{
			self clear_progress();
		}
		if(self.mustmaintainclaim && self get_owner_team() != #"none")
		{
			if(!self.numtouching[self get_owner_team()])
			{
				self.inuse = 0;
				if(isdefined(self.onunoccupied))
				{
					self [[self.onunoccupied]]();
				}
			}
			else if(self.cancontestclaim && self.lastclaimteam != #"none" && self.numtouching[self.lastclaimteam])
			{
				numother = get_num_touching_except_team(self.lastclaimteam);
				if(numother == 0)
				{
					if(isdefined(self.onuncontested))
					{
						self [[self.onuncontested]](self.lastclaimteam);
					}
				}
			}
		}
		else if(function_76f3a4cd())
		{
			function_4783042a();
		}
		waitframe(1);
		hostmigration::waittillhostmigrationdone();
	}
}

/*
	Name: check_gameobject_reenable
	Namespace: gameobjects
	Checksum: 0xE53C4594
	Offset: 0x90A8
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function check_gameobject_reenable()
{
	self endon(#"death");
	if(isdefined(self.e_object) && (isdefined(self.b_reusable) && self.b_reusable))
	{
		self.e_object endon(#"death");
		if(!self.e_object flag::exists("gameobject_end_use"))
		{
			self.e_object flag::init("gameobject_end_use");
		}
		if(isdefined(self.b_auto_reenable) && self.b_auto_reenable)
		{
			self disable_object();
			wait(1);
			self.e_object flag::clear("gameobject_end_use");
			self enable_object();
		}
		else
		{
			waittillframeend();
			self.e_object flag::clear("gameobject_end_use");
		}
	}
	if(isdefined(self.keyobject) && (isdefined(self.var_c0eeec46) && self.var_c0eeec46))
	{
		foreach(mdl_key in self.keyobject)
		{
			mdl_key destroy_object(1, 1);
		}
	}
	if(!(isdefined(self.b_reusable) && self.b_reusable))
	{
		self.e_object flagsys::set(#"hash_3c75783d64e76e20");
		util::wait_network_frame();
		self thread destroy_object(1, 1);
	}
}

/*
	Name: use_object_locked_for_team
	Namespace: gameobjects
	Checksum: 0x46593A42
	Offset: 0x92F8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function use_object_locked_for_team(team)
{
	team = util::get_team_mapping(team);
	if(isdefined(self.teamlock) && isdefined(level.teams[team]))
	{
		return self.teamlock[team];
	}
	return 0;
}

/*
	Name: can_claim
	Namespace: gameobjects
	Checksum: 0x4C1EDF40
	Offset: 0x9360
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function can_claim(sentient)
{
	if(isdefined(self.carrier))
	{
		return 0;
	}
	if(self.cancontestclaim)
	{
		numother = get_num_touching_except_team(sentient.team);
		if(numother != 0)
		{
			return 0;
		}
	}
	if(!isdefined(self.keyobject) || sentient has_key_object(self))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_dfec159b
	Namespace: gameobjects
	Checksum: 0x3E4467BC
	Offset: 0x93F8
	Size: 0x18A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dfec159b(player)
{
	if(!isalive(player) || self use_object_locked_for_team(player.pers[#"team"]))
	{
		return 0;
	}
	if(isdefined(player.laststand) && player.laststand && (!(isdefined(player.var_de39e480) && player.var_de39e480)) && (!(isdefined(player.var_4835f0a0) && player.var_4835f0a0)))
	{
		return 0;
	}
	if(player.spawntime == gettime())
	{
		return 0;
	}
	if(isdefined(player.selectinglocation) && player.selectinglocation && self.triggertype === "use")
	{
		return 0;
	}
	if(player isweaponviewonlylinked())
	{
		return 0;
	}
	if(!(isdefined(self.cancontestclaim) && self.cancontestclaim) && isdefined(self.keyobject) && !player has_key_object(self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_bbb55f41
	Namespace: gameobjects
	Checksum: 0x21E7BAA0
	Offset: 0x9590
	Size: 0x1E2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bbb55f41(sentient)
{
	if(!self can_interact_with(sentient))
	{
		return 0;
	}
	if(self.claimteam == #"none")
	{
		if(self can_claim(sentient))
		{
			set_claim_team(sentient.team);
			self.claimplayer = sentient;
			relativeteam = self get_relative_team(sentient.team);
			if(isdefined(self.teamusetimes[relativeteam]))
			{
				self.usetime = self.teamusetimes[relativeteam];
			}
			self notify(#"engaged");
			self.inuse = 1;
			if(self.usetime && isdefined(self.onbeginuse))
			{
				if(isdefined(self.classobj))
				{
					self.classobj [[self.onbeginuse]](self, self.claimplayer);
				}
				else
				{
					self [[self.onbeginuse]](self.claimplayer);
				}
			}
		}
		else if(isdefined(self.oncantuse))
		{
			self [[self.oncantuse]](sentient);
		}
	}
	else if(self.claimteam == sentient.team && self can_claim(sentient) && self.numtouching[self.claimteam] == 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: prox_trigger_think
	Namespace: gameobjects
	Checksum: 0xB266ABE8
	Offset: 0x9780
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function prox_trigger_think()
{
	level endon(#"game_ended");
	self.trigger endon(#"destroyed", #"death");
	entitynumber = self.entnum;
	while(true)
	{
		waitresult = undefined;
		waitresult = self.trigger waittill(#"trigger");
		sentient = waitresult.activator;
		if(!self function_a34c1761(sentient) || !isdefined(sentient.touchtriggers))
		{
			continue;
		}
		resume_use = self function_bbb55f41(sentient);
		if(isalive(sentient) && !isdefined(sentient.touchtriggers[entitynumber]))
		{
			sentient thread trigger_touch_think(self);
			if(resume_use && isdefined(self.onresumeuse))
			{
				self [[self.onresumeuse]](sentient);
			}
		}
	}
}

/*
	Name: is_excluded
	Namespace: gameobjects
	Checksum: 0x2FF871F8
	Offset: 0x98F8
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function is_excluded(sentient)
{
	if(!isdefined(self.exclusions))
	{
		return 0;
	}
	foreach(exclusion in self.exclusions)
	{
		if(isdefined(exclusion) && sentient function_59e66d9(exclusion))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: clear_progress
	Namespace: gameobjects
	Checksum: 0x8AE623C1
	Offset: 0x99B0
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function clear_progress()
{
	self.curprogress = 0;
	self.decayprogressmin = 0;
	self update_current_progress();
	if(isdefined(self.onuseclear))
	{
		self [[self.onuseclear]]();
	}
}

/*
	Name: function_98aae7cf
	Namespace: gameobjects
	Checksum: 0xF99EC55F
	Offset: 0x9A00
	Size: 0xDE
	Parameters: 0
	Flags: None
*/
function function_98aae7cf()
{
	if(!isdefined(self.var_1dbb2b2b))
	{
		return;
	}
	foreach(var_1dbb2b2b in self.var_1dbb2b2b)
	{
		foreach(var_9b38d2c0 in var_1dbb2b2b)
		{
			var_9b38d2c0.contribution = 0;
		}
	}
}

/*
	Name: function_3510971a
	Namespace: gameobjects
	Checksum: 0xDED07A60
	Offset: 0x9AE8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_3510971a(enabled)
{
	self.var_5083077c = enabled;
}

/*
	Name: set_claim_team
	Namespace: gameobjects
	Checksum: 0xB668E781
	Offset: 0x9B10
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function set_claim_team(newteam)
{
	/#
		assert(newteam != self.claimteam);
	#/
	if(self.var_5083077c !== 1)
	{
		if(!self.decayprogress && self.claimteam == #"none" && gettime() - self.lastclaimtime > int(self.claimgraceperiod * 1000))
		{
			self clear_progress();
		}
		else if(newteam != #"none" && newteam != self.lastclaimteam)
		{
			self clear_progress();
		}
	}
	self.lastclaimteam = self.claimteam;
	self.lastclaimtime = gettime();
	self.claimteam = newteam;
	self update_use_rate();
}

/*
	Name: get_claim_team
	Namespace: gameobjects
	Checksum: 0x7AC698A1
	Offset: 0x9C40
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_claim_team()
{
	return self.claimteam;
}

/*
	Name: function_59e66d9
	Namespace: gameobjects
	Checksum: 0xF5183E0
	Offset: 0x9C58
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_59e66d9(trigger)
{
	return self istouching(trigger);
}

/*
	Name: continue_trigger_touch_think
	Namespace: gameobjects
	Checksum: 0x994AC605
	Offset: 0x9C88
	Size: 0x1EE
	Parameters: 2
	Flags: Linked
*/
function continue_trigger_touch_think(team, object)
{
	if(!isalive(self))
	{
		return 0;
	}
	var_47a62b7b = isvehicle(self) || (isplayer(self) && self isinvehicle() && !self function_a867284b());
	if(var_47a62b7b && (!(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup)) && (!(isdefined(object.b_allow_vehicle_proximity_pickup) && object.b_allow_vehicle_proximity_pickup)))
	{
		return 0;
	}
	if(self use_object_locked_for_team(team))
	{
		return 0;
	}
	if(isdefined(self.laststand) && self.laststand && (!(isdefined(self.var_de39e480) && self.var_de39e480)) && (!(isdefined(self.var_4835f0a0) && self.var_4835f0a0)))
	{
		return 0;
	}
	if(!isdefined(object) || !isdefined(object.trigger))
	{
		return 0;
	}
	if(!object.trigger istriggerenabled())
	{
		return 0;
	}
	if(!object function_a34c1761(self))
	{
		return 0;
	}
	if(!self function_59e66d9(object.trigger))
	{
		return 0;
	}
	return 1;
}

/*
	Name: setplayergametypeuseratecallback
	Namespace: gameobjects
	Checksum: 0xC81BD733
	Offset: 0x9E80
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function setplayergametypeuseratecallback(callbackfunc)
{
	self.gametypeuseratecallback = callbackfunc;
}

/*
	Name: allow_vehicle_proximity_pickup
	Namespace: gameobjects
	Checksum: 0x640326BE
	Offset: 0x9EA8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function allow_vehicle_proximity_pickup(b_enable)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.b_allow_vehicle_proximity_pickup = b_enable;
}

/*
	Name: trigger_touch_think
	Namespace: gameobjects
	Checksum: 0xBF58F0C4
	Offset: 0x9EE8
	Size: 0x6DC
	Parameters: 1
	Flags: Linked
*/
function trigger_touch_think(object)
{
	object.trigger endon(#"destroyed", #"death");
	team = self.team;
	score = 1;
	player_use_rate = 1;
	object.numtouching[team] = object.numtouching[team] + score;
	if(isdefined(self.playerrole) && isdefined(self.playerrole.gameobjectuserate))
	{
		player_use_rate = self.playerrole.gameobjectuserate;
	}
	if(isdefined(self.gametypeuseratecallback))
	{
		player_use_rate = player_use_rate * self [[self.gametypeuseratecallback]](object);
	}
	object.touchinguserate[team] = object.touchinguserate[team] + player_use_rate;
	touchname = self getentitynumber();
	struct = spawnstruct();
	struct.player = self;
	struct.starttime = gettime();
	struct.userate = player_use_rate;
	object.touchlist[team][touchname] = struct;
	if(object.var_5c196da4)
	{
		if(isdefined(object.var_1dbb2b2b[team][touchname]))
		{
			var_f25f27fb = object.var_1dbb2b2b[team][touchname];
			if(!isdefined(var_f25f27fb.player))
			{
				var_f25f27fb.player = self;
			}
		}
		else
		{
			var_f25f27fb = spawnstruct();
			var_f25f27fb.player = self;
			var_f25f27fb.contribution = 0;
			object.var_1dbb2b2b[team][touchname] = var_f25f27fb;
		}
		var_f25f27fb.starttime = gettime();
		var_f25f27fb.var_e22ea52b = 1;
	}
	if(object.usetime)
	{
		object update_use_rate();
	}
	if(isdefined(object.objectiveid) && object.type != "carryObject")
	{
		if(isplayer(self))
		{
			objective_setplayerusing(object.objectiveid, self);
		}
		else
		{
			objective_setplayerusing(object.objectiveid, self.owner);
		}
	}
	self.touchtriggers[object.entnum] = object.trigger;
	if(isdefined(object.ontouchuse))
	{
		object [[object.ontouchuse]](self);
	}
	if(isdefined(self.var_17bc9194) && self.var_17bc9194)
	{
		object.curprogress = object.usetime + 1;
		object.numtouching[object.claimteam] = 1;
		self.var_17bc9194 = undefined;
		while(object.curprogress >= 1)
		{
			waitframe(1);
		}
	}
	else if(object.usetime == 0 && level.var_c85170d1 === 1)
	{
		object update_use_rate();
	}
	while(self continue_trigger_touch_think(team, object))
	{
		waitframe(1);
	}
	if(isdefined(self))
	{
		self.touchtriggers[object.entnum] = undefined;
		if(isdefined(object.objectiveid) && object.type != "carryObject")
		{
			if(isplayer(self))
			{
				objective_clearplayerusing(object.objectiveid, self);
			}
			else
			{
				objective_clearplayerusing(object.objectiveid, self.owner);
			}
		}
	}
	else if(isdefined(object.var_1dbb2b2b) && isdefined(object.var_1dbb2b2b[team]))
	{
		object.var_1dbb2b2b[team][touchname] = undefined;
	}
	if(level.gameended)
	{
		return;
	}
	if(isdefined(var_f25f27fb))
	{
		var_f25f27fb.var_e22ea52b = 0;
	}
	object.touchlist[team][touchname] = undefined;
	object.numtouching[team] = object.numtouching[team] - score;
	object.touchinguserate[team] = object.touchinguserate[team] - player_use_rate;
	if(object.numtouching[team] < 1)
	{
		object.numtouching[team] = 0;
		object.touchinguserate[team] = 0;
	}
	if(object.usetime)
	{
		if(object.numtouching[team] <= 0 && object.curprogress >= object.usetime)
		{
			object.curprogress = object.usetime - 1;
			object update_current_progress();
		}
	}
	if(isdefined(self) && isdefined(object.onendtouchuse))
	{
		object [[object.onendtouchuse]](self);
	}
	object update_use_rate();
}

/*
	Name: get_num_touching_except_team
	Namespace: gameobjects
	Checksum: 0x176E8C4A
	Offset: 0xA5D0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function get_num_touching_except_team(ignoreteam)
{
	numtouching = 0;
	foreach(team, _ in level.teams)
	{
		if(ignoreteam == team)
		{
			continue;
		}
		numtouching = numtouching + self.numtouching[team];
	}
	return numtouching;
}

/*
	Name: function_740d5aae
	Namespace: gameobjects
	Checksum: 0xF9739094
	Offset: 0xA688
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_740d5aae(team)
{
	return self.numtouching[team];
}

/*
	Name: get_touching_use_rate_except_team
	Namespace: gameobjects
	Checksum: 0xFB3E2566
	Offset: 0xA6A8
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function get_touching_use_rate_except_team(ignoreteam)
{
	numtouching = 0;
	foreach(team, _ in level.teams)
	{
		if(ignoreteam == team)
		{
			continue;
		}
		numtouching = numtouching + get_team_use_rate(team);
	}
	return numtouching;
}

/*
	Name: get_team_use_rate
	Namespace: gameobjects
	Checksum: 0xB5389D3D
	Offset: 0xA760
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function get_team_use_rate(team)
{
	if(self.var_a0ff5eb8)
	{
		useobject = self;
		userate = 0;
		if(useobject.touchlist[team].size > 0)
		{
			foreach(touchdata in useobject.touchlist[team])
			{
				if(isdefined(touchdata.userate) && touchdata.userate > userate)
				{
					userate = touchdata.userate;
				}
			}
		}
	}
	else
	{
		userate = self.touchinguserate[team];
	}
	return userate;
}

/*
	Name: update_use_rate
	Namespace: gameobjects
	Checksum: 0xB3B66732
	Offset: 0xA870
	Size: 0x150
	Parameters: 0
	Flags: Linked
*/
function update_use_rate()
{
	numclaimants = self.numtouching[self.claimteam];
	claimantsuserate = get_team_use_rate(self.claimteam);
	numother = 0;
	numother = get_num_touching_except_team(self.claimteam);
	otheruserate = get_touching_use_rate_except_team(self.claimteam);
	self.userate = 0;
	if(self.decayprogress)
	{
		if(numclaimants && !numother)
		{
			self.userate = claimantsuserate;
		}
		else if(!numclaimants && numother)
		{
			self.userate = otheruserate;
		}
		else if(!numclaimants && !numother)
		{
			self.userate = 0;
		}
	}
	else if(numclaimants && !numother)
	{
		self.userate = claimantsuserate;
	}
	if(isdefined(self.onupdateuserate))
	{
		self [[self.onupdateuserate]]();
	}
}

/*
	Name: use_hold_think
	Namespace: gameobjects
	Checksum: 0x709847C6
	Offset: 0xA9C8
	Size: 0x5B0
	Parameters: 2
	Flags: Linked
*/
function use_hold_think(player, disableweaponcyclingduringhold)
{
	player notify(#"use_hold");
	if(!isdefined(self.var_bca8171a))
	{
		self.var_bca8171a = spawnstruct();
	}
	self.var_bca8171a.player = player;
	if(!(isdefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger))
	{
		if(!sessionmodeismultiplayergame() && !function_f99d2668())
		{
			gameobject_link = util::spawn_model("tag_origin", player.origin, player.angles);
			player playerlinkto(gameobject_link);
		}
		else
		{
			player playerlinkto(self.trigger);
			player playerlinkedoffsetenable();
		}
	}
	player clientclaimtrigger(self.trigger);
	player.claimtrigger = self.trigger;
	useweapon = self.useweapon;
	if(isdefined(useweapon))
	{
		if(isdefined(useweapon.var_d2751f9d) && useweapon.var_d2751f9d)
		{
			player val::set(#"hash_18142cb460526d28", "disable_gestures");
		}
		player giveweapon(useweapon);
		player setweaponammostock(useweapon, 0);
		player setweaponammoclip(useweapon, 0);
		player switchtoweapon(useweapon);
	}
	else if(self.keepweapon !== 1)
	{
		player val::set(#"hash_18142cb460526d28", "disable_weapons");
	}
	self clear_progress();
	self.inuse = 1;
	self.userate = 0;
	if(isdefined(self.objectiveid))
	{
		objective_setplayerusing(self.objectiveid, player);
	}
	if(disableweaponcyclingduringhold)
	{
		player disableweaponcycling();
		enableweaponcyclingafterhold = 1;
		self.var_bca8171a.enableweaponcycling = 1;
	}
	if(isdefined(player.var_17bc9194) && player.var_17bc9194)
	{
		self.curprogress = self.usetime;
		result = 1;
		player.var_17bc9194 = undefined;
	}
	else
	{
		result = use_hold_think_loop(player);
		if(!isdefined(result))
		{
			result = 0;
		}
	}
	self.inuse = 0;
	if(isdefined(player))
	{
		if(enableweaponcyclingafterhold === 1)
		{
			player enableweaponcycling();
			self.var_bca8171a.enableweaponcycling = 0;
		}
		if(isdefined(self.objectiveid))
		{
			objective_clearplayerusing(self.objectiveid, player);
		}
		self clear_progress();
		if(isdefined(player.attachedusemodel))
		{
			player detach(player.attachedusemodel, "tag_inhand");
			player.attachedusemodel = undefined;
		}
		player notify(#"done_using");
		if(isdefined(useweapon))
		{
			player thread take_use_weapon(useweapon);
		}
		player.claimtrigger = undefined;
		player clientreleasetrigger(self.trigger);
		if(isdefined(useweapon))
		{
			player killstreaks::switch_to_last_non_killstreak_weapon();
		}
		else if(self.keepweapon !== 1)
		{
			player val::reset(#"hash_18142cb460526d28", "disable_weapons");
		}
		if(!(isdefined(self.dontlinkplayertotrigger) && self.dontlinkplayertotrigger))
		{
			player unlink();
		}
		if(!isalive(player))
		{
			player.killedinuse = 1;
		}
		if(level.gameended)
		{
			player waitthenfreezeplayercontrolsifgameendedstill();
		}
	}
	if(isdefined(gameobject_link))
	{
		gameobject_link delete();
	}
	return result;
}

/*
	Name: waitthenfreezeplayercontrolsifgameendedstill
	Namespace: gameobjects
	Checksum: 0x32AA346A
	Offset: 0xAF80
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function waitthenfreezeplayercontrolsifgameendedstill(wait_time = 1)
{
	player = self;
	wait(wait_time);
	if(isdefined(player) && level.gameended)
	{
		player val::set(#"gameobjects_gameended", "freezecontrols", 1);
	}
}

/*
	Name: take_use_weapon
	Namespace: gameobjects
	Checksum: 0x3A0C83EA
	Offset: 0xB000
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function take_use_weapon(useweapon)
{
	self endon(#"use_hold", #"death", #"disconnect");
	level endon(#"game_ended");
	while(self getcurrentweapon() == useweapon && !self.throwinggrenade)
	{
		waitframe(1);
	}
	if(isdefined(useweapon.var_d2751f9d) && useweapon.var_d2751f9d)
	{
		self val::reset(#"hash_18142cb460526d28", "disable_gestures");
	}
	self takeweapon(useweapon);
}

/*
	Name: has_line_of_sight
	Namespace: gameobjects
	Checksum: 0xCAFBE33
	Offset: 0xB0F0
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function has_line_of_sight(player)
{
	eye = player util::get_eye();
	trace = sighttracepassed(eye, self.origin, 0, self.var_5ecd70, player);
	return trace;
}

/*
	Name: continue_hold_think_loop
	Namespace: gameobjects
	Checksum: 0x7D4C8FE1
	Offset: 0xB160
	Size: 0x28A
	Parameters: 4
	Flags: Linked
*/
function continue_hold_think_loop(player, waitforweapon, timedout, usetime)
{
	maxwaittime = 1.5;
	if(!isalive(player))
	{
		return 0;
	}
	if(isdefined(player.laststand) && player.laststand)
	{
		return 0;
	}
	if(self.curprogress >= usetime)
	{
		return 0;
	}
	if(!player usebuttonpressed())
	{
		return 0;
	}
	if(player function_f75eb1ae())
	{
		return 0;
	}
	if(player.throwinggrenade && (!isdefined(self.var_c2f21609) || (self.var_c2f21609 != 14 && self.var_c2f21609 != 15)))
	{
		return 0;
	}
	if(player isinvehicle())
	{
		return 0;
	}
	if(player isremotecontrolling() || player util::isusingremote())
	{
		return 0;
	}
	if(isdefined(player.selectinglocation) && player.selectinglocation)
	{
		return 0;
	}
	if(player isweaponviewonlylinked())
	{
		return 0;
	}
	if(!player function_59e66d9(self.trigger))
	{
		if(!isdefined(player.cursorhintent) || player.cursorhintent != self)
		{
			return 0;
		}
	}
	if(isdefined(self.requireslos) && self.requireslos && !has_line_of_sight(player))
	{
		return 0;
	}
	if(!self.userate && !waitforweapon)
	{
		return 0;
	}
	if(waitforweapon && timedout > maxwaittime)
	{
		return 0;
	}
	if(isdefined(self.interrupted) && self.interrupted)
	{
		return 0;
	}
	if(level.gameended)
	{
		return 0;
	}
	return 1;
}

/*
	Name: update_current_progress
	Namespace: gameobjects
	Checksum: 0x782745A6
	Offset: 0xB3F8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function update_current_progress()
{
	if(self.usetime)
	{
		if(isdefined(self.curprogress))
		{
			progress = float(self.curprogress) / self.usetime;
		}
		else
		{
			progress = 0;
		}
		if(isdefined(self.objectiveid))
		{
			objective_setprogress(self.objectiveid, math::clamp(progress, 0, 1));
		}
	}
}

/*
	Name: use_hold_think_loop
	Namespace: gameobjects
	Checksum: 0x9AE2A3DA
	Offset: 0xB498
	Size: 0x30A
	Parameters: 1
	Flags: Linked
*/
function use_hold_think_loop(player)
{
	self endon(#"disabled");
	useweapon = self.useweapon;
	waitforweapon = 1;
	timedout = 0;
	while(self continue_hold_think_loop(player, waitforweapon, timedout, self.usetime))
	{
		timedout = timedout + 0.05;
		if(!isdefined(useweapon) || useweapon == level.weaponnone || player getcurrentweapon() == useweapon)
		{
			playerusemultiplier = 1;
			if(isdefined(self.getuseratemultiplier))
			{
				playerusemultiplier = self [[self.getuseratemultiplier]](player);
			}
			previousprogress = self.curprogress;
			self.curprogress = self.curprogress + level.var_9fee970c * self.userate * playerusemultiplier;
			deltaprogress = self.curprogress - previousprogress;
			if(isdefined(self.var_5c196da4) && self.var_5c196da4 && isdefined(self.var_1dbb2b2b))
			{
				function_72307b09(deltaprogress);
			}
			self update_current_progress();
			if(isdefined(self.onuseupdate))
			{
				self [[self.onuseupdate]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
			}
			if(isdefined(self.var_ff74c7e9))
			{
				self [[self.var_ff74c7e9]](self get_claim_team(), self.curprogress / self.usetime, deltaprogress / self.usetime);
			}
			self.userate = 1;
			waitforweapon = 0;
		}
		else
		{
			self.userate = 0;
		}
		if(sessionmodeismultiplayergame() || function_f99d2668())
		{
			if(self.curprogress >= self.usetime)
			{
				return 1;
			}
			waitframe(1);
		}
		else
		{
			waitframe(1);
			if(self.curprogress >= self.usetime)
			{
				util::wait_network_frame();
				return 1;
			}
		}
		hostmigration::waittillhostmigrationdone();
	}
	return 0;
}

/*
	Name: update_trigger
	Namespace: gameobjects
	Checksum: 0x12EB588A
	Offset: 0xB7B0
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function update_trigger()
{
	if(self.triggertype != "use")
	{
		return;
	}
	if(!isdefined(self.trigger))
	{
		return;
	}
	if(isdefined(self.absolute_visible_and_interact_team))
	{
		self.trigger triggerenable(1);
		self.trigger setteamfortrigger(self.absolute_visible_and_interact_team);
		return;
	}
	if(self.interactteam == #"none")
	{
		self.trigger triggerenable(0);
	}
	else if(self.interactteam == #"friendly")
	{
		self.trigger triggerenable(1);
		if(isdefined(level.teams[self.ownerteam]))
		{
			self.trigger setteamfortrigger(self.ownerteam);
		}
		else
		{
			self.trigger triggerenable(0);
		}
	}
	else if(self.interactteam == #"enemy")
	{
		self.trigger triggerenable(1);
		self.trigger setexcludeteamfortrigger(self.ownerteam);
	}
	else if(self.interactteam == #"any" || !level.teambased)
	{
		self.trigger triggerenable(1);
		self.trigger setteamfortrigger(#"none");
	}
}

/*
	Name: update_objective
	Namespace: gameobjects
	Checksum: 0xC62AE1D
	Offset: 0xB9C0
	Size: 0x454
	Parameters: 0
	Flags: Linked
*/
function update_objective()
{
	if(self.type === "GenericObject" || !isdefined(self.objectiveid))
	{
		return;
	}
	if(isdefined(self.e_object) && (isdefined(self.e_object.var_c65066ad) && self.e_object.var_c65066ad))
	{
		objective_setteam(self.objectiveid, #"none");
	}
	else
	{
		objective_setteam(self.objectiveid, self.ownerteam);
	}
	if(isdefined(self.absolute_visible_and_interact_team) && self.visibleteam != #"none")
	{
		objective_setstate(self.objectiveid, "active");
		function_da7940a3(self.objectiveid, 0);
		function_3ae6fa3(self.objectiveid, self.absolute_visible_and_interact_team, 1);
	}
	else if(self.visibleteam == #"any")
	{
		objective_setstate(self.objectiveid, "active");
		function_da7940a3(self.objectiveid, 1);
	}
	else if(isdefined(self.ownerteam) && isdefined(level.spawnsystem.ispawn_teammask[self.ownerteam]) && self.visibleteam == #"friendly")
	{
		objective_setstate(self.objectiveid, "active");
		function_da7940a3(self.objectiveid, 0);
		function_3ae6fa3(self.objectiveid, self.ownerteam, 1);
	}
	else if(isdefined(self.ownerteam) && isdefined(level.spawnsystem.ispawn_teammask[self.ownerteam]) && self.visibleteam == #"enemy")
	{
		objective_setstate(self.objectiveid, "active");
		function_da7940a3(self.objectiveid, 1);
		function_3ae6fa3(self.objectiveid, self.ownerteam, 0);
	}
	else
	{
		objective_setstate(self.objectiveid, "invisible");
		function_da7940a3(self.objectiveid, 0);
	}
	if(self.type == "carryObject" || self.type == "packObject")
	{
		if(isalive(self.carrier))
		{
			objective_onentity(self.objectiveid, self.carrier);
			objective_setinvisibletoplayer(self.objectiveid, self.carrier);
		}
		else if(isdefined(self.objectiveonvisuals) && self.objectiveonvisuals)
		{
			objective_onentity(self.objectiveid, self.visuals[0]);
		}
		else if(isdefined(self.objectiveonself) && self.objectiveonself)
		{
			objective_onentity(self.objectiveid, self);
		}
		else
		{
			objective_clearentity(self.objectiveid);
		}
	}
}

/*
	Name: function_c59e69d3
	Namespace: gameobjects
	Checksum: 0xD1C3F9CC
	Offset: 0xBE20
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_c59e69d3(team)
{
	mdl_gameobject = self function_fd4a5f2f();
	if(!isdefined(team))
	{
		team = team.ownerteam;
	}
	team = util::get_team_mapping(team);
	foreach(e_player in util::get_players(team))
	{
		mdl_gameobject hide_waypoint(e_player);
	}
}

/*
	Name: function_2b948aef
	Namespace: gameobjects
	Checksum: 0x489EB5CA
	Offset: 0xBF10
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_2b948aef(team)
{
	mdl_gameobject = self function_fd4a5f2f();
	team = util::get_team_mapping(team);
	foreach(e_player in util::get_players(team))
	{
		mdl_gameobject show_waypoint(e_player);
	}
}

/*
	Name: hide_waypoint
	Namespace: gameobjects
	Checksum: 0x7EFF9370
	Offset: 0xBFE8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function hide_waypoint(e_player)
{
	mdl_gameobject = self function_fd4a5f2f();
	if(!isdefined(mdl_gameobject.objectiveid))
	{
		return;
	}
	if(isdefined(e_player))
	{
		if(!isplayer(e_player))
		{
			/#
				assert(0, "");
			#/
			return;
		}
		objective_setinvisibletoplayer(mdl_gameobject.objectiveid, e_player);
	}
	else
	{
		objective_setinvisibletoall(mdl_gameobject.objectiveid);
	}
}

/*
	Name: show_waypoint
	Namespace: gameobjects
	Checksum: 0xEC988E29
	Offset: 0xC0B0
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function show_waypoint(e_player)
{
	mdl_gameobject = self function_fd4a5f2f();
	if(!isdefined(mdl_gameobject.objectiveid))
	{
		return;
	}
	if(isdefined(e_player))
	{
		if(!isplayer(e_player))
		{
			/#
				assert(0, "");
			#/
			return;
		}
		objective_setvisibletoplayer(mdl_gameobject.objectiveid, e_player);
	}
	else
	{
		objective_setvisibletoall(mdl_gameobject.objectiveid);
	}
}

/*
	Name: should_ping_object
	Namespace: gameobjects
	Checksum: 0xF5447002
	Offset: 0xC178
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function should_ping_object(relativeteam)
{
	if(relativeteam == #"friendly" && self.objidpingfriendly)
	{
		return 1;
	}
	if(relativeteam == #"enemy" && self.objidpingenemy)
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_update_teams
	Namespace: gameobjects
	Checksum: 0x5E05CF41
	Offset: 0xC1E8
	Size: 0x1B4
	Parameters: 1
	Flags: None
*/
function get_update_teams(relativeteam)
{
	updateteams = [];
	if(level.teambased)
	{
		if(relativeteam == #"friendly")
		{
			foreach(team, _ in level.teams)
			{
				if(self is_friendly_team(team))
				{
					updateteams[updateteams.size] = team;
				}
			}
		}
		else if(relativeteam == #"enemy")
		{
			foreach(team, _ in level.teams)
			{
				if(!self is_friendly_team(team))
				{
					updateteams[updateteams.size] = team;
				}
			}
		}
	}
	else if(relativeteam == #"friendly")
	{
		updateteams[updateteams.size] = level.nonteambasedteam;
	}
	else
	{
		updateteams[updateteams.size] = #"axis";
	}
	return updateteams;
}

/*
	Name: should_show_compass_due_to_radar
	Namespace: gameobjects
	Checksum: 0xFAF329A5
	Offset: 0xC3A8
	Size: 0x9A
	Parameters: 1
	Flags: None
*/
function should_show_compass_due_to_radar(team)
{
	showcompass = 0;
	if(!isdefined(self.carrier))
	{
		return 0;
	}
	if(self.carrier hasperk(#"specialty_gpsjammer") == 0)
	{
		if(killstreaks::hasuav(team))
		{
			showcompass = 1;
		}
	}
	if(killstreaks::hassatellite(team))
	{
		showcompass = 1;
	}
	return showcompass;
}

/*
	Name: _set_team
	Namespace: gameobjects
	Checksum: 0x887455C8
	Offset: 0xC450
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
private function _set_team(team)
{
	self.ownerteam = team;
	if(team != #"any")
	{
		self.team = team;
		foreach(visual in self.visuals)
		{
			visual.team = team;
		}
	}
}

/*
	Name: set_owner_team
	Namespace: gameobjects
	Checksum: 0xBA924530
	Offset: 0xC508
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function set_owner_team(team)
{
	mdl_gameobject = self function_fd4a5f2f();
	if(team == #"any")
	{
		team = #"none";
	}
	team = util::get_team_mapping(team);
	mdl_gameobject _set_team(team);
	mdl_gameobject update_trigger();
	mdl_gameobject update_objective();
}

/*
	Name: get_owner_team
	Namespace: gameobjects
	Checksum: 0xA10F116F
	Offset: 0xC5C8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function get_owner_team()
{
	mdl_gameobject = self function_fd4a5f2f();
	return mdl_gameobject.ownerteam;
}

/*
	Name: flip_owner_team
	Namespace: gameobjects
	Checksum: 0x611ECBAD
	Offset: 0xC608
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function flip_owner_team()
{
	team = get_owner_team();
	b_trigger_enabled = self.trigger istriggerenabled();
	if(team === #"allies")
	{
		self set_owner_team(#"axis");
	}
	else if(team === #"axis")
	{
		self set_owner_team(#"allies");
	}
	self.trigger triggerenable(b_trigger_enabled);
}

/*
	Name: flip_owner_team_on_all_gameobjects
	Namespace: gameobjects
	Checksum: 0xBAE29440
	Offset: 0xC6E8
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function flip_owner_team_on_all_gameobjects()
{
	if(isdefined(level.a_gameobjects))
	{
		array::thread_all(level.a_gameobjects, &flip_owner_team);
	}
}

/*
	Name: function_2efe0342
	Namespace: gameobjects
	Checksum: 0xA53AECC6
	Offset: 0xC730
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_2efe0342()
{
	self allow_use(#"none");
}

/*
	Name: function_407c83be
	Namespace: gameobjects
	Checksum: 0x6F0DADCA
	Offset: 0xC760
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_407c83be()
{
	if(isdefined(level.a_gameobjects))
	{
		array::thread_all(level.a_gameobjects, &function_2efe0342);
	}
}

/*
	Name: function_6cdadc59
	Namespace: gameobjects
	Checksum: 0x4039212C
	Offset: 0xC7A8
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_6cdadc59(point)
{
	if(isdefined(level.a_gameobjects))
	{
		return arraygetclosest(point, level.a_gameobjects);
	}
}

/*
	Name: set_decay_time
	Namespace: gameobjects
	Checksum: 0x27B4A23D
	Offset: 0xC7F0
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function set_decay_time(time)
{
	self.decaytime = int(time * 1000);
}

/*
	Name: set_use_time
	Namespace: gameobjects
	Checksum: 0x81A4B8B6
	Offset: 0xC830
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function set_use_time(time)
{
	self.usetime = int(time * 1000);
}

/*
	Name: function_86d3b442
	Namespace: gameobjects
	Checksum: 0xCE04AC7C
	Offset: 0xC870
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_86d3b442(time)
{
	self.var_d0b697a4 = int(time * 1000);
}

/*
	Name: set_use_text
	Namespace: gameobjects
	Checksum: 0x7EF77234
	Offset: 0xC8B0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_use_text(text)
{
	self.usetext = text;
}

/*
	Name: set_team_use_time
	Namespace: gameobjects
	Checksum: 0xDB863A69
	Offset: 0xC8D8
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function set_team_use_time(relativeteam, time)
{
	self.teamusetimes[relativeteam] = int(time * 1000);
}

/*
	Name: set_team_use_text
	Namespace: gameobjects
	Checksum: 0xB703B3FD
	Offset: 0xC928
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function set_team_use_text(relativeteam, text)
{
	self.teamusetexts[relativeteam] = text;
}

/*
	Name: set_use_hint_text
	Namespace: gameobjects
	Checksum: 0x86FCE894
	Offset: 0xC960
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function set_use_hint_text(text)
{
	self.trigger sethintstring(text);
}

/*
	Name: allow_carry
	Namespace: gameobjects
	Checksum: 0x1FDD5B0D
	Offset: 0xC990
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function allow_carry(relativeteam)
{
	allow_use(relativeteam);
}

/*
	Name: allow_use
	Namespace: gameobjects
	Checksum: 0x92375A6E
	Offset: 0xC9C0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function allow_use(relativeteam)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.interactteam = relativeteam;
	mdl_gameobject update_trigger();
}

/*
	Name: set_visible_team
	Namespace: gameobjects
	Checksum: 0x4DC458F3
	Offset: 0xCA20
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function set_visible_team(relativeteam)
{
	mdl_gameobject = self function_fd4a5f2f();
	mdl_gameobject.visibleteam = relativeteam;
	if(!tweakables::gettweakablevalue("hud", "showobjicons"))
	{
		mdl_gameobject.visibleteam = #"none";
	}
	mdl_gameobject update_objective();
}

/*
	Name: set_model_visibility
	Namespace: gameobjects
	Checksum: 0xE840662B
	Offset: 0xCAB8
	Size: 0x17E
	Parameters: 1
	Flags: None
*/
function set_model_visibility(visibility)
{
	if(visibility)
	{
		for(index = 0; index < self.visuals.size; index++)
		{
			self.visuals[index] show();
			if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
			{
				self.visuals[index] thread make_solid();
			}
		}
	}
	else
	{
		for(index = 0; index < self.visuals.size; index++)
		{
			self.visuals[index] ghost();
			if(self.visuals[index].classname == "script_brushmodel" || self.visuals[index].classname == "script_model")
			{
				self.visuals[index] notify(#"changing_solidness");
				self.visuals[index] notsolid();
			}
		}
	}
}

/*
	Name: make_solid
	Namespace: gameobjects
	Checksum: 0x3800F18E
	Offset: 0xCC40
	Size: 0xD2
	Parameters: 0
	Flags: Linked
*/
function make_solid()
{
	self endon(#"death");
	self notify(#"changing_solidness");
	self endon(#"changing_solidness");
	while(true)
	{
		for(i = 0; i < level.players.size; i++)
		{
			if(level.players[i] function_59e66d9(self))
			{
				break;
			}
		}
		if(i == level.players.size)
		{
			self solid();
			break;
		}
		waitframe(1);
	}
}

/*
	Name: set_carrier_visible
	Namespace: gameobjects
	Checksum: 0x24466600
	Offset: 0xCD20
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_carrier_visible(relativeteam)
{
	self.carriervisible = relativeteam;
}

/*
	Name: set_can_use
	Namespace: gameobjects
	Checksum: 0xF56E1E6D
	Offset: 0xCD48
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_can_use(relativeteam)
{
	self.useteam = relativeteam;
}

/*
	Name: set_2d_icon
	Namespace: gameobjects
	Checksum: 0x88860C03
	Offset: 0xCD70
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function set_2d_icon(relativeteam, shader)
{
	self.compassicons[relativeteam] = shader;
}

/*
	Name: set_3d_icon
	Namespace: gameobjects
	Checksum: 0xF448064
	Offset: 0xCDA8
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function set_3d_icon(relativeteam, shader)
{
	if(!isdefined(shader))
	{
		self.worldicons_disabled[relativeteam] = 1;
	}
	else
	{
		self.worldicons_disabled[relativeteam] = 0;
	}
	self.worldicons[relativeteam] = shader;
}

/*
	Name: set_objective_entity
	Namespace: gameobjects
	Checksum: 0xCC3479F5
	Offset: 0xCE10
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function set_objective_entity(entity)
{
	if(isdefined(self.objectiveid))
	{
		objective_onentity(self.objectiveid, entity);
	}
}

/*
	Name: get_objective_ids
	Namespace: gameobjects
	Checksum: 0x3619EB7A
	Offset: 0xCE50
	Size: 0x80
	Parameters: 1
	Flags: None
*/
function get_objective_ids(team)
{
	a_objective_ids = [];
	if(isdefined(self.objectiveid))
	{
		if(!isdefined(a_objective_ids))
		{
			a_objective_ids = [];
		}
		else if(!isarray(a_objective_ids))
		{
			a_objective_ids = array(a_objective_ids);
		}
		a_objective_ids[a_objective_ids.size] = self.objectiveid;
	}
	return a_objective_ids;
}

/*
	Name: gameobject_is_player_looking_at
	Namespace: gameobjects
	Checksum: 0xF12B3772
	Offset: 0xCED8
	Size: 0x236
	Parameters: 5
	Flags: None
*/
function gameobject_is_player_looking_at(origin, dot, do_trace, ignore_ent, ignore_trace_distance)
{
	/#
		assert(isplayer(self), "");
	#/
	if(!isdefined(dot))
	{
		dot = 0.7;
	}
	if(!isdefined(do_trace))
	{
		do_trace = 1;
	}
	eye = self util::get_eye();
	delta_vec = anglestoforward(vectortoangles(origin - eye));
	view_vec = anglestoforward(self getplayerangles());
	new_dot = vectordot(delta_vec, view_vec);
	if(new_dot >= dot)
	{
		if(do_trace)
		{
			trace = bullettrace(eye, origin, 0, ignore_ent);
			if(trace[#"position"] == origin)
			{
				return 1;
			}
			if(isdefined(ignore_trace_distance))
			{
				n_mag = distance(origin, eye);
				n_dist = distance(trace[#"position"], eye);
				n_delta = abs(n_dist - n_mag);
				if(n_delta <= ignore_trace_distance)
				{
					return 1;
				}
			}
		}
		else
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: hide_icons
	Namespace: gameobjects
	Checksum: 0x39AA953A
	Offset: 0xD118
	Size: 0x1D4
	Parameters: 1
	Flags: None
*/
function hide_icons(team)
{
	if(self.visibleteam == #"any" || self.visibleteam == #"friendly")
	{
		hide_friendly = 1;
	}
	else
	{
		hide_friendly = 0;
	}
	if(self.visibleteam == #"any" || self.visibleteam == #"enemy")
	{
		hide_enemy = 1;
	}
	else
	{
		hide_enemy = 0;
	}
	self.hidden_compassicon = [];
	self.hidden_worldicon = [];
	if(hide_friendly == 1)
	{
		self.hidden_compassicon[#"friendly"] = self.compassicons[#"friendly"];
		self.hidden_worldicon[#"friendly"] = self.worldicons[#"friendly"];
	}
	if(hide_enemy == 1)
	{
		self.hidden_compassicon[#"enemy"] = self.compassicons[#"enemyy"];
		self.hidden_worldicon[#"enemy"] = self.worldicons[#"enemy"];
	}
	self set_2d_icon(team, undefined);
	self set_3d_icon(team, undefined);
}

/*
	Name: show_icons
	Namespace: gameobjects
	Checksum: 0x1734C60F
	Offset: 0xD2F8
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function show_icons(team)
{
	if(isdefined(self.hidden_compassicon[team]))
	{
		self set_2d_icon(team, self.hidden_compassicon[team]);
	}
	if(isdefined(self.hidden_worldicon[team]))
	{
		self set_3d_icon(team, self.hidden_worldicon[team]);
	}
}

/*
	Name: set_3d_use_icon
	Namespace: gameobjects
	Checksum: 0x62F3654E
	Offset: 0xD380
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function set_3d_use_icon(relativeteam, shader)
{
	self.worlduseicons[relativeteam] = shader;
}

/*
	Name: set_3d_is_waypoint
	Namespace: gameobjects
	Checksum: 0xC80177D2
	Offset: 0xD3B8
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function set_3d_is_waypoint(relativeteam, waypoint)
{
	self.worldiswaypoint[relativeteam] = waypoint;
}

/*
	Name: set_carry_icon
	Namespace: gameobjects
	Checksum: 0xC3FB8CEF
	Offset: 0xD3F0
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function set_carry_icon(shader)
{
	/#
		assert(self.type == "", "");
	#/
	self.carryicon = shader;
}

/*
	Name: set_visible_carrier_model
	Namespace: gameobjects
	Checksum: 0x31C1A07E
	Offset: 0xD448
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function set_visible_carrier_model(visiblemodel)
{
	self.visiblecarriermodel = visiblemodel;
}

/*
	Name: get_visible_carrier_model
	Namespace: gameobjects
	Checksum: 0xE3CD3658
	Offset: 0xD470
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_visible_carrier_model()
{
	return self.visiblecarriermodel;
}

/*
	Name: destroy_object
	Namespace: gameobjects
	Checksum: 0xC491E31D
	Offset: 0xD488
	Size: 0x454
	Parameters: 4
	Flags: Linked
*/
function destroy_object(deletetrigger, forcehide, b_connect_paths = 0, b_success = 0)
{
	mdl_gameobject = function_fd4a5f2f();
	if(isdefined(mdl_gameobject.e_object))
	{
		mdl_gameobject.e_object flagsys::set(#"hash_3c75783d64e76e20");
	}
	mdl_gameobject endon(#"death");
	if(!isdefined(forcehide))
	{
		forcehide = 1;
	}
	mdl_gameobject disable_object(forcehide, undefined, b_success, 1);
	if(isdefined(self.c_door) && self.c_door.m_str_type === "security")
	{
		if(isdefined(self.c_door.m_e_door))
		{
			self.c_door.m_e_door notify(#"hash_d46ecc32678f28a");
		}
	}
	waittillframeend();
	foreach(visual in mdl_gameobject.visuals)
	{
		if(b_connect_paths)
		{
			visual connectpaths();
		}
		if(isdefined(visual))
		{
			visual ghost();
			visual delete();
		}
	}
	if(isdefined(mdl_gameobject.trigger))
	{
		mdl_gameobject.trigger notify(#"destroyed");
		if(isdefined(deletetrigger) && deletetrigger)
		{
			mdl_gameobject.trigger delete();
		}
		else
		{
			mdl_gameobject.trigger triggerenable(1);
		}
	}
	if(isinarray(level.a_gameobjects, mdl_gameobject))
	{
		arrayremovevalue(level.a_gameobjects, mdl_gameobject);
	}
	if(isdefined(mdl_gameobject.var_bca8171a) && isdefined(mdl_gameobject.var_bca8171a.player))
	{
		if(isdefined(mdl_gameobject.var_bca8171a.enableweaponcycling) && mdl_gameobject.var_bca8171a.enableweaponcycling)
		{
			mdl_gameobject.var_bca8171a.player enableweaponcycling();
		}
	}
	if(isdefined(mdl_gameobject.var_bca8171a) && isdefined(mdl_gameobject.var_bca8171a.player))
	{
		mdl_gameobject.var_bca8171a.player val::reset(#"carry_object", "disable_weapons");
	}
	if(isdefined(mdl_gameobject.droptrigger))
	{
		mdl_gameobject.droptrigger delete();
	}
	mdl_gameobject notify(#"destroyed_complete");
	e_container = mdl_gameobject.e_object;
	if(!isdefined(e_container) || (!(isdefined(e_container.var_c65066ad) && e_container.var_c65066ad)))
	{
		mdl_gameobject release_all_objective_ids();
	}
	mdl_gameobject delete();
}

/*
	Name: disable_object
	Namespace: gameobjects
	Checksum: 0x406DE96A
	Offset: 0xD8E8
	Size: 0x2E4
	Parameters: 4
	Flags: Linked
*/
function disable_object(var_fa771a51, var_ffd61eb5 = 1, b_success = 0, b_destroyed = 0)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.b_enabled = undefined;
	mdl_gameobject notify(#"disabled");
	if(isdefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || (isdefined(var_fa771a51) && var_fa771a51))
	{
		if(isdefined(mdl_gameobject.carrier))
		{
			mdl_gameobject.carrier take_object(mdl_gameobject);
		}
		for(i = 0; i < mdl_gameobject.visuals.size; i++)
		{
			if(isdefined(mdl_gameobject.visuals[i]))
			{
				mdl_gameobject.visuals[i] ghost();
				mdl_gameobject.visuals[i] notsolid();
			}
		}
	}
	if(isdefined(mdl_gameobject.trigger))
	{
		mdl_gameobject.trigger triggerenable(0);
	}
	if(var_ffd61eb5)
	{
		if(!isdefined(mdl_gameobject.str_restore_visible_team_after_disable))
		{
			mdl_gameobject.str_restore_visible_team_after_disable = mdl_gameobject.visibleteam;
		}
		mdl_gameobject set_visible_team("none");
		if(isdefined(mdl_gameobject.objectiveid))
		{
			objective_clearentity(mdl_gameobject.objectiveid);
			if(isdefined(mdl_gameobject.var_25010336))
			{
				release_obj_id(mdl_gameobject.objectiveid);
				objective_delete(mdl_gameobject.objectiveid);
				mdl_gameobject.objectiveid = undefined;
			}
		}
	}
	e_container = mdl_gameobject.e_object;
	if(isdefined(e_container) && (isdefined(e_container.var_c65066ad) && e_container.var_c65066ad))
	{
		e_container function_8dbe8332(b_success, b_destroyed);
	}
}

/*
	Name: enable_object
	Namespace: gameobjects
	Checksum: 0x26DBDA39
	Offset: 0xDBD8
	Size: 0x32C
	Parameters: 2
	Flags: Linked
*/
function enable_object(var_13c260df, b_show_objective = 1)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject endon(#"death");
	e_container = mdl_gameobject.e_object;
	if(isdefined(e_container) && (isdefined(e_container.var_c65066ad) && e_container.var_c65066ad))
	{
		e_container function_35a012bf();
	}
	mdl_gameobject.b_enabled = 1;
	if(isdefined(mdl_gameobject.type) && (mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject") || (isdefined(var_13c260df) && var_13c260df))
	{
		for(i = 0; i < mdl_gameobject.visuals.size; i++)
		{
			mdl_gameobject.visuals[i] show();
			mdl_gameobject.visuals[i] solid();
		}
	}
	if(isdefined(mdl_gameobject.trigger))
	{
		mdl_gameobject.trigger triggerenable(1);
	}
	if(b_show_objective)
	{
		if(!isdefined(mdl_gameobject.objectiveid) && isdefined(mdl_gameobject.var_25010336))
		{
			mdl_gameobject [[mdl_gameobject.var_25010336]]();
		}
		if(isdefined(mdl_gameobject.str_restore_visible_team_after_disable))
		{
			mdl_gameobject set_visible_team(mdl_gameobject.str_restore_visible_team_after_disable);
			mdl_gameobject.str_restore_visible_team_after_disable = undefined;
		}
		else if(isdefined(mdl_gameobject.visibleteam))
		{
			mdl_gameobject set_visible_team(mdl_gameobject.visibleteam);
		}
		else
		{
			mdl_gameobject set_visible_team(#"any");
		}
		if(isdefined(mdl_gameobject.objectiveid))
		{
			objective_onentity(mdl_gameobject.objectiveid, mdl_gameobject);
			if(mdl_gameobject.type == "carryObject" || mdl_gameobject.type == "packObject")
			{
				mdl_gameobject notify(#"hash_431541b507a8c588");
				objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
			}
		}
	}
}

/*
	Name: get_relative_team
	Namespace: gameobjects
	Checksum: 0x650591CE
	Offset: 0xDF10
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function get_relative_team(team)
{
	team = util::get_team_mapping(team);
	if(self.ownerteam == #"any")
	{
		return #"friendly";
	}
	if(team == self.ownerteam)
	{
		return #"friendly";
	}
	if(team == get_enemy_team(self.ownerteam))
	{
		return #"enemy";
	}
	return #"neutral";
}

/*
	Name: is_friendly_team
	Namespace: gameobjects
	Checksum: 0xAF1EB9E8
	Offset: 0xDFC8
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function is_friendly_team(team)
{
	team = util::get_team_mapping(team);
	if(!level.teambased)
	{
		return 1;
	}
	if(self.ownerteam == #"any")
	{
		return 1;
	}
	if(self.ownerteam == team)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a34c1761
	Namespace: gameobjects
	Checksum: 0xB13AAA12
	Offset: 0xE040
	Size: 0x326
	Parameters: 1
	Flags: Linked
*/
function function_a34c1761(sentient)
{
	var_47a62b7b = isvehicle(sentient) || (isplayer(sentient) && sentient isinvehicle() && !sentient function_a867284b());
	if(var_47a62b7b && (!(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup)) && (!(isdefined(self.b_allow_vehicle_proximity_pickup) && self.b_allow_vehicle_proximity_pickup)))
	{
		return 0;
	}
	if(isdefined(level.b_allow_vehicle_proximity_pickup) && level.b_allow_vehicle_proximity_pickup || (isdefined(self.b_allow_vehicle_proximity_pickup) && self.b_allow_vehicle_proximity_pickup))
	{
		if(!isplayer(sentient) && !isvehicle(sentient))
		{
			return 0;
		}
	}
	else if(!isplayer(sentient))
	{
		return 0;
	}
	if(isplayer(sentient))
	{
		if(!function_dfec159b(sentient))
		{
			return 0;
		}
		if(isdefined(self.var_d647eb08) && self.var_d647eb08 && sentient isreloading())
		{
			return 0;
		}
	}
	else if(!isdefined(sentient.var_69d05189) || sentient.var_69d05189 == 0)
	{
		return 0;
	}
	if(self is_excluded(sentient))
	{
		return 0;
	}
	if(isdefined(self.canuseobject) && ![[self.canuseobject]](sentient))
	{
		return 0;
	}
	if(self.triggertype === "use" && isdefined(sentient.var_121392a1) && sentient.var_121392a1.size > 0)
	{
		foreach(var_cd6ef3e2 in sentient.var_121392a1)
		{
			if(isdefined(var_cd6ef3e2.var_4f6b79a4) && (isdefined(var_cd6ef3e2.var_4f6b79a4.var_4f6b79a4.var_cb34970a) ? var_cd6ef3e2.var_4f6b79a4.var_cb34970a : 0))
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: can_interact_with
	Namespace: gameobjects
	Checksum: 0x4E30F08E
	Offset: 0xE370
	Size: 0x322
	Parameters: 1
	Flags: Linked
*/
function can_interact_with(sentient)
{
	if(isdefined(self.ignore_use_time))
	{
		ignore_time = self.ignore_use_time[sentient getentitynumber()];
		if(isdefined(ignore_time))
		{
			if(level.time < ignore_time)
			{
				return 0;
			}
			self.ignore_use_time[sentient getentitynumber()] = undefined;
		}
	}
	team = sentient.team;
	if(isdefined(self.absolute_visible_and_interact_team))
	{
		if(team == self.absolute_visible_and_interact_team)
		{
			return 1;
		}
	}
	if(isdefined(self.var_af6e4895) && isplayer(sentient))
	{
		player = sentient;
		if(!player hasweapon(self.var_af6e4895))
		{
			return 0;
		}
		ammocount = player getammocount(self.var_af6e4895);
		if(ammocount == 0)
		{
			return 0;
		}
	}
	switch(self.interactteam)
	{
		case "none":
		{
			return 0;
		}
		case "any":
		{
			return 1;
		}
		case "free":
		{
			return 0;
		}
		case "friendly":
		{
			if(level.teambased)
			{
				if(team == self.ownerteam)
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(sentient.team == self.ownerteam && sentient.team != #"free")
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		case "enemy":
		{
			if(level.teambased)
			{
				if(team != self.ownerteam)
				{
					return 1;
				}
				else if(isdefined(self.decayprogress) && self.decayprogress && self.curprogress > 0 && (!isdefined(self.decayprogressmin) || self.curprogress > self.decayprogressmin))
				{
					return 1;
				}
				else
				{
					return 0;
				}
			}
			else if(sentient.team != self.ownerteam)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		default:
		{
			/#
				assert(0, "");
			#/
			return 0;
		}
	}
}

/*
	Name: is_team
	Namespace: gameobjects
	Checksum: 0x78EAB050
	Offset: 0xE6A0
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function is_team(team)
{
	team = util::get_team_mapping(team);
	switch(team)
	{
		case "none":
		case "neutral":
		case "any":
		{
			return 1;
			break;
		}
	}
	if(isdefined(level.teams[team]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_relative_team
	Namespace: gameobjects
	Checksum: 0x91BED041
	Offset: 0xE738
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function is_relative_team(relativeteam)
{
	switch(relativeteam)
	{
		case "friendly":
		case "none":
		case "enemy":
		case "any":
		{
			return 1;
			break;
		}
		default:
		{
			return 0;
			break;
		}
	}
}

/*
	Name: get_enemy_team
	Namespace: gameobjects
	Checksum: 0x7A53980E
	Offset: 0xE7C8
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function get_enemy_team(team)
{
	team = util::get_team_mapping(team);
	switch(team)
	{
		case "neutral":
		{
			return #"none";
			break;
		}
		case "allies":
		{
			return #"axis";
			break;
		}
		default:
		{
			return #"allies";
			break;
		}
	}
}

/*
	Name: set_absolute_visible_and_interact_team
	Namespace: gameobjects
	Checksum: 0xDF76ADE
	Offset: 0xE878
	Size: 0x7A
	Parameters: 1
	Flags: None
*/
function set_absolute_visible_and_interact_team(team)
{
	team = util::get_team_mapping(team);
	/#
		assert(team == #"allies" || team == #"axis", "");
	#/
	self.absolute_visible_and_interact_team = team;
}

/*
	Name: get_next_obj_id
	Namespace: gameobjects
	Checksum: 0x585BF47A
	Offset: 0xE900
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function get_next_obj_id()
{
	if(level.numgametypereservedobjectives < 64)
	{
		nextid = level.numgametypereservedobjectives;
		level.numgametypereservedobjectives++;
	}
	else if(level.releasedobjectives.size > 0)
	{
		nextid = array::pop_front(level.releasedobjectives, 0);
	}
	if(!isdefined(nextid))
	{
		/#
			println("");
		#/
		nextid = 63;
	}
	return nextid;
}

/*
	Name: release_obj_id
	Namespace: gameobjects
	Checksum: 0xB481885D
	Offset: 0xE9A8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function release_obj_id(objid)
{
	/#
		assert(objid < level.numgametypereservedobjectives);
	#/
	for(i = 0; i < level.releasedobjectives.size; i++)
	{
		if(objid == level.releasedobjectives[i] && objid == 63)
		{
			return;
		}
		/#
			/#
				assert(objid != level.releasedobjectives[i]);
			#/
		#/
	}
	level.releasedobjectives[level.releasedobjectives.size] = objid;
	objective_setstate(objid, "empty");
}

/*
	Name: release_all_objective_ids
	Namespace: gameobjects
	Checksum: 0xEE8C6421
	Offset: 0xEAA0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function release_all_objective_ids()
{
	if(isdefined(self.objid))
	{
		foreach(v in self.objid)
		{
			release_obj_id(v);
		}
	}
	if(isdefined(self.objectiveid))
	{
		release_obj_id(self.objectiveid);
	}
}

/*
	Name: get_label
	Namespace: gameobjects
	Checksum: 0xA0188A2B
	Offset: 0xEB58
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function get_label()
{
	label = self.trigger.script_label;
	if(!isdefined(label))
	{
		label = "";
		return label;
	}
	if(label[0] != "_")
	{
		return "_" + label;
	}
	return label;
}

/*
	Name: must_maintain_claim
	Namespace: gameobjects
	Checksum: 0xFE84396C
	Offset: 0xEBC0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function must_maintain_claim(enabled)
{
	self.mustmaintainclaim = enabled;
}

/*
	Name: can_contest_claim
	Namespace: gameobjects
	Checksum: 0xCA7B00A9
	Offset: 0xEBE8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function can_contest_claim(enabled)
{
	self.cancontestclaim = enabled;
}

/*
	Name: set_flags
	Namespace: gameobjects
	Checksum: 0x90659934
	Offset: 0xEC10
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function set_flags(flags)
{
	if(isdefined(self.objectiveid))
	{
		objective_setgamemodeflags(self.objectiveid, flags);
	}
}

/*
	Name: get_flags
	Namespace: gameobjects
	Checksum: 0xD6DF4BC4
	Offset: 0xEC50
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function get_flags(flags)
{
	if(isdefined(self.objectiveid))
	{
		return objective_getgamemodeflags(self.objectiveid);
	}
	return 0;
}

/*
	Name: set_identifier
	Namespace: gameobjects
	Checksum: 0x262A9A86
	Offset: 0xEC90
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function set_identifier(identifier)
{
	self.identifier = identifier;
}

/*
	Name: get_identifier
	Namespace: gameobjects
	Checksum: 0x40FE8B01
	Offset: 0xECB8
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_identifier()
{
	return self.identifier;
}

/*
	Name: create_pack_object
	Namespace: gameobjects
	Checksum: 0x20D7ADA4
	Offset: 0xECD0
	Size: 0x5E6
	Parameters: 7
	Flags: Linked
*/
function create_pack_object(ownerteam, trigger, visuals, offset, objectivename, allowinitialholddelay = 0, allowweaponcyclingduringhold = 0)
{
	if(!isdefined(level.max_packobjects))
	{
		level.max_packobjects = 4;
	}
	/#
		assert(level.max_packobjects < 5, "");
	#/
	packobject = spawn("script_model", trigger.origin);
	packobject.type = "packObject";
	packobject.curorigin = trigger.origin;
	packobject.entnum = trigger getentitynumber();
	if(issubstr(trigger.classname, "use"))
	{
		packobject.triggertype = "use";
	}
	else
	{
		packobject.triggertype = "proximity";
	}
	trigger.baseorigin = trigger.origin;
	packobject.trigger = trigger;
	trigger enablelinkto();
	packobject linkto(trigger);
	packobject.useweapon = undefined;
	if(!isdefined(offset))
	{
		offset = (0, 0, 0);
	}
	if(!isdefined(objectivename))
	{
		/#
			iprintln("");
		#/
		return;
	}
	for(index = 0; index < visuals.size; index++)
	{
		visuals[index].baseorigin = visuals[index].origin;
		visuals[index].baseangles = visuals[index].angles;
	}
	packobject.visuals = visuals;
	packobject _set_team(ownerteam);
	packobject.compassicons = [];
	packobject.objidpingfriendly = 0;
	packobject.objidpingenemy = 0;
	if(packobject function_4ea98a09())
	{
		/#
			assert(isdefined(objectivename), "");
		#/
		packobject.objid = [];
		level.objidstart = level.objidstart + 2;
		packobject.objectiveid = get_next_obj_id();
		objective_add(packobject.objectiveid, "invisible", packobject.curorigin, objectivename);
	}
	packobject.carrier = undefined;
	packobject.isresetting = 0;
	packobject.interactteam = #"none";
	packobject.allowweapons = 1;
	packobject.visiblecarriermodel = undefined;
	packobject.dropoffset = 0;
	packobject.worldicons = [];
	packobject.carriervisible = 0;
	packobject.visibleteam = #"none";
	packobject.worldiswaypoint = [];
	packobject.worldicons_disabled = [];
	packobject.packicon = undefined;
	packobject.setdropped = undefined;
	packobject.ondrop = undefined;
	packobject.onpickup = undefined;
	packobject.onreset = undefined;
	packobject.usetime = 10000;
	packobject.decayprogress = 0;
	packobject.var_98bb0715 = 1;
	packobject.var_5c196da4 = 0;
	if(packobject.triggertype == "use")
	{
		packobject.trigger setcursorhint("HINT_INTERACTIVE_PROMPT");
		packobject.userate = 1;
		packobject thread use_object_use_think(!allowinitialholddelay, !allowweaponcyclingduringhold);
	}
	else
	{
		packobject setup_touching();
		packobject.curprogress = 0;
		packobject.userate = 0;
		packobject.claimteam = #"none";
		packobject.claimplayer = undefined;
		packobject.lastclaimteam = #"none";
		packobject.lastclaimtime = 0;
		packobject.claimgraceperiod = 0;
		packobject.mustmaintainclaim = 0;
		packobject.cancontestclaim = 0;
		packobject.teamusetimes = [];
		packobject.teamusetexts = [];
		packobject thread use_object_prox_think();
	}
	packobject thread update_carry_object_objective_origin();
	packobject.b_reusable = 1;
	return packobject;
}

/*
	Name: give_pack_object
	Namespace: gameobjects
	Checksum: 0x4BC57DA5
	Offset: 0xF2C0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function give_pack_object(object)
{
	self.packobject[self.packobject.size] = object;
	self thread track_carrier(object);
}

/*
	Name: get_packicon_offset
	Namespace: gameobjects
	Checksum: 0x6CBB8CEA
	Offset: 0xF308
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function get_packicon_offset(index = 0)
{
	if(self issplitscreen())
	{
		size = 25;
		base = -130;
	}
	else
	{
		size = 35;
		base = -40;
	}
	int = base - size * index;
	return int;
}

/*
	Name: adjust_remaining_packicons
	Namespace: gameobjects
	Checksum: 0x9671711A
	Offset: 0xF398
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function adjust_remaining_packicons()
{
	if(!isdefined(self.packicon))
	{
		return;
	}
	if(self.packicon.size > 0)
	{
		for(i = 0; i < self.packicon.size; i++)
		{
			self.packicon[i].x = get_packicon_offset(i);
		}
	}
}

/*
	Name: set_pack_icon
	Namespace: gameobjects
	Checksum: 0x54E45B86
	Offset: 0xF418
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function set_pack_icon(shader)
{
	/#
		assert(self.type == "", "");
	#/
	self.packicon = shader;
}

/*
	Name: init_game_objects
	Namespace: gameobjects
	Checksum: 0xE235DB5
	Offset: 0xF470
	Size: 0x120
	Parameters: 8
	Flags: Linked
*/
function init_game_objects(str_gameobject_bundle, str_team_override, b_allow_companion_command, t_override, a_keyline_objects, str_objective_override, str_tag_override, str_identifier_override)
{
	object = new cinteractobj();
	[[ object ]]->__constructor();
	c_interact_obj = object;
	c_interact_obj.e_object = self;
	str_bundle = undefined;
	if(isdefined(str_gameobject_bundle))
	{
		str_bundle = str_gameobject_bundle;
		self.scriptbundlename = str_bundle;
	}
	else if(self.classname === "scriptbundle_gameobject")
	{
		str_bundle = self.scriptbundlename;
	}
	/#
		assert(isdefined(str_bundle), "" + self.origin);
	#/
	[[ c_interact_obj ]]->init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command, str_objective_override);
	return c_interact_obj;
}

#namespace cinteractobj;

/*
	Name: __constructor
	Namespace: cinteractobj
	Checksum: 0xF958DCE2
	Offset: 0xF598
	Size: 0x12
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.m_str_trigger_type = "use";
}

/*
	Name: __destructor
	Namespace: cinteractobj
	Checksum: 0x553EE287
	Offset: 0xF5B8
	Size: 0x44
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
	/#
		if(getdvarint(#"hash_69e71fbd49bdaa8a", 0))
		{
			iprintlnbold("");
		}
	#/
}

/*
	Name: init_game_object
	Namespace: cinteractobj
	Checksum: 0xAAE128D6
	Offset: 0xF608
	Size: 0x6F4
	Parameters: 8
	Flags: Linked
*/
function init_game_object(str_bundle, str_team_override, str_tag_override, str_identifier_override, a_keyline_objects, t_override, b_allow_companion_command = 1, str_objective_override)
{
	self.m_s_bundle = getscriptbundle(str_bundle);
	/#
		assert(isdefined(self.m_s_bundle), "" + str_bundle + "");
	#/
	if(isdefined(str_tag_override))
	{
		self.m_str_tag = str_tag_override;
	}
	else
	{
		self.m_str_tag = self.m_s_bundle.str_tag;
	}
	if(isentity(self.e_object))
	{
		self.m_v_tag_origin = self.e_object gettagorigin(self.m_str_tag);
	}
	if(!isdefined(self.m_v_tag_origin))
	{
		self.m_str_tag = undefined;
		self.m_v_tag_origin = self.e_object.origin;
		/#
			if(isentity(self.e_object))
			{
				println("" + self.m_s_bundle.str_tag + "" + self.e_object.model);
			}
		#/
	}
	self.m_n_trigger_height = self.m_s_bundle.n_trigger_height;
	self.m_n_trigger_radius = self.m_s_bundle.n_trigger_radius;
	self.m_str_team = self.m_s_bundle.str_team;
	self.var_426bccfd = self.m_s_bundle.var_ce7dda5f;
	self.var_15547ed4 = isdefined(self.m_s_bundle.b_play_vo) && self.m_s_bundle.b_play_vo;
	self.m_str_player_scene_anim = self.m_s_bundle.playerscenebundle;
	self.m_b_scene_use_time_override = self.m_s_bundle.playerscenebundletimeoverride;
	self.m_str_anim = self.m_s_bundle.viewanim;
	self.m_str_obj_anim = self.m_s_bundle.entityanim;
	self.m_b_reusable = self.m_s_bundle.b_reusable;
	self.m_b_auto_reenable = self.m_s_bundle.autoreenable;
	self.m_str_identifier = self.m_s_bundle.str_identifier;
	self.m_str_trigger_type = self.m_s_bundle.triggertype;
	self.m_b_gameobject_scene_alignment = self.m_s_bundle.playerscenebundlegameobjectalignment;
	self.var_7abf2b16 = self.m_s_bundle.var_e45035d4;
	self.var_26a01d70 = self.m_s_bundle.var_1a876104;
	self.m_n_trigger_use_time = self.m_s_bundle.n_trigger_use_time;
	if(!isdefined(self.m_n_trigger_use_time))
	{
		self.m_n_trigger_use_time = 0;
	}
	self.var_14f4f0bc = self.m_s_bundle.var_f6949418;
	if(!isdefined(self.var_14f4f0bc))
	{
		self.var_14f4f0bc = 0;
	}
	if(isdefined(str_identifier_override))
	{
		self.m_str_identifier = str_identifier_override;
	}
	self.m_str_hint = self.m_s_bundle.str_hint;
	if(isdefined(str_objective_override))
	{
		self.m_str_objective = str_objective_override;
	}
	else
	{
		self.m_str_objective = (isdefined(self.m_s_bundle.objective) ? self.m_s_bundle.objective : undefined);
	}
	self.e_object.str_objective_name = self.m_s_bundle.objective;
	self.e_object.var_45aad1f4 = self.m_str_objective;
	self.m_str_type = self.m_s_bundle.gameobjecttype;
	if(isdefined(self.m_s_bundle.allowweapons) && self.m_s_bundle.allowweapons)
	{
		self.m_b_allow_weapons = 1;
	}
	else
	{
		self.m_b_allow_weapons = 0;
	}
	if(isdefined(str_team_override))
	{
		self.m_str_team = str_team_override;
	}
	self.m_str_team = util::get_team_mapping(self.m_str_team);
	if(isdefined(a_keyline_objects))
	{
		self.m_a_keyline_objects = a_keyline_objects;
	}
	else if(isdefined(self.m_s_bundle.model))
	{
		var_ed8e6d51 = util::spawn_model(self.m_s_bundle.model, self.e_object.origin, self.e_object.angles);
		self.m_a_keyline_objects = array(var_ed8e6d51);
	}
	n_trig_x = self.m_s_bundle.triggerxoffset;
	if(!isdefined(n_trig_x))
	{
		n_trig_x = 0;
	}
	n_trig_y = self.m_s_bundle.triggeryoffset;
	if(!isdefined(n_trig_y))
	{
		n_trig_y = 0;
	}
	n_trig_z = self.m_s_bundle.triggerzoffset;
	if(!isdefined(n_trig_z))
	{
		n_trig_z = 0;
	}
	self.m_n_trigger_offset = (n_trig_x, n_trig_y, n_trig_z);
	if(isdefined(self.e_object.func_custom_gameobject_position))
	{
		self.m_n_trigger_offset = (0, 0, 0);
		self.m_v_tag_origin = self.e_object [[self.e_object.func_custom_gameobject_position]]();
	}
	self.m_b_allow_companion_command = b_allow_companion_command;
	if(isdefined(t_override) && isdefined(t_override.classname))
	{
		if(is_valid_gameobject_trigger(t_override))
		{
			self.m_t_interact = t_override;
		}
		assert("");
	}
	self.var_a99c4d4c = [];
	self.var_2854e7f7 = [];
	self create_gameobject_trigger();
	self thread function_768739b6();
}

/*
	Name: create_gameobject_trigger
	Namespace: cinteractobj
	Checksum: 0xA51D4232
	Offset: 0xFD08
	Size: 0xA06
	Parameters: 0
	Flags: Linked
*/
function create_gameobject_trigger()
{
	if(!isdefined(self.m_t_interact))
	{
		if(self.m_str_type === "generic" || self.m_str_trigger_type === "proximity")
		{
			self.m_t_interact = spawn("trigger_radius", self.m_v_tag_origin + self.m_n_trigger_offset + (0, 0, self.m_n_trigger_height / 2), 0, self.m_n_trigger_radius, self.m_n_trigger_height, 1);
		}
		else
		{
			self.m_t_interact = spawn("trigger_radius_use", self.m_v_tag_origin + self.m_n_trigger_offset + (0, 0, self.m_n_trigger_height / 2), 0, self.m_n_trigger_radius, self.m_n_trigger_height, 1);
			if(isdefined(self.e_object.angles))
			{
				self.m_t_interact.angles = self.e_object.angles;
			}
			self.m_t_interact usetriggerrequirelookat(isdefined(self.e_object.require_look_at) && self.e_object.require_look_at);
			self.m_t_interact usetriggerrequirelooktoward(isdefined(self.e_object.require_look_toward) && self.e_object.require_look_toward);
		}
	}
	self.m_t_interact.trigger_offset = self.m_n_trigger_offset;
	self.m_t_interact triggerignoreteam();
	self.m_t_interact setvisibletoall();
	self.m_t_interact setcursorhint("HINT_INTERACTIVE_PROMPT");
	self.m_t_interact.var_a865c2cd = (isdefined(self.m_s_bundle.var_a865c2cd) ? self.m_s_bundle.var_a865c2cd : 0);
	self.m_t_interact.str_hint = self.m_str_hint;
	if(self.m_str_team != #"any")
	{
		self.m_t_interact setteamfortrigger(self.m_str_team);
	}
	if(!isdefined(self.m_a_keyline_objects))
	{
		self.m_a_keyline_objects = [];
	}
	else if(!isarray(self.m_a_keyline_objects))
	{
		self.m_a_keyline_objects = array(self.m_a_keyline_objects);
	}
	switch(self.m_str_type)
	{
		case "carry":
		{
			/#
				assert(isdefined(self.m_a_keyline_objects[0]), "");
			#/
			mdl_gameobject = gameobjects::create_carry_object(self.m_str_team, self.m_t_interact, self.m_a_keyline_objects, (0, 0, 0), self.m_str_objective, self.var_26a01d70);
			break;
		}
		case "pack":
		{
			/#
				assert(isdefined(self.m_a_keyline_objects[0]), "");
			#/
			mdl_gameobject = gameobjects::create_pack_object(self.m_str_team, self.m_t_interact, self.m_a_keyline_objects, (0, 0, 0), self.m_str_objective, self.var_26a01d70);
			break;
		}
		case "generic":
		{
			mdl_gameobject = gameobjects::create_generic_object(self.m_str_team, self.m_t_interact, self.m_a_keyline_objects, (0, 0, 0));
			break;
		}
		case "use":
		default:
		{
			mdl_gameobject = gameobjects::create_use_object(self.m_str_team, self.m_t_interact, self.m_a_keyline_objects, (0, 0, 0), self.m_str_objective, self.var_26a01d70, 0, self.e_object.script_enable_on_start);
			break;
		}
	}
	mdl_gameobject.single_use = 0;
	if(self.m_str_type == "carry" || self.m_str_type == "pack")
	{
		mdl_gameobject.objectiveonself = 1;
		if(isdefined(mdl_gameobject.objectiveid))
		{
			objective_setposition(mdl_gameobject.objectiveid, (0, 0, 0));
		}
		if(isdefined(self.m_s_bundle.carryicon))
		{
			if(self.m_str_type == "carry")
			{
				mdl_gameobject gameobjects::set_carry_icon(self.m_s_bundle.carryicon);
			}
			else
			{
				mdl_gameobject gameobjects::set_pack_icon(self.m_s_bundle.carryicon);
			}
		}
		if(isdefined(self.m_s_bundle.var_39e522a0))
		{
			mdl_gameobject gameobjects::set_visible_carrier_model(self.m_s_bundle.var_39e522a0);
		}
		if(isdefined(self.m_s_bundle.droponusebutton) && self.m_s_bundle.droponusebutton)
		{
			mdl_gameobject gameobjects::function_a8c842d6(self.m_s_bundle.droponusebutton, 1);
		}
		if(isdefined(self.m_s_bundle.weapon))
		{
			mdl_gameobject gameobjects::function_6e870d38(self.m_s_bundle.weapon);
		}
	}
	mdl_gameobject gameobjects::set_identifier(self.m_str_identifier);
	mdl_gameobject.origin = self.m_t_interact.origin;
	mdl_gameobject.angles = self.m_t_interact.angles;
	mdl_gameobject gameobjects::set_owner_team(self.m_str_team);
	if(self.m_str_team == #"any")
	{
		mdl_gameobject gameobjects::allow_use(self.m_str_team);
		mdl_gameobject gameobjects::set_visible_team(self.m_str_team);
	}
	else
	{
		mdl_gameobject gameobjects::allow_use(#"friendly");
		mdl_gameobject gameobjects::set_visible_team(#"friendly");
	}
	mdl_gameobject gameobjects::set_use_time(self.m_n_trigger_use_time);
	mdl_gameobject gameobjects::function_86d3b442(self.var_14f4f0bc);
	mdl_gameobject.str_player_scene_anim = self.m_str_player_scene_anim;
	mdl_gameobject.str_anim = self.m_str_anim;
	mdl_gameobject.b_reusable = self.m_b_reusable;
	mdl_gameobject.b_auto_reenable = self.m_b_auto_reenable;
	mdl_gameobject.allowweapons = self.m_b_allow_weapons;
	mdl_gameobject.b_scene_use_time_override = self.m_b_scene_use_time_override;
	mdl_gameobject.b_use_gameobject_for_alignment = self.m_b_gameobject_scene_alignment;
	mdl_gameobject.var_75ea46f6 = self.var_7abf2b16;
	mdl_gameobject.var_a7ef92ac = self.m_s_bundle.var_559e6e9f;
	mdl_gameobject.b_allow_companion_command = self.m_b_allow_companion_command;
	if(isdefined(self.m_str_obj_anim))
	{
		mdl_gameobject.str_obj_anim = self.m_str_obj_anim;
	}
	mdl_gameobject.t_interact = self.m_t_interact;
	mdl_gameobject.t_interact enablelinkto();
	mdl_gameobject.e_object = self.e_object;
	if(isentity(mdl_gameobject.e_object))
	{
		if(isdefined(self.m_str_tag))
		{
			mdl_gameobject.t_interact linkto(mdl_gameobject.e_object, self.m_str_tag);
		}
		else
		{
			mdl_gameobject.t_interact linkto(mdl_gameobject.e_object);
		}
	}
	if(isdefined(mdl_gameobject.str_player_scene_anim) || isdefined(mdl_gameobject.str_anim))
	{
		mdl_gameobject.dontlinkplayertotrigger = 1;
	}
	if(!mdl_gameobject.e_object flag::exists("gameobject_end_use"))
	{
		mdl_gameobject.e_object flag::init("gameobject_end_use");
	}
	self.e_object.mdl_gameobject = mdl_gameobject;
}

/*
	Name: is_valid_gameobject_trigger
	Namespace: cinteractobj
	Checksum: 0xC53F303D
	Offset: 0x10718
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function is_valid_gameobject_trigger(t_override)
{
	if(self.m_str_trigger_type === "proximity")
	{
		switch(t_override.classname)
		{
			case "trigger_once_new":
			case "trigger_box":
			case "trigger_once":
			case "trigger_radius":
			case "trigger_box_new":
			case "trigger_multiple":
			case "trigger_radius_new":
			case "trigger_multiple_new":
			{
				return 1;
			}
			default:
			{
				return 0;
			}
		}
	}
	else
	{
		switch(t_override.classname)
		{
			case "trigger_use_new":
			case "trigger_radius_use":
			case "hash_6119f399228d396b":
			case "trigger_use":
			{
				return 1;
			}
			default:
			{
				return 0;
			}
		}
	}
	return 0;
}

/*
	Name: function_768739b6
	Namespace: cinteractobj
	Checksum: 0xB7AF34C4
	Offset: 0x10870
	Size: 0x41A
	Parameters: 0
	Flags: Linked
*/
function function_768739b6()
{
	level endon(#"game_ended");
	self.e_object endon(#"death", #"gameobject_end_use");
	self.e_object.mdl_gameobject endon(#"death");
	level waittill(#"all_players_spawned");
	if(self.m_str_team == #"none")
	{
		return;
	}
	var_9c2f0815 = (isdefined(self.e_object.var_f66cebb1) ? self.m_str_team : #"none");
	var_fb20e730 = util::get_players(self.m_str_team);
	while(var_fb20e730.size)
	{
		foreach(e_player in var_fb20e730)
		{
			if(function_aa070e6f(e_player) && !isinarray(self.var_2854e7f7, e_player.team) && !e_player isinvehicle())
			{
				var_ef387694 = {#targetname:self.e_object.var_f66cebb1, #side:var_9c2f0815, #team:self.m_str_team};
				if(isdefined(self.e_object.var_fa2dfcb4))
				{
					function_58ca2822("itfr_dis_obj", undefined, var_ef387694);
				}
				else if(isdefined(self.e_object.var_ff3c99c5))
				{
					function_58ca2822("mini_hint_itct", undefined, var_ef387694);
				}
				else if(isdefined(self.var_426bccfd))
				{
					switch(self.var_426bccfd)
					{
						case "door":
						{
							function_58ca2822("door_hint_itct", undefined, var_ef387694);
							break;
						}
						case "panel":
						{
							function_58ca2822("panl_hint_itct", undefined, var_ef387694);
							break;
						}
						case "radio":
						{
							function_58ca2822("rdio_hint_itct", undefined, var_ef387694);
							break;
						}
						case "console":
						{
							function_58ca2822("cnsl_hint_itct", undefined, var_ef387694);
							break;
						}
						case "climb":
						{
							function_58ca2822("clmb_hint_itct", undefined, var_ef387694);
							break;
						}
						default:
						{
							function_58ca2822("gobj_hint_itct", undefined, var_ef387694);
							break;
						}
					}
				}
				array::add(self.var_2854e7f7, e_player.team);
				break;
			}
		}
		wait(1);
		var_fb20e730 = util::get_players(self.m_str_team);
	}
}

/*
	Name: function_aa070e6f
	Namespace: cinteractobj
	Checksum: 0x8C6163A9
	Offset: 0x10C98
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_aa070e6f(e_player)
{
	if(isdefined(self.e_object) && isdefined(self.e_object.mdl_gameobject) && isdefined(e_player) && (isdefined(self.e_object.mdl_gameobject.b_enabled) && self.e_object.mdl_gameobject.b_enabled))
	{
		return distance2dsquared(self.e_object.origin, e_player.origin) < 675 * 675 && e_player util::is_player_looking_at(self.e_object.origin);
	}
	return 0;
}

#namespace gameobjects;

/*
	Name: cinteractobj
	Namespace: gameobjects
	Checksum: 0xF9E0C889
	Offset: 0x10D78
	Size: 0x176
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cinteractobj()
{
	classes.cinteractobj[0] = spawnstruct();
	classes.cinteractobj[0].__vtable[1442378129] = &cinteractobj::function_aa070e6f;
	classes.cinteractobj[0].__vtable[1988573622] = &cinteractobj::function_768739b6;
	classes.cinteractobj[0].__vtable[1835166644] = &cinteractobj::is_valid_gameobject_trigger;
	classes.cinteractobj[0].__vtable[405623345] = &cinteractobj::create_gameobject_trigger;
	classes.cinteractobj[0].__vtable[489596092] = &cinteractobj::init_game_object;
	classes.cinteractobj[0].__vtable[913321084] = &cinteractobj::__destructor;
	classes.cinteractobj[0].__vtable[674154906] = &cinteractobj::__constructor;
}

/*
	Name: assign_class_object
	Namespace: gameobjects
	Checksum: 0x423D646A
	Offset: 0x10EF8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function assign_class_object(o_class)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.classobj = o_class;
}

/*
	Name: set_onbeginuse_event
	Namespace: gameobjects
	Checksum: 0xFF0DD86
	Offset: 0x10F38
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function set_onbeginuse_event(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.onbeginuse = func;
}

/*
	Name: set_onuse_event
	Namespace: gameobjects
	Checksum: 0x8D947C58
	Offset: 0x10F78
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function set_onuse_event(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.onuse = func;
}

/*
	Name: set_onenduse_event
	Namespace: gameobjects
	Checksum: 0x4C5AA235
	Offset: 0x10FB8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function set_onenduse_event(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.onenduse = func;
}

/*
	Name: set_onpickup_event
	Namespace: gameobjects
	Checksum: 0xA43F90CE
	Offset: 0x10FF8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function set_onpickup_event(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.onpickup = func;
}

/*
	Name: function_13798243
	Namespace: gameobjects
	Checksum: 0x1CE96EED
	Offset: 0x11038
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_13798243(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.ondrop = func;
}

/*
	Name: function_997b21ed
	Namespace: gameobjects
	Checksum: 0x770D6317
	Offset: 0x11078
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_997b21ed(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.oncantuse = func;
}

/*
	Name: function_6362d6ea
	Namespace: gameobjects
	Checksum: 0xE83D422F
	Offset: 0x110B8
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_6362d6ea(func)
{
	mdl_gameobject = function_fd4a5f2f();
	mdl_gameobject.onuseupdate = func;
}

/*
	Name: function_fd4a5f2f
	Namespace: gameobjects
	Checksum: 0x6B347373
	Offset: 0x110F8
	Size: 0x1E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fd4a5f2f()
{
	if(isdefined(self.mdl_gameobject))
	{
		return self.mdl_gameobject;
	}
	return self;
}

/*
	Name: play_interact_anim
	Namespace: gameobjects
	Checksum: 0xEF511ACF
	Offset: 0x11120
	Size: 0x484
	Parameters: 1
	Flags: Linked
*/
function play_interact_anim(e_player)
{
	e_player endon(#"disconnect");
	if(isdefined(self.str_player_scene_anim))
	{
		str_player_scene = self.str_player_scene_anim;
		if(isdefined(self.b_use_gameobject_for_alignment) && self.b_use_gameobject_for_alignment)
		{
			e_align = self.e_object;
		}
		else if(isdefined(self.var_75ea46f6) && self.var_75ea46f6)
		{
			e_align = e_player;
		}
		else
		{
			e_align = level;
		}
		a_ents = array(e_player);
		if(self.type == "carryObject")
		{
			if(!isdefined(a_ents))
			{
				a_ents = [];
			}
			else if(!isarray(a_ents))
			{
				a_ents = array(a_ents);
			}
			a_ents[a_ents.size] = self.visuals[0];
		}
		if(isdefined(self.var_a7ef92ac) && self.var_a7ef92ac)
		{
			var_be17187b = undefined;
			var_be17187b = self waittill(#"gameobject_end_use_player", #"gameobject_abort", #"death");
			if(var_be17187b._notify === "gameobject_end_use_player")
			{
				e_align thread scene::play(str_player_scene, a_ents);
			}
		}
		else
		{
			e_align thread scene::play(str_player_scene, a_ents);
			waitframe(1);
			if(isdefined(self) && isdefined(e_player.str_current_anim) && (isdefined(self.b_scene_use_time_override) && self.b_scene_use_time_override))
			{
				var_484df237 = getanimlength(e_player.str_current_anim);
				self set_use_time(var_484df237);
			}
			while(e_player usebuttonpressed() && (isdefined(self) && isdefined(self.e_object) && !self.e_object flag::get("gameobject_end_use")))
			{
				waitframe(1);
			}
			e_align scene::stop(str_player_scene);
			if(isdefined(self) && self.type == "carryObject" && !isdefined(self.carrier))
			{
				self thread set_dropped(e_player);
			}
		}
	}
	else if(isdefined(self.str_anim))
	{
		mdl_anchor = util::spawn_model("tag_origin", e_player.origin, e_player.angles);
		self thread anchor_delete_watcher(mdl_anchor);
		str_anim = self.str_anim;
		if(isdefined(str_anim))
		{
			e_player thread animation::play(str_anim, mdl_anchor, undefined, 1, 0.2, 0);
		}
		if(isdefined(self.str_obj_anim))
		{
			self.e_object thread animation::play(self.str_obj_anim, self.e_object, undefined, 1, 0.2, 0);
		}
		while(e_player usebuttonpressed() && (isdefined(self) && !self.e_object flag::get("gameobject_end_use")))
		{
			waitframe(1);
		}
		if(e_player.str_current_anim === str_anim)
		{
			e_player thread animation::stop();
		}
	}
}

/*
	Name: anchor_delete_watcher
	Namespace: gameobjects
	Checksum: 0x9A96E327
	Offset: 0x115B0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function anchor_delete_watcher(mdl_anchor)
{
	self.e_object waittill(#"gameobject_end_use", #"gameobject_abort");
	util::wait_network_frame();
	if(isdefined(mdl_anchor))
	{
		mdl_anchor delete();
	}
}

/*
	Name: function_73944efe
	Namespace: gameobjects
	Checksum: 0xF6FD46C8
	Offset: 0x11628
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function function_73944efe(touchlist, touch)
{
	if(!isdefined(touch.player))
	{
		return undefined;
	}
	if(!isplayer(touch.player))
	{
		if(isdefined(touch.player.owner) && isplayer(touch.player.owner))
		{
			if(array::find(touchlist, touch.player.owner) == undefined)
			{
				return touch.player.owner;
			}
		}
	}
	else
	{
		return touch.player;
	}
}

/*
	Name: function_c6fa00c2
	Namespace: gameobjects
	Checksum: 0x682A9170
	Offset: 0x11708
	Size: 0x1B8
	Parameters: 0
	Flags: None
*/
function function_c6fa00c2()
{
	if(!(isdefined(self.var_5c196da4) && self.var_5c196da4))
	{
		return;
	}
	var_5b307a20 = [];
	var_1dbb2b2b = self.var_1dbb2b2b[self.team];
	if(!var_1dbb2b2b.size)
	{
		var_1dbb2b2b = self.var_1dbb2b2b[self.claimteam];
	}
	foreach(contribution in var_1dbb2b2b)
	{
		var_9b38d2c0 = contribution.player;
		percentage = 100 * contribution.contribution / self.usetime;
		var_9b38d2c0.var_759a143b = int(0.5 + percentage);
		if(var_9b38d2c0.var_759a143b > getgametypesetting(#"hash_1c94fa23e276efe9"))
		{
			if(!isdefined(var_5b307a20))
			{
				var_5b307a20 = [];
			}
			else if(!isarray(var_5b307a20))
			{
				var_5b307a20 = array(var_5b307a20);
			}
			var_5b307a20[var_5b307a20.size] = var_9b38d2c0;
		}
	}
	return var_5b307a20;
}

