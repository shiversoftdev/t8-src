// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\killstreaks\planemortar_shared.gsc;
#using scripts\killstreaks\airsupport.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace artillery_barrage;

/*
	Name: init_shared
	Namespace: artillery_barrage
	Checksum: 0x43B51B45
	Offset: 0x210
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_1e3747c0))
	{
		level.var_1e3747c0 = {};
		airsupport::init_shared();
		level.var_f90a2fa = undefined;
		level.var_dfa42e41 = undefined;
	}
}

/*
	Name: function_5fd995a8
	Namespace: artillery_barrage
	Checksum: 0xC806F277
	Offset: 0x268
	Size: 0xF0
	Parameters: 0
	Flags: None
*/
function function_5fd995a8()
{
	if(self killstreakrules::iskillstreakallowed("artillery_barrage", self.team) == 0)
	{
		return 0;
	}
	result = self function_6f7927c();
	killstreak_used = result === 1;
	if(killstreak_used && isdefined(self))
	{
		bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
		var_fa9aff9a = self gadgetgetslot(bundle.ksweapon);
		self gadgetpowerset(var_fa9aff9a, 0);
	}
	return killstreak_used;
}

/*
	Name: function_aa4be620
	Namespace: artillery_barrage
	Checksum: 0xDE0CB561
	Offset: 0x360
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_aa4be620()
{
	self beginlocationartilleryselection("map_directional_selector");
}

/*
	Name: function_6f7927c
	Namespace: artillery_barrage
	Checksum: 0x1DEC7D79
	Offset: 0x390
	Size: 0x19A
	Parameters: 0
	Flags: None
*/
function function_6f7927c()
{
	self airsupport::function_9e2054b0(&function_aa4be620);
	locations = [];
	if(!isdefined(self.pers[#"hash_3b8a938c10ba768b"]) || !self.pers[#"hash_3b8a938c10ba768b"])
	{
		self thread planemortar::singleradarsweep();
	}
	location = self airsupport::waitforlocationselection();
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isdefined(location.origin))
	{
		self.pers[#"hash_3b8a938c10ba768b"] = 1;
		self notify(#"cancel_selection");
		return 0;
	}
	if(self killstreakrules::iskillstreakallowed("artillery_barrage", self.team) == 0)
	{
		self.pers[#"hash_3b8a938c10ba768b"] = 1;
		self notify(#"cancel_selection");
		return 0;
	}
	self.pers[#"hash_3b8a938c10ba768b"] = 0;
	return self airsupport::function_83904681(location, &function_d7cf7d18, "artillery_barrage");
}

/*
	Name: function_d7cf7d18
	Namespace: artillery_barrage
	Checksum: 0x772293E1
	Offset: 0x538
	Size: 0xC8
	Parameters: 2
	Flags: None
*/
function function_d7cf7d18(location, killstreak_id)
{
	team = self.team;
	spawn_influencer = level influencers::create_enemy_influencer("artillery", location.origin, team);
	self thread watchforkillstreakend(team, spawn_influencer, killstreak_id);
	yaw = location.yaw;
	self thread function_496d0824(location.origin, location.yaw, team, killstreak_id);
	return true;
}

/*
	Name: watchforkillstreakend
	Namespace: artillery_barrage
	Checksum: 0x878D6660
	Offset: 0x608
	Size: 0x94
	Parameters: 3
	Flags: None
*/
function watchforkillstreakend(team, influencer, killstreak_id)
{
	self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"hash_6a70219902316c7e", #"emp_jammed");
	killstreakrules::killstreakstop("artillery_barrage", team, killstreak_id);
}

/*
	Name: getplaneflyheight
	Namespace: artillery_barrage
	Checksum: 0x43A0D4B3
	Offset: 0x6A8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function getplaneflyheight(bundle)
{
	loc_000006E2:
	return (airsupport::getminimumflyheight() + (isdefined(bundle.var_d4f45bfd) ? bundle.var_d4f45bfd : 0)) + randomint((isdefined(bundle.var_f7478ae6) ? bundle.var_f7478ae6 : 1));
}

/*
	Name: function_496d0824
	Namespace: artillery_barrage
	Checksum: 0x53B4B192
	Offset: 0x728
	Size: 0x5A0
	Parameters: 4
	Flags: None
*/
function function_496d0824(var_3bc2d545, var_e8456387, team, killstreak_id)
{
	owner = self;
	owner endon(#"emp_jammed", #"joined_team", #"joined_spectators", #"disconnect");
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	var_6c36c4dd = bundle.var_e077ecb;
	var_9bed4193 = bundle.var_32e69cad;
	var_66e0652a = 26000;
	height = getplaneflyheight(bundle);
	plane_start = (level.mapcenter[0], level.mapcenter[1], height);
	var_dca1c8d4 = self getteamcenter(self.team);
	var_d1769adf = vectornormalize((var_dca1c8d4[0], var_dca1c8d4[1], height) - (level.mapcenter[0], level.mapcenter[1], height));
	var_675219e7 = (level.mapcenter[0], level.mapcenter[1], height) + vectorscale(var_d1769adf, var_9bed4193);
	var_aff95821 = vectorcross((0, 0, 1), var_d1769adf);
	plane_start = var_675219e7 - vectorscale(var_aff95821, var_6c36c4dd);
	var_f348056 = var_675219e7 + vectorscale(var_aff95821, var_66e0652a);
	var_fe427c32 = vectortoangles(var_aff95821);
	if(isdefined(bundle.var_c28c2429))
	{
		var_fe427c32 = (var_fe427c32[0], var_fe427c32[1], bundle.var_c28c2429 * 0.75);
	}
	plane = spawnvehicle(bundle.var_f8ca3420, plane_start, var_fe427c32);
	plane setowner(owner);
	plane notsolid();
	plane killstreaks::configure_team("artillery_barrage", killstreak_id, owner, undefined, undefined, &configurechopperteampost);
	plane killstreak_hacking::enable_hacking("artillery_barrage");
	plane endon(#"hash_1fe75f940ce5fd52");
	var_1313ba73 = bundle.var_540b2ab4;
	plane.var_61e3ab9c = var_1313ba73 * 2;
	plane.var_7d573472 = var_1313ba73 * 2;
	plane setspeedimmediate(var_1313ba73, plane.var_61e3ab9c, plane.var_7d573472);
	target_set(plane, vectorscale((0, 0, 1), 100));
	plane solid();
	plane killstreaks::function_2b6aa9e8("artillery_barrage", &function_cc147a03, &function_c0f8c056);
	plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", "death");
	plane thread function_6cd200d2();
	plane thread watchgameended();
	owner thread function_598dc586(plane, var_3bc2d545, var_e8456387, team, killstreak_id, height);
	owner thread function_a9ef6d5d(plane, var_675219e7, var_aff95821, var_d1769adf);
	plane.var_f348056 = var_f348056;
	plane.var_493a2839 = var_aff95821;
	plane.var_66e0652a = var_66e0652a;
	plane thread function_6fb32e6d();
	owner waittill(#"hash_6a70219902316c7e");
	wait(1.5);
	if(function_1f3792ee(plane))
	{
		plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
	}
}

/*
	Name: function_6fb32e6d
	Namespace: artillery_barrage
	Checksum: 0xCD4F227E
	Offset: 0xCD0
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function function_6fb32e6d()
{
	plane = self;
	wait(0.5);
	if(function_1f3792ee(plane))
	{
		bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
		playfxontag(bundle.var_61feee4, plane, "tag_fx_engine2");
		playfxontag(bundle.var_61feee4, plane, "tag_fx_engine5");
	}
}

/*
	Name: getteamcenter
	Namespace: artillery_barrage
	Checksum: 0xAA9E9F48
	Offset: 0xD88
	Size: 0x122
	Parameters: 1
	Flags: None
*/
function getteamcenter(team)
{
	if(!isdefined(team))
	{
		return self.origin;
	}
	teamplayers = getplayers(team);
	var_69a51ca3 = 0;
	var_f44bf438 = (0, 0, 0);
	foreach(teammate in teamplayers)
	{
		if(!isdefined(teammate))
		{
			continue;
		}
		if(!isalive(teammate))
		{
			continue;
		}
		var_f44bf438 = var_f44bf438 + teammate.origin;
		var_69a51ca3++;
	}
	if(var_69a51ca3 == 0)
	{
		return self.origin;
	}
	return vectorscale(var_f44bf438, 1 / var_69a51ca3);
}

/*
	Name: function_4b1354ff
	Namespace: artillery_barrage
	Checksum: 0xD6D26438
	Offset: 0xEB8
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function function_4b1354ff()
{
	plane = self;
	if(plane.isleaving === 1)
	{
		return;
	}
	plane.isleaving = 1;
	var_fc8999ee = 10;
	planedir = anglestoforward(plane.angles);
	var_6fe4cf51 = 30000;
	var_15f570c1 = plane.origin + vectorscale(planedir, 30000);
	plane setplanegoalpos(var_15f570c1, var_15f570c1 + vectorscale(planedir, 300));
	plane setspeed((0.05681818 * var_6fe4cf51) / var_fc8999ee, 100);
	plane setneargoalnotifydist(100);
	plane waittill(#"curve_end");
}

/*
	Name: function_a9ef6d5d
	Namespace: artillery_barrage
	Checksum: 0xE150667D
	Offset: 0xFF8
	Size: 0xA28
	Parameters: 4
	Flags: None
*/
function function_a9ef6d5d(plane, var_675219e7, var_aff95821, var_d1769adf)
{
	owner = self;
	owner endon(#"hash_6a70219902316c7e");
	plane endon(#"death");
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	if(isdefined(bundle.var_c28c2429))
	{
		plane setplanebarrelroll(bundle.var_c28c2429 / 360, 25, 1);
	}
	var_f460c99e = [];
	var_219e510 = [];
	var_1330ab2b = bundle.var_533663fb * 2;
	var_c23fc1e3 = var_1330ab2b * bundle.var_31cddd6;
	var_e41f7c67 = var_1330ab2b * 0.5;
	var_15b62717 = var_c23fc1e3 * 0.5;
	var_368f3731 = 15 + (30 / bundle.var_31cddd6);
	var_8a172643 = var_e41f7c67 * sin(var_368f3731);
	var_a4c5b0ed = var_15b62717 * cos(var_368f3731);
	var_e3c75fef = 15 + (15 / bundle.var_31cddd6);
	var_a8afe3e3 = var_e41f7c67 * sin(var_e3c75fef);
	var_cb3c02d3 = var_15b62717 * cos(var_e3c75fef);
	var_61cc72b5 = 60;
	var_aa3875fe = var_e41f7c67 * sin(var_61cc72b5);
	var_8be5e7a8 = var_15b62717 * cos(var_61cc72b5);
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = var_675219e7 + vectorscale(var_aff95821, 50);
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_8be5e7a8)) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_aa3875fe));
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_a4c5b0ed)) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_8a172643));
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_cb3c02d3)) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_a8afe3e3));
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_15b62717)) + (vectorscale(var_d1769adf, var_e41f7c67 * -1));
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_cb3c02d3)) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) - var_a8afe3e3));
	if(!isdefined(var_f460c99e))
	{
		var_f460c99e = [];
	}
	else if(!isarray(var_f460c99e))
	{
		var_f460c99e = array(var_f460c99e);
	}
	var_f460c99e[var_f460c99e.size] = (var_675219e7 + vectorscale(var_aff95821, var_a4c5b0ed)) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) - var_8a172643));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = var_675219e7 + (vectorscale(var_d1769adf, var_1330ab2b * -1));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_a4c5b0ed * -1))) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) - var_8a172643));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_cb3c02d3 * -1))) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) - var_a8afe3e3));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_15b62717 * -1))) + (vectorscale(var_d1769adf, var_e41f7c67 * -1));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_cb3c02d3 * -1))) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_a8afe3e3));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_a4c5b0ed * -1))) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_8a172643));
	if(!isdefined(var_219e510))
	{
		var_219e510 = [];
	}
	else if(!isarray(var_219e510))
	{
		var_219e510 = array(var_219e510);
	}
	var_219e510[var_219e510.size] = (var_675219e7 + (vectorscale(var_aff95821, var_8be5e7a8 * -1))) + (vectorscale(var_d1769adf, (var_e41f7c67 * -1) + var_aa3875fe));
	/#
		function_8c164ce0(var_f460c99e);
	#/
	/#
		function_8c164ce0(var_219e510);
	#/
	var_1313ba73 = bundle.var_540b2ab4;
	plane setspeed(var_1313ba73, plane.var_61e3ab9c, plane.var_7d573472);
	while(function_1f3792ee(plane))
	{
		plane setplanegoalpos(var_f460c99e, var_1313ba73);
		plane waittill(#"curve_end");
		plane setplanegoalpos(var_219e510, var_1313ba73);
		plane waittill(#"curve_end");
	}
}

/*
	Name: function_8c164ce0
	Namespace: artillery_barrage
	Checksum: 0xEC09CA62
	Offset: 0x1A28
	Size: 0x148
	Parameters: 1
	Flags: None
*/
function function_8c164ce0(path)
{
	/#
		draw_path = getdvarint(#"hash_619e2bb393e45754", 0);
		if(draw_path == 0)
		{
			return;
		}
		var_11f31e2c = 0;
		radius = 100;
		alpha = 0.9;
		var_342eb58c = 2000;
		foreach(point in path)
		{
			if(!var_11f31e2c)
			{
				var_11f31e2c = 1;
				util::debug_sphere(point, radius, (0, 1, 0), alpha, var_342eb58c);
				continue;
			}
			util::debug_sphere(point, radius, (0, 0, 1), alpha, var_342eb58c);
		}
	#/
}

/*
	Name: function_598dc586
	Namespace: artillery_barrage
	Checksum: 0xDC541D66
	Offset: 0x1B78
	Size: 0x998
	Parameters: 6
	Flags: None
*/
function function_598dc586(plane, position, yaw, team, killstreak_id, fly_height)
{
	owner = self;
	owner endon(#"emp_jammed", #"joined_team", #"joined_spectators", #"disconnect");
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	var_37bb8781 = (0, yaw, 0);
	var_c6aa53c = anglestoforward(var_37bb8781);
	var_dc88ed1e = (position[0], position[1], fly_height);
	tracestartpos = (position[0], position[1], fly_height);
	traceendpos = (position[0], position[1], fly_height * -1);
	trace = bullettrace(tracestartpos, traceendpos, 0, undefined);
	targetpoint = (trace[#"fraction"] < 1 ? trace[#"position"] : (position[0], position[1], 0));
	/#
		if(getdvarint(#"hash_bbfcab5c3429103", 0) > 0)
		{
			for(i = 0; i < 10; i++)
			{
				sphere(targetpoint + (0, 0, 50 * i), 20, (1, 0, 0), 1, 1, 10, 800);
			}
		}
	#/
	initialoffset = (0, 0, 0);
	if(isdefined(bundle.var_d784077a))
	{
		wait(bundle.var_d784077a);
	}
	for(sweep = 0; sweep < bundle.var_b88f3e5a && function_1f3792ee(plane); sweep++)
	{
		for(var_41c99c37 = 0; var_41c99c37 < bundle.var_b32c8349 && function_1f3792ee(plane); var_41c99c37++)
		{
			startpoint = plane.origin;
			var_47b0cb83 = vectornormalize(var_dc88ed1e - startpoint);
			var_aab835e2 = anglestoright(var_37bb8781);
			rightoffset = vectorscale(var_aab835e2, bundle.var_ed4e0bcc + util::function_a1281365(bundle.var_64e90954));
			leftoffset = vectorscale(var_aab835e2, (bundle.var_ed4e0bcc * -1) + util::function_a1281365(bundle.var_64e90954));
			fire_right = vectorcross((0, 0, 1), var_47b0cb83);
			var_71d1c0cb = plane gettagorigin("tag_gunner_flash2");
			var_8cdd6f66 = plane gettagorigin("tag_gunner_flash1");
			playfxontag(bundle.var_cf763c03, plane, "tag_gunner_flash2");
			playfxontag(bundle.var_cf763c03, plane, "tag_gunner_flash1");
			var_5bbbb605 = ((targetpoint + initialoffset) + rightoffset) + (vectorscale(var_c6aa53c, (var_41c99c37 * bundle.var_f936eadc) + util::function_a1281365(bundle.var_178f3ad6)));
			var_3fddb9e8 = ((targetpoint + initialoffset) + leftoffset) + (vectorscale(var_c6aa53c, (var_41c99c37 * bundle.var_f936eadc) + util::function_a1281365(bundle.var_178f3ad6)));
			var_3e44dbbe = 1;
			if(var_3e44dbbe)
			{
				/#
					if(getdvarint(#"hash_2d8cc6ef214202c9", 0) > 0)
					{
						sphere(var_5bbbb605, 12, (0, 0, 1), 0.8, 1, 10, 120);
						sphere(var_3fddb9e8, 12, (0, 0, 1), 0.8, 1, 10, 120);
					}
				#/
				if(!ispointonnavmesh(var_5bbbb605))
				{
					var_e70ce280 = getclosestpointonnavmesh(var_5bbbb605, bundle.var_7135d43f);
					if(isdefined(var_e70ce280))
					{
						var_5bbbb605 = var_e70ce280;
					}
				}
				if(!ispointonnavmesh(var_3fddb9e8))
				{
					var_f69911a1 = getclosestpointonnavmesh(var_3fddb9e8, bundle.var_7135d43f);
					if(isdefined(var_f69911a1))
					{
						var_3fddb9e8 = var_f69911a1;
					}
				}
			}
			/#
				if(getdvarint(#"hash_2d8cc6ef214202c9", 0) > 0)
				{
					sphere(var_5bbbb605, 20, (0, 1, 0), 0.9, 1, 10, 120);
					sphere(var_3fddb9e8, 20, (0, 1, 0), 0.9, 1, 10, 120);
				}
			#/
			var_9bba3fcb = vectornormalize((var_5bbbb605[0], var_5bbbb605[1], startpoint[2]) - var_71d1c0cb);
			var_126a2ae4 = vectornormalize((var_3fddb9e8[0], var_3fddb9e8[1], startpoint[2]) - var_8cdd6f66);
			var_d8497bd7 = var_5bbbb605 - vectorscale(var_9bba3fcb, bundle.var_bd3080e0);
			var_d8497bd7 = (var_d8497bd7[0], var_d8497bd7[1], var_71d1c0cb[2]);
			var_6bd2a8a7 = var_3fddb9e8 - vectorscale(var_126a2ae4, bundle.var_bd3080e0);
			var_6bd2a8a7 = (var_6bd2a8a7[0], var_6bd2a8a7[1], var_8cdd6f66[2]);
			var_a1c7fa61 = vectortoangles(var_d8497bd7 - var_71d1c0cb);
			var_7575c35 = vectortoangles(var_6bd2a8a7 - var_8cdd6f66);
			self thread function_5a0d2864(var_71d1c0cb, var_d8497bd7, var_5bbbb605, var_a1c7fa61, self.team, killstreak_id);
			self thread function_5a0d2864(var_8cdd6f66, var_6bd2a8a7, var_3fddb9e8, var_7575c35, self.team, killstreak_id);
			plane playsound(#"hash_3e7e330ab5fcdcd");
			wait(bundle.var_768e166a);
		}
		if((sweep + 1) < bundle.var_b88f3e5a && bundle.var_de725346 > 0 && function_1f3792ee(plane))
		{
			wait(bundle.var_de725346);
		}
	}
	wait(3);
	owner notify(#"hash_6a70219902316c7e");
}

/*
	Name: function_1f3792ee
	Namespace: artillery_barrage
	Checksum: 0xDD6E94C2
	Offset: 0x2518
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_1f3792ee(plane)
{
	return isdefined(plane) && !isdefined(plane.destroyed) && !plane.isleaving === 1;
}

/*
	Name: function_5a0d2864
	Namespace: artillery_barrage
	Checksum: 0xC9C339E0
	Offset: 0x2560
	Size: 0x6AC
	Parameters: 6
	Flags: None
*/
function function_5a0d2864(startpoint, endpoint, targetpoint, angles, team, killstreak_id)
{
	bundle = level.killstreakbundle[#"artillery_barrage"];
	shell = spawn("script_model", startpoint);
	shell.team = team;
	shell.targetname = "guided_artillery_shell";
	shell setowner(self);
	shell.owner = self;
	shell.owner thread watchownerevents(shell);
	shell killstreaks::configure_team("artillery_barrage", killstreak_id, self);
	shell killstreak_hacking::enable_hacking("artillery_barrage");
	target_set(shell);
	shell endon(#"delete", #"death");
	shell.angles = angles;
	shell setmodel(bundle.var_10082efb);
	shell setenemymodel(bundle.var_152e037f);
	shell notsolid();
	playfxontag(bundle.var_f5fcd16f, shell, "tag_bomb_fx");
	shell clientfield::set("enemyvehicle", 1);
	shell killstreaks::function_2b6aa9e8("artillery_barrage", &function_8ebde515, undefined, &function_9b3c6309);
	shell thread watchforemp(self);
	var_c786830e = max(bundle.var_98a3d82c - 0.1, 0.1);
	var_c786830e = min(var_c786830e, 1.5);
	shell moveto(endpoint, bundle.var_98a3d82c, 0, var_c786830e);
	wait(bundle.var_98a3d82c * 0.5);
	velocity = shell getvelocity();
	wait(bundle.var_98a3d82c * 0.5);
	remainingdistance = distance2d(shell.origin, targetpoint);
	halfgravity = getdvarfloat(#"bg_gravity", 0) * 0.5;
	dxy = abs(remainingdistance);
	dz = endpoint[2] - targetpoint[2];
	droptime = sqrt(dz / halfgravity);
	dvxy = dxy / droptime;
	nvel = vectornormalize(velocity);
	launchvel = nvel * dvxy;
	bomb = self magicmissile(bundle.ksweapon, shell.origin, launchvel);
	target_set(bomb);
	bomb killstreaks::configure_team("artillery_barrage", killstreak_id, self);
	bomb killstreak_hacking::enable_hacking("artillery_barrage");
	shell notify(#"hackertool_update_ent", {#entity:bomb});
	bomb clientfield::set("enemyvehicle", 1);
	bomb.targetname = "guided_artillery_shell";
	bomb setowner(self);
	bomb.owner = self;
	bomb.team = team;
	var_23aaa2dd = max(droptime - 4, 2);
	bomb thread function_ae65820c(var_23aaa2dd);
	bomb killstreaks::function_2b6aa9e8("artillery_barrage", &function_8ebde515, undefined, &function_9b3c6309);
	bomb thread watchforemp(self);
	bomb thread watchforimpact(self);
	bomb.owner thread watchownerevents(bomb);
	if(isdefined(level.var_1e30ea6a))
	{
		bomb.owner thread [[level.var_1e30ea6a]](bundle.ksweapon, bomb);
	}
	waitframe(1);
	shell hide();
	waitframe(1);
	shell delete();
}

/*
	Name: function_ae65820c
	Namespace: artillery_barrage
	Checksum: 0x3208933A
	Offset: 0x2C18
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_ae65820c(delay)
{
	wait(delay);
	if(isdefined(self))
	{
		self playloopsound(#"hash_6e9ee0f0f9ecd8d7");
	}
}

/*
	Name: function_8ebde515
	Namespace: artillery_barrage
	Checksum: 0x37AC3565
	Offset: 0x2C60
	Size: 0x18C
	Parameters: 2
	Flags: None
*/
function function_8ebde515(attacker, weapon)
{
	self endon(#"death");
	bundle = level.killstreakbundle[#"artillery_barrage"];
	attacker = self [[level.figure_out_attacker]](attacker);
	if(isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker)))
	{
		challenges::destroyedaircraft(attacker, weapon, 0);
		attacker challenges::addflyswatterstat(weapon, self);
		scoreevents::processscoreevent(bundle.var_ebd92bbc, attacker, self.owner, weapon);
	}
	if(isdefined(bundle.ksexplosionfx))
	{
		playfxontag(bundle.ksexplosionfx, self, "tag_origin");
	}
	self setmodel(#"tag_origin");
	self stoploopsound();
	wait(0.5);
	self delete();
}

/*
	Name: watchownerevents
	Namespace: artillery_barrage
	Checksum: 0x4D7636E7
	Offset: 0x2DF8
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function watchownerevents(bomb)
{
	player = self;
	bomb endon(#"death");
	player waittill(#"disconnect", #"joined_team", #"joined_spectators");
	if(isdefined(isalive(bomb)))
	{
		bomb delete();
	}
}

/*
	Name: watchforemp
	Namespace: artillery_barrage
	Checksum: 0x1470D4E5
	Offset: 0x2EA0
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function watchforemp(owner)
{
	self endon(#"delete", #"death");
	waitresult = undefined;
	waitresult = self waittill(#"emp_deployed");
	function_9b3c6309(waitresult.attacker);
}

/*
	Name: watchforimpact
	Namespace: artillery_barrage
	Checksum: 0xB5BB3766
	Offset: 0x2F18
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function watchforimpact(owner)
{
	if(!isdefined(level.var_dfa42e41))
	{
		return;
	}
	s_info = spawnstruct();
	s_info.origin = self.origin;
	while(isalive(self))
	{
		s_info.origin = self.origin;
		waitframe(1);
	}
	[[level.var_dfa42e41]](s_info);
}

/*
	Name: function_9b3c6309
	Namespace: artillery_barrage
	Checksum: 0xAE13D852
	Offset: 0x2FB8
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function function_9b3c6309(attacker)
{
	if(isdefined(level.var_f90a2fa))
	{
		thread [[level.var_f90a2fa]](attacker, self);
	}
	bundle = level.killstreakbundle[#"artillery_barrage"];
	if(isdefined(self) && isdefined(bundle.ksexplosionfx))
	{
		playfx(bundle.ksexplosionfx, self.origin);
	}
	self stoploopsound();
	wait(0.1);
	self delete();
}

/*
	Name: function_cc147a03
	Namespace: artillery_barrage
	Checksum: 0xE3CFA643
	Offset: 0x3090
	Size: 0x174
	Parameters: 2
	Flags: None
*/
function function_cc147a03(attacker, weapon)
{
	plane = self;
	plane.destroyed = 1;
	if(isdefined(attacker) && (!isdefined(plane.owner) || plane.owner util::isenemyplayer(attacker)))
	{
		challenges::destroyedaircraft(attacker, weapon, 0);
		attacker challenges::addflyswatterstat(weapon, self);
		luinotifyevent(#"player_callout", 2, #"hash_5d32f6a46883ef3c", attacker.entnum);
		plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:1});
	}
	if(plane.isleaving !== 1)
	{
		plane killstreaks::play_pilot_dialog_on_owner("destroyed", "artillery_barrage");
		plane killstreaks::play_destroyed_dialog_on_owner("artillery_barrage", self.killstreakid);
	}
}

/*
	Name: function_c0f8c056
	Namespace: artillery_barrage
	Checksum: 0x9CF4978D
	Offset: 0x3210
	Size: 0x64
	Parameters: 2
	Flags: None
*/
function function_c0f8c056(attacker, weapon)
{
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	playfxontag(bundle.var_328ce6e4, self, "tag_fx_engine3");
}

/*
	Name: function_6cd200d2
	Namespace: artillery_barrage
	Checksum: 0xA97E05E3
	Offset: 0x3280
	Size: 0x354
	Parameters: 0
	Flags: None
*/
function function_6cd200d2()
{
	plane = self;
	waitresult = undefined;
	waitresult = plane waittill(#"hash_1fe75f940ce5fd52");
	killed = waitresult.is_killed;
	if(target_istarget(plane))
	{
		target_remove(plane);
	}
	if(killed)
	{
		wait(randomfloatrange(0.1, 0.2));
		plane function_62b8d1d7();
		plane function_ab90e44c();
		plane thread function_b27d956d();
		goalx = randomfloatrange(650, 700);
		goaly = randomfloatrange(650, 700);
		if(randomintrange(0, 2) > 0)
		{
			goalx = goalx * -1;
		}
		if(randomintrange(0, 2) > 0)
		{
			goaly = goaly * -1;
		}
		planedir = anglestoforward(plane.angles);
		plane setplanegoalpos((plane.origin + (goalx, goaly, randomfloatrange(600, 700) * -1)) + vectorscale(planedir, 3500));
		var_8518e93e = randomfloatrange(3, 4);
		plane setplanebarrelroll(randomfloatrange(0.08333334, 0.1111111), randomfloatrange(4, 5));
		plane_speed = plane getspeedmph();
		wait(0.7);
		plane setspeed(plane_speed * 1.5, 20);
		wait(var_8518e93e - 0.7);
		plane function_f6f579e3();
		wait(0.1);
		plane ghost();
		wait(0.5);
	}
	else
	{
		plane function_4b1354ff();
	}
	plane delete();
}

/*
	Name: function_62b8d1d7
	Namespace: artillery_barrage
	Checksum: 0x3B32BA5D
	Offset: 0x35E0
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_62b8d1d7()
{
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	playfxontag(bundle.var_545fa8c2, self, "tag_fx_engine4");
	self playsound(level.heli_sound[#"crash"]);
}

/*
	Name: function_ab90e44c
	Namespace: artillery_barrage
	Checksum: 0x4E25D569
	Offset: 0x3668
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_ab90e44c()
{
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	playfxontag(bundle.var_328ce6e4, self, "tag_fx_engine1");
}

/*
	Name: function_b27d956d
	Namespace: artillery_barrage
	Checksum: 0xED6A8D42
	Offset: 0x36C8
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_b27d956d()
{
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	wait(randomfloatrange(0.2, 0.4));
	playfxontag(bundle.var_328ce6e4, self, "tag_fx_engine5");
	playfxontag(bundle.var_545fa8c2, self, "tag_fx_engine4");
	self playsound(level.heli_sound[#"crash"]);
	wait(randomfloatrange(0.2, 0.4));
	playfxontag(bundle.var_328ce6e4, self, "tag_fx_engine3");
}

/*
	Name: function_f6f579e3
	Namespace: artillery_barrage
	Checksum: 0x85B28032
	Offset: 0x37E0
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_f6f579e3()
{
	bundle = level.killstreaks[#"artillery_barrage"].script_bundle;
	playfxontag(bundle.ksexplosionfx, self, "tag_body_animate");
	self playsound(level.heli_sound[#"crash"]);
}

/*
	Name: configurechopperteampost
	Namespace: artillery_barrage
	Checksum: 0x46ED3CE8
	Offset: 0x3868
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function configurechopperteampost(owner, ishacked)
{
	plane = self;
	plane thread watchownerdisconnect(owner);
}

/*
	Name: watchownerdisconnect
	Namespace: artillery_barrage
	Checksum: 0x96C36BA6
	Offset: 0x38B0
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function watchownerdisconnect(owner)
{
	self notify("25895df09879ecfc");
	self endon("25895df09879ecfc");
	plane = self;
	plane endon(#"hash_1fe75f940ce5fd52");
	owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
	plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
}

/*
	Name: watchgameended
	Namespace: artillery_barrage
	Checksum: 0x4888B352
	Offset: 0x3968
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function watchgameended()
{
	plane = self;
	plane endon(#"hash_1fe75f940ce5fd52", #"death");
	level waittill(#"game_ended");
	plane notify(#"hash_1fe75f940ce5fd52", {#is_killed:0});
}

