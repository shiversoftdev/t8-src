// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_300f815a565e66fb;
#using script_383a3b1bb18ba876;
#using script_6c8abe14025b47c4;
#using script_8988fdbc78d6c53;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace emp;

/*
	Name: init_shared
	Namespace: emp
	Checksum: 0x8165F644
	Offset: 0x170
	Size: 0x1F4
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_707cab08))
	{
		level.var_707cab08 = {};
		level.var_707cab08.activeplayeremps = [];
		level.var_707cab08.activeemps = [];
		foreach(team, _ in level.teams)
		{
			level.var_707cab08.activeemps[team] = 0;
		}
		level.var_707cab08.enemyempactivefunc = &enemyempactive;
		level thread emptracker();
		clientfield::register("scriptmover", "emp_turret_init", 1, 1, "int");
		clientfield::register("vehicle", "emp_turret_deploy", 1, 1, "int");
		callback::on_spawned(&onplayerspawned);
		callback::on_connect(&onplayerconnect);
		vehicle::add_main_callback("emp_turret", &initturretvehicle);
		callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
	}
}

/*
	Name: fx_flesh_hit_neck_fatal
	Namespace: emp
	Checksum: 0x35077F94
	Offset: 0x370
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function fx_flesh_hit_neck_fatal(params)
{
	foreach(player in params.players)
	{
		if(player hasactiveemp())
		{
			scoregiven = scoreevents::processscoreevent(#"emp_assist", player, undefined, undefined);
			if(isdefined(scoregiven))
			{
				player challenges::earnedempassistscore(scoregiven);
				killstreakindex = level.killstreakindices[#"emp"];
				killstreaks::killstreak_assist(player, self, killstreakindex);
			}
		}
	}
}

/*
	Name: initturretvehicle
	Namespace: emp
	Checksum: 0x8895CEE9
	Offset: 0x490
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function initturretvehicle()
{
	turretvehicle = self;
	turretvehicle killstreaks::setup_health("emp");
	turretvehicle.damagetaken = 0;
	turretvehicle.health = turretvehicle.maxhealth;
	turretvehicle clientfield::set("enemyvehicle", 1);
	turretvehicle.soundmod = "drone_land";
	turretvehicle.overridevehiclekilled = &onturretdeath;
	target_set(turretvehicle, vectorscale((0, 0, 1), 36));
	if(isdefined(level.var_389a99a4))
	{
		turretvehicle [[level.var_389a99a4]]();
	}
}

/*
	Name: onplayerspawned
	Namespace: emp
	Checksum: 0x602E8074
	Offset: 0x580
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function onplayerspawned()
{
	self endon(#"disconnect");
	self updateemp();
}

/*
	Name: onplayerconnect
	Namespace: emp
	Checksum: 0x5760E475
	Offset: 0x5B8
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function onplayerconnect()
{
	self.entnum = self getentitynumber();
	level.var_707cab08.activeplayeremps[self.entnum] = 0;
}

/*
	Name: deployempturret
	Namespace: emp
	Checksum: 0x68B1623A
	Offset: 0x600
	Size: 0x1E4
	Parameters: 1
	Flags: None
*/
function deployempturret(emp)
{
	player = self;
	player endon(#"disconnect", #"joined_team", #"joined_spectators");
	emp endon(#"death");
	emp.vehicle useanimtree("generic");
	emp.vehicle setanim(#"o_turret_emp_core_deploy", 1);
	length = getanimlength(#"o_turret_emp_core_deploy");
	emp.vehicle clientfield::set("emp_turret_deploy", 1);
	wait(length * 0.75);
	emp.vehicle thread playempfx();
	emp.vehicle playsound(#"mpl_emp_turret_activate");
	emp.vehicle setanim(#"o_turret_emp_core_spin", 1);
	player thread emp_jamenemies(emp, 0);
	wait(length * 0.25);
	emp.vehicle clearanim(#"o_turret_emp_core_deploy", 0);
}

/*
	Name: doneempfx
	Namespace: emp
	Checksum: 0xB0DDB460
	Offset: 0x7F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function doneempfx(fxtagorigin)
{
	playfx(#"killstreaks/fx_emp_exp_death", fxtagorigin);
	playsoundatposition(#"mpl_emp_turret_deactivate", fxtagorigin);
}

/*
	Name: playempfx
	Namespace: emp
	Checksum: 0x43C11E68
	Offset: 0x848
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function playempfx()
{
	emp_vehicle = self;
	emp_vehicle playloopsound(#"mpl_emp_turret_loop_close");
	waitframe(1);
}

/*
	Name: on_timeout
	Namespace: emp
	Checksum: 0x99380E11
	Offset: 0x890
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function on_timeout()
{
	emp = self;
	if(isdefined(emp.vehicle))
	{
		fxtagorigin = emp.vehicle gettagorigin("tag_fx");
		doneempfx(fxtagorigin);
	}
	shutdownemp(emp);
}

/*
	Name: oncancelplacement
	Namespace: emp
	Checksum: 0x5F303090
	Offset: 0x920
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function oncancelplacement(emp)
{
	stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
}

/*
	Name: onturretdeath
	Namespace: emp
	Checksum: 0xFC1F2145
	Offset: 0x978
	Size: 0x5C
	Parameters: 8
	Flags: Linked
*/
function onturretdeath(inflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	self ondeath(attacker, weapon);
}

/*
	Name: ondeathafterframeend
	Namespace: emp
	Checksum: 0x8E3FC7A4
	Offset: 0x9E0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function ondeathafterframeend(attacker, weapon)
{
	waittillframeend();
	if(isdefined(self))
	{
		self ondeath(attacker, weapon);
	}
}

/*
	Name: ondeath
	Namespace: emp
	Checksum: 0xBF8404DD
	Offset: 0xA28
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function ondeath(attacker, weapon)
{
	emp_vehicle = self;
	fxtagorigin = self gettagorigin("tag_fx");
	doneempfx(fxtagorigin);
	if(isdefined(level.var_b1ffcff8))
	{
		self [[level.var_b1ffcff8]](attacker, weapon);
	}
	shutdownemp(emp_vehicle.parentstruct);
}

/*
	Name: onshutdown
	Namespace: emp
	Checksum: 0xDFDC0910
	Offset: 0xAD0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function onshutdown(emp)
{
	shutdownemp(emp);
}

/*
	Name: shutdownemp
	Namespace: emp
	Checksum: 0x40FE52B9
	Offset: 0xB00
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function shutdownemp(emp)
{
	if(!isdefined(emp))
	{
		return;
	}
	if(isdefined(emp.already_shutdown))
	{
		return;
	}
	emp.already_shutdown = 1;
	if(isdefined(emp.vehicle))
	{
		emp.vehicle clientfield::set("emp_turret_deploy", 0);
	}
	stopemp(emp.team, emp.ownerentnum, emp.originalteam, emp.killstreakid);
	if(isdefined(emp.othermodel))
	{
		emp.othermodel delete();
	}
	if(isdefined(emp.vehicle))
	{
		emp.vehicle delete();
	}
	emp delete();
}

/*
	Name: stopemp
	Namespace: emp
	Checksum: 0x80CFADB4
	Offset: 0xC28
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function stopemp(currentteam, currentownerentnum, originalteam, killstreakid)
{
	stopempeffect(currentteam, currentownerentnum);
	stopemprule(originalteam, killstreakid);
}

/*
	Name: stopempeffect
	Namespace: emp
	Checksum: 0x2E2A293C
	Offset: 0xC88
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function stopempeffect(team, ownerentnum)
{
	level.var_707cab08.activeemps[team] = 0;
	level.var_707cab08.activeplayeremps[ownerentnum] = 0;
	level notify(#"emp_updated");
}

/*
	Name: stopemprule
	Namespace: emp
	Checksum: 0xA8A0AC76
	Offset: 0xCF0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function stopemprule(killstreakoriginalteam, killstreakid)
{
	killstreakrules::killstreakstop("emp", killstreakoriginalteam, killstreakid);
}

/*
	Name: hasactiveemp
	Namespace: emp
	Checksum: 0x3114FF4F
	Offset: 0xD30
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function hasactiveemp()
{
	return level.var_707cab08.activeplayeremps[self.entnum];
}

/*
	Name: teamhasactiveemp
	Namespace: emp
	Checksum: 0xC6D7EDA4
	Offset: 0xD58
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function teamhasactiveemp(team)
{
	return level.var_707cab08.activeemps[team] > 0;
}

/*
	Name: getenemies
	Namespace: emp
	Checksum: 0x59E14CAE
	Offset: 0xD88
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function getenemies()
{
	enemies = [];
	combatants = level.players;
	if(sessionmodeiscampaigngame())
	{
		combatants = arraycombine(combatants, getactorarray(), 0, 0);
	}
	foreach(combatant in combatants)
	{
		if(combatant.team === #"spectator")
		{
			continue;
		}
		if(level.teambased && util::function_fbce7263(combatant.team, self.team) || (!level.teambased && combatant != self))
		{
			if(!isdefined(enemies))
			{
				enemies = [];
			}
			else if(!isarray(enemies))
			{
				enemies = array(enemies);
			}
			enemies[enemies.size] = combatant;
		}
	}
	return enemies;
}

/*
	Name: function_d12cde1c
	Namespace: emp
	Checksum: 0x2C4EF1C8
	Offset: 0xF20
	Size: 0x10
	Parameters: 0
	Flags: Linked
*/
function function_d12cde1c()
{
	return isdefined(level.var_707cab08);
}

/*
	Name: enemyempactive
	Namespace: emp
	Checksum: 0xD6E3D472
	Offset: 0xF38
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function enemyempactive()
{
	if(!function_d12cde1c())
	{
		return 0;
	}
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			if(util::function_fbce7263(team, self.team) && teamhasactiveemp(team))
			{
				return 1;
			}
		}
	}
	else
	{
		enemies = self getenemies();
		foreach(player in enemies)
		{
			if(player hasactiveemp())
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: enemyempowner
	Namespace: emp
	Checksum: 0xAF80B9B1
	Offset: 0x10B0
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function enemyempowner()
{
	enemies = self getenemies();
	foreach(player in enemies)
	{
		if(player hasactiveemp())
		{
			return player;
		}
	}
	return undefined;
}

/*
	Name: emp_jamenemies
	Namespace: emp
	Checksum: 0x50216CC6
	Offset: 0x1160
	Size: 0x244
	Parameters: 2
	Flags: Linked
*/
function emp_jamenemies(empent, hacked)
{
	level endon(#"game_ended");
	self endon(#"killstreak_hacked");
	if(level.teambased)
	{
		if(hacked)
		{
			level.var_707cab08.activeemps[empent.originalteam] = 0;
		}
		level.var_707cab08.activeemps[self.team] = 1;
	}
	if(hacked)
	{
		level.var_707cab08.activeplayeremps[empent.originalownerentnum] = 0;
	}
	level.var_707cab08.activeplayeremps[self.entnum] = 1;
	level notify(#"emp_updated");
	level notify(#"emp_deployed");
	visionsetnaked("flash_grenade", 1.5);
	wait(0.1);
	visionsetnaked("flash_grenade", 0);
	visionsetnaked("default", 5);
	radius = (isdefined(level.empkillstreakbundle.ksdamageradius) ? level.empkillstreakbundle.ksdamageradius : 750);
	empkillstreakweapon = getweapon(#"emp");
	empkillstreakweapon.isempkillstreak = 1;
	level killstreaks::destroyotherteamsactivevehicles(self, empkillstreakweapon, radius);
	level killstreaks::destroyotherteamsequipment(self, empkillstreakweapon, radius);
	level weaponobjects::destroy_other_teams_supplemental_watcher_objects(self, empkillstreakweapon, radius);
}

/*
	Name: emptracker
	Namespace: emp
	Checksum: 0xC370014D
	Offset: 0x13B0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function emptracker()
{
	level endon(#"game_ended");
	while(true)
	{
		level waittill(#"emp_updated");
		foreach(player in level.players)
		{
			player updateemp();
		}
	}
}

/*
	Name: updateemp
	Namespace: emp
	Checksum: 0x85553954
	Offset: 0x1478
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function updateemp()
{
	player = self;
	enemy_emp_active = player enemyempactive();
	player setempjammed(enemy_emp_active);
	emped = player isempjammed();
	player clientfield::set_to_player("empd_monitor_distance", emped);
	if(emped)
	{
		player notify(#"emp_jammed");
	}
}

