// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16d00590b7ac9e6;

#namespace animation_selector_table_evaluators;

/*
	Name: registerastscriptfunctions
	Namespace: animation_selector_table_evaluators
	Checksum: 0x7F3720D
	Offset: 0x150
	Size: 0x11C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function registerastscriptfunctions()
{
	animationselectortable::registeranimationselectortableevaluator("testFunction", &testfunction);
	animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimations", &evaluateblockedanimations);
	animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsRelaxed", &evaluateblockedanimationsrelaxed);
	animationselectortable::registeranimationselectortableevaluator("evaluateBlockedAnimationsOffNavmesh", &evaluateblockedanimationsoffnavmesh);
	animationselectortable::registeranimationselectortableevaluator("evaluateHumanTurnAnimations", &evaluatehumanturnanimations);
	animationselectortable::registeranimationselectortableevaluator("evaluateHumanExposedArrivalAnimations", &evaluatehumanexposedarrivalanimations);
	animationselectortable::registeranimationselectortableevaluator("evaluateJukeBlockedAnimations", &evaluatejukeblockedanimations);
}

/*
	Name: testfunction
	Namespace: animation_selector_table_evaluators
	Checksum: 0x3BC6C447
	Offset: 0x278
	Size: 0x48
	Parameters: 2
	Flags: Linked
*/
function testfunction(entity, animations)
{
	if(isarray(animations) && animations.size > 0)
	{
		return animations[0];
	}
}

/*
	Name: function_aa7530df
	Namespace: animation_selector_table_evaluators
	Checksum: 0xB4EFB203
	Offset: 0x2C8
	Size: 0x19E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_aa7530df(entity, animation)
{
	pixbeginevent(#"evaluator_checkanimationagainstgeo");
	/#
		assert(isactor(entity));
	#/
	forwarddir = anglestoforward(entity.angles);
	localdeltavector = getmovedelta(animation, 0, 1, entity);
	endpoint = entity localtoworldcoords(localdeltavector);
	forwardpoint = endpoint + vectorscale(forwarddir, 100);
	/#
		recordline(entity.origin, endpoint, (0, 0, 1), "", entity);
		recordline(endpoint, forwardpoint, (1, 0.5, 0), "", entity);
	#/
	if(entity maymovefrompointtopoint(endpoint, forwardpoint, 1, 1))
	{
		pixendevent();
		return 1;
	}
	pixendevent();
	return 0;
}

/*
	Name: evaluatejukeblockedanimations
	Namespace: animation_selector_table_evaluators
	Checksum: 0xDB568B1
	Offset: 0x470
	Size: 0x7C
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluatejukeblockedanimations(entity, animations)
{
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &function_aa7530df, &evaluator_checkanimationforovershootinggoal));
	}
}

/*
	Name: evaluator_checkanimationagainstgeo
	Namespace: animation_selector_table_evaluators
	Checksum: 0x837F2393
	Offset: 0x4F8
	Size: 0x22E
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluator_checkanimationagainstgeo(entity, animation)
{
	pixbeginevent(#"evaluator_checkanimationagainstgeo");
	/#
		assert(isactor(entity));
	#/
	localdeltahalfvector = getmovedelta(animation, 0, 0.5, entity);
	midpoint = entity localtoworldcoords(localdeltahalfvector);
	midpoint = (midpoint[0], midpoint[1], entity.origin[2]);
	/#
		recordline(entity.origin, midpoint, (1, 0.5, 0), "", entity);
	#/
	if(entity maymovetopoint(midpoint, 1, 1))
	{
		localdeltavector = getmovedelta(animation, 0, 1, entity);
		endpoint = entity localtoworldcoords(localdeltavector);
		endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
		/#
			recordline(midpoint, endpoint, (1, 0.5, 0), "", entity);
		#/
		if(entity maymovefrompointtopoint(midpoint, endpoint, 1, 1))
		{
			pixendevent();
			return 1;
		}
	}
	pixendevent();
	return 0;
}

/*
	Name: evaluator_checkanimationendpointagainstgeo
	Namespace: animation_selector_table_evaluators
	Checksum: 0x696E3B83
	Offset: 0x730
	Size: 0x11E
	Parameters: 2
	Flags: Private
*/
private function evaluator_checkanimationendpointagainstgeo(entity, animation)
{
	pixbeginevent(#"evaluator_checkanimationendpointagainstgeo");
	/#
		assert(isactor(entity));
	#/
	localdeltavector = getmovedelta(animation, 0, 1, entity);
	endpoint = entity localtoworldcoords(localdeltavector);
	endpoint = (endpoint[0], endpoint[1], entity.origin[2]);
	if(entity maymovetopoint(endpoint, 0, 0))
	{
		pixendevent();
		return 1;
	}
	pixendevent();
	return 0;
}

/*
	Name: evaluator_checkanimationforovershootinggoal
	Namespace: animation_selector_table_evaluators
	Checksum: 0x64D63BD
	Offset: 0x858
	Size: 0x1CE
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluator_checkanimationforovershootinggoal(entity, animation)
{
	pixbeginevent(#"evaluator_checkanimationforovershootinggoal");
	/#
		assert(isactor(entity));
	#/
	localdeltavector = getmovedelta(animation, 0, 1, entity);
	endpoint = entity localtoworldcoords(localdeltavector);
	animdistsq = lengthsquared(localdeltavector);
	if(entity haspath())
	{
		startpos = entity.origin;
		goalpos = entity.pathgoalpos;
		/#
			assert(isdefined(goalpos));
		#/
		disttogoalsq = distancesquared(startpos, goalpos);
		if(animdistsq < disttogoalsq * 0.9)
		{
			pixendevent();
			return 1;
		}
	}
	/#
		record3dtext("", entity.origin, (1, 0.5, 0), "", entity);
	#/
	pixendevent();
	return 0;
}

/*
	Name: evaluator_checkanimationagainstnavmesh
	Namespace: animation_selector_table_evaluators
	Checksum: 0x13A7AB2B
	Offset: 0xA30
	Size: 0xE6
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluator_checkanimationagainstnavmesh(entity, animation)
{
	/#
		assert(isactor(entity));
	#/
	localdeltavector = getmovedelta(animation, 0, 1, entity);
	endpoint = entity localtoworldcoords(localdeltavector);
	if(ispointonnavmesh(endpoint, entity))
	{
		return 1;
	}
	/#
		record3dtext("", entity.origin, (1, 0.5, 0), "", entity);
	#/
	return 0;
}

/*
	Name: evaluator_checkanimationarrivalposition
	Namespace: animation_selector_table_evaluators
	Checksum: 0xF312BC75
	Offset: 0xB20
	Size: 0x136
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluator_checkanimationarrivalposition(entity, animation)
{
	localdeltavector = getmovedelta(animation, 0, 1, entity);
	endpoint = entity localtoworldcoords(localdeltavector);
	animdistsq = lengthsquared(localdeltavector);
	startpos = entity.origin;
	goalpos = entity.pathgoalpos;
	disttogoalsq = distancesquared(startpos, goalpos);
	if(disttogoalsq < animdistsq)
	{
		if(isdefined(entity.ai.var_a5dabb8b) && entity.ai.var_a5dabb8b)
		{
			return 1;
		}
		if(entity isposatgoal(endpoint))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: evaluator_findfirstvalidanimation
	Namespace: animation_selector_table_evaluators
	Checksum: 0xEAE94B3D
	Offset: 0xC60
	Size: 0x194
	Parameters: 3
	Flags: Linked, Private
*/
private function evaluator_findfirstvalidanimation(entity, animations, tests)
{
	/#
		assert(isarray(animations), "");
	#/
	/#
		assert(isarray(tests), "");
	#/
	foreach(aliasanimations in animations)
	{
		if(aliasanimations.size > 0)
		{
			valid = 1;
			animation = aliasanimations[0];
			foreach(test in tests)
			{
				if(![[test]](entity, animation))
				{
					valid = 0;
					break;
				}
			}
			if(valid)
			{
				return animation;
			}
		}
	}
}

/*
	Name: evaluateblockedanimations
	Namespace: animation_selector_table_evaluators
	Checksum: 0xD3E56763
	Offset: 0xE00
	Size: 0x6E
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluateblockedanimations(entity, animations)
{
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstnavmesh, &evaluator_checkanimationforovershootinggoal));
	}
	return undefined;
}

/*
	Name: evaluateblockedanimationsrelaxed
	Namespace: animation_selector_table_evaluators
	Checksum: 0x49B8628B
	Offset: 0xE78
	Size: 0x5E
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluateblockedanimationsrelaxed(entity, animations)
{
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal));
	}
	return undefined;
}

/*
	Name: evaluateblockedanimationsoffnavmesh
	Namespace: animation_selector_table_evaluators
	Checksum: 0x2BBB7AF3
	Offset: 0xEE0
	Size: 0x5E
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluateblockedanimationsoffnavmesh(entity, animations)
{
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationagainstgeo));
	}
	return undefined;
}

/*
	Name: evaluatehumanturnanimations
	Namespace: animation_selector_table_evaluators
	Checksum: 0x9B637584
	Offset: 0xF48
	Size: 0xF6
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluatehumanturnanimations(entity, animations)
{
	/#
		if(isdefined(level.ai_dontturn) && level.ai_dontturn)
		{
			return undefined;
		}
	#/
	/#
		record3dtext(("" + gettime()) + "", entity.origin, (1, 0.5, 0), "", entity);
	#/
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationforovershootinggoal, &evaluator_checkanimationagainstgeo, &evaluator_checkanimationagainstnavmesh));
	}
	return undefined;
}

/*
	Name: evaluatehumanexposedarrivalanimations
	Namespace: animation_selector_table_evaluators
	Checksum: 0x706AD130
	Offset: 0x1048
	Size: 0x6E
	Parameters: 2
	Flags: Linked, Private
*/
private function evaluatehumanexposedarrivalanimations(entity, animations)
{
	if(!isdefined(entity.pathgoalpos))
	{
		return undefined;
	}
	if(animations.size > 0)
	{
		return evaluator_findfirstvalidanimation(entity, animations, array(&evaluator_checkanimationarrivalposition));
	}
	return undefined;
}

