// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\killstreaks\airsupport.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace planemortar;

/*
	Name: init_shared
	Namespace: planemortar
	Checksum: 0xFAAB9FA3
	Offset: 0x220
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.planemortar_shared))
	{
		level.planemortar_shared = {};
		airsupport::init_shared();
		level.planemortarexhaustfx = "killstreaks/fx8_mortar_jet_thrusters";
		level.var_913789d7 = "killstreaks/fx8_mortar_jet_contrails";
		clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int");
	}
}

/*
	Name: usekillstreakplanemortar
	Namespace: planemortar
	Checksum: 0xF535F49C
	Offset: 0x2B8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function usekillstreakplanemortar(hardpointtype)
{
	if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0)
	{
		return false;
	}
	result = self selectplanemortarlocation(hardpointtype);
	if(!isdefined(result) || !result)
	{
		return false;
	}
	return true;
}

/*
	Name: waittill_confirm_location
	Namespace: planemortar
	Checksum: 0xCA401B41
	Offset: 0x338
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function waittill_confirm_location()
{
	self endon(#"emp_jammed", #"emp_grenaded");
	waitresult = undefined;
	waitresult = self waittill(#"confirm_location");
	return waitresult.position;
}

/*
	Name: function_a3cb6b44
	Namespace: planemortar
	Checksum: 0xE8EC8839
	Offset: 0x398
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_a3cb6b44()
{
	self beginlocationmortarselection("map_mortar_selector", 800, "map_mortar_selector_done", "map_mortar_selector_radius");
}

/*
	Name: selectplanemortarlocation
	Namespace: planemortar
	Checksum: 0x78F13043
	Offset: 0x3D8
	Size: 0x23A
	Parameters: 1
	Flags: None
*/
function selectplanemortarlocation(hardpointtype)
{
	if(isdefined(level.var_30264985))
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change", #"weapon_change_complete");
	}
	self airsupport::function_9e2054b0(&function_a3cb6b44);
	locations = [];
	if(!isdefined(self.pers[#"mortarradarused"]) || !self.pers[#"mortarradarused"])
	{
		self thread singleradarsweep();
	}
	if(isdefined(level.var_269fec2))
	{
		self [[level.var_269fec2]]();
	}
	for(i = 0; i < 3; i++)
	{
		location = self airsupport::waitforlocationselection();
		if(!isdefined(self))
		{
			return 0;
		}
		if(!isdefined(location.origin))
		{
			self.pers[#"mortarradarused"] = 1;
			self notify(#"cancel_selection");
			return 0;
		}
		locations[i] = location;
	}
	if(self killstreakrules::iskillstreakallowed(hardpointtype, self.team) == 0)
	{
		self.pers[#"mortarradarused"] = 1;
		self notify(#"cancel_selection");
		return 0;
	}
	self.pers[#"mortarradarused"] = 0;
	return self airsupport::function_83904681(locations, &useplanemortar, "planemortar");
}

/*
	Name: waitplaybacktime
	Namespace: planemortar
	Checksum: 0x399D38E6
	Offset: 0x620
	Size: 0x90
	Parameters: 1
	Flags: None
*/
function waitplaybacktime(soundalias)
{
	self endon(#"death", #"disconnect");
	playbacktime = soundgetplaybacktime(soundalias);
	if(playbacktime >= 0)
	{
		waittime = playbacktime * 0.001;
		wait(waittime);
	}
	else
	{
		wait(1);
	}
	self notify(soundalias);
}

/*
	Name: singleradarsweep
	Namespace: planemortar
	Checksum: 0xE2422AF
	Offset: 0x6B8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function singleradarsweep()
{
	self endon(#"disconnect", #"cancel_selection");
	wait(0.5);
	self playlocalsound(#"mpl_killstreak_satellite");
	if(self.hasspyplane == 0 && !level.forceradar)
	{
		self thread doradarsweep();
	}
}

/*
	Name: doradarsweep
	Namespace: planemortar
	Checksum: 0x807B7EE7
	Offset: 0x748
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function doradarsweep()
{
	self setclientuivisibilityflag("g_compassShowEnemies", 1);
	wait(0.2);
	self setclientuivisibilityflag("g_compassShowEnemies", 0);
}

/*
	Name: useplanemortar
	Namespace: planemortar
	Checksum: 0x249AE97A
	Offset: 0x7A0
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function useplanemortar(positions, killstreak_id)
{
	team = self.team;
	self.planemortarpilotindex = killstreaks::get_random_pilot_index("planemortar");
	self killstreaks::play_pilot_dialog("arrive", "planemortar", undefined, self.planemortarpilotindex);
	self thread planemortar_watchforendnotify(team, killstreak_id);
	self thread doplanemortar(positions, team, killstreak_id);
	return true;
}

/*
	Name: doplanemortar
	Namespace: planemortar
	Checksum: 0x807C8376
	Offset: 0x850
	Size: 0x1B8
	Parameters: 3
	Flags: None
*/
function doplanemortar(positions, team, killstreak_id)
{
	self endon(#"emp_jammed", #"disconnect");
	yaw = randomintrange(0, 360);
	odd = 0;
	wait(1);
	foreach(position in positions)
	{
		level influencers::create_enemy_influencer("artillery", position.origin, team);
		self thread dobombrun(position.origin, yaw, team);
		if(odd == 0)
		{
			yaw = (yaw + 35) % 360;
		}
		else
		{
			yaw = (yaw + 290) % 360;
		}
		odd = (odd + 1) % 2;
		wait(0.8);
	}
	self notify(#"planemortarcomplete");
	wait(1);
	if(isdefined(level.plane_mortar_bda_dialog))
	{
		self thread [[level.plane_mortar_bda_dialog]]();
	}
}

/*
	Name: planemortar_watchforendnotify
	Namespace: planemortar
	Checksum: 0xAEE0D371
	Offset: 0xA10
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function planemortar_watchforendnotify(team, killstreak_id)
{
	self waittill(#"disconnect", #"joined_team", #"joined_spectators", #"planemortarcomplete", #"emp_jammed");
	planemortar_killstreakstop(team, killstreak_id);
}

/*
	Name: planemortar_killstreakstop
	Namespace: planemortar
	Checksum: 0xFB0A892
	Offset: 0xAA0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function planemortar_killstreakstop(team, killstreak_id)
{
	killstreakrules::killstreakstop("planemortar", team, killstreak_id);
}

/*
	Name: dobombrun
	Namespace: planemortar
	Checksum: 0x33FA5407
	Offset: 0xAE0
	Size: 0x574
	Parameters: 3
	Flags: None
*/
function dobombrun(position, yaw, team)
{
	self endon(#"emp_jammed");
	player = self;
	angles = (0, yaw, 0);
	direction = anglestoforward(angles);
	height = (airsupport::getminimumflyheight() + 2000) + (randomfloatrange(-200, 200));
	position = (position[0] + randomfloat(30), position[1] + randomfloat(30), height);
	startpoint = position + (vectorscale(direction, -12000));
	endpoint = position + vectorscale(direction, 18000);
	height = airsupport::getnoflyzoneheightcrossed(startpoint, endpoint, height);
	height = height + (randomfloatrange(-200, 200));
	startpoint = (startpoint[0], startpoint[1], height);
	position = (position[0], position[1], height);
	endpoint = (endpoint[0], endpoint[1], height);
	plane = spawn("script_model", startpoint);
	plane.weapon = getweapon("planemortar");
	plane setweapon(plane.weapon);
	plane.team = team;
	plane setteam(team);
	plane.targetname = "plane_mortar";
	plane setowner(self);
	plane.owner = self;
	plane endon(#"delete", #"death");
	plane thread planewatchforemp(self);
	plane.angles = angles;
	plane setmodel("veh_t8_mil_air_jet_fighter_mp_light");
	plane setenemymodel("veh_t8_mil_air_jet_fighter_mp_dark");
	plane clientfield::set("planemortar_contrail", 1);
	plane clientfield::set("enemyvehicle", 1);
	plane playsound(#"mpl_lightning_flyover_boom");
	plane setdrawinfrared(1);
	plane.killcament = spawn("script_model", (plane.origin + vectorscale((0, 0, 1), 700)) + (vectorscale(direction, -1500)));
	plane.killcament util::deleteaftertime(2 * 3);
	plane.killcament.angles = (15, yaw, 0);
	plane.killcament.starttime = gettime();
	plane.killcament linkto(plane);
	start = (position[0], position[1], plane.origin[2]);
	impact = bullettrace(start, start + (vectorscale((0, 0, -1), 100000)), 1, plane);
	plane moveto(endpoint, (2 * 5) / 4, 0, 0);
	plane.killcament thread followbomb(plane, position, direction, impact, player);
	wait(2 / 2);
	if(isdefined(self))
	{
		self thread dropbomb(plane, position);
	}
	wait((2 * 3) / 4);
	plane plane_cleanupondeath();
}

/*
	Name: followbomb
	Namespace: planemortar
	Checksum: 0x552A8385
	Offset: 0x1060
	Size: 0xCC
	Parameters: 5
	Flags: None
*/
function followbomb(plane, position, direction, impact, player)
{
	player endon(#"emp_jammed");
	wait((2 * 5) / 12);
	plane.killcament unlink();
	plane.killcament moveto((impact[#"position"] + vectorscale((0, 0, 1), 1000)) + (vectorscale(direction, -600)), 0.8, 0, 0.2);
}

/*
	Name: lookatexplosion
	Namespace: planemortar
	Checksum: 0x203C38B9
	Offset: 0x1138
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function lookatexplosion(bomb)
{
	while(isdefined(self) && isdefined(bomb))
	{
		angles = vectortoangles(vectornormalize(bomb.origin - self.origin));
		self.angles = (max(angles[0], 15), angles[1], angles[2]);
		waitframe(1);
	}
}

/*
	Name: planewatchforemp
	Namespace: planemortar
	Checksum: 0xA5BF038D
	Offset: 0x11E8
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function planewatchforemp(owner)
{
	self endon(#"delete", #"death");
	waitresult = undefined;
	waitresult = self waittill(#"emp_deployed");
	if(isdefined(level.planeawardscoreevent))
	{
		thread [[level.planeawardscoreevent]](waitresult.attacker, self);
	}
	self plane_cleanupondeath();
}

/*
	Name: plane_cleanupondeath
	Namespace: planemortar
	Checksum: 0xD5FF5478
	Offset: 0x1288
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function plane_cleanupondeath()
{
	self delete();
}

/*
	Name: dropbomb
	Namespace: planemortar
	Checksum: 0xC723FA43
	Offset: 0x12B0
	Size: 0x23C
	Parameters: 2
	Flags: None
*/
function dropbomb(plane, bombposition)
{
	if(!isdefined(plane.owner))
	{
		return;
	}
	z = bombposition[2];
	targets = getplayers();
	foreach(target in targets)
	{
		if(plane.owner util::isenemyplayer(target) && distance2dsquared(target.origin, bombposition) < 250000)
		{
			if(bullettracepassed((target.origin[0], target.origin[1], plane.origin[2]), target.origin, 0, plane))
			{
				bombposition = target.origin;
				break;
			}
		}
	}
	bombposition = (bombposition[0], bombposition[1], z - 100);
	bomb = self magicmissile(getweapon("planemortar"), bombposition, vectorscale((0, 0, -1), 5000));
	bomb.soundmod = "heli";
	bomb playsound(#"mpl_lightning_bomb_incoming");
	bomb.killcament = plane.killcament;
	plane.killcament thread lookatexplosion(bomb);
}

