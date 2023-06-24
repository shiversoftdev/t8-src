// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using scripts\zm_common\trials\zm_trial_headshots_only.gsc;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_aat_plasmatic_burst;

/*
	Name: __init__system__
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xEE415EAA
	Offset: 0x150
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register("zm_aat_plasmatic_burst", &__init__, undefined, #"aat");
}

/*
	Name: __init__
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x4397D909
	Offset: 0x198
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_plasmatic_burst", 0.15, 0, 30, 5, 1, &result, "t7_hud_zm_aat_blastfurnace", "wpn_aat_blast_furnace_plr", undefined, 2);
	clientfield::register("actor", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
	clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_explosion", 1, 1, "counter");
	clientfield::register("actor", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
	clientfield::register("vehicle", "zm_aat_plasmatic_burst" + "_burn", 1, 1, "int");
}

/*
	Name: result
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xB9B7DCB2
	Offset: 0x2F8
	Size: 0x3C
	Parameters: 4
	Flags: Linked
*/
function result(death, attacker, mod, weapon)
{
	self thread function_988b8f91(attacker, weapon);
}

/*
	Name: function_988b8f91
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0xA5DAB14F
	Offset: 0x340
	Size: 0x3B8
	Parameters: 2
	Flags: Linked
*/
function function_988b8f91(e_attacker, w_weapon)
{
	if(self.birthtime == gettime())
	{
		waitframe(1);
		if(!isalive(self))
		{
			return;
		}
	}
	self thread clientfield::increment("zm_aat_plasmatic_burst" + "_explosion");
	level notify(#"plasmatic_burst", {#hash_ac85a15f:self});
	a_e_blasted_zombies = array::get_all_closest(self.origin, getaiteamarray(#"axis"), undefined, undefined, 120);
	if(a_e_blasted_zombies.size > 0)
	{
		waitframe(1);
		i = 0;
		while(i < a_e_blasted_zombies.size)
		{
			if(isalive(a_e_blasted_zombies[i]))
			{
				if(isdefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_indirect[a_e_blasted_zombies[i].archetype])
				{
					arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
					continue;
				}
				if(a_e_blasted_zombies[i] == self && (!(isdefined(level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype]) && level.aat[#"zm_aat_plasmatic_burst"].immune_result_direct[a_e_blasted_zombies[i].archetype])))
				{
					self thread zombie_death_gib(e_attacker, w_weapon);
					arrayremovevalue(a_e_blasted_zombies, a_e_blasted_zombies[i]);
					continue;
				}
				a_e_blasted_zombies[i] thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
				util::wait_network_frame();
			}
			i++;
		}
		wait(0.25);
		a_e_blasted_zombies = array::remove_dead(a_e_blasted_zombies);
		a_e_blasted_zombies = array::remove_undefined(a_e_blasted_zombies);
		foreach(var_8eee7949 in a_e_blasted_zombies)
		{
			if(isdefined(var_8eee7949))
			{
				var_8eee7949 thread function_cd252d6e(e_attacker, w_weapon);
				util::wait_network_frame(randomintrange(1, 3));
			}
		}
	}
}

/*
	Name: function_cd252d6e
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x36DF57CE
	Offset: 0x700
	Size: 0x19C
	Parameters: 2
	Flags: Linked
*/
function function_cd252d6e(e_attacker, w_weapon)
{
	self endon(#"death");
	self.var_1e7e5205 = 1;
	var_70ab6bc = int(0.5 * 3333.333);
	for(i = 0; i <= 6; i++)
	{
		self dodamage(var_70ab6bc, self.origin, e_attacker, undefined, "none", "MOD_AAT", 0, w_weapon);
		if(!isalive(self) && isplayer(e_attacker))
		{
			e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_plasmatic_burst");
		}
		wait(0.5);
	}
	if(self ishidden())
	{
		while(self ishidden())
		{
			wait(0.5);
		}
		wait(0.5);
	}
	self.var_1e7e5205 = undefined;
	self thread clientfield::set("zm_aat_plasmatic_burst" + "_burn", 0);
}

/*
	Name: zombie_death_gib
	Namespace: zm_aat_plasmatic_burst
	Checksum: 0x1D74224A
	Offset: 0x8A8
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function zombie_death_gib(e_attacker, w_weapon)
{
	if(isdefined(level.headshots_only) && level.headshots_only || zm_trial_headshots_only::is_active())
	{
		return;
	}
	if(isdefined(self.var_ba1bd9b2) && self.var_ba1bd9b2)
	{
		return;
	}
	self clientfield::set("zm_aat_plasmatic_burst" + "_burn", 1);
	gibserverutils::gibhead(self);
	if(math::cointoss())
	{
		gibserverutils::gibleftarm(self);
	}
	else
	{
		gibserverutils::gibrightarm(self);
	}
	gibserverutils::giblegs(self);
	self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_AAT", 0, w_weapon);
	if(isplayer(e_attacker))
	{
		e_attacker zm_stats::increment_challenge_stat(#"zombie_hunter_plasmatic_burst");
	}
}

