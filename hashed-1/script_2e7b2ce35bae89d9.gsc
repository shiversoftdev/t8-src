// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using script_7510e6cc8220a052;
#using scripts\core_common\bots\bot_action.gsc;

#namespace bot;

/*
	Name: callback_botentereduseredge
	Namespace: bot
	Checksum: 0x6A27EF3C
	Offset: 0xF0
	Size: 0x254
	Parameters: 6
	Flags: Linked
*/
function callback_botentereduseredge(startnode, endnode, mantlenode, startpos, endpos, var_2a1f4ab7)
{
	if(self isplayinganimscripted())
	{
		/#
			self botprinterror("");
		#/
		waitframe(1);
		self botreleasemanualcontrol();
		return;
	}
	var_75e8e8e8 = startnode.type !== "Volume";
	if(var_75e8e8e8)
	{
		if(startnode.type === "Begin" || startnode.type === "End" && isdefined(startnode.spawnflags) && startnode.spawnflags & 134217728)
		{
			var_75e8e8e8 = 0;
		}
	}
	if(var_75e8e8e8)
	{
		/#
			self botprinterror("");
		#/
		self thread function_a8270705(endpos);
		return;
	}
	params = spawnstruct();
	params.startnode = startnode;
	params.endnode = endnode;
	params.mantlenode = mantlenode;
	params.startpos = startpos;
	params.endpos = endpos;
	params.var_2a1f4ab7 = var_2a1f4ab7;
	if(isdefined(startnode) && isdefined(startnode.script_parameters) && startnode.script_parameters == "botIgnoreHeightCheck")
	{
		params.var_bccf04e7 = 1;
	}
	self function_cf312d24(params);
	self thread function_268dc89a(params);
}

/*
	Name: cancel
	Namespace: bot
	Checksum: 0x249F206B
	Offset: 0x350
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function cancel()
{
	self notify(#"hash_a729d7d4c6847f6");
}

/*
	Name: function_a8270705
	Namespace: bot
	Checksum: 0x9C1D251D
	Offset: 0x370
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_a8270705(endpos)
{
	self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
	self endon_callback(&release_control, #"entering_last_stand", #"new_shot");
	level endon(#"game_ended");
	self teleport(endpos, "Legacy fallback");
	self botreleasemanualcontrol();
}

/*
	Name: function_c3452ef9
	Namespace: bot
	Checksum: 0xCAEE8B3A
	Offset: 0x438
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_c3452ef9(params)
{
	self.traversestartnode = params.startnode;
	self.traversalstartpos = params.startpos;
	self.traverseendnode = params.endnode;
	self.traversalendpos = params.endpos;
	self.traversemantlenode = params.mantlenode;
	namespace_26186a83::play_animation("parametric_traverse@traversal");
	self.traversestartnode = undefined;
	self.traversalstartpos = undefined;
	self.traverseendnode = undefined;
	self.traversalendpos = undefined;
	self.traversemantlenode = undefined;
	self release_control();
}

/*
	Name: function_268dc89a
	Namespace: bot
	Checksum: 0x4A8A7855
	Offset: 0x508
	Size: 0x41C
	Parameters: 1
	Flags: Linked
*/
function function_268dc89a(params)
{
	self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_37fc5d1ffce4acaf");
	self endon_callback(&release_control, #"entering_last_stand", #"new_shot");
	level endon(#"game_ended");
	self.bot.traversal = params;
	self bot_action::reset();
	self thread traversal_timeout(params);
	if(params.var_b8915580)
	{
		self function_fc004e60(params);
	}
	else if(params.dist2d > 30 && params.var_5aacf42 >= 0)
	{
		/#
			self botprinterror("");
		#/
		self thread function_c3452ef9(params);
		return;
	}
	if(abs(params.targetheight) <= 18)
	{
		self function_18cd6cbc(params);
	}
	else if(params.targetheight > 0)
	{
		if(params.var_5aacf42 < 0)
		{
			/#
				self botprinterror("");
			#/
			self thread function_c3452ef9(params);
			return;
		}
		self mantle_traversal(params);
	}
	else if(params.targetheight < -72 && (!(isdefined(params.var_bccf04e7) && params.var_bccf04e7)))
	{
		/#
			self botprinterror("");
		#/
		self thread function_c3452ef9(params);
		return;
	}
	if(params.targetheight < 0)
	{
		self function_ec5f6276(params.endpos);
	}
	else
	{
		/#
			self botprinterror("" + params.startnode.origin);
		#/
		self thread function_c3452ef9(params);
		return;
	}
	if(!ispointonnavmesh(self.origin, self))
	{
		/#
			self botprinterror("" + params.startnode.origin);
		#/
		self thread function_c3452ef9(params);
		return;
	}
	if(distancesquared(self.origin, params.endpos) > distancesquared(self.origin, params.startpos))
	{
		/#
			self botprinterror("");
		#/
		self thread function_c3452ef9(params);
		return;
	}
	self release_control();
}

/*
	Name: release_control
	Namespace: bot
	Checksum: 0xC6A08843
	Offset: 0x930
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function release_control(notifyhash)
{
	self notify(#"hash_612231aa5def85e2");
	if(!isbot(self))
	{
		return;
	}
	self.bot.traversal = undefined;
	self botreleasemanualcontrol();
}

/*
	Name: traversal_timeout
	Namespace: bot
	Checksum: 0xF9D9BD6B
	Offset: 0x998
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function traversal_timeout(params)
{
	self endon(#"death", #"hash_a729d7d4c6847f6", #"hash_612231aa5def85e2");
	level endon(#"game_ended");
	wait(3.5);
	/#
		self botprinterror("" + params.startnode.origin);
	#/
	self notify(#"hash_37fc5d1ffce4acaf");
	self thread function_c3452ef9(params);
	self.bot.traversal = undefined;
	self botreleasemanualcontrol();
}

/*
	Name: function_cf312d24
	Namespace: bot
	Checksum: 0x5EA6FB39
	Offset: 0xA80
	Size: 0x374
	Parameters: 1
	Flags: Linked
*/
function function_cf312d24(params)
{
	params.starttrace = checknavmeshdirection(params.startpos, params.endpos - params.startpos, 512, 0);
	params.endtrace = checknavmeshdirection(params.endpos, params.startpos - params.endpos, 512, 0);
	params.targetpos = (isdefined(params.var_2a1f4ab7) ? params.var_2a1f4ab7 : params.endtrace);
	params.targetheight = params.targetpos[2] - params.starttrace[2];
	normal = params.startpos - params.endpos;
	params.normal = vectornormalize((normal[0], normal[1], 0));
	if(distance2dsquared(params.starttrace, params.targetpos) == 0)
	{
		params.var_5aacf42 = 0;
	}
	else
	{
		params.var_5aacf42 = vectordot(params.starttrace - params.targetpos, params.normal);
	}
	params.dist2d = distance2d(params.starttrace, params.targetpos);
	params.var_b8915580 = function_51cbae24(params);
	/#
		if(self should_record(""))
		{
			var_47d2875c = (params.targetpos[0], params.targetpos[1], params.starttrace[2]);
			var_b03d274a = (params.dist2d > 30 ? (1, 0, 0) : (0, 1, 0));
			recordline(params.starttrace, var_47d2875c, var_b03d274a, "", self);
			recordsphere(var_47d2875c, 3, var_b03d274a, "", self);
			recordsphere(params.starttrace, 3, (0, 1, 0), "", self);
			recordsphere(params.targetpos, 3, (1, 0, 1), "", self);
		}
	#/
}

/*
	Name: function_51cbae24
	Namespace: bot
	Checksum: 0x18BCC96F
	Offset: 0xE00
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_51cbae24(params)
{
	if(params.targetheight < 18)
	{
		return 0;
	}
	dir = vectornormalize(params.endpos - params.startpos);
	result = bullettrace(params.startpos, params.startpos + dir * 512, 0, self);
	if(result[#"surfacetype"] == "ladder")
	{
		return 1;
	}
	return 0;
}

/*
	Name: mantle_traversal
	Namespace: bot
	Checksum: 0x638308E2
	Offset: 0xEC8
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function mantle_traversal(params)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	function_b34ef250(params.starttrace, params.normal, 20);
	jump(params.targetpos);
	mantle(params.targetpos);
}

/*
	Name: function_6e54af92
	Namespace: bot
	Checksum: 0xAAF243E0
	Offset: 0xF98
	Size: 0x1BA
	Parameters: 3
	Flags: None
*/
function function_6e54af92(endpos, ledgetop, normal)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	trace = bullettrace(ledgetop, ledgetop - vectorscale((0, 0, 1), 1024), 0, self);
	var_82c7381e = trace[#"position"];
	self botsetmovepoint(endpos);
	var_ccaaa590 = vectordot(self.origin - var_82c7381e, normal);
	while(var_ccaaa590 > 20)
	{
		waitframe(1);
		var_ccaaa590 = vectordot(self.origin - var_82c7381e, normal);
	}
	self botsetmovemagnitude(0);
	self bottapbutton(10);
	waitframe(1);
	while(!self isonground() || self ismantling())
	{
		waitframe(1);
	}
}

/*
	Name: jump_traversal
	Namespace: bot
	Checksum: 0xAEAB866E
	Offset: 0x1160
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function jump_traversal(params)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 0), "", undefined, 0.5);
		}
	#/
	self function_b34ef250(params.starttrace, params.normal);
	self jump(params.targetpos);
	self fall();
}

/*
	Name: function_ec5f6276
	Namespace: bot
	Checksum: 0x411F12B2
	Offset: 0x1230
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function function_ec5f6276(endpos)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	self botsetmovemagnitude(1);
	self botsetmovepoint(endpos);
	self fall();
}

/*
	Name: function_18cd6cbc
	Namespace: bot
	Checksum: 0xA46815C6
	Offset: 0x12F0
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function function_18cd6cbc(params)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	self botsetmovemagnitude(1);
	self botsetmovepoint(params.endpos);
	dist = distance2dsquared(self.origin, params.endpos);
	prev_dist = dist;
	while(dist > 256 && prev_dist >= dist)
	{
		waitframe(1);
		prev_dist = dist;
		dist = distance2dsquared(self.origin, params.endpos);
	}
}

/*
	Name: function_fc004e60
	Namespace: bot
	Checksum: 0xEB8E9E2F
	Offset: 0x1430
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_fc004e60(params)
{
	self botsetmovepoint(params.endpos);
	while(!self isonground())
	{
		waitframe(1);
	}
}

/*
	Name: teleport
	Namespace: bot
	Checksum: 0x24D19001
	Offset: 0x1488
	Size: 0xAA
	Parameters: 2
	Flags: Linked
*/
function teleport(endpos, reason)
{
	/#
		if(self should_record(""))
		{
			record3dtext("" + reason, self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	self setorigin(endpos);
	self dontinterpolate();
	waitframe(1);
}

/*
	Name: mantle
	Namespace: bot
	Checksum: 0x94B7AF26
	Offset: 0x1540
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function mantle(var_2a1f4ab7)
{
	self botsetmovemagnitude(1);
	/#
		if(self should_record(""))
		{
			record3dtext("", var_2a1f4ab7, (1, 1, 1), "", undefined, 0.5);
			recordsphere(var_2a1f4ab7, 3, (1, 1, 0), "", self);
		}
	#/
	while(!self isonground() || self ismantling())
	{
		waitframe(1);
	}
}

/*
	Name: function_b34ef250
	Namespace: bot
	Checksum: 0x8C91A923
	Offset: 0x1630
	Size: 0x172
	Parameters: 3
	Flags: Linked
*/
function function_b34ef250(var_f125b440, normal, dist = 0)
{
	/#
		if(self should_record(""))
		{
			recordtext = "";
			if(dist > 0)
			{
				recordtext = recordtext + "" + dist;
			}
			record3dtext(recordtext, var_f125b440, (1, 1, 1), "", undefined, 0.5);
			recordsphere(var_f125b440, 3, (0, 1, 0), "", self);
		}
	#/
	self botsetmovepoint(var_f125b440);
	self botsetmovemagnitude(1);
	var_459ca70 = vectordot(self.origin - var_f125b440, normal);
	while(var_459ca70 > dist)
	{
		waitframe(1);
		var_459ca70 = vectordot(self.origin - var_f125b440, normal);
	}
}

/*
	Name: jump
	Namespace: bot
	Checksum: 0xD3B6286D
	Offset: 0x17B0
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function jump(var_75f5c2cb)
{
	/#
		if(self should_record(""))
		{
			record3dtext("", var_75f5c2cb, (1, 1, 1), "", undefined, 0.5);
			recordsphere(var_75f5c2cb, 3, (1, 1, 1), "", self);
		}
	#/
	self bottapbutton(10);
	waitframe(1);
}

/*
	Name: fall
	Namespace: bot
	Checksum: 0xEE5814E2
	Offset: 0x1860
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function fall()
{
	/#
		if(self should_record(""))
		{
			record3dtext("", self.origin, (1, 1, 1), "", undefined, 0.5);
		}
	#/
	while(self isonground())
	{
		waitframe(1);
	}
	while(!self isonground())
	{
		waitframe(1);
	}
}

