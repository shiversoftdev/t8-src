// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace animationstatenetwork;

/*
	Name: initnotetrackhandler
	Namespace: animationstatenetwork
	Checksum: 0x353C801F
	Offset: 0x68
	Size: 0x12
	Parameters: 0
	Flags: AutoExec
*/
function autoexec initnotetrackhandler()
{
	level._notetrack_handler = [];
}

/*
	Name: runnotetrackhandler
	Namespace: animationstatenetwork
	Checksum: 0x95594D17
	Offset: 0x88
	Size: 0x96
	Parameters: 1
	Flags: Private, Event
*/
event private runnotetrackhandler(eventstruct)
{
	/#
		assert(isarray(eventstruct.notetracks));
	#/
	for(index = 0; index < eventstruct.notetracks.size; index++)
	{
		handlenotetrack(eventstruct.entity, eventstruct.notetracks[index]);
	}
}

/*
	Name: handlenotetrack
	Namespace: animationstatenetwork
	Checksum: 0xC6DDB474
	Offset: 0x128
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
function private handlenotetrack(entity, notetrack)
{
	notetrackhandler = level._notetrack_handler[notetrack];
	if(!isdefined(notetrackhandler))
	{
		return;
	}
	if(isfunctionptr(notetrackhandler))
	{
		[[notetrackhandler]](entity);
	}
	else
	{
		entity setblackboardattribute(notetrackhandler.blackboardattributename, notetrackhandler.blackboardvalue);
	}
}

/*
	Name: registernotetrackhandlerfunction
	Namespace: animationstatenetwork
	Checksum: 0x8ABF809F
	Offset: 0x1C0
	Size: 0xCA
	Parameters: 2
	Flags: Linked
*/
function registernotetrackhandlerfunction(notetrackname, notetrackfuncptr)
{
	/#
		assert(isstring(notetrackname), "");
	#/
	/#
		assert(isfunctionptr(notetrackfuncptr), "");
	#/
	/#
		assert(!isdefined(level._notetrack_handler[notetrackname]), ("" + notetrackname) + "");
	#/
	level._notetrack_handler[notetrackname] = notetrackfuncptr;
}

/*
	Name: registerblackboardnotetrackhandler
	Namespace: animationstatenetwork
	Checksum: 0x76200BF7
	Offset: 0x298
	Size: 0x6E
	Parameters: 3
	Flags: Linked
*/
function registerblackboardnotetrackhandler(notetrackname, blackboardattributename, blackboardvalue)
{
	notetrackhandler = spawnstruct();
	notetrackhandler.blackboardattributename = blackboardattributename;
	notetrackhandler.blackboardvalue = blackboardvalue;
	level._notetrack_handler[notetrackname] = notetrackhandler;
}

