// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_383a3b1bb18ba876;
#using script_47fb62300ac0bd60;
#using script_4a03c204316cf33;
#using script_545a0bac37bda541;
#using script_56ca01b3b31455b5;
#using script_57c900a7e39234be;
#using script_5a63672f07149a55;
#using script_68d2ee1489345a1d;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\dialog_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\loadout_shared.gsc;
#using scripts\core_common\placeables.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace killstreaks;

/*
	Name: init_shared
	Namespace: killstreaks
	Checksum: 0x1FBD8B0E
	Offset: 0x660
	Size: 0x22C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.killstreaks = [];
	level.killstreakweapons = [];
	level.var_8997324c = [];
	level.droplocations = [];
	level.zoffsetcounter = 0;
	level.var_46c23c0f = 0;
	clientfield::register("clientuimodel", "locSel.commandMode", 1, 1, "int");
	clientfield::register("clientuimodel", "locSel.snapTo", 1, 1, "int");
	clientfield::register("vehicle", "timeout_beep", 1, 2, "int");
	clientfield::register("toplayer", "thermal_glow", 1, 1, "int");
	clientfield::register("toplayer", "thermal_glow_enemies_only", 12000, 1, "int");
	level.play_killstreak_firewall_being_hacked_dialog = undefined;
	level.play_killstreak_firewall_hacked_dialog = undefined;
	level.play_killstreak_being_hacked_dialog = undefined;
	level.play_killstreak_hacked_dialog = undefined;
	level.play_pilot_dialog_on_owner = undefined;
	level.play_pilot_dialog = undefined;
	level.play_taacom_dialog_response_on_owner = undefined;
	level.play_taacom_dialog = undefined;
	level.var_514f9d20 = undefined;
	level.var_9f8e080d = undefined;
	level.var_19a15e42 = undefined;
	level.var_239dc073 = getweapon(#"killstreak_remote");
	if(!isdefined(level.var_6cfbe5a))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_6cfbe5a = object;
		[[ level.var_6cfbe5a ]]->initialize(1, 0.1);
	}
}

/*
	Name: function_447e6858
	Namespace: killstreaks
	Checksum: 0x4AEF68A2
	Offset: 0x898
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function function_447e6858()
{
	level.numkillstreakreservedobjectives = 0;
	level.killstreakcounter = 0;
	if(!isdefined(level.roundstartkillstreakdelay))
	{
		level.roundstartkillstreakdelay = 0;
	}
	level.iskillstreakweapon = &is_killstreak_weapon;
	level.killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
	callback::on_spawned(&on_player_spawned);
	callback::on_joined_team(&on_joined_team);
	level.var_d80e834 = &function_da600615;
}

/*
	Name: function_da600615
	Namespace: killstreaks
	Checksum: 0x10698EE5
	Offset: 0x978
	Size: 0xE0
	Parameters: 1
	Flags: None
*/
function function_da600615(bot)
{
	weapons = bot getweaponslist();
	foreach(weapon in weapons)
	{
		if(is_killstreak_weapon(weapon))
		{
			killstreak = get_killstreak_for_weapon(weapon);
			bot thread usekillstreak(killstreak, 0);
		}
	}
}

/*
	Name: function_b5b6ef3e
	Namespace: killstreaks
	Checksum: 0xC8866853
	Offset: 0xA60
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b5b6ef3e(func, obj)
{
	callback::add_callback(#"hash_45f35669076bc317", func, obj);
}

/*
	Name: function_f83b20be
	Namespace: killstreaks
	Checksum: 0xC287955A
	Offset: 0xAA8
	Size: 0x18E
	Parameters: 2
	Flags: None
*/
function function_f83b20be(killstreak_type, var_1624ed59)
{
	/#
		assert(isdefined(level.killstreaks[killstreak_type]), "");
	#/
	item_index = getitemindexfromref(var_1624ed59);
	killstreak_info = getunlockableiteminfofromindex(item_index, 0);
	var_ccab2c89 = 0;
	if(isdefined(killstreak_info))
	{
		var_ccab2c89 = killstreak_info.momentum;
	}
	level.killstreaks[killstreak_type].itemindex = item_index;
	level.killstreaks[killstreak_type].momentumcost = var_ccab2c89;
	level.killstreaks[killstreak_type].menuname = var_1624ed59;
	level.killstreaks[killstreak_type].uiname = "";
	/#
		if(isdefined(killstreak_info))
		{
			level.killstreaks[killstreak_type].uiname = killstreak_info.displayname;
		}
		if(level.killstreaks[killstreak_type].uiname == "")
		{
			level.killstreaks[killstreak_type].uiname = var_1624ed59;
		}
	#/
}

/*
	Name: killstreak_init
	Namespace: killstreaks
	Checksum: 0x448731D8
	Offset: 0xC40
	Size: 0x13A
	Parameters: 1
	Flags: None
*/
function killstreak_init(killstreak_type)
{
	/#
		assert(isdefined(killstreak_type), "");
	#/
	/#
		assert(!isdefined(level.killstreaks[killstreak_type]), "" + killstreak_type + "");
	#/
	level.killstreaks[killstreak_type] = spawnstruct();
	level.killstreaks[killstreak_type].killstreaklevel = 0;
	level.killstreaks[killstreak_type].quantity = 0;
	level.killstreaks[killstreak_type].allowassists = 0;
	level.killstreaks[killstreak_type].overrideentitycameraindemo = 0;
	level.killstreaks[killstreak_type].teamkillpenaltyscale = 1;
	level.killstreaks[killstreak_type].var_b6c17aab = 0;
}

/*
	Name: register_weapon
	Namespace: killstreaks
	Checksum: 0x2FE1AB23
	Offset: 0xD88
	Size: 0xEA
	Parameters: 2
	Flags: None
*/
function register_weapon(killstreak_type, weapon)
{
	if(weapon.name == #"none")
	{
		return;
	}
	/#
		assert(isdefined(killstreak_type), "");
	#/
	/#
		assert(weapon.name != #"none");
	#/
	/#
		assert(!isdefined(level.killstreakweapons[weapon]), "");
	#/
	level.killstreaks[killstreak_type].weapon = weapon;
	level.killstreakweapons[weapon] = killstreak_type;
}

/*
	Name: register_vehicle
	Namespace: killstreaks
	Checksum: 0x55EBC4C8
	Offset: 0xE80
	Size: 0x9A
	Parameters: 2
	Flags: None
*/
function register_vehicle(killstreak_type, vehicle)
{
	/#
		assert(isdefined(killstreak_type), "");
	#/
	/#
		assert(!isdefined(level.var_8997324c[vehicle]), "");
	#/
	level.killstreaks[killstreak_type].vehicle = vehicle;
	level.var_8997324c[vehicle] = killstreak_type;
}

/*
	Name: register
	Namespace: killstreaks
	Checksum: 0xD9388809
	Offset: 0xF28
	Size: 0x284
	Parameters: 10
	Flags: None
*/
function register(killstreaktype, killstreakweaponname, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed = 0, killstreakstatsname = undefined, registerdvars = 1, registerinventory = 1)
{
	/#
		assert(isdefined(killstreakusefunction), "" + killstreaktype);
	#/
	killstreak_init(killstreaktype);
	function_f83b20be(killstreaktype, killstreakmenuname);
	level.killstreaks[killstreaktype].usagekey = killstreakusagekey;
	level.killstreaks[killstreaktype].usefunction = killstreakusefunction;
	level.killstreaks[killstreaktype].delaystreak = killstreakdelaystreak;
	if(isdefined(killstreakweaponname))
	{
		killstreakweapon = getweapon(killstreakweaponname);
		register_weapon(killstreaktype, killstreakweapon);
	}
	if(isdefined(killstreakstatsname))
	{
		level.killstreaks[killstreaktype].killstreakstatsname = killstreakstatsname;
	}
	level.killstreaks[killstreaktype].weaponholdallowed = weaponholdallowed;
	if(isdefined(registerinventory) && registerinventory)
	{
		level.menureferenceforkillstreak[killstreakmenuname] = killstreaktype;
		bundlename = function_656f23d5(killstreaktype);
		killstreak_bundles::register_killstreak_bundle(bundlename);
		var_28f0acc5 = undefined;
		if(isdefined(killstreakweaponname))
		{
			var_28f0acc5 = "inventory_" + killstreakweaponname;
		}
		register("inventory_" + killstreaktype, var_28f0acc5, killstreakmenuname, killstreakusagekey, killstreakusefunction, killstreakdelaystreak, weaponholdallowed, killstreakstatsname, 0, 0);
	}
}

/*
	Name: function_656f23d5
	Namespace: killstreaks
	Checksum: 0x18B7EEB4
	Offset: 0x11B8
	Size: 0x46
	Parameters: 1
	Flags: Private
*/
private function function_656f23d5(killstreaktype)
{
	if(killstreaktype === "drone_squadron")
	{
		if(sessionmodeiscampaigngame())
		{
			return "drone_squadron" + "_cp";
		}
	}
	return killstreaktype;
}

/*
	Name: function_e48aca4d
	Namespace: killstreaks
	Checksum: 0x9E86985D
	Offset: 0x1208
	Size: 0x624
	Parameters: 6
	Flags: Private
*/
private function function_e48aca4d(type, bundle, weapon, vehicle, var_c0a31091, isinventoryweapon)
{
	killstreak_init(type);
	menukey = bundle.var_a99ef6da;
	if(!isdefined(menukey))
	{
		menukey = type;
	}
	else if(isdefined(isinventoryweapon) && isinventoryweapon)
	{
		menukey = "inventory_" + menukey;
	}
	function_f83b20be(type, menukey);
	level.killstreaks[type].usagekey = type;
	level.killstreaks[type].delaystreak = bundle.var_daf6b7af;
	level.killstreaks[type].usefunction = var_c0a31091;
	level.killstreaks[type].weaponholdallowed = 0;
	register_weapon(type, weapon);
	level.menureferenceforkillstreak[menukey] = type;
	if(isdefined(bundle.altweapons))
	{
		foreach(alt_weapon in bundle.altweapons)
		{
			function_181f96a6(type, alt_weapon.var_359445cd);
		}
	}
	if(isdefined(vehicle))
	{
		register_vehicle(type, vehicle);
	}
	loc_0000143A:
	function_7e46eaea(type, bundle.var_b45be9e6, bundle.var_502a0e23, bundle.var_667c638e, bundle.var_a56710c6, bundle.var_bc2f6af9, bundle.var_6417048f, (isdefined(bundle.var_65d707d0) ? bundle.var_65d707d0 : 0), (isdefined(bundle.var_a9b0c301) ? bundle.var_a9b0c301 : 0));
	level.killstreaks[type].var_4a5906fd = bundle.var_3211a185;
	if(isdefined(level.cratetypes))
	{
		if(isdefined(isinventoryweapon) && isinventoryweapon)
		{
			if(isdefined(level.cratetypes[#"inventory_supplydrop"]) && isdefined(level.cratetypes[#"inventory_supplydrop"][type]))
			{
				level.cratetypes[#"inventory_supplydrop"][type].hint = bundle.var_1d2a2ca4;
				level.cratetypes[#"inventory_supplydrop"][type].hint_gambler = bundle.var_8c4d7906;
			}
		}
		else if(isdefined(level.cratetypes[#"supplydrop"]) && isdefined(level.cratetypes[#"supplydrop"][type]))
		{
			level.cratetypes[#"supplydrop"][type].hint = bundle.var_1d2a2ca4;
			level.cratetypes[#"supplydrop"][type].hint_gambler = bundle.var_8c4d7906;
			game.strings[type + "_hint"] = bundle.var_1d2a2ca4;
		}
		if(isdefined(level.cratetypes[#"gambler"]) && isdefined(level.cratetypes[#"gambler"][type]))
		{
			level.cratetypes[#"gambler"][type].hint = bundle.var_1d2a2ca4;
			level.cratetypes[#"gambler"][type].hint_gambler = bundle.var_8c4d7906;
		}
	}
	function_1110a5de(type, bundle.var_5fbfc70d, bundle.var_e7b30a9a, bundle.var_b7bd2ff9, bundle.var_f6042a3, bundle.var_2451b1f2, bundle.var_7742570a, bundle.var_335def6c, bundle.var_7a502c34, bundle.var_e773a429, bundle.var_799a81a7, bundle.var_f5871fe4, bundle.var_bd7786a4);
	level.killstreaks[type].script_bundle = bundle;
	killstreak_bundles::function_25ce781d(type, bundle);
	if(isdefined(bundle.var_1bc9830d) && bundle.var_1bc9830d && (!(isdefined(isinventoryweapon) && isinventoryweapon)))
	{
		register_dev_dvars(type);
	}
}

/*
	Name: function_25ce781d
	Namespace: killstreaks
	Checksum: 0x8CD61EBB
	Offset: 0x1838
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function function_25ce781d(bundle, var_c0a31091)
{
	function_e48aca4d(bundle.var_d3413870, bundle, bundle.var_1ab696c6, bundle.ksvehicle, var_c0a31091, 0);
	if(isdefined(bundle.var_fc0c8eae) && bundle.var_fc0c8eae.name != #"none")
	{
		function_e48aca4d("inventory_" + bundle.var_d3413870, bundle, bundle.var_fc0c8eae, undefined, var_c0a31091, 1);
	}
}

/*
	Name: function_e4ef8390
	Namespace: killstreaks
	Checksum: 0xB7B90E2C
	Offset: 0x1910
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_e4ef8390(bundlename, var_832677ec)
{
	bundle = struct::get_script_bundle("killstreak", bundlename);
	function_25ce781d(bundle, var_832677ec);
}

/*
	Name: is_registered
	Namespace: killstreaks
	Checksum: 0xA2867BF1
	Offset: 0x1968
	Size: 0x1E
	Parameters: 1
	Flags: None
*/
function is_registered(killstreaktype)
{
	return isdefined(level.killstreaks[killstreaktype]);
}

/*
	Name: function_7e46eaea
	Namespace: killstreaks
	Checksum: 0xF84173DD
	Offset: 0x1990
	Size: 0x17E
	Parameters: 9
	Flags: None
*/
function function_7e46eaea(killstreaktype, receivedtext, notusabletext, inboundtext, inboundnearplayertext, var_43279ec9, hackedtext, utilizesairspace, var_a4a7d3e7)
{
	/#
		assert(isdefined(killstreaktype), "");
	#/
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	level.killstreaks[killstreaktype].receivedtext = receivedtext;
	level.killstreaks[killstreaktype].notavailabletext = notusabletext;
	level.killstreaks[killstreaktype].inboundtext = inboundtext;
	level.killstreaks[killstreaktype].var_43279ec9 = var_43279ec9;
	level.killstreaks[killstreaktype].inboundnearplayertext = inboundnearplayertext;
	level.killstreaks[killstreaktype].hackedtext = hackedtext;
	level.killstreaks[killstreaktype].utilizesairspace = utilizesairspace;
	level.killstreaks[killstreaktype].var_a4a7d3e7 = var_a4a7d3e7;
}

/*
	Name: function_1110a5de
	Namespace: killstreaks
	Checksum: 0x5656707B
	Offset: 0x1B18
	Size: 0x346
	Parameters: 13
	Flags: None
*/
function function_1110a5de(killstreaktype, informdialog, taacomdialogbundlekey, pilotdialogarraykey, startdialogkey, enemystartdialogkey, enemystartmultipledialogkey, hackeddialogkey, hackedstartdialogkey, requestdialogkey, threatdialogkey, var_3b69c05b, var_2729ed45)
{
	/#
		assert(isdefined(killstreaktype), "");
	#/
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	level.killstreaks[killstreaktype].informdialog = informdialog;
	level.killstreaks[killstreaktype].taacomdialogbundlekey = taacomdialogbundlekey;
	level.killstreaks[killstreaktype].startdialogkey = startdialogkey;
	level.killstreaks[killstreaktype].enemystartdialogkey = enemystartdialogkey;
	level.killstreaks[killstreaktype].enemystartmultipledialogkey = enemystartmultipledialogkey;
	level.killstreaks[killstreaktype].hackeddialogkey = hackeddialogkey;
	level.killstreaks[killstreaktype].hackedstartdialogkey = hackedstartdialogkey;
	level.killstreaks[killstreaktype].var_2729ed45 = var_2729ed45;
	level.killstreaks[killstreaktype].requestdialogkey = requestdialogkey;
	level.killstreaks[killstreaktype].var_3b69c05b = var_3b69c05b;
	level.killstreaks[killstreaktype].threatdialogkey = threatdialogkey;
	if(isdefined(pilotdialogarraykey))
	{
		taacombundles = struct::get_script_bundles("mpdialog_taacom");
		foreach(bundle in taacombundles)
		{
			if(!isdefined(bundle.pilotbundles))
			{
				bundle.pilotbundles = [];
			}
			bundle.pilotbundles[killstreaktype] = [];
			i = 0;
			field = pilotdialogarraykey + i;
			fieldvalue = bundle.(field);
			while(isdefined(fieldvalue))
			{
				bundle.pilotbundles[killstreaktype][i] = fieldvalue;
				i++;
				field = pilotdialogarraykey + i;
				fieldvalue = bundle.(field);
			}
		}
		level.tacombundles = taacombundles;
	}
}

/*
	Name: function_181f96a6
	Namespace: killstreaks
	Checksum: 0x69ACDAF7
	Offset: 0x1E68
	Size: 0x13A
	Parameters: 2
	Flags: None
*/
function function_181f96a6(killstreaktype, weapon)
{
	/#
		assert(isdefined(killstreaktype), "");
	#/
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	if(weapon.name == #"none")
	{
		return;
	}
	if(level.killstreaks[killstreaktype].weapon === weapon)
	{
		return;
	}
	if(!isdefined(level.killstreaks[killstreaktype].altweapons))
	{
		level.killstreaks[killstreaktype].altweapons = [];
	}
	if(!isdefined(level.killstreakweapons[weapon]))
	{
		level.killstreakweapons[weapon] = killstreaktype;
	}
	level.killstreaks[killstreaktype].altweapons[level.killstreaks[killstreaktype].altweapons.size] = weapon;
}

/*
	Name: register_alt_weapon
	Namespace: killstreaks
	Checksum: 0x236DB43C
	Offset: 0x1FB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register_alt_weapon(killstreaktype, weapon)
{
	function_181f96a6(killstreaktype, weapon);
	function_181f96a6("inventory_" + killstreaktype, weapon);
}

/*
	Name: function_e37b061
	Namespace: killstreaks
	Checksum: 0xD7E73783
	Offset: 0x2008
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_e37b061(killstreaktype, weapon)
{
	function_181f96a6(killstreaktype, weapon);
}

/*
	Name: function_b013c2d3
	Namespace: killstreaks
	Checksum: 0xB96B3C92
	Offset: 0x2040
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_b013c2d3(killstreaktype, weapon)
{
	if(!isdefined(level.var_3ff1b984))
	{
		level.var_3ff1b984 = [];
	}
	level.var_3ff1b984[weapon] = killstreaktype;
}

/*
	Name: register_remote_override_weapon
	Namespace: killstreaks
	Checksum: 0x6F845769
	Offset: 0x2098
	Size: 0x146
	Parameters: 3
	Flags: None
*/
function register_remote_override_weapon(killstreaktype, weaponname, isinventory)
{
	/#
		assert(isdefined(killstreaktype), "");
	#/
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	weapon = getweapon(weaponname);
	if(level.killstreaks[killstreaktype].weapon === weapon)
	{
		return;
	}
	if(!isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons))
	{
		level.killstreaks[killstreaktype].remoteoverrideweapons = [];
	}
	if(!isdefined(level.killstreakweapons[weapon]))
	{
		level.killstreakweapons[weapon] = killstreaktype;
	}
	level.killstreaks[killstreaktype].remoteoverrideweapons[level.killstreaks[killstreaktype].remoteoverrideweapons.size] = weapon;
}

/*
	Name: is_remote_override_weapon
	Namespace: killstreaks
	Checksum: 0xFD3EE148
	Offset: 0x21E8
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function is_remote_override_weapon(killstreaktype, weapon)
{
	if(isdefined(level.killstreaks[killstreaktype].remoteoverrideweapons))
	{
		for(i = 0; i < level.killstreaks[killstreaktype].remoteoverrideweapons.size; i++)
		{
			if(level.killstreaks[killstreaktype].remoteoverrideweapons[i] == weapon)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: register_dev_dvars
	Namespace: killstreaks
	Checksum: 0xE3EED71
	Offset: 0x2288
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function register_dev_dvars(killstreaktype)
{
	/#
		/#
			assert(isdefined(killstreaktype), "");
		#/
		/#
			assert(isdefined(level.killstreaks[killstreaktype]), "");
		#/
		level.killstreaks[killstreaktype].devdvar = "" + killstreaktype + "";
		level.killstreaks[killstreaktype].devenemydvar = "" + killstreaktype + "";
		level.killstreaks[killstreaktype].devtimeoutdvar = "" + killstreaktype + "";
		setdvar(level.killstreaks[killstreaktype].devtimeoutdvar, 0);
		level thread register_devgui(killstreaktype);
	#/
}

/*
	Name: register_dev_debug_dvar
	Namespace: killstreaks
	Checksum: 0xFAA7106F
	Offset: 0x23C8
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function register_dev_debug_dvar(killstreaktype)
{
	/#
		/#
			assert(isdefined(killstreaktype), "");
		#/
		/#
			assert(isdefined(level.killstreaks[killstreaktype]), "");
		#/
		level.killstreaks[killstreaktype].devdebugdvar = "" + killstreaktype + "";
		devgui_scorestreak_command_debugdvar(killstreaktype, level.killstreaks[killstreaktype].devdebugdvar);
	#/
}

/*
	Name: register_devgui
	Namespace: killstreaks
	Checksum: 0xCD94A804
	Offset: 0x2490
	Size: 0x138
	Parameters: 1
	Flags: None
*/
function register_devgui(killstreaktype)
{
	/#
		level endon(#"game_ended");
		wait(randomintrange(2, 20) * float(function_60d95f53()) / 1000);
		give_type_all = "";
		give_type_enemy = "";
		if(isdefined(level.killstreaks[killstreaktype].devdvar))
		{
			devgui_scorestreak_command_givedvar(killstreaktype, give_type_all, level.killstreaks[killstreaktype].devdvar);
		}
		if(isdefined(level.killstreaks[killstreaktype].devenemydvar))
		{
			devgui_scorestreak_command_givedvar(killstreaktype, give_type_enemy, level.killstreaks[killstreaktype].devenemydvar);
		}
	#/
}

/*
	Name: devgui_scorestreak_command_givedvar
	Namespace: killstreaks
	Checksum: 0xD0873308
	Offset: 0x25D0
	Size: 0x54
	Parameters: 3
	Flags: None
*/
function devgui_scorestreak_command_givedvar(killstreaktype, give_type, dvar)
{
	/#
		devgui_scorestreak_command(killstreaktype, give_type, "" + dvar + "");
	#/
}

/*
	Name: devgui_scorestreak_command_timeoutdvar
	Namespace: killstreaks
	Checksum: 0x3B975041
	Offset: 0x2630
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function devgui_scorestreak_command_timeoutdvar(killstreaktype, dvar)
{
	/#
		devgui_scorestreak_dvar_toggle(killstreaktype, "", dvar);
	#/
}

/*
	Name: devgui_scorestreak_command_debugdvar
	Namespace: killstreaks
	Checksum: 0xD5B5A8E8
	Offset: 0x2670
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function devgui_scorestreak_command_debugdvar(killstreaktype, dvar)
{
	/#
		devgui_scorestreak_dvar_toggle(killstreaktype, "", dvar);
	#/
}

/*
	Name: devgui_scorestreak_dvar_toggle
	Namespace: killstreaks
	Checksum: 0xD8515D7C
	Offset: 0x26B0
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function devgui_scorestreak_dvar_toggle(killstreaktype, title, dvar)
{
	setdvar(dvar, 0);
	devgui_scorestreak_command(killstreaktype, "Toggle " + title, "toggle " + dvar + " 1 0");
}

/*
	Name: devgui_scorestreak_command
	Namespace: killstreaks
	Checksum: 0x225196E3
	Offset: 0x2728
	Size: 0xFC
	Parameters: 3
	Flags: None
*/
function devgui_scorestreak_command(killstreaktype, title, command)
{
	/#
		/#
			assert(isdefined(killstreaktype), "");
		#/
		/#
			assert(isdefined(level.killstreaks[killstreaktype]), "");
		#/
		root = "";
		user_name = level.killstreaks[killstreaktype].menuname;
		util::add_queued_debug_command(root + user_name + "" + killstreaktype + "" + title + "" + command + "");
	#/
}

/*
	Name: should_draw_debug
	Namespace: killstreaks
	Checksum: 0xB9D33805
	Offset: 0x2830
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function should_draw_debug(killstreak)
{
	/#
		/#
			assert(isdefined(killstreak), "");
		#/
		function_2459bd2f();
		if(isdefined(level.killstreaks[killstreak]) && isdefined(level.killstreaks[killstreak].devdebugdvar))
		{
			return getdvarint(level.killstreaks[killstreak].devdebugdvar, 0);
		}
	#/
	return 0;
}

/*
	Name: function_2459bd2f
	Namespace: killstreaks
	Checksum: 0x89ABA113
	Offset: 0x28D8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_2459bd2f()
{
	/#
		/#
			assert(isdefined(level.killstreaks), "");
		#/
	#/
}

/*
	Name: is_available
	Namespace: killstreaks
	Checksum: 0x25A5F372
	Offset: 0x2918
	Size: 0x2E
	Parameters: 1
	Flags: None
*/
function is_available(killstreak)
{
	if(isdefined(level.menureferenceforkillstreak[killstreak]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_by_menu_name
	Namespace: killstreaks
	Checksum: 0x104C1963
	Offset: 0x2950
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function get_by_menu_name(killstreak)
{
	return level.menureferenceforkillstreak[killstreak];
}

/*
	Name: get_menu_name
	Namespace: killstreaks
	Checksum: 0xB5B3BB8
	Offset: 0x2978
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function get_menu_name(killstreaktype)
{
	/#
		assert(isdefined(level.killstreaks[killstreaktype]));
	#/
	return level.killstreaks[killstreaktype].menuname;
}

/*
	Name: get_level
	Namespace: killstreaks
	Checksum: 0x2883C6BC
	Offset: 0x29D0
	Size: 0x122
	Parameters: 2
	Flags: None
*/
function get_level(index, killstreak)
{
	killstreaklevel = level.killstreaks[get_by_menu_name(killstreak)].killstreaklevel;
	if(getdvarint(#"custom_killstreak_mode", 0) == 2)
	{
		if(isdefined(self.killstreak[index]) && killstreak == self.killstreak[index])
		{
			killsrequired = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);
			if(killsrequired)
			{
				killstreaklevel = getdvarint("custom_killstreak_" + index + 1 + "_kills", 0);
			}
		}
	}
	return killstreaklevel;
}

/*
	Name: give_if_streak_count_matches
	Namespace: killstreaks
	Checksum: 0x3A74463F
	Offset: 0x2B00
	Size: 0x25E
	Parameters: 3
	Flags: None
*/
function give_if_streak_count_matches(index, killstreak, streakcount)
{
	pixbeginevent(#"givekillstreakifstreakcountmatches");
	/#
		if(!isdefined(killstreak))
		{
			println("");
		}
		if(isdefined(killstreak))
		{
			println("" + killstreak + "");
		}
		if(!is_available(killstreak))
		{
			println("");
		}
	#/
	if(self.pers[#"killstreaksearnedthiskillstreak"] > index && util::isroundbased())
	{
		hasalreadyearnedkillstreak = 1;
	}
	else
	{
		hasalreadyearnedkillstreak = 0;
	}
	if(isdefined(killstreak) && is_available(killstreak) && !hasalreadyearnedkillstreak)
	{
		killstreaklevel = get_level(index, killstreak);
		if(self hasperk(#"specialty_killstreak"))
		{
			reduction = getdvarint(#"perk_killstreakreduction", 0);
			killstreaklevel = killstreaklevel - reduction;
			if(killstreaklevel <= 0)
			{
				killstreaklevel = 1;
			}
		}
		if(killstreaklevel == streakcount)
		{
			self give(get_by_menu_name(killstreak), streakcount);
			self.pers[#"killstreaksearnedthiskillstreak"] = index + 1;
			pixendevent();
			return 1;
		}
	}
	pixendevent();
	return 0;
}

/*
	Name: give_for_streak
	Namespace: killstreaks
	Checksum: 0x606EB200
	Offset: 0x2D68
	Size: 0xCA
	Parameters: 0
	Flags: None
*/
function give_for_streak()
{
	if(!util::is_killstreaks_enabled())
	{
		return;
	}
	if(!isdefined(self.pers[#"totalkillstreakcount"]))
	{
		self.pers[#"totalkillstreakcount"] = 0;
	}
	given = 0;
	for(i = 0; i < self.killstreak.size; i++)
	{
		given = given | give_if_streak_count_matches(i, self.killstreak[i], self.pers[#"cur_kill_streak"]);
	}
}

/*
	Name: is_an_a_killstreak
	Namespace: killstreaks
	Checksum: 0xFBFBA1B6
	Offset: 0x2E40
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function is_an_a_killstreak()
{
	onkillstreak = 0;
	if(!isdefined(self.pers[#"kill_streak_before_death"]))
	{
		self.pers[#"kill_streak_before_death"] = 0;
	}
	streakplusone = self.pers[#"kill_streak_before_death"] + 1;
	if(self.pers[#"kill_streak_before_death"] >= 5)
	{
		onkillstreak = 1;
	}
	return onkillstreak;
}

/*
	Name: give
	Namespace: killstreaks
	Checksum: 0x58CC984A
	Offset: 0x2EF0
	Size: 0x194
	Parameters: 5
	Flags: None
*/
function give(killstreaktype, streak, suppressnotification, noxp, tobottom)
{
	pixbeginevent(#"givekillstreak");
	self endon(#"disconnect");
	level endon(#"game_ended");
	had_to_delay = 0;
	killstreakgiven = 0;
	if(isdefined(noxp))
	{
		if(self give_internal(killstreaktype, undefined, noxp, tobottom))
		{
			killstreakgiven = 1;
			if(self.just_given_new_inventory_killstreak === 1)
			{
				self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
			}
		}
	}
	else if(self give_internal(killstreaktype, noxp))
	{
		killstreakgiven = 1;
		if(self.just_given_new_inventory_killstreak === 1)
		{
			self add_to_notification_queue(level.killstreaks[killstreaktype].menuname, streak, killstreaktype, noxp, 1);
		}
	}
	pixendevent();
}

/*
	Name: take
	Namespace: killstreaks
	Checksum: 0x38847068
	Offset: 0x3090
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function take(killstreak)
{
	self endon(#"disconnect");
	killstreak_weapon = get_killstreak_weapon(killstreak);
	remove_used_killstreak(killstreak);
	if(self getinventoryweapon() == killstreak_weapon)
	{
		self setinventoryweapon(level.weaponnone);
	}
	waittillframeend();
	currentweapon = self getcurrentweapon();
	if(currentweapon != killstreak_weapon || killstreak_weapon.iscarriedkillstreak)
	{
		return;
	}
	switch_to_last_non_killstreak_weapon();
	activate_next();
}

/*
	Name: remove_oldest
	Namespace: killstreaks
	Checksum: 0x9589C7B6
	Offset: 0x3198
	Size: 0x174
	Parameters: 0
	Flags: None
*/
function remove_oldest()
{
	if(isdefined(self.pers[#"killstreaks"][0]))
	{
		currentweapon = self getcurrentweapon();
		if(currentweapon == get_killstreak_weapon(self.pers[#"killstreaks"][0]))
		{
			primaries = self getweaponslistprimaries();
			if(primaries.size > 0)
			{
				self switchtoweapon(primaries[0]);
			}
		}
		self notify(#"oldest_killstreak_removed", {#id:self.pers[#"killstreak_unique_id"][0], #type:self.pers[#"killstreaks"][0]});
		self remove_used_killstreak(self.pers[#"killstreaks"][0], self.pers[#"killstreak_unique_id"][0], 0);
	}
}

/*
	Name: give_internal
	Namespace: killstreaks
	Checksum: 0xBE20B265
	Offset: 0x3318
	Size: 0x980
	Parameters: 4
	Flags: None
*/
function give_internal(killstreaktype, do_not_update_death_count, noxp, tobottom)
{
	self.just_given_new_inventory_killstreak = undefined;
	if(level.gameended)
	{
		return 0;
	}
	if(!util::is_killstreaks_enabled())
	{
		return 0;
	}
	if(!isdefined(level.killstreaks[killstreaktype]))
	{
		return 0;
	}
	if(!isdefined(self.pers[#"killstreaks"]))
	{
		self.pers[#"killstreaks"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_has_been_used"]))
	{
		self.pers[#"killstreak_has_been_used"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_unique_id"]))
	{
		self.pers[#"killstreak_unique_id"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_ammo_count"]))
	{
		self.pers[#"killstreak_ammo_count"] = [];
	}
	just_max_stack_removed_inventory_killstreak = undefined;
	if(isdefined(tobottom) && tobottom)
	{
		size = self.pers[#"killstreaks"].size;
		if(self.pers[#"killstreaks"].size >= level.maxinventoryscorestreaks)
		{
			self remove_oldest();
			just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
		}
		for(i = size; i > 0; i--)
		{
			self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i - 1];
			self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i - 1];
			self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i - 1];
			self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i - 1];
		}
		self.pers[#"killstreaks"][0] = killstreaktype;
		self.pers[#"killstreak_unique_id"][0] = level.killstreakcounter;
		level.killstreakcounter++;
		if(isdefined(noxp))
		{
			self.pers[#"killstreak_has_been_used"][0] = noxp;
		}
		else
		{
			self.pers[#"killstreak_has_been_used"][0] = 0;
		}
		if(size == 0)
		{
			weapon = get_killstreak_weapon(killstreaktype);
			ammocount = give_weapon(weapon, 1);
		}
		self.pers[#"killstreak_ammo_count"][0] = 0;
	}
	else
	{
		var_7b935486 = 0;
		if(self.pers[#"killstreaks"].size && self.currentweapon === get_killstreak_weapon(self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1]))
		{
			var_7b935486 = 1;
		}
		self.pers[#"killstreaks"][self.pers[#"killstreaks"].size] = killstreaktype;
		self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size] = level.killstreakcounter;
		level.killstreakcounter++;
		if(self.pers[#"killstreaks"].size > level.maxinventoryscorestreaks)
		{
			self remove_oldest();
			just_max_stack_removed_inventory_killstreak = self.just_removed_used_killstreak;
		}
		if(!isdefined(noxp))
		{
			noxp = 0;
		}
		self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size] = noxp;
		weapon = get_killstreak_weapon(killstreaktype);
		ammocount = give_weapon(weapon, 1);
		self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size] = ammocount;
		if(var_7b935486)
		{
			var_3522232f = self.pers[#"killstreaks"].size - 2;
			var_a1312679 = self.pers[#"killstreaks"].size - 1;
			var_3197d2aa = self.pers[#"killstreaks"][var_3522232f];
			var_c72e250a = self.pers[#"killstreak_unique_id"][var_3522232f];
			var_948e9ad0 = self.pers[#"killstreak_has_been_used"][var_3522232f];
			var_80931fe9 = self.pers[#"killstreak_ammo_count"][var_3522232f];
			self.pers[#"killstreaks"][var_3522232f] = self.pers[#"killstreaks"][var_a1312679];
			self.pers[#"killstreak_unique_id"][var_3522232f] = self.pers[#"killstreak_unique_id"][var_a1312679];
			self.pers[#"killstreak_has_been_used"][var_3522232f] = self.pers[#"killstreak_has_been_used"][var_a1312679];
			self.pers[#"killstreak_ammo_count"][var_3522232f] = self.pers[#"killstreak_ammo_count"][var_a1312679];
			self.pers[#"killstreaks"][var_a1312679] = var_3197d2aa;
			self.pers[#"killstreak_unique_id"][var_a1312679] = var_c72e250a;
			self.pers[#"killstreak_has_been_used"][var_a1312679] = var_948e9ad0;
			self.pers[#"killstreak_ammo_count"][var_a1312679] = var_80931fe9;
			self setinventoryweapon(get_killstreak_weapon(var_3197d2aa));
		}
	}
	self.just_given_new_inventory_killstreak = killstreaktype !== just_max_stack_removed_inventory_killstreak && (!(isdefined(var_7b935486) && var_7b935486));
	if(!isdefined(self.var_58d669ff))
	{
		self.var_58d669ff = [];
	}
	if(!isdefined(self.var_58d669ff[killstreaktype]))
	{
		self.var_58d669ff[killstreaktype] = [];
	}
	array::push(self.var_58d669ff[killstreaktype], gettime(), self.var_58d669ff[killstreaktype].size);
	return 1;
}

/*
	Name: add_to_notification_queue
	Namespace: killstreaks
	Checksum: 0x4372C9C5
	Offset: 0x3CA0
	Size: 0x11C
	Parameters: 5
	Flags: None
*/
function add_to_notification_queue(menuname, streakcount, hardpointtype, nonotify, var_af825242)
{
	killstreaktablenumber = level.killstreakindices[menuname];
	if(!isdefined(killstreaktablenumber))
	{
		return;
	}
	if(isdefined(nonotify) && nonotify)
	{
		return;
	}
	informdialog = get_killstreak_inform_dialog(hardpointtype);
	self thread play_killstreak_ready_dialog(hardpointtype, 2.4);
	self thread play_killstreak_ready_sfx(hardpointtype);
	self luinotifyevent(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
	self function_b552ffa9(#"killstreak_received", 3, killstreaktablenumber, informdialog, var_af825242);
}

/*
	Name: has_equipped
	Namespace: killstreaks
	Checksum: 0x28A4B350
	Offset: 0x3DC8
	Size: 0xA2
	Parameters: 0
	Flags: None
*/
function has_equipped()
{
	currentweapon = self getcurrentweapon();
	keys = getarraykeys(level.killstreaks);
	for(i = 0; i < keys.size; i++)
	{
		if(level.killstreaks[keys[i]].weapon == currentweapon)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: _get_from_weapon
	Namespace: killstreaks
	Checksum: 0xA4D5D87D
	Offset: 0x3E78
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function _get_from_weapon(weapon)
{
	return get_killstreak_for_weapon(weapon);
}

/*
	Name: get_from_weapon
	Namespace: killstreaks
	Checksum: 0xC82018C2
	Offset: 0x3EA8
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function get_from_weapon(weapon)
{
	if(weapon == level.weaponnone)
	{
		return undefined;
	}
	res = _get_from_weapon(weapon);
	if(!isdefined(res))
	{
		return _get_from_weapon(weapon.rootweapon);
	}
	return res;
}

/*
	Name: give_weapon
	Namespace: killstreaks
	Checksum: 0x6240500E
	Offset: 0x3F28
	Size: 0x748
	Parameters: 3
	Flags: None
*/
function give_weapon(weapon, isinventory, usestoredammo)
{
	currentweapon = self getcurrentweapon();
	if(currentweapon != level.weaponnone && (!(isdefined(level.usingmomentum) && level.usingmomentum)))
	{
		weaponslist = self getweaponslist();
		for(idx = 0; idx < weaponslist.size; idx++)
		{
			carriedweapon = weaponslist[idx];
			if(currentweapon == carriedweapon)
			{
				continue;
			}
			switch(carriedweapon.name)
			{
				case "m32":
				case "minigun":
				{
					continue;
				}
			}
			if(is_killstreak_weapon(carriedweapon))
			{
				self takeweapon(carriedweapon);
			}
		}
	}
	if(currentweapon != weapon && self hasweapon(weapon) == 0)
	{
		self takeweapon(weapon);
		self giveweapon(weapon);
	}
	if(isdefined(level.usingmomentum) && level.usingmomentum)
	{
		self setinventoryweapon(weapon);
		if(weapon.iscarriedkillstreak)
		{
			if(!isdefined(self.pers[#"held_killstreak_ammo_count"][weapon]))
			{
				self.pers[#"held_killstreak_ammo_count"][weapon] = 0;
			}
			if(!isdefined(self.pers[#"held_killstreak_clip_count"][weapon]))
			{
				self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
			}
			if(!isdefined(self.pers[#"killstreak_quantity"][weapon]))
			{
				self.pers[#"killstreak_quantity"][weapon] = 0;
			}
			if(currentweapon == weapon && !isheldinventorykillstreakweapon(weapon))
			{
				return weapon.maxammo;
			}
			if(isdefined(usestoredammo) && usestoredammo && self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1] > 0)
			{
				switch(weapon.name)
				{
					case "inventory_minigun":
					{
						if(isdefined(self.minigunactive) && self.minigunactive)
						{
							return self.pers[#"held_killstreak_ammo_count"][weapon];
						}
						break;
					}
					case "inventory_m32":
					{
						if(isdefined(self.m32active) && self.m32active)
						{
							return self.pers[#"held_killstreak_ammo_count"][weapon];
						}
						break;
					}
					default:
					{
						break;
					}
				}
				self.pers[#"held_killstreak_ammo_count"][weapon] = self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1];
				self loadout::function_3ba6ee5d(weapon, self.pers[#"killstreak_ammo_count"][self.pers[#"killstreak_ammo_count"].size - 1]);
			}
			else
			{
				self.pers[#"held_killstreak_ammo_count"][weapon] = weapon.maxammo;
				self.pers[#"held_killstreak_clip_count"][weapon] = weapon.clipsize;
				self loadout::function_3ba6ee5d(weapon, self.pers[#"held_killstreak_ammo_count"][weapon]);
			}
			return self.pers[#"held_killstreak_ammo_count"][weapon];
		}
		switch(weapon.statname)
		{
			case "dart":
			case "ultimate_turret":
			case "counteruav":
			case "combat_robot_marker":
			case "remote_missile":
			case "swat_team":
			case "supplydrop_marker":
			case "m32_drop":
			case "drone_squadron":
			case "overwatch_helicopter":
			case "straferun":
			case "recon_car":
			case "uav":
			case "ac130":
			case "helicopter_comlink":
			case "swat_helicopter":
			case "ai_tank_marker":
			case "planemortar":
			case "minigun_drop":
			case "missile_drone":
			{
				delta = 1;
				break;
			}
			default:
			{
				delta = 0;
				break;
			}
		}
		return change_killstreak_quantity(weapon, delta);
	}
	self setactionslot(4, "weapon", weapon);
	return 1;
}

/*
	Name: activate_next
	Namespace: killstreaks
	Checksum: 0xCC1A1C27
	Offset: 0x4680
	Size: 0x282
	Parameters: 1
	Flags: None
*/
function activate_next(do_not_update_death_count)
{
	if(level.gameended)
	{
		return 0;
	}
	if(isdefined(level.usingmomentum) && level.usingmomentum)
	{
		self setinventoryweapon(level.weaponnone);
	}
	else
	{
		self setactionslot(4, "");
	}
	if(!isdefined(self.pers[#"killstreaks"]) || self.pers[#"killstreaks"].size == 0)
	{
		return 0;
	}
	killstreaktype = self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
	if(!isdefined(level.killstreaks[killstreaktype]))
	{
		return 0;
	}
	weapon = level.killstreaks[killstreaktype].weapon;
	waitframe(1);
	if(self isremotecontrolling() && self.usingremote === weapon.statname)
	{
		while(self isremotecontrolling())
		{
			waitframe(1);
		}
	}
	ammocount = give_weapon(weapon, 0, 1);
	if(weapon.iscarriedkillstreak)
	{
		self setweaponammoclip(weapon, self.pers[#"held_killstreak_clip_count"][weapon]);
		self setweaponammostock(weapon, ammocount - self.pers[#"held_killstreak_clip_count"][weapon]);
	}
	if(!isdefined(do_not_update_death_count) || do_not_update_death_count != 0)
	{
		self.pers["killstreakItemDeathCount" + killstreaktype] = self.deathcount;
	}
	return 1;
}

/*
	Name: give_owned
	Namespace: killstreaks
	Checksum: 0x186674BC
	Offset: 0x4910
	Size: 0x20E
	Parameters: 0
	Flags: None
*/
function give_owned()
{
	if(!isdefined(self.pers[#"killstreaks"]))
	{
		self.pers[#"killstreaks"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_has_been_used"]))
	{
		self.pers[#"killstreak_has_been_used"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_unique_id"]))
	{
		self.pers[#"killstreak_unique_id"] = [];
	}
	if(!isdefined(self.pers[#"killstreak_ammo_count"]))
	{
		self.pers[#"killstreak_ammo_count"] = [];
	}
	if(self.pers[#"killstreaks"].size > 0)
	{
		self activate_next(0);
	}
	size = self.pers[#"killstreaks"].size;
	if(size > 0)
	{
		self thread play_killstreak_ready_dialog(self.pers[#"killstreaks"][size - 1]);
	}
	self.lastnonkillstreakweapon = (isdefined(self.currentweapon) ? self.currentweapon : level.weaponnone);
	if(self.lastnonkillstreakweapon == level.weaponnone)
	{
		weapons = self getweaponslistprimaries();
		if(weapons.size > 0)
		{
			self.lastnonkillstreakweapon = weapons[0];
		}
		else
		{
			self.lastnonkillstreakweapon = level.weaponbasemelee;
		}
	}
}

/*
	Name: get_killstreak_quantity
	Namespace: killstreaks
	Checksum: 0x8232B0B6
	Offset: 0x4B28
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function get_killstreak_quantity(killstreakweapon)
{
	if(!isdefined(self.pers[#"killstreak_quantity"]))
	{
		return 0;
	}
	return (isdefined(self.pers[#"killstreak_quantity"][killstreakweapon]) ? self.pers[#"killstreak_quantity"][killstreakweapon] : 0);
}

/*
	Name: change_killstreak_quantity
	Namespace: killstreaks
	Checksum: 0x2595F3FE
	Offset: 0x4BA8
	Size: 0x24A
	Parameters: 2
	Flags: None
*/
function change_killstreak_quantity(killstreakweapon, delta)
{
	if(delta === 1 && killstreakweapon.statname == "remote_missile")
	{
		streamermodelhint(killstreakweapon.var_22082a57, 7);
	}
	quantity = get_killstreak_quantity(killstreakweapon);
	previousquantity = quantity;
	quantity = quantity + delta;
	if(quantity > level.scorestreaksmaxstacking)
	{
		quantity = level.scorestreaksmaxstacking;
	}
	if(self hasweapon(killstreakweapon) == 0)
	{
		self takeweapon(killstreakweapon);
		self giveweapon(killstreakweapon);
		self seteverhadweaponall(1);
	}
	self.pers[#"killstreak_quantity"][killstreakweapon] = quantity;
	self setweaponammoclip(killstreakweapon, quantity);
	self notify("killstreak_quantity_" + killstreakweapon.name);
	killstreaktype = get_killstreak_for_weapon(killstreakweapon);
	if(!isdefined(self.var_58d669ff))
	{
		self.var_58d669ff = [];
	}
	if(!isdefined(self.var_58d669ff[killstreaktype]))
	{
		self.var_58d669ff[killstreaktype] = [];
	}
	for(index = 0; delta - index > 0; index++)
	{
		array::push(self.var_58d669ff[killstreaktype], function_f8d53445(), self.var_58d669ff[killstreaktype].size);
	}
	return quantity;
}

/*
	Name: function_1f96e8f8
	Namespace: killstreaks
	Checksum: 0xFB30AD69
	Offset: 0x4E00
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_1f96e8f8(killstreakweapon)
{
	quantity = get_killstreak_quantity(killstreakweapon);
	if(quantity > level.scorestreaksmaxstacking)
	{
		quantity = level.scorestreaksmaxstacking;
	}
	if(self hasweapon(killstreakweapon) == 0)
	{
		self takeweapon(killstreakweapon);
		self giveweapon(killstreakweapon);
		self seteverhadweaponall(1);
	}
	self setweaponammoclip(killstreakweapon, quantity);
	return quantity;
}

/*
	Name: has_killstreak_in_class
	Namespace: killstreaks
	Checksum: 0xE80A8CB3
	Offset: 0x4ED8
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function has_killstreak_in_class(killstreakmenuname)
{
	foreach(equippedkillstreak in self.killstreak)
	{
		if(equippedkillstreak == killstreakmenuname)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: has_killstreak
	Namespace: killstreaks
	Checksum: 0x508BD6AC
	Offset: 0x4F68
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function has_killstreak(killstreak)
{
	player = self;
	if(!isdefined(killstreak) || !isdefined(player.pers[#"killstreaks"]))
	{
		return 0;
	}
	for(i = 0; i < self.pers[#"killstreaks"].size; i++)
	{
		if(player.pers[#"killstreaks"][i] == killstreak)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: recordkillstreakbegindirect
	Namespace: killstreaks
	Checksum: 0x6800A840
	Offset: 0x5028
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function recordkillstreakbegindirect(killstreak, recordstreakindex)
{
	player = self;
	if(!isplayer(player) || !isdefined(recordstreakindex))
	{
		return;
	}
	if(!isdefined(self.killstreakevents))
	{
		player.killstreakevents = associativearray();
	}
	var_b16cd32d = 0;
	if(isdefined(self.var_58d669ff) && isdefined(self.var_58d669ff[killstreak]) && self.var_58d669ff[killstreak].size > 0)
	{
		var_b16cd32d = array::pop_front(self.var_58d669ff[killstreak], 0);
	}
	if(isdefined(self.killstreakevents[recordstreakindex]))
	{
		kills = player.killstreakevents[recordstreakindex];
		eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
		player killstreakrules::recordkillstreakenddirect(eventindex, recordstreakindex, kills);
		player.killstreakevents[recordstreakindex] = undefined;
	}
	else
	{
		eventindex = player recordkillstreakevent(recordstreakindex, var_b16cd32d);
		player.killstreakevents[recordstreakindex] = eventindex;
	}
}

/*
	Name: remove_when_done
	Namespace: killstreaks
	Checksum: 0xB9844EC0
	Offset: 0x51C8
	Size: 0x63C
	Parameters: 3
	Flags: None
*/
function remove_when_done(killstreak, haskillstreakbeenused, isfrominventory)
{
	self endon(#"disconnect");
	waitresult = undefined;
	waitresult = self waittill(#"killstreak_done");
	killstreaktype = waitresult.var_d3413870;
	if(waitresult.is_successful)
	{
		/#
			print("" + get_menu_name(killstreak));
		#/
		killstreak_weapon = get_killstreak_weapon(killstreak);
		recordstreakindex = undefined;
		var_d86010cb = get_killstreak_for_weapon_for_stats(killstreak_weapon);
		if(isdefined(level.killstreaks[var_d86010cb].menuname))
		{
			recordstreakindex = level.killstreakindices[level.killstreaks[var_d86010cb].menuname];
			self recordkillstreakbegindirect(killstreak, recordstreakindex);
		}
		if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
		{
			var_ad8ae78f = {#activatedby:getplayerspawnid(self), #killstreak:killstreak, #gametime:function_f8d53445()};
			function_92d1707f(#"hash_1aa07f199266e0c7", var_ad8ae78f);
			if(isdefined(isfrominventory) && isfrominventory)
			{
				remove_used_killstreak(killstreak);
				if(self getinventoryweapon() == killstreak_weapon)
				{
					self setinventoryweapon(level.weaponnone);
				}
			}
			else
			{
				self change_killstreak_quantity(killstreak_weapon, -1);
			}
		}
		else if(isdefined(level.usingmomentum) && level.usingmomentum)
		{
			if(isdefined(isfrominventory) && isfrominventory && self getinventoryweapon() == killstreak_weapon)
			{
				remove_used_killstreak(killstreak);
				self setinventoryweapon(level.weaponnone);
			}
			else if(isdefined(level.var_b0dc03c7))
			{
				self [[level.var_b0dc03c7]](killstreaktype);
			}
		}
		else
		{
			remove_used_killstreak(killstreak);
		}
		if(!(isdefined(level.usingmomentum) && level.usingmomentum))
		{
			self setactionslot(4, "");
		}
		success = 1;
	}
	else
	{
		killstreak_weapon = get_killstreak_weapon(killstreak);
		self function_1f96e8f8(killstreak_weapon);
	}
	waittillframeend();
	self unhide_compass();
	killstreak_weapon = get_killstreak_weapon(killstreaktype);
	if(killstreak_weapon.var_7d24272c)
	{
		if(!(isdefined(level.usingmomentum) && level.usingmomentum) || (isdefined(isfrominventory) && isfrominventory) && waitresult.is_successful)
		{
			activate_next();
		}
		return;
	}
	currentweapon = self getcurrentweapon();
	if(currentweapon == killstreak_weapon && killstreak_weapon.iscarriedkillstreak)
	{
		return;
	}
	if(waitresult.is_successful && (!self has_killstreak_in_class(get_menu_name(killstreak)) || (isdefined(isfrominventory) && isfrominventory)))
	{
		switch_to_last_non_killstreak_weapon();
	}
	else
	{
		killstreakforcurrentweapon = get_from_weapon(currentweapon);
		if(currentweapon.isgameplayweapon)
		{
			if(isdefined(self.isplanting) && self.isplanting || (isdefined(self.isdefusing) && self.isdefusing))
			{
				return;
			}
		}
		if(!isdefined(killstreakforcurrentweapon) && isdefined(currentweapon))
		{
			return;
		}
		if(waitresult.is_successful || !isdefined(killstreakforcurrentweapon) || killstreakforcurrentweapon == killstreak || killstreakforcurrentweapon == "inventory_" + killstreak)
		{
			switch_to_last_non_killstreak_weapon();
		}
	}
	if(!(isdefined(level.usingmomentum) && level.usingmomentum) || (isdefined(isfrominventory) && isfrominventory) && waitresult.is_successful)
	{
		activate_next();
	}
}

/*
	Name: usekillstreak
	Namespace: killstreaks
	Checksum: 0xFCA1A76E
	Offset: 0x5810
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function usekillstreak(killstreak, isfrominventory)
{
	haskillstreakbeenused = get_if_top_killstreak_has_been_used();
	if(isdefined(self.selectinglocation))
	{
		return;
	}
	if(isdefined(self.drone))
	{
		[[level.killstreaks[killstreak].usefunction]](killstreak);
	}
	else
	{
		self thread remove_when_done(killstreak, haskillstreakbeenused, isfrominventory);
		self thread trigger_killstreak(killstreak, isfrominventory);
	}
}

/*
	Name: function_2ea0382e
	Namespace: killstreaks
	Checksum: 0xB93886BD
	Offset: 0x58C0
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function function_2ea0382e()
{
	self.pers[#"killstreaks"] = [];
	self.pers[#"killstreak_has_been_used"] = [];
	self.pers[#"killstreak_unique_id"] = [];
	self.pers[#"killstreak_ammo_count"] = [];
}

/*
	Name: remove_used_killstreak
	Namespace: killstreaks
	Checksum: 0x79EA9E99
	Offset: 0x5930
	Size: 0x372
	Parameters: 3
	Flags: None
*/
function remove_used_killstreak(killstreak, killstreakid, take_weapon_after_use = 1)
{
	self.just_removed_used_killstreak = undefined;
	if(!isdefined(self.pers[#"killstreaks"]))
	{
		return;
	}
	killstreakindex = undefined;
	for(i = self.pers[#"killstreaks"].size - 1; i >= 0; i--)
	{
		if(self.pers[#"killstreaks"][i] == killstreak)
		{
			if(isdefined(killstreakid) && self.pers[#"killstreak_unique_id"][i] != killstreakid)
			{
				continue;
			}
			killstreakindex = i;
			break;
		}
	}
	if(!isdefined(killstreakindex))
	{
		return 0;
	}
	self.just_removed_used_killstreak = killstreak;
	if(take_weapon_after_use && !self has_killstreak_in_class(get_menu_name(killstreak)))
	{
		self thread take_weapon_after_use(get_killstreak_weapon(killstreak));
	}
	arraysize = self.pers[#"killstreaks"].size;
	for(i = killstreakindex; i < arraysize - 1; i++)
	{
		self.pers[#"killstreaks"][i] = self.pers[#"killstreaks"][i + 1];
		self.pers[#"killstreak_has_been_used"][i] = self.pers[#"killstreak_has_been_used"][i + 1];
		self.pers[#"killstreak_unique_id"][i] = self.pers[#"killstreak_unique_id"][i + 1];
		self.pers[#"killstreak_ammo_count"][i] = self.pers[#"killstreak_ammo_count"][i + 1];
	}
	self.pers[#"killstreaks"][arraysize - 1] = undefined;
	self.pers[#"killstreak_has_been_used"][arraysize - 1] = undefined;
	self.pers[#"killstreak_unique_id"][arraysize - 1] = undefined;
	self.pers[#"killstreak_ammo_count"][arraysize - 1] = undefined;
	return 1;
}

/*
	Name: take_weapon_after_use
	Namespace: killstreaks
	Checksum: 0x839DFF14
	Offset: 0x5CB0
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function take_weapon_after_use(killstreakweapon)
{
	self endon(#"disconnect", #"death", #"joined_team", #"joined_spectators");
	self waittill(#"weapon_change");
	inventoryweapon = self getinventoryweapon();
	if(inventoryweapon != killstreakweapon)
	{
		self takeweapon(killstreakweapon);
	}
	self.killstreakactivated = 1;
}

/*
	Name: get_top_killstreak
	Namespace: killstreaks
	Checksum: 0xD00A01B
	Offset: 0x5D70
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function get_top_killstreak()
{
	if(self.pers[#"killstreaks"].size == 0)
	{
		return undefined;
	}
	return self.pers[#"killstreaks"][self.pers[#"killstreaks"].size - 1];
}

/*
	Name: get_if_top_killstreak_has_been_used
	Namespace: killstreaks
	Checksum: 0xC935897C
	Offset: 0x5DE0
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function get_if_top_killstreak_has_been_used()
{
	if(!(isdefined(level.usingmomentum) && level.usingmomentum))
	{
		if(self.pers[#"killstreak_has_been_used"].size == 0)
		{
			return undefined;
		}
		return self.pers[#"killstreak_has_been_used"][self.pers[#"killstreak_has_been_used"].size - 1];
	}
}

/*
	Name: get_top_killstreak_unique_id
	Namespace: killstreaks
	Checksum: 0x694DB466
	Offset: 0x5E70
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function get_top_killstreak_unique_id()
{
	if(self.pers[#"killstreak_unique_id"].size == 0)
	{
		return undefined;
	}
	return self.pers[#"killstreak_unique_id"][self.pers[#"killstreak_unique_id"].size - 1];
}

/*
	Name: get_killstreak_index_by_id
	Namespace: killstreaks
	Checksum: 0x6B0826B9
	Offset: 0x5EE0
	Size: 0x7A
	Parameters: 1
	Flags: None
*/
function get_killstreak_index_by_id(killstreakid)
{
	for(index = self.pers[#"killstreak_unique_id"].size - 1; index >= 0; index--)
	{
		if(self.pers[#"killstreak_unique_id"][index] == killstreakid)
		{
			return index;
		}
	}
	return undefined;
}

/*
	Name: get_killstreak_momentum_cost
	Namespace: killstreaks
	Checksum: 0x60CF6AB0
	Offset: 0x5F68
	Size: 0xBA
	Parameters: 2
	Flags: None
*/
function get_killstreak_momentum_cost(player, killstreak)
{
	if(!(isdefined(level.usingmomentum) && level.usingmomentum))
	{
		return 0;
	}
	if(!isdefined(killstreak) || !isdefined(player) || !isplayer(player))
	{
		return 0;
	}
	/#
		assert(isdefined(level.killstreaks[killstreak]));
	#/
	return player function_dceb5542(level.killstreaks[killstreak].itemindex);
}

/*
	Name: get_killstreak_for_weapon_for_stats
	Namespace: killstreaks
	Checksum: 0x3D3FD004
	Offset: 0x6030
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function get_killstreak_for_weapon_for_stats(weapon)
{
	prefix = "inventory_";
	killstreak = get_killstreak_for_weapon(weapon);
	if(isdefined(killstreak))
	{
		if(strstartswith(killstreak, prefix))
		{
			killstreak = getsubstr(killstreak, prefix.size);
		}
	}
	return killstreak;
}

/*
	Name: get_killstreak_team_kill_penalty_scale
	Namespace: killstreaks
	Checksum: 0xC1F023ED
	Offset: 0x60C0
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function get_killstreak_team_kill_penalty_scale(weapon)
{
	killstreak = get_killstreak_for_weapon(weapon);
	if(!isdefined(killstreak))
	{
		return 1;
	}
	return (isdefined(level.killstreaks[killstreak].teamkillpenaltyscale) ? level.killstreaks[killstreak].teamkillpenaltyscale : 1);
}

/*
	Name: wait_till_heavy_weapon_is_fully_on
	Namespace: killstreaks
	Checksum: 0xA7FC90EA
	Offset: 0x6148
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function wait_till_heavy_weapon_is_fully_on(weapon)
{
	self endon(#"death", #"disconnect");
	slot = self gadgetgetslot(weapon);
	while(weapon == self getcurrentweapon())
	{
		if(self util::gadget_is_in_use(slot))
		{
			self.lastnonkillstreakweapon = weapon;
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_4f415d8e
	Namespace: killstreaks
	Checksum: 0xB95CC349
	Offset: 0x61E8
	Size: 0x222
	Parameters: 1
	Flags: None
*/
function function_4f415d8e(params)
{
	if(game.state == "postgame" || !isdefined(self))
	{
		return;
	}
	/#
		assert(self.lastnonkillstreakweapon != level.weaponnone);
	#/
	lastvalidpimary = self.lastnonkillstreakweapon;
	weapon = params.weapon;
	if(weapons::is_primary_weapon(weapon))
	{
		lastvalidpimary = weapon;
	}
	if(weapon === self.lastnonkillstreakweapon || weapon === level.weaponnone || weapon === level.weaponbasemelee)
	{
		return;
	}
	if(weapon.isgameplayweapon)
	{
		return;
	}
	if(isdefined(self.resurrect_weapon) && weapon == self.resurrect_weapon)
	{
		return;
	}
	name = get_killstreak_for_weapon(weapon);
	if(isdefined(name) && !weapon.iscarriedkillstreak)
	{
		killstreak = level.killstreaks[name];
		return;
	}
	if(params.last_weapon.isequipment)
	{
		if(self.lastnonkillstreakweapon.iscarriedkillstreak)
		{
			self.lastnonkillstreakweapon = lastvalidpimary;
		}
		return;
	}
	if(ability_util::is_hero_weapon(weapon))
	{
		if(weapon.gadget_heroversion_2_0)
		{
			if(weapon.isgadget && self getammocount(weapon) > 0)
			{
				self thread wait_till_heavy_weapon_is_fully_on(weapon);
				return;
			}
		}
	}
	self.lastnonkillstreakweapon = weapon;
}

/*
	Name: function_1e9a761c
	Namespace: killstreaks
	Checksum: 0x7584140
	Offset: 0x6418
	Size: 0x6C
	Parameters: 5
	Flags: None
*/
function function_1e9a761c(timeout, var_17488197, endcondition1, endcondition2, endcondition3)
{
	waitframe(1);
	placeable = self;
	placeable thread waitfortimeout(placeable.killstreakref, timeout, var_17488197, endcondition1, endcondition2);
}

/*
	Name: function_4167ea4e
	Namespace: killstreaks
	Checksum: 0xA071E028
	Offset: 0x6490
	Size: 0x2CC
	Parameters: 1
	Flags: None
*/
function function_4167ea4e(params)
{
	weapon = params.weapon;
	if(!is_killstreak_weapon(weapon))
	{
		return;
	}
	if(function_f479a2ff(weapon))
	{
		return;
	}
	killstreak = get_killstreak_for_weapon(weapon);
	if(isdefined(level.forceusekillstreak) && level.forceusekillstreak)
	{
		thread usekillstreak(killstreak, undefined);
		return;
	}
	if(!(isdefined(level.usingmomentum) && level.usingmomentum))
	{
		killstreak = get_top_killstreak();
		if(weapon != get_killstreak_weapon(killstreak))
		{
			return;
		}
	}
	if(is_remote_override_weapon(killstreak, weapon))
	{
		return;
	}
	waittillframeend();
	if(isdefined(self.usingkillstreakheldweapon) && self.usingkillstreakheldweapon && weapon.iscarriedkillstreak)
	{
		return;
	}
	isfrominventory = undefined;
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		if(weapon == self getinventoryweapon())
		{
			isfrominventory = 1;
		}
		else if(self getammocount(weapon) <= 0 && weapon.name != "killstreak_ai_tank")
		{
			self switch_to_last_non_killstreak_weapon();
			return;
		}
	}
	else if(isdefined(level.usingmomentum) && level.usingmomentum)
	{
		if(weapon == self getinventoryweapon())
		{
			isfrominventory = 1;
		}
		else if(self.momentum < self function_dceb5542(level.killstreaks[killstreak].itemindex))
		{
			self switch_to_last_non_killstreak_weapon();
			return;
		}
	}
	if(!isdefined(level.starttime) && level.roundstartkillstreakdelay > 0)
	{
		display_unavailable_time();
		return;
	}
	thread usekillstreak(killstreak, isfrominventory);
}

/*
	Name: function_20263b9e
	Namespace: killstreaks
	Checksum: 0xCF979E48
	Offset: 0x6768
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function function_20263b9e(params)
{
	grenade = params.projectile;
	grenadeweaponid = params.weapon;
	if(grenadeweaponid == level.var_239dc073)
	{
		return;
	}
	if(grenadeweaponid.inventorytype === "offhand")
	{
		if(is_killstreak_weapon(grenadeweaponid))
		{
			killstreak = get_killstreak_for_weapon(grenadeweaponid);
			isfrominventory = grenadeweaponid == self getinventoryweapon();
			thread usekillstreak(killstreak, isfrominventory);
		}
	}
}

/*
	Name: function_ce4a7c15
	Namespace: killstreaks
	Checksum: 0x44F55126
	Offset: 0x6850
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_ce4a7c15(params)
{
	grenadeweaponid = params.weapon;
	if(grenadeweaponid == level.var_239dc073)
	{
		return;
	}
	if(is_killstreak_weapon(grenadeweaponid))
	{
		killstreak = get_killstreak_for_weapon(grenadeweaponid);
		isfrominventory = grenadeweaponid == self getinventoryweapon();
		thread usekillstreak(killstreak, isfrominventory);
	}
}

/*
	Name: should_delay_killstreak
	Namespace: killstreaks
	Checksum: 0x86DCA66
	Offset: 0x6908
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function should_delay_killstreak(killstreaktype)
{
	if(!isdefined(level.starttime))
	{
		return 0;
	}
	if(level.roundstartkillstreakdelay < float(gettime() - level.starttime - level.discardtime) / 1000)
	{
		return 0;
	}
	if(!is_delayable_killstreak(killstreaktype))
	{
		return 0;
	}
	killstreakweapon = get_killstreak_weapon(killstreaktype);
	if(killstreakweapon.iscarriedkillstreak)
	{
		return 0;
	}
	if(util::isfirstround() || util::isoneround())
	{
		return 0;
	}
	return 1;
}

/*
	Name: is_delayable_killstreak
	Namespace: killstreaks
	Checksum: 0xFF9307F6
	Offset: 0x69F8
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function is_delayable_killstreak(killstreaktype)
{
	if(isdefined(level.killstreaks[killstreaktype]) && (isdefined(level.killstreaks[killstreaktype].delaystreak) && level.killstreaks[killstreaktype].delaystreak))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_xp_amount_for_killstreak
	Namespace: killstreaks
	Checksum: 0xCC0FB719
	Offset: 0x6A68
	Size: 0x186
	Parameters: 1
	Flags: None
*/
function get_xp_amount_for_killstreak(killstreaktype)
{
	xpamount = 0;
	switch(level.killstreaks[killstreaktype].killstreaklevel)
	{
		case 1:
		case 2:
		case 3:
		case 4:
		{
			xpamount = 100;
			break;
		}
		case 5:
		{
			xpamount = 150;
			break;
		}
		case 6:
		case 7:
		{
			xpamount = 200;
			break;
		}
		case 8:
		{
			xpamount = 250;
			break;
		}
		case 9:
		{
			xpamount = 300;
			break;
		}
		case 10:
		case 11:
		{
			xpamount = 350;
			break;
		}
		case 12:
		case 13:
		case 14:
		case 15:
		{
			xpamount = 500;
			break;
		}
	}
	return xpamount;
}

/*
	Name: display_unavailable_time
	Namespace: killstreaks
	Checksum: 0x5E28270F
	Offset: 0x6BF8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function display_unavailable_time()
{
	timepassed = float([[level.gettimepassed]]()) / 1000;
	timeleft = int(level.roundstartkillstreakdelay - timepassed);
	if(timeleft <= 0)
	{
		timeleft = 1;
	}
	self iprintlnbold(#"hash_55a79f95e07a10bc", " " + timeleft + " ", #"hash_79a58948c3b976f5");
}

/*
	Name: trigger_killstreak
	Namespace: killstreaks
	Checksum: 0x6E6981BD
	Offset: 0x6CC0
	Size: 0x220
	Parameters: 2
	Flags: None
*/
function trigger_killstreak(killstreaktype, isfrominventory)
{
	/#
		assert(isdefined(level.killstreaks[killstreaktype].usefunction), "" + killstreaktype);
	#/
	self.usingkillstreakfrominventory = isfrominventory;
	if(isdefined(level.infinalkillcam) && level.infinalkillcam)
	{
		return 0;
	}
	if(should_delay_killstreak(killstreaktype))
	{
		display_unavailable_time();
	}
	else
	{
		success = [[level.killstreaks[killstreaktype].usefunction]](killstreaktype);
		if(isdefined(success) && success)
		{
			if(isdefined(self))
			{
				if(!isdefined(self.pers[level.killstreaks[killstreaktype].usagekey]))
				{
					self.pers[level.killstreaks[killstreaktype].usagekey] = 0;
				}
				self.pers[level.killstreaks[killstreaktype].usagekey]++;
				self notify(#"killstreak_used", killstreaktype, sessionmodeismultiplayergame());
				self notify(#"killstreak_done", {#hash_d3413870:killstreaktype, #is_successful:1});
				self.usingkillstreakfrominventory = undefined;
			}
			return 1;
		}
	}
	if(isdefined(self))
	{
		self.usingkillstreakfrominventory = undefined;
		self notify(#"killstreak_done", {#hash_d3413870:killstreaktype, #is_successful:0});
	}
	return 0;
}

/*
	Name: add_to_killstreak_count
	Namespace: killstreaks
	Checksum: 0xC049EA4F
	Offset: 0x6EE8
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function add_to_killstreak_count(weapon)
{
	if(!isdefined(self.pers[#"totalkillstreakcount"]))
	{
		self.pers[#"totalkillstreakcount"] = 0;
	}
	self.pers[#"totalkillstreakcount"]++;
}

/*
	Name: get_first_valid_killstreak_alt_weapon
	Namespace: killstreaks
	Checksum: 0x3BE75253
	Offset: 0x6F50
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function get_first_valid_killstreak_alt_weapon(killstreaktype)
{
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	if(isdefined(level.killstreaks[killstreaktype].altweapons))
	{
		for(i = 0; i < level.killstreaks[killstreaktype].altweapons.size; i++)
		{
			if(isdefined(level.killstreaks[killstreaktype].altweapons[i]))
			{
				return level.killstreaks[killstreaktype].altweapons[i];
			}
		}
	}
	return level.weaponnone;
}

/*
	Name: should_give_killstreak
	Namespace: killstreaks
	Checksum: 0xFFDA38D7
	Offset: 0x7030
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function should_give_killstreak(weapon)
{
	killstreakbuilding = getdvarint(#"scr_allow_killstreak_building", 0);
	rootweapon = isdefined(weapon) && (isdefined(weapon.rootweapon) ? weapon.rootweapon : weapon);
	if(killstreakbuilding == 0)
	{
		if(is_weapon_associated_with_killstreak(rootweapon))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: point_is_in_danger_area
	Namespace: killstreaks
	Checksum: 0xB26A7194
	Offset: 0x70D8
	Size: 0x42
	Parameters: 3
	Flags: None
*/
function point_is_in_danger_area(point, targetpos, radius)
{
	return distance2d(point, targetpos) <= radius * 1.25;
}

/*
	Name: print_killstreak_start_text
	Namespace: killstreaks
	Checksum: 0xB884D98E
	Offset: 0x7128
	Size: 0x2BC
	Parameters: 5
	Flags: None
*/
function print_killstreak_start_text(killstreaktype, owner, team, targetpos, dangerradius)
{
	if(!isdefined(level.killstreaks[killstreaktype]))
	{
		return;
	}
	if(level.teambased)
	{
		players = level.players;
		if(!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext))
		{
			for(i = 0; i < players.size; i++)
			{
				if(isalive(players[i]) && isdefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team)
				{
					if(point_is_in_danger_area(players[i].origin, targetpos, dangerradius))
					{
						players[i] iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
					}
				}
			}
		}
		if(isdefined(level.killstreaks[killstreaktype]))
		{
			for(i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				playerteam = player.pers[#"team"];
				if(isdefined(playerteam))
				{
					if(playerteam == team)
					{
						player iprintln(level.killstreaks[killstreaktype].inboundtext, owner);
					}
				}
			}
		}
	}
	else if(!level.hardcoremode && isdefined(level.killstreaks[killstreaktype].inboundnearplayertext))
	{
		if(point_is_in_danger_area(owner.origin, targetpos, dangerradius))
		{
			owner iprintlnbold(level.killstreaks[killstreaktype].inboundnearplayertext);
		}
	}
}

/*
	Name: play_killstreak_ready_sfx
	Namespace: killstreaks
	Checksum: 0x6502437D
	Offset: 0x73F0
	Size: 0x20C
	Parameters: 1
	Flags: None
*/
function play_killstreak_ready_sfx(killstreaktype)
{
	if(!isdefined(level.gameended) || !level.gameended)
	{
		switch(killstreaktype)
		{
			case "uav":
			{
				var_426d4c5d = "uin_kls_uav";
				break;
			}
			case "counteruav":
			{
				var_426d4c5d = "uin_kls_counteruav";
				break;
			}
			case "remote_missile":
			{
				var_426d4c5d = "uin_kls_remote_missile";
				break;
			}
			case "ultimate_turret":
			{
				var_426d4c5d = "uin_kls_ultimate_turret";
				break;
			}
			case "helicopter_comlink":
			{
				var_426d4c5d = "uin_kls_helicopter_comlink";
				break;
			}
			case "tank_robot":
			{
				var_426d4c5d = "uin_kls_tank_robot";
				break;
			}
			case "swat_team":
			{
				var_426d4c5d = "uin_kls_swat_team";
				break;
			}
			case "ac130":
			{
				var_426d4c5d = "uin_kls_ac130";
				break;
			}
			case "recon_car":
			{
				var_426d4c5d = "uin_kls_rcbomb";
				break;
			}
			case "supply_drop":
			{
				var_426d4c5d = "uin_kls_supply_drop";
				break;
			}
			case "planemortar":
			{
				var_426d4c5d = "uin_kls_airstrike";
				break;
			}
			case "straferun":
			{
				var_426d4c5d = "uin_kls_straferun";
				break;
			}
		}
		if(isdefined(var_426d4c5d))
		{
			self playsoundtoplayer(var_426d4c5d, self);
		}
		else
		{
			self playsoundtoplayer("uin_kls_generic", self);
		}
	}
}

/*
	Name: killstreak_dialog_queued
	Namespace: killstreaks
	Checksum: 0x2E90B495
	Offset: 0x7608
	Size: 0x120
	Parameters: 3
	Flags: None
*/
function killstreak_dialog_queued(dialogkey, killstreaktype, killstreakid)
{
	if(!isdefined(dialogkey) || !isdefined(killstreaktype))
	{
		return;
	}
	if(isdefined(self.currentkillstreakdialog))
	{
		if(dialogkey === self.currentkillstreakdialog.dialogkey && killstreaktype === self.currentkillstreakdialog.killstreaktype && killstreakid === self.currentkillstreakdialog.killstreakid)
		{
			return 1;
		}
	}
	for(i = 0; i < self.killstreakdialogqueue.size; i++)
	{
		if(dialogkey === self.killstreakdialogqueue[i].dialogkey && killstreaktype === self.killstreakdialogqueue[i].killstreaktype && killstreaktype === self.killstreakdialogqueue[i].killstreaktype)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: play_killstreak_ready_dialog
	Namespace: killstreaks
	Checksum: 0x4E6CE951
	Offset: 0x7730
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function play_killstreak_ready_dialog(killstreaktype, taacomwaittime)
{
	self notify("killstreak_ready_" + killstreaktype);
	self endon(#"death", "killstreak_start_" + killstreaktype, "killstreak_ready_" + killstreaktype);
	level endon(#"game_ended");
	if(isdefined(level.gameended) && level.gameended)
	{
		return;
	}
	if(killstreak_dialog_queued("ready", killstreaktype))
	{
		return;
	}
	if(isdefined(taacomwaittime))
	{
		wait(taacomwaittime);
	}
	self play_taacom_dialog("ready", killstreaktype);
}

/*
	Name: play_taacom_dialog_on_owner
	Namespace: killstreaks
	Checksum: 0xA79DC5C0
	Offset: 0x7808
	Size: 0x7C
	Parameters: 3
	Flags: None
*/
function play_taacom_dialog_on_owner(dialogkey, killstreaktype, killstreakid)
{
	if(!isdefined(self.owner) || !isdefined(self.team) || self.team != self.owner.team)
	{
		return;
	}
	self.owner play_taacom_dialog(dialogkey, killstreaktype, killstreakid);
}

/*
	Name: play_taacom_dialog_response
	Namespace: killstreaks
	Checksum: 0xA452AF7
	Offset: 0x7890
	Size: 0x84
	Parameters: 4
	Flags: None
*/
function play_taacom_dialog_response(dialogkey, killstreaktype, killstreakid, pilotindex)
{
	/#
		assert(isdefined(dialogkey));
	#/
	/#
		assert(isdefined(killstreaktype));
	#/
	if(!isdefined(pilotindex))
	{
		return;
	}
	self play_taacom_dialog(dialogkey + pilotindex, killstreaktype, killstreakid);
}

/*
	Name: player_killstreak_threat_tracking
	Namespace: killstreaks
	Checksum: 0x227B033B
	Offset: 0x7920
	Size: 0x320
	Parameters: 1
	Flags: None
*/
function player_killstreak_threat_tracking(killstreaktype)
{
	/#
		assert(isdefined(killstreaktype));
	#/
	self endon(#"death", #"delete", #"leaving");
	level endon(#"game_ended");
	while(true)
	{
		if(!isdefined(self.owner))
		{
			return;
		}
		players = self.owner dialog_shared::get_enemy_players();
		players = array::randomize(players);
		foreach(player in players)
		{
			if(!player dialog_shared::can_play_dialog(1))
			{
				continue;
			}
			lookangles = player getplayerangles();
			if(lookangles[0] < 270 || lookangles[0] > 330)
			{
				continue;
			}
			lookdir = anglestoforward(lookangles);
			eyepoint = player geteye();
			streakdir = vectornormalize(self.origin - eyepoint);
			dot = vectordot(streakdir, lookdir);
			if(dot < 0.94)
			{
				continue;
			}
			traceresult = bullettrace(eyepoint, self.origin, 1, player);
			if(traceresult[#"fraction"] >= 1 || traceresult[#"entity"] === self)
			{
				if(dialog_shared::dialog_chance("killstreakSpotChance"))
				{
					player dialog_shared::play_killstreak_threat(killstreaktype);
				}
				wait(dialog_shared::mpdialog_value("killstreakSpotDelay", 0));
				break;
			}
		}
		wait(dialog_shared::mpdialog_value("killstreakSpotInterval", float(function_60d95f53()) / 1000));
	}
}

/*
	Name: get_killstreak_inform_dialog
	Namespace: killstreaks
	Checksum: 0xFE475E43
	Offset: 0x7C48
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function get_killstreak_inform_dialog(killstreaktype)
{
	if(isdefined(level.killstreaks[killstreaktype].informdialog))
	{
		return level.killstreaks[killstreaktype].informdialog;
	}
	return "";
}

/*
	Name: get_killstreak_usage_by_killstreak
	Namespace: killstreaks
	Checksum: 0x696D02EB
	Offset: 0x7C98
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function get_killstreak_usage_by_killstreak(killstreaktype)
{
	/#
		assert(isdefined(level.killstreaks[killstreaktype]), "");
	#/
	return get_killstreak_usage(level.killstreaks[killstreaktype].usagekey);
}

/*
	Name: get_killstreak_usage
	Namespace: killstreaks
	Checksum: 0x1BF1158E
	Offset: 0x7D08
	Size: 0x30
	Parameters: 1
	Flags: None
*/
function get_killstreak_usage(usagekey)
{
	if(!isdefined(self.pers[usagekey]))
	{
		return 0;
	}
	return self.pers[usagekey];
}

/*
	Name: on_player_spawned
	Namespace: killstreaks
	Checksum: 0x54ACCA58
	Offset: 0x7D40
	Size: 0xEE
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	pixbeginevent(#"hash_1d81325f0403ec55");
	self thread give_owned();
	self.killcamkilledbyent = undefined;
	self callback::function_f77ced93(&function_4f415d8e);
	self callback::function_f77ced93(&function_4167ea4e);
	self callback::function_20263b9e(&function_20263b9e);
	self callback::function_ce4a7c15(&function_ce4a7c15);
	self thread initialspawnprotection();
	pixendevent();
}

/*
	Name: on_joined_team
	Namespace: killstreaks
	Checksum: 0x4A6E824E
	Offset: 0x7E38
	Size: 0x166
	Parameters: 1
	Flags: None
*/
function on_joined_team(params)
{
	self endon(#"disconnect");
	self setinventoryweapon(level.weaponnone);
	self.pers[#"cur_kill_streak"] = 0;
	self.pers[#"cur_total_kill_streak"] = 0;
	self setplayercurrentstreak(0);
	self.pers[#"totalkillstreakcount"] = 0;
	self.pers[#"killstreaks"] = [];
	self.pers[#"killstreak_has_been_used"] = [];
	self.pers[#"killstreak_unique_id"] = [];
	self.pers[#"killstreak_ammo_count"] = [];
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		self.pers[#"killstreak_quantity"] = [];
		self.pers[#"held_killstreak_ammo_count"] = [];
		self.pers[#"held_killstreak_clip_count"] = [];
	}
}

/*
	Name: initialspawnprotection
	Namespace: killstreaks
	Checksum: 0x93966CBA
	Offset: 0x7FA8
	Size: 0x11C
	Parameters: 0
	Flags: Private
*/
private function initialspawnprotection()
{
	self endon(#"death", #"disconnect");
	self thread airsupport::monitorspeed(level.spawnprotectiontime);
	if(!isdefined(level.spawnprotectiontime) || level.spawnprotectiontime == 0)
	{
		return;
	}
	self.specialty_nottargetedbyairsupport = 1;
	self clientfield::set("killstreak_spawn_protection", 1);
	self val::set(#"killstreak_spawn_protection", "ignoreme", 1);
	wait(level.spawnprotectiontime);
	self clientfield::set("killstreak_spawn_protection", 0);
	self.specialty_nottargetedbyairsupport = undefined;
	self val::reset(#"killstreak_spawn_protection", "ignoreme");
}

/*
	Name: killstreak_debug_think
	Namespace: killstreaks
	Checksum: 0x31C27AD8
	Offset: 0x80D0
	Size: 0xE0
	Parameters: 0
	Flags: None
*/
function killstreak_debug_think()
{
	/#
		setdvar(#"debug_killstreak", "");
		for(;;)
		{
			cmd = getdvarstring(#"debug_killstreak");
			switch(cmd)
			{
				case "data_dump":
				{
					killstreak_data_dump();
					break;
				}
			}
			if(cmd != "")
			{
				setdvar(#"debug_killstreak", "");
			}
			wait(0.5);
		}
	#/
}

/*
	Name: killstreak_data_dump
	Namespace: killstreaks
	Checksum: 0x57AF23CE
	Offset: 0x81B8
	Size: 0x33C
	Parameters: 0
	Flags: None
*/
function killstreak_data_dump()
{
	/#
		iprintln("");
		println("");
		println("");
		keys = getarraykeys(level.killstreaks);
		for(i = 0; i < keys.size; i++)
		{
			data = level.killstreaks[keys[i]];
			type_data = level.killstreaktype[keys[i]];
			print(keys[i] + "");
			print(data.killstreaklevel + "");
			print(data.weapon.name + "");
			alt = 0;
			if(isdefined(data.altweapons))
			{
				/#
					assert(data.altweapons.size <= 4);
				#/
				for(alt = 0; alt < data.altweapons.size; alt++)
				{
					print(data.altweapons[alt].name + "");
				}
			}
			while(alt < 4)
			{
				print("");
				alt++;
			}
			type = 0;
			if(isdefined(type_data))
			{
				/#
					assert(type_data.size < 4);
				#/
				type_keys = getarraykeys(type_data);
				while(type < type_keys.size)
				{
					if(type_data[type_keys[type]] == 1)
					{
						print(type_keys[type] + "");
					}
					type++;
				}
			}
			while(type < 4)
			{
				print("");
				type++;
			}
			println("");
		}
		println("");
	#/
}

/*
	Name: function_2b6aa9e8
	Namespace: killstreaks
	Checksum: 0x3D325193
	Offset: 0x8500
	Size: 0x94
	Parameters: 4
	Flags: None
*/
function function_2b6aa9e8(killstreak_ref, destroyed_callback, low_health_callback, emp_callback)
{
	self setcandamage(1);
	self thread monitordamage(killstreak_ref, killstreak_bundles::get_max_health(killstreak_ref), destroyed_callback, killstreak_bundles::get_low_health(killstreak_ref), low_health_callback, 0, emp_callback, 1);
}

/*
	Name: monitordamage
	Namespace: killstreaks
	Checksum: 0xF79A35AD
	Offset: 0x85A0
	Size: 0x706
	Parameters: 8
	Flags: None
*/
function monitordamage(killstreak_ref, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage)
{
	self endon(#"death", #"delete");
	self setcandamage(1);
	self setup_health(killstreak_ref, max_health, low_health);
	self.health = self.maxhealth;
	self.damagetaken = 0;
	while(true)
	{
		weapon_damage = undefined;
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		damage = waitresult.amount;
		direction = waitresult.direction;
		point = waitresult.position;
		type = waitresult.mod;
		tagname = waitresult.tag_name;
		modelname = waitresult.model_name;
		partname = waitresult.part_name;
		weapon = waitresult.weapon;
		flags = waitresult.flags;
		inflictor = waitresult.inflictor;
		chargelevel = waitresult.charge_level;
		if(isdefined(self.invulnerable) && self.invulnerable)
		{
			continue;
		}
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			continue;
		}
		friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
		if(!friendlyfire)
		{
			continue;
		}
		if(isdefined(self.owner) && attacker == self.owner)
		{
			continue;
		}
		isvalidattacker = 1;
		if(level.teambased)
		{
			isvalidattacker = isdefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
		}
		if(!isvalidattacker)
		{
			continue;
		}
		if(isdefined(self.killstreakdamagemodifier))
		{
			damage = [[self.killstreakdamagemodifier]](damage, attacker, direction, point, type, tagname, modelname, partname, weapon, flags, inflictor, chargelevel);
			if(damage <= 0)
			{
				continue;
			}
		}
		if(weapon.isemp && type == "MOD_GRENADE_SPLASH")
		{
			emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
			if(!isdefined(emp_damage_to_apply))
			{
				emp_damage_to_apply = (isdefined(emp_damage) ? emp_damage : 1);
			}
			if(isdefined(emp_callback) && emp_damage_to_apply > 0)
			{
				self [[emp_callback]](attacker);
			}
			weapon_damage = emp_damage_to_apply;
		}
		if(isdefined(self.selfdestruct) && self.selfdestruct)
		{
			weapon_damage = self.maxhealth + 1;
		}
		if(!isdefined(weapon_damage))
		{
			weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
			if(!isdefined(weapon_damage))
			{
				weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
			}
		}
		if(weapon_damage > 0)
		{
			if(damagefeedback::dodamagefeedback(weapon, attacker))
			{
				if(!isvehicle(self))
				{
					attacker thread damagefeedback::update(type, undefined, undefined, weapon, self);
				}
			}
			self challenges::trackassists(attacker, weapon_damage, 0);
		}
		self.damagetaken = self.damagetaken + weapon_damage;
		if(!issentient(self) && weapon_damage > 0)
		{
			self.attacker = attacker;
		}
		if(self.damagetaken > self.maxhealth)
		{
			level.globalkillstreaksdestroyed++;
			attacker stats::function_e24eec31(getweapon(killstreak_ref), #"destroyed", 1);
			self function_73566ec7(attacker, weapon, self.owner);
			if(isdefined(destroyed_callback))
			{
				self thread [[destroyed_callback]](attacker, weapon);
			}
			return;
		}
		remaining_health = max_health - self.damagetaken;
		if(remaining_health < low_health && weapon_damage > 0)
		{
			if(isdefined(low_health_callback) && (!isdefined(self.currentstate) || self.currentstate != "damaged"))
			{
				self [[low_health_callback]](attacker, weapon);
			}
			self.currentstate = "damaged";
		}
		if(isdefined(self.extra_low_health) && remaining_health < self.extra_low_health && weapon_damage > 0)
		{
			if(isdefined(self.extra_low_health_callback) && !isdefined(self.extra_low_damage_notified))
			{
				self [[self.extra_low_health_callback]](attacker, weapon);
				self.extra_low_damage_notified = 1;
			}
		}
	}
}

/*
	Name: function_73566ec7
	Namespace: killstreaks
	Checksum: 0xBBCCF197
	Offset: 0x8CB0
	Size: 0x3B8
	Parameters: 3
	Flags: None
*/
function function_73566ec7(attacker, weapon, owner)
{
	if(!isdefined(self) || (isdefined(self.var_c5bb583d) && self.var_c5bb583d) || !isdefined(attacker) || !isplayer(attacker) || !isdefined(self.killstreaktype) || self.team === attacker.team)
	{
		return;
	}
	bundle = level.killstreakbundle[self.killstreaktype];
	if(isdefined(bundle) && isdefined(bundle.var_ebd92bbc))
	{
		scoreevents::processscoreevent(bundle.var_ebd92bbc, attacker, owner, weapon);
		attacker stats::function_dad108fa(#"stats_destructions", 1);
		attacker contracts::function_a54e2068(#"hash_317a8b8df3aa8838");
		self.var_c5bb583d = 1;
		if(isdefined(self.attackers) && self.attackers.size > 0)
		{
			maxhealth = 1 / self.maxhealth;
			if(!isdefined(bundle.var_74711af9))
			{
				return;
			}
			foreach(assister in self.attackers)
			{
				if(assister == attacker || !isplayer(assister) || !util::function_fbce7263(self.team, assister.team))
				{
					continue;
				}
				if(isdefined(bundle.var_93f7b1ae) && isdefined(self.attackerdamage))
				{
					timepassed = float(gettime() - self.attackerdamage[assister.clientid].lastdamagetime) / 1000;
					if(timepassed > bundle.var_93f7b1ae)
					{
						continue;
					}
				}
				if(isdefined(bundle.var_ebcd245a) && isdefined(self.attackerdamage))
				{
					damagepercent = self.attackerdamage[assister.clientid].damage * maxhealth;
					if(damagepercent < bundle.var_ebcd245a)
					{
						continue;
					}
				}
				scoreevents::processscoreevent(bundle.var_74711af9, assister, owner, self.attackerdamage[assister.clientid].weapon);
				assister stats::function_dad108fa(#"stats_destructions", 1);
				assister contracts::function_a54e2068(#"hash_317a8b8df3aa8838");
			}
		}
	}
}

/*
	Name: ondamageperweapon
	Namespace: killstreaks
	Checksum: 0xF5FD7D12
	Offset: 0x9070
	Size: 0x394
	Parameters: 15
	Flags: None
*/
function ondamageperweapon(killstreak_ref, attacker, damage, flags, type, weapon, max_health, destroyed_callback, low_health, low_health_callback, emp_damage, emp_callback, allow_bullet_damage, chargelevel, var_488beb6d)
{
	self.maxhealth = max_health;
	self.lowhealth = low_health;
	tablehealth = killstreak_bundles::get_max_health(killstreak_ref);
	if(isdefined(tablehealth))
	{
		self.maxhealth = tablehealth;
	}
	tablehealth = killstreak_bundles::get_low_health(killstreak_ref);
	if(isdefined(tablehealth))
	{
		self.lowhealth = tablehealth;
	}
	if(isdefined(self.invulnerable) && self.invulnerable)
	{
		return 0;
	}
	if(!isdefined(attacker) || !isplayer(attacker))
	{
		return get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
	}
	friendlyfire = damage::friendlyfirecheck(self.owner, attacker);
	if(!friendlyfire)
	{
		return 0;
	}
	if(!(isdefined(var_488beb6d) && var_488beb6d))
	{
		isvalidattacker = 1;
		if(level.teambased)
		{
			isvalidattacker = isdefined(attacker.team) && util::function_fbce7263(attacker.team, self.team);
		}
		if(!isvalidattacker)
		{
			return 0;
		}
	}
	if(weapon.isemp && type == "MOD_GRENADE_SPLASH")
	{
		emp_damage_to_apply = killstreak_bundles::get_emp_grenade_damage(killstreak_ref, self.maxhealth);
		if(!isdefined(emp_damage_to_apply))
		{
			emp_damage_to_apply = (isdefined(emp_damage) ? emp_damage : 1);
		}
		if(isdefined(emp_callback) && emp_damage_to_apply > 0)
		{
			self [[emp_callback]](attacker, weapon);
		}
		return emp_damage_to_apply;
	}
	weapon_damage = killstreak_bundles::get_weapon_damage(killstreak_ref, self.maxhealth, attacker, weapon, type, damage, flags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = get_old_damage(attacker, weapon, type, damage, allow_bullet_damage);
	}
	if(!isdefined(weapon_damage) || weapon_damage <= 0)
	{
		return 0;
	}
	idamage = int(weapon_damage);
	if(idamage > self.health)
	{
		self function_73566ec7(attacker, weapon, self.owner);
		if(isdefined(destroyed_callback))
		{
			self thread [[destroyed_callback]](attacker, weapon);
		}
	}
	return idamage;
}

/*
	Name: get_old_damage
	Namespace: killstreaks
	Checksum: 0x9614D753
	Offset: 0x9410
	Size: 0x246
	Parameters: 6
	Flags: None
*/
function get_old_damage(attacker, weapon, type, damage, allow_bullet_damage, bullet_damage_scalar)
{
	switch(type)
	{
		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		{
			if(!allow_bullet_damage)
			{
				damage = 0;
				break;
			}
			if(isdefined(attacker) && isplayer(attacker))
			{
				hasfmj = attacker hasperk(#"specialty_armorpiercing");
			}
			if(isdefined(hasfmj) && hasfmj)
			{
				damage = int(damage * level.cac_armorpiercing_data);
			}
			if(isdefined(bullet_damage_scalar))
			{
				damage = int(damage * bullet_damage_scalar);
			}
			break;
		}
		case "mod_explosive":
		case "mod_projectile":
		case "mod_projectile_splash":
		{
			if(weapon.statindex == level.weaponpistolenergy.statindex || weapon.statindex != level.weaponshotgunenergy.statindex || weapon.statindex == level.weaponspecialcrossbow.statindex)
			{
				break;
			}
			if(isdefined(self.remotemissiledamage) && isdefined(weapon) && weapon.name == #"remote_missile_missile")
			{
				damage = self.remotemissiledamage;
			}
			else if(isdefined(self.rocketdamage))
			{
				damage = self.rocketdamage;
			}
			break;
		}
		default:
		{
			break;
		}
	}
	return damage;
}

/*
	Name: isheldinventorykillstreakweapon
	Namespace: killstreaks
	Checksum: 0xAEC8DCEA
	Offset: 0x9660
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function isheldinventorykillstreakweapon(killstreakweapon)
{
	switch(killstreakweapon.name)
	{
		case "inventory_m32":
		case "inventory_minigun":
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: waitfortimecheck
	Namespace: killstreaks
	Checksum: 0x59BAEABB
	Offset: 0x96B8
	Size: 0xAC
	Parameters: 5
	Flags: None
*/
function waitfortimecheck(duration, callback, endcondition1, endcondition2, endcondition3)
{
	self endon(#"hacked");
	if(isdefined(endcondition1))
	{
		self endon(endcondition1);
	}
	if(isdefined(endcondition2))
	{
		self endon(endcondition2);
	}
	if(isdefined(endcondition3))
	{
		self endon(endcondition3);
	}
	hostmigration::migrationawarewait(duration);
	self notify(#"time_check");
	self [[callback]]();
}

/*
	Name: emp_isempd
	Namespace: killstreaks
	Checksum: 0x463640D5
	Offset: 0x9770
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function emp_isempd()
{
	if(isdefined(level.var_707cab08.enemyempactivefunc))
	{
		return self [[level.var_707cab08.enemyempactivefunc]]();
	}
	return 0;
}

/*
	Name: waittillemp
	Namespace: killstreaks
	Checksum: 0xAE381FC1
	Offset: 0x97B8
	Size: 0x7C
	Parameters: 2
	Flags: None
*/
function waittillemp(onempdcallback, arg)
{
	self endon(#"death", #"delete");
	waitresult = undefined;
	waitresult = self waittill(#"emp_deployed");
	if(isdefined(onempdcallback))
	{
		[[onempdcallback]](waitresult.attacker, arg);
	}
}

/*
	Name: destroyotherteamsequipment
	Namespace: killstreaks
	Checksum: 0x8FE0A48A
	Offset: 0x9840
	Size: 0x12C
	Parameters: 3
	Flags: None
*/
function destroyotherteamsequipment(attacker, weapon, radius)
{
	foreach(team, _ in level.teams)
	{
		if(!util::function_fbce7263(team, attacker.team))
		{
			continue;
		}
		destroyequipment(attacker, team, weapon, radius);
		destroytacticalinsertions(attacker, team, radius);
	}
	destroyequipment(attacker, "free", weapon, radius);
	destroytacticalinsertions(attacker, "free", radius);
}

/*
	Name: destroyequipment
	Namespace: killstreaks
	Checksum: 0x7E9D5430
	Offset: 0x9978
	Size: 0x1DE
	Parameters: 4
	Flags: None
*/
function destroyequipment(attacker, team, weapon, radius)
{
	radiussq = radius * radius;
	for(i = 0; i < level.missileentities.size; i++)
	{
		item = level.missileentities[i];
		if(!isdefined(item))
		{
			continue;
		}
		if(distancesquared(item.origin, attacker.origin) > radiussq)
		{
			continue;
		}
		if(!isdefined(item.weapon))
		{
			continue;
		}
		if(!isdefined(item.owner))
		{
			continue;
		}
		if(isdefined(team) && util::function_fbce7263(item.owner.team, team))
		{
			continue;
		}
		else if(item.owner == attacker)
		{
			continue;
		}
		if(!item.weapon.isequipment && (!(isdefined(item.destroyedbyemp) && item.destroyedbyemp)))
		{
			continue;
		}
		watcher = item.owner weaponobjects::getwatcherforweapon(item.weapon);
		if(!isdefined(watcher))
		{
			continue;
		}
		watcher thread weaponobjects::waitanddetonate(item, 0, attacker, weapon);
	}
}

/*
	Name: destroytacticalinsertions
	Namespace: killstreaks
	Checksum: 0x19ED56A8
	Offset: 0x9B60
	Size: 0x11E
	Parameters: 3
	Flags: None
*/
function destroytacticalinsertions(attacker, victimteam, radius)
{
	radiussq = radius * radius;
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(!isdefined(player.tacticalinsertion))
		{
			continue;
		}
		if(level.teambased && util::function_fbce7263(player.team, victimteam))
		{
			continue;
		}
		if(attacker == player)
		{
			continue;
		}
		if(distancesquared(player.origin, attacker.origin) < radiussq)
		{
			player.tacticalinsertion thread tacticalinsertion::fizzle();
		}
	}
}

/*
	Name: destroyotherteamsactivevehicles
	Namespace: killstreaks
	Checksum: 0x275AA921
	Offset: 0x9C88
	Size: 0xC8
	Parameters: 3
	Flags: None
*/
function destroyotherteamsactivevehicles(attacker, weapon, radius)
{
	foreach(team, _ in level.teams)
	{
		if(!util::function_fbce7263(team, attacker.team))
		{
			continue;
		}
		destroyactivevehicles(attacker, team, weapon, radius);
	}
}

/*
	Name: destroyactivevehicles
	Namespace: killstreaks
	Checksum: 0x7292F5EC
	Offset: 0x9D58
	Size: 0xC04
	Parameters: 4
	Flags: None
*/
function destroyactivevehicles(attacker, team, weapon, radius)
{
	radiussq = radius * radius;
	targets = target_getarray();
	destroyentities(targets, attacker, team, weapon, radius);
	ai_tanks = getentarray("talon", "targetname");
	destroyentities(ai_tanks, attacker, team, weapon, radius);
	remotemissiles = getentarray("remote_missile", "targetname");
	destroyentities(remotemissiles, attacker, team, weapon, radius);
	remotedrone = getentarray("remote_drone", "targetname");
	destroyentities(remotedrone, attacker, team, weapon, radius);
	script_vehicles = getentarray("script_vehicle", "classname");
	foreach(vehicle in script_vehicles)
	{
		if(distancesquared(vehicle.origin, attacker.origin) > radiussq)
		{
			continue;
		}
		if(isdefined(team) && !util::function_fbce7263(vehicle.team, team) && isvehicle(vehicle))
		{
			if(isdefined(vehicle.detonateviaemp) && (isdefined(weapon.isempkillstreak) && weapon.isempkillstreak))
			{
				vehicle [[vehicle.detonateviaemp]](attacker, weapon);
			}
			if(isdefined(vehicle.archetype))
			{
				if(vehicle.archetype == "turret" || vehicle.archetype == "rcbomb" || vehicle.archetype == "wasp")
				{
					vehicle dodamage(vehicle.health + 1, vehicle.origin, attacker, attacker, "", "MOD_EXPLOSIVE", 0, weapon);
				}
			}
		}
	}
	planemortars = getentarray("plane_mortar", "targetname");
	foreach(planemortar in planemortars)
	{
		if(distance2d(planemortar.origin, attacker.origin) > radius)
		{
			continue;
		}
		if(isdefined(team) && isdefined(planemortar.team))
		{
			if(util::function_fbce7263(planemortar.team, team))
			{
				continue;
			}
		}
		else if(planemortar.owner == attacker)
		{
			continue;
		}
		planemortar notify(#"emp_deployed", {#attacker:attacker});
	}
	dronestrikes = getentarray("drone_strike", "targetname");
	foreach(dronestrike in dronestrikes)
	{
		if(distance2d(dronestrike.origin, attacker.origin) > radius)
		{
			continue;
		}
		if(isdefined(team) && isdefined(dronestrike.team))
		{
			if(util::function_fbce7263(dronestrike.team, team))
			{
				continue;
			}
		}
		else if(dronestrike.owner == attacker)
		{
			continue;
		}
		dronestrike notify(#"emp_deployed", {#attacker:attacker});
	}
	var_eca5110 = getentarray("guided_artillery_shell", "targetname");
	foreach(shell in var_eca5110)
	{
		if(distance2d(shell.origin, attacker.origin) > radius)
		{
			continue;
		}
		if(isdefined(team) && isdefined(shell.team))
		{
			if(util::function_fbce7263(shell.team, team))
			{
				continue;
			}
		}
		else if(shell.owner == attacker)
		{
			continue;
		}
		shell notify(#"emp_deployed", {#attacker:attacker});
	}
	counteruavs = getentarray("counteruav", "targetname");
	foreach(counteruav in counteruavs)
	{
		if(distance2d(counteruav.origin, attacker.origin) > radius)
		{
			continue;
		}
		if(isdefined(team) && isdefined(counteruav.team))
		{
			if(util::function_fbce7263(counteruav.team, team))
			{
				continue;
			}
		}
		else if(counteruav.owner == attacker)
		{
			continue;
		}
		counteruav notify(#"emp_deployed", {#attacker:attacker});
	}
	satellites = getentarray("satellite", "targetname");
	foreach(satellite in satellites)
	{
		if(distance2d(satellite.origin, attacker.origin) > radius)
		{
			continue;
		}
		if(isdefined(team) && isdefined(satellite.team))
		{
			if(util::function_fbce7263(satellite.team, team))
			{
				continue;
			}
		}
		else if(satellite.owner == attacker)
		{
			continue;
		}
		satellite notify(#"emp_deployed", {#attacker:attacker});
	}
	robots = getaiarchetypearray("robot");
	foreach(robot in robots)
	{
		if(distancesquared(robot.origin, attacker.origin) > radiussq)
		{
			continue;
		}
		if(robot.allowdeath !== 0 && robot.magic_bullet_shield !== 1 && isdefined(team) && !util::function_fbce7263(robot.team, team))
		{
			if(isdefined(attacker) && (!isdefined(robot.owner) || robot.owner util::isenemyplayer(attacker)))
			{
				scoreevents::processscoreevent(#"destroyed_combat_robot", attacker, robot.owner, weapon);
				luinotifyevent(#"player_callout", 2, #"hash_3b274c8c3c961f3", attacker.entnum);
			}
			robot kill();
		}
	}
	if(isdefined(level.missile_swarm_owner))
	{
		if(level.missile_swarm_owner util::isenemyplayer(attacker))
		{
			if(distancesquared(level.missile_swarm_owner.origin, attacker.origin) < radiussq)
			{
				level.missile_swarm_owner notify(#"emp_destroyed_missile_swarm", {#attacker:attacker});
			}
		}
	}
}

/*
	Name: destroyentities
	Namespace: killstreaks
	Checksum: 0x308E6B06
	Offset: 0xA968
	Size: 0x26C
	Parameters: 5
	Flags: None
*/
function destroyentities(entities, attacker, team, weapon, radius)
{
	meansofdeath = "MOD_EXPLOSIVE";
	damage = 5000;
	direction_vec = (0, 0, 0);
	point = (0, 0, 0);
	modelname = "";
	tagname = "";
	partname = "";
	radiussq = radius * radius;
	foreach(entity in entities)
	{
		if(isdefined(team) && isdefined(entity.team))
		{
			if(util::function_fbce7263(entity.team, team))
			{
				continue;
			}
		}
		else if(isdefined(entity.owner) && entity.owner == attacker)
		{
			continue;
		}
		if(distancesquared(entity.origin, attacker.origin) < radiussq)
		{
			entity notify(#"damage", {#weapon:weapon, #part_name:partname, #model_name:modelname, #tag_name:tagname, #mod:meansofdeath, #position:point, #direction:direction_vec, #attacker:attacker, #amount:damage});
		}
	}
}

/*
	Name: get_killstreak_for_weapon
	Namespace: killstreaks
	Checksum: 0x6FF20849
	Offset: 0xABE0
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function get_killstreak_for_weapon(weapon)
{
	if(!isdefined(level.killstreakweapons))
	{
		return undefined;
	}
	if(isdefined(level.killstreakweapons[weapon]))
	{
		return level.killstreakweapons[weapon];
	}
	return level.killstreakweapons[weapon.rootweapon];
}

/*
	Name: is_killstreak_weapon_assist_allowed
	Namespace: killstreaks
	Checksum: 0x1791B548
	Offset: 0xAC50
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function is_killstreak_weapon_assist_allowed(weapon)
{
	killstreak = get_killstreak_for_weapon(weapon);
	if(!isdefined(killstreak))
	{
		return 0;
	}
	if(level.killstreaks[killstreak].allowassists)
	{
		return 1;
	}
	return 0;
}

/*
	Name: should_override_entity_camera_in_demo
	Namespace: killstreaks
	Checksum: 0x49FB5665
	Offset: 0xACB8
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function should_override_entity_camera_in_demo(player, weapon)
{
	killstreak = get_killstreak_for_weapon(weapon);
	if(!isdefined(killstreak))
	{
		return 0;
	}
	if(level.killstreaks[killstreak].overrideentitycameraindemo)
	{
		return 1;
	}
	if(isdefined(player.remoteweapon) && (isdefined(player.remoteweapon.controlled) && player.remoteweapon.controlled))
	{
		return 1;
	}
	return 0;
}

/*
	Name: watch_for_remove_remote_weapon
	Namespace: killstreaks
	Checksum: 0xDB20C792
	Offset: 0xAD70
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function watch_for_remove_remote_weapon()
{
	self endon(#"endwatchforremoveremoteweapon");
	for(;;)
	{
		self waittill(#"remove_remote_weapon");
		self switch_to_last_non_killstreak_weapon();
		self enableusability();
	}
}

/*
	Name: clear_using_remote
	Namespace: killstreaks
	Checksum: 0x30A73597
	Offset: 0xADD0
	Size: 0x154
	Parameters: 3
	Flags: None
*/
function clear_using_remote(immediate, skipnotify, gameended)
{
	if(!isdefined(self))
	{
		return;
	}
	self.dofutz = 0;
	self.no_fade2black = 0;
	self clientfield::set_to_player("static_postfx", 0);
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 1;
	}
	self.usingremote = undefined;
	self reset_killstreak_delay_killcam();
	self enableoffhandweapons();
	self enableweaponcycling();
	curweapon = self getcurrentweapon();
	if(isalive(self))
	{
		self switch_to_last_non_killstreak_weapon(immediate, undefined, gameended);
	}
	if(!(isdefined(skipnotify) && skipnotify))
	{
		self notify(#"stopped_using_remote");
	}
	thread hide_tablet();
}

/*
	Name: hide_tablet
	Namespace: killstreaks
	Checksum: 0xDD9E6BA
	Offset: 0xAF30
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function hide_tablet()
{
	self endon(#"disconnect");
	wait(0.2);
}

/*
	Name: reset_killstreak_delay_killcam
	Namespace: killstreaks
	Checksum: 0xF94B6B5F
	Offset: 0xAF58
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function reset_killstreak_delay_killcam()
{
	self.killstreak_delay_killcam = undefined;
}

/*
	Name: init_ride_killstreak
	Namespace: killstreaks
	Checksum: 0x1D6B270
	Offset: 0xAF70
	Size: 0x78
	Parameters: 2
	Flags: None
*/
function init_ride_killstreak(streak, always_allow = 0)
{
	self disableusability();
	result = self init_ride_killstreak_internal(streak, always_allow);
	if(isdefined(self))
	{
		self enableusability();
	}
	return result;
}

/*
	Name: init_ride_killstreak_internal
	Namespace: killstreaks
	Checksum: 0x75CD999
	Offset: 0xAFF0
	Size: 0x4DA
	Parameters: 2
	Flags: None
*/
function init_ride_killstreak_internal(streak, always_allow)
{
	var_5df1cb97 = 0;
	if(isdefined(streak) && (streak == "dart" || streak == "killstreak_remote_turret" || streak == "killstreak_ai_tank" || streak == "qrdrone" || streak == "sentinel" || streak == "recon_car"))
	{
		laptopwait = "timeout";
	}
	else if(isdefined(streak) && streak == "remote_missile")
	{
		laptopwait = "timeout";
		var_5df1cb97 = getdvarfloat(#"hash_409036e81396b597", 0.075);
	}
	else
	{
		laptopwait = undefined;
		laptopwait = self waittill_timeout(0.2, #"disconnect", #"death", #"weapon_switch_started");
		laptopwait = laptopwait._notify;
	}
	hostmigration::waittillhostmigrationdone();
	if(laptopwait == "weapon_switch_started")
	{
		return "fail";
	}
	if(!isalive(self) && !always_allow)
	{
		return "fail";
	}
	if(laptopwait == "disconnect" || laptopwait == "death")
	{
		if(laptopwait == "disconnect")
		{
			return "disconnect";
		}
		if(!isdefined(self.team) || self.team == #"spectator")
		{
			return "fail";
		}
		return "success";
	}
	if(self isempjammed() && (!(isdefined(self.ignoreempjammed) && self.ignoreempjammed)))
	{
		return "fail";
	}
	if(self is_interacting_with_object())
	{
		return "fail";
	}
	self thread hud::fade_to_black_for_x_sec(0, 0.2 + var_5df1cb97, 0.1, 0.1);
	self thread watch_for_remove_remote_weapon();
	blackoutwait = undefined;
	blackoutwait = self waittill_timeout(0.2, #"disconnect", #"death");
	self notify(#"endwatchforremoveremoteweapon");
	hostmigration::waittillhostmigrationdone();
	if(blackoutwait._notify != "disconnect")
	{
		self thread clear_ride_intro(1);
		if(!isdefined(self.team) || self.team == #"spectator")
		{
			return "fail";
		}
	}
	if(always_allow)
	{
		if(blackoutwait._notify == "disconnect")
		{
			return "disconnect";
		}
		return "success";
	}
	if(self isonladder())
	{
		return "fail";
	}
	if(!isalive(self))
	{
		return "fail";
	}
	if(self isempjammed() && (!(isdefined(self.ignoreempjammed) && self.ignoreempjammed)))
	{
		return "fail";
	}
	if(isdefined(self.laststand) && self.laststand)
	{
		return "fail";
	}
	if(self is_interacting_with_object())
	{
		return "fail";
	}
	if(blackoutwait._notify == "disconnect")
	{
		return "disconnect";
	}
	return "success";
}

/*
	Name: clear_ride_intro
	Namespace: killstreaks
	Checksum: 0xC35525FE
	Offset: 0xB4D8
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function clear_ride_intro(delay)
{
	self endon(#"disconnect");
	if(isdefined(delay))
	{
		wait(delay);
	}
	self thread hud::screen_fade_in(0);
}

/*
	Name: is_interacting_with_object
	Namespace: killstreaks
	Checksum: 0x5D3BFB56
	Offset: 0xB528
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function is_interacting_with_object()
{
	if(self iscarryingturret())
	{
		return 1;
	}
	if(isdefined(self.isplanting) && self.isplanting)
	{
		return 1;
	}
	if(isdefined(self.isdefusing) && self.isdefusing)
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_random_pilot_index
	Namespace: killstreaks
	Checksum: 0x3657744C
	Offset: 0xB598
	Size: 0xE2
	Parameters: 1
	Flags: None
*/
function get_random_pilot_index(killstreaktype)
{
	if(!isdefined(killstreaktype))
	{
		return undefined;
	}
	if(!isdefined(self.pers[#"mptaacom"]))
	{
		return undefined;
	}
	taacombundle = get_mpdialog_tacom_bundle(self.pers[#"mptaacom"]);
	if(!isdefined(taacombundle) || !isdefined(taacombundle.pilotbundles))
	{
		return undefined;
	}
	if(!isdefined(taacombundle.pilotbundles[killstreaktype]))
	{
		return undefined;
	}
	numpilots = taacombundle.pilotbundles[killstreaktype].size;
	if(numpilots <= 0)
	{
		return undefined;
	}
	return randomint(numpilots);
}

/*
	Name: get_mpdialog_tacom_bundle
	Namespace: killstreaks
	Checksum: 0x53B8C27B
	Offset: 0xB688
	Size: 0x30
	Parameters: 1
	Flags: None
*/
function get_mpdialog_tacom_bundle(name)
{
	if(!isdefined(level.tacombundles))
	{
		return undefined;
	}
	return level.tacombundles[name];
}

/*
	Name: hide_compass
	Namespace: killstreaks
	Checksum: 0x68901E7
	Offset: 0xB6C0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function hide_compass()
{
	self clientfield::set("killstreak_hides_compass", 1);
}

/*
	Name: unhide_compass
	Namespace: killstreaks
	Checksum: 0x3CF65802
	Offset: 0xB6F0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function unhide_compass()
{
	self clientfield::set("killstreak_hides_compass", 0);
}

/*
	Name: setup_health
	Namespace: killstreaks
	Checksum: 0x52EB398D
	Offset: 0xB720
	Size: 0xEE
	Parameters: 3
	Flags: None
*/
function setup_health(killstreak_ref, max_health, low_health)
{
	self.maxhealth = max_health;
	self.lowhealth = low_health;
	self.hackedhealthupdatecallback = &defaulthackedhealthupdatecallback;
	tablemaxhealth = killstreak_bundles::get_max_health(killstreak_ref);
	if(isdefined(tablemaxhealth))
	{
		self.maxhealth = tablemaxhealth;
	}
	tablelowhealth = killstreak_bundles::get_low_health(killstreak_ref);
	if(isdefined(tablelowhealth))
	{
		self.lowhealth = tablelowhealth;
	}
	tablehackedhealth = killstreak_bundles::get_hacked_health(killstreak_ref);
	if(isdefined(tablehackedhealth))
	{
		self.hackedhealth = tablehackedhealth;
	}
	else
	{
		self.hackedhealth = self.maxhealth;
	}
}

/*
	Name: defaulthackedhealthupdatecallback
	Namespace: killstreaks
	Checksum: 0xF6B89FE9
	Offset: 0xB818
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function defaulthackedhealthupdatecallback(hacker)
{
	killstreak = self;
	/#
		assert(isdefined(self.maxhealth));
	#/
	/#
		assert(isdefined(self.hackedhealth));
	#/
	/#
		assert(isdefined(self.damagetaken));
	#/
	damageafterhacking = self.maxhealth - self.hackedhealth;
	if(self.damagetaken < damageafterhacking)
	{
		self.damagetaken = damageafterhacking;
	}
}

/*
	Name: function_8cd96439
	Namespace: killstreaks
	Checksum: 0xD3EF1564
	Offset: 0xB8D8
	Size: 0x1B0
	Parameters: 19
	Flags: None
*/
function function_8cd96439(killstreakref, killstreakid, onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately = 0)
{
	player = self;
	placeable = placeables::spawnplaceable(onplacecallback, oncancelcallback, onmovecallback, onshutdowncallback, ondeathcallback, onempcallback, undefined, undefined, model, validmodel, invalidmodel, spawnsvehicle, pickupstring, timeout, health, empdamage, placehintstring, invalidlocationhintstring, placeimmediately, &function_84da1341);
	if(isdefined(placeable.othermodel))
	{
		placeable.othermodel clientfield::set("enemyvehicle", 1);
	}
	placeable.killstreakref = killstreakref;
	placeable.killstreakid = killstreakid;
	placeable configure_team(killstreakref, killstreakid, player);
	return placeable;
}

/*
	Name: function_84da1341
	Namespace: killstreaks
	Checksum: 0xA99B2F6
	Offset: 0xBA90
	Size: 0x88
	Parameters: 4
	Flags: None
*/
function function_84da1341(damagecallback, var_b6f10e7c, var_1891d3cd, var_2053fdc6)
{
	waitframe(1);
	placeable = self;
	if(isdefined(level.var_8ddb1b0e))
	{
		placeable thread [[level.var_8ddb1b0e]](placeable.killstreakref, placeable.health, var_b6f10e7c, 0, undefined, var_1891d3cd, var_2053fdc6, 1);
	}
}

/*
	Name: configure_team
	Namespace: killstreaks
	Checksum: 0x47404EA4
	Offset: 0xBB20
	Size: 0xCC
	Parameters: 7
	Flags: None
*/
function configure_team(killstreaktype, killstreakid, owner, influencertype, configureteamprefunction, configureteampostfunction, ishacked = 0)
{
	killstreak = self;
	killstreak.killstreaktype = killstreaktype;
	killstreak.killstreakid = killstreakid;
	killstreak _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction);
	killstreak configure_team_internal(owner, ishacked);
	owner thread trackactivekillstreak(killstreak);
}

/*
	Name: configure_team_internal
	Namespace: killstreaks
	Checksum: 0x553B6B49
	Offset: 0xBBF8
	Size: 0x218
	Parameters: 2
	Flags: None
*/
function configure_team_internal(owner, ishacked)
{
	killstreak = self;
	if(ishacked == 0)
	{
		killstreak.originalowner = owner;
		killstreak.originalteam = owner.team;
		/#
		#/
	}
	assert(killstreak.killstreakteamconfigured, "");
	if(isdefined(killstreak.killstreakconfigureteamprefunction))
	{
		killstreak thread [[killstreak.killstreakconfigureteamprefunction]](owner, ishacked);
	}
	if(isdefined(killstreak.killstreakinfluencertype))
	{
		killstreak influencers::remove_influencers();
	}
	if(!isdefined(owner) || !isdefined(owner.team))
	{
		return;
	}
	killstreak setteam(owner.team);
	killstreak.team = owner.team;
	if(!isai(killstreak))
	{
		killstreak setowner(owner);
	}
	killstreak.owner = owner;
	killstreak.ownerentnum = owner.entnum;
	killstreak.pilotindex = killstreak.owner get_random_pilot_index(killstreak.killstreaktype);
	if(isdefined(killstreak.killstreakinfluencertype))
	{
		killstreak influencers::create_entity_enemy_influencer(killstreak.killstreakinfluencertype, owner.team);
	}
	if(isdefined(killstreak.killstreakconfigureteampostfunction))
	{
		killstreak thread [[killstreak.killstreakconfigureteampostfunction]](owner, ishacked);
	}
}

/*
	Name: _setup_configure_team_callbacks
	Namespace: killstreaks
	Checksum: 0x7EF006CD
	Offset: 0xBE18
	Size: 0x6A
	Parameters: 3
	Flags: Private
*/
private function _setup_configure_team_callbacks(influencertype, configureteamprefunction, configureteampostfunction)
{
	killstreak = self;
	killstreak.killstreakteamconfigured = 1;
	killstreak.killstreakinfluencertype = influencertype;
	killstreak.killstreakconfigureteamprefunction = configureteamprefunction;
	killstreak.killstreakconfigureteampostfunction = configureteampostfunction;
}

/*
	Name: trackactivekillstreak
	Namespace: killstreaks
	Checksum: 0xCDC57544
	Offset: 0xBE90
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function trackactivekillstreak(killstreak)
{
	killstreakindex = killstreak.killstreakid;
	if(isdefined(self) && isdefined(self.pers) && isdefined(killstreakindex))
	{
		self endon(#"disconnect");
		self.pers[#"activekillstreaks"][killstreakindex] = killstreak;
		killstreak waittill(#"killstreak_hacked", #"death");
		self.pers[#"activekillstreaks"][killstreakindex] = undefined;
	}
}

/*
	Name: play_killstreak_firewall_being_hacked_dialog
	Namespace: killstreaks
	Checksum: 0x85697C5F
	Offset: 0xBF50
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function play_killstreak_firewall_being_hacked_dialog(killstreaktype, killstreakid)
{
	if(isdefined(level.play_killstreak_firewall_being_hacked_dialog))
	{
		self [[level.play_killstreak_firewall_being_hacked_dialog]](killstreaktype, killstreakid);
	}
}

/*
	Name: play_killstreak_firewall_hacked_dialog
	Namespace: killstreaks
	Checksum: 0xFAED37C0
	Offset: 0xBF98
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function play_killstreak_firewall_hacked_dialog(killstreaktype, killstreakid)
{
	if(isdefined(level.play_killstreak_firewall_hacked_dialog))
	{
		self [[level.play_killstreak_firewall_hacked_dialog]](killstreaktype, killstreakid);
	}
}

/*
	Name: play_killstreak_being_hacked_dialog
	Namespace: killstreaks
	Checksum: 0x72F86D3
	Offset: 0xBFE0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function play_killstreak_being_hacked_dialog(killstreaktype, killstreakid)
{
	if(isdefined(level.play_killstreak_being_hacked_dialog))
	{
		self [[level.play_killstreak_being_hacked_dialog]](killstreaktype, killstreakid);
	}
}

/*
	Name: play_killstreak_hacked_dialog
	Namespace: killstreaks
	Checksum: 0x69366C5A
	Offset: 0xC028
	Size: 0x48
	Parameters: 3
	Flags: None
*/
function play_killstreak_hacked_dialog(killstreaktype, killstreakid, hacker)
{
	if(isdefined(level.play_killstreak_hacked_dialog))
	{
		self [[level.play_killstreak_hacked_dialog]](killstreaktype, killstreakid, hacker);
	}
}

/*
	Name: play_killstreak_start_dialog
	Namespace: killstreaks
	Checksum: 0xFE499411
	Offset: 0xC078
	Size: 0x48
	Parameters: 3
	Flags: None
*/
function play_killstreak_start_dialog(hardpointtype, team, killstreak_id)
{
	if(isdefined(level.play_killstreak_start_dialog))
	{
		self [[level.play_killstreak_start_dialog]](hardpointtype, team, killstreak_id);
	}
}

/*
	Name: play_pilot_dialog
	Namespace: killstreaks
	Checksum: 0xFBF4E22D
	Offset: 0xC0C8
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function play_pilot_dialog(dialogkey, killstreaktype, killstreakid, pilotindex)
{
	if(isdefined(level.play_pilot_dialog))
	{
		self [[level.play_pilot_dialog]](dialogkey, killstreaktype, killstreakid, pilotindex);
	}
}

/*
	Name: play_pilot_dialog_on_owner
	Namespace: killstreaks
	Checksum: 0x106DE477
	Offset: 0xC128
	Size: 0x48
	Parameters: 3
	Flags: None
*/
function play_pilot_dialog_on_owner(dialogkey, killstreaktype, killstreakid)
{
	if(isdefined(level.play_pilot_dialog_on_owner))
	{
		self [[level.play_pilot_dialog_on_owner]](dialogkey, killstreaktype, killstreakid);
	}
}

/*
	Name: play_destroyed_dialog_on_owner
	Namespace: killstreaks
	Checksum: 0x3475B4F8
	Offset: 0xC178
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function play_destroyed_dialog_on_owner(killstreaktype, killstreakid)
{
	if(isdefined(level.play_destroyed_dialog_on_owner))
	{
		self [[level.play_destroyed_dialog_on_owner]](killstreaktype, killstreakid);
	}
}

/*
	Name: play_taacom_dialog
	Namespace: killstreaks
	Checksum: 0xA6933B7
	Offset: 0xC1C0
	Size: 0x78
	Parameters: 7
	Flags: None
*/
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, var_46bd7973, var_8a6b001a, weapon, priority)
{
	if(isdefined(level.play_taacom_dialog))
	{
		self [[level.play_taacom_dialog]](dialogkey, killstreaktype, killstreakid, var_46bd7973, var_8a6b001a, weapon, priority);
	}
}

/*
	Name: play_taacom_dialog_response_on_owner
	Namespace: killstreaks
	Checksum: 0xFD42B25D
	Offset: 0xC240
	Size: 0x48
	Parameters: 3
	Flags: None
*/
function play_taacom_dialog_response_on_owner(dialogkey, killstreaktype, killstreakid)
{
	if(isdefined(level.play_taacom_dialog_response_on_owner))
	{
		self [[level.play_taacom_dialog_response_on_owner]](dialogkey, killstreaktype, killstreakid);
	}
}

/*
	Name: leader_dialog_for_other_teams
	Namespace: killstreaks
	Checksum: 0x8874CBF4
	Offset: 0xC290
	Size: 0x60
	Parameters: 5
	Flags: None
*/
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey)
{
	if(isdefined(level.var_9f8e080d))
	{
		[[level.var_9f8e080d]](dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey);
	}
}

/*
	Name: leader_dialog
	Namespace: killstreaks
	Checksum: 0xE78E35CB
	Offset: 0xC2F8
	Size: 0x6C
	Parameters: 6
	Flags: None
*/
function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey)
{
	if(isdefined(level.var_514f9d20))
	{
		[[level.var_514f9d20]](dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey);
	}
}

/*
	Name: processscoreevent
	Namespace: killstreaks
	Checksum: 0xF13D7D7C
	Offset: 0xC370
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function processscoreevent(event, player, victim, weapon)
{
	if(isdefined(level.var_19a15e42))
	{
		[[level.var_19a15e42]](event, player, victim, weapon);
	}
}

/*
	Name: allow_assists
	Namespace: killstreaks
	Checksum: 0x6F01D1C4
	Offset: 0xC3D0
	Size: 0x32
	Parameters: 2
	Flags: None
*/
function allow_assists(killstreaktype, allow)
{
	level.killstreaks[killstreaktype].allowassists = allow;
}

/*
	Name: set_team_kill_penalty_scale
	Namespace: killstreaks
	Checksum: 0x4806634D
	Offset: 0xC410
	Size: 0x3A
	Parameters: 3
	Flags: None
*/
function set_team_kill_penalty_scale(killstreaktype, scale, isinventory)
{
	level.killstreaks[killstreaktype].teamkillpenaltyscale = scale;
}

/*
	Name: override_entity_camera_in_demo
	Namespace: killstreaks
	Checksum: 0x74CDA3DA
	Offset: 0xC458
	Size: 0x3A
	Parameters: 3
	Flags: None
*/
function override_entity_camera_in_demo(killstreaktype, value, isinventory)
{
	level.killstreaks[killstreaktype].overrideentitycameraindemo = value;
}

/*
	Name: update_player_threat
	Namespace: killstreaks
	Checksum: 0x7CD93D31
	Offset: 0xC4A0
	Size: 0x27A
	Parameters: 1
	Flags: None
*/
function update_player_threat(player)
{
	if(!isplayer(player))
	{
		return;
	}
	heli = self;
	player.threatlevel = 0;
	dist = distance(player.origin, heli.origin);
	player.threatlevel = player.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
	if(isdefined(heli.attacker) && player == heli.attacker)
	{
		player.threatlevel = player.threatlevel + 100;
	}
	if(isdefined(player.carryobject))
	{
		player.threatlevel = player.threatlevel + 200;
	}
	if(isdefined(player.score))
	{
		player.threatlevel = player.threatlevel + player.score * 2;
	}
	if(player weapons::has_launcher())
	{
		if(player weapons::has_lockon(heli))
		{
			player.threatlevel = player.threatlevel + 1000;
		}
		else
		{
			player.threatlevel = player.threatlevel + 500;
		}
	}
	if(player weapons::has_heavy_weapon())
	{
		player.threatlevel = player.threatlevel + 300;
	}
	if(player weapons::has_lmg())
	{
		player.threatlevel = player.threatlevel + 200;
	}
	if(isdefined(player.antithreat))
	{
		player.threatlevel = player.threatlevel - player.antithreat;
	}
	if(player.threatlevel <= 0)
	{
		player.threatlevel = 1;
	}
}

/*
	Name: update_non_player_threat
	Namespace: killstreaks
	Checksum: 0x2C27FF2F
	Offset: 0xC728
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function update_non_player_threat(non_player)
{
	heli = self;
	non_player.threatlevel = 0;
	dist = distance(non_player.origin, heli.origin);
	non_player.threatlevel = non_player.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
	if(non_player.threatlevel <= 0)
	{
		non_player.threatlevel = 1;
	}
}

/*
	Name: update_actor_threat
	Namespace: killstreaks
	Checksum: 0x5631DAC2
	Offset: 0xC7E8
	Size: 0x1D2
	Parameters: 1
	Flags: None
*/
function update_actor_threat(actor)
{
	heli = self;
	actor.threatlevel = 0;
	dist = distance(actor.origin, heli.origin);
	actor.threatlevel = actor.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
	if(isdefined(actor.owner))
	{
		if(isdefined(heli.attacker) && actor.owner == heli.attacker)
		{
			actor.threatlevel = actor.threatlevel + 100;
		}
		if(isdefined(actor.owner.carryobject))
		{
			actor.threatlevel = actor.threatlevel + 200;
		}
		if(isdefined(actor.owner.score))
		{
			actor.threatlevel = actor.threatlevel + actor.owner.score * 4;
		}
		if(isdefined(actor.owner.antithreat))
		{
			actor.threatlevel = actor.threatlevel - actor.owner.antithreat;
		}
	}
	if(actor.threatlevel <= 0)
	{
		actor.threatlevel = 1;
	}
}

/*
	Name: update_dog_threat
	Namespace: killstreaks
	Checksum: 0x6B0D6732
	Offset: 0xC9C8
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function update_dog_threat(dog)
{
	heli = self;
	dog.threatlevel = 0;
	dist = distance(dog.origin, heli.origin);
	dog.threatlevel = dog.threatlevel + level.heli_visual_range - dist / level.heli_visual_range * 100;
}

/*
	Name: missile_valid_target_check
	Namespace: killstreaks
	Checksum: 0xF2072DEB
	Offset: 0xCA60
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function missile_valid_target_check(missiletarget)
{
	heli2target_normal = vectornormalize(missiletarget.origin - self.origin);
	heli2forward = anglestoforward(self.angles);
	heli2forward_normal = vectornormalize(heli2forward);
	heli_dot_target = vectordot(heli2target_normal, heli2forward_normal);
	if(heli_dot_target >= level.heli_valid_target_cone)
	{
		return 1;
	}
	return 0;
}

/*
	Name: update_missile_player_threat
	Namespace: killstreaks
	Checksum: 0xFC6A5FB0
	Offset: 0xCB20
	Size: 0x16A
	Parameters: 1
	Flags: None
*/
function update_missile_player_threat(player)
{
	player.missilethreatlevel = 0;
	dist = distance(player.origin, self.origin);
	player.missilethreatlevel = player.missilethreatlevel + level.heli_missile_range - dist / level.heli_missile_range * 100;
	if(self missile_valid_target_check(player) == 0)
	{
		player.missilethreatlevel = 1;
		return;
	}
	if(isdefined(self.attacker) && player == self.attacker)
	{
		player.missilethreatlevel = player.missilethreatlevel + 100;
	}
	player.missilethreatlevel = player.missilethreatlevel + player.score * 4;
	if(isdefined(player.antithreat))
	{
		player.missilethreatlevel = player.missilethreatlevel - player.antithreat;
	}
	if(player.missilethreatlevel <= 0)
	{
		player.missilethreatlevel = 1;
	}
}

/*
	Name: update_missile_dog_threat
	Namespace: killstreaks
	Checksum: 0xE6F5360C
	Offset: 0xCC98
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function update_missile_dog_threat(dog)
{
	dog.missilethreatlevel = 1;
}

/*
	Name: function_fff56140
	Namespace: killstreaks
	Checksum: 0x44F9C19C
	Offset: 0xCCC0
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function function_fff56140(owner, var_4a025683)
{
	self notify(#"hash_4363bc1bae999ad3");
	self endon(#"hash_4363bc1bae999ad3", #"death");
	res = undefined;
	res = owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"changed_specialist");
	[[var_4a025683]]();
}

/*
	Name: should_not_timeout
	Namespace: killstreaks
	Checksum: 0x4FD82F9B
	Offset: 0xCD70
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function should_not_timeout(killstreak)
{
	/#
		/#
			assert(isdefined(killstreak), "");
		#/
		/#
			assert(isdefined(level.killstreaks[killstreak]), "");
		#/
		if(getdvarint(#"hash_e8bb2ce168acce0", 0))
		{
			return 1;
		}
		if(isdefined(level.killstreaks[killstreak].devtimeoutdvar))
		{
			return getdvarint(level.killstreaks[killstreak].devtimeoutdvar, 0);
		}
	#/
	return 0;
}

/*
	Name: waitfortimeout
	Namespace: killstreaks
	Checksum: 0x76406F25
	Offset: 0xCE50
	Size: 0x194
	Parameters: 6
	Flags: None
*/
function waitfortimeout(killstreak, duration, callback, endcondition1, endcondition2, endcondition3)
{
	/#
		if(should_not_timeout(killstreak))
		{
			return;
		}
	#/
	self endon(#"killstreak_hacked", #"hash_602ae7ca650d6287");
	if(isdefined(endcondition1))
	{
		self endon(endcondition1);
	}
	if(isdefined(endcondition2))
	{
		self endon(endcondition2);
	}
	if(isdefined(endcondition3))
	{
		self endon(endcondition3);
	}
	self thread waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3);
	killstreakbundle = level.killstreakbundle[killstreak];
	self.killstreakendtime = gettime() + duration;
	if(isdefined(killstreakbundle) && isdefined(killstreakbundle.kstimeoutbeepduration))
	{
		self function_b00e94e0(killstreakbundle, duration);
	}
	else
	{
		hostmigration::migrationawarewait(duration);
	}
	self notify(#"kill_waitfortimeouthacked_thread");
	self.killstreaktimedout = 1;
	self.killstreakendtime = 0;
	self notify(#"timed_out");
	self [[callback]]();
}

/*
	Name: function_b00e94e0
	Namespace: killstreaks
	Checksum: 0x4375C286
	Offset: 0xCFF0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_b00e94e0(killstreakbundle, duration)
{
	self waitfortimeoutbeep(killstreakbundle.kstimeoutbeepduration, killstreakbundle.kstimeoutfastbeepduration, duration);
}

/*
	Name: waitfortimeoutbeep
	Namespace: killstreaks
	Checksum: 0xB5A158E6
	Offset: 0xD040
	Size: 0x184
	Parameters: 3
	Flags: None
*/
function waitfortimeoutbeep(kstimeoutbeepduration, kstimeoutfastbeepduration, duration)
{
	self endon(#"death");
	beepduration = int(kstimeoutbeepduration * 1000);
	hostmigration::migrationawarewait(max(duration - beepduration, 0));
	if(isvehicle(self))
	{
		self clientfield::set("timeout_beep", 1);
	}
	if(isdefined(kstimeoutfastbeepduration))
	{
		fastbeepduration = int(kstimeoutfastbeepduration * 1000);
		hostmigration::migrationawarewait(max(beepduration - fastbeepduration, 0));
		if(isvehicle(self))
		{
			self clientfield::set("timeout_beep", 2);
		}
		hostmigration::migrationawarewait(fastbeepduration);
	}
	self function_67bc25ec();
}

/*
	Name: function_67bc25ec
	Namespace: killstreaks
	Checksum: 0x1835166
	Offset: 0xD1D0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_67bc25ec()
{
	if(isdefined(self) && isvehicle(self))
	{
		self clientfield::set("timeout_beep", 0);
	}
}

/*
	Name: waitfortimeouthacked
	Namespace: killstreaks
	Checksum: 0xC010D7A1
	Offset: 0xD220
	Size: 0xF4
	Parameters: 5
	Flags: None
*/
function waitfortimeouthacked(killstreak, callback, endcondition1, endcondition2, endcondition3)
{
	self endon(#"kill_waitfortimeouthacked_thread");
	if(isdefined(endcondition1))
	{
		self endon(endcondition1);
	}
	if(isdefined(endcondition2))
	{
		self endon(endcondition2);
	}
	if(isdefined(endcondition3))
	{
		self endon(endcondition3);
	}
	self waittill(#"killstreak_hacked");
	hackedduration = self killstreak_hacking::get_hacked_timeout_duration_ms();
	self.killstreakendtime = gettime() + hackedduration;
	hostmigration::migrationawarewait(hackedduration);
	self.killstreakendtime = 0;
	self notify(#"timed_out");
	self [[callback]]();
}

/*
	Name: function_975d45c3
	Namespace: killstreaks
	Checksum: 0x710042BC
	Offset: 0xD320
	Size: 0x76
	Parameters: 0
	Flags: None
*/
function function_975d45c3()
{
	startheight = 200;
	switch(self getstance())
	{
		case "crouch":
		{
			startheight = 30;
			break;
		}
		case "prone":
		{
			startheight = 15;
			break;
		}
	}
	return startheight;
}

/*
	Name: set_killstreak_delay_killcam
	Namespace: killstreaks
	Checksum: 0xA390AB0F
	Offset: 0xD3A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_killstreak_delay_killcam(killstreak_name)
{
	self.killstreak_delay_killcam = killstreak_name;
}

/*
	Name: getactivekillstreaks
	Namespace: killstreaks
	Checksum: 0x6F81CECF
	Offset: 0xD3C8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function getactivekillstreaks()
{
	return self.pers[#"activekillstreaks"];
}

/*
	Name: watchteamchange
	Namespace: killstreaks
	Checksum: 0xB2DF8979
	Offset: 0xD3F0
	Size: 0xAE
	Parameters: 1
	Flags: None
*/
function watchteamchange(teamchangenotify)
{
	self notify(teamchangenotify + "_Singleton");
	self endon(teamchangenotify + "_Singleton");
	killstreak = self;
	killstreak endon(#"death", teamchangenotify);
	killstreak.owner waittill(#"joined_team", #"disconnect", #"joined_spectators", #"emp_jammed");
	killstreak notify(teamchangenotify);
}

/*
	Name: killstreak_assist
	Namespace: killstreaks
	Checksum: 0x21EDCFD3
	Offset: 0xD4A8
	Size: 0x3C
	Parameters: 3
	Flags: None
*/
function killstreak_assist(victim, assister, killstreak)
{
	victim recordkillstreakassist(victim, assister, killstreak);
}

/*
	Name: add_ricochet_protection
	Namespace: killstreaks
	Checksum: 0xD416383A
	Offset: 0xD4F0
	Size: 0x122
	Parameters: 4
	Flags: None
*/
function add_ricochet_protection(killstreak_id, owner, origin, ricochet_distance)
{
	testing = 0;
	/#
		testing = getdvarint(#"scr_ricochet_protection_debug", 0) == 2;
	#/
	if(!level.hardcoremode && !testing)
	{
		return;
	}
	if(!isdefined(ricochet_distance) || ricochet_distance == 0)
	{
		return;
	}
	if(!isdefined(owner.ricochet_protection))
	{
		owner.ricochet_protection = [];
	}
	owner.ricochet_protection[killstreak_id] = spawnstruct();
	owner.ricochet_protection[killstreak_id].origin = origin;
	owner.ricochet_protection[killstreak_id].distancesq = ricochet_distance * ricochet_distance;
}

/*
	Name: set_ricochet_protection_endtime
	Namespace: killstreaks
	Checksum: 0x3133257F
	Offset: 0xD620
	Size: 0x82
	Parameters: 3
	Flags: None
*/
function set_ricochet_protection_endtime(killstreak_id, owner, endtime)
{
	if(!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id))
	{
		return;
	}
	if(!isdefined(owner.ricochet_protection[killstreak_id]))
	{
		return;
	}
	owner.ricochet_protection[killstreak_id].endtime = endtime;
}

/*
	Name: remove_ricochet_protection
	Namespace: killstreaks
	Checksum: 0x7B41B8AB
	Offset: 0xD6B0
	Size: 0x54
	Parameters: 2
	Flags: None
*/
function remove_ricochet_protection(killstreak_id, owner)
{
	if(!isdefined(owner) || !isdefined(owner.ricochet_protection) || !isdefined(killstreak_id))
	{
		return;
	}
	owner.ricochet_protection[killstreak_id] = undefined;
}

/*
	Name: thermal_glow
	Namespace: killstreaks
	Checksum: 0xF3B712BB
	Offset: 0xD710
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function thermal_glow(enable)
{
	clientfield::set_to_player("thermal_glow", enable);
}

/*
	Name: thermal_glow_enemies_only
	Namespace: killstreaks
	Checksum: 0xF7A4ED8
	Offset: 0xD740
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function thermal_glow_enemies_only(enable)
{
	clientfield::set_to_player("thermal_glow_enemies_only", enable);
}

/*
	Name: is_ricochet_protected
	Namespace: killstreaks
	Checksum: 0xB42C6CEC
	Offset: 0xD770
	Size: 0x106
	Parameters: 1
	Flags: None
*/
function is_ricochet_protected(player)
{
	if(!isdefined(player) || !isdefined(player.ricochet_protection))
	{
		return 0;
	}
	foreach(protection in player.ricochet_protection)
	{
		if(!isdefined(protection))
		{
			continue;
		}
		if(isdefined(protection.endtime) && protection.endtime < gettime())
		{
			continue;
		}
		if(distancesquared(protection.origin, player.origin) < protection.distancesq)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: debug_ricochet_protection
	Namespace: killstreaks
	Checksum: 0x2DFF2CDD
	Offset: 0xD880
	Size: 0x2A8
	Parameters: 0
	Flags: None
*/
function debug_ricochet_protection()
{
	/#
		debug_wait = 0.5;
		debug_frames = int(debug_wait / float(function_60d95f53()) / 1000) + 1;
		while(true)
		{
			if(getdvarint(#"scr_ricochet_protection_debug", 0) == 0)
			{
				wait(2);
				continue;
			}
			wait(debug_wait);
			foreach(player in level.players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				if(!isdefined(player.ricochet_protection))
				{
					continue;
				}
				foreach(protection in player.ricochet_protection)
				{
					if(!isdefined(protection))
					{
						continue;
					}
					if(isdefined(protection.endtime) && protection.endtime < gettime())
					{
						continue;
					}
					radius = sqrt(protection.distancesq);
					sphere(protection.origin, radius, (1, 1, 0), 0.25, 0, 36, debug_frames);
					circle(protection.origin, radius, (1, 0.5, 0), 0, 1, debug_frames);
					circle(protection.origin + vectorscale((0, 0, 1), 2), radius, (1, 0.5, 0), 0, 1, debug_frames);
				}
			}
		}
	#/
}

