// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28212a1c4376c358;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace smart_cover;

/*
	Name: init_shared
	Namespace: smart_cover
	Checksum: 0x78D3D525
	Offset: 0x240
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	callback::on_localplayer_spawned(&on_local_player_spawned);
	clientfield::register("scriptmover", "smartcover_placed", 1, 5, "float", &smartcover_placed, 0, 0);
	clientfield::register("clientuimodel", "hudItems.smartCoverState", 1, 1, "int", undefined, 0, 0);
	clientfield::register("scriptmover", "start_smartcover_microwave", 1, 1, "int", &function_f80b166e, 0, 0);
	level.var_5101157d = spawnstruct();
	level.var_5101157d.previewmodels = [];
	level.var_5101157d.var_aef370a9 = [];
	level.var_5101157d.weapon = getweapon(#"ability_smart_cover");
	deployable::function_2e088f73(level.var_5101157d.weapon, 1);
	if(sessionmodeismultiplayergame())
	{
		level.var_5101157d.bundle = getscriptbundle(#"hash_25c242b3e86ced05");
	}
	else if(function_f99d2668())
	{
		level.var_5101157d.bundle = getscriptbundle(#"hash_25e448b3e889dd9d");
	}
	else if(sessionmodeiscampaigngame())
	{
		level.var_5101157d.bundle = getscriptbundle(#"hash_25a046b3e8500d6b");
	}
	function_8434338d();
}

/*
	Name: function_8434338d
	Namespace: smart_cover
	Checksum: 0x219A8E38
	Offset: 0x4B0
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_8434338d()
{
	setdvar(#"hash_25f7092e7c7b66f2", 0);
	setdvar(#"hash_4332205cbf1cc384", 0);
	setdvar(#"hash_6e04e8c9b344f745", 1000);
	setdvar(#"hash_436fc2fad44e9041", 1);
	setdvar(#"hash_1d8eb304f5cf8033", 1);
	setdvar(#"hash_4c7f3e5c0af7fdc0", level.var_5101157d.bundle.var_1f0ae388);
	setdvar(#"hash_13c23fd3a4387b84", 8);
	setdvar(#"hash_55a8dba3350b8b7c", 4);
	setdvar(#"hash_4f4ce3cb18b004bc", 10);
	setdvar(#"hash_417afa70d515fba5", (isdefined(level.var_5101157d.bundle.var_76d79155) ? level.var_5101157d.bundle.var_76d79155 : 0));
	setdvar(#"hash_71f8bd4cd30de4b3", (isdefined(level.var_5101157d.bundle.var_e35fc674) ? level.var_5101157d.bundle.var_e35fc674 : 0));
	setdvar(#"hash_39a564d4801c4b2e", (isdefined(level.var_5101157d.bundle.var_1f0ae388) ? level.var_5101157d.bundle.var_1f0ae388 : 0));
}

/*
	Name: function_f80b166e
	Namespace: smart_cover
	Checksum: 0x7BC02CC0
	Offset: 0x748
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function function_f80b166e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.var_5101157d.bundle.var_f4e0e7d7) && level.var_5101157d.bundle.var_f4e0e7d7 && newval == 1)
	{
		self thread startmicrowavefx(localclientnum);
	}
	else if(newval == 0)
	{
		self notify(#"beam_stop");
	}
}

/*
	Name: smartcover_placed
	Namespace: smart_cover
	Checksum: 0x4570B1F3
	Offset: 0x818
	Size: 0x19C
	Parameters: 7
	Flags: Linked
*/
function smartcover_placed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(!isdefined(level.var_5101157d.bundle.deployanim))
	{
		return;
	}
	self useanimtree("generic");
	if(newval == 1)
	{
		self setanimrestart(level.var_5101157d.bundle.deployanim, 1, 0, 1);
	}
	else if(bwastimejump)
	{
		var_e72a224a = self getanimtime(level.var_5101157d.bundle.deployanim);
		var_f56117a2 = 1 - newval;
		if(var_f56117a2 < var_e72a224a)
		{
			self setanimtime(level.var_5101157d.bundle.deployanim, var_f56117a2);
		}
	}
}

/*
	Name: function_112e3e89
	Namespace: smart_cover
	Checksum: 0xACA90D1B
	Offset: 0x9C0
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_112e3e89(localclientnum)
{
	if(!isdefined(level.var_5101157d.previewmodels[localclientnum]))
	{
		return;
	}
	foreach(var_688ed1a6 in level.var_5101157d.previewmodels[localclientnum])
	{
		var_688ed1a6 hide();
	}
}

/*
	Name: function_fd04d5d5
	Namespace: smart_cover
	Checksum: 0xD5AFD0F6
	Offset: 0xA78
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function function_fd04d5d5(localclientnum)
{
	player = self;
	player function_112e3e89(localclientnum);
	level.var_5101157d.var_aef370a9[localclientnum] = 0;
}

/*
	Name: function_1c2930c7
	Namespace: smart_cover
	Checksum: 0x122AF5E9
	Offset: 0xAD0
	Size: 0x328
	Parameters: 1
	Flags: None
*/
function function_1c2930c7(localclientnum)
{
	player = function_5c10bd79(localclientnum);
	player notify(#"hash_5c7dbac0591cb11f");
	player endon(#"hash_5c7dbac0591cb11f", #"game_ended");
	level endon(#"game_ended");
	level.var_5101157d.var_aef370a9[localclientnum] = 1;
	function_722fc669(localclientnum);
	var_ccfe777 = 0;
	while(true)
	{
		waitframe(1);
		player = function_5c10bd79(localclientnum);
		if(!isdefined(player))
		{
			break;
		}
		var_b43e8dc2 = player function_287dcf4b(level.var_5101157d.bundle.var_63aab046, level.var_5101157d.bundle.maxwidth, 1, 1, level.var_5101157d.var_8d86ade8);
		if(!isdefined(var_b43e8dc2) && !var_ccfe777)
		{
			var_ccfe777 = 1;
			player function_112e3e89(localclientnum);
			player function_bf191832(0, (0, 0, 0), (0, 0, 0));
			continue;
		}
		else if(isdefined(var_b43e8dc2) && var_ccfe777)
		{
			var_ccfe777 = 0;
		}
		else if(!isdefined(var_b43e8dc2))
		{
			player function_bf191832(0, (0, 0, 0), (0, 0, 0));
			continue;
		}
		if((isdefined(level.var_5101157d.bundle.var_8fa9aac4) ? level.var_5101157d.bundle.var_8fa9aac4 : 0))
		{
			if(var_b43e8dc2.var_bf9ca9b0)
			{
				var_688ed1a6 = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 0, 1);
			}
			else
			{
				var_688ed1a6 = player function_8fb44aff(localclientnum, var_b43e8dc2.origin, var_b43e8dc2.angles, var_b43e8dc2.isvalid, 2, 3);
				var_688ed1a6 function_dbaf4647(localclientnum);
				var_688ed1a6 function_5a8becdc(localclientnum, player, var_b43e8dc2, 1);
			}
		}
	}
}

/*
	Name: function_59605cb
	Namespace: smart_cover
	Checksum: 0xEEC8FCE6
	Offset: 0xE00
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_59605cb(localclientnum)
{
	player = self;
	player notify(#"hash_5c7dbac0591cb11f");
	player function_fd04d5d5(localclientnum);
}

/*
	Name: function_17d973ec
	Namespace: smart_cover
	Checksum: 0x774ECDF6
	Offset: 0xE58
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function function_17d973ec(localclientnum)
{
	player = function_5c10bd79(localclientnum);
	player notify(#"hash_5c39bdc22418d792");
	player endon(#"hash_5c39bdc22418d792");
	if(!isdefined(player.smartcover))
	{
		player.smartcover = spawnstruct();
	}
}

/*
	Name: function_5d802b86
	Namespace: smart_cover
	Checksum: 0x714A013A
	Offset: 0xEE0
	Size: 0x78
	Parameters: 1
	Flags: None
*/
function function_5d802b86(localclientnum)
{
	player = self;
	player endon(#"disconnect");
	player waittill(#"death");
	player function_59605cb(localclientnum);
	player notify(#"hash_5c39bdc22418d792");
}

/*
	Name: on_local_player_spawned
	Namespace: smart_cover
	Checksum: 0x93A55C8B
	Offset: 0xF60
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_local_player_spawned(localclientnum)
{
}

/*
	Name: function_641491ac
	Namespace: smart_cover
	Checksum: 0x119AA0DE
	Offset: 0xF78
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function function_641491ac(localclientnum, modelname)
{
	var_688ed1a6 = spawn(localclientnum, (0, 0, 0), "script_model");
	var_688ed1a6 setmodel(modelname);
	var_688ed1a6 hide();
	var_688ed1a6 notsolid();
	return var_688ed1a6;
}

/*
	Name: function_722fc669
	Namespace: smart_cover
	Checksum: 0x4A346657
	Offset: 0x1008
	Size: 0x178
	Parameters: 1
	Flags: Linked
*/
function function_722fc669(localclientnum)
{
	player = self;
	if(isdefined(level.var_5101157d.previewmodels[localclientnum]))
	{
		return;
	}
	level.var_5101157d.previewmodels[localclientnum] = [];
	level.var_5101157d.previewmodels[localclientnum][0] = function_641491ac(localclientnum, level.var_5101157d.bundle.placementmodel);
	level.var_5101157d.previewmodels[localclientnum][1] = function_641491ac(localclientnum, level.var_5101157d.bundle.var_46732914);
	level.var_5101157d.previewmodels[localclientnum][2] = function_641491ac(localclientnum, level.var_5101157d.bundle.var_1b5c037d);
	level.var_5101157d.previewmodels[localclientnum][3] = function_641491ac(localclientnum, level.var_5101157d.bundle.var_76ac23f2);
}

/*
	Name: function_8fb44aff
	Namespace: smart_cover
	Checksum: 0x790DCB58
	Offset: 0x1188
	Size: 0x1B2
	Parameters: 6
	Flags: Linked
*/
function function_8fb44aff(localclientnum, origin, angles, isvalid, var_eb65925c, var_4b3e5e0a)
{
	player = self;
	var_688ed1a6 = undefined;
	var_80f43370 = undefined;
	var_ff5a387e = (isvalid ? var_eb65925c : var_4b3e5e0a);
	for(var_a6932c26 = 0; var_a6932c26 < level.var_5101157d.previewmodels[localclientnum].size; var_a6932c26++)
	{
		if(var_a6932c26 == var_ff5a387e)
		{
			continue;
		}
		level.var_5101157d.previewmodels[localclientnum][var_a6932c26] hide();
	}
	level.var_5101157d.previewmodels[localclientnum][var_ff5a387e].origin = origin;
	level.var_5101157d.previewmodels[localclientnum][var_ff5a387e].angles = angles;
	level.var_5101157d.previewmodels[localclientnum][var_ff5a387e] show();
	player function_bf191832(0, origin, angles);
	return level.var_5101157d.previewmodels[localclientnum][var_ff5a387e];
}

/*
	Name: function_d66a0190
	Namespace: smart_cover
	Checksum: 0x2D590EC
	Offset: 0x1348
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function function_d66a0190(row, column)
{
	var_c21dfa9e = row * level.var_5101157d.bundle.var_f0b4da50 + column;
	if(var_c21dfa9e < 10)
	{
		return "joint_0" + var_c21dfa9e;
	}
	return "joint_" + var_c21dfa9e;
}

/*
	Name: function_dbaf4647
	Namespace: smart_cover
	Checksum: 0x77D40342
	Offset: 0x13C0
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_dbaf4647(localclientnum)
{
	smartcover = self;
	for(rowindex = 0; rowindex < level.var_5101157d.bundle.var_f0b4da50; rowindex++)
	{
		for(colindex = 1; colindex <= level.var_5101157d.bundle.var_b118698f; colindex++)
		{
			var_c4027b0a = function_d66a0190(rowindex, colindex);
			smartcover showpart(localclientnum, var_c4027b0a);
		}
	}
}

/*
	Name: function_5a8becdc
	Namespace: smart_cover
	Checksum: 0x11B80931
	Offset: 0x1498
	Size: 0x478
	Parameters: 4
	Flags: Linked
*/
function function_5a8becdc(localclientnum, player, var_7daa4df9, var_4b1c8937)
{
	smartcover = self;
	var_59cc3b18 = level.var_5101157d.bundle.maxheight / level.var_5101157d.bundle.var_f0b4da50;
	var_6d7689d4 = level.var_5101157d.bundle.maxwidth / level.var_5101157d.bundle.var_b118698f;
	var_b963136f = int(var_7daa4df9.width / var_6d7689d4);
	var_227adab7 = var_7daa4df9.width - var_6d7689d4 * var_b963136f;
	if(var_227adab7 > 0 && var_227adab7 / 2 < level.var_5101157d.bundle.var_3dfbdbeb && var_b963136f + 2 <= level.var_5101157d.bundle.var_b118698f)
	{
		var_b963136f = var_b963136f + 2;
	}
	var_9de92bd5 = int(var_7daa4df9.height / var_59cc3b18);
	var_2582dbd = var_7daa4df9.height - var_59cc3b18 * var_9de92bd5;
	if(var_2582dbd > 0 && var_2582dbd < level.var_5101157d.bundle.var_3dfbdbeb && var_2582dbd < level.var_5101157d.bundle.var_f0b4da50)
	{
		var_9de92bd5++;
	}
	var_5e91d5a8 = [];
	var_e465f403 = level.var_5101157d.bundle.var_f0b4da50 - var_9de92bd5;
	for(rowindex = 0; rowindex < var_e465f403; rowindex++)
	{
		rownum = level.var_5101157d.bundle.var_f0b4da50 - rowindex - 1;
		for(colindex = 1; colindex < level.var_5101157d.bundle.var_b118698f; colindex++)
		{
			var_c4027b0a = function_d66a0190(rownum, colindex);
			smartcover hidepart(localclientnum, var_c4027b0a);
		}
	}
	var_f636c423 = level.var_5101157d.bundle.var_b118698f - var_b963136f;
	for(var_688bc60 = 0; var_688bc60 < int(var_f636c423 / 2); var_688bc60++)
	{
		cola = var_688bc60 + 1;
		var_b2d5a637 = level.var_5101157d.bundle.var_b118698f - var_688bc60;
		for(rowindex = 0; rowindex < level.var_5101157d.bundle.var_f0b4da50; rowindex++)
		{
			var_e5b19696 = function_d66a0190(rowindex, cola);
			var_1ffc0b2e = function_d66a0190(rowindex, var_b2d5a637);
			smartcover hidepart(localclientnum, var_e5b19696);
			smartcover hidepart(localclientnum, var_1ffc0b2e);
		}
	}
}

/*
	Name: debug_trace
	Namespace: smart_cover
	Checksum: 0x30FC85C7
	Offset: 0x1918
	Size: 0xEC
	Parameters: 2
	Flags: None
*/
function debug_trace(origin, trace)
{
	/#
		if(trace[#"fraction"] < 1)
		{
			color = (0.95, 0.05, 0.05);
		}
		else
		{
			color = (0.05, 0.95, 0.05);
		}
		sphere(trace[#"position"], 5, color, 0.75, 1, 10, 100);
		util::debug_line(origin, trace[#"position"], color, 100);
	#/
}

/*
	Name: startmicrowavefx
	Namespace: smart_cover
	Checksum: 0x6DDEADFE
	Offset: 0x1A10
	Size: 0x508
	Parameters: 1
	Flags: Linked
*/
function startmicrowavefx(localclientnum)
{
	turret = self;
	turret endon(#"death");
	turret endon(#"beam_stop");
	turret.should_update_fx = 1;
	angles = turret.angles;
	origin = turret.origin + vectorscale((0, 0, 1), 30);
	microwavefxent = spawn(localclientnum, origin, "script_model");
	microwavefxent setmodel(#"tag_microwavefx");
	microwavefxent.angles = angles;
	microwavefxent.fxhandles = [];
	microwavefxent.fxnames = [];
	microwavefxent.fxhashs = [];
	self thread cleanupfx(localclientnum, microwavefxent);
	wait(0.3);
	while(true)
	{
		/#
			if(getdvarint(#"hash_93503b23ed2be27", 0))
			{
				turret.should_update_fx = 1;
				microwavefxent.fxhashs[#"center"] = 0;
			}
		#/
		if(turret.should_update_fx == 0)
		{
			wait(1);
			continue;
		}
		if(isdefined(level.last_microwave_turret_fx_trace) && level.last_microwave_turret_fx_trace == gettime())
		{
			waitframe(1);
			continue;
		}
		angles = turret.angles;
		origin = turret.origin + vectorscale((0, 0, 1), 30);
		forward = anglestoforward(angles);
		forward = vectorscale(forward, (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0) + 40);
		var_e2e9fefa = anglestoforward(angles + (0, 55 / 3, 0));
		var_e2e9fefa = vectorscale(var_e2e9fefa, (isdefined(level.var_5101157d.bundle.var_b345c668) ? level.var_5101157d.bundle.var_b345c668 : 0) + 40);
		trace = bullettrace(origin, origin + forward, 0, turret);
		traceright = bullettrace(origin, origin - var_e2e9fefa, 0, turret);
		traceleft = bullettrace(origin, origin + var_e2e9fefa, 0, turret);
		/#
			if(getdvarint(#"hash_93503b23ed2be27", 0))
			{
				debug_trace(origin, trace);
				debug_trace(origin, traceright);
				debug_trace(origin, traceleft);
			}
		#/
		need_to_rebuild = microwavefxent microwavefxhash(trace, origin, "center");
		need_to_rebuild = need_to_rebuild | microwavefxent microwavefxhash(traceright, origin, "right");
		need_to_rebuild = need_to_rebuild | microwavefxent microwavefxhash(traceleft, origin, "left");
		level.last_microwave_turret_fx_trace = gettime();
		if(!need_to_rebuild)
		{
			wait(1);
			continue;
		}
		wait(0.1);
		microwavefxent playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, turret.team);
		turret.should_update_fx = 0;
		wait(1);
	}
}

/*
	Name: microwavefxhash
	Namespace: smart_cover
	Checksum: 0x4DF9581
	Offset: 0x1F20
	Size: 0x1A8
	Parameters: 3
	Flags: Linked
*/
function microwavefxhash(trace, origin, name)
{
	hash = 0;
	counter = 2;
	for(i = 0; i < 5; i++)
	{
		endofhalffxsq = i * 150 + 125 * i * 150 + 125;
		endoffullfxsq = i * 150 + 200 * i * 150 + 200;
		tracedistsq = distancesquared(origin, trace[#"position"]);
		if(tracedistsq >= endofhalffxsq || i == 0)
		{
			if(tracedistsq < endoffullfxsq)
			{
				hash = hash + 1;
			}
			else
			{
				hash = hash + counter;
			}
		}
		counter = counter * 2;
	}
	if(!isdefined(self.fxhashs[name]))
	{
		self.fxhashs[name] = 0;
	}
	last_hash = self.fxhashs[name];
	self.fxhashs[name] = hash;
	return last_hash != hash;
}

/*
	Name: cleanupfx
	Namespace: smart_cover
	Checksum: 0xB4C05205
	Offset: 0x20D0
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function cleanupfx(localclientnum, microwavefxent)
{
	self waittill(#"death", #"beam_stop");
	foreach(handle in microwavefxent.fxhandles)
	{
		if(isdefined(handle))
		{
			stopfx(localclientnum, handle);
		}
	}
	microwavefxent delete();
}

/*
	Name: play_fx_on_tag
	Namespace: smart_cover
	Checksum: 0x6E53822B
	Offset: 0x21B0
	Size: 0xDC
	Parameters: 4
	Flags: Linked
*/
function play_fx_on_tag(localclientnum, fxname, tag, team)
{
	if(!isdefined(self.fxhandles[tag]) || fxname != self.fxnames[tag])
	{
		stop_fx_on_tag(localclientnum, fxname, tag);
		self.fxnames[tag] = fxname;
		self.fxhandles[tag] = util::playfxontag(localclientnum, fxname, self, tag);
		setfxteam(localclientnum, self.fxhandles[tag], team);
	}
}

/*
	Name: stop_fx_on_tag
	Namespace: smart_cover
	Checksum: 0x6BD5A195
	Offset: 0x2298
	Size: 0x74
	Parameters: 3
	Flags: Linked
*/
function stop_fx_on_tag(localclientnum, fxname, tag)
{
	if(isdefined(self.fxhandles[tag]))
	{
		stopfx(localclientnum, self.fxhandles[tag]);
		self.fxhandles[tag] = undefined;
		self.fxnames[tag] = undefined;
	}
}

/*
	Name: render_debug_sphere
	Namespace: smart_cover
	Checksum: 0x3353F5B5
	Offset: 0x2318
	Size: 0x94
	Parameters: 3
	Flags: None
*/
function render_debug_sphere(tag, color, fxname)
{
	/#
		if(getdvarint(#"hash_93503b23ed2be27", 0))
		{
			origin = self gettagorigin(tag);
			sphere(origin, 2, color, 0.75, 1, 10, 100);
		}
	#/
}

/*
	Name: stop_or_start_fx
	Namespace: smart_cover
	Checksum: 0x9D8E8467
	Offset: 0x23B8
	Size: 0xEC
	Parameters: 5
	Flags: Linked
*/
function stop_or_start_fx(localclientnum, fxname, tag, start, team)
{
	if(start)
	{
		self play_fx_on_tag(localclientnum, fxname, tag, team);
		/#
			if(fxname == "")
			{
				render_debug_sphere(tag, vectorscale((1, 1, 0), 0.5), fxname);
			}
			else
			{
				render_debug_sphere(tag, (0, 1, 0), fxname);
			}
		#/
	}
	else
	{
		stop_fx_on_tag(localclientnum, fxname, tag);
		/#
			render_debug_sphere(tag, (1, 0, 0), fxname);
		#/
	}
}

/*
	Name: playmicrowavefx
	Namespace: smart_cover
	Checksum: 0x847C0412
	Offset: 0x24B0
	Size: 0x5EC
	Parameters: 6
	Flags: Linked
*/
function playmicrowavefx(localclientnum, trace, traceright, traceleft, origin, team)
{
	for(i = 0; i < 5; i++)
	{
		endofhalffxsq = i * 150 + 125 * i * 150 + 125;
		endoffullfxsq = i * 150 + 200 * i * 150 + 200;
		tracedistsq = distancesquared(origin, trace[#"position"]);
		startfx = tracedistsq >= endofhalffxsq || i == 0;
		fxname = (tracedistsq < endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave_sm" : "weapon/fx8_equip_smart_cover_microwave");
		switch(i)
		{
			case 0:
			{
				self play_fx_on_tag(localclientnum, fxname, "tag_fx11", team);
				break;
			}
			case 1:
			{
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx32", startfx, team);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx42", startfx, team);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx43", startfx, team);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx53", startfx, team);
				break;
			}
		}
		tracedistsq = distancesquared(origin, traceleft[#"position"]);
		startfx = tracedistsq >= endofhalffxsq;
		fxname = (tracedistsq < endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave_sm" : "weapon/fx8_equip_smart_cover_microwave");
		switch(i)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx22", startfx, team);
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx33", startfx, team);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx44", startfx, team);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx54", startfx, team);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx55", startfx, team);
				break;
			}
		}
		tracedistsq = distancesquared(origin, traceright[#"position"]);
		startfx = tracedistsq >= endofhalffxsq;
		fxname = (tracedistsq < endoffullfxsq ? "weapon/fx8_equip_smart_cover_microwave_sm" : "weapon/fx8_equip_smart_cover_microwave");
		switch(i)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx21", startfx, team);
				break;
			}
			case 2:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx31", startfx, team);
				break;
			}
			case 3:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx41", startfx, team);
				break;
			}
			case 4:
			{
				self stop_or_start_fx(localclientnum, fxname, "tag_fx51", startfx, team);
				self stop_or_start_fx(localclientnum, fxname, "tag_fx52", startfx, team);
				break;
			}
		}
	}
}

