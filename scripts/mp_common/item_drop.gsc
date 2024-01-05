// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_util.gsc;
#using scripts\mp_common\item_world.gsc;
#using script_6b993fdc7adc35ec;
#using scripts\mp_common\item_inventory.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace item_drop;

/*
	Name: __init__system__
	Namespace: item_drop
	Checksum: 0x99494908
	Offset: 0x278
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"item_drop", &__init__, undefined, #"item_world");
}

/*
	Name: __init__
	Namespace: item_drop
	Checksum: 0x839E9DB7
	Offset: 0x2C8
	Size: 0x27C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(getgametypesetting(#"useitemspawns")) || getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	clientfield::register("missile", "dynamic_item_drop", 10000, 3, "int");
	clientfield::register("missile", "dynamic_item_drop_count", 11000, 10, "int");
	clientfield::register("scriptmover", "dynamic_item_drop", 10000, 3, "int");
	clientfield::register("scriptmover", "dynamic_item_drop_count", 11000, 10, "int");
	clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int");
	clientfield::register("scriptmover", "dynamic_stash_type", 1, 2, "int");
	if(!isdefined(level.var_98d0ae2b))
	{
		level.var_98d0ae2b = new throttle();
		[[ level.var_98d0ae2b ]]->initialize(2, 0.05);
	}
	if(!isdefined(level.var_19011fa7))
	{
		level.var_19011fa7 = new throttle();
		[[ level.var_19011fa7 ]]->initialize(2, 0.05);
	}
	level.disableweapondrop = 1;
	level.var_ace9fb52 = [];
	level.item_spawn_drops = [];
	level.var_18dc9d17 = [];
	level.var_8ac64bf3 = [];
	level.var_19e75cfb = [];
	level.var_2746aef8 = &function_ba4c90d9;
	/#
		function_344f8c02();
	#/
}

/*
	Name: function_344f8c02
	Namespace: item_drop
	Checksum: 0xF28DA510
	Offset: 0x550
	Size: 0x54
	Parameters: 0
	Flags: Private
*/
function private function_344f8c02()
{
	/#
		adddebugcommand(("" + util::get_map_name()) + "");
		level thread function_60c9a9e1();
	#/
}

/*
	Name: function_60c9a9e1
	Namespace: item_drop
	Checksum: 0x83CC1389
	Offset: 0x5B0
	Size: 0x76
	Parameters: 0
	Flags: Private
*/
function private function_60c9a9e1()
{
	/#
		while(true)
		{
			if(getdvarint(#"hash_9fd3c7ff85dca2c", 0))
			{
				setdvar(#"hash_9fd3c7ff85dca2c", 0);
				function_8a5fd783();
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_3b2b6383
	Namespace: item_drop
	Checksum: 0xDEF8ED9
	Offset: 0x630
	Size: 0x1CA
	Parameters: 5
	Flags: Linked, Private
*/
function private function_3b2b6383(origin, angles, normal, var_a6762160, var_ba40b4c1)
{
	angles = function_c1fa62a2(angles, normal);
	angles = combineangles(angles, (0, angleclamp180((origin[0] + origin[1]) + origin[2]), 0));
	if(isdefined(var_a6762160))
	{
		if(var_ba40b4c1 && (isdefined(var_a6762160.var_32ceba33) && var_a6762160.var_32ceba33))
		{
			loc_0000071A:
			loc_0000073A:
			angles = combineangles(angles, ((isdefined(var_a6762160.var_d1f348db) ? var_a6762160.var_d1f348db : 0), (isdefined(var_a6762160.var_cc1bbd2c) ? var_a6762160.var_cc1bbd2c : 0), (isdefined(var_a6762160.var_ae6581c0) ? var_a6762160.var_ae6581c0 : 0)));
		}
		else
		{
			loc_0000079A:
			loc_000007BA:
			angles = combineangles(angles, ((isdefined(var_a6762160.var_7adcadc1) ? var_a6762160.var_7adcadc1 : 0), (isdefined(var_a6762160.var_6731866b) ? var_a6762160.var_6731866b : 0), (isdefined(var_a6762160.var_e6ac0592) ? var_a6762160.var_e6ac0592 : 0)));
		}
	}
	return angles;
}

/*
	Name: function_feb1473
	Namespace: item_drop
	Checksum: 0x3D5A2684
	Offset: 0x808
	Size: 0x12E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_feb1473(var_a6762160, var_ba40b4c1)
{
	origin = (0, 0, 0);
	if(isdefined(var_a6762160))
	{
		if(var_ba40b4c1 && (isdefined(var_a6762160.var_32ceba33) && var_a6762160.var_32ceba33))
		{
			loc_0000087E:
			loc_0000089E:
			origin = ((isdefined(var_a6762160.var_8a122876) ? var_a6762160.var_8a122876 : 0), (isdefined(var_a6762160.var_7c4c8ceb) ? var_a6762160.var_7c4c8ceb : 0), (isdefined(var_a6762160.var_ee67711f) ? var_a6762160.var_ee67711f : 0));
		}
		else
		{
			loc_000008EA:
			loc_0000090A:
			origin = ((isdefined(var_a6762160.var_ada071fe) ? var_a6762160.var_ada071fe : 0), (isdefined(var_a6762160.var_5ab74bb1) ? var_a6762160.var_5ab74bb1 : 0), (isdefined(var_a6762160.var_50773731) ? var_a6762160.var_50773731 : 0));
		}
	}
	return origin;
}

/*
	Name: function_a3675ae5
	Namespace: item_drop
	Checksum: 0xB6F99EA1
	Offset: 0x940
	Size: 0x4C
	Parameters: 0
	Flags: Private
*/
function private function_a3675ae5()
{
	return (randomintrange(-10, 10), randomintrange(-180, 180), randomintrange(-10, 10));
}

/*
	Name: function_32b2794
	Namespace: item_drop
	Checksum: 0x350A685F
	Offset: 0x998
	Size: 0x7A
	Parameters: 1
	Flags: Private
*/
function private function_32b2794(degree)
{
	distance = randomintrange(48, 60);
	return (cos(degree) * distance, sin(degree) * distance, randomintrange(24, 36));
}

/*
	Name: function_44a6883c
	Namespace: item_drop
	Checksum: 0x9EA4E9FE
	Offset: 0xA20
	Size: 0x552
	Parameters: 6
	Flags: Linked, Private
*/
function private function_44a6883c(&drop_item_id, &drop_items, &drop_count, &drop_amount, var_4a5c0085 = 1, var_fee0423a = 0)
{
	var_f55ea9e5 = drop_item_id.size;
	for(index = 0; index < var_f55ea9e5; index++)
	{
		if(!isdefined(drop_item_id[index]))
		{
			continue;
		}
		item = function_b1702735(drop_item_id[index]);
		var_a6762160 = item.var_a6762160;
		itemname = item_world_util::get_itemtype(var_a6762160);
		if(var_a6762160.itemtype == #"weapon")
		{
			continue;
		}
		var_a057551d = namespace_a0d533d1::function_cfa794ca(0, var_a6762160);
		if(var_fee0423a && (!(isdefined(var_a6762160.stackable) && var_a6762160.stackable)))
		{
			for(var_604c3ae6 = 0; var_604c3ae6 < index; var_604c3ae6++)
			{
				if(drop_item_id[var_604c3ae6] == -1)
				{
					continue;
				}
				var_92d652f2 = function_b1702735(drop_item_id[var_604c3ae6]);
				var_f6a3c690 = var_92d652f2.var_a6762160;
				var_fa38de52 = item_world_util::get_itemtype(var_f6a3c690);
				if(itemname != var_fa38de52)
				{
					continue;
				}
				drop_count[var_604c3ae6] = drop_count[var_604c3ae6] + drop_count[index];
				drop_item_id[index] = -1;
				drop_items[index] = undefined;
				drop_count[index] = undefined;
				drop_amount[index] = undefined;
			}
		}
		if(!(isdefined(var_a6762160.stackable) && var_a6762160.stackable))
		{
			continue;
		}
		if(var_4a5c0085)
		{
			if(var_a057551d <= 1)
			{
				continue;
			}
			if(drop_count[index] == var_a057551d)
			{
				continue;
			}
			if(drop_count[index] > var_a057551d)
			{
				excess = drop_count[index] - var_a057551d;
				drop_count[index] = var_a057551d;
				drop_item_id[var_f55ea9e5] = drop_item_id[index];
				if(isdefined(drop_items[index]))
				{
					drop_items[var_f55ea9e5] = drop_items[index];
				}
				drop_count[var_f55ea9e5] = excess;
				drop_amount[var_f55ea9e5] = drop_amount[index];
				var_f55ea9e5++;
				continue;
			}
		}
		if(!isdefined(drop_count[index]) || drop_count[index] <= 0)
		{
			continue;
		}
		for(var_604c3ae6 = 0; var_604c3ae6 < index; var_604c3ae6++)
		{
			if(!isdefined(drop_count[index]) || drop_count[index] <= 0)
			{
				break;
			}
			if(drop_item_id[var_604c3ae6] == -1)
			{
				continue;
			}
			var_92d652f2 = function_b1702735(drop_item_id[var_604c3ae6]);
			var_f6a3c690 = var_92d652f2.var_a6762160;
			var_fa38de52 = item_world_util::get_itemtype(var_f6a3c690);
			if(itemname != var_fa38de52)
			{
				continue;
			}
			excess = drop_count[index];
			if(var_4a5c0085)
			{
				var_8429965a = var_a057551d - drop_count[var_604c3ae6];
				excess = int(min(var_8429965a, drop_count[index]));
			}
			drop_count[var_604c3ae6] = drop_count[var_604c3ae6] + excess;
			drop_count[index] = drop_count[index] - excess;
			if(drop_count[index] <= 0)
			{
				/#
					assert(drop_count[index] == 0);
				#/
				drop_item_id[index] = -1;
				drop_items[index] = undefined;
				drop_count[index] = undefined;
				drop_amount[index] = undefined;
				break;
			}
		}
	}
}

/*
	Name: function_23b6897
	Namespace: item_drop
	Checksum: 0x2265192C
	Offset: 0xF80
	Size: 0x942
	Parameters: 2
	Flags: Linked, Private
*/
function private function_23b6897(player, position)
{
	if(isplayer(player))
	{
		heightoffset = max(player getplayerviewheight() + -20, 18);
		var_891dc751 = (0, 0, heightoffset);
		centerpoint = player.origin;
		var_bb96e272 = position - centerpoint;
		var_bb96e272 = (var_bb96e272[0], var_bb96e272[1], 0);
		var_bb96e272 = vectornormalize(var_bb96e272);
		forward = (1, 0, 0);
		theta = vectortoangles(var_bb96e272)[1] - vectortoangles(forward)[1];
		var_9942a6e3 = 13;
		var_ed81de82 = var_9942a6e3 * var_9942a6e3;
		var_f6c0e955 = 25;
		var_f24d242c = var_f6c0e955 * var_f6c0e955;
		var_93296058 = 40;
		var_c8214507 = var_93296058 * var_93296058;
		var_408cb959 = 43;
		var_333b976a = var_408cb959 * var_408cb959;
		var_67aa12c4 = 43;
		var_978f1539 = var_67aa12c4 * var_67aa12c4;
		var_e20a427 = array(15, 15, 15, 15);
		var_ea03e490 = array(180 / var_e20a427[0], 240 / var_e20a427[1], 360 / var_e20a427[2], 360 / var_e20a427[3]);
		var_44a167ba = array(0, 0, int(var_ea03e490[2] - var_ea03e490[0]), int(var_ea03e490[3] - var_ea03e490[1]));
		distance = distance(position, centerpoint);
		distances = array(distance, distance * 1.5, distance, distance * 1.5);
		checkdistance = distance * 3;
		/#
			assert(distances.size == var_44a167ba.size);
		#/
		/#
			assert(distances.size == var_e20a427.size);
		#/
		/#
			assert(distances.size == var_ea03e490.size);
		#/
		var_f4b807cb = item_world::function_2e3efdda(centerpoint, undefined, undefined, checkdistance, undefined, 1);
		var_c36bd68a = arraysortclosest(level.var_ace9fb52, centerpoint, 24, 0, checkdistance);
		var_ac2b6007 = arraysortclosest(level.item_spawn_stashes, centerpoint, 36, 0, checkdistance);
		var_6594679a = arraysortclosest(level.item_supply_drops, centerpoint, 36, 0, checkdistance);
		for(var_709013a9 = 0; var_709013a9 < distances.size; var_709013a9++)
		{
			currentdistance = distances[var_709013a9];
			for(check = var_44a167ba[var_709013a9]; check < var_ea03e490[var_709013a9]; check++)
			{
				var_7e8fc0d7 = ((check % 2) == 1 ? int(ceil(check / -2)) : int(ceil(check / 2)));
				angle = theta + (var_e20a427[var_709013a9] * var_7e8fc0d7);
				checkpoint = ((currentdistance * (cos(angle), sin(angle), 0)) + centerpoint) + var_891dc751;
				/#
					debug_sphere(checkpoint, 2, (0, 1, 1));
				#/
				var_d154a9ba = 0;
				for(var_b7e54435 = 0; var_b7e54435 < var_f4b807cb.size; var_b7e54435++)
				{
					if(isdefined(var_f4b807cb[var_b7e54435].var_a6762160) && var_f4b807cb[var_b7e54435].var_a6762160.itemtype == #"weapon" && distance2dsquared(var_f4b807cb[var_b7e54435].origin, checkpoint) < var_f24d242c)
					{
						var_d154a9ba = 1;
						break;
						continue;
					}
					if(distance2dsquared(var_f4b807cb[var_b7e54435].origin, checkpoint) < var_ed81de82)
					{
						var_d154a9ba = 1;
						break;
					}
				}
				if(var_d154a9ba)
				{
					continue;
				}
				for(var_4271eacb = 0; var_4271eacb < var_c36bd68a.size; var_4271eacb++)
				{
					if(distance2dsquared(var_c36bd68a[var_4271eacb].origin, checkpoint) < var_c8214507)
					{
						var_d154a9ba = 1;
						break;
					}
				}
				if(var_d154a9ba)
				{
					continue;
				}
				for(var_cf8ede88 = 0; var_cf8ede88 < var_ac2b6007.size; var_cf8ede88++)
				{
					if(distance2dsquared(var_ac2b6007[var_cf8ede88].origin, checkpoint) < var_333b976a)
					{
						var_d154a9ba = 1;
						break;
					}
				}
				if(var_d154a9ba)
				{
					continue;
				}
				for(var_d0dbf0b4 = 0; var_d0dbf0b4 < var_6594679a.size; var_d0dbf0b4++)
				{
					if(distance2dsquared(var_6594679a[var_d0dbf0b4].origin, checkpoint) < var_978f1539)
					{
						var_d154a9ba = 1;
						break;
					}
				}
				if(!var_d154a9ba)
				{
					if(isplayer(player))
					{
						eyepos = player geteye();
						sighttrace = physicstraceex(eyepos, checkpoint, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), player, 1);
						if(sighttrace[#"fraction"] < 1)
						{
							/#
								debug_line(eyepos, checkpoint, (1, 0, 0));
							#/
							continue;
						}
						/#
							debug_line(eyepos, checkpoint, (0, 1, 1));
						#/
					}
					return checkpoint;
				}
			}
		}
	}
	if(isplayer(player))
	{
		position = player.origin;
	}
	return position;
}

/*
	Name: function_2734eea3
	Namespace: item_drop
	Checksum: 0xE20A1DB8
	Offset: 0x18D0
	Size: 0x1AE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2734eea3(player)
{
	if(!isplayer(player))
	{
		return 0;
	}
	var_24242c8e = 0;
	if(isdefined(player.laststandparams) && isdefined(player.laststandparams.attacker) && isplayer(player.laststandparams.attacker) && player.laststandparams.attacker != player)
	{
		var_24242c8e = var_24242c8e | !util::function_fbce7263(player.laststandparams.attacker.team, player.team);
	}
	if(!var_24242c8e && isdefined(player.var_a1d415ee) && isdefined(player.var_a1d415ee.attacker) && isplayer(player.var_a1d415ee.attacker) && player.var_a1d415ee.attacker != player)
	{
		var_24242c8e = var_24242c8e | !util::function_fbce7263(player.var_a1d415ee.attacker.team, player.team);
	}
	return var_24242c8e;
}

/*
	Name: function_a938fba7
	Namespace: item_drop
	Checksum: 0x7B48EB01
	Offset: 0x1A88
	Size: 0xA26
	Parameters: 6
	Flags: Linked, Private
*/
function private function_a938fba7(player, position, angles, var_a6762160, var_74e79ee3 = 0, var_ba40b4c1 = 1)
{
	/#
		assert(isentity(self));
	#/
	/#
		assert(isentity(player));
	#/
	/#
		assert(isvec(position));
	#/
	/#
		assert(isvec(angles));
	#/
	self notsolid();
	ignoreent = player;
	zoffset = 64;
	if(isplayer(player) && player isinvehicle())
	{
		var_1e60f7f2 = player getvehicleoccupied();
		var_6246b3c7 = 0;
		foreach(vehicle in array(#"tactical_raft_wz"))
		{
			if(isdefined(var_1e60f7f2.scriptvehicletype) && vehicle == var_1e60f7f2.scriptvehicletype)
			{
				var_6246b3c7 = 1;
				break;
			}
		}
		if(!var_6246b3c7)
		{
			ignoreent = var_1e60f7f2;
		}
		else
		{
			ignoreent = undefined;
		}
		vehicle = player getvehicleoccupied();
		if(vehicle getoccupantseat(player) == 0)
		{
			zoffset = zoffset + (abs(player.origin[2] - vehicle.origin[2]));
		}
	}
	origin = function_23b6897(player, position);
	self.origin = origin;
	var_96a432da = origin + (0, 0, zoffset);
	var_abe21f5c = origin - (0, 0, zoffset);
	starttrace = physicstraceex(origin, var_96a432da, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), ignoreent, 1);
	var_96a432da = starttrace[#"position"];
	var_ed97e13a = 5;
	onground = 0;
	var_5a13db05 = 0;
	for(index = 0; index < var_ed97e13a; index++)
	{
		/#
			debug_sphere(var_96a432da, 1.5, (0, 1, 0));
			debug_sphere(var_abe21f5c, 1.5, (0, 1, 0));
			debug_line(var_96a432da, var_abe21f5c, (0, 1, 0));
		#/
		var_708a2754 = physicstraceex(var_96a432da, var_abe21f5c, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), ignoreent, 1);
		if(var_708a2754[#"fraction"] < 1)
		{
			if(var_708a2754[#"position"][2] > -10000)
			{
				origin = var_708a2754[#"position"];
			}
			if(isdefined(var_a6762160))
			{
				originoffset = function_feb1473(var_a6762160, var_ba40b4c1);
				origin = origin + originoffset;
			}
			normal = var_708a2754[#"normal"];
			angles = function_3b2b6383(origin, angles, normal, var_a6762160, var_ba40b4c1);
			self.origin = origin;
			self.angles = angles;
			var_5a13db05 = 1;
			if(vectordot(var_708a2754[#"normal"], (0, 0, 1)) >= 0.5)
			{
				parentent = var_708a2754[#"entity"];
				if(isdefined(parentent) && parentent.model != "")
				{
					if(isplayer(parentent))
					{
						ignoreent = parentent;
						var_96a432da = var_708a2754[#"position"];
						continue;
					}
					if(parentent.classname == "script_vehicle")
					{
						var_fe7058af = 0;
						foreach(vehicle in array(#"player_atv", #"helicopter_light", "recon_wz", "hawk"))
						{
							if(isdefined(parentent.scriptvehicletype) && vehicle == parentent.scriptvehicletype)
							{
								var_fe7058af = 1;
								break;
							}
						}
						if(!var_fe7058af && isdefined(parentent.var_7b500c20) && !var_74e79ee3)
						{
							arrayremovevalue(parentent.var_7b500c20, undefined, 0);
							var_fe7058af = parentent.var_7b500c20.size >= 10;
						}
						if(var_fe7058af)
						{
							continue;
						}
					}
					if(self == parentent)
					{
						ignoreent = self;
						continue;
					}
					self linkto(parentent);
					if(!var_74e79ee3)
					{
						if(!isdefined(parentent.var_7b500c20))
						{
							parentent.var_7b500c20 = [];
						}
						else if(!isarray(parentent.var_7b500c20))
						{
							parentent.var_7b500c20 = array(parentent.var_7b500c20);
						}
						parentent.var_7b500c20[parentent.var_7b500c20.size] = self;
					}
				}
				onground = 1;
			}
			break;
		}
		break;
	}
	if(!onground)
	{
		if(!var_5a13db05)
		{
			self.angles = function_3b2b6383(self.origin, self.angles, (0, 0, 1), var_a6762160, var_ba40b4c1);
		}
		/#
			debug_sphere(self.origin, 1, (1, 0.5, 0));
		#/
		if(isplayer(player))
		{
			physicstrace = physicstraceex(self.origin, self.origin + (vectorscale((0, 0, -1), 5)), self.mins, self.maxs, ignoreent, 1);
			if(physicstrace[#"fraction"] < 1)
			{
				self.origin = player.origin + vectorscale((0, 0, 1), 18);
				/#
					debug_sphere(self.origin, 0.6, (1, 0, 0));
				#/
			}
		}
		self setcontents(self setcontents(0) & (~(((32768 | 67108864) | 8388608) | 33554432)));
		self physicslaunch();
		self thread function_10ececeb();
		return true;
	}
	/#
		debug_sphere(self.origin, 1, (1, 1, 0));
	#/
	return false;
}

/*
	Name: function_10ececeb
	Namespace: item_drop
	Checksum: 0x837AB8
	Offset: 0x24B8
	Size: 0x5DE
	Parameters: 5
	Flags: Linked
*/
function function_10ececeb(var_e280bfe2 = 1, tracedistance = 24, originheightoffset = 0, min = (0, 0, 0), max = (0, 0, 0))
{
	self endon(#"death");
	self waittill(#"stationary");
	var_21f31454 = undefined;
	var_326ad23d = undefined;
	var_ba3b53da = undefined;
	parentent = undefined;
	var_9caaeb74 = undefined;
	var_6b8fe84d = undefined;
	while(true)
	{
		origin = self.origin + (anglestoup(self.angles) * originheightoffset);
		var_708a2754 = physicstrace(origin + (0, 0, 1), origin - (0, 0, tracedistance), min, max, self, 32);
		parentent = var_708a2754[#"entity"];
		if(var_708a2754[#"startsolid"])
		{
			self physicslaunch();
		}
		else
		{
			if(!isdefined(parentent))
			{
				if(isdefined(self.var_7b500c20))
				{
					foreach(item in self.var_7b500c20)
					{
						if(isdefined(item))
						{
							[[ level.var_19011fa7 ]]->waitinqueue(self);
							if(isdefined(item))
							{
								item unlink();
							}
						}
					}
					self.var_7b500c20 = undefined;
				}
				return;
			}
			if(!isdefined(parentent.iscorpse) && isdefined(parentent) && parentent.model != "" && !isplayer(parentent))
			{
				var_fe7058af = 0;
				if(!var_e280bfe2)
				{
					var_fe7058af = 1;
				}
				if(!var_fe7058af && parentent.classname == "script_vehicle")
				{
					foreach(vehicle in array(#"player_atv", #"helicopter_light", "recon_wz", "hawk"))
					{
						if(isdefined(parentent.scriptvehicletype) && vehicle == parentent.scriptvehicletype)
						{
							var_fe7058af = 1;
							break;
						}
					}
					if(!var_fe7058af && isdefined(parentent.var_7b500c20))
					{
						arrayremovevalue(parentent.var_7b500c20, undefined, 0);
						var_fe7058af = parentent.var_7b500c20.size >= 10;
					}
				}
				if(!var_fe7058af && self !== parentent)
				{
					self linkto(parentent);
					if(!isdefined(parentent.var_7b500c20))
					{
						parentent.var_7b500c20 = [];
					}
					else if(!isarray(parentent.var_7b500c20))
					{
						parentent.var_7b500c20 = array(parentent.var_7b500c20);
					}
					parentent.var_7b500c20[parentent.var_7b500c20.size] = self;
					return;
				}
				if(!isdefined(var_21f31454))
				{
					var_21f31454 = parentent;
					var_326ad23d = parentent.origin;
					var_ba3b53da = parentent.angles;
				}
				var_9caaeb74 = parentent.origin;
				var_6b8fe84d = parentent.angles;
			}
		}
		[[ level.var_19011fa7 ]]->waitinqueue(self);
		if(isdefined(var_21f31454) && isdefined(parentent) && var_21f31454 === parentent && distancesquared(var_326ad23d, var_9caaeb74) <= 2 && distancesquared(var_ba3b53da, var_6b8fe84d) <= 2)
		{
			waitframe(1);
			continue;
		}
		self physicslaunch();
		waitframe(1);
	}
}

/*
	Name: codecallback_playerkilled
	Namespace: item_drop
	Checksum: 0x18E5B26E
	Offset: 0x2AA0
	Size: 0x5E
	Parameters: 1
	Flags: Event
*/
event codecallback_playerkilled(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self))
	{
		drop_inventory(self);
		if(isdefined(self))
		{
			self.inventory = undefined;
		}
	}
}

/*
	Name: codecallback_playerdisconnect
	Namespace: item_drop
	Checksum: 0x68EF5686
	Offset: 0x2B08
	Size: 0xA6
	Parameters: 1
	Flags: Event
*/
event codecallback_playerdisconnect(eventstruct)
{
	if(sessionmodeiswarzonegame() && isplayer(self))
	{
		if(!(isdefined(level.inprematchperiod) && level.inprematchperiod) && isdefined(self) && (isdefined(self.var_97b0977) && self.var_97b0977))
		{
			drop_inventory(self);
			if(isdefined(self))
			{
				self.inventory = undefined;
			}
		}
	}
}

/*
	Name: function_f3f9788a
	Namespace: item_drop
	Checksum: 0x4BCB15AD
	Offset: 0x2BB8
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function function_f3f9788a(itemtype, percentchance)
{
	level.var_19e75cfb[level.var_19e75cfb.size] = {#chance:max(min(percentchance, 1), 0), #type:itemtype};
}

/*
	Name: function_8a5fd783
	Namespace: item_drop
	Checksum: 0xEDAADFC3
	Offset: 0x2C40
	Size: 0x1FC
	Parameters: 0
	Flags: None
*/
function function_8a5fd783()
{
	foreach(item in level.item_spawn_drops)
	{
		if(isdefined(item))
		{
			item delete();
		}
	}
	arrayremovevalue(level.item_spawn_drops, undefined, 0);
	arrayremovevalue(level.var_18dc9d17, undefined, 0);
	foreach(stash in level.var_ace9fb52)
	{
		if(isdefined(stash))
		{
			stash delete();
		}
	}
	arrayremovevalue(level.var_ace9fb52, undefined, 0);
	foreach(stash in level.var_8ac64bf3)
	{
		if(isdefined(stash))
		{
			stash delete();
		}
	}
	arrayremovevalue(level.var_8ac64bf3, undefined, 0);
}

/*
	Name: function_767443cc
	Namespace: item_drop
	Checksum: 0x85312B20
	Offset: 0x2E48
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_767443cc(player)
{
	if(!isplayer(player))
	{
		return;
	}
	player.var_4896787f = 1;
}

/*
	Name: function_175940f3
	Namespace: item_drop
	Checksum: 0xC2B21A7D
	Offset: 0x2E88
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_175940f3(player)
{
	return isdefined(player) && (isdefined(player.var_33a24f82) && player.var_33a24f82);
}

/*
	Name: drop_inventory
	Namespace: item_drop
	Checksum: 0x307C2F6E
	Offset: 0x2EC8
	Size: 0x10B6
	Parameters: 1
	Flags: Linked
*/
function drop_inventory(player)
{
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	if(!isplayer(player))
	{
		return;
	}
	player.var_33a24f82 = 1;
	if(isdefined(player.var_4896787f) && player.var_4896787f)
	{
		player item_inventory::reset_inventory();
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return;
	}
	playernum = player getentitynumber();
	level callback::callback(#"on_drop_inventory", player);
	items = [];
	if(!isplayer(player) || !isdefined(player.inventory) || player oob::isoutofbounds())
	{
		player.var_33a24f82 = 0;
		return items;
	}
	if(isdefined(player.laststandparams) && isdefined(player.laststandparams.smeansofdeath) && player.laststandparams.smeansofdeath == #"mod_trigger_hurt" && player.laststandparams.sweapon.name === #"none")
	{
		player.var_33a24f82 = 0;
		return items;
	}
	if(!item_world_util::function_74e1e547(player.origin))
	{
		player.var_33a24f82 = 0;
		return items;
	}
	var_24242c8e = function_2734eea3(player);
	playerteam = player.team;
	drop_items = [];
	drop_count = [];
	drop_amount = [];
	drop_item_id = [];
	drop_weapon_options = [];
	var_d148a5b6 = [];
	var_406c6a0e = [];
	var_8049cf09 = 100;
	if((isdefined(getgametypesetting(#"deathcirclerespawn")) ? getgametypesetting(#"deathcirclerespawn") : 0))
	{
		var_8049cf09 = 80;
	}
	if(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))
	{
		var_8049cf09 = 60;
	}
	if(level.var_ace9fb52.size > var_8049cf09)
	{
		arrayremovevalue(level.var_ace9fb52, undefined);
		var_8aad666b = level.var_ace9fb52[0];
		if(isdefined(var_8aad666b))
		{
			dynamicitems = arraysortclosest(level.item_spawn_drops, var_8aad666b.origin, level.item_spawn_drops.size, 0, 12);
			var_6e680942 = dynamicitems.size;
			for(index = 0; index < var_6e680942; index++)
			{
				dynamicitem = dynamicitems[index];
				if(isdefined(dynamicitem))
				{
					dynamicitem delete();
				}
			}
			var_8aad666b delete();
			arrayremovevalue(level.var_ace9fb52, undefined);
		}
	}
	deathstash = spawn("script_model", player.origin);
	if(!isdefined(deathstash))
	{
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return;
	}
	if(isdefined(level.var_65f7ae17) && level.var_65f7ae17)
	{
		deathstash setmodel("p8_fxanim_wz_win_death_stash_mod");
	}
	else
	{
		if(isdefined(level.var_7b65cb7) && level.var_7b65cb7)
		{
			deathstash setmodel("p8_fxanim_wz_spd_death_stash_mod");
		}
		else
		{
			deathstash setmodel("p8_fxanim_wz_death_stash_mod");
		}
	}
	deathstash useanimtree("generic");
	deathstash notsolid();
	targetname = (player getentitynumber() + "_death_stash_") + randomint(2147483647);
	deathstash.targetname = targetname;
	deathstash.var_bad13452 = 0;
	deathstash.var_a76e4941 = 1;
	var_beee4134 = deathstash function_a938fba7(player, player.origin, player.angles, undefined, 1);
	level.var_8ac64bf3[level.var_8ac64bf3.size] = deathstash;
	deathstashitems = 0;
	if(!var_beee4134)
	{
		deathstash.stationary = 1;
	}
	foreach(inventoryitem in player.inventory.items)
	{
		itemid = inventoryitem.id;
		if(itemid == 32767)
		{
			continue;
		}
		if(isdefined(inventoryitem.endtime))
		{
			continue;
		}
		if(isdefined(inventoryitem.var_a6762160.var_6b5d0aaa) && inventoryitem.var_a6762160.var_6b5d0aaa)
		{
			continue;
		}
		item_weapon = item_world_util::function_f4a8d375(itemid);
		count = (isdefined(inventoryitem.count) ? inventoryitem.count : 1);
		amount = inventoryitem.amount;
		if(isdefined(item_weapon) && inventoryitem.var_a6762160.itemtype == #"weapon")
		{
			var_4f21d62e = namespace_a0d533d1::function_2b83d3ff(inventoryitem);
			inventoryitem.weaponoptions = player item_inventory::function_fc04b237(var_4f21d62e, inventoryitem.weaponoptions);
			var_ca577a9c = player getweaponammoclip(var_4f21d62e);
			amount = min(item_weapon.clipsize, var_ca577a9c);
			addammo = var_ca577a9c - item_weapon.clipsize;
			if(addammo > 0)
			{
				player function_fc9f8b05(var_4f21d62e, addammo);
			}
		}
		if(count <= 0)
		{
			continue;
		}
		if(isdefined(item_weapon))
		{
			drop_items[drop_item_id.size] = item_weapon;
		}
		drop_count[drop_item_id.size] = count;
		drop_amount[drop_item_id.size] = amount;
		drop_weapon_options[drop_item_id.size] = inventoryitem.weaponoptions;
		var_d148a5b6[drop_item_id.size] = inventoryitem.charmindex;
		var_406c6a0e[drop_item_id.size] = inventoryitem.var_2febbde5;
		drop_item_id[drop_item_id.size] = itemid;
	}
	foreach(ammoweapon, itemid in player.inventory.ammo)
	{
		weapon = getweapon(ammoweapon);
		ammostock = player getweaponammostock(weapon);
		player setweaponammostock(weapon, 0);
		if(ammostock > 0)
		{
			drop_items[drop_item_id.size] = weapon;
			drop_amount[drop_item_id.size] = ammostock;
			drop_count[drop_item_id.size] = 1;
			drop_item_id[drop_item_id.size] = itemid;
		}
	}
	if(drop_item_id.size > 0)
	{
		foreach(var_bf145320 in level.var_19e75cfb)
		{
			itemname = var_bf145320.type;
			if(isdefined(level.var_4afb8f5a[itemname]))
			{
				itemname = level.var_4afb8f5a[itemname];
				if(itemname == #"")
				{
					continue;
				}
			}
			itempoint = function_4ba8fde(itemname);
			if(!isdefined(itempoint))
			{
				continue;
			}
			if(var_bf145320.chance >= randomfloat(1))
			{
				itemid = itempoint.id;
				item_weapon = item_world_util::function_f4a8d375(itemid);
				if(isdefined(item_weapon))
				{
					drop_items[drop_item_id.size] = item_weapon;
				}
				drop_count[drop_item_id.size] = 1;
				drop_amount[drop_item_id.size] = 1;
				drop_item_id[drop_item_id.size] = itemid;
			}
		}
	}
	player item_inventory::reset_inventory();
	deathstash endon(#"death");
	waitframe(1);
	function_44a6883c(drop_item_id, drop_items, drop_count, drop_amount, 1, 1);
	if(deathstashitems <= 0 && drop_item_id.size <= 0)
	{
		if(var_beee4134)
		{
			deathstash waittill(#"stationary");
		}
		deathstash.stationary = 1;
		deathstash animscripted("death_stash_open", deathstash.origin, deathstash.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
		deathstash waittill(#"death_stash_open");
		deathstash animscripted("death_stash_empty", deathstash.origin, deathstash.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
		deathstash.var_bad13452 = 2;
		deathstash clientfield::set("dynamic_stash", 2);
	}
	else
	{
		deathstash clientfield::set("dynamic_stash", 1);
	}
	deathstash clientfield::set("dynamic_stash_type", 2);
	deathstash.stash_type = 2;
	if(drop_item_id.size <= 0)
	{
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return items;
	}
	degree = 0;
	var_758f910 = drop_item_id.size;
	var_557c3e3e = int((360 / var_758f910) * 2);
	even = (drop_item_id.size % 2) == 0;
	for(index = 0; index < drop_item_id.size; index++)
	{
		if(drop_item_id[index] == -1)
		{
			continue;
		}
		item = player drop_item(drop_items[index], drop_count[index], drop_amount[index], drop_item_id[index], deathstash.origin, deathstash.angles, 1, 1, targetname, deathstash, array(), 1, drop_weapon_options[index], var_d148a5b6[index], var_406c6a0e[index]);
		items[items.size] = item;
		if(!isdefined(deathstash.var_7b500c20))
		{
			deathstash.var_7b500c20 = [];
		}
		else if(!isarray(deathstash.var_7b500c20))
		{
			deathstash.var_7b500c20 = array(deathstash.var_7b500c20);
		}
		deathstash.var_7b500c20[deathstash.var_7b500c20.size] = item;
	}
	if(var_24242c8e)
	{
		for(index = 0; index < items.size; index++)
		{
			item = items[index];
			if(!isdefined(item))
			{
				continue;
			}
			item.hidefromteam = playerteam;
			item.var_6e788302 = playernum;
		}
	}
	level.var_ace9fb52[level.var_ace9fb52.size] = deathstash;
	if(isdefined(player))
	{
		player.var_33a24f82 = 0;
	}
	return items;
}

/*
	Name: drop_item
	Namespace: item_drop
	Checksum: 0x5622F03
	Offset: 0x3F88
	Size: 0xB4A
	Parameters: 15
	Flags: Linked
*/
function drop_item(weapon = undefined, count = 0, amount = 0, itemid, position, angles = (0, 0, 0), stashitem = 0, deathstash = 0, targetname = undefined, parentent = undefined, attachments = undefined, var_ba40b4c1 = 1, weaponoptions = undefined, charmindex = undefined, var_2febbde5 = undefined)
{
	/#
		assert(!isdefined(deathstash) || deathstash === 1 || deathstash === 0);
	#/
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	/#
		assert(item_world_util::function_2c7fc531(itemid));
	#/
	if(count <= 0)
	{
		return;
	}
	[[ level.var_98d0ae2b ]]->waitinqueue();
	arrayremovevalue(level.var_18dc9d17, undefined);
	var_2e8786e2 = 300;
	if(isdefined(getgametypesetting(#"wzbigteambattle")) && getgametypesetting(#"wzbigteambattle"))
	{
		var_2e8786e2 = 250;
	}
	if(level.var_18dc9d17.size > var_2e8786e2)
	{
		level.var_18dc9d17[0].hidetime = gettime();
		item_world::function_a54d07e6(level.var_18dc9d17[0]);
		level.var_18dc9d17[0] delete();
	}
	item = function_b1702735(itemid);
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	if(isdefined(item.var_a6762160.var_340eac1f) && item.var_a6762160.var_340eac1f)
	{
		originalattachments = item.attachments;
		item.attachments = attachments;
		if(!namespace_a0d533d1::function_ee669356(item))
		{
			if(isdefined(item.var_a6762160.baseweapon))
			{
				item = function_4ba8fde(item.var_a6762160.baseweapon);
			}
			else
			{
				/#
					assert(0, "");
				#/
			}
		}
		item.attachments = originalattachments;
	}
	if(isdefined(level.var_4afb8f5a[item.var_a6762160.name]))
	{
		item_name = level.var_4afb8f5a[item.var_a6762160.name];
		if(item_name == #"")
		{
			return;
		}
		item = function_4ba8fde(item_name);
		if(!isdefined(item) || !isdefined(item.var_a6762160))
		{
			return;
		}
		weapon = item_world_util::function_f4a8d375(item.id);
	}
	if(!item_world_util::function_74e1e547(position))
	{
		return;
	}
	dropitem = spawn("script_model", position);
	dropitem.angles = angles;
	dropitem.attachments = attachments;
	dropitem.var_627c698b = weapon;
	dropitem.var_67169c0b = targetname;
	dropitem.deathstash = deathstash;
	dropitem.id = function_4ba8fde(item.var_a6762160.name).id;
	dropitem.weaponoptions = weaponoptions;
	dropitem.charmindex = charmindex;
	dropitem.var_2febbde5 = var_2febbde5;
	/#
		assert(dropitem.id < 1024);
	#/
	dropitem.var_bd027dd9 = item_world_util::function_1f0def85(dropitem);
	dropitem.var_a6762160 = item.var_a6762160;
	if(item.var_a6762160.name == #"sig_blade_wz_item" && isdefined(level.var_5b2a8d88))
	{
		level.var_5b2a8d88[dropitem.var_bd027dd9] = 1;
	}
	if(stashitem)
	{
		dropitem clientfield::set("dynamic_item_drop", 5);
	}
	else
	{
		dropitem clientfield::set("dynamic_item_drop", 1);
	}
	dropitem function_46d7f921(dropitem.id);
	dropitem notsolid();
	dropitem ghost();
	if(stashitem)
	{
		dropitem.hidetime = -1;
	}
	else
	{
		dropitem.hidetime = 0;
	}
	dropitem.amount = amount;
	dropitem.count = count;
	dropitem clientfield::set("dynamic_item_drop_count", int(max(dropitem.count, dropitem.amount)));
	if(var_ba40b4c1 && isdefined(dropitem.var_a6762160.var_77d2cbb5))
	{
		dropitem setmodel(dropitem.var_a6762160.var_77d2cbb5);
	}
	else
	{
		if(isdefined(dropitem.var_a6762160.model))
		{
			dropitem setmodel(dropitem.var_a6762160.model);
		}
		else
		{
			if(isdefined(weapon))
			{
				dropitem setmodel(weapon.worldmodel);
			}
			else
			{
				dropitem delete();
				return;
			}
		}
	}
	if(!namespace_a0d533d1::function_70b12595(dropitem))
	{
		dropitem clientfield::set("item_world_attachments", 1);
	}
	else
	{
		dropitem clientfield::set("item_world_attachments", 0);
	}
	params = {#deathstash:deathstash, #item:dropitem};
	if(isplayer(self))
	{
		self callback::callback(#"on_drop_item", params);
	}
	if(isdefined(weapon))
	{
		dropitem setweapon(weapon);
		dropitem useweaponhidetags(weapon);
	}
	if(isdefined(dropitem.var_a6762160.modelscale))
	{
		dropitem setscale(dropitem.var_a6762160.modelscale);
	}
	if(!stashitem)
	{
		dropitem function_a938fba7((isentity(self) ? self : dropitem), position, angles, item.var_a6762160, undefined, var_ba40b4c1);
	}
	if(isentity(parentent) && dropitem !== parentent && item_world_util::function_74e1e547(parentent.origin))
	{
		dropitem.origin = parentent.origin;
		if(!(isdefined(parentent.stationary) && parentent.stationary) || isdefined(parentent getlinkedent()))
		{
			dropitem linkto(parentent);
		}
	}
	arrayremovevalue(level.item_spawn_drops, undefined, 1);
	if(isdefined(level.item_spawn_drops[dropitem.var_bd027dd9]))
	{
		level.item_spawn_drops[dropitem.var_bd027dd9] delete();
	}
	level.item_spawn_drops[dropitem.var_bd027dd9] = dropitem;
	level.var_18dc9d17[level.var_18dc9d17.size] = dropitem;
	return dropitem;
}

/*
	Name: function_4da960f6
	Namespace: item_drop
	Checksum: 0x94E0A564
	Offset: 0x4AE0
	Size: 0x25A
	Parameters: 3
	Flags: Linked
*/
function function_4da960f6(origin, radius, time)
{
	/#
		assert(isvec(origin));
	#/
	/#
		assert(isfloat(radius) || isint(radius));
	#/
	/#
		assert(isfloat(time) || isint(time));
	#/
	if(time < 0)
	{
		return;
	}
	var_6665e24 = arraysortclosest(level.item_spawn_drops, origin, 24, 0, radius);
	var_c36bd68a = arraysortclosest(level.var_ace9fb52, origin, 24, 0, radius);
	var_f4b807cb = arraycombine(var_6665e24, var_c36bd68a, 1, 0);
	starttime = gettime();
	while((float(gettime() - starttime)) / 1000 < time)
	{
		foreach(item in var_f4b807cb)
		{
			if(!isentity(item))
			{
				continue;
			}
			if(isdefined(item.classname) && item.classname == #"grenade")
			{
				continue;
			}
			item physicslaunch();
		}
		waitframe(1);
	}
}

/*
	Name: function_ba4c90d9
	Namespace: item_drop
	Checksum: 0xB3F625B0
	Offset: 0x4D48
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_ba4c90d9(item)
{
	if(isdefined(item) && isdefined(item.var_bd027dd9) && isdefined(level.item_spawn_drops[item.var_bd027dd9]))
	{
		item clientfield::set("dynamic_item_drop", 0);
		arrayremoveindex(level.item_spawn_drops, item.var_bd027dd9, 1);
	}
}

/*
	Name: debug_sphere
	Namespace: item_drop
	Checksum: 0xCFF309A5
	Offset: 0x4DE0
	Size: 0x11C
	Parameters: 3
	Flags: None
*/
function debug_sphere(origin, radius, color)
{
	/#
		if(!getdvarint(#"hash_2844354393b7be9e", 0))
		{
			return;
		}
		sec = getdvarint(#"hash_6c3e4a7cf7546b8f", 10);
		var_f04d2832 = int(1 / (float(function_60d95f53()) / 1000));
		sphere(origin, radius, color, 1, 0, 10, var_f04d2832 * sec);
		recordsphere(origin, radius, color, "");
	#/
}

/*
	Name: debug_line
	Namespace: item_drop
	Checksum: 0xD8BA3985
	Offset: 0x4F08
	Size: 0x11C
	Parameters: 3
	Flags: None
*/
function debug_line(start, end, color)
{
	/#
		if(!getdvarint(#"hash_2844354393b7be9e", 0))
		{
			return;
		}
		sec = getdvarint(#"hash_6c3e4a7cf7546b8f", 10);
		var_f04d2832 = int(1 / (float(function_60d95f53()) / 1000));
		line(start, end, color, 1, 0, var_f04d2832 * sec);
		recordline(start, end, color, "");
	#/
}

