// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_bgb_undead_man_walking;

/*
	Name: __init__system__
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x5ECFF494
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_undead_man_walking", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x92656164
	Offset: 0xF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_undead_man_walking", "time", 60, &enable, undefined, undefined, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x10594CE0
	Offset: 0x160
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	self thread function_da70ffac();
	if(bgb::increment_ref_count(#"zm_bgb_undead_man_walking"))
	{
		return;
	}
	function_8b96ace8(1);
	spawner::add_global_spawn_function(#"axis", &function_db1ee563);
}

/*
	Name: function_da70ffac
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x4DCB8914
	Offset: 0x220
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_da70ffac()
{
	self waittill(#"disconnect", #"bled_out", #"bgb_update");
	if(bgb::decrement_ref_count(#"zm_bgb_undead_man_walking"))
	{
		return;
	}
	spawner::remove_global_spawn_function(#"axis", &function_db1ee563);
	function_8b96ace8(0);
}

/*
	Name: function_8b96ace8
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x9DA75F05
	Offset: 0x2D8
	Size: 0x1CE
	Parameters: 1
	Flags: Linked
*/
function function_8b96ace8(b_walk = 1)
{
	a_ai = getaiarray();
	for(i = 0; i < a_ai.size; i++)
	{
		var_5d66253 = 0;
		if(isdefined(level.var_2f67e192))
		{
			var_5d66253 = [[level.var_2f67e192]](a_ai[i]);
		}
		else if(isalive(a_ai[i]) && (a_ai[i].var_6f84b820 === #"basic" || a_ai[i].var_6f84b820 === #"enhanced") && a_ai[i].team === level.zombie_team)
		{
			var_5d66253 = 1;
		}
		if(var_5d66253)
		{
			if(b_walk)
			{
				a_ai[i].zombie_move_speed_restore = a_ai[i].zombie_move_speed;
				a_ai[i].var_b518759e = 1;
				a_ai[i] zombie_utility::set_zombie_run_cycle_override_value("walk");
				continue;
			}
			a_ai[i].var_b518759e = undefined;
			a_ai[i] zombie_utility::set_zombie_run_cycle_restore_from_override();
		}
	}
}

/*
	Name: function_db1ee563
	Namespace: zm_bgb_undead_man_walking
	Checksum: 0x955C4937
	Offset: 0x4B0
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_db1ee563()
{
	var_5d66253 = 0;
	if(isdefined(level.var_2f67e192))
	{
		var_5d66253 = [[level.var_2f67e192]](self);
	}
	else if(isalive(self) && (self.var_6f84b820 === #"basic" || self.var_6f84b820 === #"enhanced") && self.team === level.zombie_team)
	{
		var_5d66253 = 1;
	}
	if(var_5d66253)
	{
		self.var_b518759e = 1;
		self zombie_utility::set_zombie_run_cycle_override_value("walk");
	}
}

