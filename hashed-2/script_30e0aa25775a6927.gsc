// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace plannerblackboard;

/*
	Name: main
	Namespace: plannerblackboard
	Checksum: 0x88702A61
	Offset: 0x78
	Size: 0x36
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	/#
		level.__ai_debugplannerblackboard = getdvarint(#"ai_debugplannerblackboard", 0);
	#/
}

/*
	Name: clearundostack
	Namespace: plannerblackboard
	Checksum: 0x3308C3BA
	Offset: 0xB8
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function clearundostack(blackboard)
{
	/#
		assert(isstruct(blackboard));
	#/
	blackboard.undostack = [];
}

/*
	Name: create
	Namespace: plannerblackboard
	Checksum: 0x1B56BA85
	Offset: 0x108
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function create(blackboardvalues)
{
	/#
		assert(isarray(blackboardvalues));
	#/
	blackboard = spawnstruct();
	blackboard.undostack = [];
	blackboard.values = blackboardvalues;
	setreadmode(blackboard);
	return blackboard;
}

/*
	Name: getattribute
	Namespace: plannerblackboard
	Checksum: 0x8F27E276
	Offset: 0x190
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function getattribute(blackboard, attribute)
{
	/#
		assert(isstruct(blackboard));
	#/
	/#
		assert(isstring(attribute) || function_7a600918(attribute));
	#/
	/#
		assert(isarray(blackboard.values));
	#/
	value = blackboard.values[attribute];
	if(isarray(value))
	{
		return arraycopy(value);
	}
	return value;
}

/*
	Name: getundostacksize
	Namespace: plannerblackboard
	Checksum: 0x7C8CAE92
	Offset: 0x290
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function getundostacksize(blackboard)
{
	/#
		assert(isstruct(blackboard));
	#/
	/#
		assert(isarray(blackboard.undostack));
	#/
	return blackboard.undostack.size;
}

/*
	Name: setattribute
	Namespace: plannerblackboard
	Checksum: 0x810511CB
	Offset: 0x308
	Size: 0x2BA
	Parameters: 4
	Flags: Linked
*/
function setattribute(blackboard, attribute, value, readonly = 0)
{
	/#
		assert(isstruct(blackboard));
	#/
	/#
		assert(isstring(attribute) || function_7a600918(attribute));
	#/
	/#
		assert(isarray(blackboard.values));
	#/
	/#
		assert(isarray(blackboard.undostack));
	#/
	/#
		assert(blackboard.mode === "");
	#/
	/#
		if(isdefined(level.__ai_debugplannerblackboard) && level.__ai_debugplannerblackboard > 0 && !readonly)
		{
			/#
				assert(!isstruct(value), "");
			#/
			if(isarray(value))
			{
				foreach(entryvalue in value)
				{
					/#
						assert(!isstruct(entryvalue), "");
					#/
				}
			}
		}
	#/
	stackvalue = spawnstruct();
	stackvalue.attribute = attribute;
	stackvalue.value = blackboard.values[attribute];
	blackboard.undostack[blackboard.undostack.size] = stackvalue;
	blackboard.values[attribute] = value;
}

/*
	Name: setreadmode
	Namespace: plannerblackboard
	Checksum: 0x4C0C0D2F
	Offset: 0x5D0
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function setreadmode(blackboard)
{
	blackboard.mode = "r";
}

/*
	Name: setreadwritemode
	Namespace: plannerblackboard
	Checksum: 0x36137579
	Offset: 0x5F8
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function setreadwritemode(blackboard)
{
	blackboard.mode = "rw";
}

/*
	Name: undo
	Namespace: plannerblackboard
	Checksum: 0x222613FB
	Offset: 0x620
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function undo(blackboard, stackindex)
{
	/#
		assert(isstruct(blackboard));
	#/
	/#
		assert(isarray(blackboard.values));
	#/
	/#
		assert(isarray(blackboard.undostack));
	#/
	/#
		assert(stackindex < blackboard.undostack.size);
	#/
	for(index = blackboard.undostack.size - 1; index > stackindex; index--)
	{
		stackvalue = blackboard.undostack[index];
		blackboard.values[stackvalue.attribute] = stackvalue.value;
		arrayremoveindex(blackboard.undostack, index);
	}
}

