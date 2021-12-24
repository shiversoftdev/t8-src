// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_57f7003580bb15e0;
#using script_7bafaa95bb1b427e;
#using script_8988fdbc78d6c53;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\entityheadicons_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace molotov;

/*
	Name: function_89f2df9
	Namespace: molotov
	Checksum: 0xEB8260F3
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"molotov", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: molotov
	Checksum: 0x72855F46
	Offset: 0x218
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	params = function_4d1e7b48("dot_molotov");
	level.var_e6a4f161 = params.var_18d16a6b;
	level.var_5d450296 = params.var_67e2281d;
	level.var_e8a6b3ee = [];
	level._effect[#"hash_31b6cc906e6d0ae0"] = #"hash_6b74a0816b45e3f8";
	weaponobjects::function_e6400478(#"eq_molotov", &function_853f8cff, 1);
}

/*
	Name: function_853f8cff
	Namespace: molotov
	Checksum: 0x1487C254
	Offset: 0x2E8
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function function_853f8cff(watcher)
{
	watcher.onspawn = &function_f37c777a;
}

/*
	Name: function_f37c777a
	Namespace: molotov
	Checksum: 0x9982D291
	Offset: 0x318
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_f37c777a(watcher, player)
{
	player endon(#"death", #"disconnect");
	level endon(#"game_ended");
	player stats::function_e24eec31(self.weapon, #"used", 1);
	self thread function_1cdbb1e5(player, self.weapon);
}

/*
	Name: function_bba54dca
	Namespace: molotov
	Checksum: 0x38151815
	Offset: 0x3C0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_bba54dca()
{
	self waittill(#"death");
	waittillframeend();
	self notify(#"hash_2a125df0aca068b");
}

/*
	Name: function_1cdbb1e5
	Namespace: molotov
	Checksum: 0xF38C420F
	Offset: 0x3F8
	Size: 0x274
	Parameters: 2
	Flags: Linked
*/
function function_1cdbb1e5(owner, weapon)
{
	self endon(#"hacked", #"hash_2a125df0aca068b");
	/#
		assert(isdefined(weapon.var_4dd46f8a), "" + weapon.name);
	#/
	self thread function_bba54dca();
	team = self.team;
	var_3e7a440 = getscriptbundle(weapon.var_4dd46f8a);
	killcament = spawn("script_model", self.origin);
	killcament util::deleteaftertime(var_3e7a440.var_b79d64a9 + 5);
	killcament.starttime = gettime();
	killcament linkto(self);
	killcament setweapon(self.weapon);
	killcament killcam::store_killcam_entity_on_entity(self);
	self thread function_71c73ece();
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
			function_462c8632(owner, waitresult.position, waitresult.normal, self.var_59ba00f5, killcament, weapon, team, var_3e7a440);
		}
	}
}

/*
	Name: function_462c8632
	Namespace: molotov
	Checksum: 0xFEF75571
	Offset: 0x678
	Size: 0x8C
	Parameters: 8
	Flags: Linked
*/
function function_462c8632(owner, origin, normal, velocity, killcament, weapon, team, var_4dd46f8a)
{
	playsoundatposition("", origin);
	self thread function_e8ad1d81(origin, owner, normal, velocity, killcament, weapon, team, var_4dd46f8a);
}

/*
	Name: function_f4e48434
	Namespace: molotov
	Checksum: 0x49E5EE11
	Offset: 0x710
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_f4e48434(position)
{
	var_c84f4998 = getwaterheight(position) - position[2];
	return var_c84f4998 >= 24;
}

/*
	Name: function_a66ba8cc
	Namespace: molotov
	Checksum: 0x9B27189
	Offset: 0x760
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_a66ba8cc(var_c84f4998)
{
	return 0 < var_c84f4998 && var_c84f4998 < 24;
}

/*
	Name: function_330c2616
	Namespace: molotov
	Checksum: 0x83089DC4
	Offset: 0x790
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_330c2616(position)
{
	return getwaterheight(position) - position[2];
}

/*
	Name: function_71c73ece
	Namespace: molotov
	Checksum: 0xD9BD93D7
	Offset: 0x7C8
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function function_71c73ece()
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
	Namespace: molotov
	Checksum: 0xF8C8E4D8
	Offset: 0x850
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_7cbeb2f0(normal)
{
	if(normal[2] < 0.5)
	{
		stepoutdistance = normal * getdvarint(#"hash_72463d6fcf7cb178", 50);
	}
	else
	{
		stepoutdistance = normal * getdvarint(#"hash_1423ebf820f9483f", 12);
	}
	return stepoutdistance;
}

/*
	Name: function_e8ad1d81
	Namespace: molotov
	Checksum: 0xA0B562E4
	Offset: 0x8E8
	Size: 0x95C
	Parameters: 8
	Flags: Linked
*/
function function_e8ad1d81(position, owner, normal, velocity, killcament, weapon, team, var_4dd46f8a)
{
	var_4f9d7296 = position;
	var_493d36f9 = normal;
	var_77261b6 = vectornormalize(velocity);
	var_1f254a06 = vectorscale(var_77261b6, -1);
	var_d6d43109 = 1;
	var_e76400c0 = undefined;
	wallnormal = undefined;
	var_693f108f = undefined;
	var_aecaaa11 = getweapon(#"hash_23dd6039fe2f36c6");
	var_5632b17 = getweapon("molotov_fire_wall");
	var_7bf146f2 = getweapon("molotov_steam");
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
			var_1f254a06 = normal;
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
					level thread function_42b9fdbe(var_7bf146f2, newpos, (0, 0, 1), int(var_4dd46f8a.var_b79d64a9), team);
					break;
				}
				level thread function_42b9fdbe(var_5632b17, newpos, wall_normal, int(var_4dd46f8a.var_b79d64a9), team);
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
	function_1493c734(startpos, 20, (0, 1, 0), 0.6, 200);
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
			spawntimedfx(var_5632b17, traceposition, var_252a0dc7, int(var_4dd46f8a.var_b79d64a9), team);
		}
	}
	var_1f254a06 = normal;
	level function_8a03d3f3(owner, position, startpos, var_1f254a06, var_d6d43109, rotation, killcament, weapon, var_4dd46f8a, team, var_e76400c0, wallnormal, var_693f108f);
}

/*
	Name: function_523961e2
	Namespace: molotov
	Checksum: 0xE542A424
	Offset: 0x1250
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
	Name: function_31cc6bd9
	Namespace: molotov
	Checksum: 0x2BCA9E1E
	Offset: 0x12F0
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_31cc6bd9()
{
	if(!isdefined(level.var_a88ac760))
	{
		return;
	}
	keys = getarraykeys(level.var_a88ac760);
	time = gettime();
	foreach(key in keys)
	{
		if(level.var_a88ac760[key].var_46ee5246 < time)
		{
			level.var_a88ac760[key] = undefined;
		}
	}
}

/*
	Name: function_31f342a2
	Namespace: molotov
	Checksum: 0x6C2D898F
	Offset: 0x13D0
	Size: 0xF6
	Parameters: 2
	Flags: Linked
*/
function function_31f342a2(origin, var_9c7e3678)
{
	if(!isdefined(level.var_a88ac760))
	{
		return 0;
	}
	foreach(molotov in level.var_a88ac760)
	{
		if(abs((molotov.origin[2] - origin[2]) > 20))
		{
			continue;
		}
		if(distance2dsquared(molotov.origin, origin) < var_9c7e3678)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_8a03d3f3
	Namespace: molotov
	Checksum: 0xB4DBD043
	Offset: 0x14D0
	Size: 0xFA8
	Parameters: 13
	Flags: Linked
*/
function function_8a03d3f3(owner, impactpos, startpos, normal, multiplier, rotation, killcament, weapon, var_4dd46f8a, team, var_e76400c0, wallnormal, var_693f108f)
{
	defaultdistance = var_4dd46f8a.var_6193a41b * multiplier;
	defaultdropdistance = getdvarint(#"hash_4a8fc6d7cacea9d5", 90);
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
	function_31cc6bd9();
	if(function_31f342a2(startpos, (var_4dd46f8a.var_6193a41b * 1.5) * (var_4dd46f8a.var_6193a41b * 1.5)) && fxcount > 10)
	{
		fxcount = 7;
	}
	var_4997e17c = perpendicularvector(normal);
	for(fxindex = 0; fxindex < fxcount; fxindex++)
	{
		locations[#"point"][fxindex] = function_523961e2(startpos, normal, var_4997e17c, fxindex, fxcount, defaultdistance, rotation);
		function_1493c734(locations[#"point"][fxindex], 10, (0, fxindex * 20, 0), 0.6, 200);
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
			function_1493c734(traceposition, 10, (1, 0, 0), 0.6, 200);
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
				function_1493c734(var_e5d1793d[#"position"], 10, (0, 0, 1), 0.6, 200);
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
				function_1493c734(var_9417df90[#"position"], 10, (0, 0, 1), 0.6, 200);
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
	var_aecaaa11 = getweapon(#"hash_23dd6039fe2f36c6");
	var_3cbce009 = getweapon("molotov_fire_tall");
	var_4a1b9411 = getweapon("molotov_fire_small");
	var_7bf146f2 = getweapon("molotov_steam");
	var_6b23e1c9 = impactpos + (normal * 1.5);
	forward = (1, 0, 0);
	if(abs(vectordot(forward, normal)) > 0.999)
	{
		forward = (0, 0, 1);
	}
	if(!function_f4e48434(var_6b23e1c9))
	{
		playfx(level._effect[#"hash_31b6cc906e6d0ae0"], var_6b23e1c9, forward, normal, 0, team);
		if(!isdefined(var_e76400c0))
		{
			spawntimedfx(var_aecaaa11, var_6b23e1c9, normal, int(var_4dd46f8a.var_b79d64a9), team);
		}
	}
	if(level.gameended)
	{
		return;
	}
	if(!isdefined(level.var_801fd65e))
	{
		level.var_801fd65e = 0;
	}
	if(!isdefined(level.var_a88ac760))
	{
		level.var_a88ac760 = [];
	}
	var_bf264593 = level.var_a88ac760.size;
	level.var_a88ac760[var_bf264593] = {};
	var_4b424bc1 = level.var_a88ac760[var_bf264593];
	var_4b424bc1.var_46ee5246 = int(gettime() + (var_4dd46f8a.var_b79d64a9 * 1000));
	var_4b424bc1.origin = startpos;
	thread damageeffectarea(owner, startpos, killcament, normal, var_aecaaa11, var_4dd46f8a, multiplier, var_e76400c0, wallnormal, var_693f108f, var_4b424bc1.var_46ee5246);
	thread function_9464e4ad(owner, startpos, killcament, normal, var_aecaaa11, var_4dd46f8a, multiplier, var_e76400c0, wallnormal, var_693f108f, var_4b424bc1.var_46ee5246);
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
		if(isdefined(locations[#"hash_7852e39f75c4b5c0"][var_7ee5c69b]))
		{
			fireweapon = var_4a1b9411;
		}
		else if(isdefined(locations[#"steam"][var_7ee5c69b]))
		{
			fireweapon = var_7bf146f2;
		}
		else
		{
			fireweapon = (isdefined(locations[#"hash_33059ac06a23beca"][var_7ee5c69b]) ? var_3cbce009 : var_aecaaa11);
		}
		level thread function_42b9fdbe(fireweapon, locations[#"loc"][var_7ee5c69b], locations[#"normal"][var_7ee5c69b], int(var_4dd46f8a.var_b79d64a9), team);
	}
}

/*
	Name: function_42b9fdbe
	Namespace: molotov
	Checksum: 0x8EFF178F
	Offset: 0x2480
	Size: 0x84
	Parameters: 5
	Flags: Linked
*/
function function_42b9fdbe(weapon, loc, normal, duration, team)
{
	fxnormal = normal;
	wait(randomfloatrange(0, 0.5));
	spawntimedfx(weapon, loc, fxnormal, duration, team);
}

/*
	Name: incendiary_debug_line
	Namespace: molotov
	Checksum: 0x72D5C657
	Offset: 0x2510
	Size: 0xB4
	Parameters: 5
	Flags: None
*/
function incendiary_debug_line(from, to, color, depthtest, time)
{
	/#
		debug_rcbomb = getdvarint(#"hash_4eff71fc5bf5542a", 0);
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
	Namespace: molotov
	Checksum: 0xF49B8DC2
	Offset: 0x25D0
	Size: 0x6C0
	Parameters: 11
	Flags: Linked
*/
function damageeffectarea(owner, position, killcament, normal, weapon, var_4dd46f8a, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, damageendtime)
{
	level endon(#"game_ended");
	radius = var_4dd46f8a.var_6193a41b * radius_multiplier;
	height = var_4dd46f8a.var_cbd86f3e;
	trigger_radius_position = position - (0, 0, height);
	trigger_radius_height = height * 2;
	if(isdefined(var_e76400c0) && isdefined(wallnormal))
	{
		var_21f4217c = (var_e76400c0 + vectorscale(wallnormal, 12)) - (0, 0, var_cbaaea69);
		var_289a74bc = spawn("trigger_radius", var_21f4217c, 0, 12, var_cbaaea69);
		/#
			if(getdvarint(#"scr_draw_triggers", 0))
			{
				level thread util::drawcylinder(var_21f4217c, 12, var_cbaaea69, undefined, "", (1, 0, 0), 0.9);
			}
		#/
	}
	if(radius >= 0.04)
	{
		fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
		firesound = spawn("script_origin", fireeffectarea.origin);
		if(isdefined(firesound))
		{
			firesound playloopsound(#"hash_d2a83cecbfbd9e2");
		}
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
	originalteam = (isdefined(owner) ? owner.team : undefined);
	while(gettime() < damageendtime && (!isdefined(owner) || owner.team == originalteam))
	{
		damageapplied = 0;
		potential_targets = self getpotentialtargets(owner, var_4dd46f8a);
		if(isdefined(owner))
		{
			owner.var_52dceca = [];
		}
		foreach(target in potential_targets)
		{
			self trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a);
		}
		if(isdefined(owner))
		{
			var_2d3611fa = owner.var_52dceca.size;
			if(var_2d3611fa > 0 && burntime < gettime())
			{
				scoreevents::processscoreevent(#"hash_1343f5418bd52c6c", owner, undefined, weapon, var_2d3611fa);
				burntime = gettime() + (int(var_4dd46f8a.var_5c06ec56 * 1000));
			}
			if(isdefined(level.playgadgetsuccess) && var_d0603aba)
			{
				if(isdefined(level.var_ac6052e9))
				{
					var_9194a036 = [[level.var_ac6052e9]]("molotovSuccessLineCount", 0);
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
		wait(var_4dd46f8a.var_90bd7d92);
	}
	arrayremovevalue(self.var_ebf0b1c9, undefined);
	foreach(target in self.var_ebf0b1c9)
	{
		target.var_84e41b20 = undefined;
		target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
	}
	if(isdefined(owner))
	{
		owner.var_52dceca = [];
	}
	if(isdefined(killcament))
	{
		killcament entityheadicons::destroyentityheadicons();
	}
	if(isdefined(fireeffectarea))
	{
		fireeffectarea delete();
		if(isdefined(firesound))
		{
			firesound thread stopfiresound();
		}
	}
	if(isdefined(var_289a74bc))
	{
		var_289a74bc delete();
	}
	/#
		if(getdvarint(#"scr_draw_triggers", 0))
		{
			level notify(#"hash_33d328e380ab0acc");
		}
	#/
}

/*
	Name: stopfiresound
	Namespace: molotov
	Checksum: 0x459200D2
	Offset: 0x2C98
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
	Namespace: molotov
	Checksum: 0x89C2716E
	Offset: 0x2CF8
	Size: 0x384
	Parameters: 11
	Flags: Linked
*/
function function_9464e4ad(owner, position, killcament, normal, weapon, var_4dd46f8a, radius_multiplier, var_e76400c0, wallnormal, var_cbaaea69, damageendtime)
{
	level endon(#"game_ended");
	radius = var_4dd46f8a.var_6193a41b * radius_multiplier;
	height = var_4dd46f8a.var_cbd86f3e;
	trigger_radius_position = position - (0, 0, height);
	trigger_radius_height = height * 2;
	if(isdefined(var_e76400c0) && isdefined(wallnormal))
	{
		var_21f4217c = (var_e76400c0 + vectorscale(wallnormal, 12)) - (0, 0, var_cbaaea69);
		var_289a74bc = spawn("trigger_radius", var_21f4217c, 0, 12, var_cbaaea69);
	}
	if(radius >= 0.04)
	{
		fireeffectarea = spawn("trigger_radius", trigger_radius_position, 0, radius, trigger_radius_height);
	}
	self.var_ebf0b1c9 = [];
	while(gettime() < damageendtime)
	{
		damageapplied = 0;
		potential_targets = self weapons::function_356292be(owner, position, radius);
		foreach(target in potential_targets)
		{
			self trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a);
		}
		wait(var_4dd46f8a.var_8fbd03cb);
	}
	arrayremovevalue(self.var_ebf0b1c9, undefined);
	foreach(target in self.var_ebf0b1c9)
	{
		target.var_84e41b20 = undefined;
		target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
	}
	if(isdefined(owner))
	{
		owner globallogic_score::function_d3ca3608(#"hash_468ad9ee571cf1c6");
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
	Namespace: molotov
	Checksum: 0xD79BE6E5
	Offset: 0x3088
	Size: 0x364
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
	all_targets = arraycombine(all_targets, getaiarray(), 0, 0);
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
	Namespace: molotov
	Checksum: 0xBDF3846B
	Offset: 0x33F8
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
	Namespace: molotov
	Checksum: 0x3F85864C
	Offset: 0x3560
	Size: 0x350
	Parameters: 8
	Flags: Linked
*/
function trytoapplyfiredamage(target, owner, position, fireeffectarea, var_289a74bc, killcament, weapon, var_4dd46f8a)
{
	if(!(isdefined(fireeffectarea) || isdefined(var_289a74bc)))
	{
		return;
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
			if(isplayer(target))
			{
				target thread damageinfirearea(sourcepos, killcament, trace, position, weapon, var_4dd46f8a, owner);
				if(isdefined(owner) && util::function_fbce7263(target.team, owner.team))
				{
					owner.var_52dceca[targetentnum] = target;
				}
			}
			else
			{
				target thread function_37ddab3(sourcepos, killcament, trace, position, weapon, var_4dd46f8a, owner);
			}
			self.var_ebf0b1c9[targetentnum] = target;
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
			target status_effect::function_408158ef(level.var_5d450296, level.var_e6a4f161);
			self.var_ebf0b1c9[targetentnum] = undefined;
		}
		else if(isdefined(killcament))
		{
			target.var_84e41b20[killcament.starttime] = undefined;
		}
		if(isdefined(owner))
		{
			owner.var_52dceca[targetentnum] = undefined;
		}
	}
}

/*
	Name: damageinfirearea
	Namespace: molotov
	Checksum: 0x877AA08B
	Offset: 0x38B8
	Size: 0x1DC
	Parameters: 7
	Flags: Linked
*/
function damageinfirearea(origin, killcament, trace, position, weapon, var_4dd46f8a, owner)
{
	self endon(#"disconnect", #"death");
	timer = 0;
	if(candofiredamage(killcament, self, var_4dd46f8a.var_90bd7d92))
	{
		/#
			level.var_de532e7f = getdvarint(#"hash_4eff71fc5bf5542a", 0);
			if(level.var_de532e7f)
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
		params = function_4d1e7b48("dot_molotov");
		params.killcament = killcament;
		self status_effect::status_effect_apply(params, weapon, owner, 0, undefined, undefined, origin);
		self.var_ae639436 = var_4dd4e6ee;
		self thread sndfiredamage();
	}
}

/*
	Name: function_37ddab3
	Namespace: molotov
	Checksum: 0xC06182FA
	Offset: 0x3AA0
	Size: 0x162
	Parameters: 7
	Flags: Linked
*/
function function_37ddab3(origin, killcament, trace, position, weapon, var_4dd46f8a, owner)
{
	self endon(#"disconnect", #"death");
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
		self.var_ae639436 = var_4dd4e6ee;
	}
}

/*
	Name: sndfiredamage
	Namespace: molotov
	Checksum: 0xBA1B4524
	Offset: 0x3C10
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
	Namespace: molotov
	Checksum: 0xCC6A57B2
	Offset: 0x3D68
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
	Namespace: molotov
	Checksum: 0xD3E0FD6C
	Offset: 0x3DC0
	Size: 0xF0
	Parameters: 3
	Flags: Linked
*/
function hitpos(start, end, color)
{
	trace = bullettrace(start, end, 0, undefined);
	/#
		level.var_de532e7f = getdvarint(#"hash_4eff71fc5bf5542a", 0);
		if(level.var_de532e7f)
		{
			debugstar(trace[#"position"], 2000, color);
		}
		thread incendiary_debug_line(start, trace[#"position"], color, 1, 80);
	#/
	return trace;
}

/*
	Name: candofiredamage
	Namespace: molotov
	Checksum: 0xFFEF4ADF
	Offset: 0x3EB8
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function candofiredamage(killcament, victim, resetfiretime)
{
	if(isplayer(victim) && victim depthofplayerinwater() >= 1)
	{
		return 0;
	}
	entnum = victim getentitynumber();
	if(!isdefined(level.var_e8a6b3ee[entnum]))
	{
		level.var_e8a6b3ee[entnum] = 1;
		level thread resetfiredamage(entnum, resetfiretime);
		return 1;
	}
	return 0;
}

/*
	Name: resetfiredamage
	Namespace: molotov
	Checksum: 0xC71B4EDC
	Offset: 0x3F88
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
	level.var_e8a6b3ee[entnum] = undefined;
}

/*
	Name: function_1493c734
	Namespace: molotov
	Checksum: 0x18D818C1
	Offset: 0x3FD8
	Size: 0xB4
	Parameters: 5
	Flags: Linked
*/
function function_1493c734(origin, radius, color, alpha, time)
{
	/#
		var_9f49d7d = getdvarint(#"hash_58042b6209e0c2a6", 0);
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

