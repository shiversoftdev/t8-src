// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\mp_common\item_inventory.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;

#namespace dart;

/*
	Name: __init__system__
	Namespace: dart
	Checksum: 0xF31F83BF
	Offset: 0x250
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"dart_wz", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: dart
	Checksum: 0x5306A8F
	Offset: 0x298
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_item_use(&on_item_use);
	vehicle::add_main_callback("dart_wz", &function_79a59d11);
	clientfield::register("toplayer", "dart_wz_out_of_circle", 24000, 5, "int");
	clientfield::register("toplayer", "dart_wz_static_postfx", 24000, 1, "int");
	clientfield::register("vehicle", "dart_wz_timeout_beep", 1, 1, "int");
}

/*
	Name: kill_vehicle
	Namespace: dart
	Checksum: 0x73CC0FDA
	Offset: 0x380
	Size: 0x84
	Parameters: 2
	Flags: Linked, Private
*/
function private kill_vehicle(attackingplayer, weapon = level.weaponnone)
{
	damageorigin = self.origin + (0, 0, 1);
	self finishvehicleradiusdamage(self, undefined, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", weapon, damageorigin, 400, -1, (0, 0, 1), 0);
}

/*
	Name: on_item_use
	Namespace: dart
	Checksum: 0x9B7D844B
	Offset: 0x410
	Size: 0x264
	Parameters: 1
	Flags: Linked, Private
*/
function private on_item_use(params)
{
	self endon(#"death", #"disconnect");
	if(!isdefined(params.item) || !isdefined(params.item.var_a6762160) || !isdefined(params.item.var_a6762160.weapon) || params.item.var_a6762160.weapon.name != #"dart")
	{
		return;
	}
	if(!self function_1e845317())
	{
		return;
	}
	self function_bd506c77();
	if(!self function_1e845317())
	{
		self function_c08cf66b();
		return;
	}
	traceresults = self function_8d3b7a66();
	var_7f11909d = undefined;
	var_2e2dbfa3 = undefined;
	if(isdefined(traceresults.hitent))
	{
		var_7f11909d = traceresults.origin - traceresults.hitent.origin;
		var_2e2dbfa3 = traceresults.hitent.angles;
	}
	spawnorigin = traceresults.origin;
	if(isdefined(traceresults.hitent) && isdefined(var_7f11909d))
	{
		anglesdelta = traceresults.hitent.angles - var_2e2dbfa3;
		spawnorigin = traceresults.hitent.origin + rotatepoint(var_7f11909d, anglesdelta);
	}
	self thread function_bac16d76(spawnorigin, traceresults.angles, params.item.id);
}

/*
	Name: function_1e845317
	Namespace: dart
	Checksum: 0x4EF96ACB
	Offset: 0x680
	Size: 0x6E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1e845317()
{
	if(self clientfield::get_to_player("inside_infiltration_vehicle") != 0)
	{
		return false;
	}
	if(self isinvehicle())
	{
		return false;
	}
	if(!function_3238d10d(self.origin))
	{
		return false;
	}
	return true;
}

/*
	Name: function_bd506c77
	Namespace: dart
	Checksum: 0x7FB67844
	Offset: 0x6F8
	Size: 0xEE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_bd506c77()
{
	self endon(#"death", #"disconnect");
	remoteweapon = getweapon(#"warzone_remote");
	if(self hasweapon(remoteweapon))
	{
		return;
	}
	if(self isswitchingweapons())
	{
		self waittilltimeout(2, #"weapon_change");
	}
	self giveweapon(remoteweapon);
	self switchtoweapon(remoteweapon, 1);
	self waittilltimeout(2, #"weapon_change");
}

/*
	Name: function_c08cf66b
	Namespace: dart
	Checksum: 0xE274E21C
	Offset: 0x7F0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c08cf66b()
{
	remoteweapon = getweapon(#"warzone_remote");
	self takeweapon(remoteweapon);
}

/*
	Name: function_bac16d76
	Namespace: dart
	Checksum: 0xEEA4CBB8
	Offset: 0x840
	Size: 0x214
	Parameters: 3
	Flags: Linked, Private
*/
function private function_bac16d76(spawnorigin, spawnangles, itemid)
{
	self endon(#"death", #"disconnect");
	playereyepos = self getplayercamerapos();
	vehicle = spawnvehicle(#"veh_dart_wz", spawnorigin, spawnangles);
	if(isdefined(vehicle))
	{
		level.item_vehicles[level.item_vehicles.size] = vehicle;
		vehicle.id = itemid;
		vehicle setteam(self.team);
		vehicle.team = self.team;
		vehicle setowner(self);
		vehicle.owner = self;
		vehicle.ownerentnum = self.entnum;
		vehicle thread item_inventory::function_956a8ecd();
		target_set(vehicle, (0, 0, 0));
		/#
			assert(vehicle isremotecontrol());
		#/
		vehicle usevehicle(self, 0);
		if(!self function_f35d7cf3(playereyepos, vehicle))
		{
			vehicle.origin = playereyepos;
			vehicle kill_vehicle(self, getweapon(#"dart"));
		}
	}
	else
	{
		self function_c08cf66b();
	}
}

/*
	Name: function_5f9c568d
	Namespace: dart
	Checksum: 0xD033E17B
	Offset: 0xA60
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5f9c568d(params)
{
	player = self.owner;
	player thread function_ea9fe221(self);
}

/*
	Name: function_79a59d11
	Namespace: dart
	Checksum: 0xA9A49827
	Offset: 0xAA0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function function_79a59d11()
{
	self disabledriverfiring(1);
	self.ignore_death_jolt = 1;
	self.var_92043a49 = 1;
	self.is_staircase_up = &function_5f9c568d;
	self.vehcheckforpredictedcrash = 1;
	self.predictedcollisiontime = 0.2;
	self.var_4ab08c1d = 1;
	self.glasscollision_alt = 1;
}

/*
	Name: function_8d3b7a66
	Namespace: dart
	Checksum: 0xA676B4D7
	Offset: 0xB28
	Size: 0x13A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8d3b7a66()
{
	eyeangle = self getplayerangles();
	forward = anglestoforward(eyeangle);
	eyepos = self getplayercamerapos();
	endpos = eyepos + (forward * 50);
	var_f45df727 = eyepos + (forward * 200);
	traceresults = {};
	traceresults.trace = bullettrace(eyepos, var_f45df727, 1, self, 1, 1);
	traceresults.isvalid = traceresults.trace[#"fraction"] >= 1;
	traceresults.waterdepth = 0;
	traceresults.origin = endpos;
	traceresults.angles = eyeangle;
	return traceresults;
}

/*
	Name: function_f35d7cf3
	Namespace: dart
	Checksum: 0x480206D6
	Offset: 0xC70
	Size: 0x188
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f35d7cf3(playereyepos, vehicle)
{
	eyeangle = self getplayerangles();
	forward = anglestoforward(eyeangle);
	eyepos = playereyepos;
	endpos = vehicle.origin;
	trace = bullettrace(eyepos, endpos, 1, self, 1, 1);
	if(trace[#"fraction"] < 1)
	{
		return 0;
	}
	mins = (vehicle.radius * -1, vehicle.radius * -1, vehicle.radius * -1);
	maxs = (vehicle.radius, vehicle.radius, vehicle.radius);
	trace = physicstraceex(eyepos, endpos, mins, maxs, self, 1);
	return trace[#"fraction"] >= 1;
}

/*
	Name: on_vehicle_damage
	Namespace: dart
	Checksum: 0x47A34B0C
	Offset: 0xE00
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function on_vehicle_damage(params)
{
	if(params.smeansofdeath === "MOD_CRUSH" && self isvehicleusable())
	{
		self.idflags = self.idflags | 8192;
	}
	return params.idamage;
}

/*
	Name: function_ca9b286c
	Namespace: dart
	Checksum: 0xF69CEF3D
	Offset: 0xE70
	Size: 0x19C
	Parameters: 1
	Flags: Event
*/
event function_ca9b286c(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	if(!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != #"dart_wz")
	{
		return;
	}
	vehicle.owner = self;
	self clientfield::set_to_player("dart_wz_static_postfx", 1);
	vehicle enabledartmissilelocking();
	self thread function_d13b1540(vehicle);
	vehicle thread watchownerdisconnect(self);
	vehicle thread watchremotecontroldeactivate();
	vehicle thread function_b35c5fa4();
	vehicle callback::function_36aab2f3(&dartcollision);
	vehicle callback::function_d8abfc3d(#"on_vehicle_damage", &on_vehicle_damage);
	vehicle callback::function_d8abfc3d(#"on_vehicle_killed", &on_vehicle_killed);
}

/*
	Name: watchremotecontroldeactivate
	Namespace: dart
	Checksum: 0xA10341D2
	Offset: 0x1018
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function watchremotecontroldeactivate()
{
	self notify("45eaa61d466e347f");
	self endon("45eaa61d466e347f");
	dart = self;
	player = self.owner;
	dart endon(#"death", #"remote_weapon_end");
	player endon(#"disconnect");
	while(player attackbuttonpressed())
	{
		waitframe(1);
	}
	while(true)
	{
		if(player attackbuttonpressed())
		{
			player thread function_ea9fe221(dart);
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_e011eea6
	Namespace: dart
	Checksum: 0x8F86A72
	Offset: 0x1100
	Size: 0x8C
	Parameters: 1
	Flags: Event
*/
event function_e011eea6(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	if(!isdefined(vehicle.scriptvehicletype) || vehicle.scriptvehicletype != #"dart_wz")
	{
		return;
	}
	self thread function_ea9fe221(vehicle);
}

/*
	Name: watchownerdisconnect
	Namespace: dart
	Checksum: 0x8B87C381
	Offset: 0x1198
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function watchownerdisconnect(player)
{
	self notify("3e0604a78c24647e");
	self endon("3e0604a78c24647e");
	self endon(#"death");
	player waittill(#"disconnect", #"death");
	self makevehicleunusable();
	self kill_vehicle(self);
}

/*
	Name: function_d13b1540
	Namespace: dart
	Checksum: 0xD2A3CD31
	Offset: 0x1230
	Size: 0x4C8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d13b1540(vehicle)
{
	self notify("6f85cb6661241b51");
	self endon("6f85cb6661241b51");
	self endon(#"death", #"disconnect");
	vehicle endon(#"death", #"exit_vehicle");
	var_51fede25 = gettime() + 30000;
	self vehicle::set_vehicle_drivable_time_starting_now(30000);
	var_5fa298a1 = var_51fede25 - 10000;
	var_5cf8708d = 0;
	while(true)
	{
		time = gettime();
		if(1 && time >= var_51fede25)
		{
			self thread function_ea9fe221(vehicle);
			break;
		}
		if(self inlaststand())
		{
			self thread function_ea9fe221(vehicle);
			break;
		}
		if(isdefined(self.isjammed) && self.isjammed)
		{
			self thread function_ea9fe221(vehicle);
			break;
		}
		if(self clientfield::get_to_player("inside_infiltration_vehicle") != 0)
		{
			self thread function_ea9fe221(vehicle);
			break;
		}
		if(1 && time >= var_5fa298a1 && (!(isdefined(var_5cf8708d) && var_5cf8708d)))
		{
			var_5cf8708d = 1;
			vehicle clientfield::set("dart_wz_timeout_beep", 1);
		}
		if(1)
		{
			var_aba3faed = distancesquared(self.origin, vehicle.origin);
			if(var_aba3faed > 8000 * 8000)
			{
				self thread function_ea9fe221(vehicle);
			}
		}
		waterheight = getwaterheight(vehicle.origin, 100, -10000);
		if(waterheight != 131072)
		{
			var_19dbcac7 = vehicle.origin[2] - waterheight;
			if(var_19dbcac7 <= 0)
			{
				self thread function_ea9fe221(vehicle, 1);
			}
		}
		if(isdefined(level.deathcircle))
		{
			if(distance2dsquared(vehicle.origin, level.deathcircle.origin) > level.deathcircle.radius * level.deathcircle.radius)
			{
				if(!isdefined(vehicle.var_3de57a77))
				{
					vehicle.var_3de57a77 = gettime();
				}
				var_a71a8383 = gettime() - vehicle.var_3de57a77;
				if((int(3 * 1000)) <= var_a71a8383)
				{
					vehicle usevehicle(self, 0);
					self clientfield::set_to_player("recon_out_of_circle", 0);
				}
				var_e96a9222 = min(var_a71a8383, int(3 * 1000));
				var_e96a9222 = var_e96a9222 / (int(3 * 1000));
				var_e96a9222 = var_e96a9222 * 31;
				self clientfield::set_to_player("recon_out_of_circle", int(var_e96a9222));
				waitframe(1);
			}
			else
			{
				self clientfield::set_to_player("recon_out_of_circle", 0);
				vehicle.var_3de57a77 = undefined;
				wait(0.5);
			}
		}
		else
		{
			wait(0.1);
		}
	}
}

/*
	Name: function_3a595d3c
	Namespace: dart
	Checksum: 0x1AA9C86D
	Offset: 0x1700
	Size: 0x106
	Parameters: 0
	Flags: Linked
*/
function function_3a595d3c()
{
	camera_pos = isdefined(self.owner) && (isdefined(self getseatoccupant(0)) ? self.owner getplayercamerapos() : self.origin);
	dir = anglestoforward(self.angles);
	results = bullettrace(camera_pos, camera_pos + (dir * 96), 1, self, 1, 1);
	if(isdefined(results))
	{
		if(isdefined(results[#"fraction"]) && results[#"fraction"] > 0.99)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_c6ac711a
	Namespace: dart
	Checksum: 0xBF547E45
	Offset: 0x1810
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c6ac711a(target)
{
	if(!isdefined(target))
	{
		return false;
	}
	if(target.classname != "grenade")
	{
		return false;
	}
	if(!isdefined(target.weapon) || target.weapon.name != #"dart")
	{
		return false;
	}
	if(!isdefined(target.owner) || target.owner != self)
	{
		return false;
	}
	return true;
}

/*
	Name: function_b35c5fa4
	Namespace: dart
	Checksum: 0xD16D34D1
	Offset: 0x18C0
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function function_b35c5fa4()
{
	self notify("5a365a749191eb18");
	self endon("5a365a749191eb18");
	dart = self;
	player = dart.owner;
	dart endon(#"death");
	player endon(#"death");
	if(1)
	{
		for(;;)
		{
			waitresult = undefined;
			waitresult = dart waittill(#"veh_predictedcollision");
		}
		for(;;)
		{
		}
		for(;;)
		{
		}
		if(waitresult.stype == "glass")
		{
		}
		if(player function_c6ac711a(waitresult.target))
		{
		}
		if(!isdefined(waitresult.target) && (waitresult.stype === "default" || waitresult.stype === ""))
		{
			if(self function_3a595d3c())
			{
			}
		}
		player = dart.owner;
		player thread function_ea9fe221(dart, 1);
		return;
	}
}

/*
	Name: dartcollision
	Namespace: dart
	Checksum: 0x22699F6D
	Offset: 0x1A50
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function dartcollision(params)
{
	dart = self;
	player = dart.owner;
	if(params.stype == "glass")
	{
		return;
	}
	if(!isdefined(params.entity) && (params.stype === "default" || params.stype === ""))
	{
		if(self function_3a595d3c())
		{
			return;
		}
	}
	player thread function_ea9fe221(dart, 1);
}

/*
	Name: leave_dart
	Namespace: dart
	Checksum: 0xCABBF2AB
	Offset: 0x1B28
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function leave_dart(dart)
{
	if(isdefined(self))
	{
		if(isdefined(dart) && self isinvehicle() && self getvehicleoccupied() == dart)
		{
			dart usevehicle(self, 0);
		}
		self function_c08cf66b();
	}
}

/*
	Name: function_ea9fe221
	Namespace: dart
	Checksum: 0xB65582B7
	Offset: 0x1BC0
	Size: 0x58C
	Parameters: 2
	Flags: Linked
*/
function function_ea9fe221(dart, collision)
{
	player = self;
	if(isdefined(dart))
	{
		if(isdefined(dart.var_ea9fe221) && dart.var_ea9fe221)
		{
			return;
		}
		dart.var_ea9fe221 = 1;
	}
	if(isdefined(player) && player clientfield::get_to_player("inside_infiltration_vehicle") != 0)
	{
		player clientfield::set_to_player("dart_wz_static_postfx", 0);
		player leave_dart(dart);
		if(isdefined(dart))
		{
			dart kill_vehicle(player, getweapon(#"dart"));
		}
		return;
	}
	waitframe(1);
	if(isdefined(player) && isplayer(player))
	{
		player clientfield::set_to_player("dart_wz_static_postfx", 0);
		player val::set(#"dart", "freezecontrols", 1);
		player enableweaponcycling();
		player setclientuivisibilityflag("hud_visible", 0);
	}
	if(isdefined(dart) && isvehicle(dart))
	{
		dart disabledartmissilelocking();
		dart setspeedimmediate(0);
		if(isdefined(player) && isplayer(player) && !isbot(player))
		{
			forward = anglestoforward(dart.angles);
			moveamount = vectorscale(forward, 300 * -1);
			trace = physicstrace(dart.origin, dart.origin + moveamount, (4 * -1, 4 * -1, 4 * -1), (4, 4, 4), undefined, 1);
			cam = spawn("script_model", trace[#"position"]);
			cam setmodel(#"tag_origin");
			cam linkto(dart);
			cam util::deleteaftertime(5);
		}
		dart kill_vehicle(player, getweapon(#"dart"));
	}
	if(isdefined(cam))
	{
		player camerasetposition(cam.origin);
		player camerasetlookat(dart.origin);
		player cameraactivate(1);
	}
	if(isdefined(player) && isplayer(player) && !isbot(player))
	{
		player vehicle::stop_monitor_missiles_locked_on_to_me();
		player vehicle::stop_monitor_damage_as_occupant();
	}
	waittime = 0.5;
	if(isdefined(collision) && collision)
	{
		waittime = 2;
	}
	wait(waittime);
	if(isdefined(player) && isplayer(player))
	{
		player setclientuivisibilityflag("hud_visible", 1);
		player val::reset(#"dart", "freezecontrols");
		player cameraactivate(0);
		player leave_dart(dart);
		player thread hud::fade_to_black_for_x_sec(0, 0.3, 0, 0.1);
	}
	if(isdefined(cam))
	{
		cam delete();
	}
}

/*
	Name: on_vehicle_killed
	Namespace: dart
	Checksum: 0x42E626E1
	Offset: 0x2158
	Size: 0x15C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_vehicle_killed(params)
{
	if(isdefined(params.occupants))
	{
		if(params.occupants.size > 0 && self function_c7aa9338(params.occupants))
		{
			if(isplayer(params.eattacker))
			{
				params.eattacker stats::function_dad108fa(#"destroy_equipment", 1);
				callback::callback(#"hash_67dd51a5d529c64c");
			}
		}
	}
	if(isdefined(self.owner) && isplayer(self.owner))
	{
		self.owner leave_dart(self);
	}
	wait(0.1);
	if(isdefined(self))
	{
		self.var_4217cfcb = 1;
		self ghost();
	}
	wait(2);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_c7aa9338
	Namespace: dart
	Checksum: 0xAE4AE137
	Offset: 0x22C0
	Size: 0x9A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c7aa9338(array)
{
	foreach(ent in array)
	{
		if(util::function_fbce7263(ent.team, self.team))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: getdartmissiletargets
	Namespace: dart
	Checksum: 0x1AFAC91F
	Offset: 0x2368
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function getdartmissiletargets()
{
	targets = arraycombine(target_getarray(), level.missileentities, 0, 0);
	targets = arraycombine(targets, level.players, 0, 0);
	return targets;
}

/*
	Name: isvaliddartmissiletarget
	Namespace: dart
	Checksum: 0x4DEADE95
	Offset: 0x23E0
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function isvaliddartmissiletarget(ent)
{
	player = self;
	if(!isdefined(ent))
	{
		return false;
	}
	entisplayer = isplayer(ent);
	if(entisplayer && !isalive(ent))
	{
		return false;
	}
	if(ent.ignoreme === 1)
	{
		return false;
	}
	dart = player getvehicleoccupied();
	if(!isdefined(dart))
	{
		return false;
	}
	if(distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange)
	{
		return false;
	}
	if(entisplayer && ent hasperk(#"specialty_nokillstreakreticle"))
	{
		return false;
	}
	return true;
}

/*
	Name: isstillvaliddartmissiletarget
	Namespace: dart
	Checksum: 0x94867430
	Offset: 0x2528
	Size: 0x1AE
	Parameters: 2
	Flags: Linked
*/
function isstillvaliddartmissiletarget(ent, weapon)
{
	player = self;
	if(!(target_istarget(ent) || isplayer(ent)) && (!(isdefined(ent.allowcontinuedlockonafterinvis) && ent.allowcontinuedlockonafterinvis)))
	{
		return false;
	}
	dart = player getvehicleoccupied();
	if(!isdefined(dart))
	{
		return false;
	}
	entisplayer = isplayer(ent);
	if(entisplayer && !isalive(ent))
	{
		return false;
	}
	if(ent.ignoreme === 1)
	{
		return false;
	}
	if(distancesquared(dart.origin, ent.origin) > player.dart_killstreak_weapon.lockonmaxrange * player.dart_killstreak_weapon.lockonmaxrange)
	{
		return false;
	}
	if(entisplayer && ent hasperk(#"specialty_nokillstreakreticle"))
	{
		return false;
	}
	if(!heatseekingmissile::insidestingerreticlelocked(ent, undefined, weapon))
	{
		return false;
	}
	return true;
}

/*
	Name: disabledartmissilelocking
	Namespace: dart
	Checksum: 0x794C004E
	Offset: 0x26E0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function disabledartmissilelocking()
{
	dart = self;
	player = dart.owner;
	if(isdefined(player))
	{
		player.get_stinger_target_override = undefined;
		player.is_still_valid_target_for_stinger_override = undefined;
		player.is_valid_target_for_stinger_override = undefined;
		player.dart_killstreak_weapon = undefined;
		player notify(#"stinger_irt_off");
		player heatseekingmissile::clearirtarget();
	}
}

/*
	Name: enabledartmissilelocking
	Namespace: dart
	Checksum: 0xC26B6F36
	Offset: 0x2778
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function enabledartmissilelocking()
{
	dart = self;
	player = dart.owner;
	weapon = dart seatgetweapon(0);
	if(isdefined(player))
	{
		player.get_stinger_target_override = &getdartmissiletargets;
		player.is_still_valid_target_for_stinger_override = &isstillvaliddartmissiletarget;
		player.is_valid_target_for_stinger_override = &isvaliddartmissiletarget;
		player.dart_killstreak_weapon = weapon;
		player thread heatseekingmissile::stingerirtloop(weapon);
	}
}

