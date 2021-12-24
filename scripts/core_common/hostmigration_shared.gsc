// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace hostmigration;

/*
	Name: debug_script_structs
	Namespace: hostmigration
	Checksum: 0xA6692FB5
	Offset: 0xF0
	Size: 0x134
	Parameters: 0
	Flags: None
*/
function debug_script_structs()
{
	/#
		if(isdefined(level.struct))
		{
			println("" + level.struct.size);
			println("");
			for(i = 0; i < level.struct.size; i++)
			{
				struct = level.struct[i];
				if(isdefined(struct.targetname))
				{
					println((("" + i) + "") + struct.targetname);
					continue;
				}
				println((("" + i) + "") + "");
			}
		}
		else
		{
			println("");
		}
	#/
}

/*
	Name: updatetimerpausedness
	Namespace: hostmigration
	Checksum: 0xD98F79A8
	Offset: 0x230
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function updatetimerpausedness()
{
	shouldbestopped = isdefined(level.hostmigrationtimer);
	if(!level.timerstopped && shouldbestopped)
	{
		level.timerstopped = 1;
		level.playabletimerstopped = 1;
		level.timerpausetime = gettime();
	}
	else if(level.timerstopped && !shouldbestopped)
	{
		level.timerstopped = 0;
		level.playabletimerstopped = 0;
		level.discardtime = level.discardtime + (gettime() - level.timerpausetime);
	}
}

/*
	Name: pausetimer
	Namespace: hostmigration
	Checksum: 0xB3F39624
	Offset: 0x2F8
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function pausetimer()
{
	level.migrationtimerpausetime = gettime();
}

/*
	Name: resumetimer
	Namespace: hostmigration
	Checksum: 0x56E5439B
	Offset: 0x318
	Size: 0x2A
	Parameters: 0
	Flags: None
*/
function resumetimer()
{
	level.discardtime = level.discardtime + (gettime() - level.migrationtimerpausetime);
}

/*
	Name: locktimer
	Namespace: hostmigration
	Checksum: 0x7D35BD0F
	Offset: 0x350
	Size: 0x7E
	Parameters: 0
	Flags: None
*/
function locktimer()
{
	level endon(#"host_migration_begin", #"host_migration_end");
	for(;;)
	{
		currtime = gettime();
		waitframe(1);
		if(!level.timerstopped && isdefined(level.discardtime))
		{
			level.discardtime = level.discardtime + (gettime() - currtime);
		}
	}
}

/*
	Name: matchstarttimerconsole_internal
	Namespace: hostmigration
	Checksum: 0xB6197DAC
	Offset: 0x3D8
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function matchstarttimerconsole_internal(counttime)
{
	waittillframeend();
	level endon(#"match_start_timer_beginning");
	luinotifyevent(#"create_prematch_timer", 2, gettime() + (int(counttime * 1000)), 1);
	wait(counttime);
}

/*
	Name: matchstarttimerconsole
	Namespace: hostmigration
	Checksum: 0x963E25E
	Offset: 0x458
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function matchstarttimerconsole(type, duration)
{
	level notify(#"match_start_timer_beginning");
	waitframe(1);
	counttime = int(duration);
	if(isdefined(level.host_migration_activate_visionset_func))
	{
		level thread [[level.host_migration_activate_visionset_func]]();
	}
	var_5654073f = counttime >= 2;
	if(var_5654073f)
	{
		matchstarttimerconsole_internal(counttime);
	}
	if(isdefined(level.host_migration_deactivate_visionset_func))
	{
		level thread [[level.host_migration_deactivate_visionset_func]]();
	}
	luinotifyevent(#"prematch_timer_ended", 1, var_5654073f);
}

/*
	Name: hostmigrationwait
	Namespace: hostmigration
	Checksum: 0xD2B06B88
	Offset: 0x550
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function hostmigrationwait()
{
	level endon(#"game_ended");
	if(level.hostmigrationreturnedplayercount < (level.players.size * 2) / 3)
	{
		thread matchstarttimerconsole("waiting_for_teams", 20);
		hostmigrationwaitforplayers();
	}
	potm::function_f22ccf4a();
	level notify(#"host_migration_countdown_begin");
	thread matchstarttimerconsole("match_starting_in", 5);
	wait(5);
}

/*
	Name: waittillhostmigrationcountdown
	Namespace: hostmigration
	Checksum: 0x5A9BBE20
	Offset: 0x618
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function waittillhostmigrationcountdown()
{
	level endon(#"host_migration_end");
	if(!isdefined(level.hostmigrationtimer))
	{
		return;
	}
	level waittill(#"host_migration_countdown_begin");
}

/*
	Name: hostmigrationwaitforplayers
	Namespace: hostmigration
	Checksum: 0x2CF2107C
	Offset: 0x668
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function hostmigrationwaitforplayers()
{
	level endon(#"hostmigration_enoughplayers");
	wait(15);
}

/*
	Name: hostmigrationtimerthink_internal
	Namespace: hostmigration
	Checksum: 0x1F043121
	Offset: 0x690
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function hostmigrationtimerthink_internal()
{
	level endon(#"host_migration_begin", #"host_migration_end");
	self.hostmigrationcontrolsfrozen = 0;
	while(!isalive(self))
	{
		self waittill(#"spawned");
	}
	self.hostmigrationcontrolsfrozen = 1;
	val::set(#"hostmigration", "freezecontrols", 1);
	val::set(#"hostmigration", "disablegadgets", 1);
	level waittill(#"host_migration_end");
}

/*
	Name: hostmigrationtimerthink
	Namespace: hostmigration
	Checksum: 0xB681C5FD
	Offset: 0x780
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function hostmigrationtimerthink()
{
	self endon(#"disconnect");
	level endon(#"host_migration_begin");
	hostmigrationtimerthink_internal();
	if(self.hostmigrationcontrolsfrozen)
	{
		val::reset(#"hostmigration", "freezecontrols");
		val::reset(#"hostmigration", "disablegadgets");
	}
}

/*
	Name: waittillhostmigrationdone
	Namespace: hostmigration
	Checksum: 0xAFCD5979
	Offset: 0x820
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function waittillhostmigrationdone()
{
	if(!isdefined(level.hostmigrationtimer))
	{
		return 0;
	}
	starttime = gettime();
	level waittill(#"host_migration_end");
	return gettime() - starttime;
}

/*
	Name: waittillhostmigrationstarts
	Namespace: hostmigration
	Checksum: 0x26ACF0F7
	Offset: 0x870
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function waittillhostmigrationstarts(duration)
{
	if(isdefined(level.hostmigrationtimer))
	{
		return;
	}
	level endon(#"host_migration_begin");
	wait(duration);
}

/*
	Name: waitlongdurationwithhostmigrationpause
	Namespace: hostmigration
	Checksum: 0x1018FA09
	Offset: 0x8B0
	Size: 0x13C
	Parameters: 1
	Flags: None
*/
function waitlongdurationwithhostmigrationpause(duration)
{
	if(duration == 0)
	{
		return;
	}
	/#
		assert(duration > 0);
	#/
	starttime = gettime();
	endtime = gettime() + (int(duration * 1000));
	while(gettime() < endtime)
	{
		waittillhostmigrationstarts((float(endtime - gettime())) / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			endtime = endtime + timepassed;
		}
	}
	/#
		if(gettime() != endtime)
		{
			println((("" + gettime()) + "") + endtime);
		}
	#/
	waittillhostmigrationdone();
	return gettime() - starttime;
}

/*
	Name: waitlongdurationwithhostmigrationpauseemp
	Namespace: hostmigration
	Checksum: 0x8C8595E8
	Offset: 0x9F8
	Size: 0x15E
	Parameters: 1
	Flags: None
*/
function waitlongdurationwithhostmigrationpauseemp(duration)
{
	if(duration == 0)
	{
		return;
	}
	/#
		assert(duration > 0);
	#/
	starttime = gettime();
	empendtime = gettime() + (int(duration * 1000));
	level.empendtime = empendtime;
	while(gettime() < empendtime)
	{
		waittillhostmigrationstarts((float(empendtime - gettime())) / 1000);
		if(isdefined(level.hostmigrationtimer))
		{
			timepassed = waittillhostmigrationdone();
			if(isdefined(empendtime))
			{
				empendtime = empendtime + timepassed;
			}
		}
	}
	/#
		if(gettime() != empendtime)
		{
			println((("" + gettime()) + "") + empendtime);
		}
	#/
	waittillhostmigrationdone();
	level.empendtime = undefined;
	return gettime() - starttime;
}

/*
	Name: waitlongdurationwithgameendtimeupdate
	Namespace: hostmigration
	Checksum: 0x94CE32A4
	Offset: 0xB60
	Size: 0x196
	Parameters: 1
	Flags: None
*/
function waitlongdurationwithgameendtimeupdate(duration)
{
	if(duration == 0)
	{
		return;
	}
	/#
		assert(duration > 0);
	#/
	starttime = gettime();
	endtime = gettime() + (int(duration * 1000));
	while(gettime() < endtime)
	{
		waittillhostmigrationstarts((float(endtime - gettime())) / 1000);
		while(isdefined(level.hostmigrationtimer))
		{
			endtime = endtime + 1000;
			setgameendtime(int(endtime));
			wait(1);
		}
	}
	/#
		if(gettime() != endtime)
		{
			println((("" + gettime()) + "") + endtime);
		}
	#/
	while(isdefined(level.hostmigrationtimer))
	{
		endtime = endtime + 1000;
		setgameendtime(int(endtime));
		wait(1);
	}
	return gettime() - starttime;
}

/*
	Name: migrationawarewait
	Namespace: hostmigration
	Checksum: 0x5134BC4E
	Offset: 0xD00
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function migrationawarewait(durationms)
{
	waittillhostmigrationdone();
	endtime = gettime() + durationms;
	timeremaining = durationms;
	while(true)
	{
		event = level util::waittill_level_any_timeout(float(timeremaining) / 1000, self, "game_ended", "host_migration_begin");
		if(event != "host_migration_begin")
		{
			return;
		}
		timeremaining = endtime - gettime();
		if(timeremaining <= 0)
		{
			return;
		}
		endtime = gettime() + durationms;
		waittillhostmigrationdone();
	}
}

