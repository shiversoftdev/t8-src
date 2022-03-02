// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3aa0f32b70d4f7cb;
#using script_4c5c4a64a59247a2;
#using script_54ad756f68b48e83;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace aiutility;

/*
	Name: registerbehaviorscriptfunctions
	Namespace: aiutility
	Checksum: 0xBA68F7E7
	Offset: 0x7F0
	Size: 0x21F4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec registerbehaviorscriptfunctions()
{
	/#
		assert(iscodefunctionptr(&btapi_forceragdoll));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_forceragdoll", &btapi_forceragdoll);
	/#
		assert(iscodefunctionptr(&btapi_hasammo));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasammo", &btapi_hasammo);
	/#
		assert(iscodefunctionptr(&btapi_haslowammo));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_haslowammo", &btapi_haslowammo);
	/#
		assert(iscodefunctionptr(&btapi_hasenemy));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_hasenemy", &btapi_hasenemy);
	/#
		assert(iscodefunctionptr(&btapi_issafefromgrenades));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_issafefromgrenades", &btapi_issafefromgrenades);
	/#
		assert(isscriptfunctionptr(&issafefromgrenades));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"issafefromgrenades", &issafefromgrenades);
	/#
		assert(isscriptfunctionptr(&ingrenadeblastradius));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"ingrenadeblastradius", &ingrenadeblastradius);
	/#
		assert(isscriptfunctionptr(&recentlysawenemy));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"recentlysawenemy", &recentlysawenemy);
	/#
		assert(isscriptfunctionptr(&shouldbeaggressive));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldbeaggressive", &shouldbeaggressive);
	/#
		assert(isscriptfunctionptr(&shouldonlyfireaccurately));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldonlyfireaccurately", &shouldonlyfireaccurately);
	/#
		assert(isscriptfunctionptr(&shouldreacttonewenemy));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldreacttonewenemy", &shouldreacttonewenemy);
	/#
		assert(isscriptfunctionptr(&shouldreacttonewenemy));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldreacttonewenemy", &shouldreacttonewenemy);
	/#
		assert(isscriptfunctionptr(&hasweaponmalfunctioned));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hasweaponmalfunctioned", &hasweaponmalfunctioned);
	/#
		assert(isscriptfunctionptr(&shouldstopmoving));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstopmoving", &shouldstopmoving);
	/#
		assert(isscriptfunctionptr(&shouldstopmoving));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldstopmoving", &shouldstopmoving);
	/#
		assert(isscriptfunctionptr(&choosebestcovernodeasap));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"choosebestcovernodeasap", &choosebestcovernodeasap);
	/#
		assert(isscriptfunctionptr(&choosebettercoverservicecodeversion));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion, 1);
	/#
		assert(iscodefunctionptr(&btapi_trackcoverparamsservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_trackcoverparamsservice", &btapi_trackcoverparamsservice);
	/#
		assert(isscriptfunctionptr(&trackcoverparamsservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"trackcoverparamsservice", &trackcoverparamsservice);
	/#
		assert(iscodefunctionptr(&btapi_refillammoifneededservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_refillammoifneededservice", &btapi_refillammoifneededservice);
	/#
		assert(isscriptfunctionptr(&refillammo));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoifneededservice", &refillammo);
	/#
		assert(isscriptfunctionptr(&trystoppingservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"trystoppingservice", &trystoppingservice);
	/#
		assert(isscriptfunctionptr(&isfrustrated));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isfrustrated", &isfrustrated);
	/#
		assert(iscodefunctionptr(&btapi_updatefrustrationlevel));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_updatefrustrationlevel", &btapi_updatefrustrationlevel);
	/#
		assert(isscriptfunctionptr(&updatefrustrationlevel));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"updatefrustrationlevel", &updatefrustrationlevel);
	/#
		assert(isscriptfunctionptr(&islastknownenemypositionapproachable));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"islastknownenemypositionapproachable", &islastknownenemypositionapproachable);
	/#
		assert(isscriptfunctionptr(&tryadvancingonlastknownpositionbehavior));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryadvancingonlastknownpositionbehavior", &tryadvancingonlastknownpositionbehavior);
	/#
		assert(isscriptfunctionptr(&trygoingtoclosestnodetoenemybehavior));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"trygoingtoclosestnodetoenemybehavior", &trygoingtoclosestnodetoenemybehavior);
	/#
		assert(isscriptfunctionptr(&tryrunningdirectlytoenemybehavior));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"tryrunningdirectlytoenemybehavior", &tryrunningdirectlytoenemybehavior);
	/#
		assert(isscriptfunctionptr(&flagenemyunattackableservice));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"flagenemyunattackableservice", &flagenemyunattackableservice);
	/#
		assert(isscriptfunctionptr(&keepclaimnode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimnode", &keepclaimnode);
	/#
		assert(isscriptfunctionptr(&keepclaimnode));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"keepclaimnode", &keepclaimnode);
	/#
		assert(isscriptfunctionptr(&releaseclaimnode));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"releaseclaimnode", &releaseclaimnode);
	/#
		assert(isscriptfunctionptr(&releaseclaimnode));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"releaseclaimnode", &releaseclaimnode);
	/#
		assert(isscriptfunctionptr(&scriptstartragdoll));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"startragdoll", &scriptstartragdoll);
	/#
		assert(isscriptfunctionptr(&notstandingcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"notstandingcondition", &notstandingcondition);
	/#
		assert(isscriptfunctionptr(&notcrouchingcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"notcrouchingcondition", &notcrouchingcondition);
	/#
		assert(isscriptfunctionptr(&meleeacquiremutex));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleeacquiremutex", &meleeacquiremutex);
	/#
		assert(isscriptfunctionptr(&meleereleasemutex));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"meleereleasemutex", &meleereleasemutex);
	/#
		assert(isscriptfunctionptr(&prepareforexposedmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"prepareforexposedmelee", &prepareforexposedmelee);
	/#
		assert(isscriptfunctionptr(&cleanupmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupmelee", &cleanupmelee);
	/#
		assert(iscodefunctionptr(&btapi_shouldnormalmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
	/#
		assert(iscodefunctionptr(&btapi_shouldnormalmelee));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldnormalmelee", &btapi_shouldnormalmelee);
	/#
		assert(isscriptfunctionptr(&shouldnormalmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldnormalmelee", &shouldnormalmelee);
	/#
		assert(iscodefunctionptr(&btapi_shouldmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldmelee", &btapi_shouldmelee);
	/#
		assert(iscodefunctionptr(&btapi_shouldmelee));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldmelee", &btapi_shouldmelee);
	/#
		assert(isscriptfunctionptr(&shouldmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldmelee", &shouldmelee);
	/#
		assert(isscriptfunctionptr(&shouldmelee));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"shouldmelee", &shouldmelee);
	/#
		assert(isscriptfunctionptr(&hascloseenemytomelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hascloseenemymelee", &hascloseenemytomelee);
	/#
		assert(isscriptfunctionptr(&isbalconydeath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isbalconydeath", &isbalconydeath);
	/#
		assert(isscriptfunctionptr(&balconydeath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"balconydeath", &balconydeath);
	/#
		assert(isscriptfunctionptr(&usecurrentposition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"usecurrentposition", &usecurrentposition);
	/#
		assert(isscriptfunctionptr(&isunarmed));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isunarmed", &isunarmed);
	/#
		assert(iscodefunctionptr(&btapi_shouldchargemelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
	/#
		assert(isscriptfunctionptr(&shouldchargemelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchargemelee", &shouldchargemelee);
	/#
		assert(iscodefunctionptr(&btapi_shouldchargemelee));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"btapi_shouldchargemelee", &btapi_shouldchargemelee);
	/#
		assert(isscriptfunctionptr(&shouldattackinchargemelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackinchargemelee", &shouldattackinchargemelee);
	/#
		assert(isscriptfunctionptr(&cleanupchargemelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemelee", &cleanupchargemelee);
	/#
		assert(isscriptfunctionptr(&cleanupchargemeleeattack));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupchargemeleeattack", &cleanupchargemeleeattack);
	/#
		assert(isscriptfunctionptr(&setupchargemeleeattack));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupchargemeleeattack", &setupchargemeleeattack);
	/#
		assert(isscriptfunctionptr(&shouldchoosespecialpain));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpain", &shouldchoosespecialpain);
	/#
		assert(isscriptfunctionptr(&function_9b0e7a22));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_50fc16dcf1175197", &function_9b0e7a22);
	/#
		assert(isscriptfunctionptr(&shouldchoosespecialpronepain));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronepain", &shouldchoosespecialpronepain);
	/#
		assert(isscriptfunctionptr(&function_89cb7bfd));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_78675d76c0c51e10", &function_89cb7bfd);
	/#
		assert(isscriptfunctionptr(&shouldchoosespecialdeath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialdeath", &shouldchoosespecialdeath);
	/#
		assert(isscriptfunctionptr(&shouldchoosespecialpronedeath));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldchoosespecialpronedeath", &shouldchoosespecialpronedeath);
	/#
		assert(isscriptfunctionptr(&setupexplosionanimscale));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"setupexplosionanimscale", &setupexplosionanimscale);
	/#
		assert(isscriptfunctionptr(&shouldstealth));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealth", &shouldstealth);
	/#
		assert(isscriptfunctionptr(&stealthreactcondition));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactcondition", &stealthreactcondition);
	/#
		assert(isscriptfunctionptr(&locomotionshouldstealth));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"locomotionshouldstealth", &locomotionshouldstealth);
	/#
		assert(isscriptfunctionptr(&shouldstealthresume));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldstealthresume", &shouldstealthresume);
	/#
		assert(isscriptfunctionptr(&locomotionshouldstealth));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"locomotionshouldstealth", &locomotionshouldstealth);
	/#
		assert(isscriptfunctionptr(&stealthreactcondition));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"stealthreactcondition", &stealthreactcondition);
	/#
		assert(isscriptfunctionptr(&stealthreactstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactstart", &stealthreactstart);
	/#
		assert(isscriptfunctionptr(&stealthreactterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthreactterminate", &stealthreactterminate);
	/#
		assert(isscriptfunctionptr(&stealthidleterminate));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"stealthidleterminate", &stealthidleterminate);
	/#
		assert(iscodefunctionptr(&btapi_isinphalanx));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isinphalanx", &btapi_isinphalanx);
	/#
		assert(isscriptfunctionptr(&isinphalanx));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanx", &isinphalanx);
	/#
		assert(isscriptfunctionptr(&isinphalanxstance));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isinphalanxstance", &isinphalanxstance);
	/#
		assert(isscriptfunctionptr(&togglephalanxstance));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"togglephalanxstance", &togglephalanxstance);
	/#
		assert(isscriptfunctionptr(&isatattackobject));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatattackobject", &isatattackobject);
	/#
		assert(isscriptfunctionptr(&shouldattackobject));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldattackobject", &shouldattackobject);
	/#
		assert(isscriptfunctionptr(&function_81c32010));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_554e27065bc759d9", &function_81c32010);
	behaviortreenetworkutility::registerbehaviortreeaction(#"defaultaction", undefined, undefined, undefined);
	archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

/*
	Name: bb_getstairsnumskipsteps
	Namespace: aiutility
	Checksum: 0xA4DE3D3A
	Offset: 0x29F0
	Size: 0x162
	Parameters: 0
	Flags: Linked, Private
*/
function private bb_getstairsnumskipsteps()
{
	/#
		assert(isdefined(self._stairsstartnode) && isdefined(self._stairsendnode));
	#/
	numtotalsteps = self getblackboardattribute("_staircase_num_total_steps");
	stepssofar = self getblackboardattribute("_staircase_num_steps");
	direction = self getblackboardattribute("_staircase_direction");
	numoutsteps = 2;
	totalstepswithoutout = numtotalsteps - numoutsteps;
	/#
		assert(stepssofar < totalstepswithoutout);
	#/
	remainingsteps = totalstepswithoutout - stepssofar;
	if(remainingsteps >= 8)
	{
		return "staircase_skip_8";
	}
	if(remainingsteps >= 6)
	{
		return "staircase_skip_6";
	}
	/#
		assert(remainingsteps >= 3);
	#/
	return "staircase_skip_3";
}

/*
	Name: bb_gettraversalheight
	Namespace: aiutility
	Checksum: 0xEF6B7B6C
	Offset: 0x2B60
	Size: 0x264
	Parameters: 0
	Flags: Linked, Private
*/
function private bb_gettraversalheight()
{
	entity = self;
	startposition = entity.traversalstartpos;
	endposition = entity.traversalendpos;
	if(isdefined(entity.traveseheightoverride))
	{
		/#
			record3dtext("" + entity.traveseheightoverride, self.origin + vectorscale((0, 0, 1), 32), (1, 0, 0), "");
		#/
		return entity.traveseheightoverride;
	}
	if(isdefined(entity.traversemantlenode))
	{
		pivotorigin = archetype_mocomps_utility::calculatepivotoriginfromedge(entity, entity.traversemantlenode, entity.origin);
		traversalheight = pivotorigin[2] - (isdefined(entity.var_fad2bca9) && entity.var_fad2bca9 && (isdefined(entity.traversalstartpos) ? entity.traversalstartpos[2] : entity.origin[2]));
		/#
			record3dtext("" + traversalheight, self.origin + vectorscale((0, 0, 1), 32), (1, 0, 0), "");
		#/
		return traversalheight;
	}
	if(isdefined(startposition) && isdefined(endposition))
	{
		traversalheight = endposition[2] - startposition[2];
		if(bb_getparametrictraversaltype() == "jump_across_traversal")
		{
			traversalheight = abs(traversalheight);
		}
		/#
			record3dtext("" + traversalheight, self.origin + vectorscale((0, 0, 1), 32), (1, 0, 0), "");
		#/
		return traversalheight;
	}
	return 0;
}

/*
	Name: bb_gettraversalwidth
	Namespace: aiutility
	Checksum: 0x769E4324
	Offset: 0x2DD0
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
function private bb_gettraversalwidth()
{
	entity = self;
	startposition = entity.traversalstartpos;
	endposition = entity.traversalendpos;
	if(isdefined(entity.travesewidthoverride))
	{
		/#
			record3dtext("" + entity.travesewidthoverride, self.origin + vectorscale((0, 0, 1), 48), (1, 0, 0), "");
		#/
		return entity.travesewidthoverride;
	}
	if(isdefined(startposition) && isdefined(endposition))
	{
		var_d4b651b8 = distance2d(startposition, endposition);
		/#
			record3dtext("" + var_d4b651b8, self.origin + vectorscale((0, 0, 1), 48), (1, 0, 0), "");
		#/
		return var_d4b651b8;
	}
	return 0;
}

/*
	Name: function_a0d0fc27
	Namespace: aiutility
	Checksum: 0x56732A42
	Offset: 0x2F10
	Size: 0x112
	Parameters: 4
	Flags: Linked
*/
function function_a0d0fc27(entity, startnode, endnode, mantlenode)
{
	/#
		assert(isdefined(startnode));
	#/
	/#
		assert(isdefined(endnode));
	#/
	/#
		assert(isdefined(mantlenode));
	#/
	if(!(isdefined(entity.var_20e07206) && entity.var_20e07206))
	{
		return;
	}
	if(isdefined(mantlenode.var_d2a62948) && mantlenode.var_d2a62948)
	{
		return;
	}
	heightdiff = abs(endnode.origin[2] - startnode.origin[2]);
	if(heightdiff > 40)
	{
		mantlenode.var_d2a62948 = 1;
	}
}

/*
	Name: function_b882ba71
	Namespace: aiutility
	Checksum: 0x7B4AA76
	Offset: 0x3030
	Size: 0x104
	Parameters: 4
	Flags: Linked
*/
function function_b882ba71(entity, startnode, endnode, mantlenode)
{
	/#
		assert(isdefined(startnode));
	#/
	/#
		assert(isdefined(endnode));
	#/
	/#
		assert(isdefined(mantlenode));
	#/
	var_3efada15 = abs(startnode.origin[2] - mantlenode.origin[2]);
	var_6d4236a3 = abs(endnode.origin[2] - mantlenode.origin[2]);
	if(var_3efada15 > var_6d4236a3)
	{
		return var_3efada15;
	}
	return var_6d4236a3;
}

/*
	Name: bb_getparametrictraversaltype
	Namespace: aiutility
	Checksum: 0x40F39B85
	Offset: 0x3140
	Size: 0x42E
	Parameters: 0
	Flags: Linked
*/
function bb_getparametrictraversaltype()
{
	entity = self;
	startposition = entity.traversalstartpos;
	endposition = entity.traversalendpos;
	if(function_f99d2668())
	{
		entity.traveseheightoverride = undefined;
	}
	if(isdefined(entity.travesetypeoverride))
	{
		return entity.travesetypeoverride;
	}
	if(!isdefined(entity.traversestartnode) || entity.traversestartnode.type != "Volume" || (!isdefined(entity.traverseendnode) || entity.traverseendnode.type != "Volume"))
	{
		return "unknown_traversal";
	}
	if(isdefined(entity.traversestartnode) && isdefined(entity.traversemantlenode))
	{
		function_a0d0fc27(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode);
		if(function_f99d2668() && (isdefined(entity.traversemantlenode.var_d2a62948) && entity.traversemantlenode.var_d2a62948))
		{
			entity.traveseheightoverride = abs(function_b882ba71(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode));
		}
		if(isdefined(entity.traversemantlenode.var_d2a62948) && entity.traversemantlenode.var_d2a62948 && (isdefined(entity.var_2c628c0f) && entity.var_2c628c0f))
		{
			isendpointaboveorsamelevel = startposition[2] < endposition[2];
			traversaltype = "jump_down_mantle_traversal";
			if(isendpointaboveorsamelevel)
			{
				traversaltype = "jump_up_mantle_traversal";
			}
			if(function_f99d2668())
			{
				entity.traveseheightoverride = function_b882ba71(entity, entity.traversestartnode, entity.traverseendnode, entity.traversemantlenode);
				if(traversaltype == "jump_down_mantle_traversal")
				{
					entity.traveseheightoverride = entity.traveseheightoverride * -1;
				}
			}
			return traversaltype;
		}
		return "mantle_traversal";
	}
	if(isdefined(startposition) && isdefined(endposition))
	{
		traversaldistance = distance2d(startposition, endposition);
		isendpointaboveorsamelevel = startposition[2] <= endposition[2];
		if(traversaldistance >= 108 && (abs(endposition[2] - startposition[2])) <= 100)
		{
			return "jump_across_traversal";
		}
		if(isendpointaboveorsamelevel)
		{
			if(isdefined(entity.traverseendnode.var_446fcc3b) && entity.traverseendnode.var_446fcc3b && (isdefined(entity.var_1731eda3) && entity.var_1731eda3))
			{
				return "jump_up_hanging_traversal";
			}
			return "jump_up_traversal";
		}
		return "jump_down_traversal";
	}
	return "unknown_traversal";
}

/*
	Name: bb_getawareness
	Namespace: aiutility
	Checksum: 0xC83A34E
	Offset: 0x3578
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function bb_getawareness()
{
	return self.awarenesslevelcurrent;
}

/*
	Name: bb_getawarenessprevious
	Namespace: aiutility
	Checksum: 0x4B7F790B
	Offset: 0x3590
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function bb_getawarenessprevious()
{
	return self.awarenesslevelprevious;
}

/*
	Name: function_cc26899f
	Namespace: aiutility
	Checksum: 0x6DAE3713
	Offset: 0x35A8
	Size: 0xB2
	Parameters: 0
	Flags: Linked
*/
function function_cc26899f()
{
	if(isdefined(self.zombie_move_speed))
	{
		if(self.zombie_move_speed == "walk")
		{
			return "locomotion_speed_walk";
		}
		if(self.zombie_move_speed == "run")
		{
			return "locomotion_speed_run";
		}
		if(self.zombie_move_speed == "sprint")
		{
			return "locomotion_speed_sprint";
		}
		if(self.zombie_move_speed == "super_sprint")
		{
			return "locomotion_speed_super_sprint";
		}
		if(self.zombie_move_speed == "super_super_sprint")
		{
			return "locomotion_speed_super_super_sprint";
		}
	}
	return "locomotion_speed_walk";
}

/*
	Name: bb_getgibbedlimbs
	Namespace: aiutility
	Checksum: 0x685B9669
	Offset: 0x3668
	Size: 0xA6
	Parameters: 0
	Flags: Linked, Private
*/
function private bb_getgibbedlimbs()
{
	entity = self;
	rightarmgibbed = gibserverutils::isgibbed(entity, 16);
	leftarmgibbed = gibserverutils::isgibbed(entity, 32);
	if(rightarmgibbed && leftarmgibbed)
	{
		return "both_arms";
	}
	if(rightarmgibbed)
	{
		return "right_arm";
	}
	if(leftarmgibbed)
	{
		return "left_arm";
	}
	return "none";
}

/*
	Name: bb_getyawtocovernode
	Namespace: aiutility
	Checksum: 0x6A0BCD47
	Offset: 0x3718
	Size: 0x102
	Parameters: 0
	Flags: Linked, Private
*/
function private bb_getyawtocovernode()
{
	if(!isdefined(self.node))
	{
		return 0;
	}
	disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);
	if(isdefined(self.keepclaimednode) && self.keepclaimednode)
	{
		if(disttonodesqr > 64 * 64)
		{
			return 0;
		}
	}
	else if(disttonodesqr > 24 * 24)
	{
		return 0;
	}
	angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
	return angletonode;
}

/*
	Name: bb_gethigheststance
	Namespace: aiutility
	Checksum: 0x590445B7
	Offset: 0x3828
	Size: 0x82
	Parameters: 0
	Flags: None
*/
function bb_gethigheststance()
{
	if(self isatcovernodestrict() && self shouldusecovernode())
	{
		higheststance = gethighestnodestance(self.node);
		return higheststance;
	}
	return self getblackboardattribute("_stance");
}

/*
	Name: bb_getlocomotionfaceenemyquadrantprevious
	Namespace: aiutility
	Checksum: 0x19BAFD99
	Offset: 0x38B8
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function bb_getlocomotionfaceenemyquadrantprevious()
{
	if(isdefined(self.prevrelativedir))
	{
		direction = self.prevrelativedir;
		switch(direction)
		{
			case 0:
			{
				return "locomotion_face_enemy_none";
			}
			case 1:
			{
				return "locomotion_face_enemy_front";
			}
			case 2:
			{
				return "locomotion_face_enemy_right";
			}
			case 3:
			{
				return "locomotion_face_enemy_left";
			}
			case 4:
			{
				return "locomotion_face_enemy_back";
			}
		}
	}
	return "locomotion_face_enemy_none";
}

/*
	Name: bb_getcurrentcovernodetype
	Namespace: aiutility
	Checksum: 0x9DB29EE7
	Offset: 0x3980
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function bb_getcurrentcovernodetype()
{
	return getcovertype(self.node);
}

/*
	Name: bb_getcoverconcealed
	Namespace: aiutility
	Checksum: 0xC1870DC2
	Offset: 0x39A8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function bb_getcoverconcealed()
{
	if(iscoverconcealed(self.node))
	{
		return "concealed";
	}
	return "unconcealed";
}

/*
	Name: bb_getcurrentlocationcovernodetype
	Namespace: aiutility
	Checksum: 0xCDDB28A9
	Offset: 0x39E0
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function bb_getcurrentlocationcovernodetype()
{
	if(isdefined(self.node) && distancesquared(self.origin, self.node.origin) < (48 * 48))
	{
		return bb_getcurrentcovernodetype();
	}
	return bb_getpreviouscovernodetype();
}

/*
	Name: bb_getshouldturn
	Namespace: aiutility
	Checksum: 0xB0C525FB
	Offset: 0x3A58
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function bb_getshouldturn()
{
	if(isdefined(self.should_turn) && self.should_turn)
	{
		return "should_turn";
	}
	return "should_not_turn";
}

/*
	Name: bb_getarmsposition
	Namespace: aiutility
	Checksum: 0xEAE9A500
	Offset: 0x3A90
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function bb_getarmsposition()
{
	if(isdefined(self.zombie_arms_position))
	{
		if(self.zombie_arms_position == "up")
		{
			return "arms_up";
		}
		return "arms_down";
	}
	return "arms_up";
}

/*
	Name: bb_gethaslegsstatus
	Namespace: aiutility
	Checksum: 0x52357467
	Offset: 0x3AD8
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function bb_gethaslegsstatus()
{
	if(self.missinglegs)
	{
		return "has_legs_no";
	}
	return "has_legs_yes";
}

/*
	Name: function_f61d3341
	Namespace: aiutility
	Checksum: 0x3F90F896
	Offset: 0x3B00
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_f61d3341()
{
	if(gibserverutils::isgibbed(self, 256))
	{
		return "has_left_leg_no";
	}
	return "has_left_leg_yes";
}

/*
	Name: function_9b395e55
	Namespace: aiutility
	Checksum: 0xBFD04108
	Offset: 0x3B38
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_9b395e55()
{
	if(gibserverutils::isgibbed(self, 128))
	{
		return "has_right_leg_no";
	}
	return "has_right_leg_yes";
}

/*
	Name: function_99e55609
	Namespace: aiutility
	Checksum: 0x7CB8E60F
	Offset: 0x3B70
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_99e55609()
{
	if(gibserverutils::isgibbed(self, 32))
	{
		return "has_left_arm_no";
	}
	return "has_left_arm_yes";
}

/*
	Name: function_aa8f1e69
	Namespace: aiutility
	Checksum: 0xFC043C2
	Offset: 0x3BA8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_aa8f1e69()
{
	if(gibserverutils::isgibbed(self, 16))
	{
		return "has_right_arm_no";
	}
	return "has_right_arm_yes";
}

/*
	Name: function_5b03a448
	Namespace: aiutility
	Checksum: 0xA1253C04
	Offset: 0x3BE0
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function function_5b03a448()
{
	if(isdefined(self.var_beb2295))
	{
		return "has_grapplee_yes";
	}
	return "has_grapplee_no";
}

/*
	Name: actorgetpredictedyawtoenemy
	Namespace: aiutility
	Checksum: 0x1F9444D8
	Offset: 0x3C08
	Size: 0x16E
	Parameters: 2
	Flags: Linked
*/
function actorgetpredictedyawtoenemy(entity, lookaheadtime)
{
	if(isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime())
	{
		return entity.predictedyawtoenemy;
	}
	selfpredictedpos = entity.origin;
	moveangle = entity.angles[1] + entity getmotionangle();
	selfpredictedpos = selfpredictedpos + (((cos(moveangle), sin(moveangle), 0) * 200) * lookaheadtime);
	yaw = (vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1]) - entity.angles[1];
	yaw = absangleclamp360(yaw);
	entity.predictedyawtoenemy = yaw;
	entity.predictedyawtoenemytime = gettime();
	return yaw;
}

/*
	Name: bb_actorispatroling
	Namespace: aiutility
	Checksum: 0x74A18853
	Offset: 0x3D80
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function bb_actorispatroling()
{
	entity = self;
	if(entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol"))
	{
		return "patrol_enabled";
	}
	return "patrol_disabled";
}

/*
	Name: bb_actorhasenemy
	Namespace: aiutility
	Checksum: 0x1CE4B463
	Offset: 0x3DE8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function bb_actorhasenemy()
{
	entity = self;
	if(isdefined(entity.enemy))
	{
		return "has_enemy";
	}
	return "no_enemy";
}

/*
	Name: bb_actorgetenemyyaw
	Namespace: aiutility
	Checksum: 0xE85625C2
	Offset: 0x3E28
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function bb_actorgetenemyyaw()
{
	enemy = self.enemy;
	if(!isdefined(enemy))
	{
		return 0;
	}
	toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
	return toenemyyaw;
}

/*
	Name: bb_actorgetperfectenemyyaw
	Namespace: aiutility
	Checksum: 0x6A731D8A
	Offset: 0x3E80
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function bb_actorgetperfectenemyyaw()
{
	enemy = self.enemy;
	if(!isdefined(enemy))
	{
		return 0;
	}
	toenemyyaw = (vectortoangles(enemy.origin - self.origin)[1]) - self.angles[1];
	toenemyyaw = absangleclamp360(toenemyyaw);
	/#
		recordenttext("" + toenemyyaw, self, (1, 0, 0), "");
	#/
	return toenemyyaw;
}

/*
	Name: function_caea19a8
	Namespace: aiutility
	Checksum: 0xA21E8E23
	Offset: 0x3F38
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_caea19a8()
{
	result = self.angles[1];
	v_origin = self geteventpointofinterest();
	if(!isdefined(v_origin) && isdefined(self.ai.var_2a2d6d17))
	{
		v_origin = self.ai.var_2a2d6d17.origin;
	}
	if(isdefined(v_origin))
	{
		str_typename = self getcurrenteventtypename();
		e_originator = self getcurrenteventoriginator();
		if(str_typename == "bullet" && isdefined(e_originator))
		{
			v_origin = e_originator.origin;
		}
		deltaorigin = v_origin - self.origin;
		result = vectortoangles(deltaorigin)[1];
	}
	return result;
}

/*
	Name: bb_actorgetreactyaw
	Namespace: aiutility
	Checksum: 0x9EC53214
	Offset: 0x4068
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function bb_actorgetreactyaw()
{
	return absangleclamp360(self.angles[1] - self getblackboardattribute("_react_yaw_world"));
}

/*
	Name: getangleusingdirection
	Namespace: aiutility
	Checksum: 0xE6088AD3
	Offset: 0x40B8
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function getangleusingdirection(direction)
{
	directionyaw = vectortoangles(direction)[1];
	yawdiff = directionyaw - self.angles[1];
	yawdiff = yawdiff * 0.002777778;
	flooredyawdiff = floor(yawdiff + 0.5);
	turnangle = (yawdiff - flooredyawdiff) * 360;
	return absangleclamp360(turnangle);
}

/*
	Name: wasatcovernode
	Namespace: aiutility
	Checksum: 0x588B17D3
	Offset: 0x4180
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function wasatcovernode()
{
	if(isdefined(self.prevnode))
	{
		if(self.prevnode.type == #"hash_63cbb4767da2a801" || self.prevnode.type == #"hash_2a7b1ca393696762" || self.prevnode.type == #"hash_7a0e62fbbe3989d4" || (self.prevnode.type == #"hash_581529fff05853f0" || self.prevnode.type == #"hash_1bb444d857814e92") || (self.prevnode.type == #"hash_6d8019ab9d39bf96" || self.prevnode.type == #"hash_280d1247a6abdbae" || self.prevnode.type == #"hash_171465527444ed14"))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: bb_getlocomotionexityaw
	Namespace: aiutility
	Checksum: 0xE8B0C578
	Offset: 0x42C8
	Size: 0x64E
	Parameters: 2
	Flags: Linked
*/
function bb_getlocomotionexityaw(blackboard, yaw)
{
	if(self haspath())
	{
		predictedlookaheadinfo = self predictexit();
		status = predictedlookaheadinfo[#"path_prediction_status"];
		if(!isdefined(self.pathgoalpos))
		{
			return -1;
		}
		if(status == 3)
		{
			start = self.origin;
			end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
			angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
			exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
			/#
				record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
			#/
			return exityaw;
		}
		if(status == 4)
		{
			start = self.origin;
			end = start + vectorscale((0, predictedlookaheadinfo[#"path_prediction_travel_vector"][1], 0), 100);
			angletoexit = vectortoangles(predictedlookaheadinfo[#"path_prediction_travel_vector"])[1];
			exityaw = absangleclamp360(angletoexit - self.angles[1]);
			/#
				record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
			#/
			return exityaw;
		}
		if(status == 0)
		{
			if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25)
			{
				end = self.pathgoalpos;
				angletodestination = vectortoangles(end - self.origin)[1];
				exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);
				/#
					record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
				#/
				return exityaw;
			}
			start = predictedlookaheadinfo[#"path_prediction_start_point"];
			end = start + predictedlookaheadinfo[#"path_prediction_travel_vector"];
			exityaw = getangleusingdirection(predictedlookaheadinfo[#"path_prediction_travel_vector"]);
			/#
				record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
			#/
			return exityaw;
		}
		if(status == 2)
		{
			if(wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25)
			{
				end = self.pathgoalpos;
				angletodestination = vectortoangles(end - self.origin)[1];
				exityaw = absangleclamp360(angletodestination - self.prevnode.angles[1]);
				/#
					record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
				#/
				return exityaw;
			}
			exityaw = getangleusingdirection(vectornormalize(self.pathgoalpos - self.origin));
			/#
				record3dtext("" + int(exityaw), self.origin - vectorscale((0, 0, 1), 5), (1, 0, 0), "", undefined, 0.4);
			#/
			return exityaw;
		}
	}
	return -1;
}

/*
	Name: bb_getlocomotionfaceenemyquadrant
	Namespace: aiutility
	Checksum: 0xD12C3602
	Offset: 0x4920
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function bb_getlocomotionfaceenemyquadrant()
{
	/#
		walkstring = getdvarstring(#"tacticalwalkdirection");
		switch(walkstring)
		{
			case "right":
			{
				return "";
			}
			case "left":
			{
				return "";
			}
			case "back":
			{
				return "";
			}
		}
	#/
	if(isdefined(self.relativedir))
	{
		direction = self.relativedir;
		switch(direction)
		{
			case 0:
			{
				return "locomotion_face_enemy_front";
			}
			case 1:
			{
				return "locomotion_face_enemy_front";
			}
			case 2:
			{
				return "locomotion_face_enemy_right";
			}
			case 3:
			{
				return "locomotion_face_enemy_left";
			}
			case 4:
			{
				return "locomotion_face_enemy_back";
			}
		}
	}
	return "locomotion_face_enemy_front";
}

/*
	Name: bb_getlocomotionpaintype
	Namespace: aiutility
	Checksum: 0x5F4BFADE
	Offset: 0x4A78
	Size: 0x272
	Parameters: 0
	Flags: Linked
*/
function bb_getlocomotionpaintype()
{
	if(self haspath())
	{
		predictedlookaheadinfo = self predictpath();
		status = predictedlookaheadinfo[#"path_prediction_status"];
		startpos = self.origin;
		furthestpointtowardsgoalclear = 1;
		if(status == 2)
		{
			furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
			furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
		}
		if(furthestpointtowardsgoalclear)
		{
			forwarddir = anglestoforward(self.angles);
			possiblepaintypes = [];
			endpos = startpos + vectorscale(forwarddir, 300);
			if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0))
			{
				possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
			}
			endpos = startpos + vectorscale(forwarddir, 200);
			if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0))
			{
				possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
			}
			endpos = startpos + vectorscale(forwarddir, 150);
			if(self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0))
			{
				possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
			}
			if(possiblepaintypes.size)
			{
				return array::random(possiblepaintypes);
			}
		}
	}
	return "locomotion_inplace_pain";
}

/*
	Name: bb_getlookaheadangle
	Namespace: aiutility
	Checksum: 0x96C5A87E
	Offset: 0x4CF8
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function bb_getlookaheadangle()
{
	return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

/*
	Name: bb_getpreviouscovernodetype
	Namespace: aiutility
	Checksum: 0x9D2180C2
	Offset: 0x4D48
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function bb_getpreviouscovernodetype()
{
	return getcovertype(self.prevnode);
}

/*
	Name: bb_actorgettrackingturnyaw
	Namespace: aiutility
	Checksum: 0xDF11439D
	Offset: 0x4D70
	Size: 0x306
	Parameters: 0
	Flags: Linked
*/
function bb_actorgettrackingturnyaw()
{
	var_71a0045b = undefined;
	if(isdefined(self.enemy))
	{
		if(self cansee(self.enemy))
		{
			var_71a0045b = self.enemy.origin;
		}
		else if(issentient(self.enemy))
		{
			if(self.highlyawareradius && distance2dsquared(self.enemy.origin, self.origin) < (self.highlyawareradius * self.highlyawareradius))
			{
				var_71a0045b = self.enemy.origin;
			}
			else
			{
				var_18c9035f = self function_18c9035f(self.enemy);
				attackedrecently = self attackedrecently(self.enemy, 2);
				if(attackedrecently && isdefined(var_18c9035f))
				{
					if(self canshoot(var_18c9035f))
					{
						var_71a0045b = self.var_18c9035f;
					}
				}
				if(!isdefined(var_71a0045b))
				{
					if(issentient(self.enemy))
					{
						lastknownpostime = self lastknowntime(self.enemy);
						lastknownpos = self lastknownpos(self.enemy);
					}
					else
					{
						lastknownpostime = gettime();
						lastknownpos = self.enemy.origin;
					}
					if(gettime() <= (lastknownpostime + 2))
					{
						if(sighttracepassed(self geteye(), lastknownpos, 0, self, self.enemy))
						{
							var_71a0045b = lastknownpos;
						}
					}
				}
			}
		}
	}
	else
	{
		if(isdefined(self.ai.var_3af1add3))
		{
			var_71a0045b = [[self.ai.var_3af1add3]](self);
		}
		else if(isdefined(self.likelyenemyposition))
		{
			if(self canshoot(self.likelyenemyposition))
			{
				var_71a0045b = self.likelyenemyposition;
			}
		}
	}
	if(isdefined(var_71a0045b))
	{
		turnyaw = absangleclamp360(self.angles[1] - (vectortoangles(var_71a0045b - self.origin)[1]));
		return turnyaw;
	}
	return 0;
}

/*
	Name: bb_getweaponclass
	Namespace: aiutility
	Checksum: 0x6A3ADFD7
	Offset: 0x5080
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function bb_getweaponclass()
{
	return "rifle";
}

/*
	Name: function_6f949118
	Namespace: aiutility
	Checksum: 0x51E54E2C
	Offset: 0x5098
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_6f949118()
{
	angles = self gettagangles("tag_origin");
	return angleclamp180(angles[0]);
}

/*
	Name: function_38855dc8
	Namespace: aiutility
	Checksum: 0xA4A779B2
	Offset: 0x50F0
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_38855dc8()
{
	if(!isdefined(self.favoriteenemy))
	{
		return 0;
	}
	velocity = self.favoriteenemy getvelocity();
	return length(velocity);
}

/*
	Name: function_ebaa4b7c
	Namespace: aiutility
	Checksum: 0x8FC8F2A0
	Offset: 0x5148
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_ebaa4b7c()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}
	return self.enemy.origin[2] - self.origin[2];
}

/*
	Name: notstandingcondition
	Namespace: aiutility
	Checksum: 0xDB392358
	Offset: 0x5188
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function notstandingcondition(behaviortreeentity)
{
	if(behaviortreeentity getblackboardattribute("_stance") != "stand")
	{
		return true;
	}
	return false;
}

/*
	Name: notcrouchingcondition
	Namespace: aiutility
	Checksum: 0x36D1B7D2
	Offset: 0x51D0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function notcrouchingcondition(behaviortreeentity)
{
	if(behaviortreeentity getblackboardattribute("_stance") != "crouch")
	{
		return true;
	}
	return false;
}

/*
	Name: scriptstartragdoll
	Namespace: aiutility
	Checksum: 0xCD9607E
	Offset: 0x5218
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function scriptstartragdoll(behaviortreeentity)
{
	behaviortreeentity startragdoll();
}

/*
	Name: prepareforexposedmelee
	Namespace: aiutility
	Checksum: 0x955A3675
	Offset: 0x5248
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private prepareforexposedmelee(behaviortreeentity)
{
	keepclaimnode(behaviortreeentity);
	meleeacquiremutex(behaviortreeentity);
	currentstance = behaviortreeentity getblackboardattribute("_stance");
	if(isdefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly")
	{
		behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
	}
	if(currentstance == "crouch")
	{
		behaviortreeentity setblackboardattribute("_desired_stance", "stand");
	}
}

/*
	Name: isfrustrated
	Namespace: aiutility
	Checksum: 0xF17973FD
	Offset: 0x5348
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function isfrustrated(behaviortreeentity)
{
	return isdefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0;
}

/*
	Name: clampfrustration
	Namespace: aiutility
	Checksum: 0x3754C62B
	Offset: 0x5390
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function clampfrustration(frustrationlevel)
{
	if(frustrationlevel > 4)
	{
		return 4;
	}
	if(frustrationlevel < 0)
	{
		return 0;
	}
	return frustrationlevel;
}

/*
	Name: updatefrustrationlevel
	Namespace: aiutility
	Checksum: 0x3B3D6277
	Offset: 0x53D0
	Size: 0x42E
	Parameters: 1
	Flags: Linked
*/
function updatefrustrationlevel(entity)
{
	if(!isdefined(entity.ai.frustrationlevel))
	{
		entity.ai.frustrationlevel = 0;
	}
	if(!isdefined(entity.enemy))
	{
		entity.ai.frustrationlevel = 0;
		return false;
	}
	/#
		record3dtext("" + entity.ai.frustrationlevel, entity.origin, (1, 0.5, 0), "");
	#/
	if(isactor(entity.enemy) || isplayer(entity.enemy))
	{
		if(entity.ai.aggressivemode)
		{
			if(!isdefined(entity.ai.lastfrustrationboost))
			{
				entity.ai.lastfrustrationboost = gettime();
			}
			if(entity.ai.lastfrustrationboost + 5000 < gettime())
			{
				entity.ai.frustrationlevel++;
				entity.ai.lastfrustrationboost = gettime();
				entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
			}
		}
		isawareofenemy = (gettime() - entity lastknowntime(entity.enemy)) < (int(10 * 1000));
		if(entity.ai.frustrationlevel == 4)
		{
			hasseenenemy = entity seerecently(entity.enemy, 2);
		}
		else
		{
			hasseenenemy = entity seerecently(entity.enemy, 5);
		}
		hasattackedenemyrecently = entity attackedrecently(entity.enemy, 5);
		if(!isawareofenemy || isactor(entity.enemy))
		{
			if(!hasseenenemy)
			{
				entity.ai.frustrationlevel++;
			}
			else if(!hasattackedenemyrecently)
			{
				entity.ai.frustrationlevel = entity.ai.frustrationlevel + 2;
			}
			entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
			return true;
		}
		if(hasattackedenemyrecently)
		{
			entity.ai.frustrationlevel = entity.ai.frustrationlevel - 2;
			entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
			return true;
		}
		if(hasseenenemy)
		{
			entity.ai.frustrationlevel--;
			entity.ai.frustrationlevel = clampfrustration(entity.ai.frustrationlevel);
			return true;
		}
	}
	return false;
}

/*
	Name: flagenemyunattackableservice
	Namespace: aiutility
	Checksum: 0xFB956162
	Offset: 0x5808
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function flagenemyunattackableservice(behaviortreeentity)
{
	behaviortreeentity flagenemyunattackable();
}

/*
	Name: islastknownenemypositionapproachable
	Namespace: aiutility
	Checksum: 0xF7122A8A
	Offset: 0x5838
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function islastknownenemypositionapproachable(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy))
	{
		lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
		if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: tryadvancingonlastknownpositionbehavior
	Namespace: aiutility
	Checksum: 0xC5E32208
	Offset: 0x58D8
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function tryadvancingonlastknownpositionbehavior(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy))
	{
		if(isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode)
		{
			lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
			if(behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0))
			{
				behaviortreeentity function_a57c34b7(lastknownpositionofenemy, lastknownpositionofenemy);
				setnextfindbestcovertime(behaviortreeentity, undefined);
				return true;
			}
		}
	}
	return false;
}

/*
	Name: trygoingtoclosestnodetoenemybehavior
	Namespace: aiutility
	Checksum: 0xDC923C28
	Offset: 0x59E0
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function trygoingtoclosestnodetoenemybehavior(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy))
	{
		closestrandomnode = behaviortreeentity findbestcovernodes(behaviortreeentity.engagemaxdist, behaviortreeentity.enemy.origin)[0];
		if(isdefined(closestrandomnode) && behaviortreeentity isingoal(closestrandomnode.origin) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0))
		{
			usecovernodewrapper(behaviortreeentity, closestrandomnode);
			return true;
		}
	}
	return false;
}

/*
	Name: tryrunningdirectlytoenemybehavior
	Namespace: aiutility
	Checksum: 0x53A4E744
	Offset: 0x5AD0
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function tryrunningdirectlytoenemybehavior(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy) && (isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode))
	{
		origin = behaviortreeentity.enemy.origin;
		if(behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0))
		{
			behaviortreeentity function_a57c34b7(origin, origin);
			setnextfindbestcovertime(behaviortreeentity, undefined);
			return true;
		}
	}
	return false;
}

/*
	Name: shouldreacttonewenemy
	Namespace: aiutility
	Checksum: 0xDCDFA404
	Offset: 0x5BD0
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function shouldreacttonewenemy(behaviortreeentity)
{
	return false;
}

/*
	Name: hasweaponmalfunctioned
	Namespace: aiutility
	Checksum: 0xA0BE632D
	Offset: 0x5C70
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function hasweaponmalfunctioned(behaviortreeentity)
{
	return isdefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

/*
	Name: issafefromgrenades
	Namespace: aiutility
	Checksum: 0x4CA3F3F2
	Offset: 0x5CA0
	Size: 0x186
	Parameters: 1
	Flags: Linked
*/
function issafefromgrenades(entity)
{
	if(isdefined(entity.grenade) && isdefined(entity.grenade.weapon) && entity.grenade !== entity.knowngrenade && !entity issafefromgrenade())
	{
		if(isdefined(entity.node))
		{
			offsetorigin = entity getnodeoffsetposition(entity.node);
			percentradius = distance(entity.grenade.origin, offsetorigin);
			if(entity.grenadeawareness >= percentradius)
			{
				return true;
			}
		}
		else
		{
			percentradius = distance(entity.grenade.origin, entity.origin) / entity.grenade.weapon.explosionradius;
			if(entity.grenadeawareness >= percentradius)
			{
				return true;
			}
		}
		entity.knowngrenade = entity.grenade;
		return false;
	}
	return true;
}

/*
	Name: ingrenadeblastradius
	Namespace: aiutility
	Checksum: 0xB10DB48C
	Offset: 0x5E30
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function ingrenadeblastradius(entity)
{
	return !entity issafefromgrenade();
}

/*
	Name: recentlysawenemy
	Namespace: aiutility
	Checksum: 0x32E224C3
	Offset: 0x5E60
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function recentlysawenemy(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6))
	{
		return true;
	}
	return false;
}

/*
	Name: shouldonlyfireaccurately
	Namespace: aiutility
	Checksum: 0x65D26053
	Offset: 0x5EC0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function shouldonlyfireaccurately(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire)
	{
		return true;
	}
	return false;
}

/*
	Name: shouldbeaggressive
	Namespace: aiutility
	Checksum: 0x266BDC16
	Offset: 0x5F00
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function shouldbeaggressive(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.ai.aggressivemode) && behaviortreeentity.ai.aggressivemode)
	{
		return true;
	}
	return false;
}

/*
	Name: usecovernodewrapper
	Namespace: aiutility
	Checksum: 0xC3FB5BC4
	Offset: 0x5F50
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function usecovernodewrapper(behaviortreeentity, node)
{
	samenode = behaviortreeentity.node === node;
	behaviortreeentity usecovernode(node);
	if(!samenode)
	{
		behaviortreeentity setblackboardattribute("_cover_mode", "cover_mode_none");
		behaviortreeentity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
	}
	setnextfindbestcovertime(behaviortreeentity, node);
}

/*
	Name: setnextfindbestcovertime
	Namespace: aiutility
	Checksum: 0x42CAA252
	Offset: 0x6018
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function setnextfindbestcovertime(behaviortreeentity, node)
{
	behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

/*
	Name: trackcoverparamsservice
	Namespace: aiutility
	Checksum: 0xBC411721
	Offset: 0x6078
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function trackcoverparamsservice(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode())
	{
		if(!isdefined(behaviortreeentity.covernode))
		{
			behaviortreeentity.covernode = behaviortreeentity.node;
			setnextfindbestcovertime(behaviortreeentity, behaviortreeentity.node);
		}
		return;
	}
	behaviortreeentity.covernode = undefined;
}

/*
	Name: choosebestcovernodeasap
	Namespace: aiutility
	Checksum: 0xD333B2AF
	Offset: 0x6128
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function choosebestcovernodeasap(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.enemy))
	{
		return false;
	}
	node = getbestcovernodeifavailable(behaviortreeentity);
	if(isdefined(node))
	{
		usecovernodewrapper(behaviortreeentity, node);
	}
}

/*
	Name: shouldchoosebettercover
	Namespace: aiutility
	Checksum: 0xEDFB2E0F
	Offset: 0x6190
	Size: 0x43C
	Parameters: 1
	Flags: Linked
*/
function shouldchoosebettercover(behaviortreeentity)
{
	if(behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth"))
	{
		return 0;
	}
	if(isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover)
	{
		return 0;
	}
	if(behaviortreeentity isinanybadplace())
	{
		return 1;
	}
	if(isdefined(behaviortreeentity.enemy))
	{
		shouldusecovernoderesult = 0;
		shouldbeboredatcurrentcover = 0;
		abouttoarriveatcover = 0;
		iswithineffectiverangealready = 0;
		islookingaroundforenemy = 0;
		if(behaviortreeentity shouldholdgroundagainstenemy())
		{
			return 0;
		}
		if(behaviortreeentity haspath() && isdefined(behaviortreeentity.arrivalfinalpos) && isdefined(behaviortreeentity.pathgoalpos) && self.pathgoalpos == behaviortreeentity.arrivalfinalpos)
		{
			if(distancesquared(behaviortreeentity.origin, behaviortreeentity.arrivalfinalpos) < 4096)
			{
				abouttoarriveatcover = 1;
			}
		}
		shouldusecovernoderesult = behaviortreeentity shouldusecovernode();
		if(self isatgoal())
		{
			if(shouldusecovernoderesult && isdefined(behaviortreeentity.node) && self isatgoal())
			{
				lastknownpos = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
				dist = distance2d(behaviortreeentity.origin, lastknownpos);
				if(dist > behaviortreeentity.engageminfalloffdist && dist <= behaviortreeentity.engagemaxfalloffdist)
				{
					iswithineffectiverangealready = 1;
				}
			}
			shouldbeboredatcurrentcover = !iswithineffectiverangealready && behaviortreeentity isatcovernode() && gettime() > self.nextfindbestcovertime;
			if(!shouldusecovernoderesult)
			{
				if(isdefined(behaviortreeentity.ai.frustrationlevel) && behaviortreeentity.ai.frustrationlevel > 0 && behaviortreeentity haspath())
				{
					islookingaroundforenemy = 1;
				}
			}
		}
		shouldlookforbettercover = !islookingaroundforenemy && !abouttoarriveatcover && !iswithineffectiverangealready && (!shouldusecovernoderesult || shouldbeboredatcurrentcover || !self isatgoal());
		/#
			if(shouldlookforbettercover)
			{
				color = (0, 1, 0);
			}
			else
			{
				color = (1, 0, 0);
			}
			recordenttext((((((((("" + shouldusecovernoderesult) + "") + islookingaroundforenemy) + "") + abouttoarriveatcover) + "") + iswithineffectiverangealready) + "") + shouldbeboredatcurrentcover, behaviortreeentity, color, "");
		#/
	}
	else
	{
		return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
	}
	return shouldlookforbettercover;
}

/*
	Name: choosebettercoverservicecodeversion
	Namespace: aiutility
	Checksum: 0xA81A88A
	Offset: 0x65D8
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function choosebettercoverservicecodeversion(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.stealth) && behaviortreeentity ai::get_behavior_attribute("stealth"))
	{
		return false;
	}
	if(isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover)
	{
		return false;
	}
	if(isdefined(behaviortreeentity.knowngrenade))
	{
		return false;
	}
	if(!issafefromgrenades(behaviortreeentity))
	{
		behaviortreeentity.nextfindbestcovertime = 0;
	}
	if(isdefined(behaviortreeentity.keepclaimednode) && behaviortreeentity.keepclaimednode)
	{
		return false;
	}
	newnode = behaviortreeentity choosebettercovernode();
	if(isdefined(newnode))
	{
		usecovernodewrapper(behaviortreeentity, newnode);
		return true;
	}
	setnextfindbestcovertime(behaviortreeentity, undefined);
	return false;
}

/*
	Name: choosebettercoverservice
	Namespace: aiutility
	Checksum: 0x9BF66C4F
	Offset: 0x6708
	Size: 0x196
	Parameters: 1
	Flags: Private
*/
function private choosebettercoverservice(behaviortreeentity)
{
	shouldchoosebettercoverresult = shouldchoosebettercover(behaviortreeentity);
	if(shouldchoosebettercoverresult && !behaviortreeentity.keepclaimednode)
	{
		transitionrunning = behaviortreeentity asmistransitionrunning();
		substatepending = behaviortreeentity asmissubstatepending();
		transdecrunning = behaviortreeentity asmistransdecrunning();
		isbehaviortreeinrunningstate = behaviortreeentity getbehaviortreestatus() == 5;
		if(!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate)
		{
			node = getbestcovernodeifavailable(behaviortreeentity);
			goingtodifferentnode = isdefined(node) && (!isdefined(behaviortreeentity.node) || node != behaviortreeentity.node);
			if(goingtodifferentnode)
			{
				usecovernodewrapper(behaviortreeentity, node);
				return true;
			}
			setnextfindbestcovertime(behaviortreeentity, undefined);
		}
	}
	return false;
}

/*
	Name: refillammo
	Namespace: aiutility
	Checksum: 0xDC5880DD
	Offset: 0x68A8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function refillammo(behaviortreeentity)
{
	if(behaviortreeentity.weapon != level.weaponnone)
	{
		behaviortreeentity.ai.bulletsinclip = behaviortreeentity.weapon.clipsize;
	}
}

/*
	Name: getbestcovernodeifavailable
	Namespace: aiutility
	Checksum: 0xA92D4B15
	Offset: 0x6900
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function getbestcovernodeifavailable(behaviortreeentity)
{
	node = behaviortreeentity findbestcovernode();
	if(!isdefined(node))
	{
		return undefined;
	}
	if(behaviortreeentity nearclaimnode())
	{
		currentnode = self.node;
	}
	if(isdefined(currentnode) && node == currentnode)
	{
		return undefined;
	}
	if(isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode)
	{
		return undefined;
	}
	return node;
}

/*
	Name: getsecondbestcovernodeifavailable
	Namespace: aiutility
	Checksum: 0x6E82F465
	Offset: 0x69B8
	Size: 0xE6
	Parameters: 1
	Flags: None
*/
function getsecondbestcovernodeifavailable(behaviortreeentity)
{
	nodes = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.origin);
	if(nodes.size > 1)
	{
		node = nodes[1];
	}
	if(!isdefined(node))
	{
		return undefined;
	}
	if(behaviortreeentity nearclaimnode())
	{
		currentnode = self.node;
	}
	if(isdefined(currentnode) && node == currentnode)
	{
		return undefined;
	}
	if(isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode)
	{
		return undefined;
	}
	return node;
}

/*
	Name: getcovertype
	Namespace: aiutility
	Checksum: 0xA77F51BF
	Offset: 0x6AA8
	Size: 0x19A
	Parameters: 1
	Flags: Linked
*/
function getcovertype(node)
{
	if(isdefined(node))
	{
		if(node.type == #"hash_7a0e62fbbe3989d4")
		{
			return "cover_pillar";
		}
		if(node.type == #"hash_63cbb4767da2a801")
		{
			return "cover_left";
		}
		if(node.type == #"hash_2a7b1ca393696762")
		{
			return "cover_right";
		}
		if(node.type == #"hash_581529fff05853f0" || node.type == #"hash_1bb444d857814e92")
		{
			return "cover_stand";
		}
		if(node.type == #"hash_6d8019ab9d39bf96" || node.type == #"hash_280d1247a6abdbae" || node.type == #"hash_171465527444ed14")
		{
			return "cover_crouch";
		}
		if(node.type == #"exposed" || node.type == #"guard")
		{
			return "cover_exposed";
		}
	}
	return "cover_none";
}

/*
	Name: iscoverconcealed
	Namespace: aiutility
	Checksum: 0x67A065DD
	Offset: 0x6C50
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function iscoverconcealed(node)
{
	if(isdefined(node))
	{
		return node.type == #"hash_171465527444ed14" || node.type == #"hash_1bb444d857814e92";
	}
	return 0;
}

/*
	Name: canseeenemywrapper
	Namespace: aiutility
	Checksum: 0x7168AC47
	Offset: 0x6CB0
	Size: 0x4C2
	Parameters: 0
	Flags: None
*/
function canseeenemywrapper()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}
	if(!isdefined(self.node))
	{
		return self cansee(self.enemy);
	}
	node = self.node;
	enemyeye = self.enemy geteye();
	yawtoenemy = angleclamp180(node.angles[1] - (vectortoangles(enemyeye - node.origin)[1]));
	if(node.type == #"hash_63cbb4767da2a801" || node.type == #"hash_2a7b1ca393696762")
	{
		if(yawtoenemy > 60 || yawtoenemy < -60)
		{
			return 0;
		}
		if(isdefined(node.spawnflags) && (node.spawnflags & 4) == 4)
		{
			if(node.type == #"hash_63cbb4767da2a801" && yawtoenemy > 10)
			{
				return 0;
			}
			if(node.type == #"hash_2a7b1ca393696762" && yawtoenemy < -10)
			{
				return 0;
			}
		}
	}
	nodeoffset = (0, 0, 0);
	if(node.type == #"hash_7a0e62fbbe3989d4")
	{
		/#
			assert(!(isdefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || (!(isdefined(node.spawnflags) && (node.spawnflags & 1024) == 1024)));
		#/
		canseefromleft = 1;
		canseefromright = 1;
		nodeoffset = (-32, 3.7, 60);
		lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
		canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
		nodeoffset = (32, 3.7, 60);
		lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
		canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
		return canseefromright || canseefromleft;
	}
	if(node.type == #"hash_63cbb4767da2a801")
	{
		nodeoffset = (-36, 7, 63);
	}
	else
	{
		if(node.type == #"hash_2a7b1ca393696762")
		{
			nodeoffset = (36, 7, 63);
		}
		else
		{
			if(node.type == #"hash_581529fff05853f0" || node.type == #"hash_1bb444d857814e92")
			{
				nodeoffset = (-3.7, -22, 63);
			}
			else if(node.type == #"hash_6d8019ab9d39bf96" || node.type == #"hash_280d1247a6abdbae" || node.type == #"hash_171465527444ed14")
			{
				nodeoffset = (3.5, -12.5, 45);
			}
		}
	}
	lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
	if(sighttracepassed(lookfrompoint, enemyeye, 0, undefined))
	{
		return 1;
	}
	return 0;
}

/*
	Name: calculatenodeoffsetposition
	Namespace: aiutility
	Checksum: 0x21330360
	Offset: 0x7180
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function calculatenodeoffsetposition(node, nodeoffset)
{
	right = anglestoright(node.angles);
	forward = anglestoforward(node.angles);
	return (node.origin + vectorscale(right, nodeoffset[0])) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

/*
	Name: gethighestnodestance
	Namespace: aiutility
	Checksum: 0xDB3CBE0A
	Offset: 0x7228
	Size: 0x16A
	Parameters: 1
	Flags: Linked
*/
function gethighestnodestance(node)
{
	/#
		assert(isdefined(node));
	#/
	if(isdefined(node.spawnflags) && (node.spawnflags & 4) == 4)
	{
		return "stand";
	}
	if(isdefined(node.spawnflags) && (node.spawnflags & 8) == 8)
	{
		return "crouch";
	}
	if(isdefined(node.spawnflags) && (node.spawnflags & 16) == 16)
	{
		return "prone";
	}
	/#
		errormsg(((node.type + "") + node.origin) + "");
	#/
	if(node.type == #"hash_6d8019ab9d39bf96" || node.type == #"hash_280d1247a6abdbae" || node.type == #"hash_171465527444ed14")
	{
		return "crouch";
	}
	return "stand";
}

/*
	Name: isstanceallowedatnode
	Namespace: aiutility
	Checksum: 0xDEA45D6
	Offset: 0x73A0
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function isstanceallowedatnode(stance, node)
{
	/#
		assert(isdefined(stance));
	#/
	/#
		assert(isdefined(node));
	#/
	if(stance == "stand" && (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4))
	{
		return true;
	}
	if(stance == "crouch" && (isdefined(node.spawnflags) && (node.spawnflags & 8) == 8))
	{
		return true;
	}
	if(stance == "prone" && (isdefined(node.spawnflags) && (node.spawnflags & 16) == 16))
	{
		return true;
	}
	return false;
}

/*
	Name: trystoppingservice
	Namespace: aiutility
	Checksum: 0x44120FA3
	Offset: 0x74C0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function trystoppingservice(behaviortreeentity)
{
	if(behaviortreeentity shouldholdgroundagainstenemy())
	{
		behaviortreeentity clearpath();
		behaviortreeentity.keepclaimednode = 1;
		return true;
	}
	behaviortreeentity.keepclaimednode = 0;
	return false;
}

/*
	Name: shouldstopmoving
	Namespace: aiutility
	Checksum: 0x8677A63D
	Offset: 0x7528
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function shouldstopmoving(behaviortreeentity)
{
	if(behaviortreeentity shouldholdgroundagainstenemy())
	{
		return true;
	}
	return false;
}

/*
	Name: setcurrentweapon
	Namespace: aiutility
	Checksum: 0xAD8BE9D9
	Offset: 0x7560
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function setcurrentweapon(weapon)
{
	self.weapon = weapon;
	self.weaponclass = weapon.weapclass;
	if(weapon != level.weaponnone)
	{
		/#
			assert(isdefined(weapon.worldmodel), ("" + weapon.name) + "");
		#/
	}
	self.weaponmodel = weapon.worldmodel;
}

/*
	Name: setprimaryweapon
	Namespace: aiutility
	Checksum: 0xAABAA136
	Offset: 0x7600
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function setprimaryweapon(weapon)
{
	self.primaryweapon = weapon;
	self.primaryweaponclass = weapon.weapclass;
	if(weapon != level.weaponnone)
	{
		/#
			assert(isdefined(weapon.worldmodel), ("" + weapon.name) + "");
		#/
	}
}

/*
	Name: setsecondaryweapon
	Namespace: aiutility
	Checksum: 0xED0E9108
	Offset: 0x7690
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function setsecondaryweapon(weapon)
{
	self.secondaryweapon = weapon;
	self.secondaryweaponclass = weapon.weapclass;
	if(weapon != level.weaponnone)
	{
		/#
			assert(isdefined(weapon.worldmodel), ("" + weapon.name) + "");
		#/
	}
}

/*
	Name: keepclaimnode
	Namespace: aiutility
	Checksum: 0x94EF7426
	Offset: 0x7720
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function keepclaimnode(behaviortreeentity)
{
	behaviortreeentity.keepclaimednode = 1;
	return true;
}

/*
	Name: releaseclaimnode
	Namespace: aiutility
	Checksum: 0x141FDB8A
	Offset: 0x7748
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function releaseclaimnode(behaviortreeentity)
{
	behaviortreeentity.keepclaimednode = 0;
	return true;
}

/*
	Name: getaimyawtoenemyfromnode
	Namespace: aiutility
	Checksum: 0xD3D3BBAF
	Offset: 0x7770
	Size: 0x82
	Parameters: 3
	Flags: Linked
*/
function getaimyawtoenemyfromnode(behaviortreeentity, node, enemy)
{
	return angleclamp180((vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1]) - node.angles[1]);
}

/*
	Name: getaimpitchtoenemyfromnode
	Namespace: aiutility
	Checksum: 0x938FD05C
	Offset: 0x7800
	Size: 0x82
	Parameters: 3
	Flags: Linked
*/
function getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy)
{
	return angleclamp180((vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0]) - node.angles[0]);
}

/*
	Name: choosefrontcoverdirection
	Namespace: aiutility
	Checksum: 0xDA99FCCF
	Offset: 0x7890
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function choosefrontcoverdirection(behaviortreeentity)
{
	coverdirection = behaviortreeentity getblackboardattribute("_cover_direction");
	behaviortreeentity setblackboardattribute("_previous_cover_direction", coverdirection);
	behaviortreeentity setblackboardattribute("_cover_direction", "cover_front_direction");
}

/*
	Name: shouldtacticalwalk
	Namespace: aiutility
	Checksum: 0xC8795C1C
	Offset: 0x7918
	Size: 0x1C6
	Parameters: 1
	Flags: Linked
*/
function shouldtacticalwalk(behaviortreeentity)
{
	if(!behaviortreeentity haspath())
	{
		return false;
	}
	if(ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk"))
	{
		return true;
	}
	if(ai::hasaiattribute(behaviortreeentity, "disablesprint") && !ai::getaiattribute(behaviortreeentity, "disablesprint"))
	{
		if(ai::hasaiattribute(behaviortreeentity, "sprint") && ai::getaiattribute(behaviortreeentity, "sprint"))
		{
			return false;
		}
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
		if(pathdist < 9216)
		{
			return true;
		}
	}
	if(behaviortreeentity shouldfacemotion())
	{
		return false;
	}
	if(!behaviortreeentity issafefromgrenade())
	{
		return false;
	}
	return true;
}

/*
	Name: shouldstealth
	Namespace: aiutility
	Checksum: 0x3A16A257
	Offset: 0x7AE8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function shouldstealth(behaviortreeentity)
{
	if(behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth"))
	{
		return true;
	}
	return false;
}

/*
	Name: locomotionshouldstealth
	Namespace: aiutility
	Checksum: 0xC3609638
	Offset: 0x7B48
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function locomotionshouldstealth(behaviortreeentity)
{
	if(behaviortreeentity haspath())
	{
		return true;
	}
	return false;
}

/*
	Name: shouldstealthresume
	Namespace: aiutility
	Checksum: 0x338202E1
	Offset: 0x7B80
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function shouldstealthresume(behaviortreeentity)
{
	if(!shouldstealth(behaviortreeentity))
	{
		return false;
	}
	if(isdefined(behaviortreeentity.stealth_resume) && behaviortreeentity.stealth_resume)
	{
		behaviortreeentity.stealth_resume = undefined;
		return true;
	}
	return false;
}

/*
	Name: stealthreactcondition
	Namespace: aiutility
	Checksum: 0x20ADFF39
	Offset: 0x7BE8
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
function private stealthreactcondition(entity)
{
	inscene = isdefined(self._o_scene) && isdefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
	return !(isdefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

/*
	Name: stealthreactstart
	Namespace: aiutility
	Checksum: 0xE12B2FE2
	Offset: 0x7C90
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private stealthreactstart(behaviortreeentity)
{
	behaviortreeentity.stealth_reacting = 1;
}

/*
	Name: stealthreactterminate
	Namespace: aiutility
	Checksum: 0x21E60D2E
	Offset: 0x7CB8
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private stealthreactterminate(behaviortreeentity)
{
	behaviortreeentity.stealth_reacting = undefined;
}

/*
	Name: stealthidleterminate
	Namespace: aiutility
	Checksum: 0x5C1961BD
	Offset: 0x7CD8
	Size: 0x5A
	Parameters: 1
	Flags: Linked, Private
*/
function private stealthidleterminate(behaviortreeentity)
{
	behaviortreeentity notify(#"stealthidleterminate");
	if(isdefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle)
	{
		behaviortreeentity.stealth_resume_after_idle = undefined;
		behaviortreeentity.stealth_resume = 1;
	}
}

/*
	Name: locomotionshouldpatrol
	Namespace: aiutility
	Checksum: 0x5A49B982
	Offset: 0x7D40
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function locomotionshouldpatrol(behaviortreeentity)
{
	if(shouldstealth(behaviortreeentity))
	{
		return false;
	}
	if(behaviortreeentity haspath() && behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol"))
	{
		return true;
	}
	return false;
}

/*
	Name: _dropriotshield
	Namespace: aiutility
	Checksum: 0xEBE7DFE4
	Offset: 0x7DD0
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private _dropriotshield(riotshieldinfo)
{
	entity = self;
	entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 1, 0);
	if(isdefined(entity))
	{
		entity detach(riotshieldinfo.model, riotshieldinfo.tag);
	}
}

/*
	Name: attachriotshield
	Namespace: aiutility
	Checksum: 0xCBD1D023
	Offset: 0x7E58
	Size: 0xA2
	Parameters: 4
	Flags: None
*/
function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag)
{
	riotshield = spawnstruct();
	riotshield.weapon = riotshieldweapon;
	riotshield.tag = riotshieldtag;
	riotshield.model = riotshieldmodel;
	entity attach(riotshieldmodel, riotshield.tag);
	entity.riotshield = riotshield;
}

/*
	Name: dropriotshield
	Namespace: aiutility
	Checksum: 0xF17BE595
	Offset: 0x7F08
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function dropriotshield(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.riotshield))
	{
		riotshieldinfo = behaviortreeentity.riotshield;
		behaviortreeentity.riotshield = undefined;
		behaviortreeentity thread _dropriotshield(riotshieldinfo);
	}
}

/*
	Name: meleeacquiremutex
	Namespace: aiutility
	Checksum: 0xBCF29CD1
	Offset: 0x7F68
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function meleeacquiremutex(behaviortreeentity)
{
	if(isdefined(behaviortreeentity) && isdefined(behaviortreeentity.enemy))
	{
		behaviortreeentity.meleeenemy = behaviortreeentity.enemy;
		if(isplayer(behaviortreeentity.meleeenemy))
		{
			if(!isdefined(behaviortreeentity.meleeenemy.meleeattackers))
			{
				behaviortreeentity.meleeenemy.meleeattackers = 0;
			}
			behaviortreeentity.meleeenemy.meleeattackers++;
		}
	}
}

/*
	Name: meleereleasemutex
	Namespace: aiutility
	Checksum: 0xCCDA40A7
	Offset: 0x8018
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function meleereleasemutex(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.meleeenemy))
	{
		if(isplayer(behaviortreeentity.meleeenemy))
		{
			if(isdefined(behaviortreeentity.meleeenemy.meleeattackers))
			{
				behaviortreeentity.meleeenemy.meleeattackers = behaviortreeentity.meleeenemy.meleeattackers - 1;
				if(behaviortreeentity.meleeenemy.meleeattackers <= 0)
				{
					behaviortreeentity.meleeenemy.meleeattackers = undefined;
				}
			}
		}
	}
	behaviortreeentity.meleeenemy = undefined;
}

/*
	Name: shouldmutexmelee
	Namespace: aiutility
	Checksum: 0xE689D6FE
	Offset: 0x80D8
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function shouldmutexmelee(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy))
	{
		if(!isplayer(behaviortreeentity.enemy))
		{
			if(behaviortreeentity.enemy.meleeattackers)
			{
				return 0;
			}
		}
		else
		{
			if(!sessionmodeiscampaigngame())
			{
				return 1;
			}
			behaviortreeentity.enemy.meleeattackers = 0;
			return behaviortreeentity.enemy.meleeattackers < 1;
		}
	}
	return 1;
}

/*
	Name: shouldnormalmelee
	Namespace: aiutility
	Checksum: 0x2D09C2B4
	Offset: 0x8190
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function shouldnormalmelee(behaviortreeentity)
{
	return hascloseenemytomelee(behaviortreeentity);
}

/*
	Name: shouldmelee
	Namespace: aiutility
	Checksum: 0xAFB450E0
	Offset: 0x81C0
	Size: 0x2EE
	Parameters: 1
	Flags: Linked
*/
function shouldmelee(entity)
{
	if(isdefined(entity.ai.lastshouldmeleeresult) && !entity.ai.lastshouldmeleeresult && (entity.ai.lastshouldmeleechecktime + 50) >= gettime())
	{
		return false;
	}
	entity.lastshouldmeleechecktime = gettime();
	entity.lastshouldmeleeresult = 0;
	if(!isdefined(entity.enemy))
	{
		return false;
	}
	if(!entity.enemy.allowdeath)
	{
		return false;
	}
	if(!isalive(entity.enemy))
	{
		return false;
	}
	if(!issentient(entity.enemy))
	{
		return false;
	}
	if(isvehicle(entity.enemy) && (!(isdefined(entity.enemy.ai.good_melee_target) && entity.enemy.ai.good_melee_target)))
	{
		return false;
	}
	if(isplayer(entity.enemy) && entity.enemy getstance() == "prone")
	{
		return false;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) > 140 * 140)
	{
		return false;
	}
	if(ai::hasaiattribute(entity, "can_melee") && !ai::getaiattribute(entity, "can_melee"))
	{
		return false;
	}
	if(ai::hasaiattribute(entity.enemy, "can_be_meleed") && !ai::getaiattribute(entity.enemy, "can_be_meleed"))
	{
		return false;
	}
	if(!shouldmutexmelee(entity))
	{
		return false;
	}
	if(shouldnormalmelee(entity) || shouldchargemelee(entity))
	{
		entity.ai.lastshouldmeleeresult = 1;
		return true;
	}
	return false;
}

/*
	Name: hascloseenemytomelee
	Namespace: aiutility
	Checksum: 0xF4336D71
	Offset: 0x84B8
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function hascloseenemytomelee(entity)
{
	return hascloseenemytomeleewithrange(entity, 64 * 64);
}

/*
	Name: hascloseenemytomeleewithrange
	Namespace: aiutility
	Checksum: 0x5EE9CD79
	Offset: 0x84F0
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function hascloseenemytomeleewithrange(entity, melee_range_sq)
{
	/#
		assert(isdefined(entity.enemy));
	#/
	if(!entity cansee(entity.enemy))
	{
		return 0;
	}
	predicitedposition = entity.enemy.origin + vectorscale(entity getenemyvelocity(), 0.25);
	distsq = distancesquared(entity.origin, predicitedposition);
	yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
	if(distsq <= (36 * 36))
	{
		return abs(yawtoenemy) <= 40;
	}
	if(distsq <= melee_range_sq && entity maymovetopoint(entity.enemy.origin))
	{
		return abs(yawtoenemy) <= 80;
	}
	return 0;
}

/*
	Name: shouldchargemelee
	Namespace: aiutility
	Checksum: 0xEBE9269D
	Offset: 0x86A0
	Size: 0x20C
	Parameters: 1
	Flags: Linked
*/
function shouldchargemelee(entity)
{
	/#
		assert(isdefined(entity.enemy));
	#/
	currentstance = entity getblackboardattribute("_stance");
	if(currentstance != "stand")
	{
		return 0;
	}
	if(isdefined(entity.ai.nextchargemeleetime))
	{
		if(gettime() < entity.ai.nextchargemeleetime)
		{
			return 0;
		}
	}
	enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
	if(enemydistsq < 64 * 64)
	{
		return 0;
	}
	offset = entity.enemy.origin - ((vectornormalize(entity.enemy.origin - entity.origin)) * 36);
	if(enemydistsq < (140 * 140) && entity maymovetopoint(offset, 1, 1))
	{
		yawtoenemy = angleclamp180(entity.angles[1] - (vectortoangles(entity.enemy.origin - entity.origin)[1]));
		return abs(yawtoenemy) <= 80;
	}
	return 0;
}

/*
	Name: shouldattackinchargemelee
	Namespace: aiutility
	Checksum: 0xE20EA85E
	Offset: 0x88B8
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldattackinchargemelee(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy))
	{
		if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 74 * 74)
		{
			yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - (vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]));
			if(abs(yawtoenemy) > 80)
			{
				return false;
			}
			return true;
		}
	}
}

/*
	Name: setupchargemeleeattack
	Namespace: aiutility
	Checksum: 0xB4601FAF
	Offset: 0x89A8
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private setupchargemeleeattack(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.enemy) && behaviortreeentity.enemy.scriptvehicletype === "firefly")
	{
		behaviortreeentity setblackboardattribute("_melee_enemy_type", "fireflyswarm");
	}
	meleeacquiremutex(behaviortreeentity);
	keepclaimnode(behaviortreeentity);
}

/*
	Name: cleanupmelee
	Namespace: aiutility
	Checksum: 0xE3BE1216
	Offset: 0x8A48
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
function private cleanupmelee(behaviortreeentity)
{
	meleereleasemutex(behaviortreeentity);
	releaseclaimnode(behaviortreeentity);
	behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
	if(isdefined(behaviortreeentity.ai.var_aba9dcfd) && isdefined(behaviortreeentity.ai.var_38ee3a42))
	{
		behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_aba9dcfd, behaviortreeentity.ai.var_38ee3a42));
	}
}

/*
	Name: cleanupchargemelee
	Namespace: aiutility
	Checksum: 0x5966F3D4
	Offset: 0x8B38
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private cleanupchargemelee(behaviortreeentity)
{
	behaviortreeentity.ai.nextchargemeleetime = gettime() + 2000;
	behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
	meleereleasemutex(behaviortreeentity);
	releaseclaimnode(behaviortreeentity);
	behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

/*
	Name: cleanupchargemeleeattack
	Namespace: aiutility
	Checksum: 0xF812BB1A
	Offset: 0x8BF8
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function cleanupchargemeleeattack(behaviortreeentity)
{
	meleereleasemutex(behaviortreeentity);
	releaseclaimnode(behaviortreeentity);
	behaviortreeentity setblackboardattribute("_melee_enemy_type", undefined);
	if(isdefined(behaviortreeentity.ai.var_aba9dcfd) && isdefined(behaviortreeentity.ai.var_38ee3a42))
	{
		behaviortreeentity pathmode("move delayed", 1, randomfloatrange(behaviortreeentity.ai.var_aba9dcfd, behaviortreeentity.ai.var_38ee3a42));
	}
	else
	{
		behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
	}
}

/*
	Name: shouldchoosespecialpronepain
	Namespace: aiutility
	Checksum: 0x6E372EAB
	Offset: 0x8D28
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldchoosespecialpronepain(behaviortreeentity)
{
	stance = behaviortreeentity getblackboardattribute("_stance");
	return stance == "prone_back" || stance == "prone_front";
}

/*
	Name: function_9b0e7a22
	Namespace: aiutility
	Checksum: 0xB94355AF
	Offset: 0x8D88
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9b0e7a22(behaviortreeentity)
{
	return behaviortreeentity.var_40543c03 === "concussion";
}

/*
	Name: shouldchoosespecialpain
	Namespace: aiutility
	Checksum: 0x89B84A3C
	Offset: 0x8DB0
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldchoosespecialpain(behaviortreeentity)
{
	return isdefined(behaviortreeentity.var_40543c03);
}

/*
	Name: function_89cb7bfd
	Namespace: aiutility
	Checksum: 0x580B9631
	Offset: 0x8DD0
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_89cb7bfd(behaviortreeentity)
{
	return behaviortreeentity.var_ab2486b4;
}

/*
	Name: shouldchoosespecialdeath
	Namespace: aiutility
	Checksum: 0x38B4EB9D
	Offset: 0x8DF0
	Size: 0x32
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldchoosespecialdeath(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.damageweapon))
	{
		return behaviortreeentity.damageweapon.specialpain;
	}
	return 0;
}

/*
	Name: shouldchoosespecialpronedeath
	Namespace: aiutility
	Checksum: 0x1CAE839E
	Offset: 0x8E30
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
function private shouldchoosespecialpronedeath(behaviortreeentity)
{
	stance = behaviortreeentity getblackboardattribute("_stance");
	return stance == "prone_back" || stance == "prone_front";
}

/*
	Name: setupexplosionanimscale
	Namespace: aiutility
	Checksum: 0x8F557654
	Offset: 0x8E90
	Size: 0x40
	Parameters: 2
	Flags: Linked, Private
*/
function private setupexplosionanimscale(entity, asmstatename)
{
	self.animtranslationscale = 2;
	self asmsetanimationrate(0.7);
	return 4;
}

/*
	Name: isbalconydeath
	Namespace: aiutility
	Checksum: 0xC0271541
	Offset: 0x8ED8
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function isbalconydeath(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.node))
	{
		return false;
	}
	if(!(behaviortreeentity.node.spawnflags & 1024 || behaviortreeentity.node.spawnflags & 2048))
	{
		return false;
	}
	covermode = behaviortreeentity getblackboardattribute("_cover_mode");
	if(isdefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > (int(100 * behaviortreeentity.node.script_balconydeathchance)))
	{
		return false;
	}
	distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);
	if(distsq > 64 * 64)
	{
		return false;
	}
	self.b_balcony_death = 1;
	return true;
}

/*
	Name: balconydeath
	Namespace: aiutility
	Checksum: 0xE71D4B3E
	Offset: 0x9030
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function balconydeath(behaviortreeentity)
{
	behaviortreeentity.clamptonavmesh = 0;
	if(behaviortreeentity.node.spawnflags & 1024)
	{
		behaviortreeentity setblackboardattribute("_special_death", "balcony");
	}
	else if(behaviortreeentity.node.spawnflags & 2048)
	{
		behaviortreeentity setblackboardattribute("_special_death", "balcony_norail");
	}
}

/*
	Name: usecurrentposition
	Namespace: aiutility
	Checksum: 0x30FFC69D
	Offset: 0x90E0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function usecurrentposition(entity)
{
	entity function_a57c34b7(entity.origin);
}

/*
	Name: isunarmed
	Namespace: aiutility
	Checksum: 0x27B445E0
	Offset: 0x9118
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function isunarmed(behaviortreeentity)
{
	if(behaviortreeentity.weapon == level.weaponnone)
	{
		return true;
	}
	return false;
}

/*
	Name: preshootlaserandglinton
	Namespace: aiutility
	Checksum: 0xCF45F7B5
	Offset: 0x9150
	Size: 0x180
	Parameters: 1
	Flags: None
*/
function preshootlaserandglinton(ai)
{
	self endon(#"death");
	if(!isdefined(ai.laserstatus))
	{
		ai.laserstatus = 0;
	}
	sniper_glint = #"hash_3db1ecb54b192a49";
	while(true)
	{
		self waittill(#"about_to_fire");
		if(ai.laserstatus !== 1)
		{
			ai laseron();
			ai.laserstatus = 1;
			tag = ai gettagorigin("tag_flash");
			if(isdefined(tag))
			{
				playfxontag(sniper_glint, ai, "tag_flash");
			}
			else
			{
				type = (isdefined(ai.classname) ? "" + ai.classname : "");
				/#
					println(("" + type) + "");
				#/
				playfxontag(sniper_glint, ai, "tag_eye");
			}
		}
	}
}

/*
	Name: postshootlaserandglintoff
	Namespace: aiutility
	Checksum: 0x6672A077
	Offset: 0x92D8
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function postshootlaserandglintoff(ai)
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"stopped_firing");
		if(ai.laserstatus === 1)
		{
			ai laseroff();
			ai.laserstatus = 0;
		}
	}
}

/*
	Name: isinphalanx
	Namespace: aiutility
	Checksum: 0xB7EC4716
	Offset: 0x9358
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private isinphalanx(entity)
{
	return entity ai::get_behavior_attribute("phalanx");
}

/*
	Name: isinphalanxstance
	Namespace: aiutility
	Checksum: 0xE16C216A
	Offset: 0x9390
	Size: 0xB6
	Parameters: 1
	Flags: Linked, Private
*/
function private isinphalanxstance(entity)
{
	phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
	currentstance = entity getblackboardattribute("_stance");
	switch(phalanxstance)
	{
		case "stand":
		{
			return currentstance == "stand";
		}
		case "crouch":
		{
			return currentstance == "crouch";
		}
	}
	return 1;
}

/*
	Name: togglephalanxstance
	Namespace: aiutility
	Checksum: 0xBFDAA8F0
	Offset: 0x9450
	Size: 0xBA
	Parameters: 1
	Flags: Linked, Private
*/
function private togglephalanxstance(entity)
{
	phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
	switch(phalanxstance)
	{
		case "stand":
		{
			entity setblackboardattribute("_desired_stance", "stand");
			break;
		}
		case "crouch":
		{
			entity setblackboardattribute("_desired_stance", "crouch");
			break;
		}
	}
}

/*
	Name: isatattackobject
	Namespace: aiutility
	Checksum: 0xAFCB0B77
	Offset: 0x9518
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function isatattackobject(entity)
{
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return false;
	}
	if(isdefined(entity.attackable) && (isdefined(entity.attackable.is_active) && entity.attackable.is_active))
	{
		if(!isdefined(entity.attackable_slot))
		{
			return false;
		}
		if(entity isatgoal())
		{
			entity.is_at_attackable = 1;
			return true;
		}
	}
	return false;
}

/*
	Name: shouldattackobject
	Namespace: aiutility
	Checksum: 0x8B7120EE
	Offset: 0x95E0
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function shouldattackobject(entity)
{
	if(isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1]))
	{
		return false;
	}
	if(isdefined(entity.attackable) && (isdefined(entity.attackable.is_active) && entity.attackable.is_active))
	{
		if(isdefined(entity.is_at_attackable) && entity.is_at_attackable)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: meleeattributescallback
	Namespace: aiutility
	Checksum: 0x91107536
	Offset: 0x9690
	Size: 0xB2
	Parameters: 4
	Flags: None
*/
function meleeattributescallback(entity, attribute, oldvalue, value)
{
	switch(attribute)
	{
		case "can_melee":
		{
			if(value)
			{
				entity.canmelee = 1;
			}
			else
			{
				entity.canmelee = 0;
			}
			break;
		}
		case "can_be_meleed":
		{
			if(value)
			{
				entity.canbemeleed = 1;
			}
			else
			{
				entity.canbemeleed = 0;
			}
			break;
		}
	}
}

/*
	Name: arrivalattributescallback
	Namespace: aiutility
	Checksum: 0x2F72C6AE
	Offset: 0x9750
	Size: 0x82
	Parameters: 4
	Flags: None
*/
function arrivalattributescallback(entity, attribute, oldvalue, value)
{
	switch(attribute)
	{
		case "disablearrivals":
		{
			if(value)
			{
				entity.ai.disablearrivals = 1;
			}
			else
			{
				entity.ai.disablearrivals = 0;
			}
			break;
		}
	}
}

/*
	Name: phalanxattributecallback
	Namespace: aiutility
	Checksum: 0xEA881215
	Offset: 0x97E0
	Size: 0x5A
	Parameters: 4
	Flags: None
*/
function phalanxattributecallback(entity, attribute, oldvalue, value)
{
	if(value)
	{
		entity.ai.phalanx = 1;
	}
	else
	{
		entity.ai.phalanx = 0;
	}
}

/*
	Name: function_81c32010
	Namespace: aiutility
	Checksum: 0x728C26EA
	Offset: 0x9848
	Size: 0x2BA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_81c32010(behaviortreeentity)
{
	if(!isdefined(behaviortreeentity.reacquire_state))
	{
		behaviortreeentity.reacquire_state = 0;
	}
	if(!isdefined(behaviortreeentity.enemy))
	{
		behaviortreeentity.reacquire_state = 0;
		return false;
	}
	if(behaviortreeentity haspath())
	{
		behaviortreeentity.reacquire_state = 0;
		return false;
	}
	if(behaviortreeentity seerecently(behaviortreeentity.enemy, 4))
	{
		behaviortreeentity.reacquire_state = 0;
		return false;
	}
	dirtoenemy = vectornormalize(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
	forward = anglestoforward(behaviortreeentity.angles);
	if(vectordot(dirtoenemy, forward) < 0.5)
	{
		behaviortreeentity.reacquire_state = 0;
		return false;
	}
	switch(behaviortreeentity.reacquire_state)
	{
		case 0:
		case 1:
		case 2:
		{
			step_size = 32 + (behaviortreeentity.reacquire_state * 32);
			reacquirepos = behaviortreeentity reacquirestep(step_size);
			break;
		}
		case 4:
		{
			if(!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy())
			{
				behaviortreeentity flagenemyunattackable();
			}
			break;
		}
		default:
		{
			if(behaviortreeentity.reacquire_state > 15)
			{
				behaviortreeentity.reacquire_state = 0;
				return false;
			}
			break;
		}
	}
	if(isvec(reacquirepos))
	{
		behaviortreeentity function_a57c34b7(reacquirepos);
		return true;
	}
	behaviortreeentity.reacquire_state++;
	return false;
}

