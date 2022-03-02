// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace ai_interface;

/*
	Name: main
	Namespace: ai_interface
	Checksum: 0x38936AC0
	Offset: 0xB8
	Size: 0x36
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	/#
		level.__ai_debuginterface = getdvarint(#"ai_debuginterface", 0);
	#/
}

/*
	Name: _checkvalue
	Namespace: ai_interface
	Checksum: 0x57640758
	Offset: 0xF8
	Size: 0x32A
	Parameters: 3
	Flags: Private
*/
function private _checkvalue(archetype, attributename, value)
{
	/#
		attribute = level.__ai_interface[archetype][attributename];
		switch(attribute[#"type"])
		{
			case "_interface_entity":
			{
				break;
			}
			case "_interface_match":
			{
				possiblevalues = attribute[#"values"];
				/#
					assert(!isarray(possiblevalues) || isinarray(possiblevalues, value), ((("" + value) + "") + attributename) + "");
				#/
				break;
			}
			case "_interface_numeric":
			{
				maxvalue = attribute[#"max_value"];
				minvalue = attribute[#"min_value"];
				/#
					assert(isint(value) || isfloat(value), ((("" + attributename) + "") + value) + "");
				#/
				/#
					assert(!isdefined(maxvalue) && !isdefined(minvalue) || (value <= maxvalue && value >= minvalue), ((((("" + value) + "") + minvalue) + "") + maxvalue) + "");
				#/
				break;
			}
			case "_interface_vector":
			{
				if(isdefined(value))
				{
					/#
						assert(isvec(value), ((("" + attributename) + "") + value) + "");
					#/
				}
				break;
			}
			default:
			{
				/#
					assert(((("" + attribute[#"type"]) + "") + attributename) + "");
				#/
				break;
			}
		}
	#/
}

/*
	Name: _checkprerequisites
	Namespace: ai_interface
	Checksum: 0xCC1F9C29
	Offset: 0x430
	Size: 0x314
	Parameters: 2
	Flags: Private
*/
function private _checkprerequisites(entity, attribute)
{
	/#
		if(isdefined(level.__ai_debuginterface) && level.__ai_debuginterface > 0)
		{
			/#
				assert(isentity(entity) || isstruct(entity), "");
			#/
			/#
				assert(isactor(entity) || isvehicle(entity) || isstruct(entity) || isbot(entity), "");
			#/
			/#
				assert(isstring(attribute), "");
			#/
			/#
				assert(isarray(entity.__interface), (("" + function_9e72a96(entity.archetype)) + "") + "");
			#/
			/#
				assert(isarray(level.__ai_interface), "");
			#/
			/#
				assert(isarray(level.__ai_interface[entity.archetype]), ("" + function_9e72a96(entity.archetype)) + "");
			#/
			/#
				assert(isarray(level.__ai_interface[entity.archetype][attribute]), (("" + attribute) + "") + function_9e72a96(entity.archetype) + "");
			#/
			/#
				assert(isstring(level.__ai_interface[entity.archetype][attribute][#"type"]), ("" + attribute) + "");
			#/
		}
	#/
}

/*
	Name: _checkregistrationprerequisites
	Namespace: ai_interface
	Checksum: 0x568ED2A5
	Offset: 0x750
	Size: 0xC4
	Parameters: 3
	Flags: Private
*/
function private _checkregistrationprerequisites(archetype, attribute, callbackfunction)
{
	/#
		/#
			assert(function_7a600918(archetype), "");
		#/
		/#
			assert(function_7a600918(attribute), "");
		#/
		/#
			assert(!isdefined(callbackfunction) || isfunctionptr(callbackfunction), "");
		#/
	#/
}

/*
	Name: _initializelevelinterface
	Namespace: ai_interface
	Checksum: 0xF36E74C5
	Offset: 0x820
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
function private _initializelevelinterface(archetype)
{
	if(!isdefined(level.__ai_interface))
	{
		level.__ai_interface = [];
	}
	if(!isdefined(level.__ai_interface[archetype]))
	{
		level.__ai_interface[archetype] = [];
	}
}

#namespace ai;

/*
	Name: createinterfaceforentity
	Namespace: ai
	Checksum: 0xFFD46BE1
	Offset: 0x880
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function createinterfaceforentity(entity)
{
	if(!isdefined(entity.__interface))
	{
		entity.__interface = [];
	}
}

/*
	Name: getaiattribute
	Namespace: ai
	Checksum: 0x165A3D0
	Offset: 0x8B8
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function getaiattribute(entity, attribute)
{
	/#
		ai_interface::_checkprerequisites(entity, attribute);
	#/
	if(!isdefined(entity.__interface[attribute]))
	{
		return level.__ai_interface[entity.archetype][attribute][#"default_value"];
	}
	return entity.__interface[attribute];
}

/*
	Name: hasaiattribute
	Namespace: ai
	Checksum: 0x209EA5AA
	Offset: 0x950
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function hasaiattribute(entity, attribute)
{
	return isdefined(entity) && isdefined(attribute) && isdefined(entity.archetype) && isdefined(level.__ai_interface) && isdefined(level.__ai_interface[entity.archetype]) && isdefined(level.__ai_interface[entity.archetype][attribute]);
}

/*
	Name: registerentityinterface
	Namespace: ai
	Checksum: 0x5AEEDB23
	Offset: 0x9E0
	Size: 0x17C
	Parameters: 4
	Flags: Linked
*/
function registerentityinterface(archetype, attribute, defaultvalue, callbackfunction)
{
	/#
		ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
	#/
	ai_interface::_initializelevelinterface(archetype);
	/#
		/#
			assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
		#/
	#/
	level.__ai_interface[archetype][attribute] = [];
	level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
	level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
	level.__ai_interface[archetype][attribute][#"type"] = "_interface_entity";
	/#
		ai_interface::_checkvalue(archetype, attribute, defaultvalue);
	#/
}

/*
	Name: registermatchedinterface
	Namespace: ai
	Checksum: 0x889E916D
	Offset: 0xB68
	Size: 0x1F4
	Parameters: 5
	Flags: Linked
*/
function registermatchedinterface(archetype, attribute, defaultvalue, possiblevalues, callbackfunction)
{
	/#
		ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
		/#
			assert(!isdefined(possiblevalues) || isarray(possiblevalues), "");
		#/
	#/
	ai_interface::_initializelevelinterface(archetype);
	/#
		/#
			assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
		#/
	#/
	level.__ai_interface[archetype][attribute] = [];
	level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
	level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
	level.__ai_interface[archetype][attribute][#"type"] = "_interface_match";
	level.__ai_interface[archetype][attribute][#"values"] = possiblevalues;
	/#
		ai_interface::_checkvalue(archetype, attribute, defaultvalue);
	#/
}

/*
	Name: registernumericinterface
	Namespace: ai
	Checksum: 0xC0361B74
	Offset: 0xD68
	Size: 0x33C
	Parameters: 6
	Flags: Linked
*/
function registernumericinterface(archetype, attribute, defaultvalue, minimum, maximum, callbackfunction)
{
	/#
		ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
		/#
			assert(!isdefined(minimum) || isint(minimum) || isfloat(minimum), "");
		#/
		/#
			assert(!isdefined(maximum) || isint(maximum) || isfloat(maximum), "");
		#/
		/#
			assert(!isdefined(minimum) && !isdefined(maximum) || (isdefined(minimum) && isdefined(maximum)), "");
		#/
		/#
			assert(!isdefined(minimum) && !isdefined(maximum) || minimum <= maximum, (("" + attribute) + "") + "");
		#/
	#/
	ai_interface::_initializelevelinterface(archetype);
	/#
		/#
			assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
		#/
	#/
	level.__ai_interface[archetype][attribute] = [];
	level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
	level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
	level.__ai_interface[archetype][attribute][#"max_value"] = maximum;
	level.__ai_interface[archetype][attribute][#"min_value"] = minimum;
	level.__ai_interface[archetype][attribute][#"type"] = "_interface_numeric";
	/#
		ai_interface::_checkvalue(archetype, attribute, defaultvalue);
	#/
}

/*
	Name: registervectorinterface
	Namespace: ai
	Checksum: 0xB1C188E9
	Offset: 0x10B0
	Size: 0x17C
	Parameters: 4
	Flags: None
*/
function registervectorinterface(archetype, attribute, defaultvalue, callbackfunction)
{
	/#
		ai_interface::_checkregistrationprerequisites(archetype, attribute, callbackfunction);
	#/
	ai_interface::_initializelevelinterface(archetype);
	/#
		/#
			assert(!isdefined(level.__ai_interface[archetype][attribute]), ((("" + attribute) + "") + archetype) + "");
		#/
	#/
	level.__ai_interface[archetype][attribute] = [];
	level.__ai_interface[archetype][attribute][#"callback"] = callbackfunction;
	level.__ai_interface[archetype][attribute][#"default_value"] = defaultvalue;
	level.__ai_interface[archetype][attribute][#"type"] = "_interface_vector";
	/#
		ai_interface::_checkvalue(archetype, attribute, defaultvalue);
	#/
}

/*
	Name: setaiattribute
	Namespace: ai
	Checksum: 0x6FBDC64
	Offset: 0x1238
	Size: 0x130
	Parameters: 3
	Flags: Linked
*/
function setaiattribute(entity, attribute, value)
{
	/#
		ai_interface::_checkprerequisites(entity, attribute);
		ai_interface::_checkvalue(entity.archetype, attribute, value);
	#/
	oldvalue = entity.__interface[attribute];
	if(!isdefined(oldvalue))
	{
		oldvalue = level.__ai_interface[entity.archetype][attribute][#"default_value"];
	}
	entity.__interface[attribute] = value;
	callback = level.__ai_interface[entity.archetype][attribute][#"callback"];
	if(isfunctionptr(callback))
	{
		[[callback]](entity, attribute, oldvalue, value);
	}
}

