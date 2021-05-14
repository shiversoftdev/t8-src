// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_3728b3b9606c4299;
#using script_383a3b1bb18ba876;
#using script_47fb62300ac0bd60;
#using script_4a03c204316cf33;
#using script_57c900a7e39234be;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_751513c609504a42;
#using script_eed89631556efd2;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace helicopter;

/*
	Name: init_shared
	Namespace: helicopter
	Checksum: 0x49F5EA8B
	Offset: 0x760
	Size: 0x5CC
	Parameters: 1
	Flags: None
*/
function init_shared(var_fc96f513)
{
	if(!isdefined(level.var_b17af6b4))
	{
		level.var_b17af6b4 = {};
		airsupport::init_shared();
		flak_drone::init_shared();
		path_start = getentarray("heli_start", "targetname");
		loop_start = getentarray("heli_loop_start", "targetname");
		/#
			debug_refresh = 1;
		#/
		thread heli_update_global_dvars(debug_refresh);
		level.chaff_offset[#"attack"] = (-130, 0, -140);
		level.choppercomlinkfriendly = #"veh_t7_drone_hunter";
		level.choppercomlinkenemy = #"hash_7948c5263c738621";
		level.chopperregular = #"hash_7948c5263c738621";
		precachehelicopter(level.chopperregular);
		clientfield::register("vehicle", "heli_comlink_bootup_anim", 1, 1, "int");
		clientfield::register("vehicle", "heli_warn_targeted", 1, 1, "int");
		clientfield::register("vehicle", "heli_warn_locked", 1, 1, "int");
		clientfield::register("vehicle", "heli_warn_fired", 1, 1, "int");
		clientfield::register("vehicle", "active_camo", 1, 3, "int");
		level.heli_paths = [];
		level.heli_loop_paths = [];
		level.heli_startnodes = [];
		level.heli_leavenodes = [];
		level.heli_crash_paths = [];
		level.last_start_node_index = 0;
		level.chopper_fx[#"explode"][#"death"] = "destruct/fx8_atk_chppr_exp_lg";
		level.chopper_fx[#"explode"][#"guard"] = "killstreaks/fx_heli_exp_md";
		level.chopper_fx[#"explode"][#"gunner"] = "killstreaks/fx_vtol_exp";
		level.chopper_fx[#"explode"][#"large"] = "killstreaks/fx_heli_exp_sm";
		level.chopper_fx[#"damage"][#"light_smoke"] = "destruct/fx8_atk_chppr_smk_trail";
		level.chopper_fx[#"damage"][#"heavy_smoke"] = "destruct/fx8_atk_chppr_exp_trail";
		level.chopper_fx[#"smoke"][#"trail"] = "destruct/fx8_atk_chppr_exp_trail";
		level.chopper_fx[#"fire"][#"trail"][#"large"] = "killstreaks/fx_heli_smk_trail_engine";
		level._effect[#"heli_comlink_light"][#"friendly"] = #"hash_33eb8912b6c63ecd";
		level._effect[#"heli_comlink_light"][#"enemy"] = #"hash_33eb8912b6c63ecd";
		bundle = struct::get_script_bundle("killstreak", var_fc96f513);
		killstreaks::register_bundle(bundle, &usekillstreakhelicopter);
		killstreaks::set_team_kill_penalty_scale("helicopter_comlink", 0);
		level.killstreakbundle[#"helicopter_comlink"] = bundle;
		level.killstreaks[#"helicopter_comlink"].threatonkill = 1;
		if(!path_start.size && !loop_start.size)
		{
			return;
		}
		heli_path_graph();
	}
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: helicopter
	Checksum: 0xE25AAA38
	Offset: 0xD38
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon(#"cobra_20mm_comlink"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: helicopter
	Checksum: 0x8EE4938D
	Offset: 0xD90
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(helicopter, var_dbd1a594)
{
	helicopter killstreaks::configure_team_internal(var_dbd1a594, 1);
	helicopter.team = var_dbd1a594.team;
	helicopter setteam(var_dbd1a594.team);
	helicopter setowner(var_dbd1a594);
	helicopter.owner = var_dbd1a594;
	hackedcallbackpost(var_dbd1a594);
	helicopter.loopcount = 0;
	if(isdefined(level.var_f1edf93f))
	{
		helicopter notify(#"hash_602ae7ca650d6287");
		var_eb79e7c3 = [[level.var_f1edf93f]]();
		starttime = gettime();
		duration = int(var_eb79e7c3 * 1000);
		helicopter.halftime = starttime + duration * 0.5;
		helicopter.killstreakendtime = starttime + duration;
		helicopter.endtime = starttime + duration;
		helicopter.var_478039e8 = 0;
		helicopter notify(#"hash_12e918889eada2ad");
	}
	var_dbd1a594 thread watchforearlyleave(helicopter);
}

/*
	Name: precachehelicopter
	Namespace: helicopter
	Checksum: 0xB9BB7098
	Offset: 0xF48
	Size: 0x172
	Parameters: 1
	Flags: Linked
*/
function precachehelicopter(model)
{
	level.vehicle_deathmodel[model] = model;
	level.heli_sound[#"hit"] = #"evt_helicopter_hit";
	level.heli_sound[#"hitsecondary"] = #"evt_helicopter_hit";
	level.heli_sound[#"damaged"] = #"null";
	level.heli_sound[#"spinloop"] = #"evt_helicopter_spin_loop";
	level.heli_sound[#"spinstart"] = #"evt_helicopter_spin_start";
	level.heli_sound[#"crash"] = #"evt_helicopter_midair_exp";
	level.heli_sound[#"missilefire"] = #"wpn_hellfire_fire_npc";
}

/*
	Name: function_7da89497
	Namespace: helicopter
	Checksum: 0x5733CC09
	Offset: 0x10C8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_7da89497()
{
	self beginlocationcomlinkselection("map_mortar_selector");
}

/*
	Name: usekillstreakhelicopter
	Namespace: helicopter
	Checksum: 0xCD0985AB
	Offset: 0x10F8
	Size: 0x2D0
	Parameters: 1
	Flags: Linked
*/
function usekillstreakhelicopter(hardpointtype)
{
	if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0)
	{
		return 0;
	}
	if(!isdefined(level.heli_paths) || !level.heli_paths.size)
	{
		/#
			iprintlnbold("");
		#/
		return 0;
	}
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		level.helilocation = self.origin;
	}
	destination = 0;
	missilesenabled = 0;
	if(hardpointtype == "helicopter_x2")
	{
		missilesenabled = 1;
	}
	/#
		assert(level.heli_paths.size > 0, "");
	#/
	random_path = randomint(level.heli_paths[destination].size);
	startnode = level.heli_paths[destination][random_path];
	protectlocation = undefined;
	armored = 0;
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		protectlocation = (level.helilocation[0], level.helilocation[1], int(airsupport::getminimumflyheight()));
		armored = 0;
		startnode = getvalidprotectlocationstart(random_path, protectlocation, destination);
	}
	killstreak_id = self killstreakrules::killstreakstart(hardpointtype, self.team);
	if(killstreak_id == -1)
	{
		return 0;
	}
	if(isdefined(level.var_34f03cda))
	{
		self [[level.var_34f03cda]](hardpointtype);
	}
	self killstreaks::play_killstreak_start_dialog(hardpointtype, self.team, killstreak_id);
	self thread announcehelicopterinbound(hardpointtype);
	thread heli_think(self, startnode, self.team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id);
	return 1;
}

/*
	Name: announcehelicopterinbound
	Namespace: helicopter
	Checksum: 0x60F0755
	Offset: 0x13D0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function announcehelicopterinbound(hardpointtype)
{
	team = self.team;
	self stats::function_e24eec31(killstreaks::get_killstreak_weapon(hardpointtype), #"used", 1);
}

/*
	Name: heli_path_graph
	Namespace: helicopter
	Checksum: 0x1A4EA6CB
	Offset: 0x1430
	Size: 0x714
	Parameters: 0
	Flags: Linked
*/
function heli_path_graph()
{
	path_start = getentarray("heli_start", "targetname");
	path_dest = getentarray("heli_dest", "targetname");
	loop_start = getentarray("heli_loop_start", "targetname");
	gunner_loop_start = getentarray("heli_gunner_loop_start", "targetname");
	leave_nodes = getentarray("heli_leave", "targetname");
	crash_start = getentarray("heli_crash_start", "targetname");
	/#
		assert(isdefined(path_start) && isdefined(path_dest), "");
	#/
	for(i = 0; i < path_dest.size; i++)
	{
		startnode_array = [];
		isprimarydest = 0;
		destnode_pointer = path_dest[i];
		destnode = getent(destnode_pointer.target, "targetname");
		for(j = 0; j < path_start.size; j++)
		{
			todest = 0;
			currentnode = path_start[j];
			while(isdefined(currentnode.target))
			{
				nextnode = getent(currentnode.target, "targetname");
				if(nextnode.origin == destnode.origin)
				{
					todest = 1;
					break;
				}
				/#
					airsupport::debug_print3d_simple("", currentnode, vectorscale((0, 0, -1), 10));
					if(isdefined(nextnode.target))
					{
						airsupport::debug_line(nextnode.origin, getent(nextnode.target, "").origin, (0.25, 0.5, 0.25), 5);
					}
					if(isdefined(currentnode.script_delay))
					{
						airsupport::debug_print3d_simple("" + currentnode.script_delay, currentnode, vectorscale((0, 0, 1), 10));
					}
				#/
				currentnode = nextnode;
			}
			if(todest)
			{
				startnode_array[startnode_array.size] = getent(path_start[j].target, "targetname");
				if(isdefined(path_start[j].script_noteworthy) && path_start[j].script_noteworthy == "primary")
				{
					isprimarydest = 1;
				}
			}
		}
		/#
			assert(isdefined(startnode_array) && startnode_array.size > 0, "");
		#/
		if(isprimarydest)
		{
			level.heli_primary_path = startnode_array;
			continue;
		}
		level.heli_paths[level.heli_paths.size] = startnode_array;
	}
	for(i = 0; i < loop_start.size; i++)
	{
		startnode = getent(loop_start[i].target, "targetname");
		level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
	}
	/#
		assert(isdefined(level.heli_loop_paths[0]), "");
	#/
	for(i = 0; i < gunner_loop_start.size; i++)
	{
		startnode = getent(gunner_loop_start[i].target, "targetname");
		startnode.isgunnerpath = 1;
		level.heli_loop_paths[level.heli_loop_paths.size] = startnode;
	}
	for(i = 0; i < path_start.size; i++)
	{
		if(isdefined(path_start[i].script_noteworthy) && path_start[i].script_noteworthy == "primary")
		{
			continue;
		}
		level.heli_startnodes[level.heli_startnodes.size] = path_start[i];
	}
	/#
		assert(isdefined(level.heli_startnodes[0]), "");
	#/
	for(i = 0; i < leave_nodes.size; i++)
	{
		level.heli_leavenodes[level.heli_leavenodes.size] = leave_nodes[i];
	}
	/#
		assert(isdefined(level.heli_leavenodes[0]), "");
	#/
	for(i = 0; i < crash_start.size; i++)
	{
		crash_start_node = getent(crash_start[i].target, "targetname");
		level.heli_crash_paths[level.heli_crash_paths.size] = crash_start_node;
	}
	/#
		assert(isdefined(level.heli_crash_paths[0]), "");
	#/
}

/*
	Name: heli_update_global_dvars
	Namespace: helicopter
	Checksum: 0xF3A10946
	Offset: 0x1B50
	Size: 0x834
	Parameters: 1
	Flags: Linked
*/
function heli_update_global_dvars(debug_refresh)
{
	do
	{
		level.heli_loopmax = getdvar(#"scr_heli_loopmax", 2);
		level.heli_missile_rof = getdvar(#"scr_heli_missile_rof", 2);
		level.heli_armor = getdvar(#"scr_heli_armor", 500);
		level.heli_maxhealth = getdvar(#"scr_heli_maxhealth", 2000);
		level.heli_amored_maxhealth = getdvar(#"scr_heli_armored_maxhealth", 1500);
		level.heli_missile_max = getdvar(#"scr_heli_missile_max", 20);
		level.heli_dest_wait = getdvar(#"scr_heli_dest_wait", 8);
		level.heli_debug = getdvar(#"scr_heli_debug", 0);
		level.heli_debug_crash = getdvar(#"scr_heli_debug_crash", 0);
		level.heli_targeting_delay = getdvar(#"scr_heli_targeting_delay", 0.1);
		level.heli_turretreloadtime = getdvar(#"scr_heli_turretreloadtime", 0.5);
		level.heli_turretclipsize = getdvar(#"scr_heli_turretclipsize", 60);
		level.heli_visual_range = (isdefined(level.heli_visual_range_override) ? level.heli_visual_range_override : getdvar(#"scr_heli_visual_range", 3500));
		level.heli_missile_range = getdvar(#"scr_heli_missile_range", 100000);
		level.heli_health_degrade = getdvar(#"scr_heli_health_degrade", 0);
		level.heli_turret_target_cone = getdvar(#"scr_heli_turret_target_cone", 0.6);
		level.heli_target_spawnprotection = getdvar(#"scr_heli_target_spawnprotection", 5);
		level.heli_missile_regen_time = getdvar(#"scr_heli_missile_regen_time", 10);
		level.heli_turret_spinup_delay = getdvar(#"scr_heli_turret_spinup_delay", 0.1);
		level.heli_target_recognition = getdvar(#"scr_heli_target_recognition", 0.2);
		level.heli_missile_friendlycare = getdvar(#"scr_heli_missile_friendlycare", 512);
		level.heli_missile_target_cone = getdvar(#"scr_heli_missile_target_cone", 0.6);
		level.heli_valid_target_cone = getdvar(#"scr_heli_missile_valid_target_cone", 0.7);
		level.heli_armor_bulletdamage = getdvar(#"scr_heli_armor_bulletdamage", 0.5);
		level.heli_attract_strength = getdvar(#"scr_heli_attract_strength", 1000);
		level.heli_attract_range = getdvar(#"scr_heli_attract_range", 20000);
		level.helicopterturretmaxangle = getdvar(#"scr_helicopterturretmaxangle", 50);
		level.var_e071ed64 = isdefined(getgametypesetting(#"hash_5f76e2d55ad861ed")) && getgametypesetting(#"hash_5f76e2d55ad861ed") && getdvar(#"hash_3910a4196fe6b62e", 1);
		if(level.var_e071ed64)
		{
			level.heli_protect_time = getdvarint(#"scr_heli_protect_time", 75);
			level.heli_protect_pos_time = getdvarint(#"scr_heli_protect_pos_time", 8);
			level.var_a41ff83e = getdvarint(#"hash_26f6fa23a134bc05", 6);
			level.var_78bf9902 = getdvarint(#"hash_27120423a14b94bb", 8);
			level.heli_protect_radius = getdvarint(#"scr_heli_protect_radius", 1500);
			level.var_17076139 = getdvarint(#"hash_5681be4514516b7a", 1400);
			level.var_c2bbc18f = getdvarint(#"hash_569da8451469c0d0", 1600);
			level.var_d9c77d70 = getdvarint(#"hash_7e0189d9c55ba919", 350);
		}
		else
		{
			level.heli_protect_time = getdvar(#"scr_heli_protect_time", 75);
			level.heli_protect_pos_time = getdvar(#"scr_heli_protect_pos_time", 8);
			level.heli_protect_radius = getdvar(#"scr_heli_protect_radius", 2000);
		}
		level.heli_missile_reload_time = getdvar(#"scr_heli_missile_reload_time", 5);
		level.heli_warning_distance = getdvar(#"scr_heli_warning_distance", 500);
		wait(1);
	}
	while(isdefined(debug_refresh));
}

/*
	Name: set_goal_pos
	Namespace: helicopter
	Checksum: 0xEF17AAC
	Offset: 0x2390
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function set_goal_pos(goalpos, stop)
{
	if(!isdefined(self))
	{
		return;
	}
	self.heligoalpos = goalpos;
	if(level.var_e071ed64)
	{
		if(issentient(self) && ispathfinder(self))
		{
			self setgoal(goalpos, stop);
			self function_a57c34b7(goalpos, stop, 1);
		}
		else
		{
			self function_a57c34b7(goalpos, stop, 0);
		}
	}
	else
	{
		self setgoal(goalpos, stop);
	}
}

/*
	Name: spawn_helicopter
	Namespace: helicopter
	Checksum: 0x64C990E
	Offset: 0x2480
	Size: 0x270
	Parameters: 8
	Flags: Linked
*/
function spawn_helicopter(owner, origin, angles, var_87735872, targetname, target_offset, hardpointtype, killstreak_id)
{
	chopper = spawnvehicle(var_87735872, origin, angles);
	chopper setowner(owner);
	chopper.owner = owner;
	chopper clientfield::set("enemyvehicle", 1);
	chopper.attackers = [];
	chopper.attackerdata = [];
	chopper.attackerdamage = [];
	chopper.flareattackerdamage = [];
	chopper.destroyfunc = &destroyhelicopter;
	chopper.hardpointtype = hardpointtype;
	chopper.killstreak_id = killstreak_id;
	chopper.pilotistalking = 0;
	chopper setdrawinfrared(1);
	chopper.allowcontinuedlockonafterinvis = 1;
	chopper.soundmod = "heli";
	chopper.targetname = "chopper";
	chopper.team = owner.team;
	chopper setteam(owner.team);
	if(!isdefined(target_offset))
	{
		target_offset = (0, 0, 0);
	}
	chopper.target_offset = target_offset;
	target_set(chopper, target_offset);
	chopper.var_54b19f55 = 1;
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		chopper killstreaks::function_2b6aa9e8(hardpointtype);
		chopper.overridevehicledamage = &function_11038a4a;
	}
	chopper setrotorspeed(1);
	return chopper;
}

/*
	Name: function_11038a4a
	Namespace: helicopter
	Checksum: 0xB0F280D3
	Offset: 0x26F8
	Size: 0xFA
	Parameters: 15
	Flags: Linked
*/
function function_11038a4a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	helicopter = self;
	if(smeansofdeath == "MOD_TRIGGER_HURT")
	{
		return 0;
	}
	idamage = self killstreaks::ondamageperweapon("helicopter_comlink", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.lowhealth, undefined, 0, undefined, 1, 1);
	return idamage;
}

/*
	Name: onflakdronedestroyed
	Namespace: helicopter
	Checksum: 0x5DB57E19
	Offset: 0x2800
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function onflakdronedestroyed()
{
	chopper = self;
	if(!isdefined(chopper))
	{
		return;
	}
	chopper.numflares = 0;
	chopper killstreaks::play_pilot_dialog_on_owner("weaponDestroyed", "helicopter_comlink", chopper.killstreak_id);
	chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
}

/*
	Name: explodeoncontact
	Namespace: helicopter
	Checksum: 0x3CB3ABC0
	Offset: 0x2890
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function explodeoncontact(hardpointtype)
{
	self endon(#"death");
	wait(10);
	for(;;)
	{
		self waittill(#"touch");
		self thread heli_explode();
	}
}

/*
	Name: getvalidprotectlocationstart
	Namespace: helicopter
	Checksum: 0xD47D0BA6
	Offset: 0x28E8
	Size: 0x19A
	Parameters: 4
	Flags: Linked
*/
function getvalidprotectlocationstart(random_path, protectlocation, destination, var_aea79ccc = 0)
{
	startnode = level.heli_paths[destination][random_path];
	path_index = random_path + 1 % level.heli_paths[destination].size;
	if(var_aea79ccc)
	{
		innofly = airsupport::crossesnoflyzone(protectlocation + (0, 0, 1), protectlocation);
		if(isdefined(innofly))
		{
			protectlocation = (protectlocation[0], protectlocation[1], level.noflyzones[innofly].origin[2] + level.noflyzones[innofly].height);
		}
		noflyzone = airsupport::crossesnoflyzone(startnode.origin, protectlocation);
		while(isdefined(noflyzone) && path_index != random_path)
		{
			startnode = level.heli_paths[destination][path_index];
			if(isdefined(noflyzone))
			{
				path_index = path_index + 1 % level.heli_paths[destination].size;
			}
		}
	}
	return level.heli_paths[destination][path_index];
}

/*
	Name: getvalidrandomleavenode
	Namespace: helicopter
	Checksum: 0xB884652B
	Offset: 0x2A90
	Size: 0x21C
	Parameters: 2
	Flags: Linked
*/
function getvalidrandomleavenode(start, var_aea79ccc = 1)
{
	if(self === level.vtol)
	{
		foreach(node in level.heli_leavenodes)
		{
			if(isdefined(node.script_noteworthy) && node.script_noteworthy == "primary")
			{
				return node;
			}
		}
	}
	random_leave_node = randomint(level.heli_leavenodes.size);
	leavenode = level.heli_leavenodes[random_leave_node];
	path_index = random_leave_node + 1 % level.heli_leavenodes.size;
	if(var_aea79ccc)
	{
		noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
		isprimary = leavenode.script_noteworthy === "primary";
		while(isdefined(noflyzone) || isprimary && path_index != random_leave_node)
		{
			leavenode = level.heli_leavenodes[path_index];
			noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
			isprimary = leavenode.script_noteworthy === "primary";
			path_index = path_index + 1 % level.heli_leavenodes.size;
		}
	}
	return level.heli_leavenodes[path_index];
}

/*
	Name: getvalidrandomstartnode
	Namespace: helicopter
	Checksum: 0x5F176CE6
	Offset: 0x2CB8
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function getvalidrandomstartnode(dest, var_aea79ccc = 1)
{
	if(!isdefined(level.heli_startnodes) || !level.heli_startnodes.size)
	{
		return undefined;
	}
	path_index = randomint(level.heli_startnodes.size);
	best_index = path_index;
	if(var_aea79ccc)
	{
		count = 0;
		for(i = 0; i < level.heli_startnodes.size; i++)
		{
			startnode = level.heli_startnodes[path_index];
			noflyzone = airsupport::crossesnoflyzone(startnode.origin, dest);
			if(!isdefined(noflyzone))
			{
				best_index = path_index;
				if(path_index != level.last_start_node_index)
				{
					break;
				}
			}
			path_index = path_index + 1 % level.heli_startnodes.size;
		}
	}
	level.last_start_node_index = best_index;
	return level.heli_startnodes[best_index];
}

/*
	Name: getvalidrandomcrashnode
	Namespace: helicopter
	Checksum: 0x410BDC26
	Offset: 0x2E28
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function getvalidrandomcrashnode(start)
{
	random_leave_node = randomint(level.heli_crash_paths.size);
	leavenode = level.heli_crash_paths[random_leave_node];
	path_index = random_leave_node + 1 % level.heli_crash_paths.size;
	noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
	while(isdefined(noflyzone) && path_index != random_leave_node)
	{
		leavenode = level.heli_crash_paths[path_index];
		noflyzone = airsupport::crossesnoflyzone(leavenode.origin, start);
		path_index = path_index + 1 % level.heli_crash_paths.size;
	}
	return level.heli_crash_paths[path_index];
}

/*
	Name: configureteampost
	Namespace: helicopter
	Checksum: 0x952AA20E
	Offset: 0x2F48
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function configureteampost(owner, ishacked)
{
	chopper = self;
	owner thread watchforearlyleave(chopper);
}

/*
	Name: hackedcallbackpost
	Namespace: helicopter
	Checksum: 0xAB767E59
	Offset: 0x2F90
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function hackedcallbackpost(hacker)
{
	heli = self;
	if(isdefined(heli.flak_drone))
	{
		heli.flak_drone flak_drone::configureteam(heli, 1);
	}
}

/*
	Name: heli_think
	Namespace: helicopter
	Checksum: 0xE05B53C6
	Offset: 0x2FF0
	Size: 0x6F4
	Parameters: 8
	Flags: Linked
*/
function heli_think(owner, startnode, heli_team, missilesenabled, protectlocation, hardpointtype, armored, killstreak_id)
{
	heliorigin = startnode.origin;
	heliangles = startnode.angles;
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		choppermodelfriendly = level.choppercomlinkfriendly;
		choppermodelenemy = level.choppercomlinkenemy;
	}
	else
	{
		choppermodelfriendly = level.chopperregular;
		choppermodelenemy = level.chopperregular;
	}
	chopper = spawn_helicopter(owner, heliorigin, heliangles, "veh_t8_helicopter_gunship_mp", choppermodelfriendly, vectorscale((0, 0, 1), 100), hardpointtype, killstreak_id);
	chopper.harpointtype = hardpointtype;
	chopper killstreaks::configure_team(hardpointtype, killstreak_id, owner, "helicopter", undefined, &configureteampost);
	level.vehicle_death_thread[chopper.vehicletype] = level.var_6af968ce;
	if(isdefined(chopper.flak_drone))
	{
		chopper.flak_drone flak_drone::configureteam(chopper, 0);
	}
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		chopper killstreak_hacking::enable_hacking("helicopter_comlink", undefined, &hackedcallbackpost);
	}
	chopper thread watchforemp();
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		chopper.defaultweapon = getweapon(#"cobra_20mm_comlink");
	}
	else
	{
		chopper.defaultweapon = getweapon(#"cobra_20mm");
	}
	chopper.requireddeathcount = owner.deathcount;
	chopper.chaff_offset = level.chaff_offset[#"attack"];
	minigun_snd_ent = spawn("script_origin", chopper gettagorigin("tag_flash"));
	minigun_snd_ent linkto(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
	chopper.minigun_snd_ent = minigun_snd_ent;
	minigun_snd_ent thread autostopsound();
	chopper thread heli_existance();
	level.chopper = chopper;
	chopper.reached_dest = 0;
	if(hardpointtype != "helicopter_comlink" && hardpointtype != "inventory_helicopter_comlink")
	{
		if(armored)
		{
			chopper.maxhealth = level.heli_amored_maxhealth;
		}
		else
		{
			chopper.maxhealth = level.heli_maxhealth;
		}
	}
	if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
	{
		chopper.numflares = 1;
	}
	else if(hardpointtype == "helicopter_guard")
	{
		chopper.numflares = 1;
	}
	else
	{
		chopper.numflares = 2;
	}
	chopper.flareoffset = vectorscale((0, 0, -1), 256);
	chopper.waittime = level.heli_dest_wait;
	chopper.loopcount = 0;
	chopper.evasive = 0;
	chopper.health_bulletdamageble = level.heli_armor;
	chopper.health_evasive = level.heli_armor;
	chopper.targeting_delay = level.heli_targeting_delay;
	chopper.primarytarget = undefined;
	chopper.secondarytarget = undefined;
	chopper.attacker = undefined;
	chopper.missile_ammo = level.heli_missile_max;
	chopper.currentstate = "ok";
	chopper.lastrocketfiretime = -1;
	if(isdefined(protectlocation))
	{
		chopper thread heli_protect(startnode, protectlocation, hardpointtype, heli_team);
		chopper clientfield::set("heli_comlink_bootup_anim", 1);
	}
	else
	{
		chopper thread heli_fly(startnode, 2, hardpointtype);
	}
	if(hardpointtype != "helicopter_comlink")
	{
		chopper thread heli_damage_monitor(hardpointtype);
	}
	chopper killstreaks::play_pilot_dialog_on_owner("arrive", "helicopter_comlink", killstreak_id);
	chopper thread wait_for_killed();
	chopper thread heli_health(hardpointtype);
	chopper thread attack_targets(missilesenabled, hardpointtype);
	chopper thread heli_targeting(missilesenabled, hardpointtype);
	chopper thread heli_missile_regen();
	chopper thread namespace_14c38db0::function_7e1a12ce(level.killstreakbundle[#"helicopter_comlink"].var_2aeadfa0);
	chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
	chopper thread create_flare_ent(vectorscale((0, 0, -1), 150));
}

/*
	Name: autostopsound
	Namespace: helicopter
	Checksum: 0x2EFCF4BC
	Offset: 0x36F0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function autostopsound()
{
	self endon(#"death");
	level waittill(#"game_ended");
	self stoploopsound();
}

/*
	Name: heli_existance
	Namespace: helicopter
	Checksum: 0x3FA41E5F
	Offset: 0x3740
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function heli_existance()
{
	self endon(#"death");
	self waittill(#"leaving");
	self influencers::remove_influencers();
}

/*
	Name: create_flare_ent
	Namespace: helicopter
	Checksum: 0xA982CDE8
	Offset: 0x3788
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function create_flare_ent(offset)
{
	self.flare_ent = spawn("script_model", self gettagorigin("tag_origin"));
	self.flare_ent setmodel(#"tag_origin");
	self.flare_ent linkto(self, "tag_origin", offset);
}

/*
	Name: heli_missile_regen
	Namespace: helicopter
	Checksum: 0x2E585EC0
	Offset: 0x3828
	Size: 0x130
	Parameters: 0
	Flags: Linked
*/
function heli_missile_regen()
{
	self endon(#"death", #"crashing", #"leaving");
	for(;;)
	{
		/#
			airsupport::debug_print3d("" + self.missile_ammo, (0.5, 0.5, 1), self, vectorscale((0, 0, -1), 100), 0);
		#/
		if(self.missile_ammo >= level.heli_missile_max)
		{
			self waittill(#"hash_49f5138339c191ab");
		}
		else if(self.currentstate == "heavy smoke")
		{
			wait(level.heli_missile_regen_time / 4);
		}
		else if(self.currentstate == "light smoke")
		{
			wait(level.heli_missile_regen_time / 2);
		}
		else
		{
			wait(level.heli_missile_regen_time);
		}
		if(self.missile_ammo < level.heli_missile_max)
		{
			self.missile_ammo++;
		}
	}
}

/*
	Name: heli_targeting
	Namespace: helicopter
	Checksum: 0x3AE4A804
	Offset: 0x3960
	Size: 0x5A0
	Parameters: 2
	Flags: Linked
*/
function heli_targeting(missilesenabled, hardpointtype)
{
	self endon(#"death", #"crashing", #"leaving");
	for(;;)
	{
		targets = [];
		targetsmissile = [];
		players = level.players;
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(self cantargetplayer_turret(player, hardpointtype))
			{
				if(isdefined(player))
				{
					targets[targets.size] = player;
				}
			}
			if(missilesenabled && self cantargetplayer_missile(player, hardpointtype))
			{
				if(isdefined(player))
				{
					targetsmissile[targetsmissile.size] = player;
				}
				continue;
			}
			continue;
		}
		tanks = getentarray("talon", "targetname");
		foreach(tank in tanks)
		{
			if(self cantargettank_turret(tank))
			{
				targets[targets.size] = tank;
			}
		}
		actors = getactorarray();
		foreach(actor in actors)
		{
			if(isdefined(actor) && isactor(actor) && isalive(actor))
			{
				if(self cantargetactor_turret(actor, hardpointtype))
				{
					targets[targets.size] = actor;
				}
			}
		}
		if(targets.size == 0 && targetsmissile.size == 0)
		{
			self.primarytarget = undefined;
			self.secondarytarget = undefined;
			/#
				debug_print_target();
			#/
			wait(self.targeting_delay);
			continue;
		}
		if(targets.size == 1)
		{
			if(isdefined(targets[0].type) && (targets[0].type == "dog" || targets[0].type == "tank_drone"))
			{
				killstreaks::update_dog_threat(targets[0]);
			}
			else if(isactor(targets[0]))
			{
				killstreaks::update_actor_threat(targets[0]);
			}
			else
			{
				killstreaks::update_player_threat(targets[0]);
			}
			self.primarytarget = targets[0];
			self notify(#"hash_60aef9581f7a8d3");
			self.secondarytarget = undefined;
			/#
				debug_print_target();
			#/
		}
		else if(targets.size > 1)
		{
			assignprimarytargets(targets);
		}
		if(targetsmissile.size == 1)
		{
			if(!isdefined(targetsmissile[0].type) || targetsmissile[0].type != "dog" || targets[0].type == "tank_drone")
			{
				self killstreaks::update_missile_player_threat(targetsmissile[0]);
			}
			else if(targetsmissile[0].type == "dog")
			{
				self killstreaks::update_missile_dog_threat(targetsmissile[0]);
			}
			self.secondarytarget = targetsmissile[0];
			self notify(#"hash_6dd7a2ff6886252b");
			/#
				debug_print_target();
			#/
		}
		else if(targetsmissile.size > 1)
		{
			assignsecondarytargets(targetsmissile);
		}
		wait(self.targeting_delay);
		/#
			debug_print_target();
		#/
	}
}

/*
	Name: cantargetplayer_turret
	Namespace: helicopter
	Checksum: 0x88AC05A2
	Offset: 0x3F08
	Size: 0x2AC
	Parameters: 2
	Flags: Linked
*/
function cantargetplayer_turret(player, hardpointtype)
{
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(player.ignoreme === 1)
	{
		return 0;
	}
	if(player == self.owner)
	{
		self check_owner(hardpointtype);
		return 0;
	}
	if(player airsupport::cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}
	if(distance(player.origin, self.origin) > level.heli_visual_range)
	{
		return 0;
	}
	if(!isdefined(player.team))
	{
		return 0;
	}
	if(!util::function_fbce7263(player.team, self.team))
	{
		return 0;
	}
	if(player.team == #"spectator")
	{
		return 0;
	}
	if(isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}
	heli_centroid = self.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	visible_amount = player sightconetrace(heli_turret_point, self);
	if(visible_amount < level.heli_target_recognition)
	{
		return 0;
	}
	var_2910def0 = self namespace_14c38db0::function_1c169b3a(player);
	namespace_14c38db0::function_a4d6d6d8(player, int((isdefined(self.targeting_delay) ? self.targeting_delay : 0.25) * 1000));
	if(!var_2910def0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: cantargetactor_turret
	Namespace: helicopter
	Checksum: 0x5E5D1A5D
	Offset: 0x41C0
	Size: 0x16E
	Parameters: 2
	Flags: Linked
*/
function cantargetactor_turret(actor, hardpointtype)
{
	helicopter = self;
	cantarget = 1;
	if(!isalive(actor))
	{
		return actor;
	}
	if(!isdefined(actor.team))
	{
		return 0;
	}
	if(!util::function_fbce7263(actor.team, helicopter.team))
	{
		return 0;
	}
	if(distancesquared(actor.origin, helicopter.origin) > level.heli_visual_range * level.heli_visual_range)
	{
		return 0;
	}
	heli_centroid = helicopter.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(helicopter.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	visible_amount = actor sightconetrace(heli_turret_point, helicopter);
	if(visible_amount < level.heli_target_recognition)
	{
		return 0;
	}
	return cantarget;
}

/*
	Name: getverticaltan
	Namespace: helicopter
	Checksum: 0x950C1E5E
	Offset: 0x4338
	Size: 0xD4
	Parameters: 2
	Flags: None
*/
function getverticaltan(startorigin, endorigin)
{
	vector = endorigin - startorigin;
	opposite = startorigin[2] - endorigin[2];
	if(opposite < 0)
	{
		opposite = opposite * 1;
	}
	adjacent = distance2d(startorigin, endorigin);
	if(adjacent < 0)
	{
		adjacent = adjacent * 1;
	}
	if(adjacent < 0.01)
	{
		adjacent = 0.01;
	}
	tangent = opposite / adjacent;
	return tangent;
}

/*
	Name: cantargetplayer_missile
	Namespace: helicopter
	Checksum: 0x12F97021
	Offset: 0x4418
	Size: 0x2DA
	Parameters: 2
	Flags: Linked
*/
function cantargetplayer_missile(player, hardpointtype)
{
	cantarget = 1;
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(player.ignoreme === 1)
	{
		return 0;
	}
	if(player == self.owner)
	{
		self check_owner(hardpointtype);
		return 0;
	}
	if(player airsupport::cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}
	if(distance(player.origin, self.origin) > level.heli_missile_range)
	{
		return 0;
	}
	if(!isdefined(player.team))
	{
		return 0;
	}
	if(level.teambased && !util::function_fbce7263(player.team, self.team))
	{
		return 0;
	}
	if(player.team == #"spectator")
	{
		return 0;
	}
	if(isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}
	if(self target_cone_check(player, level.heli_missile_target_cone) == 0)
	{
		return 0;
	}
	if(self namespace_14c38db0::function_1c169b3a(player) == 0)
	{
		return 0;
	}
	heli_centroid = self.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!isdefined(player.lasthit))
	{
		player.lasthit = 0;
	}
	player.lasthit = self heliturretsighttrace(heli_turret_point, player, player.lasthit);
	if(player.lasthit != 0)
	{
		return 0;
	}
	return cantarget;
}

/*
	Name: cantargetdog_turret
	Namespace: helicopter
	Checksum: 0xA22BD614
	Offset: 0x4700
	Size: 0x1B2
	Parameters: 1
	Flags: None
*/
function cantargetdog_turret(dog)
{
	cantarget = 1;
	if(!isdefined(dog))
	{
		return 0;
	}
	if(distance(dog.origin, self.origin) > level.heli_visual_range)
	{
		return 0;
	}
	if(!isdefined(dog.team))
	{
		return 0;
	}
	if(level.teambased && !util::function_fbce7263(dog.team, self.team))
	{
		return 0;
	}
	if(isdefined(dog.script_owner) && self.owner == dog.script_owner)
	{
		return 0;
	}
	heli_centroid = self.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!isdefined(dog.lasthit))
	{
		dog.lasthit = 0;
	}
	dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
	if(dog.lasthit != 0)
	{
		return 0;
	}
	return cantarget;
}

/*
	Name: cantargetdog_missile
	Namespace: helicopter
	Checksum: 0xA25AEDE7
	Offset: 0x48C0
	Size: 0x1B2
	Parameters: 1
	Flags: None
*/
function cantargetdog_missile(dog)
{
	cantarget = 1;
	if(!isdefined(dog))
	{
		return 0;
	}
	if(distance(dog.origin, self.origin) > level.heli_missile_range)
	{
		return 0;
	}
	if(!isdefined(dog.team))
	{
		return 0;
	}
	if(level.teambased && !util::function_fbce7263(dog.team, self.team))
	{
		return 0;
	}
	if(isdefined(dog.script_owner) && self.owner == dog.script_owner)
	{
		return 0;
	}
	heli_centroid = self.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	if(!isdefined(dog.lasthit))
	{
		dog.lasthit = 0;
	}
	dog.lasthit = self heliturretdogtrace(heli_turret_point, dog, dog.lasthit);
	if(dog.lasthit != 0)
	{
		return 0;
	}
	return cantarget;
}

/*
	Name: cantargettank_turret
	Namespace: helicopter
	Checksum: 0xB9D5713
	Offset: 0x4A80
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function cantargettank_turret(tank)
{
	cantarget = 1;
	if(!isdefined(tank))
	{
		return 0;
	}
	if(distance(tank.origin, self.origin) > level.heli_visual_range)
	{
		return 0;
	}
	if(!isdefined(tank.team))
	{
		return 0;
	}
	if(level.teambased && !util::function_fbce7263(tank.team, self.team))
	{
		return 0;
	}
	if(isdefined(tank.owner) && self.owner == tank.owner)
	{
		return 0;
	}
	return cantarget;
}

/*
	Name: assignprimarytargets
	Namespace: helicopter
	Checksum: 0x646310BB
	Offset: 0x4B70
	Size: 0x246
	Parameters: 1
	Flags: Linked
*/
function assignprimarytargets(targets)
{
	for(idx = 0; idx < targets.size; idx++)
	{
		if(isdefined(targets[idx].type) && targets[idx].type == "dog")
		{
			killstreaks::update_dog_threat(targets[idx]);
			continue;
		}
		if(isactor(targets[idx]))
		{
			killstreaks::update_actor_threat(targets[idx]);
			continue;
		}
		if(isplayer(targets[idx]))
		{
			killstreaks::update_player_threat(targets[idx]);
			continue;
		}
		killstreaks::update_non_player_threat(targets[idx]);
	}
	/#
		assert(targets.size >= 2, "");
	#/
	highest = 0;
	second_highest = 0;
	primarytarget = undefined;
	for(idx = 0; idx < targets.size; idx++)
	{
		/#
			assert(isdefined(targets[idx].threatlevel), "");
		#/
		if(targets[idx].threatlevel >= highest)
		{
			highest = targets[idx].threatlevel;
			primarytarget = targets[idx];
		}
	}
	/#
		assert(isdefined(primarytarget), "");
	#/
	self.primarytarget = primarytarget;
	self notify(#"hash_60aef9581f7a8d3");
}

/*
	Name: assignsecondarytargets
	Namespace: helicopter
	Checksum: 0xF2BA2C08
	Offset: 0x4DC0
	Size: 0x216
	Parameters: 1
	Flags: Linked
*/
function assignsecondarytargets(targets)
{
	for(idx = 0; idx < targets.size; idx++)
	{
		if(!isdefined(targets[idx].type) || targets[idx].type != "dog")
		{
			self killstreaks::update_missile_player_threat(targets[idx]);
			continue;
		}
		if(targets[idx].type == "dog" || targets[0].type == "tank_drone")
		{
			killstreaks::update_missile_dog_threat(targets[idx]);
		}
	}
	/#
		assert(targets.size >= 2, "");
	#/
	highest = 0;
	second_highest = 0;
	primarytarget = undefined;
	secondarytarget = undefined;
	for(idx = 0; idx < targets.size; idx++)
	{
		/#
			assert(isdefined(targets[idx].missilethreatlevel), "");
		#/
		if(targets[idx].missilethreatlevel >= highest)
		{
			highest = targets[idx].missilethreatlevel;
			secondarytarget = targets[idx];
		}
	}
	/#
		assert(isdefined(secondarytarget), "");
	#/
	self.secondarytarget = secondarytarget;
	self notify(#"hash_6dd7a2ff6886252b");
}

/*
	Name: heli_reset
	Namespace: helicopter
	Checksum: 0x71AEA4F8
	Offset: 0x4FE0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self setyawspeed(75, 45, 45);
	self setmaxpitchroll(30, 30);
	self setneargoalnotifydist(256);
}

/*
	Name: heli_wait
	Namespace: helicopter
	Checksum: 0x14616472
	Offset: 0x5078
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function heli_wait(waittime)
{
	self endon(#"death", #"crashing", #"evasive");
	self thread heli_hover();
	wait(waittime);
	heli_reset();
	self notify(#"hash_6c89e93b924cbb7f");
}

/*
	Name: heli_hover
	Namespace: helicopter
	Checksum: 0x59DDFA0
	Offset: 0x5100
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function heli_hover()
{
	self endon(#"death", #"hash_6c89e93b924cbb7f", #"evasive", #"leaving", #"crashing");
	randint = randomint(360);
	self setgoalyaw(self.angles[1] + randint);
}

/*
	Name: wait_for_killed
	Namespace: helicopter
	Checksum: 0x6296784A
	Offset: 0x51A8
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function wait_for_killed()
{
	self endon(#"death", #"crashing", #"leaving");
	self.bda = 0;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"killed");
		victim = waitresult.victim;
		if(!isdefined(self.owner) || !isdefined(victim))
		{
			continue;
		}
		if(self.owner == victim)
		{
			continue;
		}
		if(level.teambased && !util::function_fbce7263(self.owner.team, victim.team))
		{
			continue;
		}
		self thread wait_for_bda_timeout();
	}
}

/*
	Name: wait_for_bda_timeout
	Namespace: helicopter
	Checksum: 0x1A261A2C
	Offset: 0x52C8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function wait_for_bda_timeout()
{
	self endon(#"killed");
	wait(2.5);
	if(!isdefined(self))
	{
		return;
	}
	self play_bda_dialog();
}

/*
	Name: play_bda_dialog
	Namespace: helicopter
	Checksum: 0x14AB0A80
	Offset: 0x5310
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function play_bda_dialog()
{
	if(self.bda == 1)
	{
		bdadialog = "kill1";
	}
	else if(self.bda == 2)
	{
		bdadialog = "kill2";
	}
	else if(self.bda == 3)
	{
		bdadialog = "kill3";
	}
	else if(self.bda > 3)
	{
		bdadialog = "killMultiple";
	}
	self killstreaks::play_pilot_dialog_on_owner(bdadialog, self.killstreaktype, self.killstreak_id);
	self notify(#"bda_dialog", {#dialog_key:bdadialog});
	self.bda = 0;
}

/*
	Name: heli_hacked_health_update
	Namespace: helicopter
	Checksum: 0x36E46D6D
	Offset: 0x5400
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function heli_hacked_health_update(hacker)
{
	helicopter = self;
	hackeddamagetaken = helicopter.maxhealth - helicopter.hackedhealth;
	/#
		assert(hackeddamagetaken > 0);
	#/
	if(hackeddamagetaken > helicopter.damagetaken)
	{
		helicopter.damagetaken = hackeddamagetaken;
	}
}

/*
	Name: heli_damage_monitor
	Namespace: helicopter
	Checksum: 0x59FAEC96
	Offset: 0x5488
	Size: 0x98A
	Parameters: 1
	Flags: Linked
*/
function heli_damage_monitor(hardpointtype)
{
	helicopter = self;
	self endon(#"death", #"crashing");
	self.damagetaken = 0;
	last_hit_vo = 0;
	hit_vo_spacing = 6000;
	helicopter.hackedhealthupdatecallback = &heli_hacked_health_update;
	helicopter.hackedhealth = killstreak_bundles::get_hacked_health(hardpointtype);
	if(!isdefined(self.attackerdata))
	{
		self.attackers = [];
		self.attackerdata = [];
		self.attackerdamage = [];
		self.flareattackerdamage = [];
	}
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		damage = waitresult.amount;
		type = waitresult.mod;
		flags = waitresult.flags;
		chargelevel = waitresult.chargelevel;
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			continue;
		}
		heli_friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
		if(!heli_friendlyfire)
		{
			continue;
		}
		if(!level.hardcoremode)
		{
			if(isdefined(self.owner) && attacker == self.owner)
			{
				continue;
			}
			if(level.teambased)
			{
				isvalidattacker = isdefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
			}
			else
			{
				isvalidattacker = 1;
			}
			if(!isvalidattacker)
			{
				continue;
			}
		}
		weapon_damage = killstreak_bundles::get_weapon_damage(hardpointtype, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
		if(!isdefined(weapon_damage))
		{
			weapon_damage = killstreaks::get_old_damage(attacker, weapon, type, damage, 1, level.var_926d9f1);
		}
		self.damagetaken = self.damagetaken + weapon_damage;
		playercontrolled = 0;
		if(self.damagetaken > self.maxhealth && !isdefined(self.xpgiven))
		{
			self.xpgiven = 1;
			switch(hardpointtype)
			{
				case "helicopter_comlink":
				case "inventory_helicopter_comlink":
				{
					event = "attack_chopper_shutdown";
					if(self.leaving !== 1)
					{
						self killstreaks::play_destroyed_dialog_on_owner(self.killstreaktype, self.killstreak_id);
					}
					break;
				}
				case "supply_drop":
				case "supply_drop_combat_robot":
				{
					if(isdefined(helicopter.killstreakweaponname))
					{
						switch(helicopter.killstreakweaponname)
						{
							case "tank_robot":
							case "ai_tank_drop_marker":
							case "inventory_ai_tank_marker":
							case "inventory_tank_robot":
							case "ai_tank_marker":
							{
								event = "destroyed_helicopter_agr_drop";
								break;
							}
							case "combat_robot_marker":
							case "inventory_combat_robot_marker":
							case "combat_robot_drop":
							case "inventory_combat_robot_drop":
							{
								event = "destroyed_helicopter_giunit_drop";
								break;
							}
							default:
							{
								event = "care_package_shutdown";
								break;
							}
						}
					}
					else
					{
						event = "care_package_shutdown";
					}
					break;
				}
			}
			if(isdefined(level.var_4d5e1035))
			{
				self [[level.var_4d5e1035]](attacker, weapon, type, weapon_damage, event, playercontrolled, hardpointtype);
			}
			weaponstatname = #"destroyed";
			switch(weapon.name)
			{
				case "tow_turret":
				case "tow_turret_drop":
				case "auto_tow":
				{
					weaponstatname = #"kills";
					break;
				}
			}
			attacker stats::function_e24eec31(weapon, weaponstatname, 1);
			notifystring = undefined;
			killstreakreference = undefined;
			switch(hardpointtype)
			{
				case "helicopter_player_firstperson":
				{
					killstreakreference = "killstreak_helicopter_player_firstperson";
					break;
				}
				case "helicopter_x2":
				case "helicopter_comlink":
				case "helicopter":
				case "inventory_helicopter_comlink":
				{
					notifystring = #"hash_286f843fea185e5";
					killstreakreference = "killstreak_helicopter_comlink";
					break;
				}
				case "supply_drop":
				{
					notifystring = #"hash_3267fdfd0c2b7fdc";
					killstreakreference = "killstreak_supply_drop";
					break;
				}
				case "helicopter_guard":
				{
					killstreakreference = "killstreak_helicopter_guard";
				}
			}
			if(isdefined(killstreakreference))
			{
				level.globalkillstreaksdestroyed++;
				attacker stats::function_e24eec31(getweapon(hardpointtype), #"destroyed", 1);
			}
			if(hardpointtype == "helicopter_player_gunner")
			{
				self.owner sendkillstreakdamageevent(600);
			}
			if(isdefined(notifystring))
			{
				luinotifyevent(#"player_callout", 2, notifystring, attacker.entnum);
			}
			if(isdefined(self.attackers))
			{
				for(j = 0; j < self.attackers.size; j++)
				{
					player = self.attackers[j];
					if(!isdefined(player))
					{
						continue;
					}
					if(player == attacker)
					{
						continue;
					}
					flare_done = self.flareattackerdamage[player.clientid];
					if(isdefined(flare_done) && flare_done == 1)
					{
						scoreevents::processscoreevent(#"aircraft_flare_assist", player, undefined, undefined);
						continue;
					}
					damage_done = self.attackerdamage[player.clientid];
					player thread processcopterassist(self, damage_done);
				}
				self.attackers = [];
			}
			attacker notify(#"destroyed_helicopter");
			if(target_istarget(self))
			{
				target_remove(self);
			}
		}
		else if(isdefined(self.owner) && isplayer(self.owner))
		{
			if(last_hit_vo + hit_vo_spacing < gettime())
			{
				if(type == "MOD_PROJECTILE" || randomintrange(0, 3) == 0)
				{
					last_hit_vo = gettime();
				}
			}
		}
	}
}

/*
	Name: init_active_camo
	Namespace: helicopter
	Checksum: 0x75CAA6B7
	Offset: 0x5E20
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function init_active_camo()
{
	heli = self;
	heli.active_camo_damage = 0;
	heli.active_camo_disabled = 0;
	heli.camo_state = 0;
	heli_set_active_camo_state(1);
	if(isdefined(heli.flak_drone))
	{
		heli.flak_drone flak_drone::setcamostate(1);
	}
}

/*
	Name: heli_set_active_camo_state
	Namespace: helicopter
	Checksum: 0xA73986E3
	Offset: 0x5EA8
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function heli_set_active_camo_state(state)
{
	heli = self;
	if(!isdefined(heli.active_camo_supported))
	{
		return;
	}
	if(state == 0)
	{
		heli clientfield::set("toggle_lights", 1);
		if(heli.camo_state == 1)
		{
			heli playsound(#"veh_hind_cloak_off");
		}
		heli.camo_state = 0;
		heli.camo_state_switch_time = gettime();
	}
	else if(state == 1)
	{
		if(heli.active_camo_disabled)
		{
			return;
		}
		heli clientfield::set("toggle_lights", 0);
		if(heli.camo_state == 0)
		{
			heli playsound(#"veh_hind_cloak_on");
		}
		heli.camo_state = 1;
		heli.camo_state_switch_time = gettime();
		if(isdefined(heli.owner))
		{
			if(isdefined(heli.play_camo_dialog) && heli.play_camo_dialog)
			{
				heli killstreaks::play_pilot_dialog_on_owner("activateCounter", "helicopter_comlink", self.killstreak_id);
				heli.play_camo_dialog = 0;
			}
			else if(!isdefined(heli.play_camo_dialog))
			{
				heli.play_camo_dialog = 1;
			}
		}
	}
	else if(state == 2)
	{
		heli clientfield::set("toggle_lights", 1);
	}
	if(isdefined(heli.flak_drone))
	{
		heli.flak_drone flak_drone::setcamostate(state);
	}
	heli clientfield::set("active_camo", state);
}

/*
	Name: heli_active_camo_damage_update
	Namespace: helicopter
	Checksum: 0x1B402F78
	Offset: 0x6100
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function heli_active_camo_damage_update(damage)
{
	self endon(#"death", #"crashing");
	heli = self;
	heli.active_camo_damage = heli.active_camo_damage + damage;
	if(heli.active_camo_damage > 100)
	{
		heli.active_camo_disabled = 1;
		heli thread heli_active_camo_damage_disable();
	}
	else
	{
		heli heli_set_active_camo_state(2);
		wait(1);
		heli heli_set_active_camo_state(1);
	}
}

/*
	Name: heli_active_camo_damage_disable
	Namespace: helicopter
	Checksum: 0x11CF99DE
	Offset: 0x61E0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function heli_active_camo_damage_disable()
{
	self endon(#"death", #"crashing");
	heli = self;
	heli notify(#"heli_active_camo_damage_disable");
	heli endon(#"heli_active_camo_damage_disable");
	heli heli_set_active_camo_state(0);
	wait(10);
	heli.active_camo_damage = 0;
	heli.active_camo_disabled = 0;
	heli heli_set_active_camo_state(1);
}

/*
	Name: heli_health
	Namespace: helicopter
	Checksum: 0x4FAC767
	Offset: 0x6298
	Size: 0x392
	Parameters: 2
	Flags: Linked
*/
function heli_health(hardpointtype, playernotify)
{
	self endon(#"death", #"crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	damagestate = 3;
	for(;;)
	{
		self waittill(#"damage");
		waitframe(1);
		if(!isdefined(self.damagetaken))
		{
			waitframe(1);
			continue;
		}
		if(!(isdefined(self.var_5b3f091f) && self.var_5b3f091f) && self.damagetaken >= self.maxhealth * 0.5)
		{
			self killstreaks::play_pilot_dialog_on_owner("damaged", "helicopter_comlink", self.killstreak_id);
			self.var_5b3f091f = 1;
		}
		if(self.damagetaken > self.maxhealth)
		{
			damagestate = 0;
			self heli_set_active_camo_state(0);
			self thread heli_crash(hardpointtype, self.owner, playernotify);
			continue;
		}
		if(self.damagetaken >= self.maxhealth * 0.66 && damagestate >= 2)
		{
			if(isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp")
			{
				playfxontag(level.chopper_fx[#"damage"][#"heavy_smoke"], self, "tag_origin");
			}
			else
			{
				playfxontag(level.chopper_fx[#"damage"][#"heavy_smoke"], self, "tag_engine_left");
			}
			damagestate = 1;
			self.currentstate = "heavy smoke";
			self.evasive = 1;
			self notify(#"hash_7654c30da43c0215");
			continue;
		}
		if(self.damagetaken >= self.maxhealth * 0.33 && damagestate == 3)
		{
			if(isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp")
			{
				playfxontag(level.chopper_fx[#"damage"][#"light_smoke"], self, "tag_origin");
			}
			else
			{
				playfxontag(level.chopper_fx[#"damage"][#"light_smoke"], self, "tag_main_rotor");
			}
			damagestate = 2;
			self.currentstate = "light smoke";
			self notify(#"hash_7654c30da43c0215");
		}
	}
}

/*
	Name: heli_evasive
	Namespace: helicopter
	Checksum: 0xBD7F0D1B
	Offset: 0x6638
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function heli_evasive(hardpointtype)
{
	self notify(#"evasive");
	self.evasive = 1;
	loop_startnode = level.heli_loop_paths[0];
	startwait = 2;
	if(isdefined(self.donotstop) && self.donotstop)
	{
		startwait = 0;
	}
	self thread heli_fly(loop_startnode, startwait, hardpointtype);
}

/*
	Name: notify_player
	Namespace: helicopter
	Checksum: 0xE1695CC9
	Offset: 0x66D8
	Size: 0x5A
	Parameters: 3
	Flags: Linked
*/
function notify_player(player, playernotify, delay)
{
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(playernotify))
	{
		return;
	}
	player endon(#"disconnect", playernotify);
	wait(delay);
	player notify(playernotify);
}

/*
	Name: play_going_down_vo
	Namespace: helicopter
	Checksum: 0xA774D9BF
	Offset: 0x6740
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function play_going_down_vo(delay)
{
	self.owner endon(#"disconnect");
	self endon(#"death");
	wait(delay);
}

/*
	Name: heli_crash
	Namespace: helicopter
	Checksum: 0x98866D0D
	Offset: 0x6788
	Size: 0x4E4
	Parameters: 3
	Flags: Linked
*/
function heli_crash(hardpointtype, player, playernotify)
{
	self endon(#"death");
	self notify(#"crashing");
	self influencers::remove_influencers();
	self stoploopsound(0);
	if(isdefined(self.minigun_snd_ent))
	{
		self.minigun_snd_ent stoploopsound();
	}
	if(isdefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent stoploopsound();
	}
	crashtypes = [];
	crashtypes[0] = "crashOnPath";
	crashtypes[1] = "spinOut";
	crashtype = crashtypes[randomint(2)];
	if(isdefined(self.crashtype))
	{
		crashtype = self.crashtype;
	}
	/#
		if(level.heli_debug_crash)
		{
			switch(level.heli_debug_crash)
			{
				case 1:
				{
					crashtype = "";
					break;
				}
				case 2:
				{
					crashtype = "";
					break;
				}
				case 3:
				{
					crashtype = "";
					break;
				}
				default:
				{
				}
			}
		}
	#/
	switch(crashtype)
	{
		case "explode":
		{
			thread notify_player(player, playernotify, 0);
			self thread heli_explode();
			break;
		}
		case "crashonpath":
		{
			if(isdefined(player))
			{
				self thread play_going_down_vo(0.5);
			}
			thread notify_player(player, playernotify, 4);
			self clear_client_flags();
			self thread crashonnearestcrashpath(hardpointtype);
			break;
		}
		case "spinout":
		{
			if(isdefined(player))
			{
				self thread play_going_down_vo(0.5);
			}
			thread notify_player(player, playernotify, 4);
			self clear_client_flags();
			heli_reset();
			heli_speed = 30 + randomint(50);
			heli_accel = 10 + randomint(25);
			leavenode = getvalidrandomcrashnode(self.origin);
			self setspeed(heli_speed, heli_accel);
			self set_goal_pos(leavenode.origin, 0);
			rateofspin = 45 + randomint(90);
			thread heli_secondary_explosions();
			self thread heli_spin(rateofspin);
			self waittill_timeout(randomintrange(4, 6), #"near_goal");
			if(isdefined(player) && isdefined(playernotify))
			{
				player notify(playernotify);
			}
			self thread heli_explode();
			break;
		}
	}
	self thread explodeoncontact(hardpointtype);
	time = randomintrange(4, 6);
	self thread waitthenexplode(time);
}

/*
	Name: damagedrotorfx
	Namespace: helicopter
	Checksum: 0xC624D42C
	Offset: 0x6C78
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function damagedrotorfx()
{
	self endon(#"death");
	self setrotorspeed(0.6);
}

/*
	Name: waitthenexplode
	Namespace: helicopter
	Checksum: 0x6402F8A
	Offset: 0x6CB8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function waitthenexplode(time)
{
	self endon(#"death");
	wait(time);
	self thread heli_explode();
}

/*
	Name: crashonnearestcrashpath
	Namespace: helicopter
	Checksum: 0x7125F558
	Offset: 0x6D00
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function crashonnearestcrashpath(hardpointtype)
{
	crashpathdistance = -1;
	crashpath = level.heli_crash_paths[0];
	for(i = 0; i < level.heli_crash_paths.size; i++)
	{
		currentdistance = distance(self.origin, level.heli_crash_paths[i].origin);
		if(crashpathdistance == -1 || crashpathdistance > currentdistance)
		{
			crashpathdistance = currentdistance;
			crashpath = level.heli_crash_paths[i];
		}
	}
	heli_speed = 30 + randomint(50);
	heli_accel = 10 + randomint(25);
	self setspeed(heli_speed, heli_accel);
	thread heli_secondary_explosions();
	self thread heli_fly(crashpath, 0, hardpointtype);
	rateofspin = 45 + randomint(90);
	self thread heli_spin(rateofspin);
	self endon(#"death");
	self waittill(#"hash_69f631648cf75ba");
	self waittill_timeout(5, #"hash_477c371e4f948b01");
	self thread heli_explode();
}

/*
	Name: checkhelicoptertag
	Namespace: helicopter
	Checksum: 0xF3E5EAA5
	Offset: 0x6F08
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function checkhelicoptertag(tagname)
{
	if(isdefined(self.model))
	{
		if(self.model == "veh_t8_drone_hunter_mp_light")
		{
			switch(tagname)
			{
				case "tag_engine_left":
				{
					return "tag_fx_exhaust2";
				}
				case "tag_engine_right":
				{
					return "tag_fx_exhaust1";
				}
				case "tail_rotor_jnt":
				{
					return "tag_fx_tail";
				}
				default:
				{
					break;
				}
			}
		}
	}
	return tagname;
}

/*
	Name: heli_secondary_explosions
	Namespace: helicopter
	Checksum: 0x6D38AE84
	Offset: 0x6FB0
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function heli_secondary_explosions()
{
	self endon(#"death");
	playfxontag(level.chopper_fx[#"explode"][#"large"], self, self checkhelicoptertag("tag_engine_left"));
	self playsound(level.heli_sound[#"hit"]);
	if(isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp")
	{
		self thread trail_fx(level.chopper_fx[#"smoke"][#"trail"], self checkhelicoptertag("tag_engine_right"), "stop tail smoke");
	}
	else
	{
		self thread trail_fx(level.chopper_fx[#"smoke"][#"trail"], self checkhelicoptertag("tail_rotor_jnt"), "stop tail smoke");
	}
	self thread trail_fx(level.chopper_fx[#"fire"][#"trail"][#"large"], self checkhelicoptertag("tag_engine_left"), "stop body fire");
	wait(3);
	if(!isdefined(self))
	{
		return;
	}
	playfxontag(level.chopper_fx[#"explode"][#"large"], self, self checkhelicoptertag("tag_engine_left"));
	self playsound(level.heli_sound[#"hitsecondary"]);
}

/*
	Name: heli_spin
	Namespace: helicopter
	Checksum: 0x41C9955E
	Offset: 0x7248
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function heli_spin(speed)
{
	self endon(#"death");
	self thread spinsoundshortly();
	self setyawspeed(speed, speed / 3, speed / 3);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + speed * 0.9);
		wait(1);
	}
}

/*
	Name: spinsoundshortly
	Namespace: helicopter
	Checksum: 0x5B4B4D5D
	Offset: 0x72F0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function spinsoundshortly()
{
	self endon(#"death");
	wait(0.25);
	self stoploopsound();
	waitframe(1);
	self playloopsound(level.heli_sound[#"spinloop"]);
	waitframe(1);
	self playsound(level.heli_sound[#"spinstart"]);
}

/*
	Name: trail_fx
	Namespace: helicopter
	Checksum: 0x6E08D4B9
	Offset: 0x7390
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function trail_fx(trail_fx, trail_tag, stop_notify)
{
}

/*
	Name: destroyhelicopter
	Namespace: helicopter
	Checksum: 0xF4F4ECF1
	Offset: 0x73B8
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function destroyhelicopter(var_fec7078b)
{
	team = self.originalteam;
	if(target_istarget(self))
	{
		target_remove(self);
	}
	self influencers::remove_influencers();
	if(isdefined(self.interior_model))
	{
		self.interior_model delete();
		self.interior_model = undefined;
	}
	if(isdefined(self.minigun_snd_ent))
	{
		self.minigun_snd_ent stoploopsound();
		self.minigun_snd_ent delete();
		self.minigun_snd_ent = undefined;
	}
	if(isdefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent delete();
		self.alarm_snd_ent = undefined;
	}
	if(isdefined(self.flare_ent))
	{
		self.flare_ent delete();
		self.flare_ent = undefined;
	}
	killstreakrules::killstreakstop(self.hardpointtype, team, self.killstreak_id);
	if(isdefined(var_fec7078b) && var_fec7078b)
	{
		self function_e1058a3e();
	}
	self delete();
}

/*
	Name: function_e1058a3e
	Namespace: helicopter
	Checksum: 0x2B0D3E4D
	Offset: 0x7568
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function function_e1058a3e()
{
	if(!isdefined(self))
	{
		return;
	}
	forward = self.origin + vectorscale((0, 0, 1), 100) - self.origin;
	if(isdefined(self.helitype) && self.helitype == "littlebird")
	{
		playfx(level.chopper_fx[#"explode"][#"guard"], self.origin, forward);
	}
	else if(isdefined(self.vehicletype) && self.vehicletype == #"heli_player_gunner_mp")
	{
		playfx(level.chopper_fx[#"explode"][#"gunner"], self.origin, forward);
	}
	else if(isdefined(self.vehicletype) && self.vehicletype == #"vehicle_t8_mil_helicopter_swat_transport")
	{
		fxpos = self gettagorigin("tag_deathfx");
		if(!isdefined(fxpos))
		{
			fxpos = self.origin;
		}
		playfx(level.chopper_fx[#"explode"][#"large"], fxpos, forward);
	}
	else
	{
		fxpos = self gettagorigin("tag_deathfx");
		if(!isdefined(fxpos))
		{
			fxpos = self.origin;
		}
		playfx("destruct/fx8_trans_heli_exp_lg", fxpos, forward);
	}
	self playsound(level.heli_sound[#"crash"]);
}

/*
	Name: heli_explode
	Namespace: helicopter
	Checksum: 0xDE2CA399
	Offset: 0x77B0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function heli_explode()
{
	self endon(#"death");
	self function_e1058a3e();
	wait(0.1);
	/#
		assert(isdefined(self.destroyfunc));
	#/
	self [[self.destroyfunc]]();
}

/*
	Name: clear_client_flags
	Namespace: helicopter
	Checksum: 0x61329550
	Offset: 0x7820
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function clear_client_flags()
{
	self clientfield::set("heli_warn_fired", 0);
	self clientfield::set("heli_warn_targeted", 0);
	self clientfield::set("heli_warn_locked", 0);
}

/*
	Name: function_86012f82
	Namespace: helicopter
	Checksum: 0x7F457982
	Offset: 0x7890
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function function_86012f82(goalpos, stop)
{
	if(!isdefined(self))
	{
		return;
	}
	self.heligoalpos = goalpos;
	if(issentient(self) && ispathfinder(self) && ispointinnavvolume(self.origin, "navvolume_big"))
	{
		self setgoal(goalpos, stop);
		self function_a57c34b7(goalpos, stop, 1);
	}
	else
	{
		self function_a57c34b7(goalpos, stop, 0);
	}
}

/*
	Name: function_8de67419
	Namespace: helicopter
	Checksum: 0x8C6EFDB4
	Offset: 0x7978
	Size: 0x186
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8de67419(var_b4c35bb7)
{
	self endon(#"death");
	radius = distance(self.origin, var_b4c35bb7);
	var_a9a839e2 = getclosestpointonnavvolume(var_b4c35bb7, "navvolume_big", radius);
	if(isdefined(var_a9a839e2))
	{
		self function_86012f82(var_a9a839e2, 0);
		while(true)
		{
			/#
				recordsphere(var_a9a839e2, 8, (0, 0, 1), "");
			#/
			var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");
			if(!var_baa92af9)
			{
				if(issentient(self))
				{
					self function_60d50ea4();
				}
				self notify(#"hash_2bf34763927dd61b");
				break;
			}
			waitframe(1);
		}
	}
	else if(issentient(self))
	{
		self function_60d50ea4();
	}
	self notify(#"hash_2bf34763927dd61b");
}

/*
	Name: function_62eb6272
	Namespace: helicopter
	Checksum: 0x5B451B77
	Offset: 0x7B08
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function function_62eb6272(var_70031e7b)
{
	self notify(#"hash_51364ded7e42dc41");
	self notify(#"leaving");
	hardpointtype = self.hardpointtype;
	self.leaving = 1;
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](self, 0);
	}
	if(!self.destroyscoreeventgiven === 1)
	{
		self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
		self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
	}
	leavenode = getvalidrandomleavenode(self.origin);
	var_b4c35bb7 = leavenode.origin;
	if(isdefined(var_70031e7b))
	{
		var_b4c35bb7 = var_70031e7b;
	}
	heli_reset();
	self vehclearlookat();
	exitangles = vectortoangles(var_b4c35bb7 - self.origin);
	self setgoalyaw(exitangles[1]);
	wait(1.5);
	if(!isdefined(self))
	{
		return;
	}
	/#
		self util::debug_slow_heli_speed();
	#/
	self set_goal_pos(self.origin + var_b4c35bb7 - self.origin / 2 + vectorscale((0, 0, 1), 1000), 0);
	self waittill(#"near_goal", #"death");
	if(isdefined(self))
	{
		self set_goal_pos(var_b4c35bb7, 1);
		self waittill(#"goal", #"death");
		if(isdefined(self))
		{
			self stoploopsound(1);
			self util::death_notify_wrapper();
			if(isdefined(self.alarm_snd_ent))
			{
				self.alarm_snd_ent stoploopsound();
				self.alarm_snd_ent delete();
				self.alarm_snd_ent = undefined;
			}
			/#
				assert(isdefined(self.destroyfunc));
			#/
			self [[self.destroyfunc]]();
		}
	}
}

/*
	Name: function_fabf8bc5
	Namespace: helicopter
	Checksum: 0x1E270537
	Offset: 0x7E18
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_fabf8bc5(var_b4c35bb7)
{
	self endon(#"death", #"near_goal");
	while(true)
	{
		distsq = distancesquared(self.origin, var_b4c35bb7);
		if(distsq <= 10000)
		{
			self notify(#"fallback_goal");
			break;
		}
		if(!ispointinnavvolume(self.origin, "navvolume_big"))
		{
			self notify(#"fallback_goal");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: heli_leave
	Namespace: helicopter
	Checksum: 0xAD44098B
	Offset: 0x7EF0
	Size: 0x42C
	Parameters: 2
	Flags: Linked
*/
function heli_leave(var_70031e7b = undefined, var_1caffd41 = 0)
{
	if(!level.var_e071ed64 || var_1caffd41)
	{
		self thread function_62eb6272(var_70031e7b);
		return;
	}
	self notify(#"hash_51364ded7e42dc41");
	self notify(#"leaving");
	hardpointtype = self.hardpointtype;
	self.leaving = 1;
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](self, 0);
	}
	if(!(isdefined(self.destroyscoreeventgiven) && self.destroyscoreeventgiven))
	{
		self killstreaks::play_pilot_dialog_on_owner("timeout", hardpointtype);
		self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", hardpointtype);
	}
	leavenode = getvalidrandomleavenode(self.origin);
	var_b4c35bb7 = leavenode.origin;
	if(isdefined(var_70031e7b))
	{
		var_b4c35bb7 = var_70031e7b;
	}
	heli_reset();
	self thread function_fabf8bc5(var_b4c35bb7);
	self vehclearlookat();
	exitangles = vectortoangles(var_b4c35bb7 - self.origin);
	self setgoalyaw(exitangles[1]);
	if(!ispointinnavvolume(var_b4c35bb7, "navvolume_big"))
	{
		self thread function_8de67419(var_b4c35bb7);
		if(isdefined(level.var_65f7e97e))
		{
			self waittill_timeout(level.var_65f7e97e, #"fallback_goal", #"hash_2bf34763927dd61b", #"death");
		}
		else
		{
			self waittill(#"fallback_goal", #"hash_2bf34763927dd61b", #"death");
		}
	}
	/#
		self util::debug_slow_heli_speed();
	#/
	if(!isdefined(self))
	{
		return;
	}
	self function_86012f82(var_b4c35bb7, 1);
	if(isdefined(level.var_65f7e97e))
	{
		self waittill_timeout(level.var_65f7e97e, #"fallback_goal", #"near_goal", #"death");
	}
	else
	{
		self waittill(#"fallback_goal", #"near_goal", #"death");
	}
	if(isdefined(self))
	{
		self stoploopsound(1);
		self util::death_notify_wrapper();
		if(isdefined(self.alarm_snd_ent))
		{
			self.alarm_snd_ent stoploopsound();
			self.alarm_snd_ent delete();
			self.alarm_snd_ent = undefined;
		}
		/#
			assert(isdefined(self.destroyfunc));
		#/
		self [[self.destroyfunc]]();
	}
}

/*
	Name: heli_fly
	Namespace: helicopter
	Checksum: 0x2D6780F0
	Offset: 0x8328
	Size: 0x52C
	Parameters: 3
	Flags: Linked
*/
function heli_fly(currentnode, startwait, hardpointtype)
{
	self endon(#"death", #"leaving");
	self notify(#"flying");
	self endon(#"flying", #"abandoned");
	self.reached_dest = 0;
	heli_reset();
	pos = self.origin;
	wait(startwait);
	while(isdefined(currentnode.target))
	{
		var_6cfa3712 = getentarray(currentnode.target, "targetname");
		/#
			assert(isdefined(var_6cfa3712), "");
		#/
		nextnode = var_6cfa3712[0];
		pos = nextnode.origin + vectorscale((0, 0, 1), 30);
		if(isdefined(currentnode.script_airspeed) && isdefined(currentnode.script_accel))
		{
			heli_speed = currentnode.script_airspeed;
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_speed = 30 + randomint(20);
			heli_accel = 10 + randomint(5);
		}
		if(isdefined(self.pathspeedscale))
		{
			heli_speed = heli_speed * self.pathspeedscale;
			heli_accel = heli_accel * self.pathspeedscale;
		}
		if(!isdefined(nextnode.target))
		{
			stop = 1;
		}
		else
		{
			stop = 0;
		}
		/#
			airsupport::debug_line(currentnode.origin, nextnode.origin, (1, 0.5, 0.5), 200);
		#/
		if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke")
		{
			self setspeed(heli_speed, heli_accel);
			self set_goal_pos(pos, stop);
			self waittill(#"near_goal");
			self notify(#"hash_69f631648cf75ba");
		}
		else if(isdefined(nextnode.script_delay) && !isdefined(self.donotstop))
		{
			stop = 1;
		}
		self setspeed(heli_speed, heli_accel);
		self set_goal_pos(pos, stop);
		if(!isdefined(nextnode.script_delay) || isdefined(self.donotstop))
		{
			self waittill(#"near_goal");
			self notify(#"hash_69f631648cf75ba");
		}
		else
		{
			self setgoalyaw(nextnode.angles[1]);
			self waittill(#"goal");
			heli_wait(nextnode.script_delay);
		}
		for(index = 0; index < level.heli_loop_paths.size; index++)
		{
			if(level.heli_loop_paths[index].origin == nextnode.origin)
			{
				self.loopcount++;
			}
		}
		if(self.loopcount >= level.heli_loopmax)
		{
			self thread heli_leave();
			return;
		}
		currentnode = nextnode;
	}
	self setgoalyaw(currentnode.angles[1]);
	self.reached_dest = 1;
	self notify(#"hash_477c371e4f948b01");
	if(isdefined(self.waittime) && self.waittime > 0)
	{
		heli_wait(self.waittime);
	}
	if(isdefined(self))
	{
		self thread heli_evasive(hardpointtype);
	}
}

/*
	Name: set_heli_speed_normal
	Namespace: helicopter
	Checksum: 0xF76AE92
	Offset: 0x8860
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function set_heli_speed_normal()
{
	self setmaxpitchroll(30, 30);
	heli_speed = 30 + randomint(20);
	heli_accel = 10 + randomint(5);
	self setspeed(heli_speed, heli_accel);
	self setyawspeed(75, 45, 45);
}

/*
	Name: set_heli_speed_evasive
	Namespace: helicopter
	Checksum: 0x94655095
	Offset: 0x8918
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function set_heli_speed_evasive()
{
	self setmaxpitchroll(30, 90);
	heli_speed = 50 + randomint(20);
	heli_accel = 30 + randomint(5);
	self setspeed(heli_speed, heli_accel);
	self setyawspeed(100, 75, 75);
}

/*
	Name: set_heli_speed_hover
	Namespace: helicopter
	Checksum: 0xE0F9A692
	Offset: 0x89D0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function set_heli_speed_hover()
{
	self setmaxpitchroll(0, 90);
	self setspeed(20, 10);
	self setyawspeed(55, 25, 25);
}

/*
	Name: is_targeted
	Namespace: helicopter
	Checksum: 0x8093BF97
	Offset: 0x8A38
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function is_targeted()
{
	if(isdefined(self.locking_on) && self.locking_on)
	{
		return 1;
	}
	if(isdefined(self.locked_on) && self.locked_on)
	{
		return 1;
	}
	if(isdefined(self.locking_on_hacking) && self.locking_on_hacking)
	{
		return 1;
	}
	return 0;
}

/*
	Name: heli_mobilespawn
	Namespace: helicopter
	Checksum: 0xE544A0E5
	Offset: 0x8AA8
	Size: 0x144
	Parameters: 1
	Flags: None
*/
function heli_mobilespawn(protectdest)
{
	self endon(#"death");
	self notify(#"flying");
	self endon(#"flying", #"abandoned");
	/#
		iprintlnbold("" + protectdest[0] + "" + protectdest[1] + "" + protectdest[2] + "");
	#/
	heli_reset();
	self sethoverparams(50, 100, 50);
	wait(2);
	set_heli_speed_normal();
	self set_goal_pos(protectdest, 1);
	self waittill(#"near_goal");
	set_heli_speed_hover();
}

/*
	Name: function_656691ab
	Namespace: helicopter
	Checksum: 0xAD2D79E2
	Offset: 0x8BF8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_656691ab()
{
	self endon(#"death", #"abandoned");
	while(true)
	{
		var_baa92af9 = ispointinnavvolume(self.origin, "navvolume_big");
		if(var_baa92af9)
		{
			heli_reset();
			if(!ispathfinder(self))
			{
				self makepathfinder();
			}
			self util::function_c596f193();
			self.ignoreme = 1;
			if(isdefined(self.heligoalpos))
			{
				self set_goal_pos(self.heligoalpos, 1);
			}
			self notify(#"hash_340ab3c2b94ff86a");
			break;
		}
		wait(2);
	}
}

/*
	Name: function_81cba63
	Namespace: helicopter
	Checksum: 0xD78555A8
	Offset: 0x8D28
	Size: 0x22E
	Parameters: 0
	Flags: Linked
*/
function function_81cba63()
{
	self endon(#"death", #"abandoned");
	while(true)
	{
		if(isdefined(self.protectdest))
		{
			/#
				recordsphere(self.protectdest, 8, (0, 0, 1), "");
			#/
		}
		if(isdefined(self.var_6c63b409))
		{
			/#
				recordline(self.protectdest, self.var_6c63b409, (0, 1, 0), "");
				recordsphere(self.var_6c63b409, 8, (0, 1, 0), "");
			#/
		}
		if(isdefined(self.goalpos))
		{
			/#
				recordsphere(self.goalpos, 8, (0, 1, 1), "");
				recordline(self.origin, self.goalpos, (0, 1, 1), "");
			#/
		}
		if(isdefined(self.var_2c1a38eb) && isdefined(self.var_f9d38924))
		{
			/#
				recordsphere(self.var_f9d38924, 8, (0, 1, 0), "");
				recordline(self.var_2c1a38eb, self.var_f9d38924, (0, 1, 0), "");
				record3dtext("" + distance(self.var_2c1a38eb, self.var_f9d38924), self.var_f9d38924 + vectorscale((0, 0, 1), 20), (0, 1, 0), "");
			#/
		}
		waitframe(1);
	}
}

/*
	Name: heli_get_protect_spot
	Namespace: helicopter
	Checksum: 0xA3AA0C22
	Offset: 0x8F60
	Size: 0x41E
	Parameters: 3
	Flags: Linked
*/
function heli_get_protect_spot(protectdest, var_551cf1b9, heli_team)
{
	/#
		assert(isdefined(level.heli_protect_radius));
	#/
	if(!isdefined(var_551cf1b9))
	{
		var_551cf1b9 = level.heli_protect_radius;
	}
	min_radius = int(var_551cf1b9 * 0.4);
	max_radius = var_551cf1b9;
	groundpos = getclosestpointonnavmesh(protectdest, 10000);
	/#
		assert(isdefined(level.var_17076139) && isdefined(level.var_c2bbc18f));
	#/
	/#
		assert(isdefined(level.var_c2bbc18f >= level.var_17076139));
	#/
	var_783ce12c = level.var_17076139;
	var_c4124b8e = level.var_c2bbc18f;
	if(heli_team == #"axis")
	{
		/#
			assert(isdefined(level.var_d9c77d70));
		#/
		var_783ce12c = var_783ce12c + level.var_d9c77d70;
		var_c4124b8e = var_c4124b8e + level.var_d9c77d70;
	}
	hoverheight = var_783ce12c + var_c4124b8e - var_783ce12c / 2;
	radius = 10000;
	if(isdefined(groundpos))
	{
		var_9ff2f344 = undefined;
		if(isdefined(self.primarytarget))
		{
			var_9ff2f344 = getclosestpointonnavmesh(self.primarytarget.origin, 10000);
		}
		if(isdefined(var_9ff2f344))
		{
			groundpos = var_9ff2f344;
		}
		protectdest = (groundpos[0], groundpos[1], groundpos[2] + hoverheight);
		protectdest = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
		if(isdefined(protectdest))
		{
			self.var_2c1a38eb = groundpos;
			self.var_f9d38924 = protectdest;
			halfheight = var_c4124b8e - var_783ce12c / 2;
			queryresult = positionquery_source_navigation(protectdest, min_radius, max_radius, halfheight, 50, self);
			if(isdefined(queryresult.data) && queryresult.data.size)
			{
				validpoints = [];
				var_7f378b0 = randomintrange(var_783ce12c, var_c4124b8e);
				foreach(point in queryresult.data)
				{
					distsq = distancesquared(self.origin, point.origin);
					if(distsq >= var_7f378b0 * var_7f378b0)
					{
						array::add(validpoints, point);
					}
				}
				if(validpoints.size)
				{
					return array::random(validpoints);
				}
			}
		}
	}
	return undefined;
}

/*
	Name: function_438e7b44
	Namespace: helicopter
	Checksum: 0x8580DAE9
	Offset: 0x9388
	Size: 0x57C
	Parameters: 4
	Flags: Linked
*/
function function_438e7b44(startnode, protectdest, hardpointtype, heli_team)
{
	self endon(#"death");
	self notify(#"flying");
	self endon(#"flying", #"abandoned");
	self.reached_dest = 0;
	heli_reset();
	wait(2);
	currentdest = protectdest;
	nodeheight = protectdest[2];
	nextnode = startnode;
	heightoffset = 0;
	if(heli_team == #"axis")
	{
		heightoffset = 400;
	}
	protectdest = (protectdest[0], protectdest[1], nodeheight);
	noflyzoneheight = airsupport::getnoflyzoneheight(protectdest);
	protectdest = (protectdest[0], protectdest[1], noflyzoneheight + heightoffset);
	currentdest = protectdest;
	starttime = gettime();
	self.endtime = starttime + int(level.heli_protect_time * 1000);
	self.halftime = starttime + int(level.heli_protect_time * 0.5 * 1000);
	self.killstreakendtime = int(self.endtime);
	/#
		self util::debug_slow_heli_speed();
	#/
	self set_goal_pos(self.origin + currentdest - self.origin / 3 + vectorscale((0, 0, 1), 1000), 0);
	self waittill(#"near_goal");
	self killstreaks::play_pilot_dialog_on_owner("arrive", hardpointtype, self.killstreak_id);
	self thread updatetargetyaw();
	mapenter = 1;
	var_2ca2e589 = 1;
	while(gettime() < self.endtime)
	{
		if(!(isdefined(self.var_478039e8) && self.var_478039e8) && gettime() >= self.halftime)
		{
			self killstreaks::play_pilot_dialog_on_owner("timecheck", hardpointtype);
			self.var_478039e8 = 1;
		}
		self set_goal_pos(currentdest, 1);
		self thread updatespeedonlock();
		self waittill(#"near_goal");
		hostmigration::waittillhostmigrationdone();
		self notify(#"hash_69f631648cf75ba");
		if(self is_targeted())
		{
			if(isdefined(var_2ca2e589) && var_2ca2e589)
			{
				var_2ca2e589 = 0;
			}
			else
			{
				wait(5);
			}
		}
		else
		{
			waittillframeend();
			time = level.heli_protect_pos_time;
			if(self.evasive == 1)
			{
				time = 2;
			}
			if(isdefined(var_2ca2e589) && var_2ca2e589)
			{
				waitresult = undefined;
				waitresult = self waittill_timeout(time, #"hash_594587fd1093c3b3", #"hash_7cda5f1e15bc902c", #"hash_7654c30da43c0215");
				if(waitresult._notify != "timeout")
				{
					var_2ca2e589 = 0;
				}
			}
			else
			{
				wait(time);
			}
		}
		prevdest = currentdest;
		currentdest = function_d5de7cb1(protectdest, nodeheight);
		noflyzoneheight = airsupport::getnoflyzoneheight(currentdest);
		currentdest = (currentdest[0], currentdest[1], noflyzoneheight + heightoffset);
		noflyzones = airsupport::crossesnoflyzones(prevdest, currentdest);
		if(isdefined(noflyzones) && noflyzones.size > 0)
		{
			currentdest = prevdest;
		}
	}
	self heli_set_active_camo_state(1);
	self thread heli_leave();
}

/*
	Name: heli_random_point_in_radius
	Namespace: helicopter
	Checksum: 0x70A102BA
	Offset: 0x9910
	Size: 0x10E
	Parameters: 2
	Flags: Linked
*/
function heli_random_point_in_radius(protectdest, nodeheight)
{
	min_distance = int(level.heli_protect_radius * 0.2);
	direction = randomintrange(0, 360);
	distance = randomintrange(min_distance, level.heli_protect_radius);
	x = cos(direction);
	y = sin(direction);
	x = x * distance;
	y = y * distance;
	return (protectdest[0] + x, protectdest[1] + y, nodeheight);
}

/*
	Name: function_d5de7cb1
	Namespace: helicopter
	Checksum: 0x3F810F54
	Offset: 0x9A28
	Size: 0xF6
	Parameters: 2
	Flags: Linked
*/
function function_d5de7cb1(protectdest, nodeheight)
{
	protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
	tries = 10;
	noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot);
	while(tries != 0 && isdefined(noflyzone))
	{
		protect_spot = heli_random_point_in_radius(protectdest, nodeheight);
		tries--;
		noflyzone = airsupport::crossesnoflyzone(protectdest, protect_spot);
	}
	noflyzoneheight = airsupport::getnoflyzoneheightcrossed(protectdest, protect_spot, nodeheight);
	return (protect_spot[0], protect_spot[1], noflyzoneheight);
}

/*
	Name: heli_protect
	Namespace: helicopter
	Checksum: 0xAFDC8C21
	Offset: 0x9B28
	Size: 0x5C4
	Parameters: 4
	Flags: Linked
*/
function heli_protect(startnode, protectdest, hardpointtype, heli_team)
{
	if(!(isdefined(level.var_e071ed64) && level.var_e071ed64))
	{
		self thread function_438e7b44(startnode, protectdest, hardpointtype, heli_team);
		return;
	}
	self endon(#"death", #"abandoned");
	self notify(#"flying");
	self endon(#"flying");
	heli_reset();
	self setneargoalnotifydist(400);
	self.reached_dest = 0;
	self.goalradius = 30;
	starttime = gettime();
	self.halftime = starttime + int(level.heli_protect_time * 0.5 * 1000);
	self.killstreakendtime = starttime + int(level.heli_protect_time * 1000);
	self.endtime = starttime + int(level.heli_protect_time * 1000);
	self thread function_656691ab();
	self thread function_81cba63();
	self.protectdest = protectdest;
	self.var_6c63b409 = protectdest;
	radius = 10000;
	if(isdefined(self.owner))
	{
		radius = distance(protectdest, self.origin);
	}
	var_a9a839e2 = getclosestpointonnavvolume(protectdest, "navvolume_big", radius);
	if(isdefined(var_a9a839e2))
	{
		protectdest = var_a9a839e2;
		self.var_6c63b409 = protectdest;
		var_b140bc48 = heli_get_protect_spot(protectdest, 300, heli_team);
		if(isdefined(var_b140bc48))
		{
			self function_86012f82(var_b140bc48.origin, 1);
			protectdest = var_b140bc48.origin;
			self.var_6c63b409 = var_b140bc48.origin;
		}
		else
		{
			self function_86012f82(protectdest, 1);
		}
	}
	/#
		self util::debug_slow_heli_speed();
	#/
	self thread updatetargetyaw();
	self thread updatespeedonlock();
	self function_86012f82(protectdest, 1);
	self waittill_timeout(30, #"near_goal", #"hash_60aef9581f7a8d3");
	self setneargoalnotifydist(256);
	var_520e3459 = level.heli_protect_pos_time;
	var_2ca2e589 = 1;
	while(gettime() < self.killstreakendtime)
	{
		if(!(isdefined(self.var_478039e8) && self.var_478039e8) && gettime() >= self.halftime)
		{
			self killstreaks::play_pilot_dialog_on_owner("timecheck", hardpointtype);
			self.var_478039e8 = 1;
		}
		var_520e3459 = randomintrange(level.var_a41ff83e, level.var_78bf9902);
		if(!isdefined(self))
		{
			return;
		}
		var_c092cd08 = heli_get_protect_spot(protectdest, undefined, heli_team);
		if(isdefined(var_c092cd08))
		{
			self function_86012f82(var_c092cd08.origin, 1);
			self waittill_timeout(10, #"near_goal", #"hash_12e918889eada2ad");
		}
		else
		{
			self waittill_timeout(var_520e3459, #"hash_12e918889eada2ad");
		}
		if(!ispointinnavvolume(self.origin, "navvolume_big"))
		{
			var_a9a839e2 = getclosestpointonnavvolume(self.origin, "navvolume_big", 3000);
			if(isdefined(var_a9a839e2))
			{
				self.origin = var_a9a839e2;
			}
		}
		hostmigration::waittillhostmigrationdone();
		self notify(#"hash_69f631648cf75ba");
	}
	self heli_set_active_camo_state(1);
	self thread heli_leave();
}

/*
	Name: updatespeedonlock
	Namespace: helicopter
	Checksum: 0x1CFE81E7
	Offset: 0xA0F8
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function updatespeedonlock()
{
	self endon(#"death", #"crashing", #"leaving");
	while(true)
	{
		self waittill(#"hash_594587fd1093c3b3", #"hash_7cda5f1e15bc902c");
		self updatespeed();
		wait(1);
	}
}

/*
	Name: updatespeed
	Namespace: helicopter
	Checksum: 0x20C29BA1
	Offset: 0xA180
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function updatespeed()
{
	if(self is_targeted() || (isdefined(self.evasive) && self.evasive))
	{
		set_heli_speed_evasive();
	}
	else
	{
		set_heli_speed_normal();
	}
}

/*
	Name: updatetargetyaw
	Namespace: helicopter
	Checksum: 0xB7677090
	Offset: 0xA1F0
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function updatetargetyaw()
{
	self notify(#"endtargetyawupdate");
	self endon(#"death", #"crashing", #"leaving", #"endtargetyawupdate");
	for(;;)
	{
		if(isdefined(self.primarytarget))
		{
			yaw = math::get_2d_yaw(self.origin, self.primarytarget.origin);
			self settargetyaw(yaw);
		}
		else if(isdefined(self.var_6c63b409))
		{
			yaw = math::get_2d_yaw(self.origin, self.var_6c63b409);
			self settargetyaw(yaw);
		}
		wait(1);
	}
}

/*
	Name: fire_missile
	Namespace: helicopter
	Checksum: 0x8AC2A60F
	Offset: 0xA2F8
	Size: 0x228
	Parameters: 3
	Flags: Linked
*/
function fire_missile(smissiletype, ishots = 1, etarget)
{
	/#
		assert(self.health > 0);
	#/
	weapon = undefined;
	weaponshoottime = undefined;
	tags = [];
	switch(smissiletype)
	{
		case "ffar":
		{
			weapon = getweapon(#"hind_ffar");
			tags[0] = "tag_store_r_2";
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
			break;
		}
	}
	/#
		assert(isdefined(weapon));
	#/
	/#
		assert(tags.size > 0);
	#/
	weaponshoottime = weapon.firetime;
	/#
		assert(isdefined(weaponshoottime));
	#/
	self setvehweapon(weapon);
	nextmissiletag = -1;
	for(i = 0; i < ishots; i++)
	{
		nextmissiletag++;
		if(nextmissiletag >= tags.size)
		{
			nextmissiletag = 0;
		}
		emissile = self fireweapon(0, etarget);
		emissile.killcament = self;
		self.lastrocketfiretime = gettime();
		if(i < ishots - 1)
		{
			wait(weaponshoottime);
		}
	}
}

/*
	Name: check_owner
	Namespace: helicopter
	Checksum: 0x870A3094
	Offset: 0xA528
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function check_owner(hardpointtype)
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team) || self.owner.team != self.team)
	{
		self notify(#"abandoned");
		self thread heli_leave();
	}
}

/*
	Name: attack_targets
	Namespace: helicopter
	Checksum: 0xA699CF08
	Offset: 0xA5B0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function attack_targets(missilesenabled, hardpointtype)
{
	self thread attack_primary(hardpointtype);
	if(missilesenabled)
	{
		self thread attack_secondary(hardpointtype);
	}
}

/*
	Name: attack_secondary
	Namespace: helicopter
	Checksum: 0xF64866DB
	Offset: 0xA608
	Size: 0x1B0
	Parameters: 1
	Flags: Linked
*/
function attack_secondary(hardpointtype)
{
	self endon(#"death", #"crashing", #"leaving");
	for(;;)
	{
		if(isdefined(self.secondarytarget))
		{
			self.secondarytarget.antithreat = undefined;
			self.missiletarget = self.secondarytarget;
			antithreat = 0;
			while(isdefined(self.missiletarget) && isalive(self.missiletarget))
			{
				if(self target_cone_check(self.missiletarget, level.heli_missile_target_cone))
				{
					self thread missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
				}
				else
				{
					break;
				}
				antithreat = antithreat + 100;
				self.missiletarget.antithreat = antithreat;
				wait(level.heli_missile_rof);
				if(!isdefined(self.secondarytarget) || (isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget))
				{
					break;
				}
			}
			if(isdefined(self.missiletarget))
			{
				self.missiletarget.antithreat = undefined;
			}
		}
		self waittill(#"hash_6dd7a2ff6886252b");
		self check_owner(hardpointtype);
	}
}

/*
	Name: turret_target_check
	Namespace: helicopter
	Checksum: 0xB6F388AF
	Offset: 0xA7C0
	Size: 0x102
	Parameters: 2
	Flags: None
*/
function turret_target_check(turrettarget, attackangle)
{
	targetyaw = math::get_2d_yaw(self.origin, turrettarget.origin);
	chopperyaw = self.angles[1];
	if(targetyaw < 0)
	{
		targetyaw = targetyaw * -1;
	}
	targetyaw = int(targetyaw) % 360;
	if(chopperyaw < 0)
	{
		chopperyaw = chopperyaw * -1;
	}
	chopperyaw = int(chopperyaw) % 360;
	if(chopperyaw > targetyaw)
	{
		difference = chopperyaw - targetyaw;
	}
	else
	{
		difference = targetyaw - chopperyaw;
	}
	return difference <= attackangle;
}

/*
	Name: target_cone_check
	Namespace: helicopter
	Checksum: 0x96687AB
	Offset: 0xA8D0
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function target_cone_check(target, conecosine)
{
	heli2target_normal = vectornormalize(target.origin - self.origin);
	heli2forward = anglestoforward(self.angles);
	heli2forward_normal = vectornormalize(heli2forward);
	heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
	if(heli_dot_target >= conecosine)
	{
		/#
			airsupport::debug_print3d_simple("" + heli_dot_target, self, vectorscale((0, 0, -1), 40), 40);
		#/
		return 1;
	}
	return 0;
}

/*
	Name: missile_support
	Namespace: helicopter
	Checksum: 0xFADA7E6A
	Offset: 0xA9D0
	Size: 0x316
	Parameters: 4
	Flags: Linked
*/
function missile_support(target_player, rof, instantfire, endon_notify)
{
	self endon(#"death", #"crashing", #"leaving");
	if(isdefined(endon_notify))
	{
		self endon(endon_notify);
	}
	self.turret_giveup = 0;
	if(!instantfire)
	{
		wait(rof);
		self.turret_giveup = 1;
		self notify(#"hash_239cb033027eceb9");
	}
	if(isdefined(target_player))
	{
		if(level.teambased)
		{
			for(i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				if(isdefined(player.team) && !util::function_fbce7263(player.team, self.team) && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare)
				{
					/#
						airsupport::debug_print3d_simple("", self, vectorscale((0, 0, -1), 80), 40);
					#/
					self notify(#"hash_e4d0e93ec90d140");
					return;
				}
			}
		}
		else
		{
			player = self.owner;
			if(isdefined(player) && isdefined(player.team) && !util::function_fbce7263(player.team, self.team) && distance(player.origin, target_player.origin) <= level.heli_missile_friendlycare)
			{
				/#
					airsupport::debug_print3d_simple("", self, vectorscale((0, 0, -1), 80), 40);
				#/
				self notify(#"hash_e4d0e93ec90d140");
				return;
			}
		}
	}
	if(self.missile_ammo > 0 && isdefined(target_player))
	{
		self fire_missile("ffar", 1, target_player);
		self.missile_ammo--;
		self notify(#"hash_49f5138339c191ab");
	}
	else
	{
		return;
	}
	if(instantfire)
	{
		wait(rof);
		self notify(#"hash_e4d0e93ec90d140");
	}
}

/*
	Name: attack_primary
	Namespace: helicopter
	Checksum: 0xC44CA869
	Offset: 0xACF0
	Size: 0x478
	Parameters: 1
	Flags: Linked
*/
function attack_primary(hardpointtype)
{
	self endon(#"death", #"crashing", #"leaving");
	level endon(#"game_ended");
	self turretsetontargettolerance(0, 5);
	for(;;)
	{
		if(isdefined(self.primarytarget))
		{
			self.primarytarget.antithreat = undefined;
			self.turrettarget = self.primarytarget;
			antithreat = 0;
			last_pos = undefined;
			while(isdefined(self.turrettarget) && isalive(self.turrettarget))
			{
				if(hardpointtype == "helicopter_comlink" || hardpointtype == "inventory_helicopter_comlink")
				{
					self vehlookat(self.turrettarget);
				}
				if(!isdefined(self.turrettarget) || !isalive(self.turrettarget))
				{
					break;
				}
				self turret::set_target(self.turrettarget, undefined, 0);
				self setvehweapon(self.defaultweapon);
				while(!self.turretontarget)
				{
					waitframe(1);
				}
				self notify(#"turret_on_target");
				self heli_set_active_camo_state(0);
				wait(level.heli_turret_spinup_delay);
				weaponshoottime = self.defaultweapon.firetime;
				self setvehweapon(self.defaultweapon);
				for(i = 0; i < level.heli_turretclipsize; i++)
				{
					if(isdefined(self.turrettarget) && isdefined(self.primarytarget))
					{
						if(self.primarytarget != self.turrettarget)
						{
							self turret::set_target(self.primarytarget, vectorscale((0, 0, 1), 10), 0);
							while(!self.turretontarget)
							{
								waitframe(1);
							}
						}
					}
					if(gettime() != self.lastrocketfiretime)
					{
						if(isdefined(self.primarytarget))
						{
							self turret::set_target(self.primarytarget, vectorscale((0, 0, 1), 10), 0);
							s_turret = self turret::_get_turret_data(0);
							minigun = self fireweapon(0, self.primarytarget, s_turret.v_offset);
						}
						else
						{
							minigun = self fireweapon();
						}
					}
					waitframe(1);
				}
				self notify(#"hash_1c98ddac8879f7bc");
				wait(level.heli_turretreloadtime);
				self heli_set_active_camo_state(1);
				if(isdefined(self.turrettarget) && isalive(self.turrettarget))
				{
					antithreat = antithreat + 100;
					self.turrettarget.antithreat = antithreat;
				}
				if(!isdefined(self.primarytarget) || (isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget))
				{
					break;
				}
			}
			if(isdefined(self.turrettarget))
			{
				self.turrettarget.antithreat = undefined;
			}
		}
		self waittill(#"hash_60aef9581f7a8d3");
		self check_owner(hardpointtype);
	}
}

/*
	Name: debug_print_target
	Namespace: helicopter
	Checksum: 0x38914D90
	Offset: 0xB170
	Size: 0x25C
	Parameters: 0
	Flags: None
*/
function debug_print_target()
{
	/#
		if(isdefined(level.heli_debug) && level.heli_debug == 1)
		{
			if(isdefined(self.primarytarget) && isdefined(self.primarytarget.threatlevel))
			{
				if(isdefined(self.primarytarget.type) && self.primarytarget.type == "")
				{
					name = "";
				}
				else
				{
					name = self.primarytarget.name;
				}
				primary_msg = "" + name + "" + self.primarytarget.threatlevel;
			}
			else
			{
				primary_msg = "";
			}
			if(isdefined(self.secondarytarget) && isdefined(self.secondarytarget.threatlevel))
			{
				if(isdefined(self.secondarytarget.type) && self.secondarytarget.type == "")
				{
					name = "";
				}
				else
				{
					name = self.secondarytarget.name;
				}
				secondary_msg = "" + name + "" + self.secondarytarget.threatlevel;
			}
			else
			{
				secondary_msg = "";
			}
			frames = int(self.targeting_delay * 20) + 1;
			thread airsupport::draw_text(primary_msg, (1, 0.6, 0.6), self, vectorscale((0, 0, 1), 40), frames);
			thread airsupport::draw_text(secondary_msg, (1, 0.6, 0.6), self, (0, 0, 0), frames);
		}
	#/
}

/*
	Name: waittill_confirm_location
	Namespace: helicopter
	Checksum: 0xE03023D
	Offset: 0xB3D8
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function waittill_confirm_location()
{
	self endon(#"emp_jammed", #"emp_grenaded");
	waitresult = undefined;
	waitresult = self waittill(#"confirm_location");
	return waitresult.position;
}

/*
	Name: selecthelicopterlocation
	Namespace: helicopter
	Checksum: 0x55A2F5E0
	Offset: 0xB438
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function selecthelicopterlocation(hardpointtype)
{
	self airsupport::function_9e2054b0(&function_7da89497);
	location = self airsupport::waitforlocationselection();
	if(!isdefined(location))
	{
		return 0;
	}
	if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0)
	{
		return 0;
	}
	level.helilocation = location.origin;
	return airsupport::function_83904681(location.origin);
}

/*
	Name: processcopterassist
	Namespace: helicopter
	Checksum: 0xBEEF709B
	Offset: 0xB500
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function processcopterassist(destroyedcopter, damagedone)
{
	self endon(#"disconnect");
	destroyedcopter endon(#"disconnect");
	waitframe(1);
	if(!isdefined(level.teams[self.team]))
	{
		return;
	}
	if(!isdefined(destroyedcopter))
	{
		return;
	}
	if(!util::function_fbce7263(self.team, destroyedcopter.team))
	{
		return;
	}
	assist_level = "aircraft_destruction_assist";
	assist_level_value = int(ceil(damagedone.damage / destroyedcopter.maxhealth * 4));
	if(assist_level_value > 0)
	{
		if(assist_level_value > 3)
		{
			assist_level_value = 3;
		}
		assist_level = assist_level + "_" + assist_level_value * 25;
	}
	scoreevents::processscoreevent(assist_level, self, undefined, undefined);
}

/*
	Name: playpilotdialog
	Namespace: helicopter
	Checksum: 0xE22C6B3A
	Offset: 0xB648
	Size: 0xF4
	Parameters: 4
	Flags: None
*/
function playpilotdialog(dialog, time, voice, shouldwait)
{
	self endon(#"death");
	level endon(#"remote_end");
	if(isdefined(time))
	{
		wait(time);
	}
	if(!isdefined(self.pilotvoicenumber))
	{
		self.pilotvoicenumber = 0;
	}
	if(isdefined(voice))
	{
		voicenumber = voice;
	}
	else
	{
		voicenumber = self.pilotvoicenumber;
	}
	soundalias = level.teamprefix[self.team] + voicenumber + "_" + dialog;
	if(isdefined(self.owner))
	{
		self.owner playpilottalking(shouldwait, soundalias);
	}
}

/*
	Name: playpilottalking
	Namespace: helicopter
	Checksum: 0xBF3AFCAC
	Offset: 0xB748
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function playpilottalking(shouldwait, soundalias)
{
	self endon(#"disconnect", #"joined_team", #"joined_spectators");
	for(trycounter = 0; isdefined(self.pilottalking) && self.pilottalking && trycounter < 10; trycounter++)
	{
		if(isdefined(shouldwait) && !shouldwait)
		{
			return;
		}
		wait(1);
	}
	self.pilottalking = 1;
	self playlocalsound(soundalias);
	wait(3);
	self.pilottalking = 0;
}

/*
	Name: watchforearlyleave
	Namespace: helicopter
	Checksum: 0xF38DD0C6
	Offset: 0xB830
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function watchforearlyleave(chopper)
{
	chopper notify(#"watchforearlyleave_helicopter");
	chopper endon(#"watchforearlyleave_helicopter", #"death");
	self endon(#"heli_timeup");
	self waittill(#"disconnect", #"joined_team", #"joined_spectator");
	if(isdefined(chopper))
	{
		chopper thread heli_leave();
	}
	if(isdefined(self))
	{
		self notify(#"heli_timeup");
	}
}

/*
	Name: watchforemp
	Namespace: helicopter
	Checksum: 0x6FF829DF
	Offset: 0xB8F8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function watchforemp()
{
	heli = self;
	heli endon(#"death", #"heli_timeup");
	heli.owner endon(#"disconnect", #"joined_team", #"joined_spectator", #"changed_specialist");
	heli.owner waittill(#"emp_jammed");
	heli thread heli_explode();
}

