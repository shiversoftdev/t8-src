// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace behaviorstatemachine;

/*
	Name: registerbsmscriptapiinternal
	Namespace: behaviorstatemachine
	Checksum: 0x8A655FF4
	Offset: 0x68
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function registerbsmscriptapiinternal(functionname, scriptfunction)
{
	if(!isdefined(level._bsmscriptfunctions))
	{
		level._bsmscriptfunctions = [];
	}
	/#
		assert(isdefined(scriptfunction) && isdefined(scriptfunction), "");
	#/
	/#
		assert(!isdefined(level._bsmscriptfunctions[functionname]), "");
	#/
	level._bsmscriptfunctions[functionname] = scriptfunction;
}

