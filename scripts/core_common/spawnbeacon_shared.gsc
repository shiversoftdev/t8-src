// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_2dc48f46bfeac894;
#using script_47fb62300ac0bd60;
#using script_545a0bac37bda541;
#using script_6c8abe14025b47c4;
#using script_79a7e1c31a3e8cc;
#using script_8988fdbc78d6c53;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace spawn_beacon;

/*
	Name: init_shared
	Namespace: spawn_beacon
	Checksum: 0x6DF4987F
	Offset: 0x250
	Size: 0x26C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.var_9fa5aeb4 = undefined;
	level.var_34c482f2 = undefined;
	level.var_4b1d905b = undefined;
	level.var_ae2fe442 = undefined;
	if(!isdefined(game.spawnbeaconid))
	{
		game.spawnbeaconid = 0;
	}
	if(!isdefined(level.spawnbeaconsettings))
	{
		level.spawnbeaconsettings = spawnstruct();
	}
	level.spawnbeaconsettings.userspawnbeacons = [];
	level.spawnbeaconsettings.availablespawnlists = [];
	level.spawnbeaconsettings.var_d6a27a84 = [];
	level.spawnbeaconsettings.var_d741a6a4 = [];
	if(getgametypesetting(#"hash_332d856eb0e6a511") === 1)
	{
		level.spawnbeaconsettings.var_51d5c26f = getscriptbundle("spawnbeacon_custom_settings_comp");
	}
	else
	{
		level.spawnbeaconsettings.var_51d5c26f = getscriptbundle("default_spawnbeacon_settings");
	}
	level.spawnbeaconsettings.var_c1a364b9 = getweapon(#"gadget_spawnbeacon");
	level.spawnbeaconsettings.var_613ff100 = [];
	level.spawnbeaconsettings.beacons = [];
	level.spawnbeaconsettings.var_f73b7201 = 100;
	level.spawnbeaconsettings.var_b851d15e = vectorscale((0, 0, 1), 5);
	level.spawnbeaconsettings.var_247a8b = 100;
	/#
		level.spawnbeaconsettings.var_e7571ff1 = [];
	#/
	setupcallbacks();
	setupclientfields();
	callback::on_finalize_initialization(&function_1c601b99);
	deployable::function_2e088f73(getweapon("gadget_spawnbeacon"), &function_9aafb7bb, undefined);
}

/*
	Name: function_1c601b99
	Namespace: spawn_beacon
	Checksum: 0xD9DBFBA9
	Offset: 0x4C8
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.spawnbeaconsettings.var_c1a364b9, &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: spawn_beacon
	Checksum: 0xAC14486
	Offset: 0x510
	Size: 0x5C
	Parameters: 2
	Flags: None
*/
function function_bff5c062(spawnbeacon, var_dbd1a594)
{
	spawnbeacon.var_d02ddb8e = getweapon(#"gadget_icepick");
	spawnbeacon thread function_a9ff3efb(1);
}

/*
	Name: function_ee74520a
	Namespace: spawn_beacon
	Checksum: 0x67C58238
	Offset: 0x578
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function function_ee74520a()
{
	if(!isdefined(level.spawnbeaconsettings))
	{
		level.spawnbeaconsettings = spawnstruct();
	}
	level.spawnbeaconsettings.var_9d48e929 = 1;
}

/*
	Name: function_7262646d
	Namespace: spawn_beacon
	Checksum: 0x9DA55E50
	Offset: 0x5C8
	Size: 0x42
	Parameters: 0
	Flags: None
*/
function function_7262646d()
{
	if(!isdefined(level.spawnbeaconsettings))
	{
		level.spawnbeaconsettings = spawnstruct();
	}
	level.spawnbeaconsettings.var_7262646d = 1;
}

/*
	Name: function_5e54a568
	Namespace: spawn_beacon
	Checksum: 0xF2E45952
	Offset: 0x618
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_5e54a568(var_b71a2a66)
{
	if(!isdefined(level.spawnbeaconsettings))
	{
		level.spawnbeaconsettings = spawnstruct();
	}
	level.spawnbeaconsettings.var_3c919ca8 = var_b71a2a66;
}

/*
	Name: function_6b437265
	Namespace: spawn_beacon
	Checksum: 0x20A5B134
	Offset: 0x670
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_6b437265(team)
{
	foreach(spawnbeacon in level.spawnbeaconsettings.beacons)
	{
		if(!isdefined(spawnbeacon))
		{
			continue;
		}
		if(team == spawnbeacon.team)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_cfabb62c
	Namespace: spawn_beacon
	Checksum: 0x48A99B08
	Offset: 0x718
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_cfabb62c(watcher)
{
	watcher.watchforfire = 1;
	watcher.onspawn = &function_f0edbdf5;
	watcher.ontimeout = &function_13ac856e;
	watcher.var_994b472b = &function_f9d3fff8;
	watcher.deleteonplayerspawn = 0;
}

/*
	Name: function_f9d3fff8
	Namespace: spawn_beacon
	Checksum: 0x80B60C34
	Offset: 0x798
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_f9d3fff8(player)
{
	if(isdefined(self) && isdefined(self.spawnbeacon))
	{
		self.spawnbeacon thread function_a9ff3efb(0);
	}
}

/*
	Name: function_13ac856e
	Namespace: spawn_beacon
	Checksum: 0xD876CFB
	Offset: 0x7E0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_13ac856e()
{
	if(isdefined(self) && isdefined(self.spawnbeacon))
	{
		self.spawnbeacon thread function_a9ff3efb(0);
	}
}

/*
	Name: function_f8930fa1
	Namespace: spawn_beacon
	Checksum: 0x24CE78B6
	Offset: 0x820
	Size: 0x284
	Parameters: 1
	Flags: None
*/
function function_f8930fa1(time)
{
	self endon(#"death", #"hash_1cda4fff4d28444");
	if(time == 0)
	{
		return;
	}
	if((isdefined(level.spawnbeaconsettings.var_7262646d) ? level.spawnbeaconsettings.var_7262646d : 0))
	{
		return;
	}
	if(isdefined(level.var_7a0aaea2))
	{
		time = level.var_7a0aaea2;
	}
	if(time > (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4) ? level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4 : 0))
	{
		wait(time - (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4) ? level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4 : 0));
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(level.var_a1ca927c))
	{
		self [[level.var_a1ca927c]]();
	}
	remainingtime = (time < (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4) ? level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4 : 0) ? time : (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4) ? level.spawnbeaconsettings.var_51d5c26f.var_a0ffd0e4 : 0));
	wait(remainingtime);
	while(isdefined(level.spawnbeaconsettings.var_9d48e929) && level.spawnbeaconsettings.var_9d48e929 && isdefined(self) && isdefined(self.owner) && !isalive(self.owner))
	{
		wait(0.5);
	}
	if(!isdefined(self))
	{
		return;
	}
	self thread function_a9ff3efb(0);
}

/*
	Name: function_f0edbdf5
	Namespace: spawn_beacon
	Checksum: 0x2DA8470B
	Offset: 0xAB0
	Size: 0x284
	Parameters: 2
	Flags: None
*/
function function_f0edbdf5(watcher, owner)
{
	self endon(#"death");
	self.var_52a68abf = 1;
	self thread weaponobjects::onspawnuseweaponobject(watcher, owner);
	self hide();
	if(isdefined(self.previouslyhacked) && self.previouslyhacked)
	{
		return;
	}
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](self, 0);
	}
	waitframe(1);
	if(!isdefined(owner))
	{
		self delete();
		return;
	}
	owner notify(#"hash_31be1f8b27209ad0", {#beacon:self, #player:owner});
	level notify(#"hash_31be1f8b27209ad0", {#beacon:self, #player:owner});
	if(!owner deployable::function_f8fe102f())
	{
		owner deployable::function_416f03e6(level.spawnbeaconsettings.var_c1a364b9);
		self delete();
		return;
	}
	if(isdefined(owner))
	{
		owner stats::function_e24eec31(self.weapon, #"used", 1);
	}
	self deployable::function_dd266e08(owner);
	self.var_9bab32d9 = owner.var_9bab32d9;
	owner.var_9bab32d9 = undefined;
	owner onplacespawnbeacon(self);
	owner clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
	owner.var_9698a18d = 1;
	spawnbeacon = self.spawnbeacon;
	spawnbeacon setanim(#"o_spawn_beacon_deploy", 1);
}

/*
	Name: function_d7cd849c
	Namespace: spawn_beacon
	Checksum: 0x3885C717
	Offset: 0xD40
	Size: 0x116
	Parameters: 3
	Flags: None
*/
function function_d7cd849c(var_cb0f3959, team, var_86a79150)
{
	if(!isdefined(var_cb0f3959))
	{
		return;
	}
	if(!isdefined(level.spawnbeaconsettings.var_d741a6a4[var_cb0f3959]))
	{
		level.spawnbeaconsettings.var_d741a6a4[var_cb0f3959] = 0;
	}
	var_ad7969ca = level.spawnbeaconsettings.var_d741a6a4[var_cb0f3959];
	if(var_ad7969ca != 0 && gettime() < int(5 * 1000) + var_ad7969ca)
	{
		return;
	}
	var_925a9324 = [];
	var_925a9324[0] = var_86a79150;
	killstreaks::leader_dialog(var_cb0f3959, team, var_925a9324, "spawnbeacon");
	level.spawnbeaconsettings.var_d741a6a4[var_cb0f3959] = gettime();
}

/*
	Name: setupclientfields
	Namespace: spawn_beacon
	Checksum: 0x62E9B76E
	Offset: 0xE60
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function setupclientfields()
{
	clientfield::register("scriptmover", "spawnbeacon_placed", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.spawnbeacon.active", 1, 1, "int");
}

/*
	Name: function_45a43bd6
	Namespace: spawn_beacon
	Checksum: 0x93F2DB01
	Offset: 0xED0
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_45a43bd6()
{
	player = self;
	if(isdefined(player.var_9698a18d) && player.var_9698a18d)
	{
		player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 1);
	}
}

/*
	Name: setupcallbacks
	Namespace: spawn_beacon
	Checksum: 0x719DA63F
	Offset: 0xF30
	Size: 0xCC
	Parameters: 0
	Flags: Private
*/
private function setupcallbacks()
{
	ability_player::register_gadget_activation_callbacks(26, &function_184fe5a4, &function_bd482609);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_spawned(&on_player_spawned);
	callback::on_loadout(&on_loadout);
	weaponobjects::function_e6400478(#"gadget_spawnbeacon", &function_cfabb62c, 1);
}

/*
	Name: function_9ede386f
	Namespace: spawn_beacon
	Checksum: 0x41BF9ED9
	Offset: 0x1008
	Size: 0x54
	Parameters: 1
	Flags: Private
*/
private function function_9ede386f(slot)
{
	wait(0.1);
	if(!isdefined(self))
	{
		return;
	}
	self function_19ed70ca(slot, 1);
	self gadgetpowerset(slot, 0);
}

/*
	Name: function_8892377a
	Namespace: spawn_beacon
	Checksum: 0x973E0145
	Offset: 0x1068
	Size: 0x154
	Parameters: 0
	Flags: None
*/
function function_8892377a()
{
	if(!self hasweapon(level.spawnbeaconsettings.var_c1a364b9))
	{
		self clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
		self.var_9698a18d = 0;
		self.var_583f6cce = undefined;
	}
	else if(!isdefined(self.pers[#"hash_677f229433c8735b"]))
	{
		self.pers[#"hash_677f229433c8735b"] = 0;
	}
	if(getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && self.pers[#"hash_677f229433c8735b"] >= 1)
	{
		var_4dbaac09 = self gadgetgetslot(level.spawnbeaconsettings.var_c1a364b9);
		self thread function_9ede386f(var_4dbaac09);
	}
}

/*
	Name: on_loadout
	Namespace: spawn_beacon
	Checksum: 0xC13B15A5
	Offset: 0x11C8
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_loadout()
{
	self function_8892377a();
}

/*
	Name: on_player_spawned
	Namespace: spawn_beacon
	Checksum: 0xFC6A4D25
	Offset: 0x11F0
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	player = self;
	player function_45a43bd6();
	if(isdefined(level.var_9fa5aeb4))
	{
		self [[level.var_9fa5aeb4]]();
	}
}

/*
	Name: function_41a037e6
	Namespace: spawn_beacon
	Checksum: 0xCFD732CC
	Offset: 0x1240
	Size: 0x196
	Parameters: 0
	Flags: None
*/
function function_41a037e6()
{
	spawnbeacon = self;
	spawnbeacon.threatlevel = 0;
	foreach(player in level.players)
	{
		if(player getteam() == spawnbeacon.team)
		{
			continue;
		}
		foreach(var_25d50c8b in level.spawnbeaconsettings.var_613ff100)
		{
			distance = distancesquared(spawnbeacon.origin, player.origin);
			if(distance <= var_25d50c8b.var_ba0b31e6 && distance > var_25d50c8b.var_5857777c)
			{
				spawnbeacon.threatlevel = spawnbeacon.threatlevel + var_25d50c8b.points;
			}
		}
	}
}

/*
	Name: function_a8549b52
	Namespace: spawn_beacon
	Checksum: 0x7659774D
	Offset: 0x13E0
	Size: 0x19E
	Parameters: 0
	Flags: None
*/
function function_a8549b52()
{
	level endon(#"game_ended");
	spawnbeacon = self;
	spawnbeacon endon(#"hash_d0a2bdefbbff6f6");
	while(isdefined(spawnbeacon))
	{
		if(isdefined(spawnbeacon.isdisabled) && spawnbeacon.isdisabled)
		{
			spawnbeacon waittill(#"hash_390d1d75264c4e9f");
		}
		spawnbeacon function_41a037e6();
		if(spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_ba2632d3) ? level.spawnbeaconsettings.var_51d5c26f.var_ba2632d3 : 0))
		{
			objective_setgamemodeflags(spawnbeacon.objectiveid, 2);
		}
		else if(spawnbeacon.threatlevel >= (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_332c5109) ? level.spawnbeaconsettings.var_51d5c26f.var_332c5109 : 0))
		{
			objective_setgamemodeflags(spawnbeacon.objectiveid, 1);
		}
		else
		{
			objective_setgamemodeflags(spawnbeacon.objectiveid, 0);
		}
		wait(1);
	}
}

/*
	Name: getnewspawnbeaconspawnlist
	Namespace: spawn_beacon
	Checksum: 0xD363C04B
	Offset: 0x1588
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function getnewspawnbeaconspawnlist()
{
	if(!sessionmodeiscampaigngame())
	{
		/#
			assert(level.spawnbeaconsettings.availablespawnlists.size > 0);
		#/
		spawnlist = array::pop(level.spawnbeaconsettings.availablespawnlists);
		/#
			assert(isdefined(spawnlist));
		#/
		return spawnlist;
	}
}

/*
	Name: freespawnbeaconspawnlist
	Namespace: spawn_beacon
	Checksum: 0xFB41CF98
	Offset: 0x1628
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function freespawnbeaconspawnlist(spawnlistname)
{
	if(isdefined(spawnlistname))
	{
		/#
			assert(!array::contains(level.spawnbeaconsettings.availablespawnlists, spawnlistname));
		#/
		array::push(level.spawnbeaconsettings.availablespawnlists, spawnlistname);
	}
}

/*
	Name: function_184fe5a4
	Namespace: spawn_beacon
	Checksum: 0xFB7646E5
	Offset: 0x16A8
	Size: 0x66
	Parameters: 2
	Flags: None
*/
function function_184fe5a4(slot, playerweapon)
{
	/#
		assert(isplayer(self));
	#/
	self notify(#"hash_4537c6dac90cc3f2", {#weapon:playerweapon});
}

/*
	Name: function_bd482609
	Namespace: spawn_beacon
	Checksum: 0x243B075F
	Offset: 0x1718
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function function_bd482609(slot, weapon)
{
	self.var_c11172a1 = 0;
}

/*
	Name: on_player_killed
	Namespace: spawn_beacon
	Checksum: 0x9406DB57
	Offset: 0x1740
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function on_player_killed(s_params)
{
	if(isdefined(self.spawnbeaconbuildprogressobjid))
	{
		deleteobjective(self.spawnbeaconbuildprogressobjid);
		self.spawnbeaconbuildprogressobjid = undefined;
	}
	if(isdefined(self.var_c11172a1) && self.var_c11172a1 && isdefined(s_params.eattacker))
	{
		killstreaks::processscoreevent(#"forward_spawn_stopped_activation", s_params.eattacker, undefined, level.spawnbeaconsettings.var_c1a364b9);
	}
}

/*
	Name: getobjectiveid
	Namespace: spawn_beacon
	Checksum: 0x8E60B111
	Offset: 0x17F8
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function getobjectiveid()
{
	return gameobjects::get_next_obj_id();
}

/*
	Name: deleteobjective
	Namespace: spawn_beacon
	Checksum: 0xEB3530A5
	Offset: 0x1818
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function deleteobjective(objectiveid)
{
	if(isdefined(objectiveid))
	{
		objective_delete(objectiveid);
		gameobjects::release_obj_id(objectiveid);
	}
}

/*
	Name: function_4d9f82ce
	Namespace: spawn_beacon
	Checksum: 0x27BDFABD
	Offset: 0x1868
	Size: 0x166
	Parameters: 0
	Flags: None
*/
function function_4d9f82ce()
{
	spawnbeacon = self;
	player = spawnbeacon.owner;
	if(!isdefined(player))
	{
		return;
	}
	if(!player hasweapon(level.spawnbeaconsettings.var_c1a364b9))
	{
		return;
	}
	var_4dbaac09 = player gadgetgetslot(level.spawnbeaconsettings.var_c1a364b9);
	currentpower = player gadgetpowerget(var_4dbaac09) / 100;
	penalty = (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_da5fcc2d) ? level.spawnbeaconsettings.var_51d5c26f.var_da5fcc2d : 0) - (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_da5fcc2d) ? level.spawnbeaconsettings.var_51d5c26f.var_da5fcc2d : 0) * currentpower;
	player.var_299012ff = int(penalty);
}

/*
	Name: function_e46fd633
	Namespace: spawn_beacon
	Checksum: 0xACE08B93
	Offset: 0x19D8
	Size: 0x1CC
	Parameters: 0
	Flags: Private
*/
private function function_e46fd633()
{
	spawnbeacon = self;
	if((isdefined(level.spawnbeaconsettings.var_51d5c26f.var_d2110d43) ? level.spawnbeaconsettings.var_51d5c26f.var_d2110d43 : 0))
	{
		spawnbeacon function_4d9f82ce();
	}
	var_b80d3663 = isdefined(spawnbeacon.var_d02ddb8e) && spawnbeacon.var_d02ddb8e.name === "gadget_icepick";
	if(isdefined(self.owner) && !var_b80d3663)
	{
		var_9a5be956 = self.owner;
		self.owner thread killstreaks::play_taacom_dialog("spawnBeaconDestroyedFriendly");
	}
	function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_79efc1, util::getotherteam(spawnbeacon.team), spawnbeacon.var_846acfcf);
	if(!var_b80d3663)
	{
		function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_2ee73347, spawnbeacon.team, var_9a5be956);
		spawnbeacon.owner globallogic_score::function_5829abe3(spawnbeacon.var_846acfcf, spawnbeacon.var_d02ddb8e, level.spawnbeaconsettings.var_c1a364b9);
	}
}

/*
	Name: function_a9ff3efb
	Namespace: spawn_beacon
	Checksum: 0xC0544248
	Offset: 0x1BB0
	Size: 0x9BC
	Parameters: 1
	Flags: None
*/
function function_a9ff3efb(var_d3213f00)
{
	self notify(#"hash_523ddcbd662010e5");
	self function_68a6ec15();
	self.var_ab0875aa = 1;
	spawnbeacon = self;
	attacker = (var_d3213f00 ? self.var_846acfcf : self.owner);
	spawnbeacon dodamage(spawnbeacon.health + 10000, spawnbeacon.origin, attacker, undefined, undefined, "MOD_EXPLOSIVE");
	if(target_istarget(spawnbeacon))
	{
		target_remove(spawnbeacon);
	}
	player = self.owner;
	if(isdefined(self.beacondisabled) && self.beacondisabled)
	{
		return;
	}
	if(isdefined(level.var_d2600afc) && (isdefined(spawnbeacon.var_846acfcf) && spawnbeacon.var_846acfcf != player))
	{
		self [[level.var_d2600afc]](spawnbeacon.var_846acfcf, player, level.spawnbeaconsettings.var_c1a364b9, spawnbeacon.var_d02ddb8e);
	}
	if(game.state == "playing")
	{
		if(spawnbeacon.health <= 0)
		{
			if(isdefined(level.spawnbeaconsettings.var_51d5c26f.var_b3756378))
			{
				spawnbeacon playsound(level.spawnbeaconsettings.var_51d5c26f.var_b3756378);
			}
		}
		else if(isdefined(level.spawnbeaconsettings.var_51d5c26f.var_b4ecfeb2))
		{
			spawnbeacon playsound(level.spawnbeaconsettings.var_51d5c26f.var_b4ecfeb2);
		}
		if(isdefined(var_d3213f00) && var_d3213f00)
		{
			self function_e46fd633();
		}
		else if(isdefined(self.owner))
		{
			var_9a5be956 = self.owner;
			self.owner thread killstreaks::play_taacom_dialog("spawnBeaconOfflineFriendly");
		}
		function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_10c9ba2d, self.team, var_9a5be956);
		function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_f29e64de, util::getotherteam(self.team), undefined);
	}
	if(isdefined(level.spawnbeaconsettings.var_51d5c26f.var_35fbc280))
	{
		playfx(level.spawnbeaconsettings.var_51d5c26f.var_35fbc280, spawnbeacon.origin);
	}
	if(isdefined(level.spawnbeaconsettings.var_51d5c26f.var_bb6c29b4) && isdefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle"))
	{
		playfx(level.spawnbeaconsettings.var_51d5c26f.var_bb6c29b4, spawnbeacon.origin);
	}
	if((isdefined(self.var_ca3a0f16) ? self.var_ca3a0f16 : 0) || (isdefined(player) && isdefined(player.var_c4a4cb7d) && player hasweapon(getweapon(#"hash_7ab3f9a730359659"), 1)))
	{
		if(isdefined(self.objectiveid))
		{
			gameobjects::release_obj_id(self.objectiveid);
		}
	}
	else
	{
		if(isdefined(level.var_34c482f2))
		{
			self [[level.var_34c482f2]](attacker, self.var_d02ddb8e);
		}
		/#
			array::push_front(level.spawnbeaconsettings.var_e7571ff1, self.objectiveid);
		#/
		if(isdefined(self.objectiveid))
		{
			deleteobjective(self.objectiveid);
			level.spawnbeaconsettings.beacons[self.objectiveid] = undefined;
		}
		self.beacondisabled = 1;
		freespawnbeaconspawnlist(self.spawnlist);
	}
	self clientfield::set("enemyequip", 0);
	if(isdefined(self.var_d7cf6658))
	{
		foreach(gameobject in self.var_d7cf6658)
		{
			gameobject gameobjects::destroy_object(1, 1);
		}
	}
	if(isdefined(self.owner))
	{
		var_c2ca0930 = getarraykeys(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid]);
		foreach(var_2f55edb in var_c2ca0930)
		{
			if(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid][var_2f55edb] == self)
			{
				var_10432750 = var_2f55edb;
			}
		}
	}
	if(isdefined(var_10432750))
	{
		level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid] = array::remove_index(level.spawnbeaconsettings.userspawnbeacons[self.owner.clientid], var_10432750, 0);
	}
	self stoploopsound();
	self notify(#"hash_d0a2bdefbbff6f6");
	self callback::remove_callback(#"on_end_game", &function_438ca4e0);
	if(isdefined(player))
	{
		player notify(#"hash_d0a2bdefbbff6f6");
		player clientfield::set_player_uimodel("hudItems.spawnbeacon.active", 0);
		player.var_9698a18d = 0;
		player.var_583f6cce = undefined;
	}
	if(isdefined(self.var_2d045452))
	{
		self.var_2d045452 delete();
	}
	deployable::function_81598103(self);
	var_b0e81be9 = self gettagorigin("tag_base_d0");
	if(!isdefined(var_b0e81be9))
	{
		var_b0e81be9 = self.origin;
	}
	var_505e3308 = self gettagangles("tag_base_d0");
	if(!isdefined(var_505e3308))
	{
		var_505e3308 = self.angles;
	}
	var_8fec56c4 = anglestoforward(var_505e3308);
	var_61753233 = anglestoup(var_505e3308);
	playfx(#"hash_695b2e7e4b63a645", var_b0e81be9, var_8fec56c4, var_61753233);
	if(!(isdefined(spawnbeacon.var_4fc7245b) ? spawnbeacon.var_4fc7245b : 0) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0) && isdefined(player))
	{
		player.pers[#"lives"]--;
	}
	self delete();
}

/*
	Name: getspawnbeaconspawns
	Namespace: spawn_beacon
	Checksum: 0xCC24B47E
	Offset: 0x2578
	Size: 0x3F0
	Parameters: 1
	Flags: None
*/
function getspawnbeaconspawns(origin)
{
	spawnstoadd = [];
	collectionradiusmax = (isdefined(level.spawnbeaconsettings.var_51d5c26f.collectionradiusmax) ? level.spawnbeaconsettings.var_51d5c26f.collectionradiusmax : 0) * (isdefined(level.spawnbeaconsettings.var_51d5c26f.collectionradiusmax) ? level.spawnbeaconsettings.var_51d5c26f.collectionradiusmax : 0);
	collectionradiusmin = (isdefined(level.spawnbeaconsettings.var_51d5c26f.collectionradiusmin) ? level.spawnbeaconsettings.var_51d5c26f.collectionradiusmin : 0) * (isdefined(level.spawnbeaconsettings.var_51d5c26f.collectionradiusmin) ? level.spawnbeaconsettings.var_51d5c26f.collectionradiusmin : 0);
	var_a62d9bc = (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_6150bb7f) ? level.spawnbeaconsettings.var_51d5c26f.var_6150bb7f : 0);
	if(!isdefined(level.allspawnpoints))
	{
		return spawnstoadd;
	}
	foreach(spawnpoint in level.allspawnpoints)
	{
		if((isdefined(spawnpoint.ct) ? spawnpoint.ct : 0))
		{
			continue;
		}
		if(var_a62d9bc > 0 && abs(spawnpoint.origin[2] - origin[2]) > var_a62d9bc)
		{
			continue;
		}
		distsqr = distancesquared(origin, spawnpoint.origin);
		if(distsqr > collectionradiusmax)
		{
			continue;
		}
		if(distsqr < collectionradiusmin)
		{
			continue;
		}
		var_dcf0e6cc = 0;
		foreach(protectedzone in level.spawnbeaconsettings.var_d6a27a84)
		{
			if(protectedzone istouching(spawnpoint.origin, (45, 45, 72)))
			{
				var_dcf0e6cc = 1;
				break;
			}
		}
		if(var_dcf0e6cc)
		{
			continue;
		}
		if(!isdefined(spawnpoint.enabled))
		{
			spawnpoint.enabled = -1;
		}
		if(!isdefined(spawnstoadd))
		{
			spawnstoadd = [];
		}
		else if(!isarray(spawnstoadd))
		{
			spawnstoadd = array(spawnstoadd);
		}
		spawnstoadd[spawnstoadd.size] = spawnpoint;
	}
	return spawnstoadd;
}

/*
	Name: createspawngroupforspawnbeacon
	Namespace: spawn_beacon
	Checksum: 0x22833CCF
	Offset: 0x2970
	Size: 0x1D6
	Parameters: 2
	Flags: None
*/
function createspawngroupforspawnbeacon(associatedspawnbeacon, spawnstoadd)
{
	/#
		assert(isdefined(spawnstoadd));
	#/
	/#
		assert(isdefined(associatedspawnbeacon));
	#/
	if(spawnstoadd.size == 0)
	{
		return 0;
	}
	team = associatedspawnbeacon.team;
	enemyteam = util::getotherteam(team);
	var_5b29525a = level.teambased && isdefined(game.switchedsides) && game.switchedsides && level.spawnsystem.var_3709dc53;
	associatedspawnbeacon.spawnlist = getnewspawnbeaconspawnlist();
	/#
		assert(isdefined(associatedspawnbeacon.spawnlist));
	#/
	if(level.teambased)
	{
		if(var_5b29525a)
		{
			enemyteam = team;
			team = enemyteam;
		}
		/#
			assert(isdefined(team));
		#/
		addspawnpoints(team, spawnstoadd, associatedspawnbeacon.spawnlist);
		addspawnpoints(enemyteam, spawnstoadd, associatedspawnbeacon.spawnlist);
	}
	else
	{
		addspawnpoints("free", spawnstoadd, associatedspawnbeacon.spawnlist);
	}
	associatedspawnbeacon.spawns = spawnstoadd;
	return 1;
}

/*
	Name: function_425d8006
	Namespace: spawn_beacon
	Checksum: 0x358C2EA3
	Offset: 0x2B50
	Size: 0x200
	Parameters: 0
	Flags: None
*/
function function_425d8006()
{
	spawnbeacon = self;
	spawnbeacon endon(#"hash_d0a2bdefbbff6f6");
	level endon(#"game_ended");
	spawnbeacon.isdisabled = 1;
	spawnbeacon notify(#"hash_11330668dbb5f2aa");
	objective_setgamemodeflags(spawnbeacon.objectiveid, 3);
	var_d7760961 = (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_26f4f5f0) ? level.spawnbeaconsettings.var_51d5c26f.var_26f4f5f0 : 0);
	var_f1c32a14 = "";
	if(spawnbeacon.team == #"allies")
	{
		var_f1c32a14 = "A";
	}
	else
	{
		var_f1c32a14 = "B";
	}
	function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_1068819a, spawnbeacon.team, undefined);
	function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_c5d0582b, util::getotherteam(spawnbeacon.team), undefined);
	setbombtimer(var_f1c32a14, gettime() + int(var_d7760961 * 1000));
	wait(var_d7760961);
	spawnbeacon.isdisabled = 0;
	spawnbeacon notify(#"hash_390d1d75264c4e9f");
}

/*
	Name: watchfordeath
	Namespace: spawn_beacon
	Checksum: 0x6151BE03
	Offset: 0x2D58
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function watchfordeath()
{
	level endon(#"game_ended");
	self.owner endon(#"disconnect", #"joined_team", #"changed_specialist");
	self endon(#"hash_523ddcbd662010e5");
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_b08a3652 = 1;
	self.var_846acfcf = waitresult.attacker;
	self.var_d02ddb8e = waitresult.weapon;
	if(isdefined(waitresult.attacker) && isdefined(self) && isdefined(self.owner) && waitresult.attacker.team == self.owner.team)
	{
		var_b08a3652 = 0;
	}
	self thread function_a9ff3efb(var_b08a3652);
}

/*
	Name: watchfordamage
	Namespace: spawn_beacon
	Checksum: 0xC6A1D917
	Offset: 0x2EA8
	Size: 0x180
	Parameters: 0
	Flags: None
*/
function watchfordamage()
{
	self endon(#"death");
	level endon(#"game_ended");
	self endon(#"hash_523ddcbd662010e5");
	spawnbeacon = self;
	spawnbeacon endon(#"death");
	spawnbeacon.health = level.spawnbeaconsettings.var_51d5c26f.health;
	if(isdefined(level.var_b8701e49))
	{
		spawnbeacon.health = level.var_b8701e49;
	}
	spawnbeacon.maxhealth = spawnbeacon.health;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(isdefined(waitresult.attacker) && waitresult.amount > 0 && damagefeedback::dodamagefeedback(waitresult.weapon, waitresult.attacker))
		{
			waitresult.attacker damagefeedback::update(waitresult.mod, waitresult.inflictor, undefined, waitresult.weapon, self);
		}
	}
}

/*
	Name: function_40c032a1
	Namespace: spawn_beacon
	Checksum: 0x395DBB65
	Offset: 0x3030
	Size: 0x112
	Parameters: 12
	Flags: None
*/
function function_40c032a1(einflictor, attacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, iboneindex, imodelindex)
{
	bundle = level.spawnbeaconsettings.var_51d5c26f;
	chargelevel = 0;
	weapon_damage = killstreak_bundles::function_dd7587e4(bundle, bundle.health, attacker, weapon, smeansofdeath, idamage, idflags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = killstreaks::get_old_damage(attacker, weapon, smeansofdeath, idamage, 1);
	}
	return int(weapon_damage);
}

/*
	Name: function_438ca4e0
	Namespace: spawn_beacon
	Checksum: 0x8D9867E
	Offset: 0x3150
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_438ca4e0()
{
	spawnbeacon = self;
	spawnbeacon.var_648955e6 = 1;
	spawnbeacon function_68a6ec15();
}

/*
	Name: function_9c87725b
	Namespace: spawn_beacon
	Checksum: 0x6C8134B4
	Offset: 0x3190
	Size: 0x36
	Parameters: 0
	Flags: None
*/
function function_9c87725b()
{
	var_d5110c6d = game.spawnbeaconid;
	game.spawnbeaconid = game.spawnbeaconid + 1;
	return var_d5110c6d;
}

/*
	Name: function_639cb9da
	Namespace: spawn_beacon
	Checksum: 0xD447EE52
	Offset: 0x31D0
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_639cb9da()
{
	self endon(#"death");
	self waittill(#"game_ended");
	if(!isdefined(self))
	{
		return;
	}
	self function_a9ff3efb(0);
}

/*
	Name: function_b3608e1
	Namespace: spawn_beacon
	Checksum: 0x72094947
	Offset: 0x3228
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function function_b3608e1(spawnbeacon)
{
	spawnbeacon.objectiveid = getobjectiveid();
	objective_add(spawnbeacon.objectiveid, "active", spawnbeacon.origin, level.spawnbeaconsettings.var_51d5c26f.var_3fd7e59a);
	objective_setteam(spawnbeacon.objectiveid, spawnbeacon.team);
	function_3ae6fa3(spawnbeacon.objectiveid, spawnbeacon.owner.team, 1);
	objective_setprogress(spawnbeacon.objectiveid, 1);
}

/*
	Name: function_2a54cacd
	Namespace: spawn_beacon
	Checksum: 0x10FC4A0A
	Offset: 0x3328
	Size: 0x888
	Parameters: 2
	Flags: None
*/
function function_2a54cacd(var_a820f9, spawns)
{
	player = self;
	if(isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid]) && level.spawnbeaconsettings.userspawnbeacons[player.clientid].size >= (isdefined(level.spawnbeaconsettings.var_51d5c26f.var_e3d3bd15) ? level.spawnbeaconsettings.var_51d5c26f.var_e3d3bd15 : 1))
	{
		beacontoremove = level.spawnbeaconsettings.userspawnbeacons[player.clientid][0];
		if(isdefined(beacontoremove))
		{
			beacontoremove thread function_a9ff3efb(0);
		}
		else
		{
			level.spawnbeaconsettings.userspawnbeacons[self.clientid] = undefined;
		}
	}
	slot = player gadgetgetslot(level.spawnbeaconsettings.var_c1a364b9);
	player gadgetpowerreset(slot);
	player gadgetpowerset(slot, 0);
	var_4dbaac09 = player gadgetgetslot(level.spawnbeaconsettings.var_c1a364b9);
	player function_69b5c53c(var_4dbaac09, 0);
	var_60dbfaf8 = spawn("script_model", var_a820f9.origin);
	var_60dbfaf8 setmodel(level.spawnbeaconsettings.var_c1a364b9.worldmodel);
	var_a820f9.spawnbeacon = var_60dbfaf8;
	var_60dbfaf8.var_2d045452 = var_a820f9;
	var_60dbfaf8 function_41b29ff0(#"hash_77200d1bb519ba08");
	var_60dbfaf8 useanimtree("generic");
	target_set(var_60dbfaf8, vectorscale((0, 0, 1), 32));
	var_60dbfaf8.owner = player;
	var_60dbfaf8 clientfield::set("spawnbeacon_placed", 1);
	var_60dbfaf8 setteam(player getteam());
	var_60dbfaf8.var_86a21346 = &function_40c032a1;
	var_60dbfaf8 solid();
	var_60dbfaf8 show();
	var_60dbfaf8.victimsoundmod = "vehicle";
	if((isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0))
	{
		player.pers[#"lives"]++;
	}
	var_60dbfaf8 setweapon(level.spawnbeaconsettings.var_c1a364b9);
	var_60dbfaf8.weapon = level.spawnbeaconsettings.var_c1a364b9;
	function_b3608e1(var_60dbfaf8);
	createspawngroupforspawnbeacon(var_60dbfaf8, spawns);
	level.spawnbeaconsettings.beacons[var_60dbfaf8.objectiveid] = var_60dbfaf8;
	if(!isdefined(level.spawnbeaconsettings.userspawnbeacons[player.clientid]))
	{
		level.spawnbeaconsettings.userspawnbeacons[player.clientid] = [];
	}
	var_a7edcaed = level.spawnbeaconsettings.userspawnbeacons.size + 1;
	array::push(level.spawnbeaconsettings.userspawnbeacons[player.clientid], var_60dbfaf8, var_a7edcaed);
	if((isdefined(level.spawnbeaconsettings.var_51d5c26f.canbedamaged) ? level.spawnbeaconsettings.var_51d5c26f.canbedamaged : 0))
	{
		var_60dbfaf8 setcandamage(1);
	}
	var_60dbfaf8 clientfield::set("enemyequip", 1);
	var_60dbfaf8.var_99d2556b = gettime();
	var_60dbfaf8.threatlevel = 0;
	var_60dbfaf8.spawncount = 0;
	var_60dbfaf8.uniqueid = function_9c87725b();
	function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_69b1ff7, player getteam(), player);
	function_d7cd849c(level.spawnbeaconsettings.var_51d5c26f.var_4f37dfe9, util::getotherteam(player getteam()), undefined);
	if(isdefined(level.spawnbeaconsettings.var_51d5c26f.var_a0db3d4d))
	{
		var_60dbfaf8 playloopsound(level.spawnbeaconsettings.var_51d5c26f.var_a0db3d4d);
	}
	if(isdefined(level.var_4b1d905b))
	{
		self [[level.var_4b1d905b]](var_60dbfaf8);
	}
	var_60dbfaf8 thread function_a8549b52();
	var_60dbfaf8 thread watchfordamage();
	var_60dbfaf8 thread watchfordeath();
	var_60dbfaf8 thread function_f8930fa1((isdefined(level.spawnbeaconsettings.var_51d5c26f.timeout) ? level.spawnbeaconsettings.var_51d5c26f.timeout : 0));
	var_60dbfaf8 thread function_639cb9da();
	var_60dbfaf8 callback::function_d8abfc3d(#"on_end_game", &function_438ca4e0);
	player deployable::function_6ec9ee30(var_60dbfaf8, level.spawnbeaconsettings.var_c1a364b9);
	if(!isdefined(player.pers[#"hash_677f229433c8735b"]))
	{
		player.pers[#"hash_677f229433c8735b"] = 0;
	}
	player.pers[#"hash_677f229433c8735b"]++;
	if(getdvarint(#"hash_da55c6d97d1dc52", 1) && (isdefined(level.var_6cd68fbe) ? level.var_6cd68fbe : 0))
	{
		player function_19ed70ca(slot, 1);
	}
	player.var_583f6cce = var_60dbfaf8;
	player notify(#"hash_5cc0dbbb9afaf340");
}

/*
	Name: function_264da546
	Namespace: spawn_beacon
	Checksum: 0x1D136018
	Offset: 0x3BB8
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function function_264da546(var_cd3712d2, jammer)
{
	/#
		println("");
	#/
}

/*
	Name: function_9aafb7bb
	Namespace: spawn_beacon
	Checksum: 0xC0A675C4
	Offset: 0x3BF8
	Size: 0x88
	Parameters: 3
	Flags: None
*/
function function_9aafb7bb(origin, angles, player)
{
	if(!isdefined(player.var_9bab32d9))
	{
		player.var_9bab32d9 = spawnstruct();
	}
	player.var_9bab32d9.spawns = [];
	if(isdefined(level.var_ae2fe442))
	{
		return [[level.var_ae2fe442]](origin, angles, player);
	}
	return 1;
}

/*
	Name: onplacespawnbeacon
	Namespace: spawn_beacon
	Checksum: 0xD9D65C39
	Offset: 0x3C88
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function onplacespawnbeacon(spawnbeacon)
{
	spawnbeacon setvisibletoall();
	if(isdefined(spawnbeacon.othermodel))
	{
		spawnbeacon.othermodel setinvisibletoall();
	}
	if(isdefined(spawnbeacon.var_9bab32d9) && isdefined(spawnbeacon.var_9bab32d9.spawns))
	{
		self function_2a54cacd(spawnbeacon, spawnbeacon.var_9bab32d9.spawns);
	}
}

/*
	Name: oncancelplacement
	Namespace: spawn_beacon
	Checksum: 0xA9B60788
	Offset: 0x3D38
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function oncancelplacement(spawnbeacon)
{
	var_4dbaac09 = self gadgetgetslot(level.spawnbeaconsettings.var_c1a364b9);
	self gadgetdeactivate(var_4dbaac09, level.spawnbeaconsettings.var_c1a364b9, 0);
	self gadgetpowerset(var_4dbaac09, 100);
}

/*
	Name: function_d82c03d4
	Namespace: spawn_beacon
	Checksum: 0x708937E9
	Offset: 0x3DD0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_d82c03d4(player)
{
	spawnbeacon = self;
	player endon(#"disconnect");
	spawnbeacon endon(#"death");
	player waittill(#"joined_team");
	if(isdefined(spawnbeacon))
	{
		spawnbeacon thread function_a9ff3efb(0);
	}
}

/*
	Name: function_e9fea0ea
	Namespace: spawn_beacon
	Checksum: 0x4B315C06
	Offset: 0x3E60
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_e9fea0ea()
{
	player = self;
	if(!isdefined(level.spawnbeaconsettings) || !isdefined(level.spawnbeaconsettings.userspawnbeacons))
	{
		return undefined;
	}
	return level.spawnbeaconsettings.userspawnbeacons[player.clientid];
}

/*
	Name: function_68a6ec15
	Namespace: spawn_beacon
	Checksum: 0x80F724D1
	Offset: 0x3EC8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_68a6ec15()
{
}

/*
	Name: function_d32596e5
	Namespace: spawn_beacon
	Checksum: 0x80F724D1
	Offset: 0x3ED8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_d32596e5()
{
}

