// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39bd5b6b799b1c9c;
#using script_3f65948f90646f7c;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_65181344;

/*
	Name: function_2c4d3d40
	Namespace: namespace_65181344
	Checksum: 0x8222AB7E
	Offset: 0xE0
	Size: 0x1A2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2c4d3d40()
{
	level.var_de3d5d56 = [];
	var_3a1737b4 = getscriptbundles(#"hash_10587321f369e7f3");
	var_cce250bc = function_d634ed59();
	index = 0;
	offsetorigin = vectorscale((0, 0, -1), 64000);
	foreach(var_1461de43, var_28f8f6a9 in var_3a1737b4)
	{
		if(isdefined(level.var_de3d5d56))
		{
			level.var_de3d5d56[var_1461de43] = var_28f8f6a9;
		}
		function_43cd95f4(index, var_1461de43);
		function_54ca5536(index, 1);
		function_b97dfce0(index, offsetorigin);
		index++;
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
}

/*
	Name: function_440f0490
	Namespace: namespace_65181344
	Checksum: 0x19B119F8
	Offset: 0x290
	Size: 0x326
	Parameters: 1
	Flags: Linked, Private
*/
private function function_440f0490(var_b91441dd)
{
	/#
		assert(isdefined(var_b91441dd) && var_b91441dd.type === "");
	#/
	/#
		assert(var_b91441dd.itemlist.size > 0, "" + var_b91441dd.name + "");
	#/
	if(var_b91441dd.itemlist.size <= 0)
	{
		return;
	}
	weights = [];
	var_ac9f1dc8 = 0;
	for(rowindex = 0; rowindex < var_b91441dd.itemlist.size; rowindex++)
	{
		var_35843db5 = (isdefined(var_b91441dd.itemlist[rowindex].minweight) ? var_b91441dd.itemlist[rowindex].minweight : 0);
		var_ccef9e25 = (isdefined(var_b91441dd.itemlist[rowindex].maxweight) ? var_b91441dd.itemlist[rowindex].maxweight : 0);
		minweight = int(min(var_35843db5, var_ccef9e25));
		maxweight = int(max(var_35843db5, var_ccef9e25));
		diff = maxweight - minweight;
		randomint = function_d59c2d03(diff + 1);
		weight = randomint + minweight;
		weights[weights.size] = weight;
		var_ac9f1dc8 = var_ac9f1dc8 + weight;
	}
	var_d54615ef = function_d59c2d03(var_ac9f1dc8);
	var_8efa5a60 = 0;
	for(var_ee49f1ad = 0; var_ee49f1ad < weights.size; var_ee49f1ad++)
	{
		var_8efa5a60 = var_8efa5a60 + weights[var_ee49f1ad];
		if(var_d54615ef <= var_8efa5a60)
		{
			var_b91441dd = getscriptbundle(var_b91441dd.itemlist[var_ee49f1ad].var_a6762160);
			/#
				assert(var_b91441dd.type === "");
			#/
			break;
		}
	}
	return var_b91441dd;
}

/*
	Name: function_6a5c090c
	Namespace: namespace_65181344
	Checksum: 0x9723BFBE
	Offset: 0x5C0
	Size: 0xE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6a5c090c()
{
	level.var_de3d5d56 = undefined;
}

/*
	Name: function_9e9f43cd
	Namespace: namespace_65181344
	Checksum: 0xC727ABCD
	Offset: 0x5D8
	Size: 0x21A
	Parameters: 0
	Flags: Linked
*/
function function_9e9f43cd()
{
	if(!level flagsys::get(#"hash_67b445a4b1d59922") && !level flagsys::get(#"hash_11c9cde7b522c5a9"))
	{
		/#
			assert(0);
		#/
		return;
	}
	foreach(targetname, points in level.var_1d777960)
	{
		for(index = 0; index < points.size; index++)
		{
			origin = points[index].origin;
			angles = points[index].angles;
			ground_pos = physicstraceex(origin + vectorscale((0, 0, 1), 24), origin - vectorscale((0, 0, 1), 96), (0, 0, 0), (0, 0, 0), undefined, 32);
			position = ground_pos[#"position"];
			function_53a81463(position, angles, targetname, #"");
		}
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
}

/*
	Name: function_e88ecf7f
	Namespace: namespace_65181344
	Checksum: 0xC6FD4D7A
	Offset: 0x800
	Size: 0x1E8
	Parameters: 0
	Flags: Linked
*/
function function_e88ecf7f()
{
	if(!level flagsys::get(#"hash_67b445a4b1d59922") && !level flagsys::get(#"hash_11c9cde7b522c5a9"))
	{
		/#
			assert(0);
		#/
		return;
	}
	/#
		assert(level.var_bf9b06d3.size == level.var_8d50adaa.size);
	#/
	for(index = 0; index < level.var_bf9b06d3.size; index++)
	{
		points = function_abaeb170(level.var_bf9b06d3[index], undefined, undefined, level.var_8d50adaa[index], undefined, 0);
		for(pointindex = 0; pointindex < points.size; pointindex++)
		{
			function_b2cf8bc6(points[pointindex].id, #"");
			if(isdefined(points[pointindex].targetname))
			{
				level.var_28cd0b1f[points[pointindex].targetname] = 1;
			}
		}
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
}

/*
	Name: function_35461e5f
	Namespace: namespace_65181344
	Checksum: 0x1A261B57
	Offset: 0x9F0
	Size: 0x12E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_35461e5f(row, var_be90d3da = 0)
{
	items = [];
	item_name = self.var_b91441dd.itemlist[row].var_a6762160;
	item = function_62c0d32d(item_name, var_be90d3da);
	if(isdefined(item))
	{
		items[items.size] = item;
	}
	for(index = 1; index <= 5; index++)
	{
		item_name = self.var_b91441dd.itemlist[row].("childitementry_" + index);
		if(!isdefined(item_name))
		{
			continue;
		}
		item = function_62c0d32d(item_name, var_be90d3da);
		if(isdefined(item))
		{
			items[items.size] = item;
		}
	}
	return items;
}

/*
	Name: function_62c0d32d
	Namespace: namespace_65181344
	Checksum: 0x8FC72C7D
	Offset: 0xB28
	Size: 0x27A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_62c0d32d(item_name, var_be90d3da = 0)
{
	if(isdefined(item_name) && isdefined(level.var_4afb8f5a[item_name]))
	{
		item_name = level.var_4afb8f5a[item_name];
	}
	if(!isdefined(item_name) || item_name == "")
	{
		return;
	}
	var_f77e15f6 = function_4ba8fde(item_name);
	if(!isdefined(var_f77e15f6))
	{
		return;
	}
	origin = (0, 0, 0);
	angles = (0, 0, 0);
	if(!var_be90d3da)
	{
		origin = self.origin;
		angles = self.angles;
	}
	var_a6762160 = (isdefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name));
	weapon = namespace_ad5a0cd6::function_35e06774(var_a6762160, isdefined(var_a6762160.attachments));
	itemcount = (isdefined(var_a6762160.amount) ? var_a6762160.amount : 1);
	var_aec6fa7f = 0;
	if(var_a6762160.itemtype == #"weapon")
	{
		var_aec6fa7f = var_a6762160.amount * weapon.clipsize;
	}
	else if(var_a6762160.itemtype == #"armor" || var_a6762160.itemtype == #"ammo")
	{
		var_aec6fa7f = var_a6762160.amount;
		itemcount = 1;
	}
	item = item_drop::drop_item(weapon, itemcount, var_aec6fa7f, var_f77e15f6.id, origin, angles, var_be90d3da);
	if(isdefined(item))
	{
		item.spawning = 1;
	}
	return item;
}

/*
	Name: function_98013deb
	Namespace: namespace_65181344
	Checksum: 0x3E344F68
	Offset: 0xDB0
	Size: 0x88
	Parameters: 1
	Flags: Linked, Private
*/
private function function_98013deb(row)
{
	var_27758d04 = 0;
	for(index = 1; index <= 5; index++)
	{
		item_name = self.var_b91441dd.itemlist[row].("childitementry_" + index);
		if(isdefined(item_name))
		{
			var_27758d04++;
		}
	}
	return var_27758d04;
}

/*
	Name: function_a0a5aec6
	Namespace: namespace_65181344
	Checksum: 0x23F0CF98
	Offset: 0xE40
	Size: 0xB3E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_a0a5aec6(point, row, var_be90d3da = 0)
{
	if(!isdefined(point))
	{
		return;
	}
	item_name = self.var_b91441dd.itemlist[row].var_a6762160;
	if(isdefined(item_name) && isdefined(level.var_4afb8f5a[item_name]))
	{
		item_name = level.var_4afb8f5a[item_name];
	}
	if(!isdefined(item_name) || item_name == "")
	{
		function_43cd95f4(point.id, "");
		/#
			if(!isdefined(level.var_d80c35aa[#"blank"]))
			{
				level.var_d80c35aa[#"blank"] = 0;
			}
			level.var_d80c35aa[#"blank"]++;
		#/
		return;
	}
	var_a6762160 = (isdefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name));
	/#
		if(!var_be90d3da && isdefined(var_a6762160) && isdefined(var_a6762160.itemtype))
		{
			if(!isdefined(level.var_d80c35aa[var_a6762160.itemtype]))
			{
				level.var_d80c35aa[var_a6762160.itemtype] = 0;
			}
			level.var_d80c35aa[var_a6762160.itemtype]++;
		}
	#/
	if(!isdefined(var_a6762160) || !isdefined(var_a6762160.itemtype) || var_a6762160.itemtype == #"blank")
	{
		function_43cd95f4(point.id, "");
		return;
	}
	if(var_a6762160.itemtype == #"vehicle")
	{
		ground_pos = bullettrace(point.origin + vectorscale((0, 0, 1), 128), point.origin - vectorscale((0, 0, 1), 128), 0, undefined, 1);
		if(ground_pos[#"surfacetype"] == "water" || ground_pos[#"surfacetype"] == "watershallow")
		{
			ground_pos = bullettrace(point.origin + vectorscale((0, 0, 1), 2048), point.origin - vectorscale((0, 0, 1), 2048), 0, undefined, 1);
		}
		spawnpoint = ground_pos[#"position"] + vectorscale((0, 0, 1), 36);
		vehicle = undefined;
		if(namespace_ad5a0cd6::function_74e1e547(spawnpoint))
		{
			vehicle = spawnvehicle(var_a6762160.vehicle, spawnpoint, point.angles);
		}
		if(isdefined(vehicle))
		{
			level.var_d79f1ee4[level.var_d79f1ee4.size] = vehicle;
			level.var_8819644a[level.var_8819644a.size] = {#used:0, #vehicle:vehicle, #vehicletype:vehicle.vehicletype, #origin:vehicle.origin};
			if(isairborne(vehicle))
			{
				spawnoffset = (0, 0, vehicle.height);
				vehicle.origin = point.origin + spawnoffset;
			}
			vehicle makeusable();
			if(isdefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle)
			{
				vehicle setbrake(1);
			}
			if(isdefined(getgametypesetting(#"hash_59ab05f71c3789c7")) && getgametypesetting(#"hash_59ab05f71c3789c7"))
			{
				target_remove(vehicle);
			}
		}
		function_43cd95f4(point.id, "");
		/#
			level.var_f2db6a7f++;
		#/
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
		return;
	}
	var_27758d04 = self function_98013deb(row);
	if(!var_be90d3da)
	{
		origin = point.origin;
		angles = point.angles;
		if(var_27758d04 > 0)
		{
			if(!isdefined(var_a6762160.var_47f145b4))
			{
				angles = (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0);
				forward = anglestoforward(angles) * level.var_69dda516[0];
				offset = rotatepoint(forward, (0, level.var_cc113617[0], 0));
				origin = origin + offset;
				ground_pos = physicstraceex(origin + vectorscale((0, 0, 1), 24), origin - vectorscale((0, 0, 1), 96), (0, 0, 0), (0, 0, 0), undefined, 32);
				origin = ground_pos[#"position"];
				normal = ground_pos[#"normal"];
				angles = function_c1fa62a2(angles, normal);
			}
		}
		else if(!isdefined(var_a6762160.var_47f145b4))
		{
			angles = combineangles(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
		}
		else
		{
			angles = (0, angles[1], 0);
		}
		loc_00001696:
		loc_000016B6:
		angles = combineangles(angles, ((isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0), (isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0), (isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0)));
		loc_0000170E:
		loc_0000172E:
		originoffset = ((isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0), (isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0), (isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0));
		origin = origin + originoffset;
		if(var_27758d04 > 0 || isdefined(var_a6762160.var_47f145b4))
		{
			point = function_53a81463(origin, angles, point.targetname, item_name);
		}
		else
		{
			function_b97dfce0(point.id, origin);
			function_3eab95b5(point.id, angles);
			point.angles = angles;
		}
	}
	function_43cd95f4(point.id, item_name);
	if(item_name == #"hash_43aca7fcfd3e5949")
	{
		level.var_5b2a8d88[point.id] = 1;
	}
	if(var_be90d3da)
	{
		function_54ca5536(point.id, -1);
	}
	/#
		if(var_be90d3da)
		{
			if(!isdefined(level.var_ecf16fd3[var_a6762160.itemtype]))
			{
				level.var_ecf16fd3[var_a6762160.itemtype] = 0;
			}
			level.var_ecf16fd3[var_a6762160.itemtype]++;
			level.var_2850ef5++;
		}
		else
		{
			level.var_136445c0++;
		}
	#/
	if(var_27758d04 > 0)
	{
		for(index = 1; index <= 5; index++)
		{
			item_name = self.var_b91441dd.itemlist[row].("childitementry_" + index);
			if(isdefined(item_name))
			{
				function_f0e5262b(item_name, point, index, var_be90d3da, point.targetname);
			}
		}
	}
}

/*
	Name: function_f0e5262b
	Namespace: namespace_65181344
	Checksum: 0xFBB1DC52
	Offset: 0x1988
	Size: 0x50C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_f0e5262b(item_name, point, childindex, var_be90d3da = 0, targetname)
{
	if(isdefined(level.var_4afb8f5a[item_name]))
	{
		item_name = level.var_4afb8f5a[item_name];
	}
	var_a6762160 = (isdefined(level.var_de3d5d56) ? level.var_de3d5d56[item_name] : getscriptbundle(item_name));
	offset = (0, 0, 0);
	angles = (0, 0, 0);
	origin = point.origin;
	if(!var_be90d3da)
	{
		/#
			assert(childindex > 0 && childindex <= 5);
		#/
		parentangles = (0, point.angles[1], 0);
		degree = level.var_cc113617[childindex];
		distance = level.var_69dda516[childindex];
		offset = (cos(degree) * distance, sin(degree) * distance, 0);
		offset = rotatepoint(offset, parentangles);
		origin = origin + offset;
		ground_pos = physicstraceex(origin + vectorscale((0, 0, 1), 24), origin - vectorscale((0, 0, 1), 96), (0, 0, 0), (0, 0, 0), undefined, 32);
		loc_00001BDE:
		loc_00001BFE:
		var_f05b52fe = ((isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0), (isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0), (isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0));
		origin = ground_pos[#"position"] + var_f05b52fe;
		normal = ground_pos[#"normal"];
		angles = angles + (0, level.var_82e94a26[childindex], 0);
		angles = angles + (0, point.angles[1], 0);
		angles = function_c1fa62a2(angles, normal);
		loc_00001CD6:
		loc_00001CF6:
		angles = combineangles(angles, ((isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0), (isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0), (isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0)));
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
	var_23972ae0 = function_53a81463(origin, angles, targetname, item_name);
	if(var_be90d3da)
	{
		function_54ca5536(var_23972ae0.id, -1);
	}
	/#
		if(var_be90d3da)
		{
			if(!isdefined(level.var_ecf16fd3[var_a6762160.itemtype]))
			{
				level.var_ecf16fd3[var_a6762160.itemtype] = 0;
			}
			level.var_ecf16fd3[var_a6762160.itemtype]++;
			level.var_2850ef5++;
		}
		else if(!isdefined(level.var_8d9ad8e8[var_a6762160.itemtype]))
		{
			level.var_8d9ad8e8[var_a6762160.itemtype] = 0;
		}
		level.var_8d9ad8e8[var_a6762160.itemtype]++;
		level.var_5720c09a++;
	#/
}

/*
	Name: function_ea39d1fa
	Namespace: namespace_65181344
	Checksum: 0x236E67A2
	Offset: 0x1EA0
	Size: 0x5C6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ea39d1fa(stash)
{
	stash.var_aa9f8f87 = self.scriptbundlename;
	var_aa9f8f87 = self.var_b91441dd;
	if(isdefined(var_aa9f8f87) && isdefined(level.var_fb9a8536[var_aa9f8f87.name]))
	{
		var_aa9f8f87 = getscriptbundle(level.var_fb9a8536[var_aa9f8f87.name]);
	}
	var_eff83f3 = var_aa9f8f87;
	if(isdefined(level.var_93c59949[var_aa9f8f87.name]))
	{
		var_cf36f90d = level.var_93c59949[var_aa9f8f87.name];
		for(index = 0; index < var_cf36f90d.size; index++)
		{
			randindex = function_d59c2d03(var_cf36f90d.size);
			var_ec7042e9 = var_cf36f90d[index];
			var_cf36f90d[index] = var_cf36f90d[randindex];
			var_cf36f90d[randindex] = var_ec7042e9;
		}
		foreach(var_ee110db8 in var_cf36f90d)
		{
			if(isdefined(var_ee110db8.var_52a66db0))
			{
				if(stash.targetname !== var_ee110db8.var_52a66db0)
				{
					continue;
				}
			}
			if(var_ee110db8.count == 0)
			{
				continue;
			}
			var_1dd9b7f1 = getscriptbundle(var_ee110db8.replacement);
			if(var_1dd9b7f1.type !== #"itemspawnlist")
			{
				/#
					assert(0, "" + var_ee110db8);
				#/
				continue;
			}
			var_eff83f3 = var_1dd9b7f1;
			self.var_b91441dd = var_eff83f3;
			if(var_ee110db8.count > 0)
			{
				var_ee110db8.count--;
			}
			break;
		}
	}
	for(row = 0; row < var_eff83f3.itemlist.size; row++)
	{
		if(!isdefined(var_eff83f3.itemlist[row].var_a6762160))
		{
			continue;
		}
		var_b91441dd = getscriptbundle(var_eff83f3.itemlist[row].var_a6762160);
		var_bbe618cc = var_b91441dd.type == #"itemspawnlist" || var_b91441dd.type == #"hash_3b34ec2d17821763";
		available = (isdefined(var_eff83f3.itemlist[row].available) ? var_eff83f3.itemlist[row].available : 0);
		var_8107154f = [];
		do
		{
			point = function_53a81463(stash.origin, stash.angles, (isdefined(stash.targetname) ? stash.targetname : stash.target), "");
			var_8107154f[var_8107154f.size] = point.id;
			if(!var_bbe618cc)
			{
				function_a0a5aec6(point, row, 1);
			}
			available--;
		}
		while(available > 0);
		if(var_bbe618cc)
		{
			if(var_b91441dd.type == #"hash_3b34ec2d17821763")
			{
				var_12ab6449 = function_440f0490(var_b91441dd);
				if(!isdefined(var_12ab6449))
				{
					continue;
				}
				var_b91441dd = var_12ab6449;
			}
			if(isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name]))
			{
				var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
			}
			itemspawnlist = spawnstruct();
			itemspawnlist.var_b91441dd = var_b91441dd;
			itemspawnlist function_e25c9d12(var_8107154f, var_8107154f.size, 1);
		}
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
	self.var_b91441dd = var_aa9f8f87;
}

/*
	Name: function_216a69d6
	Namespace: namespace_65181344
	Checksum: 0xFC49D908
	Offset: 0x2470
	Size: 0x75E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_216a69d6(var_9f19fcb6, reset)
{
	dynents = array();
	if(isdefined(self.target))
	{
		dynents = getdynentarray(self.target, 1);
	}
	if(isdefined(self.targetname))
	{
		var_ed91073b = function_c79d31c4(self.targetname, 1);
		dynents = arraycombine(dynents, var_ed91073b, 1, 0);
	}
	for(index = 0; index < self.points.size; index++)
	{
		randindex = function_d59c2d03(self.points.size);
		var_521b73a = self.points[index];
		self.points[index] = self.points[randindex];
		self.points[randindex] = var_521b73a;
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	var_a31ad4de = (isdefined(self.var_b91441dd.var_9b009839) ? self.var_b91441dd.var_9b009839 : 0);
	var_418a2e03 = [];
	foreach(dynent in dynents)
	{
		level.var_5862f2ce[level.var_5862f2ce.size] = dynent;
		dynent.var_1ed4b650 = self.var_b91441dd.var_1ed4b650;
		randint = function_d59c2d03(100);
		var_42abd8e = randint <= var_9f19fcb6;
		if(var_a31ad4de > -1 && var_418a2e03.size >= var_a31ad4de)
		{
			var_42abd8e = 0;
		}
		if(var_42abd8e && reset)
		{
			var_418a2e03[var_418a2e03.size] = dynent;
			continue;
		}
		setdynentenabled(dynent, 0);
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	var_c041d1bd = 0;
	var_a9826383 = 0;
	pointindex = 0;
	while(var_c041d1bd < var_418a2e03.size)
	{
		if(pointindex >= self.points.size)
		{
			if(var_a9826383)
			{
				break;
			}
			var_a9826383 = 1;
			pointindex = 0;
		}
		if(self.points[pointindex] == -1)
		{
		}
		else
		{
			point = function_b1702735(self.points[pointindex]);
			if(point.var_8e092725 == -1)
			{
			}
			else if(isdefined(self.var_b91441dd.var_7fb0967b) && !var_a9826383)
			{
				var_1ba7b9c8 = arraysortclosest(level.var_5ce07338, point.origin, 1, 0, self.var_b91441dd.var_7fb0967b);
				if(var_1ba7b9c8.size > 0)
				{
				}
			}
			else
			{
				function_54ca5536(self.points[pointindex], -1);
				self.points[pointindex] = -1;
				dynent = var_418a2e03[var_c041d1bd];
				dynent.angles = point.angles;
				dynent.origin = point.origin;
				dynent.hintstring = self.var_b91441dd.hintstring;
				dynent.displayname = self.var_b91441dd.displayname;
				dynent.var_3d685b35 = (isdefined(self.var_b91441dd.var_3d685b35) ? self.var_b91441dd.var_3d685b35 : 0);
				level.var_5ce07338[level.var_5ce07338.size] = dynent;
				targetname = (isdefined(dynent.targetname) ? dynent.targetname : dynent.target);
				if(!isdefined(level.var_93d08989[targetname]))
				{
					level.var_93d08989[targetname] = array();
				}
				var_2a4308b9 = level.var_93d08989[targetname].size;
				level.var_93d08989[targetname][var_2a4308b9] = dynent;
				setdynentenabled(dynent, 1);
				function_e2a06860(dynent, 0);
				self function_ea39d1fa(dynent);
				var_c041d1bd++;
			}
		}
		pointindex++;
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	for(var_63d7a070 = var_c041d1bd; var_63d7a070 < var_418a2e03.size; var_63d7a070++)
	{
		dynent = var_418a2e03[var_63d7a070];
		setdynentenabled(dynent, 0);
	}
}

/*
	Name: _spawn
	Namespace: namespace_65181344
	Checksum: 0x3F2D204C
	Offset: 0x2BD8
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function _spawn(reset)
{
	if(isdefined(self.var_b91441dd.var_f4cdfe08) && self.var_b91441dd.var_f4cdfe08)
	{
		self function_216a69d6((isdefined(self.var_b91441dd.var_fde72c94) ? self.var_b91441dd.var_fde72c94 : 100), reset);
	}
	else
	{
		self function_e25c9d12(self.var_8107154f, self.var_8107154f.size);
	}
}

/*
	Name: _setup
	Namespace: namespace_65181344
	Checksum: 0x9F19E227
	Offset: 0x2C80
	Size: 0x242
	Parameters: 0
	Flags: Linked, Private
*/
private function _setup()
{
	self.var_b91441dd = getscriptbundle(self.scriptbundlename);
	if(isdefined(self.var_b91441dd) && isdefined(level.var_fb9a8536[self.var_b91441dd.name]))
	{
		self.var_b91441dd = getscriptbundle(level.var_fb9a8536[self.var_b91441dd.name]);
	}
	/#
		assert(isdefined(self.var_b91441dd), "" + self.scriptbundlename + "");
	#/
	/#
		assert(isdefined(self.var_b91441dd.itemlist), "" + self.scriptbundlename + "");
	#/
	self.remaining = (isdefined(self.count) ? self.count : 0);
	self.points = function_d0dc448b(self.target);
	self.var_8107154f = [];
	foreach(var_13d946ef in self.points)
	{
		self.var_8107154f[var_13d946ef] = var_13d946ef;
	}
	if(!isdefined(level.var_28cd0b1f[self.target]))
	{
		/#
			assert(isdefined(self.points) && self.points.size > 0, "" + self.var_b91441dd.name + "" + self.target);
		#/
	}
	if(!isdefined(self.points))
	{
		self.points = [];
	}
}

/*
	Name: function_a71c4d18
	Namespace: namespace_65181344
	Checksum: 0x87BA8A9E
	Offset: 0x2ED0
	Size: 0x76
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a71c4d18()
{
	self.points = undefined;
	self.var_8107154f = undefined;
	self.var_b91441dd = undefined;
	self.angles = undefined;
	self.available = undefined;
	self.var_ccc6d5b7 = undefined;
	self.modelscale = undefined;
	self.remaining = undefined;
	self.var_3ddde668 = undefined;
	self.var_5d3a106 = undefined;
	self.var_202d2992 = undefined;
	self.rows = undefined;
	self.weights = undefined;
	self.var_ac9f1dc8 = undefined;
}

/*
	Name: function_3095d12a
	Namespace: namespace_65181344
	Checksum: 0x78A3CAF7
	Offset: 0x2F50
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_3095d12a()
{
	if(isdefined(level.var_ccc3aaf))
	{
		return;
	}
	level.var_ccc3aaf = 1;
	flagsys::set(#"hash_14b8213ddc0feac");
}

/*
	Name: function_9db93def
	Namespace: namespace_65181344
	Checksum: 0x212E03F2
	Offset: 0x2FA0
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9db93def()
{
	/#
		assert(isdefined(self.target) && self.target != "", "" + self.origin + "");
	#/
	/#
		assert(self.target !== self.targetname, "" + self.origin + "" + self.target + "");
	#/
}

/*
	Name: function_6b9be08d
	Namespace: namespace_65181344
	Checksum: 0xBE8DE2EB
	Offset: 0x3050
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6b9be08d()
{
	return getdvarint(#"hash_21e070fbb56cf0f", 1);
}

/*
	Name: function_e25c9d12
	Namespace: namespace_65181344
	Checksum: 0xD8D56BAF
	Offset: 0x3088
	Size: 0x1364
	Parameters: 4
	Flags: Linked, Private
*/
private function function_e25c9d12(var_8107154f, spawncount, var_be90d3da = 0, var_a1b91de4 = undefined)
{
	if(!isstruct(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	/#
		if(isdefined(self.points) && isdefined(self.target))
		{
			level.var_2e96a450[self.target] = self.points.size;
		}
	#/
	/#
		assert(isstruct(self));
	#/
	/#
		assert(isarray(var_8107154f));
	#/
	/#
		assert(isint(spawncount));
	#/
	/#
		assert(isdefined(self.var_b91441dd));
	#/
	/#
		assert(!(isdefined(self.var_ca330541) && self.var_ca330541));
	#/
	/#
		assert(!(isdefined(self.var_f4cdfe08) && self.var_f4cdfe08));
	#/
	if(spawncount <= 0)
	{
		return;
	}
	items = [];
	self.rows = (isdefined(self.var_b91441dd.itemlist.size) ? self.var_b91441dd.itemlist.size : 0);
	self.count = spawncount;
	self.available = [];
	self.weights = [];
	self.var_ac9f1dc8 = 0;
	for(row = 0; row < self.rows; row++)
	{
		self.available[row] = (isdefined(self.var_b91441dd.itemlist[row].available) ? self.var_b91441dd.itemlist[row].available : 0);
		if(self.available[row] != 0)
		{
			var_35843db5 = (isdefined(self.var_b91441dd.itemlist[row].minweight) ? self.var_b91441dd.itemlist[row].minweight : 0);
			var_ccef9e25 = (isdefined(self.var_b91441dd.itemlist[row].maxweight) ? self.var_b91441dd.itemlist[row].maxweight : 0);
			minweight = int(min(var_35843db5, var_ccef9e25));
			maxweight = int(max(var_35843db5, var_ccef9e25));
			diff = maxweight - minweight;
			weight = function_d59c2d03(diff + 1) + minweight;
			self.weights[row] = weight;
			self.var_ac9f1dc8 = self.var_ac9f1dc8 + self.weights[row];
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	var_399d601b = spawncount;
	var_413b71b8 = self.var_ac9f1dc8;
	self.var_ac9f1dc8 = 0;
	for(row = 0; row < self.rows; row++)
	{
		if(self.available[row] == 0)
		{
			continue;
		}
		if(self.available[row] < 0)
		{
			self.var_ac9f1dc8 = self.var_ac9f1dc8 + self.weights[row];
			continue;
		}
		points = self.weights[row] / var_413b71b8 * var_399d601b;
		if(points > self.available[row])
		{
			self.weights[row] = 2147483647;
			spawncount = spawncount - self.available[row];
			continue;
		}
		self.var_ac9f1dc8 = self.var_ac9f1dc8 + self.weights[row];
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	self.var_202d2992 = [];
	self.var_3ddde668 = [];
	self.var_43feff59 = 0;
	self.var_5d3a106 = 0;
	var_47b33860 = spawncount / max(self.var_ac9f1dc8, 1);
	for(row = 0; row < self.rows; row++)
	{
		if(self.available[row] != 0)
		{
			if(self.weights[row] == 2147483647)
			{
				points = self.available[row];
			}
			else
			{
				points = self.weights[row] * var_47b33860;
			}
			self.var_202d2992[row] = int(floor(points));
			self.var_3ddde668[row] = int(points - self.var_202d2992[row] * 1000);
			self.var_43feff59 = self.var_43feff59 + self.var_202d2992[row];
			self.var_5d3a106 = self.var_5d3a106 + self.var_3ddde668[row];
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	arrayremovevalue(self.var_202d2992, 0, 1);
	arrayremovevalue(self.var_3ddde668, 0, 1);
	/#
		assert(self.var_43feff59 <= var_399d601b);
	#/
	var_c499a7fa = getarraykeys(self.var_3ddde668);
	if(self.var_5d3a106 > 0)
	{
		for(pointindex = self.var_43feff59; pointindex < spawncount && self.var_5d3a106 > 0; pointindex++)
		{
			randomval = function_d59c2d03(self.var_5d3a106);
			var_28ef6352 = 0;
			for(var_56c03814 = 0; var_56c03814 < self.var_3ddde668.size; var_56c03814++)
			{
				var_75aa5cbb = var_c499a7fa[var_c499a7fa.size - var_56c03814 - 1];
				if(self.available[var_75aa5cbb] != 0)
				{
					var_cc5fea3d = var_28ef6352 + self.var_3ddde668[var_75aa5cbb];
					if(var_28ef6352 <= randomval && randomval <= var_cc5fea3d)
					{
						self.var_5d3a106 = self.var_5d3a106 - self.var_3ddde668[var_75aa5cbb];
						self.var_3ddde668[var_75aa5cbb] = 0;
						self.var_202d2992[var_75aa5cbb] = (isdefined(self.var_202d2992[var_75aa5cbb]) ? self.var_202d2992[var_75aa5cbb] : 0) + 1;
						self.var_43feff59++;
						break;
					}
					var_28ef6352 = var_cc5fea3d;
				}
			}
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	/#
		assert(self.var_43feff59 <= var_399d601b);
	#/
	if(!isdefined(var_a1b91de4))
	{
		var_a1b91de4 = getarraykeys(var_8107154f);
		for(index = 0; index < var_8107154f.size; index++)
		{
			randindex = function_d59c2d03(var_8107154f.size);
			var_521b73a = var_8107154f[var_a1b91de4[randindex]];
			var_8107154f[var_a1b91de4[randindex]] = var_8107154f[var_a1b91de4[index]];
			var_8107154f[var_a1b91de4[index]] = var_521b73a;
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	self.var_ccc6d5b7 = [];
	var_7a7ab6bf = 0;
	var_a9826383 = 0;
	arraykeys = getarraykeys(self.var_202d2992);
	var_f5111345 = 0;
	pointindex = 0;
	while(var_f5111345 < arraykeys.size && var_7a7ab6bf < self.count)
	{
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
		var_75aa5cbb = arraykeys[var_f5111345];
		if(pointindex >= var_8107154f.size)
		{
			/#
				assert(var_a9826383 === 0);
			#/
			var_a9826383 = 1;
			pointindex = 0;
		}
		if(var_8107154f[var_a1b91de4[pointindex]] == -1)
		{
		}
		else
		{
			var_a6762160 = self.var_b91441dd.itemlist[var_75aa5cbb].var_a6762160;
			if(isdefined(var_a6762160) && var_a6762160 != "")
			{
				scriptbundle = (isdefined(level.var_de3d5d56[var_a6762160]) ? level.var_de3d5d56[var_a6762160] : getscriptbundle(var_a6762160));
				if(isdefined(scriptbundle) && isdefined(scriptbundle.type) && (scriptbundle.type == #"itemspawnlist" || scriptbundle.type == #"hash_3b34ec2d17821763"))
				{
					self.var_ccc6d5b7[var_75aa5cbb] = self.var_202d2992[var_75aa5cbb];
					self.var_202d2992[var_75aa5cbb] = 0;
					var_f5111345++;
				}
			}
			else if(var_8107154f[var_a1b91de4[pointindex]] == -2)
			{
				var_9ffcb596 = self function_35461e5f(var_75aa5cbb, var_be90d3da);
				items = arraycombine(items, var_9ffcb596, 1, 0);
			}
			else
			{
				var_f77e15f6 = function_b1702735(var_8107154f[var_a1b91de4[pointindex]]);
				if(isdefined(self.var_b91441dd.var_7fb0967b) && !var_a9826383)
				{
					var_8822f354 = 0;
					itemtype = undefined;
					if(isdefined(var_a6762160))
					{
						scriptbundle = (isdefined(level.var_de3d5d56[var_a6762160]) ? level.var_de3d5d56[var_a6762160] : getscriptbundle(var_a6762160));
						if(isdefined(scriptbundle))
						{
							itemtype = scriptbundle.itemtype;
						}
					}
					if(isdefined(self.var_b91441dd.var_dc7ffbef) && isdefined(itemtype))
					{
						if(itemtype == #"vehicle")
						{
							vehicles = getvehiclearray();
							var_7150cb21 = arraysortclosest(vehicles, var_f77e15f6.origin, 1, 0, self.var_b91441dd.var_7fb0967b);
							var_8822f354 = var_7150cb21.size;
						}
						else
						{
							var_8822f354 = function_579fdc53(var_f77e15f6.origin, undefined, itemtype, self.var_b91441dd.var_7fb0967b, -1, 2147483647);
						}
					}
					else
					{
						var_8822f354 = function_6de8969b(var_f77e15f6.origin, undefined, self.var_b91441dd.var_7fb0967b, -1, 1, 2147483647);
					}
					if(var_8822f354 > 0)
					{
					}
				}
				self function_a0a5aec6(var_f77e15f6, var_75aa5cbb, var_be90d3da);
			}
			else
			{
				var_8107154f[var_a1b91de4[pointindex]] = -1;
				self.var_202d2992[var_75aa5cbb]--;
				var_7a7ab6bf++;
				if(self.var_202d2992[var_75aa5cbb] == 0)
				{
					var_f5111345++;
				}
			}
		}
		pointindex++;
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	for(index = 0; index < self.var_b91441dd.itemlist.size; index++)
	{
		if(!isdefined(self.var_ccc6d5b7[index]))
		{
			continue;
		}
		itemlist = self.var_b91441dd.itemlist[index];
		if(!isdefined(itemlist.var_a6762160) || itemlist.var_a6762160 === "")
		{
			continue;
		}
		var_b91441dd = getscriptbundle(itemlist.var_a6762160);
		if(!isdefined(var_b91441dd.type) || (var_b91441dd.type != #"itemspawnlist" && var_b91441dd.type != #"hash_3b34ec2d17821763"))
		{
			continue;
		}
		if(var_b91441dd.type == #"hash_3b34ec2d17821763")
		{
			var_12ab6449 = function_440f0490(var_b91441dd);
			if(!isdefined(var_12ab6449))
			{
				continue;
			}
			var_b91441dd = var_12ab6449;
		}
		if(isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name]))
		{
			var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
		}
		itemspawnlist = spawnstruct();
		itemspawnlist.var_b91441dd = var_b91441dd;
		itemspawnlist.origin = self.origin;
		itemspawnlist.angles = self.angles;
		var_4168f4f3 = itemspawnlist function_e25c9d12(var_8107154f, self.var_ccc6d5b7[index], var_be90d3da, var_a1b91de4);
		items = arraycombine(items, var_4168f4f3, 1, 0);
	}
	return items;
}

/*
	Name: function_c6477714
	Namespace: namespace_65181344
	Checksum: 0x6D0B1790
	Offset: 0x43F8
	Size: 0x4C4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c6477714(reset)
{
	override = spawnstruct();
	override.scriptbundlename = #"hash_2793921166478849";
	override.var_b91441dd = getscriptbundle(override.scriptbundlename);
	override.var_ebfb74b9 = function_8322cf16();
	var_8107154f = [];
	for(index = 0; index < override.var_ebfb74b9; index++)
	{
		var_8107154f[index] = index;
	}
	var_1d9375fc = struct::get_array("scriptbundle_itemspawnlist", "classname");
	foreach(group in var_1d9375fc)
	{
		group.var_b91441dd = getscriptbundle(group.scriptbundlename);
		if(isdefined(group.var_b91441dd.var_ca330541) && group.var_b91441dd.var_ca330541)
		{
			spawnpoints = function_91b29d2a(group.target);
			foreach(spawnpoint in spawnpoints)
			{
				var_8107154f[spawnpoint.id] = -1;
				override.var_ebfb74b9--;
			}
			group function_9db93def();
			group _setup();
			group _spawn(reset);
		}
	}
	foreach(group in var_1d9375fc)
	{
		group.var_b91441dd = getscriptbundle(group.scriptbundlename);
		if(isdefined(group.var_b91441dd.var_f4cdfe08) && group.var_b91441dd.var_f4cdfe08)
		{
			dynents = getdynentarray(group.target, 1);
			foreach(dynent in dynents)
			{
				level.var_5862f2ce[level.var_5862f2ce.size] = dynent;
				setdynentenabled(dynent, 0);
			}
			spawnpoints = function_91b29d2a(group.target);
			foreach(spawnpoint in spawnpoints)
			{
				var_8107154f[spawnpoint.id] = -1;
				override.var_ebfb74b9--;
			}
		}
	}
	override function_e25c9d12(var_8107154f, override.var_ebfb74b9);
}

/*
	Name: function_62fdaf9e
	Namespace: namespace_65181344
	Checksum: 0x4591F687
	Offset: 0x48C8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_62fdaf9e()
{
	keys = getarraykeys(level.struct);
	for(index = 0; index < keys.size; index++)
	{
		key = keys[index];
		value = level.struct[key];
		if(!isdefined(value))
		{
			continue;
		}
		if(isdefined(value.classname) && value.classname == #"scriptbundle_itemspawnlist")
		{
			level.struct[key] = undefined;
		}
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
	arrayremovevalue(level.struct, undefined, 0);
}

/*
	Name: init_spawn_system
	Namespace: namespace_65181344
	Checksum: 0x5CE1D65D
	Offset: 0x4A08
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function init_spawn_system()
{
	level.var_d0676b07 = getrealtime();
	level.var_3e9c9a35 = 30;
	function_2c4d3d40();
	function_3095d12a();
}

/*
	Name: is_enabled
	Namespace: namespace_65181344
	Checksum: 0xAEE4BDE7
	Offset: 0x4A68
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function is_enabled()
{
	return isdefined(getgametypesetting(#"useitemspawns")) && getgametypesetting(#"useitemspawns");
}

/*
	Name: function_6a80751c
	Namespace: namespace_65181344
	Checksum: 0x68A3FD88
	Offset: 0x4AC0
	Size: 0x5C2
	Parameters: 0
	Flags: Linked
*/
function function_6a80751c()
{
	var_f6e761cd = function_c77ddcd6();
	for(var_13d946ef = 0; var_13d946ef < var_f6e761cd; var_13d946ef++)
	{
		point = function_b1702735(var_13d946ef);
		var_a6762160 = point.var_a6762160;
		if(!isdefined(var_a6762160))
		{
			continue;
		}
		origin = point.origin;
		angles = point.angles;
		loc_00004BF2:
		loc_00004C12:
		angles = function_bdd10bae(angles, ((isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0), (isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0), (isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0)));
		if(!isdefined(var_a6762160.var_47f145b4))
		{
			angles = function_bdd10bae(angles, (0, angleclamp180(origin[0] + origin[1] + origin[2]), 0));
		}
		loc_00004CCE:
		loc_00004CF6:
		originoffset = ((isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0) * -1, (isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0) * -1, (isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0) * -1);
		origin = origin + originoffset;
		function_b97dfce0(point.id, origin);
		function_3eab95b5(point.id, angles);
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
	function_682385e7();
	if(isarray(level.var_a4a4012e))
	{
		foreach(item in level.var_a4a4012e)
		{
			if(isdefined(item))
			{
				item delete();
			}
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	level.var_a4a4012e = [];
	if(isarray(level.var_8ac64bf3))
	{
		foreach(stash in level.var_8ac64bf3)
		{
			if(isdefined(stash))
			{
				stash delete();
			}
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	level.var_8ac64bf3 = [];
	if(isarray(level.var_d79f1ee4))
	{
		foreach(vehicle in level.var_d79f1ee4)
		{
			if(isdefined(vehicle))
			{
				vehicle delete();
			}
		}
	}
	if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
	{
		waitframe(1);
		level.var_d0676b07 = getrealtime();
	}
	level.var_d79f1ee4 = [];
	level.var_8819644a = [];
	level.var_a4a4012e = [];
}

/*
	Name: function_50a2c746
	Namespace: namespace_65181344
	Checksum: 0x755DA753
	Offset: 0x5090
	Size: 0x3EE
	Parameters: 3
	Flags: Linked
*/
function function_50a2c746(var_f38d5b52, reset = 1, var_87e9f374 = 0)
{
	/#
		assert(isarray(var_f38d5b52));
	#/
	/#
		if(var_87e9f374)
		{
		}
	#/
	var_1d9375fc = struct::get_array("scriptbundle_itemspawnlist", "classname");
	foreach(group in var_1d9375fc)
	{
		if(!isdefined(group.target))
		{
			continue;
		}
		var_b91441dd = getscriptbundle(group.scriptbundlename);
		if(isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name]))
		{
			var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
		}
		if(!isdefined(var_b91441dd))
		{
			continue;
		}
		if(var_87e9f374)
		{
			if(!(isdefined(var_b91441dd.var_dc91e192) && var_b91441dd.var_dc91e192) || (!(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08)))
			{
				continue;
			}
		}
		else if(isdefined(var_b91441dd.var_dc91e192) && var_b91441dd.var_dc91e192 && (isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08))
		{
			continue;
		}
		if(isdefined(var_f38d5b52[group.target]))
		{
			if(!(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08))
			{
				continue;
			}
		}
		var_f38d5b52[group.target] = 1;
		if(getdvarint(#"hash_424f2e897e67b1ba", 0))
		{
			if(!(isdefined(var_b91441dd.var_bb617d29) && var_b91441dd.var_bb617d29) && (!(isdefined(var_b91441dd.var_f4cdfe08) && var_b91441dd.var_f4cdfe08)) && (!(isdefined(var_b91441dd.var_ca330541) && var_b91441dd.var_ca330541)))
			{
				continue;
			}
		}
		else if(isdefined(var_b91441dd.var_bb617d29) && var_b91441dd.var_bb617d29)
		{
			continue;
		}
		group function_9db93def();
		group _setup();
		group _spawn(reset);
		group function_a71c4d18();
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
	}
	return var_f38d5b52;
}

/*
	Name: setup_groups
	Namespace: namespace_65181344
	Checksum: 0x97F2E01A
	Offset: 0x5488
	Size: 0x6D6
	Parameters: 1
	Flags: Linked
*/
function setup_groups(reset = 1)
{
	if(reset)
	{
		level flagsys::set(#"hash_67b445a4b1d59922");
	}
	else
	{
		level flagsys::set(#"hash_11c9cde7b522c5a9");
	}
	flagsys::wait_till(#"hash_14b8213ddc0feac");
	/#
		if(!isdefined(level.var_55f723bd))
		{
			level.var_3683df16 = 0;
			level.var_3062619 = "";
			level.var_55f723bd = openfile("", "");
		}
	#/
	/#
		if(reset)
		{
		}
	#/
	starttime = gettime();
	level.var_d0676b07 = getrealtime();
	level.var_4afb8f5a = (reset ? level.var_f726653d : level.var_ee46a98d);
	foreach(value in level.var_4afb8f5a)
	{
	}
	level.var_fb9a8536 = (reset ? level.var_ee110db8 : level.var_db0e7b82);
	foreach(value in level.var_fb9a8536)
	{
	}
	if(!isdefined(level.var_28cd0b1f))
	{
		level.var_28cd0b1f = [];
	}
	if(reset)
	{
		function_6a80751c();
	}
	function_e88ecf7f();
	function_9e9f43cd();
	level.var_5862f2ce = [];
	level.var_5ce07338 = [];
	level.var_93d08989 = [];
	level.var_d79f1ee4 = [];
	level.var_8819644a = [];
	level.var_5b2a8d88 = [];
	level.var_cc113617 = [5:270, 4:225, 3:315, 2:120, 1:50, 0:-130];
	level.var_82e94a26 = [5:0, 4:5, 3:-15, 2:-5, 1:10];
	level.var_69dda516 = [5:25, 4:25, 3:25, 2:32, 1:34, 0:17];
	/#
		level.var_136445c0 = 0;
		level.var_d80c35aa = [];
		level.var_5720c09a = 0;
		level.var_8d9ad8e8 = [];
		level.var_2850ef5 = 0;
		level.var_ecf16fd3 = [];
		level.var_f2db6a7f = 0;
	#/
	if(isdefined(function_6b9be08d()) && function_6b9be08d() == 1)
	{
		function_c6477714(reset);
	}
	else
	{
		var_f38d5b52 = [];
		function_50a2c746(var_f38d5b52, reset, 1);
		if(getrealtime() - level.var_d0676b07 > level.var_3e9c9a35)
		{
			waitframe(1);
			level.var_d0676b07 = getrealtime();
		}
		function_50a2c746(var_f38d5b52, reset, 0);
	}
	/#
		level.var_a7247d85 = function_8322cf16();
		level.var_66e56764 = level.var_136445c0 + level.var_5720c09a + level.var_2850ef5;
		level.var_efeab371 = [];
		foreach(type, count in level.var_d80c35aa)
		{
			loc_00005A40:
			level.var_efeab371[type] = (isdefined(count) ? count : 0) + (isdefined(level.var_8d9ad8e8[type]) ? level.var_8d9ad8e8[type] : 0) + (isdefined(level.var_ecf16fd3[type]) ? level.var_ecf16fd3[type] : 0);
		}
	#/
	/#
		foreach(count in level.var_efeab371)
		{
		}
	#/
	if(reset)
	{
		function_62fdaf9e();
		function_6a5c090c();
	}
	/#
		if(reset)
		{
			closefile(level.var_55f723bd);
			level.var_55f723bd = undefined;
		}
	#/
	level.var_f1f90fd3 = float(gettime() - starttime) / 1000;
}

/*
	Name: function_5eada592
	Namespace: namespace_65181344
	Checksum: 0x4D5F0B33
	Offset: 0x5B68
	Size: 0x442
	Parameters: 2
	Flags: Linked
*/
function function_5eada592(scriptbundlename, linkto = 1)
{
	if(!isdefined(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(scriptbundlename))
	{
		/#
			assert(0);
		#/
		return;
	}
	self.var_b91441dd = getscriptbundle(scriptbundlename);
	if(!isdefined(self.var_b91441dd))
	{
		/#
			assert(0);
		#/
		return;
	}
	items = [];
	for(row = 0; row < self.var_b91441dd.itemlist.size; row++)
	{
		if(!isdefined(self.var_b91441dd.itemlist[row].var_a6762160))
		{
			continue;
		}
		var_b91441dd = getscriptbundle(self.var_b91441dd.itemlist[row].var_a6762160);
		var_bbe618cc = var_b91441dd.type == #"itemspawnlist" || var_b91441dd.type == #"hash_3b34ec2d17821763";
		available = (isdefined(self.var_b91441dd.itemlist[row].available) ? self.var_b91441dd.itemlist[row].available : 0);
		var_8107154f = [];
		do
		{
			var_8107154f[var_8107154f.size] = -2;
			if(!var_bbe618cc)
			{
				var_9ffcb596 = function_35461e5f(row, 1);
				items = arraycombine(items, var_9ffcb596, 1, 0);
			}
			available--;
		}
		while(available > 0);
		if(var_bbe618cc)
		{
			if(var_b91441dd.type == #"hash_3b34ec2d17821763")
			{
				var_12ab6449 = function_440f0490(var_b91441dd);
				if(!isdefined(var_12ab6449))
				{
					continue;
				}
				var_b91441dd = var_12ab6449;
			}
			if(isdefined(var_b91441dd) && isdefined(level.var_fb9a8536[var_b91441dd.name]))
			{
				var_b91441dd = getscriptbundle(level.var_fb9a8536[var_b91441dd.name]);
			}
			itemspawnlist = spawnstruct();
			itemspawnlist.var_b91441dd = var_b91441dd;
			var_9ffcb596 = itemspawnlist function_e25c9d12(var_8107154f, var_8107154f.size, 1);
			items = arraycombine(items, var_9ffcb596, 1, 0);
		}
	}
	foreach(item in items)
	{
		if(!isdefined(item))
		{
			continue;
		}
		item.var_67169c0b = self.targetname;
		item.origin = self.origin;
		if(linkto)
		{
			item linkto(self);
		}
		item.spawning = 0;
	}
	return items;
}

/*
	Name: function_fd87c780
	Namespace: namespace_65181344
	Checksum: 0xAF13F82A
	Offset: 0x5FB8
	Size: 0x1EA
	Parameters: 2
	Flags: Linked
*/
function function_fd87c780(scriptbundlename, itemcount)
{
	if(!isdefined(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(scriptbundlename))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isint(itemcount) || itemcount <= 0)
	{
		/#
			assert(0);
		#/
		return;
	}
	itemgroup = spawnstruct();
	itemgroup.var_b91441dd = getscriptbundle(scriptbundlename);
	itemgroup.origin = self.origin;
	itemgroup.angles = self.angles;
	var_8107154f = [];
	for(var_13d946ef = 0; var_13d946ef < itemcount; var_13d946ef++)
	{
		var_8107154f[var_8107154f.size] = -2;
	}
	items = itemgroup function_e25c9d12(var_8107154f, var_8107154f.size, 0);
	foreach(item in items)
	{
		if(!isdefined(item))
		{
			continue;
		}
		item.spawning = 0;
	}
	return items;
}

