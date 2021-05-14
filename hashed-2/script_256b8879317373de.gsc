// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace player;

/*
	Name: function_89f2df9
	Namespace: player
	Checksum: 0xA74CE0FE
	Offset: 0x138
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player
	Checksum: 0xE9735667
	Offset: 0x180
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
	clientfield::register("world", "gameplay_started", 1, 1, "int");
	clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int");
	clientfield::register("toplayer", "player_dof_settings", 1, 2, "int");
	setdvar(#"hash_256144ebda864b87", 1);
	if(!isdefined(getdvarint(#"hash_8351525729015ab", 0)))
	{
		setdvar(#"hash_8351525729015ab", 0);
	}
}

/*
	Name: spawn_player
	Namespace: player
	Checksum: 0xAAD66F82
	Offset: 0x2B0
	Size: 0x354
	Parameters: 0
	Flags: Linked
*/
function spawn_player()
{
	self endon(#"disconnect", #"joined_spectators");
	self notify(#"spawned");
	level notify(#"player_spawned");
	self notify(#"end_respawn");
	self set_spawn_variables();
	self luinotifyevent(#"player_spawned", 0);
	self function_b552ffa9(#"player_spawned", 0);
	self setclientuivisibilityflag("killcam_nemesis", 0);
	self.sessionteam = self.team;
	function_73646bd9(self);
	self.sessionstate = "playing";
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	self.spectatekillcam = 0;
	self.statusicon = "";
	self.damagedplayers = [];
	self.friendlydamage = undefined;
	self.hasspawned = 1;
	self.lastspawntime = gettime();
	self.spawntime = gettime();
	self.afk = 0;
	self.laststunnedby = undefined;
	self.var_a010bd8f = undefined;
	self.var_9060b065 = undefined;
	self.lastflashedby = undefined;
	self.var_a7679005 = undefined;
	self.var_7ef2427c = undefined;
	self.var_e021fe43 = undefined;
	self.var_f866f320 = undefined;
	self.laststand = undefined;
	self.resurrect_not_allowed_by = undefined;
	self.revivingteammate = 0;
	self.burning = undefined;
	self.lastshotby = 127;
	self.maxhealth = self.spawnhealth;
	self.health = self.maxhealth;
	self function_9080887a();
	if(self.pers[#"lives"] && (!(isdefined(level.takelivesondeath) && level.takelivesondeath)))
	{
		self.pers[#"lives"]--;
	}
	if(isdefined(game.lives) && (isdefined(game.lives[self.team]) && game.lives[self.team]) && (!(isdefined(level.takelivesondeath) && level.takelivesondeath)))
	{
		game.lives[self.team]--;
	}
	self.disabledweapon = 0;
	self util::resetusability();
	self reset_attacker_list();
	self resetfov();
}

/*
	Name: on_player_spawned
	Namespace: player
	Checksum: 0xE4EC3AB0
	Offset: 0x610
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(util::function_3f165ee8())
	{
		return;
	}
	level.var_2386648b = 0;
	if(sessionmodeiszombiesgame() || sessionmodeiscampaigngame())
	{
		snappedorigin = self get_snapped_spot_origin(self.origin);
		if(!self flagsys::get(#"shared_igc"))
		{
			self setorigin(snappedorigin);
		}
		update_rate = 0.1;
	}
	if(function_f99d2668())
	{
		update_rate = 0.4;
		level.var_2386648b = 1;
	}
	if(isdefined(update_rate))
	{
		self thread last_valid_position(update_rate);
	}
}

/*
	Name: last_valid_position
	Namespace: player
	Checksum: 0x4E28A121
	Offset: 0x738
	Size: 0x4C8
	Parameters: 1
	Flags: Linked
*/
function last_valid_position(update_rate)
{
	self notify(#"stop_last_valid_position");
	self endon(#"stop_last_valid_position", #"disconnect");
	while(!isdefined(self.last_valid_position))
	{
		self.last_valid_position = getclosestpointonnavmesh(self.origin, 2048, 0);
		wait(update_rate);
	}
	while(isdefined(self))
	{
		if(isdefined(level.var_cdc822b) && ![[level.var_cdc822b]]())
		{
			wait(update_rate);
			continue;
		}
		var_fab0ffd6 = self getpathfindingradius();
		if(distance2dsquared(self.origin, self.last_valid_position) < var_fab0ffd6 * var_fab0ffd6 && self.origin[2] - self.last_valid_position[2] * self.origin[2] - self.last_valid_position[2] < 16 * 16)
		{
			wait(update_rate);
			continue;
		}
		if(self isplayerswimming())
		{
			if(isdefined(self.var_5d991645))
			{
				if(distancesquared(self.origin, self.var_5d991645) < var_fab0ffd6 * var_fab0ffd6)
				{
					wait(update_rate);
					continue;
				}
			}
			ground_pos = groundtrace(self.origin + vectorscale((0, 0, 1), 8), self.origin + vectorscale((0, 0, -1), 100000), 0, self)[#"position"];
			if(!isdefined(ground_pos))
			{
				wait(update_rate);
				continue;
			}
			position = getclosestpointonnavmesh(ground_pos, 100, var_fab0ffd6);
			if(isdefined(position))
			{
				self.last_valid_position = position;
				self.var_5d991645 = self.origin;
			}
		}
		else if(ispointonnavmesh(self.origin, self))
		{
			self.last_valid_position = self.origin;
		}
		else if(!ispointonnavmesh(self.origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(self.origin, self.last_valid_position) < 32 * 32 && self.origin[2] - self.last_valid_position[2] * self.origin[2] - self.last_valid_position[2] < 32 * 32)
		{
			wait(update_rate);
			continue;
		}
		else
		{
			position = getclosestpointonnavmesh(self.origin, 100, var_fab0ffd6);
			if(isdefined(position))
			{
				if(isdefined(level.var_2386648b) && level.var_2386648b)
				{
					player_position = self.origin + vectorscale((0, 0, 1), 20);
					var_f5df51f2 = position + vectorscale((0, 0, 1), 20);
					player_vehicle = undefined;
					if(isvehicle(self getgroundent()))
					{
						player_vehicle = self getgroundent();
					}
					if(bullettracepassed(player_position, var_f5df51f2, 0, self, player_vehicle))
					{
						self.last_valid_position = position;
					}
				}
				else
				{
					self.last_valid_position = position;
				}
			}
			else if(isdefined(level.var_a6a84389))
			{
				self.last_valid_position = self [[level.var_a6a84389]](var_fab0ffd6);
			}
		}
		wait(update_rate);
	}
}

/*
	Name: take_weapons
	Namespace: player
	Checksum: 0x16956B2E
	Offset: 0xC08
	Size: 0x224
	Parameters: 0
	Flags: Linked
*/
function take_weapons()
{
	if(!(isdefined(self.gun_removed) && self.gun_removed))
	{
		self.gun_removed = 1;
		self._weapons = [];
		if(!isdefined(self._current_weapon))
		{
			self._current_weapon = level.weaponnone;
		}
		w_current = self getcurrentweapon();
		if(w_current != level.weaponnone)
		{
			self._current_weapon = w_current;
		}
		a_weapon_list = self getweaponslist();
		if(self._current_weapon == level.weaponnone)
		{
			if(isdefined(a_weapon_list[0]))
			{
				self._current_weapon = a_weapon_list[0];
			}
		}
		foreach(weapon in a_weapon_list)
		{
			if(isdefined(weapon.dniweapon) && weapon.dniweapon)
			{
				continue;
			}
			if(!isdefined(self._weapons))
			{
				self._weapons = [];
			}
			else if(!isarray(self._weapons))
			{
				self._weapons = array(self._weapons);
			}
			self._weapons[self._weapons.size] = get_weapondata(weapon);
			self takeweapon(weapon);
		}
		if(isdefined(level.detach_all_weapons))
		{
			self [[level.detach_all_weapons]]();
		}
	}
}

/*
	Name: generate_weapon_data
	Namespace: player
	Checksum: 0xDBAC7572
	Offset: 0xE38
	Size: 0x216
	Parameters: 0
	Flags: Linked
*/
function generate_weapon_data()
{
	self._generated_weapons = [];
	if(!isdefined(self._generated_current_weapon))
	{
		self._generated_current_weapon = level.weaponnone;
	}
	if(isdefined(self.gun_removed) && self.gun_removed && isdefined(self._weapons))
	{
		self._generated_weapons = arraycopy(self._weapons);
		self._generated_current_weapon = self._current_weapon;
	}
	else
	{
		w_current = self getcurrentweapon();
		if(w_current != level.weaponnone)
		{
			self._generated_current_weapon = w_current;
		}
		a_weapon_list = self getweaponslist();
		if(self._generated_current_weapon == level.weaponnone)
		{
			if(isdefined(a_weapon_list[0]))
			{
				self._generated_current_weapon = a_weapon_list[0];
			}
		}
		foreach(weapon in a_weapon_list)
		{
			if(isdefined(weapon.dniweapon) && weapon.dniweapon)
			{
				continue;
			}
			if(!isdefined(self._generated_weapons))
			{
				self._generated_weapons = [];
			}
			else if(!isarray(self._generated_weapons))
			{
				self._generated_weapons = array(self._generated_weapons);
			}
			self._generated_weapons[self._generated_weapons.size] = get_weapondata(weapon);
		}
	}
}

/*
	Name: give_back_weapons
	Namespace: player
	Checksum: 0x1EB68700
	Offset: 0x1058
	Size: 0x176
	Parameters: 1
	Flags: Linked
*/
function give_back_weapons(b_immediate = 0)
{
	if(isdefined(self._weapons))
	{
		foreach(weapondata in self._weapons)
		{
			weapondata_give(weapondata);
		}
		if(isdefined(self._current_weapon) && self._current_weapon != level.weaponnone)
		{
			if(b_immediate)
			{
				self switchtoweaponimmediate(self._current_weapon);
			}
			else
			{
				self switchtoweapon(self._current_weapon);
			}
		}
		else
		{
			weapon = self loadout::function_18a77b37("primary");
			if(isdefined(weapon) && self hasweapon(weapon))
			{
				switch_to_primary_weapon(b_immediate);
			}
		}
	}
	self._weapons = undefined;
	self.gun_removed = undefined;
}

/*
	Name: get_weapondata
	Namespace: player
	Checksum: 0x5AB4A58E
	Offset: 0x11D8
	Size: 0x3AE
	Parameters: 1
	Flags: Linked
*/
function get_weapondata(weapon)
{
	if(isdefined(level.var_51443ce5))
	{
		return self [[level.var_51443ce5]](weapon);
	}
	weapondata = [];
	if(!isdefined(weapon))
	{
		weapon = self getcurrentweapon();
	}
	weapondata[#"weapon"] = weapon.rootweapon.name;
	weapondata[#"attachments"] = util::function_2146bd83(weapon);
	if(weapon != level.weaponnone)
	{
		weapondata[#"clip"] = self getweaponammoclip(weapon);
		weapondata[#"stock"] = self getweaponammostock(weapon);
		weapondata[#"fuel"] = self getweaponammofuel(weapon);
		weapondata[#"heat"] = self isweaponoverheating(1, weapon);
		weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
		weapondata[#"renderoptions"] = self getweaponoptions(weapon);
		if(weapon.isriotshield)
		{
			weapondata[#"health"] = self.weaponhealth;
		}
	}
	else
	{
		weapondata[#"clip"] = 0;
		weapondata[#"stock"] = 0;
		weapondata[#"fuel"] = 0;
		weapondata[#"heat"] = 0;
		weapondata[#"overheat"] = 0;
	}
	if(weapon.dualwieldweapon != level.weaponnone)
	{
		weapondata[#"lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
	}
	else
	{
		weapondata[#"lh_clip"] = 0;
	}
	if(weapon.altweapon != level.weaponnone)
	{
		weapondata[#"alt_clip"] = self getweaponammoclip(weapon.altweapon);
		weapondata[#"alt_stock"] = self getweaponammostock(weapon.altweapon);
	}
	else
	{
		weapondata[#"alt_clip"] = 0;
		weapondata[#"alt_stock"] = 0;
	}
	return weapondata;
}

/*
	Name: weapondata_give
	Namespace: player
	Checksum: 0x396E724D
	Offset: 0x1590
	Size: 0x2BC
	Parameters: 1
	Flags: Linked
*/
function weapondata_give(weapondata)
{
	if(isdefined(level.var_bfbdc0cd))
	{
		self [[level.var_bfbdc0cd]](weapondata);
		return;
	}
	weapon = util::get_weapon_by_name(weapondata[#"weapon"], weapondata[#"attachments"]);
	self giveweapon(weapon, weapondata[#"renderoptions"]);
	if(weapon != level.weaponnone)
	{
		self setweaponammoclip(weapon, weapondata[#"clip"]);
		self setweaponammostock(weapon, weapondata[#"stock"]);
		if(isdefined(weapondata[#"fuel"]))
		{
			self setweaponammofuel(weapon, weapondata[#"fuel"]);
		}
		if(isdefined(weapondata[#"heat"]) && isdefined(weapondata[#"overheat"]))
		{
			self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
		}
		if(weapon.isriotshield && isdefined(weapondata[#"health"]))
		{
			self.weaponhealth = weapondata[#"health"];
		}
	}
	if(weapon.dualwieldweapon != level.weaponnone)
	{
		self setweaponammoclip(weapon.dualwieldweapon, weapondata[#"lh_clip"]);
	}
	if(weapon.altweapon != level.weaponnone)
	{
		self setweaponammoclip(weapon.altweapon, weapondata[#"alt_clip"]);
		self setweaponammostock(weapon.altweapon, weapondata[#"alt_stock"]);
	}
}

/*
	Name: switch_to_primary_weapon
	Namespace: player
	Checksum: 0xA9069C9D
	Offset: 0x1858
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function switch_to_primary_weapon(b_immediate = 0)
{
	weapon = self loadout::function_18a77b37("primary");
	if(is_valid_weapon(weapon))
	{
		if(b_immediate)
		{
			self switchtoweaponimmediate(weapon);
		}
		else
		{
			self switchtoweapon(weapon);
		}
	}
}

/*
	Name: function_1bff13a1
	Namespace: player
	Checksum: 0x95468985
	Offset: 0x18F0
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_1bff13a1(b_immediate = 0)
{
	weapon = self loadout::function_18a77b37("secondary");
	if(is_valid_weapon(weapon))
	{
		if(b_immediate)
		{
			self switchtoweaponimmediate(weapon);
		}
		else
		{
			self switchtoweapon(weapon);
		}
	}
}

/*
	Name: fill_current_clip
	Namespace: player
	Checksum: 0x288F39CC
	Offset: 0x1988
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function fill_current_clip()
{
	w_current = self getcurrentweapon();
	if(w_current.isheavyweapon)
	{
		w_current = self loadout::function_18a77b37("primary");
	}
	if(isdefined(w_current) && self hasweapon(w_current))
	{
		self setweaponammoclip(w_current, w_current.clipsize);
	}
}

/*
	Name: is_valid_weapon
	Namespace: player
	Checksum: 0x35314059
	Offset: 0x1A30
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function is_valid_weapon(weaponobject)
{
	return isdefined(weaponobject) && weaponobject != level.weaponnone;
}

/*
	Name: is_spawn_protected
	Namespace: player
	Checksum: 0x8BE7F198
	Offset: 0x1A60
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function is_spawn_protected()
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(!isdefined(self.spawntime))
	{
		self.spawntime = 0;
	}
	if(!isdefined(level.spawnprotectiontimems))
	{
		level.spawnprotectiontimems = int((isdefined(level.spawnprotectiontime) ? level.spawnprotectiontime : 0) * 1000);
	}
	return gettime() - (isdefined(self.spawntime) ? self.spawntime : 0) <= level.spawnprotectiontimems;
}

/*
	Name: simple_respawn
	Namespace: player
	Checksum: 0x2E9B94E1
	Offset: 0x1B08
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function simple_respawn()
{
	self [[level.onspawnplayer]](0);
}

/*
	Name: get_snapped_spot_origin
	Namespace: player
	Checksum: 0xA7AACC4C
	Offset: 0x1B28
	Size: 0x136
	Parameters: 1
	Flags: Linked
*/
function get_snapped_spot_origin(spot_position)
{
	snap_max_height = 100;
	size = 15;
	height = size * 2;
	mins = (-1 * size, -1 * size, 0);
	maxs = (size, size, height);
	spot_position = (spot_position[0], spot_position[1], spot_position[2] + 5);
	new_spot_position = (spot_position[0], spot_position[1], spot_position[2] - snap_max_height);
	trace = physicstrace(spot_position, new_spot_position, mins, maxs, self);
	if(trace[#"fraction"] < 1)
	{
		return trace[#"position"];
	}
	return spot_position;
}

/*
	Name: allow_stance_change
	Namespace: player
	Checksum: 0x454A5903
	Offset: 0x1C68
	Size: 0x1B2
	Parameters: 1
	Flags: None
*/
function allow_stance_change(b_allow = 1)
{
	if(b_allow)
	{
		self allowprone(1);
		self allowcrouch(1);
		self allowstand(1);
	}
	else
	{
		str_stance = self getstance();
		switch(str_stance)
		{
			case "prone":
			{
				self allowprone(1);
				self allowcrouch(0);
				self allowstand(0);
				break;
			}
			case "crouch":
			{
				self allowprone(0);
				self allowcrouch(1);
				self allowstand(0);
				break;
			}
			case "stand":
			{
				self allowprone(0);
				self allowcrouch(0);
				self allowstand(1);
				break;
			}
		}
	}
}

/*
	Name: set_spawn_variables
	Namespace: player
	Checksum: 0x31273D6E
	Offset: 0x1E28
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function set_spawn_variables()
{
	resettimeout();
	self stopshellshock();
	self stoprumble("damage_heavy");
}

/*
	Name: reset_attacker_list
	Namespace: player
	Checksum: 0x2B456A2E
	Offset: 0x1E80
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function reset_attacker_list()
{
	self.attackers = [];
	self.attackerdata = [];
	self.attackerdamage = [];
	self.var_6ef09a14 = [];
	self.firsttimedamaged = 0;
}

/*
	Name: function_9080887a
	Namespace: player
	Checksum: 0xEED46786
	Offset: 0x1EC8
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_9080887a(var_cf05ebb7)
{
	if(!isdefined(self.var_894f7879))
	{
		self.var_894f7879 = [];
	}
	var_f7d37aa4 = 0;
	foreach(modifier in self.var_894f7879)
	{
		var_f7d37aa4 = var_f7d37aa4 + modifier;
	}
	var_9fc0715e = (isdefined(var_cf05ebb7) ? var_cf05ebb7 : self.spawnhealth);
	self.var_66cb03ad = int(var_9fc0715e + var_f7d37aa4 + (isdefined(level.var_90bb9821) ? level.var_90bb9821 : 0));
	if(self.var_66cb03ad < 1)
	{
		self.var_66cb03ad = 1;
	}
}

/*
	Name: function_d1768e8e
	Namespace: player
	Checksum: 0xEBFC7865
	Offset: 0x1FF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_d1768e8e()
{
	self notify(#"fully_healed");
	callback::callback(#"fully_healed");
}

/*
	Name: function_c6fe9951
	Namespace: player
	Checksum: 0xFD773145
	Offset: 0x2030
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_c6fe9951()
{
	self notify(#"hash_25663702210244cc");
	callback::callback(#"hash_25663702210244cc");
}

/*
	Name: function_2a67df65
	Namespace: player
	Checksum: 0x553A2C7F
	Offset: 0x2070
	Size: 0xE4
	Parameters: 4
	Flags: Linked
*/
function function_2a67df65(modname, value, var_96a9fbf4, var_b861a047)
{
	if(!isdefined(self.var_894f7879))
	{
		self.var_894f7879 = [];
	}
	self function_74598aba(var_96a9fbf4);
	var_4addc45b = 1;
	if(level.var_6adbdb63 === 1 && value < 0)
	{
		var_4addc45b = 0;
	}
	if(var_4addc45b)
	{
		self.var_894f7879[modname] = value;
	}
	self function_9080887a();
	if(!(isdefined(var_b861a047) && var_b861a047))
	{
		self function_b2b139e6();
	}
}

/*
	Name: function_b2b139e6
	Namespace: player
	Checksum: 0x4BDA00DB
	Offset: 0x2160
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_b2b139e6()
{
	if(isdefined(self.var_abe2db87))
	{
		return;
	}
	if(self.health > self.var_66cb03ad)
	{
		self.health = self.var_66cb03ad;
		self function_d1768e8e();
	}
}

/*
	Name: function_b933de24
	Namespace: player
	Checksum: 0xB7F9C6B
	Offset: 0x21B8
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_b933de24(modname, var_b861a047)
{
	if(isdefined(self))
	{
		if(!isdefined(self.var_894f7879))
		{
			self.var_894f7879 = [];
		}
		var_d87cedce = self.var_66cb03ad;
		self.var_894f7879[modname] = undefined;
		self function_9080887a();
		if(!(isdefined(var_b861a047) && var_b861a047))
		{
			self function_b2b139e6();
		}
	}
}

/*
	Name: function_74598aba
	Namespace: player
	Checksum: 0x131656B8
	Offset: 0x2258
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_74598aba(var_96a9fbf4)
{
	if(!isdefined(var_96a9fbf4))
	{
		return;
	}
	foreach(modifier in var_96a9fbf4)
	{
		if(!isdefined(modifier))
		{
			continue;
		}
		self function_b933de24(modifier.name, modifier.var_b861a047);
	}
}

/*
	Name: function_466d8a4b
	Namespace: player
	Checksum: 0xE719AD03
	Offset: 0x2308
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_466d8a4b(var_b66879ad, team)
{
	params = {#hash_b66879ad:var_b66879ad, #team:team};
	self notify(#"joined_team", params);
	level notify(#"joined_team");
	self callback::callback(#"joined_team", params);
}

/*
	Name: function_6f6c29e
	Namespace: player
	Checksum: 0x24480671
	Offset: 0x23A8
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_6f6c29e(var_b66879ad)
{
	params = {#hash_b66879ad:var_b66879ad, #team:#"spectator"};
	self notify(#"joined_spectator", params);
	level notify(#"joined_spectator");
	self callback::callback(#"hash_4b55701ea20843ba", params);
}

/*
	Name: function_2f80d95b
	Namespace: player
	Checksum: 0x485AA377
	Offset: 0x2450
	Size: 0xA8
	Parameters: 2
	Flags: Variadic
*/
function function_2f80d95b(player_func, vararg)
{
	players = level.players;
	foreach(player in players)
	{
		util::single_func_argarray(player, player_func, vararg);
	}
}

/*
	Name: function_4dcd9a89
	Namespace: player
	Checksum: 0xC445F89A
	Offset: 0x2500
	Size: 0x98
	Parameters: 3
	Flags: Variadic
*/
function function_4dcd9a89(players, player_func, vararg)
{
	foreach(player in players)
	{
		util::single_func_argarray(player, player_func, vararg);
	}
}

/*
	Name: function_7629df88
	Namespace: player
	Checksum: 0xDC200B8F
	Offset: 0x25A0
	Size: 0xC0
	Parameters: 3
	Flags: Variadic
*/
function function_7629df88(team, player_func, vararg)
{
	players = level.players;
	foreach(player in players)
	{
		if(player.team == team)
		{
			util::single_func_argarray(player, player_func, vararg);
		}
	}
}

/*
	Name: function_e7f18b20
	Namespace: player
	Checksum: 0x59510324
	Offset: 0x2668
	Size: 0xC8
	Parameters: 2
	Flags: Variadic
*/
function function_e7f18b20(player_func, vararg)
{
	players = level.players;
	foreach(player in players)
	{
		if(!isdefined(player.pers[#"team"]))
		{
			continue;
		}
		util::single_func_argarray(player, player_func, vararg);
	}
}

/*
	Name: function_38de2d5a
	Namespace: player
	Checksum: 0x92F4585E
	Offset: 0x2738
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function function_38de2d5a(notification)
{
	players = level.players;
	foreach(player in players)
	{
		player notify(notification);
	}
}

/*
	Name: function_5ae8566b
	Namespace: player
	Checksum: 0x6AF03592
	Offset: 0x27D0
	Size: 0xC6
	Parameters: 2
	Flags: Linked
*/
function function_5ae8566b(var_cd7b9255, var_e9c4ebeb)
{
	var_84d04e6 = {#hash_a1cac2f1:0, #hash_b8c7d886:0, #hash_c8777194:var_e9c4ebeb, #hash_bc840360:0, #rate:0, #enabled:var_cd7b9255};
	if(!isdefined(self.heal))
	{
		self.heal = var_84d04e6;
	}
	if(!isdefined(self.var_66cb03ad))
	{
		self.var_66cb03ad = self.maxhealth;
	}
}

/*
	Name: figure_out_attacker
	Namespace: player
	Checksum: 0xF060AC6F
	Offset: 0x28A0
	Size: 0x1D2
	Parameters: 1
	Flags: Linked
*/
function figure_out_attacker(eattacker)
{
	if(isdefined(eattacker) && !isplayer(eattacker))
	{
		team = self.team;
		if(isdefined(eattacker.script_owner))
		{
			if(util::function_fbce7263(eattacker.script_owner.team, team))
			{
				eattacker = eattacker.script_owner;
			}
		}
		if(isdefined(eattacker.owner))
		{
			eattacker = eattacker.owner;
		}
		if(isdefined(eattacker.var_97f1b32a) && eattacker.var_97f1b32a && isdefined(level.var_6ed50229))
		{
			/#
				assert(isvehicle(eattacker));
			#/
			if(isvehicle(eattacker) && isdefined(eattacker.var_735382e) && isdefined(eattacker.var_a816f2cd))
			{
				driver = eattacker getseatoccupant(0);
				if(!isdefined(driver))
				{
					currenttime = gettime();
					if(currenttime - eattacker.var_a816f2cd <= int(level.var_6ed50229 * 1000))
					{
						eattacker = eattacker.var_735382e;
					}
				}
			}
		}
	}
	return eattacker;
}

/*
	Name: function_4ca4d8c6
	Namespace: player
	Checksum: 0xED3293A0
	Offset: 0x2A80
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function function_4ca4d8c6(string, value)
{
	/#
		assert(isdefined(string), "");
	#/
	if(isdefined(self) && isdefined(self.pers))
	{
		self.pers[string] = value;
	}
}

/*
	Name: function_2abc116
	Namespace: player
	Checksum: 0xF9EE4994
	Offset: 0x2AE8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_2abc116(string, var_817b185)
{
	/#
		assert(isdefined(string), "");
	#/
	if(isdefined(self) && isdefined(self.pers) && isdefined(self.pers[string]))
	{
		return self.pers[string];
	}
	return var_817b185;
}

