// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_magicbox.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_powerup_bonfire_sale;

/*
	Name: __init__system__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x68C46370
	Offset: 0x1A8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_powerup_bonfire_sale", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x5E19CBFF
	Offset: 0x1F8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("bonfire_sale", &grab_bonfire_sale);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("bonfire_sale", "p8_zm_power_up_bonfire_sale", #"zombie/powerup_max_ammo", &zm_powerups::func_should_never_drop, 0, 0, 0, undefined, "powerup_bon_fire", "zombie_powerup_bonfire_sale_time", "zombie_powerup_bonfire_sale_on");
	}
}

/*
	Name: __main__
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x80F724D1
	Offset: 0x2A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: grab_bonfire_sale
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x44386BBF
	Offset: 0x2B0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function grab_bonfire_sale(player)
{
	level thread start_bonfire_sale(self);
	player thread zm_powerups::powerup_vo("bonfiresale");
}

/*
	Name: start_bonfire_sale
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0xF1994B5E
	Offset: 0x300
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function start_bonfire_sale(item)
{
	level notify(#"powerup bonfire sale");
	level endon(#"powerup bonfire sale");
	temp_ent = spawn("script_origin", (0, 0, 0));
	temp_ent playloopsound(#"zmb_double_point_loop");
	zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 1);
	level thread toggle_bonfire_sale_on();
	zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", 30);
	if(bgb::is_team_enabled("zm_bgb_temporal_gift"))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") + 30);
	}
	while(zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") > 0)
	{
		waitframe(1);
		zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_time") - 0.05);
	}
	zombie_utility::set_zombie_var(#"zombie_powerup_bonfire_sale_on", 0);
	level notify(#"bonfire_sale_off");
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] playsound(#"zmb_points_loop_off");
	}
	temp_ent delete();
}

/*
	Name: toggle_bonfire_sale_on
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0xAF1E75BC
	Offset: 0x580
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function toggle_bonfire_sale_on()
{
	level endon(#"powerup bonfire sale");
	if(!isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on")))
	{
		return;
	}
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_bonfire_sale_on"))
	{
		if(isdefined(level.bonfire_init_func))
		{
			level thread [[level.bonfire_init_func]]();
		}
		level waittill(#"bonfire_sale_off");
	}
}

/*
	Name: setup_bonfiresale_audio
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0x7FBDBCC6
	Offset: 0x628
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function setup_bonfiresale_audio()
{
	wait(2);
	intercom = getentarray("intercom", "targetname");
	while(true)
	{
		while(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 0)
		{
			wait(0.2);
		}
		for(i = 0; i < intercom.size; i++)
		{
			intercom[i] thread play_bonfiresale_audio();
		}
		while(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 1)
		{
			wait(0.1);
		}
		level notify(#"firesale_over");
	}
}

/*
	Name: play_bonfiresale_audio
	Namespace: zm_powerup_bonfire_sale
	Checksum: 0xA93C05FB
	Offset: 0x730
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function play_bonfiresale_audio()
{
	if(isdefined(level.sndfiresalemusoff) && level.sndfiresalemusoff)
	{
		return;
	}
	if(isdefined(level.sndannouncerisrich) && level.sndannouncerisrich)
	{
		self playloopsound(#"mus_fire_sale_rich");
	}
	else
	{
		self playloopsound(#"mus_fire_sale");
	}
	level waittill(#"firesale_over");
	self stoploopsound();
}

