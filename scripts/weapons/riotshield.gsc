// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weapons.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace riotshield;

/*
	Name: init_shared
	Namespace: riotshield
	Checksum: 0x755A1CA4
	Offset: 0x288
	Size: 0x15C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.weaponriotshield))
	{
		level.weaponriotshield = getweapon(#"riotshield");
	}
	level.deployedshieldmodel = #"wpn_t7_shield_riot_world";
	level.stowedshieldmodel = #"wpn_t7_shield_riot_world";
	level.carriedshieldmodel = #"wpn_t7_shield_riot_world";
	level.detectshieldmodel = #"wpn_t7_shield_riot_world";
	level.riotshielddestroyanim = "o_riot_stand_destroyed";
	level.riotshielddeployanim = "o_riot_stand_deploy";
	level.riotshieldshotanimfront = "o_riot_stand_shot";
	level.riotshieldshotanimback = "o_riot_stand_shot_back";
	level.riotshieldmeleeanimfront = "o_riot_stand_melee_front";
	level.riotshieldmeleeanimback = "o_riot_stand_melee_back";
	level.riotshield_placement_zoffset = 26;
	thread register();
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: register
	Namespace: riotshield
	Checksum: 0x604A7B92
	Offset: 0x3F0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function register()
{
	clientfield::register("scriptmover", "riotshield_state", 1, 2, "int");
}

/*
	Name: watchpregameclasschange
	Namespace: riotshield
	Checksum: 0xBD8D7061
	Offset: 0x430
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function watchpregameclasschange()
{
	self endon(#"death", #"disconnect", #"track_riot_shield");
	self waittill(#"changed_class");
	if(level.ingraceperiod && !self.hasdonecombat)
	{
		self clearstowedweapon();
		self refreshshieldattachment();
		self thread trackriotshield();
	}
}

/*
	Name: watchriotshieldpickup
	Namespace: riotshield
	Checksum: 0xD74A9EF3
	Offset: 0x4E8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function watchriotshieldpickup()
{
	self endon(#"death", #"disconnect", #"track_riot_shield");
	self notify(#"watch_riotshield_pickup");
	self endon(#"watch_riotshield_pickup");
	self waittill(#"pickup_riotshield");
	self endon(#"weapon_change");
	/#
		println("");
	#/
	wait(0.5);
	/#
		println("");
	#/
	currentweapon = self getcurrentweapon();
	self.hasriotshield = self hasriotshield();
	self.hasriotshieldequipped = currentweapon.isriotshield;
	self refreshshieldattachment();
}

/*
	Name: trackriotshield
	Namespace: riotshield
	Checksum: 0x34FE33AB
	Offset: 0x628
	Size: 0x280
	Parameters: 0
	Flags: Linked
*/
function trackriotshield()
{
	self endon(#"death", #"disconnect");
	self notify(#"track_riot_shield");
	self endon(#"track_riot_shield");
	self thread watchpregameclasschange();
	self waittill(#"weapon_change");
	self refreshshieldattachment();
	currentweapon = self getcurrentweapon();
	self.hasriotshield = self hasriotshield();
	self.hasriotshieldequipped = currentweapon.isriotshield;
	self.lastnonshieldweapon = level.weaponnone;
	while(true)
	{
		self thread watchriotshieldpickup();
		currentweapon = self getcurrentweapon();
		currentweapon = self getcurrentweapon();
		self.hasriotshield = self hasriotshield();
		self.hasriotshieldequipped = currentweapon.isriotshield;
		refresh_attach = 0;
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		if(waitresult.weapon.isriotshield)
		{
			refresh_attach = 1;
			if(isdefined(self.riotshieldentity))
			{
				self notify(#"destroy_riotshield");
			}
			if(self.hasriotshield)
			{
				if(isdefined(self.riotshieldtakeweapon))
				{
					self takeweapon(self.riotshieldtakeweapon);
					self.riotshieldtakeweapon = undefined;
				}
			}
			if(isvalidnonshieldweapon(currentweapon))
			{
				self.lastnonshieldweapon = currentweapon;
			}
		}
		if(self.hasriotshield || refresh_attach == 1)
		{
			self refreshshieldattachment();
		}
	}
}

/*
	Name: isvalidnonshieldweapon
	Namespace: riotshield
	Checksum: 0xA7FA2D55
	Offset: 0x8B0
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function isvalidnonshieldweapon(weapon)
{
	if(!weapons::may_drop(weapon))
	{
		return false;
	}
	return true;
}

/*
	Name: startriotshielddeploy
	Namespace: riotshield
	Checksum: 0x4FCCEEE8
	Offset: 0x8E8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function startriotshielddeploy()
{
	self notify(#"start_riotshield_deploy");
	self thread watchriotshielddeploy();
}

/*
	Name: resetreconmodelvisibility
	Namespace: riotshield
	Checksum: 0xC2819B02
	Offset: 0x920
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function resetreconmodelvisibility(owner)
{
	if(!isdefined(self))
	{
		return;
	}
	self setinvisibletoall();
	self setforcenocull();
	if(!isdefined(owner))
	{
		return;
	}
	for(i = 0; i < level.players.size; i++)
	{
		if(level.players[i] hasperk(#"specialty_showenemyequipment"))
		{
			if(level.players[i].team == #"spectator")
			{
				continue;
			}
			isenemy = 1;
			if(level.teambased)
			{
				if(!level.players[i] util::isenemyteam(owner.team))
				{
					isenemy = 0;
				}
			}
			else if(level.players[i] == owner)
			{
				isenemy = 0;
			}
			if(isenemy)
			{
				self setvisibletoplayer(level.players[i]);
			}
		}
	}
}

/*
	Name: resetreconmodelonevent
	Namespace: riotshield
	Checksum: 0xC97E2058
	Offset: 0xAA8
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function resetreconmodelonevent(eventname, owner)
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = level waittill(eventname);
		if(isdefined(waitresult.player))
		{
			owner = waitresult.player;
		}
		self resetreconmodelvisibility(owner);
	}
}

/*
	Name: attachreconmodel
	Namespace: riotshield
	Checksum: 0xA61D4783
	Offset: 0xB30
	Size: 0x11A
	Parameters: 2
	Flags: Linked
*/
function attachreconmodel(modelname, owner)
{
	if(!isdefined(self))
	{
		return;
	}
	reconmodel = spawn("script_model", self.origin);
	reconmodel.angles = self.angles;
	reconmodel setmodel(modelname);
	reconmodel.model_name = modelname;
	reconmodel linkto(self);
	reconmodel setcontents(0);
	reconmodel resetreconmodelvisibility(owner);
	reconmodel thread resetreconmodelonevent("joined_team", owner);
	reconmodel thread resetreconmodelonevent("player_spawned", owner);
	self.reconmodel = reconmodel;
}

/*
	Name: spawnriotshieldcover
	Namespace: riotshield
	Checksum: 0x998F98D3
	Offset: 0xC58
	Size: 0x150
	Parameters: 2
	Flags: Linked
*/
function spawnriotshieldcover(origin, angles)
{
	shield_ent = spawn("script_model", origin, 1);
	shield_ent.targetname = "riotshield_mp";
	shield_ent.angles = angles;
	shield_ent setmodel(level.deployedshieldmodel);
	shield_ent setowner(self);
	shield_ent.owner = self;
	shield_ent.team = self.team;
	shield_ent setteam(self.team);
	shield_ent attachreconmodel(level.detectshieldmodel, self);
	shield_ent useanimtree("generic");
	shield_ent setscriptmoverflag(0);
	shield_ent disconnectpaths();
	return shield_ent;
}

/*
	Name: watchriotshielddeploy
	Namespace: riotshield
	Checksum: 0x619831FE
	Offset: 0xDB0
	Size: 0x414
	Parameters: 0
	Flags: Linked
*/
function watchriotshielddeploy()
{
	self endon(#"death", #"disconnect", #"start_riotshield_deploy");
	waitresult = undefined;
	waitresult = self waittill(#"deploy_riotshield");
	deploy_attempt = waitresult.is_deploy_attempt;
	weapon = waitresult.weapon;
	self setplacementhint(1);
	placement_hint = 0;
	if(deploy_attempt)
	{
		placement = self canplaceriotshield("deploy_riotshield");
		if(placement[#"result"])
		{
			self.hasdonecombat = 1;
			zoffset = level.riotshield_placement_zoffset;
			shield_ent = self spawnriotshieldcover(placement[#"origin"] + (0, 0, zoffset), placement[#"angles"]);
			item_ent = deployriotshield(self, shield_ent);
			primaries = self getweaponslistprimaries();
			/#
				/#
					assert(isdefined(item_ent));
				#/
				/#
					assert(!isdefined(self.riotshieldretrievetrigger));
				#/
				/#
					assert(!isdefined(self.riotshieldentity));
				#/
				if(level.gametype != "")
				{
					/#
						assert(primaries.size > 0);
					#/
				}
			#/
			shield_ent clientfield::set("riotshield_state", 1);
			shield_ent.reconmodel clientfield::set("riotshield_state", 1);
			if(level.gametype != "shrp")
			{
				self weapons::function_d571ac59(self.lastnonshieldweapon);
			}
			if(!self hasweapon(level.weaponbasemeleeheld))
			{
				self giveweapon(level.weaponbasemeleeheld);
				self.riotshieldtakeweapon = level.weaponbasemeleeheld;
			}
			self.riotshieldretrievetrigger = item_ent;
			self.riotshieldentity = shield_ent;
			self thread watchdeployedriotshieldents();
			self thread deleteshieldontriggerdeath(self.riotshieldretrievetrigger);
			self thread deleteshieldonplayerdeathordisconnect(shield_ent);
			self.riotshieldentity thread watchdeployedriotshielddamage();
			level notify(#"riotshield_planted", {#player:self});
		}
		else
		{
			placement_hint = 1;
			clip_max_ammo = weapon.clipsize;
			self setweaponammoclip(weapon, clip_max_ammo);
		}
	}
	else
	{
		placement_hint = 1;
	}
	if(placement_hint)
	{
		self setriotshieldfailhint();
	}
}

/*
	Name: riotshielddistancetest
	Namespace: riotshield
	Checksum: 0x738A0F24
	Offset: 0x11D0
	Size: 0x116
	Parameters: 1
	Flags: None
*/
function riotshielddistancetest(origin)
{
	/#
		/#
			assert(isdefined(origin));
		#/
	#/
	min_dist_squared = getdvarfloat(#"riotshield_deploy_limit_radius", 0);
	min_dist_squared = min_dist_squared * min_dist_squared;
	for(i = 0; i < level.players.size; i++)
	{
		if(isdefined(level.players[i].riotshieldentity))
		{
			dist_squared = distancesquared(level.players[i].riotshieldentity.origin, origin);
			if(min_dist_squared > dist_squared)
			{
				/#
					println("");
				#/
				return false;
			}
		}
	}
	return true;
}

/*
	Name: watchdeployedriotshieldents
	Namespace: riotshield
	Checksum: 0xBF11C10D
	Offset: 0x12F0
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function watchdeployedriotshieldents()
{
	/#
		/#
			assert(isdefined(self.riotshieldretrievetrigger));
		#/
		/#
			assert(isdefined(self.riotshieldentity));
		#/
	#/
	self waittill(#"destroy_riotshield");
	if(isdefined(self.riotshieldretrievetrigger))
	{
		self.riotshieldretrievetrigger delete();
	}
	if(isdefined(self.riotshieldentity))
	{
		if(isdefined(self.riotshieldentity.reconmodel))
		{
			self.riotshieldentity.reconmodel delete();
		}
		self.riotshieldentity connectpaths();
		self.riotshieldentity delete();
	}
}

/*
	Name: watchdeployedriotshielddamage
	Namespace: riotshield
	Checksum: 0x218E4884
	Offset: 0x13F8
	Size: 0x38C
	Parameters: 0
	Flags: Linked
*/
function watchdeployedriotshielddamage()
{
	self endon(#"death");
	damagemax = getdvarint(#"riotshield_deployed_health", 0);
	self.damagetaken = 0;
	while(true)
	{
		self.maxhealth = 100000;
		self.health = self.maxhealth;
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		damage = waitresult.amount;
		weapon = waitresult.weapon;
		type = waitresult.mod;
		if(!isdefined(attacker))
		{
			continue;
		}
		/#
			/#
				assert(isdefined(self.owner) && isdefined(self.owner.team));
			#/
		#/
		if(isplayer(attacker))
		{
			if(level.teambased && !util::function_fbce7263(attacker.team, self.owner.team) && attacker != self.owner)
			{
				continue;
			}
		}
		if(type == "MOD_MELEE" || type == "MOD_MELEE_ASSASSINATE")
		{
			damage = damage * getdvarfloat(#"riotshield_melee_damage_scale", 0);
		}
		else
		{
			if(type == "MOD_PISTOL_BULLET" || type == "MOD_RIFLE_BULLET")
			{
				damage = damage * getdvarfloat(#"riotshield_bullet_damage_scale", 0);
			}
			else
			{
				if(type == "MOD_GRENADE" || type == "MOD_GRENADE_SPLASH" || type == "MOD_EXPLOSIVE" || type == "MOD_EXPLOSIVE_SPLASH" || type == "MOD_PROJECTILE" || type == "MOD_PROJECTILE_SPLASH")
				{
					damage = damage * getdvarfloat(#"riotshield_explosive_damage_scale", 0);
				}
				else
				{
					if(type == "MOD_IMPACT")
					{
						damage = damage * getdvarfloat(#"riotshield_projectile_damage_scale", 0);
					}
					else if(type == "MOD_CRUSH")
					{
						damage = damagemax;
					}
				}
			}
		}
		self.damagetaken = self.damagetaken + damage;
		if(self.damagetaken >= damagemax)
		{
			self thread damagethendestroyriotshield(attacker, weapon);
			break;
		}
	}
}

/*
	Name: damagethendestroyriotshield
	Namespace: riotshield
	Checksum: 0xE492E124
	Offset: 0x1790
	Size: 0x184
	Parameters: 2
	Flags: Linked
*/
function damagethendestroyriotshield(attacker, weapon)
{
	self notify(#"damagethendestroyriotshield");
	self endon(#"death");
	if(isdefined(self.owner.riotshieldretrievetrigger))
	{
		self.owner.riotshieldretrievetrigger delete();
	}
	if(isdefined(self.reconmodel))
	{
		self.reconmodel delete();
	}
	self connectpaths();
	self.owner.riotshieldentity = undefined;
	self notsolid();
	self clientfield::set("riotshield_state", 2);
	if(isdefined(attacker) && attacker != self.owner && isplayer(attacker))
	{
		scoreevents::processscoreevent(#"destroyed_shield", attacker, self.owner, weapon);
	}
	wait(getdvarfloat(#"riotshield_destroyed_cleanup_time", 0));
	self delete();
}

/*
	Name: deleteshieldontriggerdeath
	Namespace: riotshield
	Checksum: 0x28F189A0
	Offset: 0x1920
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function deleteshieldontriggerdeath(shield_trigger)
{
	shield_trigger waittill(#"trigger", #"death");
	self notify(#"destroy_riotshield");
}

/*
	Name: deleteshieldonplayerdeathordisconnect
	Namespace: riotshield
	Checksum: 0x4E183919
	Offset: 0x1970
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function deleteshieldonplayerdeathordisconnect(shield_ent)
{
	shield_ent endon(#"death", #"damagethendestroyriotshield");
	self waittill(#"death", #"disconnect", #"remove_planted_weapons");
	shield_ent thread damagethendestroyriotshield();
}

/*
	Name: watchriotshieldstuckentitydeath
	Namespace: riotshield
	Checksum: 0xA3CDE87
	Offset: 0x19F8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function watchriotshieldstuckentitydeath(grenade, owner)
{
	grenade endon(#"death");
	self waittill(#"damagethendestroyriotshield", #"death", #"disconnect", #"weapon_change", #"deploy_riotshield");
	grenade detonate(owner);
}

/*
	Name: on_player_spawned
	Namespace: riotshield
	Checksum: 0x4CCB4C6E
	Offset: 0x1AA0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self thread watch_riot_shield_use();
}

/*
	Name: watch_riot_shield_use
	Namespace: riotshield
	Checksum: 0xE2D81E6D
	Offset: 0x1AC8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function watch_riot_shield_use()
{
	self endon(#"death", #"disconnect");
	self thread trackriotshield();
	for(;;)
	{
		self waittill(#"raise_riotshield");
		self thread startriotshielddeploy();
	}
}

/*
	Name: function_4f975761
	Namespace: riotshield
	Checksum: 0xADE09964
	Offset: 0x1B38
	Size: 0xD2
	Parameters: 1
	Flags: Event
*/
event function_4f975761(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(grenade util::ishacked())
	{
		return;
	}
	switch(weapon.name)
	{
		case "explosive_bolt":
		case "proximity_grenade":
		case "sticky_grenade":
		{
			grenade thread check_stuck_to_shield();
			break;
		}
	}
}

/*
	Name: check_stuck_to_shield
	Namespace: riotshield
	Checksum: 0x33C47A96
	Offset: 0x1C18
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function check_stuck_to_shield()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"stuck_to_shield");
	waitresult.entity watchriotshieldstuckentitydeath(self, waitresult.owner);
}

