// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_38755604e51a604e;
#using script_3f65948f90646f7c;
#using script_51f4cef054ca0f89;
#using script_5209c07c35771d12;
#using script_5b1c3d314b9c88fb;
#using script_64ab2b950d85b8ad;
#using script_8abfb58852911dd;
#using script_cb32d07c95e5628;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_defaults.gsc;

#namespace infection;

/*
	Name: function_89f2df9
	Namespace: infection
	Checksum: 0xDA8D89CD
	Offset: 0x150
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_31f83f7a18d98ab2", &__init__, undefined, #"infection");
}

/*
	Name: __init__
	Namespace: infection
	Checksum: 0x5EFD29D2
	Offset: 0x1A0
	Size: 0x144
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!function_74650d7())
	{
		return;
	}
	globallogic_defaults::function_daa7e9d5();
	level.var_6b2b1231 = getweapon(#"hash_6b525d940c1c1e39");
	clientfield::register("toplayer", "infected", 21000, 1, "int");
	callback::on_player_killed_with_params(&function_2cdab964);
	callback::on_player_killed_with_params(&function_70f6e873);
	callback::on_spawned(&on_player_spawned);
	level thread function_d9ff5189();
	level thread function_16e24b6c();
	/#
		level thread function_44b9dd1d();
	#/
	/#
		level thread function_cdd9b388();
	#/
}

/*
	Name: function_e717b0d
	Namespace: infection
	Checksum: 0x32A694E3
	Offset: 0x2F0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e717b0d(player)
{
	if(!isdefined(player) || !isalive(player) || !isdefined(player.inventory))
	{
		return;
	}
	hatchet = namespace_441c2f1c::function_ba18c3e5(#"hash_15bac43598d4827c");
	var_fa3df96 = player namespace_b376ff3f::function_e66dcff5(hatchet);
	player item_world::function_de2018e3(hatchet, player, var_fa3df96);
}

/*
	Name: function_d9ff5189
	Namespace: infection
	Checksum: 0x8C28712
	Offset: 0x3B0
	Size: 0x3DC
	Parameters: 0
	Flags: Linked
*/
function function_d9ff5189()
{
	level.var_6990c489 = [];
	zones = array(#"hash_4dbcc2b446bd38a1", #"hash_10428139e6b0bbff", #"hash_25aa44d926c0c474", #"hash_6415ec7e8184bf28", #"hash_5847443f3024c929", #"hash_73005dd6865f9f10", #"hash_404f9fa38b97a6d7", #"hash_2b716492bb846abc", #"hash_630ccdf81f24d726", #"hash_637c310235240983", #"hash_2471629856eb1593", #"hash_2534a9ced626d51", #"hash_591cde4f594114c1", #"hash_2db90e94e83ff798", #"hash_7c4b27a01e9028f8", #"hash_1713d247dfe47377", #"hash_5e4769235f7fac0b", #"hash_44cf5914cb790bb6", #"hash_293b65bfdc1ba1db", #"hash_69f475f09d7479b2");
	foreach(zone in zones)
	{
		var_c8dd66c4 = struct::get_array(zone, "targetname");
		if(var_c8dd66c4.size > 0)
		{
			var_f7b61e5e = spawnstruct();
			min = var_c8dd66c4[0].origin;
			max = min;
			for(index = 1; index < var_c8dd66c4.size; index++)
			{
				spawn = var_c8dd66c4[index].origin;
				max = (max(max[0], spawn[0]), max(max[1], spawn[1]), max(max[2], spawn[2]));
				min = (min(min[0], spawn[0]), min(min[1], spawn[1]), min(min[2], spawn[2]));
			}
			var_f7b61e5e.origin = min + max / 2;
			var_f7b61e5e.max = max;
			var_f7b61e5e.min = min;
			var_f7b61e5e.spawn_points = var_c8dd66c4;
			level.var_6990c489[level.var_6990c489.size] = var_f7b61e5e;
		}
		waitframe(1);
	}
}

/*
	Name: function_f488681f
	Namespace: infection
	Checksum: 0x2FD0A1D1
	Offset: 0x798
	Size: 0xFA
	Parameters: 0
	Flags: Linked
*/
function function_f488681f()
{
	if(isdefined(self.var_139ab759) && self.var_139ab759 + 0 >= gettime())
	{
		return;
	}
	spawn_point = function_89116a1e();
	if(isdefined(spawn_point))
	{
		var_1b36fba4 = spawn_point.origin;
		starttrace = physicstraceex(var_1b36fba4 + vectorscale((0, 0, 1), 128), var_1b36fba4, vectorscale((-1, -1, -1), 0.5), vectorscale((1, 1, 1), 0.5), self, 1);
		var_1b36fba4 = starttrace[#"position"];
		self.resurrect_origin = var_1b36fba4;
		self.resurrect_angles = spawn_point.angles;
		self.var_139ab759 = gettime();
	}
}

/*
	Name: function_8bdd6715
	Namespace: infection
	Checksum: 0xF881000D
	Offset: 0x8A0
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function function_8bdd6715()
{
	self item_world::function_df82b00c();
	item_drop::function_767443cc(self);
	self thread function_b8c66122();
	self thread function_ff850b97();
	self warzone::function_2f66bc37();
	self clientfield::set_to_player("infected", 1);
	self clientfield::set_to_player("realtime_multiplay", 1);
	self function_3aaa02be(0);
	self.var_a62dbeca = 1;
}

/*
	Name: on_player_spawned
	Namespace: infection
	Checksum: 0x194EA72A
	Offset: 0x990
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(isdefined(self))
	{
		if(self clientfield::get_to_player("infected") == 1)
		{
			self freezecontrolsallowlook(1);
			self ghost();
			self thread function_cc4a1b88();
			wait(0.5);
			if(!isdefined(self))
			{
				return;
			}
			self show();
			self function_c6775cf9("boast_zombie_climbout");
			self freezecontrolsallowlook(0);
		}
	}
}

/*
	Name: function_cc4a1b88
	Namespace: infection
	Checksum: 0xE3D1CD5
	Offset: 0xA80
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_cc4a1b88()
{
	self luinotifyevent(#"hash_21b9cfc69e007bc4", 0);
}

/*
	Name: function_89116a1e
	Namespace: infection
	Checksum: 0x1C58E2BE
	Offset: 0xAB0
	Size: 0x3A8
	Parameters: 0
	Flags: Linked
*/
function function_89116a1e()
{
	if(!isplayer(self))
	{
		/#
			assert(0);
		#/
		return;
	}
	if(!isdefined(level.var_6990c489) || level.var_6990c489.size <= 0)
	{
		return;
	}
	zones = level.var_6990c489;
	var_3fe45e06 = [];
	if(isdefined(level.deathcircle) && isdefined(level.deathcircle.var_7aec140c))
	{
		var_5b345622 = min(level.deathcircle.radius - level.deathcircle.var_7aec140c.radius, 10000);
		var_3fe45e06 = [];
		var_89e77f16 = level.deathcircle.radius - var_5b345622 * level.deathcircle.radius - var_5b345622;
		nextorigin = level.deathcircle.origin;
		for(index = 0; index < zones.size; index++)
		{
			zone = zones[index];
			if(distance2dsquared(nextorigin, zone.origin) <= var_89e77f16)
			{
				var_3fe45e06[var_3fe45e06.size] = zone;
			}
		}
	}
	if(var_3fe45e06.size > 0)
	{
		zones = var_3fe45e06;
	}
	else if(isdefined(level.deathcircle))
	{
		closestzone = zones[0];
		var_42c5fb9a = distance2dsquared(level.deathcircle.origin, closestzone.origin);
		for(index = 1; index < zones.size; index++)
		{
			zone = zones[index];
			var_d5e7808c = distance2dsquared(level.deathcircle.origin, zone.origin);
			if(var_d5e7808c < var_42c5fb9a)
			{
				var_42c5fb9a = var_d5e7808c;
				closestzone = zone;
			}
		}
		zones = array(closestzone);
	}
	closestzone = zones[0];
	closestdistsq = distance2dsquared(self.origin, closestzone.origin);
	for(index = 1; index < zones.size; index++)
	{
		zone = zones[index];
		var_98ea9d5c = distance2dsquared(self.origin, zone.origin);
		if(var_98ea9d5c < closestdistsq)
		{
			closestzone = zone;
			closestdistsq = var_98ea9d5c;
		}
	}
	return closestzone.spawn_points[randomint(closestzone.spawn_points.size)];
}

/*
	Name: function_b8c66122
	Namespace: infection
	Checksum: 0x99EABDA7
	Offset: 0xE60
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_b8c66122()
{
	/#
		assert(isplayer(self));
	#/
	if(!isplayer(self) || !isalive(self))
	{
		return;
	}
	if(item_world::function_1b11e73c())
	{
		while(isdefined(self) && !isdefined(self.inventory))
		{
			waitframe(1);
		}
		if(!isdefined(self))
		{
			return;
		}
		for(i = 0; i < 2; i++)
		{
			function_e717b0d(self);
		}
	}
	if(isdefined(self))
	{
		self takeweapon(level.weaponbasemeleeheld);
		self giveweapon(level.var_6b2b1231);
	}
}

/*
	Name: function_4fcf8d3f
	Namespace: infection
	Checksum: 0xD01A71B1
	Offset: 0xF90
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4fcf8d3f(player)
{
	if(!isplayer(player) || !player function_bf46a7aa())
	{
		return;
	}
	if(player.health < player.maxhealth)
	{
		player.health = player.maxhealth;
	}
	for(i = 0; i < 2; i++)
	{
		function_e717b0d(player);
	}
}

/*
	Name: function_2cdab964
	Namespace: infection
	Checksum: 0x2BE98590
	Offset: 0x1048
	Size: 0xFC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2cdab964(params)
{
	attacker = params.eattacker;
	weapon = params.weapon;
	if(isdefined(params.laststandparams))
	{
		attacker = params.laststandparams.attacker;
		weapon = params.laststandparams.sweapon;
	}
	function_4fcf8d3f(attacker);
	if(isdefined(self) && isdefined(self.var_a1d415ee) && isdefined(self.var_a1d415ee.attacker))
	{
		var_a6c0f254 = self.var_a1d415ee.attacker;
		if(var_a6c0f254 !== attacker)
		{
			function_4fcf8d3f(var_a6c0f254);
		}
	}
}

/*
	Name: function_70f6e873
	Namespace: infection
	Checksum: 0x4BBF3C35
	Offset: 0x1150
	Size: 0x118
	Parameters: 1
	Flags: Linked, Private
*/
private function function_70f6e873(params)
{
	if(!isdefined(self) || !self function_bf46a7aa())
	{
		return;
	}
	attacker = params.eattacker;
	origin = self.origin;
	items = self namespace_65181344::function_fd87c780(#"hash_764a785c198b6416", 1);
	foreach(item in items)
	{
		if(!isdefined(item))
		{
			continue;
		}
		item thread namespace_b912c30b::function_7a1e21a9(attacker, origin);
	}
}

/*
	Name: function_4776caf4
	Namespace: infection
	Checksum: 0x8A7D04
	Offset: 0x1270
	Size: 0xFC
	Parameters: 1
	Flags: Private, Event
*/
private event function_4776caf4(eventstruct)
{
	eventstruct.projectile endon(#"death");
	if(function_f99d2668() && isplayer(self) && isalive(self))
	{
		weaponname = eventstruct.weapon.name;
		if(weaponname != #"hash_351254cd4fc93d6e")
		{
			return;
		}
		eventstruct.projectile waittill(#"stationary");
		if(!isdefined(eventstruct.projectile))
		{
			return;
		}
		eventstruct.projectile delete();
	}
}

/*
	Name: function_fcd9114b
	Namespace: infection
	Checksum: 0xE0D236C8
	Offset: 0x1378
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fcd9114b()
{
	return self ismeleeing() && isdefined(self.var_8a022726) && isdefined(self.var_8a022726.var_a9309589) && self.var_8a022726 istriggerenabled() && self istouching(self.var_8a022726);
}

/*
	Name: function_ff850b97
	Namespace: infection
	Checksum: 0x413FF922
	Offset: 0x1400
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_ff850b97()
{
	self endon(#"death");
	while(true)
	{
		if(self function_fcd9114b())
		{
			self.var_8a022726.var_a9309589 dodamage(1, self.origin, self, self, undefined, "MOD_EXPLOSIVE");
			while(self function_fcd9114b())
			{
				waitframe(1);
			}
			continue;
		}
		waitframe(1);
	}
}

/*
	Name: function_16e24b6c
	Namespace: infection
	Checksum: 0xBD0E9F67
	Offset: 0x14A8
	Size: 0x312
	Parameters: 0
	Flags: Linked
*/
function function_16e24b6c()
{
	var_d05b667e = [#"p8_wz_door_01_frame_wooden_double":1, #"hash_6c99ba1916eb0091":1, #"hash_3044adfce9288deb":1, #"p8_wz_door_01_double_frame":1, #"hash_5ab15b04f91b09bf":1, #"hash_508d4a4298138acd":1, #"hash_20a46dc75ae6f72e":1, #"hash_798df3b536b0d16":1, #"p8_wz_door_barricade_01_sml":1, #"p8_wz_door_barricade_01_med":1, #"hash_5308594e726c540e":1, #"hash_699fd623f8d686ee":1, #"hash_1debd9bb0784f5f9":1, #"p8_wz_door_01_wood_plain":1, #"p8_wz_door_01_wood":1, #"p8_wz_door_01_turbine":1, #"p8_wz_door_01_train":1, #"hash_3f00c218be809b12":1, #"p8_wz_door_01_latch":1, #"p8_wz_door_01_frame_wooden_painted":1, #"hash_5cac930f08cac52b":1, #"p8_wz_door_01_frame":1, #"hash_7c40a6297a29d7bd":1, #"hash_505006a36f471eaf":1, #"p8_wz_door_01_factory":1, #"hash_70294bd7c3b0e2ff":1, #"p8_wz_door_01_estate":1, #"hash_290a174e389e6f29":1, #"hash_6130912b218af142":1, #"hash_88b4d6deb60840d":1, #"hash_782cd59538c6d7e9":1, #"hash_6149a1384751c8c3":1, #"hash_1d237cb3c02d5a18":1, #"p8_wz_door_01":1, #"hash_2d2d8bbfcae8b556":1];
	dynents = getdynentarray();
	foreach(dynent in dynents)
	{
		if(!isdefined(dynent.var_15d44120) || !isdefined(var_d05b667e[dynent.var_15d44120]))
		{
			continue;
		}
		dynent.ondamaged = &function_cabd9ff3;
	}
}

/*
	Name: function_cabd9ff3
	Namespace: infection
	Checksum: 0x14E106BE
	Offset: 0x17C8
	Size: 0xC6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_cabd9ff3(eventstruct)
{
	if(!isdefined(eventstruct) || !isdefined(eventstruct.attacker) || !eventstruct.attacker function_bf46a7aa())
	{
		return;
	}
	dynent = eventstruct.ent;
	if(!isdefined(dynent.var_5059b11f))
	{
		dynent.var_5059b11f = 0;
	}
	dynent.var_5059b11f++;
	if(dynent.var_5059b11f >= 2)
	{
		dynent.health = dynent.health - dynent.health;
	}
}

/*
	Name: function_44b9dd1d
	Namespace: infection
	Checksum: 0xF274B9C1
	Offset: 0x1898
	Size: 0x84
	Parameters: 0
	Flags: Private
*/
private function function_44b9dd1d()
{
	/#
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		mapname = util::function_53bbf9d2();
		adddebugcommand("");
		adddebugcommand("" + mapname + "");
	#/
}

/*
	Name: function_cdd9b388
	Namespace: infection
	Checksum: 0x73FC4480
	Offset: 0x1928
	Size: 0x2F4
	Parameters: 0
	Flags: Private
*/
private function function_cdd9b388()
{
	/#
		while(true)
		{
			if(getdvarint(#"hash_4649e82f518e2143", 0))
			{
				wait(1);
			}
			else
			{
				waitframe(1);
			}
			if(getdvarint(#"hash_4649e82f518e2143", 0))
			{
				players = getplayers();
				if(players.size <= 0)
				{
					continue;
				}
				origin = players[0].origin;
				points = [];
				if(isdefined(level.var_6990c489))
				{
					foreach(zone in level.var_6990c489)
					{
						if(!isdefined(zone.spawn_points))
						{
							continue;
						}
						points = arraycombine(points, zone.spawn_points, 1, 0);
					}
				}
				var_ea8ae4bc = 20000;
				var_654d4508 = var_ea8ae4bc * var_ea8ae4bc;
				var_84dd2a8b = 2048;
				foreach(point in points)
				{
					var_57791385 = distancesquared(origin, point.origin);
					if(var_57791385 > var_654d4508)
					{
						continue;
					}
					radius = 64;
					if(var_57791385 < var_84dd2a8b * var_84dd2a8b)
					{
						radius = max(distance(origin, point.origin) / var_84dd2a8b * radius, 1);
					}
					color = (1, 0, 1);
					sphere(point.origin, radius, color, 1, 0, 10, 20);
				}
			}
		}
	#/
}

