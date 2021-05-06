// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_55e622b35104ba68;
#using script_6de2f7255a97ab00;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_795feefe;

/*
	Name: function_89f2df9
	Namespace: namespace_795feefe
	Checksum: 0x2CB416E4
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_53d8c22399769679", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_795feefe
	Checksum: 0x9BCDADA0
	Offset: 0x140
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_5c9e1f9 = (isdefined(getgametypesetting(#"hash_701bac755292fab2")) ? getgametypesetting(#"hash_701bac755292fab2") : 0) || (isdefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);
	if(level.var_5c9e1f9)
	{
		level.var_f5ea5804 = 0;
		level callback::add_callback(#"hash_3057417db7f8acdd", &function_d53a8c5b);
		level callback::add_callback(#"hash_405e46788e83af41", &function_d53a8c5b);
		level callback::add_callback(#"hash_7912e21750e4010d", &function_d53a8c5b);
	}
	/#
		level thread function_fc45523f();
	#/
}

/*
	Name: function_d53a8c5b
	Namespace: namespace_795feefe
	Checksum: 0x68892A64
	Offset: 0x2B8
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_d53a8c5b()
{
	if(!(isdefined(level.var_f5ea5804) && level.var_f5ea5804))
	{
		var_69f123e5 = function_9dc0fa01();
		if(isdefined(var_69f123e5))
		{
			var_69f123e5 namespace_67838d10::function_723d686d();
			var_cb4de8b0 = struct::get("zombie_plane_flight_goal", "targetname");
			if(isdefined(var_cb4de8b0))
			{
				var_69f123e5 thread function_3e59cbbb(var_cb4de8b0);
			}
		}
	}
	else
	{
		level callback::remove_callback(#"hash_3057417db7f8acdd", &function_d53a8c5b);
		level callback::remove_callback(#"hash_405e46788e83af41", &function_d53a8c5b);
		level callback::remove_callback(#"hash_7912e21750e4010d", &function_d53a8c5b);
	}
}

/*
	Name: function_3e59cbbb
	Namespace: namespace_795feefe
	Checksum: 0x7DF7D86C
	Offset: 0x400
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_3e59cbbb(goal)
{
	level endon(#"game_ended");
	self endon(#"death");
	self function_a57c34b7(goal.origin, 0, 0);
	self waittill(#"goal", #"near_goal");
	self namespace_67838d10::function_723d686d();
	waitframe(1);
	self ghost();
	wait(1);
	self delete();
}

/*
	Name: function_f3dbfe8d
	Namespace: namespace_795feefe
	Checksum: 0xA9AE4388
	Offset: 0x4D8
	Size: 0x12E
	Parameters: 15
	Flags: Linked
*/
function function_f3dbfe8d(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	newhealth = max(self.health - idamage, 0);
	if(newhealth <= 0)
	{
		level.var_f5ea5804 = 1;
		self ghost();
		if(!(isdefined(level.var_f2ea2755) && level.var_f2ea2755))
		{
			namespace_8f74625a::function_8366d4d6(self.origin, #"hash_6bf51ee970d5ba5e");
			level.var_f2ea2755 = 1;
		}
	}
	return idamage;
}

/*
	Name: function_9dc0fa01
	Namespace: namespace_795feefe
	Checksum: 0xFDA160E3
	Offset: 0x610
	Size: 0x2C2
	Parameters: 0
	Flags: Linked
*/
function function_9dc0fa01()
{
	var_7206c0ef = getent("motd_plane_ee", "targetname");
	var_cb4de8b0 = struct::get("zombie_plane_flight_goal", "targetname");
	if(isdefined(level.deathcircle) && isdefined(var_7206c0ef) && isdefined(var_cb4de8b0))
	{
		center = level.deathcircle.origin;
		radius = level.deathcircle.radius;
		angle = randomint(360);
		x_pos = center[0] + radius * cos(angle);
		y_pos = center[1] + radius * sin(angle);
		var_7206c0ef.origin = (x_pos, y_pos, 10000);
		var_e3b87be8 = center[0] + radius * cos(angle + 180);
		var_8e6c495b = center[1] + radius * sin(angle + 180);
		var_cb4de8b0.origin = (var_e3b87be8, var_8e6c495b, 10000);
		var_69f123e5 = spawnvehicle("vehicle_zmb_air_alcatraz_plane", var_7206c0ef.origin, vectortoangles(vectornormalize(var_cb4de8b0.origin - var_7206c0ef.origin)));
		if(!isdefined(var_69f123e5))
		{
			return;
		}
		var_69f123e5.overridevehicledamage = &function_f3dbfe8d;
		var_69f123e5 setforcenocull();
		var_69f123e5 setneargoalnotifydist(128);
		var_69f123e5.maxhealth = 1;
		var_69f123e5 setspeed(50);
		return var_69f123e5;
	}
}

/*
	Name: function_fc45523f
	Namespace: namespace_795feefe
	Checksum: 0xD9D925C
	Offset: 0x8E0
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_fc45523f()
{
	/#
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		mapname = util::function_53bbf9d2();
		adddebugcommand("" + mapname + "");
		level thread function_37401a52();
	#/
}

/*
	Name: function_37401a52
	Namespace: namespace_795feefe
	Checksum: 0x8C1C774F
	Offset: 0x970
	Size: 0x116
	Parameters: 0
	Flags: None
*/
function function_37401a52()
{
	/#
		self notify("");
		self endon("");
		level endon(#"game_ended");
		while(true)
		{
			if(getdvarint(#"hash_533e1b9932a65628", 0))
			{
				var_69f123e5 = function_de4b0705();
				if(isdefined(var_69f123e5))
				{
					var_69f123e5 namespace_67838d10::function_723d686d();
					var_cb4de8b0 = struct::get("", "");
					if(isdefined(var_cb4de8b0))
					{
						var_69f123e5 thread function_3e59cbbb(var_cb4de8b0);
					}
				}
				setdvar(#"hash_533e1b9932a65628", 0);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_de4b0705
	Namespace: namespace_795feefe
	Checksum: 0x42C2645D
	Offset: 0xA90
	Size: 0x304
	Parameters: 0
	Flags: None
*/
function function_de4b0705()
{
	/#
		var_7206c0ef = getent("", "");
		var_cb4de8b0 = struct::get("", "");
		if(!isdefined(level.deathcircle) && isdefined(var_7206c0ef) && isdefined(var_cb4de8b0))
		{
			var_8a2c40d0 = struct::get("", "");
			if(isdefined(var_8a2c40d0))
			{
				center = var_8a2c40d0.origin;
				radius = 9000;
				angle = randomint(360);
				x_pos = center[0] + radius * cos(angle);
				y_pos = center[1] + radius * sin(angle);
				var_7206c0ef.origin = (x_pos, y_pos, 10000);
				var_e3b87be8 = center[0] + radius * cos(angle + 180);
				var_8e6c495b = center[1] + radius * sin(angle + 180);
				var_cb4de8b0.origin = (var_e3b87be8, var_8e6c495b, 10000);
				var_69f123e5 = spawnvehicle("", var_7206c0ef.origin, vectortoangles(vectornormalize(var_cb4de8b0.origin - var_7206c0ef.origin)));
				if(!isdefined(var_69f123e5))
				{
					return;
				}
				var_69f123e5.overridevehicledamage = &function_f3dbfe8d;
				var_69f123e5 setforcenocull();
				var_69f123e5 setneargoalnotifydist(128);
				var_69f123e5.maxhealth = 1;
				var_69f123e5 setspeed(50);
				return var_69f123e5;
			}
		}
		else
		{
			function_9dc0fa01();
		}
	#/
}

