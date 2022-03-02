// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5b1c3d314b9c88fb;
#using script_8abfb58852911dd;
#using script_cb32d07c95e5628;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_fc4416da;

/*
	Name: function_89f2df9
	Namespace: namespace_fc4416da
	Checksum: 0xEEE7DE70
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_3fc11c4e389f5df9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fc4416da
	Checksum: 0x6BEA99D
	Offset: 0x138
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_eaeb557();
}

/*
	Name: function_eaeb557
	Namespace: namespace_fc4416da
	Checksum: 0xC20CFC9B
	Offset: 0x160
	Size: 0x378
	Parameters: 0
	Flags: Linked
*/
function function_eaeb557()
{
	level endon(#"game_ended");
	item_world::function_1b11e73c();
	zombie_apoc_homunculus = getdynent("zombie_apoc_homunculus");
	var_c3ff57f0 = array::randomize(getdynentarray("spring_event_homunculus"));
	b_enable = isdefined(getgametypesetting(#"hash_53b5887dea69a320")) && getgametypesetting(#"hash_53b5887dea69a320");
	if(isdefined(zombie_apoc_homunculus))
	{
		function_e2a06860(zombie_apoc_homunculus, 3);
	}
	foreach(var_4f3558ce in var_c3ff57f0)
	{
		function_e2a06860(var_4f3558ce, 3);
	}
	item_world::function_4de3ca98();
	if(isdefined(zombie_apoc_homunculus))
	{
		if(isdefined(level.var_fdbdcdfd) && level.var_fdbdcdfd)
		{
			function_e2a06860(zombie_apoc_homunculus, 1);
		}
		else
		{
			function_e2a06860(zombie_apoc_homunculus, 3);
		}
	}
	n_active = 0;
	foreach(var_4f3558ce in var_c3ff57f0)
	{
		if(b_enable && n_active < 5 && (!(isdefined(var_4f3558ce.b_disabled) && var_4f3558ce.b_disabled)))
		{
			function_e2a06860(var_4f3558ce, 1);
			n_active++;
			if(isdefined(var_4f3558ce.target))
			{
				var_d4265274 = function_c79d31c4(var_4f3558ce.target);
				foreach(var_2ba94f3f in var_d4265274)
				{
					if(var_2ba94f3f !== self)
					{
						var_2ba94f3f.b_disabled = 1;
					}
				}
			}
			continue;
		}
		function_e2a06860(var_4f3558ce, 3);
	}
}

/*
	Name: function_209450ae
	Namespace: namespace_fc4416da
	Checksum: 0x8DD96A2C
	Offset: 0x4E0
	Size: 0x2DC
	Parameters: 1
	Flags: Private, Event
*/
event private function_209450ae(eventstruct)
{
	dynent = eventstruct.ent;
	if(dynent.targetname !== "spring_event_homunculus" && dynent.targetname !== "zombie_apoc_homunculus")
	{
		return;
	}
	dynent.health = 10000;
	if(!level flagsys::get(#"hash_507a4486c4a79f1d") || (isdefined(dynent.var_1a909065) && dynent.var_1a909065))
	{
		return;
	}
	dynent.var_1a909065 = 1;
	var_7580ce3e = spawnstruct();
	var_7580ce3e.origin = dynent.origin + vectorscale((0, 0, 1), 32);
	function_e2a06860(dynent, 2);
	wait(0.7);
	if(isdefined(dynent))
	{
		function_e2a06860(dynent, 3);
	}
	if(dynent.targetname == "spring_event_homunculus")
	{
		a_items = var_7580ce3e namespace_65181344::function_fd87c780(#"hash_6da7deb599deaa8e", 5);
	}
	else
	{
		a_items = var_7580ce3e namespace_65181344::function_fd87c780(#"hash_7a5e7842cd4cca81", 7);
	}
	foreach(item in a_items)
	{
		if(isdefined(item))
		{
			item.origin = var_7580ce3e.origin;
		}
	}
	foreach(item in a_items)
	{
		if(isdefined(item))
		{
			item thread function_7a1e21a9(var_7580ce3e.origin);
		}
		waitframe(randomintrange(1, 3));
	}
	var_7580ce3e struct::delete();
}

/*
	Name: function_7a1e21a9
	Namespace: namespace_fc4416da
	Checksum: 0xB420E649
	Offset: 0x7C8
	Size: 0x1CA
	Parameters: 1
	Flags: Linked
*/
function function_7a1e21a9(v_loc)
{
	self endon(#"death");
	self.origin = v_loc;
	self.angles = self.angles + (0, randomint(360), 0);
	n_x_offset = randomintrange(8, 32);
	n_y_offset = randomintrange(8, 32);
	if(math::cointoss(50))
	{
		n_x_offset = n_x_offset * -1;
	}
	if(math::cointoss(50))
	{
		n_y_offset = n_y_offset * -1;
	}
	v_loc = v_loc + (n_x_offset, n_y_offset, 0);
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

