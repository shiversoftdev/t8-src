// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_30e0aa25775a6927;

#namespace planner;

/*
	Name: _blackboardsapplyundostate
	Namespace: planner
	Checksum: 0x4AE3E704
	Offset: 0xC8
	Size: 0x114
	Parameters: 2
	Flags: Linked, Private
*/
private function _blackboardsapplyundostate(planner, state)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	foreach(key, blackboard in planner.blackboards)
	{
		if(isdefined(state[key]))
		{
			plannerblackboard::undo(blackboard, state[key]);
			continue;
		}
		planner.blackboards[key] = undefined;
	}
}

/*
	Name: _blackboardscalculateundostate
	Namespace: planner
	Checksum: 0x4A8D5B4
	Offset: 0x1E8
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
private function _blackboardscalculateundostate(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	state = [];
	foreach(key, blackboard in planner.blackboards)
	{
		state[key] = plannerblackboard::getundostacksize(blackboard) - 1;
	}
	return state;
}

/*
	Name: _blackboardsreadmode
	Namespace: planner
	Checksum: 0xCBB984FA
	Offset: 0x2F8
	Size: 0xE0
	Parameters: 1
	Flags: Linked, Private
*/
private function _blackboardsreadmode(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	foreach(blackboard in planner.blackboards)
	{
		plannerblackboard::setreadmode(blackboard);
	}
}

/*
	Name: _blackboardsreadwritemode
	Namespace: planner
	Checksum: 0xF0354B9
	Offset: 0x3E0
	Size: 0xE0
	Parameters: 1
	Flags: Linked, Private
*/
private function _blackboardsreadwritemode(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	foreach(blackboard in planner.blackboards)
	{
		plannerblackboard::setreadwritemode(blackboard);
	}
}

/*
	Name: _initializeplannerfunctions
	Namespace: planner
	Checksum: 0x2A554532
	Offset: 0x4C8
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
private function _initializeplannerfunctions(functype)
{
	if(!isdefined(level._plannerscriptfunctions))
	{
		level._plannerscriptfunctions = [];
	}
	if(!isdefined(level._plannerscriptfunctions[functype]))
	{
		level._plannerscriptfunctions[functype] = [];
	}
}

/*
	Name: _plancalculateplanindex
	Namespace: planner
	Checksum: 0xB54D03A
	Offset: 0x528
	Size: 0x1E
	Parameters: 1
	Flags: Linked, Private
*/
private function _plancalculateplanindex(planner)
{
	return planner.plan.size - 1;
}

/*
	Name: _planexpandaction
	Namespace: planner
	Checksum: 0x9C8669C9
	Offset: 0x550
	Size: 0x298
	Parameters: 2
	Flags: Linked, Private
*/
private function _planexpandaction(planner, action)
{
	planner.api = action.api;
	pixbeginevent(action.api);
	aiprofile_beginentry(action.api);
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstruct(action));
	#/
	/#
		assert(action.type == "");
	#/
	/#
		assert(isarray(planner.plan));
	#/
	actionfuncs = plannerutility::getplanneractionfunctions(action.api);
	actioninfo = spawnstruct();
	actioninfo.name = action.api;
	if(isdefined(actionfuncs[#"parameterize"]))
	{
		_blackboardsreadwritemode(planner);
		actioninfo.params = [[actionfuncs[#"parameterize"]]](planner, action.constants);
		/#
			assert(isstruct(actioninfo.params), "" + action.api + "");
		#/
		_blackboardsreadmode(planner);
	}
	else
	{
		actioninfo.params = spawnstruct();
	}
	planner.plan[planner.plan.size] = actioninfo;
	planner.api = undefined;
	aiprofile_endentry();
	pixendevent();
	return 1;
}

/*
	Name: _planexpandpostcondition
	Namespace: planner
	Checksum: 0x1BDDCACA
	Offset: 0x7F0
	Size: 0x170
	Parameters: 2
	Flags: Linked, Private
*/
private function _planexpandpostcondition(planner, postcondition)
{
	planner.api = postcondition.api;
	pixbeginevent(postcondition.api);
	aiprofile_beginentry(postcondition.api);
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstruct(postcondition));
	#/
	/#
		assert(postcondition.type == "");
	#/
	_blackboardsreadwritemode(planner);
	postconditionfunc = plannerutility::getplannerapifunction(postcondition.api);
	[[postconditionfunc]](planner, postcondition.constants);
	_blackboardsreadmode(planner);
	planner.api = undefined;
	aiprofile_endentry();
	pixendevent();
	return 1;
}

/*
	Name: _planexpandprecondition
	Namespace: planner
	Checksum: 0xAB49430E
	Offset: 0x968
	Size: 0x168
	Parameters: 2
	Flags: Linked, Private
*/
private function _planexpandprecondition(planner, precondition)
{
	planner.api = precondition.api;
	pixbeginevent(precondition.api);
	aiprofile_beginentry(precondition.api);
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstruct(precondition));
	#/
	/#
		assert(precondition.type == "");
	#/
	_blackboardsreadmode(planner);
	preconditionfunc = plannerutility::getplannerapifunction(precondition.api);
	result = [[preconditionfunc]](planner, precondition.constants);
	planner.api = undefined;
	aiprofile_endentry();
	pixendevent();
	return result;
}

/*
	Name: _planfindnextsibling
	Namespace: planner
	Checksum: 0xBEEB951F
	Offset: 0xAD8
	Size: 0x64
	Parameters: 3
	Flags: Linked, Private
*/
private function _planfindnextsibling(planner, parentnodeentry, currentchildindex)
{
	/#
		assert(isstruct(planner));
	#/
	return parentnodeentry.node.children[currentchildindex + 1];
}

/*
	Name: _planstackhasnodes
	Namespace: planner
	Checksum: 0xB3A94D02
	Offset: 0xB48
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function _planstackhasnodes(planner)
{
	/#
		assert(isstruct(planner));
	#/
	return planner.nodestack.size > 0;
}

/*
	Name: _planstackpeeknode
	Namespace: planner
	Checksum: 0xEBD0A9EC
	Offset: 0xB98
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
private function _planstackpeeknode(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(planner.nodestack.size > 0);
	#/
	nodeentry = planner.nodestack[planner.nodestack.size - 1];
	return nodeentry;
}

/*
	Name: _planstackpopnode
	Namespace: planner
	Checksum: 0x45AD52C3
	Offset: 0xC30
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
private function _planstackpopnode(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(planner.nodestack.size > 0);
	#/
	nodeentry = planner.nodestack[planner.nodestack.size - 1];
	planner.nodestack[planner.nodestack.size - 1] = undefined;
	return nodeentry;
}

/*
	Name: _planstackpushnode
	Namespace: planner
	Checksum: 0x9014B843
	Offset: 0xCE8
	Size: 0x126
	Parameters: 3
	Flags: Linked, Private
*/
private function _planstackpushnode(planner, node, childindex = undefined)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstruct(node));
	#/
	nodeentry = spawnstruct();
	nodeentry.childindex = (isdefined(childindex) ? childindex : -1);
	nodeentry.node = node;
	nodeentry.planindex = _plancalculateplanindex(planner);
	nodeentry.undostate = _blackboardscalculateundostate(planner);
	planner.nodestack[planner.nodestack.size] = nodeentry;
}

/*
	Name: _planpushvalidparent
	Namespace: planner
	Checksum: 0x56D87CE2
	Offset: 0xE18
	Size: 0x28A
	Parameters: 3
	Flags: Linked, Private
*/
private function _planpushvalidparent(planner, childnodeentry, result)
{
	while(_planstackhasnodes(planner))
	{
		parentnodeentry = _planstackpeeknode(planner);
		/#
			assert(isdefined(parentnodeentry));
		#/
		switch(parentnodeentry.node.type)
		{
			case "sequence":
			{
				if(result)
				{
					nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);
					if(isdefined(nextchildnode))
					{
						_planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
						return 1;
					}
				}
				else
				{
					_undoplan(planner, parentnodeentry.planindex);
					_blackboardsapplyundostate(planner, parentnodeentry.undostate);
				}
				_planstackpopnode(planner);
				break;
			}
			case "selector":
			case "planner":
			{
				if(!result)
				{
					_undoplan(planner, parentnodeentry.planindex);
					_blackboardsapplyundostate(planner, parentnodeentry.undostate);
					nextchildnode = _planfindnextsibling(planner, parentnodeentry, childnodeentry.childindex);
					if(isdefined(nextchildnode))
					{
						_planstackpushnode(planner, nextchildnode, childnodeentry.childindex + 1);
						return 1;
					}
				}
				_planstackpopnode(planner);
				break;
			}
			default:
			{
				_planstackpopnode(planner);
				break;
			}
		}
		childnodeentry = parentnodeentry;
	}
	return result;
}

/*
	Name: _planprocessstack
	Namespace: planner
	Checksum: 0xA6771835
	Offset: 0x10B0
	Size: 0x24A
	Parameters: 1
	Flags: Linked, Private
*/
private function _planprocessstack(planner)
{
	/#
		assert(isstruct(planner));
	#/
	result = 1;
	waitedinthrottle = 0;
	while(_planstackhasnodes(planner))
	{
		planner.planstarttime = getrealtime();
		nodeentry = _planstackpeeknode(planner);
		switch(nodeentry.node.type)
		{
			case "action":
			{
				result = _planexpandaction(planner, nodeentry.node);
				break;
			}
			case "postcondition":
			{
				result = _planexpandpostcondition(planner, nodeentry.node);
				break;
			}
			case "precondition":
			{
				result = _planexpandprecondition(planner, nodeentry.node);
				break;
			}
			case "selector":
			case "sequence":
			case "planner":
			{
				_planstackpushnode(planner, nodeentry.node.children[0], 0);
				continue;
			}
			default:
			{
				/#
					assert(0, "" + nodeentry.node.type + "");
				#/
				break;
			}
		}
		result = _planpushvalidparent(planner, nodeentry, result);
	}
}

/*
	Name: _undoplan
	Namespace: planner
	Checksum: 0xD0C58196
	Offset: 0x1308
	Size: 0xEA
	Parameters: 2
	Flags: Linked, Private
*/
private function _undoplan(planner, planindex)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.plan));
	#/
	/#
		assert(planindex < planner.plan.size);
	#/
	for(index = planner.plan.size - 1; index > planindex && index >= 0; index--)
	{
		planner.plan[index] = undefined;
	}
}

/*
	Name: addaction
	Namespace: planner
	Checksum: 0xE5F66D2E
	Offset: 0x1400
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function addaction(parent, actionname, constants)
{
	node = createaction(actionname, constants);
	addchild(parent, node);
	return node;
}

/*
	Name: addchild
	Namespace: planner
	Checksum: 0x3539AE9F
	Offset: 0x1460
	Size: 0xB2
	Parameters: 2
	Flags: Linked
*/
function addchild(parent, node)
{
	/#
		assert(isstruct(parent));
	#/
	/#
		assert(isstruct(node));
	#/
	/#
		assert(isarray(parent.children));
	#/
	parent.children[parent.children.size] = node;
}

/*
	Name: addgoto
	Namespace: planner
	Checksum: 0xE0D3A5B5
	Offset: 0x1520
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function addgoto(parent, gotonode)
{
	addchild(parent, gotonode);
}

/*
	Name: addselector
	Namespace: planner
	Checksum: 0xDB7675AA
	Offset: 0x1558
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function addselector(parent)
{
	node = createselector();
	addchild(parent, node);
	return node;
}

/*
	Name: addsequence
	Namespace: planner
	Checksum: 0xD28F8660
	Offset: 0x15A0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function addsequence(parent)
{
	node = createsequence();
	addchild(parent, node);
	return node;
}

/*
	Name: addpostcondition
	Namespace: planner
	Checksum: 0xF15278B9
	Offset: 0x15E8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function addpostcondition(parent, functionname, constants)
{
	node = createpostcondition(functionname, constants);
	addchild(parent, node);
	return node;
}

/*
	Name: addprecondition
	Namespace: planner
	Checksum: 0x1E41C244
	Offset: 0x1648
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function addprecondition(parent, functionname, constants)
{
	node = createprecondition(functionname, constants);
	addchild(parent, node);
	return node;
}

/*
	Name: cancel
	Namespace: planner
	Checksum: 0xF72218F5
	Offset: 0x16A8
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function cancel(planner)
{
	/#
		assert(isstruct(planner));
	#/
	planner.cancel = 1;
}

/*
	Name: createaction
	Namespace: planner
	Checksum: 0x79C1AB7F
	Offset: 0x16F8
	Size: 0xC6
	Parameters: 2
	Flags: Linked
*/
function createaction(actionname, constants)
{
	/#
		assert(!isdefined(constants) || isarray(constants));
	#/
	/#
		assert(function_7a600918(actionname));
	#/
	node = spawnstruct();
	node.type = "action";
	node.api = actionname;
	node.constants = constants;
	return node;
}

/*
	Name: createplanner
	Namespace: planner
	Checksum: 0xE4F462D8
	Offset: 0x17C8
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function createplanner(name)
{
	/#
		assert(function_7a600918(name));
	#/
	planner = spawnstruct();
	planner.cancel = 0;
	planner.children = [];
	planner.name = name;
	planner.planning = 0;
	planner.type = "planner";
	planner.blackboards = [];
	planner.blackboards[0] = plannerblackboard::create([]);
	return planner;
}

/*
	Name: createpostcondition
	Namespace: planner
	Checksum: 0xED52093F
	Offset: 0x1898
	Size: 0x126
	Parameters: 2
	Flags: Linked
*/
function createpostcondition(functionname, constants)
{
	/#
		assert(function_7a600918(functionname));
	#/
	/#
		assert(!isdefined(constants) || isarray(constants));
	#/
	/#
		assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "" + function_9e72a96(functionname) + "");
	#/
	node = spawnstruct();
	node.type = "postcondition";
	node.api = functionname;
	node.constants = constants;
	return node;
}

/*
	Name: createprecondition
	Namespace: planner
	Checksum: 0x2148A93E
	Offset: 0x19C8
	Size: 0x126
	Parameters: 2
	Flags: Linked
*/
function createprecondition(functionname, constants)
{
	/#
		assert(function_7a600918(functionname));
	#/
	/#
		assert(!isdefined(constants) || isarray(constants));
	#/
	/#
		assert(isfunctionptr(plannerutility::getplannerapifunction(functionname)), "" + function_9e72a96(functionname) + "");
	#/
	node = spawnstruct();
	node.type = "precondition";
	node.api = functionname;
	node.constants = constants;
	return node;
}

/*
	Name: createselector
	Namespace: planner
	Checksum: 0x637C2A73
	Offset: 0x1AF8
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function createselector()
{
	node = spawnstruct();
	node.children = [];
	node.type = "selector";
	return node;
}

/*
	Name: createsequence
	Namespace: planner
	Checksum: 0xFEBCE52F
	Offset: 0x1B48
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function createsequence()
{
	node = spawnstruct();
	node.children = [];
	node.type = "sequence";
	return node;
}

/*
	Name: createsubblackboard
	Namespace: planner
	Checksum: 0x19FE12A6
	Offset: 0x1B98
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function createsubblackboard(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	newblackboardindex = planner.blackboards.size;
	defaultvalues = [];
	planner.blackboards[newblackboardindex] = plannerblackboard::create(defaultvalues);
	plannerblackboard::setreadwritemode(planner.blackboards[newblackboardindex]);
	return newblackboardindex;
}

/*
	Name: getblackboardattribute
	Namespace: planner
	Checksum: 0x92932927
	Offset: 0x1C78
	Size: 0x122
	Parameters: 3
	Flags: Linked
*/
function getblackboardattribute(planner, attribute, blackboardindex = 0)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstring(attribute) || function_7a600918(attribute));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	/#
		assert(isstruct(planner.blackboards[blackboardindex]));
	#/
	return plannerblackboard::getattribute(planner.blackboards[blackboardindex], attribute);
}

/*
	Name: getblackboardvalues
	Namespace: planner
	Checksum: 0xBE7BC252
	Offset: 0x1DA8
	Size: 0xBA
	Parameters: 2
	Flags: None
*/
function getblackboardvalues(planner, blackboardindex)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	/#
		assert(isstruct(planner.blackboards[blackboardindex]));
	#/
	return planner.blackboards[blackboardindex].values;
}

/*
	Name: getsubblackboard
	Namespace: planner
	Checksum: 0xA43D50B5
	Offset: 0x1E70
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function getsubblackboard(planner, blackboardindex)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	/#
		assert(blackboardindex > 0 && blackboardindex < planner.blackboards.size);
	#/
	return planner.blackboards[blackboardindex];
}

/*
	Name: plan
	Namespace: planner
	Checksum: 0x424CED55
	Offset: 0x1F30
	Size: 0x286
	Parameters: 5
	Flags: Linked
*/
function plan(planner, blackboardvalues, maxframetime = 3, starttime = undefined, var_302e19d3 = 0)
{
	pixbeginevent(planner.name);
	aiprofile_beginentry(planner.name);
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(blackboardvalues));
	#/
	planner.cancel = 0;
	planner.maxframetime = maxframetime;
	planner.plan = [];
	planner.planning = 1;
	planner.planstarttime = starttime;
	if(!isdefined(planner.planstarttime))
	{
		planner.planstarttime = getrealtime();
	}
	if(!var_302e19d3)
	{
		planner.blackboards = [];
		planner.blackboards[0] = plannerblackboard::create(blackboardvalues);
	}
	planner.nodestack = [];
	_planstackpushnode(planner, planner);
	_planprocessstack(planner);
	planner.nodestack = [];
	planner.planning = 0;
	foreach(subblackboard in planner.blackboards)
	{
		plannerblackboard::clearundostack(subblackboard);
	}
	aiprofile_endentry();
	pixendevent();
	return planner.plan;
}

/*
	Name: printplanner
	Namespace: planner
	Checksum: 0xBA353C39
	Offset: 0x21C0
	Size: 0xDC
	Parameters: 2
	Flags: None
*/
function printplanner(planner, filename)
{
	/#
		/#
			assert(isstruct(planner));
		#/
		file = openfile(filename, "");
		printid = randomint(2147483647);
		_printplannernode(file, planner, 0, printid);
		_printclearprintid(planner);
		closefile(file);
	#/
}

/*
	Name: _printclearprintid
	Namespace: planner
	Checksum: 0x4786A905
	Offset: 0x22A8
	Size: 0x96
	Parameters: 1
	Flags: Private
*/
private function _printclearprintid(plannernode)
{
	/#
		plannernode.printid = undefined;
		if(isdefined(plannernode.children))
		{
			for(index = 0; index < plannernode.children.size; index++)
			{
				if(isdefined(plannernode.children[index].printid))
				{
					_printclearprintid(plannernode.children[index]);
				}
			}
		}
	#/
}

/*
	Name: function_3af5bab0
	Namespace: planner
	Checksum: 0x863AF71D
	Offset: 0x2348
	Size: 0x254
	Parameters: 1
	Flags: Private
*/
private function function_3af5bab0(node)
{
	/#
		text = node.type;
		if(isdefined(node.name))
		{
			text = text + "" + node.name;
		}
		if(isdefined(node.api))
		{
			text = text + "" + node.api;
		}
		if(isdefined(node.constants))
		{
			text = text + "";
			first = 1;
			foreach(key, value in node.constants)
			{
				if(!first)
				{
					text = text + "";
				}
				if(isint(value) || isfloat(value))
				{
					text = text + key + "" + value;
				}
				else if(isstring(value))
				{
					text = text + key + "" + value + "";
				}
				else if(isarray(value))
				{
					text = text + key + "";
				}
				else if(!isdefined(value))
				{
					text = text + key + "";
				}
				first = 0;
			}
		}
		if(isdefined(node.name) || isdefined(node.api))
		{
			text = text + "";
		}
		return text;
	#/
}

/*
	Name: _printplannernode
	Namespace: planner
	Checksum: 0x392185FF
	Offset: 0x25A8
	Size: 0x1BE
	Parameters: 4
	Flags: Private
*/
private function _printplannernode(file, plannernode, indent, printid)
{
	/#
		/#
			assert(isstruct(plannernode));
		#/
		indentspace = "";
		for(index = 0; index < indent; index++)
		{
			indentspace = indentspace + "";
		}
		text = "";
		if(plannernode.printid === printid)
		{
			text = text + "";
			text = text + function_3af5bab0(plannernode);
			fprintln(file, indentspace + text);
			return;
		}
		plannernode.printid = printid;
		text = function_3af5bab0(plannernode);
		fprintln(file, indentspace + text);
		if(isdefined(plannernode.children))
		{
			for(index = 0; index < plannernode.children.size; index++)
			{
				_printplannernode(file, plannernode.children[index], indent + 1, printid);
			}
		}
	#/
}

/*
	Name: setblackboardattribute
	Namespace: planner
	Checksum: 0xCB1F5636
	Offset: 0x2770
	Size: 0x14C
	Parameters: 5
	Flags: Linked
*/
function setblackboardattribute(planner, attribute, value, blackboardindex = 0, readonly = 0)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isstring(attribute) || function_7a600918(attribute));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	/#
		assert(isstruct(planner.blackboards[blackboardindex]));
	#/
	plannerblackboard::setattribute(planner.blackboards[blackboardindex], attribute, value, readonly);
}

/*
	Name: subblackboardcount
	Namespace: planner
	Checksum: 0x2C749CE5
	Offset: 0x28C8
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function subblackboardcount(planner)
{
	/#
		assert(isstruct(planner));
	#/
	/#
		assert(isarray(planner.blackboards));
	#/
	return planner.blackboards.size - 1;
}

#namespace plannerutility;

/*
	Name: createplannerfromasset
	Namespace: plannerutility
	Checksum: 0x6772921
	Offset: 0x2948
	Size: 0x4AA
	Parameters: 1
	Flags: Linked
*/
function createplannerfromasset(assetname)
{
	htnasset = gethierarchicaltasknetwork(assetname);
	if(isdefined(htnasset) && htnasset.nodes.size > 0)
	{
		plannernodes = [];
		if(htnasset.nodes.size >= 1)
		{
			node = htnasset.nodes[0];
			plannernodes[0] = planner::createplanner(node.name);
		}
		for(nodeindex = 1; nodeindex < htnasset.nodes.size; nodeindex++)
		{
			node = htnasset.nodes[nodeindex];
			switch(node.type)
			{
				case "action":
				{
					plannernodes[nodeindex] = planner::createaction(node.name, node.constants);
					break;
				}
				case "postcondition":
				{
					plannernodes[nodeindex] = planner::createpostcondition(node.name, node.constants);
					break;
				}
				case "precondition":
				{
					plannernodes[nodeindex] = planner::createprecondition(node.name, node.constants);
					break;
				}
				case "planner":
				{
					plannernodes[nodeindex] = planner::createplanner(node.name);
					break;
				}
				case "selector":
				{
					plannernodes[nodeindex] = planner::createselector();
					break;
				}
				case "sequence":
				{
					plannernodes[nodeindex] = planner::createsequence();
					break;
				}
				case "goto":
				{
					plannernodes[nodeindex] = spawnstruct();
					break;
				}
			}
		}
		for(nodeindex = 0; nodeindex < htnasset.nodes.size; nodeindex++)
		{
			parentnode = plannernodes[nodeindex];
			htnnode = htnasset.nodes[nodeindex];
			if(!isdefined(htnnode.childindexes) || htnnode.type == #"goto")
			{
				continue;
			}
			for(childindex = 0; childindex < htnnode.childindexes.size; childindex++)
			{
				/#
					assert(htnnode.childindexes[childindex] < plannernodes.size);
				#/
				childnum = htnnode.childindexes[childindex];
				childnode = plannernodes[childnum];
				htnchildnode = htnasset.nodes[childnum];
				while(htnchildnode.type === #"goto")
				{
					/#
						assert(isdefined(htnchildnode.childindexes));
					#/
					/#
						assert(htnchildnode.childindexes.size == 1);
					#/
					childnum = htnchildnode.childindexes[0];
					childnode = plannernodes[childnum];
					htnchildnode = htnasset.nodes[childnum];
				}
				planner::addchild(parentnode, childnode);
			}
		}
		return plannernodes[0];
	}
}

/*
	Name: getplannerapifunction
	Namespace: plannerutility
	Checksum: 0xAEA18E2E
	Offset: 0x2E00
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function getplannerapifunction(functionname)
{
	/#
		assert(function_7a600918(functionname) && functionname != "", "");
	#/
	/#
		assert(isdefined(level._plannerscriptfunctions[#"api"][functionname]), "" + function_9e72a96(functionname) + "");
	#/
	return level._plannerscriptfunctions[#"api"][functionname];
}

/*
	Name: getplanneractionfunctions
	Namespace: plannerutility
	Checksum: 0x68BECD93
	Offset: 0x2EC8
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function getplanneractionfunctions(actionname)
{
	/#
		assert(function_7a600918(actionname) && actionname != "", "");
	#/
	/#
		assert(isdefined(level._plannerscriptfunctions[#"action"][actionname]), "" + function_9e72a96(actionname) + "");
	#/
	return level._plannerscriptfunctions[#"action"][actionname];
}

/*
	Name: registerplannerapi
	Namespace: plannerutility
	Checksum: 0x9AEA3328
	Offset: 0x2F90
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function registerplannerapi(functionname, functionptr)
{
	/#
		assert(function_7a600918(functionname) && functionname != "", "");
	#/
	/#
		assert(isfunctionptr(functionptr), "" + function_9e72a96(functionname) + "");
	#/
	planner::_initializeplannerfunctions(#"api");
	/#
		assert(!isdefined(level._plannerscriptfunctions[#"api"][functionname]), "" + functionname + "");
	#/
	level._plannerscriptfunctions[#"api"][functionname] = functionptr;
}

/*
	Name: registerplanneraction
	Namespace: plannerutility
	Checksum: 0xC1AE2C31
	Offset: 0x30D8
	Size: 0x246
	Parameters: 5
	Flags: Linked
*/
function registerplanneraction(actionname, paramfuncptr, initializefuncptr, updatefuncptr, terminatefuncptr)
{
	/#
		assert(function_7a600918(actionname) && actionname != "", "");
	#/
	planner::_initializeplannerfunctions("Action");
	/#
		assert(!isdefined(level._plannerscriptfunctions[#"action"][actionname]), "" + function_9e72a96(actionname) + "");
	#/
	level._plannerscriptfunctions[#"action"][actionname] = [];
	if(isfunctionptr(paramfuncptr))
	{
		level._plannerscriptfunctions[#"action"][actionname][#"parameterize"] = paramfuncptr;
	}
	if(isfunctionptr(initializefuncptr))
	{
		level._plannerscriptfunctions[#"action"][actionname][#"initialize"] = initializefuncptr;
	}
	if(isfunctionptr(updatefuncptr))
	{
		level._plannerscriptfunctions[#"action"][actionname][#"update"] = updatefuncptr;
	}
	if(isfunctionptr(terminatefuncptr))
	{
		level._plannerscriptfunctions[#"action"][actionname][#"terminate"] = terminatefuncptr;
	}
}

