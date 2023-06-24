// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\killstreaks\mp\killstreaks.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\mp_common\player\player_utils.gsc;
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\weapons\weapon_utils.gsc;
#using scripts\abilities\ability_util.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\killstreaks\killstreaks_util.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\core_common\globallogic\globallogic_player.gsc;
#using scripts\mp_common\player\player_loadout.gsc;
#using scripts\weapons\weapons.gsc;
#using scripts\abilities\ability_power.gsc;
#using scripts\core_common\burnplayer.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\armor.gsc;
#using scripts\mp_common\bb.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\vehicle.gsc;

#namespace player;

/*
	Name: callback_playerdamage
	Namespace: player
	Checksum: 0xDABD95BC
	Offset: 0x4D0
	Size: 0xFA4
	Parameters: 13
	Flags: Linked
*/
function callback_playerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal)
{
	profilelog_begintiming(6, "ship");
	if(function_b5dadafc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal))
	{
		return;
	}
	if(self getinvulnerability())
	{
		return;
	}
	do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
	self.idflags = idflags;
	self.idflagstime = gettime();
	if(!isplayer(eattacker) && isdefined(eattacker) && eattacker.owner === self)
	{
		treat_self_damage_as_friendly_fire = eattacker.treat_owner_damage_as_friendly_fire;
	}
	ignore_round_start_friendly_fire = isdefined(einflictor) && smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT";
	eattacker = figure_out_attacker(eattacker);
	if(isplayer(eattacker) && (isdefined(eattacker.laststand) && eattacker.laststand) && einflictor === eattacker)
	{
		return;
	}
	smeansofdeath = modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc);
	if(!self should_do_player_damage(eattacker, einflictor, weapon, smeansofdeath, idflags))
	{
		return;
	}
	function_4ac2aefc(einflictor, eattacker, smeansofdeath);
	weapon = function_f4f77cfb(weapon, einflictor);
	pixbeginevent(#"hash_5a86c546901702e2");
	if(!isdefined(vdir))
	{
		idflags = idflags | 4;
	}
	attackerishittingteammate = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
	attackerishittingself = isplayer(eattacker) && self == eattacker;
	friendlyfire = attackerishittingself && treat_self_damage_as_friendly_fire === 1 || (level.teambased && !attackerishittingself && attackerishittingteammate);
	pixendevent();
	idamage = modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
	if(friendlyfire)
	{
		idamage = modify_player_damage_friendlyfire(idamage, eattacker);
	}
	if(shitloc == "riotshield")
	{
		riotshield_hit(einflictor, eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate, vdir);
		if(isdefined(eattacker) && !attackerishittingself && (isalive(eattacker) || eattacker util::isusingremote()))
		{
			if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath))
			{
				if(idamage > 0 && self.health > 0)
				{
					perkfeedback = function_e512b988(self, weapon, smeansofdeath, einflictor, idflags & 2048);
				}
				eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc, 0, idflags);
			}
		}
	}
	idamage = self does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath, vpoint, idamage, einflictor, eattacker);
	if(!isdefined(idamage) || idamage == 0)
	{
		return;
	}
	if(isdefined(eattacker) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath))
	{
		var_8f516911 = function_b576d3d(weapon, shitloc);
		idamage = idamage * var_8f516911;
	}
	var_f16d7bc8 = (isdefined(self.armor) ? self.armor : 0);
	armor_damage = apply_damage_to_armor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire);
	idamage = armor_damage.idamage;
	idflags = armor_damage.idflags;
	idamage = function_74a5d514(eattacker, idamage, smeansofdeath, weapon, shitloc);
	idamage = make_sure_damage_is_not_zero(idamage, idflags & 2048);
	params = {#vsurfacenormal:vsurfacenormal, #boneindex:boneindex, #vdamageorigin:vdamageorigin, #vpoint:vpoint, #idflags:idflags, #shitloc:shitloc, #vdir:vdir, #weapon:weapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #eattacker:eattacker, #einflictor:einflictor};
	self callback::callback(#"on_player_damage", params);
	if(self laststand::player_is_in_laststand())
	{
		self notify(#"laststand_damage", params);
		self.health++;
		self.laststanddamage = idamage;
		idamage = 1;
	}
	if(shitloc == "riotshield")
	{
		shitloc = "none";
	}
	if(!function_104e1126(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex))
	{
		return;
	}
	prevhealthratio = self.health / self.maxhealth;
	fatal = 0;
	if(friendlyfire)
	{
		pixmarker("BEGIN: PlayerDamage player");
		if(function_1727a023(ignore_round_start_friendly_fire, eattacker))
		{
			self.lastdamagewasfromenemy = 0;
			fatal = self function_961fe569(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
		}
		var_86f19cfe = 0;
		if(level.friendlyfire == 4 && (isdefined(eattacker.var_e03ca8a5) && eattacker.var_e03ca8a5))
		{
			var_86f19cfe = 1;
			eattacker.var_e03ca8a5 = undefined;
		}
		if(!var_86f19cfe && function_44b6bb92(eattacker, ignore_round_start_friendly_fire))
		{
			eattacker.lastdamagewasfromenemy = 0;
			eattacker.friendlydamage = 1;
			fatal = eattacker function_961fe569(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
			eattacker.friendlydamage = undefined;
		}
		pixmarker("END: PlayerDamage player");
	}
	else
	{
		self.lastattackweapon = weapon;
		var_5370b15e = (idamage > self.health ? self.health : idamage);
		globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
		globallogic_player::function_efd02c1d(einflictor);
		if(isdefined(eattacker))
		{
			level.lastlegitimateattacker = eattacker;
		}
		if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" && isdefined(einflictor) && isdefined(einflictor.iscooked))
		{
			self.wascooked = gettime();
		}
		else
		{
			self.wascooked = undefined;
		}
		self.lastdamagewasfromenemy = isdefined(eattacker) && eattacker != self;
		if(self.lastdamagewasfromenemy && isdefined(self.clientid))
		{
			if(isplayer(eattacker))
			{
				if(!isdefined(eattacker.damagedplayers))
				{
					eattacker.damagedplayers = [];
				}
				if(!isdefined(eattacker.damagedplayers[self.clientid]))
				{
					eattacker.damagedplayers[self.clientid] = spawnstruct();
				}
				eattacker.damagedplayers[self.clientid].time = gettime();
				eattacker.damagedplayers[self.clientid].entity = self;
			}
		}
		if(isplayer(eattacker) && isdefined(weapon.gadget_type) && weapon.gadget_type == 11)
		{
			if(isdefined(eattacker.heavyweaponhits))
			{
				eattacker.heavyweaponhits++;
			}
		}
		fatal = self function_961fe569(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
	}
	self.var_e2e8198f = gettime();
	if(isdefined(eattacker) && !attackerishittingself && (isalive(eattacker) || eattacker util::isusingremote()))
	{
		if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath))
		{
			if(idamage > 0 && self.health > 0)
			{
				perkfeedback = function_e512b988(self, weapon, smeansofdeath, einflictor, idflags & 2048);
			}
			eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc, fatal, idflags);
		}
	}
	if(isalive(self))
	{
		if(!isdefined(eattacker) || !friendlyfire || (isdefined(level.hardcoremode) && level.hardcoremode))
		{
			if(!isdefined(var_f16d7bc8) || var_f16d7bc8 == 0 || (weapons::isheadshot(shitloc, smeansofdeath) && !self armor::has_helmet()))
			{
				self battlechatter::pain_vox(smeansofdeath, weapon);
			}
		}
	}
	self.hasdonecombat = 1;
	if(weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH" && !isdefined(weapon.var_13600e25))
	{
		if(!self hasperk(#"specialty_immuneemp"))
		{
			self notify(#"emp_grenaded", {#position:vpoint, #attacker:eattacker});
		}
	}
	if(isdefined(eattacker) && eattacker != self && !friendlyfire)
	{
		level.usestartspawns = 0;
	}
	player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
	profilelog_endtiming(6, "gs=" + game.state);
}

/*
	Name: function_f5cfe2b4
	Namespace: player
	Checksum: 0x881DE93E
	Offset: 0x1480
	Size: 0x1E6
	Parameters: 4
	Flags: None
*/
function function_f5cfe2b4(einflictor, eattacker, idamage, idflags)
{
	if(!sessionmodeiswarzonegame())
	{
		return;
	}
	var_4e3e876f = (isdefined(getgametypesetting(#"hash_67b94d37f2e44ee2")) ? getgametypesetting(#"hash_67b94d37f2e44ee2") : 0);
	if(var_4e3e876f <= 0)
	{
		return;
	}
	if(isdefined(eattacker) && isplayer(eattacker) && isalive(eattacker))
	{
		if(isplayer(self) && self util::isenemyteam(eattacker.team))
		{
			return;
		}
		if(eattacker.health !== eattacker.maxhealth)
		{
			eattacker playsoundtoplayer(#"chr_vampire", eattacker);
		}
		var_2be81a5b = (idamage * var_4e3e876f) / 100;
		newhealth = eattacker.health + var_2be81a5b;
		eattacker.health = int(math::clamp(newhealth, 0, max(eattacker.health, eattacker.maxhealth)));
	}
}

/*
	Name: function_74a5d514
	Namespace: player
	Checksum: 0x58CAF822
	Offset: 0x1670
	Size: 0x1A8
	Parameters: 5
	Flags: Linked
*/
function function_74a5d514(eattacker, idamage, smeansofdeath, weapon, shitloc)
{
	meleedamage = smeansofdeath === "MOD_MELEE" || smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || smeansofdeath === "MOD_MELEE_ASSASSINATE";
	if(isdefined(eattacker) && isplayer(eattacker) && meleedamage && eattacker hasperk(#"specialty_brawler"))
	{
		idamage = int(idamage * 4);
		new_health = eattacker.health + 50;
		eattacker.health = int(math::clamp(new_health, 0, max(eattacker.health, eattacker.maxhealth)));
		params = getstatuseffect(#"deaf_tinnitus");
		self status_effect::status_effect_apply(params, weapon, eattacker);
	}
	return idamage;
}

/*
	Name: function_31f333c6
	Namespace: player
	Checksum: 0xC0CAC3DD
	Offset: 0x1820
	Size: 0xB2
	Parameters: 3
	Flags: Private
*/
function private function_31f333c6(einflictor, eattacker, weapon)
{
	if(isplayer(einflictor))
	{
		return true;
	}
	if(!isplayer(eattacker))
	{
		return false;
	}
	if(isvehicle(einflictor))
	{
		return false;
	}
	if(weapon.isprimary)
	{
		return true;
	}
	if(weapon.isheroweapon)
	{
		return true;
	}
	if(weapon.islauncher)
	{
		return true;
	}
	return false;
}

/*
	Name: function_a31ab50c
	Namespace: player
	Checksum: 0xE860EF1A
	Offset: 0x18E0
	Size: 0x82
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a31ab50c(var_7c61c7a1)
{
	var_ce3cee3a = (self.var_a8b1ce45 === gettime() ? self.var_20038876 : 0);
	var_752c0834 = int(max(var_7c61c7a1, var_ce3cee3a));
	self.var_20038876 = var_752c0834;
	self.var_a8b1ce45 = gettime();
	return var_752c0834;
}

/*
	Name: function_961fe569
	Namespace: player
	Checksum: 0x11C73DFD
	Offset: 0x1970
	Size: 0x1050
	Parameters: 13
	Flags: Linked, Private
*/
function private function_961fe569(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal)
{
	pixbeginevent(#"hash_161ca565ac88c256");
	if(!level.console && idflags & 8 && isplayer(eattacker))
	{
		/#
			println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isplayer(einflictor) + "") + idamage) + "") + shitloc);
		#/
		eattacker stats::function_dad108fa(#"penetration_shots", 1);
	}
	if(getdvarstring(#"scr_csmode") != "")
	{
		self shellshock(#"damage_mp", 0.2);
	}
	self function_a774b4ed(eattacker, einflictor, weapon, smeansofdeath, idamage);
	self ability_power::power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
	if(isplayer(eattacker))
	{
		self.lastshotby = eattacker.clientid;
	}
	if(smeansofdeath == "MOD_BURNED")
	{
		self burnplayer::takingburndamage(eattacker, weapon, smeansofdeath);
	}
	else
	{
		if(smeansofdeath == "MOD_DEATH_CIRCLE")
		{
			vdir = undefined;
		}
		else if(smeansofdeath == "MOD_BLED_OUT")
		{
			vdir = undefined;
		}
	}
	self.gadget_was_active_last_damage = self gadgetisactive(0);
	isexplosivedamage = weapon_utils::isexplosivedamage(smeansofdeath);
	var_f727da4 = 0;
	if(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)
	{
		var_f727da4 = 1;
	}
	if(isexplosivedamage && idamage > 0 && (weapon.explosioninnerdamage > 1 || (isdefined(einflictor) && einflictor.var_9d992ed1 === 1)))
	{
		var_771902ea = status_effect::function_3c54ae98(3);
		var_81ccea1a = 1;
		if(weapons::getbaseweapon(weapon) == level.weaponflechette)
		{
			var_81ccea1a = smeansofdeath != "MOD_PROJECTILE" && weaponhasattachment(weapon, "uber");
		}
		if(var_81ccea1a && !var_f727da4 && weapon != getweapon(#"hero_pineapplegun"))
		{
			idamage = int(idamage * (1 - var_771902ea));
		}
		var_677cfdb0 = getstatuseffect("explosive_damage");
		status_effect::status_effect_apply(var_677cfdb0, weapon, eattacker);
	}
	if(isdefined(eattacker) && self != eattacker)
	{
		damagedone = idamage;
		if(self.health < damagedone)
		{
			damagedone = self.health;
		}
		if(isplayer(eattacker) && self util::isenemyteam(eattacker.team))
		{
			if(!isdefined(eattacker.damagedone))
			{
				eattacker.damagedone = 0;
			}
			eattacker.damagedone = eattacker.damagedone + damagedone;
			eattacker.pers[#"damagedone"] = eattacker.damagedone;
			eattacker weapons::function_b1d41bd5(weapon, damagedone);
			eattacker contracts::player_contract_event(#"damagedone", damagedone);
			eattacker stats::function_bb7eedf0(#"total_damage", int(damagedone));
			eattacker stats::function_b7f80d87(#"total_damage", int(damagedone));
			if(!sessionmodeiswarzonegame())
			{
				if(isarenamode())
				{
					total_damage = (isdefined(eattacker stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"arenavalue")) ? eattacker stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"arenavalue") : 0) + (isdefined(damagedone) ? damagedone : 0);
					eattacker stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"arenavalue", total_damage);
				}
				else
				{
					total_damage = (isdefined(eattacker stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"statvalue")) ? eattacker stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"statvalue") : 0) + (isdefined(damagedone) ? damagedone : 0);
					eattacker stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"total_damage", #"statvalue", total_damage);
				}
			}
			if(smeansofdeath === "MOD_HEAD_SHOT" && !killstreaks::is_killstreak_weapon(weapon))
			{
				eattacker stats::function_dad108fa(#"headshot_damage", int(damagedone));
			}
		}
	}
	is_melee = weapon_utils::ismeleemod(smeansofdeath);
	var_8c8cca9b = function_f74d2943(weapon, 6);
	var_e31583b3 = isdefined(var_8c8cca9b) && !is_melee;
	var_9a429025 = function_f74d2943(weapon, 7);
	var_7e7a6e97 = isdefined(var_9a429025) && !is_melee;
	if(isdefined(self.var_213b4a61) && (smeansofdeath == "MOD_BURNED" || smeansofdeath == "MOD_DOT") || var_e31583b3 && self !== eattacker)
	{
		var_9277fb8e = idamage;
		if(self.var_e00c085f === gettime())
		{
			var_9277fb8e = var_9277fb8e + self.var_9277fb8e;
		}
		var_e6544856 = max(self.maxhealth, self.health);
		var_7c61c7a1 = (var_e6544856 - self.health) + var_9277fb8e;
		var_56712f4 = self function_401b9b57();
		var_62b80170 = var_e6544856 - var_56712f4;
		if(var_7c61c7a1 > var_62b80170)
		{
			var_7c61c7a1 = var_62b80170;
		}
		self.var_e00c085f = gettime();
		self.var_9277fb8e = var_9277fb8e;
		if(isdefined(self.var_4dcf932b))
		{
			params = getstatuseffect("wound_radiation");
		}
		else
		{
			if(isdefined(self.var_e8bb749a))
			{
				params = getstatuseffect("shock_rifle_shock");
			}
			else
			{
				if(var_7e7a6e97)
				{
					params = var_9a429025;
				}
				else
				{
					if(var_e31583b3)
					{
						params = var_8c8cca9b;
					}
					else
					{
						params = getstatuseffect("wound");
					}
				}
			}
		}
		if(!(isdefined(params.var_d8e9a175) && params.var_d8e9a175) && (!isdefined(self.var_4dcf932b) || self.var_4dcf932b != self))
		{
			params.var_4df0ea83 = smeansofdeath != "MOD_DOT";
			if(params.setype == 6)
			{
				params.var_752c0834 = function_a31ab50c(var_7c61c7a1);
				params.var_4df0ea83 = 1;
				self.var_abe2db87 = 1;
			}
			self status_effect::status_effect_apply(params, weapon, eattacker, 0);
			var_284f3c1a = params.setype == 6;
			if(var_7e7a6e97 && !var_284f3c1a)
			{
				var_25635954 = (var_e31583b3 ? var_8c8cca9b : getstatuseffect("wound"));
				var_25635954.var_752c0834 = function_a31ab50c(var_7c61c7a1);
				self.var_abe2db87 = 1;
				self status_effect::status_effect_apply(var_25635954, weapon, eattacker, 0);
			}
		}
		if(isdefined(params.var_73c88af2) && params.var_73c88af2)
		{
			vdir = undefined;
		}
	}
	if(idamage > 1 && isdefined(eattacker) && isdefined(self.var_ea1458aa))
	{
		if(weapon_utils::isbulletdamage(smeansofdeath))
		{
			angles = self getplayerangles();
			forward = anglestoforward((0, angles[1], 0));
			var_5511f898 = vectornormalize(eattacker.origin - self.origin);
			if(vectordot(forward, var_5511f898) < 0.7)
			{
				if(!isdefined(self.var_ea1458aa.var_64ffda50))
				{
					self.var_ea1458aa.var_64ffda50 = [];
				}
				attackerentnum = eattacker getentitynumber();
				self.var_ea1458aa.var_64ffda50[attackerentnum] = gettime();
			}
		}
		else if(weapon_utils::isexplosivedamage(smeansofdeath))
		{
			if(isdefined(einflictor) && isdefined(einflictor.weapon) && einflictor.weapon.statname == #"recon_car")
			{
				if(!isdefined(self.var_ea1458aa.var_8f7ff7ed))
				{
					self.var_ea1458aa.var_8f7ff7ed = [];
				}
				attackerentnum = eattacker getentitynumber();
				self.var_ea1458aa.var_8f7ff7ed[attackerentnum] = gettime();
			}
		}
	}
	if(level.var_71c35c9f && weapon.statname == #"launcher_standard_t8" && smeansofdeath == "MOD_PROJECTILE_SPLASH")
	{
		idamage = int(idamage * 0.25);
	}
	fatal = self finishplayerdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
	if(self.var_abe2db87 === 1)
	{
		self function_b2b139e6();
		self.var_abe2db87 = undefined;
	}
	if(isdefined(self.laststand) && self.laststand)
	{
		if(isdefined(level.var_b1ad0b64) && isdefined(self.laststanddamage))
		{
			fatal = self [[level.var_b1ad0b64]](self.laststanddamage, smeansofdeath);
			self.laststanddamage = undefined;
		}
		else
		{
			fatal = 1;
		}
	}
	pixendevent();
	return fatal;
}

/*
	Name: player_damage_log
	Namespace: player
	Checksum: 0x802D1C37
	Offset: 0x29C8
	Size: 0x42C
	Parameters: 11
	Flags: Linked, Private
*/
function private player_damage_log(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
	pixbeginevent(#"playerdamage log");
	/#
		if(getdvarint(#"g_debugdamage", 0))
		{
			println(((((((((("" + self getentitynumber()) + "") + self.health) + "") + eattacker.clientid) + "") + isplayer(einflictor) + "") + idamage) + "") + shitloc);
		}
	#/
	if(self.sessionstate != "dead")
	{
		lpselfnum = self getentitynumber();
		lpselfname = self.name;
		lpselfteam = self.team;
		lpselfguid = self getguid();
		lpattackerteam = "";
		lpattackerorigin = (0, 0, 0);
		var_76d450bd = function_b14806c6(self player_role::get(), currentsessionmode());
		if(isplayer(eattacker))
		{
			lpattacknum = eattacker getentitynumber();
			var_c8fa9c41 = eattacker getxuid();
			lpattackguid = eattacker getguid();
			lpattackname = eattacker.name;
			lpattackerteam = eattacker.team;
			lpattackerorigin = eattacker.origin;
			isusingheropower = 0;
			var_a48b1a67 = function_b14806c6(eattacker player_role::get(), currentsessionmode());
			if(eattacker ability_player::is_using_any_gadget())
			{
				isusingheropower = 1;
			}
			if(isdefined(self.currentweapon))
			{
				name = self.currentweapon.name;
			}
			bb::function_c3b9e07f(eattacker, lpattackerorigin, var_a48b1a67, weapon.name, self, self.origin, var_76d450bd, name, idamage, smeansofdeath, shitloc, 0, isusingheropower, undefined);
		}
		else
		{
			lpattacknum = -1;
			var_c8fa9c41 = 0;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
			bb::function_c3b9e07f(undefined, undefined, undefined, weapon.name, self, self.origin, undefined, undefined, idamage, smeansofdeath, shitloc, 0, 0, undefined);
		}
	}
	pixendevent();
}

/*
	Name: should_allow_postgame_damage
	Namespace: player
	Checksum: 0x46CB25CC
	Offset: 0x2E00
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
function private should_allow_postgame_damage(smeansofdeath)
{
	if(smeansofdeath == "MOD_TRIGGER_HURT" || smeansofdeath == "MOD_CRUSH")
	{
		return true;
	}
	return false;
}

/*
	Name: do_post_game_damage
	Namespace: player
	Checksum: 0x5CCA662C
	Offset: 0x2E40
	Size: 0xE4
	Parameters: 13
	Flags: Linked, Private
*/
function private do_post_game_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal)
{
	if(!gamestate::is_game_over())
	{
		return;
	}
	if(!should_allow_postgame_damage(smeansofdeath))
	{
		return;
	}
	self finishplayerdamage(einflictor, eattacker, idamage, idflags, "MOD_POST_GAME", weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal);
}

/*
	Name: function_b5dadafc
	Namespace: player
	Checksum: 0x7DB1440
	Offset: 0x2F30
	Size: 0x1D0
	Parameters: 13
	Flags: Linked, Private
*/
function private function_b5dadafc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, vsurfacenormal)
{
	if(!gamestate::is_state("pregame"))
	{
		return false;
	}
	friendlyfire = isplayer(eattacker) && self util::isenemyplayer(eattacker) == 0;
	if(friendlyfire)
	{
		idamage = self does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, 0, smeansofdeath, vpoint, idamage, einflictor, eattacker);
		if(idamage <= 0)
		{
			return false;
		}
	}
	if(damagefeedback::dodamagefeedback(weapon, einflictor, idamage, smeansofdeath))
	{
		if(idamage > 0)
		{
			perkfeedback = function_e512b988(self, weapon, smeansofdeath, einflictor, idflags & 2048);
		}
		eattacker = figure_out_attacker(eattacker);
		if(isdefined(eattacker))
		{
			eattacker thread damagefeedback::update(smeansofdeath, einflictor, perkfeedback, weapon, self, psoffsettime, shitloc, 0, idflags);
		}
	}
	return true;
}

/*
	Name: function_e512b988
	Namespace: player
	Checksum: 0x640BC59B
	Offset: 0x3108
	Size: 0x292
	Parameters: 5
	Flags: Linked, Private
*/
function private function_e512b988(player, weapon, smeansofdeath, einflictor, armor_damaged)
{
	perkfeedback = undefined;
	var_14e61d05 = player function_14e61d05();
	hasflakjacket = player hasperk(#"specialty_flakjacket");
	isexplosivedamage = weapon_utils::isexplosivedamage(smeansofdeath);
	isflashorstundamage = weapon_utils::isflashorstundamage(weapon, smeansofdeath);
	var_d015da29 = weapon_utils::isfiredamage(weapon, smeansofdeath);
	var_1c365dd = player status_effect::function_3c54ae98(7) > 0;
	if(isflashorstundamage && var_14e61d05)
	{
		perkfeedback = "tacticalMask";
	}
	else
	{
		if(var_1c365dd && weapon == getweapon(#"shock_rifle"))
		{
			perkfeedback = "resistance";
		}
		else
		{
			if(player hasperk(#"specialty_fireproof") && weapon_utils::isfiredamage(weapon, smeansofdeath))
			{
				perkfeedback = "flakjacket";
			}
			else
			{
				if(isexplosivedamage || var_d015da29 && hasflakjacket && !weapon.ignoresflakjacket && !function_e3242ae4(weapon, einflictor))
				{
					perkfeedback = "flakjacket";
					player thread challenges::flakjacketprotectedmp();
				}
				else if(armor_damaged)
				{
					if((isdefined(getgametypesetting(#"hash_11e1a0adebdab01a")) ? getgametypesetting(#"hash_11e1a0adebdab01a") : 0))
					{
						perkfeedback = "armor";
					}
				}
			}
		}
	}
	return perkfeedback;
}

/*
	Name: function_e3242ae4
	Namespace: player
	Checksum: 0x1255F46
	Offset: 0x33A8
	Size: 0x56
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e3242ae4(weapon, einflictor)
{
	if(weapon.isaikillstreakdamage)
	{
		if(weapon.name != "ai_tank_drone_rocket" || isdefined(einflictor.firedbyai))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: does_player_completely_avoid_damage
	Namespace: player
	Checksum: 0xAD4A37B1
	Offset: 0x3408
	Size: 0x516
	Parameters: 10
	Flags: Linked, Private
*/
function private does_player_completely_avoid_damage(idflags, shitloc, weapon, friendlyfire, attackerishittingself, smeansofdeath, vpoint, idamage, einflictor, eattacker)
{
	if(idflags & 8192)
	{
		return idamage;
	}
	if(friendlyfire && level.friendlyfire == 0)
	{
		return 0;
	}
	if(friendlyfire && (weapon === getweapon(#"straferun_gun") || weapon == getweapon(#"straferun_rockets")))
	{
		return 0;
	}
	if(shitloc == "riotshield")
	{
		if(!idflags & 160)
		{
			return 0;
		}
	}
	if(self.currentweapon === getweapon(#"sig_buckler_turret") && weapon != getweapon(#"remote_missile_missile") && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_EXPLOSIVE" || (weapon.type == "gas" && (smeansofdeath == "MOD_GAS" || smeansofdeath == "MOD_BURNED"))))
	{
		angles = self getplayerangles();
		forward = anglestoforward((0, angles[1], 0));
		var_587ddb7b = weapon.statname == #"hero_flamethrower" && weapon.type == "gas" && (smeansofdeath == "MOD_GAS" || smeansofdeath == "MOD_BURNED");
		if(var_587ddb7b && isdefined(eattacker) && 0)
		{
			vpoint = eattacker.origin;
		}
		dirtoplayer = self.origin - vpoint;
		dir = vectornormalize((dirtoplayer[0], dirtoplayer[1], 0));
		dot = vectordot(forward, dir);
		dot_threshold = -0.7;
		if(var_587ddb7b)
		{
			dot_threshold = getdvarfloat(#"hash_5225b2e88154efd5", -0.25);
		}
		if(dot < dot_threshold)
		{
			var_a0c3f41d = (isdefined(self.currentweapon.var_e2b40cd5) ? self.currentweapon.var_e2b40cd5 : 0);
			if(var_a0c3f41d > 0)
			{
				blockeddamage = idamage;
				blockeddamage = blockeddamage * (1 - var_a0c3f41d);
				function_56dc620b(einflictor, eattacker, int(blockeddamage), weapon, getscriptbundle(self.currentweapon.customsettings));
				idamage = idamage * var_a0c3f41d;
				return int(idamage);
			}
			function_56dc620b(einflictor, eattacker, idamage, weapon, getscriptbundle(self.currentweapon.customsettings));
			return 0;
		}
	}
	if(weapon.isemp && smeansofdeath == "MOD_GRENADE_SPLASH")
	{
		if(self hasperk(#"specialty_immuneemp"))
		{
			return 0;
		}
	}
	return idamage;
}

/*
	Name: function_56dc620b
	Namespace: player
	Checksum: 0x2D9ED130
	Offset: 0x3928
	Size: 0x2B4
	Parameters: 5
	Flags: Linked
*/
function function_56dc620b(einflictor, eattacker, idamage, weapon, customsettings)
{
	previous_shield_damage = self.shielddamageblocked;
	self.shielddamageblocked = self.shielddamageblocked + idamage;
	if(self.shielddamageblocked % 200 < previous_shield_damage % 200)
	{
		if(isdefined(einflictor) && !isplayer(einflictor))
		{
			if(!isdefined(einflictor.var_a6cf412b))
			{
				einflictor.var_a6cf412b = [];
			}
			if(!isdefined(einflictor.var_a6cf412b[self.clientid]) || einflictor.var_a6cf412b[self.clientid].var_70465a20 != (isdefined(self.var_70465a20) ? self.var_70465a20 : 0))
			{
				info = spawnstruct();
				info.var_5d378d77 = 1;
				info.var_70465a20 = (isdefined(self.var_70465a20) ? self.var_70465a20 : 0);
				einflictor.var_a6cf412b[self.clientid] = info;
			}
			else
			{
				einflictor.var_a6cf412b[self.clientid].var_5d378d77++;
			}
		}
		var_2c23422d = (isdefined(customsettings.var_2c23422d) ? customsettings.var_2c23422d : 0);
		if(isplayer(einflictor) || einflictor.var_a6cf412b[self.clientid].var_5d378d77 <= var_2c23422d)
		{
			score = rank::getscoreinfovalue("shield_blocked_damage");
			if(score > 0)
			{
				self stats::function_e24eec31(level.weaponriotshield, #"score_from_blocked_damage", score);
			}
			scoreevents::processscoreevent(#"shield_blocked_damage", self, undefined, self.currentweapon);
		}
		self battlechatter::function_bd715920(self.currentweapon, eattacker, self.origin, weapon);
	}
}

/*
	Name: riotshield_hit
	Namespace: player
	Checksum: 0xCD1FDD8
	Offset: 0x3BE8
	Size: 0x1B4
	Parameters: 7
	Flags: Linked, Private
*/
function private riotshield_hit(einflictor, eattacker, idamage, smeansofdeath, weapon, attackerishittingteammate, vdir)
{
	if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_IMPACT" && !attackerishittingteammate)
	{
		currentweapon = self getcurrentweapon();
		if(currentweapon.isriotshield)
		{
			if(isplayer(eattacker))
			{
				eattacker.lastattackedshieldplayer = self;
				eattacker.lastattackedshieldtime = gettime();
			}
			function_56dc620b(einflictor, eattacker, idamage, weapon, getscriptbundle(currentweapon.customsettings));
			forward = anglestoforward(self getplayerangles());
			dot = vectordot(forward, vdir);
			if(dot < -0.8)
			{
				self status_effect::status_effect_apply(getstatuseffect("riotshield_hit_slow"), self.currentweapon, self, 0);
			}
		}
	}
}

/*
	Name: function_ef7fa582
	Namespace: player
	Checksum: 0x71A352D6
	Offset: 0x3DA8
	Size: 0x8A
	Parameters: 3
	Flags: Linked, Private
*/
function private function_ef7fa582(eattacker, etarget, weapon)
{
	if(level.hardcoremode)
	{
		return 0;
	}
	if(!isdefined(eattacker) || !isdefined(etarget))
	{
		return 0;
	}
	if(!isdefined(weapon))
	{
		return 0;
	}
	if(isdefined(eattacker.script_owner) && eattacker.script_owner == etarget)
	{
		return weapon.donotdamageowner;
	}
	return 0;
}

/*
	Name: should_do_player_damage
	Namespace: player
	Checksum: 0xCC0EE404
	Offset: 0x3E40
	Size: 0x3B4
	Parameters: 5
	Flags: Linked, Private
*/
function private should_do_player_damage(eattacker, einflictor, weapon, smeansofdeath, idflags)
{
	if(gamestate::is_game_over())
	{
		return false;
	}
	if(self.sessionteam == #"spectator")
	{
		return false;
	}
	if(isdefined(self.candocombat) && !self.candocombat)
	{
		return false;
	}
	if(isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return false;
	}
	if(isdefined(level.hostmigrationtimer))
	{
		return false;
	}
	if(level.onlyheadshots)
	{
		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
		{
			return false;
		}
	}
	if(isdefined(einflictor) && isdefined(einflictor.team) && !self util::isenemyteam(einflictor.team))
	{
		if(isvehicle(einflictor) && (isdefined(einflictor.var_54b19f55) && einflictor.var_54b19f55))
		{
			return false;
		}
		if(isai(einflictor) && isdefined(einflictor.ai) && (isdefined(einflictor.ai.var_54b19f55) && einflictor.ai.var_54b19f55))
		{
			return false;
		}
	}
	if(isdefined(eattacker) && isdefined(eattacker.team) && !self util::isenemyteam(eattacker.team))
	{
		if(isvehicle(eattacker) && (isdefined(eattacker.var_54b19f55) && eattacker.var_54b19f55))
		{
			return false;
		}
		if(isai(eattacker) && (isdefined(eattacker.ai.var_54b19f55) && eattacker.ai.var_54b19f55))
		{
			return false;
		}
	}
	if(self vehicle::player_is_occupant_invulnerable(eattacker, smeansofdeath))
	{
		return false;
	}
	if(weapon.issupplydropweapon && !weapon.isgrenadeweapon && smeansofdeath != "MOD_TRIGGER_HURT")
	{
		return false;
	}
	if(self.scene_takedamage === 0)
	{
		return false;
	}
	if(function_ef7fa582(einflictor, self, weapon))
	{
		return false;
	}
	if(idflags & 8 && self is_spawn_protected())
	{
		return false;
	}
	if(smeansofdeath == "MOD_CRUSH" && isdefined(einflictor) && einflictor.deal_no_crush_damage === 1)
	{
		return;
	}
	return true;
}

/*
	Name: apply_damage_to_armor
	Namespace: player
	Checksum: 0x3B85D527
	Offset: 0x4200
	Size: 0x24C
	Parameters: 9
	Flags: Linked, Private
*/
function private apply_damage_to_armor(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, shitloc, friendlyfire, ignore_round_start_friendly_fire)
{
	victim = self;
	if(friendlyfire && !function_1727a023(ignore_round_start_friendly_fire, eattacker))
	{
		return {#idamage:idamage, #idflags:idflags};
	}
	if(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == victim)
	{
		return {#idamage:victim.health, #idflags:idflags};
	}
	armor = self armor::get_armor();
	gear_armor = self.armor;
	self.var_426947c4 = undefined;
	idamage = victim armor::apply_damage(weapon, idamage, smeansofdeath, eattacker, shitloc);
	idamage = victim armor::function_a77114f2(einflictor, eattacker, idamage, smeansofdeath, weapon, shitloc);
	armor_damaged = armor != self armor::get_armor();
	if(armor_damaged)
	{
		idflags = idflags | 2048;
		if(gear_armor > 0 && self.armor <= 0)
		{
			self.var_426947c4 = 1;
		}
	}
	if(isdefined(self.power_armor_took_damage) && self.power_armor_took_damage)
	{
		idflags = idflags | 1024;
	}
	return {#idamage:idamage, #idflags:idflags};
}

/*
	Name: make_sure_damage_is_not_zero
	Namespace: player
	Checksum: 0xE648CDDE
	Offset: 0x4458
	Size: 0xB2
	Parameters: 2
	Flags: Linked, Private
*/
function private make_sure_damage_is_not_zero(idamage, armor_damaged)
{
	if(idamage < 1)
	{
		if(armor_damaged || self ability_util::gadget_power_armor_on() || self armor::has_armor() && isdefined(self.maxhealth) && self.health < self.maxhealth)
		{
			self.health = self.health + 1;
		}
		idamage = 1;
	}
	return int(idamage);
}

/*
	Name: modify_player_damage_friendlyfire
	Namespace: player
	Checksum: 0xDC39DBAB
	Offset: 0x4518
	Size: 0x72
	Parameters: 2
	Flags: Linked, Private
*/
function private modify_player_damage_friendlyfire(idamage, eattacker)
{
	friendlyfire = [[level.figure_out_friendly_fire]](self, eattacker);
	if(friendlyfire == 2 || friendlyfire == 3)
	{
		idamage = int(idamage * 0.5);
	}
	return idamage;
}

/*
	Name: function_7681dccc
	Namespace: player
	Checksum: 0x6EE493A0
	Offset: 0x4598
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_7681dccc()
{
	if(self isinvehicle())
	{
		vehicle = self getvehicleoccupied();
		if(isdefined(vehicle) && isdefined(vehicle.overrideplayerdamage))
		{
			return vehicle.overrideplayerdamage;
		}
	}
	if(isdefined(self.overrideplayerdamage))
	{
		return self.overrideplayerdamage;
	}
	if(isdefined(level.overrideplayerdamage))
	{
		return level.overrideplayerdamage;
	}
}

/*
	Name: modify_player_damage
	Namespace: player
	Checksum: 0xEE3E792C
	Offset: 0x4638
	Size: 0x43A
	Parameters: 11
	Flags: Linked, Private
*/
function private modify_player_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
	overrideplayerdamage = function_7681dccc();
	if(isdefined(overrideplayerdamage))
	{
		idamage = self [[overrideplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex);
	}
	/#
		assert(isdefined(idamage), "");
	#/
	if(isdefined(eattacker))
	{
		idamage = loadout::cac_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
		if(isdefined(eattacker.pickup_damage_scale) && eattacker.pickup_damage_scale_time > gettime())
		{
			idamage = idamage * eattacker.pickup_damage_scale;
		}
	}
	idamage = custom_gamemodes_modified_damage(self, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc);
	if(level.onplayerdamage != (&globallogic::blank))
	{
		modifieddamage = [[level.onplayerdamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
		if(isdefined(modifieddamage))
		{
			if(modifieddamage <= 0)
			{
				return;
			}
			idamage = modifieddamage;
		}
	}
	if(level.onlyheadshots)
	{
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			idamage = 150;
		}
	}
	if(weapon.damagealwayskillsplayer)
	{
		idamage = self.maxhealth + 1;
	}
	if(shitloc == "riotshield")
	{
		if(idflags & 32)
		{
			if(!idflags & 64)
			{
				idamage = idamage * 0;
			}
		}
		else if(idflags & 128)
		{
			if(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && einflictor.stucktoplayer == self)
			{
				idamage = self.maxhealth + 1;
			}
		}
	}
	if(self.currentweapon === getweapon(#"sig_buckler_dw") && (smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_PROJECTILE"))
	{
		angles = self getplayerangles();
		forward = anglestoforward((0, angles[1], 0));
		dirtoplayer = self.origin - vpoint;
		dir = vectornormalize((dirtoplayer[0], dirtoplayer[1], 0));
		dot = vectordot(forward, dir);
		if(dot < -0.7)
		{
			idamage = idamage * weapon.var_6844746b;
		}
	}
	return int(idamage);
}

/*
	Name: modify_player_damage_meansofdeath
	Namespace: player
	Checksum: 0x1F5BF10F
	Offset: 0x4A80
	Size: 0xD2
	Parameters: 5
	Flags: Linked, Private
*/
function private modify_player_damage_meansofdeath(einflictor, eattacker, smeansofdeath, weapon, shitloc)
{
	if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(eattacker) && !weapon_utils::ismeleemod(smeansofdeath))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}
	if(isdefined(einflictor) && isdefined(einflictor.script_noteworthy))
	{
		if(einflictor.script_noteworthy == "ragdoll_now")
		{
			smeansofdeath = "MOD_FALLING";
		}
	}
	return smeansofdeath;
}

/*
	Name: function_4ac2aefc
	Namespace: player
	Checksum: 0x2479AF1A
	Offset: 0x4B60
	Size: 0x2AA
	Parameters: 3
	Flags: Linked, Private
*/
function private function_4ac2aefc(einflictor, eattacker, smeansofdeath)
{
	if(isplayer(eattacker))
	{
		if(isdefined(einflictor) && eattacker == einflictor)
		{
			if(smeansofdeath == "MOD_HEAD_SHOT" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
			{
				if(!isdefined(eattacker.hits))
				{
					eattacker.hits = 0;
				}
				if(!isdefined(eattacker.var_2641e022))
				{
					eattacker.var_2641e022 = 0;
				}
				if(!isdefined(eattacker.shotsfired))
				{
					eattacker.shotsfired = 0;
				}
				if(!isdefined(eattacker.shotshit))
				{
					eattacker.shotshit = 0;
				}
				if(isdefined(eattacker.pers))
				{
					if(!isdefined(eattacker.pers[#"shotshit"]))
					{
						eattacker.pers[#"shotshit"] = 0;
					}
					eattacker.pers[#"shotshit"]++;
					eattacker.shotshit = eattacker.pers[#"shotshit"];
				}
				eattacker.hits++;
				if(smeansofdeath == "MOD_HEAD_SHOT")
				{
					eattacker.var_2641e022++;
				}
				shotsmissed = eattacker.shotsfired - eattacker.shotshit;
				if(shotsmissed < 0)
				{
					shotsmissed = 0;
				}
				eattacker.shotsmissed = shotsmissed;
				if(isdefined(eattacker.pers))
				{
					eattacker.pers[#"shotsmissed"] = shotsmissed;
				}
			}
		}
		if(isdefined(eattacker.pers))
		{
			if(!isdefined(eattacker.pers[#"participation"]))
			{
				eattacker.pers[#"participation"] = 0;
			}
			eattacker.pers[#"participation"]++;
		}
	}
}

/*
	Name: function_811dd365
	Namespace: player
	Checksum: 0xA8E5EBE9
	Offset: 0x4E18
	Size: 0x17E
	Parameters: 3
	Flags: Linked, Private
*/
function private function_811dd365(einflictor, weapon, smeansofdeath)
{
	if(!self is_spawn_protected())
	{
		return false;
	}
	if(weapon.explosionradius == 0)
	{
		return false;
	}
	if(weapons::getbaseweapon(weapon) == level.weaponflechette && weaponhasattachment(weapon, "uber"))
	{
		return false;
	}
	distsqr = (isdefined(self.lastspawnpoint) ? distancesquared(einflictor.origin, self.lastspawnpoint.origin) : 0);
	if(distsqr < 250 * 250)
	{
		if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH")
		{
			return true;
		}
		if(smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH")
		{
			return true;
		}
		if(smeansofdeath == "MOD_EXPLOSIVE")
		{
			return true;
		}
	}
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		return true;
	}
	return false;
}

/*
	Name: function_104e1126
	Namespace: player
	Checksum: 0x7F300D76
	Offset: 0x4FA0
	Size: 0x62A
	Parameters: 11
	Flags: Linked, Private
*/
function private function_104e1126(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex)
{
	is_explosive_damage = weapon_utils::isexplosivedamage(smeansofdeath);
	if(is_explosive_damage)
	{
		if(self function_811dd365(einflictor, weapon, smeansofdeath))
		{
			return false;
		}
		if(self function_eacd01b7(eattacker, weapon))
		{
			return false;
		}
	}
	if(isdefined(einflictor) && (smeansofdeath == "MOD_GAS" || is_explosive_damage))
	{
		self.explosiveinfo = [];
		self.explosiveinfo[#"damagetime"] = gettime();
		self.explosiveinfo[#"damageid"] = einflictor getentitynumber();
		self.explosiveinfo[#"originalownerkill"] = 0;
		self.explosiveinfo[#"bulletpenetrationkill"] = 0;
		self.explosiveinfo[#"chainkill"] = 0;
		self.explosiveinfo[#"damageexplosivekill"] = 0;
		self.explosiveinfo[#"chainkill"] = 0;
		self.explosiveinfo[#"cookedkill"] = 0;
		self.explosiveinfo[#"weapon"] = weapon;
		self.explosiveinfo[#"originalowner"] = einflictor.originalowner;
		isfrag = weapon.rootweapon.name == "frag_grenade";
		if(isdefined(eattacker) && eattacker != self)
		{
			if(isdefined(eattacker) && isdefined(einflictor.owner) && (weapon.name == #"satchel_charge" || weapon.name == #"claymore" || weapon.name == #"bouncingbetty"))
			{
				self.explosiveinfo[#"originalownerkill"] = einflictor.owner == self;
				self.explosiveinfo[#"damageexplosivekill"] = isdefined(einflictor.wasdamaged);
				self.explosiveinfo[#"chainkill"] = isdefined(einflictor.waschained);
				self.explosiveinfo[#"wasjustplanted"] = isdefined(einflictor.wasjustplanted);
				self.explosiveinfo[#"bulletpenetrationkill"] = isdefined(einflictor.wasdamagedfrombulletpenetration);
				self.explosiveinfo[#"cookedkill"] = 0;
			}
			if(isdefined(einflictor) && isdefined(einflictor.stucktoplayer) && weapon.projexplosiontype == "grenade")
			{
				self.explosiveinfo[#"stucktoplayer"] = einflictor.stucktoplayer;
			}
			if(weapon.dostun)
			{
				self.laststunnedby = eattacker;
				self.laststunnedtime = self.idflagstime;
			}
			if(isdefined(eattacker.lastgrenadesuicidetime) && eattacker.lastgrenadesuicidetime >= (gettime() - 50) && isfrag)
			{
				self.explosiveinfo[#"suicidegrenadekill"] = 1;
			}
			else
			{
				self.explosiveinfo[#"suicidegrenadekill"] = 0;
			}
		}
		if(isfrag)
		{
			self.explosiveinfo[#"cookedkill"] = isdefined(einflictor.iscooked);
			self.explosiveinfo[#"throwbackkill"] = isdefined(einflictor.threwback);
		}
		if(isdefined(eattacker) && isplayer(eattacker) && eattacker != self)
		{
			self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
		}
	}
	if(smeansofdeath == "MOD_IMPACT" && isdefined(eattacker) && isplayer(eattacker) && eattacker != self)
	{
		if(!weapon.isballisticknife)
		{
			self globallogic_score::setinflictorstat(einflictor, eattacker, weapon);
		}
		if(weapon.rootweapon.name == "hatchet" && isdefined(einflictor))
		{
			self.explosiveinfo[#"projectile_bounced"] = isdefined(einflictor.bounced);
		}
	}
	return true;
}

/*
	Name: function_acca46ef
	Namespace: player
	Checksum: 0xE37BE2DE
	Offset: 0x55D8
	Size: 0x84
	Parameters: 0
	Flags: Linked, Private
*/
function private function_acca46ef()
{
	if(!isdefined(level.discardtime) || !isdefined(level.starttime))
	{
		return false;
	}
	if(level.friendlyfiredelay && level.friendlyfiredelaytime >= ((float((gettime() - level.starttime) - level.discardtime)) / 1000))
	{
		return true;
	}
	return false;
}

/*
	Name: function_44b6bb92
	Namespace: player
	Checksum: 0x8F54457F
	Offset: 0x5668
	Size: 0xB4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_44b6bb92(eattacker, ignore_round_start_friendly_fire)
{
	if(!isalive(eattacker))
	{
		return false;
	}
	friendlyfire = [[level.figure_out_friendly_fire]](self, eattacker);
	if(friendlyfire == 1)
	{
		if(function_acca46ef() && ignore_round_start_friendly_fire == 0)
		{
			return true;
		}
	}
	if(friendlyfire == 2)
	{
		return true;
	}
	if(friendlyfire == 3)
	{
		return true;
	}
	return false;
}

/*
	Name: function_1727a023
	Namespace: player
	Checksum: 0x8D870D66
	Offset: 0x5728
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_1727a023(ignore_round_start_friendly_fire, attacker)
{
	friendlyfire = [[level.figure_out_friendly_fire]](self, attacker);
	if(friendlyfire == 1)
	{
		if(function_acca46ef() && ignore_round_start_friendly_fire == 0)
		{
			return false;
		}
		return true;
	}
	if(friendlyfire == 3)
	{
		return true;
	}
	return false;
}

/*
	Name: function_eacd01b7
	Namespace: player
	Checksum: 0xD67A64F6
	Offset: 0x57B8
	Size: 0x4E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_eacd01b7(eattacker, weapon)
{
	if(level.hardcoremode)
	{
		return 0;
	}
	if(!isdefined(eattacker))
	{
		return 0;
	}
	if(self != eattacker)
	{
		return 0;
	}
	return weapon.donotdamageowner;
}

/*
	Name: function_f4f77cfb
	Namespace: player
	Checksum: 0x9AA3BA61
	Offset: 0x5810
	Size: 0x17A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_f4f77cfb(weapon, einflictor)
{
	if(weapon == level.weaponnone && isdefined(einflictor))
	{
		if(isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel")
		{
			weapon = getweapon(#"explodable_barrel");
		}
		else
		{
			if(isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_"))
			{
				weapon = getweapon(#"destructible_car");
			}
			else if(isdefined(einflictor.scriptvehicletype))
			{
				veh_weapon = getweapon(einflictor.scriptvehicletype);
				if(isdefined(veh_weapon))
				{
					weapon = veh_weapon;
				}
			}
		}
	}
	if(isdefined(einflictor) && isdefined(einflictor.script_noteworthy))
	{
		if(isdefined(level.overrideweaponfunc))
		{
			weapon = [[level.overrideweaponfunc]](weapon, einflictor.script_noteworthy);
		}
	}
	return weapon;
}

/*
	Name: custom_gamemodes_modified_damage
	Namespace: player
	Checksum: 0x3F9B8259
	Offset: 0x5998
	Size: 0xE2
	Parameters: 7
	Flags: Linked, Private
*/
function private custom_gamemodes_modified_damage(victim, eattacker, idamage, smeansofdeath, weapon, einflictor, shitloc)
{
	if(level.onlinegame && !sessionmodeisprivate())
	{
		return idamage;
	}
	if(isdefined(eattacker) && isdefined(eattacker.damagemodifier))
	{
		idamage = idamage * eattacker.damagemodifier;
	}
	if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
	{
		idamage = int(idamage * level.bulletdamagescalar);
	}
	return idamage;
}

/*
	Name: function_a774b4ed
	Namespace: player
	Checksum: 0xA6EEBD61
	Offset: 0x5A88
	Size: 0x206
	Parameters: 5
	Flags: Linked, Private
*/
function private function_a774b4ed(eattacker, einflictor, weapon, smeansofdeath, idamage)
{
	self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
	if(!self util::isusingremote())
	{
		if(sessionmodeiswarzonegame() && smeansofdeath == "MOD_DEATH_CIRCLE")
		{
			if(!isdefined(self.var_2f5355a6) || gettime() > self.var_2f5355a6)
			{
				self playrumbleonentity("damage_death_circle");
				self.var_2f5355a6 = gettime();
			}
		}
		else
		{
			if(sessionmodeiswarzonegame() && smeansofdeath == "MOD_BLED_OUT")
			{
				if(!isdefined(self.var_2c725854) || gettime() > self.var_2c725854)
				{
					self playrumbleonentity("damage_bleed");
					self.var_2c725854 = gettime();
				}
			}
			else
			{
				if(smeansofdeath != "MOD_DOT" && smeansofdeath != "MOD_DOT_SELF")
				{
					if(!isdefined(self.var_6d9f302e) || gettime() > self.var_6d9f302e)
					{
						self playrumbleonentity("damage_heavy");
						self.var_6d9f302e = gettime();
					}
				}
				else if(!isdefined(self.var_b82529f5) || gettime() > self.var_b82529f5)
				{
					self playrumbleonentity("damage_light");
					self.var_b82529f5 = gettime();
				}
			}
		}
	}
}

/*
	Name: function_40c6c42d
	Namespace: player
	Checksum: 0x24303A83
	Offset: 0x5C98
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function function_40c6c42d(attacker)
{
	damage = 0;
	if(isdefined(attacker.clientid) && isdefined(self.attackerdamage) && isdefined(self.attackerdamage[attacker.clientid]) && self.attackerdamage[attacker.clientid].damage)
	{
		damage = self.attackerdamage[attacker.clientid].damage;
		if(damage > 200)
		{
			damage = 200;
		}
	}
	return damage;
}

/*
	Name: function_201c298c
	Namespace: player
	Checksum: 0x403B20AD
	Offset: 0x5D50
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function function_201c298c()
{
	var_28214e57 = undefined;
	lastdamagetime = undefined;
	if(isarray(self.attackerdamage))
	{
		foreach(clientid, damage in self.attackerdamage)
		{
			if(!isdefined(var_28214e57) || damage.lastdamagetime > lastdamagetime)
			{
				var_28214e57 = clientid;
				lastdamagetime = damage.lastdamagetime;
			}
		}
	}
	if(isdefined(var_28214e57))
	{
		foreach(player in getplayers())
		{
			if(player.clientid === var_28214e57)
			{
				return player;
			}
		}
	}
	return undefined;
}

