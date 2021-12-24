// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39bd5b6b799b1c9c;
#using script_64ab2b950d85b8ad;
#using script_6b993fdc7adc35ec;
#using script_8abfb58852911dd;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace item_drop;

/*
	Name: function_89f2df9
	Namespace: item_drop
	Checksum: 0x99494908
	Offset: 0x278
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_98d0ae2b = object;
		[[ level.var_98d0ae2b ]]->initialize(2, 0.05);
	}
	if(!isdefined(level.var_19011fa7))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_19011fa7 = object;
		[[ level.var_19011fa7 ]]->initialize(2, 0.05);
	}
	level.disableweapondrop = 1;
	level.var_ace9fb52 = [];
	level.var_a4a4012e = [];
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
private function function_344f8c02()
{
	/#
		adddebugcommand(("" + util::function_53bbf9d2()) + "");
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
private function function_60c9a9e1()
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
private function function_3b2b6383(origin, angles, normal, var_a6762160, var_ba40b4c1)
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
private function function_feb1473(var_a6762160, var_ba40b4c1)
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
private function function_a3675ae5()
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
private function function_32b2794(degree)
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
private function function_44a6883c(var_d9a91a6, var_fc79d82, var_c46cdc46, var_413559c8, var_4a5c0085 = 1, var_fee0423a = 0)
{
	var_f55ea9e5 = var_d9a91a6.size;
	for(index = 0; index < var_f55ea9e5; index++)
	{
		if(!isdefined(var_d9a91a6[index]))
		{
			continue;
		}
		item = function_b1702735(var_d9a91a6[index]);
		var_a6762160 = item.var_a6762160;
		itemname = namespace_ad5a0cd6::function_d73e17cb(var_a6762160);
		if(var_a6762160.itemtype == #"weapon")
		{
			continue;
		}
		var_a057551d = namespace_a0d533d1::function_cfa794ca(0, var_a6762160);
		if(var_fee0423a && (!(isdefined(var_a6762160.stackable) && var_a6762160.stackable)))
		{
			for(var_604c3ae6 = 0; var_604c3ae6 < index; var_604c3ae6++)
			{
				if(var_d9a91a6[var_604c3ae6] == -1)
				{
					continue;
				}
				var_92d652f2 = function_b1702735(var_d9a91a6[var_604c3ae6]);
				var_f6a3c690 = var_92d652f2.var_a6762160;
				var_fa38de52 = namespace_ad5a0cd6::function_d73e17cb(var_f6a3c690);
				if(itemname != var_fa38de52)
				{
					continue;
				}
				var_c46cdc46[var_604c3ae6] = var_c46cdc46[var_604c3ae6] + var_c46cdc46[index];
				var_d9a91a6[index] = -1;
				var_fc79d82[index] = undefined;
				var_c46cdc46[index] = undefined;
				var_413559c8[index] = undefined;
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
			if(var_c46cdc46[index] == var_a057551d)
			{
				continue;
			}
			if(var_c46cdc46[index] > var_a057551d)
			{
				excess = var_c46cdc46[index] - var_a057551d;
				var_c46cdc46[index] = var_a057551d;
				var_d9a91a6[var_f55ea9e5] = var_d9a91a6[index];
				if(isdefined(var_fc79d82[index]))
				{
					var_fc79d82[var_f55ea9e5] = var_fc79d82[index];
				}
				var_c46cdc46[var_f55ea9e5] = excess;
				var_413559c8[var_f55ea9e5] = var_413559c8[index];
				var_f55ea9e5++;
				continue;
			}
		}
		if(!isdefined(var_c46cdc46[index]) || var_c46cdc46[index] <= 0)
		{
			continue;
		}
		for(var_604c3ae6 = 0; var_604c3ae6 < index; var_604c3ae6++)
		{
			if(!isdefined(var_c46cdc46[index]) || var_c46cdc46[index] <= 0)
			{
				break;
			}
			if(var_d9a91a6[var_604c3ae6] == -1)
			{
				continue;
			}
			var_92d652f2 = function_b1702735(var_d9a91a6[var_604c3ae6]);
			var_f6a3c690 = var_92d652f2.var_a6762160;
			var_fa38de52 = namespace_ad5a0cd6::function_d73e17cb(var_f6a3c690);
			if(itemname != var_fa38de52)
			{
				continue;
			}
			excess = var_c46cdc46[index];
			if(var_4a5c0085)
			{
				var_8429965a = var_a057551d - var_c46cdc46[var_604c3ae6];
				excess = int(min(var_8429965a, var_c46cdc46[index]));
			}
			var_c46cdc46[var_604c3ae6] = var_c46cdc46[var_604c3ae6] + excess;
			var_c46cdc46[index] = var_c46cdc46[index] - excess;
			if(var_c46cdc46[index] <= 0)
			{
				/#
					assert(var_c46cdc46[index] == 0);
				#/
				var_d9a91a6[index] = -1;
				var_fc79d82[index] = undefined;
				var_c46cdc46[index] = undefined;
				var_413559c8[index] = undefined;
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
private function function_23b6897(player, position)
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
		var_ac2b6007 = arraysortclosest(level.var_5862f2ce, centerpoint, 36, 0, checkdistance);
		var_6594679a = arraysortclosest(level.var_a5f063d, centerpoint, 36, 0, checkdistance);
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
private function function_2734eea3(player)
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
private function function_a938fba7(player, position, angles, var_a6762160, var_74e79ee3 = 0, var_ba40b4c1 = 1)
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
		return 1;
	}
	/#
		debug_sphere(self.origin, 1, (1, 1, 0));
	#/
	return 0;
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
		if(var_708a2754[#"hash_7f9ee3a239b86eea"])
		{
			self physicslaunch();
		}
		else if(!isdefined(parentent))
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
	if(function_f99d2668() && isplayer(self))
	{
		function_504d49aa(self);
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
	if(function_f99d2668() && isplayer(self))
	{
		if(!(isdefined(level.inprematchperiod) && level.inprematchperiod) && isdefined(self) && (isdefined(self.var_97b0977) && self.var_97b0977))
		{
			function_504d49aa(self);
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
	foreach(item in level.var_a4a4012e)
	{
		if(isdefined(item))
		{
			item delete();
		}
	}
	arrayremovevalue(level.var_a4a4012e, undefined, 0);
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
	Name: function_504d49aa
	Namespace: item_drop
	Checksum: 0x307C2F6E
	Offset: 0x2EC8
	Size: 0x10B6
	Parameters: 1
	Flags: Linked
*/
function function_504d49aa(player)
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
		player namespace_b376ff3f::function_56a681fb();
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return;
	}
	playernum = player getentitynumber();
	level callback::callback(#"hash_27e13b9438e33053", player);
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
	if(!namespace_ad5a0cd6::function_74e1e547(player.origin))
	{
		player.var_33a24f82 = 0;
		return items;
	}
	var_24242c8e = function_2734eea3(player);
	playerteam = player.team;
	var_fc79d82 = [];
	var_c46cdc46 = [];
	var_413559c8 = [];
	var_d9a91a6 = [];
	var_c6cad27f = [];
	var_d148a5b6 = [];
	var_406c6a0e = [];
	var_8049cf09 = 100;
	if((isdefined(getgametypesetting(#"hash_19400c3e10b77e6b")) ? getgametypesetting(#"hash_19400c3e10b77e6b") : 0))
	{
		var_8049cf09 = 80;
	}
	if(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))
	{
		var_8049cf09 = 60;
	}
	if(level.var_ace9fb52.size > var_8049cf09)
	{
		arrayremovevalue(level.var_ace9fb52, undefined);
		var_8aad666b = level.var_ace9fb52[0];
		if(isdefined(var_8aad666b))
		{
			var_c5c64633 = arraysortclosest(level.var_a4a4012e, var_8aad666b.origin, level.var_a4a4012e.size, 0, 12);
			var_6e680942 = var_c5c64633.size;
			for(index = 0; index < var_6e680942; index++)
			{
				var_ae944413 = var_c5c64633[index];
				if(isdefined(var_ae944413))
				{
					var_ae944413 delete();
				}
			}
			var_8aad666b delete();
			arrayremovevalue(level.var_ace9fb52, undefined);
		}
	}
	var_4961f577 = spawn("script_model", player.origin);
	if(!isdefined(var_4961f577))
	{
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return;
	}
	if(isdefined(level.var_65f7ae17) && level.var_65f7ae17)
	{
		var_4961f577 setmodel("p8_fxanim_wz_win_death_stash_mod");
	}
	else if(isdefined(level.var_7b65cb7) && level.var_7b65cb7)
	{
		var_4961f577 setmodel("p8_fxanim_wz_spd_death_stash_mod");
	}
	else
	{
		var_4961f577 setmodel("p8_fxanim_wz_death_stash_mod");
	}
	var_4961f577 useanimtree("generic");
	var_4961f577 notsolid();
	targetname = (player getentitynumber() + "_death_stash_") + randomint(2147483647);
	var_4961f577.targetname = targetname;
	var_4961f577.var_bad13452 = 0;
	var_4961f577.var_a76e4941 = 1;
	var_beee4134 = var_4961f577 function_a938fba7(player, player.origin, player.angles, undefined, 1);
	level.var_8ac64bf3[level.var_8ac64bf3.size] = var_4961f577;
	var_782cd9e6 = 0;
	if(!var_beee4134)
	{
		var_4961f577.stationary = 1;
	}
	foreach(var_b619c089 in player.inventory.items)
	{
		var_d8138db2 = var_b619c089.id;
		if(var_d8138db2 == 32767)
		{
			continue;
		}
		if(isdefined(var_b619c089.endtime))
		{
			continue;
		}
		if(isdefined(var_b619c089.var_a6762160.var_6b5d0aaa) && var_b619c089.var_a6762160.var_6b5d0aaa)
		{
			continue;
		}
		var_af76aeca = namespace_ad5a0cd6::function_f4a8d375(var_d8138db2);
		count = (isdefined(var_b619c089.count) ? var_b619c089.count : 1);
		amount = var_b619c089.amount;
		if(isdefined(var_af76aeca) && var_b619c089.var_a6762160.itemtype == #"weapon")
		{
			var_4f21d62e = namespace_a0d533d1::function_2b83d3ff(var_b619c089);
			var_b619c089.weaponoptions = player namespace_b376ff3f::function_fc04b237(var_4f21d62e, var_b619c089.weaponoptions);
			var_ca577a9c = player getweaponammoclip(var_4f21d62e);
			amount = min(var_af76aeca.clipsize, var_ca577a9c);
			addammo = var_ca577a9c - var_af76aeca.clipsize;
			if(addammo > 0)
			{
				player function_fc9f8b05(var_4f21d62e, addammo);
			}
		}
		if(count <= 0)
		{
			continue;
		}
		if(isdefined(var_af76aeca))
		{
			var_fc79d82[var_d9a91a6.size] = var_af76aeca;
		}
		var_c46cdc46[var_d9a91a6.size] = count;
		var_413559c8[var_d9a91a6.size] = amount;
		var_c6cad27f[var_d9a91a6.size] = var_b619c089.weaponoptions;
		var_d148a5b6[var_d9a91a6.size] = var_b619c089.var_3a7d925b;
		var_406c6a0e[var_d9a91a6.size] = var_b619c089.var_2febbde5;
		var_d9a91a6[var_d9a91a6.size] = var_d8138db2;
	}
	foreach(var_95162a97, var_d8138db2 in player.inventory.ammo)
	{
		weapon = getweapon(var_95162a97);
		ammostock = player getweaponammostock(weapon);
		player setweaponammostock(weapon, 0);
		if(ammostock > 0)
		{
			var_fc79d82[var_d9a91a6.size] = weapon;
			var_413559c8[var_d9a91a6.size] = ammostock;
			var_c46cdc46[var_d9a91a6.size] = 1;
			var_d9a91a6[var_d9a91a6.size] = var_d8138db2;
		}
	}
	if(var_d9a91a6.size > 0)
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
			var_d90e0e15 = function_4ba8fde(itemname);
			if(!isdefined(var_d90e0e15))
			{
				continue;
			}
			if(var_bf145320.chance >= randomfloat(1))
			{
				var_d8138db2 = var_d90e0e15.id;
				var_af76aeca = namespace_ad5a0cd6::function_f4a8d375(var_d8138db2);
				if(isdefined(var_af76aeca))
				{
					var_fc79d82[var_d9a91a6.size] = var_af76aeca;
				}
				var_c46cdc46[var_d9a91a6.size] = 1;
				var_413559c8[var_d9a91a6.size] = 1;
				var_d9a91a6[var_d9a91a6.size] = var_d8138db2;
			}
		}
	}
	player namespace_b376ff3f::function_56a681fb();
	var_4961f577 endon(#"death");
	waitframe(1);
	function_44a6883c(var_d9a91a6, var_fc79d82, var_c46cdc46, var_413559c8, 1, 1);
	if(var_782cd9e6 <= 0 && var_d9a91a6.size <= 0)
	{
		if(var_beee4134)
		{
			var_4961f577 waittill(#"stationary");
		}
		var_4961f577.stationary = 1;
		var_4961f577 animscripted("death_stash_open", var_4961f577.origin, var_4961f577.angles, "p8_fxanim_wz_death_stash_used_anim", "normal", "root", 1, 0);
		var_4961f577 waittill(#"death_stash_open");
		var_4961f577 animscripted("death_stash_empty", var_4961f577.origin, var_4961f577.angles, "p8_fxanim_wz_death_stash_empty_anim", "normal", "root", 1, 0);
		var_4961f577.var_bad13452 = 2;
		var_4961f577 clientfield::set("dynamic_stash", 2);
	}
	else
	{
		var_4961f577 clientfield::set("dynamic_stash", 1);
	}
	var_4961f577 clientfield::set("dynamic_stash_type", 2);
	var_4961f577.var_ed175c5 = 2;
	if(var_d9a91a6.size <= 0)
	{
		if(isdefined(player))
		{
			player.var_33a24f82 = 0;
		}
		return items;
	}
	degree = 0;
	var_758f910 = var_d9a91a6.size;
	var_557c3e3e = int((360 / var_758f910) * 2);
	even = (var_d9a91a6.size % 2) == 0;
	for(index = 0; index < var_d9a91a6.size; index++)
	{
		if(var_d9a91a6[index] == -1)
		{
			continue;
		}
		item = player drop_item(var_fc79d82[index], var_c46cdc46[index], var_413559c8[index], var_d9a91a6[index], var_4961f577.origin, var_4961f577.angles, 1, 1, targetname, var_4961f577, array(), 1, var_c6cad27f[index], var_d148a5b6[index], var_406c6a0e[index]);
		items[items.size] = item;
		if(!isdefined(var_4961f577.var_7b500c20))
		{
			var_4961f577.var_7b500c20 = [];
		}
		else if(!isarray(var_4961f577.var_7b500c20))
		{
			var_4961f577.var_7b500c20 = array(var_4961f577.var_7b500c20);
		}
		var_4961f577.var_7b500c20[var_4961f577.var_7b500c20.size] = item;
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
	level.var_ace9fb52[level.var_ace9fb52.size] = var_4961f577;
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
function drop_item(weapon = undefined, count = 0, amount = 0, var_d8138db2, position, angles = (0, 0, 0), var_be90d3da = 0, var_4961f577 = 0, targetname = undefined, parentent = undefined, attachments = undefined, var_ba40b4c1 = 1, weaponoptions = undefined, var_3a7d925b = undefined, var_2febbde5 = undefined)
{
	/#
		assert(!isdefined(var_4961f577) || var_4961f577 === 1 || var_4961f577 === 0);
	#/
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	/#
		assert(namespace_ad5a0cd6::function_2c7fc531(var_d8138db2));
	#/
	if(count <= 0)
	{
		return;
	}
	[[ level.var_98d0ae2b ]]->waitinqueue();
	arrayremovevalue(level.var_18dc9d17, undefined);
	var_2e8786e2 = 300;
	if(isdefined(getgametypesetting(#"hash_695d922e24b41e31")) && getgametypesetting(#"hash_695d922e24b41e31"))
	{
		var_2e8786e2 = 250;
	}
	if(level.var_18dc9d17.size > var_2e8786e2)
	{
		level.var_18dc9d17[0].var_8e092725 = gettime();
		item_world::function_a54d07e6(level.var_18dc9d17[0]);
		level.var_18dc9d17[0] delete();
	}
	item = function_b1702735(var_d8138db2);
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
			assert(0, "");
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
		weapon = namespace_ad5a0cd6::function_f4a8d375(item.id);
	}
	if(!namespace_ad5a0cd6::function_74e1e547(position))
	{
		return;
	}
	dropitem = spawn("script_model", position);
	dropitem.angles = angles;
	dropitem.attachments = attachments;
	dropitem.var_627c698b = weapon;
	dropitem.var_67169c0b = targetname;
	dropitem.var_4961f577 = var_4961f577;
	dropitem.id = function_4ba8fde(item.var_a6762160.name).id;
	dropitem.weaponoptions = weaponoptions;
	dropitem.var_3a7d925b = var_3a7d925b;
	dropitem.var_2febbde5 = var_2febbde5;
	/#
		assert(dropitem.id < 1024);
	#/
	dropitem.var_bd027dd9 = namespace_ad5a0cd6::function_1f0def85(dropitem);
	dropitem.var_a6762160 = item.var_a6762160;
	if(item.var_a6762160.name == #"hash_43aca7fcfd3e5949" && isdefined(level.var_5b2a8d88))
	{
		level.var_5b2a8d88[dropitem.var_bd027dd9] = 1;
	}
	if(var_be90d3da)
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
	if(var_be90d3da)
	{
		dropitem.var_8e092725 = -1;
	}
	else
	{
		dropitem.var_8e092725 = 0;
	}
	dropitem.amount = amount;
	dropitem.count = count;
	dropitem clientfield::set("dynamic_item_drop_count", int(max(dropitem.count, dropitem.amount)));
	if(var_ba40b4c1 && isdefined(dropitem.var_a6762160.var_77d2cbb5))
	{
		dropitem setmodel(dropitem.var_a6762160.var_77d2cbb5);
	}
	else if(isdefined(dropitem.var_a6762160.model))
	{
		dropitem setmodel(dropitem.var_a6762160.model);
	}
	else if(isdefined(weapon))
	{
		dropitem setmodel(weapon.worldmodel);
	}
	else
	{
		dropitem delete();
		return;
	}
	if(!namespace_a0d533d1::function_70b12595(dropitem))
	{
		dropitem clientfield::set("item_world_attachments", 1);
	}
	else
	{
		dropitem clientfield::set("item_world_attachments", 0);
	}
	params = {#hash_4961f577:var_4961f577, #item:dropitem};
	if(isplayer(self))
	{
		self callback::callback(#"hash_4d3e34c3c8f8bb2a", params);
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
	if(!var_be90d3da)
	{
		dropitem function_a938fba7((isentity(self) ? self : dropitem), position, angles, item.var_a6762160, undefined, var_ba40b4c1);
	}
	if(isentity(parentent) && dropitem !== parentent && namespace_ad5a0cd6::function_74e1e547(parentent.origin))
	{
		dropitem.origin = parentent.origin;
		if(!(isdefined(parentent.stationary) && parentent.stationary) || isdefined(parentent getlinkedent()))
		{
			dropitem linkto(parentent);
		}
	}
	arrayremovevalue(level.var_a4a4012e, undefined, 1);
	if(isdefined(level.var_a4a4012e[dropitem.var_bd027dd9]))
	{
		level.var_a4a4012e[dropitem.var_bd027dd9] delete();
	}
	level.var_a4a4012e[dropitem.var_bd027dd9] = dropitem;
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
	var_6665e24 = arraysortclosest(level.var_a4a4012e, origin, 24, 0, radius);
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
	if(isdefined(item) && isdefined(item.var_bd027dd9) && isdefined(level.var_a4a4012e[item.var_bd027dd9]))
	{
		item clientfield::set("dynamic_item_drop", 0);
		arrayremoveindex(level.var_a4a4012e, item.var_bd027dd9, 1);
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

