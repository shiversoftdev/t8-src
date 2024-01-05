// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\weapons\tacticalinsertion.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace trophy_system;

/*
	Name: init_shared
	Namespace: trophy_system
	Checksum: 0x7D760E55
	Offset: 0x1A8
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.trophylongflashfx = #"weapon/fx_trophy_flash";
	level.trophydetonationfx = #"weapon/fx_trophy_detonation";
	level.fx_trophy_radius_indicator = #"weapon/fx_trophy_radius_indicator";
	trophydeployanim = "p8_fxanim_mp_eqp_trophy_system_world_anim";
	trophyspinanim = "p8_fxanim_mp_eqp_trophy_system_world_open_anim";
	level.var_4f3822f4 = &trophysystemdetonate;
	level thread register();
	callback::on_player_killed_with_params(&on_player_killed);
	weaponobjects::function_e6400478(#"trophy_system", &createtrophysystemwatcher, 1);
	callback::on_finalize_initialization(&function_1c601b99);
}

/*
	Name: function_1c601b99
	Namespace: trophy_system
	Checksum: 0x2293F296
	Offset: 0x2D0
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon(#"trophy_system"), &function_bff5c062);
	}
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](getweapon(#"trophy_system"), &weaponobjects::function_127fb8f3);
	}
}

/*
	Name: function_bff5c062
	Namespace: trophy_system
	Checksum: 0x63927001
	Offset: 0x378
	Size: 0x1A8
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(trophysystem, attackingplayer)
{
	trophysystem notify(#"hacked");
	trophysystem.owner weaponobjects::hackerremoveweapon(trophysystem);
	trophysystem.team = attackingplayer.team;
	trophysystem setteam(attackingplayer.team);
	trophysystem.owner = attackingplayer;
	trophysystem setowner(attackingplayer);
	trophysystem thread trophyactive(attackingplayer);
	trophysystem weaponobjects::function_386fa470(attackingplayer);
	if(isdefined(trophysystem) && isdefined(level.var_f1edf93f))
	{
		_station_up_to_detention_center_triggers = [[level.var_f1edf93f]]();
		if((isdefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0))
		{
			trophysystem notify(#"cancel_timeout");
			trophysystem thread weaponobjects::weapon_object_timeout(trophysystem.var_2d045452, _station_up_to_detention_center_triggers);
		}
	}
	trophysystem thread weaponobjects::function_6d8aa6a0(attackingplayer, trophysystem.var_2d045452);
	if(isdefined(trophysystem) && isdefined(level.var_fc1bbaef))
	{
		[[level.var_fc1bbaef]](trophysystem);
	}
}

/*
	Name: function_720ddf7f
	Namespace: trophy_system
	Checksum: 0xB9704709
	Offset: 0x528
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_720ddf7f(func)
{
	level.var_ccfcde75 = func;
}

/*
	Name: register
	Namespace: trophy_system
	Checksum: 0xD87F53ED
	Offset: 0x550
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function register()
{
	clientfield::register("missile", "trophy_system_state", 1, 2, "int");
	clientfield::register("scriptmover", "trophy_system_state", 1, 2, "int");
}

/*
	Name: on_player_killed
	Namespace: trophy_system
	Checksum: 0xA1C63D6F
	Offset: 0x5C0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function on_player_killed(s_params)
{
	attacker = s_params.eattacker;
	weapon = s_params.weapon;
	if(!isdefined(attacker) || !isdefined(weapon))
	{
		return;
	}
	if(weapon.name == #"trophy_system")
	{
		scoreevents::processscoreevent(#"trophy_system_kill", attacker, self, weapon);
	}
}

/*
	Name: createtrophysystemwatcher
	Namespace: trophy_system
	Checksum: 0x2F96521E
	Offset: 0x668
	Size: 0x166
	Parameters: 1
	Flags: Linked
*/
function createtrophysystemwatcher(watcher)
{
	watcher.ondetonatecallback = &trophysystemdetonate;
	watcher.activatesound = #"wpn_claymore_alert";
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.activationdelay = 0.1;
	watcher.deleteonplayerspawn = 0;
	watcher.enemydestroy = 1;
	watcher.onspawn = &ontrophysystemspawn;
	watcher.ondamage = &watchtrophysystemdamage;
	watcher.ondestroyed = &ontrophysystemsmashed;
	watcher.var_994b472b = &function_5a4f1e1e;
	watcher.onstun = &weaponobjects::weaponstun;
	watcher.stuntime = 1;
	watcher.ontimeout = &ontrophysystemsmashed;
}

/*
	Name: trophysystemstopped
	Namespace: trophy_system
	Checksum: 0x45F02F7A
	Offset: 0x7D8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function trophysystemstopped()
{
	self endon(#"death", #"trophysystemstopped");
	self util::waittillnotmoving();
	self.trophysystemstationary = 1;
	self notify(#"trophysystemstopped");
}

/*
	Name: ontrophysystemspawn
	Namespace: trophy_system
	Checksum: 0x74ABF906
	Offset: 0x840
	Size: 0x324
	Parameters: 2
	Flags: Linked
*/
function ontrophysystemspawn(watcher, player)
{
	player endon(#"disconnect");
	level endon(#"game_ended");
	self endon(#"death");
	self useanimtree("generic");
	self weaponobjects::onspawnuseweaponobject(watcher, player);
	self.trophysystemstationary = 0;
	self.weapon = getweapon(#"trophy_system");
	self.var_2d045452 = watcher;
	self setweapon(self.weapon);
	self.ammo = player ammo_get(self.weapon);
	self thread trophysystemstopped();
	movestate = self util::waittillrollingornotmoving();
	if(movestate == "rolling")
	{
		self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 1);
		self clientfield::set("trophy_system_state", 1);
	}
	if(!self.trophysystemstationary)
	{
		trophysystemstopped();
	}
	self.trophysystemstationary = 1;
	if(isalive(player))
	{
		player stats::function_e24eec31(self.weapon, #"used", 1);
	}
	self thread trophyactive(player);
	self thread trophywatchhack();
	self util::make_sentient();
	self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_anim", 0);
	self setanim(#"p8_fxanim_mp_eqp_trophy_system_world_open_anim", 1);
	self clientfield::set("trophy_system_state", 2);
	self playsound(#"wpn_trophy_deploy_start");
	self playloopsound(#"wpn_trophy_spin", 0.25);
	self setreconmodeldeployed();
}

/*
	Name: setreconmodeldeployed
	Namespace: trophy_system
	Checksum: 0x591A8839
	Offset: 0xB70
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function setreconmodeldeployed()
{
	if(isdefined(self.reconmodelentity))
	{
		self.reconmodelentity clientfield::set("trophy_system_state", 2);
	}
}

/*
	Name: trophywatchhack
	Namespace: trophy_system
	Checksum: 0x4176EAF7
	Offset: 0xBB0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function trophywatchhack()
{
	self endon(#"death");
	self waittill(#"hacked");
	self clientfield::set("trophy_system_state", 0);
}

/*
	Name: function_5a4f1e1e
	Namespace: trophy_system
	Checksum: 0x5D53B53D
	Offset: 0xC08
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5a4f1e1e(player)
{
	self thread trophysystemdetonate();
}

/*
	Name: ontrophysystemsmashed
	Namespace: trophy_system
	Checksum: 0xE8AB216
	Offset: 0xC38
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function ontrophysystemsmashed(attacker, callback_data)
{
	playfx(level._equipment_explode_fx_lg, self.origin);
	self playsound(#"dst_trophy_smash");
	var_3c4d4b60 = isdefined(self.owner);
	if(var_3c4d4b60 && isdefined(level.playequipmentdestroyedonplayer))
	{
		self.owner [[level.playequipmentdestroyedonplayer]]();
	}
	if(isdefined(attacker) && (!var_3c4d4b60 || self.owner util::isenemyplayer(attacker)))
	{
		attacker challenges::destroyedequipment();
		scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, undefined);
	}
	if(isdefined(level.var_d2600afc))
	{
		self [[level.var_d2600afc]](attacker, self.owner, self.weapon);
	}
	self delete();
}

/*
	Name: trophyactive
	Namespace: trophy_system
	Checksum: 0x741A7128
	Offset: 0xDA0
	Size: 0x46A
	Parameters: 1
	Flags: Linked
*/
function trophyactive(owner)
{
	owner endon(#"disconnect");
	self endon(#"death", #"hacked");
	while(true)
	{
		if(!isdefined(self))
		{
			return;
		}
		if(level.missileentities.size < 1 || isdefined(self.disabled))
		{
			waitframe(1);
			continue;
		}
		waitframe(1);
		missileents = owner getentitiesinrange(level.missileentities, 512, self.origin);
		for(index = 0; index < missileents.size; index++)
		{
			if(!isdefined(self))
			{
				return;
			}
			grenade = missileents[index];
			if(!isdefined(grenade))
			{
				continue;
			}
			if(grenade == self)
			{
				continue;
			}
			if(!grenade.weapon.destroyablebytrophysystem)
			{
				continue;
			}
			if(grenade.destroyablebytrophysystem === 0)
			{
				continue;
			}
			switch(grenade.model)
			{
				case "t6_wpn_grenade_supply_projectile":
				{
					continue;
				}
			}
			if(grenade.weapon == self.weapon)
			{
				if(isdefined(self.trophysystemstationary) && !self.trophysystemstationary && (isdefined(grenade.trophysystemstationary) && grenade.trophysystemstationary))
				{
					continue;
				}
			}
			if(!isdefined(grenade.owner) && ismissile(grenade))
			{
				grenade.owner = getmissileowner(grenade);
			}
			if(isdefined(grenade.owner))
			{
				if(level.teambased)
				{
					if(!grenade.owner util::isenemyteam(owner.team))
					{
						continue;
					}
				}
				else if(grenade.owner == owner)
				{
					continue;
				}
				if(bullettracepassed(grenade.origin, self.origin + vectorscale((0, 0, 1), 29), 0, self, grenade, 0, 1))
				{
					grenade notify(#"death");
					if(isdefined(level.var_ccfcde75))
					{
						owner [[level.var_ccfcde75]](self, grenade);
					}
					var_84c1f04c = grenade.origin - self.origin;
					if(var_84c1f04c == (0, 0, 0))
					{
						var_84c1f04c = (1, 0, 0);
					}
					fxup = anglestoup(self.angles);
					if(fxup == (0, 0, 0))
					{
						fxup = (0, 0, 1);
					}
					playfx(level.trophylongflashfx, self.origin + vectorscale((0, 0, 1), 15), var_84c1f04c, fxup);
					owner thread projectileexplode(grenade, self);
					index--;
					self playsound(#"wpn_trophy_alert");
					if(getdvarint(#"player_sustainammo", 0) == 0)
					{
						if(!isdefined(self.ammo))
						{
							self.ammo = 0;
						}
						self.ammo--;
						if(self.ammo <= 0)
						{
							self thread trophysystemdetonate();
						}
					}
				}
			}
		}
	}
}

/*
	Name: projectileexplode
	Namespace: trophy_system
	Checksum: 0xB5462279
	Offset: 0x1218
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function projectileexplode(projectile, trophy)
{
	self endon(#"death");
	projposition = projectile.origin;
	playfx(level.trophydetonationfx, projposition);
	projectile notify(#"trophy_destroyed");
	trophy radiusdamage(projposition, 128, 105, 10, self);
	scoreevents::processscoreevent(#"trophy_defense", self, projectile.owner, trophy.weapon);
	self function_3170d645(projectile, trophy);
	self challenges::trophy_defense(projposition, 512);
	if(isdefined(level.var_d3a438fb))
	{
		if([[level.var_d3a438fb]](trophy))
		{
			self stats::function_dad108fa(#"hash_707d06184cf09b50", 1);
		}
	}
	if(self util::is_item_purchased(#"trophy_system"))
	{
		self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
	}
	self function_be7a08a8(trophy.weapon, 1);
	projectile delete();
}

/*
	Name: _the_root_zurich_spawners
	Namespace: trophy_system
	Checksum: 0x9F3AF1DE
	Offset: 0x1400
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function _the_root_zurich_spawners(gameobject, trophy)
{
	return distancesquared(gameobject.origin, trophy.origin) <= math::pow(512, 2);
}

/*
	Name: function_3170d645
	Namespace: trophy_system
	Checksum: 0xF0A3A221
	Offset: 0x1460
	Size: 0x6AC
	Parameters: 2
	Flags: Linked
*/
function function_3170d645(projectile, trophy)
{
	player = self;
	entities = getentitiesinradius(trophy.origin, 512);
	var_48b7bfeb = 0;
	for(i = 0; i < entities.size; i++)
	{
		if(!isdefined(self))
		{
			return;
		}
		ent = entities[i];
		if(isdefined(ent.owner) && !ent util::isenemyteam(player.team) && (ent.classname === "noclass" || ent.classname === "script_model" || ent.classname === "script_vehicle" || ent.archetype === #"mp_dog" || ent.archetype === #"human" || isdefined(ent.aitype)) && (ent.item !== level.weaponnone || ent.weapon !== level.weaponnone || ent.meleeweapon !== level.weaponnone || ent.turretweapon !== level.weaponnone) && (isdefined(ent.takedamage) && ent.takedamage))
		{
			if((isdefined(ent.health) ? ent.health : 0) > 0)
			{
				var_48b7bfeb = 1;
				break;
			}
		}
	}
	if(var_48b7bfeb)
	{
		scoreevents::processscoreevent(#"hash_1ed8a05490cfe606", player, projectile.owner, trophy.weapon);
	}
	if(isdefined(level.flags))
	{
		var_2e36557f = 0;
		foreach(flag in level.flags)
		{
			useobj = flag.useobj;
			if(!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy))
			{
				continue;
			}
			var_2e36557f = var_2e36557f | (useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy"));
			if(var_2e36557f)
			{
				break;
			}
		}
		if(var_2e36557f)
		{
			scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
		}
	}
	if(isdefined(level.zones))
	{
		var_2e36557f = 0;
		foreach(zone in level.zones)
		{
			useobj = zone.gameobject;
			if(!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy))
			{
				continue;
			}
			var_2e36557f = var_2e36557f | (useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy"));
			if(var_2e36557f)
			{
				break;
			}
		}
		if(var_2e36557f)
		{
			scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
		}
	}
	if(isdefined(level.bombzones))
	{
		var_2e36557f = 0;
		foreach(useobj in level.bombzones)
		{
			if(!isdefined(useobj) || !_the_root_zurich_spawners(useobj, trophy))
			{
				continue;
			}
			var_2e36557f = var_2e36557f | (useobj.userate && (!player util::isenemyteam(useobj.claimteam) || useobj.interactteam === #"enemy"));
			if(var_2e36557f)
			{
				break;
			}
		}
		if(var_2e36557f)
		{
			scoreevents::processscoreevent(#"hash_2f3000a4b38e9235", player, projectile.owner, trophy.weapon);
		}
	}
}

/*
	Name: trophydestroytacinsert
	Namespace: trophy_system
	Checksum: 0x1ECD282
	Offset: 0x1B18
	Size: 0x144
	Parameters: 2
	Flags: None
*/
function trophydestroytacinsert(tacinsert, trophy)
{
	self endon(#"death");
	tacpos = tacinsert.origin;
	playfx(level.trophydetonationfx, tacinsert.origin);
	tacinsert thread tacticalinsertion::tacticalinsertiondestroyedbytrophysystem(self, trophy);
	trophy radiusdamage(tacpos, 128, 105, 10, self);
	scoreevents::processscoreevent(#"trophy_defense", self, undefined, trophy.weapon);
	if(self util::is_item_purchased(#"trophy_system"))
	{
		self stats::function_dad108fa(#"destroy_explosive_with_trophy", 1);
	}
	self function_be7a08a8(trophy.weapon, 1);
}

/*
	Name: trophysystemdetonate
	Namespace: trophy_system
	Checksum: 0x29DB310E
	Offset: 0x1C68
	Size: 0x144
	Parameters: 3
	Flags: Linked
*/
function trophysystemdetonate(attacker, weapon, target)
{
	if(!isdefined(weapon) || !weapon.isemp)
	{
		playfx(level._equipment_explode_fx_lg, self.origin);
	}
	if(isdefined(attacker) && self.owner util::isenemyplayer(attacker))
	{
		attacker challenges::destroyedequipment(weapon);
		scoreevents::processscoreevent(#"destroyed_trophy_system", attacker, self.owner, weapon);
		if(isdefined(level.var_d2600afc))
		{
			self [[level.var_d2600afc]](attacker, self.owner, self.weapon, weapon);
		}
	}
	playsoundatposition(#"exp_trophy_system", self.origin);
	self delete();
}

/*
	Name: watchtrophysystemdamage
	Namespace: trophy_system
	Checksum: 0x18D6CF20
	Offset: 0x1DB8
	Size: 0x33A
	Parameters: 1
	Flags: Linked
*/
function watchtrophysystemdamage(watcher)
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
		attacker = self [[level.figure_out_attacker]](waitresult.attacker);
		damage = weapons::function_74bbb3fa(damage, weapon, self.weapon);
		if(!isplayer(attacker))
		{
			continue;
		}
		if(level.teambased)
		{
			if(!sessionmodeiswarzonegame() && !level.hardcoremode && isdefined(self.owner) && !attacker util::isenemyteam(self.owner.team) && self.owner != attacker)
			{
				continue;
			}
		}
		if(watcher.stuntime > 0 && weapon.dostun)
		{
			self thread weaponobjects::stunstart(watcher, watcher.stuntime);
		}
		if(damage::friendlyfirecheck(self.owner, attacker))
		{
			if(damagefeedback::dodamagefeedback(weapon, attacker))
			{
				attacker damagefeedback::update();
			}
		}
		if(type == "MOD_MELEE" || weapon.isemp || weapon.destroysequipment)
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

/*
	Name: ammo_scavenger
	Namespace: trophy_system
	Checksum: 0x88568A97
	Offset: 0x2100
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function ammo_scavenger(weapon)
{
	self ammo_reset();
}

/*
	Name: ammo_reset
	Namespace: trophy_system
	Checksum: 0xD1CA8726
	Offset: 0x2130
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function ammo_reset()
{
	self._trophy_system_ammo1 = undefined;
	self._trophy_system_ammo2 = undefined;
}

/*
	Name: ammo_get
	Namespace: trophy_system
	Checksum: 0xA250A1F2
	Offset: 0x2150
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function ammo_get(weapon)
{
	totalammo = weapon.ammocountequipment;
	if(isdefined(self._trophy_system_ammo1) && !self util::ishacked())
	{
		totalammo = self._trophy_system_ammo1;
		self._trophy_system_ammo1 = undefined;
		if(isdefined(self._trophy_system_ammo2))
		{
			self._trophy_system_ammo1 = self._trophy_system_ammo2;
			self._trophy_system_ammo2 = undefined;
		}
	}
	return totalammo;
}

/*
	Name: ammo_weapon_pickup
	Namespace: trophy_system
	Checksum: 0x3C6E07DE
	Offset: 0x21E0
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function ammo_weapon_pickup(ammo)
{
	if(isdefined(ammo))
	{
		if(isdefined(self._trophy_system_ammo1))
		{
			self._trophy_system_ammo2 = self._trophy_system_ammo1;
			self._trophy_system_ammo1 = ammo;
		}
		else
		{
			self._trophy_system_ammo1 = ammo;
		}
	}
}

/*
	Name: ammo_weapon_hacked
	Namespace: trophy_system
	Checksum: 0xB4EE70E5
	Offset: 0x2238
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function ammo_weapon_hacked(ammo)
{
	self ammo_weapon_pickup(ammo);
}

