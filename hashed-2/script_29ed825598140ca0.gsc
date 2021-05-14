// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_184abbae9afad370;
#using script_18f0d22c75b141a7;
#using script_2c49ae69cd8ce30c;
#using script_2c74a7b5eea1ec89;
#using script_2dc48f46bfeac894;
#using script_35b5ff21c2a0960f;
#using script_3f27a7b2232674db;
#using script_3f9e54c7a9a7e1e2;
#using script_47fb62300ac0bd60;
#using script_5399f402045d7abd;
#using script_545a0bac37bda541;
#using script_66052559f4fc2bf9;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_70a43d6ba27cff6a;
#using script_7133a4d461308099;
#using script_75be2950b381443;
#using script_7bafaa95bb1b427e;
#using script_caab14e8a60767c;
#using scripts\core_common\audio_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\medals_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\bb.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\gametypes\deathicons.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\userspawnselection.gsc;
#using scripts\mp_common\util.gsc;

#namespace player;

/*
	Name: function_df36a02d
	Namespace: player
	Checksum: 0x8306888C
	Offset: 0x698
	Size: 0x2AE
	Parameters: 3
	Flags: Linked
*/
function function_df36a02d(attacker, weapon, mod)
{
	if(isdefined(weapon))
	{
		var_2f9ea2b9 = weapons::getbaseweapon(weapon);
		baseweaponindex = getbaseweaponitemindex(var_2f9ea2b9);
		self clientfield::set_player_uimodel("huditems.killedByItemIndex", baseweaponindex);
	}
	else
	{
		self clientfield::set_player_uimodel("huditems.killedByItemIndex", 0);
	}
	if(isdefined(attacker))
	{
		self clientfield::set_player_uimodel("huditems.killedByEntNum", attacker getentitynumber());
	}
	else
	{
		self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
	}
	if(isdefined(mod))
	{
		var_19b57d54 = function_4a856ead(mod);
		if(mod != "MOD_META")
		{
			if(attacker === self)
			{
				var_19b57d54 = function_4a856ead("MOD_SUICIDE");
			}
			else if(weapon === level.weaponnone)
			{
				var_19b57d54 = function_4a856ead("MOD_UNKNOWN");
				self clientfield::set_player_uimodel("huditems.killedByEntNum", self getentitynumber());
			}
		}
		self clientfield::set_player_uimodel("huditems.killedByMOD", var_19b57d54);
	}
	else
	{
		self clientfield::set_player_uimodel("huditems.killedByEntNum", 15);
	}
	attachments = function_30d57f0e(weapon);
	self clientfield::set_player_uimodel("huditems.killedByAttachmentCount", attachments.size);
	for(var_20d65af5 = 0; var_20d65af5 < attachments.size && var_20d65af5 < 5; var_20d65af5++)
	{
		self clientfield::set_player_uimodel("huditems.killedByAttachment" + var_20d65af5, attachments[var_20d65af5]);
	}
}

/*
	Name: function_7622d447
	Namespace: player
	Checksum: 0xD813DB1A
	Offset: 0x950
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function function_7622d447(attacker)
{
	if(isdefined(self.attackers))
	{
		for(j = 0; j < self.attackers.size; j++)
		{
			player = self.attackers[j];
			if(self function_ca27b62b(attacker, player))
			{
				damage_done = self.attackerdamage[player.clientid].damage;
				einflictor = self.attackerdamage[player.clientid].einflictor;
				weapon = self.attackerdamage[player.clientid].weapon;
				player function_b8871aa2(einflictor, self, damage_done, weapon);
			}
		}
	}
}

/*
	Name: function_ca27b62b
	Namespace: player
	Checksum: 0x4E6E319
	Offset: 0xA70
	Size: 0x138
	Parameters: 2
	Flags: Linked
*/
function function_ca27b62b(attacker, player)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(isdefined(attacker) && player util::isenemyteam(attacker.team))
	{
		return 0;
	}
	if(self.attackerdamage[player.clientid].damage == 0)
	{
		return 0;
	}
	if(isdefined(level.var_f68b214e) && level.var_f68b214e && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime)
	{
		return 0;
	}
	if(isdefined(level.var_c77de7d6) && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_284c61bd
	Namespace: player
	Checksum: 0x9B55029A
	Offset: 0xBB0
	Size: 0x26E
	Parameters: 3
	Flags: Linked
*/
function function_284c61bd(attacker, meansofdeath, bledout = 0)
{
	if(function_f99d2668())
	{
		return;
	}
	if(isdefined(self.attackers) && isdefined(attacker))
	{
		for(j = 0; j < self.attackers.size; j++)
		{
			player = self.attackers[j];
			if(!isdefined(player))
			{
				continue;
			}
			if(player util::isenemyteam(attacker.team))
			{
				continue;
			}
			if(self.attackerdamage[player.clientid].damage == 0)
			{
				continue;
			}
			if(isdefined(level.var_f68b214e) && level.var_f68b214e && isdefined(player.deathtime) && player.deathtime > self.attackerdamage[player.clientid].lastdamagetime)
			{
				continue;
			}
			if(isdefined(level.var_c77de7d6) && level.var_c77de7d6 && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime && !bledout)
			{
				continue;
			}
			einflictor = self.attackerdamage[player.clientid].einflictor;
			weapon = self.attackerdamage[player.clientid].weapon;
			if(player != attacker)
			{
				meansofdeath = self.attackerdamage[player.clientid].meansofdeath;
			}
			self function_4e3e8bee(einflictor, player, meansofdeath, weapon, attacker);
		}
	}
}

/*
	Name: function_66cec679
	Namespace: player
	Checksum: 0x2B0701CF
	Offset: 0xE28
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_66cec679()
{
	team = self.team;
	teammates = getplayers(team);
	foreach(player in teammates)
	{
		if(player == self)
		{
			continue;
		}
		if(player.sessionstate == "spectator")
		{
			player.spectatorclient = self getentitynumber();
		}
	}
}

/*
	Name: function_448f7ed2
	Namespace: player
	Checksum: 0x8BCF820A
	Offset: 0xF10
	Size: 0x176
	Parameters: 0
	Flags: Linked, Private
*/
private function function_448f7ed2()
{
	if(isdefined(level.wave_spawn) && level.wave_spawn)
	{
		time = gettime();
		team = self.pers[#"team"];
		if(isdefined(team) && isdefined(level.lastwave) && isdefined(level.lastwave[team]) && isdefined(level.wavedelay) && isdefined(level.wavedelay[team]))
		{
			wavedelay = int(level.wavedelay[team] * 1000);
			lasttime = time - level.lastwave[team];
			timediff = wavedelay - lasttime;
			var_4e7f2872 = isdefined(level.var_75db41a7) && time >= level.var_75db41a7;
			if(timediff > 5000 && !var_4e7f2872)
			{
				return 1;
			}
		}
	}
	else
	{
		return 1;
	}
	return 0;
}

/*
	Name: callback_playerkilled
	Namespace: player
	Checksum: 0x97F55C13
	Offset: 0x1090
	Size: 0x3104
	Parameters: 10
	Flags: Linked
*/
function callback_playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration, enteredresurrect = 0)
{
	profilelog_begintiming(7, "ship");
	self endon(#"spawned");
	self.var_4ef33446 = smeansofdeath == "MOD_META";
	if(gamestate::is_game_over())
	{
		post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		return;
	}
	if(self.sessionteam == #"spectator")
	{
		return;
	}
	util::function_1ea0b2ce();
	level.var_445b1bca = gettime();
	self needsrevive(0);
	if(isdefined(self.burning) && self.burning == 1)
	{
		self setburn(0);
	}
	self.suicide = 0;
	self.teamkilled = 0;
	countdeath = !(isdefined(self.var_cee93f5) && self.var_cee93f5) && !self.var_4ef33446;
	if(countdeath)
	{
		if(!isdefined(self.var_a7d7e50a))
		{
			self.var_a7d7e50a = 0;
		}
		level.deaths[self.team]++;
		self.var_a7d7e50a++;
		start_generator_captureshouldshowpain();
	}
	self callback::callback(#"on_player_killed");
	attacker callback::callback(#"hash_1c99870b7a855dd0");
	self thread globallogic_audio::flush_leader_dialog_key_on_player("equipmentDestroyed");
	weapon = update_weapon(einflictor, weapon);
	pixbeginevent(#"hash_47eb123ec5413349");
	self thread audio::function_30d4f8c4(attacker, smeansofdeath, weapon);
	wasinlaststand = 0;
	bledout = 0;
	deathtimeoffset = 0;
	attackerstance = undefined;
	self.laststandthislife = undefined;
	self.vattackerorigin = undefined;
	self function_df36a02d(attacker, weapon, smeansofdeath);
	weapon_at_time_of_death = self getcurrentweapon();
	var_8efc9727 = isplayer(attacker) && self util::isenemyplayer(attacker) == 0;
	var_41c4d474 = isplayer(attacker) && self == attacker;
	var_f90950bd = (isdefined(attacker) ? attacker : self);
	var_aedb48f4 = {#hash_10d87328:function_f8d53445(), #shitloc:shitloc, #vdir:vdir, #sweapon:weapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #hash_83634238:(isplayer(var_f90950bd.origin) ? var_f90950bd getplayerangles() : var_f90950bd.angles), #attackerorigin:var_f90950bd.origin, #attacker:attacker, #einflictor:einflictor, #victimweapon:self.currentweapon, #hash_5fceefd4:self getplayerangles(), #victimorigin:self.origin};
	laststandparams = self.laststandparams;
	var_a1d415ee = self.var_a1d415ee;
	if(isdefined(self.uselaststandparams) && enteredresurrect == 0)
	{
		self.uselaststandparams = undefined;
		/#
			assert(isdefined(self.laststandparams));
		#/
		if(isdefined(self.laststandparams) && (!level.teambased || (!isdefined(attacker) || !isplayer(attacker) || !var_8efc9727 || var_41c4d474)))
		{
			einflictor = self.laststandparams.einflictor;
			attacker = self.laststandparams.attacker;
			attackerstance = self.laststandparams.attackerstance;
			idamage = self.laststandparams.idamage;
			smeansofdeath = self.laststandparams.smeansofdeath;
			weapon = self.laststandparams.sweapon;
			vdir = self.laststandparams.vdir;
			shitloc = self.laststandparams.shitloc;
			self.vattackerorigin = self.laststandparams.vattackerorigin;
			self.killcam_entity_info_cached = self.laststandparams.killcam_entity_info_cached;
			if(!(isdefined(self.laststandparams.var_59b19c1b) && self.laststandparams.var_59b19c1b))
			{
				deathtimeoffset = float(gettime() - self.laststandparams.laststandstarttime) / 1000;
			}
			bledout = self.laststandparams.bledout;
			wasinlaststand = 1;
			var_8efc9727 = isplayer(attacker) && self util::isenemyplayer(attacker) == 0;
			var_41c4d474 = isplayer(attacker) && self == attacker;
		}
	}
	params = {#laststandparams:laststandparams, #deathanimduration:deathanimduration, #psoffsettime:psoffsettime, #shitloc:shitloc, #vdir:vdir, #weapon:weapon, #smeansofdeath:smeansofdeath, #idamage:idamage, #eattacker:attacker, #einflictor:einflictor};
	self callback::callback(#"on_player_killed_with_params", params);
	self stopsounds();
	bestplayer = undefined;
	bestplayermeansofdeath = undefined;
	obituarymeansofdeath = undefined;
	bestplayerweapon = undefined;
	obituaryweapon = weapon;
	assistedsuicide = 0;
	if(isdefined(self.attackers) && (!isdefined(attacker) || attacker.classname === "trigger_hurt_new" || attacker.classname === "worldspawn" || (isdefined(attacker.ismagicbullet) && attacker.ismagicbullet) || attacker == self))
	{
		if(!isdefined(bestplayer))
		{
			for(i = 0; i < self.attackers.size; i++)
			{
				player = self.attackers[i];
				if(!isdefined(player))
				{
					continue;
				}
				if(!isdefined(self.attackerdamage[player.clientid]) || !isdefined(self.attackerdamage[player.clientid].damage))
				{
					continue;
				}
				if(var_41c4d474 || var_8efc9727)
				{
					continue;
				}
				if(player == self)
				{
					continue;
				}
				if(isdefined(level.var_c77de7d6) && gettime() > int(level.var_c77de7d6 * 1000) + self.attackerdamage[player.clientid].lastdamagetime)
				{
					continue;
				}
				if(!globallogic_player::allowedassistweapon(self.attackerdamage[player.clientid].weapon))
				{
					continue;
				}
				if(self.attackerdamage[player.clientid].damage > 1 && !isdefined(bestplayer))
				{
					bestplayer = player;
					bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
					bestplayerweapon = self.attackerdamage[player.clientid].weapon;
					continue;
				}
				if(isdefined(bestplayer) && self.attackerdamage[player.clientid].damage > self.attackerdamage[bestplayer.clientid].damage)
				{
					bestplayer = player;
					bestplayermeansofdeath = self.attackerdamage[player.clientid].meansofdeath;
					bestplayerweapon = self.attackerdamage[player.clientid].weapon;
				}
			}
		}
		if(isdefined(bestplayer))
		{
			scoreevents::processscoreevent(#"assisted_suicide", bestplayer, self, bestplayerweapon);
			self recordkillmodifier("assistedsuicide");
			assistedsuicide = 1;
		}
	}
	if(isdefined(bestplayer))
	{
		attacker = bestplayer;
		obituarymeansofdeath = bestplayermeansofdeath;
		obituaryweapon = bestplayerweapon;
		if(isdefined(bestplayerweapon))
		{
			weapon = bestplayerweapon;
		}
	}
	if(isdefined(attacker) && isplayer(attacker) && isdefined(self.clientid))
	{
		if(!isdefined(attacker.damagedplayers))
		{
			attacker.damagedplayers = [];
		}
		attacker.damagedplayers[self.clientid] = undefined;
	}
	if(enteredresurrect == 0)
	{
		globallogic::doweaponspecifickilleffects(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	}
	self.deathtime = gettime();
	self.pers[#"deathtime"] = self.deathtime;
	if(!var_41c4d474 && !var_8efc9727)
	{
		/#
			assert(isdefined(self.lastspawntime));
		#/
		if(!isdefined(self.alivetimecurrentindex))
		{
			self.alivetimecurrentindex = 0;
		}
		if(isdefined(self.lastspawntime))
		{
			self.alivetimes[self.alivetimecurrentindex] = self.deathtime - self.lastspawntime;
		}
		else
		{
			self.alivetimes[self.alivetimecurrentindex] = 0;
		}
		self.alivetimecurrentindex = self.alivetimecurrentindex + 1 % level.alivetimemaxcount;
	}
	attacker = function_4ac2aefc(attacker, weapon);
	einflictor = function_91cd8b0d(einflictor);
	smeansofdeath = self function_b029639e(attacker, einflictor, weapon, smeansofdeath, shitloc);
	if(!isdefined(obituarymeansofdeath))
	{
		obituarymeansofdeath = smeansofdeath;
	}
	self.hasriotshield = 0;
	self.hasriotshieldequipped = 0;
	self thread function_8826f676();
	var_a1f4d122 = undefined;
	if(isdefined(self.var_a1d415ee))
	{
		if(isplayer(self.var_a1d415ee.attacker))
		{
			var_a1f4d122 = self.var_a1d415ee.attacker;
		}
	}
	if(!self.var_4ef33446)
	{
		self function_abbc84ad(attacker, weapon, smeansofdeath, einflictor);
		self function_a3030357(attacker, einflictor, obituaryweapon, obituarymeansofdeath, var_a1f4d122);
	}
	if(wasinlaststand)
	{
		function_caabcf70(self, var_aedb48f4, laststandparams, var_a1d415ee);
	}
	if(enteredresurrect == 0)
	{
		self.sessionstate = "dead";
		self.statusicon = "hud_status_dead";
	}
	self.pers[#"weapon"] = undefined;
	self.killedplayerscurrent = [];
	if(countdeath)
	{
		if(!isdefined(self.deathcount))
		{
			self.deathcount = 0;
		}
		self.deathcount++;
	}
	/#
		println("" + self.clientid + "" + self.deathcount);
	#/
	if(bledout == 0)
	{
		self function_4e516ee6(attacker, weapon);
	}
	lpselfnum = self getentitynumber();
	lpselfname = self.name;
	lpattackguid = "";
	lpattackname = "";
	lpselfteam = self.team;
	lpselfguid = self getguid();
	lpattackteam = "";
	lpattackorigin = (0, 0, 0);
	lpattacknum = -1;
	var_c8fa9c41 = 0;
	awardassists = 0;
	wasteamkill = 0;
	wassuicide = 0;
	pixendevent();
	if(countdeath)
	{
		scoreevents::processscoreevent(#"death", self, self, weapon);
	}
	if(isplayer(attacker))
	{
		lpattackguid = attacker getguid();
		lpattackname = attacker.name;
		lpattackteam = attacker.team;
		lpattackorigin = attacker.origin;
		var_c8fa9c41 = attacker getxuid();
		if(attacker == self || assistedsuicide == 1)
		{
			if(countdeath)
			{
				dokillcam = 0;
				wassuicide = 1;
				awardassists = self suicide(einflictor, attacker, smeansofdeath, weapon, shitloc);
				if(assistedsuicide == 1)
				{
					self function_284c61bd(attacker, smeansofdeath);
				}
				if(level.friendlyfire == 4)
				{
					self team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
				}
			}
		}
		else
		{
			pixbeginevent(#"hash_3c7e54851be0668");
			lpattacknum = attacker getentitynumber();
			dokillcam = 1;
			if(var_8efc9727 && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0)
			{
			}
			else if(var_8efc9727)
			{
				wasteamkill = 1;
				self team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
			}
			else
			{
				function_ed2725ad(einflictor, attacker, weapon);
				if(bledout == 0 || level.var_7d1eeba9 === 1)
				{
					self kill(einflictor, attacker, smeansofdeath, weapon, shitloc);
					self function_284c61bd(attacker, smeansofdeath, bledout);
				}
				if(bledout == 0 || level.var_81ca6158 === 1)
				{
					if(level.teambased)
					{
						awardassists = 1;
					}
				}
			}
			if(smeansofdeath == "MOD_HEAD_SHOT" || (smeansofdeath == "MOD_IMPACT" && shitloc == "head") && !wasteamkill && !isdefined(killstreaks::get_killstreak_for_weapon(weapon)))
			{
				scoreevents::processscoreevent(#"headshot", attacker, self, weapon);
				attacker contracts::player_contract_event(#"headshot");
			}
			pixendevent();
		}
	}
	else if(isdefined(attacker) && (attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn"))
	{
		dokillcam = 0;
		lpattacknum = -1;
		var_c8fa9c41 = 0;
		lpattackguid = "";
		lpattackname = "";
		lpattackteam = "world";
		scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
		self globallogic_score::incpersstat(#"suicides", 1);
		self.suicides = self globallogic_score::getpersstat(#"suicides");
		self.suicide = 1;
		thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
		awardassists = 1;
		self function_284c61bd(undefined, smeansofdeath);
		if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides)
		{
			self notify(#"teamkillkicked");
			self function_3c238bc5();
		}
	}
	else
	{
		dokillcam = 0;
		lpattacknum = -1;
		var_c8fa9c41 = 0;
		lpattackguid = "";
		lpattackname = "";
		lpattackteam = "world";
		wassuicide = 1;
		if(isdefined(einflictor) && isdefined(einflictor.killcament))
		{
			dokillcam = 1;
			lpattacknum = self getentitynumber();
			wassuicide = 0;
		}
		if(isdefined(attacker) && isdefined(attacker.team) && isdefined(level.teams[attacker.team]))
		{
			if(self util::isenemyteam(attacker.team))
			{
				if(level.teambased)
				{
					if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
					{
						globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
					}
				}
				wassuicide = 0;
			}
		}
		awardassists = 1;
		self function_284c61bd(undefined, smeansofdeath);
	}
	if(isplayer(attacker) && isdefined(attacker.pers))
	{
		if(attacker.pers[#"hash_49e7469988944ecf"] === 1)
		{
			if(weapon.statindex == level.var_bb448b5f.statindex)
			{
				scoreevents::processscoreevent(#"hash_39926f44fa76b382", attacker, self, weapon);
				attacker.pers[#"hash_49e7469988944ecf"] = undefined;
			}
		}
	}
	if(!level.ingraceperiod && enteredresurrect == 0)
	{
		if(smeansofdeath != "MOD_FALLING")
		{
			if(weapon.name != "incendiary_fire")
			{
				self weapons::drop_scavenger_for_death(attacker);
			}
		}
		if(should_drop_weapon_on_death(wasteamkill, wassuicide, weapon_at_time_of_death, smeansofdeath))
		{
			self weapons::drop_for_death(attacker, weapon, smeansofdeath, 0);
		}
	}
	if(awardassists)
	{
		self function_48a1200f(einflictor, attacker, weapon, lpattackteam);
	}
	pixbeginevent(#"hash_6f37a114f9261138");
	self.lastattacker = attacker;
	self.lastdeathpos = self.origin;
	if(isdefined(attacker) && isplayer(attacker) && !var_41c4d474 && !var_8efc9727)
	{
		attacker notify(#"killed_enemy_player", {#time:gettime(), #weapon:weapon, #victim:self});
		self thread challenges::playerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, shitloc, attackerstance, bledout);
	}
	else
	{
		self notify(#"playerkilledchallengesprocessed");
	}
	killerheropoweractive = 0;
	killer = undefined;
	killerloadoutindex = -1;
	killerwasads = 0;
	killerinvictimfov = 0;
	victiminkillerfov = 0;
	var_76d450bd = function_b14806c6(self player_role::get(), currentsessionmode());
	if(isplayer(attacker))
	{
		var_a48b1a67 = function_b14806c6(attacker player_role::get(), currentsessionmode());
		attacker.lastkilltime = gettime();
		killer = attacker;
		killerloadoutindex = attacker.class_num;
		killerwasads = attacker playerads() >= 1;
		killerinvictimfov = util::within_fov(self.origin, self.angles, attacker.origin, self.fovcosine);
		victiminkillerfov = util::within_fov(attacker.origin, attacker.angles, self.origin, attacker.fovcosine);
		if(attacker ability_player::is_using_any_gadget())
		{
			killerheropoweractive = 1;
		}
		var_c144d535 = (isdefined(self.currentweapon) ? self.currentweapon.name : "");
		if(killstreaks::is_killstreak_weapon(weapon))
		{
			killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
			bb::function_c3b9e07f(attacker, lpattackorigin, var_a48b1a67, weapon.name, self, self.origin, var_76d450bd, var_c144d535, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, killstreak);
		}
		else
		{
			bb::function_c3b9e07f(attacker, lpattackorigin, var_a48b1a67, weapon.name, self, self.origin, var_76d450bd, var_c144d535, idamage, smeansofdeath, shitloc, 1, killerheropoweractive, undefined);
		}
	}
	else
	{
		bb::function_c3b9e07f(undefined, undefined, undefined, weapon.name, self, self.origin, var_76d450bd, undefined, idamage, smeansofdeath, shitloc, 1, 0, undefined);
	}
	victimweapon = undefined;
	victimweaponpickedup = 0;
	victimkillstreakweaponindex = 0;
	var_8926cc9f = 0;
	if(isdefined(weapon_at_time_of_death))
	{
		victimweapon = weapon_at_time_of_death;
		if(isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victimweapon]))
		{
			victimweaponpickedup = 1;
		}
		if(killstreaks::is_killstreak_weapon(victimweapon))
		{
			killstreak = killstreaks::get_killstreak_for_weapon_for_stats(victimweapon);
			if(isdefined(level.killstreaks[killstreak].menuname))
			{
				var_8926cc9f = 1;
				victimkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
				if(!isdefined(victimkillstreakweaponindex))
				{
					var_8926cc9f = 0;
					victimkillstreakweaponindex = 0;
				}
			}
		}
	}
	victimwasads = self playerads() >= 1;
	victimheropoweractive = self ability_player::is_using_any_gadget();
	killerweaponpickedup = 0;
	killerkillstreakweaponindex = 0;
	var_28af8061 = 0;
	if(isdefined(weapon))
	{
		if(isdefined(killer) && isdefined(killer.pickedupweapons) && isdefined(killer.pickedupweapons[weapon]))
		{
			killerweaponpickedup = 1;
		}
		if(killstreaks::is_killstreak_weapon(weapon))
		{
			killstreak = killstreaks::get_killstreak_for_weapon_for_stats(weapon);
			if(isdefined(level.killstreaks[killstreak].menuname))
			{
				var_28af8061 = 1;
				killerkillstreakweaponindex = level.killstreakindices[level.killstreaks[killstreak].menuname];
				if(!isdefined(killerkillstreakweaponindex))
				{
					var_28af8061 = 0;
					killerkillstreakweaponindex = 0;
				}
			}
		}
	}
	var_989983f4 = spawnstruct();
	var_989983f4.var_b4b63e47 = self.class_num;
	var_989983f4.victimweaponpickedup = victimweaponpickedup;
	var_989983f4.victimwasads = victimwasads;
	var_989983f4.killerloadoutindex = killerloadoutindex;
	var_989983f4.killerweaponpickedup = killerweaponpickedup;
	var_989983f4.killerwasads = killerwasads;
	var_989983f4.victimheropoweractive = victimheropoweractive;
	var_989983f4.killerheropoweractive = killerheropoweractive;
	var_989983f4.victiminkillerfov = victiminkillerfov;
	var_989983f4.killerinvictimfov = killerinvictimfov;
	var_989983f4.killerkillstreakweaponindex = killerkillstreakweaponindex;
	var_989983f4.victimkillstreakweaponindex = victimkillstreakweaponindex;
	var_989983f4.var_28af8061 = var_28af8061;
	var_989983f4.var_8926cc9f = var_8926cc9f;
	matchrecordlogadditionaldeathinfo(self, killer, victimweapon, weapon, var_989983f4);
	self namespace_42fe87d::record_special_move_data_for_life(killer);
	self.pickedupweapons = [];
	self.switching_teams = undefined;
	self.joining_team = undefined;
	self.leaving_team = undefined;
	attackerstring = "none";
	if(isplayer(attacker))
	{
		attackerstring = attacker getxuid() + "(" + lpattackname + ")";
	}
	/#
		print("" + smeansofdeath + "" + weapon.name + "" + attackerstring + "" + idamage + "" + shitloc + "" + int(self.origin[0]) + "" + int(self.origin[1]) + "" + int(self.origin[2]));
	#/
	level thread globallogic::updateteamstatus();
	level thread globallogic::updatealivetimes(self.team);
	self thread function_395ef176();
	if(isdefined(self.killcam_entity_info_cached))
	{
		killcam_entity_info = self.killcam_entity_info_cached;
		self.killcam_entity_info_cached = undefined;
	}
	else
	{
		killcam_entity_info = killcam::get_killcam_entity_info(attacker, einflictor, weapon);
	}
	if(isdefined(self.killstreak_delay_killcam))
	{
		dokillcam = 0;
	}
	self weapons::detach_carry_object_model();
	pixendevent();
	pixbeginevent(#"hash_6a07afbdee38d766");
	vattackerorigin = undefined;
	if(isdefined(attacker))
	{
		vattackerorigin = attacker.origin;
	}
	if(enteredresurrect == 0)
	{
		clone_weapon = weapon;
		if(weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee")
		{
			clone_weapon = level.weaponnone;
		}
		body = self cloneplayer(deathanimduration, clone_weapon, attacker, vdir);
		if(isdefined(body) && !level.inprematchperiod)
		{
			self function_10f480f(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body);
			self battlechatter::play_death_vox(body, attacker, weapon, smeansofdeath);
			if(isdefined(var_a1d415ee))
			{
				globallogic::doweaponspecificcorpseeffects(body, var_a1d415ee.einflictor, var_a1d415ee.attacker, var_a1d415ee.idamage, var_a1d415ee.smeansofdeath, var_a1d415ee.sweapon, var_a1d415ee.vdir, var_a1d415ee.shitloc, psoffsettime);
			}
			else if(!isdefined(laststandparams) || (!(isdefined(laststandparams.bledout) && laststandparams.bledout)))
			{
				globallogic::doweaponspecificcorpseeffects(body, einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
			}
		}
	}
	pixendevent();
	if(enteredresurrect)
	{
		thread globallogic_spawn::spawnqueuedclient(self.team, attacker);
	}
	self function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
	self function_7622d447();
	self.laststandparams = undefined;
	self.var_a1d415ee = undefined;
	if(isdefined(self.attackers))
	{
		self.attackers = [];
	}
	self.wantsafespawn = 0;
	perks = [];
	killstreaks = globallogic::getkillstreaks(attacker);
	if(!isdefined(self.killstreak_delay_killcam))
	{
		self thread [[level.spawnplayerprediction]]();
	}
	profilelog_endtiming(7, "gs=" + game.state);
	self thread killcam::function_eb3deeec(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker);
	if(wasteamkill == 0 && assistedsuicide == 0 && smeansofdeath != "MOD_SUICIDE" && (!(!isdefined(attacker) || attacker.classname == "trigger_hurt_new" || attacker.classname == "worldspawn" || attacker == self || isdefined(attacker.disablefinalkillcam))))
	{
		level thread killcam::record_settings(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker);
		if(level.gametype === "bounty")
		{
			if(isdefined(var_a1f4d122))
			{
				level thread potm::function_5523a49a(#"hash_c0e3040ba19a2b8", lpattacknum, var_c8fa9c41, self, killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, var_a1f4d122, einflictor);
			}
		}
		else
		{
			level thread potm::function_5523a49a(#"kill", lpattacknum, var_c8fa9c41, self, killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, perks, killstreaks, attacker, einflictor);
		}
	}
	if(enteredresurrect)
	{
		return;
	}
	if(!self.var_4ef33446)
	{
		if(isdefined(self.var_342564dd) && self.var_342564dd && self == attacker)
		{
			waitframe(1);
		}
		else
		{
			wait(0.25);
		}
	}
	weaponclass = util::getweaponclass(weapon);
	if(isdefined(weaponclass) && weaponclass == #"weapon_sniper")
	{
		self thread battlechatter::killed_by_sniper(attacker);
	}
	else
	{
		self thread battlechatter::player_killed(attacker, killstreak, einflictor, weapon, smeansofdeath);
	}
	self.cancelkillcam = 0;
	if(isdefined(self.killstreak_delay_killcam))
	{
		dokillcam = 0;
	}
	if(!userspawnselection::isspawnselectenabled())
	{
		self thread killcam::cancel_on_use();
	}
	if(!self.var_4ef33446)
	{
		self watch_death(weapon, attacker, smeansofdeath, deathanimduration);
	}
	else
	{
		dokillcam = 0;
	}
	/#
		if(getdvarint(#"scr_forcekillcam", 0) != 0)
		{
			dokillcam = 1;
			if(lpattacknum < 0)
			{
				lpattacknum = self getentitynumber();
				var_c8fa9c41 = 0;
			}
		}
	#/
	if(self.currentspectatingclient != -1 && level.spectatetype == 4 && self.pers[#"team"] != #"spectator")
	{
		function_39a7df61(self);
	}
	keep_deathcam = 0;
	self.respawntimerstarttime = gettime();
	if(function_f99d2668())
	{
		self.var_686890d5 = undefined;
		if(!gamestate::is_game_over())
		{
			if(teams::is_all_dead(self.team))
			{
				self function_66cec679();
				if(!platoons::function_382a49e0())
				{
					self thread namespace_81c567a8::function_1caf5c87(self.team);
				}
			}
			else if(function_73da2f89())
			{
				if(self function_448f7ed2())
				{
					self thread namespace_81c567a8::function_b3964dc9();
				}
			}
			else
			{
				self thread namespace_81c567a8::function_9b2bd02c();
			}
		}
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		dokillcam = 0;
		livesleft = !(level.numlives && !self.pers[#"lives"]) && (!(level.numteamlives && !game.lives[self.team]));
		if(livesleft)
		{
			if(isdefined(level.var_f220c297) && level.var_f220c297)
			{
				self thread [[level.spawnspectator]](self.origin + vectorscale((0, 0, 1), 60), self.angles);
			}
			else
			{
				function_93115f65();
			}
		}
		else if(!(isdefined(self.var_686890d5) && self.var_686890d5))
		{
			self thread [[level.spawnspectator]](self.origin + vectorscale((0, 0, 1), 60), self.angles);
		}
		return;
	}
	if(game.state != "playing")
	{
		return;
	}
	if(isdefined(self.overrideplayerdeadstatus))
	{
		keep_deathcam = self [[self.overrideplayerdeadstatus]]();
	}
	if(!self.cancelkillcam && dokillcam && level.killcam && wasteamkill == 0)
	{
		self clientfield::set_player_uimodel("hudItems.killcamActive", 1);
		livesleft = !(level.numlives && !self.pers[#"lives"]) && (!(level.numteamlives && !game.lives[self.team]));
		timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
		willrespawnimmediately = livesleft && timeuntilspawn <= 0 && !level.playerqueuedrespawn && !userspawnselection::isspawnselectenabled();
		self killcam::killcam(lpattacknum, self getentitynumber(), killcam_entity_info, weapon, smeansofdeath, self.deathtime, deathtimeoffset, psoffsettime, willrespawnimmediately, globallogic_utils::timeuntilroundend(), perks, killstreaks, attacker, keep_deathcam);
		if(function_f99d2668())
		{
			self luinotifyevent(#"hash_5b2d65a026de792d", 0);
		}
	}
	else if(self.cancelkillcam)
	{
		if(isdefined(self.killcamsskipped))
		{
			self.killcamsskipped++;
		}
		else
		{
			self.killcamsskipped = 1;
		}
	}
	self clientfield::set_player_uimodel("hudItems.killcamActive", 0);
	self function_7b0f4389();
	if(self.var_4ef33446)
	{
		waitframe(1);
	}
	secondary_deathcam = 0;
	timeuntilspawn = globallogic_spawn::timeuntilspawn(1);
	shoulddoseconddeathcam = timeuntilspawn > 0;
	if(shoulddoseconddeathcam && isdefined(self.secondarydeathcamtime))
	{
		secondary_deathcam = self [[self.secondarydeathcamtime]]();
	}
	if(secondary_deathcam > 0 && !self.cancelkillcam)
	{
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		globallogic_utils::waitfortimeornotify(secondary_deathcam, "end_death_delay");
		self notify(#"death_delay_finished");
	}
	if(!self.cancelkillcam && dokillcam && level.killcam && keep_deathcam)
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
	}
	function_93115f65();
}

/*
	Name: function_d5c8119d
	Namespace: player
	Checksum: 0xF2A9B079
	Offset: 0x41A0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_d5c8119d()
{
	var_8e3c3c5b = level.var_fb91af8.size - 1;
	if(var_8e3c3c5b < 0)
	{
		return 0;
	}
	if(level.var_52b56362 === var_8e3c3c5b)
	{
		return isdefined(level.deathcircle.scaling) && level.deathcircle.scaling || level.deathcircle.radius <= 0;
	}
	return 0;
}

/*
	Name: function_9956f107
	Namespace: player
	Checksum: 0x5B309CBA
	Offset: 0x4238
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function function_9956f107()
{
	if(isdefined(level.deathcircle) && !isdefined(level.deathcircle.var_7aec140c))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_73da2f89
	Namespace: player
	Checksum: 0x6187F074
	Offset: 0x4278
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_73da2f89()
{
	if(game.state != "pregame" && game.state != "playing")
	{
		return 0;
	}
	if(!infection::function_74650d7())
	{
		if(isdefined(level.var_f220c297) && level.var_f220c297)
		{
			if(function_d5c8119d())
			{
				return 0;
			}
			if(isdefined(level.var_78442886) && isdefined(level.var_245d4af9) && level.var_78442886 >= level.var_245d4af9)
			{
				return 0;
			}
		}
		if(isdefined(level.wave_spawn) && level.wave_spawn && function_9956f107())
		{
			return 0;
		}
	}
	return globallogic_spawn::function_38527849();
}

/*
	Name: function_93115f65
	Namespace: player
	Checksum: 0xE06FDBC3
	Offset: 0x4388
	Size: 0x15E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_93115f65()
{
	if(game.state != "playing")
	{
		self.sessionstate = "dead";
		self.spectatorclient = -1;
		self.killcamtargetentity = -1;
		self.killcamentity = -1;
		self.archivetime = 0;
		self.psoffsettime = 0;
		self.spectatekillcam = 0;
		return;
	}
	function_f9dc085a();
	userespawntime = 1;
	if(isdefined(level.hostmigrationtimer))
	{
		userespawntime = 0;
	}
	hostmigration::waittillhostmigrationcountdown();
	if(globallogic_utils::isvalidclass(self.curclass) || !loadout::function_87bcb1b())
	{
		timepassed = undefined;
		if(isdefined(self.respawntimerstarttime) && userespawntime)
		{
			timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
		}
		self thread [[level.spawnclient]](timepassed);
		self.respawntimerstarttime = undefined;
	}
}

/*
	Name: function_caabcf70
	Namespace: player
	Checksum: 0x8C0309B
	Offset: 0x44F0
	Size: 0x37C
	Parameters: 4
	Flags: Linked, Private
*/
private function function_caabcf70(victim, var_aedb48f4, laststandparams, var_a1d415ee)
{
	/#
		assert(isdefined(victim));
	#/
	/#
		assert(isdefined(var_aedb48f4));
	#/
	if(!isdefined(victim) || !isdefined(var_aedb48f4))
	{
		return;
	}
	var_f53d817d = (isdefined(laststandparams) ? laststandparams : var_aedb48f4);
	var_ee2f4691 = (isdefined(var_a1d415ee) ? var_a1d415ee : var_aedb48f4);
	function_ad11630f(victim, var_f53d817d.victimorigin, var_f53d817d.var_5fceefd4, var_f53d817d.victimweapon, var_f53d817d.attacker, var_f53d817d.attackerorigin, var_f53d817d.var_83634238, var_f53d817d.sweapon, var_f53d817d.var_10d87328, var_f53d817d.shitloc, var_f53d817d.smeansofdeath, var_ee2f4691.attacker, var_ee2f4691.attackerorigin, var_ee2f4691.var_83634238, var_ee2f4691.sweapon, var_ee2f4691.var_10d87328, var_ee2f4691.shitloc, var_ee2f4691.smeansofdeath);
	lifeindex = victim match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
	if(isdefined(lifeindex) && isdefined(victim) && isplayer(victim))
	{
		var_6c7269e = victim match_record::get_player_index();
		if(isdefined(var_6c7269e))
		{
			match_record::set_stat(#"lives", lifeindex, #"player_index", var_6c7269e);
		}
		if(isdefined(var_f53d817d) && isdefined(var_f53d817d.attacker) && isplayer(var_f53d817d.attacker))
		{
			var_7d5350e1 = var_f53d817d.attacker match_record::get_player_index();
			if(isdefined(var_7d5350e1))
			{
				match_record::set_stat(#"lives", lifeindex, #"hash_bc364c8d078a4b9", var_7d5350e1);
			}
		}
		if(isdefined(var_ee2f4691) && isdefined(var_ee2f4691.attacker) && isplayer(var_ee2f4691.attacker))
		{
			var_f913202b = var_ee2f4691.attacker match_record::get_player_index();
			if(isdefined(var_f913202b))
			{
				match_record::set_stat(#"lives", lifeindex, #"hash_6adf5918df7d307d", var_f913202b);
			}
		}
	}
}

/*
	Name: function_7b0f4389
	Namespace: player
	Checksum: 0x296E9F2F
	Offset: 0x4878
	Size: 0x18C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7b0f4389()
{
	self.var_eca4c67f = 0;
	if(userspawnselection::isspawnselectenabled() && (!(isdefined(self.switching_teams) && self.switching_teams)) && self globallogic_spawn::mayspawn())
	{
		while(!self function_d1be915f())
		{
			waitframe(1);
		}
		showmenu = self userspawnselection::shouldshowspawnselectionmenu();
		if(showmenu)
		{
			if(isdefined(self.predicted_spawn_point))
			{
				self setorigin(self.predicted_spawn_point.origin);
				self setplayerangles(self.predicted_spawn_point.angles);
			}
			specialistindex = self player_role::get();
			if(player_role::is_valid(specialistindex))
			{
				self.var_eca4c67f = 1;
				self userspawnselection::function_b55c5868();
				self userspawnselection::waitforspawnselection();
			}
		}
		else
		{
			self userspawnselection::activatespawnselectionmenu();
		}
	}
}

/*
	Name: function_d1be915f
	Namespace: player
	Checksum: 0x7008266D
	Offset: 0x4A10
	Size: 0x38
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1be915f()
{
	if(self isremotecontrolling())
	{
		return 0;
	}
	if(isdefined(self.killstreak_delay_killcam))
	{
		return 0;
	}
	return 1;
}

/*
	Name: watch_death
	Namespace: player
	Checksum: 0x764DE07F
	Offset: 0x4A50
	Size: 0x116
	Parameters: 4
	Flags: Linked, Private
*/
private function watch_death(weapon, attacker, smeansofdeath, deathanimduration)
{
	defaultplayerdeathwatchtime = 1.75;
	if(smeansofdeath == "MOD_MELEE_ASSASSINATE" || 0 > weapon.deathcamtime)
	{
		defaultplayerdeathwatchtime = deathanimduration * 0.001 + 0.5;
	}
	else if(0 < weapon.deathcamtime)
	{
		defaultplayerdeathwatchtime = weapon.deathcamtime;
	}
	if(isdefined(level.overrideplayerdeathwatchtimer))
	{
		defaultplayerdeathwatchtime = [[level.overrideplayerdeathwatchtimer]](defaultplayerdeathwatchtime);
	}
	if(!(isdefined(self.var_342564dd) && self.var_342564dd && self == attacker))
	{
		globallogic_utils::waitfortimeornotify(defaultplayerdeathwatchtime, "end_death_delay");
	}
	self notify(#"death_delay_finished");
}

/*
	Name: function_b029639e
	Namespace: player
	Checksum: 0xA4577044
	Offset: 0x4B70
	Size: 0x10E
	Parameters: 5
	Flags: Linked, Private
*/
private function function_b029639e(attacker, einflictor, weapon, smeansofdeath, shitloc)
{
	if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && isplayer(attacker) && !weapon_utils::ismeleemod(smeansofdeath))
	{
		return "MOD_HEAD_SHOT";
	}
	switch(weapon.name)
	{
		case "dog_bite":
		{
			smeansofdeath = "MOD_PISTOL_BULLET";
			break;
		}
		case "destructible_car":
		{
			smeansofdeath = "MOD_EXPLOSIVE";
			break;
		}
		case "explodable_barrel":
		{
			smeansofdeath = "MOD_EXPLOSIVE";
			break;
		}
	}
	return smeansofdeath;
}

/*
	Name: function_4e516ee6
	Namespace: player
	Checksum: 0x1B00543E
	Offset: 0x4C88
	Size: 0x434
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4e516ee6(attacker, weapon)
{
	if(!isdefined(self.switching_teams) && !self.var_4ef33446)
	{
		if(isplayer(attacker) && level.teambased && attacker != self && !self util::isenemyteam(attacker.team))
		{
			self.pers[#"cur_kill_streak"] = 0;
			self.pers[#"cur_total_kill_streak"] = 0;
			self.pers[#"totalkillstreakcount"] = 0;
			self.pers[#"killstreaksearnedthiskillstreak"] = 0;
			self setplayercurrentstreak(0);
		}
		else if(!(isdefined(self.var_cee93f5) && self.var_cee93f5))
		{
			self globallogic_score::incpersstat(#"deaths", 1, 1, 1);
		}
		self.deaths = self globallogic_score::getpersstat(#"deaths");
		self updatestatratio("kdratio", "kills", "deaths");
		if(self.pers[#"cur_kill_streak"] > self.pers[#"best_kill_streak"])
		{
			self.pers[#"best_kill_streak"] = self.pers[#"cur_kill_streak"];
		}
		self.pers[#"kill_streak_before_death"] = self.pers[#"cur_kill_streak"];
		if(isdefined(self.pers[#"hash_33112f192fb3c234"]) && isdefined(self.pers[#"hash_33112f192fb3c234"][#"current"]))
		{
			self.pers[#"hash_33112f192fb3c234"][#"current"][#"highestkillstreak"] = 0;
		}
		self.pers[#"cur_kill_streak"] = 0;
		self.pers[#"cur_total_kill_streak"] = 0;
		self.pers[#"totalkillstreakcount"] = 0;
		self.pers[#"killstreaksearnedthiskillstreak"] = 0;
		self setplayercurrentstreak(0);
		if(isdefined(self.cur_death_streak))
		{
			self.cur_death_streak++;
			if(self.cur_death_streak >= getdvarint(#"perk_deathstreakcountrequired", 0))
			{
				self enabledeathstreak();
			}
		}
	}
	else
	{
		self.pers[#"cur_kill_streak"] = 0;
		self.pers[#"cur_total_kill_streak"] = 0;
		self.pers[#"totalkillstreakcount"] = 0;
		self.pers[#"killstreaksearnedthiskillstreak"] = 0;
		self setplayercurrentstreak(0);
	}
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		level.globalkillstreaksdeathsfrom++;
	}
}

/*
	Name: function_abbc84ad
	Namespace: player
	Checksum: 0x7A33F08A
	Offset: 0x50C8
	Size: 0x3FC
	Parameters: 4
	Flags: Linked, Private
*/
private function function_abbc84ad(attacker, weapon, smeansofdeath, inflictor)
{
	if(isplayer(attacker) && attacker != self && (!level.teambased || self util::isenemyteam(attacker.team)))
	{
		attackerweaponpickedup = 0;
		if(isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[weapon]))
		{
			attackerweaponpickedup = 1;
		}
		self stats::function_eec52333(weapon, #"deaths", 1, self.class_num, attackerweaponpickedup);
		victim_weapon = self.lastdroppableweapon;
		if(isdefined(victim_weapon))
		{
			victimweaponpickedup = 0;
			if(isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[victim_weapon]))
			{
				victimweaponpickedup = 1;
			}
			self stats::function_eec52333(victim_weapon, #"deathsduringuse", 1, self.class_num, victimweaponpickedup);
		}
		recordweaponstatkills = 1;
		if(attacker.isthief === 1 && isdefined(weapon) && weapon.isheroweapon === 1)
		{
			recordweaponstatkills = 0;
		}
		if(smeansofdeath != "MOD_FALLING" && recordweaponstatkills)
		{
			if(weapon.name == #"explosive_bolt" && isdefined(inflictor) && isdefined(inflictor.ownerweaponatlaunch) && inflictor.owneradsatlaunch)
			{
				inflictorownerweaponatlaunchpickedup = 0;
				if(isdefined(attacker.pickedupweapons) && isdefined(attacker.pickedupweapons[inflictor.ownerweaponatlaunch]))
				{
					inflictorownerweaponatlaunchpickedup = 1;
				}
				attacker stats::function_eec52333(inflictor.ownerweaponatlaunch, #"kills", 1, attacker.class_num, inflictorownerweaponatlaunchpickedup, 1);
			}
			else
			{
				attacker stats::function_eec52333(weapon, #"kills", 1, attacker.class_num, attackerweaponpickedup);
			}
		}
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			attacker stats::function_eec52333(weapon, #"headshots", 1, attacker.class_num, attackerweaponpickedup);
		}
		if(smeansofdeath == "MOD_PROJECTILE")
		{
			attacker stats::function_e24eec31(weapon, #"direct_hit_kills", 1);
		}
		victimisroulette = self.isroulette === 1;
		if(self ability_player::gadget_checkheroabilitykill(attacker) && !victimisroulette)
		{
			attacker stats::function_e24eec31(attacker.heroability, #"kills_while_active", 1);
		}
	}
}

/*
	Name: function_a3030357
	Namespace: player
	Checksum: 0x150CA13A
	Offset: 0x54D0
	Size: 0x534
	Parameters: 5
	Flags: Linked
*/
function function_a3030357(attacker, einflictor, weapon, smeansofdeath, var_bee367e6 = undefined)
{
	if(function_f99d2668())
	{
		return;
	}
	if(smeansofdeath == "MOD_META")
	{
		return;
	}
	if(!isplayer(attacker) || self util::isenemyplayer(attacker) == 0 || (isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon)))
	{
		level notify(#"reset_obituary_count");
		level.lastobituaryplayercount = 0;
		level.lastobituaryplayer = undefined;
	}
	else if(isdefined(level.lastobituaryplayer) && level.lastobituaryplayer == attacker)
	{
		level.lastobituaryplayercount++;
	}
	else
	{
		level notify(#"reset_obituary_count");
		level.lastobituaryplayer = attacker;
		level.lastobituaryplayercount = 1;
	}
	level thread scoreevents::decrementlastobituaryplayercountafterfade();
	if(level.lastobituaryplayercount >= 4)
	{
		level notify(#"reset_obituary_count");
		level.lastobituaryplayercount = 0;
		level.lastobituaryplayer = undefined;
		self thread scoreevents::uninterruptedobitfeedkills(attacker, weapon);
	}
	overrideentitycamera = function_c0f28ff9(attacker, weapon);
	var_50d1e41a = potm::function_775b9ad1(weapon, smeansofdeath);
	var_e9d49a33 = 0;
	if(isdefined(weapon) && killstreaks::is_killstreak_weapon(weapon))
	{
		var_e9d49a33 = 1;
	}
	if(isdefined(einflictor) && (isdefined(einflictor.var_e9d49a33) && einflictor.var_e9d49a33 || (isdefined(einflictor.owner) && (isdefined(einflictor.owner.var_e9d49a33) && einflictor.owner.var_e9d49a33))))
	{
		var_e9d49a33 = 1;
	}
	var_f87dccb5 = self util::isenemyteam(attacker.team);
	if(self != attacker && !var_f87dccb5)
	{
		var_e9d49a33 = 1;
	}
	if(isdefined(einflictor) && einflictor.archetype === "robot")
	{
		if(smeansofdeath == "MOD_HIT_BY_OBJECT")
		{
			weapon = getweapon(#"combat_robot_marker");
		}
		smeansofdeath = "MOD_RIFLE_BULLET";
	}
	if(level.teambased && isdefined(attacker.pers) && !var_f87dccb5 && smeansofdeath == "MOD_GRENADE" && level.friendlyfire == 0)
	{
		obituary(self, self, weapon, smeansofdeath);
		demo::function_ae3420ca(self, self, einflictor, var_50d1e41a, overrideentitycamera);
		if(!var_e9d49a33)
		{
			if(level.gametype === "bounty")
			{
				potm::function_66d09fea(#"hash_c0e3040ba19a2b8", self, self, einflictor, var_50d1e41a, overrideentitycamera);
			}
			else
			{
				potm::function_ae3420ca(self, self, einflictor, var_50d1e41a, overrideentitycamera);
			}
		}
	}
	else
	{
		obituary(self, attacker, weapon, smeansofdeath);
		demo::function_ae3420ca(attacker, self, einflictor, var_50d1e41a, overrideentitycamera);
		if(!var_e9d49a33)
		{
			if(level.gametype === "bounty")
			{
				if(isdefined(var_bee367e6))
				{
					potm::function_66d09fea(#"hash_c0e3040ba19a2b8", var_bee367e6, self, einflictor, var_50d1e41a, overrideentitycamera);
				}
			}
			else
			{
				potm::function_ae3420ca(attacker, self, einflictor, var_50d1e41a, overrideentitycamera);
			}
		}
	}
}

/*
	Name: function_c0f28ff9
	Namespace: player
	Checksum: 0x18C8FB13
	Offset: 0x5A10
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function function_c0f28ff9(attacker, weapon)
{
	overrideentitycamera = 0;
	if(!isdefined(weapon))
	{
		return overrideentitycamera;
	}
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		overrideentitycamera = killstreaks::should_override_entity_camera_in_demo(attacker, weapon);
	}
	return overrideentitycamera;
}

/*
	Name: suicide
	Namespace: player
	Checksum: 0x3FB37E4B
	Offset: 0x5A80
	Size: 0x370
	Parameters: 5
	Flags: Linked, Private
*/
private function suicide(einflictor, attacker, smeansofdeath, weapon, shitloc)
{
	awardassists = 0;
	self.suicide = 0;
	if(isdefined(self.switching_teams))
	{
		if(!level.teambased && (isdefined(level.teams[self.leaving_team]) && isdefined(level.teams[self.joining_team]) && level.teams[self.leaving_team] != level.teams[self.joining_team]))
		{
			playercounts = self teams::count_players();
			playercounts[self.leaving_team]--;
			playercounts[self.joining_team]++;
			if(playercounts[self.joining_team] - playercounts[self.leaving_team] > 1)
			{
				scoreevents::processscoreevent(#"suicide", self, undefined, undefined);
				self globallogic_score::incpersstat(#"suicides", 1);
				self.suicides = self globallogic_score::getpersstat(#"suicides");
				self.suicide = 1;
			}
		}
	}
	else
	{
		scoreevents::processscoreevent(#"suicide", self);
		self globallogic_score::incpersstat(#"suicides", 1);
		self.suicides = self globallogic_score::getpersstat(#"suicides");
		if(smeansofdeath === "MOD_SUICIDE" && shitloc === "none" && (isdefined(self.throwinggrenade) && self.throwinggrenade))
		{
			self.lastgrenadesuicidetime = gettime();
		}
		if(level.maxsuicidesbeforekick > 0 && level.maxsuicidesbeforekick <= self.suicides)
		{
			self notify(#"teamkillkicked");
			self function_3c238bc5();
		}
		thread battlechatter::on_player_suicide_or_team_kill(self, "suicide");
		awardassists = 1;
		self.suicide = 1;
	}
	if(isdefined(self.friendlydamage))
	{
		self iprintln(#"hash_7d1a0e5bd191fce");
		if(level.teamkillpointloss)
		{
			scoresub = self [[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
			globallogic_score::function_17a678b7(attacker, scoresub);
		}
	}
	return awardassists;
}

/*
	Name: team_kill
	Namespace: player
	Checksum: 0x30AEF183
	Offset: 0x5DF8
	Size: 0x34C
	Parameters: 5
	Flags: Linked, Private
*/
private function team_kill(einflictor, attacker, smeansofdeath, weapon, shitloc)
{
	scoreevents::processscoreevent(#"team_kill", attacker, undefined, weapon);
	self.teamkilled = 1;
	if(!ignore_team_kills(weapon, smeansofdeath, einflictor))
	{
		teamkill_penalty = self [[level.getteamkillpenalty]](einflictor, attacker, smeansofdeath, weapon);
		attacker globallogic_score::incpersstat(#"teamkills_nostats", teamkill_penalty, 0);
		attacker globallogic_score::incpersstat(#"teamkills", 1);
		if(!isdefined(attacker.teamkillsthisround))
		{
			attacker.teamkillsthisround = 0;
		}
		attacker.teamkillsthisround++;
		if(level.friendlyfire == 4 && attacker.pers[#"teamkills_nostats"] == level.var_fe3ff9c1)
		{
			attacker.var_e03ca8a5 = 1;
		}
		if(level.teamkillpointloss)
		{
			scoresub = self [[level.getteamkillscore]](einflictor, attacker, smeansofdeath, weapon);
			globallogic_score::function_17a678b7(attacker, scoresub);
		}
		if(globallogic_utils::gettimepassed() < 5000)
		{
			var_821200bb = 1;
		}
		else if(attacker.pers[#"teamkills_nostats"] > 1 && globallogic_utils::gettimepassed() < int(8 + attacker.pers[#"teamkills_nostats"] * 1000))
		{
			var_821200bb = 1;
		}
		else
		{
			var_821200bb = attacker function_821200bb();
		}
		if(var_821200bb > 0)
		{
			attacker.teamkillpunish = 1;
			attacker thread wait_and_suicide();
			if(attacker function_78a6af2d(var_821200bb))
			{
				attacker notify(#"teamkillkicked");
				attacker thread function_dd602974();
			}
			attacker thread function_a932bf9c();
		}
		if(isplayer(attacker))
		{
			thread battlechatter::on_player_suicide_or_team_kill(attacker, "teamkill");
		}
	}
}

/*
	Name: wait_and_suicide
	Namespace: player
	Checksum: 0x1F444C1B
	Offset: 0x6150
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
private function wait_and_suicide()
{
	self endon(#"disconnect");
	self val::set(#"wait_and_suicide", "freezecontrols");
	wait(0.25);
	self val::reset(#"wait_and_suicide", "freezecontrols");
	self suicide();
}

/*
	Name: function_48a1200f
	Namespace: player
	Checksum: 0x727347F0
	Offset: 0x61E8
	Size: 0x2FC
	Parameters: 4
	Flags: Linked, Private
*/
private function function_48a1200f(einflictor, attacker, weapon, lpattackteam)
{
	pixbeginevent(#"hash_115d2072d5ab2061");
	if(isdefined(self.attackers))
	{
		for(j = 0; j < self.attackers.size; j++)
		{
			player = self.attackers[j];
			if(!isdefined(player))
			{
				continue;
			}
			if(player == attacker)
			{
				continue;
			}
			if(player util::isenemyteam(lpattackteam))
			{
				continue;
			}
			damage_done = self.attackerdamage[player.clientid].damage;
			if(sessionmodeismultiplayergame() && isdefined(player.currentweapon))
			{
				function_92d1707f(#"hash_d1357992f4715f0", {#hash_c47a74de:player.currentweapon.name, #hash_fc39645f:function_b14806c6(player player_role::get(), currentsessionmode()), #hash_a322a945:getplayerspawnid(player), #gametime:function_f8d53445()});
			}
			player thread globallogic_score::processassist(self, damage_done, self.attackerdamage[player.clientid].weapon, self.attackerdamage[player.clientid].time, self.attackerdamage[player.clientid].meansofdeath);
		}
	}
	if(level.teambased)
	{
		self globallogic_score::processkillstreakassists(attacker, einflictor, weapon);
	}
	if(isdefined(self.lastattackedshieldplayer) && isdefined(self.lastattackedshieldtime) && self.lastattackedshieldplayer != attacker)
	{
		if(gettime() - self.lastattackedshieldtime < 4000)
		{
			self.lastattackedshieldplayer thread globallogic_score::processshieldassist(self);
		}
	}
	pixendevent();
}

/*
	Name: function_f632c17e
	Namespace: player
	Checksum: 0xE0367CA8
	Offset: 0x64F0
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_f632c17e(weapon)
{
	if(isdefined(weapon) && isdefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](weapon))
	{
		return 1;
	}
	if(isdefined(weapon) && isdefined(weapon.statname) && isdefined(level.iskillstreakweapon) && [[level.iskillstreakweapon]](getweapon(weapon.statname)))
	{
		return 1;
	}
	switch(weapon.name)
	{
		case "hash_216eeca7a4295e4":
		case "hash_17df39d53492b0bf":
		case "tank_robot_launcher_turret":
		case "hash_721bd01efec90239":
		case "hash_7b24d0d0d2823bca":
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_4e3e8bee
	Namespace: player
	Checksum: 0x19E35472
	Offset: 0x6610
	Size: 0x414
	Parameters: 5
	Flags: Linked, Private
*/
private function function_4e3e8bee(einflictor, attacker, smeansofdeath, weapon, var_e7a369ea)
{
	attacker thread globallogic_score::givekillstats(smeansofdeath, weapon, self, var_e7a369ea);
	killstreak = killstreaks::get_killstreak_for_weapon(weapon);
	if(isdefined(killstreak))
	{
		if(scoreevents::isregisteredevent(killstreak))
		{
			scoreevents::processscoreevent(killstreak, attacker, self, weapon);
		}
		if(isdefined(einflictor))
		{
			bundle = einflictor killstreak_bundles::function_48e9536e();
			if(isdefined(bundle) && (isdefined(bundle.var_ad1e41b) && bundle.var_ad1e41b))
			{
				scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
			}
			if(killstreak == "dart" || killstreak == "inventory_dart")
			{
				einflictor notify(#"veh_collision");
				callback::callback(#"veh_collision", {#normal:(0, 0, 1)});
			}
		}
	}
	else if(!function_f632c17e(weapon))
	{
		if(var_e7a369ea == attacker)
		{
			if(isdefined(self.laststandparams))
			{
				if(isdefined(self.var_a1d415ee) && self.laststandparams.attacker !== self.var_a1d415ee.attacker)
				{
					scoreevents::processscoreevent(#"kill", self.laststandparams.attacker, self, self.laststandparams.sweapon);
					scoreevents::processscoreevent(#"hash_65fff1a096fb1d2d", self.var_a1d415ee.attacker, self, self.var_a1d415ee.sweapon);
				}
				else
				{
					scoreevents::processscoreevent(#"kill", attacker, self, weapon);
				}
			}
			else
			{
				scoreevents::processscoreevent(#"kill", attacker, self, weapon);
			}
		}
		scoreevents::processscoreevent(#"ekia", attacker, self, weapon);
		if(weapon_utils::ismeleemod(smeansofdeath))
		{
			scoreevents::processscoreevent(#"melee_kill", attacker, self, weapon);
		}
	}
	damage = self function_40c6c42d(attacker);
	function_f887b191(self, attacker, damage);
	attacker thread globallogic_score::trackattackerkill(self.name, self.pers[#"rank"], self.pers[#"rankxp"], self.pers[#"prestige"], self getxuid(), weapon);
	attacker thread globallogic_score::inckillstreaktracker(weapon);
}

/*
	Name: kill
	Namespace: player
	Checksum: 0xDCD291E7
	Offset: 0x6A30
	Size: 0x22C
	Parameters: 5
	Flags: Linked, Private
*/
private function kill(einflictor, attacker, smeansofdeath, weapon, shitloc)
{
	if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
	{
		globallogic_score::inctotalkills(attacker.team);
	}
	attackername = attacker.name;
	self thread globallogic_score::trackattackeedeath(attackername, attacker.pers[#"rank"], attacker.pers[#"rankxp"], attacker.pers[#"prestige"], attacker getxuid());
	self thread medals::setlastkilledby(attacker, einflictor);
	if(level.teambased && attacker.team != #"spectator")
	{
		killstreak = killstreaks::get_killstreak_for_weapon(weapon);
		if(!isdefined(killstreak) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
		{
			globallogic_score::giveteamscore("kill", attacker.team, attacker, self);
		}
	}
	scoresub = level.deathpointloss;
	if(scoresub != 0)
	{
		globallogic_score::function_17a678b7(self, scoresub);
	}
	level thread function_e8decd0b(attacker, weapon, self, einflictor, smeansofdeath);
}

/*
	Name: should_allow_postgame_death
	Namespace: player
	Checksum: 0xB4B6EDC0
	Offset: 0x6C68
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function should_allow_postgame_death(smeansofdeath)
{
	if(smeansofdeath == "MOD_POST_GAME")
	{
		return 1;
	}
	return 0;
}

/*
	Name: post_game_death
	Namespace: player
	Checksum: 0x13DCC419
	Offset: 0x6C98
	Size: 0x17C
	Parameters: 9
	Flags: Linked, Private
*/
private function post_game_death(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(!should_allow_postgame_death(smeansofdeath))
	{
		return;
	}
	self weapons::detach_carry_object_model();
	self.sessionstate = "dead";
	self.spectatorclient = -1;
	self.killcamentity = -1;
	self.archivetime = 0;
	self.psoffsettime = 0;
	clone_weapon = weapon;
	if(weapon_utils::ismeleemod(smeansofdeath) && clone_weapon.type != "melee")
	{
		clone_weapon = level.weaponnone;
	}
	body = self cloneplayer(deathanimduration, clone_weapon, attacker, vdir);
	if(isdefined(body))
	{
		self function_10f480f(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, (0, 0, 0), deathanimduration, einflictor, body);
	}
}

/*
	Name: function_395ef176
	Namespace: player
	Checksum: 0xC974D5BC
	Offset: 0x6E20
	Size: 0x6A0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_395ef176()
{
	self endon(#"disconnect");
	var_8f42b3ff = (isdefined(level.var_8a400007) ? level.var_8a400007 : 10);
	var_65671d4a = level.numteamlives - var_8f42b3ff;
	if(isdefined(level.teambased) && level.teambased && (isdefined(level.takelivesondeath) && level.takelivesondeath) && level.numteamlives > 0)
	{
		enemy_team = util::getotherteam(self.team);
		teamarray = getplayers(self.team);
		if(game.lives[self.team] == 0 && !level.var_61952d8b[self.team])
		{
			level.var_61952d8b[self.team] = 1;
			level.var_a236b703[self.team] = 1;
			thread globallogic_audio::leader_dialog("controlNoLives", self.team);
			thread globallogic_audio::leader_dialog("controlNoLivesEnemy", enemy_team);
			clientfield::set_world_uimodel("hudItems.team" + level.teamindex[self.team] + ".noRespawnsLeft", 1);
			game.lives[self.team] = 0;
			level.var_9161927e[self.team] = teamarray.size;
			teammates = util::get_active_players(self.team);
			foreach(player in teammates)
			{
				player luinotifyevent(#"hash_6b67aa04e378d681", 1, 7);
			}
			util::function_5a68c330(24, self.team);
		}
		if(level.deaths[self.team] >= var_65671d4a && !level.var_a236b703[self.team])
		{
			level.var_a236b703[self.team] = 1;
			thread globallogic_audio::leader_dialog("controlLowLives", self.team);
			thread globallogic_audio::leader_dialog("controlLowLivesEnemy", enemy_team);
		}
		if(isdefined(level.var_9161927e) && isdefined(level.var_9161927e[self.team]))
		{
			if(level.var_9161927e[self.team] > 0)
			{
				teammates = util::get_active_players(self.team);
				foreach(player in teammates)
				{
					player luinotifyevent(#"hash_6b67aa04e378d681", 2, 1, level.var_9161927e[self.team]);
				}
			}
			if(level.var_9161927e[self.team] == 1)
			{
				thread globallogic_audio::leader_dialog("roundEncourageLastPlayer", self.team);
				thread globallogic_audio::leader_dialog("roundEncourageLastPlayerEnemy", enemy_team);
			}
			level.var_9161927e[self.team]--;
		}
		function_c49fc862(self.team);
	}
	else
	{
		clientfield::set_player_uimodel("hudItems.playerLivesCount", level.numlives - self.var_a7d7e50a);
		if(isdefined(level.var_4348a050) && level.var_4348a050)
		{
			var_e6caaa48 = level.playerlives[#"allies"];
			var_5724b72f = level.playerlives[#"axis"];
			if(level.gametype == "sd" && userspawnselection::function_127864f2(self))
			{
				return;
			}
			if(self.team == #"allies")
			{
				var_e6caaa48 = var_e6caaa48 - 1;
			}
			else if(self.team == #"axis")
			{
				var_5724b72f = var_5724b72f - 1;
			}
			if(var_e6caaa48 > 0 && var_5724b72f > 0)
			{
				foreach(player in level.activeplayers)
				{
					if(!isdefined(player))
					{
						continue;
					}
					player luinotifyevent(#"hash_6b67aa04e378d681", 3, 2, var_e6caaa48, var_5724b72f);
				}
			}
		}
	}
}

/*
	Name: function_5c5a8dad
	Namespace: player
	Checksum: 0x2ECC580C
	Offset: 0x74C8
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5c5a8dad(lives)
{
	if(lives == 0)
	{
		level notify(#"player_eliminated");
		self notify(#"player_eliminated");
	}
}

/*
	Name: start_generator_captureshouldshowpain
	Namespace: player
	Checksum: 0x72774792
	Offset: 0x7518
	Size: 0x254
	Parameters: 0
	Flags: Linked, Private
*/
private function start_generator_captureshouldshowpain()
{
	if(!(isdefined(level.takelivesondeath) && level.takelivesondeath))
	{
		self function_5c5a8dad(self.pers[#"lives"]);
		return;
	}
	if(isdefined(self.var_cee93f5) && self.var_cee93f5)
	{
		return;
	}
	if(game.lives[self.team] > 0)
	{
		if(isdefined(level.competitiveteamlives) && level.competitiveteamlives)
		{
		}
		else if(self.attackers.size < 1)
		{
			return;
		}
		foreach(attacker in self.attackers)
		{
			if(!isdefined(attacker))
			{
				continue;
			}
			if(attacker.team != self.team)
			{
				removelives = 1;
				break;
			}
		}
		if(!(isdefined(removelives) && removelives))
		{
			return;
		}
		game.lives[self.team]--;
		if(self.pers[#"lives"] == 0)
		{
			self function_5c5a8dad(game.lives[self.team]);
		}
	}
	else if(self.pers[#"lives"])
	{
		self.pers[#"lives"]--;
		level callback::callback(#"hash_e702d557e24bb6", {#player:self});
		self function_5c5a8dad(self.pers[#"lives"]);
	}
}

/*
	Name: function_10f480f
	Namespace: player
	Checksum: 0x46FF87CD
	Offset: 0x7778
	Size: 0x37C
	Parameters: 10
	Flags: Linked, Private
*/
private function function_10f480f(attacker, idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, body)
{
	if(smeansofdeath == "MOD_HIT_BY_OBJECT" && self getstance() == "prone")
	{
		self.body = body;
		if(!isdefined(self.switching_teams))
		{
			thread deathicons::add(body, self, self.team);
		}
		return;
	}
	if(isdefined(level.ragdoll_override) && self [[level.ragdoll_override]](idamage, smeansofdeath, weapon, shitloc, vdir, vattackerorigin, deathanimduration, einflictor, 0, body))
	{
		return;
	}
	if(self isonladder() || self ismantling() || smeansofdeath == "MOD_CRUSH" || smeansofdeath == "MOD_HIT_BY_OBJECT")
	{
		body startragdoll();
	}
	if(!self isonground() && smeansofdeath != "MOD_FALLING")
	{
		if(getdvarint(#"scr_disable_air_death_ragdoll", 0) == 0)
		{
			body startragdoll();
		}
	}
	if(smeansofdeath == "MOD_MELEE_ASSASSINATE" && !attacker isonground())
	{
		body start_death_from_above_ragdoll(vdir);
	}
	if(self is_explosive_ragdoll(weapon, einflictor))
	{
		body start_explosive_ragdoll(vdir, weapon);
	}
	thread delayed_ragdoll(body, shitloc, vdir, weapon, einflictor, smeansofdeath);
	if(smeansofdeath == "MOD_CRUSH")
	{
		body globallogic_vehicle::vehiclecrush(attacker, einflictor);
	}
	self.body = body;
	if(!isdefined(self.switching_teams))
	{
		thread deathicons::add(body, self, self.team);
	}
	params = spawnstruct();
	params.smeansofdeath = smeansofdeath;
	params.weapon = weapon;
	body.player = self;
	body.iscorpse = 1;
	self.body callback::callback(#"on_player_corpse");
}

/*
	Name: should_drop_weapon_on_death
	Namespace: player
	Checksum: 0x84B61DAF
	Offset: 0x7B00
	Size: 0xA4
	Parameters: 4
	Flags: Linked, Private
*/
private function should_drop_weapon_on_death(wasteamkill, wassuicide, current_weapon, smeansofdeath)
{
	if(wasteamkill)
	{
		return 0;
	}
	if(wassuicide)
	{
		return 0;
	}
	if(smeansofdeath == "MOD_TRIGGER_HURT" && !self isonground())
	{
		return 0;
	}
	if(isdefined(current_weapon) && current_weapon.isheavyweapon)
	{
		return 0;
	}
	if(smeansofdeath == "MOD_META")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8826f676
	Namespace: player
	Checksum: 0x88BF4045
	Offset: 0x7BB0
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8826f676()
{
	if(isbot(self))
	{
		level.globallarryskilled++;
	}
}

/*
	Name: function_f9dc085a
	Namespace: player
	Checksum: 0xF692912F
	Offset: 0x7BE8
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f9dc085a()
{
	if(isdefined(self.killstreak_delay_killcam))
	{
		while(isdefined(self.killstreak_delay_killcam))
		{
			wait(0.1);
		}
		wait(2);
		self killstreaks::reset_killstreak_delay_killcam();
	}
}

/*
	Name: function_3c238bc5
	Namespace: player
	Checksum: 0x2EABEDF9
	Offset: 0x7C38
	Size: 0x94
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3c238bc5()
{
	self globallogic_score::incpersstat(#"sessionbans", 1);
	self endon(#"disconnect");
	waittillframeend();
	globallogic::gamehistoryplayerkicked();
	ban(self getentitynumber());
	globallogic_audio::leader_dialog("gamePlayerKicked");
}

/*
	Name: function_dd602974
	Namespace: player
	Checksum: 0x1C6B2A15
	Offset: 0x7CD8
	Size: 0x1DC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dd602974()
{
	self globallogic_score::incpersstat(#"sessionbans", 1);
	self endon(#"disconnect");
	waittillframeend();
	playlistbanquantum = tweakables::gettweakablevalue("team", "teamkillerplaylistbanquantum");
	playlistbanpenalty = tweakables::gettweakablevalue("team", "teamkillerplaylistbanpenalty");
	if(playlistbanquantum > 0 && playlistbanpenalty > 0)
	{
		timeplayedtotal = self stats::function_441050ca(#"time_played_total");
		minutesplayed = timeplayedtotal / 60;
		freebees = 2;
		banallowance = int(floor(minutesplayed / playlistbanquantum)) + freebees;
		if(self.sessionbans > banallowance)
		{
			self stats::function_4db3fba1(#"gametypeban", timeplayedtotal + playlistbanpenalty * 60);
		}
	}
	globallogic::gamehistoryplayerkicked();
	ban(self getentitynumber(), "EXE/PLAYERKICK_TEAM_KILL");
	globallogic_audio::leader_dialog("gamePlayerKicked");
}

/*
	Name: function_821200bb
	Namespace: player
	Checksum: 0x9A5BAE7
	Offset: 0x7EC0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_821200bb()
{
	teamkills = self.pers[#"teamkills_nostats"];
	if(level.friendlyfire == 4)
	{
		if(teamkills < level.var_fe3ff9c1)
		{
			return 0;
		}
		exceeded = teamkills - level.var_fe3ff9c1 - 1;
		return level.var_ca1c5097 + level.var_2c3d094b * exceeded;
	}
	if(level.minimumallowedteamkills < 0 || teamkills <= level.minimumallowedteamkills)
	{
		return 0;
	}
	exceeded = teamkills - level.minimumallowedteamkills;
	return level.teamkillspawndelay * exceeded;
}

/*
	Name: function_78a6af2d
	Namespace: player
	Checksum: 0x5F53FD47
	Offset: 0x7FB0
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_78a6af2d(var_821200bb)
{
	if(isbot(self))
	{
		return 0;
	}
	if(level.friendlyfire == 4)
	{
		if(self.pers[#"teamkills_nostats"] >= level.var_fe3ff9c1 + level.var_3297fce5)
		{
			return 1;
		}
		return 0;
	}
	if(var_821200bb && level.minimumallowedteamkills >= 0)
	{
		if(globallogic_utils::gettimepassed() >= 5000)
		{
			return 1;
		}
		if(self.pers[#"teamkills_nostats"] > 1)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a932bf9c
	Namespace: player
	Checksum: 0x5E54853E
	Offset: 0x8098
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_a932bf9c()
{
	if(level.friendlyfire == 4)
	{
		return;
	}
	timeperoneteamkillreduction = 20;
	reductionpersecond = 1 / timeperoneteamkillreduction;
	while(true)
	{
		if(isalive(self))
		{
			self.pers[#"teamkills_nostats"] = self.pers[#"teamkills_nostats"] - reductionpersecond;
			if(self.pers[#"teamkills_nostats"] < level.minimumallowedteamkills)
			{
				self.pers[#"teamkills_nostats"] = level.minimumallowedteamkills;
				break;
			}
		}
		wait(1);
	}
}

/*
	Name: ignore_team_kills
	Namespace: player
	Checksum: 0x26DBF4FA
	Offset: 0x8198
	Size: 0x10E
	Parameters: 3
	Flags: Linked, Private
*/
private function ignore_team_kills(weapon, smeansofdeath, einflictor)
{
	if(weapon_utils::ismeleemod(smeansofdeath))
	{
		return 0;
	}
	if(weapon.ignore_team_kills === 1 || weapon.ignoreteamkills === 1)
	{
		return 1;
	}
	if(isdefined(einflictor) && einflictor.ignore_team_kills === 1)
	{
		return 1;
	}
	if(isdefined(einflictor) && isdefined(einflictor.destroyedby) && isdefined(einflictor.owner) && einflictor.destroyedby != einflictor.owner)
	{
		return 1;
	}
	if(isdefined(einflictor) && einflictor.classname == "worldspawn")
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_explosive_ragdoll
	Namespace: player
	Checksum: 0x8248D7EF
	Offset: 0x82B0
	Size: 0xB6
	Parameters: 2
	Flags: Linked, Private
*/
private function is_explosive_ragdoll(weapon, inflictor)
{
	if(!isdefined(weapon))
	{
		return 0;
	}
	if(weapon.name == #"destructible_car" || weapon.name == #"explodable_barrel")
	{
		return 1;
	}
	if(weapon.projexplosiontype == "grenade")
	{
		if(isdefined(inflictor) && isdefined(inflictor.stucktoplayer))
		{
			if(inflictor.stucktoplayer == self)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: start_explosive_ragdoll
	Namespace: player
	Checksum: 0x67831412
	Offset: 0x8370
	Size: 0x1B4
	Parameters: 2
	Flags: Linked, Private
*/
private function start_explosive_ragdoll(dir, weapon)
{
	if(!isdefined(self))
	{
		return;
	}
	x = randomintrange(50, 100);
	y = randomintrange(50, 100);
	z = randomintrange(10, 20);
	if(isdefined(weapon) && (weapon.name == #"sticky_grenade" || weapon.name == #"explosive_bolt"))
	{
		if(isdefined(dir) && lengthsquared(dir) > 0)
		{
			x = dir[0] * x;
			y = dir[1] * y;
		}
	}
	else if(math::cointoss())
	{
		x = x * -1;
	}
	if(math::cointoss())
	{
		y = y * -1;
	}
	self startragdoll();
	self launchragdoll((x, y, z));
}

/*
	Name: start_death_from_above_ragdoll
	Namespace: player
	Checksum: 0xF46F37BA
	Offset: 0x8530
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function start_death_from_above_ragdoll(dir)
{
	if(!isdefined(self))
	{
		return;
	}
	self startragdoll();
	self launchragdoll(vectorscale((0, 0, -1), 100));
}

/*
	Name: delayed_ragdoll
	Namespace: player
	Checksum: 0x8F59E29D
	Offset: 0x8588
	Size: 0x17C
	Parameters: 6
	Flags: Linked, Private
*/
private function delayed_ragdoll(ent, shitloc, vdir, weapon, einflictor, smeansofdeath)
{
	if(isdefined(ent))
	{
		deathanim = ent getcorpseanim();
		if(animhasnotetrack(deathanim, "ignore_ragdoll"))
		{
			return;
		}
	}
	waittillframeend();
	if(!isdefined(ent))
	{
		return;
	}
	if(ent isragdoll())
	{
		return;
	}
	deathanim = ent getcorpseanim();
	startfrac = 0.35;
	if(animhasnotetrack(deathanim, "start_ragdoll"))
	{
		times = getnotetracktimes(deathanim, "start_ragdoll");
		if(isdefined(times))
		{
			startfrac = times[0];
		}
	}
	waittime = startfrac * getanimlength(deathanim);
	if(waittime > 0)
	{
		wait(waittime);
	}
	if(isdefined(ent))
	{
		ent startragdoll();
	}
}

/*
	Name: function_4ac2aefc
	Namespace: player
	Checksum: 0x58FEAECE
	Offset: 0x8710
	Size: 0x32C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4ac2aefc(attacker, weapon)
{
	if(isai(attacker) && isdefined(attacker.script_owner))
	{
		if(!level.teambased || self util::isenemyteam(attacker.script_owner.team))
		{
			attacker = attacker.script_owner;
		}
	}
	if(attacker.classname == "script_vehicle" && isdefined(attacker.owner))
	{
		attacker notify(#"killed", {#victim:self});
		attacker = attacker.owner;
	}
	if(isai(attacker))
	{
		attacker notify(#"killed", {#victim:self});
	}
	if(isdefined(self.capturinglastflag) && self.capturinglastflag == 1)
	{
		attacker.lastcapkiller = 1;
	}
	if(isdefined(attacker) && attacker != self && isdefined(weapon))
	{
		if(weapon.statname == #"planemortar")
		{
			if(!isdefined(attacker.planemortarbda))
			{
				attacker.planemortarbda = 0;
			}
			attacker.planemortarbda++;
		}
		else if(weapon.statname == #"dart" || weapon.statname == #"dart_turret")
		{
			if(!isdefined(attacker.dartbda))
			{
				attacker.dartbda = 0;
			}
			attacker.dartbda++;
		}
		else if(weapon.name == #"straferun_rockets" || weapon.name == #"straferun_gun")
		{
			if(isdefined(attacker.straferunbda))
			{
				attacker.straferunbda++;
			}
		}
		else if(weapon.statname == #"remote_missile" || weapon.statname == #"remote_missile_missile" || weapon.name == #"remote_missile_bomblet")
		{
			if(!isdefined(attacker.remotemissilebda))
			{
				attacker.remotemissilebda = 0;
			}
			attacker.remotemissilebda++;
		}
	}
	return attacker;
}

/*
	Name: function_91cd8b0d
	Namespace: player
	Checksum: 0x2BE8B65B
	Offset: 0x8A48
	Size: 0x78
	Parameters: 1
	Flags: Linked, Private
*/
private function function_91cd8b0d(einflictor)
{
	if(isdefined(einflictor) && einflictor.classname == "script_vehicle")
	{
		einflictor notify(#"killed", {#victim:self});
		if(isdefined(einflictor.bda))
		{
			einflictor.bda++;
		}
	}
	return einflictor;
}

/*
	Name: update_weapon
	Namespace: player
	Checksum: 0x5EB0479A
	Offset: 0x8AC8
	Size: 0xEA
	Parameters: 2
	Flags: Linked, Private
*/
private function update_weapon(einflictor, weapon)
{
	if(weapon == level.weaponnone && isdefined(einflictor))
	{
		if(isdefined(einflictor.targetname) && einflictor.targetname == "explodable_barrel")
		{
			weapon = getweapon(#"explodable_barrel");
		}
		else if(isdefined(einflictor.destructible_type) && issubstr(einflictor.destructible_type, "vehicle_"))
		{
			weapon = getweapon(#"destructible_car");
		}
	}
	return weapon;
}

/*
	Name: function_e8decd0b
	Namespace: player
	Checksum: 0xB8773F1E
	Offset: 0x8BC0
	Size: 0xF8
	Parameters: 5
	Flags: Linked, Private
*/
private function function_e8decd0b(attacker, weapon, victim, einflictor, smeansofdeath)
{
	if(isplayer(attacker))
	{
		if(!killstreaks::is_killstreak_weapon(weapon) || killstreaks::function_e3a30c69(weapon))
		{
			level thread battlechatter::say_kill_battle_chatter(attacker, weapon, victim, einflictor, smeansofdeath);
		}
	}
	if(isdefined(einflictor))
	{
		function_6eac4ca1(einflictor, "attack_kill");
		einflictor notify(#"bhtn_action_notify", {#action:"attack_kill"});
	}
}

/*
	Name: function_ed2725ad
	Namespace: player
	Checksum: 0x8F22541D
	Offset: 0x8CC0
	Size: 0x5DA
	Parameters: 3
	Flags: Linked
*/
function function_ed2725ad(einflictor, attacker, weapon)
{
	if(isalive(attacker))
	{
		pixbeginevent(#"killstreak");
		if(!isdefined(einflictor) || !isdefined(einflictor.requireddeathcount) || attacker.deathcount == einflictor.requireddeathcount)
		{
			shouldgivekillstreak = killstreaks::should_give_killstreak(weapon);
			if(shouldgivekillstreak)
			{
				attacker killstreaks::add_to_killstreak_count(weapon);
			}
			attacker.pers[#"cur_total_kill_streak"]++;
			attacker setplayercurrentstreak(attacker.pers[#"cur_total_kill_streak"]);
			if(isdefined(level.killstreaks) && shouldgivekillstreak)
			{
				attacker.pers[#"cur_kill_streak"]++;
				if(attacker.pers[#"cur_kill_streak"] >= 2)
				{
					if(attacker.pers[#"cur_kill_streak"] % 5 == 0)
					{
						attacker activecamo::function_896ac347(weapon, #"killstreak_5", 1);
						attacker contracts::function_a54e2068(#"hash_4c15367eed618401");
						attacker contracts::function_a54e2068(#"hash_3f1070327daed588");
					}
					if(attacker.pers[#"cur_kill_streak"] % 10 == 0)
					{
						attacker challenges::killstreakten();
						attacker contracts::function_a54e2068(#"hash_73a8663654fdba0b");
					}
					if(attacker.pers[#"cur_kill_streak"] <= 30)
					{
						scoreevents::processscoreevent(#"killstreak_" + attacker.pers[#"cur_kill_streak"], attacker, self, weapon);
						if(attacker.pers[#"cur_kill_streak"] == 30)
						{
							attacker challenges::killstreak_30_noscorestreaks();
						}
					}
					else
					{
						scoreevents::processscoreevent(#"killstreak_more_than_30", attacker, self, weapon);
					}
					if(isdefined(attacker.var_ea1458aa))
					{
						if(attacker.pers[#"cur_kill_streak"] >= 5 && attacker.pers[#"cur_kill_streak"] % 5 && attacker.pers[#"cur_kill_streak"] < 30 || attacker.pers[#"cur_kill_streak"] > 30)
						{
							if(!isdefined(attacker.var_ea1458aa.var_2bad4cbb))
							{
								attacker.var_ea1458aa.var_2bad4cbb = 0;
							}
							attacker.var_ea1458aa.var_2bad4cbb++;
							attacker challenges::function_a4db0a4c();
						}
					}
				}
				if(!isdefined(level.usingmomentum) || !level.usingmomentum)
				{
					attacker thread killstreaks::give_for_streak();
				}
			}
		}
		pixendevent();
	}
	if(isdefined(attacker.gametype_kill_streak) && attacker.pers[#"cur_kill_streak"] > attacker.gametype_kill_streak)
	{
		attacker stats::function_baa25a23(#"kill_streak", attacker.pers[#"cur_kill_streak"]);
		attacker.gametype_kill_streak = attacker.pers[#"cur_kill_streak"];
	}
	if(isdefined(attacker.var_b6f732c0) && attacker.pers[#"cur_kill_streak"] > attacker.var_b6f732c0)
	{
		attacker stats::function_4db3fba1(#"hash_5ef976b050e0aa48", attacker.pers[#"cur_kill_streak"]);
		attacker.var_b6f732c0 = attacker.pers[#"cur_kill_streak"];
	}
}

/*
	Name: function_ff3ec0d4
	Namespace: player
	Checksum: 0x848F9C6C
	Offset: 0x92A8
	Size: 0x132
	Parameters: 9
	Flags: Linked
*/
function function_ff3ec0d4(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	foreach(callback in level.var_da2045d0)
	{
		if(callback.threaded)
		{
			self thread [[callback.callback]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
			continue;
		}
		self [[callback.callback]](einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
	}
}

/*
	Name: function_b8871aa2
	Namespace: player
	Checksum: 0xE6F1D5F3
	Offset: 0x93E8
	Size: 0xE2
	Parameters: 4
	Flags: Linked
*/
function function_b8871aa2(einflictor, victim, idamage, weapon)
{
	foreach(callback in level.var_fa66fada)
	{
		if(callback.threaded)
		{
			self thread [[callback.callback]](einflictor, victim, idamage, weapon);
			continue;
		}
		self [[callback.callback]](einflictor, victim, idamage, weapon);
	}
}

