// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_contracts.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;

#namespace zm_powerup_bonus_points_player;

/*
	Name: __init__system__
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0xF5B63A6A
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_bonus_points_player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0x3B2FBE99
	Offset: 0x170
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("bonus_points_player", &grab_bonus_points_player);
	zm_powerups::register_powerup("bonus_points_player_shared", &function_ec014d54);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("bonus_points_player", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
		zm_powerups::add_zombie_powerup("bonus_points_player_shared", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
	}
}

/*
	Name: grab_bonus_points_player
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0xA874C7E5
	Offset: 0x270
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function grab_bonus_points_player(player)
{
	level thread bonus_points_player_powerup(self, player);
	player thread zm_powerups::powerup_vo("bonus");
	if(zm_utility::is_standard())
	{
		player contracts::increment_zm_contract(#"hash_722a0179c583fff8");
	}
}

/*
	Name: function_ec014d54
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0x499C95D7
	Offset: 0x2F0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_ec014d54(player)
{
	level thread function_56784293(self, player);
	if(player !== self.var_2b5ec373)
	{
		player thread zm_powerups::powerup_vo("bonus");
		if(isdefined(self.var_2b5ec373) && (!(isdefined(self.var_2b5ec373.var_a50db39d) && self.var_2b5ec373.var_a50db39d)))
		{
			self.var_2b5ec373.var_a50db39d = 1;
			self.var_2b5ec373 zm_stats::increment_challenge_stat(#"hash_733e96c5baacb1da");
		}
	}
}

/*
	Name: bonus_points_player_powerup
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0x113D6D0F
	Offset: 0x3C0
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function bonus_points_player_powerup(item, player)
{
	if(isdefined(item.var_258c5fbc) && item.var_258c5fbc)
	{
		points = item.var_258c5fbc;
	}
	else
	{
		if(isdefined(level.var_a4c782b9) && level.var_a4c782b9)
		{
			points = randomintrange(1, 25) * 100;
		}
		else
		{
			points = 500;
		}
	}
	if(isdefined(level.bonus_points_powerup_override))
	{
		points = item [[level.bonus_points_powerup_override]](player);
	}
	if(isdefined(item.bonus_points_powerup_override))
	{
		points = item [[item.bonus_points_powerup_override]](player);
	}
	player notify(#"bonus_points_player_grabbed", {#e_powerup:item});
	player zm_score::player_add_points("bonus_points_powerup", points, undefined, undefined, undefined, undefined, 1);
}

/*
	Name: function_56784293
	Namespace: zm_powerup_bonus_points_player
	Checksum: 0xD39055F9
	Offset: 0x510
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_56784293(item, player)
{
	player notify(#"bonus_points_player_grabbed", {#e_powerup:item});
	player zm_score::player_add_points("bonus_points_powerup_shared", 500, undefined, undefined, undefined, undefined, 1);
}

