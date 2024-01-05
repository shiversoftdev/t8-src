// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_perk_mod_deadshot;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x8ECD7EB3
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_deadshot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x87A721CA
	Offset: 0x108
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_mod_deadshot_perk_for_level();
	level._effect[#"hash_950ebbfb250b43e"] = #"hash_1695e8ac20dd5629";
}

/*
	Name: enable_mod_deadshot_perk_for_level
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x48F35E10
	Offset: 0x158
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function enable_mod_deadshot_perk_for_level()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_deadshot", "mod_deadshot", #"perk_dead_shot", #"specialty_deadshot", 3000);
	zm_perks::register_perk_threads(#"specialty_mod_deadshot", &function_f93c5f09, &function_ce99709d);
	zm_perks::register_actor_damage_override(#"specialty_mod_deadshot", &function_36228265);
	callback::on_ai_killed(&on_ai_killed);
}

/*
	Name: function_f93c5f09
	Namespace: zm_perk_mod_deadshot
	Checksum: 0xBD911EB8
	Offset: 0x248
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_f93c5f09()
{
	self zm_perks::function_c8c7bc5(3, 1, #"perk_dead_shot");
	self reset_counter();
}

/*
	Name: function_ce99709d
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x490DAE90
	Offset: 0x298
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function function_ce99709d(b_pause, str_perk, str_result, n_slot)
{
	self zm_perks::function_c8c7bc5(3, 0, #"perk_dead_shot");
	self zm_perks::function_f2ff97a6(3, 0, #"perk_dead_shot");
}

/*
	Name: on_ai_killed
	Namespace: zm_perk_mod_deadshot
	Checksum: 0xB8CF56F8
	Offset: 0x318
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(params)
{
	e_attacker = params.eattacker;
	if(isplayer(e_attacker) && e_attacker hasperk(#"specialty_mod_deadshot"))
	{
		if(e_attacker zm_weapons::function_f5a0899d(params.weapon))
		{
			if(self zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath))
			{
				e_attacker.var_957a1762++;
				n_counter = math::clamp(e_attacker.var_957a1762, 0, 5);
				e_attacker zm_perks::function_f2ff97a6(3, n_counter, #"perk_dead_shot");
				if(e_attacker.var_957a1762 == 5)
				{
					e_attacker playsoundtoplayer(#"hash_6f931d032000253a", e_attacker);
				}
			}
			else
			{
				e_attacker reset_counter();
			}
		}
	}
}

/*
	Name: reset_counter
	Namespace: zm_perk_mod_deadshot
	Checksum: 0x9E73F300
	Offset: 0x480
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function reset_counter()
{
	self.var_957a1762 = 0;
	self zm_perks::function_f2ff97a6(3, self.var_957a1762, #"perk_dead_shot");
}

/*
	Name: function_36228265
	Namespace: zm_perk_mod_deadshot
	Checksum: 0xEB5E5FB0
	Offset: 0x4C8
	Size: 0x15E
	Parameters: 12
	Flags: Linked
*/
function function_36228265(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker.var_957a1762) && attacker.var_957a1762 >= 5 && attacker zm_weapons::function_f5a0899d(weapon))
	{
		playfx(level._effect[#"hash_950ebbfb250b43e"], vpoint);
		var_e99e314 = int(damage * 1.25);
		if(var_e99e314 >= self.health)
		{
			/#
				attacker zm_challenges::debug_print("");
			#/
			attacker zm_stats::increment_challenge_stat(#"hash_13d0e9e764b1b52");
		}
		return var_e99e314;
	}
	return damage;
}

