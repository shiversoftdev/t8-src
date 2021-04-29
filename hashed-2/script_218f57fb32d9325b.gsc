// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using script_4a3f9b8905878272;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_7b7ed6e4bc963a51;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;

#namespace archetype_human_cover;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetype_human_cover
	Checksum: 0x8744A435
	Offset: 0x1F8
	Size: 0x9C4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&shouldreturntocovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreturntocovercondition", &shouldreturntocovercondition);
	/#
		assert(isscriptfunctionptr(&shouldreturntosuppressedcover));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreturntosuppressedcover", &shouldreturntosuppressedcover);
	/#
		assert(isscriptfunctionptr(&shouldadjusttocover));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldadjusttocover", &shouldadjusttocover);
	/#
		assert(isscriptfunctionptr(&prepareforadjusttocover));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforadjusttocover", &prepareforadjusttocover);
	/#
		assert(isscriptfunctionptr(&coverblindfireshootactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverblindfireshootstart", &coverblindfireshootactionstart);
	/#
		assert(isscriptfunctionptr(&canchangestanceatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"canchangestanceatcovercondition", &canchangestanceatcovercondition);
	/#
		assert(isscriptfunctionptr(&coverchangestanceactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverchangestanceactionstart", &coverchangestanceactionstart);
	/#
		assert(isscriptfunctionptr(&preparetochangestancetostand));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetochangestancetostand", &preparetochangestancetostand);
	/#
		assert(isscriptfunctionptr(&cleanupchangestancetostand));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchangestancetostand", &cleanupchangestancetostand);
	/#
		assert(isscriptfunctionptr(&preparetochangestancetocrouch));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetochangestancetocrouch", &preparetochangestancetocrouch);
	/#
		assert(isscriptfunctionptr(&cleanupchangestancetocrouch));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchangestancetocrouch", &cleanupchangestancetocrouch);
	/#
		assert(isscriptfunctionptr(&shouldvantageatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldvantageatcovercondition", &shouldvantageatcovercondition);
	/#
		assert(isscriptfunctionptr(&supportsvantagecovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsvantagecovercondition", &supportsvantagecovercondition);
	/#
		assert(isscriptfunctionptr(&covervantageinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"covervantageinitialize", &covervantageinitialize);
	/#
		assert(isscriptfunctionptr(&shouldthrowgrenadeatcovercondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldthrowgrenadeatcovercondition", &shouldthrowgrenadeatcovercondition);
	/#
		assert(isscriptfunctionptr(&coverpreparetothrowgrenade));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpreparetothrowgrenade", &coverpreparetothrowgrenade);
	/#
		assert(isscriptfunctionptr(&covercleanuptothrowgrenade));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"covercleanuptothrowgrenade", &covercleanuptothrowgrenade);
	/#
		assert(isscriptfunctionptr(&sensenearbyplayers));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"sensenearbyplayers", &sensenearbyplayers);
	/#
		assert(isscriptfunctionptr(&function_f120d301));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5b614e766fc4d283", &function_f120d301);
	/#
		assert(isscriptfunctionptr(&function_ae382dda));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2078ca98b094c39", &function_ae382dda);
	/#
		assert(isscriptfunctionptr(&function_e17114c2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_914aa2c9d4ad21c", &function_e17114c2);
	/#
		assert(isscriptfunctionptr(&function_b1b24a11));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_46826da2c33c9632", &function_b1b24a11);
	/#
		assert(isscriptfunctionptr(&function_60315632));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_f9bf57d0e8f28a0", &function_60315632);
	/#
		assert(isscriptfunctionptr(&function_2221fee7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7f97f92742243917", &function_2221fee7);
}

/*
	Name: shouldthrowgrenadeatcovercondition
	Namespace: archetype_human_cover
	Checksum: 0x3FFABA47
	Offset: 0xBC8
	Size: 0x8F6
	Parameters: 2
	Flags: Linked
*/
function shouldthrowgrenadeatcovercondition(entity, throwifpossible = 0)
{
	if(isdefined(self.hero) && self.hero && (isdefined(self.var_6fe3ea59) && self.var_6fe3ea59))
	{
		throwifpossible = 1;
	}
	if(isdefined(level.aidisablegrenadethrows) && level.aidisablegrenadethrows)
	{
		return 0;
	}
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(!issentient(entity.enemy))
	{
		return 0;
	}
	if(isvehicle(entity.enemy) && isairborne(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.grenadeammo) && entity.grenadeammo <= 0)
	{
		return 0;
	}
	if(ai::hasaiattribute(entity, "useGrenades") && !ai::getaiattribute(entity, "useGrenades"))
	{
		return 0;
	}
	if(isplayer(entity.enemy) && entity.enemy laststand::player_is_in_laststand())
	{
		return 0;
	}
	entityangles = entity.angles;
	if(isdefined(entity.node) && (entity.node.type == #"hash_63cbb4767da2a801" || entity.node.type == #"hash_2a7b1ca393696762" || entity.node.type == #"hash_7a0e62fbbe3989d4" || (entity.node.type == #"hash_581529fff05853f0" || entity.node.type == #"hash_1bb444d857814e92") || (entity.node.type == #"hash_6d8019ab9d39bf96" || entity.node.type == #"hash_280d1247a6abdbae" || entity.node.type == #"hash_171465527444ed14")) && entity isatcovernodestrict())
	{
		entityangles = entity.node.angles;
	}
	toenemy = entity.enemy.origin - entity.origin;
	toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
	entityforward = anglestoforward(entityangles);
	entityforward = vectornormalize((entityforward[0], entityforward[1], 0));
	if(vectordot(toenemy, entityforward) < 0.5)
	{
		return 0;
	}
	if(!throwifpossible)
	{
		var_a2badbc3 = getplayers(entity.team);
		allplayers = getplayers();
		if(isdefined(var_a2badbc3) && var_a2badbc3.size)
		{
			foreach(player in var_a2badbc3)
			{
				if(distancesquared(entity.enemy.origin, player.origin) <= 640000)
				{
					return 0;
				}
			}
		}
		if(isdefined(allplayers) && allplayers.size)
		{
			foreach(player in allplayers)
			{
				if(isdefined(player) && player laststand::player_is_in_laststand() && distancesquared(entity.enemy.origin, player.origin) <= 640000)
				{
					return 0;
				}
			}
		}
		grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");
		foreach(grenadethrowinfo in grenadethrowinfos)
		{
			if(grenadethrowinfo.data.grenadethrowerteam === entity.team)
			{
				return 0;
			}
		}
		grenadethrowinfos = blackboard::getblackboardevents("human_grenade_throw");
		foreach(grenadethrowinfo in grenadethrowinfos)
		{
			if(isdefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat))
			{
				if(grenadethrowinfo.data.grenadethrower == entity)
				{
					return 0;
				}
				if(isdefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == entity.enemy)
				{
					return 0;
				}
				if(isdefined(grenadethrowinfo.data.grenadethrownposition) && isdefined(entity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, entity.grenadethrowposition) <= 1440000)
				{
					return 0;
				}
			}
		}
	}
	throw_dist = distance2dsquared(entity.origin, entity lastknownpos(entity.enemy));
	if(throw_dist < 500 * 500 || throw_dist > 1250 * 1250)
	{
		return 0;
	}
	arm_offset = temp_get_arm_offset(entity, entity lastknownpos(entity.enemy));
	throw_vel = entity canthrowgrenadepos(arm_offset, entity lastknownpos(entity.enemy));
	if(!isdefined(throw_vel))
	{
		return 0;
	}
	return 1;
}

/*
	Name: sensenearbyplayers
	Namespace: archetype_human_cover
	Checksum: 0xCDEA8E2D
	Offset: 0x14C8
	Size: 0x130
	Parameters: 1
	Flags: Linked, Private
*/
private function sensenearbyplayers(entity)
{
	players = getplayers();
	foreach(player in players)
	{
		distancesq = distancesquared(player.origin, entity.origin);
		if(distancesq <= 360 * 360)
		{
			distancetoplayer = sqrt(distancesq);
			chancetodetect = randomfloat(1);
			if(chancetodetect < distancetoplayer / 360)
			{
				entity getperfectinfo(player);
			}
		}
	}
}

/*
	Name: coverpreparetothrowgrenade
	Namespace: archetype_human_cover
	Checksum: 0x8A66F935
	Offset: 0x1600
	Size: 0x16A
	Parameters: 1
	Flags: Linked, Private
*/
private function coverpreparetothrowgrenade(entity)
{
	aiutility::keepclaimednodeandchoosecoverdirection(entity);
	if(isdefined(entity.enemy))
	{
		entity.grenadethrowposition = entity lastknownpos(entity.enemy);
	}
	grenadethrowinfo = spawnstruct();
	grenadethrowinfo.grenadethrower = entity;
	grenadethrowinfo.grenadethrownat = entity.enemy;
	grenadethrowinfo.grenadethrownposition = entity.grenadethrowposition;
	blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
	grenadethrowinfo = spawnstruct();
	grenadethrowinfo.grenadethrowerteam = entity.team;
	blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(8000, 12000));
	entity.preparegrenadeammo = entity.grenadeammo;
}

/*
	Name: covercleanuptothrowgrenade
	Namespace: archetype_human_cover
	Checksum: 0x8644B82B
	Offset: 0x1778
	Size: 0x20C
	Parameters: 1
	Flags: Linked, Private
*/
private function covercleanuptothrowgrenade(entity)
{
	aiutility::resetcoverparameters(entity);
	if(entity.preparegrenadeammo == entity.grenadeammo)
	{
		if(entity.health <= 0)
		{
			grenade = undefined;
			if(isactor(entity.enemy) && isdefined(entity.grenadeweapon))
			{
				grenade = entity.enemy magicgrenadetype(entity.grenadeweapon, entity gettagorigin("j_wrist_ri"), (0, 0, 0), float(entity.grenadeweapon.aifusetime) / 1000);
			}
			else if(isplayer(entity.enemy) && isdefined(entity.grenadeweapon))
			{
				grenade = entity.enemy magicgrenadeplayer(entity.grenadeweapon, entity gettagorigin("j_wrist_ri"), (0, 0, 0));
			}
			if(isdefined(grenade))
			{
				grenade.owner = entity;
				grenade.team = entity.team;
				~grenade;
				grenade setcontents(grenade setcontents(0) & 32768 | 67108864 | 8388608 | 33554432);
			}
		}
	}
}

/*
	Name: canchangestanceatcovercondition
	Namespace: archetype_human_cover
	Checksum: 0x986A3019
	Offset: 0x1990
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function canchangestanceatcovercondition(entity)
{
	switch(entity getblackboardattribute("_stance"))
	{
		case "stand":
		{
			return aiutility::isstanceallowedatnode("crouch", entity.node);
		}
		case "crouch":
		{
			return aiutility::isstanceallowedatnode("stand", entity.node);
		}
	}
	return 0;
}

/*
	Name: shouldreturntosuppressedcover
	Namespace: archetype_human_cover
	Checksum: 0x9BEB0B4B
	Offset: 0x1A38
	Size: 0x2E
	Parameters: 1
	Flags: Linked, Private
*/
private function shouldreturntosuppressedcover(entity)
{
	if(!entity isatgoal())
	{
		return 1;
	}
	return 0;
}

/*
	Name: shouldreturntocovercondition
	Namespace: archetype_human_cover
	Checksum: 0x3AD69C30
	Offset: 0x1A70
	Size: 0x18E
	Parameters: 1
	Flags: Linked, Private
*/
private function shouldreturntocovercondition(entity)
{
	if(entity asmistransitionrunning())
	{
		return 0;
	}
	if(isdefined(entity.covershootstarttime))
	{
		if(gettime() < entity.covershootstarttime + 800)
		{
			return 0;
		}
		if(isdefined(entity.enemy) && isplayer(entity.enemy) && entity.enemy.health < entity.enemy.maxhealth * 0.5)
		{
			if(gettime() < entity.covershootstarttime + 3000)
			{
				return 0;
			}
		}
	}
	if(aiutility::issuppressedatcovercondition(entity))
	{
		return 1;
	}
	if(!entity isatgoal())
	{
		if(isdefined(entity.node))
		{
			offsetorigin = entity getnodeoffsetposition(entity.node);
			return !entity isposatgoal(offsetorigin);
		}
		return 1;
	}
	if(!entity issafefromgrenade())
	{
		return 1;
	}
	return 0;
}

/*
	Name: shouldadjusttocover
	Namespace: archetype_human_cover
	Checksum: 0x958284F5
	Offset: 0x1C08
	Size: 0x14E
	Parameters: 1
	Flags: Linked, Private
*/
private function shouldadjusttocover(entity)
{
	if(!isdefined(entity.node))
	{
		return 0;
	}
	highestsupportedstance = aiutility::gethighestnodestance(entity.node);
	currentstance = entity getblackboardattribute("_stance");
	if(currentstance == "crouch" && highestsupportedstance == "crouch")
	{
		return 0;
	}
	covermode = entity getblackboardattribute("_cover_mode");
	previouscovermode = entity getblackboardattribute("_previous_cover_mode");
	if(covermode != "cover_alert" && previouscovermode != "cover_alert" && !entity.keepclaimednode)
	{
		return 1;
	}
	if(!aiutility::isstanceallowedatnode(currentstance, entity.node))
	{
		return 1;
	}
	return 0;
}

/*
	Name: shouldvantageatcovercondition
	Namespace: archetype_human_cover
	Checksum: 0xCED8E092
	Offset: 0x1D60
	Size: 0x1C2
	Parameters: 1
	Flags: Linked, Private
*/
private function shouldvantageatcovercondition(entity)
{
	if(!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin))
	{
		return 0;
	}
	yawtoenemyposition = aiutility::getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
	pitchtoenemyposition = aiutility::getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
	aimlimitsforcover = entity getaimlimitsfromentry("cover_vantage");
	legalaim = 0;
	if(yawtoenemyposition < aimlimitsforcover[#"aim_left"] && yawtoenemyposition > aimlimitsforcover[#"aim_right"] && pitchtoenemyposition < 85 && pitchtoenemyposition > 25 && entity.node.origin[2] - entity.enemy.origin[2] >= 36)
	{
		legalaim = 1;
	}
	return legalaim;
}

/*
	Name: supportsvantagecovercondition
	Namespace: archetype_human_cover
	Checksum: 0x44F445AF
	Offset: 0x1F30
	Size: 0xE
	Parameters: 1
	Flags: Linked, Private
*/
private function supportsvantagecovercondition(entity)
{
	return 0;
}

/*
	Name: covervantageinitialize
	Namespace: archetype_human_cover
	Checksum: 0x1B867163
	Offset: 0x1F48
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function covervantageinitialize(entity, asmstatename)
{
	aiutility::keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_vantage");
}

/*
	Name: coverblindfireshootactionstart
	Namespace: archetype_human_cover
	Checksum: 0x90FCB35D
	Offset: 0x1FA8
	Size: 0x6C
	Parameters: 2
	Flags: Linked, Private
*/
private function coverblindfireshootactionstart(entity, asmstatename)
{
	aiutility::keepclaimnode(entity);
	entity setblackboardattribute("_cover_mode", "cover_blind");
	aiutility::choosecoverdirection(entity);
}

/*
	Name: preparetochangestancetostand
	Namespace: archetype_human_cover
	Checksum: 0x87464423
	Offset: 0x2020
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function preparetochangestancetostand(entity, asmstatename)
{
	aiutility::cleanupcovermode(entity);
	entity setblackboardattribute("_desired_stance", "stand");
}

/*
	Name: cleanupchangestancetostand
	Namespace: archetype_human_cover
	Checksum: 0x813555C2
	Offset: 0x2080
	Size: 0x3A
	Parameters: 2
	Flags: Linked, Private
*/
private function cleanupchangestancetostand(entity, asmstatename)
{
	aiutility::releaseclaimnode(entity);
	entity.newenemyreaction = 0;
}

/*
	Name: preparetochangestancetocrouch
	Namespace: archetype_human_cover
	Checksum: 0x132638B4
	Offset: 0x20C8
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function preparetochangestancetocrouch(entity, asmstatename)
{
	aiutility::cleanupcovermode(entity);
	entity setblackboardattribute("_desired_stance", "crouch");
}

/*
	Name: cleanupchangestancetocrouch
	Namespace: archetype_human_cover
	Checksum: 0x16A47D1D
	Offset: 0x2128
	Size: 0x3A
	Parameters: 2
	Flags: Linked, Private
*/
private function cleanupchangestancetocrouch(entity, asmstatename)
{
	aiutility::releaseclaimnode(entity);
	entity.newenemyreaction = 0;
}

/*
	Name: prepareforadjusttocover
	Namespace: archetype_human_cover
	Checksum: 0x84BEB3A2
	Offset: 0x2170
	Size: 0x6C
	Parameters: 2
	Flags: Linked, Private
*/
private function prepareforadjusttocover(entity, asmstatename)
{
	aiutility::keepclaimnode(entity);
	highestsupportedstance = aiutility::gethighestnodestance(entity.node);
	entity setblackboardattribute("_desired_stance", highestsupportedstance);
}

/*
	Name: coverchangestanceactionstart
	Namespace: archetype_human_cover
	Checksum: 0xDA672929
	Offset: 0x21E8
	Size: 0xF2
	Parameters: 2
	Flags: Linked, Private
*/
private function coverchangestanceactionstart(entity, asmstatename)
{
	entity setblackboardattribute("_cover_mode", "cover_alert");
	aiutility::keepclaimnode(entity);
	switch(entity getblackboardattribute("_stance"))
	{
		case "stand":
		{
			entity setblackboardattribute("_desired_stance", "crouch");
			break;
		}
		case "crouch":
		{
			entity setblackboardattribute("_desired_stance", "stand");
			break;
		}
	}
}

/*
	Name: temp_get_arm_offset
	Namespace: archetype_human_cover
	Checksum: 0x1DDE1C8F
	Offset: 0x22E8
	Size: 0x47A
	Parameters: 2
	Flags: Linked
*/
function temp_get_arm_offset(entity, throwposition)
{
	stance = entity getblackboardattribute("_stance");
	arm_offset = undefined;
	if(stance == "crouch")
	{
		arm_offset = (13, -1, 56);
	}
	else
	{
		arm_offset = (14, -3, 80);
	}
	if(isdefined(entity.node) && entity isatcovernodestrict())
	{
		if(entity.node.type == #"hash_63cbb4767da2a801")
		{
			if(stance == "crouch")
			{
				arm_offset = (-38, 15, 23);
			}
			else
			{
				arm_offset = (-45, 0, 40);
			}
		}
		else if(entity.node.type == #"hash_2a7b1ca393696762")
		{
			if(stance == "crouch")
			{
				arm_offset = (46, 12, 26);
			}
			else
			{
				arm_offset = (34, -21, 50);
			}
		}
		else if(entity.node.type == #"hash_581529fff05853f0" || entity.node.type == #"hash_1bb444d857814e92")
		{
			arm_offset = (10, 7, 77);
		}
		else if(entity.node.type == #"hash_6d8019ab9d39bf96" || entity.node.type == #"hash_280d1247a6abdbae" || entity.node.type == #"hash_171465527444ed14")
		{
			arm_offset = (19, 5, 60);
		}
		else if(entity.node.type == #"hash_7a0e62fbbe3989d4")
		{
			leftoffset = undefined;
			rightoffset = undefined;
			if(stance == "crouch")
			{
				leftoffset = (-20, 0, 35);
				rightoffset = (34, 6, 50);
			}
			else
			{
				leftoffset = (-24, 0, 76);
				rightoffset = (24, 0, 76);
			}
			if(isdefined(entity.node.spawnflags) && entity.node.spawnflags & 1024 == 1024)
			{
				arm_offset = rightoffset;
			}
			else if(isdefined(entity.node.spawnflags) && entity.node.spawnflags & 2048 == 2048)
			{
				arm_offset = leftoffset;
			}
			else
			{
				yawtoenemyposition = angleclamp180(vectortoangles(throwposition - entity.node.origin)[1] - entity.node.angles[1]);
				aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
				legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;
				if(legalrightdirectionyaw)
				{
					arm_offset = rightoffset;
				}
				else
				{
					arm_offset = leftoffset;
				}
			}
		}
	}
	return arm_offset;
}

/*
	Name: function_f120d301
	Namespace: archetype_human_cover
	Checksum: 0xB8734A66
	Offset: 0x2770
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f120d301(entity)
{
	return ai::hasaiattribute(entity, "useGrenadeLauncher") && ai::getaiattribute(entity, "useGrenadeLauncher");
}

/*
	Name: function_ae382dda
	Namespace: archetype_human_cover
	Checksum: 0xF193D042
	Offset: 0x27C8
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ae382dda(entity)
{
	return ai::hasaiattribute(entity, "useLightningGun") && ai::getaiattribute(entity, "useLightningGun");
}

/*
	Name: function_e17114c2
	Namespace: archetype_human_cover
	Checksum: 0x9BA867C9
	Offset: 0x2820
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e17114c2(entity)
{
	return ai::hasaiattribute(entity, "useAnnihilator") && ai::getaiattribute(entity, "useAnnihilator");
}

/*
	Name: function_b1b24a11
	Namespace: archetype_human_cover
	Checksum: 0x49987CF9
	Offset: 0x2878
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b1b24a11(entity)
{
	entity.blockingpain = 1;
	entity ai::gun_switchto("hero_pineapplegun", "right");
}

/*
	Name: function_60315632
	Namespace: archetype_human_cover
	Checksum: 0xCD0D559F
	Offset: 0x28C0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_60315632(entity)
{
	entity.blockingpain = 1;
	entity ai::gun_switchto("hero_lightninggun", "right");
}

/*
	Name: function_2221fee7
	Namespace: archetype_human_cover
	Checksum: 0x86E6A342
	Offset: 0x2908
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2221fee7(entity)
{
	entity.blockingpain = 1;
	entity ai::gun_switchto("hero_annihilator", "right");
}

