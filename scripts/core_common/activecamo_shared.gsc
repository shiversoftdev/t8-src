// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using script_67c87580908a0a00;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace activecamo;

/*
	Name: __init__system__
	Namespace: activecamo
	Checksum: 0x2D0CB793
	Offset: 0xE8
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
	Checksum: 0x5A1FA4D9
	Offset: 0x130
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_loadout(&on_player_loadout);
	callback::function_f77ced93(&function_f77ced93);
	/#
		thread function_265047c1();
	#/
}

/*
	Name: function_f77ced93
	Namespace: activecamo
	Checksum: 0x83B05FD
	Offset: 0x198
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(params)
{
	if(isdefined(level.var_b219667f) && level.var_b219667f)
	{
		self function_8d3b94ea(params.weapon, 1);
	}
	else
	{
		self function_8d3b94ea(params.weapon, 0);
	}
	if(isdefined(level.var_3993dc8e))
	{
		self [[level.var_3993dc8e]](params.weapon);
	}
}

/*
	Name: on_player_death
	Namespace: activecamo
	Checksum: 0xA584310
	Offset: 0x248
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_player_death(params)
{
	if(game.state != "playing")
	{
		return;
	}
	self function_27779784();
}

/*
	Name: function_27779784
	Namespace: activecamo
	Checksum: 0xCBBE9C30
	Offset: 0x290
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_27779784()
{
	if(!isdefined(self) || !isdefined(self.pers) || !isdefined(self.pers[#"activecamo"]))
	{
		return;
	}
	foreach(activecamo in self.pers[#"activecamo"])
	{
		foreach(var_dd54a13b in activecamo.var_dd54a13b)
		{
			activecamo.weapon = var_dd54a13b.weapon;
			activecamo.baseweapon = function_c14cb514(activecamo.weapon);
			self function_d005b26d(activecamo, 0, 1);
		}
	}
}

/*
	Name: on_player_loadout
	Namespace: activecamo
	Checksum: 0x951F8ED1
	Offset: 0x408
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function on_player_loadout()
{
	self callback::remove_on_death(&on_player_death);
	weapons = self getweaponslist();
	foreach(weapon in weapons)
	{
		self function_8d3b94ea(weapon, 1);
	}
}

/*
	Name: function_8d3b94ea
	Namespace: activecamo
	Checksum: 0xF9996780
	Offset: 0x4D0
	Size: 0x7C
	Parameters: 3
	Flags: Linked
*/
function function_8d3b94ea(weapon, owned, b_has_weapon)
{
	weapon = function_94c2605(weapon);
	activecamoinfo = function_a108c50e(weapon, b_has_weapon);
	if(isdefined(activecamoinfo))
	{
		self init_activecamo(weapon, activecamoinfo, owned);
	}
}

/*
	Name: init_activecamo
	Namespace: activecamo
	Checksum: 0x69276C5E
	Offset: 0x558
	Size: 0x2E4
	Parameters: 3
	Flags: Linked
*/
function init_activecamo(weapon, activecamoinfo, owned)
{
	if(isdefined(activecamoinfo) && isdefined(activecamoinfo.name))
	{
		if(!isdefined(self.pers[#"activecamo"]))
		{
			self.pers[#"activecamo"] = [];
		}
		if(!isdefined(self.pers[#"activecamo"][activecamoinfo.name]))
		{
			self.pers[#"activecamo"][activecamoinfo.name] = {};
		}
		activecamo = self.pers[#"activecamo"][activecamoinfo.name];
		activecamo.info = function_3aa81e0e(activecamoinfo);
		/#
			assert(isdefined(activecamo.info));
		#/
		activecamo.weapon = weapon;
		activecamo.baseweapon = function_c14cb514(activecamo.weapon);
		if(!isdefined(activecamo.var_dd54a13b))
		{
			activecamo.var_dd54a13b = [];
		}
		if(!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon]))
		{
			activecamo.var_dd54a13b[activecamo.baseweapon] = {};
		}
		activecamo.var_dd54a13b[activecamo.baseweapon].weapon = weapon;
		activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = undefined;
		if(!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].owned))
		{
			activecamo.var_dd54a13b[activecamo.baseweapon].owned = 0;
		}
		activecamo.var_dd54a13b[activecamo.baseweapon].owned = activecamo.var_dd54a13b[activecamo.baseweapon].owned | owned;
		self function_d005b26d(activecamo, 0, 0);
		self callback::on_death(&on_player_death);
	}
}

/*
	Name: function_b008f9e9
	Namespace: activecamo
	Checksum: 0x3C5E7C47
	Offset: 0x848
	Size: 0x116
	Parameters: 1
	Flags: None
*/
function function_b008f9e9(weapon)
{
	/#
		if(!isdefined(level.activecamoinfo))
		{
			return;
		}
		if(self getcurrentweapon() != weapon)
		{
			self switchtoweapon(weapon);
			self waittilltimeout(2, #"weapon_change");
		}
		foreach(info in level.activecamoinfo)
		{
			activecamoinfo = getscriptbundle(info.name);
			self init_activecamo(weapon, activecamoinfo, 1);
			waitframe(1);
		}
	#/
}

/*
	Name: function_3aa81e0e
	Namespace: activecamo
	Checksum: 0xD9DD53BB
	Offset: 0x968
	Size: 0x646
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
		if(!isdefined(level.activecamoinfo[activecamoinfo.name]))
		{
			level.activecamoinfo[activecamoinfo.name] = {};
		}
		info = level.activecamoinfo[activecamoinfo.name];
		info.name = activecamoinfo.name;
		info.var_e639aa37 = activecamoinfo.var_e639aa37;
		info.var_cd82182a = activecamoinfo.var_cd82182a;
		info.var_e0b0d8cc = activecamoinfo.var_e0b0d8cc;
		info.var_ed6f91d5 = activecamoinfo.var_ed6f91d5;
		info.var_bd863267 = activecamoinfo.var_bd863267;
		info.var_26c1d493 = activecamoinfo.var_26c1d493;
		info.var_fa0465c6 = activecamoinfo.var_fa0465c6;
		info.var_2034fabe = activecamoinfo.var_2034fabe;
		info.var_9ae5a2b8 = activecamoinfo.var_9ae5a2b8;
		var_d3daabe = 0;
		if(isdefined(activecamoinfo.stages))
		{
			if(!isdefined(info.stages))
			{
				info.stages = [];
			}
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
				if(isdefined(var_3594168e.var_879c8798))
				{
					stage.var_19b6044e = function_8b51d9d1(var_3594168e.var_879c8798);
				}
				/#
					if(!isdefined(stage.var_19b6044e))
					{
						self function_8530ef96(((("" + info.name) + "") + function_9e72a96((isdefined(var_3594168e.var_879c8798) ? var_3594168e.var_879c8798 : "")) + "") + key);
					}
					else
					{
						activecamoname = getactivecamo(stage.var_19b6044e);
						var_31567a86 = undefined;
						if(isdefined(activecamoname) && activecamoname != #"")
						{
							var_31567a86 = getscriptbundle(activecamoname);
						}
						if(!isdefined(var_31567a86))
						{
							self function_8530ef96((((("" + info.name) + "") + stage.var_19b6044e) + "") + key);
						}
						else if(!isdefined(var_31567a86.name) || var_31567a86.name != info.name)
						{
							self function_8530ef96(((((("" + info.name) + "") + stage.var_19b6044e) + "") + (isdefined(var_31567a86.name) ? var_31567a86.name : "") + "") + key);
						}
					}
				#/
				stage.permanent = var_3594168e.permanent;
				stage.statname = var_3594168e.statname;
				stage.var_d2eac588 = var_3594168e.var_d2eac588;
				stage.var_e2dbd42d = (isdefined(var_3594168e.var_e2dbd42d) ? var_3594168e.var_e2dbd42d : 0);
				stage.resettimer = (isdefined(var_3594168e.resettimer) ? var_3594168e.resettimer : 0);
				stage.resetnotify = var_3594168e.resetnotify;
				stage.resetondeath = var_3594168e.resetondeath;
				stage.var_825ae630 = var_3594168e.var_c43b3dd3;
				stage.var_c33fcb85 = (isdefined(var_3594168e.var_c33fcb85) ? var_3594168e.var_c33fcb85 : 0);
				/#
					var_1936b16e = getdvarint(#"hash_45e0785aaf2e24af", 0);
					if(var_1936b16e)
					{
						stage.var_e2dbd42d = var_1936b16e;
					}
				#/
			}
		}
	}
	return info;
}

/*
	Name: function_a108c50e
	Namespace: activecamo
	Checksum: 0x23992060
	Offset: 0xFB8
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function function_a108c50e(weapon, b_has_weapon = 1)
{
	activecamoinfo = undefined;
	if(b_has_weapon)
	{
		weaponoptions = self getweaponoptions(weapon);
	}
	else
	{
		weaponoptions = self getbuildkitweaponoptions(weapon);
	}
	camoindex = getcamoindex(weaponoptions);
	activecamoname = getactivecamo(camoindex);
	if(isdefined(activecamoname) && activecamoname != #"")
	{
		activecamoinfo = getscriptbundle(activecamoname);
	}
	return activecamoinfo;
}

/*
	Name: function_37a45562
	Namespace: activecamo
	Checksum: 0x6F72DE30
	Offset: 0x10C0
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function function_37a45562(camoindex, activecamo)
{
	foreach(stagenum, stage in activecamo.info.stages)
	{
		if(isdefined(stage) && isdefined(stage.var_19b6044e) && stage.var_19b6044e == camoindex)
		{
			return stagenum;
		}
	}
	return undefined;
}

/*
	Name: function_d005b26d
	Namespace: activecamo
	Checksum: 0x62065FD2
	Offset: 0x1188
	Size: 0xBB4
	Parameters: 3
	Flags: Linked
*/
function function_d005b26d(activecamo, var_3a8a1e00, isdeath)
{
	if(isdefined(activecamo))
	{
		if(isdefined(activecamo.info) && isdefined(activecamo.info.stages))
		{
			weaponoptions = self getweaponoptions(activecamo.weapon);
			weaponstage = getactivecamostage(weaponoptions);
			camoindex = getcamoindex(weaponoptions);
			camoindexstage = function_37a45562(camoindex, activecamo);
			var_7491ec51 = activecamo.var_dd54a13b[activecamo.baseweapon].owned !== 1;
			if(!var_7491ec51)
			{
				var_7491ec51 = isdefined(camoindexstage);
				if(var_7491ec51)
				{
					weaponstage = camoindexstage;
				}
			}
			if(!isdefined(activecamo.stages))
			{
				activecamo.stages = [];
			}
			foreach(stagenum, infostage in activecamo.info.stages)
			{
				if(!isdefined(activecamo.stages[stagenum]))
				{
					activecamo.stages[stagenum] = {};
				}
				stage = activecamo.stages[stagenum];
				stage.info = infostage;
				/#
					assert(isdefined(stage.info));
				#/
				if(!isdefined(stage.var_dd54a13b))
				{
					stage.var_dd54a13b = [];
				}
				if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
				{
					stage.var_dd54a13b[activecamo.baseweapon] = {};
				}
				if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon].statvalue))
				{
					stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
				}
				reset = 0;
				if(var_3a8a1e00)
				{
					stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
					reset = 1;
				}
				else if(isdeath)
				{
					if(isdefined(stage.info.var_825ae630) && stage.info.var_825ae630 && (isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared))
					{
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
					}
					else if(isdefined(stage.info.resetondeath) && stage.info.resetondeath || stage.info.resettimer > 0)
					{
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
						reset = 1;
					}
				}
				if(isdefined(stage.info.var_d2eac588))
				{
					camo_stat = self stats::get_stat_global(stage.info.var_d2eac588);
					if(isdefined(camo_stat) && camo_stat < stage.info.var_e2dbd42d)
					{
						var_7dfd59c3 = (isdefined(stats::function_af5584ca(stage.info.var_d2eac588)) ? stats::function_af5584ca(stage.info.var_d2eac588) : 0);
						if(var_7dfd59c3 > 0)
						{
							camo_stat = stage.info.var_e2dbd42d;
							self stats::set_stat_global(stage.info.var_d2eac588, camo_stat);
							self stats::set_stat_challenge(stage.info.var_d2eac588, camo_stat);
						}
					}
					if(isdefined(camo_stat))
					{
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
					}
				}
				else if(isdefined(stage.info.permanent) && stage.info.permanent && isdefined(stage.info.statname))
				{
					camo_stat = self stats::get_stat_global(stage.info.statname);
					if(isdefined(camo_stat))
					{
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = camo_stat;
					}
				}
				if(!reset && (isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared))
				{
					if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
					{
						if(weaponstage > stagenum)
						{
							stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
						}
					}
					if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
					{
						if(isdefined(stage.info.var_d2eac588))
						{
							if(weaponstage > stagenum)
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
						}
						else
						{
							if(isdefined(stage.info.permanent) && stage.info.permanent && isdefined(stage.info.statname))
							{
								if(weaponstage > stagenum)
								{
									stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
								}
							}
							else if(weaponstage == stagenum)
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
						}
					}
				}
				stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
				if(var_7491ec51)
				{
					if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
					{
						if(weaponstage > stagenum)
						{
							if(isdefined(stage.info.var_d2eac588))
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
							else if(isdefined(stage.info.permanent) && stage.info.permanent && isdefined(stage.info.statname))
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
						}
					}
					if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
					{
						if(isdefined(stage.info.var_d2eac588))
						{
							if(weaponstage > stagenum)
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
						}
						else
						{
							if(isdefined(stage.info.permanent) && stage.info.permanent && isdefined(stage.info.statname))
							{
								if(weaponstage > stagenum)
								{
									stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
								}
							}
							else if(weaponstage == stagenum)
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
							}
						}
					}
				}
				if(isdefined(activecamo.info.var_e639aa37) && activecamo.info.var_e639aa37)
				{
					self thread function_f0d83504(activecamo, stage, stagenum);
				}
			}
			self function_e44edbd1(activecamo);
		}
	}
}

/*
	Name: function_c0fa0ecb
	Namespace: activecamo
	Checksum: 0xA06126FF
	Offset: 0x1D48
	Size: 0x1B2
	Parameters: 1
	Flags: Linked
*/
function function_c0fa0ecb(weapon)
{
	switch(weapon.statname)
	{
		case "tr_midburst_t8":
		case "sniper_powersemi_t8":
		case "ar_damage_t8":
		case "ar_accurate_t8":
		case "smg_capacity_t8":
		case "sniper_powerbolt_t8":
		case "ar_fastfire_t8":
		case "sniper_quickscope_t8":
		case "lmg_heavy_t8":
		case "ar_stealth_t8":
		case "tr_longburst_t8":
		case "smg_standard_t8":
		case "lmg_spray_t8":
		case "smg_accurate_t8":
		case "ar_modular_t8":
		case "smg_fastfire_t8":
		case "lmg_standard_t8":
		case "sniper_fastrechamber_t8":
		case "tr_powersemi_t8":
		case "smg_handling_t8":
		{
			self stats::function_eec52333(weapon, #"hash_4e43a25a3e77ab5f", 1, self.class_num);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_c1f96c48
	Namespace: activecamo
	Checksum: 0x53452CAC
	Offset: 0x1F08
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function function_c1f96c48(weapon)
{
	switch(weapon.statname)
	{
		case "ar_accurate_t8":
		{
			return #"hash_3d392c6f96aa2ac1";
		}
		case "ar_fastfire_t8":
		{
			return #"hash_9da725fe15aa048";
		}
		case "lmg_standard_t8":
		{
			return #"hash_5cf945d7954a39e0";
		}
		case "pistol_standard_t8":
		{
			return #"hash_1ffb9d5647330a52";
		}
		case "shotgun_semiauto_t8":
		{
			return #"hash_6ed19b98000fb441";
		}
		case "smg_accurate_t8":
		{
			return #"hash_4b703056e870752e";
		}
		case "smg_standard_t8":
		{
			return #"hash_207f20afd71816c";
		}
		default:
		{
			break;
		}
	}
	return undefined;
}

/*
	Name: function_938534a8
	Namespace: activecamo
	Checksum: 0xAE3C76B0
	Offset: 0x2030
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function function_938534a8(var_d2eac588)
{
	var_19ef0b8d = undefined;
	switch(var_d2eac588)
	{
		case "hash_3d392c6f96aa2ac1":
		{
			var_19ef0b8d = #"hash_1dfe074febc1a47";
			break;
		}
		case "hash_9da725fe15aa048":
		{
			var_19ef0b8d = #"hash_62942bcbd7f7246f";
			break;
		}
		case "hash_5cf945d7954a39e0":
		{
			var_19ef0b8d = #"hash_28de2e37d153637";
			break;
		}
		case "hash_1ffb9d5647330a52":
		{
			var_19ef0b8d = #"hash_4325109e26315e0e";
			break;
		}
		case "hash_6ed19b98000fb441":
		{
			var_19ef0b8d = #"hash_45a80b864ab2adc1";
			break;
		}
		case "hash_4b703056e870752e":
		{
			var_19ef0b8d = #"hash_3c5adf2858a5fec3";
			break;
		}
		case "hash_207f20afd71816c":
		{
			var_19ef0b8d = #"hash_6df1f30ebff59926";
			break;
		}
		default:
		{
			break;
		}
	}
	if(isdefined(var_19ef0b8d))
	{
		self stats::function_dad108fa(var_19ef0b8d, 1);
	}
}

/*
	Name: function_1af985ba
	Namespace: activecamo
	Checksum: 0x61CC4AA1
	Offset: 0x21B8
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function function_1af985ba(weapon)
{
	if(!isplayer(self))
	{
		return;
	}
	var_19bbfaaf = function_c1f96c48(weapon);
	if(!isdefined(var_19bbfaaf))
	{
		return;
	}
	var_dfcb2df3 = (isdefined(stats::function_af5584ca(var_19bbfaaf)) ? stats::function_af5584ca(var_19bbfaaf) : 0);
	if(var_dfcb2df3 > 0)
	{
		self stats::function_e24eec31(weapon, #"hash_19fbe2645c7f53a7", 1);
		self function_938534a8(var_19bbfaaf);
	}
}

/*
	Name: function_cd9deb9e
	Namespace: activecamo
	Checksum: 0x1414D7A3
	Offset: 0x22A0
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function function_cd9deb9e(weapon)
{
	if(!isplayer(self))
	{
		return;
	}
	var_19bbfaaf = function_c1f96c48(weapon);
	if(!isdefined(var_19bbfaaf))
	{
		return;
	}
	var_dfcb2df3 = (isdefined(stats::function_af5584ca(var_19bbfaaf)) ? stats::function_af5584ca(var_19bbfaaf) : 0);
	if(var_dfcb2df3 > 0)
	{
		self stats::function_e24eec31(weapon, #"hash_19fbe2645c7f53a7", 1);
		self function_938534a8(var_19bbfaaf);
	}
}

/*
	Name: function_36feaf9e
	Namespace: activecamo
	Checksum: 0xA2A232FC
	Offset: 0x2388
	Size: 0x142
	Parameters: 3
	Flags: Linked
*/
function function_36feaf9e(activecamo, value, weapon)
{
	if(!isdefined(activecamo.kills))
	{
		activecamo.kills = 0;
	}
	newvalue = activecamo.kills + value;
	if(activecamo.kills < 5 && newvalue >= 5)
	{
		self function_896ac347(weapon, "5th_kill", 1);
	}
	if(activecamo.kills < 9 && newvalue >= 9)
	{
		self function_896ac347(weapon, "9th_kill", 1);
	}
	if(activecamo.kills < 100 && newvalue >= 100)
	{
		self function_896ac347(weapon, "100th_kill", 1);
	}
	activecamo.kills = newvalue;
}

/*
	Name: function_896ac347
	Namespace: activecamo
	Checksum: 0x630DE28D
	Offset: 0x24D8
	Size: 0x914
	Parameters: 3
	Flags: Linked
*/
function function_896ac347(oweapon, statname, value)
{
	if(!isplayer(self))
	{
		return;
	}
	if(!isdefined(self.pers) || !isdefined(self.pers[#"activecamo"]))
	{
		return;
	}
	if(!isdefined(oweapon))
	{
		/#
			/#
				assertmsg("");
			#/
		#/
		return;
	}
	weapon = function_94c2605(oweapon);
	if(!isdefined(weapon))
	{
		/#
			/#
				assertmsg("" + function_9e72a96(oweapon.name));
			#/
		#/
		return;
	}
	activecamoinfo = function_a108c50e(weapon);
	if(isdefined(activecamoinfo))
	{
		activecamo = self.pers[#"activecamo"][activecamoinfo.name];
		if(isdefined(activecamo))
		{
			activecamo.weapon = weapon;
			activecamo.baseweapon = function_c14cb514(activecamo.weapon);
			if(!isdefined(activecamo.baseweapon))
			{
				/#
					/#
						assertmsg("" + function_9e72a96(activecamo.weapon.name));
					#/
				#/
				return;
			}
			if(!isdefined(activecamo.var_dd54a13b[activecamo.baseweapon]))
			{
				/#
					/#
						assertmsg(("" + function_9e72a96(activecamo.baseweapon.name)) + "");
					#/
				#/
				return;
			}
			var_7a414d4a = 0;
			var_5c900b6e = 0;
			var_7cbc8452 = 0;
			var_15838be3 = 0;
			if(isdefined(activecamo.stages))
			{
				foreach(stagenum, stage in activecamo.stages)
				{
					if(isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared)
					{
						if(stage.info.statname === statname)
						{
							var_5c900b6e = 1;
						}
						continue;
					}
					lastvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue;
					if(isdefined(stage.info.var_d2eac588) && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1)
					{
						if(stage.info.statname == statname)
						{
							if(self stats::function_dad108fa(stage.info.var_d2eac588, value))
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(stage.info.var_d2eac588);
							}
						}
					}
					else if(isdefined(stage.info.statname))
					{
						if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
						{
							if(!(isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8))
							{
								continue;
							}
						}
						if(isdefined(stage.info.permanent) && stage.info.permanent && activecamo.var_dd54a13b[activecamo.baseweapon].owned === 1)
						{
							if(self stats::function_dad108fa(statname, value))
							{
								stage.var_dd54a13b[activecamo.baseweapon].statvalue = self stats::get_stat_global(statname);
							}
						}
						else if(stage.info.statname == statname)
						{
							stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.var_dd54a13b[activecamo.baseweapon].statvalue + value;
						}
					}
					var_804a253 = stage.var_dd54a13b[activecamo.baseweapon].statvalue > lastvalue;
					if(var_804a253)
					{
						var_7a414d4a = 1;
						if(isdefined(activecamo.info.var_e0b0d8cc) && activecamo.info.var_e0b0d8cc)
						{
							var_7cbc8452 = 1;
							self thread function_a6bcf0e2(activecamo);
						}
						if(sessionmodeismultiplayergame())
						{
							if(activecamoinfo.name == #"hash_391b1d38f4d65c14")
							{
								if(stagenum == 1 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 5)
								{
									self stats::function_dad108fa(#"hash_51eff59939399dc9", 1);
								}
								else if(stagenum == 5 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 5)
								{
									self function_c0fa0ecb(weapon);
								}
							}
							else if(activecamoinfo.name == #"hash_4cc835f621014977")
							{
								if(stagenum == 1 && stage.var_dd54a13b[activecamo.baseweapon].statvalue == 1)
								{
									self stats::function_dad108fa(#"hash_354bfe5c140365bf", 1);
								}
							}
						}
					}
					if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
					{
						break;
					}
				}
				if(var_7a414d4a)
				{
					var_15838be3 = self function_b9119037(activecamo);
				}
				if(!var_15838be3 && var_5c900b6e && !var_7cbc8452 && (isdefined(activecamo.var_e0b0d8cc) && activecamo.var_e0b0d8cc))
				{
					var_7cbc8452 = 1;
					self thread function_a6bcf0e2(activecamo);
				}
			}
			if(statname == #"kills")
			{
				self function_36feaf9e(activecamo, value, activecamo.weapon);
			}
		}
	}
}

/*
	Name: function_94c2605
	Namespace: activecamo
	Checksum: 0x41188520
	Offset: 0x2DF8
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_94c2605(weapon)
{
	if(isdefined(weapon))
	{
		if(level.weaponnone != weapon)
		{
			var_7c3192e1 = weapon;
			if(var_7c3192e1.inventorytype == "dwlefthand")
			{
				if(isdefined(var_7c3192e1.dualwieldweapon) && level.weaponnone != var_7c3192e1.dualwieldweapon)
				{
					var_7c3192e1 = var_7c3192e1.dualwieldweapon;
				}
			}
			if(var_7c3192e1.isaltmode)
			{
				if(isdefined(var_7c3192e1.altweapon) && level.weaponnone != var_7c3192e1.altweapon)
				{
					var_7c3192e1 = var_7c3192e1.altweapon;
				}
			}
			return var_7c3192e1;
		}
	}
	return weapon;
}

/*
	Name: function_a6bcf0e2
	Namespace: activecamo
	Checksum: 0x7B04B8BC
	Offset: 0x2EE8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_a6bcf0e2(activecamo)
{
	self impulseactivecamo(activecamo.weapon);
}

/*
	Name: function_f0d83504
	Namespace: activecamo
	Checksum: 0x491337D3
	Offset: 0x2F20
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function function_f0d83504(activecamo, stage, stagenum)
{
	self setactivecamostage(activecamo.weapon, stagenum, 1, isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared);
}

/*
	Name: function_e44edbd1
	Namespace: activecamo
	Checksum: 0x6A0DD668
	Offset: 0x2FB0
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_e44edbd1(activecamo)
{
	if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
	{
		var_e92afc26 = 0;
		for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--)
		{
			stage = activecamo.stages[stagenum];
			if(stage.info.var_e2dbd42d > 0 && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d)
			{
				if(var_e92afc26 < stagenum)
				{
					var_e92afc26 = stagenum;
				}
			}
			if(stagenum < var_e92afc26)
			{
				stage.var_dd54a13b[activecamo.baseweapon].statvalue = stage.info.var_e2dbd42d;
			}
		}
		self function_b9119037(activecamo);
	}
	if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
	{
		activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 0;
		self function_b9119037(activecamo);
	}
}

/*
	Name: function_b9119037
	Namespace: activecamo
	Checksum: 0x7798E920
	Offset: 0x3190
	Size: 0x886
	Parameters: 1
	Flags: Linked
*/
function function_b9119037(activecamo)
{
	if(!isdefined(activecamo.baseweapon) || !isdefined(activecamo.var_dd54a13b[activecamo.baseweapon]))
	{
		return;
	}
	if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
	{
		stagenum = 0;
		foreach(key, stage in activecamo.stages)
		{
			if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
			{
				continue;
			}
			stagenum = key;
			if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d)
			{
				stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
				if(activecamo.info.var_9ae5a2b8 === 1 && stagenum == (activecamo.stages.size - 1))
				{
					var_c70461e6 = 1;
					break;
				}
				continue;
			}
			break;
		}
		if(var_c70461e6 === 1)
		{
			var_2cc4646f = 0;
			foreach(key, stage in activecamo.stages)
			{
				if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
				{
					continue;
				}
				if(!var_2cc4646f)
				{
					if(stage.info.var_c33fcb85 === 1)
					{
						var_2cc4646f = 1;
						stagenum = key;
					}
					else
					{
						continue;
					}
				}
				stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
				stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
				stage.resettime = undefined;
			}
			if(var_2cc4646f)
			{
				return set_stage_activecamo(activecamo, stagenum);
			}
		}
		else
		{
			weaponoptions = self getweaponoptions(activecamo.weapon);
			weaponstage = getactivecamostage(weaponoptions);
			if(weaponstage != stagenum || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== stagenum)
			{
				return set_stage_activecamo(activecamo, stagenum);
			}
		}
		return 0;
	}
	if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
	{
		if(!(isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8))
		{
			var_8fc208a8 = 1;
			foreach(stage in activecamo.stages)
			{
				if(isdefined(stage.info.var_d2eac588))
				{
					if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
					{
						continue;
					}
					if(stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d)
					{
						stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
					}
					if(!(isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared))
					{
						var_8fc208a8 = 0;
					}
					continue;
				}
				break;
			}
			if(var_8fc208a8)
			{
				activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = 1;
			}
		}
		var_42d9b149 = 0;
		if(isdefined(activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8) && activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8)
		{
			for(stagenum = activecamo.stages.size - 1; stagenum >= 0; stagenum--)
			{
				stage = activecamo.stages[stagenum];
				if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
				{
					continue;
				}
				if(!(isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].statvalue >= stage.info.var_e2dbd42d)
				{
					stage.var_dd54a13b[activecamo.baseweapon].cleared = 1;
					var_42d9b149 = stagenum;
					break;
				}
			}
			foreach(key, stage in activecamo.stages)
			{
				if(isdefined(stage.info.var_d2eac588))
				{
					continue;
				}
				if(var_42d9b149 == key)
				{
					continue;
				}
				if(!isdefined(stage.var_dd54a13b[activecamo.baseweapon]))
				{
					continue;
				}
				stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
				stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
			}
		}
		weaponoptions = self getweaponoptions(activecamo.weapon);
		weaponstage = getactivecamostage(weaponoptions);
		if(weaponstage != var_42d9b149 || activecamo.var_dd54a13b[activecamo.baseweapon].stagenum !== var_42d9b149)
		{
			return set_stage_activecamo(activecamo, var_42d9b149);
		}
	}
	return 0;
}

/*
	Name: set_stage_activecamo
	Namespace: activecamo
	Checksum: 0x2063D015
	Offset: 0x3A20
	Size: 0x170
	Parameters: 2
	Flags: Linked
*/
function set_stage_activecamo(activecamo, stagenum)
{
	setstage = activecamo.stages[stagenum];
	if(!isdefined(setstage))
	{
		return false;
	}
	activecamo.var_dd54a13b[activecamo.baseweapon].stagenum = stagenum;
	self setactivecamostage(activecamo.weapon, stagenum);
	if(isdefined(setstage.info.var_19b6044e))
	{
		self setcamo(activecamo.weapon, setstage.info.var_19b6044e);
	}
	/#
		self debug_print((((("" + activecamo.info.name) + "") + stagenum) + "") + (isdefined(setstage.info.info.var_19b6044e) ? setstage.info.var_19b6044e : ""));
	#/
	self thread function_a80cb651(activecamo, stagenum);
	return true;
}

/*
	Name: function_a80cb651
	Namespace: activecamo
	Checksum: 0x686E8977
	Offset: 0x3B98
	Size: 0x34C
	Parameters: 2
	Flags: Linked
*/
function function_a80cb651(activecamo, stagenum)
{
	self notify("4be8cd84d8f00caa");
	self endon("4be8cd84d8f00caa");
	self endon(#"new_stage", #"death");
	stage = activecamo.stages[stagenum];
	if(stage.info.resettimer == 0 && !isdefined(stage.info.resetnotify))
	{
		return;
	}
	weapon = activecamo.weapon;
	while(true)
	{
		if(stage.info.resettimer > 0 && isdefined(stage.info.resetnotify))
		{
			stage.resettime = gettime() + stage.info.resettimer;
			s_result = undefined;
			s_result = self waittilltimeout(float(stage.info.resettimer) / 1000, stage.info.resetnotify);
		}
		else
		{
			if(stage.info.resettimer > 0)
			{
				stage.resettime = gettime() + stage.info.resettimer;
				wait(float(stage.info.resettimer) / 1000);
			}
			else
			{
				s_result = undefined;
				s_result = self waittill(stage.info.resetnotify);
			}
		}
		baseweapon = function_c14cb514(weapon);
		if(!isdefined(s_result) || !isdefined(s_result.weapon) || baseweapon == s_result.weapon)
		{
			break;
		}
	}
	activecamo.weapon = weapon;
	activecamo.baseweapon = baseweapon;
	if(isdefined(stage.var_dd54a13b[activecamo.baseweapon].cleared) && stage.var_dd54a13b[activecamo.baseweapon].cleared)
	{
		return;
	}
	stage.var_dd54a13b[activecamo.baseweapon].statvalue = 0;
	stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
	stage.resettime = undefined;
	self function_d005b26d(activecamo, 1, 0);
}

/*
	Name: function_8530ef96
	Namespace: activecamo
	Checksum: 0xE0552F09
	Offset: 0x3EF0
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function function_8530ef96(message, weapon)
{
	/#
		if(getdvarint(#"activecamo_debug", 0) > 0)
		{
			weaponname = "";
			if(isdefined(weapon))
			{
				weaponname = "" + function_9e72a96(weapon.name);
			}
			self iprintlnbold(("" + message) + weaponname);
			println(((("" + self.playername) + "") + message) + weaponname);
		}
	#/
}

/*
	Name: debug_print
	Namespace: activecamo
	Checksum: 0x8AA95882
	Offset: 0x3FE0
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function debug_print(message, weapon)
{
	/#
		if(getdvarint(#"activecamo_debug", 0) > 0)
		{
			weaponname = "";
			if(isdefined(weapon))
			{
				weaponname = "" + function_9e72a96(weapon.name);
			}
			self iprintlnbold(("" + message) + weaponname);
			println(((("" + self.playername) + "") + message) + weaponname);
		}
	#/
}

/*
	Name: function_265047c1
	Namespace: activecamo
	Checksum: 0x21468677
	Offset: 0x40D0
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function function_265047c1()
{
	/#
		callback::on_connect(&on_player_connect);
		callback::on_disconnect(&on_player_disconnect);
		level.var_630fbd77 = "";
		root = "" + level.var_630fbd77;
		function_1039ce5c(root);
		thread devgui_think();
	#/
}

/*
	Name: on_player_connect
	Namespace: activecamo
	Checksum: 0xC9826166
	Offset: 0x4180
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function on_player_connect()
{
	/#
		if(self getentnum() < 4)
		{
			self thread devgui_player_connect();
		}
	#/
}

/*
	Name: on_player_disconnect
	Namespace: activecamo
	Checksum: 0x9493CC2C
	Offset: 0x41C0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function on_player_disconnect()
{
	/#
		if(self getentnum() < 4)
		{
			self thread devgui_player_disconnect();
		}
	#/
}

/*
	Name: devgui_player_connect
	Namespace: activecamo
	Checksum: 0x9D9313D6
	Offset: 0x4200
	Size: 0xC8
	Parameters: 0
	Flags: None
*/
function devgui_player_connect()
{
	/#
		if(!isdefined(level.var_630fbd77))
		{
			return;
		}
		wait(2);
		root = level.var_630fbd77 + "";
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] != self)
			{
				continue;
			}
			thread devgui_add_player_commands(root, players[i].playername, i + 1);
			return;
		}
	#/
}

/*
	Name: devgui_player_disconnect
	Namespace: activecamo
	Checksum: 0x33B89E06
	Offset: 0x42D0
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function devgui_player_disconnect()
{
	/#
		if(!isdefined(level.var_630fbd77))
		{
			return;
		}
		root = level.var_630fbd77 + "";
		cmd = (("" + root) + self.playername) + "";
		thread util::add_debug_command(cmd);
	#/
}

/*
	Name: devgui_add_player_commands
	Namespace: activecamo
	Checksum: 0xDA4ED4C2
	Offset: 0x4350
	Size: 0xC4
	Parameters: 3
	Flags: None
*/
function devgui_add_player_commands(root, pname, index)
{
	/#
		add_cmd_with_root = (("" + root) + pname) + "";
		pid = "" + index;
		function_f1d01720(add_cmd_with_root, index);
		function_85cb822d(add_cmd_with_root, index);
		function_de358bfd(add_cmd_with_root, index);
		function_50d79d31(add_cmd_with_root, index);
	#/
}

/*
	Name: function_1039ce5c
	Namespace: activecamo
	Checksum: 0x8D0E48
	Offset: 0x4420
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_1039ce5c(root)
{
	/#
		cmd = (root + "") + "";
		thread util::add_debug_command(cmd);
	#/
}

/*
	Name: function_f1d01720
	Namespace: activecamo
	Checksum: 0x14E9978B
	Offset: 0x4470
	Size: 0xFC
	Parameters: 2
	Flags: None
*/
function function_f1d01720(root, index)
{
	/#
		var_37949de1 = root;
		if(!isdefined(index))
		{
			index = 0;
		}
		cmd = (((root + "") + "") + index) + "";
		thread util::add_debug_command(cmd);
		cmd = (((root + "") + "") + index) + "";
		thread util::add_debug_command(cmd);
		cmd = (((root + "") + "") + index) + "";
		thread util::add_debug_command(cmd);
	#/
}

/*
	Name: function_85cb822d
	Namespace: activecamo
	Checksum: 0x7CE7E682
	Offset: 0x4578
	Size: 0x130
	Parameters: 2
	Flags: None
*/
function function_85cb822d(root, index)
{
	/#
		var_37949de1 = root + "";
		if(!isdefined(index))
		{
			index = 0;
		}
		activecamos = function_2c48197b();
		foreach(activecamo in activecamos)
		{
			activecamoname = function_9e72a96(activecamo);
			cmd = (((((var_37949de1 + activecamoname) + "") + activecamoname) + "") + index) + "";
			thread util::add_debug_command(cmd);
		}
	#/
}

/*
	Name: function_de358bfd
	Namespace: activecamo
	Checksum: 0xCEE6755D
	Offset: 0x46B0
	Size: 0x148
	Parameters: 2
	Flags: None
*/
function function_de358bfd(root, index)
{
	/#
		var_1520a1da = root + "";
		if(!isdefined(index))
		{
			index = 0;
		}
		weapons = [];
		weapons[0] = "";
		weapons[1] = "";
		weapons[2] = "";
		weapons[3] = "";
		foreach(weapon in weapons)
		{
			cmd = (((((var_1520a1da + weapon) + "") + weapon) + "") + index) + "";
			thread util::add_debug_command(cmd);
		}
	#/
}

/*
	Name: function_50d79d31
	Namespace: activecamo
	Checksum: 0x385A42D
	Offset: 0x4800
	Size: 0x160
	Parameters: 2
	Flags: None
*/
function function_50d79d31(root, index)
{
	/#
		var_82c49718 = root + "";
		if(!isdefined(index))
		{
			index = 0;
		}
		stages = [9:9, 8:8, 7:7, 6:6, 5:5, 4:4, 3:3, 2:2, 1:1, 0:0];
		foreach(stage in stages)
		{
			cmd = (((((var_82c49718 + stage) + "") + stage) + "") + index) + "";
			thread util::add_debug_command(cmd);
		}
	#/
}

/*
	Name: devgui_think
	Namespace: activecamo
	Checksum: 0xE360EDEA
	Offset: 0x4968
	Size: 0x350
	Parameters: 0
	Flags: None
*/
function devgui_think()
{
	/#
		for(;;)
		{
			wait(0.5);
			reset = 1;
			host = util::gethostplayer();
			switch(getdvarstring(#"hash_3e1bb44a57b02ed8"))
			{
				case 0:
				{
					reset = 0;
					break;
				}
				case "debugprints":
				{
					setdvar(#"activecamo_debug", !getdvarint(#"activecamo_debug", 0));
					break;
				}
				case "reset":
				{
					function_cc5baf7f(&function_58719455);
					break;
				}
				case "impulse":
				{
					function_cc5baf7f(&function_382462ff);
					break;
				}
				case "stage_next":
				{
					function_cc5baf7f(&function_3ac4d286, 0);
					break;
				}
				case "stage_prev":
				{
					function_cc5baf7f(&function_3ac4d286, 1);
					break;
				}
				case "set_camo":
				{
					function_cc5baf7f(&function_9c361e56, getdvarstring(#"hash_3fe8dd280c325e8"));
					break;
				}
				case "give_weapon":
				{
					function_cc5baf7f(&function_cc486b05, getdvarstring(#"hash_3fe8dd280c325e8"));
					break;
				}
				case "set_stage":
				{
					function_cc5baf7f(&function_779a9561, getdvarstring(#"hash_3fe8dd280c325e8"));
					break;
				}
			}
			if(reset)
			{
				setdvar(#"hash_3e1bb44a57b02ed8", "");
				setdvar(#"hash_3fe8dd280c325e8", "");
				setdvar(#"hash_324a391b56cb100", "");
			}
		}
	#/
}

/*
	Name: function_cc5baf7f
	Namespace: activecamo
	Checksum: 0x52CFE894
	Offset: 0x4CC0
	Size: 0x150
	Parameters: 2
	Flags: None
*/
function function_cc5baf7f(callback, par)
{
	/#
		pid = getdvarint(#"hash_324a391b56cb100", 0);
		if(pid > 0)
		{
			player = getplayers()[pid - 1];
			if(isdefined(player))
			{
				if(isdefined(par))
				{
					player [[callback]](par);
				}
				else
				{
					player [[callback]]();
				}
			}
		}
		else
		{
			players = getplayers();
			foreach(player in players)
			{
				if(isdefined(par))
				{
					player [[callback]](par);
					continue;
				}
				player [[callback]]();
			}
		}
	#/
}

/*
	Name: function_cc486b05
	Namespace: activecamo
	Checksum: 0xDAFFD2CA
	Offset: 0x4E18
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_cc486b05(weaponname)
{
	/#
		weapon = getweapon(weaponname);
		self giveweapon(weapon);
		self switchtoweapon(weapon);
	#/
}

/*
	Name: function_779a9561
	Namespace: activecamo
	Checksum: 0xC06F2382
	Offset: 0x4E80
	Size: 0x4F4
	Parameters: 1
	Flags: None
*/
function function_779a9561(stagenum)
{
	/#
		weapon = self getcurrentweapon();
		weapon = function_94c2605(weapon);
		activecamoinfo = function_a108c50e(weapon);
		if(isdefined(activecamoinfo))
		{
			activecamo = self.pers[#"activecamo"][activecamoinfo.name];
			if(isdefined(activecamo) && isdefined(activecamo.stages) && stagenum < activecamo.stages.size)
			{
				activecamo.weapon = weapon;
				activecamo.baseweapon = function_c14cb514(activecamo.weapon);
				if(isdefined(activecamo.info.var_cd82182a) && activecamo.info.var_cd82182a)
				{
					foreach(key, stage in activecamo.stages)
					{
						statcount = 0;
						if(key < stagenum)
						{
							statcount = stage.info.var_e2dbd42d;
						}
						if(isdefined(stage.info.var_d2eac588))
						{
							self stats::set_stat_global(stage.info.var_d2eac588, statcount);
						}
						else if(isdefined(stage.info.statname))
						{
							if(isdefined(stage.info.permanent) && stage.info.permanent)
							{
								self stats::set_stat_global(stage.info.statname, statcount);
							}
						}
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
						stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
					}
				}
				else if(isdefined(activecamo.info.var_2034fabe) && activecamo.info.var_2034fabe)
				{
					activecamo.var_dd54a13b[activecamo.baseweapon].var_8fc208a8 = undefined;
					foreach(key, stage in activecamo.stages)
					{
						statcount = 0;
						if(key < stagenum)
						{
							statcount = stage.info.var_e2dbd42d;
						}
						if(isdefined(stage.info.var_d2eac588))
						{
							self stats::set_stat_global(stage.info.var_d2eac588, statcount);
						}
						else if(isdefined(stage.info.statname))
						{
							statcount = 0;
							if(key == stagenum)
							{
								statcount = stage.info.var_e2dbd42d;
							}
							if(isdefined(stage.info.permanent) && stage.info.permanent)
							{
								self stats::set_stat_global(stage.info.statname, statcount);
							}
						}
						stage.var_dd54a13b[activecamo.baseweapon].statvalue = statcount;
						stage.var_dd54a13b[activecamo.baseweapon].cleared = undefined;
					}
				}
				self function_b9119037(activecamo);
			}
		}
	#/
}

/*
	Name: function_9c361e56
	Namespace: activecamo
	Checksum: 0xF07BA833
	Offset: 0x5380
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_9c361e56(activecamoname)
{
	/#
		activecamoinfo = getscriptbundle(activecamoname);
		weapon = self getcurrentweapon();
		if(isdefined(activecamoinfo))
		{
			self init_activecamo(weapon, activecamoinfo, 1);
		}
	#/
}

/*
	Name: function_3ac4d286
	Namespace: activecamo
	Checksum: 0x7704D71
	Offset: 0x5400
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_3ac4d286(back)
{
	/#
		weapon = self getcurrentweapon();
		self function_633fbf17(weapon, back);
	#/
}

/*
	Name: function_633fbf17
	Namespace: activecamo
	Checksum: 0xD0B106A9
	Offset: 0x5458
	Size: 0x1CC
	Parameters: 2
	Flags: None
*/
function function_633fbf17(weapon, back)
{
	/#
		if(isdefined(weapon))
		{
			self function_8d3b94ea(weapon, 1);
			weapon = function_94c2605(weapon);
			activecamoinfo = function_a108c50e(weapon);
			if(isdefined(activecamoinfo))
			{
				activecamo = self.pers[#"activecamo"][activecamoinfo.name];
				if(isdefined(activecamo))
				{
					if(isdefined(activecamo.stages))
					{
						activecamo.weapon = weapon;
						activecamo.baseweapon = function_c14cb514(activecamo.weapon);
						var_ee939e0c = (isdefined(activecamo.var_dd54a13b[activecamo.var_dd54a13b[activecamo.baseweapon].baseweapon].stagenum) ? activecamo.var_dd54a13b[activecamo.baseweapon].stagenum : -1);
						if(back)
						{
							nextstage = ((var_ee939e0c - 1) + activecamo.stages.size) % activecamo.stages.size;
						}
						else
						{
							nextstage = (var_ee939e0c + 1) % activecamo.stages.size;
						}
						self function_779a9561(nextstage);
					}
				}
			}
		}
	#/
}

/*
	Name: function_58719455
	Namespace: activecamo
	Checksum: 0x8B1BEC0B
	Offset: 0x5630
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_58719455()
{
	/#
		weapon = self getcurrentweapon();
		self function_3d928fb4(weapon);
	#/
}

/*
	Name: function_3d928fb4
	Namespace: activecamo
	Checksum: 0x7F4A8F5
	Offset: 0x5678
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_3d928fb4(weapon)
{
	/#
		if(isdefined(weapon))
		{
			self function_8d3b94ea(weapon, 1);
			weapon = function_94c2605(weapon);
			activecamoinfo = function_a108c50e(weapon);
			if(isdefined(activecamoinfo))
			{
				activecamo = self.pers[#"activecamo"][activecamoinfo.name];
				if(isdefined(activecamo))
				{
					activecamo.weapon = weapon;
					activecamo.baseweapon = function_c14cb514(activecamo.weapon);
					self function_9fc8a57c(activecamo);
				}
			}
		}
	#/
}

/*
	Name: function_9fc8a57c
	Namespace: activecamo
	Checksum: 0xF01B7BB8
	Offset: 0x5780
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_9fc8a57c(activecamo)
{
	/#
		if(isdefined(activecamo))
		{
			if(isdefined(activecamo.stages))
			{
				foreach(stagenum, stage in activecamo.stages)
				{
					self function_dc6014e8(activecamo, stage, stagenum);
				}
				self function_d005b26d(activecamo, 1, 0);
			}
		}
	#/
}

/*
	Name: function_dc6014e8
	Namespace: activecamo
	Checksum: 0x5BD01272
	Offset: 0x5850
	Size: 0xDC
	Parameters: 3
	Flags: None
*/
function function_dc6014e8(activecamo, stage, stagenum)
{
	/#
		if(isdefined(stage.info.var_d2eac588))
		{
			self stats::set_stat_global(stage.info.var_d2eac588, 0);
		}
		else if(isdefined(stage.info.statname))
		{
			if(isdefined(stage.info.permanent) && stage.info.permanent)
			{
				self stats::set_stat_global(stage.info.statname, 0);
			}
		}
	#/
}

/*
	Name: function_382462ff
	Namespace: activecamo
	Checksum: 0xB2C6E8CC
	Offset: 0x5938
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_382462ff()
{
	/#
		weapon = self getcurrentweapon();
		self function_14a9eb5b(weapon);
	#/
}

/*
	Name: function_14a9eb5b
	Namespace: activecamo
	Checksum: 0x781181D9
	Offset: 0x5980
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_14a9eb5b(weapon)
{
	/#
		if(isdefined(weapon))
		{
			self function_8d3b94ea(weapon, 1);
			weapon = function_94c2605(weapon);
			activecamoinfo = function_a108c50e(weapon);
			if(isdefined(activecamoinfo))
			{
				activecamo = self.pers[#"activecamo"][activecamoinfo.name];
				if(isdefined(activecamo))
				{
					activecamo.weapon = weapon;
					activecamo.baseweapon = function_c14cb514(activecamo.weapon);
					self function_a6bcf0e2(activecamo);
				}
			}
		}
	#/
}

