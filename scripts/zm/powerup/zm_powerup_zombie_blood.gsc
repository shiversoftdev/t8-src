// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_powerups.gsc;

#namespace zm_powerup_zombie_blood;

/*
	Name: __init__system__
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x99A1173
	Offset: 0x1F0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register("zm_powerup_zombie_blood", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x2B51AE8F
	Offset: 0x230
	Size: 0x204
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"player_zombie_blood_fx", 1, 1, "int");
	zm_powerups::register_powerup("zombie_blood", &grab_zombie_blood);
	if(zm_powerups::function_cc33adc8())
	{
		zm_powerups::add_zombie_powerup("zombie_blood", "p8_zm_esc_blood_power_up", #"zombie_powerup_max_ammo", &zm_powerups::func_should_never_drop, 1, 0, 0, undefined, "powerup_zombie_blood", "zombie_powerup_zombie_blood_time", "zombie_powerup_zombie_blood_on", 1, 0);
		zm_powerups::powerup_set_can_pick_up_in_last_stand("zombie_blood", 0);
		zm_powerups::powerup_set_statless_powerup("zombie_blood");
	}
	callback::on_connect(&init_player_zombie_blood_vars);
	level.a_zombie_blood_entities = getentarray("zombie_blood_visible", "targetname");
	if(isdefined(level.a_zombie_blood_entities))
	{
		foreach(var_8bd48f90 in level.a_zombie_blood_entities)
		{
			var_8bd48f90 thread make_zombie_blood_entity();
		}
	}
	/#
		level thread function_98b48c31();
	#/
}

/*
	Name: init_player_zombie_blood_vars
	Namespace: zm_powerup_zombie_blood
	Checksum: 0xEFBC5298
	Offset: 0x440
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function init_player_zombie_blood_vars()
{
	self.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 0;
	self.zombie_vars[#"zombie_powerup_zombie_blood_time"] = 30;
}

/*
	Name: grab_zombie_blood
	Namespace: zm_powerup_zombie_blood
	Checksum: 0xEFB9DB7
	Offset: 0x488
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function grab_zombie_blood(e_player)
{
	level thread zombie_blood_powerup(self, e_player);
}

/*
	Name: zombie_blood_powerup
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x1170E05B
	Offset: 0x4B8
	Size: 0x4C0
	Parameters: 2
	Flags: Linked
*/
function zombie_blood_powerup(var_9c0bf2db, e_player)
{
	e_player notify(#"zombie_blood");
	e_player endon(#"disconnect", #"zombie_blood");
	e_player thread zm_powerups::powerup_vo("zombie_blood");
	e_player._show_solo_hud = 1;
	if(bgb::is_team_enabled("zm_bgb_temporal_gift"))
	{
		var_9445281 = 60;
	}
	else
	{
		var_9445281 = 30;
	}
	if(!e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"])
	{
		e_player val::set("zombie_blood", "ignoreme", 1);
	}
	e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = var_9445281;
	e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 1;
	e_player setcharacteroutfit(1);
	level notify(#"player_zombie_blood", e_player);
	e_player clientfield::set("" + #"player_zombie_blood_fx", 1);
	level.a_zombie_blood_entities = array::remove_undefined(level.a_zombie_blood_entities);
	foreach(e_zombie_blood in level.a_zombie_blood_entities)
	{
		if(isdefined(e_zombie_blood.e_unique_player))
		{
			if(e_zombie_blood.e_unique_player == e_player)
			{
				e_zombie_blood setvisibletoplayer(e_player);
			}
			continue;
		}
		e_zombie_blood setvisibletoplayer(e_player);
	}
	e_player thread watch_zombie_blood_early_exit();
	while(e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] >= 0)
	{
		waitframe(1);
		e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] - 0.05;
	}
	e_player setcharacteroutfit(0);
	e_player notify(#"zombie_blood_over");
	if(isdefined(e_player.characterindex))
	{
		e_player playsound((("vox_plr_" + e_player.characterindex) + "_exert_grunt_") + randomintrange(0, 3));
	}
	e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"] = 0;
	e_player.zombie_vars[#"zombie_powerup_zombie_blood_time"] = 30;
	e_player._show_solo_hud = 0;
	e_player clientfield::set("" + #"player_zombie_blood_fx", 0);
	e_player val::reset("zombie_blood", "ignoreme");
	level.a_zombie_blood_entities = array::remove_undefined(level.a_zombie_blood_entities);
	foreach(e_zombie_blood in level.a_zombie_blood_entities)
	{
		e_zombie_blood setinvisibletoplayer(e_player);
	}
}

/*
	Name: watch_zombie_blood_early_exit
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x492966B6
	Offset: 0x980
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function watch_zombie_blood_early_exit()
{
	self notify(#"early_exit_watch");
	self endon(#"disconnect", #"early_exit_watch", #"zombie_blood_over");
	util::waittill_any_ents_two(self, "player_downed", level, "end_game");
	self.zombie_vars[#"zombie_powerup_zombie_blood_time"] = -0.05;
	self.early_exit = 1;
}

/*
	Name: make_zombie_blood_entity
	Namespace: zm_powerup_zombie_blood
	Checksum: 0xA8410284
	Offset: 0xA30
	Size: 0x190
	Parameters: 0
	Flags: Linked
*/
function make_zombie_blood_entity()
{
	/#
		assert(isdefined(level.a_zombie_blood_entities), "");
	#/
	if(!isdefined(level.a_zombie_blood_entities))
	{
		level.a_zombie_blood_entities = [];
	}
	else if(!isarray(level.a_zombie_blood_entities))
	{
		level.a_zombie_blood_entities = array(level.a_zombie_blood_entities);
	}
	level.a_zombie_blood_entities[level.a_zombie_blood_entities.size] = self;
	self setinvisibletoall();
	foreach(e_player in getplayers())
	{
		if(e_player.zombie_vars[#"zombie_powerup_zombie_blood_on"])
		{
			if(isdefined(self.e_unique_player))
			{
				if(self.e_unique_player == e_player)
				{
					self setvisibletoplayer(e_player);
				}
				continue;
			}
			self setvisibletoplayer(e_player);
		}
	}
}

/*
	Name: function_98b48c31
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x68C26836
	Offset: 0xBC8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_98b48c31()
{
	/#
		level flagsys::wait_till("");
		wait(1);
		zm_devgui::add_custom_devgui_callback(&function_9170df8e);
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_9170df8e
	Namespace: zm_powerup_zombie_blood
	Checksum: 0x80A48102
	Offset: 0xC50
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function function_9170df8e(cmd)
{
	/#
		b_return = 0;
		switch(cmd)
		{
			case "zombie_blood":
			{
				zm_devgui::zombie_devgui_give_powerup("", 1);
				break;
			}
			case "next_zombie_blood":
			{
				zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
				break;
			}
		}
		return b_return;
	#/
}

