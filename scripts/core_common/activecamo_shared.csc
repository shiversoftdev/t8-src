// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\struct.csc;
#using script_474309807eb94f34;

#namespace activecamo;

/*
	Name: __init__system__
	Namespace: activecamo
	Checksum: 0x13356F99
	Offset: 0x1A8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"activecamo", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: activecamo
	Checksum: 0x7FC2F693
	Offset: 0x1F0
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::add_callback(#"updateactivecamo", &updateactivecamo);
	callback::on_spawned(&on_player_spawned);
	callback::on_weapon_change(&on_weapon_change);
	callback::on_localplayer_spawned(&on_local_player_spawned);
	level.var_b9b11197 = getgametypesetting(#"hash_1f3825ba2a669400");
	if(!isdefined(level.var_ab319180))
	{
		level.var_ab319180 = [];
	}
	level.var_ab319180[getweapon(#"sniper_mini14_t8")] = 1;
}

/*
	Name: on_local_player_spawned
	Namespace: activecamo
	Checksum: 0xA014740B
	Offset: 0x308
	Size: 0x1A8
	Parameters: 1
	Flags: Linked
*/
function on_local_player_spawned(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	players = getplayers(localclientnum);
	foreach(player in players)
	{
		if(!isdefined(player) || !player isplayer() || !isalive(player))
		{
			continue;
		}
		if(player function_21c0fa55())
		{
			continue;
		}
		if(!player hasdobj(localclientnum))
		{
			continue;
		}
		weapon = player function_d2c2b168();
		weaponoptions = player function_e10e6c37();
		stagenum = getactivecamostage(weaponoptions);
		player update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
	}
}

/*
	Name: on_weapon_change
	Namespace: activecamo
	Checksum: 0xF21AD9E3
	Offset: 0x4B8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function on_weapon_change(params)
{
	if(self == level || !isplayer(self))
	{
		return;
	}
	localclientnum = params.localclientnum;
	weapon = self function_d2c2b168();
	weaponoptions = self function_e10e6c37();
	stagenum = getactivecamostage(weaponoptions);
	self update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
	self thread function_c887f58e();
}

/*
	Name: function_c887f58e
	Namespace: activecamo
	Checksum: 0x24F86DB1
	Offset: 0x5B0
	Size: 0x1FE
	Parameters: 0
	Flags: Linked
*/
function function_c887f58e()
{
	self notify("6d4a62e5d12fa266");
	self endon("6d4a62e5d12fa266");
	self endon(#"death", #"weapon_change");
	weapon = self function_d2c2b168();
	if(!(isdefined(isdefined(level.var_ab319180[weapon.rootweapon])) && isdefined(level.var_ab319180[weapon.rootweapon])))
	{
		return;
	}
	if(!weaponhasattachment(weapon, "uber"))
	{
		return;
	}
	var_472c15e8 = self function_e2f34c3();
	self function_d309e55a("tag_foregrip_bipod_attach_driver_animate", var_472c15e8);
	waitframe(1);
	while(true)
	{
		weapon = self function_d2c2b168();
		if(!(isdefined(isdefined(level.var_ab319180[weapon.rootweapon])) && isdefined(level.var_ab319180[weapon.rootweapon])))
		{
			return;
		}
		if(!weaponhasattachment(weapon, "uber"))
		{
			return;
		}
		if(!var_472c15e8)
		{
			if(self function_e2f34c3())
			{
				var_472c15e8 = 1;
				self function_d309e55a("tag_foregrip_bipod_attach_driver_animate", 1);
			}
		}
		else if(!self function_e2f34c3())
		{
			var_472c15e8 = 0;
			self function_d309e55a("tag_foregrip_bipod_attach_driver_animate", 0);
		}
		waitframe(1);
	}
}

/*
	Name: on_player_spawned
	Namespace: activecamo
	Checksum: 0x935722C2
	Offset: 0x7B8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function on_player_spawned(localclientnum)
{
	weapon = self function_d2c2b168();
	weaponoptions = self function_e10e6c37();
	stagenum = getactivecamostage(weaponoptions);
	self update_active_camo(localclientnum, weapon, "tag_weapon_right", stagenum, 0, 1, weaponoptions);
}

/*
	Name: function_ae141bf2
	Namespace: activecamo
	Checksum: 0xF7F5C62D
	Offset: 0x860
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function function_ae141bf2(camoindex)
{
	activecamoinfo = undefined;
	activecamoname = getactivecamo(camoindex);
	if(isdefined(activecamoname) && activecamoname != #"")
	{
		activecamoinfo = getscriptbundle(activecamoname);
	}
	return activecamoinfo;
}

/*
	Name: function_3d96ad48
	Namespace: activecamo
	Checksum: 0xA45B1C79
	Offset: 0x8E0
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function function_3d96ad48(var_6f2ae9c0)
{
	camoindex = getcamoindex(var_6f2ae9c0);
	return function_ae141bf2(camoindex);
}

/*
	Name: function_451a49f4
	Namespace: activecamo
	Checksum: 0x93EC818C
	Offset: 0x930
	Size: 0x16E
	Parameters: 4
	Flags: Linked
*/
function function_451a49f4(localclientnum, activecamoinfo, weapon, stagenum)
{
	activecamo = self init_activecamo(activecamoinfo);
	if(isdefined(activecamo))
	{
		if(!isdefined(activecamo.var_fe56592))
		{
			activecamo.var_fe56592 = [];
		}
		if(!isdefined(activecamo.var_fe56592[localclientnum]))
		{
			activecamo.var_fe56592[localclientnum] = {};
		}
		if(!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b))
		{
			activecamo.var_fe56592[localclientnum].var_dd54a13b = [];
		}
		baseweapon = function_c14cb514(weapon);
		if(!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon]))
		{
			activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon] = {};
		}
		activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum = stagenum;
	}
	return activecamo;
}

/*
	Name: function_130e0542
	Namespace: activecamo
	Checksum: 0x3BB1327
	Offset: 0xAA8
	Size: 0x1B4
	Parameters: 3
	Flags: Linked
*/
function function_130e0542(localclientnum, weapon, camoindex)
{
	init_stage = 0;
	activecamoinfo = function_ae141bf2(camoindex);
	activecamo = self init_activecamo(activecamoinfo);
	if(isdefined(activecamo))
	{
		if(isdefined(activecamo.info.stages))
		{
			var_f8bf269c = 0;
			foreach(key, stage in activecamo.info.stages)
			{
				if(isdefined(stage.var_d2eac588))
				{
					camo_stat = stats::get_stat_global(localclientnum, stage.var_d2eac588);
					if(isdefined(camo_stat) && camo_stat >= stage.var_e2dbd42d)
					{
						var_f8bf269c = 1;
						continue;
					}
				}
				if(var_f8bf269c || stage.var_19b6044e === camoindex)
				{
					init_stage = key;
					break;
				}
			}
		}
		return function_451a49f4(localclientnum, activecamoinfo, weapon, init_stage);
	}
}

/*
	Name: function_95f12bac
	Namespace: activecamo
	Checksum: 0x34509F33
	Offset: 0xC68
	Size: 0x9A
	Parameters: 3
	Flags: None
*/
function function_95f12bac(localclientnum, weapon, weaponoptions)
{
	camoindex = getcamoindex(weaponoptions);
	stagenum = getactivecamostage(weaponoptions);
	activecamoinfo = function_ae141bf2(camoindex);
	return function_451a49f4(localclientnum, activecamoinfo, weapon, stagenum);
}

/*
	Name: updateactivecamo
	Namespace: activecamo
	Checksum: 0xFDAF1EB3
	Offset: 0xD10
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function updateactivecamo(localclientnum, eventstruct)
{
	weaponoptions = self function_e10e6c37();
	stagenum = getactivecamostage(weaponoptions);
	self update_active_camo(localclientnum, eventstruct.weapon, eventstruct.tagname, stagenum, eventstruct.impulse, 0, eventstruct.var_6f2ae9c0);
}

/*
	Name: update_active_camo
	Namespace: activecamo
	Checksum: 0x4947D2D4
	Offset: 0xDC0
	Size: 0x7C4
	Parameters: 7
	Flags: Linked
*/
function update_active_camo(localclientnum, weapon, tagname, stagenum, impulse, var_d71e8c6e, var_6f2ae9c0)
{
	var_d1460f46 = tagname == "tag_stowed_back";
	self function_7a55e60a(var_d1460f46);
	activecamoinfo = function_3d96ad48(var_6f2ae9c0);
	if(!isdefined(activecamoinfo))
	{
		function_3e27a7cb(localclientnum, tagname);
		return;
	}
	activecamo = self init_activecamo(activecamoinfo);
	if(!isdefined(activecamo) || !isdefined(activecamo.info) || !isdefined(activecamo.info.stages))
	{
		function_3e27a7cb(localclientnum, tagname);
		return;
	}
	stage = activecamo.info.stages[stagenum];
	if(!isdefined(stage))
	{
		function_3e27a7cb(localclientnum, tagname);
		return;
	}
	if(!isdefined(activecamo.var_fe56592))
	{
		activecamo.var_fe56592 = [];
	}
	if(!isdefined(activecamo.var_fe56592[localclientnum]))
	{
		activecamo.var_fe56592[localclientnum] = {};
	}
	if(!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b))
	{
		activecamo.var_fe56592[localclientnum].var_dd54a13b = [];
	}
	baseweapon = function_c14cb514(weapon);
	if(!isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon]))
	{
		activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon] = {};
	}
	var_58bac2d = function_16d7447b(localclientnum, tagname);
	if(isdefined(var_58bac2d.crob) && var_58bac2d.crob !== stage.rob)
	{
		function_3e27a7cb(localclientnum, tagname);
	}
	self function_a946fb86(activecamo, stagenum, var_d1460f46);
	var_5bdd03ea = 0;
	if(self function_21c0fa55())
	{
		var_5bdd03ea = isswitchingweapons(localclientnum);
		if(!var_5bdd03ea)
		{
			var_9a7e487a = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
			if(isdefined(var_9a7e487a) && var_9a7e487a < stagenum)
			{
				laststage = activecamo.info.stages[var_9a7e487a];
				if(isdefined(laststage.var_1c54e7b8))
				{
					playsound(localclientnum, laststage.var_1c54e7b8);
				}
				else if(isdefined(stage.var_a000b430))
				{
					playsound(localclientnum, stage.var_a000b430);
				}
				if(isdefined(stage.var_2a4f6f28))
				{
					util::playfxontag(localclientnum, stage.var_2a4f6f28, self, tagname);
				}
				fx = stage.var_9828c877;
				if(isdefined(weapon))
				{
					switch(weapon.weapclass)
					{
						case "rocketlauncher":
						case "mg":
						case "rifle":
						{
							fx = stage.var_69896523;
							break;
						}
						case "pistol":
						{
							fx = stage.var_bafc7841;
							break;
						}
						default:
						{
							break;
						}
					}
				}
				if(isdefined(fx))
				{
					playviewmodelfx(localclientnum, fx, "tag_flash");
				}
			}
			if(isdefined(impulse) && impulse && isdefined(stage.var_8fc4c50d))
			{
				playsound(localclientnum, stage.var_8fc4c50d);
			}
		}
	}
	activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum = stagenum;
	var_58bac2d.crob = stage.rob;
	var_d71e8c6e = var_d71e8c6e || var_5bdd03ea;
	if(isdefined(stage.rob) && tagname == "tag_weapon_right")
	{
		if(!self function_d2503806(stage.rob, tagname))
		{
			self playrenderoverridebundle(stage.rob, tagname);
		}
		self callback::add_entity_callback(#"death", &player_on_death);
		for(layer = 1; layer <= 3; layer++)
		{
			self thread function_42887bfe(stage, tagname, layer, impulse, var_d71e8c6e);
		}
		self thread function_c55b3123(stage, tagname, "Diffuse2 Alpha", stage.var_2eeeee1b, stage.diffuse2alpha, var_d71e8c6e);
		self thread function_c55b3123(stage, tagname, "Diffuse3 Alpha", stage.var_7a3e0e45, stage.diffuse3alpha, var_d71e8c6e);
	}
	aries_is_ = stagenum + 1;
	if(isdefined(activecamo.info.stages[aries_is_]))
	{
		nextstage = activecamo.info.stages[aries_is_];
		if(isdefined(nextstage.var_19b6044e))
		{
			weaponoptions = self getweaponoptions();
			forcestreamweaponrenderoptions(localclientnum, weapon, weaponoptions, nextstage.var_19b6044e);
		}
	}
}

/*
	Name: player_on_death
	Namespace: activecamo
	Checksum: 0x94F04AE
	Offset: 0x1590
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function player_on_death(params)
{
	self function_3e27a7cb(params.localclientnum, "tag_weapon_right");
	self callback::function_52ac9652(#"death", &player_on_death);
}

/*
	Name: function_3e27a7cb
	Namespace: activecamo
	Checksum: 0x4FDBA286
	Offset: 0x1600
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_3e27a7cb(localclientnum, tagname)
{
	var_58bac2d = function_16d7447b(localclientnum, tagname);
	if(isdefined(var_58bac2d.crob))
	{
		self stoprenderoverridebundle(var_58bac2d.crob, tagname);
		var_58bac2d.crob = undefined;
	}
}

/*
	Name: function_a946fb86
	Namespace: activecamo
	Checksum: 0xC0AFA3A7
	Offset: 0x1680
	Size: 0x150
	Parameters: 3
	Flags: Linked
*/
function function_a946fb86(activecamo, stagenum, var_d1460f46)
{
	foreach(key, stage in activecamo.info.stages)
	{
		if(key > stagenum)
		{
			break;
		}
		if(isdefined(stage.var_9fbd261d))
		{
			if(isdefined(stage.var_d04f3816) && stage.var_d04f3816 || (key < stagenum && (isdefined(stage.var_413aa223) && stage.var_413aa223)) || (key == stagenum && (isdefined(stage.var_2873d2ba) && stage.var_2873d2ba)))
			{
				self function_f0d52864(stage.var_9fbd261d, var_d1460f46);
			}
		}
	}
}

/*
	Name: function_16d7447b
	Namespace: activecamo
	Checksum: 0xF828C545
	Offset: 0x17D8
	Size: 0x96
	Parameters: 2
	Flags: Linked
*/
function function_16d7447b(localclientnum, tagname)
{
	if(!isdefined(self.var_32d117a2))
	{
		self.var_32d117a2 = [];
	}
	if(!isdefined(self.var_32d117a2[localclientnum]))
	{
		self.var_32d117a2[localclientnum] = [];
	}
	if(!isdefined(self.var_32d117a2[localclientnum][tagname]))
	{
		self.var_32d117a2[localclientnum][tagname] = {};
	}
	return self.var_32d117a2[localclientnum][tagname];
}

/*
	Name: function_c55b3123
	Namespace: activecamo
	Checksum: 0x37B128DD
	Offset: 0x1878
	Size: 0x154
	Parameters: 6
	Flags: Linked
*/
function function_c55b3123(stage, tagname, var_eb6a239c, lerptime, var_f023ca7d, var_d71e8c6e)
{
	self endon(#"death", #"weapon_change");
	if(!var_d71e8c6e && lerptime > 0)
	{
		endtime = gettime() + (stage.var_2eeeee1b * 1000);
		do
		{
			waitframe(1);
			if(!isdefined(self) || !isplayer(self))
			{
				return;
			}
			currenttime = gettime();
			var_31cfb10 = var_f023ca7d;
			if(!isplayer(self))
			{
				return;
			}
			self function_78233d29(stage.rob, tagname, var_eb6a239c, var_31cfb10);
		}
		while(currenttime <= endtime);
	}
	self function_78233d29(stage.rob, tagname, var_eb6a239c, var_f023ca7d);
}

/*
	Name: function_42887bfe
	Namespace: activecamo
	Checksum: 0xE45E1413
	Offset: 0x19D8
	Size: 0x64C
	Parameters: 5
	Flags: Linked
*/
function function_42887bfe(stage, tagname, layer, impulse, var_d71e8c6e)
{
	self endon(#"death", #"weapon_change");
	var_238c3eeb = "Layer" + layer;
	var_604ae5c3 = var_238c3eeb + " Brightness";
	var_d6637dc6 = var_238c3eeb + " Fade";
	var_ea35682d = var_238c3eeb + " Tint";
	var_d1732bd2 = "robLayer" + layer;
	var_27c1d8a2 = var_d1732bd2 + "_Brightness";
	var_f5747b8 = var_d1732bd2 + "_Fade";
	var_4a72a14a = var_d1732bd2 + "_LerpTime";
	var_7fd61736 = var_d1732bd2 + "_Tint";
	if(!var_d71e8c6e && impulse)
	{
		var_b96a2aa7 = var_27c1d8a2 + "_i";
		var_ffcf1e1a = var_f5747b8 + "_i";
		var_b6cde499 = var_4a72a14a + "_i";
		var_bc211a50 = var_7fd61736 + "_i";
		lerptime = (isdefined(stage.(var_b6cde499)) ? stage.(var_b6cde499) : 0);
		brightness = (isdefined(stage.(var_b96a2aa7)) ? stage.(var_b96a2aa7) : 0);
		fade = (isdefined(stage.(var_ffcf1e1a)) ? stage.(var_ffcf1e1a) : 0);
		tint = (isdefined(stage.(var_bc211a50)) ? stage.(var_bc211a50) : 0);
		if(lerptime > 0)
		{
			endtime = gettime() + (lerptime * 1000);
			do
			{
				waitframe(1);
				if(!isdefined(self) || !isplayer(self))
				{
					return;
				}
				currenttime = gettime();
				var_b9c539b7 = brightness;
				var_a5e1ab6c = fade;
				var_df9b6bd0 = tint;
				self function_78233d29(stage.rob, tagname, var_604ae5c3, var_b9c539b7);
				self function_78233d29(stage.rob, tagname, var_d6637dc6, var_a5e1ab6c);
				self function_78233d29(stage.rob, tagname, var_ea35682d, var_df9b6bd0);
			}
			while(currenttime <= endtime);
		}
		self function_78233d29(stage.rob, tagname, var_604ae5c3, brightness);
		self function_78233d29(stage.rob, tagname, var_d6637dc6, fade);
		self function_78233d29(stage.rob, tagname, var_ea35682d, tint);
		wait(max(lerptime, 0.5));
		if(!isdefined(self) || !isplayer(self))
		{
			return;
		}
	}
	lerptime = (isdefined(stage.(var_4a72a14a)) ? stage.(var_4a72a14a) : 0);
	brightness = (isdefined(stage.(var_27c1d8a2)) ? stage.(var_27c1d8a2) : 0);
	fade = (isdefined(stage.(var_f5747b8)) ? stage.(var_f5747b8) : 0);
	tint = (isdefined(stage.(var_7fd61736)) ? stage.(var_7fd61736) : 0);
	if(!var_d71e8c6e && lerptime > 0)
	{
		endtime = gettime() + (lerptime * 1000);
		do
		{
			waitframe(1);
			if(!isdefined(self) || !isplayer(self))
			{
				return;
			}
			currenttime = gettime();
			var_b9c539b7 = brightness;
			var_a5e1ab6c = fade;
			var_df9b6bd0 = tint;
			self function_78233d29(stage.rob, tagname, var_604ae5c3, var_b9c539b7);
			self function_78233d29(stage.rob, tagname, var_d6637dc6, var_a5e1ab6c);
			self function_78233d29(stage.rob, tagname, var_ea35682d, var_df9b6bd0);
		}
		while(currenttime <= endtime);
	}
	self function_78233d29(stage.rob, tagname, var_604ae5c3, brightness);
	self function_78233d29(stage.rob, tagname, var_d6637dc6, fade);
	self function_78233d29(stage.rob, tagname, var_ea35682d, tint);
}

/*
	Name: function_3aa81e0e
	Namespace: activecamo
	Checksum: 0xF8431EC3
	Offset: 0x2030
	Size: 0x62E
	Parameters: 1
	Flags: Linked
*/
function function_3aa81e0e(activecamoinfo)
{
	info = undefined;
	if(isdefined(activecamoinfo) && isdefined(activecamoinfo.name))
	{
		if(!isdefined(level.activecamoinfo))
		{
			level.activecamoinfo = [];
		}
		if(isdefined(level.activecamoinfo[activecamoinfo.name]))
		{
			return level.activecamoinfo[activecamoinfo.name];
		}
		if(!isdefined(level.activecamoinfo[activecamoinfo.name]))
		{
			level.activecamoinfo[activecamoinfo.name] = {};
		}
		info = level.activecamoinfo[activecamoinfo.name];
		if(isdefined(activecamoinfo.stages))
		{
			if(!isdefined(info.stages))
			{
				info.stages = [];
			}
			var_d3daabe = 0;
			foreach(key, var_3594168e in activecamoinfo.stages)
			{
				if(isdefined(var_3594168e.disabled) && var_3594168e.disabled)
				{
					var_d3daabe++;
					continue;
				}
				if(!isdefined(info.stages[key - var_d3daabe]))
				{
					info.stages[key - var_d3daabe] = {};
				}
				stage = info.stages[key - var_d3daabe];
				stage.rob = var_3594168e.rob;
				if(isdefined(var_3594168e.var_879c8798))
				{
					stage.var_19b6044e = function_8b51d9d1(var_3594168e.var_879c8798);
				}
				stage.var_9fbd261d = var_3594168e.var_9fbd261d;
				stage.var_d2eac588 = var_3594168e.var_d2eac588;
				stage.var_e2dbd42d = (isdefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0);
				if(isdefined(stage.var_9fbd261d))
				{
					stage.var_d04f3816 = var_3594168e.var_d04f3816;
					stage.var_413aa223 = var_3594168e.var_413aa223;
					stage.var_2873d2ba = var_3594168e.var_2873d2ba;
				}
				if(isdefined(level.var_b9b11197) && level.var_b9b11197)
				{
					stage.var_1c54e7b8 = var_3594168e.var_1c54e7b8;
					stage.var_a000b430 = var_3594168e.var_a000b430;
					stage.var_8fc4c50d = var_3594168e.var_8fc4c50d;
				}
				stage.var_bafc7841 = var_3594168e.var_bafc7841;
				stage.var_9828c877 = var_3594168e.var_9828c877;
				stage.var_69896523 = var_3594168e.var_69896523;
				for(layer = 1; layer <= 3; layer++)
				{
					var_d1732bd2 = "robLayer" + layer;
					var_4a72a14a = var_d1732bd2 + "_LerpTime";
					var_27c1d8a2 = var_d1732bd2 + "_Brightness";
					var_f5747b8 = var_d1732bd2 + "_Fade";
					var_7fd61736 = var_d1732bd2 + "_Tint";
					stage.(var_4a72a14a) = var_3594168e.(var_4a72a14a);
					stage.(var_27c1d8a2) = var_3594168e.(var_27c1d8a2);
					stage.(var_f5747b8) = var_3594168e.(var_f5747b8);
					stage.(var_7fd61736) = var_3594168e.(var_7fd61736);
					var_b6cde499 = var_4a72a14a + "_i";
					var_b96a2aa7 = var_27c1d8a2 + "_i";
					var_ffcf1e1a = var_f5747b8 + "_i";
					var_bc211a50 = var_7fd61736 + "_i";
					stage.(var_b6cde499) = var_3594168e.(var_b6cde499);
					stage.(var_b96a2aa7) = var_3594168e.(var_b96a2aa7);
					stage.(var_ffcf1e1a) = var_3594168e.(var_ffcf1e1a);
					stage.(var_bc211a50) = var_3594168e.(var_bc211a50);
				}
				stage.diffuse2alpha = (isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0);
				stage.var_2eeeee1b = (isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0);
				stage.diffuse3alpha = (isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0);
				stage.var_7a3e0e45 = (isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0);
			}
		}
	}
	return info;
}

/*
	Name: init_activecamo
	Namespace: activecamo
	Checksum: 0xC67FCE19
	Offset: 0x2668
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function init_activecamo(activecamoinfo)
{
	if(isdefined(activecamoinfo))
	{
		if(!isdefined(self.var_9413f8b4))
		{
			self.var_9413f8b4 = [];
		}
		if(isdefined(self.var_9413f8b4[activecamoinfo.name]))
		{
			return self.var_9413f8b4[activecamoinfo.name];
		}
		if(!isdefined(self.var_9413f8b4[activecamoinfo.name]))
		{
			self.var_9413f8b4[activecamoinfo.name] = {};
		}
		activecamo = self.var_9413f8b4[activecamoinfo.name];
		activecamo.info = function_3aa81e0e(activecamoinfo);
		return activecamo;
	}
	return undefined;
}

/*
	Name: function_374e37a0
	Namespace: activecamo
	Checksum: 0x2B1A8C38
	Offset: 0x2750
	Size: 0x460
	Parameters: 4
	Flags: Linked
*/
function function_374e37a0(localclientnum, weaponmodel, var_3594168e, &var_49daa2f6)
{
	tagname = "tag_origin";
	stage = {};
	stage.rob = var_3594168e.rob;
	if(!isdefined(stage.rob))
	{
		return false;
	}
	stage.diffuse2alpha = (isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0);
	stage.var_2eeeee1b = (isdefined(var_3594168e.var_2eeeee1b) ? var_3594168e.var_2eeeee1b : 0);
	stage.diffuse3alpha = (isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0);
	stage.var_7a3e0e45 = (isdefined(var_3594168e.var_7a3e0e45) ? var_3594168e.var_7a3e0e45 : 0);
	if(!weaponmodel function_d2503806(stage.rob, tagname))
	{
		weaponmodel playrenderoverridebundle(stage.rob, tagname);
		var_49daa2f6[localclientnum] = stage.rob;
	}
	for(layer = 1; layer <= 3; layer++)
	{
		var_d1732bd2 = "robLayer" + layer;
		var_27c1d8a2 = var_d1732bd2 + "_Brightness";
		var_f5747b8 = var_d1732bd2 + "_Fade";
		var_7fd61736 = var_d1732bd2 + "_Tint";
		stage.(var_27c1d8a2) = (isdefined(var_3594168e.(var_27c1d8a2)) ? var_3594168e.(var_27c1d8a2) : 0);
		stage.(var_f5747b8) = (isdefined(var_3594168e.(var_f5747b8)) ? var_3594168e.(var_f5747b8) : 0);
		stage.(var_7fd61736) = (isdefined(var_3594168e.(var_7fd61736)) ? var_3594168e.(var_7fd61736) : 0);
		var_238c3eeb = "Layer" + layer;
		var_604ae5c3 = var_238c3eeb + " Brightness";
		var_d6637dc6 = var_238c3eeb + " Fade";
		var_ea35682d = var_238c3eeb + " Tint";
		weaponmodel function_78233d29(stage.rob, tagname, var_604ae5c3, stage.(var_27c1d8a2));
		weaponmodel function_78233d29(stage.rob, tagname, var_d6637dc6, stage.(var_f5747b8));
		weaponmodel function_78233d29(stage.rob, tagname, var_ea35682d, stage.(var_7fd61736));
	}
	diffuse2alpha = (isdefined(var_3594168e.diffuse2alpha) ? var_3594168e.diffuse2alpha : 0);
	diffuse3alpha = (isdefined(var_3594168e.diffuse3alpha) ? var_3594168e.diffuse3alpha : 0);
	weaponmodel function_78233d29(stage.rob, tagname, "Diffuse2 Alpha", diffuse2alpha);
	weaponmodel function_78233d29(stage.rob, tagname, "Diffuse3 Alpha", diffuse3alpha);
	return true;
}

/*
	Name: function_cbfd8fd6
	Namespace: activecamo
	Checksum: 0x8F69BC3F
	Offset: 0x2BB8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_cbfd8fd6(localclientnum)
{
	if(isdefined(self.weapon))
	{
		weaponoptions = self function_e10e6c37();
		camoindex = getcamoindex(weaponoptions);
		activecamoinfo = function_ae141bf2(camoindex);
		if(isdefined(activecamoinfo))
		{
			stagenum = getactivecamostage(weaponoptions);
			self function_b3a0e4f0(localclientnum, activecamoinfo, stagenum);
		}
	}
}

/*
	Name: function_e40c785a
	Namespace: activecamo
	Checksum: 0x4B506E94
	Offset: 0x2C80
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_e40c785a(localclientnum)
{
	weaponoptions = self function_e10e6c37();
	camoindex = getcamoindex(weaponoptions);
	activecamoinfo = function_ae141bf2(camoindex);
	if(isdefined(activecamoinfo))
	{
		if(isdefined(activecamoinfo.stages))
		{
			init_stage = 0;
			foreach(key, var_3594168e in activecamoinfo.stages)
			{
				if(isdefined(var_3594168e.var_d2eac588))
				{
					continue;
				}
				init_stage = key;
				break;
			}
			self function_b3a0e4f0(localclientnum, activecamoinfo, init_stage);
		}
	}
}

/*
	Name: function_6efb762c
	Namespace: activecamo
	Checksum: 0x6DED9A9D
	Offset: 0x2DC8
	Size: 0x2AC
	Parameters: 3
	Flags: None
*/
function function_6efb762c(localclientnum, camoweapon, weaponoptions)
{
	camoindex = getcamoindex(weaponoptions);
	activecamoinfo = function_ae141bf2(camoindex);
	if(isdefined(activecamoinfo))
	{
		player = function_27673a7(localclientnum);
		activecamo = player init_activecamo(activecamoinfo);
		baseweapon = function_c14cb514(camoweapon);
		if(isdefined(activecamo))
		{
			init_stage = getactivecamostage(weaponoptions);
			if(isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon]))
			{
				init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
			}
			else
			{
				activecamo = player function_130e0542(localclientnum, camoweapon, camoindex);
				if(isdefined(activecamo) && isdefined(activecamo.var_fe56592) && isdefined(activecamo.var_fe56592[localclientnum]) && isdefined(activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon]))
				{
					init_stage = activecamo.var_fe56592[localclientnum].var_dd54a13b[baseweapon].stagenum;
				}
			}
			if(isdefined(activecamoinfo.stages))
			{
				var_3594168e = activecamoinfo.stages[init_stage];
				if(isdefined(var_3594168e))
				{
					var_19b6044e = function_8b51d9d1(var_3594168e.var_879c8798);
					self setcamo(var_19b6044e);
					self setactivecamostage(init_stage);
				}
			}
			self function_b3a0e4f0(localclientnum, activecamoinfo, init_stage);
		}
	}
}

/*
	Name: function_b3a0e4f0
	Namespace: activecamo
	Checksum: 0x31B0917A
	Offset: 0x3080
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_b3a0e4f0(localclientnum, activecamoinfo, init_stage)
{
	if(isdefined(activecamoinfo) && isdefined(activecamoinfo.stages))
	{
		var_3594168e = activecamoinfo.stages[init_stage];
		if(isdefined(var_3594168e))
		{
			if(!isdefined(self.var_49daa2f6))
			{
				self.var_49daa2f6 = [];
			}
			function_374e37a0(localclientnum, self, var_3594168e, self.var_49daa2f6);
		}
	}
}

