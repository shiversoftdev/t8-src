// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_2c49ae69cd8ce30c;
#using script_35598499769dbb3d;
#using script_41fe08c37d53a635;
#using script_5399f402045d7abd;
#using script_70a43d6ba27cff6a;
#using script_7bafaa95bb1b427e;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\challenges.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;

#namespace globallogic_actor;

/*
	Name: init
	Namespace: globallogic_actor
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init()
{
}

/*
	Name: callback_actorspawned
	Namespace: globallogic_actor
	Checksum: 0x3DE9FAEC
	Offset: 0x1B0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function callback_actorspawned(spawner)
{
	self thread spawner::spawn_think(spawner);
}

/*
	Name: callback_actordamage
	Namespace: globallogic_actor
	Checksum: 0x6BCFFA6C
	Offset: 0x1E0
	Size: 0xF3A
	Parameters: 15
	Flags: Linked
*/
function callback_actordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, modelindex, surfacetype, vsurfacenormal)
{
	if(gamestate::is_game_over())
	{
		return;
	}
	if(self.team == #"spectator")
	{
		return;
	}
	if(isdefined(eattacker) && isplayer(eattacker) && isdefined(eattacker.candocombat) && !eattacker.candocombat)
	{
		return;
	}
	self.idflags = idflags;
	self.idflagstime = gettime();
	eattacker = player::figure_out_attacker(eattacker);
	if(!isdefined(vdir))
	{
		idflags = idflags | 4;
	}
	friendly = 0;
	if(self.health == self.maxhealth || !isdefined(self.attackers))
	{
		self.attackers = [];
		self.attackerdata = [];
		self.attackerdamage = [];
		self.attackersthisspawn = [];
	}
	if(globallogic_utils::isheadshot(weapon, shitloc, smeansofdeath, einflictor) && !weapon_utils::ismeleemod(smeansofdeath))
	{
		smeansofdeath = "MOD_HEAD_SHOT";
	}
	if(level.onlyheadshots)
	{
		if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
		{
			return;
		}
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			idamage = 150;
		}
	}
	if(isdefined(self.overrideactordamage))
	{
		idamage = self [[self.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
	}
	else if(isdefined(level.overrideactordamage))
	{
		idamage = self [[level.overrideactordamage]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
	}
	friendlyfire = [[level.figure_out_friendly_fire]](self, eattacker);
	if(friendlyfire == 0 && self.archetype === "robot" && isdefined(eattacker) && !util::function_fbce7263(eattacker.team, self.team))
	{
		return;
	}
	if(isdefined(self.aioverridedamage))
	{
		for(index = 0; index < self.aioverridedamage.size; index++)
		{
			damagecallback = self.aioverridedamage[index];
			idamage = self [[damagecallback]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
		}
		if(idamage < 1)
		{
			return;
		}
		idamage = int(idamage + 0.5);
	}
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
	params = spawnstruct();
	params.einflictor = einflictor;
	params.eattacker = eattacker;
	params.idamage = idamage;
	params.idflags = idflags;
	params.smeansofdeath = smeansofdeath;
	params.weapon = weapon;
	params.vpoint = vpoint;
	params.vdir = vdir;
	params.shitloc = shitloc;
	params.vdamageorigin = vdamageorigin;
	params.psoffsettime = psoffsettime;
	if(!idflags & 8192)
	{
		if(isplayer(eattacker) && isdefined(eattacker.pers))
		{
			if(!isdefined(eattacker.pers[#"participation"]))
			{
				eattacker.pers[#"participation"] = 0;
			}
			eattacker.pers[#"participation"]++;
		}
		prevhealthratio = self.health / self.maxhealth;
		isshootingownclone = 0;
		if(isdefined(self.isaiclone) && self.isaiclone && isplayer(eattacker) && self.owner == eattacker)
		{
			isshootingownclone = 1;
		}
		if(level.teambased && isplayer(eattacker) && self != eattacker && !util::function_fbce7263(self.team, eattacker.pers[#"team"]) && !isshootingownclone)
		{
			friendlyfire = [[level.figure_out_friendly_fire]](self, eattacker);
			if(friendlyfire == 0)
			{
				return;
			}
			if(friendlyfire == 1)
			{
				if(idamage < 1)
				{
					idamage = 1;
				}
				self.lastdamagewasfromenemy = 0;
				var_5370b15e = (idamage > self.health ? self.health : idamage);
				self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
				params.idamage = idamage;
				self callback::callback(#"on_ai_damage", params);
				self callback::callback(#"on_actor_damage", params);
				self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
			}
			else if(friendlyfire == 2)
			{
				return;
			}
			if(friendlyfire == 3)
			{
				idamage = int(idamage * 0.5);
				if(idamage < 1)
				{
					idamage = 1;
				}
				self.lastdamagewasfromenemy = 0;
				var_5370b15e = (idamage > self.health ? self.health : idamage);
				self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
				params.idamage = idamage;
				self callback::callback(#"on_ai_damage", params);
				self callback::callback(#"on_actor_damage", params);
				self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
			}
			friendly = 1;
		}
		else if(isdefined(eattacker) && isdefined(self.script_owner) && eattacker == self.script_owner && !level.hardcoremode && !isshootingownclone)
		{
			return;
		}
		if(isdefined(eattacker) && isdefined(self.script_owner) && isdefined(eattacker.script_owner) && eattacker.script_owner == self.script_owner)
		{
			return;
		}
		if(idamage < 1)
		{
			idamage = 1;
		}
		if(issubstr(smeansofdeath, "MOD_GRENADE") && isdefined(einflictor) && isdefined(einflictor.iscooked))
		{
			self.wascooked = gettime();
		}
		else
		{
			self.wascooked = undefined;
		}
		self.lastdamagewasfromenemy = isdefined(eattacker) && eattacker != self;
		var_5370b15e = (idamage > self.health ? self.health : idamage);
		self globallogic_player::giveattackerandinflictorownerassist(eattacker, einflictor, var_5370b15e, smeansofdeath, weapon);
		params.idamage = idamage;
		self callback::callback(#"on_ai_damage", params);
		self callback::callback(#"on_actor_damage", params);
		self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
		if(isdefined(eattacker) && eattacker != self)
		{
			if(weapon.name != "artillery" && (!isdefined(einflictor) || !isai(einflictor) || !isdefined(einflictor.controlled) || einflictor.controlled))
			{
				if(idamage > 0 && shitloc !== "riotshield")
				{
					eattacker thread damagefeedback::update(smeansofdeath, einflictor, undefined, weapon, self);
				}
			}
		}
	}
	else
	{
		params.idamage = idamage;
		self callback::callback(#"on_ai_damage", params);
		self callback::callback(#"on_actor_damage", params);
		self finishactordamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, boneindex, surfacetype, vsurfacenormal);
	}
	self thread weapons::on_damage(eattacker, einflictor, weapon, smeansofdeath, idamage);
	/#
		if(getdvarint(#"g_debugdamage", 0))
		{
			println("" + self getentitynumber() + "" + self.health + "" + eattacker.clientid + "" + isplayer(einflictor) + "" + idamage + "" + shitloc);
		}
	#/
	if(1)
	{
		lpselfnum = self getentitynumber();
		lpselfteam = self.team;
		lpattackerteam = "";
		if(isplayer(eattacker))
		{
			lpattacknum = eattacker getentitynumber();
			var_c8fa9c41 = 0;
			lpattackguid = eattacker getguid();
			lpattackname = eattacker.name;
			lpattackerteam = eattacker.pers[#"team"];
		}
		else
		{
			lpattacknum = -1;
			var_c8fa9c41 = 0;
			lpattackguid = "";
			lpattackname = "";
			lpattackerteam = "world";
		}
	}
}

/*
	Name: callback_actorkilled
	Namespace: globallogic_actor
	Checksum: 0x583A502D
	Offset: 0x1128
	Size: 0x224
	Parameters: 8
	Flags: Linked
*/
function callback_actorkilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(gamestate::is_game_over())
	{
		return;
	}
	if(isai(eattacker) && isdefined(eattacker.script_owner))
	{
		if(util::function_fbce7263(eattacker.script_owner.team, self.team))
		{
			eattacker = eattacker.script_owner;
		}
	}
	if(isdefined(eattacker) && eattacker.classname == "script_vehicle" && isdefined(eattacker.owner))
	{
		eattacker = eattacker.owner;
	}
	globallogic::doweaponspecifickilleffects(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	globallogic::doweaponspecificcorpseeffects(self, einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
	params = spawnstruct();
	params.einflictor = einflictor;
	params.eattacker = eattacker;
	params.idamage = idamage;
	params.smeansofdeath = smeansofdeath;
	params.weapon = weapon;
	params.vdir = vdir;
	params.shitloc = shitloc;
	params.psoffsettime = psoffsettime;
	self callback::callback(#"on_ai_killed", params);
}

/*
	Name: callback_actorcloned
	Namespace: globallogic_actor
	Checksum: 0x9F2F2E7
	Offset: 0x1358
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function callback_actorcloned(original)
{
	destructserverutils::copydestructstate(original, self);
	gibserverutils::copygibstate(original, self);
}

