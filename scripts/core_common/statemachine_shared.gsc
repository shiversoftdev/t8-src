// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace statemachine;

/*
	Name: create
	Namespace: statemachine
	Checksum: 0xEB03767A
	Offset: 0x78
	Size: 0x140
	Parameters: 3
	Flags: Linked
*/
function create(name, owner, change_notify = "change_state")
{
	state_machine = spawnstruct();
	state_machine.name = name;
	state_machine.states = [];
	state_machine.previous_state = undefined;
	state_machine.current_state = undefined;
	state_machine.next_state = undefined;
	state_machine.change_note = change_notify;
	if(isdefined(owner))
	{
		state_machine.owner = owner;
	}
	else
	{
		state_machine.owner = level;
	}
	if(!isdefined(state_machine.owner.state_machines))
	{
		state_machine.owner.state_machines = [];
	}
	state_machine.owner.state_machines[state_machine.name] = state_machine;
	/#
		owner thread function_acc83382();
	#/
	return state_machine;
}

/*
	Name: clear
	Namespace: statemachine
	Checksum: 0x630260D7
	Offset: 0x1C0
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function clear()
{
	if(isdefined(self.states) && isarray(self.states))
	{
		foreach(state in self.states)
		{
			state.connections_notify = undefined;
			state.connections_utility = undefined;
		}
	}
	self.states = undefined;
	self.previous_state = undefined;
	self.current_state = undefined;
	self.next_state = undefined;
	self.owner = undefined;
	self notify(#"_cancel_connections");
}

/*
	Name: add_state
	Namespace: statemachine
	Checksum: 0xB8AC72CB
	Offset: 0x2A8
	Size: 0x144
	Parameters: 5
	Flags: Linked
*/
function add_state(name, enter_func, update_func, exit_func, reenter_func)
{
	if(!isdefined(self.states[name]))
	{
		self.states[name] = spawnstruct();
	}
	self.states[name].name = name;
	self.states[name].enter_func = enter_func;
	self.states[name].exit_func = exit_func;
	self.states[name].update_func = update_func;
	self.states[name].reenter_func = reenter_func;
	self.states[name].connections_notify = [];
	self.states[name].connections_utility = [];
	self.states[name].owner = self;
	return self.states[name];
}

/*
	Name: get_state
	Namespace: statemachine
	Checksum: 0x1EDEC118
	Offset: 0x3F8
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function get_state(name)
{
	return self.states[name];
}

/*
	Name: has_state
	Namespace: statemachine
	Checksum: 0xBDB16F2
	Offset: 0x418
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function has_state(name)
{
	return isdefined(self.states) && isdefined(self.states[name]);
}

/*
	Name: add_interrupt_connection
	Namespace: statemachine
	Checksum: 0xB384BE65
	Offset: 0x448
	Size: 0xFC
	Parameters: 4
	Flags: Linked
*/
function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc)
{
	from_state = get_state(from_state_name);
	to_state = get_state(to_state_name);
	connection = spawnstruct();
	connection.to_state = to_state;
	connection.type = 0;
	connection.on_notify = on_notify;
	connection.checkfunc = checkfunc;
	from_state.connections_notify[on_notify] = connection;
	return from_state.connections_notify[from_state.connections_notify.size - 1];
}

/*
	Name: add_utility_connection
	Namespace: statemachine
	Checksum: 0xBC4DDC6C
	Offset: 0x550
	Size: 0x190
	Parameters: 4
	Flags: Linked
*/
function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore)
{
	from_state = get_state(from_state_name);
	to_state = get_state(to_state_name);
	connection = spawnstruct();
	connection.to_state = to_state;
	connection.type = 1;
	connection.checkfunc = checkfunc;
	connection.score = defaultscore;
	if(!isdefined(connection.score))
	{
		connection.score = 100;
	}
	if(!isdefined(from_state.connections_utility))
	{
		from_state.connections_utility = [];
	}
	else if(!isarray(from_state.connections_utility))
	{
		from_state.connections_utility = array(from_state.connections_utility);
	}
	from_state.connections_utility[from_state.connections_utility.size] = connection;
	return from_state.connections_utility[from_state.connections_utility.size - 1];
}

/*
	Name: function_b94a7666
	Namespace: statemachine
	Checksum: 0x30E1DB99
	Offset: 0x6E8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_b94a7666(from_state_name, on_notify)
{
	from_state = get_state(from_state_name);
	arrayremoveindex(from_state.connections_notify, on_notify, 1);
}

/*
	Name: set_state
	Namespace: statemachine
	Checksum: 0x5C250DF2
	Offset: 0x750
	Size: 0x280
	Parameters: 2
	Flags: Linked
*/
function set_state(name, state_params)
{
	state = self.states[name];
	if(!isdefined(self.owner))
	{
		return false;
	}
	if(!isdefined(state))
	{
		/#
			assertmsg((("" + name) + "") + self.name);
		#/
		return false;
	}
	reenter = self.current_state === state;
	if(isdefined(state.reenter_func) && reenter)
	{
		shouldreenter = self.owner [[state.reenter_func]](state.state_params);
	}
	if(reenter && shouldreenter !== 1)
	{
		return false;
	}
	if(isdefined(self.current_state))
	{
		self.next_state = state;
		if(isdefined(self.current_state.exit_func))
		{
			self.owner [[self.current_state.exit_func]](self.current_state.state_params);
		}
		if(!reenter)
		{
			self.previous_state = self.current_state;
		}
		self.current_state.state_params = undefined;
	}
	if(!isdefined(state_params))
	{
		state_params = spawnstruct();
	}
	state.state_params = state_params;
	self.owner notify(self.change_note);
	self.current_state = state;
	self threadnotifyconnections(self.current_state);
	if(isdefined(self.current_state.enter_func))
	{
		self.owner [[self.current_state.enter_func]](self.current_state.state_params);
	}
	if(isdefined(self.current_state.update_func))
	{
		self.owner thread [[self.current_state.update_func]](self.current_state.state_params);
	}
	return true;
}

/*
	Name: threadnotifyconnections
	Namespace: statemachine
	Checksum: 0xAF1883EF
	Offset: 0x9D8
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function threadnotifyconnections(state)
{
	self notify(#"_cancel_connections");
	foreach(connection in state.connections_notify)
	{
		/#
			assert(connection.type == 0);
		#/
		self.owner thread connection_on_notify(self, connection.on_notify, connection);
	}
}

/*
	Name: connection_on_notify
	Namespace: statemachine
	Checksum: 0x322B05F1
	Offset: 0xAB0
	Size: 0x100
	Parameters: 3
	Flags: Linked
*/
function connection_on_notify(state_machine, notify_name, connection)
{
	self endon(state_machine.change_note);
	state_machine endon(#"_cancel_connections");
	while(true)
	{
		params = undefined;
		params = self waittill(notify_name);
		connectionvalid = 1;
		if(isdefined(connection.checkfunc))
		{
			connectionvalid = self [[connection.checkfunc]](state_machine.current_state.name, connection.to_state.name, connection, params);
		}
		if(connectionvalid)
		{
			state_machine thread set_state(connection.to_state.name, params);
		}
	}
}

/*
	Name: evaluate_connections
	Namespace: statemachine
	Checksum: 0x4D238523
	Offset: 0xBB8
	Size: 0x2A4
	Parameters: 2
	Flags: Linked
*/
function evaluate_connections(eval_func, params)
{
	/#
		assert(isdefined(self.current_state));
	#/
	connectionarray = [];
	scorearray = [];
	best_connection = undefined;
	best_score = -1;
	foreach(connection in self.current_state.connections_utility)
	{
		/#
			assert(connection.type == 1);
		#/
		score = connection.score;
		if(isdefined(connection.checkfunc))
		{
			score = self.owner [[connection.checkfunc]](self.current_state.name, connection.to_state.name, connection);
		}
		if(score > 0)
		{
			if(!isdefined(connectionarray))
			{
				connectionarray = [];
			}
			else if(!isarray(connectionarray))
			{
				connectionarray = array(connectionarray);
			}
			connectionarray[connectionarray.size] = connection;
			if(!isdefined(scorearray))
			{
				scorearray = [];
			}
			else if(!isarray(scorearray))
			{
				scorearray = array(scorearray);
			}
			scorearray[scorearray.size] = score;
			if(score > best_score)
			{
				best_connection = connection;
				best_score = score;
			}
		}
	}
	if(isdefined(eval_func) && connectionarray.size > 0)
	{
		best_connection = self.owner [[eval_func]](connectionarray, scorearray, self.current_state);
	}
	if(isdefined(best_connection))
	{
		self thread set_state(best_connection.to_state.name, params);
	}
}

/*
	Name: debugon
	Namespace: statemachine
	Checksum: 0x9E3D5BC2
	Offset: 0xE68
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function debugon()
{
	/#
		dvarval = getdvarint(#"statemachine_debug", 0);
		return dvarval > 0;
	#/
}

/*
	Name: function_acc83382
	Namespace: statemachine
	Checksum: 0x41ADE5A
	Offset: 0xEB0
	Size: 0x270
	Parameters: 0
	Flags: None
*/
function function_acc83382()
{
	/#
		owner = self;
		if(!isdefined(owner))
		{
			return;
		}
		if(!debugon())
		{
			return;
		}
		owner notify(#"hash_616497f187c816cf");
		owner endon(#"death", #"hash_616497f187c816cf");
		heightstart = owner getmaxs()[2];
		if(!isdefined(heightstart))
		{
			heightstart = 20;
		}
		while(true)
		{
			i = 1;
			foreach(state_machine in owner.state_machines)
			{
				statename = "";
				if(isdefined(state_machine.current_state) && isdefined(state_machine.current_state.name))
				{
					statename = state_machine.current_state.name;
				}
				if(!getdvarint(#"recorder_enablerec", 0))
				{
					heightoffset = heightstart * i;
					print3d(owner.origin + (0, 0, heightoffset), (("" + state_machine.name) + "") + statename, (1, 1, 0));
				}
				else
				{
					record3dtext((("" + state_machine.name) + "") + statename, owner.origin, (1, 1, 0), "", owner, 1);
				}
				i++;
			}
			waitframe(1);
		}
	#/
}

