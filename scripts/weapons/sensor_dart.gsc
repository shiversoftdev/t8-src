// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\globallogic\globallogic_score.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace sensor_dart;

/*
	Name: __init__system__
	Namespace: sensor_dart
	Checksum: 0xAA5B377B
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"sensor_dart", &init_shared, undefined, undefined);
}

/*
	Name: init_shared
	Namespace: sensor_dart
	Checksum: 0x2AE7D268
	Offset: 0x228
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	level thread register();
	callback::on_spawned(&on_player_spawned);
	weaponobjects::function_e6400478(#"eq_sensor", &function_eb12ff13, 1);
	globallogic_score::function_5a241bd8(getweapon("eq_sensor"), &function_4d8676af);
	globallogic_score::function_86f90713(getweapon("eq_sensor"), &function_4d8676af);
	level.var_1f151eb = getweapon("eq_sensor");
	if(getgametypesetting(#"competitivesettings") === 1)
	{
		level.var_e88e144b = getscriptbundle("sensor_custom_settings_comp");
	}
	else
	{
		if(isdefined(level.var_1f151eb.customsettings))
		{
			level.var_e88e144b = getscriptbundle(level.var_1f151eb.customsettings);
		}
		else
		{
			level.var_e88e144b = getscriptbundle("sensor_custom_settings");
		}
	}
	level.var_9911d36f = &function_4db10465;
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: sensor_dart
	Checksum: 0x3D1555C9
	Offset: 0x428
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.var_1f151eb, &function_bff5c062);
	}
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](level.var_1f151eb, &weaponobjects::function_127fb8f3);
	}
}

/*
	Name: function_bff5c062
	Namespace: sensor_dart
	Checksum: 0x92E3C79C
	Offset: 0x4A0
	Size: 0x29C
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(sensordart, attackingplayer)
{
	sensordart.owner weaponobjects::hackerremoveweapon(sensordart);
	if(isdefined(sensordart.owner.sensor_darts))
	{
		arrayremovevalue(sensordart.owner.sensor_darts, sensordart);
	}
	sensordart setteam(attackingplayer.team);
	sensordart.team = attackingplayer.team;
	sensordart.owner = attackingplayer;
	sensordart setowner(attackingplayer);
	sensordart notify(#"hacked");
	sensordart clientfield::set("sensor_dart_state", 1);
	sensordart weaponobjects::function_386fa470(attackingplayer);
	if(!isdefined(attackingplayer.sensor_darts))
	{
		attackingplayer.sensor_darts = [];
	}
	if(!isdefined(attackingplayer.sensor_darts))
	{
		attackingplayer.sensor_darts = [];
	}
	else if(!isarray(attackingplayer.sensor_darts))
	{
		attackingplayer.sensor_darts = array(attackingplayer.sensor_darts);
	}
	attackingplayer.sensor_darts[attackingplayer.sensor_darts.size] = sensordart;
	if(isdefined(level.var_f1edf93f))
	{
		_station_up_to_detention_center_triggers = [[level.var_f1edf93f]]() * 1000;
		if((isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0))
		{
			sensordart notify(#"cancel_timeout");
			sensordart thread weaponobjects::function_d9c08e94(_station_up_to_detention_center_triggers, &function_4db10465);
		}
	}
	if(isdefined(level.var_fc1bbaef))
	{
		[[level.var_fc1bbaef]](sensordart);
	}
	sensordart thread weaponobjects::function_6d8aa6a0(attackingplayer, sensordart.var_2d045452);
}

/*
	Name: register
	Namespace: sensor_dart
	Checksum: 0x3FA10E5B
	Offset: 0x748
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function register()
{
	clientfield::register("missile", "sensor_dart_state", 1, 1, "int");
	clientfield::register("clientuimodel", "hudItems.sensorDartCount", 1, 3, "int");
}

/*
	Name: on_player_spawned
	Namespace: sensor_dart
	Checksum: 0xD63DA80B
	Offset: 0x7B8
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	weapon = getweapon("eq_sensor");
	if(isdefined(weapon) && !self hasweapon(weapon))
	{
		self clientfield::set_player_uimodel("hudItems.sensorDartCount", 0);
	}
}

/*
	Name: function_4d8676af
	Namespace: sensor_dart
	Checksum: 0x8E00FAD4
	Offset: 0x830
	Size: 0x25E
	Parameters: 5
	Flags: Linked
*/
function function_4d8676af(attacker, victim, weapon, attackerweapon, meansofdeath)
{
	if(!isdefined(attackerweapon) || !isdefined(attacker) || !isdefined(victim) || !isdefined(weapon))
	{
		return false;
	}
	if(isdefined(attacker.sensor_darts))
	{
		foreach(dart in attacker.sensor_darts)
		{
			if(isdefined(dart) && distancesquared(victim.origin, dart.origin) < ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) * ((sessionmodeiswarzonegame() ? 2400 : 800) + 50) && weapon != attackerweapon)
			{
				dart.killcount = (isdefined(dart.killcount) ? dart.killcount : 0) + 1;
				if(!isdefined(dart.var_cbca1a8f) && isdefined(level.var_ac6052e9) && dart.killcount >= [[level.var_ac6052e9]]("sensorDartSuccessKillCount", 0) && isdefined(level.playgadgetsuccess) && isdefined(dart.owner))
				{
					dart.owner [[level.playgadgetsuccess]](getweapon("eq_sensor"), undefined, victim);
					dart.var_cbca1a8f = 1;
				}
				return true;
			}
		}
	}
	return false;
}

/*
	Name: function_eb12ff13
	Namespace: sensor_dart
	Checksum: 0xAE848339
	Offset: 0xA98
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function function_eb12ff13(watcher)
{
	watcher.ondetonatecallback = &function_4b3bc61d;
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.deleteonplayerspawn = 0;
	watcher.enemydestroy = 1;
	watcher.onspawn = &function_f4970a20;
	watcher.ondamage = &function_55de888f;
	watcher.ondestroyed = &function_c142e8ec;
	watcher.pickup = &weaponobjects::function_db70257;
	watcher.var_994b472b = &function_95c69960;
}

/*
	Name: function_95c69960
	Namespace: sensor_dart
	Checksum: 0x1CF638A9
	Offset: 0xBB8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_95c69960(player)
{
	self function_c142e8ec(undefined, undefined);
}

/*
	Name: function_f4970a20
	Namespace: sensor_dart
	Checksum: 0x1DCBB31F
	Offset: 0xBE8
	Size: 0x3CC
	Parameters: 2
	Flags: Linked
*/
function function_f4970a20(watcher, player)
{
	player endon(#"death", #"disconnect");
	level endon(#"game_ended");
	self endon(#"death");
	self weaponobjects::onspawnuseweaponobject(watcher, player);
	self clientfield::set("sensor_dart_state", 1);
	self.var_2d045452 = watcher;
	self.weapon = getweapon(#"eq_sensor");
	self setweapon(self.weapon);
	if(!isdefined(player.sensor_darts))
	{
		player.sensor_darts = [];
	}
	if(!isdefined(player.sensor_darts))
	{
		player.sensor_darts = [];
	}
	else if(!isarray(player.sensor_darts))
	{
		player.sensor_darts = array(player.sensor_darts);
	}
	player.sensor_darts[player.sensor_darts.size] = self;
	waitresult = undefined;
	waitresult = self waittilltimeout(5, #"stationary");
	if(waitresult._notify == #"timeout")
	{
		function_4db10465();
		return;
	}
	player notify(#"hash_70f03cfbb15356c0", {#dart:self});
	player clientfield::set_player_uimodel("hudItems.sensorDartCount", player.sensor_darts.size);
	player stats::function_e24eec31(self.weapon, #"used", 1);
	self util::make_sentient();
	self thread function_cc9ab1fc();
	self thread function_cb672f03();
	if(isdefined(level.var_6ec46eeb))
	{
		level thread [[level.var_6ec46eeb]](self, player);
	}
	if(isdefined(level.var_2e552187))
	{
		n_fuse_time = level.var_2e552187;
	}
	else
	{
		n_fuse_time = int((isdefined(level.var_e88e144b.var_f196f1c0) ? level.var_e88e144b.var_f196f1c0 : 0) * 1000);
	}
	self thread weaponobjects::function_d9c08e94(n_fuse_time, &function_4db10465);
	self clientfield::set("enemyequip", 1);
	playfxontag(#"hash_1307839267d89579", self, "tag_fx");
}

/*
	Name: function_cb672f03
	Namespace: sensor_dart
	Checksum: 0x13893514
	Offset: 0xFC0
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_cb672f03()
{
	owner = self.owner;
	waitresult = undefined;
	waitresult = self waittill(#"picked_up", #"death");
	if(isdefined(owner) && isdefined(owner.sensor_darts))
	{
		arrayremovevalue(owner.sensor_darts, undefined);
		owner clientfield::set_player_uimodel("hudItems.sensorDartCount", owner.sensor_darts.size);
	}
	if(waitresult._notify == "death")
	{
		return;
	}
	if(isdefined(self))
	{
		self clientfield::set("sensor_dart_state", 0);
	}
}

/*
	Name: function_cc9ab1fc
	Namespace: sensor_dart
	Checksum: 0xA669B18
	Offset: 0x10B8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function function_cc9ab1fc()
{
	self endon(#"death");
	self waittill(#"hacked");
}

/*
	Name: function_c142e8ec
	Namespace: sensor_dart
	Checksum: 0x5FB6BDDF
	Offset: 0x10F0
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_c142e8ec(attacker, callback_data)
{
	playfx(level._equipment_explode_fx_lg, self.origin);
	self playsound(#"hash_2e37b2a562ab2bf8");
	var_3c4d4b60 = isdefined(self.owner);
	if(isdefined(attacker) && (!var_3c4d4b60 || self.owner util::isenemyplayer(attacker)))
	{
		if(var_3c4d4b60)
		{
			self.owner thread killstreaks::play_taacom_dialog("sensorDartDestroyedFriendly");
		}
		attacker challenges::destroyedequipment();
		scoreevents::processscoreevent(#"hash_4c5d3e163d180de8", attacker, self.owner, undefined);
		if(isdefined(level.var_d2600afc))
		{
			self [[level.var_d2600afc]](attacker, self.owner, self.weapon);
		}
	}
	self delete();
}

/*
	Name: function_4db10465
	Namespace: sensor_dart
	Checksum: 0xF63CAA78
	Offset: 0x1258
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_4db10465()
{
	self thread function_c142e8ec(undefined, undefined);
}

/*
	Name: function_4b3bc61d
	Namespace: sensor_dart
	Checksum: 0xA04BBC1D
	Offset: 0x1280
	Size: 0x204
	Parameters: 3
	Flags: Linked
*/
function function_4b3bc61d(attacker, weapon, target)
{
	level notify(#"hash_4ee855fb0aa467c9");
	if(!isdefined(weapon) || !weapon.isemp)
	{
		playfx(level._equipment_explode_fx_lg, self.origin);
	}
	if(isdefined(level.var_e88e144b.var_bb6c29b4) && isdefined(weapon) && weapon == getweapon(#"shock_rifle"))
	{
		playfx(level.var_e88e144b.var_bb6c29b4, self.origin);
	}
	if(isdefined(attacker) && self.owner util::isenemyplayer(attacker))
	{
		attacker challenges::destroyedequipment(weapon);
		self.owner globallogic_score::function_5829abe3(attacker, weapon, self.weapon);
	}
	if(function_3238d10d(self.origin))
	{
		playsoundatposition(#"hash_206452ff3953c686", self.origin);
	}
	if(isdefined(level.var_d2600afc))
	{
		self [[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
	}
	self.owner luinotifyevent(#"hash_4ee855fb0aa467c9");
	self delete();
}

/*
	Name: function_55de888f
	Namespace: sensor_dart
	Checksum: 0x7E691B91
	Offset: 0x1490
	Size: 0x38E
	Parameters: 1
	Flags: Linked
*/
function function_55de888f(watcher)
{
	self endon(#"death");
	self setcandamage(1);
	damagemax = 20;
	if(!self util::ishacked())
	{
		self.damagetaken = 0;
	}
	self.maxhealth = 10000;
	self.health = self.maxhealth;
	self setmaxhealth(self.maxhealth);
	attacker = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		damage = waitresult.amount;
		type = waitresult.mod;
		weapon = waitresult.weapon;
		damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
		attacker = self [[level.figure_out_attacker]](waitresult.attacker);
		attackerisplayer = isplayer(attacker);
		if(level.teambased && !sessionmodeiswarzonegame())
		{
			if(attackerisplayer && (!(isdefined(level.hardcoremode) && level.hardcoremode)) && !util::function_fbce7263(self.owner.team, attacker.pers[#"team"]) && self.owner != attacker)
			{
				continue;
			}
		}
		if(watcher.stuntime > 0 && weapon.dostun)
		{
			self thread weaponobjects::stunstart(watcher, watcher.stuntime);
		}
		if(attackerisplayer && damage::friendlyfirecheck(self.owner, attacker))
		{
			if(damagefeedback::dodamagefeedback(weapon, attacker))
			{
				attacker damagefeedback::update();
			}
		}
		if(type == "MOD_MELEE" || type == "MOD_MELEE_WEAPON_BUTT" || weapon.isemp || weapon.destroysequipment)
		{
			self.damagetaken = damagemax;
		}
		else
		{
			self.damagetaken = self.damagetaken + damage;
		}
		if(self.damagetaken >= damagemax)
		{
			watcher thread weaponobjects::waitanddetonate(self, 0.05, attacker, weapon);
			return;
		}
	}
}

