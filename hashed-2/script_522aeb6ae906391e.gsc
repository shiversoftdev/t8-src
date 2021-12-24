// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace blackboard;

/*
	Name: registerblackboardattribute
	Namespace: blackboard
	Checksum: 0xC5C6C510
	Offset: 0x68
	Size: 0x134
	Parameters: 4
	Flags: Linked
*/
function registerblackboardattribute(entity, attributename, defaultattributevalue, getterfunction)
{
	/#
		assert(isdefined(entity.__blackboard), "");
	#/
	/#
		assert(!isdefined(entity.__blackboard[attributename]), ("" + attributename) + "");
	#/
	if(isdefined(getterfunction))
	{
		/#
			assert(isfunctionptr(getterfunction));
		#/
		entity.__blackboard[attributename] = getterfunction;
	}
	else if(!isdefined(defaultattributevalue))
	{
		defaultattributevalue = undefined;
	}
	entity.__blackboard[attributename] = defaultattributevalue;
	/#
		if(isactor(entity))
		{
			entity trackblackboardattribute(attributename);
		}
	#/
}

/*
	Name: getstructblackboardattribute
	Namespace: blackboard
	Checksum: 0x79DE3FA4
	Offset: 0x1A8
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function getstructblackboardattribute(struct, attributename)
{
	/#
		assert(isstruct(struct));
	#/
	if(isfunctionptr(struct.__blackboard[attributename]))
	{
		getterfunction = struct.__blackboard[attributename];
		attributevalue = struct [[getterfunction]]();
		return attributevalue;
	}
	return struct.__blackboard[attributename];
}

/*
	Name: setstructblackboardattribute
	Namespace: blackboard
	Checksum: 0x159819CC
	Offset: 0x268
	Size: 0xE2
	Parameters: 3
	Flags: Linked
*/
function setstructblackboardattribute(struct, attributename, attributevalue)
{
	/#
		assert(isstruct(struct));
	#/
	if(isdefined(struct.__blackboard[attributename]))
	{
		if(!isdefined(attributevalue) && isfunctionptr(struct.__blackboard[attributename]))
		{
			return;
		}
		/#
			assert(!isfunctionptr(struct.__blackboard[attributename]), "");
		#/
	}
	struct.__blackboard[attributename] = attributevalue;
}

/*
	Name: createblackboardforentity
	Namespace: blackboard
	Checksum: 0x92D887BB
	Offset: 0x358
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function createblackboardforentity(entity)
{
	if(!isdefined(entity.__blackboard))
	{
		entity.__blackboard = [];
		if(isentity(entity))
		{
			entity createblackboardentries();
		}
	}
	if(!isdefined(level._setblackboardattributefunc))
	{
		level._setblackboardattributefunc = &setblackboardattribute;
	}
}

/*
	Name: cloneblackboardfromstruct
	Namespace: blackboard
	Checksum: 0x680B7039
	Offset: 0x3E0
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function cloneblackboardfromstruct(struct)
{
	/#
		assert(isstruct(struct));
	#/
	blackboard = [];
	if(isdefined(struct.__blackboard))
	{
		foreach(k, v in struct.__blackboard)
		{
			blackboard[k] = getstructblackboardattribute(struct, k);
		}
	}
	return blackboard;
}

