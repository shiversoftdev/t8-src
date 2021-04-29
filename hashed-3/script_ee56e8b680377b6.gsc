// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_9c817acd;

/*
	Name: function_89f2df9
	Namespace: namespace_9c817acd
	Checksum: 0x75F1303C
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_54c6c44493a304a7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9c817acd
	Checksum: 0x2428F69D
	Offset: 0x118
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_17a3a139 = [];
	level.var_4381b72a = [];
	register_handler(#"default", &function_51cc7d9a);
	register_handler(#"hash_2405aec12988c1f7", &function_7857357b);
	register_handler(#"hash_ca2f8909b847c6f", &function_f1b497ec);
	register_handler(#"hash_7a468797a3a33424", &function_41d967fe);
	register_handler(#"hash_2ebb09bf5581043d", &function_f71302f4);
	register_handler(#"hash_3173f482acc24ec8", &function_821cce69);
	register_handler(#"hash_63805884bf517826", &function_5485fc7b);
	register_handler(#"hash_63805884bf517826", &function_5485fc7b);
	register_handler(#"hash_59db68c04af7aab5", &function_e4f752b9);
	register_handler(#"hash_51f609ea675fecde", &function_d22ff818);
	register_handler(#"hash_21f619ce507cec96", &function_1989cfaf);
	function_bef13b7e(#"stand", &stand);
	function_bef13b7e(#"sprint", &sprint);
	function_bef13b7e(#"crouch", &crouch);
	function_bef13b7e(#"prone", &prone);
	function_bef13b7e(#"slide", &slide);
}

/*
	Name: start
	Namespace: namespace_9c817acd
	Checksum: 0xB1B010E7
	Offset: 0x440
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function start()
{
	self thread handle_path_success();
	self thread handle_goal_reached();
	self.bot.var_9bd97adb = undefined;
}

/*
	Name: stop
	Namespace: namespace_9c817acd
	Checksum: 0xB39C8A71
	Offset: 0x490
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function stop()
{
	self notify(#"hash_399ca08ed5c94410");
}

/*
	Name: reset
	Namespace: namespace_9c817acd
	Checksum: 0x77301EDC
	Offset: 0x4B0
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function reset()
{
	self.bot.var_857c5ea8 = 0;
}

/*
	Name: update
	Namespace: namespace_9c817acd
	Checksum: 0x93236B1A
	Offset: 0x4D0
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function update(tacbundle)
{
	if(self.bot.var_857c5ea8 > gettime())
	{
		return;
	}
	/#
		self bot::record_text("", (1, 1, 0), "");
	#/
	self function_7beea81f(tacbundle);
	self.bot.var_857c5ea8 = bot::function_7aeb27f1(0.4, 1);
}

/*
	Name: handle_path_success
	Namespace: namespace_9c817acd
	Checksum: 0xAF4F1C92
	Offset: 0x570
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function handle_path_success()
{
	self endon(#"death", #"hash_399ca08ed5c94410");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		self waittill(#"bot_path_success");
		if(!isbot(self))
		{
			return;
		}
		self.bot.var_857c5ea8 = 0;
	}
}

/*
	Name: handle_goal_reached
	Namespace: namespace_9c817acd
	Checksum: 0x2240F145
	Offset: 0x600
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function handle_goal_reached()
{
	self endon(#"death", #"hash_399ca08ed5c94410");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		self waittill(#"bot_goal_reached");
		if(!isbot(self))
		{
			return;
		}
		self.bot.var_857c5ea8 = 0;
	}
}

/*
	Name: register_handler
	Namespace: namespace_9c817acd
	Checksum: 0x32F7C8C8
	Offset: 0x690
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function register_handler(name, func)
{
	level.var_17a3a139[name] = func;
}

/*
	Name: function_bef13b7e
	Namespace: namespace_9c817acd
	Checksum: 0xC9504E68
	Offset: 0x6C8
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_bef13b7e(name, func)
{
	level.var_4381b72a[name] = func;
}

/*
	Name: function_7beea81f
	Namespace: namespace_9c817acd
	Checksum: 0xFE238835
	Offset: 0x700
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_7beea81f(tacbundle)
{
	var_f307a84d = tacbundle.var_ddbbc55a;
	if(self haspath())
	{
		var_f307a84d = tacbundle.var_37d8817b;
	}
	if(!isdefined(var_f307a84d))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return;
	}
	pixbeginevent(#"bot_stance_update");
	aiprofile_beginentry("bot_stance_update");
	handled = 0;
	node = self bot::get_position_node();
	foreach(params in var_f307a84d)
	{
		if(self function_ab5be907(tacbundle, params, node))
		{
			self.bot.var_9bd97adb = params.name;
			handled = 1;
			break;
		}
	}
	pixendevent();
	aiprofile_endentry();
}

/*
	Name: function_ab5be907
	Namespace: namespace_9c817acd
	Checksum: 0x45BAFE56
	Offset: 0x8B0
	Size: 0x168
	Parameters: 3
	Flags: Linked
*/
function function_ab5be907(tacbundle, params, node)
{
	if(!isdefined(params))
	{
		return 0;
	}
	func = level.var_17a3a139[params.name];
	if(!isdefined(func))
	{
		/#
			self botprinterror("" + function_9e72a96(params.name));
		#/
		return 0;
	}
	/#
		self bot::record_text(function_9e72a96(params.name), (1, 1, 1), "");
	#/
	pixbeginevent("bot_stance_handler: " + params.name);
	aiprofile_beginentry("bot_stance_handler: " + params.name);
	handled = self [[func]](tacbundle, params, node);
	pixendevent();
	aiprofile_endentry();
	return handled;
}

/*
	Name: function_8f722922
	Namespace: namespace_9c817acd
	Checksum: 0x13B1B17D
	Offset: 0xA20
	Size: 0xBE
	Parameters: 1
	Flags: Linked
*/
function function_8f722922(name)
{
	if(!isdefined(name))
	{
		return 0;
	}
	func = level.var_4381b72a[name];
	if(!isdefined(func))
	{
		/#
			self botprinterror("" + function_9e72a96(name));
		#/
		return 0;
	}
	/#
		self bot::record_text("" + function_9e72a96(name), (1, 1, 0), "");
	#/
	self [[func]]();
	return 1;
}

/*
	Name: function_51cc7d9a
	Namespace: namespace_9c817acd
	Checksum: 0x1E1F5F2C
	Offset: 0xAE8
	Size: 0x3A
	Parameters: 3
	Flags: Linked
*/
function function_51cc7d9a(tacbundle, params, node)
{
	return self function_8f722922(params.stance);
}

/*
	Name: function_7857357b
	Namespace: namespace_9c817acd
	Checksum: 0x1A77624D
	Offset: 0xB30
	Size: 0x11A
	Parameters: 3
	Flags: Linked
*/
function function_7857357b(tacbundle, params, node)
{
	if(!isdefined(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!function_4d468769(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self bot::in_combat() && !self iscovervalid(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_f1b497ec
	Namespace: namespace_9c817acd
	Checksum: 0xFFC1FAC5
	Offset: 0xC58
	Size: 0x11A
	Parameters: 3
	Flags: Linked
*/
function function_f1b497ec(tacbundle, params, node)
{
	if(!isdefined(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!function_7131ccf7(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self bot::in_combat() && !self iscovervalid(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_41d967fe
	Namespace: namespace_9c817acd
	Checksum: 0xE0351493
	Offset: 0xD80
	Size: 0x11A
	Parameters: 3
	Flags: Linked
*/
function function_41d967fe(tacbundle, params, node)
{
	if(!isdefined(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!function_9ccb67a3(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self bot::in_combat() && !self iscovervalid(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_f71302f4
	Namespace: namespace_9c817acd
	Checksum: 0xA5A903AC
	Offset: 0xEA8
	Size: 0x182
	Parameters: 3
	Flags: Linked
*/
function function_f71302f4(tacbundle, params, node)
{
	if(!isdefined(self.enemy))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!isdefined(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!function_7131ccf7(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self bot::in_combat() && !self iscovervalid(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!self bot::function_e0aceb0c(tacbundle, "bot_recordStance"))
	{
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_821cce69
	Namespace: namespace_9c817acd
	Checksum: 0x398A6BA8
	Offset: 0x1038
	Size: 0x162
	Parameters: 3
	Flags: Linked
*/
function function_821cce69(tacbundle, params, node)
{
	if(!isdefined(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!node.spawnflags & 8)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(node.spawnflags & 4)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self bot::in_combat() && !self iscovervalid(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_5485fc7b
	Namespace: namespace_9c817acd
	Checksum: 0x9661FAB9
	Offset: 0x11A8
	Size: 0xDA
	Parameters: 3
	Flags: Linked
*/
function function_5485fc7b(tacbundle, params, node)
{
	if(!self ai::has_behavior_attribute("sprint"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!self ai::get_behavior_attribute("sprint"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_e4f752b9
	Namespace: namespace_9c817acd
	Checksum: 0xD7FE67FB
	Offset: 0x1290
	Size: 0x212
	Parameters: 3
	Flags: Linked
*/
function function_e4f752b9(tacbundle, params, node)
{
	if(self issprinting())
	{
		/#
			self bot::record_text("", (1, 1, 0), "");
		#/
		return 1;
	}
	if(isdefined(tacbundle.sprintdist))
	{
		var_8be65bb9 = self function_f04bd922();
		movepoint = self.goalpos;
		if(isdefined(var_8be65bb9) && isdefined(var_8be65bb9.var_2cfdc66d))
		{
			movepoint = var_8be65bb9.var_2cfdc66d;
		}
		else if(isdefined(self.overridegoalpos))
		{
			movepoint = self.overridegoalpos;
		}
		distsq = distance2dsquared(self.origin, movepoint);
		var_ce946146 = tacbundle.sprintdist * tacbundle.sprintdist;
		if(distsq < var_ce946146)
		{
			/#
				self bot::record_text("", (1, 0, 0), "");
			#/
			return 0;
		}
	}
	dir = self getnormalizedmovement();
	if(vectordot(dir, (1, 0, 0)) < 0.82)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_d22ff818
	Namespace: namespace_9c817acd
	Checksum: 0x65E04662
	Offset: 0x14B0
	Size: 0x31A
	Parameters: 3
	Flags: Linked
*/
function function_d22ff818(tacbundle, params, node)
{
	if(!self ai::get_behavior_attribute("slide"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self issliding())
	{
		/#
			self bot::record_text("", (1, 1, 0), "");
		#/
		return 1;
	}
	if(!self issprinting())
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(isdefined(tacbundle.var_1f5429aa) && isdefined(tacbundle.var_48aa05a1))
	{
		var_8be65bb9 = self function_f04bd922();
		movepoint = self.goalpos;
		if(isdefined(var_8be65bb9) && isdefined(var_8be65bb9.var_2cfdc66d))
		{
			movepoint = var_8be65bb9.var_2cfdc66d;
		}
		else if(isdefined(self.overridegoalpos))
		{
			movepoint = self.overridegoalpos;
		}
		distsq = distance2dsquared(self.origin, movepoint);
		var_d6ff7b1b = tacbundle.var_1f5429aa * tacbundle.var_1f5429aa;
		var_e70d67bc = tacbundle.var_48aa05a1 * tacbundle.var_48aa05a1;
		if(distsq < var_d6ff7b1b)
		{
			/#
				self bot::record_text("", (1, 0, 0), "");
			#/
			return 0;
		}
		if(distsq > var_e70d67bc)
		{
			/#
				self bot::record_text("", (1, 0, 0), "");
			#/
			return 0;
		}
	}
	dir = self getnormalizedmovement();
	if(vectordot(dir, (1, 0, 0)) < 0.82)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: function_1989cfaf
	Namespace: namespace_9c817acd
	Checksum: 0xC5B30D43
	Offset: 0x17D8
	Size: 0x39A
	Parameters: 3
	Flags: Linked
*/
function function_1989cfaf(tacbundle, params, node)
{
	if(!self ai::get_behavior_attribute("slide"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(self issliding())
	{
		/#
			self bot::record_text("", (1, 1, 0), "");
		#/
		return 1;
	}
	if(!self issprinting())
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(!isdefined(node) || !iscovernode(node))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	if(isdefined(self function_f04bd922()))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	distsq = distance2dsquared(self.origin, node.origin);
	mindistsq = (isdefined(tacbundle.var_1f5429aa) ? tacbundle.var_1f5429aa : 0);
	mindistsq = mindistsq * mindistsq;
	if(distsq < mindistsq)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	maxdistsq = (isdefined(tacbundle.var_48aa05a1) ? tacbundle.var_48aa05a1 : 0);
	maxdistsq = maxdistsq * maxdistsq;
	if(distsq > maxdistsq)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	var_8f6b238f = (isdefined(tacbundle.var_f58a14bd) ? tacbundle.var_f58a14bd : 0);
	dir = vectornormalize(node.origin - self.origin);
	if(vectordot(dir, anglestoforward(node.angles)) <= var_8f6b238f)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	return self function_8f722922(params.stance);
}

/*
	Name: sprint
	Namespace: namespace_9c817acd
	Checksum: 0x7F313680
	Offset: 0x1B80
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function sprint()
{
	self botpressbutton(1);
	self botreleasebutton(9);
	self botreleasebutton(8);
	self botreleasebutton(39);
}

/*
	Name: stand
	Namespace: namespace_9c817acd
	Checksum: 0x8D004F98
	Offset: 0x1BF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function stand()
{
	self botreleasebutton(1);
	self botreleasebutton(9);
	self botreleasebutton(8);
	self botreleasebutton(39);
}

/*
	Name: crouch
	Namespace: namespace_9c817acd
	Checksum: 0x1452A7FC
	Offset: 0x1C60
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function crouch()
{
	self botreleasebutton(1);
	self botpressbutton(9);
	self botreleasebutton(8);
	self botreleasebutton(39);
}

/*
	Name: prone
	Namespace: namespace_9c817acd
	Checksum: 0xB89449C2
	Offset: 0x1CD0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function prone()
{
	self botreleasebutton(1);
	self botreleasebutton(9);
	self botpressbutton(8);
	self botreleasebutton(39);
}

/*
	Name: slide
	Namespace: namespace_9c817acd
	Checksum: 0x604FFB37
	Offset: 0x1D40
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function slide()
{
	self botreleasebutton(1);
	self botreleasebutton(9);
	self botreleasebutton(8);
	self bottapbutton(39);
}

