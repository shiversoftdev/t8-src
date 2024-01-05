// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\gadgets\gadget_vision_pulse.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\flag_shared.csc;

#namespace shoutcaster;

/*
	Name: is_shoutcaster
	Namespace: shoutcaster
	Checksum: 0x7054AD35
	Offset: 0x1F8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function is_shoutcaster(localclientnum)
{
	return function_9d295a8c(localclientnum);
}

/*
	Name: function_2e6e4ee0
	Namespace: shoutcaster
	Checksum: 0xBDBB8C2B
	Offset: 0x228
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2e6e4ee0(localclientnum)
{
	return is_shoutcaster(localclientnum) && function_ea9917ce(localclientnum);
}

/*
	Name: is_shoutcaster_using_team_identity
	Namespace: shoutcaster
	Checksum: 0x866CF77E
	Offset: 0x270
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function is_shoutcaster_using_team_identity(localclientnum)
{
	return is_shoutcaster(localclientnum) && getshoutcastersetting(localclientnum, "shoutcaster_fe_team_identity");
}

/*
	Name: get_team_color_id
	Namespace: shoutcaster
	Checksum: 0x441848B9
	Offset: 0x2C0
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function get_team_color_id(localclientnum, team)
{
	if(team == #"allies")
	{
		return getshoutcastersetting(localclientnum, "shoutcaster_fe_team1_color");
	}
	return getshoutcastersetting(localclientnum, "shoutcaster_fe_team2_color");
}

/*
	Name: get_team_color_fx
	Namespace: shoutcaster
	Checksum: 0xF8D168BF
	Offset: 0x330
	Size: 0x56
	Parameters: 3
	Flags: Linked
*/
function get_team_color_fx(localclientnum, team, script_bundle)
{
	color = get_team_color_id(localclientnum, team);
	return script_bundle.objects[color].fx_colorid;
}

/*
	Name: get_color_fx
	Namespace: shoutcaster
	Checksum: 0x20A0678F
	Offset: 0x390
	Size: 0x96
	Parameters: 2
	Flags: None
*/
function get_color_fx(localclientnum, script_bundle)
{
	effects = [];
	effects[#"allies"] = get_team_color_fx(localclientnum, #"allies", script_bundle);
	effects[#"axis"] = get_team_color_fx(localclientnum, #"axis", script_bundle);
	return effects;
}

/*
	Name: is_friendly
	Namespace: shoutcaster
	Checksum: 0x2DC2C898
	Offset: 0x430
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function is_friendly(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	scorepanel_flipped = getshoutcastersetting(localclientnum, "shoutcaster_ds_flip_scorepanel");
	if(!scorepanel_flipped)
	{
		friendly = self.team == #"allies";
	}
	else
	{
		friendly = self.team == #"axis";
	}
	return friendly;
}

/*
	Name: function_981be10f
	Namespace: shoutcaster
	Checksum: 0x9C2790BE
	Offset: 0x4E0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_981be10f(local_client_num)
{
	thread shoutcaster_monitor_xray_change(local_client_num);
	thread shoutcaster_monitor_player_pucks(local_client_num);
}

/*
	Name: shoutcaster_monitor_xray_change
	Namespace: shoutcaster
	Checksum: 0xEC3409E0
	Offset: 0x528
	Size: 0x410
	Parameters: 1
	Flags: Linked, Private
*/
function private shoutcaster_monitor_xray_change(local_client_num)
{
	level notify("shoutcaster_monitor_xray_change" + local_client_num);
	level endon("shoutcaster_monitor_xray_change" + local_client_num);
	util::waitforclient(local_client_num);
	firsttime = 1;
	localplayer = function_5c10bd79(local_client_num);
	lastteam = localplayer.team;
	var_f4e066d = 0;
	var_821a5c52 = 0;
	var_28f6bf0f = 0;
	var_c1935186 = 0;
	if(is_shoutcaster(local_client_num))
	{
		var_f4e066d = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
		loc_00000686:
		var_821a5c52 = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_enemies") ? 2 : 0);
		loc_000006DE:
		var_28f6bf0f = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_enemies") ? 2 : 0);
		var_c1935186 = function_2e6e4ee0(local_client_num);
	}
	while(true)
	{
		waitframe(1);
		if(!is_shoutcaster(local_client_num))
		{
			continue;
		}
		localplayer = function_5c10bd79(local_client_num);
		team = localplayer.team;
		var_52fe6881 = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
		loc_000007BE:
		var_a6f20d43 = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_enemies") ? 2 : 0);
		loc_00000816:
		var_c1e644b1 = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_enemies") ? 2 : 0);
		var_36f13a21 = function_2e6e4ee0(local_client_num);
		needupdate = 0;
		if(firsttime)
		{
			firsttime = 0;
			needupdate = 1;
		}
		else if(team != lastteam || var_52fe6881 != var_f4e066d || var_a6f20d43 != var_821a5c52 || var_c1e644b1 != var_28f6bf0f || var_c1935186 != var_36f13a21)
		{
			needupdate = 1;
		}
		if(needupdate)
		{
			lastteam = team;
			var_f4e066d = var_52fe6881;
			var_821a5c52 = var_a6f20d43;
			var_28f6bf0f = var_c1e644b1;
			var_c1935186 = var_36f13a21;
			self function_4c4946d4(local_client_num, team, var_52fe6881, (var_36f13a21 ? var_c1e644b1 : var_a6f20d43));
		}
	}
}

/*
	Name: function_4c4946d4
	Namespace: shoutcaster
	Checksum: 0xCADAEDEB
	Offset: 0x940
	Size: 0x428
	Parameters: 4
	Flags: Linked, Private
*/
function private function_4c4946d4(local_client_num, localplayerteam, var_52fe6881, var_faa7a3fb)
{
	var_f2a410c9 = [];
	players = getplayers(local_client_num);
	foreach(player in players)
	{
		if(!isalive(player))
		{
			continue;
		}
		var_f2a410c9[var_f2a410c9.size] = [];
		var_f2a410c9[var_f2a410c9.size - 1][0] = player;
		var_f2a410c9[var_f2a410c9.size - 1][1] = #"hash_2f86d28434166be7";
		var_f2a410c9[var_f2a410c9.size - 1][2] = #"hash_71fbf1094f57b910";
	}
	ents = getentarraybytype(local_client_num, 15);
	foreach(entity in ents)
	{
		if(!isdefined(entity.archetype))
		{
			continue;
		}
		if(entity.archetype != #"mp_dog")
		{
			continue;
		}
		var_f2a410c9[var_f2a410c9.size] = [];
		var_f2a410c9[var_f2a410c9.size - 1][0] = entity;
		var_f2a410c9[var_f2a410c9.size - 1][1] = #"hash_16bdbd0b3de5c91a";
		var_f2a410c9[var_f2a410c9.size - 1][2] = #"hash_71fbf1094f57b910";
	}
	foreach(array in var_f2a410c9)
	{
		entity = array[0];
		robkey = array[1];
		rob = array[2];
		if(!var_52fe6881 || var_faa7a3fb == 0)
		{
			if(entity flag::exists(#"shoutcaster_flag"))
			{
				entity renderoverridebundle::stop_bundle(#"shoutcaster_flag", rob, 0);
			}
			continue;
		}
		if(var_faa7a3fb == 2 && localplayerteam == entity.team || (var_faa7a3fb == 1 && localplayerteam != entity.team))
		{
			if(entity flag::exists(#"shoutcaster_flag"))
			{
				entity renderoverridebundle::stop_bundle(#"shoutcaster_flag", rob, 0);
			}
			continue;
		}
		entity function_a0b844f1(local_client_num, robkey, rob);
	}
}

/*
	Name: function_a0b844f1
	Namespace: shoutcaster
	Checksum: 0x40612B99
	Offset: 0xD70
	Size: 0x38C
	Parameters: 3
	Flags: Linked
*/
function function_a0b844f1(local_client_num, rob_key, rob)
{
	var_52fe6881 = getshoutcastersetting(local_client_num, "shoutcaster_qs_xray");
	loc_00000E16:
	var_a6f20d43 = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_1p_enemies") ? 2 : 0);
	loc_00000E6E:
	var_c1e644b1 = (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_allies") ? 1 : 0) + (getshoutcastersetting(local_client_num, "shoutcaster_ds_xray_air_enemies") ? 2 : 0);
	var_faa7a3fb = (function_2e6e4ee0(local_client_num) ? var_c1e644b1 : var_a6f20d43);
	localplayer = function_5c10bd79(local_client_num);
	localplayerteam = localplayer.team;
	if(!var_52fe6881 || var_faa7a3fb == 0)
	{
		return;
	}
	if(var_faa7a3fb == 2 && localplayerteam == self.team || (var_faa7a3fb == 1 && localplayerteam != self.team))
	{
		return;
	}
	self renderoverridebundle::function_c8d97b8e(local_client_num, #"shoutcaster_flag", rob_key);
	teamcolor = (self.team == #"allies" ? (0.13, 0.87, 0.94) : (0.98, 0.18, 0.1));
	if(is_shoutcaster_using_team_identity(local_client_num))
	{
		var_f90afe60 = get_team_color_id(local_client_num, self.team);
		teamcolor = function_4823f055(var_f90afe60);
	}
	self function_78233d29(rob, "", #"tintr", teamcolor[0]);
	self function_78233d29(rob, "", #"tintg", teamcolor[1]);
	self function_78233d29(rob, "", #"tintb", teamcolor[2]);
	self function_78233d29(rob, "", #"alpha", 1);
}

/*
	Name: function_7ed4edd3
	Namespace: shoutcaster
	Checksum: 0x60A8B40E
	Offset: 0x1108
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7ed4edd3(playername)
{
	if(!isdefined(playername))
	{
		return false;
	}
	if(!isdefined(level.shoutcasterpucks))
	{
		return false;
	}
	if(!isdefined(level.shoutcasterpucks[playername]))
	{
		return false;
	}
	return true;
}

/*
	Name: function_2b07633f
	Namespace: shoutcaster
	Checksum: 0x50B84315
	Offset: 0x1160
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2b07633f(playername)
{
	if(!isdefined(playername))
	{
		return false;
	}
	if(!isdefined(level.var_b9e7d957))
	{
		return false;
	}
	if(level.var_b9e7d957 != playername)
	{
		return false;
	}
	if(!isdefined(level.var_fea1a13))
	{
		return false;
	}
	return true;
}

/*
	Name: function_995e01b6
	Namespace: shoutcaster
	Checksum: 0x34194998
	Offset: 0x11C8
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function function_995e01b6(localclientnum, player)
{
	if(player.team == #"allies")
	{
		var_11792f05 = #"hash_e7985dec7c3faa9";
	}
	else
	{
		var_11792f05 = #"hash_40193ed2b55dd6b6";
	}
	level.shoutcasterpucks[player.name] = util::playfxontag(localclientnum, var_11792f05, self, "tag_origin");
}

/*
	Name: function_8e1e7736
	Namespace: shoutcaster
	Checksum: 0x8BCB674F
	Offset: 0x1270
	Size: 0xA6
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8e1e7736(localclientnum, player)
{
	level.var_b9e7d957 = player.name;
	if(player.team == #"allies")
	{
		var_e15b5f0c = #"hash_1e1361dd9519bc55";
	}
	else
	{
		var_e15b5f0c = #"hash_7a180b53914e467a";
	}
	level.var_fea1a13 = util::playfxontag(localclientnum, var_e15b5f0c, self, "tag_origin");
}

/*
	Name: function_35248a94
	Namespace: shoutcaster
	Checksum: 0x873F3749
	Offset: 0x1320
	Size: 0x5C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_35248a94(localclientnum, playername)
{
	if(isdefined(level.shoutcasterpucks[playername]))
	{
		stopfx(localclientnum, level.shoutcasterpucks[playername]);
		level.shoutcasterpucks[playername] = undefined;
	}
}

/*
	Name: function_69b179ea
	Namespace: shoutcaster
	Checksum: 0x20B7F206
	Offset: 0x1388
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_69b179ea(localclientnum)
{
	if(isdefined(level.var_fea1a13))
	{
		stopfx(localclientnum, level.var_fea1a13);
		level.var_fea1a13 = undefined;
	}
}

/*
	Name: shoutcaster_monitor_player_pucks
	Namespace: shoutcaster
	Checksum: 0x70C12BC1
	Offset: 0x13D8
	Size: 0x2A8
	Parameters: 1
	Flags: Linked, Private
*/
function private shoutcaster_monitor_player_pucks(localclientnum)
{
	level notify("shoutcaster_monitor_player_pucks" + localclientnum);
	level endon("shoutcaster_monitor_player_pucks" + localclientnum);
	while(true)
	{
		waitframe(1);
		if(!is_shoutcaster(localclientnum))
		{
			continue;
		}
		var_436f361e = function_ea9917ce(localclientnum);
		foreach(player in getplayers(localclientnum))
		{
			if(isdefined(player) && !function_3132f113(player))
			{
				if(isalive(player))
				{
					if(var_436f361e)
					{
						if(!function_7ed4edd3(player.name))
						{
							player function_995e01b6(localclientnum, player);
						}
						if(player function_21c0fa55() && !function_2b07633f(player.name))
						{
							function_69b179ea(localclientnum);
							player function_8e1e7736(localclientnum, player);
						}
					}
					else if(function_7ed4edd3(player.name))
					{
						function_35248a94(localclientnum, player.name);
					}
					continue;
				}
				if(function_7ed4edd3(player.name))
				{
					function_35248a94(localclientnum, player.name);
				}
				if(function_2b07633f(player.name))
				{
					function_69b179ea(localclientnum);
				}
			}
		}
		if(!var_436f361e)
		{
			function_69b179ea(localclientnum);
		}
	}
}

