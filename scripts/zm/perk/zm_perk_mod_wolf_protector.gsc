// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\powerup\zm_powerup_hero_weapon_power.gsc;
#using scripts\zm\powerup\zm_powerup_small_ammo.gsc;
#using scripts\zm\powerup\zm_powerup_bonus_points_player.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\visionset_mgr_shared.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_perk_mod_wolf_protector;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0xA4B958F8
	Offset: 0x190
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_wolf_protector", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0xC7B0EAA5
	Offset: 0x1D8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_4e1190045ef3588b", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x977D2391
	Offset: 0x220
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_wolf_protector", "mod_wolf_protector", #"perk_wolf_protector", #"specialty_wolf_protector", 4000);
	zm_perks::register_perk_clientfields(#"specialty_mod_wolf_protector", &register_clientfield, &set_clientfield);
	zm_perks::register_perk_threads(#"specialty_mod_wolf_protector", &give_perk, &take_perk);
	callback::on_ai_killed(&on_ai_killed);
	zm_powerups::register_powerup("wolf_bonus_points", &function_5517e41a);
	zm_powerups::register_powerup("wolf_bonus_ammo", &zm_powerup_small_ammo::function_81558cdf);
	zm_powerups::register_powerup("wolf_bonus_hero_power", &zm_powerup_hero_weapon_power::hero_weapon_power);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("wolf_bonus_points", "zombie_z_money_icon", #"zombie_powerup_bonus_points", &zm_powerups::func_should_never_drop, 1, 0, 0);
		zm_powerups::add_zombie_powerup("wolf_bonus_ammo", "p7_zm_power_up_max_ammo", #"hash_69256172c78db147", &zm_powerups::func_should_never_drop, 1, 0, 0);
		zm_powerups::add_zombie_powerup("wolf_bonus_hero_power", "p8_zm_powerup_full_power", #"zombie_powerup_free_perk", &zm_powerup_hero_weapon_power::function_7e51ac0f, 1, 0, 0);
	}
}

/*
	Name: register_clientfield
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80F724D1
	Offset: 0x480
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function register_clientfield()
{
}

/*
	Name: set_clientfield
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0xE86EF71
	Offset: 0x490
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function set_clientfield(state)
{
}

/*
	Name: give_perk
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80F724D1
	Offset: 0x4A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function give_perk()
{
}

/*
	Name: take_perk
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x80A248B4
	Offset: 0x4B8
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function take_perk(b_pause, str_perk, str_result, n_slot)
{
}

/*
	Name: function_5517e41a
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x664F72E6
	Offset: 0x4E8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5517e41a(player)
{
	level thread zm_powerup_bonus_points_player::bonus_points_player_powerup(self, player);
}

/*
	Name: on_ai_killed
	Namespace: zm_perk_mod_wolf_protector
	Checksum: 0x1FDCE9C4
	Offset: 0x518
	Size: 0x232
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	e_attacker = s_params.einflictor;
	if(isdefined(e_attacker) && isplayer(e_attacker.player_owner) && e_attacker.player_owner hasperk(#"specialty_mod_wolf_protector"))
	{
		if(level.active_powerups.size < 75)
		{
			if(math::cointoss(25))
			{
				roll = function_21a3a673(0, 100);
				if(roll <= 33)
				{
					var_7d81025 = zm_powerups::specific_powerup_drop("wolf_bonus_hero_power", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);
					if(isdefined(var_7d81025))
					{
						var_7d81025 setscale(0.3);
						var_7d81025.var_c2bcd604 = 5;
					}
				}
				else
				{
					if(roll >= 66)
					{
						var_7d81025 = zm_powerups::specific_powerup_drop("wolf_bonus_ammo", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);
						if(isdefined(var_7d81025))
						{
							var_7d81025 setscale(0.3);
						}
					}
					else
					{
						var_7d81025 = zm_powerups::specific_powerup_drop("wolf_bonus_points", self.origin, undefined, 0.1, e_attacker.player_owner, 0, 1);
						if(isdefined(var_7d81025))
						{
							var_7d81025 setscale(0.3);
							var_7d81025.var_258c5fbc = 10;
						}
					}
				}
			}
		}
	}
}

