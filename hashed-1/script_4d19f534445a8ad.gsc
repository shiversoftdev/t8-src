// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using script_6e3c826b1814cab6;
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

#namespace zm_powerup_fire_sale;

/*
	Name: function_89f2df9
	Namespace: zm_powerup_fire_sale
	Checksum: 0x29E09EBA
	Offset: 0x1A8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_powerup_fire_sale", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_fire_sale
	Checksum: 0xA1364FB9
	Offset: 0x1F0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_powerups::register_powerup("fire_sale", &grab_fire_sale);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("fire_sale", "p7_zm_power_up_firesale", #"hash_460ca52bf94f19c0", &func_should_drop_fire_sale, 0, 0, 0, undefined, "powerup_fire_sale", "zombie_powerup_fire_sale_time", "zombie_powerup_fire_sale_on");
	}
}

/*
	Name: grab_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x71363BE9
	Offset: 0x298
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function grab_fire_sale(player)
{
	if(zm_powerups::function_cfd04802("fire_sale"))
	{
		level thread function_3ceac0e1(self, player);
	}
	else
	{
		level thread start_fire_sale(self);
	}
	player thread zm_powerups::powerup_vo("firesale");
}

/*
	Name: function_3ceac0e1
	Namespace: zm_powerup_fire_sale
	Checksum: 0x87924DD6
	Offset: 0x328
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function function_3ceac0e1(var_7d81025, player)
{
	self notify("602aa2e210cb16a0");
	self endon("602aa2e210cb16a0");
	player endon(#"disconnect");
	player thread zm_powerups::function_5091b029("fire_sale");
	player zombie_utility::function_826f5e98(#"zombie_powerup_fire_sale_on", 1);
	player zombie_utility::function_826f5e98(#"zombie_powerup_fire_sale_time", 30);
	level waittilltimeout(30, #"end_game");
	player zombie_utility::function_826f5e98(#"zombie_powerup_fire_sale_on", 0);
}

/*
	Name: start_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0x1731C7FC
	Offset: 0x420
	Size: 0x2F0
	Parameters: 1
	Flags: Linked
*/
function start_fire_sale(item)
{
	if(isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave)
	{
		while(firesale_chest_is_leaving())
		{
			waitframe(1);
		}
	}
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") > 0 && (isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")) && zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") + 30);
		return;
	}
	level notify(#"powerup_fire_sale");
	level endon(#"powerup_fire_sale");
	level thread zm_audio::sndannouncerplayvox(#"fire_sale");
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 1);
	level.disable_firesale_drop = 1;
	level thread toggle_fire_sale_on();
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", 30);
	if(bgb::is_team_enabled(#"zm_bgb_temporal_gift"))
	{
		zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") + 30);
	}
	while(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") > 0)
	{
		waitframe(1);
		zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_time", zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_time") - 0.05);
	}
	level thread check_to_clear_fire_sale();
	zombie_utility::set_zombie_var(#"zombie_powerup_fire_sale_on", 0);
	level notify(#"fire_sale_off");
}

/*
	Name: check_to_clear_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0xCFC41447
	Offset: 0x718
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function check_to_clear_fire_sale()
{
	level endon(#"powerup_fire_sale");
	while(firesale_chest_is_leaving())
	{
		waitframe(1);
	}
	wait(1);
	level.disable_firesale_drop = undefined;
}

/*
	Name: firesale_chest_is_leaving
	Namespace: zm_powerup_fire_sale
	Checksum: 0xEFB33B8F
	Offset: 0x770
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function firesale_chest_is_leaving()
{
	for(i = 0; i < level.chests.size; i++)
	{
		if(i !== level.chest_index)
		{
			if(level.chests[i].zbarrier.state === "leaving" || level.chests[i].zbarrier.state === "open" || level.chests[i].zbarrier.state === "close" || level.chests[i].zbarrier.state === "closing")
			{
				return true;
			}
		}
	}
	return false;
}

/*
	Name: toggle_fire_sale_on
	Namespace: zm_powerup_fire_sale
	Checksum: 0x789D556E
	Offset: 0x878
	Size: 0x2B4
	Parameters: 0
	Flags: Linked
*/
function toggle_fire_sale_on()
{
	level endon(#"powerup_fire_sale");
	if(!isdefined(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on")))
	{
		return;
	}
	if(!isdefined(level.chest_index))
	{
		level.chest_index = 0;
	}
	level thread sndfiresalemusic_start();
	for(i = 0; i < level.chests.size; i++)
	{
		show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();
		if(show_firesale_box)
		{
			level.chests[i].zombie_cost = 10;
			if(level.chest_index != i)
			{
				if(namespace_59ff1d6c::function_901b751c(#"hash_4e0ec3fe56f08b47") != 3)
				{
					level.chests[i].was_temp = 1;
				}
				if(isdefined(level.chests[i].hidden) && level.chests[i].hidden)
				{
					level.chests[i] thread apply_fire_sale_to_chest();
				}
			}
		}
	}
	level notify(#"fire_sale_on");
	level waittill(#"fire_sale_off");
	waittillframeend();
	level thread sndfiresalemusic_stop();
	for(i = 0; i < level.chests.size; i++)
	{
		show_firesale_box = level.chests[i] [[level._zombiemode_check_firesale_loc_valid_func]]();
		if(show_firesale_box)
		{
			if(level.chest_index != i && isdefined(level.chests[i].was_temp))
			{
				level.chests[i].was_temp = undefined;
				level thread remove_temp_chest(i);
			}
			level.chests[i].zombie_cost = level.chests[i].old_cost;
		}
	}
}

/*
	Name: apply_fire_sale_to_chest
	Namespace: zm_powerup_fire_sale
	Checksum: 0x168BF18
	Offset: 0xB38
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function apply_fire_sale_to_chest()
{
	level endon(#"fire_sale_off");
	if(self.zbarrier.state == "leaving")
	{
		self.zbarrier waittilltimeout(10, #"left");
	}
	wait(0.1);
	self thread zm_magicbox::show_chest();
}

/*
	Name: remove_temp_chest
	Namespace: zm_powerup_fire_sale
	Checksum: 0x22E6898F
	Offset: 0xBB8
	Size: 0x256
	Parameters: 1
	Flags: Linked
*/
function remove_temp_chest(chest_index)
{
	if(!isdefined(level.chests[chest_index]))
	{
		return;
	}
	level.chests[chest_index].being_removed = 1;
	while(isdefined(level.chests[chest_index]) && (isdefined(level.chests[chest_index].chest_user) || (isdefined(level.chests[chest_index]._box_open) && level.chests[chest_index]._box_open == 1)))
	{
		util::wait_network_frame();
	}
	if(zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on"))
	{
		level.chests[chest_index].was_temp = 1;
		level.chests[chest_index].zombie_cost = 10;
		level.chests[chest_index].being_removed = 0;
		return;
	}
	for(i = 0; i < chest_index; i++)
	{
		util::wait_network_frame();
	}
	playfx(level._effect[#"poltergeist"], level.chests[chest_index].orig_origin);
	util::wait_network_frame();
	if(isdefined(level.custom_firesale_box_leave) && level.custom_firesale_box_leave)
	{
		level.chests[chest_index] zm_magicbox::hide_chest(1);
	}
	else
	{
		level.chests[chest_index] zm_magicbox::hide_chest();
	}
	level.chests[chest_index].being_removed = 0;
}

/*
	Name: func_should_drop_fire_sale
	Namespace: zm_powerup_fire_sale
	Checksum: 0xC2828CB3
	Offset: 0xE18
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function func_should_drop_fire_sale()
{
	if(namespace_59ff1d6c::function_901b751c(#"hash_4e0ec3fe56f08b47") == 0 || zombie_utility::function_d2dfacfd(#"zombie_powerup_fire_sale_on") == 1 || level.chest_moves < 1 || (isdefined(level.disable_firesale_drop) && level.disable_firesale_drop))
	{
		return false;
	}
	return true;
}

/*
	Name: sndfiresalemusic_start
	Namespace: zm_powerup_fire_sale
	Checksum: 0xB9F114B4
	Offset: 0xEB8
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function sndfiresalemusic_start()
{
	array = level.chests;
	foreach(struct in array)
	{
		if(!isdefined(struct.sndent))
		{
			struct.sndent = spawn("script_origin", struct.origin + vectorscale((0, 0, 1), 100));
		}
		if(isdefined(level.player_4_vox_override) && level.player_4_vox_override)
		{
			struct.sndent playloopsound(#"mus_fire_sale_rich", 1);
			continue;
		}
		struct.sndent playloopsound(#"mus_fire_sale", 1);
	}
}

/*
	Name: sndfiresalemusic_stop
	Namespace: zm_powerup_fire_sale
	Checksum: 0x4034A32D
	Offset: 0x1000
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function sndfiresalemusic_stop()
{
	array = level.chests;
	foreach(struct in array)
	{
		if(isdefined(struct.sndent))
		{
			struct.sndent playsound(#"hash_332ced69176833bb");
			waitframe(1);
			struct.sndent delete();
			struct.sndent = undefined;
		}
	}
}

