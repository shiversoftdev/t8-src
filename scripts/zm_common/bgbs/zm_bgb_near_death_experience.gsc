// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_player.gsc;

#namespace zm_bgb_near_death_experience;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_near_death_experience
	Checksum: 0xDDF68340
	Offset: 0x1A8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_near_death_experience", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x12DAA382
	Offset: 0x1F8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("allplayers", "zm_bgb_near_death_experience_3p_fx", 1, 1, "int");
	clientfield::register("toplayer", "zm_bgb_near_death_experience_1p_fx", 1, 1, "int");
	bgb::register(#"zm_bgb_near_death_experience", "time", 600, &enable, &disable, undefined, undefined);
	bgb::register_lost_perk_override(#"zm_bgb_near_death_experience", &lost_perk_override, 1);
}

/*
	Name: enable
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x2BB01DCA
	Offset: 0x310
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	if(!isdefined(level.var_67998b2d))
	{
		level.var_67998b2d = 0;
	}
	self thread bgb::function_f51e3503(240, &function_db295169, &function_cbaf1f69);
	self thread function_68acd38e();
	self thread function_8e5f5406();
}

/*
	Name: disable
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x80F724D1
	Offset: 0x3D8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

/*
	Name: function_68acd38e
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x91EE9F85
	Offset: 0x3E8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_68acd38e()
{
	self endon(#"disconnect");
	self clientfield::set("zm_bgb_near_death_experience_3p_fx", 1);
	self waittill(#"bled_out", #"bgb_update");
	self clientfield::set("zm_bgb_near_death_experience_3p_fx", 0);
	self notify(#"zm_bgb_near_death_experience_complete");
}

/*
	Name: function_8e5f5406
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x600332BE
	Offset: 0x488
	Size: 0x1E0
	Parameters: 0
	Flags: Linked
*/
function function_8e5f5406()
{
	self.var_718eafbc = 0;
	foreach(e_player in level.players)
	{
		e_player function_fa0a1b19();
	}
	if(level.var_67998b2d == 0)
	{
		callback::on_connect(&on_connect);
	}
	level.var_67998b2d++;
	self waittill(#"disconnect", #"bled_out", #"bgb_update");
	level.var_67998b2d--;
	if(level.var_67998b2d == 0)
	{
		callback::remove_on_connect(&on_connect);
	}
	foreach(e_player in level.players)
	{
		e_player zm_laststand::deregister_revive_override(e_player.var_8597ff2d[0]);
		arrayremoveindex(e_player.var_8597ff2d, 0);
	}
}

/*
	Name: on_connect
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x15093E18
	Offset: 0x670
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_connect()
{
	self function_fa0a1b19();
}

/*
	Name: function_fa0a1b19
	Namespace: zm_bgb_near_death_experience
	Checksum: 0xAA5B91A8
	Offset: 0x698
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_fa0a1b19()
{
	if(!isdefined(self.var_8597ff2d))
	{
		self.var_8597ff2d = [];
	}
	s_revive_override = self zm_laststand::register_revive_override(&function_d5c9a81);
	if(!isdefined(self.var_8597ff2d))
	{
		self.var_8597ff2d = [];
	}
	else if(!isarray(self.var_8597ff2d))
	{
		self.var_8597ff2d = array(self.var_8597ff2d);
	}
	self.var_8597ff2d[self.var_8597ff2d.size] = s_revive_override;
}

/*
	Name: function_d5c9a81
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x5431DB9F
	Offset: 0x758
	Size: 0x220
	Parameters: 1
	Flags: Linked
*/
function function_d5c9a81(e_revivee)
{
	if(!isdefined(e_revivee.revivetrigger))
	{
		return false;
	}
	if(!isalive(self))
	{
		return false;
	}
	if(self laststand::player_is_in_laststand())
	{
		return false;
	}
	if(self.team != e_revivee.team)
	{
		return false;
	}
	if(isdefined(self.is_zombie) && self.is_zombie)
	{
		return false;
	}
	if(isdefined(level.can_revive_use_depthinwater_test) && level.can_revive_use_depthinwater_test && e_revivee depthinwater() > 10)
	{
		return true;
	}
	if(isdefined(level.can_revive) && ![[level.can_revive]](e_revivee))
	{
		return false;
	}
	if(isdefined(level.can_revive_game_module) && ![[level.can_revive_game_module]](e_revivee))
	{
		return false;
	}
	if(e_revivee zm_player::in_kill_brush() || !e_revivee zm_player::in_enabled_playable_area())
	{
		return false;
	}
	if(self bgb::is_enabled(#"zm_bgb_near_death_experience") && isdefined(self.var_9c42f3fe) && array::contains(self.var_9c42f3fe, e_revivee))
	{
		return true;
	}
	if(e_revivee bgb::is_enabled(#"zm_bgb_near_death_experience") && isdefined(e_revivee.var_9c42f3fe) && array::contains(e_revivee.var_9c42f3fe, self))
	{
		return true;
	}
	return false;
}

/*
	Name: lost_perk_override
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x88650878
	Offset: 0x980
	Size: 0x66
	Parameters: 3
	Flags: Linked
*/
function lost_perk_override(perk, var_a83ac70f = undefined, var_6c1b825d = undefined)
{
	self thread zm_perks::function_b2dfd295(perk, &bgb::function_bd839f2c);
	return false;
}

/*
	Name: function_db295169
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x1D5F205A
	Offset: 0x9F0
	Size: 0x112
	Parameters: 1
	Flags: Linked
*/
function function_db295169(e_player)
{
	var_4cd31497 = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
	e_player endon(var_4cd31497, #"disconnect");
	self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");
	while(true)
	{
		if(!e_player laststand::player_is_in_laststand() && !self laststand::player_is_in_laststand())
		{
			util::waittill_any_ents_two(e_player, "player_downed", self, "player_downed");
		}
		self thread function_b7269898(e_player, var_4cd31497);
		var_9dd95907 = "zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber();
		e_player waittill(var_9dd95907);
	}
}

/*
	Name: function_b7269898
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x3E7A200B
	Offset: 0xB10
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_b7269898(e_player, str_notify)
{
	var_996880d2 = self function_991be229(e_player, str_notify);
	if(!(isdefined(var_996880d2) && var_996880d2))
	{
		return;
	}
	self function_51e0947e();
	e_player function_51e0947e();
	self function_3895d86(e_player, str_notify);
	if(isdefined(self))
	{
		self function_68790c5a();
	}
	if(isdefined(e_player))
	{
		e_player function_68790c5a();
		e_player notify("zm_bgb_near_death_experience_1p_fx_stop_" + self getentitynumber());
		if(!e_player laststand::player_is_in_laststand())
		{
			self thread function_765e5d1c();
		}
	}
}

/*
	Name: function_991be229
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x38AF864
	Offset: 0xC38
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_991be229(e_player, str_notify)
{
	e_player endon(str_notify, #"disconnect");
	self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");
	while(!self function_d5c9a81(e_player) && !e_player function_d5c9a81(self))
	{
		wait(0.1);
	}
	return true;
}

/*
	Name: function_3895d86
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x50FA2E27
	Offset: 0xCE0
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_3895d86(e_player, str_notify)
{
	e_player endon(str_notify, #"disconnect");
	self endon(#"disconnect", #"zm_bgb_near_death_experience_complete");
	while(self function_d5c9a81(e_player) || e_player function_d5c9a81(self))
	{
		wait(0.1);
	}
}

/*
	Name: function_cbaf1f69
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x77E74644
	Offset: 0xD78
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_cbaf1f69(e_player)
{
	str_notify = "zm_bgb_near_death_experience_proximity_end_" + self getentitynumber();
	e_player notify(str_notify);
}

/*
	Name: function_51e0947e
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x7281E85C
	Offset: 0xDC0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_51e0947e()
{
	if(!isdefined(self.var_7a276c72) || self.var_7a276c72 == 0)
	{
		self.var_7a276c72 = 1;
		self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 1);
	}
	else
	{
		self.var_7a276c72++;
	}
}

/*
	Name: function_68790c5a
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x73D0BC81
	Offset: 0xE30
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_68790c5a()
{
	self.var_7a276c72--;
	if(self.var_7a276c72 == 0)
	{
		self clientfield::set_to_player("zm_bgb_near_death_experience_1p_fx", 0);
	}
}

/*
	Name: function_765e5d1c
	Namespace: zm_bgb_near_death_experience
	Checksum: 0x3B4A2956
	Offset: 0xE78
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_765e5d1c()
{
	n_step = 120 / 600;
	n_original = self clientfield::get_player_uimodel("zmhud.bgb_timer");
	self.var_718eafbc++;
	var_4bfcf47f = 1 - (self.var_718eafbc * n_step);
	if(n_original > var_4bfcf47f)
	{
		self bgb::set_timer(600 * var_4bfcf47f, 600, 1);
	}
}

