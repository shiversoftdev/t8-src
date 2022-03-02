// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace audio;

/*
	Name: function_89f2df9
	Namespace: audio
	Checksum: 0x5DF1F3BF
	Offset: 0x210
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: audio
	Checksum: 0xBF147CA9
	Offset: 0x258
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&sndresetsoundsettings);
	callback::on_player_killed(&on_player_killed);
	callback::on_vehicle_spawned(&vehiclespawncontext);
	level thread register_clientfields();
	level thread sndchyronwatcher();
}

/*
	Name: register_clientfields
	Namespace: audio
	Checksum: 0x44A85536
	Offset: 0x318
	Size: 0x2D4
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("world", "sndMatchSnapshot", 1, 2, "int");
	clientfield::register("world", "sndFoleyContext", 1, 1, "int");
	clientfield::register("scriptmover", "sndRattle", 1, 1, "counter");
	clientfield::register("allplayers", "sndRattle", 1, 1, "counter");
	clientfield::register("toplayer", "sndMelee", 1, 1, "int");
	clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int");
	clientfield::register("toplayer", "sndCCHacking", 1, 2, "int");
	clientfield::register("toplayer", "sndTacRig", 1, 1, "int");
	clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int");
	clientfield::register("world", "sndIGCsnapshot", 1, 4, "int");
	clientfield::register("world", "sndChyronLoop", 1, 1, "int");
	clientfield::register("world", "sndZMBFadeIn", 1, 1, "int");
	clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter");
	clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int");
	clientfield::register("toplayer", "sndLastStand", 1, 1, "int");
}

/*
	Name: sndchyronwatcher
	Namespace: audio
	Checksum: 0xDE3B0638
	Offset: 0x5F8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function sndchyronwatcher()
{
	level waittill(#"chyron_menu_open");
	if(isdefined(level.var_3bc9e7f0) == 0)
	{
		level clientfield::set("sndChyronLoop", 1);
	}
	level waittill(#"chyron_menu_closed");
	if(isdefined(level.var_3bc9e7f0) == 0)
	{
		level clientfield::set("sndChyronLoop", 0);
	}
}

/*
	Name: sndresetsoundsettings
	Namespace: audio
	Checksum: 0x1C9200A5
	Offset: 0x6A0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function sndresetsoundsettings()
{
	self clientfield::set_to_player("sndMelee", 0);
	self util::clientnotify("sndDEDe");
	if(!self flag::exists("playing_stinger_fired_at_me"))
	{
		self flag::init("playing_stinger_fired_at_me", 0);
	}
	else
	{
		self flag::clear("playing_stinger_fired_at_me");
	}
}

/*
	Name: on_player_connect
	Namespace: audio
	Checksum: 0xA6C2C673
	Offset: 0x750
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self callback::function_d8abfc3d(#"missile_lock", &function_9070d441);
	self callback::function_d8abfc3d(#"hash_1a32e0fdeb70a76b", &function_c25f7d1);
}

/*
	Name: on_player_killed
	Namespace: audio
	Checksum: 0x79E6A167
	Offset: 0x7C0
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!(isdefined(self.killcam) && self.killcam))
	{
		self util::clientnotify("sndDED");
	}
}

/*
	Name: vehiclespawncontext
	Namespace: audio
	Checksum: 0xB7FF852D
	Offset: 0x808
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function vehiclespawncontext()
{
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self clientfield::set("sndSwitchVehicleContext", 1);
	}
}

/*
	Name: sndupdatevehiclecontext
	Namespace: audio
	Checksum: 0x3D2761D6
	Offset: 0x868
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function sndupdatevehiclecontext(added)
{
	if(!isdefined(self.sndoccupants))
	{
		self.sndoccupants = 0;
	}
	if(added)
	{
		self.sndoccupants++;
	}
	else
	{
		self.sndoccupants--;
		if(self.sndoccupants < 0)
		{
			self.sndoccupants = 0;
		}
	}
	self clientfield::set("sndSwitchVehicleContext", self.sndoccupants + 1);
}

/*
	Name: playtargetmissilesound
	Namespace: audio
	Checksum: 0x608A763C
	Offset: 0x8F8
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function playtargetmissilesound(alias, looping)
{
	self notify(#"stop_target_missile_sound");
	self endon(#"stop_target_missile_sound", #"disconnect", #"death");
	if(isdefined(alias))
	{
		time = soundgetplaybacktime(alias) * 0.001;
		if(time > 0)
		{
			do
			{
				self playlocalsound(alias);
				wait(time);
			}
			while(looping);
		}
	}
}

/*
	Name: function_9070d441
	Namespace: audio
	Checksum: 0x1A6DD9AB
	Offset: 0x9C0
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_9070d441(params)
{
	/#
		assert(isplayer(self));
	#/
	if(!flag::get("playing_stinger_fired_at_me"))
	{
		self thread playtargetmissilesound(params.weapon.lockontargetlockedsound, params.weapon.lockontargetlockedsoundloops);
		self waittill(#"stinger_fired_at_me", #"missile_unlocked", #"death");
		self notify(#"stop_target_missile_sound");
	}
}

/*
	Name: function_c25f7d1
	Namespace: audio
	Checksum: 0xB5C679FF
	Offset: 0xAA0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_c25f7d1(params)
{
	/#
		assert(isplayer(self));
	#/
	self endon(#"death", #"disconnect");
	self flag::set("playing_stinger_fired_at_me");
	self thread playtargetmissilesound(params.weapon.lockontargetfiredonsound, params.weapon.lockontargetfiredonsoundloops);
	params.projectile waittill(#"projectile_impact_explode", #"death");
	self notify(#"stop_target_missile_sound");
	self flag::clear("playing_stinger_fired_at_me");
}

/*
	Name: unlockfrontendmusic
	Namespace: audio
	Checksum: 0xF33037A6
	Offset: 0xBB8
	Size: 0x24
	Parameters: 2
	Flags: None
*/
function unlockfrontendmusic(unlockname, allplayers = 1)
{
}

/*
	Name: function_30d4f8c4
	Namespace: audio
	Checksum: 0xB907EEBB
	Offset: 0xBE8
	Size: 0x52C
	Parameters: 3
	Flags: None
*/
function function_30d4f8c4(attacker, smeansofdeath, weapon)
{
	if(function_f99d2668())
	{
		self playsoundtoplayer(#"hash_686fcf059a57de6f", self);
		return;
	}
	if(!isdefined(weapon))
	{
		return;
	}
	str_alias = #"hash_6d746e7e1822ad79";
	switch(weapon.rootweapon.name)
	{
		case "hero_annihilator":
		{
			str_alias = #"hash_5e5050d7f9042fac";
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			str_alias = #"hash_191ff361b2a52032";
			break;
		}
		case "hash_23dd6039fe2f36c6":
		{
			str_alias = #"hash_40a5f428bba291a8";
			break;
		}
		case "gadget_radiation_field":
		{
			str_alias = #"hash_16cc324cc4a290fc";
			break;
		}
		case "hash_1d2a1156220e735c":
		{
			str_alias = #"hash_1732b1323f11b7bf";
			break;
		}
		case "sig_lmg":
		{
			str_alias = #"hash_7b92159573aee640";
			break;
		}
		case "sniper_powersemi_t8":
		case "sniper_powerbolt_t8":
		case "sniper_quickscope_t8":
		case "sniper_fastrechamber_t8":
		{
			str_alias = #"hash_9b40eefa77d6446";
			break;
		}
		case "tr_midburst_t8":
		case "ar_damage_t8":
		case "ar_accurate_t8":
		case "smg_capacity_t8":
		case "pistol_burst_t8":
		case "ar_fastfire_t8":
		case "lmg_heavy_t8":
		case "ar_stealth_t8":
		case "tr_longburst_t8":
		case "smg_standard_t8":
		case "lmg_spray_t8":
		case "smg_accurate_t8":
		case "ar_modular_t8":
		case "smg_fastfire_t8":
		case "lmg_standard_t8":
		case "smg_handling_t8":
		{
			str_alias = #"hash_669a22b65807ee3b";
			break;
		}
		case "pistol_standard_t8":
		case "pistol_revolver_t8":
		case "tr_powersemi_t8":
		{
			str_alias = #"hash_2b81ab20b5e3d199";
			break;
		}
		case "shotgun_pump_t8":
		case "shotgun_semiauto_t8":
		{
			str_alias = #"hash_10ba93a0930567c5";
			break;
		}
		case "eq_sticky_grenade":
		{
			str_alias = #"hash_5330d1fc9ae03536";
			break;
		}
		case "eq_cluster_semtex_grenade":
		{
			str_alias = #"hash_58d3e2978f41dc59";
			break;
		}
	}
	switch(smeansofdeath)
	{
		case "mod_trigger_hurt":
		{
			str_alias = #"hash_3f3f94dcb425d73b";
			break;
		}
		case "mod_melee_weapon_butt":
		case "mod_melee_assassinate":
		case "mod_melee":
		{
			if(function_641cec60(weapon))
			{
				str_alias = #"hash_5cd2899685b79029";
			}
			else
			{
				if(weapon.rootweapon.name == "sig_blade")
				{
					str_alias = #"hash_6494570483effef0";
				}
				else
				{
					str_alias = #"hash_3fa09e466fc19e30";
				}
			}
			break;
		}
		case "mod_meta":
		case "mod_suicide":
		{
			str_alias = undefined;
			break;
		}
		case "mod_dot":
		{
			if(weapon.doesfiredamage)
			{
				str_alias = #"hash_40a5f428bba291a8";
				break;
			}
		}
	}
	if(isdefined(str_alias))
	{
		self playsoundtoplayer(str_alias, self);
	}
}

/*
	Name: function_641cec60
	Namespace: audio
	Checksum: 0x9EBC7D9C
	Offset: 0x1120
	Size: 0xB2
	Parameters: 1
	Flags: Linked
*/
function function_641cec60(weapon)
{
	if(!isdefined(weapon))
	{
		return;
	}
	var_80de6af = 0;
	if(weapon.name == #"knife_loadout")
	{
		var_80de6af = 1;
	}
	else if(weapon.name == #"ar_stealth_t8" || weapon.name == #"pistol_standard_t8")
	{
		if(weaponhasattachment(weapon, "uber"))
		{
			var_80de6af = 1;
		}
	}
	return var_80de6af;
}

