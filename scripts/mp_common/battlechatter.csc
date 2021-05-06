// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\dialog_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace battlechatter;

/*
	Name: function_89f2df9
	Namespace: battlechatter
	Checksum: 0xE5AE67F5
	Offset: 0x418
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"battlechatter", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: battlechatter
	Checksum: 0x1F4AA679
	Offset: 0x460
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level.var_2829c23d = &function_50e36ba7;
	level.var_44e74ef4 = &function_f1d27638;
	level.allowbattlechatter[#"bc"] = isdefined(getgametypesetting(#"allowbattlechatter")) && getgametypesetting(#"allowbattlechatter");
	level.allowspecialistdialog = dialog_shared::mpdialog_value("enableHeroDialog", 0) && (isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"]);
	level thread function_4bc12499();
}

/*
	Name: function_b79dc4e7
	Namespace: battlechatter
	Checksum: 0xAF8AA12F
	Offset: 0x580
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function function_b79dc4e7(player)
{
	teammask = getteammask(player.team);
	teamindex = 0;
	while(teammask > 1)
	{
		teammask = teammask >> 1;
		teamindex++;
	}
	if(teamindex % 2)
	{
		return "blops_taacom";
	}
	return "cdp_taacom";
}

/*
	Name: function_4bc12499
	Namespace: battlechatter
	Checksum: 0x13552C9B
	Offset: 0x610
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function function_4bc12499()
{
	level endon(#"death");
	while(true)
	{
		var_7f729179 = undefined;
		var_7f729179 = level waittill(#"play_death_vox");
		players = getlocalplayers();
		player = players[0];
		if(isdefined(player))
		{
			dialogkey = player get_death_vox(var_7f729179.mod, var_7f729179.var_f11eb5f2);
			if(isdefined(dialogkey) && isdefined(var_7f729179.body))
			{
				var_7f729179.body playsound(0, dialogkey);
			}
		}
	}
}

/*
	Name: mpdialog_value
	Namespace: battlechatter
	Checksum: 0xCD3AE2DA
	Offset: 0x710
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function mpdialog_value(mpdialogkey, defaultvalue)
{
	if(!isdefined(mpdialogkey))
	{
		return defaultvalue;
	}
	mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
	if(!isdefined(mpdialog))
	{
		return defaultvalue;
	}
	structvalue = mpdialog.(mpdialogkey);
	if(!isdefined(structvalue))
	{
		return defaultvalue;
	}
	return structvalue;
}

/*
	Name: function_f1d27638
	Namespace: battlechatter
	Checksum: 0x7E721ADF
	Offset: 0x7A0
	Size: 0x142
	Parameters: 1
	Flags: None
*/
function function_f1d27638(var_f7f4481f)
{
	if(!isdefined(var_f7f4481f) || !isdefined(var_f7f4481f.eventid))
	{
		return;
	}
	switch(var_f7f4481f.eventid)
	{
		case 0:
		{
			thread function_50e36ba7(var_f7f4481f.var_40209f44, var_f7f4481f.weapon, var_f7f4481f.var_3d136cd9, var_f7f4481f.var_7e98b410);
			break;
		}
		case 2:
		{
			thread function_ee8935da(var_f7f4481f.var_3d136cd9);
			break;
		}
		case 3:
		case 4:
		case 5:
		{
			thread function_bf569dab(var_f7f4481f.var_40209f44, var_f7f4481f.var_3d136cd9, var_f7f4481f.eventid, var_f7f4481f.weapon);
			break;
		}
	}
}

/*
	Name: get_death_vox
	Namespace: battlechatter
	Checksum: 0x35005870
	Offset: 0x8F0
	Size: 0x256
	Parameters: 2
	Flags: None
*/
function get_death_vox(meansofdeath, var_f11eb5f2)
{
	bundlename = function_361aa16d(var_f11eb5f2);
	if(!isdefined(bundlename))
	{
		return;
	}
	if(isdefined(meansofdeath) && meansofdeath == "MOD_META" && (isdefined(self.pers[#"changed_specialist"]) ? self.pers[#"changed_specialist"] : 0))
	{
		bundlename = self.var_89c4a60f;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(isdefined(meansofdeath))
	{
		switch(meansofdeath)
		{
			case "mod_unknown":
			{
				return playerbundle.exertdeath;
			}
			case "mod_burned":
			{
				if(function_fc261b83())
				{
					return "";
				}
				else
				{
					return playerbundle.exertdeathburned;
				}
			}
			case "mod_melee_weapon_butt":
			{
				return playerbundle.exertdeathstabbed;
			}
			case "mod_head_shot":
			{
				return playerbundle.var_207908de;
			}
			case "mod_falling":
			{
				return playerbundle.var_1dfcabbd;
			}
			case "mod_drown":
			{
				return playerbundle.exertdeathdrowned;
			}
			case "mod_explosive":
			{
				return playerbundle.var_44d86dec;
			}
			case "mod_dot_self":
			{
				return playerbundle.var_48305ed9;
			}
			case "mod_dot":
			{
				return playerbundle.var_f8b4bcc1;
			}
			case "mod_melee_assassinate":
			{
				return playerbundle.exertdeathstabbed;
			}
			case "mod_electrocuted":
			{
				return playerbundle.exertdeathelectrocuted;
			}
		}
	}
	return playerbundle.exertdeath;
}

/*
	Name: function_d804d2f0
	Namespace: battlechatter
	Checksum: 0xEB82A991
	Offset: 0xB50
	Size: 0x192
	Parameters: 4
	Flags: None
*/
function function_d804d2f0(localclientnum, var_70b80ca6, player, allyradiussq)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(!isdefined(player.origin))
	{
		return 0;
	}
	if(!isalive(player))
	{
		return 0;
	}
	if(player underwater())
	{
		return 0;
	}
	if(player isdriving(localclientnum))
	{
		return 0;
	}
	if(function_e75c64a4(localclientnum))
	{
		return 0;
	}
	if(!isdefined(var_70b80ca6))
	{
		return 0;
	}
	if(!isdefined(var_70b80ca6.origin))
	{
		return 0;
	}
	if(player == var_70b80ca6 || player.team != var_70b80ca6.team)
	{
		return 0;
	}
	if(player function_715f2ffc(var_70b80ca6))
	{
		return 0;
	}
	if(player hasperk(localclientnum, "specialty_quieter"))
	{
		return 0;
	}
	distsq = distancesquared(var_70b80ca6.origin, player.origin);
	if(distsq > allyradiussq)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_db89c38f
	Namespace: battlechatter
	Checksum: 0x4630B0EC
	Offset: 0xCF0
	Size: 0x114
	Parameters: 3
	Flags: None
*/
function function_db89c38f(localclientnum, var_70b80ca6, allyradiussq)
{
	allies = [];
	foreach(player in getplayers(localclientnum))
	{
		if(!function_d804d2f0(localclientnum, var_70b80ca6, player, allyradiussq))
		{
			continue;
		}
		allies[allies.size] = player;
	}
	allies = arraysort(allies, var_70b80ca6.origin);
	if(!isdefined(allies) || allies.size == 0)
	{
		return undefined;
	}
	return allies[0];
}

/*
	Name: function_d2f35e13
	Namespace: battlechatter
	Checksum: 0xA22C03F5
	Offset: 0xE10
	Size: 0x1EC
	Parameters: 6
	Flags: None
*/
function function_d2f35e13(localclientnum, var_c1a2172e, weapon, var_6ac148bc, var_5d738b56, seed)
{
	while(isdefined(var_6ac148bc) && soundplaying(var_6ac148bc))
	{
		waitframe(1);
	}
	wait(0.4);
	if(!isdefined(var_c1a2172e))
	{
		return;
	}
	successreactionradius = mpdialog_value("SuccessReactionRadius", 500);
	if(function_506f762f(weapon) && isdefined(var_5d738b56) && isplayer(var_5d738b56))
	{
		if(function_d804d2f0(localclientnum, var_c1a2172e, var_5d738b56, successreactionradius * successreactionradius))
		{
			var_8a6b001a = var_5d738b56;
		}
	}
	else
	{
		var_8a6b001a = function_db89c38f(localclientnum, var_c1a2172e, successreactionradius * successreactionradius);
	}
	if(!isdefined(var_8a6b001a))
	{
		return;
	}
	bundlename = var_8a6b001a getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	var_81485093 = function_6bb302ba(weapon, playerbundle);
	if(!isdefined(var_81485093))
	{
		return;
	}
	var_8a6b001a function_4b126e4c(localclientnum, var_81485093, seed);
}

/*
	Name: function_20edb636
	Namespace: battlechatter
	Checksum: 0xC0062C72
	Offset: 0x1008
	Size: 0x6F2
	Parameters: 2
	Flags: None
*/
function function_20edb636(weapon, playerbundle)
{
	var_7f8fdcd6 = spawnstruct();
	switch(weapon.name)
	{
		case "hero_annihilator":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.annihilatorweaponsuccess;
			break;
		}
		case "sig_buckler_dw":
		case "sig_buckler_turret":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_b8e59ed0;
			var_7f8fdcd6.startdelay = mpdialog_value("battleshieldSuccessDialogBuffer", 0);
			break;
		}
		case "claymore":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_b4d5ca8f;
			break;
		}
		case "dog_ai_defaultmelee":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_67888352;
			var_7f8fdcd6.startdelay = playerbundle.var_aaf0d901;
			break;
		}
		case "hero_flamethrower":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.purifierweaponsuccess;
			var_7f8fdcd6.startdelay = playerbundle.var_f88f40a;
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_d1c8dc4;
			break;
		}
		case "gun_mini_turret":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_3755ba19;
			break;
		}
		case "hash_40380537847df901":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.sparrowweaponsuccess;
			break;
		}
		case "hash_5a4932f4b8d8b37a":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_dc2e66f;
			break;
		}
		case "shock_rifle":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.tempestweaponsuccess;
			break;
		}
		case "eq_tripwire":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_eb8b9d7a;
			break;
		}
		case "hero_pineapplegun":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.warmachineweaponsuccess;
			var_7f8fdcd6.startdelay = mpdialog_value("pineappleGunSuccessDialogBuffer", 0);
			break;
		}
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_febcf0b;
			break;
		}
		case "eq_concertina_wire":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_d5983ddb;
			break;
		}
		case "eq_swat_grenade":
		case "hash_3f62a872201cd1ce":
		case "hash_5825488ac68418af":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_bd81e586;
			var_7f8fdcd6.startdelay = mpdialog_value("nineBangSuccessDialogBuffer", 0);
			break;
		}
		case "hash_3a19c6a9c8caef33":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_390929f1;
			break;
		}
		case "hash_23dd6039fe2f36c6":
		case "eq_molotov":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_e64f9f9a;
			var_7f8fdcd6.startdelay = mpdialog_value("playerDialogBuffer", 0);
			break;
		}
		case "gadget_radiation_field":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_ad1379f5;
			var_7f8fdcd6.startdelay = mpdialog_value("radiationFieldPodSuccessDialogBuffer", 0);
			break;
		}
		case "eq_sensor":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_ef10cbc3;
			break;
		}
		case "gadget_supplypod":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_383d5df3;
			var_7f8fdcd6.startdelay = mpdialog_value("supplyPodSuccessDialogBuffer", 0);
			break;
		}
		case "gadget_vision_pulse":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.visionpulseabilitysuccess;
			break;
		}
		case "eq_localheal":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_74dd2839;
			break;
		}
		case "gadget_icepick":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_e870e40c;
			break;
		}
		case "eq_hawk":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_bcaf7574;
			var_7f8fdcd6.startdelay = 1;
			break;
		}
		case "sig_blade":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_eb02a29a;
			break;
		}
		case "eq_smoke":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_c6ad4957;
			break;
		}
		case "sig_lmg":
		case "hash_772f4afd37e876a1":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.scytheweaponsuccess;
			break;
		}
		case "hash_f525ab9cc66c061":
		{
			var_7f8fdcd6.var_17a094cf = playerbundle.var_be9a9d3f;
			break;
		}
		default:
		{
			break;
		}
	}
	if(!isdefined(var_7f8fdcd6.startdelay))
	{
		var_7f8fdcd6.startdelay = mpdialog_value("defaultSuccessResponseBuffer", 0);
	}
	return var_7f8fdcd6;
}

/*
	Name: function_6bb302ba
	Namespace: battlechatter
	Checksum: 0xEC275AC6
	Offset: 0x1708
	Size: 0x3A6
	Parameters: 2
	Flags: None
*/
function function_6bb302ba(weapon, playerbundle)
{
	switch(weapon.name)
	{
		case "hero_annihilator":
		{
			var_cf38843b = playerbundle.var_fc5812eb;
			break;
		}
		case "sig_buckler_dw":
		case "sig_buckler_turret":
		{
			var_cf38843b = playerbundle.var_4fa3c4aa;
			break;
		}
		case "dog_ai_defaultmelee":
		{
			var_cf38843b = playerbundle.var_4ea15dd3;
			break;
		}
		case "hero_flamethrower":
		{
			var_cf38843b = playerbundle.var_772dbd73;
			break;
		}
		case "hash_4bb2d7f789b561eb":
		{
			var_cf38843b = playerbundle.var_3e1a4fb8;
			break;
		}
		case "gun_mini_turret":
		{
			var_cf38843b = playerbundle.var_dbd1897a;
			break;
		}
		case "hash_1d2a1256220e750f":
		{
			var_cf38843b = playerbundle.var_3841aa5a;
			break;
		}
		case "hash_5a4932f4b8d8b37a":
		{
			var_cf38843b = playerbundle.var_c518a57;
			break;
		}
		case "shock_rifle":
		case "hero_lightninggun":
		{
			var_cf38843b = playerbundle.var_c7859303;
			break;
		}
		case "eq_tripwire":
		{
			var_cf38843b = playerbundle.var_23b68936;
			break;
		}
		case "hero_pineapplegun":
		{
			var_cf38843b = playerbundle.var_bbf7c71f;
			break;
		}
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			var_cf38843b = playerbundle.var_26d4d8b3;
			break;
		}
		case "eq_concertina_wire":
		{
			var_cf38843b = playerbundle.var_54475e1e;
			break;
		}
		case "gadget_radiation_field":
		{
			var_cf38843b = playerbundle.var_f613c4d1;
			break;
		}
		case "eq_sensor":
		{
			var_cf38843b = playerbundle.var_f3b38bf6;
			break;
		}
		case "gadget_supplypod":
		{
			var_cf38843b = playerbundle.var_54c097dc;
			break;
		}
		case "gadget_vision_pulse":
		{
			var_cf38843b = playerbundle.var_cf906c68;
			break;
		}
		case "eq_localheal":
		{
			var_cf38843b = playerbundle.var_d32aca42;
			break;
		}
		case "hash_23dd6039fe2f36c6":
		case "eq_molotov":
		{
			var_cf38843b = playerbundle.var_140be686;
			break;
		}
		case "gadget_icepick":
		{
			var_cf38843b = playerbundle.var_c62c0c00;
			break;
		}
		case "sig_blade":
		{
			var_cf38843b = playerbundle.var_c5a434fd;
			break;
		}
		case "eq_smoke":
		{
			var_cf38843b = playerbundle.var_568ad856;
			break;
		}
		default:
		{
			break;
		}
	}
	return var_cf38843b;
}

/*
	Name: function_506f762f
	Namespace: battlechatter
	Checksum: 0xB37E5E9C
	Offset: 0x1AB8
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_506f762f(weapon)
{
	switch(weapon.name)
	{
		case "gadget_supplypod":
		case "eq_localheal":
		case "hash_52aca7c35be649b8":
		case "gadget_cleanse":
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_50e36ba7
	Namespace: battlechatter
	Checksum: 0x3E7795A7
	Offset: 0x1B30
	Size: 0x18C
	Parameters: 4
	Flags: None
*/
function function_50e36ba7(attacker, weapon, var_5d738b56, seed)
{
	if(!isdefined(attacker) || !isplayer(attacker))
	{
		return;
	}
	bundlename = attacker getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	var_39344278 = function_20edb636(weapon, playerbundle);
	if(!isdefined(var_39344278))
	{
		return;
	}
	wait(var_39344278.startdelay);
	if(!isdefined(var_39344278) || !isdefined(var_39344278.var_17a094cf) || !isdefined(attacker) || !isplayer(attacker))
	{
		return;
	}
	var_a874c58 = attacker function_4b126e4c(0, var_39344278.var_17a094cf, seed);
	if(!isdefined(var_a874c58))
	{
		return;
	}
	thread function_d2f35e13(0, attacker, weapon, var_a874c58, var_5d738b56, seed);
}

/*
	Name: function_5d7ad9a9
	Namespace: battlechatter
	Checksum: 0xF35793A6
	Offset: 0x1CC8
	Size: 0x9A
	Parameters: 2
	Flags: None
*/
function function_5d7ad9a9(hacker, originalowner)
{
	if(!isdefined(originalowner) || !isplayer(originalowner) || !originalowner function_21c0fa55())
	{
		return 0;
	}
	if(!isdefined(hacker) || !isplayer(hacker) || !isalive(hacker))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c8663dbc
	Namespace: battlechatter
	Checksum: 0x6DC4B86F
	Offset: 0x1D70
	Size: 0x49A
	Parameters: 2
	Flags: None
*/
function function_c8663dbc(weapon, player)
{
	taacombundle = function_84eb6127(player);
	if(!isdefined(taacombundle))
	{
		return undefined;
	}
	switch(weapon.name)
	{
		case "hash_21b346649d376bf3":
		{
			var_60d3002f = "jammerWeaponHacked";
			break;
		}
		case "eq_tripwire":
		{
			var_60d3002f = "meshMineWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "hash_4a4ba36128b6582f":
		{
			var_60d3002f = "seekerMineWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "eq_sensor":
		{
			var_60d3002f = "sensorDartHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "ability_smart_cover":
		case "hash_1fb0b26684caee0f":
		{
			var_60d3002f = "smartCoverHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "gadget_spawnbeacon":
		{
			var_60d3002f = "spawnBeaconHacked";
			break;
		}
		case "gadget_supplypod":
		{
			var_60d3002f = "supplyPodHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "trophy_system":
		{
			var_60d3002f = "trophyWeaponHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "hash_459c0007ec5e2470":
		case "ac130":
		{
			var_60d3002f = "ac130Hacked";
			break;
		}
		case "tank_robot":
		case "inventory_tank_robot":
		case "ai_tank_marker":
		{
			var_60d3002f = "aiTankHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "cobra_20mm_comlink":
		case "helicopter_comlink":
		case "inventory_helicopter_comlink":
		{
			var_60d3002f = "attackChopperHacked";
			break;
		}
		case "counteruav":
		{
			var_60d3002f = "cuavHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "dart":
		case "inventory_dart":
		{
			var_60d3002f = "dartHacked";
			break;
		}
		case "drone_squadron":
		case "hash_3447a6457d26a42e":
		{
			var_60d3002f = "droneSquadHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "recon_car":
		case "inventory_recon_car":
		{
			var_60d3002f = "reconCarHacked";
			break;
		}
		case "remote_missile":
		case "inventory_remote_missile":
		{
			var_60d3002f = "hellstormHacked";
			break;
		}
		case "inventory_planemortar":
		case "planemortar":
		{
			var_60d3002f = "lightningStrikeHacked";
			break;
		}
		case "overwatch_helicopter":
		case "hash_74ea4af18853e9af":
		{
			var_60d3002f = "overwatchHelicopterHacked";
			break;
		}
		case "hash_4307d5aaa7ce21d4":
		case "straferun":
		{
			var_60d3002f = "strafeRunHacked";
			break;
		}
		case "supplydrop":
		{
			var_60d3002f = "supplyDropHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "uav":
		{
			var_60d3002f = "uavHacked";
			var_b3fe42a9 = 1;
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			var_60d3002f = "sentryHacked";
			var_b3fe42a9 = 1;
			break;
		}
	}
	if(!isdefined(var_60d3002f))
	{
		return undefined;
	}
	dialogalias = taacombundle.(var_60d3002f);
	return dialogalias;
}

/*
	Name: function_84eb6127
	Namespace: battlechatter
	Checksum: 0x7D109321
	Offset: 0x2218
	Size: 0x3A
	Parameters: 1
	Flags: None
*/
function function_84eb6127(player)
{
	return struct::get_script_bundle("mpdialog_taacom", function_b79dc4e7(player));
}

/*
	Name: function_bf569dab
	Namespace: battlechatter
	Checksum: 0xB5490790
	Offset: 0x2260
	Size: 0x1CC
	Parameters: 4
	Flags: None
*/
function function_bf569dab(hacker, originalowner, eventid, weapon)
{
	if(!function_5d7ad9a9(hacker, originalowner))
	{
		return;
	}
	var_a8aa2745 = function_c8663dbc(weapon, originalowner);
	if(!isdefined(var_a8aa2745))
	{
		return;
	}
	var_6ae4c5af = playsound(0, var_a8aa2745);
	if(!isdefined(var_6ae4c5af))
	{
		return;
	}
	while(isdefined(var_6ae4c5af) && soundplaying(var_6ae4c5af))
	{
		waitframe(1);
	}
	wait(0.1);
	if(!function_5d7ad9a9(hacker, originalowner))
	{
		return;
	}
	bundlename = hacker getmpdialogname();
	if(!isdefined(bundlename))
	{
		return;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return;
	}
	if(eventid === 3)
	{
		var_2131493 = playerbundle.var_489ef66b;
	}
	else if(eventid === 4)
	{
		var_2131493 = playerbundle.var_5545b3a1;
	}
	else if(eventid === 5)
	{
		var_2131493 = playerbundle.var_1037850d;
	}
	if(!isdefined(var_2131493))
	{
		return;
	}
	originalowner playsound(0, var_2131493);
}

/*
	Name: function_ee8935da
	Namespace: battlechatter
	Checksum: 0xF17C469
	Offset: 0x2438
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function function_ee8935da(player)
{
	if(function_fc261b83())
	{
		return;
	}
	commander = "blops_commander";
	if(player.team === #"axis")
	{
		commander = "cdp_commander";
	}
	commanderbundle = struct::get_script_bundle("mpdialog_commander", commander);
	if(!isdefined(commanderbundle) || !isdefined("gamePlayerKicked"))
	{
		return;
	}
	dialogalias = commanderbundle.("gamePlayerKicked");
	if(!isdefined(dialogalias))
	{
		return;
	}
	voiceprefix = commanderbundle.("voiceprefix");
	if(isdefined(voiceprefix))
	{
		dialogalias = voiceprefix + dialogalias;
	}
	if(isdefined(dialogalias))
	{
		player playsound(0, dialogalias);
	}
}

