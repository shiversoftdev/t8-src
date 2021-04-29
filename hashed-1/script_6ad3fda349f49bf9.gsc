// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_50cd53b603b30ef5;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\util_shared.csc;

#namespace killstreak_detect;

/*
	Name: init_shared
	Namespace: killstreak_detect
	Checksum: 0xD19FC647
	Offset: 0x170
	Size: 0x29C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_c662dc2d))
	{
		level.var_c662dc2d = {};
		callback::on_localplayer_spawned(&watch_killstreak_detect_perks_changed);
		clientfield::register("scriptmover", "enemyvehicle", 1, 2, "int", &enemyscriptmovervehicle_changed, 0, 0);
		clientfield::register("vehicle", "enemyvehicle", 1, 2, "int", &enemyvehicle_changed, 0, 1);
		clientfield::register("missile", "enemyvehicle", 1, 2, "int", &enemymissilevehicle_changed, 0, 1);
		clientfield::register("actor", "enemyvehicle", 1, 2, "int", &function_430c370a, 0, 1);
		clientfield::register("vehicle", "vehicletransition", 1, 1, "int", &vehicle_transition, 0, 1);
		if(!isdefined(level.enemyvehicles))
		{
			level.enemyvehicles = [];
		}
		if(!isdefined(level.enemymissiles))
		{
			level.enemymissiles = [];
		}
		if(!isdefined(level.var_51afeae4))
		{
			level.var_51afeae4 = [];
		}
		function_8ac48939(level.killstreakcorebundle);
		level.emp_killstreaks = [];
		renderoverridebundle::function_f72f089c(#"hash_7d4b6b0d84ddafa3", #"friendly", (sessionmodeiscampaigngame() ? #"hash_461520942fd1154d" : #"hash_462904942fe18ec3"), &function_95f96f3e);
	}
}

/*
	Name: function_95f96f3e
	Namespace: killstreak_detect
	Checksum: 0xF087E375
	Offset: 0x418
	Size: 0x132
	Parameters: 3
	Flags: None
*/
function function_95f96f3e(local_client_num, bundle, param)
{
	if(!self function_4e0ca360())
	{
		return 0;
	}
	if(!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines))
	{
		return 0;
	}
	if(shoutcaster::is_shoutcaster(local_client_num))
	{
		return 0;
	}
	if(self.type === "vehicle" && self function_4add50a7())
	{
		return 0;
	}
	if(isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num])
	{
		return 0;
	}
	player = function_5c10bd79(local_client_num);
	if(self == player)
	{
		return 0;
	}
	if(player.var_33b61b6f === 1)
	{
		bundle.var_e156fd4 = 1;
		return 0;
	}
	return 1;
}

/*
	Name: function_7181329a
	Namespace: killstreak_detect
	Checksum: 0xF8155198
	Offset: 0x558
	Size: 0x11C
	Parameters: 1
	Flags: None
*/
function function_7181329a(entity)
{
	if(isplayer(entity))
	{
		return 0;
	}
	if(entity.type != "missile" && entity.type != "vehicle" && entity.type != "scriptmover" && entity.type != "actor")
	{
		return 0;
	}
	if(self clientfield::get("enemyvehicle") != 0)
	{
		return 1;
	}
	if(entity.type != "actor" && self.type !== "vehicle" && self clientfield::get("enemyequip") != 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_903bbed3
	Namespace: killstreak_detect
	Checksum: 0xAA79F8DA
	Offset: 0x680
	Size: 0x14E
	Parameters: 2
	Flags: None
*/
function function_903bbed3(local_client_num, bundle)
{
	if(self function_4e0ca360())
	{
		return 0;
	}
	if(shoutcaster::is_shoutcaster(local_client_num))
	{
		return 0;
	}
	if(self.type === "vehicle" && self function_4add50a7())
	{
		return 0;
	}
	if(isdefined(self.isbreachingfirewall) && self.isbreachingfirewall == 1)
	{
		return 0;
	}
	if(function_5778f82(local_client_num, #"specialty_showenemyvehicles") && !isplayer(self) && function_7181329a(self))
	{
		return 1;
	}
	player = function_5c10bd79(local_client_num);
	if(isdefined(player) && player.var_33b61b6f === 1)
	{
		bundle.var_e156fd4 = 1;
		return 1;
	}
	return 0;
}

/*
	Name: function_d859c344
	Namespace: killstreak_detect
	Checksum: 0xFFA2F298
	Offset: 0x7D8
	Size: 0x164
	Parameters: 2
	Flags: None
*/
function function_d859c344(local_client_num, newval)
{
	bundle = self killstreak_bundles::function_48e9536e();
	if(!isdefined(bundle))
	{
		bundle = level.killstreakcorebundle;
	}
	if(isdefined(bundle))
	{
		var_872807f = bundle.("ksROBShowFriendly");
		if(isdefined(var_872807f) && var_872807f)
		{
			self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", bundle.var_d3413870 + "friendly");
		}
		var_773a7966 = bundle.("ksROBShowEnemy");
		if(isdefined(var_773a7966) && var_773a7966)
		{
			self renderoverridebundle::function_c8d97b8e(local_client_num, #"enemy", bundle.var_d3413870 + "enemy");
		}
	}
	else
	{
		self renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_7d4b6b0d84ddafa3");
	}
}

/*
	Name: vehicle_transition
	Namespace: killstreak_detect
	Checksum: 0x2E91BC77
	Offset: 0x948
	Size: 0x90
	Parameters: 7
	Flags: None
*/
function vehicle_transition(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_d859c344(local_client_num, newval);
	if(isdefined(level.var_7cc76271))
	{
		[[level.var_7cc76271]](local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
}

/*
	Name: should_set_compass_icon
	Namespace: killstreak_detect
	Checksum: 0xB2883AF
	Offset: 0x9E0
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function should_set_compass_icon(local_client_num)
{
	return self function_83973173() || function_5778f82(local_client_num, #"specialty_showenemyvehicles");
}

/*
	Name: enemyscriptmovervehicle_changed
	Namespace: killstreak_detect
	Checksum: 0x844F510D
	Offset: 0xA30
	Size: 0xE4
	Parameters: 7
	Flags: None
*/
function enemyscriptmovervehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.scriptmovercompassicons) && isdefined(self.model))
	{
		if(isdefined(level.scriptmovercompassicons[self.model]))
		{
			if(self should_set_compass_icon(local_client_num))
			{
				self setcompassicon(level.scriptmovercompassicons[self.model]);
			}
		}
	}
	enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

/*
	Name: enemymissilevehicle_changed
	Namespace: killstreak_detect
	Checksum: 0x9EA699AA
	Offset: 0xB20
	Size: 0xE4
	Parameters: 7
	Flags: None
*/
function enemymissilevehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.missilecompassicons) && isdefined(self.weapon))
	{
		if(isdefined(level.missilecompassicons[self.weapon]))
		{
			if(self should_set_compass_icon(local_client_num))
			{
				self setcompassicon(level.missilecompassicons[self.weapon]);
			}
		}
	}
	enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
}

/*
	Name: enemymissile_changed
	Namespace: killstreak_detect
	Checksum: 0xDD3982D9
	Offset: 0xC10
	Size: 0x74
	Parameters: 7
	Flags: None
*/
function enemymissile_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self updateteammissiles(local_client_num, newval);
	self util::add_remove_list(level.enemymissiles, newval);
}

/*
	Name: enemyvehicle_changed
	Namespace: killstreak_detect
	Checksum: 0xE7B6FB21
	Offset: 0xC90
	Size: 0x1B2
	Parameters: 7
	Flags: None
*/
function enemyvehicle_changed(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.draftstage) && (level.draftstage > 0 || (isdefined(level.var_8c099032) && level.var_8c099032)))
	{
		self function_d05902d9(local_client_num, newval);
		return;
	}
	self updateteamvehicles(local_client_num, newval);
	self util::add_remove_list(level.enemyvehicles, newval);
	self updateenemyvehicles(local_client_num, newval);
	if(isdefined(self.model) && self.model == "wpn_t7_turret_emp_core" && self.type === "vehicle")
	{
		if(!isdefined(level.emp_killstreaks))
		{
			level.emp_killstreaks = [];
		}
		else if(!isarray(level.emp_killstreaks))
		{
			level.emp_killstreaks = array(level.emp_killstreaks);
		}
		level.emp_killstreaks[level.emp_killstreaks.size] = self;
	}
}

/*
	Name: function_430c370a
	Namespace: killstreak_detect
	Checksum: 0xDDC546FB
	Offset: 0xE50
	Size: 0xD4
	Parameters: 7
	Flags: None
*/
function function_430c370a(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(level.draftstage) && (level.draftstage > 0 || (isdefined(level.var_8c099032) && level.var_8c099032)))
	{
		self function_f27ffe49(local_client_num, newval);
		return;
	}
	self util::add_remove_list(level.var_51afeae4, newval);
	self function_f884010a(local_client_num, newval);
}

/*
	Name: updateteamvehicles
	Namespace: killstreak_detect
	Checksum: 0x31FC96EA
	Offset: 0xF30
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function updateteamvehicles(local_client_num, newval)
{
	self checkteamvehicles(local_client_num);
}

/*
	Name: updateteammissiles
	Namespace: killstreak_detect
	Checksum: 0x47FC2B74
	Offset: 0xF68
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function updateteammissiles(local_client_num, newval)
{
	self checkteammissiles(local_client_num);
}

/*
	Name: function_f884010a
	Namespace: killstreak_detect
	Checksum: 0xC70145CF
	Offset: 0xFA0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_f884010a(local_client_num, newval)
{
	if(!isdefined(self))
	{
		return;
	}
	function_d859c344(local_client_num, newval);
}

/*
	Name: updateenemyvehicles
	Namespace: killstreak_detect
	Checksum: 0x1C93CF2
	Offset: 0xFE0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function updateenemyvehicles(local_client_num, newval)
{
	if(!isdefined(self))
	{
		return;
	}
	function_d859c344(local_client_num, newval);
}

/*
	Name: updateenemymissiles
	Namespace: killstreak_detect
	Checksum: 0xF64B8976
	Offset: 0x1020
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function updateenemymissiles(local_client_num, newval)
{
	if(!isdefined(self))
	{
		return;
	}
	function_d859c344(local_client_num, newval);
}

/*
	Name: watch_killstreak_detect_perks_changed
	Namespace: killstreak_detect
	Checksum: 0xDDCEC4C7
	Offset: 0x1060
	Size: 0x176
	Parameters: 1
	Flags: None
*/
function watch_killstreak_detect_perks_changed(local_client_num)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	self notify(#"watch_killstreak_detect_perks_changed");
	self endon(#"watch_killstreak_detect_perks_changed");
	self endon(#"death");
	self endon(#"disconnect");
	while(isdefined(self))
	{
		waitframe(1);
		util::clean_deleted(level.var_51afeae4);
		util::clean_deleted(level.enemyvehicles);
		util::clean_deleted(level.enemymissiles);
		array::thread_all(level.var_51afeae4, &function_f884010a, local_client_num, 1);
		array::thread_all(level.enemyvehicles, &updateenemyvehicles, local_client_num, 1);
		array::thread_all(level.enemymissiles, &updateenemymissiles, local_client_num, 1);
		self waittill(#"perks_changed");
	}
}

/*
	Name: checkteamvehicles
	Namespace: killstreak_detect
	Checksum: 0x4CA2E53B
	Offset: 0x11E0
	Size: 0x13E
	Parameters: 1
	Flags: None
*/
function checkteamvehicles(localclientnum)
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team))
	{
		return;
	}
	if(!isdefined(self.vehicleoldteam))
	{
		self.vehicleoldteam = self.team;
	}
	if(!isdefined(self.vehicleoldownerteam))
	{
		self.vehicleoldownerteam = self.owner.team;
	}
	var_fd9de919 = function_9b3f0ed1(localclientnum);
	if(!isdefined(self.vehicleoldwatcherteam))
	{
		self.vehicleoldwatcherteam = var_fd9de919;
	}
	if(self.vehicleoldteam != self.team || self.vehicleoldownerteam != self.owner.team || self.vehicleoldwatcherteam != var_fd9de919)
	{
		self.vehicleoldteam = self.team;
		self.vehicleoldownerteam = self.owner.team;
		self.vehicleoldwatcherteam = var_fd9de919;
		self notify(#"team_changed");
	}
}

/*
	Name: checkteammissiles
	Namespace: killstreak_detect
	Checksum: 0x56E9CBA0
	Offset: 0x1328
	Size: 0x13E
	Parameters: 1
	Flags: None
*/
function checkteammissiles(localclientnum)
{
	if(!isdefined(self.owner) || !isdefined(self.owner.team))
	{
		return;
	}
	if(!isdefined(self.missileoldteam))
	{
		self.missileoldteam = self.team;
	}
	if(!isdefined(self.missileoldownerteam))
	{
		self.missileoldownerteam = self.owner.team;
	}
	var_fd9de919 = function_9b3f0ed1(localclientnum);
	if(!isdefined(self.missileoldwatcherteam))
	{
		self.missileoldwatcherteam = var_fd9de919;
	}
	if(self.missileoldteam != self.team || self.missileoldownerteam != self.owner.team || self.missileoldwatcherteam != var_fd9de919)
	{
		self.missileoldteam = self.team;
		self.missileoldownerteam = self.owner.team;
		self.missileoldwatcherteam = var_fd9de919;
		self notify(#"team_changed");
	}
}

/*
	Name: function_8ac48939
	Namespace: killstreak_detect
	Checksum: 0x4771E74F
	Offset: 0x1470
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_8ac48939(bundle)
{
	var_872807f = bundle.("ksROBShowFriendly");
	if(isdefined(var_872807f) && var_872807f)
	{
		renderoverridebundle::function_f72f089c(bundle.var_d3413870 + "friendly", bundle.("ksROBFriendly"), &function_95f96f3e);
	}
	var_773a7966 = bundle.("ksROBShowEnemy");
	if(isdefined(var_773a7966) && var_773a7966)
	{
		renderoverridebundle::function_f72f089c(bundle.var_d3413870 + "enemy", bundle.("ksROBEnemy"), &function_903bbed3);
	}
}

/*
	Name: function_d05902d9
	Namespace: killstreak_detect
	Checksum: 0x21571031
	Offset: 0x1578
	Size: 0x138
	Parameters: 2
	Flags: Private
*/
private function function_d05902d9(local_client_num, newval)
{
	if(!isdefined(level.var_b1dca2fb))
	{
		level.var_b1dca2fb = [];
	}
	if(!isdefined(level.var_b1dca2fb[local_client_num]))
	{
		level.var_b1dca2fb[local_client_num] = [];
	}
	var_55251088 = spawnstruct();
	var_55251088.vehicle = self;
	var_55251088.newval = newval;
	if(!isdefined(level.var_b1dca2fb[local_client_num]))
	{
		level.var_b1dca2fb[local_client_num] = [];
	}
	else if(!isarray(level.var_b1dca2fb[local_client_num]))
	{
		level.var_b1dca2fb[local_client_num] = array(level.var_b1dca2fb[local_client_num]);
	}
	level.var_b1dca2fb[local_client_num][level.var_b1dca2fb[local_client_num].size] = var_55251088;
}

/*
	Name: function_32c8b999
	Namespace: killstreak_detect
	Checksum: 0xC20D0E5E
	Offset: 0x16B8
	Size: 0x152
	Parameters: 1
	Flags: None
*/
function function_32c8b999(local_client_num)
{
	if(!isdefined(level.var_b1dca2fb) || !isdefined(level.var_b1dca2fb[local_client_num]))
	{
		return;
	}
	for(i = level.var_b1dca2fb[local_client_num].size - 1; i >= 0; i--)
	{
		vehicle = level.var_b1dca2fb[local_client_num][i].vehicle;
		newval = level.var_b1dca2fb[local_client_num][i].newval;
		if(isdefined(vehicle) && isalive(vehicle))
		{
			vehicle enemyvehicle_changed(local_client_num, undefined, newval);
		}
		level.var_b1dca2fb[local_client_num][i] = undefined;
	}
	arrayremoveindex(level.var_b1dca2fb, local_client_num);
	if(level.var_b1dca2fb.size == 0)
	{
		level.var_b1dca2fb = undefined;
	}
}

/*
	Name: function_f27ffe49
	Namespace: killstreak_detect
	Checksum: 0x698957D5
	Offset: 0x1818
	Size: 0x138
	Parameters: 2
	Flags: Private
*/
private function function_f27ffe49(local_client_num, newval)
{
	if(!isdefined(level.var_ef4cbc80))
	{
		level.var_ef4cbc80 = [];
	}
	if(!isdefined(level.var_ef4cbc80[local_client_num]))
	{
		level.var_ef4cbc80[local_client_num] = [];
	}
	var_a87a8991 = spawnstruct();
	var_a87a8991.actor = self;
	var_a87a8991.newval = newval;
	if(!isdefined(level.var_ef4cbc80[local_client_num]))
	{
		level.var_ef4cbc80[local_client_num] = [];
	}
	else if(!isarray(level.var_ef4cbc80[local_client_num]))
	{
		level.var_ef4cbc80[local_client_num] = array(level.var_ef4cbc80[local_client_num]);
	}
	level.var_ef4cbc80[local_client_num][level.var_ef4cbc80[local_client_num].size] = var_a87a8991;
}

/*
	Name: function_3eff7815
	Namespace: killstreak_detect
	Checksum: 0xF5DB7401
	Offset: 0x1958
	Size: 0x152
	Parameters: 1
	Flags: None
*/
function function_3eff7815(local_client_num)
{
	if(!isdefined(level.var_ef4cbc80) || !isdefined(level.var_ef4cbc80[local_client_num]))
	{
		return;
	}
	for(i = level.var_ef4cbc80[local_client_num].size - 1; i >= 0; i--)
	{
		actor = level.var_ef4cbc80[local_client_num][i].actor;
		newval = level.var_ef4cbc80[local_client_num][i].newval;
		if(isdefined(actor) && isalive(actor))
		{
			actor function_430c370a(local_client_num, undefined, newval);
		}
		level.var_ef4cbc80[local_client_num][i] = undefined;
	}
	arrayremoveindex(level.var_ef4cbc80, local_client_num);
	if(level.var_ef4cbc80.size == 0)
	{
		level.var_ef4cbc80 = undefined;
	}
}

