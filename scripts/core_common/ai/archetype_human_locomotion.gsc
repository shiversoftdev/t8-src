// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.gsc;
#using script_3aa0f32b70d4f7cb;
#using script_178024232e91b0a1;
#using script_59f07c660e6710a5;

#namespace archetype_human_locomotion;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: archetype_human_locomotion
	Checksum: 0x9B26AB12
	Offset: 0x1D0
	Size: 0xB64
	Parameters: 0
	Flags: AutoExec
*/
function autoexec registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&prepareformovement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareformovement", &prepareformovement);
	/#
		assert(isscriptfunctionptr(&prepareformovement));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"prepareformovement", &prepareformovement);
	/#
		assert(isscriptfunctionptr(&shouldtacticalarrivecondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldtacticalarrive", &shouldtacticalarrivecondition);
	/#
		assert(isscriptfunctionptr(&planhumanarrivalatcover));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"planhumanarrivalatcover", &planhumanarrivalatcover);
	/#
		assert(isscriptfunctionptr(&shouldplanarrivalintocover));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldplanarrivalintocover", &shouldplanarrivalintocover);
	/#
		assert(iscodefunctionptr(&btapi_shouldarriveexposed));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldarriveexposed", &btapi_shouldarriveexposed);
	/#
		assert(isscriptfunctionptr(&shouldarriveexposed));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldarriveexposed", &shouldarriveexposed);
	/#
		assert(iscodefunctionptr(&btapi_humannoncombatlocomotionupdate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotionupdate", &btapi_humannoncombatlocomotionupdate);
	/#
		assert(isscriptfunctionptr(&noncombatlocomotionupdate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"noncombatlocomotionupdate", &noncombatlocomotionupdate);
	/#
		assert(isscriptfunctionptr(&combatlocomotionstart));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"combatlocomotionstart", &combatlocomotionstart);
	/#
		assert(iscodefunctionptr(&btapi_combatlocomotionupdate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_combatlocomotionupdate", &btapi_combatlocomotionupdate);
	/#
		assert(isscriptfunctionptr(&combatlocomotionupdate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"combatlocomotionupdate", &combatlocomotionupdate);
	/#
		assert(iscodefunctionptr(&btapi_humannoncombatlocomotioncondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humannoncombatlocomotioncondition", &btapi_humannoncombatlocomotioncondition);
	/#
		assert(isscriptfunctionptr(&humannoncombatlocomotioncondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"humannoncombatlocomotioncondition", &humannoncombatlocomotioncondition);
	/#
		assert(iscodefunctionptr(&btapi_humancombatlocomotioncondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_humancombatlocomotioncondition", &btapi_humancombatlocomotioncondition);
	/#
		assert(isscriptfunctionptr(&humancombatlocomotioncondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"humancombatlocomotioncondition", &humancombatlocomotioncondition);
	/#
		assert(iscodefunctionptr(&btapi_shouldswitchtotacticalwalkfromrun));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldswitchtotacticalwalkfromrun", &btapi_shouldswitchtotacticalwalkfromrun);
	/#
		assert(isscriptfunctionptr(&shouldswitchtotacticalwalkfromrun));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldswitchtotacticalwalkfromrun", &shouldswitchtotacticalwalkfromrun);
	/#
		assert(isscriptfunctionptr(&preparetostopnearenemy));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetostopnearenemy", &preparetostopnearenemy);
	/#
		assert(isscriptfunctionptr(&preparetostopnearenemy));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"preparetostopnearenemy", &preparetostopnearenemy);
	/#
		assert(isscriptfunctionptr(&preparetomoveawayfromnearbyenemy));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"preparetomoveawayfromnearbyenemy", &preparetomoveawayfromnearbyenemy);
	/#
		assert(isscriptfunctionptr(&shouldtacticalwalkpain));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalkpain", &shouldtacticalwalkpain);
	/#
		assert(isscriptfunctionptr(&begintacticalwalkpain));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"begintacticalwalkpain", &begintacticalwalkpain);
	/#
		assert(isscriptfunctionptr(&shouldcontinuetacticalwalkpain));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldcontinuetacticalwalkpain", &shouldcontinuetacticalwalkpain);
	/#
		assert(isscriptfunctionptr(&shouldtacticalwalkscan));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalkscan", &shouldtacticalwalkscan);
	/#
		assert(isscriptfunctionptr(&continuetacticalwalkscan));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"continuetacticalwalkscan", &continuetacticalwalkscan);
	/#
		assert(isscriptfunctionptr(&tacticalwalkscanterminate));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"tacticalwalkscanterminate", &tacticalwalkscanterminate);
	/#
		assert(isscriptfunctionptr(&bsmlocomotionhasvalidpaininterrupt));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"bsmlocomotionhasvalidpaininterrupt", &bsmlocomotionhasvalidpaininterrupt);
}

/*
	Name: tacticalwalkscanterminate
	Namespace: archetype_human_locomotion
	Checksum: 0x50353A50
	Offset: 0xD40
	Size: 0x1E
	Parameters: 1
	Flags: Linked, Private
*/
function private tacticalwalkscanterminate(entity)
{
	entity.lasttacticalscantime = gettime();
	return true;
}

/*
	Name: shouldtacticalwalkscan
	Namespace: archetype_human_locomotion
	Checksum: 0xDFECFFAB
	Offset: 0xD68
	Size: 0x120
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldtacticalwalkscan(entity)
{
	if(isdefined(entity.lasttacticalscantime) && (entity.lasttacticalscantime + 2000) > gettime())
	{
		return 0;
	}
	if(!entity haspath())
	{
		return 0;
	}
	if(isdefined(entity.enemy))
	{
		return 0;
	}
	if(entity shouldfacemotion())
	{
		if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk"))
		{
			return 0;
		}
	}
	animation = entity asmgetcurrentdeltaanimation();
	if(isdefined(animation))
	{
		animtime = entity getanimtime(animation);
		return animtime <= 0.05;
	}
	return 0;
}

/*
	Name: continuetacticalwalkscan
	Namespace: archetype_human_locomotion
	Checksum: 0xBC1964C2
	Offset: 0xE90
	Size: 0x13C
	Parameters: 1
	Flags: Linked, Private
*/
function private continuetacticalwalkscan(entity)
{
	if(!entity haspath())
	{
		return 0;
	}
	if(isdefined(entity.enemy))
	{
		return 0;
	}
	if(entity shouldfacemotion())
	{
		if(ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk"))
		{
			return 0;
		}
	}
	animation = entity asmgetcurrentdeltaanimation();
	if(isdefined(animation))
	{
		animlength = getanimlength(animation);
		animtime = entity getanimtime(animation) * animlength;
		normalizedtime = (animtime + 0.2) / animlength;
		return normalizedtime < 1;
	}
	return 0;
}

/*
	Name: shouldtacticalwalkpain
	Namespace: archetype_human_locomotion
	Checksum: 0x886AE66
	Offset: 0xFD8
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldtacticalwalkpain(entity)
{
	if(!isdefined(entity.startpaintime) || (entity.startpaintime + 3000) < gettime() && randomfloat(1) > 0.25)
	{
		return bsmlocomotionhasvalidpaininterrupt(entity);
	}
	return 0;
}

/*
	Name: begintacticalwalkpain
	Namespace: archetype_human_locomotion
	Checksum: 0x6910DF8A
	Offset: 0x1058
	Size: 0x1E
	Parameters: 1
	Flags: Linked, Private
*/
function private begintacticalwalkpain(entity)
{
	entity.startpaintime = gettime();
	return true;
}

/*
	Name: shouldcontinuetacticalwalkpain
	Namespace: archetype_human_locomotion
	Checksum: 0x87BCF5A3
	Offset: 0x1080
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldcontinuetacticalwalkpain(entity)
{
	return (entity.startpaintime + 100) >= gettime();
}

/*
	Name: bsmlocomotionhasvalidpaininterrupt
	Namespace: archetype_human_locomotion
	Checksum: 0x1D76D2CC
	Offset: 0x10A8
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private bsmlocomotionhasvalidpaininterrupt(entity)
{
	return entity hasvalidinterrupt("pain");
}

/*
	Name: shouldarriveexposed
	Namespace: archetype_human_locomotion
	Checksum: 0x8CBE6EDB
	Offset: 0x10E0
	Size: 0xD6
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldarriveexposed(behaviortreeentity)
{
	if(behaviortreeentity ai::get_behavior_attribute("disablearrivals"))
	{
		return false;
	}
	if(behaviortreeentity haspath())
	{
		if(isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos) && distancesquared(behaviortreeentity.pathgoalpos, behaviortreeentity getnodeoffsetposition(behaviortreeentity.node)) < 8)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: preparetostopnearenemy
	Namespace: archetype_human_locomotion
	Checksum: 0x5FA64B85
	Offset: 0x11C0
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private preparetostopnearenemy(behaviortreeentity)
{
	behaviortreeentity clearpath();
	behaviortreeentity.keepclaimednode = 1;
}

/*
	Name: preparetomoveawayfromnearbyenemy
	Namespace: archetype_human_locomotion
	Checksum: 0x60402099
	Offset: 0x1200
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private preparetomoveawayfromnearbyenemy(behaviortreeentity)
{
	behaviortreeentity clearpath();
	behaviortreeentity.keepclaimednode = 1;
}

/*
	Name: shouldplanarrivalintocover
	Namespace: archetype_human_locomotion
	Checksum: 0xB27F8A3C
	Offset: 0x1240
	Size: 0x1A2
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldplanarrivalintocover(behaviortreeentity)
{
	goingtocovernode = isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node);
	if(!goingtocovernode)
	{
		return false;
	}
	if(isdefined(behaviortreeentity.pathgoalpos))
	{
		if(isdefined(behaviortreeentity.arrivalfinalpos))
		{
			if(behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos)
			{
				return true;
			}
			if(behaviortreeentity.ai.replannedcoverarrival === 0 && isdefined(behaviortreeentity.exitpos) && isdefined(behaviortreeentity.predictedexitpos))
			{
				behaviortreeentity.ai.replannedcoverarrival = 1;
				exitdir = vectornormalize(behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos);
				currentdir = vectornormalize(behaviortreeentity.origin - behaviortreeentity.exitpos);
				if(vectordot(exitdir, currentdir) < cos(30))
				{
					behaviortreeentity.predictedarrivaldirectionvalid = 0;
					return true;
				}
			}
		}
	}
	return false;
}

/*
	Name: shouldswitchtotacticalwalkfromrun
	Namespace: archetype_human_locomotion
	Checksum: 0xC1AFC909
	Offset: 0x13F0
	Size: 0x12E
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldswitchtotacticalwalkfromrun(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk"))
	{
		return true;
	}
	goalpos = undefined;
	if(isdefined(behaviortreeentity.arrivalfinalpos))
	{
		goalpos = behaviortreeentity.arrivalfinalpos;
	}
	else
	{
		goalpos = behaviortreeentity.pathgoalpos;
	}
	if(isdefined(behaviortreeentity.pathstartpos) && isdefined(goalpos))
	{
		pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
		if(pathdist < 250 * 250)
		{
			return true;
		}
	}
	if(!behaviortreeentity shouldfacemotion())
	{
		return true;
	}
	return false;
}

/*
	Name: humannoncombatlocomotioncondition
	Namespace: archetype_human_locomotion
	Checksum: 0x4213F6ED
	Offset: 0x1528
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private humannoncombatlocomotioncondition(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire)
	{
		return true;
	}
	if(behaviortreeentity humanshouldsprint())
	{
		return true;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		return false;
	}
	return true;
}

/*
	Name: humancombatlocomotioncondition
	Namespace: archetype_human_locomotion
	Checksum: 0xF3C0D2A8
	Offset: 0x15B8
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private humancombatlocomotioncondition(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire)
	{
		return false;
	}
	if(behaviortreeentity humanshouldsprint())
	{
		return false;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		return true;
	}
	return false;
}

/*
	Name: combatlocomotionstart
	Namespace: archetype_human_locomotion
	Checksum: 0x336F8601
	Offset: 0x1648
	Size: 0xE8
	Parameters: 1
	Flags: Linked, Private
*/
function private combatlocomotionstart(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	randomchance = randomint(100);
	if(randomchance > 50)
	{
		behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_forward");
		return true;
	}
	if(randomchance > 25)
	{
		behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_1");
		return true;
	}
	behaviortreeentity setblackboardattribute("_run_n_gun_variation", "variation_strafe_2");
	return true;
}

/*
	Name: noncombatlocomotionupdate
	Namespace: archetype_human_locomotion
	Checksum: 0xF5DE8066
	Offset: 0x1738
	Size: 0x106
	Parameters: 1
	Flags: Linked, Private
*/
function private noncombatlocomotionupdate(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(isdefined(behaviortreeentity.enemy) && (!(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) && !behaviortreeentity humanshouldsprint()))
	{
		return false;
	}
	if(!behaviortreeentity asmistransitionrunning())
	{
		behaviortreeentity setblackboardattribute("_stance", "stand");
		if(!isdefined(behaviortreeentity.ai.replannedcoverarrival))
		{
			behaviortreeentity.ai.replannedcoverarrival = 0;
		}
	}
	else
	{
		behaviortreeentity.ai.replannedcoverarrival = undefined;
	}
	return true;
}

/*
	Name: combatlocomotionupdate
	Namespace: archetype_human_locomotion
	Checksum: 0xE1298AAD
	Offset: 0x1848
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private combatlocomotionupdate(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(behaviortreeentity humanshouldsprint())
	{
		return false;
	}
	if(!behaviortreeentity asmistransitionrunning())
	{
		behaviortreeentity setblackboardattribute("_stance", "stand");
		if(!isdefined(behaviortreeentity.replannedcoverarrival))
		{
			behaviortreeentity.ai.replannedcoverarrival = 0;
		}
	}
	else
	{
		behaviortreeentity.ai.replannedcoverarrival = undefined;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		return true;
	}
	return false;
}

/*
	Name: prepareformovement
	Namespace: archetype_human_locomotion
	Checksum: 0xD7B3DAF7
	Offset: 0x1928
	Size: 0x38
	Parameters: 1
	Flags: Linked, Private
*/
function private prepareformovement(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_stance", "stand");
	return true;
}

/*
	Name: isarrivingfour
	Namespace: archetype_human_locomotion
	Checksum: 0xFA544260
	Offset: 0x1968
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isarrivingfour(arrivalangle)
{
	if(arrivalangle >= 45 && arrivalangle <= 120)
	{
		return true;
	}
	return false;
}

/*
	Name: isarrivingone
	Namespace: archetype_human_locomotion
	Checksum: 0xA79F8DD3
	Offset: 0x19A8
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isarrivingone(arrivalangle)
{
	if(arrivalangle >= 120 && arrivalangle <= 165)
	{
		return true;
	}
	return false;
}

/*
	Name: isarrivingtwo
	Namespace: archetype_human_locomotion
	Checksum: 0xAFE2F435
	Offset: 0x19E8
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isarrivingtwo(arrivalangle)
{
	if(arrivalangle >= 165 && arrivalangle <= 195)
	{
		return true;
	}
	return false;
}

/*
	Name: isarrivingthree
	Namespace: archetype_human_locomotion
	Checksum: 0x30475CD3
	Offset: 0x1A28
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isarrivingthree(arrivalangle)
{
	if(arrivalangle >= 195 && arrivalangle <= 240)
	{
		return true;
	}
	return false;
}

/*
	Name: isarrivingsix
	Namespace: archetype_human_locomotion
	Checksum: 0x8B649579
	Offset: 0x1A68
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isarrivingsix(arrivalangle)
{
	if(arrivalangle >= 240 && arrivalangle <= 315)
	{
		return true;
	}
	return false;
}

/*
	Name: isfacingfour
	Namespace: archetype_human_locomotion
	Checksum: 0x859D7C49
	Offset: 0x1AA8
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isfacingfour(facingangle)
{
	if(facingangle >= 45 && facingangle <= 135)
	{
		return true;
	}
	return false;
}

/*
	Name: isfacingeight
	Namespace: archetype_human_locomotion
	Checksum: 0x43A780D0
	Offset: 0x1AE8
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isfacingeight(facingangle)
{
	if(facingangle >= -45 && facingangle <= 45)
	{
		return true;
	}
	return false;
}

/*
	Name: isfacingseven
	Namespace: archetype_human_locomotion
	Checksum: 0x3B5ECB3E
	Offset: 0x1B28
	Size: 0x30
	Parameters: 1
	Flags: Linked, Private
*/
function private isfacingseven(facingangle)
{
	if(facingangle >= 0 && facingangle <= 90)
	{
		return true;
	}
	return false;
}

/*
	Name: isfacingsix
	Namespace: archetype_human_locomotion
	Checksum: 0x1386A8D
	Offset: 0x1B60
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private isfacingsix(facingangle)
{
	if(facingangle >= -135 && facingangle <= -45)
	{
		return true;
	}
	return false;
}

/*
	Name: isfacingnine
	Namespace: archetype_human_locomotion
	Checksum: 0x3954F94D
	Offset: 0x1BA0
	Size: 0x30
	Parameters: 1
	Flags: Linked, Private
*/
function private isfacingnine(facingangle)
{
	if(facingangle >= -90 && facingangle <= 0)
	{
		return true;
	}
	return false;
}

/*
	Name: shouldtacticalarrivecondition
	Namespace: archetype_human_locomotion
	Checksum: 0xC7E46B8C
	Offset: 0x1BD8
	Size: 0x3FA
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldtacticalarrivecondition(behaviortreeentity)
{
	if(getdvarint(#"enabletacticalarrival", 0) != 1)
	{
		return false;
	}
	if(!isdefined(behaviortreeentity.node))
	{
		return false;
	}
	if(!behaviortreeentity.node.type == #"cover left")
	{
		return false;
	}
	stance = behaviortreeentity getblackboardattribute("_arrival_stance");
	if(stance != "stand")
	{
		return false;
	}
	arrivaldistance = 35;
	/#
		arrivaldvar = getdvarint(#"tacarrivaldistance", 0);
		if(arrivaldvar != 0)
		{
			arrivaldistance = arrivaldvar;
		}
	#/
	nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
	if(distance(nodeoffsetposition, behaviortreeentity.origin) > arrivaldistance || distance(nodeoffsetposition, behaviortreeentity.origin) < 25)
	{
		return false;
	}
	entityangles = vectortoangles(behaviortreeentity.origin - nodeoffsetposition);
	if(abs(behaviortreeentity.node.angles[1] - entityangles[1]) < 60)
	{
		return false;
	}
	tacticalfaceangle = behaviortreeentity getblackboardattribute("_tactical_arrival_facing_yaw");
	arrivalangle = behaviortreeentity getblackboardattribute("_locomotion_arrival_yaw");
	if(isarrivingfour(arrivalangle))
	{
		if(!isfacingsix(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingfour(tacticalfaceangle))
		{
			return false;
		}
	}
	else
	{
		if(isarrivingone(arrivalangle))
		{
			if(!isfacingnine(tacticalfaceangle) && !isfacingseven(tacticalfaceangle))
			{
				return false;
			}
		}
		else
		{
			if(isarrivingtwo(arrivalangle))
			{
				if(!isfacingeight(tacticalfaceangle))
				{
					return false;
				}
			}
			else
			{
				if(isarrivingthree(arrivalangle))
				{
					if(!isfacingseven(tacticalfaceangle) && !isfacingnine(tacticalfaceangle))
					{
						return false;
					}
				}
				else
				{
					if(isarrivingsix(arrivalangle))
					{
						if(!isfacingfour(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingsix(tacticalfaceangle))
						{
							return false;
						}
					}
					else
					{
						return false;
					}
				}
			}
		}
	}
	return true;
}

/*
	Name: humanshouldsprint
	Namespace: archetype_human_locomotion
	Checksum: 0x19861863
	Offset: 0x1FE0
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private humanshouldsprint()
{
	currentlocomovementtype = self getblackboardattribute("_human_locomotion_movement_type");
	return currentlocomovementtype == "human_locomotion_movement_sprint";
}

/*
	Name: planhumanarrivalatcover
	Namespace: archetype_human_locomotion
	Checksum: 0xF81250E9
	Offset: 0x2028
	Size: 0x53C
	Parameters: 2
	Flags: Linked, Private
*/
function private planhumanarrivalatcover(behaviortreeentity, arrivalanim)
{
	if(behaviortreeentity ai::get_behavior_attribute("disablearrivals"))
	{
		return false;
	}
	behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	if(!isdefined(arrivalanim))
	{
		return false;
	}
	if(isdefined(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos))
	{
		if(!iscovernode(behaviortreeentity.node))
		{
			return false;
		}
		nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
		if(nodeoffsetposition != behaviortreeentity.pathgoalpos)
		{
			return false;
		}
		if(isdefined(arrivalanim))
		{
			isright = behaviortreeentity.node.type == #"cover right";
			splittime = getarrivalsplittime(arrivalanim, isright);
			issplitarrival = splittime < 1;
			nodeapproachyaw = behaviortreeentity getnodeoffsetangles(behaviortreeentity.node)[1];
			angle = (0, nodeapproachyaw - getangledelta(arrivalanim), 0);
			if(issplitarrival)
			{
				forwarddir = anglestoforward(angle);
				rightdir = anglestoright(angle);
				animlength = getanimlength(arrivalanim);
				movedelta = getmovedelta(arrivalanim, 0, (animlength - 0.2) / animlength);
				premovedelta = getmovedelta(arrivalanim, 0, splittime);
				postmovedelta = movedelta - premovedelta;
				forward = vectorscale(forwarddir, postmovedelta[0]);
				right = vectorscale(rightdir, postmovedelta[1]);
				coverenterpos = (nodeoffsetposition - forward) + right;
				postenterpos = coverenterpos;
				forward = vectorscale(forwarddir, premovedelta[0]);
				right = vectorscale(rightdir, premovedelta[1]);
				coverenterpos = (coverenterpos - forward) + right;
				/#
					recordline(postenterpos, nodeoffsetposition, (1, 0.5, 0), "", behaviortreeentity);
					recordline(coverenterpos, postenterpos, (1, 0.5, 0), "", behaviortreeentity);
				#/
				if(!behaviortreeentity maymovefrompointtopoint(postenterpos, nodeoffsetposition, 1, 0))
				{
					return false;
				}
				if(!behaviortreeentity maymovefrompointtopoint(coverenterpos, postenterpos, 1, 0))
				{
					return false;
				}
			}
			else
			{
				forwarddir = anglestoforward(angle);
				rightdir = anglestoright(angle);
				movedeltaarray = getmovedelta(arrivalanim);
				forward = vectorscale(forwarddir, movedeltaarray[0]);
				right = vectorscale(rightdir, movedeltaarray[1]);
				coverenterpos = (nodeoffsetposition - forward) + right;
				if(!behaviortreeentity maymovefrompointtopoint(coverenterpos, nodeoffsetposition, 1, 1))
				{
					return false;
				}
			}
			if(!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition))
			{
				return false;
			}
			if(ispointonnavmesh(coverenterpos, behaviortreeentity))
			{
				/#
					recordcircle(coverenterpos, 2, (1, 0, 0), "", behaviortreeentity);
				#/
				behaviortreeentity function_a57c34b7(coverenterpos, behaviortreeentity.pathgoalpos);
				return true;
			}
		}
	}
	return false;
}

/*
	Name: checkcoverarrivalconditions
	Namespace: archetype_human_locomotion
	Checksum: 0x2D3D570A
	Offset: 0x2570
	Size: 0x2F4
	Parameters: 2
	Flags: Linked, Private
*/
function private checkcoverarrivalconditions(coverenterpos, coverpos)
{
	distsqtonode = distancesquared(self.origin, coverpos);
	distsqfromnodetoenterpos = distancesquared(coverpos, coverenterpos);
	awayfromenterpos = distsqtonode >= (distsqfromnodetoenterpos + 150);
	if(!awayfromenterpos)
	{
		return false;
	}
	trace = groundtrace(coverenterpos + vectorscale((0, 0, 1), 72), coverenterpos + (vectorscale((0, 0, -1), 72)), 0, 0, 0);
	if(isdefined(trace[#"position"]) && (abs(trace[#"position"][2] - coverpos[2])) > 30)
	{
		/#
			if(getdvarint(#"ai_debugarrivals", 0))
			{
				recordcircle(coverenterpos, 1, (1, 0, 0), "");
				record3dtext("", coverenterpos, (1, 0, 0), "", undefined, 0.4);
				recordcircle(trace[#"position"], 1, (1, 0, 0), "");
				record3dtext("" + (int(abs(trace[#"position"][2] - coverpos[2]))), trace[#"position"] + vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
				record3dtext("" + 30, trace[#"position"], (1, 0, 0), "", undefined, 0.4);
				recordline(coverenterpos, trace[#"position"], (1, 0, 0), "");
			}
		#/
		return false;
	}
	return true;
}

/*
	Name: getarrivalsplittime
	Namespace: archetype_human_locomotion
	Checksum: 0xAD8D39EF
	Offset: 0x2870
	Size: 0x102
	Parameters: 2
	Flags: Linked, Private
*/
function private getarrivalsplittime(arrivalanim, isright)
{
	if(!isdefined(level.animarrivalsplittimes))
	{
		level.animarrivalsplittimes = [];
	}
	if(isdefined(level.animarrivalsplittimes[arrivalanim]))
	{
		return level.animarrivalsplittimes[arrivalanim];
	}
	bestsplit = -1;
	if(animhasnotetrack(arrivalanim, "cover_split"))
	{
		times = getnotetracktimes(arrivalanim, "cover_split");
		/#
			assert(times.size > 0);
		#/
		bestsplit = times[0];
	}
	else
	{
		bestsplit = 0.4;
	}
	level.animarrivalsplittimes[arrivalanim] = bestsplit;
	return bestsplit;
}

/*
	Name: deltarotate
	Namespace: archetype_human_locomotion
	Checksum: 0xD054026A
	Offset: 0x2980
	Size: 0x9A
	Parameters: 2
	Flags: Private
*/
function private deltarotate(delta, yaw)
{
	cosine = cos(yaw);
	sine = sin(yaw);
	return ((delta[0] * cosine) - (delta[1] * sine), (delta[1] * cosine) + (delta[0] * sine), 0);
}

