// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_bgb_burned_out;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_burned_out
	Checksum: 0xAF93A916
	Offset: 0x148
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_burned_out", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_burned_out
	Checksum: 0x4C1DBF2B
	Offset: 0x198
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_burned_out", "event", &event, undefined, undefined, undefined);
	clientfield::register("toplayer", "zm_bgb_burned_out" + "_1p" + "toplayer", 1, 1, "counter");
	clientfield::register("allplayers", "zm_bgb_burned_out" + "_3p" + "_allplayers", 1, 1, "counter");
	clientfield::register("actor", "zm_bgb_burned_out" + "_fire_torso" + "_actor", 1, 1, "counter");
	clientfield::register("vehicle", "zm_bgb_burned_out" + "_fire_torso" + "_vehicle", 1, 1, "counter");
}

/*
	Name: event
	Namespace: zm_bgb_burned_out
	Checksum: 0xF73B4FC2
	Offset: 0x308
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function event()
{
	self endon(#"disconnect", #"bgb_update");
	var_3c24cb96 = 0;
	self thread bgb::set_timer(3, 3);
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage", #"damage_armor");
		type = waitresult.mod;
		attacker = waitresult.attacker;
		if("MOD_MELEE" != type || !isai(attacker))
		{
			continue;
		}
		self thread result();
		self playsound(#"zmb_bgb_powerup_burnedout");
		var_3c24cb96++;
		self thread bgb::set_timer(3 - var_3c24cb96, 3);
		self bgb::do_one_shot_use();
		if(3 <= var_3c24cb96)
		{
			return;
		}
		wait(1.5);
	}
}

/*
	Name: result
	Namespace: zm_bgb_burned_out
	Checksum: 0x22F8524D
	Offset: 0x490
	Size: 0x3C6
	Parameters: 0
	Flags: Linked
*/
function result()
{
	self clientfield::increment_to_player("zm_bgb_burned_out" + "_1p" + "toplayer");
	self clientfield::increment("zm_bgb_burned_out" + "_3p" + "_allplayers");
	zombies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 128);
	if(!isdefined(zombies))
	{
		return;
	}
	dist_sq = 128 * 128;
	var_7694ea6b = [];
	for(i = 0; i < zombies.size; i++)
	{
		if(zombies[i].var_6f84b820 !== #"basic" && zombies[i].var_6f84b820 !== #"popcorn" && zombies[i].var_6f84b820 !== #"enhanced")
		{
			continue;
		}
		if(isdefined(zombies[i].ignore_nuke) && zombies[i].ignore_nuke)
		{
			continue;
		}
		if(isdefined(zombies[i].marked_for_death) && zombies[i].marked_for_death)
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(zombies[i]))
		{
			continue;
		}
		zombies[i].marked_for_death = 1;
		if(!isalive(zombies[i]))
		{
			continue;
		}
		if(isvehicle(zombies[i]))
		{
			zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_vehicle");
		}
		else
		{
			zombies[i] clientfield::increment("zm_bgb_burned_out" + "_fire_torso" + "_actor");
		}
		var_7694ea6b[var_7694ea6b.size] = zombies[i];
	}
	for(i = 0; i < var_7694ea6b.size; i++)
	{
		util::wait_network_frame();
		if(!isdefined(var_7694ea6b[i]))
		{
			continue;
		}
		if(zm_utility::is_magic_bullet_shield_enabled(var_7694ea6b[i]))
		{
			continue;
		}
		var_7694ea6b[i] dodamage(var_7694ea6b[i].health + 666, var_7694ea6b[i].origin, self, undefined, undefined, "MOD_BURNED", 0, level.var_78032351);
		if(isdefined(self))
		{
			self zm_stats::increment_challenge_stat(#"gum_gobbler_burned_out");
		}
	}
}

