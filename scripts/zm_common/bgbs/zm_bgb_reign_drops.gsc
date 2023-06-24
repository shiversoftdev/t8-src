// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\bgbs\zm_bgb_extra_credit.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_reign_drops;

/*
	Name: __init__system__
	Namespace: zm_bgb_reign_drops
	Checksum: 0xA926D313
	Offset: 0x1E0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_reign_drops", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_reign_drops
	Checksum: 0x97B60822
	Offset: 0x230
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_reign_drops", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: validation
	Namespace: zm_bgb_reign_drops
	Checksum: 0x891FE169
	Offset: 0x2B0
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(level.active_powerups.size >= 9 || !self bgb::function_9d8118f5())
	{
		return false;
	}
	return true;
}

/*
	Name: activation
	Namespace: zm_bgb_reign_drops
	Checksum: 0xB2761E5B
	Offset: 0x2F8
	Size: 0x334
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect", #"bled_out");
	if(zm_custom::function_3ac936c6("zm_bgb_power_keg"))
	{
		level thread bgb::function_c6cd71d5("hero_weapon_power", self function_dfc73f65(1), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_extra_credit"))
	{
		self thread zm_bgb_extra_credit::function_22f934e6(self function_dfc73f65(2), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_dead_of_nuclear_winter"))
	{
		level thread bgb::function_c6cd71d5("nuke", self function_dfc73f65(3), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_licensed_contractor"))
	{
		level thread bgb::function_c6cd71d5("carpenter", self function_dfc73f65(4), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_on_the_house") && zm_custom::function_901b751c(#"zmperksactive"))
	{
		level thread bgb::function_c6cd71d5("free_perk", self function_dfc73f65(5), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_immolation_liquidation"))
	{
		level thread bgb::function_c6cd71d5("fire_sale", self function_dfc73f65(6), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_kill_joy"))
	{
		level thread bgb::function_c6cd71d5("insta_kill", self function_dfc73f65(7), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_cache_back"))
	{
		level thread bgb::function_c6cd71d5("full_ammo", self function_dfc73f65(8), 96);
	}
	if(zm_custom::function_3ac936c6("zm_bgb_whos_keeping_score"))
	{
		level thread bgb::function_c6cd71d5("double_points", self function_dfc73f65(9), 96);
	}
	self.var_a825ccbb = 1;
	self thread function_7f3b4877();
}

/*
	Name: function_7f3b4877
	Namespace: zm_bgb_reign_drops
	Checksum: 0xB9FE92A4
	Offset: 0x638
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_7f3b4877()
{
	self endon(#"disconnect");
	waitframe(1);
	n_start_time = gettime();
	n_total_time = 0;
	while(isdefined(level.active_powerups) && level.active_powerups.size)
	{
		wait(0.5);
		n_current_time = gettime();
		n_total_time = (n_current_time - n_start_time) / 1000;
		if(n_total_time >= 28)
		{
			break;
		}
	}
	self.var_a825ccbb = undefined;
}

/*
	Name: function_dfc73f65
	Namespace: zm_bgb_reign_drops
	Checksum: 0x2494229
	Offset: 0x6E8
	Size: 0x2CE
	Parameters: 1
	Flags: Linked
*/
function function_dfc73f65(n_position)
{
	v_powerup = self bgb::get_player_dropped_powerup_origin();
	v_up = vectorscale((0, 0, 1), 5);
	var_85660237 = (v_powerup + (anglestoforward(self.angles) * 60)) + v_up;
	var_97efa74a = (var_85660237 + (anglestoforward(self.angles) * 60)) + v_up;
	switch(n_position)
	{
		case 1:
		{
			v_origin = (v_powerup + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 2:
		{
			v_origin = v_powerup;
			break;
		}
		case 3:
		{
			v_origin = (v_powerup + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		case 4:
		{
			v_origin = (var_85660237 + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 5:
		{
			v_origin = var_85660237;
			break;
		}
		case 6:
		{
			v_origin = (var_85660237 + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		case 7:
		{
			v_origin = (var_97efa74a + (anglestoright(self.angles) * -60)) + v_up;
			break;
		}
		case 8:
		{
			v_origin = var_97efa74a;
			break;
		}
		case 9:
		{
			v_origin = (var_97efa74a + (anglestoright(self.angles) * 60)) + v_up;
			break;
		}
		default:
		{
			v_origin = v_powerup;
			break;
		}
	}
	return v_origin;
}

