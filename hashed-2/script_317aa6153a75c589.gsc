// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4bf952f6ba31bb17;
#using script_6809bf766eba194a;
#using scripts\core_common\math_shared.gsc;

#namespace archetype_mocomps_utility;

/*
	Name: registerdefaultanimationmocomps
	Namespace: archetype_mocomps_utility
	Checksum: 0xDDFCE3F7
	Offset: 0x388
	Size: 0x2C4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function registerdefaultanimationmocomps()
{
	animationstatenetwork::registeranimationmocomp("adjust_to_cover", &mocompadjusttocoverinit, &mocompadjusttocoverupdate, &mocompadjusttocoverterminate);
	animationstatenetwork::registeranimationmocomp("locomotion_explosion_death", &mocomplocoexplosioninit, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_flank_stand", &mocompflankstandinit, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural", &mocomptraversalproceduralinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot", &mocomptraversalproceduralpivotinit, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_no_time_scale", &function_5f0e6de2, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_traversal_procedural_pivot_no_time_scale", &function_41323d2, &mocomptraversalproceduralpivotupdate, &mocomptraversalproceduralpivotterminate);
	animationstatenetwork::registeranimationmocomp("mocomp_traversal_teleport", &function_82b9d7b7, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_react_stealth", &function_7ea5e21f, &function_8def77d1, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_pain_ignore_pain", &function_59fe75e2, &function_8559a6cd, &function_4b95cde);
	animationstatenetwork::registeranimationmocomp("mocomp_ignore_pain_face_enemy", &mocompignorepainfaceenemyinit, &mocompignorepainfaceenemyupdate, &mocompignorepainfaceenemyterminate);
}

/*
	Name: drawtraversal
	Namespace: archetype_mocomps_utility
	Checksum: 0xA8F4A6B8
	Offset: 0x658
	Size: 0x436
	Parameters: 6
	Flags: Private
*/
private function drawtraversal(traversal, entity, animation, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(getdvarint(#"ai_debugvolumetool", 0) <= 1)
	{
		return;
	}
	/#
		recordsphere(traversal.startposition, 2, (1, 0.5, 0), "", entity);
		recordsphere(traversal.endposition, 2, (1, 0.5, 0), "", entity);
	#/
	animlength = getanimlength(animation);
	currentposition = traversal.startposition;
	nextposition = currentposition;
	segments = 0;
	while(segmenttime <= animlength)
	{
		nexttime = segmenttime + float(function_60d95f53()) / 1000;
		if(nexttime > animlength)
		{
			nexttime = animlength;
		}
		movedelta = getmovedelta(animation, segmenttime / animlength, nexttime / animlength);
		nextposition = currentposition + rotatepoint(movedelta, traversal.startangles);
		/#
			recordline(currentposition, nextposition, (1, 0.5, 0), "", entity);
		#/
		currentposition = nextposition;
		segmenttime = segmenttime + float(function_60d95f53()) / 1000;
	}
	/#
		recordsphere(nextposition, 2, (1, 0, 0), "", entity);
	#/
	if(isdefined(traversal.mantlenode))
	{
		edgepoints = getnodeedge(traversal.mantlenode);
		for(index = 1; index < edgepoints.size; index++)
		{
			/#
				recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "", entity);
			#/
		}
	}
	edgepoints = getnodeedge(traversal.startnode);
	for(index = 1; index < edgepoints.size; index++)
	{
		/#
			recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "", entity);
		#/
	}
	edgepoints = getnodeedge(traversal.endnode);
	for(index = 1; index < edgepoints.size; index++)
	{
		/#
			recordline(edgepoints[index - 1], edgepoints[index], (1, 0, 0), "", entity);
		#/
	}
}

/*
	Name: drawtraversalsection
	Namespace: archetype_mocomps_utility
	Checksum: 0x19363769
	Offset: 0xA98
	Size: 0x3F6
	Parameters: 6
	Flags: Private
*/
private function drawtraversalsection(section, entity, animation, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(getdvarint(#"ai_debugvolumetool", 0) <= 1)
	{
		return;
	}
	/#
		recordsphere(section.startposition, 2, (1, 0.5, 0), "", entity);
		recordsphere(section.endposition, 2, (1, 0.5, 0), "", entity);
		recordsphere(section.mocompstartposition, 2, (0, 1, 0), "", entity);
		recordsphere(section.adjustedmocompendposition, 2, (0, 1, 0), "", entity);
	#/
	animlength = getanimlength(animation);
	currentposition = section.startposition;
	nextposition = currentposition;
	segments = 0;
	deltatoendtotal = (0, 0, 0);
	while(segmenttime <= section.endtime)
	{
		nexttime = segmenttime + float(function_60d95f53()) / 1000;
		if(nexttime > section.endtime)
		{
			nexttime = section.endtime;
		}
		movedelta = getmovedelta(animation, segmenttime / animlength, nexttime / animlength);
		nextposition = currentposition + rotatepoint(movedelta, section.startangles);
		if(nexttime >= section.mocompstarttime && lengthsquared(deltatoendtotal) < lengthsquared(section.deltatoendposition))
		{
			adjusteddeltaperframe = section.adjusteddeltaperframe;
			deltatoendtotal = deltatoendtotal + adjusteddeltaperframe;
			if(lengthsquared(deltatoendtotal) > lengthsquared(section.deltatoendposition))
			{
				adjusteddeltaperframe = adjusteddeltaperframe - deltatoendtotal - section.deltatoendposition;
			}
			nextposition = nextposition + adjusteddeltaperframe;
			/#
				recordline(currentposition, nextposition, (0, 1, 0), "", entity);
			#/
		}
		recordline(currentposition, nextposition, (1, 0.5, 0), "", entity);
		currentposition = nextposition;
		segmenttime = segmenttime + float(function_60d95f53()) / 1000;
	}
}

/*
	Name: calculatetraveralsection
	Namespace: archetype_mocomps_utility
	Checksum: 0x515387DF
	Offset: 0xE98
	Size: 0x822
	Parameters: 9
	Flags: Linked, Private
*/
private function calculatetraveralsection(entity, traversal, animation, starttime, endtime, startposition, endposition, startangles, timescale = 1)
{
	/#
		assert(endtime >= starttime);
	#/
	animlength = getanimlength(animation);
	section = spawnstruct();
	section.starttime = starttime;
	section.starttimenormalized = section.starttime / animlength;
	section.endtime = endtime;
	section.length = section.endtime - section.starttime;
	section.startangles = startangles;
	section.startposition = startposition;
	section.endposition = endposition;
	section.mocompstarttime = starttime;
	starttimes = getnotetracktimes(animation, "start_procedural");
	if(isdefined(starttimes) && starttimes.size > 0)
	{
		for(index = 0; index < starttimes.size; index++)
		{
			mocomptime = starttimes[index] * animlength;
			if(mocomptime >= starttime && mocomptime <= endtime)
			{
				section.mocompstarttime = mocomptime;
			}
		}
	}
	section.mocompendtime = endtime;
	endtimes = getnotetracktimes(animation, "stop_procedural");
	if(isdefined(endtimes) && endtimes.size > 0)
	{
		for(index = 0; index < endtimes.size; index++)
		{
			mocomptime = endtimes[index] * animlength;
			if(mocomptime >= starttime && mocomptime <= endtime)
			{
				section.mocompendtime = mocomptime;
			}
		}
	}
	section.mocomptimelength = section.mocompendtime - section.mocompstarttime;
	section.mocomptimeinframes = floor(section.mocomptimelength / float(function_60d95f53()) / 1000);
	if(section.mocomptimeinframes <= 0)
	{
		section.mocomptimeinframes = 1;
	}
	endtime = 1;
	if(animlength > 0)
	{
		endtime = section.mocompstarttime / animlength;
	}
	endtime = math::clamp(endtime, 0, 1);
	movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
	section.mocompstartposition = section.startposition + rotatepoint(movedelta, section.startangles);
	endtime = 1;
	if(animlength > 0)
	{
		endtime = section.mocompendtime / animlength;
	}
	endtime = math::clamp(endtime, 0, 1);
	movedelta = getmovedelta(animation, section.starttimenormalized, endtime);
	section.mocompendposition = section.startposition + rotatepoint(movedelta, section.startangles);
	endtime = 1;
	if(animlength > 0)
	{
		endtime = section.endtime / animlength;
	}
	endtime = math::clamp(endtime, 0, 1);
	section.animationendposition = section.startposition + rotatepoint(getmovedelta(animation, section.starttimenormalized, endtime), section.startangles);
	section.deltatoendposition = section.endposition - section.animationendposition;
	section.deltatoendmocompposition = section.mocompendposition - section.mocompstartposition;
	section.adjustedmocompendposition = section.mocompendposition + section.deltatoendposition;
	section.adjusteddeltaperframe = section.deltatoendposition / section.mocomptimeinframes;
	section.deltatoendmocomplength = length(section.deltatoendmocompposition);
	section.deltatoendmocomplengthdesired = length(section.deltatoendposition + section.deltatoendmocompposition);
	section.deltatoendmocompmultiplier = 1;
	if(timescale && section.deltatoendmocomplength > 0 && section.deltatoendmocomplengthdesired > 0)
	{
		section.deltatoendmocompmultiplier = section.deltatoendmocomplength / section.deltatoendmocomplengthdesired;
		section.deltatoendmocompmultiplier = max(0.01, float(int(section.deltatoendmocompmultiplier * 10)) / 10);
	}
	section.deltatoendtotal = (0, 0, 0);
	if(isdefined(traversal.pivotorigin) && isdefined(traversal.pivottime))
	{
		startposition = section.startposition;
		endposition = section.endposition;
		if(section.starttime < traversal.pivottime)
		{
			endposition = traversal.pivotorigin;
		}
		else
		{
			startposition = traversal.pivotorigin;
		}
		if(endposition - startposition[2] <= 0 && section.deltatoendmocompmultiplier < 1)
		{
			section.deltatoendmocompmultiplier = 1;
		}
	}
	else if(section.endposition - section.startposition[2] <= 0 && section.deltatoendmocompmultiplier < 1)
	{
		section.deltatoendmocompmultiplier = 1;
	}
	return section;
}

/*
	Name: calculatepivotoriginfromedge
	Namespace: archetype_mocomps_utility
	Checksum: 0x33BF7497
	Offset: 0x16C8
	Size: 0x5A0
	Parameters: 3
	Flags: Linked
*/
function calculatepivotoriginfromedge(entity, mantlenode, traversalstart)
{
	/#
		assert(isvec(traversalstart));
	#/
	/#
		assert(isdefined(mantlenode));
	#/
	mantlepoints = [];
	if(isdefined(mantlenode) && ispathnode(mantlenode))
	{
		mantlepoints = getnodeedge(mantlenode);
	}
	mantlestart = undefined;
	mantleend = undefined;
	if(mantlepoints.size > 0)
	{
		/#
			assert(isarray(mantlepoints));
		#/
		/#
			assert(mantlepoints.size >= 2);
		#/
		mantlestart = mantlepoints[0];
		mantleend = mantlepoints[mantlepoints.size - 1];
	}
	else
	{
		right = anglestoright(mantlenode.angles);
		extents = mantlenode.aabb_extents;
		mantlestart = mantlenode.origin - right * extents[1];
		mantleend = mantlenode.origin + right * extents[1];
	}
	mantlestartproj = mantlestart;
	mantleendproj = (mantleend[0], mantleend[1], mantlestartproj[2]);
	traversalstartproj = (traversalstart[0], traversalstart[1], mantlestartproj[2]);
	tomantleendproj = mantleendproj - mantlestartproj;
	totraversalproj = traversalstartproj - mantlestartproj;
	mantleoriginproj = mantlestartproj + vectorprojection(totraversalproj, tomantleendproj);
	if(mantlepoints.size > 0)
	{
		mantleedgelength = length(mantleendproj - mantlestartproj);
		time = length(mantleoriginproj - mantlestartproj) / mantleedgelength;
		mantleorigin = mantlepoints[0];
		for(index = 1; index < mantlepoints.size; index++)
		{
			endpoint = mantlepoints[index];
			endpointproj = (endpoint[0], endpoint[1], mantlestartproj[2]);
			endpointtime = length(endpointproj - mantlestartproj) / mantleedgelength;
			if(endpointtime > time)
			{
				startpoint = mantlepoints[index - 1];
				startpointproj = (startpoint[0], startpoint[1], mantlestartproj[2]);
				startpointtime = length(startpointproj - mantlestartproj) / mantleedgelength;
				timedelta = time - startpointtime;
				mantleorigin = startpoint + endpoint - startpoint * timedelta / endpointtime - startpointtime;
				break;
			}
		}
	}
	else
	{
		mantleorigin = physicstraceex(mantleoriginproj + (0, 0, mantlenode.aabb_extents[2]), mantleoriginproj - (0, 0, mantlenode.aabb_extents[2]), (0, 0, 0), (0, 0, 0), entity)[#"position"];
	}
	/#
		recordline(mantleoriginproj, mantleendproj, (0, 0, 1), "", entity);
		recordline(mantlestartproj, traversalstartproj, (0, 0, 1), "", entity);
		recordline(traversalstartproj, mantleoriginproj, (0, 0, 1), "", entity);
		recordline(mantlestart, mantleend, (1, 0, 0), "", entity);
		recordline(mantlestart, mantleoriginproj, (1, 0, 0), "", entity);
		recordline(mantleoriginproj, mantleorigin, (1, 0, 0), "", entity);
	#/
	return mantleorigin;
}

/*
	Name: function_5f0e6de2
	Namespace: archetype_mocomps_utility
	Checksum: 0xC90BD6AB
	Offset: 0x1C70
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_5f0e6de2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	mocomptraversalproceduralinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, 0);
}

/*
	Name: mocomptraversalproceduralinit
	Namespace: archetype_mocomps_utility
	Checksum: 0x876929E
	Offset: 0x1CD0
	Size: 0x56C
	Parameters: 6
	Flags: Linked
*/
function mocomptraversalproceduralinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, timescale = 1)
{
	traversal = spawnstruct();
	traversal.startnode = entity.traversestartnode;
	traversal.endnode = entity.traverseendnode;
	traversal.initialanimationrate = (isactor(entity) ? (isdefined(entity function_ebbebf56()) ? entity function_ebbebf56() : 1) : 1);
	traversal.animlength = getanimlength(mocompanim);
	traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
	traversal.var_98d8ca66 = (0, 0, 0);
	traversal.startposition = entity.origin;
	traversal.adjustedendposition = (isdefined(entity.var_e4615d76) ? entity.var_e4615d76 : entity.traversalendpos);
	traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
	traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
	traversal.startangles = vectortoangles(traversal.traversalforward);
	end_time = math::clamp(traversal.actualanimlength / traversal.animlength, 0, 1);
	traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, end_time), traversal.startangles);
	if(isdefined(traversal.endnode) && isdefined(traversal.endnode.script_linkname))
	{
		traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
		if(isdefined(traversal.endnodeparent))
		{
			traversal.origincontents = entity setcontents(8192);
			traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
			traversal.adjustedendposition = physicstraceex(entity.traversalendpos + vectorscale((0, 0, 1), 24), entity.traversalendpos - vectorscale((0, 0, 1), 24), (0, 0, 0), (0, 0, 0), entity)[#"position"];
		}
	}
	traversal.sections = [];
	traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.actualanimlength, traversal.startposition, traversal.adjustedendposition, traversal.startangles, timescale);
	traversal.lastanimtime = 0;
	entity.traversal = traversal;
	entity.blockingpain = 1;
	entity.usegoalanimweight = 1;
	entity.lasttraversalanimation = mocompanim;
	entity.lasttraversalblendout = mocompanimblendouttime;
	entity.lasttraversalstartpos = traversal.startposition;
	entity.lasttraversalendpos = traversal.adjustedendposition;
	entity.lasttraversalpivot = undefined;
	if(isactor(entity))
	{
		entity setrepairpaths(0);
		entity orientmode("face angle", traversal.startangles[1]);
		entity animmode("angle deltas noclip", 0);
	}
	mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

/*
	Name: function_41323d2
	Namespace: archetype_mocomps_utility
	Checksum: 0xBDA29094
	Offset: 0x2248
	Size: 0x54
	Parameters: 5
	Flags: Linked
*/
function function_41323d2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	mocomptraversalproceduralpivotinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, 0);
}

/*
	Name: mocomptraversalproceduralpivotinit
	Namespace: archetype_mocomps_utility
	Checksum: 0xE3B8CDCB
	Offset: 0x22A8
	Size: 0x93C
	Parameters: 6
	Flags: Linked
*/
function mocomptraversalproceduralpivotinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration, timescale = 1)
{
	traversal = spawnstruct();
	traversal.startnode = entity.traversestartnode;
	traversal.endnode = entity.traverseendnode;
	traversal.mantlenode = entity.traversemantlenode;
	traversal.initialanimationrate = (isactor(entity) ? (isdefined(entity function_ebbebf56()) ? entity function_ebbebf56() : 1) : 1);
	traversal.animlength = getanimlength(mocompanim);
	traversal.actualanimlength = traversal.animlength - mocompanimblendouttime;
	traversal.var_98d8ca66 = (0, 0, 0);
	traversal.startposition = entity.origin;
	traversal.adjustedendposition = (isdefined(entity.var_e4615d76) ? entity.var_e4615d76 : entity.traversalendpos);
	traversal.traversalforward = traversal.adjustedendposition - traversal.startposition;
	traversal.traversalforward = (traversal.traversalforward[0], traversal.traversalforward[1], 0);
	traversal.startangles = vectortoangles(traversal.traversalforward);
	end_time = math::clamp(traversal.actualanimlength / traversal.animlength, 0, 1);
	traversal.endposition = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, end_time), traversal.startangles);
	if(isdefined(traversal.endnode) && isdefined(traversal.endnode.script_linkname))
	{
		traversal.endnodeparent = getent(traversal.endnode.script_linkname, "targetname");
		if(isdefined(traversal.endnodeparent))
		{
			traversal.origincontents = entity setcontents(8192);
			traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
			traversal.adjustedendposition = physicstraceex(entity.traversalendpos + vectorscale((0, 0, 1), 24), entity.traversalendpos - vectorscale((0, 0, 1), 24), (0, 0, 0), (0, 0, 0), entity)[#"position"];
		}
	}
	pivottimes = getnotetracktimes(mocompanim, "pivot_procedural");
	traversal.pivottime = traversal.actualanimlength / 2;
	if(isdefined(pivottimes) && pivottimes.size > 0)
	{
		traversal.pivottime = pivottimes[0] * traversal.animlength;
	}
	traversal.pivottime = floor(traversal.pivottime / float(function_60d95f53()) / 1000) * float(function_60d95f53()) / 1000;
	traversal.pivotorigin = calculatepivotoriginfromedge(entity, traversal.mantlenode, traversal.startposition);
	pivottagorigin = getanimtagorigin(mocompanim, 0, "tag_sync");
	animpivotorigin = traversal.pivotorigin;
	if(lengthsquared(pivottagorigin) > 0)
	{
		animpivotorigin = rotatepoint(pivottagorigin, traversal.startangles) + traversal.startposition;
	}
	pivotoffset = traversal.pivotorigin - animpivotorigin;
	animlen = 1;
	if(traversal.animlength > 0)
	{
		animlen = math::clamp(traversal.pivottime / traversal.animlength, 0, 1);
	}
	pivotorigin = traversal.startposition + rotatepoint(getmovedelta(mocompanim, 0, animlen), traversal.startangles) + pivotoffset;
	/#
		if(getdvarint(#"ai_debugvolumetool", 0) > 1)
		{
			recordsphere(animpivotorigin, 2, (0, 0, 1), "", entity);
			recordline(traversal.pivotorigin, animpivotorigin, (1, 0, 0), "", entity);
			recordsphere(traversal.pivotorigin, 2, (1, 0, 0), "", entity);
		}
	#/
	traversal.sections = [];
	traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, 0, traversal.pivottime, traversal.startposition, pivotorigin, traversal.startangles, timescale);
	traversal.sections[traversal.sections.size] = calculatetraveralsection(entity, traversal, mocompanim, traversal.pivottime, traversal.actualanimlength, pivotorigin, traversal.adjustedendposition, traversal.startangles, timescale);
	if(traversal.sections[0].deltatoendmocompmultiplier != 1)
	{
		traversal.sections[1].deltatoendmocompmultiplier = 1;
	}
	traversal.lastanimtime = 0;
	entity.traversal = traversal;
	entity.blockingpain = 1;
	entity.usegoalanimweight = 1;
	entity.lasttraversalanimation = mocompanim;
	entity.lasttraversalblendout = mocompanimblendouttime;
	entity.lasttraversalstartpos = traversal.startposition;
	entity.lasttraversalendpos = traversal.adjustedendposition;
	entity.lasttraversalpivot = traversal.pivotorigin;
	if(isactor(entity))
	{
		entity setrepairpaths(0);
		entity animmode("angle deltas noclip", 0);
	}
	mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
}

/*
	Name: mocomptraversalproceduralpivotupdate
	Namespace: archetype_mocomps_utility
	Checksum: 0x22667918
	Offset: 0x2BF0
	Size: 0x5AC
	Parameters: 5
	Flags: Linked
*/
function mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(!isalive(entity))
	{
		return;
	}
	traversal = entity.traversal;
	/#
		drawtraversal(traversal, entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
		for(index = 0; index < traversal.sections.size; index++)
		{
			drawtraversalsection(traversal.sections[index], entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
		}
	#/
	traversal = entity.traversal;
	/#
		assert(isdefined(traversal));
	#/
	animationrate = traversal.initialanimationrate;
	adjusteddeltaperframe = (0, 0, 0);
	animationnextsteptime = entity getanimtime(mocompanim) * traversal.animlength;
	movedelta = getmovedelta(mocompanim, 0, animationnextsteptime / traversal.animlength);
	/#
		assert(traversal.sections.size > 0);
	#/
	section = traversal.sections[0];
	for(index = 0; index < traversal.sections.size; index++)
	{
		section = traversal.sections[index];
		if(section.starttime <= animationnextsteptime && section.endtime > animationnextsteptime)
		{
			break;
		}
	}
	if(traversal.lastanimtime >= section.mocompstarttime && lengthsquared(section.deltatoendtotal) < lengthsquared(section.deltatoendposition))
	{
		animationtimedelta = animationnextsteptime - traversal.lastanimtime / float(function_60d95f53()) / 1000;
		adjusteddeltaperframe = section.adjusteddeltaperframe * animationtimedelta;
		section.deltatoendtotal = section.deltatoendtotal + adjusteddeltaperframe;
		if(traversal.lastanimtime <= section.mocompendtime && section.deltatoendmocompmultiplier < 1 && (!(isdefined(level.var_881e464e) && level.var_881e464e)))
		{
			animationrate = traversal.initialanimationrate * section.deltatoendmocompmultiplier;
		}
		if(lengthsquared(section.deltatoendtotal) > lengthsquared(section.deltatoendposition))
		{
			adjusteddeltaperframe = adjusteddeltaperframe - section.deltatoendtotal - section.deltatoendposition;
		}
	}
	traversal.lastanimtime = animationnextsteptime;
	traversal.var_98d8ca66 = traversal.var_98d8ca66 + adjusteddeltaperframe;
	newentityorigin = traversal.startposition + rotatepoint(movedelta, traversal.startangles) + traversal.var_98d8ca66;
	if(isdefined(traversal.endnodeparent))
	{
		parentdelta = traversal.endnodeparent.origin - traversal.lastendnodeparentorigin;
		traversal.lastendnodeparentorigin = traversal.endnodeparent.origin;
		newentityorigin = newentityorigin + parentdelta;
	}
	if(isactor(entity))
	{
		if(!(isdefined(entity.ai.var_8a9efbb6) && entity.ai.var_8a9efbb6))
		{
			entity asmsetanimationrate(animationrate);
		}
		entity forceteleport(newentityorigin, traversal.startangles, 0, 0);
	}
	else if(isplayer(entity))
	{
		entity lerporigin(newentityorigin);
		entity setplayerangles(traversal.startangles);
	}
}

/*
	Name: mocomptraversalproceduralpivotterminate
	Namespace: archetype_mocomps_utility
	Checksum: 0x63C198A7
	Offset: 0x31A8
	Size: 0x13C
	Parameters: 5
	Flags: Linked
*/
function mocomptraversalproceduralpivotterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	traversal = entity.traversal;
	if(isdefined(traversal))
	{
		mocomptraversalproceduralpivotupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
		if(isdefined(traversal.origincontents))
		{
			entity setcontents(traversal.origincontents);
		}
		if(isactor(entity))
		{
			entity asmsetanimationrate(traversal.initialanimationrate);
		}
	}
	entity.blockingpain = 0;
	entity.usegoalanimweight = 0;
	entity.traversal = undefined;
	if(isactor(entity))
	{
		entity finishtraversal();
		entity setrepairpaths(1);
	}
}

/*
	Name: initadjusttocoverparams
	Namespace: archetype_mocomps_utility
	Checksum: 0xD1CC348
	Offset: 0x32F0
	Size: 0x694
	Parameters: 0
	Flags: AutoExec
*/
autoexec function initadjusttocoverparams()
{
	_addadjusttocover("human", "cover_any", "stance_any", 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.9, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8);
	_addadjusttocover("human", "cover_stand", "stance_any", 0.4, 0.8, 0.6, 0.4, 0.6, 0.3, 0.3, 0.6, 0.9, 0.6, 0.3, 0.4, 0.7, 0.6, 0.6, 0.6);
	_addadjusttocover("human", "cover_crouch", "stance_any", 0.4, 0.4, 0.4, 0.4, 0.8, 0.5, 0.2, 0.7, 0.9, 0.4, 0.2, 0.4, 0.5, 0.5, 0.5, 0.5);
	_addadjusttocover("human", "cover_left", "stand", 0.8, 0.4, 0.4, 0.4, 0.4, 0.7, 0.3, 0.5, 0.8, 0.8, 0.8, 0.9, 0.6, 0.6, 0.4, 0.4);
	_addadjusttocover("human", "cover_left", "crouch", 0.8, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.8, 0.8, 0.7, 0.6, 0.6, 0.4, 0.4);
	_addadjusttocover("human", "cover_right", "stand", 0.8, 0.4, 0.3, 0.4, 0.6, 0.8, 0.4, 0.4, 0.4, 0.4, 0.3, 0.4, 0.6, 0.6, 0.5, 0.4);
	_addadjusttocover("human", "cover_right", "crouch", 0.8, 0.4, 0.2, 0.4, 0.4, 0.7, 0.2, 0.3, 0.3, 0.5, 0.5, 0.7, 0.6, 0.6, 0.5, 0.4);
	_addadjusttocover("human", "cover_pillar", "stance_any", 0.8, 0.7, 0.6, 0.7, 0.6, 0.5, 0.4, 0.4, 0.4, 0.6, 0.4, 0.3, 0.7, 0.5, 0.1, 0.7);
	_addadjusttocover("robot", "cover_any", "stance_any", 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.4, 0.6, 0.7, 0.5, 0.5, 0.5, 0.5, 0.4, 0.4, 0.4);
	_addadjusttocover("robot", "cover_exposed", "stance_any", 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.9, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8, 0.8);
}

/*
	Name: _addadjusttocover
	Namespace: archetype_mocomps_utility
	Checksum: 0xDD882367
	Offset: 0x3990
	Size: 0x24A
	Parameters: 19
	Flags: Linked, Private
*/
private function _addadjusttocover(archetype, node, stance, rot2, rot32, rot3, rot36, rot6, rot69, rot9, rot98, rot8, rot87, rot7, rot47, rot4, rot14, rot1, rot21)
{
	if(!isdefined(level.adjusttocover))
	{
		level.adjusttocover = [];
	}
	if(!isdefined(level.adjusttocover[archetype]))
	{
		level.adjusttocover[archetype] = [];
	}
	if(!isdefined(level.adjusttocover[archetype][node]))
	{
		level.adjusttocover[archetype][node] = [];
	}
	directions = [];
	directions[2] = rot2;
	directions[32] = rot32;
	directions[3] = rot3;
	directions[63] = rot36;
	directions[6] = rot6;
	directions[96] = rot69;
	directions[9] = rot9;
	directions[89] = rot98;
	directions[8] = rot8;
	directions[78] = rot87;
	directions[7] = rot7;
	directions[47] = rot47;
	directions[4] = rot4;
	directions[14] = rot14;
	directions[1] = rot1;
	directions[21] = rot21;
	level.adjusttocover[archetype][node][stance] = directions;
}

/*
	Name: _getadjusttocoverrotation
	Namespace: archetype_mocomps_utility
	Checksum: 0x986E7389
	Offset: 0x3BE8
	Size: 0x3AE
	Parameters: 4
	Flags: Linked, Private
*/
private function _getadjusttocoverrotation(archetype, node, stance, angletonode)
{
	/#
		assert(isarray(level.adjusttocover[archetype]));
	#/
	if(!isdefined(level.adjusttocover[archetype][node]))
	{
		node = "cover_any";
	}
	/#
		assert(isarray(level.adjusttocover[archetype][node]));
	#/
	if(!isdefined(level.adjusttocover[archetype][node][stance]))
	{
		stance = "stance_any";
	}
	/#
		assert(isarray(level.adjusttocover[archetype][node][stance]));
	#/
	/#
		assert(angletonode >= 0 && angletonode < 360);
	#/
	direction = undefined;
	if(angletonode < 11.25)
	{
		direction = 2;
	}
	else if(angletonode < 33.75)
	{
		direction = 32;
	}
	else if(angletonode < 56.25)
	{
		direction = 3;
	}
	else if(angletonode < 78.75)
	{
		direction = 63;
	}
	else if(angletonode < 101.25)
	{
		direction = 6;
	}
	else if(angletonode < 123.75)
	{
		direction = 96;
	}
	else if(angletonode < 146.25)
	{
		direction = 9;
	}
	else if(angletonode < 168.75)
	{
		direction = 89;
	}
	else if(angletonode < 191.25)
	{
		direction = 8;
	}
	else if(angletonode < 213.75)
	{
		direction = 78;
	}
	else if(angletonode < 236.25)
	{
		direction = 7;
	}
	else if(angletonode < 258.75)
	{
		direction = 47;
	}
	else if(angletonode < 281.25)
	{
		direction = 4;
	}
	else if(angletonode < 303.75)
	{
		direction = 14;
	}
	else if(angletonode < 326.25)
	{
		direction = 1;
	}
	else if(angletonode < 348.75)
	{
		direction = 21;
	}
	else
	{
		direction = 2;
	}
	/#
		assert(isdefined(level.adjusttocover[archetype][node][stance][direction]));
	#/
	adjusttime = level.adjusttocover[archetype][node][stance][direction];
	if(isdefined(adjusttime))
	{
		return adjusttime;
	}
	return 0.8;
}

/*
	Name: debuglocoexplosion
	Namespace: archetype_mocomps_utility
	Checksum: 0xB11D76E1
	Offset: 0x3FA0
	Size: 0x166
	Parameters: 1
	Flags: Private
*/
private function debuglocoexplosion(entity)
{
	entity endon(#"death");
	/#
		startorigin = entity.origin;
		startyawforward = anglestoforward((0, entity.angles[1], 0));
		damageyawforward = anglestoforward((0, entity.damageyaw - entity.angles[1], 0));
		while(gettime() - starttime < 10000)
		{
			recordsphere(startorigin, 5, (1, 0, 0), "", entity);
			recordline(startorigin, startorigin + startyawforward * 100, (0, 0, 1), "", entity);
			recordline(startorigin, startorigin + damageyawforward * 100, (1, 0, 0), "", entity);
			waitframe(1);
		}
	#/
}

/*
	Name: mocompflankstandinit
	Namespace: archetype_mocomps_utility
	Checksum: 0x55365D70
	Offset: 0x4110
	Size: 0xF2
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompflankstandinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("nogravity", 0);
	entity orientmode("face angle", entity.angles[1]);
	entity pathmode("move delayed", 0, randomfloatrange(0.5, 1));
	if(isdefined(entity.enemy))
	{
		entity getperfectinfo(entity.enemy);
		entity.newenemyreaction = 0;
	}
}

/*
	Name: mocomplocoexplosioninit
	Namespace: archetype_mocomps_utility
	Checksum: 0x1A66CF6E
	Offset: 0x4210
	Size: 0xBC
	Parameters: 5
	Flags: Linked, Private
*/
private function mocomplocoexplosioninit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("nogravity", 0);
	entity orientmode("face angle", entity.angles[1]);
	/#
		if(getdvarint(#"ai_debuglocoexplosionmocomp", 0))
		{
			entity thread debuglocoexplosion(entity);
		}
	#/
}

/*
	Name: mocompadjusttocoverinit
	Namespace: archetype_mocomps_utility
	Checksum: 0x3342E528
	Offset: 0x42D8
	Size: 0x276
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompadjusttocoverinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("angle deltas", 0);
	entity.blockingpain = 1;
	if(isdefined(entity.node))
	{
		entity.adjustnode = entity.node;
		entity.nodeoffsetorigin = entity getnodeoffsetposition(entity.node);
		entity.nodeoffsetangles = entity getnodeoffsetangles(entity.node);
		entity.nodeoffsetforward = anglestoforward(entity.nodeoffsetangles);
		entity.nodeforward = anglestoforward(entity.node.angles);
		entity.nodefinalstance = entity getblackboardattribute("_desired_stance");
		covertype = entity getblackboardattribute("_cover_type");
		if(!isdefined(entity.nodefinalstance))
		{
			entity.nodefinalstance = aiutility::gethighestnodestance(entity.adjustnode);
		}
		angledifference = floor(absangleclamp360(entity.angles[1] - entity.node.angles[1]));
		entity.mocompanglestarttime = _getadjusttocoverrotation(entity.archetype, covertype, entity.nodefinalstance, angledifference);
	}
}

/*
	Name: mocompadjusttocoverupdate
	Namespace: archetype_mocomps_utility
	Checksum: 0xC4B59665
	Offset: 0x4558
	Size: 0x354
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompadjusttocoverupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(!isdefined(entity.adjustnode))
	{
		return;
	}
	movevector = entity.nodeoffsetorigin - entity.origin;
	if(lengthsquared(movevector) > 1)
	{
		movevector = vectornormalize(movevector) * 1;
	}
	entity forceteleport(entity.origin + movevector, entity.angles, 0);
	normalizedtime = entity getanimtime(mocompanim) * getanimlength(mocompanim) + mocompanimblendouttime / mocompduration;
	if(normalizedtime > entity.mocompanglestarttime)
	{
		entity orientmode("face angle", entity.nodeoffsetangles);
		entity animmode("normal", 0);
	}
	/#
		if(getdvarint(#"ai_debugadjustmocomp", 0))
		{
			record3dtext(entity.mocompanglestarttime, entity.origin + vectorscale((0, 0, 1), 5), (0, 1, 0), "");
			hiptagorigin = entity gettagorigin("");
			recordline(entity.nodeoffsetorigin, entity.nodeoffsetorigin + entity.nodeoffsetforward * 30, (1, 0.5, 0), "", entity);
			recordline(entity.adjustnode.origin, entity.adjustnode.origin + entity.nodeforward * 20, (0, 1, 0), "", entity);
			recordline(entity.origin, entity.origin + anglestoforward(entity.angles) * 10, (1, 0, 0), "", entity);
			recordline(hiptagorigin, (hiptagorigin[0], hiptagorigin[1], entity.origin[2]), (0, 0, 1), "", entity);
		}
	#/
}

/*
	Name: mocompadjusttocoverterminate
	Namespace: archetype_mocomps_utility
	Checksum: 0xEC211FEC
	Offset: 0x48B8
	Size: 0x106
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompadjusttocoverterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
	entity.mocompanglestarttime = undefined;
	entity.nodeoffsetangle = undefined;
	entity.nodeoffsetforward = undefined;
	entity.nodeforward = undefined;
	entity.nodefinalstance = undefined;
	if(entity.adjustnode !== entity.node)
	{
		entity.nodeoffsetorigin = undefined;
		entity.nodeoffsetangles = undefined;
		entity.adjustnode = undefined;
		return;
	}
	entity forceteleport(entity.nodeoffsetorigin, entity.nodeoffsetangles, 0);
	entity.nodeoffsetorigin = undefined;
	entity.nodeoffsetangles = undefined;
	entity.adjustnode = undefined;
}

/*
	Name: function_82b9d7b7
	Namespace: archetype_mocomps_utility
	Checksum: 0xDE35FEFD
	Offset: 0x49C8
	Size: 0x194
	Parameters: 5
	Flags: Linked, Private
*/
private function function_82b9d7b7(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("normal");
	if(isdefined(entity.traverseendnode))
	{
		/#
			print3d(entity.traversestartnode.origin, "", (1, 0, 0), 1, 1, 60);
			print3d(entity.traverseendnode.origin, "", (0, 1, 0), 1, 1, 60);
			line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
		#/
		entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
	}
}

/*
	Name: function_7ea5e21f
	Namespace: archetype_mocomps_utility
	Checksum: 0x7DD6E6EF
	Offset: 0x4B68
	Size: 0x92
	Parameters: 5
	Flags: Linked
*/
function function_7ea5e21f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.var_82d6d030 = 0.5;
	notetrack_times = getnotetracktimes(mocompanim, "face_react");
	if(isdefined(notetrack_times) && notetrack_times.size > 0)
	{
		entity.var_82d6d030 = notetrack_times[0];
	}
}

/*
	Name: function_8def77d1
	Namespace: archetype_mocomps_utility
	Checksum: 0x4866EA0A
	Offset: 0x4C08
	Size: 0xAC
	Parameters: 5
	Flags: Linked
*/
function function_8def77d1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(entity getanimtime(mocompanim) >= entity.var_82d6d030)
	{
		entity orientmode("face angle", self getblackboardattribute("_react_yaw_world"));
		entity animmode("pos deltas", 0);
	}
}

/*
	Name: function_59fe75e2
	Namespace: archetype_mocomps_utility
	Checksum: 0x208D10DF
	Offset: 0x4CC0
	Size: 0x84
	Parameters: 5
	Flags: Linked
*/
function function_59fe75e2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 1;
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("zonly_physics", 1);
}

/*
	Name: function_8559a6cd
	Namespace: archetype_mocomps_utility
	Checksum: 0xE7D9A50
	Offset: 0x4D50
	Size: 0x84
	Parameters: 5
	Flags: Linked
*/
function function_8559a6cd(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 1;
	entity orientmode("face angle", entity.angles[1]);
	entity animmode("zonly_physics", 1);
}

/*
	Name: function_4b95cde
	Namespace: archetype_mocomps_utility
	Checksum: 0xB2BAC101
	Offset: 0x4DE0
	Size: 0x74
	Parameters: 5
	Flags: Linked
*/
function function_4b95cde(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
	entity orientmode("face current");
	entity animmode("normal", 0);
}

/*
	Name: mocompignorepainfaceenemyinit
	Namespace: archetype_mocomps_utility
	Checksum: 0x1338EC49
	Offset: 0x4E60
	Size: 0xBC
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompignorepainfaceenemyinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 1;
	if(isdefined(entity.enemy))
	{
		entity orientmode("face enemy");
	}
	else
	{
		entity orientmode("face angle", entity.angles[1]);
	}
	entity animmode("pos deltas");
}

/*
	Name: mocompignorepainfaceenemyupdate
	Namespace: archetype_mocomps_utility
	Checksum: 0x71A458E4
	Offset: 0x4F28
	Size: 0xAC
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompignorepainfaceenemyupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(isdefined(entity.enemy) && entity getanimtime(mocompanim) < 0.5)
	{
		entity orientmode("face enemy");
	}
	else
	{
		entity orientmode("face angle", entity.angles[1]);
	}
}

/*
	Name: mocompignorepainfaceenemyterminate
	Namespace: archetype_mocomps_utility
	Checksum: 0x34437D03
	Offset: 0x4FE0
	Size: 0x3A
	Parameters: 5
	Flags: Linked, Private
*/
private function mocompignorepainfaceenemyterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity.blockingpain = 0;
}

