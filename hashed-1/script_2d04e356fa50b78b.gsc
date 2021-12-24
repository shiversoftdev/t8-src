// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace empgrenade;

/*
	Name: function_89f2df9
	Namespace: empgrenade
	Checksum: 0xE5FA9D25
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"empgrenade", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: empgrenade
	Checksum: 0xEF1CC4E8
	Offset: 0x158
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("toplayer", "empd", 1, 1, "int");
	clientfield::register("toplayer", "empd_monitor_distance", 1, 1, "int");
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: empgrenade
	Checksum: 0x8B740512
	Offset: 0x1E8
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self endon(#"disconnect");
	self thread monitorempgrenade();
}

/*
	Name: monitorempgrenade
	Namespace: empgrenade
	Checksum: 0xFC390910
	Offset: 0x220
	Size: 0x270
	Parameters: 0
	Flags: None
*/
function monitorempgrenade()
{
	self endon(#"disconnect", #"death", #"killempmonitor");
	self.empendtime = 0;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"emp_grenaded");
		attacker = waitresult.attacker;
		explosionpoint = waitresult.position;
		if(!isalive(self) || self hasperk(#"specialty_immuneemp"))
		{
			continue;
		}
		hurtvictim = 1;
		hurtattacker = 0;
		/#
			assert(isdefined(self.team));
		#/
		if(level.teambased && isdefined(attacker) && isdefined(attacker.team) && !util::function_fbce7263(attacker.team, self.team) && attacker != self)
		{
			friendlyfire = [[level.figure_out_friendly_fire]](self, attacker);
			if(friendlyfire == 0)
			{
				continue;
			}
			else if(friendlyfire == 1)
			{
				hurtattacker = 0;
				hurtvictim = 1;
			}
			else if(friendlyfire == 2)
			{
				hurtvictim = 0;
				hurtattacker = 1;
			}
			else if(friendlyfire == 3)
			{
				hurtattacker = 1;
				hurtvictim = 1;
			}
		}
		if(hurtvictim && isdefined(self))
		{
			self thread applyemp(attacker, explosionpoint);
		}
		if(hurtattacker && isdefined(attacker))
		{
			attacker thread applyemp(attacker, explosionpoint);
		}
	}
}

/*
	Name: applyemp
	Namespace: empgrenade
	Checksum: 0xDF7E7A4A
	Offset: 0x498
	Size: 0x37C
	Parameters: 2
	Flags: None
*/
function applyemp(attacker, explosionpoint)
{
	self notify(#"applyemp");
	self endon(#"applyemp", #"disconnect", #"death");
	waitframe(1);
	if(!(isdefined(self) && isalive(self)))
	{
		return;
	}
	if(self == attacker)
	{
		currentempduration = 1;
	}
	else
	{
		distancetoexplosion = distance(self.origin, explosionpoint);
		ratio = 1 - (distancetoexplosion / 425);
		currentempduration = 3 + (3 * ratio);
	}
	if(isdefined(self.empendtime))
	{
		emp_time_left_ms = self.empendtime - gettime();
		if(emp_time_left_ms > int(currentempduration * 1000))
		{
			self.empduration = float(emp_time_left_ms) / 1000;
		}
		else
		{
			self.empduration = currentempduration;
		}
	}
	else
	{
		self.empduration = currentempduration;
	}
	self.empgrenaded = 1;
	self shellshock(#"emp_shock", 1);
	self clientfield::set_to_player("empd", 1);
	self.empstarttime = gettime();
	self.empendtime = self.empstarttime + (int(self.empduration * 1000));
	self.empedby = attacker;
	shutdownemprebootindicatormenu();
	emprebootmenu = self openluimenu("EmpRebootIndicator");
	self setluimenudata(emprebootmenu, #"endtime", int(self.empendtime));
	self setluimenudata(emprebootmenu, #"starttime", int(self.empstarttime));
	self thread emprumbleloop(0.75);
	self setempjammed(1);
	self thread empgrenadedeathwaiter();
	if(self.empduration > 0)
	{
		wait(self.empduration);
	}
	if(isdefined(self))
	{
		self notify(#"empgrenadetimedout");
		self checktoturnoffemp();
	}
}

/*
	Name: empgrenadedeathwaiter
	Namespace: empgrenade
	Checksum: 0x40812CCF
	Offset: 0x820
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function empgrenadedeathwaiter()
{
	self notify(#"empgrenadedeathwaiter");
	self endon(#"empgrenadedeathwaiter", #"empgrenadetimedout");
	self waittill(#"death", #"hash_3ffb993d40af48ca");
	if(isdefined(self))
	{
		self checktoturnoffemp();
	}
}

/*
	Name: checktoturnoffemp
	Namespace: empgrenade
	Checksum: 0x3CFC2544
	Offset: 0x8A0
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function checktoturnoffemp()
{
	if(isdefined(self))
	{
		self.empgrenaded = 0;
		shutdownemprebootindicatormenu();
		if(isdefined(level.var_707cab08.enemyempactivefunc))
		{
			if(self [[level.var_707cab08.enemyempactivefunc]]())
			{
				return;
			}
		}
		self setempjammed(0);
		self clientfield::set_to_player("empd", 0);
	}
}

/*
	Name: shutdownemprebootindicatormenu
	Namespace: empgrenade
	Checksum: 0x595E116A
	Offset: 0x948
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function shutdownemprebootindicatormenu()
{
	emprebootmenu = self getluimenu("EmpRebootIndicator");
	if(isdefined(emprebootmenu))
	{
		self closeluimenu(emprebootmenu);
	}
}

/*
	Name: emprumbleloop
	Namespace: empgrenade
	Checksum: 0x19914E55
	Offset: 0x9A0
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function emprumbleloop(duration)
{
	self endon(#"emp_rumble_loop");
	self notify(#"emp_rumble_loop");
	goaltime = gettime() + (int(duration * 1000));
	while(gettime() < goaltime)
	{
		self playrumbleonentity("damage_heavy");
		waitframe(1);
	}
}

/*
	Name: watchempexplosion
	Namespace: empgrenade
	Checksum: 0xCB1372B5
	Offset: 0xA38
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function watchempexplosion(owner, weapon)
{
	owner endon(#"disconnect", #"team_changed");
	self endon(#"trophy_destroyed");
	owner stats::function_e24eec31(weapon, #"used", 1);
	waitresult = undefined;
	waitresult = self waittill(#"explode", #"death");
	if(waitresult._notify == "explode")
	{
		level empexplosiondamageents(owner, weapon, waitresult.position, 425, 1);
	}
}

/*
	Name: empexplosiondamageents
	Namespace: empgrenade
	Checksum: 0x941863D2
	Offset: 0xB40
	Size: 0x118
	Parameters: 5
	Flags: None
*/
function empexplosiondamageents(owner, weapon, origin, radius, damageplayers)
{
	ents = getdamageableentarray(origin, radius);
	if(!isdefined(damageplayers))
	{
		damageplayers = 1;
	}
	foreach(ent in ents)
	{
		if(!damageplayers && isplayer(ent))
		{
			continue;
		}
		ent dodamage(1, origin, owner, owner, "none", "MOD_GRENADE_SPLASH", 0, weapon);
	}
}

/*
	Name: function_b18444ea
	Namespace: empgrenade
	Checksum: 0x976B0D1F
	Offset: 0xC60
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event function_b18444ea(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(grenade util::ishacked())
	{
		return;
	}
	if(weapon.isemp)
	{
		grenade thread watchempexplosion(self, weapon);
	}
}

