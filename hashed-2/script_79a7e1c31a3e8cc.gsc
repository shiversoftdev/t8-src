// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace deployable;

/*
	Name: function_89f2df9
	Namespace: deployable
	Checksum: 0x4DDFC935
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"deployable", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: deployable
	Checksum: 0x8885EE11
	Offset: 0x120
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
	level.var_160dcfef = spawnstruct();
	level.var_160dcfef.var_1b8ab31d = [];
	level.var_160dcfef.var_d4ef836e = 0;
	level.var_160dcfef.var_a48608a0 = [];
	if(!isdefined(level.var_1765ad79))
	{
		level.var_1765ad79 = 1;
	}
	/#
		level.var_160dcfef.var_193db709 = [];
		setdvar(#"hash_8d4e58d73e3f876", 0);
	#/
}

/*
	Name: function_2e088f73
	Namespace: deployable
	Checksum: 0x14A156B1
	Offset: 0x200
	Size: 0x1DE
	Parameters: 6
	Flags: Linked
*/
function function_2e088f73(weapon, var_c0064c29, var_94b4fa08 = undefined, var_3733072 = undefined, var_a39cb3db = undefined, var_fe12c0d9 = undefined)
{
	if(!isdefined(level._deployable_weapons))
	{
		level._deployable_weapons = [];
	}
	if(weapon.name == "#none")
	{
		return;
	}
	/#
		assert(weapon.name != "");
	#/
	level._deployable_weapons[weapon.statindex] = spawnstruct();
	level._deployable_weapons[weapon.statindex].var_159652c0 = &function_6654310c;
	level._deployable_weapons[weapon.statindex].var_9f2c21ea = var_c0064c29;
	level._deployable_weapons[weapon.statindex].var_1463c9a8 = var_94b4fa08;
	level._deployable_weapons[weapon.statindex].var_3733072 = var_3733072;
	level._deployable_weapons[weapon.statindex].var_a39cb3db = var_a39cb3db;
	level._deployable_weapons[weapon.statindex].var_fe12c0d9 = var_fe12c0d9;
}

/*
	Name: function_209fda28
	Namespace: deployable
	Checksum: 0x2F23C325
	Offset: 0x3E8
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_209fda28(weapon)
{
	if(!isdefined(level._deployable_weapons))
	{
		level._deployable_weapons = [];
	}
	if(isdefined(level._deployable_weapons[weapon.statindex]) && isdefined(level._deployable_weapons[weapon.statindex].var_159652c0))
	{
		self [[level._deployable_weapons[weapon.statindex].var_159652c0]](weapon);
	}
}

/*
	Name: function_84fa8d39
	Namespace: deployable
	Checksum: 0x5FB94FD2
	Offset: 0x480
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_84fa8d39(weapon)
{
	/#
		println("");
	#/
}

/*
	Name: function_cf538621
	Namespace: deployable
	Checksum: 0x7C4BA5B4
	Offset: 0x4B8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_cf538621(weapon)
{
	/#
		println("");
	#/
	self clientfield::set_to_player("gameplay_allows_deploy", 1);
}

/*
	Name: function_d60e5a06
	Namespace: deployable
	Checksum: 0x50DE56B0
	Offset: 0x510
	Size: 0x150
	Parameters: 2
	Flags: None
*/
function function_d60e5a06(center, radius)
{
	var_5795c216 = spawnstruct();
	var_5795c216.origin = center;
	var_5795c216.radiussqr = radius * radius;
	var_5795c216._id = level.var_160dcfef.var_d4ef836e;
	if(!isdefined(level.var_160dcfef.var_1b8ab31d))
	{
		level.var_160dcfef.var_1b8ab31d = [];
	}
	else if(!isarray(level.var_160dcfef.var_1b8ab31d))
	{
		level.var_160dcfef.var_1b8ab31d = array(level.var_160dcfef.var_1b8ab31d);
	}
	level.var_160dcfef.var_1b8ab31d[level.var_160dcfef.var_1b8ab31d.size] = var_5795c216;
	var_81327e4b = level.var_160dcfef.var_d4ef836e;
	level.var_160dcfef.var_d4ef836e++;
	return var_81327e4b;
}

/*
	Name: function_b20df196
	Namespace: deployable
	Checksum: 0x2645BA92
	Offset: 0x668
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_b20df196(var_a4879492)
{
	for(index = 0; index < level.var_160dcfef.var_1b8ab31d.size; index++)
	{
		if(level.var_160dcfef.var_1b8ab31d[index]._id == var_a4879492)
		{
			level.var_160dcfef.var_1b8ab31d = array::remove_index(level.var_160dcfef.var_1b8ab31d, index, 0);
			break;
		}
	}
}

/*
	Name: function_89d64a2c
	Namespace: deployable
	Checksum: 0xDD00F096
	Offset: 0x710
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_89d64a2c(origin)
{
	foreach(var_5795c216 in level.var_160dcfef.var_1b8ab31d)
	{
		if(distance2dsquared(var_5795c216.origin, origin) < var_5795c216.radiussqr)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_6ec9ee30
	Namespace: deployable
	Checksum: 0x9A240549
	Offset: 0x7C8
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_6ec9ee30(var_a2a6139a, deployable_weapon)
{
	if(isdefined(level.var_7b83b300))
	{
		self [[level.var_7b83b300]](deployable_weapon);
	}
	var_a2a6139a.weapon = deployable_weapon;
	var_a2a6139a thread function_670cd4a3();
	var_4d5b521e = self gadgetgetslot(deployable_weapon);
	self function_69b5c53c(var_4d5b521e, 0);
}

/*
	Name: function_81598103
	Namespace: deployable
	Checksum: 0x6236B027
	Offset: 0x870
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_81598103(var_a2a6139a)
{
	var_a2a6139a function_34d37476();
}

/*
	Name: function_416f03e6
	Namespace: deployable
	Checksum: 0x44EF61D8
	Offset: 0x8A0
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function function_416f03e6(var_de56bf19)
{
	if(!isdefined(self))
	{
		return;
	}
	var_4d5b521e = self gadgetgetslot(var_de56bf19);
	if(isdefined(var_de56bf19))
	{
		self function_69b5c53c(var_4d5b521e, 0);
	}
	if(isdefined(var_de56bf19) && var_de56bf19.issupplydropweapon !== 1)
	{
		self setriotshieldfailhint();
	}
	if(isdefined(level.var_cf16ff75))
	{
		self [[level.var_cf16ff75]](var_de56bf19);
	}
}

/*
	Name: function_b3d993e9
	Namespace: deployable
	Checksum: 0x4C0FB736
	Offset: 0x958
	Size: 0x1C2
	Parameters: 2
	Flags: Linked
*/
function function_b3d993e9(deployable_weapon, sethintstring = 0)
{
	player = self;
	if(deployable_weapon.var_e0d42861)
	{
		player function_bf191832(1, (0, 0, 0), (0, 0, 0));
		return 1;
	}
	var_2e7d45cb = player function_27476e09(deployable_weapon, sethintstring);
	player.var_7a3f3edf = function_ab25be55(deployable_weapon, sethintstring) && var_2e7d45cb.isvalid && function_d6ac81c7(deployable_weapon, player, var_2e7d45cb.origin, var_2e7d45cb.angles);
	player setplacementhint(player.var_7a3f3edf);
	player function_bf191832(player.var_7a3f3edf, var_2e7d45cb.origin, var_2e7d45cb.angles);
	player clientfield::set_to_player("gameplay_allows_deploy", player.var_7a3f3edf);
	if(player.var_7a3f3edf)
	{
		self.var_b8878ba9 = var_2e7d45cb.origin;
		self.var_ddc03e10 = var_2e7d45cb.angles;
	}
	else
	{
		self.var_b8878ba9 = undefined;
		self.var_ddc03e10 = undefined;
	}
	return player.var_7a3f3edf;
}

/*
	Name: function_ab25be55
	Namespace: deployable
	Checksum: 0x4E691DBE
	Offset: 0xB28
	Size: 0x9E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ab25be55(weapon, sethintstring)
{
	if(self isplayerswimming() && !(isdefined(weapon.var_83c8d96a) ? weapon.var_83c8d96a : 0))
	{
		self sethintstring(#"hash_37605398dce96965");
		return false;
	}
	if(!self isonground())
	{
		return false;
	}
	return true;
}

/*
	Name: function_831707e8
	Namespace: deployable
	Checksum: 0x74BAF7AE
	Offset: 0xBD0
	Size: 0x196
	Parameters: 2
	Flags: Linked, Private
*/
function private function_831707e8(player, deployable_weapon)
{
	if(!(isdefined(deployable_weapon.var_dbbd4cec) && deployable_weapon.var_dbbd4cec))
	{
		return false;
	}
	if(player depthinwater() > (isdefined(deployable_weapon.var_76127e14) ? deployable_weapon.var_76127e14 : 0))
	{
		return false;
	}
	if(oob::chr_party(player.origin))
	{
		return false;
	}
	if(!player isonground())
	{
		return false;
	}
	if(function_89d64a2c(player.origin))
	{
		return false;
	}
	if(function_54267517(player.origin))
	{
		return false;
	}
	traceresults = bullettrace(player.origin + vectorscale((0, 0, 1), 10), player.origin + (vectorscale((0, 0, -1), 10)), 0, player);
	if(isdefined(traceresults[#"entity"]))
	{
		entity = traceresults[#"entity"];
		if(!function_db9eb027(entity))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_867664f6
	Namespace: deployable
	Checksum: 0xF48D5300
	Offset: 0xD70
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_867664f6(player)
{
	var_8a074131 = worldentnumber();
	groundent = player getgroundent();
	if(!isdefined(groundent))
	{
		return 0;
	}
	return var_8a074131 == groundent getentitynumber();
}

/*
	Name: function_27476e09
	Namespace: deployable
	Checksum: 0x78C01BE1
	Offset: 0xDE8
	Size: 0x342
	Parameters: 2
	Flags: Linked, Private
*/
function private function_27476e09(deployable_weapon, sethintstring = 0)
{
	var_ac12dd4b = level._deployable_weapons[deployable_weapon.statindex].var_1463c9a8;
	if(!isdefined(var_ac12dd4b))
	{
		results = self function_242060b9(deployable_weapon);
	}
	else
	{
		results = [[var_ac12dd4b]](self);
	}
	/#
		assert(isdefined(results));
	#/
	/#
		assert(isdefined(results.isvalid));
	#/
	/#
		assert(isdefined(results.origin));
	#/
	/#
		assert(isdefined(results.angles));
	#/
	if(!isdefined(results.waterdepth))
	{
		results.waterdepth = 0;
	}
	var_a98c3ea7 = 1;
	if(results.waterdepth > (isdefined(deployable_weapon.var_76127e14) ? deployable_weapon.var_76127e14 : 0))
	{
		results.isvalid = 0;
	}
	results.origin = results.var_e8995ec9;
	results.isvalid = results.isvalid && !oob::chr_party(results.origin);
	results.isvalid = results.isvalid && !function_89d64a2c(results.origin);
	results.isvalid = results.isvalid && !function_54267517(results.origin);
	results.isvalid = results.isvalid && function_db9eb027(results.hitent);
	if(level.var_1765ad79)
	{
		results.isvalid = results.isvalid && function_867664f6(self);
	}
	if(!results.isvalid && function_831707e8(self, deployable_weapon))
	{
		results.origin = self.origin;
		results.angles = self.angles;
		results.isvalid = 1;
	}
	return results;
}

/*
	Name: function_d6ac81c7
	Namespace: deployable
	Checksum: 0x13ED5D6
	Offset: 0x1138
	Size: 0x6C
	Parameters: 4
	Flags: Linked, Private
*/
function private function_d6ac81c7(deployable_weapon, player, origin, angles)
{
	var_9f2c21ea = level._deployable_weapons[deployable_weapon.statindex].var_9f2c21ea;
	if(!isdefined(var_9f2c21ea))
	{
		return 1;
	}
	return [[var_9f2c21ea]](origin, angles, player);
}

/*
	Name: function_6654310c
	Namespace: deployable
	Checksum: 0x31D2877C
	Offset: 0x11B0
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6654310c(weapon)
{
	player = self;
	if(level.time == player.var_3abd9b54)
	{
		return;
	}
	player.var_3abd9b54 = level.time;
	var_7a3f3edf = player function_b3d993e9(weapon);
	if(!var_7a3f3edf && isdefined(level.var_228e8cd6))
	{
		player [[level.var_228e8cd6]](weapon);
	}
}

/*
	Name: function_f8fe102f
	Namespace: deployable
	Checksum: 0x97DBCC73
	Offset: 0x1258
	Size: 0xC
	Parameters: 0
	Flags: None
*/
function function_f8fe102f()
{
	return isdefined(self.var_b8878ba9);
}

/*
	Name: function_dd266e08
	Namespace: deployable
	Checksum: 0xFF1C0EE7
	Offset: 0x1270
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_dd266e08(owner)
{
	if(isdefined(owner) && isdefined(owner.var_b8878ba9))
	{
		self.origin = owner.var_b8878ba9;
	}
	if(isdefined(owner) && isdefined(owner.var_ddc03e10))
	{
		self.angles = owner.var_ddc03e10;
	}
}

/*
	Name: on_player_spawned
	Namespace: deployable
	Checksum: 0x1371C72C
	Offset: 0x12E8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.var_3abd9b54 = 0;
	self clientfield::set_to_player("gameplay_allows_deploy", 1);
	self callback::function_f77ced93(&function_f77ced93);
}

/*
	Name: function_aab01e08
	Namespace: deployable
	Checksum: 0x1E426955
	Offset: 0x1340
	Size: 0x80
	Parameters: 0
	Flags: Linked, Private
*/
function private function_aab01e08()
{
	weapon = undefined;
	if(self isusingoffhand())
	{
		weapon = self getcurrentoffhand();
	}
	else
	{
		weapon = self getcurrentweapon();
	}
	if(!weapon.deployable || weapon.var_e0d42861)
	{
		return undefined;
	}
	return weapon;
}

/*
	Name: function_f0adf9c
	Namespace: deployable
	Checksum: 0x5F253E92
	Offset: 0x13C8
	Size: 0x168
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f0adf9c()
{
	self notify("3bd5bdfdc5aacef9");
	self endon("3bd5bdfdc5aacef9");
	player = self;
	player endon(#"death", #"disconnect");
	deployable_weapon = player function_aab01e08();
	if(!isdefined(deployable_weapon))
	{
		player thread function_765a2e96();
		return;
	}
	while(true)
	{
		waitframe(1);
		var_7a3f3edf = player function_b3d993e9(deployable_weapon);
		if(var_7a3f3edf)
		{
			if(isdefined(level._deployable_weapons[deployable_weapon.statindex].var_3733072))
			{
				player sethintstring(level._deployable_weapons[deployable_weapon.statindex].var_3733072);
			}
		}
		else if(isdefined(level._deployable_weapons[deployable_weapon.statindex].var_a39cb3db))
		{
			player sethintstring(level._deployable_weapons[deployable_weapon.statindex].var_a39cb3db);
		}
	}
}

/*
	Name: function_765a2e96
	Namespace: deployable
	Checksum: 0x74F8D824
	Offset: 0x1538
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_765a2e96()
{
	self endon(#"death", #"disconnect");
	wait(1.5);
	self sethintstring("");
}

/*
	Name: function_db9eb027
	Namespace: deployable
	Checksum: 0x5139041B
	Offset: 0x1590
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_db9eb027(entity)
{
	if(!isdefined(entity))
	{
		return true;
	}
	if(isvehicle(entity) || isai(entity) || entity ismovingplatform())
	{
		return false;
	}
	if(isdefined(entity.weapon) || isdefined(entity.killstreakid))
	{
		return false;
	}
	return true;
}

/*
	Name: function_54d27855
	Namespace: deployable
	Checksum: 0xBDC6F712
	Offset: 0x1628
	Size: 0xA4E
	Parameters: 5
	Flags: None
*/
function function_54d27855(var_503cdc82, var_421003af, var_36baa3f1, previs_weapon, ignore_entity)
{
	results = spawnstruct();
	var_5130f5dd = 0;
	var_caa96e8a = 0;
	var_a7bfb = 0;
	var_e76d3149 = 0;
	var_68e91c5c = 0;
	var_ae7d780d = 0;
	var_f94d59f8 = 2;
	var_5adff8ce = (0, 0, 0);
	var_4c59d56 = (0, 0, 0);
	forward = anglestoforward(var_421003af);
	var_6c16750a = previs_weapon.var_f7e67f28;
	if(previs_weapon.var_9111ccc0 && previs_weapon.var_5ac2e7a4 > previs_weapon.var_f7e67f28)
	{
		var_6c16750a = previs_weapon.var_5ac2e7a4;
	}
	trace_distance = var_6c16750a / abs(cos(var_421003af[0]));
	forward_vector = vectorscale(forward, trace_distance);
	trace_start = var_36baa3f1;
	trace_result = bullettrace(trace_start, trace_start + forward_vector, 0, ignore_entity);
	hit_location = trace_start + forward_vector;
	var_db3ce012 = (0, 0, 1);
	var_79483ca0 = 10;
	var_def28dc4 = previs_weapon.var_9111ccc0;
	hitent = undefined;
	var_d22ba639 = 0;
	if(trace_result[#"fraction"] < 1)
	{
		hit_location = trace_result[#"position"];
		var_db3ce012 = trace_result[#"normal"];
		var_6165e0de = var_db3ce012[2] < 0.7;
		var_79483ca0 = trace_result[#"fraction"] * trace_distance;
		if(distance2dsquared(var_503cdc82, hit_location) < previs_weapon.var_f7e67f28 * previs_weapon.var_f7e67f28)
		{
			var_caa96e8a = 1;
		}
		height_offset = hit_location[2] - var_503cdc82[2];
		if(var_def28dc4 && var_6165e0de)
		{
			if(height_offset <= previs_weapon.var_ab300840 && height_offset >= previs_weapon.var_849af6b4)
			{
				var_a7bfb = 1;
			}
			var_e76d3149 = 1;
			var_f131a86 = vectordot(forward * -1, var_db3ce012);
			if(var_f131a86 > cos(previs_weapon.var_c4aae0fa))
			{
				var_68e91c5c = 1;
			}
			if(!var_68e91c5c)
			{
				var_d22ba639 = 1;
			}
			hitent = trace_result[#"entity"];
		}
		else
		{
			if(height_offset <= previs_weapon.var_227c90e1 && height_offset >= previs_weapon.var_849af6b4)
			{
				var_a7bfb = 1;
			}
			out_of_range = var_79483ca0 > previs_weapon.var_f7e67f28;
			if(out_of_range)
			{
				var_d22ba639 = 1;
			}
			if(!var_def28dc4 && var_6165e0de)
			{
				hit_location = var_503cdc82 + ((forward_vector[0], forward_vector[1], 0) * trace_result[#"fraction"]);
				var_db3ce012 = (0, 0, 1);
				var_ae7d780d = 1;
				var_d22ba639 = 0;
			}
		}
	}
	else
	{
		var_d22ba639 = 1;
	}
	var_c84f4998 = 0;
	water_bottom = hit_location;
	if(var_d22ba639)
	{
		var_7af8b86b = anglestoforward((0, var_421003af[1], 0));
		var_f7e67f28 = previs_weapon.var_f7e67f28;
		var_75e7a61 = var_503cdc82 + (0, 0, previs_weapon.var_227c90e1);
		var_1a606e14 = var_75e7a61 + (var_7af8b86b * var_f7e67f28);
		var_b6085963 = bullettrace(var_75e7a61, var_1a606e14, 0, ignore_entity);
		if(var_b6085963[#"fraction"] > 0)
		{
			var_f7e67f28 = (previs_weapon.var_f7e67f28 * var_b6085963[#"fraction"]) - var_f94d59f8;
			var_14b67847 = (var_503cdc82 + (var_7af8b86b * var_f7e67f28)) + (0, 0, previs_weapon.var_227c90e1);
			var_c9851f67 = var_14b67847 - (0, 0, previs_weapon.var_227c90e1 - previs_weapon.var_849af6b4);
			var_4bc118b9 = groundtrace(var_14b67847, var_c9851f67, 0, ignore_entity);
			hitent = var_4bc118b9[#"entity"];
			if(var_4bc118b9[#"fraction"] > 0.01 && var_4bc118b9[#"fraction"] < 1 && var_4bc118b9[#"normal"][2] > 0.9)
			{
				hit_location = var_4bc118b9[#"position"];
				var_db3ce012 = var_4bc118b9[#"normal"];
				var_79483ca0 = var_4bc118b9[#"fraction"] * var_f7e67f28;
				var_caa96e8a = 1;
				var_a7bfb = 1;
				if(isdefined(var_4bc118b9[#"waterdepth"]))
				{
					var_c84f4998 = var_4bc118b9[#"waterdepth"];
					water_bottom = var_4bc118b9[#"hash_39a59135a2292e13"];
				}
			}
		}
	}
	if(isdefined(hit_location))
	{
		var_5adff8ce = hit_location;
		if(var_db3ce012[2] < 0.7)
		{
			var_89135834 = angleclamp180(vectortoangles(var_db3ce012)[0] + 90);
			var_503578d3 = vectortoangles(var_db3ce012)[1];
			var_e8a49b1 = 0;
		}
		else
		{
			hit_angles = vectortoangles(var_db3ce012);
			var_503578d3 = var_421003af[1];
			pitch = angleclamp180(hit_angles[0] + 90);
			var_18f32ba4 = absangleclamp360(hit_angles[1] - var_421003af[1]);
			var_aba68694 = cos(var_18f32ba4);
			var_c59a47b6 = sin(var_18f32ba4) * -1;
			var_89135834 = pitch * var_aba68694;
			var_e8a49b1 = pitch * var_c59a47b6;
		}
		var_4c59d56 = (var_89135834, var_503578d3, var_e8a49b1);
	}
	var_5130f5dd = var_caa96e8a && var_a7bfb && (!var_e76d3149 || var_68e91c5c) && !var_ae7d780d;
	if(var_5130f5dd && (!(isdefined(previs_weapon.var_33d50507) && previs_weapon.var_33d50507)))
	{
		var_e3c2e9c6 = var_5adff8ce + ((0, 0, 1) * 30);
		var_cc9ea9b = physicstrace(var_36baa3f1, var_e3c2e9c6, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), ignore_entity);
		var_5130f5dd = var_cc9ea9b[#"fraction"] == 1;
	}
	results.isvalid = var_5130f5dd;
	results.origin = var_5adff8ce;
	results.angles = var_4c59d56;
	results.hitent = hitent;
	results.waterdepth = var_c84f4998;
	results.var_e8995ec9 = water_bottom;
	return results;
}

/*
	Name: function_f77ced93
	Namespace: deployable
	Checksum: 0x8BEF1CD0
	Offset: 0x2080
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f77ced93(params)
{
	self setplacementhint(1);
	self clientfield::set_to_player("gameplay_allows_deploy", 1);
	self thread function_f0adf9c();
}

/*
	Name: function_670cd4a3
	Namespace: deployable
	Checksum: 0x99F3123B
	Offset: 0x20E8
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_670cd4a3()
{
	self endon(#"death");
	self.var_19fde5b7 = [];
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_stuck");
		if(isdefined(waitresult.projectile))
		{
			array::add(self.var_19fde5b7, waitresult.projectile);
		}
	}
}

/*
	Name: function_34d37476
	Namespace: deployable
	Checksum: 0x6D804A3C
	Offset: 0x2170
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_34d37476()
{
	if(!isdefined(self.var_19fde5b7))
	{
		return;
	}
	foreach(var_221be278 in self.var_19fde5b7)
	{
		if(!isdefined(var_221be278))
		{
			continue;
		}
		var_221be278 dodamage(500, self.origin, undefined, undefined, undefined, "MOD_EXPLOSIVE");
	}
}

