// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_8eb9bc0a;

/*
	Name: function_89f2df9
	Namespace: namespace_8eb9bc0a
	Checksum: 0xADFCE61F
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6d3c5317001d4fc6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8eb9bc0a
	Checksum: 0xDB0786A9
	Offset: 0x140
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	setdvar(#"hash_6d3c5317001d4fc6", 0);
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
	var_852d7a5c = isprofilebuild();
	/#
		var_852d7a5c = 1;
	#/
	if(var_852d7a5c)
	{
		level thread function_97346595();
	}
}

/*
	Name: zombie_open_sesame
	Namespace: namespace_8eb9bc0a
	Checksum: 0x125944B0
	Offset: 0x208
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function zombie_open_sesame()
{
	setdvar(#"zombie_unlock_all", 1);
	level flag::set("power_on");
	level clientfield::set("zombie_power_on", 1);
	power_trigs = getentarray("use_elec_switch", "targetname");
	foreach(trig in power_trigs)
	{
		if(isdefined(trig.script_int))
		{
			level flag::set("power_on" + trig.script_int);
			level clientfield::set("zombie_power_on", trig.script_int + 1);
		}
	}
	players = getplayers();
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(!(isdefined(zombie_doors[i].has_been_opened) && zombie_doors[i].has_been_opened))
		{
			zombie_doors[i] notify(#"trigger", {#activator:players[0]});
		}
		if(isdefined(zombie_doors[i].power_door_ignore_flag_wait) && zombie_doors[i].power_door_ignore_flag_wait)
		{
			zombie_doors[i] notify(#"power_on");
		}
		waitframe(1);
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		zombie_airlock_doors[i] notify(#"trigger", {#activator:players[0]});
		waitframe(1);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(isdefined(zombie_debris[i]))
		{
			zombie_debris[i] notify(#"trigger", {#activator:players[0]});
		}
		waitframe(1);
	}
	level notify(#"open_sesame");
	wait(1);
	setdvar(#"zombie_unlock_all", 0);
}

/*
	Name: function_97346595
	Namespace: namespace_8eb9bc0a
	Checksum: 0x6235D259
	Offset: 0x5D8
	Size: 0x27A
	Parameters: 0
	Flags: Linked
*/
function function_97346595()
{
	var_2e0b8925 = getdvarint(#"hash_6d3c5317001d4fc6", 0);
	while(true)
	{
		new_value = getdvarint(#"hash_6d3c5317001d4fc6", 0);
		players = getplayers();
		if(new_value)
		{
			foreach(player in players)
			{
				player enableinvulnerability();
			}
		}
		if(new_value != var_2e0b8925)
		{
			/#
				if(!(var_2e0b8925 && new_value))
				{
					adddebugcommand("");
				}
			#/
			if(new_value != 0)
			{
				if(new_value == 2)
				{
					level thread zombie_open_sesame();
				}
				var_b2efd61b = 4 - players.size;
				/#
					adddebugcommand("" + var_b2efd61b);
				#/
				waitframe(1);
				/#
					adddebugcommand("");
				#/
			}
			else
			{
				/#
					adddebugcommand("");
				#/
				players = getplayers();
				foreach(player in players)
				{
					player disableinvulnerability();
				}
			}
		}
		var_2e0b8925 = new_value;
		waitframe(1);
	}
}

