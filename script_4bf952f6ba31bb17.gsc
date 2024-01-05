// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace animationstatenetwork;

/*
	Name: initanimationmocomps
	Namespace: animationstatenetwork
	Checksum: 0x471E5283
	Offset: 0xB0
	Size: 0x12
	Parameters: 0
	Flags: AutoExec
*/
function autoexec initanimationmocomps()
{
	level._animationmocomps = [];
}

/*
	Name: runanimationmocomp
	Namespace: animationstatenetwork
	Checksum: 0x6D517FE6
	Offset: 0xD0
	Size: 0x192
	Parameters: 1
	Flags: Linked, Event
*/
event runanimationmocomp(eventstruct)
{
	/#
		assert(eventstruct.status >= 0 && eventstruct.status <= 2, ("" + eventstruct.status) + "");
	#/
	/#
		assert(isdefined(level._animationmocomps[eventstruct.name]), ("" + eventstruct.name) + "");
	#/
	if(eventstruct.status == 0)
	{
		eventstruct.status = "asm_mocomp_start";
	}
	else
	{
		if(eventstruct.status == 1)
		{
			eventstruct.status = "asm_mocomp_update";
		}
		else
		{
			eventstruct.status = "asm_mocomp_terminate";
		}
	}
	animationmocompresult = eventstruct.entity [[level._animationmocomps[eventstruct.name][eventstruct.status]]](eventstruct.entity, eventstruct.delta_anim, eventstruct.blend_out_time, "", eventstruct.duration);
	return animationmocompresult;
}

/*
	Name: registeranimationmocomp
	Namespace: animationstatenetwork
	Checksum: 0x989A5922
	Offset: 0x270
	Size: 0x258
	Parameters: 4
	Flags: Linked
*/
function registeranimationmocomp(mocompname, startfuncptr, updatefuncptr, terminatefuncptr)
{
	mocompname = tolower(mocompname);
	/#
		assert(isstring(mocompname), "");
	#/
	/#
		assert(!isdefined(level._animationmocomps[mocompname]), ("" + mocompname) + "");
	#/
	level._animationmocomps[mocompname] = array();
	/#
		assert(isdefined(startfuncptr) && isfunctionptr(startfuncptr), "");
	#/
	level._animationmocomps[mocompname][#"asm_mocomp_start"] = startfuncptr;
	if(isdefined(updatefuncptr))
	{
		/#
			assert(isfunctionptr(updatefuncptr), "");
		#/
		level._animationmocomps[mocompname][#"asm_mocomp_update"] = updatefuncptr;
	}
	else
	{
		level._animationmocomps[mocompname][#"asm_mocomp_update"] = &animationmocompemptyfunc;
	}
	if(isdefined(terminatefuncptr))
	{
		/#
			assert(isfunctionptr(terminatefuncptr), "");
		#/
		level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = terminatefuncptr;
	}
	else
	{
		level._animationmocomps[mocompname][#"asm_mocomp_terminate"] = &animationmocompemptyfunc;
	}
}

/*
	Name: animationmocompemptyfunc
	Namespace: animationstatenetwork
	Checksum: 0x1E41624B
	Offset: 0x4D0
	Size: 0x2C
	Parameters: 5
	Flags: Linked
*/
function animationmocompemptyfunc(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
}

