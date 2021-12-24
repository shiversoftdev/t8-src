// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using script_5b1c3d314b9c88fb;
#using script_cb32d07c95e5628;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_dfdf035c;

/*
	Name: function_89f2df9
	Namespace: namespace_dfdf035c
	Checksum: 0xC4BD8EA
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_76cd7d750456ec41", &__init__, undefined, undefined);
}

/*
	Name: function_9738468f
	Namespace: namespace_dfdf035c
	Checksum: 0xB7B2BDB1
	Offset: 0x130
	Size: 0x5A
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_9738468f()
{
	level.var_5805dc3b = (isdefined(getgametypesetting(#"hash_5f842714fa80e5a9")) ? getgametypesetting(#"hash_5f842714fa80e5a9") : 0);
}

/*
	Name: __init__
	Namespace: namespace_dfdf035c
	Checksum: 0xB8BA93B
	Offset: 0x198
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	hidemiscmodels("poster_damaged");
}

/*
	Name: function_4776caf4
	Namespace: namespace_dfdf035c
	Checksum: 0xA115F08
	Offset: 0x1C0
	Size: 0x154
	Parameters: 1
	Flags: Private, Event
*/
private event function_4776caf4(eventstruct)
{
	if(level.inprematchperiod || !level.var_5805dc3b)
	{
		return;
	}
	var_5fd6ce38 = getent("poster_ee_trigger", "targetname");
	if(!isdefined(var_5fd6ce38))
	{
		return;
	}
	if(function_f99d2668() && isplayer(self) && isalive(self) && isdefined(eventstruct) && isdefined(eventstruct.weapon) && isdefined(var_5fd6ce38))
	{
		if(isdefined(eventstruct.projectile))
		{
			projectile = eventstruct.projectile;
			player_dist = distance(var_5fd6ce38.origin, self.origin);
			if(player_dist < 5000)
			{
				projectile thread function_3383b382(self, var_5fd6ce38);
			}
		}
	}
}

/*
	Name: function_3383b382
	Namespace: namespace_dfdf035c
	Checksum: 0x273061E5
	Offset: 0x320
	Size: 0x224
	Parameters: 2
	Flags: Linked
*/
function function_3383b382(player, var_5fd6ce38)
{
	if(!isdefined(player) || !isdefined(self) || !isdefined(var_5fd6ce38))
	{
		return;
	}
	level endon(#"game_ended");
	self endon(#"stationary");
	player endon(#"death");
	var_5fd6ce38 endon(#"death");
	var_bd332bd5 = 0;
	var_f94ce854 = self getvelocity();
	if(!isdefined(var_f94ce854))
	{
		return;
	}
	while(isdefined(self) && !var_bd332bd5 && abs(var_f94ce854[0]) > 0 && abs(var_f94ce854[1]) > 0)
	{
		var_f94ce854 = self getvelocity();
		if(self istouching(var_5fd6ce38))
		{
			if(isdefined(var_5fd6ce38.target))
			{
				var_b721e8a9 = var_5fd6ce38.target;
			}
			var_bd332bd5 = 1;
			break;
		}
		waitframe(1);
	}
	if(var_bd332bd5)
	{
		hidemiscmodels("poster_pristine");
		showmiscmodels("poster_damaged");
		playsoundatposition(#"hash_102a20c25b442146", var_5fd6ce38.origin);
		if(isdefined(var_b721e8a9))
		{
			var_5fd6ce38 function_79c8b708(var_b721e8a9);
		}
		var_5fd6ce38 delete();
	}
}

/*
	Name: function_79c8b708
	Namespace: namespace_dfdf035c
	Checksum: 0xDB61AD64
	Offset: 0x550
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_79c8b708(var_b721e8a9)
{
	if(!isdefined(var_b721e8a9))
	{
		return;
	}
	spawn_point = struct::get(var_b721e8a9, "targetname");
	if(isdefined(spawn_point))
	{
		a_items = spawn_point namespace_65181344::function_fd87c780(#"hash_21cd084aa0a5355d", 5);
		foreach(item in a_items)
		{
			if(isdefined(item))
			{
				item thread function_7a1e21a9(spawn_point.origin);
			}
			waitframe(randomintrange(1, 3));
		}
	}
}

/*
	Name: function_7a1e21a9
	Namespace: namespace_dfdf035c
	Checksum: 0x3FF55F6B
	Offset: 0x668
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_7a1e21a9(v_loc)
{
	self endon(#"death");
	self.origin = v_loc;
	self.angles = self.angles + (0, randomint(360), 0);
	trace = bullettrace(v_loc + vectorscale((0, 0, 1), 40), v_loc + (vectorscale((0, 0, -1), 150)), 0, undefined);
	if(trace[#"fraction"] < 1)
	{
		v_loc = trace[#"position"];
	}
	time = self namespace_b912c30b::fake_physicslaunch(v_loc, 100);
	wait(time);
	if(isdefined(self))
	{
		self.origin = v_loc;
	}
}

