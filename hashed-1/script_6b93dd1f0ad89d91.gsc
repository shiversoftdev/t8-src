// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_2ca4b414b146b498;
#using script_300f815a565e66fb;
#using script_3728b3b9606c4299;
#using script_383a3b1bb18ba876;
#using script_3fda550bc6e1089a;
#using script_47fb62300ac0bd60;
#using script_52d2de9b438adc78;
#using script_5567f9f82a6d84b3;
#using script_57c900a7e39234be;
#using script_59c6bfe164142356;
#using script_5a63672f07149a55;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_6d9aa3cb389aa46a;
#using script_7bafaa95bb1b427e;
#using script_8988fdbc78d6c53;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;

#namespace supplydrop;

/*
	Name: function_89f2df9
	Namespace: supplydrop
	Checksum: 0x749ECE1A
	Offset: 0x798
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"supplydrop", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: supplydrop
	Checksum: 0xE480EEA9
	Offset: 0x7E8
	Size: 0x5BC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.cratemodelfriendly = #"hash_758592f2e1c88aa2";
	level.cratemodelenemy = #"hash_6ad03df2db230f33";
	level.cratemodeltank = #"wpn_t7_drop_box";
	level.cratemodelboobytrapped = #"hash_62a824f2d6a931f8";
	level.vtoldrophelicoptervehicleinfo = "vehicle_t8_mil_helicopter_transport_mp";
	ir_strobe::init_shared();
	level.crateownerusetime = 500;
	level.cratenonownerusetime = int(getgametypesetting(#"cratecapturetime") * 1000);
	level.supplydropdisarmcrate = #"hash_20071ab3686e8d58";
	clientfield::register("vehicle", "supplydrop_care_package_state", 1, 1, "int");
	clientfield::register("vehicle", "supplydrop_ai_tank_state", 1, 1, "int");
	clientfield::register("scriptmover", "supplydrop_thrusters_state", 1, 1, "int");
	clientfield::register("scriptmover", "aitank_thrusters_state", 1, 1, "int");
	level._supply_drop_smoke_fx = "_t7/killstreaks/fx_supply_drop_smoke";
	level._supply_drop_explosion_fx = "explosions/fx_exp_grenade_default";
	killstreaks::function_e4ef8390("killstreak_supply_drop", &usekillstreaksupplydrop);
	killstreaks::allow_assists("supply_drop", 1);
	killstreak_bundles::register_killstreak_bundle("supply_drop_ai_tank");
	killstreak_bundles::register_killstreak_bundle("supply_drop_combat_robot");
	level.cratetypes = [];
	level.categorytypeweight = [];
	ir_strobe::function_8806675d(#"supplydrop_marker", &function_200081db);
	function_d51de8cf("uav", 150, 95);
	function_d51de8cf("recon_car", 150, 75);
	function_d51de8cf("counteruav", 100, 85);
	function_d51de8cf("remote_missile", 90, 100);
	function_d51de8cf("planemortar", 105, 80);
	function_d51de8cf("ultimate_turret", 95, 100);
	function_d51de8cf("helicopter_comlink", 30, 45);
	function_d51de8cf("straferun", 35, 35);
	function_d51de8cf("dart", 125, 75);
	function_d51de8cf("swat_team", 20, 35);
	function_d51de8cf("ac130", 10, 10);
	function_d51de8cf("tank_robot", 30, 40);
	function_d51de8cf("drone_squadron", 30, 40);
	function_d51de8cf("overwatch_helicopter", 30, 40);
	function_e611181f("inventory_tank_robot", "killstreak", "tank_robot", 75, #"hash_6f13430dac318d3b", undefined, undefined, &ai_tank::crateland);
	function_e611181f("tank_robot", "killstreak", "tank_robot", 75, #"hash_6f13430dac318d3b", undefined, undefined, &ai_tank::crateland);
	level.cratecategoryweights = [];
	level.cratecategorytypeweights = [];
	foreach(categorykey, category in level.cratetypes)
	{
		finalizecratecategory(categorykey);
	}
	/#
		level thread supply_drop_dev_gui();
	#/
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: supplydrop
	Checksum: 0x54873ABF
	Offset: 0xDB0
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon(#"supplydrop"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: supplydrop
	Checksum: 0xF1E1FD02
	Offset: 0xE08
	Size: 0x14C
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(supplydrop, var_dbd1a594)
{
	supplydrop.owner = var_dbd1a594;
	supplydrop setowner(var_dbd1a594);
	supplydrop.team = var_dbd1a594.team;
	supplydrop setteam(var_dbd1a594.team);
	supplydrop killstreaks::configure_team_internal(var_dbd1a594, 1);
	supplydrop notify(#"hacked");
	supplydrop thread deleteonownerleave();
	if(isdefined(level.var_f1edf93f))
	{
		supplydrop notify(#"hash_602ae7ca650d6287");
		var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
		supplydrop thread killstreaks::waitfortimeout("inventory_supply_drop", var_eb79e7c3, &cratedelete, "death");
	}
}

/*
	Name: finalizecratecategory
	Namespace: supplydrop
	Checksum: 0x68D482F8
	Offset: 0xF60
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function finalizecratecategory(category)
{
	level.cratecategoryweights[category] = 0;
	cratetypekeys = getarraykeys(level.cratetypes[category]);
	for(cratetype = 0; cratetype < cratetypekeys.size; cratetype++)
	{
		typekey = cratetypekeys[cratetype];
		level.cratetypes[category][typekey].previousweight = level.cratecategoryweights[category];
		level.cratecategoryweights[category] = level.cratecategoryweights[category] + level.cratetypes[category][typekey].weight;
		level.cratetypes[category][typekey].weight = level.cratecategoryweights[category];
	}
}

/*
	Name: setcategorytypeweight
	Namespace: supplydrop
	Checksum: 0x140CAE70
	Offset: 0x1090
	Size: 0x26A
	Parameters: 3
	Flags: None
*/
function setcategorytypeweight(category, type, weight)
{
	if(!isdefined(level.categorytypeweight[category]))
	{
		level.categorytypeweight[category] = [];
	}
	level.categorytypeweight[category][type] = spawnstruct();
	level.categorytypeweight[category][type].weight = weight;
	count = 0;
	totalweight = 0;
	startindex = undefined;
	finalindex = undefined;
	cratenamekeys = getarraykeys(level.cratetypes[category]);
	for(cratename = 0; cratename < cratenamekeys.size; cratename++)
	{
		namekey = cratenamekeys[cratename];
		if(level.cratetypes[category][namekey].type == type)
		{
			count++;
			totalweight = totalweight + level.cratetypes[category][namekey].weight;
			if(!isdefined(startindex))
			{
				startindex = cratename;
			}
			if(isdefined(finalindex) && (finalindex + 1) != cratename)
			{
				/#
					util::error("");
				#/
				callback::abort_level();
				return;
			}
			finalindex = cratename;
		}
	}
	level.categorytypeweight[category][type].totalcrateweight = totalweight;
	level.categorytypeweight[category][type].cratecount = count;
	level.categorytypeweight[category][type].startindex = startindex;
	level.categorytypeweight[category][type].finalindex = finalindex;
}

/*
	Name: function_d51de8cf
	Namespace: supplydrop
	Checksum: 0x5723F3B3
	Offset: 0x1308
	Size: 0xEC
	Parameters: 5
	Flags: Linked
*/
function function_d51de8cf(name, weight, var_16a49f, hint, hint_gambler)
{
	function_e611181f("supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
	function_e611181f("inventory_supplydrop", "killstreak", name, weight, hint, hint_gambler, &givecratekillstreak);
	function_e611181f("gambler", "killstreak", name, var_16a49f, hint, hint_gambler, &givecratekillstreak);
}

/*
	Name: function_e611181f
	Namespace: supplydrop
	Checksum: 0x330340DA
	Offset: 0x1400
	Size: 0x1AA
	Parameters: 8
	Flags: Linked
*/
function function_e611181f(category, type, name, weight, hint, hint_gambler, givefunction, landfunctionoverride)
{
	if(!isdefined(level.cratetypes[category]))
	{
		level.cratetypes[category] = [];
	}
	if(isitemrestricted(name))
	{
		return;
	}
	if(isdefined(level.killstreaks[name]))
	{
		bundle = level.killstreakbundle[name];
		hint = bundle.var_1d2a2ca4;
		hint_gambler = bundle.var_8c4d7906;
	}
	cratetype = spawnstruct();
	cratetype.type = type;
	cratetype.name = name;
	cratetype.weight = weight;
	cratetype.hint = hint;
	cratetype.hint_gambler = hint_gambler;
	cratetype.givefunction = givefunction;
	if(isdefined(landfunctionoverride))
	{
		cratetype.landfunctionoverride = landfunctionoverride;
	}
	level.cratetypes[category][name] = cratetype;
	game.strings[name + "_hint"] = hint;
}

/*
	Name: getrandomcratetype
	Namespace: supplydrop
	Checksum: 0xF70F79B8
	Offset: 0x15B8
	Size: 0x3C2
	Parameters: 2
	Flags: Linked
*/
function getrandomcratetype(category, gambler_crate_name)
{
	if(!isdefined(level.cratetypes) || !isdefined(level.cratetypes[category]))
	{
		return;
	}
	/#
		assert(isdefined(level.cratetypes));
	#/
	/#
		assert(isdefined(level.cratetypes[category]));
	#/
	/#
		assert(isdefined(level.cratecategoryweights[category]));
	#/
	typekey = undefined;
	cratetypestart = 0;
	randomweightend = randomintrange(1, level.cratecategoryweights[category] + 1);
	find_another = 0;
	cratenamekeys = getarraykeys(level.cratetypes[category]);
	if(isdefined(level.categorytypeweight[category]))
	{
		randomweightend = randomint(level.cratecategorytypeweights[category]) + 1;
		cratetypekeys = getarraykeys(level.categorytypeweight[category]);
		for(cratetype = 0; cratetype < cratetypekeys.size; cratetype++)
		{
			typekey = cratetypekeys[cratetype];
			if(level.categorytypeweight[category][typekey].weight < randomweightend)
			{
				continue;
			}
			cratetypestart = level.categorytypeweight[category][typekey].startindex;
			randomweightend = randomint(level.categorytypeweight[category][typekey].totalcrateweight) + 1;
			randomweightend = randomweightend + level.cratetypes[category][cratenamekeys[cratetypestart]].previousweight;
			break;
		}
	}
	for(cratetype = cratetypestart; cratetype < cratenamekeys.size; cratetype++)
	{
		typekey = cratenamekeys[cratetype];
		if(level.cratetypes[category][typekey].weight < randomweightend)
		{
			continue;
		}
		if(isdefined(gambler_crate_name) && level.cratetypes[category][typekey].name == gambler_crate_name)
		{
			find_another = 1;
		}
		if(find_another)
		{
			if(cratetype < cratenamekeys.size - 1)
			{
				cratetype++;
			}
			else if(cratetype > 0)
			{
				cratetype--;
			}
			typekey = cratenamekeys[cratetype];
		}
		break;
	}
	/#
		if(isdefined(level.dev_gui_supply_drop) && level.dev_gui_supply_drop != "" && level.dev_gui_supply_drop != "")
		{
			typekey = level.dev_gui_supply_drop;
		}
	#/
	return level.cratetypes[category][typekey];
}

/*
	Name: givecrateitem
	Namespace: supplydrop
	Checksum: 0x46FBC3C4
	Offset: 0x1988
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function givecrateitem(crate)
{
	if(!isalive(self) || !isdefined(crate.cratetype))
	{
		return;
	}
	/#
		assert(isdefined(crate.cratetype.givefunction), "" + crate.cratetype.name);
	#/
	return [[crate.cratetype.givefunction]]("inventory_" + crate.cratetype.name);
}

/*
	Name: givecratekillstreakwaiter
	Namespace: supplydrop
	Checksum: 0x7B18A891
	Offset: 0x1A50
	Size: 0x76
	Parameters: 3
	Flags: None
*/
function givecratekillstreakwaiter(event, removecrate, extraendon)
{
	self endon(#"give_crate_killstreak_done");
	if(isdefined(extraendon))
	{
		self endon(extraendon);
	}
	self waittill(event);
	self notify(#"give_crate_killstreak_done", {#is_remove:removecrate});
}

/*
	Name: givecratekillstreak
	Namespace: supplydrop
	Checksum: 0xB28C689D
	Offset: 0x1AD0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function givecratekillstreak(killstreak)
{
	self killstreaks::give(killstreak);
}

/*
	Name: givespecializedcrateweapon
	Namespace: supplydrop
	Checksum: 0x38207E4
	Offset: 0x1B00
	Size: 0x19A
	Parameters: 1
	Flags: Linked
*/
function givespecializedcrateweapon(weapon)
{
	switch(weapon.name)
	{
		case "minigun":
		{
			level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
			level weapons::add_limited_weapon(weapon, self, 3);
			break;
		}
		case "m32":
		{
			level thread popups::displayteammessagetoall(#"hash_25ae9096a4ce050c", self);
			level weapons::add_limited_weapon(weapon, self, 3);
			break;
		}
		case "m220_tow":
		{
			level thread popups::displayteammessagetoall(#"hash_51751eb890739762", self);
			level weapons::add_limited_weapon(weapon, self, 3);
			break;
		}
		case "mp40_blinged":
		{
			level thread popups::displayteammessagetoall(#"killstreak_mp40_inbound", self);
			level weapons::add_limited_weapon(weapon, self, 3);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: givecrateweapon
	Namespace: supplydrop
	Checksum: 0x5FE7A603
	Offset: 0x1CA8
	Size: 0x1D8
	Parameters: 1
	Flags: None
*/
function givecrateweapon(weapon_name)
{
	weapon = getweapon(weapon_name);
	if(weapon == level.weaponnone)
	{
		return;
	}
	currentweapon = self getcurrentweapon();
	if(currentweapon == weapon || self hasweapon(weapon))
	{
		self givemaxammo(weapon);
		return 1;
	}
	if(currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		return 1;
	}
	self stats::function_e24eec31(weapon, #"used", 1);
	givespecializedcrateweapon(weapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self waittill(#"weapon_change");
	self killstreak_weapons::usekillstreakweaponfromcrate(weapon);
	return 1;
}

/*
	Name: usesupplydropmarker
	Namespace: supplydrop
	Checksum: 0x1E1BF697
	Offset: 0x1E88
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function usesupplydropmarker(package_contents_id, context)
{
	player = self;
	self endon(#"disconnect", #"spawned_player");
	supplydropweapon = level.weaponnone;
	currentweapon = self getcurrentweapon();
	prevweapon = currentweapon;
	if(currentweapon.issupplydropweapon)
	{
		supplydropweapon = currentweapon;
	}
	if(supplydropweapon.isgrenadeweapon)
	{
		trigger_event = "grenade_fire";
	}
	else
	{
		trigger_event = "weapon_fired";
	}
	trigger_event = "none";
	self thread supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context);
	self.supplygrenadedeathdrop = 0;
	while(true)
	{
		player allowmelee(0);
		notifystring = undefined;
		notifystring = self waittill(#"weapon_change", trigger_event, #"disconnect", #"spawned_player");
		player allowmelee(1);
		if(trigger_event != "none")
		{
			if(notifystring._notify != trigger_event)
			{
				cleanup(context, player);
				return 0;
			}
		}
		if(isdefined(player.markerposition))
		{
			break;
		}
	}
	self notify(#"trigger_weapon_shutdown");
	if(supplydropweapon == level.weaponnone)
	{
		cleanup(context, player);
		return 0;
	}
	return 1;
}

/*
	Name: issupplydropgrenadeallowed
	Namespace: supplydrop
	Checksum: 0xF72590E4
	Offset: 0x20D0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function issupplydropgrenadeallowed(killstreak)
{
	if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1))
	{
		self killstreaks::switch_to_last_non_killstreak_weapon();
		return 0;
	}
	return 1;
}

/*
	Name: adddroplocation
	Namespace: supplydrop
	Checksum: 0x48DDFCCA
	Offset: 0x2130
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function adddroplocation(killstreak_id, location)
{
	level.droplocations[killstreak_id] = location;
}

/*
	Name: deldroplocation
	Namespace: supplydrop
	Checksum: 0x3EA14231
	Offset: 0x2168
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function deldroplocation(killstreak_id)
{
	level.droplocations[killstreak_id] = undefined;
}

/*
	Name: function_4c0ed253
	Namespace: supplydrop
	Checksum: 0xC7429105
	Offset: 0x2190
	Size: 0x2E8
	Parameters: 2
	Flags: Linked
*/
function function_4c0ed253(location, context)
{
	foreach(droplocation in level.droplocations)
	{
		if(distance2dsquared(droplocation, location) < 3600)
		{
			return 0;
		}
	}
	if(context.perform_physics_trace === 1)
	{
		mask = 1;
		if(isdefined(context.tracemask))
		{
			mask = context.tracemask;
		}
		radius = context.radius;
		trace = physicstrace(location + vectorscale((0, 0, 1), 5000), location + vectorscale((0, 0, 1), 30), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
		/#
			if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
			{
				sphere(location, 8, (1, 1, 0), 1, 1, 10, 1);
			}
		#/
		if(trace[#"fraction"] < 1)
		{
			if(!(isdefined(level.var_66da9c3c) && level.var_66da9c3c))
			{
				if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
				{
					util::drawcylinder(trace[#"position"], context.radius, 8000, 0.01666667, undefined, (1, 0, 0), 0.7);
				}
				return 0;
			}
		}
	}
	if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
	{
		util::drawcylinder(trace[#"position"], context.radius, 8000, 0.01666667, undefined, (0, 1, 0), 0.7);
	}
	return 1;
}

/*
	Name: islocationgood
	Namespace: supplydrop
	Checksum: 0x6897A380
	Offset: 0x2480
	Size: 0x4A0
	Parameters: 2
	Flags: Linked
*/
function islocationgood(location, context)
{
	if(getdvarint(#"hash_458cd0a10d30cedb", 1))
	{
		return function_4c0ed253(location, context);
	}
	foreach(droplocation in level.droplocations)
	{
		if(distance2dsquared(droplocation, location) < 3600)
		{
			return 0;
		}
	}
	if(context.perform_physics_trace === 1)
	{
		mask = 1;
		if(isdefined(context.tracemask))
		{
			mask = context.tracemask;
		}
		radius = context.radius;
		trace = physicstrace(location + vectorscale((0, 0, 1), 5000), location + vectorscale((0, 0, 1), 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
		if(trace[#"fraction"] < 1)
		{
			/#
				if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
				{
					sphere(location, radius, (1, 0, 0), 1, 1, 10, 1);
				}
			#/
			return 0;
		}
		/#
			if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
			{
				sphere(location, radius, (0, 0, 1), 1, 1, 10, 1);
			}
		#/
	}
	closestpoint = getclosestpointonnavmesh(location, max(context.max_dist_from_location, 24), context.dist_from_boundary);
	isvalidpoint = isdefined(closestpoint);
	if(isvalidpoint && context.check_same_floor === 1 && (abs(location[2] - closestpoint[2])) > 96)
	{
		isvalidpoint = 0;
	}
	if(isvalidpoint && distance2dsquared(location, closestpoint) > (context.max_dist_from_location * context.max_dist_from_location))
	{
		isvalidpoint = 0;
	}
	/#
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			if(!isvalidpoint)
			{
				otherclosestpoint = getclosestpointonnavmesh(location, getdvarfloat(#"scr_supply_drop_valid_location_radius_debug", 96), context.dist_from_boundary);
				if(isdefined(otherclosestpoint))
				{
					sphere(otherclosestpoint, context.max_dist_from_location, (1, 0, 0), 0.8, 0, 20, 1);
				}
			}
			else
			{
				sphere(closestpoint, context.max_dist_from_location, (0, 1, 0), 0.8, 0, 20, 1);
				util::drawcylinder(closestpoint, context.radius, 8000, 0.01666667, undefined, vectorscale((0, 1, 0), 0.9), 0.7);
			}
		}
	#/
	return isvalidpoint;
}

/*
	Name: usekillstreaksupplydrop
	Namespace: supplydrop
	Checksum: 0x67B884D3
	Offset: 0x2928
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function usekillstreaksupplydrop(killstreak)
{
	player = self;
	if(!player issupplydropgrenadeallowed(killstreak))
	{
		return 0;
	}
	context = spawnstruct();
	context.radius = level.killstreakcorebundle.ksairdropaitankradius;
	context.dist_from_boundary = 50;
	context.max_dist_from_location = 16;
	context.perform_physics_trace = 1;
	context.islocationgood = &islocationgood;
	context.killstreakref = killstreak;
	context.validlocationsound = level.killstreakcorebundle.ksvalidcarepackagelocationsound;
	context.tracemask = 1 | 4;
	context.droptag = "tag_cargo_attach";
	context.var_9fc6cfe9 = 1;
	context.killstreaktype = #"supplydrop_marker";
	return self ir_strobe::function_f625256f(undefined, context);
}

/*
	Name: function_6b6c41a7
	Namespace: supplydrop
	Checksum: 0x57B79ADF
	Offset: 0x2A88
	Size: 0x8C
	Parameters: 3
	Flags: None
*/
function function_6b6c41a7(owner, context, origin)
{
	location = spawnstruct();
	location.origin = origin;
	owner clientfield::set_player_uimodel("hudItems.tankState", 1);
	owner airsupport::function_83904681(location, &supplydropwatcher);
}

/*
	Name: use_killstreak_death_machine
	Namespace: supplydrop
	Checksum: 0xAE2B87FC
	Offset: 0x2B20
	Size: 0x1E8
	Parameters: 1
	Flags: None
*/
function use_killstreak_death_machine(killstreak)
{
	if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1))
	{
		return 0;
	}
	weapon = getweapon(#"minigun");
	currentweapon = self getcurrentweapon();
	if(currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon, 1);
		return 1;
	}
	level thread popups::displayteammessagetoall(#"hash_3b566d06e5a482e1", self);
	level weapons::add_limited_weapon(weapon, self, 3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon, 1);
	return 1;
}

/*
	Name: use_killstreak_grim_reaper
	Namespace: supplydrop
	Checksum: 0x17776300
	Offset: 0x2D10
	Size: 0x1C8
	Parameters: 1
	Flags: None
*/
function use_killstreak_grim_reaper(killstreak)
{
	if(!self killstreakrules::iskillstreakallowed(killstreak, self.team, 1))
	{
		return 0;
	}
	weapon = getweapon(#"m202_flash");
	currentweapon = self getcurrentweapon();
	if(currentweapon.issupplydropweapon || isdefined(level.grenade_array[currentweapon]) || isdefined(level.inventory_array[currentweapon]))
	{
		self takeweapon(self.lastdroppableweapon);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
		self setblockweaponpickup(weapon, 1);
		return 1;
	}
	level weapons::add_limited_weapon(weapon, self, 3);
	self takeweapon(currentweapon);
	self giveweapon(weapon);
	self switchtoweapon(weapon);
	self setblockweaponpickup(weapon, 1);
	return 1;
}

/*
	Name: cleanupwatcherondeath
	Namespace: supplydrop
	Checksum: 0xA5E0D578
	Offset: 0x2EE0
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function cleanupwatcherondeath(team, killstreak_id)
{
	player = self;
	self endon(#"disconnect", #"supplydropwatcher", #"trigger_weapon_shutdown", #"spawned_player", #"weapon_change");
	self waittill(#"death", #"joined_team", #"joined_spectators");
	killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
	self notify(#"cleanup_marker");
}

/*
	Name: cleanup
	Namespace: supplydrop
	Checksum: 0xDCD3F667
	Offset: 0x2FC8
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function cleanup(context, player)
{
	if(isdefined(context) && isdefined(context.marker))
	{
		context.marker delete();
		context.marker = undefined;
		if(isdefined(context.markerfxhandle))
		{
			context.markerfxhandle delete();
			context.markerfxhandle = undefined;
		}
		if(isdefined(player))
		{
			player clientfield::set_to_player("marker_state", 0);
		}
	}
	if(isdefined(context.killstreak_id))
	{
		deldroplocation(context.killstreak_id);
	}
}

/*
	Name: markerupdatethread
	Namespace: supplydrop
	Checksum: 0xACE021B2
	Offset: 0x30B0
	Size: 0x33E
	Parameters: 1
	Flags: Linked
*/
function markerupdatethread(context)
{
	player = self;
	player endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change", #"death");
	markermodel = spawn("script_model", (0, 0, 0));
	context.marker = markermodel;
	player thread markercleanupthread(context);
	while(true)
	{
		if(player flagsys::get(#"marking_done"))
		{
			break;
		}
		minrange = level.killstreakcorebundle.ksminairdroptargetrange;
		maxrange = level.killstreakcorebundle.ksmaxairdroptargetrange;
		forwardvector = vectorscale(anglestoforward(player getplayerangles()), maxrange);
		mask = 1;
		if(isdefined(context.tracemask))
		{
			mask = context.tracemask;
		}
		radius = 2;
		results = physicstrace(player geteye(), player geteye() + forwardvector, (radius * -1, radius * -1, 0), (radius, radius, 0), player, mask);
		markermodel.origin = results[#"position"];
		tooclose = distancesquared(markermodel.origin, player.origin) < (minrange * minrange);
		if(results[#"normal"][2] > 0.7 && !tooclose && isdefined(context.islocationgood) && [[context.islocationgood]](markermodel.origin, context))
		{
			player.markerposition = markermodel.origin;
			player clientfield::set_to_player("marker_state", 1);
		}
		else
		{
			player.markerposition = undefined;
			player clientfield::set_to_player("marker_state", 2);
		}
		waitframe(1);
	}
}

/*
	Name: function_200081db
	Namespace: supplydrop
	Checksum: 0xE001612
	Offset: 0x33F8
	Size: 0x15C
	Parameters: 3
	Flags: Linked
*/
function function_200081db(owner, context, location)
{
	team = self.team;
	killstreak_id = self killstreakrules::killstreakstart("supply_drop", team, 0, 1);
	if(killstreak_id == -1)
	{
		return 0;
	}
	bundle = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
	killstreak = killstreaks::get_killstreak_for_weapon(bundle.var_1ab696c6);
	context.var_ea9c2360 = location;
	context.killstreak_id = killstreak_id;
	self thread helidelivercrate(context.var_ea9c2360, bundle.var_1ab696c6, self, team, killstreak_id, killstreak_id, context);
	self addweaponstat(bundle.var_1ab696c6, #"used", 1);
}

/*
	Name: function_36573ef
	Namespace: supplydrop
	Checksum: 0xAA20FD25
	Offset: 0x3560
	Size: 0x88
	Parameters: 3
	Flags: None
*/
function function_36573ef(killstreak_id, context, team)
{
	result = self usesupplydropmarker(killstreak_id, context);
	self notify(#"supply_drop_marker_done");
	if(!(isdefined(result) && result))
	{
		return 0;
	}
	self killstreaks::play_killstreak_start_dialog("supply_drop", team, killstreak_id);
	return 1;
}

/*
	Name: supplydropwatcher
	Namespace: supplydrop
	Checksum: 0xD75D5EA0
	Offset: 0x35F0
	Size: 0x49C
	Parameters: 4
	Flags: Linked
*/
function supplydropwatcher(package_contents_id, trigger_event, supplydropweapon, context)
{
	player = self;
	self notify(#"supplydropwatcher");
	self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"weapon_change");
	team = self.team;
	if(isdefined(context.killstreak_id))
	{
		killstreak_id = context.killstreak_id;
	}
	else
	{
		killstreak_id = killstreakrules::killstreakstart("supply_drop", team, 0, 0);
		if(killstreak_id == -1)
		{
			return;
		}
		context.killstreak_id = killstreak_id;
	}
	player flagsys::clear(#"marking_done");
	self thread checkforemp();
	if(trigger_event != "none")
	{
		if(!supplydropweapon.isgrenadeweapon)
		{
			self thread markerupdatethread(context);
		}
		self thread checkweaponchange(team, killstreak_id);
	}
	self thread cleanupwatcherondeath(team, killstreak_id);
	while(true)
	{
		if(trigger_event == "none")
		{
			weapon = supplydropweapon;
			weapon_instance = weapon;
		}
		else
		{
			waitresult = undefined;
			waitresult = self waittill(trigger_event);
			weapon = waitresult.weapon;
			weapon_instance = waitresult.projectile;
		}
		issupplydropweapon = 1;
		if(trigger_event == "grenade_fire")
		{
			issupplydropweapon = weapon.issupplydropweapon;
		}
		if(isdefined(self) && issupplydropweapon)
		{
			if(isdefined(context))
			{
				if(!isdefined(player.markerposition) || (!(isdefined(context.islocationgood) && [[context.islocationgood]](player.markerposition, context))))
				{
					if(isdefined(level.killstreakcorebundle.ksinvalidlocationsound))
					{
						player playsoundtoplayer(level.killstreakcorebundle.ksinvalidlocationsound, player);
					}
					if(isdefined(level.killstreakcorebundle.ksinvalidlocationstring))
					{
						player iprintlnbold(level.killstreakcorebundle.ksinvalidlocationstring);
					}
					continue;
				}
				if(isdefined(context.validlocationsound))
				{
					player playsoundtoplayer(context.validlocationsound, player);
				}
				self thread helidelivercrate(context.var_ea9c2360, weapon, self, team, killstreak_id, package_contents_id, context);
			}
			else
			{
				self thread dosupplydrop(weapon_instance, weapon, self, killstreak_id, package_contents_id);
				weapon_instance thread do_supply_drop_detonation(weapon, self);
				weapon_instance thread supplydropgrenadetimeout(team, killstreak_id, weapon);
			}
			self killstreaks::switch_to_last_non_killstreak_weapon();
		}
		else
		{
			killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
			self notify(#"cleanup_marker");
		}
		break;
	}
	player flagsys::set(#"marking_done");
	player clientfield::set_to_player("marker_state", 0);
}

/*
	Name: checkforemp
	Namespace: supplydrop
	Checksum: 0x551796
	Offset: 0x3A98
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function checkforemp()
{
	self endon(#"supplydropwatcher", #"spawned_player", #"hash_5fa67b447400c1a5", #"weapon_change", #"death", #"trigger_weapon_shutdown");
	self waittill(#"emp_jammed");
	self killstreaks::switch_to_last_non_killstreak_weapon();
}

/*
	Name: supplydropgrenadetimeout
	Namespace: supplydrop
	Checksum: 0x53334153
	Offset: 0x3B30
	Size: 0x1E4
	Parameters: 3
	Flags: Linked
*/
function supplydropgrenadetimeout(team, killstreak_id, weapon)
{
	self endon(#"death", #"stationary");
	grenade_lifetime = 10;
	wait(grenade_lifetime);
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"grenade_timeout");
	killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
	if(weapon.name == #"tank_robot")
	{
		killstreakrules::killstreakstop("tank_robot", team, killstreak_id);
		self notify(#"cleanup_marker");
	}
	else if(weapon.name == #"inventory_tank_robot")
	{
		killstreakrules::killstreakstop("inventory_tank_robot", team, killstreak_id);
		self notify(#"cleanup_marker");
	}
	else if(weapon.name == #"combat_robot_drop")
	{
		killstreakrules::killstreakstop("combat_robot_drop", team, killstreak_id);
		self notify(#"cleanup_marker");
	}
	else if(weapon.name == #"inventory_combat_robot_drop")
	{
		killstreakrules::killstreakstop("inventory_combat_robot_drop", team, killstreak_id);
		self notify(#"cleanup_marker");
	}
	self delete();
}

/*
	Name: checkweaponchange
	Namespace: supplydrop
	Checksum: 0x41D5E21C
	Offset: 0x3D20
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function checkweaponchange(team, killstreak_id)
{
	self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"trigger_weapon_shutdown", #"death");
	self waittill(#"weapon_change");
	killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
	self notify(#"cleanup_marker");
}

/*
	Name: geticonforcrate
	Namespace: supplydrop
	Checksum: 0xF75DC66D
	Offset: 0x3DD8
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function geticonforcrate()
{
	if(isdefined(self.cratetype.objective))
	{
		return self.cratetype.objective;
	}
	if(self.cratetype.type == "killstreak")
	{
		/#
			assert(isdefined(self.cratetype.name));
		#/
		crateweapon = killstreaks::get_killstreak_weapon(self.cratetype.name);
		if(isdefined(crateweapon))
		{
			self.cratetype.objective = getcrateheadobjective(crateweapon);
			return self.cratetype.objective;
		}
	}
	return undefined;
}

/*
	Name: crateactivate
	Namespace: supplydrop
	Checksum: 0xA41855EC
	Offset: 0x3EB8
	Size: 0x5E4
	Parameters: 1
	Flags: Linked
*/
function crateactivate(hacker)
{
	self makeusable();
	self setcursorhint("HINT_NOICON");
	if(!isdefined(self.cratetype))
	{
		return;
	}
	self sethintstring(self.cratetype.hint);
	if(isdefined(self.cratetype.hint_gambler))
	{
		self sethintstringforperk(#"specialty_showenemyequipment", self.cratetype.hint_gambler);
	}
	crateobjid = gameobjects::get_next_obj_id();
	objective_add(crateobjid, "invisible", self.origin);
	objective_setstate(crateobjid, "active");
	self.friendlyobjid = crateobjid;
	self.enemyobjid = [];
	icon = self geticonforcrate();
	if(level.teambased)
	{
		objective_setteam(crateobjid, self.team);
		foreach(team, _ in level.teams)
		{
			if(self.team == team)
			{
				continue;
			}
			crateobjid = gameobjects::get_next_obj_id();
			objective_add(crateobjid, "invisible", self.origin);
			objective_setteam(crateobjid, team);
			objective_setstate(crateobjid, "active");
			self.enemyobjid[self.enemyobjid.size] = crateobjid;
		}
	}
	else if(!self.visibletoall)
	{
		objective_setinvisibletoall(crateobjid);
		enemycrateobjid = gameobjects::get_next_obj_id();
		objective_add(enemycrateobjid, "invisible", self.origin);
		objective_setstate(enemycrateobjid, "active");
		if(isplayer(self.owner))
		{
			objective_setinvisibletoplayer(enemycrateobjid, self.owner);
		}
		self.enemyobjid[self.enemyobjid.size] = enemycrateobjid;
	}
	if(isplayer(self.owner))
	{
		objective_setvisibletoplayer(crateobjid, self.owner);
	}
	if(isdefined(self.hacker))
	{
		objective_setinvisibletoplayer(crateobjid, self.hacker);
		crateobjid = gameobjects::get_next_obj_id();
		objective_add(crateobjid, "invisible", self.origin);
		objective_setstate(crateobjid, "active");
		objective_setinvisibletoall(crateobjid);
		objective_setvisibletoplayer(crateobjid, self.hacker);
		self.hackerobjid = crateobjid;
	}
	if(!self.visibletoall && isdefined(icon))
	{
		self entityheadicons::setentityheadicon(self.team, self, icon);
		if(self.entityheadobjectives.size > 0)
		{
			objectiveid = self.entityheadobjectives[self.entityheadobjectives.size - 1];
			if(isdefined(objectiveid))
			{
				objective_setinvisibletoall(objectiveid);
				if(isdefined(self.owner))
				{
					objective_setvisibletoplayer(objectiveid, self.owner);
				}
			}
		}
	}
	if(isdefined(self.owner) && isplayer(self.owner) && isbot(self.owner))
	{
		self.owner notify(#"bot_crate_landed", {#crate:self}, isdefined(hacker));
	}
	if(isdefined(self.owner))
	{
		self.owner notify(#"crate_landed", {#crate:self});
		setricochetprotectionendtime("supply_drop", self.killstreak_id, self.owner);
	}
}

/*
	Name: setricochetprotectionendtime
	Namespace: supplydrop
	Checksum: 0xCF0658D
	Offset: 0x44A8
	Size: 0xBC
	Parameters: 3
	Flags: Linked
*/
function setricochetprotectionendtime(killstreak, killstreak_id, owner)
{
	ksbundle = level.killstreakbundle[killstreak];
	if(isdefined(ksbundle) && isdefined(ksbundle.ksricochetpostlandduration) && ksbundle.ksricochetpostlandduration > 0)
	{
		endtime = gettime() + (int(ksbundle.ksricochetpostlandduration * 1000));
		killstreaks::set_ricochet_protection_endtime(killstreak_id, owner, endtime);
	}
}

/*
	Name: cratedeactivate
	Namespace: supplydrop
	Checksum: 0xB5B794EB
	Offset: 0x4570
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function cratedeactivate()
{
	self makeunusable();
	if(isdefined(self.friendlyobjid))
	{
		objective_delete(self.friendlyobjid);
		gameobjects::release_obj_id(self.friendlyobjid);
		self.friendlyobjid = undefined;
	}
	if(isdefined(self.enemyobjid))
	{
		foreach(objid in self.enemyobjid)
		{
			objective_delete(objid);
			gameobjects::release_obj_id(objid);
		}
		self.enemyobjid = [];
	}
	if(isdefined(self.hackerobjid))
	{
		objective_delete(self.hackerobjid);
		gameobjects::release_obj_id(self.hackerobjid);
		self.hackerobjid = undefined;
	}
}

/*
	Name: dropalltoground
	Namespace: supplydrop
	Checksum: 0xB0C32A5
	Offset: 0x46D0
	Size: 0xB0
	Parameters: 3
	Flags: Linked
*/
function dropalltoground(origin, radius, stickyobjectradius)
{
	physicsexplosionsphere(origin, radius, radius, 0);
	waitframe(1);
	weapons::drop_all_to_ground(origin, radius);
	dropcratestoground(origin, radius);
	level notify(#"drop_objects_to_ground", {#radius:stickyobjectradius, #position:origin});
}

/*
	Name: dropeverythingtouchingcrate
	Namespace: supplydrop
	Checksum: 0x5DAFFBBA
	Offset: 0x4788
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function dropeverythingtouchingcrate(origin)
{
	dropalltoground(origin, 70, 70);
}

/*
	Name: dropalltogroundaftercratedelete
	Namespace: supplydrop
	Checksum: 0x4E78249B
	Offset: 0x47C0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function dropalltogroundaftercratedelete(crate, crate_origin)
{
	crate waittill(#"death");
	wait(0.1);
	crate dropeverythingtouchingcrate(crate_origin);
}

/*
	Name: dropcratestoground
	Namespace: supplydrop
	Checksum: 0x56C6F214
	Offset: 0x4818
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function dropcratestoground(origin, radius)
{
	crate_ents = getentarray("care_package", "script_noteworthy");
	radius_sq = radius * radius;
	for(i = 0; i < crate_ents.size; i++)
	{
		if(distancesquared(origin, crate_ents[i].origin) < radius_sq)
		{
			crate_ents[i] thread dropcratetoground();
		}
	}
}

/*
	Name: dropcratetoground
	Namespace: supplydrop
	Checksum: 0x19E68D9E
	Offset: 0x48E0
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function dropcratetoground()
{
	self endon(#"death");
	if(isdefined(self.droppingtoground))
	{
		return;
	}
	self.droppingtoground = 1;
	dropeverythingtouchingcrate(self.origin);
	self cratedeactivate();
	self thread cratedroptogroundkill();
	self crateredophysics();
	self crateactivate();
	self.droppingtoground = undefined;
}

/*
	Name: cratespawn
	Namespace: supplydrop
	Checksum: 0xAF02FEE0
	Offset: 0x49A0
	Size: 0x43E
	Parameters: 8
	Flags: Linked
*/
function cratespawn(killstreak, killstreakid, owner, team, drop_origin, drop_angle, _crate, context)
{
	if(isdefined(_crate))
	{
		crate = _crate;
	}
	else
	{
		crate = spawn("script_model", drop_origin, 1);
	}
	crate killstreaks::configure_team(killstreak, killstreakid, owner);
	crate.angles = drop_angle;
	crate.visibletoall = 0;
	crate.script_noteworthy = "care_package";
	crate.weapon = getweapon(#"supplydrop");
	crate setweapon(crate.weapon);
	if(!isdefined(context) || !isdefined(context.vehicle))
	{
		crate clientfield::set("enemyequip", 1);
	}
	if(!isdefined(_crate))
	{
		if(killstreak === "tank_robot" || killstreak === "inventory_tank_robot")
		{
			crate setmodel(level.cratemodeltank);
			crate setenemymodel(level.cratemodeltank);
		}
		else
		{
			crate setmodel(level.cratemodelfriendly);
			crate setenemymodel(level.cratemodelenemy);
		}
	}
	if(isdefined(context) && (!(isdefined(context.dontdisconnectpaths) && context.dontdisconnectpaths)))
	{
		crate disconnectpaths();
	}
	switch(killstreak)
	{
		case "turret_drop":
		{
			crate.cratetype = level.cratetypes[killstreak][#"autoturret"];
			break;
		}
		case "tow_turret_drop":
		{
			crate.cratetype = level.cratetypes[killstreak][#"auto_tow"];
			break;
		}
		case "m220_tow_drop":
		{
			crate.cratetype = level.cratetypes[killstreak][#"m220_tow"];
			break;
		}
		case "tank_robot":
		case "inventory_tank_robot":
		{
			crate.cratetype = level.cratetypes[killstreak][#"tank_robot"];
			break;
		}
		case "inventory_minigun_drop":
		case "minigun_drop":
		{
			crate.cratetype = level.cratetypes[killstreak][#"minigun"];
			break;
		}
		case "m32_drop":
		case "inventory_m32_drop":
		{
			crate.cratetype = level.cratetypes[killstreak][#"m32"];
			break;
		}
		default:
		{
			crate.cratetype = getrandomcratetype("supplydrop");
			break;
		}
	}
	return crate;
}

/*
	Name: cratedelete
	Namespace: supplydrop
	Checksum: 0x3BDD87E5
	Offset: 0x4DE8
	Size: 0x1E4
	Parameters: 1
	Flags: Linked
*/
function cratedelete(drop_all_to_ground)
{
	if(!isdefined(self))
	{
		return;
	}
	killstreaks::remove_ricochet_protection(self.killstreak_id, self.originalowner);
	if(!isdefined(drop_all_to_ground))
	{
		drop_all_to_ground = 1;
	}
	if(isdefined(self.friendlyobjid))
	{
		objective_delete(self.friendlyobjid);
		gameobjects::release_obj_id(self.friendlyobjid);
		self.friendlyobjid = undefined;
	}
	if(isdefined(self.enemyobjid))
	{
		foreach(objid in self.enemyobjid)
		{
			objective_delete(objid);
			gameobjects::release_obj_id(objid);
		}
		self.enemyobjid = undefined;
	}
	if(isdefined(self.hackerobjid))
	{
		objective_delete(self.hackerobjid);
		gameobjects::release_obj_id(self.hackerobjid);
		self.hackerobjid = undefined;
	}
	if(drop_all_to_ground)
	{
		level thread dropalltogroundaftercratedelete(self, self.origin);
	}
	if(isdefined(self.killcament))
	{
		self.killcament thread util::deleteaftertime(5);
	}
	self delete();
}

/*
	Name: stationarycrateoverride
	Namespace: supplydrop
	Checksum: 0x69EDCE4A
	Offset: 0x4FD8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function stationarycrateoverride()
{
	self endon(#"death", #"stationary");
	wait(4);
	self.angles = self.angles;
	self.origin = self.origin;
	self notify(#"stationary");
}

/*
	Name: timeoutcratewaiter
	Namespace: supplydrop
	Checksum: 0x5FE15F39
	Offset: 0x5040
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function timeoutcratewaiter()
{
	self endon(#"death", #"stationary");
	wait(20);
	self cratedelete(1);
}

/*
	Name: cratephysics
	Namespace: supplydrop
	Checksum: 0x993F83C0
	Offset: 0x5090
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function cratephysics()
{
	forcepointvariance = 200;
	vertvelocitymin = -100;
	vertvelocitymax = 100;
	forcepointx = randomfloatrange(0 - forcepointvariance, forcepointvariance);
	forcepointy = randomfloatrange(0 - forcepointvariance, forcepointvariance);
	forcepoint = (forcepointx, forcepointy, 0);
	forcepoint = forcepoint + self.origin;
	initialvelocityz = randomfloatrange(vertvelocitymin, vertvelocitymax);
	initialvelocity = (0, 0, initialvelocityz);
	self physicslaunch(forcepoint, initialvelocity);
	self thread timeoutcratewaiter();
	self thread update_crate_velocity();
	self thread play_impact_sound();
	self waittill(#"stationary");
	self disconnectpaths();
}

/*
	Name: function_1f686c3b
	Namespace: supplydrop
	Checksum: 0x39248AB9
	Offset: 0x5218
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_1f686c3b(v_target_location)
{
	endtime = gettime() + 7000;
	while(endtime > gettime())
	{
		if(self.origin[2] - 20 < v_target_location[2])
		{
			break;
		}
		waitframe(1);
	}
	self notify(#"stationary");
}

/*
	Name: cratecontrolleddrop
	Namespace: supplydrop
	Checksum: 0xFA82CE34
	Offset: 0x5290
	Size: 0x204
	Parameters: 2
	Flags: Linked
*/
function cratecontrolleddrop(killstreak, v_target_location)
{
	crate = self;
	supplydrop = 1;
	if(killstreak == "tank_robot")
	{
		supplydrop = 0;
	}
	if(supplydrop)
	{
		params = level.killstreakbundle[#"supply_drop"];
	}
	else
	{
		params = level.killstreakbundle[#"tank_robot"];
	}
	var_ae4c0bf9 = 0;
	if(!isdefined(params.kstotaldroptime))
	{
		params.kstotaldroptime = 4;
	}
	var_cc6645da = 1;
	acceltime = params.kstotaldroptime * var_cc6645da;
	deceltime = params.kstotaldroptime - acceltime;
	target = (v_target_location[0], v_target_location[1], v_target_location[2] + var_ae4c0bf9);
	hostmigration::waittillhostmigrationdone();
	crate moveto(target, params.kstotaldroptime, acceltime, deceltime);
	crate thread watchforcratekill(v_target_location[2] + (isdefined(params.ksstartcratekillheightfromground) ? params.ksstartcratekillheightfromground : 200));
	crate waittill(#"movedone");
	hostmigration::waittillhostmigrationdone();
	crate cratephysics();
}

/*
	Name: play_impact_sound
	Namespace: supplydrop
	Checksum: 0xC39E69B9
	Offset: 0x54A0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function play_impact_sound()
{
	self playsound(#"phy_impact_supply");
}

/*
	Name: update_crate_velocity
	Namespace: supplydrop
	Checksum: 0x6EB78D19
	Offset: 0x54D0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function update_crate_velocity()
{
	self endon(#"death", #"stationary");
	self.velocity = (0, 0, 0);
	self.old_origin = self.origin;
	while(isdefined(self))
	{
		self.velocity = self.origin - self.old_origin;
		self.old_origin = self.origin;
		waitframe(1);
	}
}

/*
	Name: crateredophysics
	Namespace: supplydrop
	Checksum: 0x3A13FC20
	Offset: 0x5560
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function crateredophysics()
{
	forcepoint = self.origin;
	initialvelocity = (0, 0, 0);
	self physicslaunch(forcepoint, initialvelocity);
	self thread timeoutcratewaiter();
	self thread stationarycrateoverride();
	self waittill(#"stationary");
}

/*
	Name: do_supply_drop_detonation
	Namespace: supplydrop
	Checksum: 0x4D02A824
	Offset: 0x55F8
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function do_supply_drop_detonation(weapon, owner)
{
	self notify(#"supplydropwatcher");
	self endon(#"supplydropwatcher", #"spawned_player", #"disconnect", #"death", #"grenade_timeout");
	self util::waittillnotmoving();
	self.angles = (0, self.angles[1], 90);
	fuse_time = float(weapon.fusetime) / 1000;
	wait(fuse_time);
	if(!isdefined(owner) || !owner emp::enemyempactive())
	{
		thread smokegrenade::playsmokesound(self.origin, 6, level.sound_smoke_start, level.sound_smoke_stop, level.sound_smoke_loop);
		playfxontag(level._supply_drop_smoke_fx, self, "tag_fx");
		proj_explosion_sound = weapon.projexplosionsound;
		sound::play_in_space(proj_explosion_sound, self.origin);
	}
	wait(3);
	self delete();
}

/*
	Name: dosupplydrop
	Namespace: supplydrop
	Checksum: 0xDD62BE34
	Offset: 0x57B0
	Size: 0x10C
	Parameters: 6
	Flags: Linked
*/
function dosupplydrop(weapon_instance, weapon, owner, killstreak_id, package_contents_id, context)
{
	weapon endon(#"explode", #"grenade_timeout");
	self endon(#"disconnect");
	team = owner.team;
	weapon_instance thread watchexplode(weapon, owner, killstreak_id, package_contents_id);
	weapon_instance util::waittillnotmoving();
	weapon_instance notify(#"stoppedmoving");
	self thread helidelivercrate(weapon_instance.origin, weapon, owner, team, killstreak_id, package_contents_id, context);
}

/*
	Name: watchexplode
	Namespace: supplydrop
	Checksum: 0x21A968F0
	Offset: 0x58C8
	Size: 0xA4
	Parameters: 4
	Flags: Linked
*/
function watchexplode(weapon, owner, killstreak_id, package_contents_id)
{
	self endon(#"stoppedmoving");
	team = owner.team;
	waitresult = undefined;
	waitresult = self waittill(#"explode");
	owner thread helidelivercrate(waitresult.position, weapon, owner, team, killstreak_id, package_contents_id);
}

/*
	Name: cratetimeoutthreader
	Namespace: supplydrop
	Checksum: 0x90DFCE62
	Offset: 0x5978
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function cratetimeoutthreader()
{
	crate = self;
	cratetimeout(90);
	crate thread deleteonownerleave();
}

/*
	Name: cratetimeout
	Namespace: supplydrop
	Checksum: 0x16949B4E
	Offset: 0x59C8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function cratetimeout(time)
{
	crate = self;
	self thread killstreaks::waitfortimeout("inventory_supply_drop", int(90 * 1000), &cratedelete, "death");
}

/*
	Name: deleteonownerleave
	Namespace: supplydrop
	Checksum: 0x5D07F3F9
	Offset: 0x5A40
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function deleteonownerleave()
{
	crate = self;
	crate endon(#"death", #"hacked");
	crate.owner waittill(#"joined_team", #"joined_spectators", #"disconnect");
	crate cratedelete(1);
}

/*
	Name: waitanddelete
	Namespace: supplydrop
	Checksum: 0x8E47AAD9
	Offset: 0x5AE0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function waitanddelete(time)
{
	self endon(#"death");
	wait(time);
	self delete();
}

/*
	Name: function_703ed715
	Namespace: supplydrop
	Checksum: 0xFD7E219E
	Offset: 0x5B28
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_703ed715(trace)
{
	if(isdefined(trace[#"entity"]) && isvehicle(trace[#"entity"]) && trace[#"entity"].vehicleclass === "helicopter")
	{
		mask = 1;
		radius = 30;
		origin = trace[#"position"];
		trace = physicstrace(origin + (vectorscale((0, 0, -1), 100)), origin + (vectorscale((0, 0, -1), 10000)), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
		return trace;
	}
	return trace;
}

/*
	Name: dropcrate
	Namespace: supplydrop
	Checksum: 0x44862E7C
	Offset: 0x5C58
	Size: 0x684
	Parameters: 11
	Flags: Linked
*/
function dropcrate(origin, angle, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate_, context, var_83f3c388)
{
	angles = (angle[0] * 0.5, angle[1] * 0.5, angle[2] * 0.5);
	if(isdefined(crate_))
	{
		origin = crate_.origin;
		angles = crate_.angles;
		crate_ thread waitanddelete(0.1);
	}
	if(isdefined(context.var_d6388d1) && context.var_d6388d1)
	{
		context.vehicle = spawnvehicle(#"archetype_mini_quadtank_mp", origin, angles, "talon", undefined, 1, self);
	}
	crate = cratespawn(killstreak, killstreak_id, owner, team, origin, angles);
	killcament unlink();
	killcament linkto(crate);
	crate.killcament = killcament;
	crate.killstreak_id = killstreak_id;
	crate.package_contents_id = package_contents_id;
	killcament thread util::deleteaftertime(15);
	killcament thread unlinkonrotation(crate);
	if(killstreak == "tank_robot" && isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](crate, 0);
	}
	crate endon(#"death");
	if(!(isdefined(context.var_d6388d1) && context.var_d6388d1))
	{
		crate cratetimeoutthreader();
	}
	mask = 1;
	radius = 30;
	trace = physicstrace(crate.origin + (vectorscale((0, 0, -1), 100)), crate.origin + (vectorscale((0, 0, -1), 10000)), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
	trace = function_703ed715(trace);
	v_target_location = trace[#"position"];
	/#
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			util::drawcylinder(v_target_location, context.radius, 8000, 99999999, "", vectorscale((0, 0, 1), 0.9), 0.8);
		}
	#/
	if(isdefined(context.vehicle))
	{
		crate function_1f686c3b(v_target_location);
	}
	else if(!getdvarint(#"hash_763d6ee8f054423f", 0) && isdefined(v_target_location))
	{
		crate cratecontrolleddrop(killstreak, (v_target_location[0], v_target_location[1], v_target_location[2] + 10));
	}
	else if(isdefined(var_83f3c388))
	{
		crate cratecontrolleddrop(killstreak, (var_83f3c388[0], var_83f3c388[1], var_83f3c388[2] + 10));
	}
	else if(isdefined(owner.markerposition))
	{
		crate cratecontrolleddrop(killstreak, (owner.markerposition[0], owner.markerposition[1], owner.markerposition[2] + 10));
	}
	else
	{
		crate cratecontrolleddrop(killstreak, v_target_location);
	}
	crate thread hacker_tool::registerwithhackertool(level.carepackagehackertoolradius, level.carepackagehackertooltimems);
	cleanup(context, owner);
	if(isdefined(crate.cratetype) && isdefined(crate.cratetype.landfunctionoverride))
	{
		[[crate.cratetype.landfunctionoverride]](crate, killstreak, owner, team, context);
	}
	else
	{
		crate crateactivate();
		crate thread crateusethink();
		crate thread crateusethinkowner();
		if(isdefined(crate.cratetype) && isdefined(crate.cratetype.hint_gambler))
		{
			crate thread crategamblerthink();
		}
		default_land_function(crate, killstreak, owner, team);
	}
}

/*
	Name: unlinkonrotation
	Namespace: supplydrop
	Checksum: 0x8D76C020
	Offset: 0x62E8
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function unlinkonrotation(crate)
{
	self endon(#"delete");
	crate endon(#"death", #"stationary");
	waitbeforerotationcheck = getdvarfloat(#"scr_supplydrop_killcam_rot_wait", 0.5);
	wait(waitbeforerotationcheck);
	mincos = getdvarfloat(#"scr_supplydrop_killcam_max_rot", 0.999);
	cosine = 1;
	currentdirection = vectornormalize(anglestoforward(crate.angles));
	while(cosine > mincos)
	{
		olddirection = currentdirection;
		waitframe(1);
		currentdirection = vectornormalize(anglestoforward(crate.angles));
		cosine = vectordot(olddirection, currentdirection);
	}
	if(isdefined(self))
	{
		self unlink();
	}
}

/*
	Name: default_land_function
	Namespace: supplydrop
	Checksum: 0x58A1A268
	Offset: 0x6470
	Size: 0x252
	Parameters: 4
	Flags: Linked
*/
function default_land_function(crate, category, owner, team)
{
	if(1)
	{
		for(;;)
		{
			waitresult = undefined;
			waitresult = crate waittill(#"captured");
			player = waitresult.player;
			remote_hack = waitresult.is_remote_hack;
			owner = crate.owner;
			team = owner.team;
			player challenges::capturedcrate(owner);
			deletecrate = player givecrateitem(crate);
		}
		if(owner != crate.owner)
		{
		}
		if(team != owner.team)
		{
		}
		if(isdefined(deletecrate) && !deletecrate)
		{
		}
		playerhasengineerperk = player hasperk(#"specialty_showenemyequipment");
		if(playerhasengineerperk || remote_hack == 1 && owner != player && (level.teambased && util::function_fbce7263(team, player.team) || !level.teambased))
		{
			spawn_explosive_crate(crate.origin, crate.angles, category, owner, team, player, playerhasengineerperk);
			crate makeunusable();
			util::wait_network_frame();
			crate cratedelete(0);
		}
		else
		{
			crate cratedelete(1);
		}
		return;
	}
}

/*
	Name: spawn_explosive_crate
	Namespace: supplydrop
	Checksum: 0x46D990E7
	Offset: 0x66D0
	Size: 0x1CA
	Parameters: 7
	Flags: Linked
*/
function spawn_explosive_crate(origin, angle, killstreak, owner, team, hacker, playerhasengineerperk)
{
	crate = cratespawn(killstreak, undefined, owner, team, origin, angle);
	crate setowner(owner);
	crate setteam(team);
	if(level.teambased)
	{
		crate setenemymodel(level.cratemodelboobytrapped);
		crate makeusable(team);
	}
	else
	{
		crate setenemymodel(level.cratemodelenemy);
	}
	crate.hacker = hacker;
	crate.visibletoall = 0;
	crate crateactivate(hacker);
	crate sethintstringforperk("specialty_showenemyequipment", level.supplydropdisarmcrate);
	crate thread crateusethink();
	crate thread crateusethinkowner();
	crate thread watch_explosive_crate();
	crate cratetimeoutthreader();
	crate.playerhasengineerperk = playerhasengineerperk;
}

/*
	Name: watch_explosive_crate
	Namespace: supplydrop
	Checksum: 0x7A3160CA
	Offset: 0x68A8
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function watch_explosive_crate()
{
	killcament = spawn("script_model", self.origin + vectorscale((0, 0, 1), 60));
	self.killcament = killcament;
	waitresult = undefined;
	waitresult = self waittill(#"captured", #"death");
	remote_hack = waitresult.is_remote_hack;
	player = waitresult.player;
	if(isdefined(self))
	{
		if(!player hasperk(#"specialty_showenemyequipment") && !remote_hack)
		{
			self thread entityheadicons::setentityheadicon(player.team, player, "headicon_dead");
			self loop_sound("wpn_semtex_alert", 0.15);
			if(isdefined(self))
			{
				if(!isdefined(self.hacker))
				{
					self.hacker = self;
				}
				self radiusdamage(self.origin, 256, 500, 300, self.hacker, "MOD_EXPLOSIVE", getweapon(#"supplydrop"));
				playfx(level._supply_drop_explosion_fx, self.origin);
				playsoundatposition(#"wpn_grenade_explode", self.origin);
			}
		}
		else
		{
			playsoundatposition(#"mpl_turret_alert", self.origin);
			scoreevents::processscoreevent(#"disarm_hacked_care_package", player, undefined, undefined);
			player challenges::disarmedhackedcarepackage();
		}
	}
	wait(0.1);
	if(isdefined(self))
	{
		self cratedelete();
	}
	killcament thread util::deleteaftertime(5);
}

/*
	Name: loop_sound
	Namespace: supplydrop
	Checksum: 0x44FBC7B7
	Offset: 0x6B60
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function loop_sound(alias, interval)
{
	self endon(#"death");
	while(true)
	{
		playsoundatposition(alias, self.origin);
		wait(interval);
		interval = interval / 1.2;
		if(interval < 0.08)
		{
			break;
		}
	}
}

/*
	Name: watchforcratekill
	Namespace: supplydrop
	Checksum: 0xE8DCC6A
	Offset: 0x6BE8
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function watchforcratekill(start_kill_watch_z_threshold)
{
	crate = self;
	crate endon(#"death", #"stationary");
	while(crate.origin[2] > start_kill_watch_z_threshold)
	{
		waitframe(1);
	}
	stationarythreshold = 1;
	killthreshold = 0.2;
	maxframestillstationary = 10;
	numframesstationary = 0;
	while(true)
	{
		vel = 0;
		if(isdefined(self.velocity))
		{
			vel = abs(self.velocity[2]);
		}
		if(vel > killthreshold)
		{
			crate is_touching_crate();
			crate is_clone_touching_crate();
		}
		if(vel < stationarythreshold)
		{
			numframesstationary++;
		}
		else
		{
			numframesstationary = 0;
		}
		if(numframesstationary >= maxframestillstationary)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: cratekill
	Namespace: supplydrop
	Checksum: 0xBC1F15D2
	Offset: 0x6D50
	Size: 0x110
	Parameters: 0
	Flags: None
*/
function cratekill()
{
	self endon(#"death");
	stationarythreshold = 2;
	killthreshold = 15;
	maxframestillstationary = 20;
	numframesstationary = 0;
	while(true)
	{
		vel = 0;
		if(isdefined(self.velocity))
		{
			vel = abs(self.velocity[2]);
		}
		if(vel > killthreshold)
		{
			self is_touching_crate();
			self is_clone_touching_crate();
		}
		if(vel < stationarythreshold)
		{
			numframesstationary++;
		}
		else
		{
			numframesstationary = 0;
		}
		if(numframesstationary >= maxframestillstationary)
		{
			break;
		}
		wait(0.01);
	}
}

/*
	Name: cratedroptogroundkill
	Namespace: supplydrop
	Checksum: 0x388E796A
	Offset: 0x6E68
	Size: 0x41C
	Parameters: 0
	Flags: Linked
*/
function cratedroptogroundkill()
{
	self endon(#"death", #"stationary");
	for(;;)
	{
		players = getplayers();
		dotrace = 0;
		for(i = 0; i < players.size; i++)
		{
			if(players[i].sessionstate != "playing")
			{
				continue;
			}
			if(players[i].team == #"spectator")
			{
				continue;
			}
			self is_equipment_touching_crate(players[i]);
			if(!isalive(players[i]))
			{
				continue;
			}
			flattenedselforigin = (self.origin[0], self.origin[1], 0);
			flattenedplayerorigin = (players[i].origin[0], players[i].origin[1], 0);
			if(distancesquared(flattenedselforigin, flattenedplayerorigin) > 4096)
			{
				continue;
			}
			dotrace = 1;
			break;
		}
		if(dotrace)
		{
			start = self.origin;
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1, 0, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1, 0, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(0, -1, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(0, 1, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1, 1, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1, 1, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(1, -1, 0);
			cratedroptogroundtrace(start);
			start = self getpointinbounds(-1, -1, 0);
			cratedroptogroundtrace(start);
			wait(0.2);
			continue;
		}
		wait(0.5);
	}
}

/*
	Name: cratedroptogroundtrace
	Namespace: supplydrop
	Checksum: 0xBFC261E1
	Offset: 0x7290
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function cratedroptogroundtrace(start)
{
	end = start + (vectorscale((0, 0, -1), 8000));
	trace = bullettrace(start, end, 1, self, 0, 1);
	if(isdefined(trace[#"entity"]) && isplayer(trace[#"entity"]) && isalive(trace[#"entity"]))
	{
		player = trace[#"entity"];
		if(player.sessionstate != "playing")
		{
			return;
		}
		if(player.team == #"spectator")
		{
			return;
		}
		if(distancesquared(start, trace[#"position"]) < 144 || self istouching(player))
		{
			player dodamage(player.health + 1, player.origin, self.owner, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
			player playsound(#"mpl_supply_crush");
			player playsound(#"phy_impact_supply");
		}
	}
}

/*
	Name: is_touching_crate
	Namespace: supplydrop
	Checksum: 0xC6B040DD
	Offset: 0x74C0
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function is_touching_crate()
{
	if(!isdefined(self))
	{
		return;
	}
	crate = self;
	extraboundary = vectorscale((1, 1, 1), 10);
	players = getplayers();
	crate_bottom_point = self.origin;
	foreach(player in level.players)
	{
		if(isdefined(player) && isalive(player))
		{
			stance = player getstance();
			stance_z_offset = (stance == "stand" ? 75 : (stance == "crouch" ? 55 : 15));
			player_test_point = player.origin + (0, 0, stance_z_offset);
			var_f6f95bb5 = distance2dsquared(player_test_point, self.origin);
			var_dee7aebd = self.velocity[2];
			if(var_f6f95bb5 < 2500 && player_test_point[2] > crate_bottom_point[2])
			{
				attacker = (isdefined(self.owner) ? self.owner : self);
				player dodamage(player.health + 1, player.origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
				player playsound(#"mpl_supply_crush");
				player playsound(#"phy_impact_supply");
			}
		}
		self is_equipment_touching_crate(player);
	}
	vehicles = getentarray("script_vehicle", "classname");
	foreach(vehicle in vehicles)
	{
		if(isvehicle(vehicle))
		{
			if(isdefined(vehicle.archetype) && vehicle.archetype == "wasp")
			{
				if(crate istouching(vehicle, vectorscale((1, 1, 1), 2)))
				{
					vehicle notify(#"sentinel_shutdown");
				}
			}
		}
	}
}

/*
	Name: is_clone_touching_crate
	Namespace: supplydrop
	Checksum: 0x5D10AC8D
	Offset: 0x7890
	Size: 0x1EE
	Parameters: 0
	Flags: Linked
*/
function is_clone_touching_crate()
{
	if(!isdefined(self))
	{
		return;
	}
	extraboundary = vectorscale((1, 1, 1), 10);
	actors = getactorarray();
	for(i = 0; i < actors.size; i++)
	{
		if(isdefined(actors[i]) && isdefined(actors[i].isaiclone) && isalive(actors[i]) && actors[i].origin[2] < self.origin[2] && self istouching(actors[i], extraboundary))
		{
			attacker = (isdefined(self.owner) ? self.owner : self);
			actors[i] dodamage(actors[i].health + 1, actors[i].origin, attacker, self, "none", "MOD_HIT_BY_OBJECT", 0, getweapon(#"supplydrop"));
			actors[i] playsound(#"mpl_supply_crush");
			actors[i] playsound(#"phy_impact_supply");
		}
	}
}

/*
	Name: is_equipment_touching_crate
	Namespace: supplydrop
	Checksum: 0xE10EBB8
	Offset: 0x7A88
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function is_equipment_touching_crate(player)
{
	extraboundary = vectorscale((1, 1, 1), 10);
	if(isdefined(player) && isdefined(player.weaponobjectwatcherarray))
	{
		for(watcher = 0; watcher < player.weaponobjectwatcherarray.size; watcher++)
		{
			objectwatcher = player.weaponobjectwatcherarray[watcher];
			objectarray = objectwatcher.objectarray;
			if(isdefined(objectarray))
			{
				for(weaponobject = 0; weaponobject < objectarray.size; weaponobject++)
				{
					if(isdefined(objectarray[weaponobject]) && self istouching(objectarray[weaponobject], extraboundary))
					{
						if(isdefined(objectwatcher.ondetonatecallback))
						{
							objectwatcher thread weaponobjects::waitanddetonate(objectarray[weaponobject], 0);
							continue;
						}
						weaponobjects::removeweaponobject(objectwatcher, objectarray[weaponobject]);
					}
				}
			}
		}
	}
	extraboundary = vectorscale((1, 1, 1), 15);
	if(isdefined(player) && isdefined(player.tacticalinsertion) && self istouching(player.tacticalinsertion, extraboundary))
	{
		player.tacticalinsertion thread tacticalinsertion::fizzle();
	}
}

/*
	Name: spawnuseent
	Namespace: supplydrop
	Checksum: 0x1422F973
	Offset: 0x7C50
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function spawnuseent(player)
{
	useent = spawn("script_origin", self.origin);
	useent.curprogress = 0;
	useent.inuse = 0;
	useent.userate = 0;
	useent.usetime = 0;
	useent.owner = self;
	useent.var_c56ec411 = player;
	useent thread useentownerdeathwaiter(self);
	return useent;
}

/*
	Name: useentownerdeathwaiter
	Namespace: supplydrop
	Checksum: 0xD95AE8F7
	Offset: 0x7CF8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function useentownerdeathwaiter(owner)
{
	self endon(#"death");
	owner waittill(#"death");
	self delete();
}

/*
	Name: crateusethink
	Namespace: supplydrop
	Checksum: 0xB0B99B52
	Offset: 0x7D50
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function crateusethink()
{
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger", #"death");
		player = waitresult.activator;
		if(!isdefined(self))
		{
			break;
		}
		if(!isalive(player))
		{
			continue;
		}
		if(!player isonground())
		{
			continue;
		}
		if(isdefined(self.owner) && self.owner == player)
		{
			continue;
		}
		useent = self spawnuseent(player);
		result = 0;
		if(isdefined(self.hacker))
		{
			useent.hacker = self.hacker;
		}
		self.useent = useent;
		result = useent useholdthink(player, level.cratenonownerusetime);
		if(isdefined(useent))
		{
			useent delete();
		}
		else
		{
			break;
		}
		if(result)
		{
			scoreevents::givecratecapturemedal(self, player);
			self notify(#"captured", {#is_remote_hack:0, #player:player});
		}
	}
}

/*
	Name: crateusethinkowner
	Namespace: supplydrop
	Checksum: 0xF3B963BA
	Offset: 0x7F20
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function crateusethinkowner()
{
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger", #"death");
		if(waitresult._notify == "death")
		{
			return;
		}
		player = waitresult.activator;
		if(!isalive(player))
		{
			continue;
		}
		if(!isdefined(self.owner))
		{
			continue;
		}
		if(self.owner != player)
		{
			continue;
		}
		result = self useholdthink(player, level.crateownerusetime);
		if(!isdefined(self))
		{
			break;
		}
		if(result && isdefined(player))
		{
			self notify(#"captured", {#is_remote_hack:0, #player:player});
		}
	}
}

/*
	Name: useholdthink
	Namespace: supplydrop
	Checksum: 0xE18E5B8D
	Offset: 0x8070
	Size: 0x1D0
	Parameters: 2
	Flags: Linked
*/
function useholdthink(player, usetime)
{
	player notify(#"use_hold");
	player val::set(#"supplydrop", "freezecontrols");
	player val::set(#"supplydrop", "disable_weapons");
	player val::set(#"supplydrop", "disable_offhand_weapons");
	self.curprogress = 0;
	self.inuse = 1;
	self.userate = 0;
	self.usetime = usetime;
	player thread personalusebar(self);
	result = useholdthinkloop(player);
	if(isdefined(player))
	{
		player notify(#"done_using");
		player val::reset(#"supplydrop", "freezecontrols");
		player val::reset(#"supplydrop", "disable_weapons");
		player val::reset(#"supplydrop", "disable_offhand_weapons");
	}
	if(isdefined(self))
	{
		self.inuse = 0;
	}
	if(isdefined(result) && result)
	{
		return 1;
	}
	return 0;
}

/*
	Name: continueholdthinkloop
	Namespace: supplydrop
	Checksum: 0x4D7A359E
	Offset: 0x8248
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function continueholdthinkloop(player)
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(self.curprogress >= self.usetime)
	{
		return 0;
	}
	if(!isalive(player))
	{
		return 0;
	}
	if(player.throwinggrenade)
	{
		return 0;
	}
	if(!player usebuttonpressed())
	{
		return 0;
	}
	if(player meleebuttonpressed())
	{
		return 0;
	}
	if(player isinvehicle())
	{
		return 0;
	}
	if(player isweaponviewonlylinked())
	{
		return 0;
	}
	if(player isremotecontrolling())
	{
		return 0;
	}
	return 1;
}

/*
	Name: useholdthinkloop
	Namespace: supplydrop
	Checksum: 0x4512BFFE
	Offset: 0x8330
	Size: 0x112
	Parameters: 1
	Flags: Linked
*/
function useholdthinkloop(player)
{
	level endon(#"game_ended");
	self endon(#"disabled");
	self.owner endon(#"crate_use_interrupt");
	timedout = 0;
	while(self continueholdthinkloop(player))
	{
		timedout = timedout + 0.05;
		self.curprogress = self.curprogress + (level.var_9fee970c * self.userate);
		self.userate = 1;
		if(self.curprogress >= self.usetime)
		{
			self.inuse = 0;
			waitframe(1);
			return isalive(player);
		}
		waitframe(1);
		hostmigration::waittillhostmigrationdone();
	}
	return 0;
}

/*
	Name: crategamblerthink
	Namespace: supplydrop
	Checksum: 0x7D595695
	Offset: 0x8450
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function crategamblerthink()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger_use_doubletap");
		player = waitresult.player;
		if(!player hasperk(#"specialty_showenemyequipment"))
		{
			continue;
		}
		if(isdefined(self.useent) && self.useent.inuse)
		{
			if(isdefined(self.owner) && self.owner != player && (isdefined(self.useent.var_c56ec411) && self.useent.var_c56ec411 != player))
			{
				continue;
			}
		}
		player playlocalsound(#"uin_gamble_perk");
		self.cratetype = getrandomcratetype("gambler", self.cratetype.name);
		self cratereactivate();
		self sethintstringforperk("specialty_showenemyequipment", self.cratetype.hint);
		self notify(#"crate_use_interrupt");
		level notify(#"use_interrupt", {#target:self});
		return;
	}
}

/*
	Name: cratereactivate
	Namespace: supplydrop
	Checksum: 0x7FB162FC
	Offset: 0x8620
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function cratereactivate()
{
	self sethintstring(self.cratetype.hint);
	icon = self geticonforcrate();
	self thread entityheadicons::setentityheadicon(self.team, self, icon);
}

/*
	Name: personalusebar
	Namespace: supplydrop
	Checksum: 0x624D3897
	Offset: 0x8698
	Size: 0x404
	Parameters: 1
	Flags: Linked
*/
function personalusebar(object)
{
	self endon(#"disconnect");
	capturecratestate = 0;
	if(self hasperk(#"specialty_showenemyequipment") && object.owner != self && !isdefined(object.hacker) && (level.teambased && util::function_fbce7263(object.owner.team, self.team) || !level.teambased))
	{
		capturecratestate = 2;
		self playlocalsound(#"evt_hacker_hacking");
	}
	else if(self hasperk(#"specialty_showenemyequipment") && isdefined(object.hacker) && (object.owner == self || (level.teambased && object.owner.team == self.team)))
	{
		capturecratestate = 3;
		self playlocalsound(#"evt_hacker_hacking");
	}
	else
	{
		capturecratestate = 1;
		self.is_capturing_own_supply_drop = object.owner === self && (!isdefined(object.originalowner) || object.originalowner == self);
	}
	lastrate = -1;
	while(isalive(self) && isdefined(object) && object.inuse && !level.gameended)
	{
		if(lastrate != object.userate)
		{
			if(object.curprogress > object.usetime)
			{
				object.curprogress = object.usetime;
			}
			if(!object.userate)
			{
				self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
				self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
			}
			else
			{
				barfrac = object.curprogress / object.usetime;
				rateofchange = object.userate / object.usetime;
				capturecratetotaltime = 0;
				if(rateofchange > 0)
				{
					capturecratetotaltime = (1 - barfrac) / rateofchange;
				}
				self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", int(capturecratetotaltime));
				self clientfield::set_player_uimodel("hudItems.captureCrateState", capturecratestate);
			}
		}
		lastrate = object.userate;
		waitframe(1);
	}
	self.is_capturing_own_supply_drop = 0;
	self clientfield::set_player_uimodel("hudItems.captureCrateTotalTime", 0);
	self clientfield::set_player_uimodel("hudItems.captureCrateState", 0);
}

/*
	Name: spawn_helicopter
	Namespace: supplydrop
	Checksum: 0x5526C82B
	Offset: 0x8AA8
	Size: 0x430
	Parameters: 8
	Flags: Linked
*/
function spawn_helicopter(owner, team, origin, angles, var_87735872, targetname, killstreak_id, context)
{
	chopper = spawnvehicle(var_87735872, origin, angles, targetname);
	chopper setowner(owner);
	if(!isdefined(chopper))
	{
		if(isplayer(owner))
		{
			killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
			self iprintlnbold(#"hash_7a1ca44da026f58c");
			self notify(#"cleanup_marker");
		}
		return undefined;
	}
	chopper.destroyfunc = &destroyhelicopter;
	chopper.script_nocorpse = 1;
	chopper killstreaks::configure_team("supply_drop", killstreak_id, owner);
	chopper.maxhealth = level.heli_maxhealth;
	chopper.rocketdamageoneshot = chopper.maxhealth + 1;
	chopper.damagetaken = 0;
	chopper.targetname = "chopper";
	hardpointtypefordamage = "supply_drop";
	if(context.killstreakref === "inventory_tank_robot" || context.killstreakref === "tank_robot")
	{
		hardpointtypefordamage = "supply_drop_ai_tank";
	}
	else if(context.killstreakref === "inventory_combat_robot" || context.killstreakref === "combat_robot")
	{
		hardpointtypefordamage = "supply_drop_combat_robot";
	}
	chopper thread helicopter::heli_damage_monitor(hardpointtypefordamage);
	chopper thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
	chopper.spawntime = gettime();
	chopper clientfield::set("enemyvehicle", 1);
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](chopper, 0);
	}
	/#
		chopper util::debug_slow_heli_speed();
	#/
	maxpitch = getdvarint(#"scr_supplydropmaxpitch", 25);
	maxroll = getdvarint(#"scr_supplydropmaxroll", 45);
	chopper setmaxpitchroll(0, maxroll);
	chopper setdrawinfrared(1);
	chopper setneargoalnotifydist(40);
	target_set(chopper, vectorscale((0, 0, -1), 25));
	if(isplayer(owner))
	{
		chopper thread refcountdecchopper(team, killstreak_id);
	}
	chopper thread helidestroyed();
	chopper setrotorspeed(1);
	return chopper;
}

/*
	Name: destroyhelicopter
	Namespace: supplydrop
	Checksum: 0x9DA7A13E
	Offset: 0x8EE0
	Size: 0x1B4
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
	self notify(#"hash_525537be2de4c159", {#owner:self.owner, #direction:self.angles, #position:self.origin});
	lbexplode();
}

/*
	Name: getdropheight
	Namespace: supplydrop
	Checksum: 0xB7364A5
	Offset: 0x90A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function getdropheight(origin)
{
	return airsupport::getminimumflyheight();
}

/*
	Name: getdropdirection
	Namespace: supplydrop
	Checksum: 0x27177885
	Offset: 0x90C8
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function getdropdirection()
{
	return (0, randomint(360), 0);
}

/*
	Name: getnextdropdirection
	Namespace: supplydrop
	Checksum: 0x148CF9BA
	Offset: 0x90F0
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function getnextdropdirection(drop_direction, degrees)
{
	drop_direction = (0, drop_direction[1] + degrees, 0);
	if(drop_direction[1] >= 360)
	{
		drop_direction = (0, drop_direction[1] - 360, 0);
	}
	return drop_direction;
}

/*
	Name: gethelistart
	Namespace: supplydrop
	Checksum: 0x608384A3
	Offset: 0x9158
	Size: 0x1FE
	Parameters: 2
	Flags: Linked
*/
function gethelistart(drop_origin, drop_direction)
{
	dist = -1 * getdvarint(#"scr_supplydropincomingdistance", 15000);
	pathrandomness = 100;
	direction = drop_direction + (0, randomintrange(-2, 3), 0);
	start_origin = drop_origin + (anglestoforward(direction) * dist);
	start_origin = start_origin + ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
	/#
		if(getdvarint(#"scr_noflyzones_debug", 0))
		{
			if(level.noflyzones.size)
			{
				index = randomintrange(0, level.noflyzones.size);
				delta = drop_origin - level.noflyzones[index].origin;
				delta = (delta[0] + randomint(10), delta[1] + randomint(10), 0);
				delta = vectornormalize(delta);
				start_origin = drop_origin + (delta * dist);
			}
		}
	#/
	return start_origin;
}

/*
	Name: getheliend
	Namespace: supplydrop
	Checksum: 0xDF98A011
	Offset: 0x9360
	Size: 0x162
	Parameters: 2
	Flags: Linked
*/
function getheliend(drop_origin, drop_direction)
{
	pathrandomness = 150;
	dist = -1 * getdvarint(#"scr_supplydropoutgoingdistance", 15000);
	if(randomintrange(0, 2) == 0)
	{
		turn = randomintrange(60, 121);
	}
	else
	{
		turn = -1 * randomintrange(60, 121);
	}
	direction = drop_direction + (0, turn, 0);
	end_origin = drop_origin + (anglestoforward(direction) * dist);
	end_origin = end_origin + ((randomfloat(2) - 1) * pathrandomness, (randomfloat(2) - 1) * pathrandomness, 0);
	return end_origin;
}

/*
	Name: addoffsetontopoint
	Namespace: supplydrop
	Checksum: 0x33B78B68
	Offset: 0x94D0
	Size: 0x78
	Parameters: 3
	Flags: Linked
*/
function addoffsetontopoint(point, direction, offset)
{
	angles = vectortoangles((direction[0], direction[1], 0));
	offset_world = rotatepoint(offset, angles);
	return point + offset_world;
}

/*
	Name: supplydrophelistartpath_v2_setup
	Namespace: supplydrop
	Checksum: 0xFF5D15AE
	Offset: 0x9550
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function supplydrophelistartpath_v2_setup(goal, goal_offset, var_aea79ccc)
{
	goalpath = spawnstruct();
	goalpath.start = helicopter::getvalidrandomstartnode(goal, var_aea79ccc).origin;
	return goalpath;
}

/*
	Name: supplydrophelistartpath_v2_part2_local
	Namespace: supplydrop
	Checksum: 0x3AD477F1
	Offset: 0x95C0
	Size: 0x72
	Parameters: 3
	Flags: Linked
*/
function supplydrophelistartpath_v2_part2_local(goal, goalpath, goal_local_offset)
{
	direction = goal - goalpath.start;
	goalpath.path = [];
	goalpath.path[0] = addoffsetontopoint(goal, direction, goal_local_offset);
}

/*
	Name: supplydrophelistartpath_v2_part2
	Namespace: supplydrop
	Checksum: 0xC1143EC7
	Offset: 0x9640
	Size: 0x46
	Parameters: 3
	Flags: Linked
*/
function supplydrophelistartpath_v2_part2(goal, goalpath, goal_world_offset)
{
	goalpath.path = [];
	goalpath.path[0] = goal + goal_world_offset;
}

/*
	Name: supplydrophelistartpath
	Namespace: supplydrop
	Checksum: 0xDA8D60F4
	Offset: 0x9690
	Size: 0x306
	Parameters: 2
	Flags: None
*/
function supplydrophelistartpath(goal, goal_offset)
{
	total_tries = 12;
	tries = 0;
	goalpath = spawnstruct();
	drop_direction = getdropdirection();
	while(tries < total_tries)
	{
		goalpath.start = gethelistart(goal, drop_direction);
		goalpath.path = airsupport::gethelipath(goalpath.start, goal);
		startnoflyzones = airsupport::insidenoflyzones(goalpath.start, 0);
		if(isdefined(goalpath.path) && startnoflyzones.size == 0)
		{
			if(goalpath.path.size > 1)
			{
				direction = (goalpath.path[goalpath.path.size - 1]) - (goalpath.path[goalpath.path.size - 2]);
			}
			else
			{
				direction = (goalpath.path[goalpath.path.size - 1]) - goalpath.start;
			}
			goalpath.path[goalpath.path.size - 1] = addoffsetontopoint(goalpath.path[goalpath.path.size - 1], direction, goal_offset);
			/#
				sphere(goalpath.path[goalpath.path.size - 1], 10, (0, 0, 1), 1, 1, 10, 1000);
			#/
			return goalpath;
		}
		drop_direction = getnextdropdirection(drop_direction, 30);
		tries++;
	}
	drop_direction = getdropdirection();
	goalpath.start = gethelistart(goal, drop_direction);
	direction = goal - goalpath.start;
	goalpath.path = [];
	goalpath.path[0] = addoffsetontopoint(goal, direction, goal_offset);
	return goalpath;
}

/*
	Name: supplydropheliendpath_v2
	Namespace: supplydrop
	Checksum: 0xD3FE07D4
	Offset: 0x99A0
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function supplydropheliendpath_v2(start, var_aea79ccc)
{
	goalpath = spawnstruct();
	goalpath.start = start;
	goal = helicopter::getvalidrandomleavenode(start, var_aea79ccc).origin;
	goalpath.path = [];
	goalpath.path[0] = goal;
	return goalpath;
}

/*
	Name: supplydropheliendpath
	Namespace: supplydrop
	Checksum: 0x7EB86020
	Offset: 0x9A38
	Size: 0x1BE
	Parameters: 2
	Flags: None
*/
function supplydropheliendpath(origin, drop_direction)
{
	total_tries = 5;
	tries = 0;
	goalpath = spawnstruct();
	while(tries < total_tries)
	{
		goal = getheliend(origin, drop_direction);
		goalpath.path = airsupport::gethelipath(origin, goal);
		if(isdefined(goalpath.path))
		{
			return goalpath;
		}
		tries++;
	}
	leave_nodes = getentarray("heli_leave", "targetname");
	foreach(node in leave_nodes)
	{
		goalpath.path = airsupport::gethelipath(origin, node.origin);
		if(isdefined(goalpath.path))
		{
			return goalpath;
		}
	}
	goalpath.path = [];
	goalpath.path[0] = getheliend(origin, drop_direction);
	return goalpath;
}

/*
	Name: inccratekillstreakusagestat
	Namespace: supplydrop
	Checksum: 0xE186B460
	Offset: 0x9C00
	Size: 0x352
	Parameters: 2
	Flags: Linked
*/
function inccratekillstreakusagestat(weapon, killstreak_id)
{
	if(weapon == level.weaponnone)
	{
		return;
	}
	switch(weapon.name)
	{
		case "turret_drop":
		{
			self killstreaks::play_killstreak_start_dialog("turret_drop", self.pers[#"team"], killstreak_id);
			break;
		}
		case "tow_turret_drop":
		{
			self killstreaks::play_killstreak_start_dialog("tow_turret_drop", self.pers[#"team"], killstreak_id);
			break;
		}
		case "supplydrop_marker":
		case "inventory_supplydrop_marker":
		{
			self killstreaks::play_killstreak_start_dialog("supply_drop", self.pers[#"team"], killstreak_id);
			level thread popups::displaykillstreakteammessagetoall("supply_drop", self);
			self challenges::calledincarepackage();
			self stats::function_e24eec31(getweapon(#"supplydrop"), #"used", 1);
			break;
		}
		case "tank_robot":
		case "inventory_tank_robot":
		{
			self killstreaks::play_killstreak_start_dialog("tank_robot", self.pers[#"team"], killstreak_id);
			level thread popups::displaykillstreakteammessagetoall("tank_robot", self);
			self stats::function_e24eec31(getweapon(#"tank_robot"), #"used", 1);
			break;
		}
		case "inventory_minigun_drop":
		case "minigun_drop":
		{
			self killstreaks::play_killstreak_start_dialog("minigun", self.pers[#"team"], killstreak_id);
			break;
		}
		case "m32_drop":
		case "inventory_m32_drop":
		{
			self killstreaks::play_killstreak_start_dialog("m32", self.pers[#"team"], killstreak_id);
			break;
		}
		case "combat_robot_drop":
		{
			level thread popups::displaykillstreakteammessagetoall("combat_robot", self);
			break;
		}
	}
}

/*
	Name: markercleanupthread
	Namespace: supplydrop
	Checksum: 0x4E7212BF
	Offset: 0x9F60
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function markercleanupthread(context)
{
	player = self;
	player waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators", #"cleanup_marker");
	cleanup(context, player);
}

/*
	Name: getchopperdroppoint
	Namespace: supplydrop
	Checksum: 0xF1C4AE88
	Offset: 0x9FF8
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function getchopperdroppoint(context)
{
	chopper = self;
	return (isdefined(context.droptag) ? chopper gettagorigin(context.droptag) + rotatepoint((isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0)), chopper.angles) : chopper.origin);
}

/*
	Name: function_7d90f954
	Namespace: supplydrop
	Checksum: 0xCA1F713B
	Offset: 0xA0A0
	Size: 0xAE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_7d90f954(drop_origin, context)
{
	if(ispointonnavmesh(drop_origin, context.dist_from_boundary))
	{
		/#
			recordsphere(drop_origin + vectorscale((0, 0, 1), 10), 2, (0, 1, 0), "");
		#/
		return 1;
	}
	/#
		recordsphere(drop_origin + vectorscale((0, 0, 1), 10), 2, (1, 0, 0), "");
	#/
	return 0;
}

/*
	Name: function_75277c27
	Namespace: supplydrop
	Checksum: 0x60920EDF
	Offset: 0xA158
	Size: 0xA6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_75277c27(tacpoint, context)
{
	if(isdefined(tacpoint.var_eadc2c7d) && tacpoint.var_eadc2c7d >= 4000)
	{
		/#
			recordsphere(tacpoint.origin, 2, (0, 1, 0), "");
		#/
		return 1;
	}
	/#
		recordsphere(tacpoint.origin, 2, (1, 0, 0), "");
	#/
	return 0;
}

/*
	Name: function_9153c267
	Namespace: supplydrop
	Checksum: 0x9AD37F10
	Offset: 0xA208
	Size: 0x11C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_9153c267(drop_origin, context, drop_height)
{
	if(isdefined(level.var_e071ed64) && level.var_e071ed64)
	{
		heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
		var_baa92af9 = ispointinnavvolume(heli_drop_goal, "navvolume_big");
		if(var_baa92af9)
		{
			/#
				recordsphere(drop_origin + vectorscale((0, 0, 1), 20), 2, (0, 1, 0), "");
			#/
			return 1;
		}
		/#
			recordsphere(drop_origin + vectorscale((0, 0, 1), 20), 2, (1, 0, 0), "");
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_accec5c5
	Namespace: supplydrop
	Checksum: 0xCA7C7908
	Offset: 0xA330
	Size: 0x168
	Parameters: 3
	Flags: Linked, Private
*/
private function function_accec5c5(drop_origin, context, drop_height)
{
	mask = 1;
	radius = 30;
	heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
	trace = physicstrace(heli_drop_goal, drop_origin + vectorscale((0, 0, 1), 10), (radius * -1, radius * -1, 0), (radius, radius, 2 * radius), undefined, mask);
	if(trace[#"fraction"] < 1)
	{
		/#
			recordsphere(drop_origin + vectorscale((0, 0, 1), 20), 2, (1, 0, 0), "");
		#/
		return 0;
	}
	/#
		recordsphere(drop_origin + vectorscale((0, 0, 1), 20), 2, (0, 1, 0), "");
	#/
	return 1;
}

/*
	Name: function_fc826e6
	Namespace: supplydrop
	Checksum: 0x3BD73518
	Offset: 0xA4A0
	Size: 0x130
	Parameters: 3
	Flags: Linked, Private
*/
private function function_fc826e6(tacpoints, context, drop_height)
{
	/#
		assert(isdefined(tacpoints) && tacpoints.size);
	#/
	filteredpoints = [];
	foreach(tacpoint in tacpoints)
	{
		if(function_75277c27(tacpoint, context) && function_7d90f954(tacpoint.origin, context) && function_9153c267(tacpoint.origin, context, drop_height))
		{
			filteredpoints[filteredpoints.size] = tacpoint.origin;
		}
	}
	return filteredpoints;
}

/*
	Name: function_6dc6bc6b
	Namespace: supplydrop
	Checksum: 0xEB638856
	Offset: 0xA5D8
	Size: 0xF2
	Parameters: 3
	Flags: Linked
*/
function function_6dc6bc6b(origins, context, drop_height)
{
	/#
		assert(isdefined(origins) && origins.size);
	#/
	filteredpoints = [];
	foreach(origin in origins)
	{
		if(function_accec5c5(origin, context, drop_height))
		{
			filteredpoints[filteredpoints.size] = origin;
			break;
		}
		waitframe(1);
	}
	return filteredpoints;
}

/*
	Name: function_263d3e9e
	Namespace: supplydrop
	Checksum: 0x3C1BB667
	Offset: 0xA6D8
	Size: 0x2D6
	Parameters: 3
	Flags: Linked
*/
function function_263d3e9e(drop_origin, drop_height, context)
{
	if(getdvarint(#"hash_458cd0a10d30cedb", 1))
	{
		if(function_7d90f954(drop_origin, context) && function_9153c267(drop_origin, context, drop_height))
		{
			if(function_accec5c5(drop_origin, context, drop_height))
			{
				return drop_origin;
			}
		}
		cylinder = ai::t_cylinder(drop_origin, 1000, 30);
		var_629f4ae1 = tacticalquery("supply_drop_deploy", drop_origin, cylinder);
		waitframe(1);
		cylinder = ai::t_cylinder(drop_origin, 2000, 30);
		var_3b8d7cbe = tacticalquery("supply_drop_deploy", drop_origin, cylinder);
		if(isdefined(var_3b8d7cbe) && var_3b8d7cbe.size)
		{
			tacpoints = arraycombine(var_629f4ae1, var_3b8d7cbe, 0, 0);
		}
		if(isdefined(tacpoints) && tacpoints.size)
		{
			tacpoints = function_fc826e6(tacpoints, context, drop_height);
			waitframe(1);
			if(tacpoints.size)
			{
				tacpoints = arraysortclosest(tacpoints, drop_origin);
				filteredpoints = function_6dc6bc6b(tacpoints, context, drop_height);
				if(isdefined(filteredpoints[0]))
				{
					/#
						recordsphere(filteredpoints[0] + vectorscale((0, 0, 1), 70), 4, (1, 0.5, 0), "");
					#/
					return filteredpoints[0];
				}
				var_c71b63fa = arraygetclosest(drop_origin, tacpoints);
				/#
					recordsphere(var_c71b63fa + vectorscale((0, 0, 1), 70), 4, (0, 1, 1), "");
				#/
				return var_c71b63fa;
			}
		}
	}
	return drop_origin;
}

/*
	Name: function_fe13a227
	Namespace: supplydrop
	Checksum: 0xB0CF5820
	Offset: 0xA9B8
	Size: 0x156
	Parameters: 4
	Flags: Linked
*/
function function_fe13a227(chopper, heli_drop_goal, drop_height, original_drop_origin)
{
	chopper endon(#"death", #"drop_goal");
	if(getdvarint(#"hash_458cd0a10d30cedb", 1))
	{
		drop_origin = (heli_drop_goal[0], heli_drop_goal[1], heli_drop_goal[2] - drop_height);
		while(true)
		{
			/#
				recordsphere(original_drop_origin, 4, (1, 0, 0), "");
				recordsphere(drop_origin, 4, (1, 0.5, 0), "");
				recordsphere(heli_drop_goal, 4, (0, 0, 1), "");
				recordline(drop_origin, heli_drop_goal, (0, 0, 1), "");
			#/
			waitframe(1);
		}
	}
}

/*
	Name: helidelivercrate
	Namespace: supplydrop
	Checksum: 0x74EA013C
	Offset: 0xAB18
	Size: 0x13DC
	Parameters: 7
	Flags: Linked
*/
function helidelivercrate(origin, weapon, owner, team, killstreak_id, package_contents_id, context)
{
	if(owner emp::enemyempactive() && !owner hasperk(#"specialty_immuneemp"))
	{
		killstreakrules::killstreakstop(context.killstreakref, team, killstreak_id);
		self notify(#"cleanup_marker");
		return;
	}
	/#
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			level notify(#"stop_heli_drop_valid_location_marked_cylinder");
			level notify(#"stop_heli_drop_valid_location_arrived_at_goal_cylinder");
			level notify(#"stop_heli_drop_valid_location_dropped_cylinder");
			util::drawcylinder(origin, context.radius, 8000, 99999999, "", vectorscale((1, 0, 1), 0.4), 0.8);
		}
	#/
	origin = self.markerposition;
	if(isdefined(context.marker))
	{
		origin = context.marker.origin;
	}
	if(!isdefined(context.var_9fc6cfe9) || !context.var_9fc6cfe9)
	{
		context.markerfxhandle = spawnfx(level.killstreakcorebundle.fxmarkedlocation, origin + vectorscale((0, 0, 1), 5), (0, 0, 1), (1, 0, 0));
		context.markerfxhandle.team = owner.team;
		triggerfx(context.markerfxhandle);
	}
	bundle = struct::get_script_bundle("killstreak", "killstreak_supply_drop");
	ricochetdistance = (isdefined(bundle) ? bundle.ksricochetdistance : undefined);
	killstreaks::add_ricochet_protection(killstreak_id, owner, origin, ricochetdistance);
	if(isdefined(context.marker))
	{
		context.marker.team = owner.team;
		context.marker entityheadicons::destroyentityheadicons();
		context.marker entityheadicons::setentityheadicon(owner.pers[#"team"], owner, context.objective);
	}
	if(isdefined(weapon))
	{
		inccratekillstreakusagestat(weapon, killstreak_id);
	}
	rear_hatch_offset_local = getdvarint(#"scr_supplydropoffset", 0);
	drop_origin = origin;
	if(getdvarint(#"hash_458cd0a10d30cedb", 1))
	{
		drop_height = 1600;
	}
	else
	{
		drop_height = getdropheight(drop_origin);
	}
	drop_height = drop_height + (level.zoffsetcounter * 350);
	level.zoffsetcounter++;
	if(level.zoffsetcounter >= 5)
	{
		level.zoffsetcounter = 0;
	}
	original_drop_origin = drop_origin;
	if(!getdvarint(#"hash_7ccc40e85206e0a5", 1))
	{
		drop_origin = function_263d3e9e(drop_origin, drop_height, context);
	}
	else if(!function_9153c267(drop_origin, context, drop_height))
	{
		drop_origin = function_263d3e9e(drop_origin, drop_height, context);
	}
	adddroplocation(killstreak_id, drop_origin);
	if(getdvarint(#"hash_458cd0a10d30cedb", 1))
	{
		if(!isvec(drop_origin))
		{
			drop_origin = original_drop_origin;
		}
		heli_drop_goal = (drop_origin[0], drop_origin[1], drop_origin[2] + drop_height);
	}
	else
	{
		heli_drop_goal = (drop_origin[0], drop_origin[1], drop_height);
	}
	goalpath = undefined;
	if(level.var_e071ed64)
	{
		if(isdefined(context.dropoffset))
		{
			goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 0);
			supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
		}
		else
		{
			goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 0);
			goal_path_setup_needs_finishing = 1;
		}
	}
	else if(isdefined(context.dropoffset))
	{
		goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, context.dropoffset, 1);
		supplydrophelistartpath_v2_part2_local(heli_drop_goal, goalpath, context.dropoffset);
	}
	else
	{
		goalpath = supplydrophelistartpath_v2_setup(heli_drop_goal, (rear_hatch_offset_local, 0, 0), 1);
		goal_path_setup_needs_finishing = 1;
	}
	spawn_angles = vectortoangles((heli_drop_goal[0], heli_drop_goal[1], 0) - (goalpath.start[0], goalpath.start[1], 0));
	if(isdefined(context.vehiclename))
	{
		helicoptervehicleinfo = context.vehiclename;
	}
	else
	{
		helicoptervehicleinfo = level.vtoldrophelicoptervehicleinfo;
	}
	chopper = spawn_helicopter(owner, team, goalpath.start, spawn_angles, helicoptervehicleinfo, "", killstreak_id, context);
	chopper thread function_fe13a227(chopper, heli_drop_goal, drop_height, original_drop_origin);
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](chopper, 0);
	}
	if(level.var_e071ed64)
	{
		chopper makesentient();
		chopper makepathfinder();
		chopper.ignoreme = 1;
		chopper.ignoreall = 1;
		chopper setneargoalnotifydist(40);
		chopper.goalradius = 40;
		if(goal_path_setup_needs_finishing === 1)
		{
			goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
			supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
			goal_path_setup_needs_finishing = 0;
		}
	}
	else if(goal_path_setup_needs_finishing === 1)
	{
		goal_world_offset = chopper.origin - chopper getchopperdroppoint(context);
		supplydrophelistartpath_v2_part2(heli_drop_goal, goalpath, goal_world_offset);
		goal_path_setup_needs_finishing = 0;
	}
	waitforonlyonedroplocation = 0;
	while(level.droplocations.size > 1 && waitforonlyonedroplocation)
	{
		arrayremovevalue(level.droplocations, undefined);
		wait_for_drop = 0;
		foreach(id, droplocation in level.droplocations)
		{
			if(id < killstreak_id)
			{
				wait_for_drop = 1;
				break;
			}
		}
		if(wait_for_drop)
		{
			wait(0.5);
		}
		else
		{
			break;
		}
	}
	chopper.killstreakweaponname = weapon.name;
	if(isdefined(context) && isdefined(context.hasflares))
	{
		chopper.numflares = 3;
		chopper.flareoffset = (0, 0, 0);
		chopper thread helicopter::create_flare_ent(vectorscale((0, 0, -1), 50));
	}
	else
	{
		chopper.numflares = 0;
	}
	killcament = spawn("script_model", chopper.origin + vectorscale((0, 0, 1), 800));
	killcament.angles = (100, chopper.angles[1], chopper.angles[2]);
	killcament.starttime = gettime();
	killcament linkto(chopper);
	if(!isdefined(chopper))
	{
		return;
	}
	if(isdefined(context) && isdefined(context.prolog))
	{
		chopper [[context.prolog]](context);
	}
	else if(isdefined(level.killstreakweapons[weapon]))
	{
		if(getdvarint(#"hash_458cd0a10d30cedb", 1))
		{
			chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context, drop_origin);
		}
		else
		{
			chopper thread helidropcrate(level.killstreakweapons[weapon], owner, rear_hatch_offset_local, killcament, killstreak_id, package_contents_id, context);
		}
	}
	chopper endon(#"death");
	if(level.var_e071ed64)
	{
		chopper.var_f766e12d = 15;
		chopper thread airsupport::function_f1b7b432(goalpath.path, "drop_goal", 1, 1, 1);
	}
	else
	{
		chopper thread airsupport::followpath(goalpath.path, "drop_goal", 1);
	}
	chopper thread speedregulator(heli_drop_goal);
	target_set(chopper, vectorscale((0, 0, 1), 50));
	chopper waittill(#"drop_goal");
	chopper.var_f766e12d = undefined;
	chopper thread function_e16ff9df(15);
	if(isdefined(owner))
	{
		owner notify(#"hash_6736343f5a9c98f2");
	}
	if(isdefined(context) && isdefined(context.epilog))
	{
		chopper [[context.epilog]](context);
	}
	/#
		println("" + (gettime() - chopper.spawntime));
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			if(isdefined(context.dropoffset))
			{
				chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
			}
			else
			{
				chopper_drop_point = chopper getchopperdroppoint(context);
			}
			trace = groundtrace(chopper_drop_point + (vectorscale((0, 0, -1), 100)), chopper_drop_point + (vectorscale((0, 0, -1), 10000)), 0, undefined, 0);
			debug_drop_location = trace[#"position"];
			util::drawcylinder(debug_drop_location, context.radius, 8000, 99999999, "", (1, 0.6, 0), 0.9);
			iprintln("" + distance2d(chopper_drop_point, heli_drop_goal));
		}
	#/
	on_target = 0;
	last_distance_from_goal_squared = 9999999 * 9999999;
	continue_waiting = 1;
	for(remaining_tries = 30; continue_waiting && remaining_tries > 0; remaining_tries--)
	{
		if(isdefined(context.dropoffset))
		{
			chopper_drop_point = chopper.origin - rotatepoint(context.dropoffset, chopper.angles);
		}
		else
		{
			chopper_drop_point = chopper getchopperdroppoint(context);
		}
		current_distance_from_goal_squared = distance2dsquared(chopper_drop_point, heli_drop_goal);
		continue_waiting = current_distance_from_goal_squared < last_distance_from_goal_squared && current_distance_from_goal_squared > (3.7 * 3.7);
		last_distance_from_goal_squared = current_distance_from_goal_squared;
		/#
			if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
			{
				sphere(chopper_drop_point, 8, (1, 0, 0), 0.9, 0, 20, 1);
			}
		#/
		if(continue_waiting)
		{
			/#
				if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
				{
					iprintln("" + distance2d(chopper_drop_point, heli_drop_goal));
				}
			#/
			waitframe(1);
		}
	}
	/#
		if(getdvarint(#"scr_supply_drop_valid_location_debug", 0))
		{
			iprintln("" + distance2d(chopper_drop_point, heli_drop_goal));
		}
	#/
	chopper notify(#"drop_crate", {#owner:chopper.owner, #direction:chopper.angles, #position:chopper.origin});
	chopper.droptime = gettime();
	chopper playsound(#"veh_supply_drop");
	wait(0.7);
	if(isdefined(level.killstreakweapons[weapon]))
	{
		chopper killstreaks::play_pilot_dialog_on_owner("waveStartFinal", level.killstreakweapons[weapon], chopper.killstreak_id);
	}
	/#
		chopper util::debug_slow_heli_speed();
	#/
	if(level.var_e071ed64)
	{
		chopper util::function_c596f193();
		if(!ispathfinder(chopper))
		{
			chopper makepathfinder();
		}
		chopper.ignoreme = 1;
		chopper.ignoreall = 1;
		goalpath = supplydropheliendpath_v2(chopper.origin, 0);
		chopper airsupport::function_f1b7b432(goalpath.path, undefined, 1, 1);
	}
	else
	{
		goalpath = supplydropheliendpath_v2(chopper.origin, 1);
		chopper airsupport::followpath(goalpath.path, undefined, 0);
	}
	/#
		println("" + (gettime() - chopper.droptime));
	#/
	chopper notify(#"leaving");
	chopper delete();
}

/*
	Name: function_e16ff9df
	Namespace: supplydrop
	Checksum: 0x20958BD7
	Offset: 0xBF00
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_e16ff9df(delay)
{
	wait(delay);
	if(!isdefined(self))
	{
		return;
	}
	if(target_istarget(self))
	{
		target_remove(self);
	}
}

/*
	Name: speedregulator
	Namespace: supplydrop
	Checksum: 0xCCB3640B
	Offset: 0xBF58
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function speedregulator(goal)
{
	self endon(#"drop_goal", #"death");
	/#
		self util::debug_slow_heli_speed();
	#/
	maxpitch = getdvarint(#"scr_supplydropmaxpitch", 25);
	maxroll = getdvarint(#"scr_supplydropmaxroll", 35);
	self setmaxpitchroll(maxpitch, maxroll);
}

/*
	Name: helidropcrate
	Namespace: supplydrop
	Checksum: 0xDCEF2D7E
	Offset: 0xC030
	Size: 0x4DC
	Parameters: 8
	Flags: Linked
*/
function helidropcrate(killstreak, originalowner, offset, killcament, killstreak_id, package_contents_id, context, var_83f3c388)
{
	helicopter = self;
	originalowner endon(#"disconnect");
	crate = cratespawn(killstreak, killstreak_id, originalowner, self.team, self.origin, self.angles, undefined, context);
	if(killstreak == "inventory_supply_drop" || killstreak == "supply_drop")
	{
		loc_0000C16C:
		crate linkto(helicopter, (isdefined(context.droptag) ? context.droptag : "tag_origin"), (isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0)));
		helicopter clientfield::set("supplydrop_care_package_state", 1);
	}
	else if(killstreak == "inventory_tank_robot" || killstreak == "tank_robot" || killstreak == "ai_tank_marker")
	{
		loc_0000C228:
		crate linkto(helicopter, (isdefined(context.droptag) ? context.droptag : "tag_origin"), (isdefined(context.droptagoffset) ? context.droptagoffset : (0, 0, 0)));
		helicopter clientfield::set("supplydrop_ai_tank_state", 1);
		if(isdefined(level.var_14151f16))
		{
			[[level.var_14151f16]](crate, 0);
		}
	}
	team = self.team;
	waitresult = undefined;
	waitresult = helicopter waittill(#"drop_crate", #"hash_525537be2de4c159");
	chopperowner = waitresult.owner;
	origin = waitresult.position;
	angles = waitresult.direction;
	if(waitresult._notify == #"hash_525537be2de4c159")
	{
		crate cratedelete(0);
		return;
	}
	if(isdefined(chopperowner))
	{
		owner = chopperowner;
		if(owner != originalowner)
		{
			crate killstreaks::configure_team(killstreak, owner);
			killstreaks::remove_ricochet_protection(killstreak_id, owner);
		}
	}
	else
	{
		owner = originalowner;
	}
	if(isdefined(self))
	{
		team = self.team;
		if(killstreak == "inventory_supply_drop" || killstreak == "supply_drop")
		{
			helicopter clientfield::set("supplydrop_care_package_state", 0);
		}
		else if(killstreak == "inventory_tank_robot" || killstreak == "tank_robot")
		{
			helicopter clientfield::set("supplydrop_ai_tank_state", 0);
		}
	}
	if(team == owner.team)
	{
		rear_hatch_offset_height = getdvarint(#"scr_supplydropoffsetheight", 200);
		rear_hatch_offset_world = rotatepoint((offset, 0, 0), angles);
		drop_origin = (origin - (0, 0, rear_hatch_offset_height)) - rear_hatch_offset_world;
		thread dropcrate(drop_origin, angles, killstreak, owner, team, killcament, killstreak_id, package_contents_id, crate, context, var_83f3c388);
	}
}

/*
	Name: helidestroyed
	Namespace: supplydrop
	Checksum: 0x68BF4C15
	Offset: 0xC518
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function helidestroyed()
{
	self endon(#"leaving", #"helicopter_gone", #"death");
	while(true)
	{
		if(self.damagetaken > self.maxhealth)
		{
			break;
		}
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.owner))
	{
		self.owner notify(#"hash_d843795c594bf0e");
	}
	self setspeed(25, 5);
	wait(randomfloatrange(0.5, 1.5));
	self notify(#"hash_525537be2de4c159", {#owner:self.owner, #direction:self.angles, #position:self.origin});
	lbexplode();
}

/*
	Name: lbexplode
	Namespace: supplydrop
	Checksum: 0x308E85B3
	Offset: 0xC668
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function lbexplode()
{
	forward = (self.origin + (0, 0, 1)) - self.origin;
	fxpos = self gettagorigin("tag_deathfx");
	if(!isdefined(fxpos))
	{
		fxpos = self.origin;
	}
	playfx("destruct/fx8_trans_heli_exp_lg", fxpos, forward);
	self playsound(level.heli_sound[#"crash"]);
	self notify(#"explode");
	if(isdefined(self.delete_after_destruction_wait_time))
	{
		self hide();
		self waitanddelete(self.delete_after_destruction_wait_time);
	}
	else
	{
		self delete();
	}
}

/*
	Name: lbspin
	Namespace: supplydrop
	Checksum: 0x3B6C7DDC
	Offset: 0xC790
	Size: 0x11E
	Parameters: 1
	Flags: None
*/
function lbspin(speed)
{
	self endon(#"explode");
	playfxontag(level.chopper_fx[#"explode"][#"large"], self, "tail_rotor_jnt");
	playfxontag(level.chopper_fx[#"fire"][#"trail"][#"large"], self, "tail_rotor_jnt");
	self setyawspeed(speed, speed, speed);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + (speed * 0.9));
		wait(1);
	}
}

/*
	Name: refcountdecchopper
	Namespace: supplydrop
	Checksum: 0xB2692474
	Offset: 0xC8B8
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function refcountdecchopper(team, killstreak_id)
{
	self waittill(#"death");
	killstreakrules::killstreakstop("supply_drop", team, killstreak_id);
	self notify(#"cleanup_marker");
}

/*
	Name: supply_drop_dev_gui
	Namespace: supplydrop
	Checksum: 0xE40AC231
	Offset: 0xC920
	Size: 0x82
	Parameters: 0
	Flags: None
*/
function supply_drop_dev_gui()
{
	/#
		setdvar(#"scr_supply_drop_gui", "");
		while(true)
		{
			wait(0.5);
			devgui_string = getdvarstring(#"scr_supply_drop_gui");
			level.dev_gui_supply_drop = devgui_string;
		}
	#/
}

