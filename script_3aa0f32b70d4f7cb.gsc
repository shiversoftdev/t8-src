// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace behaviortreenetworkutility;

/*
	Name: registerbehaviortreescriptapi
	Namespace: behaviortreenetworkutility
	Checksum: 0x20FA0909
	Offset: 0x68
	Size: 0xCC
	Parameters: 3
	Flags: Linked
*/
function registerbehaviortreescriptapi(functionname, functionptr, allowedcallsperframe)
{
	if(!isdefined(level._behaviortreescriptfunctions))
	{
		level._behaviortreescriptfunctions = [];
	}
	/#
		assert(isdefined(functionname) && isdefined(functionptr), "");
	#/
	/#
		assert(!isdefined(level._behaviortreescriptfunctions[functionname]), "");
	#/
	level._behaviortreescriptfunctions[functionname] = functionptr;
	if(isdefined(allowedcallsperframe))
	{
		registerlimitedbehaviortreeapi(functionname, allowedcallsperframe);
	}
}

/*
	Name: registerbehaviortreeaction
	Namespace: behaviortreenetworkutility
	Checksum: 0x8D3678BC
	Offset: 0x140
	Size: 0x1E0
	Parameters: 4
	Flags: Linked
*/
function registerbehaviortreeaction(actionname, startfuncptr, updatefuncptr, terminatefuncptr)
{
	if(!isdefined(level._behaviortreeactions))
	{
		level._behaviortreeactions = [];
	}
	/#
		assert(isdefined(actionname), "");
	#/
	/#
		assert(!isdefined(level._behaviortreeactions[actionname]), ("" + actionname) + "");
	#/
	level._behaviortreeactions[actionname] = array();
	if(isdefined(startfuncptr))
	{
		/#
			assert(isfunctionptr(startfuncptr), "");
		#/
		level._behaviortreeactions[actionname][#"bhtn_action_start"] = startfuncptr;
	}
	if(isdefined(updatefuncptr))
	{
		/#
			assert(isfunctionptr(updatefuncptr), "");
		#/
		level._behaviortreeactions[actionname][#"bhtn_action_update"] = updatefuncptr;
	}
	if(isdefined(terminatefuncptr))
	{
		/#
			assert(isfunctionptr(terminatefuncptr), "");
		#/
		level._behaviortreeactions[actionname][#"bhtn_action_terminate"] = terminatefuncptr;
	}
}

