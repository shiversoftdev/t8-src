// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai\archetype_human_cover.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\ai\archetype_civilian_interface.gsc;
#using script_59f07c660e6710a5;
#using script_7b7ed6e4bc963a51;
#using script_3aa0f32b70d4f7cb;
#using script_178024232e91b0a1;
#using script_caf007e2a98afa2;
#using script_522aeb6ae906391e;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace archetype_civilian;

/*
	Name: main
	Namespace: archetype_civilian
	Checksum: 0x5C8E6EEA
	Offset: 0x3B8
	Size: 0x24
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	archetypecivilian::registerbehaviorscriptfunctions();
	civilianinterface::registercivilianinterfaceattributes();
}

#namespace archetypecivilian;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetypecivilian
	Checksum: 0x4A23957C
	Offset: 0x3E8
	Size: 0x7CC
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	spawner::add_archetype_spawn_function(#"civilian", &civilianblackboardinit);
	spawner::add_archetype_spawn_function(#"civilian", &civilianinit);
	/#
		assert(!isdefined(&civilianmoveactioninitialize) || isscriptfunctionptr(&civilianmoveactioninitialize));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&civilianmoveactionfinalize) || isscriptfunctionptr(&civilianmoveactionfinalize));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction("civilianMoveAction", &civilianmoveactioninitialize, undefined, &civilianmoveactionfinalize);
	/#
		assert(isscriptfunctionptr(&civilianwanderservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianWanderService", &civilianwanderservice, 1);
	/#
		assert(isscriptfunctionptr(&civilianpanicescapechooseposition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPanicEscapeChoosePosition", &civilianpanicescapechooseposition, 1);
	/#
		assert(isscriptfunctionptr(&rioterchoosepositionservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("rioterChoosePositionService", &rioterchoosepositionservice, 1);
	/#
		assert(isscriptfunctionptr(&civilianfollowservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianFollowService", &civilianfollowservice, 1);
	/#
		assert(isscriptfunctionptr(&civiliancanthrowmolotovgrenade));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianCanThrowMolotovGrenade", &civiliancanthrowmolotovgrenade);
	/#
		assert(isscriptfunctionptr(&civilianpreparetothrowgrenade));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianPrepareToThrowGrenade", &civilianpreparetothrowgrenade);
	/#
		assert(isscriptfunctionptr(&civiliancleanuptothrowgrenade));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianCleanUpToThrowGrenade", &civiliancleanuptothrowgrenade);
	/#
		assert(isscriptfunctionptr(&civilianispanicked));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsPanicked", &civilianispanicked);
	/#
		assert(isscriptfunctionptr(&civilianarrivalallowed));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal("civilianArrivalAllowed", &civilianarrivalallowed);
	/#
		assert(isscriptfunctionptr(&civilianareturnsallowed));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal("civilianAreTurnsAllowed", &civilianareturnsallowed);
	/#
		assert(isscriptfunctionptr(&civilianisrioter));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal("civilianIsRioter", &civilianisrioter);
	/#
		assert(isscriptfunctionptr(&civilianisrioter));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("civilianIsRioter", &civilianisrioter);
	/#
		assert(isscriptfunctionptr(&rioterreaquireservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("rioterReaquireService", &rioterreaquireservice);
	/#
		mapname = util::get_map_name();
		adddebugcommand(((((("" + mapname) + "") + "") + "") + "") + "");
		adddebugcommand(((((("" + mapname) + "") + "") + "") + "") + "");
		adddebugcommand(((((("" + mapname) + "") + "") + "") + "") + "");
		adddebugcommand(((((("" + mapname) + "") + "") + "") + "") + "");
		level thread function_686ab596();
	#/
}

/*
	Name: function_686ab596
	Namespace: archetypecivilian
	Checksum: 0x3586DCA1
	Offset: 0xBC0
	Size: 0x21C
	Parameters: 0
	Flags: Private
*/
function private function_686ab596()
{
	wait(5);
	while(true)
	{
		var_dfd6386 = getdvarstring(#"hash_27ecb7addfd5db25", "");
		ais = getaiarchetypearray(#"civilian");
		foreach(ai in ais)
		{
			switch(var_dfd6386)
			{
				case "riot":
				{
					ai::setaiattribute(ai, #"hash_78e762abc4fbf1de", "riot");
					ai setteam(#"team3");
					break;
				}
				case "panic":
				{
					ai::setaiattribute(ai, #"hash_78e762abc4fbf1de", "panic");
					break;
				}
				case "calm":
				{
					ai::setaiattribute(ai, #"hash_78e762abc4fbf1de", "calm");
					break;
				}
				case "run":
				{
					ai::setaiattribute(ai, #"hash_78e762abc4fbf1de", "run");
					break;
				}
				default:
				{
					break;
				}
			}
		}
		wait(0.05);
	}
}

/*
	Name: civilianblackboardinit
	Namespace: archetypecivilian
	Checksum: 0x9AEE720C
	Offset: 0xDE8
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
function private civilianblackboardinit()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &civilianonanimscriptedcallback;
}

/*
	Name: function_49d80e54
	Namespace: archetypecivilian
	Checksum: 0x2828501B
	Offset: 0xE40
	Size: 0x6C
	Parameters: 4
	Flags: Linked
*/
function function_49d80e54(civilian, attribute, oldvalue, value)
{
	/#
		assert(issentient(civilian));
	#/
	civilian setblackboardattribute("follow", value);
}

/*
	Name: civilianinit
	Namespace: archetypecivilian
	Checksum: 0x66FE35BC
	Offset: 0xEB8
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
function private civilianinit()
{
	entity = self;
	locomotiontypes = array("alt1", "alt2", "alt3");
	altindex = entity getentitynumber() % locomotiontypes.size;
	entity setblackboardattribute("_human_locomotion_variation", locomotiontypes[altindex]);
	entity setavoidancemask("avoid none");
	entity disableaimassist();
	entity.ignorepathenemyfightdist = 1;
}

/*
	Name: civilianonanimscriptedcallback
	Namespace: archetypecivilian
	Checksum: 0x20EB2BBB
	Offset: 0xFA0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianonanimscriptedcallback(entity)
{
	entity.__blackboard = undefined;
	entity civilianblackboardinit();
}

/*
	Name: function_ebea502e
	Namespace: archetypecivilian
	Checksum: 0x2ACC7CC8
	Offset: 0xFD8
	Size: 0xA6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ebea502e(entity)
{
	if(entity asmistransitionrunning() || entity getbehaviortreestatus() != 5 || entity asmissubstatepending() || entity asmistransdecrunning())
	{
		return true;
	}
	if(entity getpathmode() == "dont move")
	{
		return false;
	}
	return false;
}

/*
	Name: rioterchoosepositionservice
	Namespace: archetypecivilian
	Checksum: 0xF652606E
	Offset: 0x1088
	Size: 0x42C
	Parameters: 1
	Flags: Linked, Private
*/
function private rioterchoosepositionservice(entity)
{
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") != "riot")
	{
		return false;
	}
	if(!isdefined(entity.enemy))
	{
		return false;
	}
	if(function_ebea502e(entity))
	{
		return false;
	}
	var_1f2328d0 = entity function_4794d6a3();
	forcedgoal = isdefined(var_1f2328d0.goalforced) && var_1f2328d0.goalforced;
	isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
	itsbeenawhile = gettime() > entity.nextfindbestcovertime;
	isinbadplace = entity isinanybadplace();
	lastknownpos = entity lastknownpos(entity.enemy);
	dist = distance2d(entity.origin, lastknownpos);
	var_1ebff8de = itsbeenawhile || !isatscriptgoal || isinbadplace;
	if(!var_1ebff8de)
	{
		return false;
	}
	if(forcedgoal)
	{
		/#
			assert(isdefined(var_1f2328d0.goalpos));
		#/
		entity function_a57c34b7(var_1f2328d0.goalpos);
		aiutility::setnextfindbestcovertime(entity, undefined);
		return true;
	}
	center = entity.origin;
	if(isdefined(entity.goalpos))
	{
		center = entity.goalpos;
	}
	cylinder = ai::t_cylinder(center, entity.goalradius, entity.goalheight);
	pixbeginevent("rioter_tacquery_combat");
	aiprofile_beginentry("rioter_tacquery_combat");
	tacpoints = tacticalquery("rioter_tacquery_combat", center, entity, cylinder);
	pixendevent();
	aiprofile_endentry();
	pickedpoint = undefined;
	if(isdefined(tacpoints))
	{
		tacpoints = array::randomize(tacpoints);
		foreach(tacpoint in tacpoints)
		{
			if(self isingoal(tacpoint.origin))
			{
				if(isdefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin)
				{
					continue;
				}
				pickedpoint = tacpoint;
				break;
			}
		}
	}
	if(isdefined(pickedpoint))
	{
		entity function_a57c34b7(pickedpoint.origin);
		aiutility::setnextfindbestcovertime(entity, undefined);
		return true;
	}
	return false;
}

/*
	Name: civilianpanicescapechooseposition
	Namespace: archetypecivilian
	Checksum: 0x7FC8FBAE
	Offset: 0x14C0
	Size: 0x122
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianpanicescapechooseposition(entity)
{
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "riot")
	{
		return false;
	}
	if(isdefined(entity.ai.escaping) && entity.ai.escaping)
	{
		return false;
	}
	if(!ai::getaiattribute(entity, "auto_escape"))
	{
		return false;
	}
	escape_nodes = getnodearray("civ_escape", "targetname");
	if(escape_nodes.size)
	{
		var_cc364bf7 = arraygetclosest(entity.origin, escape_nodes);
		entity function_a57c34b7(var_cc364bf7.origin);
		entity.ai.escaping = 1;
	}
}

/*
	Name: civilianwanderservice
	Namespace: archetypecivilian
	Checksum: 0x2BFC3290
	Offset: 0x15F0
	Size: 0x43C
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianwanderservice(entity)
{
	if(isentity(entity getblackboardattribute("follow")))
	{
		return false;
	}
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "riot")
	{
		return false;
	}
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "panic" && ai::getaiattribute(entity, "auto_escape"))
	{
		return false;
	}
	if(!ai::getaiattribute(entity, "auto_wander"))
	{
		return false;
	}
	if(function_ebea502e(entity))
	{
		return false;
	}
	var_1f2328d0 = entity function_4794d6a3();
	forcedgoal = isdefined(var_1f2328d0.goalforced) && var_1f2328d0.goalforced;
	isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
	itsbeenawhile = gettime() > entity.nextfindbestcovertime;
	var_1ebff8de = itsbeenawhile || !isatscriptgoal;
	if(!var_1ebff8de)
	{
		return false;
	}
	if(forcedgoal)
	{
		/#
			assert(isdefined(var_1f2328d0.goalpos));
		#/
		entity function_a57c34b7(var_1f2328d0.goalpos);
		aiutility::setnextfindbestcovertime(entity, undefined);
		return true;
	}
	cylinder = ai::t_cylinder(entity.goalpos, entity.goalradius, entity.goalheight);
	pixbeginevent("civilian_wander_tacquery");
	aiprofile_beginentry("civilian_wander_tacquery");
	tacpoints = tacticalquery("civilian_wander_tacquery", entity.goalpos, entity, cylinder);
	pixendevent();
	aiprofile_endentry();
	pickedpoint = undefined;
	if(isdefined(tacpoints))
	{
		tacpoints = array::randomize(tacpoints);
		foreach(tacpoint in tacpoints)
		{
			if(!self isposinclaimedlocation(tacpoint.origin) && self isingoal(tacpoint.origin))
			{
				if(isdefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin)
				{
					continue;
				}
				pickedpoint = tacpoint;
				break;
			}
		}
	}
	if(isdefined(pickedpoint))
	{
		entity function_a57c34b7(pickedpoint.origin);
		aiutility::setnextfindbestcovertime(entity, undefined);
		return true;
	}
	return false;
}

/*
	Name: civilianfollowservice
	Namespace: archetypecivilian
	Checksum: 0x25229B37
	Offset: 0x1A38
	Size: 0x3FC
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianfollowservice(entity)
{
	followradiussq = 300 * 300;
	followent = entity getblackboardattribute("follow");
	if(!isentity(followent))
	{
		return false;
	}
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "panic" && ai::getaiattribute(entity, "auto_escape"))
	{
		return false;
	}
	if(function_ebea502e(entity))
	{
		return false;
	}
	var_1f2328d0 = entity function_4794d6a3();
	distsq = (isdefined(entity.overridegoalpos) ? distancesquared(entity.overridegoalpos, followent.origin) : -1);
	forcedgoal = isdefined(var_1f2328d0.goalforced) && var_1f2328d0.goalforced;
	isatscriptgoal = entity isatgoal() || entity isapproachinggoal();
	itsbeenawhile = gettime() > entity.nextfindbestcovertime;
	var_1ebff8de = itsbeenawhile || !isatscriptgoal || distsq < 0 || distsq > followradiussq;
	if(!var_1ebff8de)
	{
		return false;
	}
	pixbeginevent("civilian_follow_tacquery");
	aiprofile_beginentry("civilian_follow_tacquery");
	tacpoints = tacticalquery("civilian_follow_tacquery", followent, entity, followent);
	pixendevent();
	aiprofile_endentry();
	pickedpoint = undefined;
	if(isdefined(tacpoints))
	{
		tacpoints = array::randomize(tacpoints);
		if(tacpoints.size == 0)
		{
			pickedpoint = followent;
		}
		else
		{
			foreach(tacpoint in tacpoints)
			{
				if(!self isposinclaimedlocation(tacpoint.origin) && self isingoal(tacpoint.origin))
				{
					if(isdefined(entity.pathgoalpos) && entity.pathgoalpos == tacpoint.origin)
					{
						continue;
					}
					pickedpoint = tacpoint;
					break;
				}
			}
		}
	}
	if(isdefined(pickedpoint))
	{
		entity function_a57c34b7(pickedpoint.origin);
		aiutility::setnextfindbestcovertime(entity, undefined);
		return true;
	}
	return false;
}

/*
	Name: civilianmoveactioninitialize
	Namespace: archetypecivilian
	Checksum: 0xB1079006
	Offset: 0x1E40
	Size: 0x58
	Parameters: 2
	Flags: Linked, Private
*/
function private civilianmoveactioninitialize(entity, asmstatename)
{
	entity setblackboardattribute("_desired_stance", "stand");
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: civilianmoveactionfinalize
	Namespace: archetypecivilian
	Checksum: 0x79DAD227
	Offset: 0x1EA0
	Size: 0x68
	Parameters: 2
	Flags: Linked, Private
*/
function private civilianmoveactionfinalize(entity, asmstatename)
{
	if(entity getblackboardattribute("_stance") != "stand")
	{
		entity setblackboardattribute("_desired_stance", "stand");
	}
	return 4;
}

/*
	Name: civilianispanicked
	Namespace: archetypecivilian
	Checksum: 0xAE6917CF
	Offset: 0x1F10
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianispanicked(entity)
{
	return entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "panic";
}

/*
	Name: function_e27d2a1b
	Namespace: archetypecivilian
	Checksum: 0x4DEDC785
	Offset: 0x1F50
	Size: 0x22
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e27d2a1b()
{
	return ai::getaiattribute(self, #"hash_78e762abc4fbf1de");
}

/*
	Name: civilianarrivalallowed
	Namespace: archetypecivilian
	Checksum: 0xF885D8BC
	Offset: 0x1F80
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianarrivalallowed(entity)
{
	if(ai::getaiattribute(entity, "disablearrivals"))
	{
		return false;
	}
	return true;
}

/*
	Name: civilianareturnsallowed
	Namespace: archetypecivilian
	Checksum: 0x20F720F
	Offset: 0x1FC0
	Size: 0x40
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianareturnsallowed(entity)
{
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "calm")
	{
		return false;
	}
	return true;
}

/*
	Name: civilianisrioter
	Namespace: archetypecivilian
	Checksum: 0x12BF3473
	Offset: 0x2008
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function civilianisrioter(entity)
{
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") == "riot")
	{
		return true;
	}
	return false;
}

/*
	Name: civiliancanthrowmolotovgrenade
	Namespace: archetypecivilian
	Checksum: 0x372237DA
	Offset: 0x2050
	Size: 0x586
	Parameters: 2
	Flags: Linked
*/
function civiliancanthrowmolotovgrenade(behaviortreeentity, throwifpossible = 0)
{
	if(!isdefined(behaviortreeentity.enemy))
	{
		return false;
	}
	if(!issentient(behaviortreeentity.enemy))
	{
		return false;
	}
	if(isvehicle(behaviortreeentity.enemy) && behaviortreeentity.enemy.vehicleclass === "helicopter")
	{
		return false;
	}
	if(!ai::getaiattribute(behaviortreeentity, "useGrenades"))
	{
		return false;
	}
	entityangles = behaviortreeentity.angles;
	toenemy = behaviortreeentity.enemy.origin - behaviortreeentity.origin;
	toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
	entityforward = anglestoforward(entityangles);
	entityforward = vectornormalize((entityforward[0], entityforward[1], 0));
	if(vectordot(toenemy, entityforward) < 0.5)
	{
		return false;
	}
	if(!throwifpossible)
	{
		foreach(player in level.players)
		{
			if(player laststand::player_is_in_laststand() && distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 640000)
			{
				return false;
			}
		}
		grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");
		foreach(grenadethrowinfo in grenadethrowinfos)
		{
			if(grenadethrowinfo.data.grenadethrowerteam === behaviortreeentity.team)
			{
				return false;
			}
		}
		grenadethrowinfos = blackboard::getblackboardevents("riot_grenade_throw");
		foreach(grenadethrowinfo in grenadethrowinfos)
		{
			if(isdefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat))
			{
				if(grenadethrowinfo.data.grenadethrower == behaviortreeentity)
				{
					return false;
				}
				if(isdefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == behaviortreeentity.enemy)
				{
					return false;
				}
				if(isdefined(grenadethrowinfo.data.grenadethrownposition) && isdefined(behaviortreeentity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, behaviortreeentity.grenadethrowposition) <= 1440000)
				{
					return false;
				}
			}
		}
	}
	throw_dist = distance2dsquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
	if(throw_dist < (300 * 300) || throw_dist > (1250 * 1250))
	{
		return false;
	}
	arm_offset = archetype_human_cover::temp_get_arm_offset(behaviortreeentity, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
	throw_vel = behaviortreeentity canthrowgrenadepos(arm_offset, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
	if(!isdefined(throw_vel))
	{
		return false;
	}
	return true;
}

/*
	Name: civilianpreparetothrowgrenade
	Namespace: archetypecivilian
	Checksum: 0xB498D46E
	Offset: 0x25E0
	Size: 0x16A
	Parameters: 1
	Flags: Linked, Private
*/
function private civilianpreparetothrowgrenade(behaviortreeentity)
{
	aiutility::keepclaimnode(behaviortreeentity);
	if(isdefined(behaviortreeentity.enemy))
	{
		behaviortreeentity.grenadethrowposition = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
	}
	grenadethrowinfo = spawnstruct();
	grenadethrowinfo.grenadethrower = behaviortreeentity;
	grenadethrowinfo.grenadethrownat = behaviortreeentity.enemy;
	grenadethrowinfo.grenadethrownposition = behaviortreeentity.grenadethrowposition;
	blackboard::addblackboardevent("riot_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
	grenadethrowinfo = spawnstruct();
	grenadethrowinfo.grenadethrowerteam = behaviortreeentity.team;
	blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(8000, 12000));
	behaviortreeentity.preparegrenadeammo = behaviortreeentity.grenadeammo;
}

/*
	Name: civiliancleanuptothrowgrenade
	Namespace: archetypecivilian
	Checksum: 0x10DDECD9
	Offset: 0x2758
	Size: 0x20C
	Parameters: 1
	Flags: Linked, Private
*/
function private civiliancleanuptothrowgrenade(behaviortreeentity)
{
	aiutility::releaseclaimnode(behaviortreeentity);
	if(behaviortreeentity.preparegrenadeammo == behaviortreeentity.grenadeammo)
	{
		if(behaviortreeentity.health <= 0)
		{
			grenade = undefined;
			if(isactor(behaviortreeentity.enemy) && isdefined(behaviortreeentity.grenadeweapon))
			{
				grenade = behaviortreeentity.enemy magicgrenadetype(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0), float(behaviortreeentity.grenadeweapon.aifusetime) / 1000);
			}
			else if(isplayer(behaviortreeentity.enemy) && isdefined(behaviortreeentity.grenadeweapon))
			{
				grenade = behaviortreeentity.enemy magicgrenadeplayer(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0));
			}
			if(isdefined(grenade))
			{
				grenade.owner = behaviortreeentity;
				grenade.team = behaviortreeentity.team;
				grenade setcontents(grenade setcontents(0) & (~(((32768 | 67108864) | 8388608) | 33554432)));
			}
		}
	}
}

/*
	Name: rioterreaquireservice
	Namespace: archetypecivilian
	Checksum: 0xBC4E7368
	Offset: 0x2970
	Size: 0x2E6
	Parameters: 1
	Flags: Linked, Private
*/
function private rioterreaquireservice(entity)
{
	if(entity getblackboardattribute(#"hash_78e762abc4fbf1de") != "riot")
	{
		return false;
	}
	if(!isdefined(entity.reacquire_state))
	{
		entity.reacquire_state = 0;
	}
	if(!isdefined(entity.enemy))
	{
		entity.reacquire_state = 0;
		return false;
	}
	if(entity haspath())
	{
		return false;
	}
	if(entity seerecently(entity.enemy, 3))
	{
		entity.reacquire_state = 0;
		return false;
	}
	dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
	forward = anglestoforward(entity.angles);
	if(vectordot(dirtoenemy, forward) < 0.5)
	{
		entity.reacquire_state = 0;
		return false;
	}
	switch(entity.reacquire_state)
	{
		case 0:
		case 1:
		case 2:
		{
			step_size = 32 + (entity.reacquire_state * 32);
			reacquirepos = entity reacquirestep(step_size);
			break;
		}
		case 4:
		{
			if(!entity cansee(entity.enemy) || !entity canshootenemy())
			{
				entity flagenemyunattackable();
			}
			break;
		}
		default:
		{
			if(entity.reacquire_state > 15)
			{
				entity.reacquire_state = 0;
				return false;
			}
			break;
		}
	}
	if(isvec(reacquirepos))
	{
		entity function_a57c34b7(reacquirepos);
		entity.reacquire_state = 0;
		return true;
	}
	entity.reacquire_state++;
	return false;
}

