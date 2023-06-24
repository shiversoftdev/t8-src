// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_powerups.gsc;

#namespace zm_trial_magicbox_hunt;

/*
	Name: __init__system__
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0xFF2B8677
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_magicbox_hunt", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0xA95CCB58
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"magicbox_hunt", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0xA82CD81B
	Offset: 0x160
	Size: 0x114
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_dd1a18c9)
{
	level.var_dd1a18c9 = zm_trial::function_5769f26a(var_dd1a18c9);
	level.var_59f4d3a6 = 0;
	level.var_b69d170f = 0;
	level.var_bb641599 = 1;
	level.disable_firesale_drop = 1;
	zm_powerups::function_74b8ec6b("fire_sale");
	setgametypesetting(#"zmpowerupfiresale", 0);
	array::thread_all(getplayers(), &function_a4bcce4e);
	zm_trial_util::function_2976fa44(level.var_dd1a18c9);
	zm_trial_util::function_dace284(0);
	level thread function_cfb0f4d();
}

/*
	Name: on_end
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0xCD42B9B8
	Offset: 0x280
	Size: 0xF6
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	level.var_dd1a18c9 = undefined;
	level.var_59f4d3a6 = undefined;
	level.var_bb641599 = 0;
	level.disable_firesale_drop = 0;
	zm_powerups::function_41cedb05("fire_sale");
	setgametypesetting(#"zmpowerupfiresale", 1);
	array::thread_all(getplayers(), &function_e8f640a5);
	if(!level.var_b69d170f)
	{
		zm_trial::fail(#"hash_52e05a9ea3e881ea");
	}
	level.var_b69d170f = undefined;
}

/*
	Name: function_cfb0f4d
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0x4DC837F3
	Offset: 0x380
	Size: 0xD0
	Parameters: 0
	Flags: Private
*/
function private function_cfb0f4d()
{
	level endon(#"hash_7646638df88a3656", #"hash_2b35a48172d1e0c2");
	while(true)
	{
		level waittill(#"weapon_fly_away_start");
		level.var_59f4d3a6++;
		if(level.var_59f4d3a6 == level.var_dd1a18c9)
		{
			zm_trial_util::function_7d32b7d0(1);
			level.var_b69d170f = 1;
			level.var_bb641599 = 0;
			level notify(#"hash_2b35a48172d1e0c2");
		}
		else
		{
			zm_trial_util::function_dace284(level.var_59f4d3a6);
		}
	}
}

/*
	Name: function_a4bcce4e
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0x7239C5E2
	Offset: 0x458
	Size: 0x8E
	Parameters: 0
	Flags: Private
*/
function private function_a4bcce4e()
{
	for(i = 0; i < 4; i++)
	{
		str_bgb = self.bgb_pack[i];
		if(str_bgb === #"zm_bgb_immolation_liquidation")
		{
			self.var_abfa1f6a = bgb_pack::function_834d35e(i);
			self bgb_pack::function_b2308cd(i, 3);
		}
	}
}

/*
	Name: function_e8f640a5
	Namespace: zm_trial_magicbox_hunt
	Checksum: 0x5AA485B8
	Offset: 0x4F0
	Size: 0x88
	Parameters: 0
	Flags: Private
*/
function private function_e8f640a5()
{
	for(i = 0; i < 4; i++)
	{
		str_bgb = self.bgb_pack[i];
		if(str_bgb === #"zm_bgb_immolation_liquidation")
		{
			self bgb_pack::function_b2308cd(i, self.var_abfa1f6a);
			self.var_abfa1f6a = undefined;
		}
	}
}

