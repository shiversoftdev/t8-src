// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_3aa0f32b70d4f7cb;
#using script_4a3f9b8905878272;
#using script_6809bf766eba194a;
#using script_caf007e2a98afa2;
#using scripts\core_common\math_shared.gsc;

#namespace aiutility;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: aiutility
	Checksum: 0x35A059A5
	Offset: 0x300
	Size: 0x13C4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function registerbehaviorscriptfunctions()
{
	/#
		assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
	/#
		assert(iscodefunctionptr(&btapi_locomotionbehaviorcondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_locomotionbehaviorcondition", &btapi_locomotionbehaviorcondition);
	/#
		assert(isscriptfunctionptr(&noncombatlocomotioncondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"noncombatlocomotioncondition", &noncombatlocomotioncondition);
	/#
		assert(isscriptfunctionptr(&setdesiredstanceformovement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"setdesiredstanceformovement", &setdesiredstanceformovement);
	/#
		assert(isscriptfunctionptr(&clearpathfromscript));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"clearpathfromscript", &clearpathfromscript);
	/#
		assert(isscriptfunctionptr(&locomotionshouldpatrol));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldpatrol", &locomotionshouldpatrol);
	/#
		assert(isscriptfunctionptr(&locomotionshouldpatrol));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldpatrol", &locomotionshouldpatrol);
	/#
		assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("btApi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
	/#
		assert(isscriptfunctionptr(&shouldtacticalwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldtacticalwalk", &shouldtacticalwalk);
	/#
		assert(iscodefunctionptr(&btapi_shouldtacticalwalk));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldtacticalwalk", &btapi_shouldtacticalwalk);
	/#
		assert(isscriptfunctionptr(&shouldtacticalwalk));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldtacticalwalk", &shouldtacticalwalk);
	/#
		assert(isscriptfunctionptr(&shouldadjuststanceattacticalwalk));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldadjuststanceattacticalwalk", &shouldadjuststanceattacticalwalk);
	/#
		assert(isscriptfunctionptr(&adjuststancetofaceenemyinitialize));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyinitialize", &adjuststancetofaceenemyinitialize);
	/#
		assert(isscriptfunctionptr(&adjuststancetofaceenemyterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"adjuststancetofaceenemyterminate", &adjuststancetofaceenemyterminate);
	/#
		assert(isscriptfunctionptr(&tacticalwalkactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"tacticalwalkactionstart", &tacticalwalkactionstart);
	/#
		assert(isscriptfunctionptr(&tacticalwalkactionstart));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"tacticalwalkactionstart", &tacticalwalkactionstart);
	/#
		assert(isscriptfunctionptr(&cleararrivalpos));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleararrivalpos", &cleararrivalpos);
	/#
		assert(isscriptfunctionptr(&cleararrivalpos));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"cleararrivalpos", &cleararrivalpos);
	/#
		assert(isscriptfunctionptr(&shouldstartarrivalcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstartarrival", &shouldstartarrivalcondition);
	/#
		assert(isscriptfunctionptr(&shouldstartarrivalcondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstartarrival", &shouldstartarrivalcondition);
	/#
		assert(isscriptfunctionptr(&locomotionshouldtraverse));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldtraverse", &locomotionshouldtraverse);
	/#
		assert(isscriptfunctionptr(&locomotionshouldtraverse));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldtraverse", &locomotionshouldtraverse);
	/#
		assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
	/#
		assert(isscriptfunctionptr(&locomotionshouldparametrictraverse));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldparametrictraverse", &locomotionshouldparametrictraverse);
	/#
		assert(isscriptfunctionptr(&function_5ef5b35a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7234c48b18665dc6", &function_5ef5b35a);
	/#
		assert(isscriptfunctionptr(&function_5ef5b35a));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7234c48b18665dc6", &function_5ef5b35a);
	/#
		assert(isscriptfunctionptr(&function_8a8c5d44));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
	/#
		assert(isscriptfunctionptr(&function_8a8c5d44));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4c93e133d3b1accc", &function_8a8c5d44);
	/#
		assert(isscriptfunctionptr(&traverseactionstart));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"traverseactionstart", &traverseactionstart);
	/#
		assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_5d1b3df7dd4e60c0", &wpn_debug_bot_joinleave);
	/#
		assert(isscriptfunctionptr(&traverseactionstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"traverseactionstart", &traverseactionstart);
	/#
		assert(isscriptfunctionptr(&wpn_debug_bot_joinleave));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5d1b3df7dd4e60c0", &wpn_debug_bot_joinleave);
	/#
		assert(!isdefined(&traverseactionstart) || isscriptfunctionptr(&traverseactionstart));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&wpn_debug_bot_joinleave) || isscriptfunctionptr(&wpn_debug_bot_joinleave));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"traverseactionstart", &traverseactionstart, undefined, &wpn_debug_bot_joinleave);
	/#
		assert(isscriptfunctionptr(&traversesetup));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"traversesetup", &traversesetup);
	/#
		assert(isscriptfunctionptr(&traversesetup));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"traversesetup", &traversesetup);
	/#
		assert(isscriptfunctionptr(&disablerepath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"disablerepath", &disablerepath);
	/#
		assert(isscriptfunctionptr(&enablerepath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"enablerepath", &enablerepath);
	/#
		assert(isscriptfunctionptr(&canjuke));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"canjuke", &canjuke);
	/#
		assert(isscriptfunctionptr(&choosejukedirection));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosejukedirection", &choosejukedirection);
	/#
		assert(isscriptfunctionptr(&locomotionpainbehaviorcondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionpainbehaviorcondition", &locomotionpainbehaviorcondition);
	/#
		assert(isscriptfunctionptr(&locomotionisonstairs));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionisonstairs", &locomotionisonstairs);
	/#
		assert(isscriptfunctionptr(&locomotionshouldlooponstairs));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldlooponstairs", &locomotionshouldlooponstairs);
	/#
		assert(isscriptfunctionptr(&locomotionshouldskipstairs));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldskipstairs", &locomotionshouldskipstairs);
	/#
		assert(isscriptfunctionptr(&locomotionstairsstart));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsstart", &locomotionstairsstart);
	/#
		assert(isscriptfunctionptr(&locomotionstairsend));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionstairsend", &locomotionstairsend);
	/#
		assert(isscriptfunctionptr(&delaymovement));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"delaymovement", &delaymovement);
	/#
		assert(isscriptfunctionptr(&delaymovement));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"delaymovement", &delaymovement);
}

/*
	Name: locomotionisonstairs
	Namespace: aiutility
	Checksum: 0x51DB5D78
	Offset: 0x16D0
	Size: 0x90
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionisonstairs(behaviortreeentity)
{
	startnode = behaviortreeentity.traversestartnode;
	if(isdefined(startnode) && behaviortreeentity shouldstarttraversal())
	{
		if(isdefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs"))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: locomotionshouldskipstairs
	Namespace: aiutility
	Checksum: 0x694F31AD
	Offset: 0x1768
	Size: 0x150
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionshouldskipstairs(behaviortreeentity)
{
	/#
		assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
	#/
	numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
	stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
	direction = behaviortreeentity getblackboardattribute("_staircase_direction");
	if(direction != "staircase_up")
	{
		return 0;
	}
	numoutsteps = 2;
	totalstepswithoutout = numtotalsteps - numoutsteps;
	if(stepssofar >= totalstepswithoutout)
	{
		return 0;
	}
	remainingsteps = totalstepswithoutout - stepssofar;
	if(remainingsteps >= 3 || remainingsteps >= 6 || remainingsteps >= 8)
	{
		return 1;
	}
	return 0;
}

/*
	Name: locomotionshouldlooponstairs
	Namespace: aiutility
	Checksum: 0xFBD44FEA
	Offset: 0x18C0
	Size: 0x19C
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionshouldlooponstairs(behaviortreeentity)
{
	/#
		assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
	#/
	numtotalsteps = behaviortreeentity getblackboardattribute("_staircase_num_total_steps");
	stepssofar = behaviortreeentity getblackboardattribute("_staircase_num_steps");
	exittype = behaviortreeentity getblackboardattribute("_staircase_exit_type");
	direction = behaviortreeentity getblackboardattribute("_staircase_direction");
	numoutsteps = 2;
	if(direction == "staircase_up")
	{
		switch(exittype)
		{
			case "staircase_up_exit_l_3_stairs":
			case "staircase_up_exit_r_3_stairs":
			{
				numoutsteps = 3;
				break;
			}
			case "staircase_up_exit_r_4_stairs":
			case "staircase_up_exit_l_4_stairs":
			{
				numoutsteps = 4;
				break;
			}
		}
	}
	if(stepssofar >= (numtotalsteps - numoutsteps))
	{
		behaviortreeentity setstairsexittransform();
		return 0;
	}
	return 1;
}

/*
	Name: locomotionstairsstart
	Namespace: aiutility
	Checksum: 0x22A422F0
	Offset: 0x1A68
	Size: 0x3A0
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionstairsstart(behaviortreeentity)
{
	startnode = behaviortreeentity.traversestartnode;
	endnode = behaviortreeentity.traverseendnode;
	/#
		assert(isdefined(startnode) && isdefined(endnode));
	#/
	behaviortreeentity._stairsstartnode = startnode;
	behaviortreeentity._stairsendnode = endnode;
	if(startnode.type == #"begin")
	{
		direction = "staircase_down";
	}
	else
	{
		direction = "staircase_up";
	}
	behaviortreeentity setblackboardattribute("_staircase_type", behaviortreeentity._stairsstartnode.animscript);
	behaviortreeentity setblackboardattribute("_staircase_state", "staircase_start");
	behaviortreeentity setblackboardattribute("_staircase_direction", direction);
	numtotalsteps = undefined;
	if(isdefined(startnode.script_int))
	{
		numtotalsteps = int(endnode.script_int);
	}
	else if(isdefined(endnode.script_int))
	{
		numtotalsteps = int(endnode.script_int);
	}
	/#
		assert(isdefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
	#/
	behaviortreeentity setblackboardattribute("_staircase_num_total_steps", numtotalsteps);
	behaviortreeentity setblackboardattribute("_staircase_num_steps", 0);
	exittype = undefined;
	if(direction == "staircase_up")
	{
		switch(int(behaviortreeentity._stairsstartnode.script_int) % 4)
		{
			case 0:
			{
				exittype = "staircase_up_exit_r_3_stairs";
				break;
			}
			case 1:
			{
				exittype = "staircase_up_exit_r_4_stairs";
				break;
			}
			case 2:
			{
				exittype = "staircase_up_exit_l_3_stairs";
				break;
			}
			case 3:
			{
				exittype = "staircase_up_exit_l_4_stairs";
				break;
			}
		}
	}
	else
	{
		switch(int(behaviortreeentity._stairsstartnode.script_int) % 2)
		{
			case 0:
			{
				exittype = "staircase_down_exit_l_2_stairs";
				break;
			}
			case 1:
			{
				exittype = "staircase_down_exit_r_2_stairs";
				break;
			}
		}
	}
	behaviortreeentity setblackboardattribute("_staircase_exit_type", exittype);
	return 1;
}

/*
	Name: locomotionstairloopstart
	Namespace: aiutility
	Checksum: 0xD9BCC4CB
	Offset: 0x1E10
	Size: 0x64
	Parameters: 1
	Flags: Private
*/
private function locomotionstairloopstart(behaviortreeentity)
{
	/#
		assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
	#/
	behaviortreeentity setblackboardattribute("_staircase_state", "staircase_loop");
}

/*
	Name: locomotionstairsend
	Namespace: aiutility
	Checksum: 0xC39986C1
	Offset: 0x1E80
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionstairsend(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_staircase_state", undefined);
	behaviortreeentity setblackboardattribute("_staircase_direction", undefined);
}

/*
	Name: locomotionpainbehaviorcondition
	Namespace: aiutility
	Checksum: 0x68ED932B
	Offset: 0x1ED8
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionpainbehaviorcondition(entity)
{
	return entity haspath() && entity hasvalidinterrupt("pain");
}

/*
	Name: clearpathfromscript
	Namespace: aiutility
	Checksum: 0x8E5C9B0D
	Offset: 0x1F28
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function clearpathfromscript(behaviortreeentity)
{
	behaviortreeentity clearpath();
}

/*
	Name: noncombatlocomotioncondition
	Namespace: aiutility
	Checksum: 0x4035587
	Offset: 0x1F58
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function noncombatlocomotioncondition(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire)
	{
		return 1;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		return 0;
	}
	return 1;
}

/*
	Name: combatlocomotioncondition
	Namespace: aiutility
	Checksum: 0x484BE655
	Offset: 0x1FD0
	Size: 0x68
	Parameters: 1
	Flags: Private
*/
private function combatlocomotioncondition(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire)
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		return 1;
	}
	return 0;
}

/*
	Name: setdesiredstanceformovement
	Namespace: aiutility
	Checksum: 0x691C16B
	Offset: 0x2040
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
private function setdesiredstanceformovement(behaviortreeentity)
{
	if(behaviortreeentity getblackboardattribute("_stance") != "stand")
	{
		behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	}
}

/*
	Name: locomotionshouldtraverse
	Namespace: aiutility
	Checksum: 0xBE7E677D
	Offset: 0x20A8
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionshouldtraverse(behaviortreeentity)
{
	startnode = behaviortreeentity.traversestartnode;
	if(isdefined(startnode) && behaviortreeentity shouldstarttraversal())
	{
		/#
			record3dtext("", self.origin, (1, 0, 0), "");
		#/
		return 1;
	}
	return 0;
}

/*
	Name: locomotionshouldparametrictraverse
	Namespace: aiutility
	Checksum: 0x36855DF2
	Offset: 0x2130
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
private function locomotionshouldparametrictraverse(entity)
{
	startnode = entity.traversestartnode;
	if(isdefined(startnode) && entity shouldstarttraversal())
	{
		traversaltype = entity getblackboardattribute("_parametric_traversal_type");
		/#
			record3dtext("", self.origin, (1, 0, 0), "");
		#/
		return traversaltype != "unknown_traversal";
	}
	return 0;
}

/*
	Name: function_5ef5b35a
	Namespace: aiutility
	Checksum: 0x2C577854
	Offset: 0x21E0
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5ef5b35a(behaviortreeentity)
{
	startnode = behaviortreeentity.traversestartnode;
	if(isdefined(startnode) && behaviortreeentity function_420d1e6b())
	{
		/#
			record3dtext("", self.origin, (1, 0, 0), "");
		#/
		return 1;
	}
	return 0;
}

/*
	Name: function_8a8c5d44
	Namespace: aiutility
	Checksum: 0xAC045DC6
	Offset: 0x2268
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8a8c5d44(entity)
{
	startnode = entity.traversestartnode;
	if(isdefined(startnode) && entity function_420d1e6b())
	{
		traversaltype = entity getblackboardattribute("_parametric_traversal_type");
		/#
			record3dtext("", self.origin, (1, 0, 0), "");
		#/
		return traversaltype != "unknown_traversal";
	}
	return 0;
}

/*
	Name: traversesetup
	Namespace: aiutility
	Checksum: 0xB892D16D
	Offset: 0x2318
	Size: 0x68
	Parameters: 1
	Flags: Linked, Private
*/
private function traversesetup(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_stance", "stand");
	behaviortreeentity setblackboardattribute("_traversal_type", behaviortreeentity.traversestartnode.animscript);
	return 1;
}

/*
	Name: traverseactionstart
	Namespace: aiutility
	Checksum: 0x7DCFA62E
	Offset: 0x2388
	Size: 0x210
	Parameters: 2
	Flags: Linked
*/
function traverseactionstart(behaviortreeentity, asmstatename)
{
	traversesetup(behaviortreeentity);
	if(!isdefined(asmstatename) && isdefined(self.ai.var_2b570fa6))
	{
		asmstatename = self.ai.var_2b570fa6;
	}
	behaviortreeentity.var_efe0efe7 = behaviortreeentity function_b7350442();
	behaviortreeentity.var_846d7e33 = behaviortreeentity function_f650e40b();
	behaviortreeentity allowpitchangle(0);
	behaviortreeentity clearpitchorient();
	/#
		result = behaviortreeentity astsearch(asmstatename);
		if(!isdefined(result[#"animation"]))
		{
			record3dtext("", self.origin + vectorscale((0, 0, 1), 16), (1, 0, 0), "");
		}
		else
		{
			record3dtext("" + (function_7a600918(result[#"animation"]) ? function_9e72a96(result[#"animation"]) : result[#"animation"]), self.origin + vectorscale((0, 0, 1), 16), (1, 0, 0), "");
		}
	#/
	animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
	return 5;
}

/*
	Name: wpn_debug_bot_joinleave
	Namespace: aiutility
	Checksum: 0x7D3DA67
	Offset: 0x25A0
	Size: 0x96
	Parameters: 2
	Flags: Linked
*/
function wpn_debug_bot_joinleave(behaviortreeentity, asmstatename)
{
	behaviortreeentity allowpitchangle(isdefined(behaviortreeentity.var_efe0efe7) && behaviortreeentity.var_efe0efe7);
	if(isdefined(behaviortreeentity.var_846d7e33) && behaviortreeentity.var_846d7e33)
	{
		behaviortreeentity setpitchorient();
	}
	behaviortreeentity.var_efe0efe7 = undefined;
	behaviortreeentity.var_846d7e33 = undefined;
	return 4;
}

/*
	Name: disablerepath
	Namespace: aiutility
	Checksum: 0x9C7CBE99
	Offset: 0x2640
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function disablerepath(entity)
{
	entity.disablerepath = 1;
}

/*
	Name: enablerepath
	Namespace: aiutility
	Checksum: 0x3024BB5E
	Offset: 0x2668
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
private function enablerepath(entity)
{
	entity.disablerepath = 0;
}

/*
	Name: shouldstartarrivalcondition
	Namespace: aiutility
	Checksum: 0xB9312F44
	Offset: 0x2690
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function shouldstartarrivalcondition(behaviortreeentity)
{
	if(behaviortreeentity shouldstartarrival())
	{
		return 1;
	}
	return 0;
}

/*
	Name: cleararrivalpos
	Namespace: aiutility
	Checksum: 0x3B19F646
	Offset: 0x26C8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function cleararrivalpos(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.isarrivalpending) || (isdefined(behaviortreeentity.isarrivalpending) && behaviortreeentity.isarrivalpending))
	{
		self function_d4c687c9();
	}
	return 1;
}

/*
	Name: delaymovement
	Namespace: aiutility
	Checksum: 0xA196ADB1
	Offset: 0x2728
	Size: 0x48
	Parameters: 1
	Flags: Linked
*/
function delaymovement(entity)
{
	entity pathmode("move delayed", 0, randomfloatrange(1, 2));
	return 1;
}

/*
	Name: shouldadjuststanceattacticalwalk
	Namespace: aiutility
	Checksum: 0xF29BE643
	Offset: 0x2778
	Size: 0x50
	Parameters: 1
	Flags: Linked, Private
*/
private function shouldadjuststanceattacticalwalk(behaviortreeentity)
{
	stance = behaviortreeentity getblackboardattribute("_stance");
	if(stance != "stand")
	{
		return 1;
	}
	return 0;
}

/*
	Name: adjuststancetofaceenemyinitialize
	Namespace: aiutility
	Checksum: 0xB44CF945
	Offset: 0x27D0
	Size: 0x60
	Parameters: 1
	Flags: Linked, Private
*/
private function adjuststancetofaceenemyinitialize(behaviortreeentity)
{
	behaviortreeentity.newenemyreaction = 0;
	behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	behaviortreeentity orientmode("face enemy");
	return 1;
}

/*
	Name: adjuststancetofaceenemyterminate
	Namespace: aiutility
	Checksum: 0x5734C22D
	Offset: 0x2838
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function adjuststancetofaceenemyterminate(behaviortreeentity)
{
	behaviortreeentity setblackboardattribute("_stance", "stand");
}

/*
	Name: tacticalwalkactionstart
	Namespace: aiutility
	Checksum: 0x1F0E4168
	Offset: 0x2878
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
private function tacticalwalkactionstart(behaviortreeentity)
{
	cleararrivalpos(behaviortreeentity);
	resetcoverparameters(behaviortreeentity);
	setcanbeflanked(behaviortreeentity, 0);
	behaviortreeentity setblackboardattribute("_stance", "stand");
	behaviortreeentity orientmode("face enemy");
	return 1;
}

/*
	Name: validjukedirection
	Namespace: aiutility
	Checksum: 0x85737082
	Offset: 0x2920
	Size: 0x130
	Parameters: 4
	Flags: Linked, Private
*/
private function validjukedirection(entity, entitynavmeshposition, forwardoffset, lateraloffset)
{
	jukenavmeshthreshold = 6;
	forwardposition = (entity.origin + lateraloffset) + forwardoffset;
	backwardposition = (entity.origin + lateraloffset) - forwardoffset;
	forwardpositionvalid = ispointonnavmesh(forwardposition, entity) && tracepassedonnavmesh(entity.origin, forwardposition);
	backwardpositionvalid = ispointonnavmesh(backwardposition, entity) && tracepassedonnavmesh(entity.origin, backwardposition);
	if(!isdefined(entity.ignorebackwardposition))
	{
		return forwardpositionvalid && backwardpositionvalid;
	}
	return forwardpositionvalid;
}

/*
	Name: calculatejukedirection
	Namespace: aiutility
	Checksum: 0x46F5FA11
	Offset: 0x2A60
	Size: 0x2D4
	Parameters: 3
	Flags: Linked
*/
function calculatejukedirection(entity, entityradius, jukedistance)
{
	jukenavmeshthreshold = 30;
	defaultdirection = "forward";
	if(isdefined(entity.defaultjukedirection))
	{
		defaultdirection = entity.defaultjukedirection;
	}
	if(isdefined(entity.enemy))
	{
		navmeshposition = getclosestpointonnavmesh(entity.origin, jukenavmeshthreshold);
		if(!isvec(navmeshposition))
		{
			return defaultdirection;
		}
		vectortoenemy = entity.enemy.origin - entity.origin;
		vectortoenemyangles = vectortoangles(vectortoenemy);
		forwarddistance = anglestoforward(vectortoenemyangles) * entityradius;
		rightjukedistance = anglestoright(vectortoenemyangles) * jukedistance;
		preferleft = undefined;
		if(entity haspath())
		{
			rightposition = entity.origin + rightjukedistance;
			leftposition = entity.origin - rightjukedistance;
			preferleft = distancesquared(leftposition, entity.pathgoalpos) <= distancesquared(rightposition, entity.pathgoalpos);
		}
		else
		{
			preferleft = math::cointoss();
		}
		if(preferleft)
		{
			if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1))
			{
				return "left";
			}
			if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance))
			{
				return "right";
			}
		}
		else if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance))
		{
			return "right";
		}
		if(validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1))
		{
			return "left";
		}
	}
	return defaultdirection;
}

/*
	Name: calculatedefaultjukedirection
	Namespace: aiutility
	Checksum: 0x8634E656
	Offset: 0x2D40
	Size: 0x82
	Parameters: 1
	Flags: Linked, Private
*/
private function calculatedefaultjukedirection(entity)
{
	jukedistance = 30;
	entityradius = 15;
	if(isdefined(entity.jukedistance))
	{
		jukedistance = entity.jukedistance;
	}
	if(isdefined(entity.entityradius))
	{
		entityradius = entity.entityradius;
	}
	return calculatejukedirection(entity, entityradius, jukedistance);
}

/*
	Name: canjuke
	Namespace: aiutility
	Checksum: 0x2CC1C9AB
	Offset: 0x2DD0
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function canjuke(entity)
{
	if(isdefined(entity.jukemaxdistance) && isdefined(entity.enemy))
	{
		maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
		if(distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared)
		{
			return 0;
		}
	}
	jukedirection = calculatedefaultjukedirection(entity);
	return jukedirection != "forward";
}

/*
	Name: choosejukedirection
	Namespace: aiutility
	Checksum: 0xF354215
	Offset: 0x2E98
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function choosejukedirection(entity)
{
	jukedirection = calculatedefaultjukedirection(entity);
	entity setblackboardattribute("_juke_direction", jukedirection);
}

