// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5660bae5b402a1eb;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_free_perk;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_free_perk
	Checksum: 0x90C812FD
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_powerup_free_perk", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_free_perk
	Checksum: 0xCF08CC46
	Offset: 0x138
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("free_perk", &grab_free_perk);
	if(zm_powerups::function_cc33adc8())
	{
		str_model = zm_powerups::function_bcfcc27e();
		zm_powerups::add_zombie_powerup("free_perk", str_model, #"zombie_powerup_free_perk", &zm_powerups::func_should_never_drop, 0, 0, 0);
	}
}

/*
	Name: grab_free_perk
	Namespace: zm_powerup_free_perk
	Checksum: 0xC8F141CC
	Offset: 0x1E0
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function grab_free_perk(var_a3878cd)
{
	foreach(e_player in getplayers())
	{
		if(!e_player laststand::player_is_in_laststand() && e_player.sessionstate != "spectator")
		{
			var_16c042b8 = e_player zm_perks::function_b2cba45a();
		}
	}
}

