// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\ai\archetype_human_interface.gsc;
#using script_35598499769dbb3d;
#using script_41fe08c37d53a635;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_7b7ed6e4bc963a51;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace archetype_human;

/*
	Name: init
	Namespace: archetype_human
	Checksum: 0xF709FCF
	Offset: 0x398
	Size: 0xD6
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init()
{
	spawner::add_archetype_spawn_function(#"human", &archetypehumanblackboardinit);
	spawner::add_archetype_spawn_function(#"human", &archetypehumaninit);
	humaninterface::registerhumaninterfaceattributes();
	clientfield::register("actor", "facial_dial", 1, 1, "int");
	/#
		level.__ai_forcegibs = getdvarint(#"ai_forcegibs", 0);
	#/
}

/*
	Name: archetypehumaninit
	Namespace: archetype_human
	Checksum: 0x3FDB8D09
	Offset: 0x478
	Size: 0x124
	Parameters: 0
	Flags: Linked, Private
*/
function private archetypehumaninit()
{
	entity = self;
	aiutility::addaioverridedamagecallback(entity, &damageoverride);
	aiutility::addaioverridekilledcallback(entity, &humangibkilledoverride);
	locomotiontypes = array("alt1", "alt2", "alt3", "alt4");
	altindex = entity getentitynumber() % locomotiontypes.size;
	entity setblackboardattribute("_human_locomotion_variation", locomotiontypes[altindex]);
	if(isdefined(entity.hero) && entity.hero)
	{
		entity setblackboardattribute("_human_locomotion_variation", "alt1");
	}
}

/*
	Name: archetypehumanblackboardinit
	Namespace: archetype_human
	Checksum: 0x3F1A33C1
	Offset: 0x5A8
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
function private archetypehumanblackboardinit()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &archetypehumanonanimscriptedcallback;
	self.___archetypeonbehavecallback = &archetypehumanonbehavecallback;
	if(self.accuratefire)
	{
		self thread aiutility::preshootlaserandglinton(self);
		self thread aiutility::postshootlaserandglintoff(self);
	}
	destructserverutils::togglespawngibs(self, 1);
	gibserverutils::togglespawngibs(self, 1);
}

/*
	Name: archetypehumanonbehavecallback
	Namespace: archetype_human
	Checksum: 0xD52F46
	Offset: 0x680
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private archetypehumanonbehavecallback(entity)
{
	if(btapi_isatcovercondition(entity))
	{
		entity setblackboardattribute("_previous_cover_mode", "cover_alert");
		entity setblackboardattribute("_cover_mode", "cover_mode_none");
	}
	grenadethrowinfo = spawnstruct();
	grenadethrowinfo.grenadethrower = entity;
	blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(3000, 4000));
}

/*
	Name: archetypehumanonanimscriptedcallback
	Namespace: archetype_human
	Checksum: 0x3C52BD29
	Offset: 0x760
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private archetypehumanonanimscriptedcallback(entity)
{
	entity.__blackboard = undefined;
	entity archetypehumanblackboardinit();
	vignettemode = ai::getaiattribute(entity, "vignette_mode");
	humansoldierserverutils::vignettemodecallback(entity, "vignette_mode", vignettemode, vignettemode);
}

/*
	Name: humangibkilledoverride
	Namespace: archetype_human
	Checksum: 0x39AFDDD1
	Offset: 0x7E8
	Size: 0x300
	Parameters: 8
	Flags: Linked, Private
*/
function private humangibkilledoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime)
{
	entity = self;
	if(math::cointoss())
	{
		return damage;
	}
	attackerdistance = 0;
	if(isdefined(attacker))
	{
		attackerdistance = distancesquared(attacker.origin, entity.origin);
	}
	isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
	forcegibbing = 0;
	if(isdefined(weapon.weapclass) && weapon.weapclass == "turret")
	{
		forcegibbing = 1;
		if(isdefined(inflictor))
		{
			isdirectexplosive = isinarray(array("MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
			iscloseexplosive = distancesquared(inflictor.origin, entity.origin) <= (60 * 60);
			if(isdirectexplosive && iscloseexplosive)
			{
				gibserverutils::annihilate(entity);
			}
		}
	}
	if(forcegibbing || isexplosive || (isdefined(level.__ai_forcegibs) && level.__ai_forcegibs) || (weapon.dogibbing && attackerdistance <= (weapon.maxgibdistance * weapon.maxgibdistance)))
	{
		gibserverutils::togglespawngibs(entity, 1);
		destructserverutils::togglespawngibs(entity, 1);
		trygibbinglimb(entity, damage, hitloc, isexplosive || forcegibbing);
		trygibbinglegs(entity, damage, hitloc, isexplosive);
	}
	return damage;
}

/*
	Name: trygibbinghead
	Namespace: archetype_human
	Checksum: 0x883E59D6
	Offset: 0xAF0
	Size: 0x9C
	Parameters: 4
	Flags: Private
*/
function private trygibbinghead(entity, damage, hitloc, isexplosive)
{
	if(isexplosive)
	{
		gibserverutils::gibhead(entity);
	}
	else if(isinarray(array("head", "neck", "helmet"), hitloc))
	{
		gibserverutils::gibhead(entity);
	}
}

/*
	Name: trygibbinglimb
	Namespace: archetype_human
	Checksum: 0x2B3164B5
	Offset: 0xB98
	Size: 0x1CC
	Parameters: 4
	Flags: Linked, Private
*/
function private trygibbinglimb(entity, damage, hitloc, isexplosive)
{
	if(isexplosive)
	{
		randomchance = randomfloatrange(0, 1);
		if(randomchance < 0.5)
		{
			gibserverutils::gibrightarm(entity);
		}
		else
		{
			gibserverutils::gibleftarm(entity);
		}
	}
	else
	{
		if(isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc))
		{
			gibserverutils::gibleftarm(entity);
		}
		else
		{
			if(isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc))
			{
				gibserverutils::gibrightarm(entity);
			}
			else if(isinarray(array("torso_upper"), hitloc) && math::cointoss())
			{
				if(math::cointoss())
				{
					gibserverutils::gibleftarm(entity);
				}
				else
				{
					gibserverutils::gibrightarm(entity);
				}
			}
		}
	}
}

/*
	Name: trygibbinglegs
	Namespace: archetype_human
	Checksum: 0x6ABF2038
	Offset: 0xD70
	Size: 0x1FC
	Parameters: 5
	Flags: Linked, Private
*/
function private trygibbinglegs(entity, damage, hitloc, isexplosive, attacker)
{
	if(isexplosive)
	{
		randomchance = randomfloatrange(0, 1);
		if(randomchance < 0.33)
		{
			gibserverutils::gibrightleg(entity);
		}
		else
		{
			if(randomchance < 0.66)
			{
				gibserverutils::gibleftleg(entity);
			}
			else
			{
				gibserverutils::giblegs(entity);
			}
		}
	}
	else
	{
		if(isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc))
		{
			gibserverutils::gibleftleg(entity);
		}
		else
		{
			if(isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc))
			{
				gibserverutils::gibrightleg(entity);
			}
			else if(isinarray(array("torso_lower"), hitloc) && math::cointoss())
			{
				if(math::cointoss())
				{
					gibserverutils::gibleftleg(entity);
				}
				else
				{
					gibserverutils::gibrightleg(entity);
				}
			}
		}
	}
}

/*
	Name: damageoverride
	Namespace: archetype_human
	Checksum: 0x886CC922
	Offset: 0xF78
	Size: 0x252
	Parameters: 12
	Flags: Linked
*/
function damageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex)
{
	entity = self;
	entity destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex);
	if(isdefined(eattacker) && isplayer(eattacker) && (smeansofdeath === "MOD_RIFLE_BULLET" || smeansofdeath === "MOD_PISTOL_BULLET" || smeansofdeath === "MOD_HEAD_SHOT") && isdefined(shitloc) && (shitloc == "head" || shitloc == "helmet" || shitloc == "neck"))
	{
		idamage = idamage * 5;
	}
	if(isdefined(eattacker) && !isplayer(eattacker) && !isvehicle(eattacker))
	{
		dist = distancesquared(entity.origin, eattacker.origin);
		if(dist < 65536)
		{
			idamage = int(idamage * 10);
		}
		else
		{
			idamage = int(idamage * 1.5);
		}
	}
	if(sweapon.name == "incendiary_grenade")
	{
		idamage = entity.health;
	}
	return idamage;
}

#namespace humansoldierserverutils;

/*
	Name: cqbattributecallback
	Namespace: humansoldierserverutils
	Checksum: 0xE38099FC
	Offset: 0x11D8
	Size: 0xA4
	Parameters: 4
	Flags: Linked
*/
function cqbattributecallback(entity, attribute, oldvalue, value)
{
	if(value)
	{
		entity asmchangeanimmappingtable(2);
	}
	else
	{
		if(entity ai::get_behavior_attribute("useAnimationOverride"))
		{
			entity asmchangeanimmappingtable(1);
		}
		else
		{
			entity asmchangeanimmappingtable(0);
		}
	}
}

/*
	Name: forcetacticalwalkcallback
	Namespace: humansoldierserverutils
	Checksum: 0x22BCC9DE
	Offset: 0x1288
	Size: 0x32
	Parameters: 4
	Flags: Linked
*/
function forcetacticalwalkcallback(entity, attribute, oldvalue, value)
{
	entity.ignorerunandgundist = value;
}

/*
	Name: movemodeattributecallback
	Namespace: humansoldierserverutils
	Checksum: 0x78D737F6
	Offset: 0x12C8
	Size: 0x82
	Parameters: 4
	Flags: Linked
*/
function movemodeattributecallback(entity, attribute, oldvalue, value)
{
	entity.ignorepathenemyfightdist = 0;
	switch(value)
	{
		case "normal":
		{
			break;
		}
		case "rambo":
		{
			entity.ignorepathenemyfightdist = 1;
			break;
		}
	}
}

/*
	Name: useanimationoverridecallback
	Namespace: humansoldierserverutils
	Checksum: 0xCAB1E305
	Offset: 0x1358
	Size: 0x64
	Parameters: 4
	Flags: Linked
*/
function useanimationoverridecallback(entity, attribute, oldvalue, value)
{
	if(value)
	{
		entity asmchangeanimmappingtable(1);
	}
	else
	{
		entity asmchangeanimmappingtable(0);
	}
}

/*
	Name: disablesprintcallback
	Namespace: humansoldierserverutils
	Checksum: 0xF35086B4
	Offset: 0x13C8
	Size: 0x4A
	Parameters: 4
	Flags: Linked
*/
function disablesprintcallback(entity, attribute, oldvalue, value)
{
	if(value)
	{
		entity.disablesprint = 1;
	}
	else
	{
		entity.disablesprint = 0;
	}
}

/*
	Name: forcesprintcallback
	Namespace: humansoldierserverutils
	Checksum: 0x91F5B377
	Offset: 0x1420
	Size: 0x4A
	Parameters: 4
	Flags: Linked
*/
function forcesprintcallback(entity, attribute, oldvalue, value)
{
	if(value)
	{
		entity.forcesprint = 1;
	}
	else
	{
		entity.forcesprint = 0;
	}
}

/*
	Name: vignettemodecallback
	Namespace: humansoldierserverutils
	Checksum: 0x37A24688
	Offset: 0x1478
	Size: 0x202
	Parameters: 4
	Flags: Linked
*/
function vignettemodecallback(entity, attribute, oldvalue, value)
{
	switch(value)
	{
		case "off":
		{
			entity.pushable = 1;
			entity collidewithactors(0);
			entity pushplayer(0);
			entity setavoidancemask("avoid all");
			entity setsteeringmode("normal steering");
			break;
		}
		case "slow":
		{
			entity.pushable = 0;
			entity collidewithactors(0);
			entity pushplayer(1);
			entity setavoidancemask("avoid ai");
			entity setsteeringmode("vignette steering");
			break;
		}
		case "fast":
		{
			entity.pushable = 0;
			entity collidewithactors(1);
			entity pushplayer(1);
			entity setavoidancemask("avoid none");
			entity setsteeringmode("vignette steering");
			break;
		}
		default:
		{
			break;
		}
	}
}

