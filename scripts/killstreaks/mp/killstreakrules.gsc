// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace killstreakrules;

/*
	Name: init
	Namespace: killstreakrules
	Checksum: 0xB3AD4745
	Offset: 0x470
	Size: 0x136C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_shared();
	level.var_956bde25 = &function_65739e7b;
	createrule("tank_robot", 2, 1);
	createrule("ac130", 1, 1);
	createrule("airsupport", 1, 1);
	createrule("ammo_station", 8, 4);
	createrule("armor_station", 8, 4);
	createrule("artillery_barrage", 1, 1);
	createrule("combatrobot", 4, 2);
	createrule("chopper", 2, 1);
	createrule("chopperInTheAir", 2, 1);
	createrule("counteruav", 6, 3);
	createrule("dart", 4, 2);
	createrule("dog", 1, 1);
	createrule("drone_squadron", 4, 2);
	createrule("drone_strike", 1, 1);
	createrule("emp", 2, 1);
	createrule("firesupport", 1, 1);
	createrule("helicopter_comlink", 2, 1);
	createrule("missiledrone", 3, 3);
	createrule("missileswarm", 1, 1);
	createrule("planemortar", 1, 1);
	createrule("playercontrolledchopper", 1, 1);
	createrule("qrdrone", 3, 2);
	createrule("uav", 10, 5);
	createrule("raps", 2, 1);
	createrule("rcxd", 4, 2);
	createrule("recon_car", 4, 2);
	createrule("remote_missile", 2, 1);
	createrule("remotemortar", 1, 1);
	createrule("satellite", 2, 1);
	createrule("sentinel", 4, 2);
	createrule("spawnbeacon", 1, 2);
	createrule("straferun", 1, 1);
	createrule("supplydrop", 4, 4);
	createrule("swat_team", 4, 2);
	createrule("targetableent", 32, 32);
	createrule("turret", 8, 4);
	createrule("ultimate_turret", 8, 4);
	createrule("vehicle", 7, 7);
	createrule("weapon", 12, 6);
	addkillstreaktorule("tank_robot", "tank_robot", 1, 1);
	addkillstreaktorule("ac130", "ac130", 1, 1);
	addkillstreaktorule("airstrike", "airsupport", 1, 1);
	addkillstreaktorule("airstrike", "vehicle", 1, 1);
	addkillstreaktorule("ammo_station", "turret", 1, 1);
	addkillstreaktorule("armor_station", "turret", 1, 1);
	addkillstreaktorule("artillery", "firesupport", 1, 1);
	addkillstreaktorule("artillery_barrage", "artillery_barrage", 1, 1);
	addkillstreaktorule("auto_tow", "turret", 1, 1);
	addkillstreaktorule("autoturret", "turret", 1, 1);
	addkillstreaktorule("combat_robot", "combatrobot", 1, 1);
	addkillstreaktorule("counteruav", "counteruav", 1, 1);
	addkillstreaktorule("counteruav", "targetableent", 1, 1);
	addkillstreaktorule("dart", "dart", 1, 1);
	addkillstreaktorule("dog", "dog", 1, 1);
	addkillstreaktorule("drone_squadron", "drone_squadron", 1, 1);
	addkillstreaktorule("drone_strike", "drone_strike", 1, 1);
	addkillstreaktorule("emp", "emp", 1, 1);
	addkillstreaktorule("helicopter", "chopper", 1, 1);
	addkillstreaktorule("helicopter", "chopperInTheAir", 1, 0);
	addkillstreaktorule("helicopter", "playercontrolledchopper", 0, 1);
	addkillstreaktorule("helicopter", "targetableent", 1, 1);
	addkillstreaktorule("helicopter", "vehicle", 1, 1);
	addkillstreaktorule("helicopter_comlink", "chopper", 1, 1);
	addkillstreaktorule("helicopter_comlink", "chopperInTheAir", 1, 0);
	addkillstreaktorule("helicopter_comlink", "targetableent", 1, 1);
	addkillstreaktorule("helicopter_comlink", "vehicle", 1, 1);
	addkillstreaktorule("helicopter_comlink", "helicopter_comlink", 1, 1);
	addkillstreaktorule("overwatch_helicopter", "chopper", 1, 1);
	addkillstreaktorule("overwatch_helicopter", "chopperInTheAir", 1, 0);
	addkillstreaktorule("overwatch_helicopter", "targetableent", 1, 1);
	addkillstreaktorule("overwatch_helicopter", "vehicle", 1, 1);
	addkillstreaktorule("helicopter_guard", "airsupport", 1, 1);
	addkillstreaktorule("attack_helicopter", "chopperInTheAir", 1, 0);
	addkillstreaktorule("attack_helicopter", "playercontrolledchopper", 1, 1);
	addkillstreaktorule("attack_helicopter", "targetableent", 1, 1);
	addkillstreaktorule("attack_helicopter", "vehicle", 1, 1);
	addkillstreaktorule("helicopter_player_firstperson", "vehicle", 1, 1);
	addkillstreaktorule("helicopter_player_firstperson", "chopperInTheAir", 1, 1);
	addkillstreaktorule("helicopter_player_firstperson", "playercontrolledchopper", 1, 1);
	addkillstreaktorule("helicopter_player_firstperson", "targetableent", 1, 1);
	addkillstreaktorule("helicopter_x2", "chopper", 1, 1);
	addkillstreaktorule("helicopter_x2", "chopperInTheAir", 1, 0);
	addkillstreaktorule("helicopter_x2", "playercontrolledchopper", 0, 1);
	addkillstreaktorule("helicopter_x2", "targetableent", 1, 1);
	addkillstreaktorule("helicopter_x2", "vehicle", 1, 1);
	addkillstreaktorule("m202_flash", "weapon", 1, 1);
	addkillstreaktorule("m220_tow", "weapon", 1, 1);
	addkillstreaktorule("m220_tow_drop", "supplydrop", 1, 1);
	addkillstreaktorule("m220_tow_drop", "vehicle", 1, 1);
	addkillstreaktorule("m220_tow_killstreak", "weapon", 1, 1);
	addkillstreaktorule("m32", "weapon", 1, 1);
	addkillstreaktorule("m32_drop", "weapon", 1, 1);
	addkillstreaktorule("microwave_turret", "turret", 1, 1);
	addkillstreaktorule("minigun", "weapon", 1, 1);
	addkillstreaktorule("minigun_drop", "weapon", 1, 1);
	addkillstreaktorule("mini_turret", "turret", 1, 1);
	addkillstreaktorule("missile_drone", "missiledrone", 1, 1);
	addkillstreaktorule("missile_swarm", "missileswarm", 1, 1);
	addkillstreaktorule("mortar", "firesupport", 1, 1);
	addkillstreaktorule("mp40_drop", "weapon", 1, 1);
	addkillstreaktorule("napalm", "airsupport", 1, 1);
	addkillstreaktorule("napalm", "vehicle", 1, 1);
	addkillstreaktorule("planemortar", "planemortar", 1, 1);
	addkillstreaktorule("qrdrone", "qrdrone", 1, 1);
	addkillstreaktorule("qrdrone", "vehicle", 1, 1);
	addkillstreaktorule("uav", "uav", 1, 1);
	addkillstreaktorule("uav", "targetableent", 1, 1);
	addkillstreaktorule("ultimate_turret", "turret", 1, 1);
	addkillstreaktorule("ultimate_turret", "ultimate_turret", 1, 1);
	addkillstreaktorule("satellite", "satellite", 1, 1);
	addkillstreaktorule("raps", "raps", 1, 1);
	addkillstreaktorule("rcbomb", "rcxd", 1, 1);
	addkillstreaktorule("recon_car", "recon_car", 1, 1);
	addkillstreaktorule("remote_missile", "targetableent", 1, 1);
	addkillstreaktorule("remote_missile", "remote_missile", 1, 1);
	addkillstreaktorule("remote_mortar", "remotemortar", 1, 1);
	addkillstreaktorule("remote_mortar", "targetableent", 1, 1);
	addkillstreaktorule("sentinel", "sentinel", 1, 1);
	addkillstreaktorule("spawnbeacon", "spawnbeacon", 1, 1);
	addkillstreaktorule("straferun", "straferun", 1, 1);
	addkillstreaktorule("supply_drop", "supplydrop", 1, 1);
	addkillstreaktorule("supply_drop", "targetableent", 1, 1);
	addkillstreaktorule("supply_drop", "vehicle", 1, 1);
	addkillstreaktorule("supply_station", "supplydrop", 1, 1);
	addkillstreaktorule("supply_station", "targetableent", 1, 1);
	addkillstreaktorule("supply_station", "vehicle", 1, 1);
	addkillstreaktorule("swat_team", "swat_team", 1, 1);
	addkillstreaktorule("tow_turret_drop", "supplydrop", 1, 1);
	addkillstreaktorule("tow_turret_drop", "vehicle", 1, 1);
	addkillstreaktorule("turret_drop", "supplydrop", 1, 1);
	addkillstreaktorule("turret_drop", "vehicle", 1, 1);
}

/*
	Name: function_65739e7b
	Namespace: killstreakrules
	Checksum: 0x15A64DEC
	Offset: 0x17E8
	Size: 0x10C
	Parameters: 3
	Flags: Linked
*/
function function_65739e7b(hardpointtype, team, isemped)
{
	if(isdefined(level.killstreaks[hardpointtype]) && isdefined(level.killstreaks[hardpointtype].notavailabletext))
	{
		self iprintlnbold(level.killstreaks[hardpointtype].notavailabletext);
		if(!isdefined(self.currentkillstreakdialog) && level.killstreaks[hardpointtype].utilizesairspace && isemped == 0)
		{
			self globallogic_audio::play_taacom_dialog("airspaceFull");
		}
		if(!isdefined(self.currentkillstreakdialog) && level.killstreaks[hardpointtype].var_a4a7d3e7)
		{
			self globallogic_audio::play_taacom_dialog("groundspaceFull");
		}
	}
}

