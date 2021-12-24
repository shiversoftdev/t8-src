// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_7bafaa95bb1b427e;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_f8e3338e;

/*
	Name: function_89f2df9
	Namespace: namespace_f8e3338e
	Checksum: 0x7892C2F6
	Offset: 0x1C0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1e8004ee73b43357", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: namespace_f8e3338e
	Checksum: 0x55A9CF6
	Offset: 0x208
	Size: 0x112
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	params = function_4d1e7b48("dot_wraith_fire");
	level.var_40d32830 = params.var_18d16a6b;
	level.var_ccdda8d1 = params.var_67e2281d;
	level.var_660293e0 = [];
	level.var_d3b05dcb = [];
	level._effect[#"hash_6024e139900c449a"] = #"hash_3937ef26298b6caf";
	weaponobjects::function_e6400478(#"hash_c78156ba6aeda14", &function_5ea93036, 1);
	weaponobjects::function_e6400478(#"hash_6cb687e3f8c569fd", &function_5ea93036, 1);
	level.var_f9145520 = 0;
}

/*
	Name: function_5ea93036
	Namespace: namespace_f8e3338e
	Checksum: 0x18CA03FD
	Offset: 0x328
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function function_5ea93036(watcher)
{
	watcher.onspawn = &function_dfe5cf4c;
}

/*
	Name: function_dfe5cf4c
	Namespace: namespace_f8e3338e
	Checksum: 0x56D354E
	Offset: 0x358
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_dfe5cf4c(watcher, player)
{
	player endon(#"death");
	level endon(#"game_ended");
	player stats::function_e24eec31(self.weapon, #"used", 1);
	self thread function_13f6636b(player, self.weapon);
}

/*
	Name: function_4dbceded
	Namespace: namespace_f8e3338e
	Checksum: 0x46A290DD
	Offset: 0x3F0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_4dbceded()
{
	self waittill(#"death");
	waittillframeend();
	self notify(#"hash_51d0dcaebb5940a5");
}

/*
	Name: function_13f6636b
	Namespace: namespace_f8e3338e
	Checksum: 0xF51E619C
	Offset: 0x428
	Size: 0x264
	Parameters: 2
	Flags: Linked
*/
function function_13f6636b(owner, weapon)
{
	self endon(#"hacked", #"hash_51d0dcaebb5940a5");
	/#
		assert(isdefined(weapon.var_4dd46f8a), "" + weapon.name);
	#/
	self thread function_4dbceded();
	team = self.team;
	killcament = spawn("script_model", self.origin);
	killcament.targetname = "wraith_fire_killcament";
	killcament util::deleteaftertime(15);
	killcament.starttime = gettime();
	killcament linkto(self);
	killcament setweapon(self.weapon);
	killcament killcam::store_killcam_entity_on_entity(self);
	self thread function_b66b2f4d();
	waitresult = undefined;
	waitresult = self waittill(#"projectile_impact_explode", #"explode");
	if(waitresult._notify == "projectile_impact_explode")
	{
		if(isdefined(killcament))
		{
			killcament unlink();
		}
		var_bd5f5c6c = !function_f4e48434(waitresult.position);
		if(var_bd5f5c6c)
		{
			function_3932cbd9(owner, waitresult.position, waitresult.normal, self.var_59ba00f5, killcament, weapon, team, getscriptbundle(weapon.var_4dd46f8a));
		}
	}
}

/*
	Name: function_3932cbd9
	Namespace: namespace_f8e3338e
	Checksum: 0x937F9BE6
	Offset: 0x698
	Size: 0x8C
	Parameters: 8
	Flags: Linked
*/
function function_3932cbd9(owner, origin, normal, velocity, killcament, weapon, team, var_4dd46f8a)
{
	playsoundatposition("", origin);
	self thread function_e8ad1d81(origin, owner, normal, velocity, killcament, weapon, team, var_4dd46f8a);
}

/*
	Name: function_f4e48434
	Namespace: namespace_f8e3338e
	Checksum: 0xAD03EE07
	Offset: 0x730
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_f4e48434(position)
{
	var_c84f4998 = getwaterheight(position) - position[2];
	return !(isdefined(level.var_c62ed297) && level.var_c62ed297) && var_c84f4998 >= 24;
}

/*
	Name: function_a66ba8cc
	Namespace: namespace_f8e3338e
	Checksum: 0x73C35DEA
	Offset: 0x7A0
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function function_a66ba8cc(var_c84f4998)
{
	return !(isdefined(level.var_c62ed297) && level.var_c62ed297) && 0 < var_c84f4998 && var_c84f4998 < 24;
}

/*
	Name: function_330c2616
	Namespace: namespace_f8e3338e
	Checksum: 0x846D9BB4
	Offset: 0x7F0
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_330c2616(position)
{
	return getwaterheight(position) - position[2];
}

/*
	Name: function_b66b2f4d
	Namespace: namespace_f8e3338e
	Checksum: 0x53598544
	Offset: 0x828
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function function_b66b2f4d()
{
	self endon(#"projectile_impact_explode", #"death");
	while(true)
	{
		self.var_59ba00f5 = self getvelocity();
		wait(float(function_60d95f53()) / 1000);
	}
}

/*
	Name: function_7cbeb2f0
	Namespace: namespace_f8e3338e
	Checksum: 0xC04FDEAF
	Offset: 0x8B0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_7cbeb2f0(normal)
{
	if(normal[2] < 0.5)
	{
		stepoutdistance = normal * getdvarint(#"hash_4fd125a3b5b9c476", 50);
	}
	else
	{
		stepoutdistance = normal * getdvarint(#"hash_49b134352662c4b9", 12);
	}
	return stepoutdistance;
}

/*
	Name: function_e8ad1d81
	Namespace: namespace_f8e3338e
	Checksum: 0xE612B478
	Offset: 0x948
	Size: 0x96C
	Parameters: 8
	Flags: Linked
*/
function function_e8ad1d81(position, owner, normal, velocity, killcament, weapon, team, var_4dd46f8a)
{
	var_4f9d7296 = position;
	var_493d36f9 = normal;
	var_96609105 = vectornormalize(velocity);
	var_87d082a9 = vectorscale(var_96609105, -1);
	var_d6d43109 = 1;
	var_e76400c0 = undefined;
	wallnormal = undefined;
	var_693f108f = undefined;
	var_8eb0a180 = getweapon(#"hash_55a4aa4a1077e2cc");
	var_f483ab45 = getweapon(#"hash_7d040bd867e93061");
	var_fc031a6d = getweapon(#"hash_5624a55eb03372d0");
	if(normal[2] < -0.5)
	{
		var_36c22d1d = position + vectorscale(normal, 2);
		var_8ae62b02 = var_36c22d1d - vectorscale((0, 0, 1), 240);
		var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), self, 1);
		if(var_69d15ad0[#"fraction"] < 1)
		{
			position = var_69d15ad0[#"position"];
			if(var_69d15ad0[#"fraction"] > 0)
			{
				normal = var_69d15ad0[#"normal"];
			}
			else
			{
				normal = (0, 0, 1);
			}
			var_1b1117c6 = 1.2 * var_69d15ad0[#"fraction"];
			var_87d082a9 = normal;
			if(var_1b1117c6 > 0)
			{
				wait(var_1b1117c6);
			}
		}
		else
		{
			return;
		}
	}
	else if(normal[2] < 0.5)
	{
		var_36c22d1d = position + vectorscale(var_493d36f9, 2);
		var_8ae62b02 = var_36c22d1d - vectorscale((0, 0, 1), 20);
		var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), self, 1);
		if(var_69d15ad0[#"fraction"] < 1)
		{
			position = var_36c22d1d;
			if(var_69d15ad0[#"fraction"] > 0)
			{
				normal = var_69d15ad0[#"normal"];
			}
			else
			{
				normal = (0, 0, 1);
			}
		}
	}
	if(normal[2] < 0.5)
	{
		wall_normal = normal;
		var_36c22d1d = var_4f9d7296 + vectorscale(var_493d36f9, 8);
		var_8ae62b02 = var_36c22d1d - vectorscale((0, 0, 1), 300);
		var_69d15ad0 = physicstrace(var_36c22d1d, var_8ae62b02, vectorscale((-1, -1, -1), 3), vectorscale((1, 1, 1), 3), self, 1);
		var_693f108f = var_69d15ad0[#"fraction"] * 300;
		var_959a2a8b = 0;
		if(var_693f108f > 10)
		{
			var_e76400c0 = var_4f9d7296;
			wallnormal = var_493d36f9;
			var_d6d43109 = sqrt(1 - var_69d15ad0[#"fraction"]);
			var_959a2a8b = 1;
		}
		if(var_69d15ad0[#"fraction"] < 1)
		{
			position = var_69d15ad0[#"position"];
			if(var_69d15ad0[#"fraction"] > 0)
			{
				normal = var_69d15ad0[#"normal"];
			}
			else
			{
				normal = (0, 0, 1);
			}
		}
		if(var_959a2a8b)
		{
			x = var_4f9d7296[0];
			y = var_4f9d7296[1];
			lowestz = var_69d15ad0[#"position"][2];
			z = var_4f9d7296[2];
			while(z > lowestz)
			{
				newpos = (x, y, z);
				var_c84f4998 = function_330c2616(newpos);
				if(function_a66ba8cc(var_c84f4998) || function_f4e48434(newpos))
				{
					newpos = newpos - (0, 0, var_c84f4998);
					level thread function_42b9fdbe(var_fc031a6d, newpos, (0, 0, 1), int(var_4dd46f8a.var_b79d64a9), team);
					break;
				}
				level thread function_42b9fdbe(var_f483ab45, newpos, wall_normal, int(var_4dd46f8a.var_b79d64a9), team);
				z = z - randomintrange(20, 30);
			}
			var_bc9ec158 = 0.6 * var_69d15ad0[#"fraction"];
			if(var_bc9ec158 > 0)
			{
				wait(var_bc9ec158);
			}
		}
	}
	startpos = position + function_7cbeb2f0(normal);
	desiredendpos = startpos + vectorscale((0, 0, 1), 60);
	function_85ff22aa(startpos, 20, (0, 1, 0), 0.6, 200);
	phystrace = physicstrace(startpos, desiredendpos, vectorscale((-1, -1, -1), 4), vectorscale((1, 1, 1), 4), self, 1);
	goalpos = (phystrace[#"fraction"] < 1 ? phystrace[#"position"] : desiredendpos);
	if(isdefined(killcament))
	{
		killcament moveto(goalpos, 0.5);
	}
	rotation = randomint(360);
	if(normal[2] < 0.1 && !isdefined(var_e76400c0))
	{
		black = vectorscale((1, 1, 1), 0.1);
		trace = hitpos(startpos, (startpos + ((normal * -1) * 70)) + ((0, 0, -1) * 70), black);
		traceposition = trace[#"position"];
		if(trace[#"fraction"] < 0.9)
		{
			var_252a0dc7 = trace[#"normal"];
			function_a25dee15(var_f483ab45, traceposition, var_252a0dc7, int(var_4dd46f8a.var_b79d64a9), team);
		}
	}
	var_87d082a9 = normal;
	level function_8a03d3f3(owner, position, startpos, var_87d082a9, var_d6d43109, rotation, killcament, weapon, var_4dd46f8a, team, var_e76400c0, wallnormal, var_693f108f);
}

/*
	Name: function_523961e2
	Namespace: namespace_f8e3338e
	Checksum: 0x8A2D34AB
	Offset: 0x12C0
	Size: 0x98
	Parameters: 7
	Flags: Linked
*/
function function_523961e2(startpos, normal, var_4997e17c, fxindex, fxcount, defaultdistance, rotation)
{
	currentangle = (360 / fxcount) * fxindex;
	var_7ee25402 = rotatepointaroundaxis(var_4997e17c * defaultdistance, normal, currentangle + rotation);
	return startpos + var_7ee25402;
}

/*
	Name: function_8a03d3f3
	Namespace: namespace_f8e3338e
	Checksum: 0x5D59B051
	Offset: 0x1360
	Size: 0x10B0
	Parameters: 13
	Flags: Linked
*/
function function_8a03d3f3(owner, impactpos, startpos, normal, multiplier, rotation, killcament, weapon, var_4dd46f8a, team, var_e76400c0, wallnormal, var_693f108f)
{
	defaultdistance = var_4dd46f8a.var_6193a41b * multiplier;
	defaultdropdistance = getdvarint(#"hash_4270b8db6cf2ceff", 90);
	colorarray = [];
	colorarray[colorarray.size] = (0.9, 0.2, 0.2);
	colorarray[colorarray.size] = (0.2, 0.9, 0.2);
	colorarray[colorarray.size] = (0.2, 0.2, 0.9);
	colorarray[colorarray.size] = vectorscale((1, 1, 1), 0.9);
	locations = [];
	locations[#"color"] = [];
	locations[#"loc"] = [];
	locations[#"tracepos"] = [];
	locations[#"distsqrd"] = [];
	locations[#"fxtoplay"] = [];
	locations[#"radius"] = [];
	locations[#"hash_33059ac06a23beca"] = [];
	locations[#"hash_7852e39f75c4b5c0"] = [];
	locations[#"steam"] = [];
	fxcount = var_4dd46f8a.var_b650dc43;
	var_33ad9452 = (isdefined(var_4dd46f8a.var_bc24d9d3) ? var_4dd46f8a.var_bc24d9d3 : 0);
	fxcount = int(math::clamp((fxcount * multiplier) + 6, 6, var_4dd46f8a.var_b650dc43));
	if(multiplier < 0.04)
	{
		fxcount = 0;
	}
	var_4997e17c = perpendicularvector(normal);
	for(fxindex = 0; fxindex < fxcount; fxindex++)
	{
		locations[#"point"][fxindex] = function_523961e2(startpos, normal, var_4997e17c, fxindex, fxcount, defaultdistance, rotation);
		function_85ff22aa(locations[#"point"][fxindex], 10, (0, fxindex * 20, 0), 0.6, 200);
		locations[#"color"][fxindex] = colorarray[fxindex % colorarray.size];
	}
	var_1cac1ca8 = normal[2] > 0.5;
	for(count = 0; count < fxcount; count++)
	{
		trace = hitpos(startpos, locations[#"point"][count], locations[#"color"][count]);
		traceposition = trace[#"position"];
		locations[#"tracepos"][count] = traceposition;
		hitsomething = 0;
		if(trace[#"fraction"] < 0.7)
		{
			function_85ff22aa(traceposition, 10, (1, 0, 0), 0.6, 200);
			locations[#"loc"][count] = traceposition;
			locations[#"normal"][count] = trace[#"normal"];
			if(var_1cac1ca8)
			{
				locations[#"hash_33059ac06a23beca"][count] = 1;
			}
			hitsomething = 1;
		}
		if(!hitsomething)
		{
			var_e5d1793d = hitpos(traceposition, traceposition - (normal * defaultdropdistance), locations[#"color"][count]);
			if(var_e5d1793d[#"fraction"] != 1)
			{
				function_85ff22aa(var_e5d1793d[#"position"], 10, (0, 0, 1), 0.6, 200);
				locations[#"loc"][count] = var_e5d1793d[#"position"];
				var_c84f4998 = function_330c2616(var_e5d1793d[#"position"]);
				if(function_a66ba8cc(var_c84f4998))
				{
					locations[#"normal"][count] = (0, 0, 1);
					locations[#"steam"][count] = 1;
					locations[#"loc"][count] = locations[#"loc"][count] - (0, 0, var_c84f4998);
				}
				else
				{
					locations[#"normal"][count] = var_e5d1793d[#"normal"];
					locations[#"hash_7852e39f75c4b5c0"][count] = 1;
				}
			}
		}
		randangle = randomint(360);
		var_c4b09917 = randomfloatrange(-25, 25);
		var_7ee25402 = rotatepointaroundaxis(var_4997e17c, normal, randangle);
		var_995eb37a = int(min(((var_33ad9452 * multiplier) * trace[#"fraction"]) + 1, var_33ad9452));
		for(var_ecef2fde = 0; var_ecef2fde < var_995eb37a && (count % 2) == 0; var_ecef2fde++)
		{
			fraction = (var_ecef2fde + 1) / (var_995eb37a + 1);
			offsetpoint = (startpos + ((traceposition - startpos) * fraction)) + (var_7ee25402 * var_c4b09917);
			var_9417df90 = hitpos(offsetpoint, offsetpoint - (normal * defaultdropdistance), locations[#"color"][count]);
			if(var_9417df90[#"fraction"] != 1)
			{
				function_85ff22aa(var_9417df90[#"position"], 10, (0, 0, 1), 0.6, 200);
				locindex = count + (fxcount * (var_ecef2fde + 1));
				locations[#"loc"][locindex] = var_9417df90[#"position"];
				var_c84f4998 = function_330c2616(var_9417df90[#"position"]);
				if(function_a66ba8cc(var_c84f4998))
				{
					locations[#"normal"][locindex] = (0, 0, 1);
					locations[#"steam"][locindex] = 1;
					locations[#"loc"][locindex] = locations[#"loc"][locindex] - (0, 0, var_c84f4998);
					continue;
				}
				locations[#"normal"][locindex] = var_9417df90[#"normal"];
			}
		}
	}
	var_8eb0a180 = getweapon(#"hash_55a4aa4a1077e2cc");
	var_1c8ca3ba = getweapon(#"hash_753ba1d1412a4962");
	var_c0fe81f1 = getweapon(#"hash_5e1f4dd6a8a34700");
	var_fc031a6d = getweapon(#"hash_5624a55eb03372d0");
	var_6b23e1c9 = impactpos + (normal * 1.5);
	forward = (1, 0, 0);
	if(abs(vectordot(forward, normal)) > 0.999)
	{
		forward = (0, 0, 1);
	}
	mdl_anchor = util::spawn_model("tag_origin", var_6b23e1c9);
	s_trace = groundtrace(mdl_anchor.origin + vectorscale((0, 0, 1), 10), mdl_anchor.origin + (vectorscale((0, 0, -1), 100)), 0, mdl_anchor);
	if(isdefined(s_trace[#"entity"]) && s_trace[#"entity"] ismovingplatform())
	{
		mdl_anchor linkto(s_trace[#"entity"]);
	}
	else
	{
		mdl_anchor delete();
	}
	if(!function_f4e48434(var_6b23e1c9))
	{
		if(isdefined(mdl_anchor))
		{
			playfxontag(level._effect[#"hash_6024e139900c449a"], mdl_anchor, "tag_origin", 0);
		}
		else
		{
			var_63f53893 = playfx(level._effect[#"hash_6024e139900c449a"], var_6b23e1c9, forward, normal, 0, team);
			if(!isdefined(level.var_d3b05dcb))
			{
				level.var_d3b05dcb = [];
			}
			else if(!isarray(level.var_d3b05dcb))
			{
				level.var_d3b05dcb = array(level.var_d3b05dcb);
			}
			level.var_d3b05dcb[level.var_d3b05dcb.size] = var_63f53893;
		}
		if(!isdefined(var_e76400c0))
		{
			var_af1bdf1 = function_a25dee15(var_8eb0a180, var_6b23e1c9, normal, int(var_4dd46f8a.var_b79d64a9), team);
			var_af1bdf1 function_4e5a1dd3(mdl_anchor);
		}
	}
	if(level.gameended)
	{
		return;
	}
	thread damageeffectarea(owner, startpos, killcament, normal, var_8eb0a180, var_4dd46f8a, multiplier, var_e76400c0, wallnormal, var_693f108f, mdl_anchor);
	thread function_9464e4ad(owner, startpos, killcament, normal, var_8eb0a180, var_4dd46f8a, multiplier, var_e76400c0, wallnormal, var_693f108f, mdl_anchor);
	var_b1dd2ca0 = getarraykeys(locations[#"loc"]);
	foreach(var_7ee5c69b in var_b1dd2ca0)
	{
		if(!isdefined(var_7ee5c69b))
		{
			continue;
		}
		if(function_f4e48434(locations[#"loc"][var_7ee5c69b]))
		{
			continue;
		}
		if(is_round_reset())
		{
			break;
		}
		if(isdefined(locations[#"hash_7852e39f75c4b5c0"][var_7ee5c69b]))
		{
			fireweapon = var_c0fe81f1;
		}
		else if(isdefined(locations[#"steam"][var_7ee5c69b]))
		{
			fireweapon = var_fc031a6d;
		}
		else
		{
			fireweapon = (isdefined(locations[#"hash_33059ac06a23beca"][var_7ee5c69b]) ? var_1c8ca3ba : var_8eb0a180);
		}
		level thread function_42b9fdbe(fireweapon, locations[#"loc"][var_7ee5c69b], locations[#"normal"][var_7ee5c69b], int(var_4dd46f8a.var_b79d64a9), team, mdl_anchor);
	}
}

/*
	Name: function_42b9fdbe
	Namespace: namespace_f8e3338e
	Checksum: 0x72227895
	Offset: 0x2418
	Size: 0x9C
	Parameters: 6
	Flags: Linked
*/
function function_42b9fdbe(weapon, loc, normal, duration, team, mdl_anchor)
{
	wait(randomfloatrange(0, 0.5));
	var_af1bdf1 = function_a25dee15(weapon, loc, normal, duration, team);
	var_af1bdf1 function_4e5a1dd3(mdl_anchor);
}

/*
	Name: function_a25dee15
	Namespace: namespace_f8e3338e
	Checksum: 0x3DAEE41B
	Offset: 0x24C0
	Size: 0x186
	Parameters: 5
	Flags: Linked
*/
function function_a25dee15(weapon, loc, normal, duration, team)
{
	level.var_d3b05dcb = array::remove_undefined(level.var_d3b05dcb);
	var_c4554e4a = (isdefined(level.var_f9af4bc8) ? level.var_f9af4bc8 : 20);
	if(level.var_d3b05dcb.size >= var_c4554e4a)
	{
		level.var_d3b05dcb[0] delete();
		arrayremoveindex(level.var_d3b05dcb, 0);
	}
	var_af1bdf1 = spawntimedfx(weapon, loc, normal, duration, team);
	if(!isdefined(level.var_d3b05dcb))
	{
		level.var_d3b05dcb = [];
	}
	else if(!isarray(level.var_d3b05dcb))
	{
		level.var_d3b05dcb = array(level.var_d3b05dcb);
	}
	level.var_d3b05dcb[level.var_d3b05dcb.size] = var_af1bdf1;
	return var_af1bdf1;
}

/*
	Name: function_4e5a1dd3
	Namespace: namespace_f8e3338e
	Checksum: 0xFC9933A
	Offset: 0x2650
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_4e5a1dd3(mdl_anchor)
{
	if(isdefined(self) && isdefined(mdl_anchor))
	{
		self enablelinkto();
		self linkto(mdl_anchor);
	}
}

/*
	Name: incendiary_debug_line
	Namespace: namespace_f8e3338e
	Checksum: 0x5FA412
	Offset: 0x26A8
	Size: 0xB4
	Parameters: 5
	Flags: None
*/
function incendiary_debug_line(from, to, color, depthtest, time)
{
	/#
		debug_rcbomb = getdvarint(#"hash_75de04766593ca0c", 0);
		if(debug_rcbomb == 1)
		{
			if(!isdefined(time))
			{
				time = 100;
			}
			if(!isdefined(depthtest))
			{
				depthtest = 1;
			}
			line(from, to, color, 1, depthtest, time);
		}
	#/
}

/*
	Name: damageeffectarea
	Namespace: namespace_f8e3338e
	Checksum: 0xAB9BF636
	Offset: 0x2768
	Size: 0x698
	Parameters: 11
	Flags: Linked
*/
function damageeffectarea(owner, position, killcament, normal, weapon, var_4dd46f8a, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, mdl_anchor)
{
	level endon(#"game_ended");
	radius = var_4dd46f8a.var_6193a41b * radius_multiplier;
	height = var_4dd46f8a.var_cbd86f3e;
	trigger_radius_position = position - (0, 0, height);
	trigger_radius_height = height * 2;
	spawnflags = function_30125f88();
	if(isdefined(var_e76400c0) && isdefined(wallnormal))
	{
		var_21f4217c = (var_e76400c0 + vectorscale(wallnormal, 12)) - (0, 0, var_cbaaea69);
		var_289a74bc = spawn("trigger_radius", var_21f4217c, spawnflags, 12, var_cbaaea69);
		var_289a74bc function_4e5a1dd3(mdl_anchor);
		/#
			if(getdvarint(#"scr_draw_triggers", 0))
			{
				level thread util::drawcylinder(var_21f4217c, 12, var_cbaaea69, undefined, "", (1, 0, 0), 0.9);
			}
		#/
	}
	if(radius >= 0.04)
	{
		fireeffectarea = spawn("trigger_radius", trigger_radius_position, spawnflags, radius, trigger_radius_height);
		fireeffectarea function_4e5a1dd3(mdl_anchor);
		firesound = spawn("script_origin", fireeffectarea.origin);
		firesound playloopsound(#"hash_bdb30092e9dc406");
		level thread influencers::create_grenade_influencers((isdefined(owner) ? owner.team : undefined), weapon, fireeffectarea);
	}
	/#
		if(getdvarint(#"scr_draw_triggers", 0))
		{
			level thread util::drawcylinder(trigger_radius_position, radius, trigger_radius_height, undefined, "");
		}
	#/
	self.var_ebf0b1c9 = [];
	burntime = 0;
	var_d0603aba = 1;
	damageendtime = int(gettime() + (var_4dd46f8a.var_b79d64a9 * 1000));
	while(gettime() < damageendtime)
	{
		damageapplied = 0;
		potential_targets = self getpotentialtargets(owner, var_4dd46f8a);
		if(isdefined(owner))
		{
			owner.var_14e5c74a = [];
		}
		self thread function_124fe29c(potential_targets, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a);
		if(isdefined(owner))
		{
			var_2d3611fa = owner.var_14e5c74a.size;
			if(var_2d3611fa > 0 && burntime < gettime())
			{
				burntime = gettime() + (int(var_4dd46f8a.var_5c06ec56 * 1000));
			}
			if(isdefined(level.playgadgetsuccess) && var_d0603aba)
			{
				if(isdefined(level.var_ac6052e9))
				{
					var_9194a036 = [[level.var_ac6052e9]]("wraith_fireSuccessLineCount", 0);
				}
				if(var_2d3611fa >= (isdefined(var_9194a036) ? var_9194a036 : 3))
				{
					owner [[level.playgadgetsuccess]](weapon);
				}
			}
			if(var_d0603aba)
			{
				var_d0603aba = 0;
			}
		}
		if(is_round_reset())
		{
			break;
		}
		wait(var_4dd46f8a.var_90bd7d92);
	}
	arrayremovevalue(self.var_ebf0b1c9, undefined);
	foreach(target in self.var_ebf0b1c9)
	{
		target.var_84e41b20 = undefined;
		target status_effect::function_408158ef(level.var_ccdda8d1, level.var_40d32830);
	}
	if(isdefined(owner))
	{
		owner.var_14e5c74a = [];
	}
	if(isdefined(killcament))
	{
		killcament entityheadicons::destroyentityheadicons();
	}
	if(isdefined(mdl_anchor))
	{
		mdl_anchor delete();
	}
	if(isdefined(fireeffectarea))
	{
		fireeffectarea delete();
		firesound thread stopfiresound();
	}
	if(isdefined(var_289a74bc))
	{
		var_289a74bc delete();
	}
	/#
		if(getdvarint(#"scr_draw_triggers", 0))
		{
			level notify(#"hash_67e730c2519446");
		}
	#/
}

/*
	Name: is_round_reset
	Namespace: namespace_f8e3338e
	Checksum: 0xB6249EEB
	Offset: 0x2E08
	Size: 0x50
	Parameters: 0
	Flags: Linked, Private
*/
private function is_round_reset()
{
	if(level flag::exists("round_reset") && level flag::get("round_reset"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_30125f88
	Namespace: namespace_f8e3338e
	Checksum: 0x9F4F6285
	Offset: 0x2E60
	Size: 0x22
	Parameters: 0
	Flags: Linked, Private
*/
private function function_30125f88()
{
	if(level.friendlyfire > 0)
	{
		return 2 | 1;
	}
	return 0;
}

/*
	Name: function_124fe29c
	Namespace: namespace_f8e3338e
	Checksum: 0xFC65148B
	Offset: 0x2E90
	Size: 0x15C
	Parameters: 8
	Flags: Linked
*/
function function_124fe29c(a_targets, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a)
{
	function_e7f6e154();
	var_b54f21b2 = 0;
	foreach(target in a_targets)
	{
		if(isalive(target))
		{
			var_1956fc57 = trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a);
			if(var_1956fc57)
			{
				var_b54f21b2++;
			}
		}
		if(var_b54f21b2 >= 1)
		{
			util::wait_network_frame();
			var_b54f21b2 = 0;
		}
	}
	level.var_f9145520--;
}

/*
	Name: function_e7f6e154
	Namespace: namespace_f8e3338e
	Checksum: 0xC1B8C551
	Offset: 0x2FF8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_e7f6e154(n_count_per_network_frame = 1)
{
	while(level.var_f9145520 >= n_count_per_network_frame)
	{
		util::wait_network_frame();
	}
	level.var_f9145520++;
}

/*
	Name: stopfiresound
	Namespace: namespace_f8e3338e
	Checksum: 0x5B4DC95C
	Offset: 0x3058
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function stopfiresound()
{
	firesound = self;
	firesound stoploopsound(2);
	wait(0.5);
	if(isdefined(firesound))
	{
		firesound delete();
	}
}

/*
	Name: function_9464e4ad
	Namespace: namespace_f8e3338e
	Checksum: 0x923229B2
	Offset: 0x30B8
	Size: 0x3DC
	Parameters: 11
	Flags: Linked
*/
function function_9464e4ad(owner, position, killcament, normal, weapon, var_4dd46f8a, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, mdl_anchor)
{
	level endon(#"game_ended");
	radius = var_4dd46f8a.var_6193a41b * radius_multiplier;
	height = var_4dd46f8a.var_cbd86f3e;
	trigger_radius_position = position - (0, 0, height);
	trigger_radius_height = height * 2;
	spawnflags = function_30125f88();
	if(isdefined(var_e76400c0) && isdefined(wallnormal))
	{
		var_21f4217c = (var_e76400c0 + vectorscale(wallnormal, 12)) - (0, 0, var_cbaaea69);
		var_289a74bc = spawn("trigger_radius", var_21f4217c, spawnflags, 12, var_cbaaea69);
		var_289a74bc function_4e5a1dd3(mdl_anchor);
	}
	if(radius >= 0.04)
	{
		fireeffectarea = spawn("trigger_radius", trigger_radius_position, spawnflags, radius, trigger_radius_height);
		fireeffectarea function_4e5a1dd3(mdl_anchor);
	}
	self.var_ebf0b1c9 = [];
	damageendtime = int(gettime() + (var_4dd46f8a.var_b79d64a9 * 1000));
	while(gettime() < damageendtime)
	{
		damageapplied = 0;
		potential_targets = self weapons::function_356292be(owner, position, radius);
		self thread function_124fe29c(potential_targets, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a);
		if(is_round_reset())
		{
			break;
		}
		wait(var_4dd46f8a.var_8fbd03cb);
	}
	arrayremovevalue(self.var_ebf0b1c9, undefined);
	foreach(target in self.var_ebf0b1c9)
	{
		target.var_84e41b20 = undefined;
		target status_effect::function_408158ef(level.var_ccdda8d1, level.var_40d32830);
	}
	if(isdefined(owner))
	{
		owner globallogic_score::function_d3ca3608(#"hash_775faa6097bd0ccc");
	}
	if(isdefined(mdl_anchor))
	{
		mdl_anchor delete();
	}
	if(isdefined(fireeffectarea))
	{
		fireeffectarea delete();
	}
	if(isdefined(var_289a74bc))
	{
		var_289a74bc delete();
	}
}

/*
	Name: getpotentialtargets
	Namespace: namespace_f8e3338e
	Checksum: 0xA4691B4E
	Offset: 0x34A0
	Size: 0x33C
	Parameters: 2
	Flags: Linked
*/
function getpotentialtargets(owner, var_4dd46f8a)
{
	owner_team = (isdefined(owner) ? owner.team : undefined);
	if(level.teambased && isdefined(owner_team) && level.friendlyfire == 0)
	{
		potential_targets = [];
		foreach(team, _ in level.teams)
		{
			if(var_4dd46f8a.var_14e16318 === 1 || util::function_fbce7263(team, owner_team))
			{
				potential_targets = arraycombine(potential_targets, getplayers(team), 0, 0);
				continue;
			}
		}
		if(isdefined(var_4dd46f8a.var_4e1d1f97) && var_4dd46f8a.var_4e1d1f97)
		{
			if(!isdefined(potential_targets))
			{
				potential_targets = [];
			}
			else if(!isarray(potential_targets))
			{
				potential_targets = array(potential_targets);
			}
			if(!isinarray(potential_targets, owner))
			{
				potential_targets[potential_targets.size] = owner;
			}
		}
		return potential_targets;
	}
	all_targets = [];
	all_targets = arraycombine(all_targets, level.players, 0, 0);
	if(level.friendlyfire > 0)
	{
		return all_targets;
	}
	potential_targets = [];
	foreach(target in all_targets)
	{
		if(!isdefined(target))
		{
			continue;
		}
		if(!isdefined(target.team))
		{
			continue;
		}
		if(isdefined(owner))
		{
			if(target != owner)
			{
				if(!isdefined(owner_team))
				{
					continue;
				}
				if(!util::function_fbce7263(target.team, owner_team))
				{
					continue;
				}
			}
		}
		else if(!isdefined(self))
		{
			continue;
		}
		if(!isdefined(self.team))
		{
			continue;
		}
		if(!util::function_fbce7263(target.team, self.team))
		{
			continue;
		}
		potential_targets[potential_targets.size] = target;
	}
	return potential_targets;
}

/*
	Name: function_5a49ebd3
	Namespace: namespace_f8e3338e
	Checksum: 0x68792967
	Offset: 0x37E8
	Size: 0x160
	Parameters: 1
	Flags: None
*/
function function_5a49ebd3(team)
{
	scriptmodels = getentarray("script_model", "classname");
	var_e26b971c = [];
	foreach(scriptmodel in scriptmodels)
	{
		if(!isdefined(scriptmodel))
		{
			continue;
		}
		if(!isdefined(scriptmodel.team))
		{
			continue;
		}
		if(scriptmodel.health <= 0)
		{
			continue;
		}
		if(scriptmodel.team == team)
		{
			if(!isdefined(var_e26b971c))
			{
				var_e26b971c = [];
			}
			else if(!isarray(var_e26b971c))
			{
				var_e26b971c = array(var_e26b971c);
			}
			if(!isinarray(var_e26b971c, scriptmodel))
			{
				var_e26b971c[var_e26b971c.size] = scriptmodel;
			}
		}
	}
	return var_e26b971c;
}

/*
	Name: trytoapplyfiredamage
	Namespace: namespace_f8e3338e
	Checksum: 0xF8C65320
	Offset: 0x3950
	Size: 0x434
	Parameters: 8
	Flags: Linked
*/
function trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a)
{
	var_1956fc57 = 0;
	if(!(isdefined(fireeffectarea) || isdefined(var_289a74bc)) || is_round_reset())
	{
		return var_1956fc57;
	}
	if(isdefined(level.var_484675b5) && level.var_484675b5 && owner === target)
	{
		return var_1956fc57;
	}
	if(isdefined(level.var_edae191d) && level.var_edae191d && isplayer(target))
	{
		return var_1956fc57;
	}
	var_4c3c1b32 = 0;
	var_75046efd = 0;
	sourcepos = position;
	if(isdefined(fireeffectarea))
	{
		var_4c3c1b32 = target istouching(fireeffectarea);
		sourcepos = fireeffectarea.origin;
	}
	if(isdefined(var_289a74bc))
	{
		var_75046efd = target istouching(var_289a74bc);
		sourcepos = var_289a74bc.origin;
	}
	var_be45d685 = !(var_4c3c1b32 || var_75046efd);
	targetentnum = target getentitynumber();
	if(!var_be45d685 && (!isdefined(target.sessionstate) || target.sessionstate == "playing"))
	{
		trace = bullettrace(position, target getshootatpos(), 0, target);
		if(trace[#"fraction"] == 1)
		{
			if(isplayer(target) || (function_f99d2668() && isactor(target)))
			{
				target thread damageinfirearea(sourcepos, killcament, trace, position, weapon, var_4dd46f8a, owner);
				if(isdefined(owner) && util::function_fbce7263(target.team, owner.team))
				{
					owner.var_14e5c74a[targetentnum] = target;
				}
			}
			else
			{
				target thread function_37ddab3(sourcepos, killcament, trace, position, weapon, var_4dd46f8a, owner);
			}
			self.var_ebf0b1c9[targetentnum] = target;
			var_1956fc57 = 1;
		}
		else
		{
			var_be45d685 = 1;
		}
	}
	if(var_be45d685 && isdefined(target.var_84e41b20) && isplayer(target))
	{
		if(target.var_84e41b20.size == 0)
		{
			target.var_84e41b20 = undefined;
			target status_effect::function_408158ef(level.var_ccdda8d1, level.var_40d32830);
			self.var_ebf0b1c9[targetentnum] = undefined;
		}
		else if(isdefined(killcament))
		{
			target.var_84e41b20[killcament.starttime] = undefined;
		}
		if(isdefined(owner))
		{
			owner.var_14e5c74a[targetentnum] = undefined;
		}
	}
	return var_1956fc57;
}

/*
	Name: damageinfirearea
	Namespace: namespace_f8e3338e
	Checksum: 0xC87180FA
	Offset: 0x3D90
	Size: 0x1CC
	Parameters: 7
	Flags: Linked
*/
function damageinfirearea(origin, killcament, trace, position, weapon, var_4dd46f8a, owner)
{
	self endon(#"death");
	timer = 0;
	if(candofiredamage(killcament, self, var_4dd46f8a.var_90bd7d92))
	{
		/#
			level.var_eb1010d2 = getdvarint(#"hash_75de04766593ca0c", 0);
			if(level.var_eb1010d2)
			{
				if(!isdefined(level.incendiarydamagetime))
				{
					level.incendiarydamagetime = gettime();
				}
				iprintlnbold(level.incendiarydamagetime - gettime());
				level.incendiarydamagetime = gettime();
			}
		#/
		var_4dd4e6ee = owner;
		if(!isdefined(self.var_84e41b20))
		{
			self.var_84e41b20 = [];
		}
		if(isdefined(killcament))
		{
			self.var_84e41b20[killcament.starttime] = 1;
		}
		params = function_4d1e7b48("dot_wraith_fire");
		params.killcament = killcament;
		self status_effect::status_effect_apply(params, weapon, owner, 0, undefined, undefined, origin);
		self.var_c8b39cc6 = var_4dd4e6ee;
		self thread sndfiredamage();
	}
}

/*
	Name: function_37ddab3
	Namespace: namespace_f8e3338e
	Checksum: 0xF643314
	Offset: 0x3F68
	Size: 0x152
	Parameters: 7
	Flags: Linked
*/
function function_37ddab3(origin, killcament, trace, position, weapon, var_4dd46f8a, owner)
{
	self endon(#"death");
	timer = 0;
	if(candofiredamage(killcament, self, var_4dd46f8a.var_8fbd03cb))
	{
		var_4dd4e6ee = owner;
		if(!isdefined(self.var_84e41b20))
		{
			self.var_84e41b20 = [];
		}
		if(isdefined(killcament))
		{
			self.var_84e41b20[killcament.starttime] = 1;
		}
		var_341dfe48 = int(var_4dd46f8a.var_4931651e * var_4dd46f8a.var_8fbd03cb);
		self dodamage(var_341dfe48, self.origin, owner, weapon, "none", "MOD_BURNED", 0, weapon);
		self.var_c8b39cc6 = var_4dd4e6ee;
	}
}

/*
	Name: sndfiredamage
	Namespace: namespace_f8e3338e
	Checksum: 0xBE1A992E
	Offset: 0x40C8
	Size: 0x14E
	Parameters: 0
	Flags: Linked
*/
function sndfiredamage()
{
	self notify(#"sndfire");
	self endon(#"sndfire", #"death", #"disconnect");
	if(!isdefined(self.sndfireent))
	{
		self.sndfireent = spawn("script_origin", self.origin);
		self.sndfireent linkto(self, "tag_origin");
		self.sndfireent playsound(#"chr_burn_start");
		self thread sndfiredamage_deleteent(self.sndfireent);
	}
	self.sndfireent playloopsound(#"chr_burn_start_loop", 0.5);
	wait(3);
	if(isdefined(self.sndfireent))
	{
		self.sndfireent delete();
		self.sndfireent = undefined;
	}
}

/*
	Name: sndfiredamage_deleteent
	Namespace: namespace_f8e3338e
	Checksum: 0xAB71831A
	Offset: 0x4220
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function sndfiredamage_deleteent(ent)
{
	self waittill(#"death", #"disconnect");
	if(isdefined(ent))
	{
		ent delete();
	}
}

/*
	Name: hitpos
	Namespace: namespace_f8e3338e
	Checksum: 0x155D7EAF
	Offset: 0x4278
	Size: 0xF0
	Parameters: 3
	Flags: Linked
*/
function hitpos(start, end, color)
{
	trace = bullettrace(start, end, 0, undefined);
	/#
		level.var_eb1010d2 = getdvarint(#"hash_75de04766593ca0c", 0);
		if(level.var_eb1010d2)
		{
			debugstar(trace[#"position"], 2000, color);
		}
		thread incendiary_debug_line(start, trace[#"position"], color, 1, 80);
	#/
	return trace;
}

/*
	Name: candofiredamage
	Namespace: namespace_f8e3338e
	Checksum: 0x260EC7F5
	Offset: 0x4370
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function candofiredamage(killcament, victim, resetfiretime)
{
	if(isplayer(victim) && victim depthofplayerinwater() >= 1 && (!(isdefined(level.var_c62ed297) && level.var_c62ed297)))
	{
		return 0;
	}
	if(is_round_reset())
	{
		return 0;
	}
	entnum = victim getentitynumber();
	if(!isdefined(level.var_660293e0[entnum]))
	{
		level.var_660293e0[entnum] = 1;
		level thread resetfiredamage(entnum, resetfiretime);
		return 1;
	}
	return 0;
}

/*
	Name: resetfiredamage
	Namespace: namespace_f8e3338e
	Checksum: 0x8F1E11B7
	Offset: 0x4478
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function resetfiredamage(entnum, time)
{
	if(time > 0.05)
	{
		wait(time - 0.05);
	}
	level.var_660293e0[entnum] = undefined;
}

/*
	Name: function_85ff22aa
	Namespace: namespace_f8e3338e
	Checksum: 0x7C8334D1
	Offset: 0x44C8
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function function_85ff22aa(origin, radius, color, alpha, time)
{
	/#
		var_9f49d7d = getdvarint(#"hash_66232b46a7e21dec", 0);
		if(var_9f49d7d > 0)
		{
			if(var_9f49d7d > 1)
			{
				radius = int(radius / var_9f49d7d);
			}
			util::debug_sphere(origin, radius, color, alpha, time);
		}
	#/
}

