// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\acid_bomb.csc;
#using scripts\mp_common\vehicle.csc;
#using scripts\mp_common\callbacks.csc;
#using scripts\abilities\gadgets\gadget_vision_pulse.csc;
#using scripts\core_common\vehicle_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\killstreaks\helicopter_shared.csc;
#using scripts\killstreaks\airsupport.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace callback;

/*
	Name: __init__system__
	Namespace: callback
	Checksum: 0xF5E1CFAD
	Offset: 0x140
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"callback", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: callback
	Checksum: 0x7289BF0B
	Offset: 0x188
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread set_default_callbacks();
}

/*
	Name: set_default_callbacks
	Namespace: callback
	Checksum: 0xD5177BAC
	Offset: 0x1B0
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function set_default_callbacks()
{
	level.callbackplayerspawned = &playerspawned;
	level.callbackplayerlaststand = &playerlaststand;
	level.var_beec2b1 = &function_27cbba18;
	level.callbacklocalclientconnect = &localclientconnect;
	level.callbackcreatingcorpse = &creating_corpse;
	level.callbackentityspawned = &entityspawned;
	level.var_69b47c50 = &entervehicle;
	level.var_db2ec524 = &exitvehicle;
	level.callbackairsupport = &airsupport;
	level.callbackplayaifootstep = &footsteps::playaifootstep;
	level._custom_weapon_cb_func = &spawned_weapon_type;
	level.var_6b11d5f6 = &function_cbfd8fd6;
	level.gadgetvisionpulse_reveal_func = &gadget_vision_pulse::gadget_visionpulse_reveal;
}

/*
	Name: localclientconnect
	Namespace: callback
	Checksum: 0xDF968405
	Offset: 0x2F8
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function localclientconnect(localclientnum)
{
	/#
		println("" + localclientnum);
	#/
	if(isdefined(level.charactercustomizationsetup))
	{
		[[level.charactercustomizationsetup]](localclientnum);
	}
	callback(#"on_localclient_connect", localclientnum);
}

/*
	Name: function_27cbba18
	Namespace: callback
	Checksum: 0x4F3F2DAE
	Offset: 0x380
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_27cbba18(localclientnum)
{
	self callback(#"hash_781399e15b138a4e", localclientnum);
}

/*
	Name: playerlaststand
	Namespace: callback
	Checksum: 0xEAF7BE84
	Offset: 0x3B8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function playerlaststand(localclientnum)
{
	self endon(#"death");
	callback(#"on_player_laststand", localclientnum);
}

/*
	Name: playerspawned
	Namespace: callback
	Checksum: 0x278695F8
	Offset: 0x408
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function playerspawned(localclientnum)
{
	self endon(#"death");
	self notify(#"playerspawned_callback");
	self endon(#"playerspawned_callback");
	if(isdefined(level.infraredvisionset))
	{
		function_8608b950(localclientnum, level.infraredvisionset);
	}
	if(isdefined(level._playerspawned_override))
	{
		self thread [[level._playerspawned_override]](localclientnum);
		return;
	}
	if(self function_21c0fa55())
	{
		level notify(#"localplayer_spawned");
		callback(#"on_localplayer_spawned", localclientnum);
	}
	callback(#"on_player_spawned", localclientnum);
}

/*
	Name: entityspawned
	Namespace: callback
	Checksum: 0x1F076C3A
	Offset: 0x518
	Size: 0x304
	Parameters: 1
	Flags: Linked
*/
function entityspawned(localclientnum)
{
	self endon(#"death");
	if(isplayer(self))
	{
		if(isdefined(level._clientfaceanimonplayerspawned))
		{
			self thread [[level._clientfaceanimonplayerspawned]](localclientnum);
		}
	}
	if(isdefined(level._entityspawned_override))
	{
		self thread [[level._entityspawned_override]](localclientnum);
		return;
	}
	if(!isdefined(self.type))
	{
		/#
			println("");
		#/
		return;
	}
	if(self.type == "missile")
	{
		if(isdefined(level._custom_weapon_cb_func))
		{
			self thread [[level._custom_weapon_cb_func]](localclientnum);
		}
		if(self.weapon.name === "eq_acid_bomb")
		{
			self thread acid_bomb::spawned(localclientnum);
		}
	}
	else
	{
		if(self.type == "vehicle" || self.type == "helicopter" || self.type == "plane")
		{
			if(isdefined(level._customvehiclecbfunc))
			{
				self thread [[level._customvehiclecbfunc]](localclientnum);
			}
			self thread vehicle::field_toggle_exhaustfx_handler(localclientnum, undefined, 0, 1);
			self thread vehicle::field_toggle_lights_handler(localclientnum, undefined, 0, 1);
			if(self.type == "plane" || self.type == "helicopter")
			{
				self thread vehicle::aircraft_dustkick();
			}
			else
			{
				self thread vehicle::vehicle_rumble(localclientnum);
			}
			if(self.type == "helicopter")
			{
				self thread helicopter::startfx_loop(localclientnum);
			}
		}
		else
		{
			if(self.type == "scriptmover")
			{
				if(isdefined(level.var_83485e06))
				{
					self thread [[level.var_83485e06]](localclientnum);
				}
			}
			else
			{
				if(self.type == "actor")
				{
					if(isdefined(level._customactorcbfunc))
					{
						self thread [[level._customactorcbfunc]](localclientnum);
					}
				}
				else if(self.type == "NA")
				{
					if(isdefined(self.weapon))
					{
						if(isdefined(level.var_6b11d5f6))
						{
							self thread [[level.var_6b11d5f6]](localclientnum);
						}
					}
				}
			}
		}
	}
}

/*
	Name: entervehicle
	Namespace: callback
	Checksum: 0xB2F7B0C4
	Offset: 0x828
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function entervehicle(localclientnum, vehicle)
{
	if(isdefined(level.var_e583fd9b))
	{
		self thread [[level.var_e583fd9b]](localclientnum, vehicle);
	}
}

/*
	Name: exitvehicle
	Namespace: callback
	Checksum: 0xCD73CA4D
	Offset: 0x870
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function exitvehicle(localclientnum, vehicle)
{
	if(isdefined(level.var_8e36d09b))
	{
		self thread [[level.var_8e36d09b]](localclientnum, vehicle);
	}
}

/*
	Name: airsupport
	Namespace: callback
	Checksum: 0xE0C1AB32
	Offset: 0x8B8
	Size: 0x636
	Parameters: 12
	Flags: Linked
*/
function airsupport(localclientnum, x, y, z, type, yaw, team, teamfaction, owner, exittype, time, height)
{
	pos = (x, y, z);
	switch(teamfaction)
	{
		case "v":
		{
			teamfaction = #"vietcong";
			break;
		}
		case "nva":
		case "n":
		{
			teamfaction = #"nva";
			break;
		}
		case "j":
		{
			teamfaction = #"japanese";
			break;
		}
		case "m":
		{
			teamfaction = #"marines";
			break;
		}
		case "s":
		{
			teamfaction = #"specops";
			break;
		}
		case "r":
		{
			teamfaction = #"russian";
			break;
		}
		default:
		{
			/#
				println("");
			#/
			/#
				println(("" + teamfaction) + "");
			#/
			teamfaction = #"marines";
			break;
		}
	}
	switch(team)
	{
		case "x":
		{
			team = #"axis";
			break;
		}
		case "l":
		{
			team = #"allies";
			break;
		}
		case "r":
		{
			team = #"free";
			break;
		}
		default:
		{
			/#
				println(("" + team) + "");
			#/
			team = #"allies";
			break;
		}
	}
	data = spawnstruct();
	data.team = team;
	data.owner = owner;
	data.bombsite = pos;
	data.yaw = yaw;
	direction = (0, yaw, 0);
	data.direction = direction;
	data.flyheight = height;
	if(type == "a")
	{
		planehalfdistance = 12000;
		data.planehalfdistance = planehalfdistance;
		data.startpoint = pos + (vectorscale(anglestoforward(direction), -1 * planehalfdistance));
		data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
		data.planemodel = "t5_veh_air_b52";
		data.flybysound = "null";
		data.washsound = #"veh_b52_flyby_wash";
		data.apextime = 6145;
		data.exittype = -1;
		data.flyspeed = 2000;
		data.flytime = (planehalfdistance * 2) / data.flyspeed;
		planetype = "airstrike";
	}
	else
	{
		if(type == "n")
		{
			planehalfdistance = 24000;
			data.planehalfdistance = planehalfdistance;
			data.startpoint = pos + (vectorscale(anglestoforward(direction), -1 * planehalfdistance));
			data.endpoint = pos + vectorscale(anglestoforward(direction), planehalfdistance);
			data.planemodel = airsupport::getplanemodel(teamfaction);
			data.flybysound = "null";
			data.washsound = #"evt_us_napalm_wash";
			data.apextime = 2362;
			data.exittype = exittype;
			data.flyspeed = 7000;
			data.flytime = (planehalfdistance * 2) / data.flyspeed;
			planetype = "napalm";
		}
		else
		{
			/#
				println("");
				println("");
				println(type);
				println("");
			#/
			return;
		}
	}
}

/*
	Name: creating_corpse
	Namespace: callback
	Checksum: 0xBD02EA93
	Offset: 0xEF8
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function creating_corpse(localclientnum, player)
{
	params = spawnstruct();
	params.player = player;
	if(isdefined(player))
	{
		params.playername = player getplayername();
	}
	self callback(#"on_player_corpse", localclientnum, params);
}

/*
	Name: callback_stunned
	Namespace: callback
	Checksum: 0x31246C39
	Offset: 0xF90
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function callback_stunned(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.stunned = newval;
	/#
		println("");
	#/
	if(newval)
	{
		self notify(#"stunned");
	}
	else
	{
		self notify(#"not_stunned");
	}
	if(isdefined(self.stunnedcallback))
	{
		self [[self.stunnedcallback]](localclientnum, newval);
	}
}

/*
	Name: callback_emp
	Namespace: callback
	Checksum: 0x44D38C0E
	Offset: 0x1058
	Size: 0x96
	Parameters: 7
	Flags: Linked
*/
function callback_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.emp = newval;
	/#
		println("");
	#/
	if(newval)
	{
		self notify(#"emp");
	}
	else
	{
		self notify(#"not_emp");
	}
}

/*
	Name: callback_proximity
	Namespace: callback
	Checksum: 0x57175FF4
	Offset: 0x10F8
	Size: 0x4A
	Parameters: 7
	Flags: Linked
*/
function callback_proximity(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.enemyinproximity = newval;
}

