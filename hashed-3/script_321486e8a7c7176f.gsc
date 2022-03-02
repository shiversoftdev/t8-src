// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_30e0aa25775a6927;
#using script_31e56101095f174b;
#using script_aa63c66acbb23e;

#namespace plannersquad;

/*
	Name: function_bf7acc22
	Namespace: plannersquad
	Checksum: 0xCCFD251E
	Offset: 0x98
	Size: 0xF0
	Parameters: 1
	Flags: Private
*/
function private function_bf7acc22(squad)
{
	botentries = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	foreach(botinfo in botentries)
	{
		bot = botinfo[#"__unsafe__"][#"bot"];
		if(isdefined(bot) && isdefined(bot.bot))
		{
			bot bot::function_6c280dfe();
		}
	}
}

/*
	Name: _debugsquad
	Namespace: plannersquad
	Checksum: 0x1283B2EC
	Offset: 0x190
	Size: 0xDE8
	Parameters: 1
	Flags: Private
*/
function private _debugsquad(squad)
{
	/#
		if(!isdefined(level.__plannersquaddebug))
		{
			level.__plannersquaddebug = [];
		}
		for(index = 0; index <= level.__plannersquaddebug.size; index++)
		{
			if(!isdefined(level.__plannersquaddebug[index]) || level.__plannersquaddebug[index].shutdown)
			{
				break;
			}
		}
		level.__plannersquaddebug[index] = squad;
		squadid = index + 1;
		while(isdefined(squad) && !squad.shutdown)
		{
			var_deb0d0ec = 0;
			squadid = getdvarint(#"ai_debugsquad", 0);
			if(isdefined(squad.blackboard) && isdefined(squad.blackboard.values[#"doppelbots"]))
			{
				doppelbots = squad.blackboard.values[#"doppelbots"];
				foreach(doppelbot in doppelbots)
				{
					if(doppelbot[#"entnum"] == squadid)
					{
						var_deb0d0ec = 1;
						break;
					}
				}
			}
			if(var_deb0d0ec)
			{
				position = (0, 0, 0);
				xoffset = 200;
				yoffset = 10;
				textscale = 0.7;
				bots = plannersquadutility::getblackboardattribute(squad, "");
				bottext = "";
				foreach(botentry in bots)
				{
					bot = botentry[#"__unsafe__"][#"bot"];
					if(strategiccommandutility::isvalidbot(bot))
					{
						bottext = bottext + ((("" + bot getentitynumber()) + "") + bot.name);
					}
				}
				team = plannersquadutility::getblackboardattribute(squad, "");
				side = strategiccommandutility::function_a1edb007(team);
				recordtext(side + bottext, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				xoffset = xoffset + 15;
				yoffset = yoffset + 13;
				timing = (((("" + squad.planstarttime) + "") + squad.planfinishtime) + "") + (int((squad.planfinishtime - squad.planstarttime) / ((float(function_60d95f53()) / 1000) * 1000) + 1)) + "";
				recordtext(timing, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				xoffset = xoffset + 15;
				target = plannersquadutility::getblackboardattribute(squad, "");
				if(isdefined(target))
				{
					var_3d879b56 = target[#"strategy"];
					if(isdefined(var_3d879b56))
					{
						if(isdefined(var_3d879b56.sdebug))
						{
							foreach(str in var_3d879b56.sdebug)
							{
								yoffset = yoffset + 13;
								recordtext(str, position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
							}
							xoffset = xoffset + 15;
						}
						var_45c7238e = function_101999aa(var_3d879b56, "", array("", "", "", "", "", "", "", ""), position + (500, 10, 0), (1, 1, 1), "", textscale);
						function_101999aa(var_3d879b56, "", array("", "", "", "", "", "", "", ""), position + (500, 10 + var_45c7238e, 0), (1, 1, 1), "", textscale);
						targetpos = undefined;
						var_35e9a86a = undefined;
						if(target[#"type"] == "")
						{
							entity = target[#"__unsafe__"][#"entity"];
							if(isdefined(entity))
							{
								targetpos = entity.origin;
								object = target[#"__unsafe__"][#"object"];
								if(isdefined(object))
								{
									if(isdefined(object))
									{
										var_35e9a86a = object.trigger;
									}
								}
							}
						}
						else
						{
							if(target[#"type"] == "" || target[#"type"] == "")
							{
								var_5fbc7570 = target[#"__unsafe__"][#"hash_57b897c5ec9b1b71"];
								targetpos = var_5fbc7570.origin;
								component = target[#"__unsafe__"][#"component"];
								var_35e9a86a = component.var_2956bff4;
								if(isdefined(component.var_6bc907c4))
								{
									function_f301de44(component.var_6bc907c4, (1, 0, 1), "");
									recordline(targetpos, component.var_6bc907c4.origin, (1, 0, 1), "");
									record3dtext("", component.var_6bc907c4.origin, (1, 0, 1), "", textscale);
								}
							}
							else
							{
								if(target[#"type"] == "")
								{
									var_5fbc7570 = target[#"__unsafe__"][#"hash_57b897c5ec9b1b71"];
									targetpos = var_5fbc7570.origin;
									component = target[#"__unsafe__"][#"component"];
									var_35e9a86a = component.var_cc67d976;
								}
								else
								{
									if(target[#"type"] == "")
									{
										var_5fbc7570 = target[#"__unsafe__"][#"hash_57b897c5ec9b1b71"];
										targetpos = var_5fbc7570.origin;
										component = target[#"__unsafe__"][#"component"];
										var_35e9a86a = component.var_c68dc48c;
									}
									else
									{
										if(target[#"type"] == "")
										{
											bundle = target[#"__unsafe__"][#"bundle"];
											targetpos = bundle.var_27726d51.origin;
										}
										else
										{
											yoffset = yoffset + 13;
											recordtext("" + target[#"type"], position + (xoffset, yoffset, 0), (1, 0, 0), "", textscale);
										}
									}
								}
							}
						}
						if(isdefined(targetpos))
						{
							recordsphere(targetpos, 20, (1, 0, 1));
							record3dtext("" + target[#"type"], targetpos + vectorscale((0, 0, 1), 21), (1, 0, 1), "", textscale);
							if(isdefined(var_35e9a86a))
							{
								function_f301de44(var_35e9a86a, (1, 0, 1), "");
								recordline(targetpos, var_35e9a86a.origin, (1, 0, 1), "");
								record3dtext("", var_35e9a86a.origin, (1, 0, 1), "", textscale);
							}
						}
						else
						{
							yoffset = yoffset + 13;
							recordtext("", position + (xoffset, yoffset, 0), (1, 0, 0), "", textscale);
						}
					}
				}
				else
				{
					yoffset = yoffset + 13;
					recordtext("", position + (xoffset, yoffset, 0), (1, 0, 0), "", textscale);
				}
				for(index = 0; index < squad.plan.size; index++)
				{
					yoffset = yoffset + 13;
					recordtext(function_9e72a96(squad.plan[index].name), position + (xoffset, yoffset, 0), (1, 1, 1), "", textscale);
				}
			}
			if(getdvarint(#"ai_debuggoldenpath", 0) == squadid)
			{
				escortpoi = plannersquadutility::getblackboardattribute(squad, "");
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_101999aa
	Namespace: plannersquad
	Checksum: 0xDA741A5A
	Offset: 0xF80
	Size: 0x15A
	Parameters: 7
	Flags: Private
*/
function private function_101999aa(strategy, header, var_71b35362, position, color, channel, textscale)
{
	/#
		xoffset = 0;
		yoffset = 0;
		recordtext(header, position, color, channel, textscale);
		xoffset = xoffset + 15;
		foreach(field in var_71b35362)
		{
			yoffset = yoffset + 13;
			recordtext((field + "") + strategy.(field), position + (xoffset, yoffset, 0), color, channel, textscale);
		}
		yoffset = yoffset + 13;
		return yoffset;
	#/
}

/*
	Name: function_f301de44
	Namespace: plannersquad
	Checksum: 0x8E80008A
	Offset: 0x10E8
	Size: 0x1AC
	Parameters: 3
	Flags: Private
*/
function private function_f301de44(trigger, color, channel)
{
	/#
		maxs = trigger getmaxs();
		mins = trigger getmins();
		if(issubstr(trigger.classname, ""))
		{
			radius = max(maxs[0], maxs[1]);
			top = trigger.origin + (0, 0, maxs[2]);
			bottom = trigger.origin + (0, 0, mins[2]);
			recordcircle(bottom, radius, color, channel);
			recordcircle(top, radius, color, channel);
			recordline(bottom, top, color, channel);
		}
		else
		{
			function_af72dbc5(trigger.origin, mins, maxs, trigger.angles[0], color, channel);
		}
	#/
}

/*
	Name: _executeplan
	Namespace: plannersquad
	Checksum: 0x283B6616
	Offset: 0x12A0
	Size: 0x2CE
	Parameters: 1
	Flags: Linked, Private
*/
function private _executeplan(squad)
{
	/#
		assert(isdefined(squad));
	#/
	/#
		assert(isdefined(squad.plan), "");
	#/
	/#
		assert(isdefined(squad.plan.size), "");
	#/
	if(!isdefined(squad.currentplanindex))
	{
		squad.currentplanindex = 0;
	}
	if(squad.actionstatus === 1)
	{
		squad.actionstatus = undefined;
		squad.currentplanindex++;
	}
	if(squad.currentplanindex >= squad.plan.size || squad.actionstatus === 2)
	{
		squad.plan = [];
		squad.actionstatus = undefined;
		squad.currentplanindex = undefined;
		return;
	}
	action = squad.plan[squad.currentplanindex];
	functions = plannerutility::getplanneractionfunctions(action.name);
	if(!isdefined(squad.actionstatus))
	{
		if(isdefined(functions[#"initialize"]))
		{
			squad.actionstatus = [[functions[#"initialize"]]](squad.planner, action.params);
		}
		else
		{
			squad.actionstatus = 1;
		}
	}
	if(squad.actionstatus === 1 || squad.actionstatus === 3)
	{
		if(isdefined(functions[#"update"]))
		{
			squad.actionstatus = [[functions[#"update"]]](squad.planner, action.params);
		}
	}
	if(squad.actionstatus === 1)
	{
		if(isdefined(functions[#"terminate"]))
		{
			squad.actionstatus = [[functions[#"terminate"]]](squad.planner, action.params);
		}
	}
}

/*
	Name: function_9de03b3f
	Namespace: plannersquad
	Checksum: 0xAA6CEBAC
	Offset: 0x1578
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9de03b3f(squad)
{
	botentries = plannersquadutility::getblackboardattribute(squad, "doppelbots");
	if(!isdefined(botentries))
	{
		return false;
	}
	foreach(botinfo in botentries)
	{
		if(isdefined(botinfo[#"__unsafe__"][#"bot"]))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: _plan
	Namespace: plannersquad
	Checksum: 0xB1972837
	Offset: 0x1658
	Size: 0x7A
	Parameters: 1
	Flags: Linked, Private
*/
function private _plan(squad)
{
	planstarttime = gettime();
	squad.plan = planner::plan(squad.planner, squad.blackboard.values, squad.maxplannerframetime);
	squad.planstarttime = planstarttime;
	squad.planfinishtime = gettime();
}

/*
	Name: _strategize
	Namespace: plannersquad
	Checksum: 0xB1C915A3
	Offset: 0x16E0
	Size: 0xDE
	Parameters: 1
	Flags: Linked, Private
*/
function private _strategize(squad)
{
	/#
		assert(isdefined(squad));
	#/
	/#
		assert(isdefined(squad.planner));
	#/
	squad.planning = 1;
	[[ level.strategic_command_throttle ]]->waitinqueue(squad);
	squad.lastupdatetime = gettime();
	if(function_9de03b3f(squad))
	{
		_plan(squad);
	}
	else
	{
		plannersquadutility::shutdown(squad);
	}
	squad.actionstatus = undefined;
	squad.currentplanindex = undefined;
	squad.planning = 0;
}

/*
	Name: _updateplanner
	Namespace: plannersquad
	Checksum: 0xD376CA49
	Offset: 0x17C8
	Size: 0xE6
	Parameters: 1
	Flags: Linked, Private
*/
function private _updateplanner(squad)
{
	/#
		assert(isdefined(squad));
	#/
	while(isdefined(squad) && !squad.shutdown)
	{
		[[ level.strategic_command_throttle ]]->waitinqueue(squad);
		time = gettime();
		if(squad.plan.size == 0 || (time - squad.lastupdatetime) > squad.updaterate && !squad.planning)
		{
			squad _strategize(squad);
		}
		_executeplan(squad);
		waitframe(1);
	}
}

#namespace plannersquadutility;

/*
	Name: createsquad
	Namespace: plannersquadutility
	Checksum: 0x53A286D3
	Offset: 0x18B8
	Size: 0x1F0
	Parameters: 4
	Flags: Linked
*/
function createsquad(blackboard, planner, updaterate = (float(function_60d95f53()) / 1000) * 100, maxplannerframetime = 2)
{
	/#
		assert(isstruct(blackboard));
	#/
	/#
		assert(isstruct(planner));
	#/
	squad = spawnstruct();
	squad.actionstatus = undefined;
	squad.blackboard = blackboard;
	squad.createtime = gettime();
	squad.currentplanindex = undefined;
	squad.maxplannerframetime = maxplannerframetime;
	squad.plan = [];
	squad.planfinishtime = gettime();
	squad.planstarttime = gettime();
	squad.planner = planner;
	squad.lastupdatetime = 0;
	squad.planning = 0;
	squad.shutdown = 0;
	squad.updaterate = updaterate * 1000;
	plannerblackboard::clearundostack(squad.blackboard);
	/#
		squad thread plannersquad::_debugsquad(squad);
	#/
	squad thread plannersquad::_updateplanner(squad);
	return squad;
}

/*
	Name: getblackboardattribute
	Namespace: plannersquadutility
	Checksum: 0xF74E00C3
	Offset: 0x1AB0
	Size: 0x32
	Parameters: 2
	Flags: Linked
*/
function getblackboardattribute(squad, attribute)
{
	return plannerblackboard::getattribute(squad.blackboard, attribute);
}

/*
	Name: setblackboardattribute
	Namespace: plannersquadutility
	Checksum: 0x50459F5D
	Offset: 0x1AF0
	Size: 0x3A
	Parameters: 3
	Flags: None
*/
function setblackboardattribute(squad, attribute, value)
{
	return plannerblackboard::setattribute(squad.blackboard, attribute, value);
}

/*
	Name: shutdown
	Namespace: plannersquadutility
	Checksum: 0xFE853130
	Offset: 0x1B38
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function shutdown(squad)
{
	squad.shutdown = 1;
	planner::cancel(squad.planner);
}

