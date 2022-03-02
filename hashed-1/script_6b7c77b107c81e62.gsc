// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_b6ee49c3;

/*
	Name: function_89f2df9
	Namespace: namespace_b6ee49c3
	Checksum: 0xB8D4CB0B
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_442c4eb4e72ecbe2", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b6ee49c3
	Checksum: 0x6D861B2F
	Offset: 0x140
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"hash_56ab3c042b783de6")) ? getgametypesetting(#"hash_56ab3c042b783de6") : 0))
	{
		return;
	}
	clientfield::function_a8bbc967("hudItems.dynentUseHoldProgress", 13000, 5, "float", 0);
	/#
		level thread function_5f747d5a();
	#/
	level thread update_loop();
	callback::on_connect(&on_player_connect);
	callback::on_disconnect(&on_player_disconnect);
	callback::on_player_killed(&on_player_killed);
}

/*
	Name: on_player_connect
	Namespace: namespace_b6ee49c3
	Checksum: 0x16177ECA
	Offset: 0x260
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_connect()
{
	usetrigger = function_938bdf98();
	self clientclaimtrigger(usetrigger);
	self.var_8a022726 = usetrigger;
	/#
		if(self ishost())
		{
			self thread function_6b66543a();
		}
	#/
}

/*
	Name: on_player_disconnect
	Namespace: namespace_b6ee49c3
	Checksum: 0xBA04C288
	Offset: 0x2E0
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_disconnect()
{
	if(isdefined(self.var_8a022726))
	{
		self.var_8a022726 delete();
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_b6ee49c3
	Checksum: 0xEA13EF91
	Offset: 0x318
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_killed()
{
	self clientfield::set_player_uimodel("hudItems.dynentUseHoldProgress", 0);
}

/*
	Name: function_938bdf98
	Namespace: namespace_b6ee49c3
	Checksum: 0x954CBF42
	Offset: 0x348
	Size: 0x190
	Parameters: 0
	Flags: Linked, Private
*/
function private function_938bdf98()
{
	usetrigger = spawn("trigger_radius_use", vectorscale((0, 0, -1), 10000), 0, 128, 64, 1);
	usetrigger triggerignoreteam();
	usetrigger setinvisibletoall();
	usetrigger setvisibletoplayer(self);
	usetrigger setteamfortrigger(#"none");
	usetrigger setcursorhint("HINT_NOICON");
	usetrigger triggerenable(0);
	usetrigger usetriggerignoreuseholdtime();
	usetrigger function_4bf6de9a(0);
	usetrigger function_c96c67a5(0);
	usetrigger function_89fca53b(1);
	usetrigger function_49462027(1, (1 | 16) | 1024);
	usetrigger callback::function_a04381e0(&function_46502841);
	return usetrigger;
}

/*
	Name: update_loop
	Namespace: namespace_b6ee49c3
	Checksum: 0xA88BF5BC
	Offset: 0x4E0
	Size: 0x18E
	Parameters: 0
	Flags: Linked, Private
*/
function private update_loop()
{
	level endon(#"game_ended");
	var_1a1c0d86 = 0;
	while(true)
	{
		foreach(i, player in getplayers())
		{
			if((i % 5) == var_1a1c0d86)
			{
				if(!isdefined(player.var_8a022726))
				{
					continue;
				}
				if(player.sessionstate != "playing" || !isalive(player) || player isinvehicle() || (isdefined(level.var_3dfbaf65) && player [[level.var_3dfbaf65]]()))
				{
					player.var_8a022726 triggerenable(0);
					continue;
				}
				player function_2f394f36();
			}
		}
		var_1a1c0d86 = (var_1a1c0d86 + 1) % 5;
		waitframe(1);
	}
}

/*
	Name: function_2f394f36
	Namespace: namespace_b6ee49c3
	Checksum: 0x664CE89E
	Offset: 0x678
	Size: 0x6D4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2f394f36()
{
	height = self getmaxs()[2];
	bounds = (50, 50, height / 2);
	var_5ed7231a = self getcentroid();
	/#
		debug = self ishost() && getdvarint(#"hash_23e7101285284738", 0);
		if(debug)
		{
			box(var_5ed7231a, (0, 0, 0) - bounds, bounds, 0, (0, 0, 1), 1, 0, 5);
		}
	#/
	viewheight = self getplayerviewheight();
	vieworigin = self.origin + (0, 0, viewheight);
	viewangles = self getplayerangles();
	var_7303a80a = anglestoforward(viewangles);
	var_e86a4d9 = function_db4bc717(var_5ed7231a, bounds);
	var_c61b7280 = undefined;
	var_97684497 = undefined;
	bestdot = -1;
	foreach(dynent in var_e86a4d9)
	{
		centroid = function_c5689a6a(dynent);
		var_966ddbb9 = centroid - vieworigin;
		var_966ddbb9 = vectornormalize((var_966ddbb9[0], var_966ddbb9[1], 0));
		var_755fcbbd = vectordot(var_7303a80a, var_966ddbb9);
		/#
			if(debug)
			{
				sphere(dynent.origin, 9, (0, 0, 1), 1, 0, 8, 5);
			}
		#/
		if(var_755fcbbd < 0)
		{
			continue;
		}
		if(isdefined(dynent.var_a548ec11) && gettime() <= dynent.var_a548ec11)
		{
			/#
				if(debug)
				{
					print3d(dynent.origin, "", (1, 1, 1), 1, 0.5, 5);
				}
			#/
			continue;
		}
		stateindex = function_ffdbe8c2(dynent);
		bundle = function_489009c1(dynent);
		if(isdefined(bundle) && isdefined(bundle.var_c14aa186) && isdefined(bundle.var_c14aa186[stateindex]) && (isdefined(bundle.var_c14aa186[stateindex].var_efabe801) && bundle.var_c14aa186[stateindex].var_efabe801 || (level.inprematchperiod && (!(isdefined(bundle.var_c14aa186[stateindex].var_4a78f198) && bundle.var_c14aa186[stateindex].var_4a78f198)))))
		{
			/#
				if(debug)
				{
					print3d(dynent.origin, "", (1, 1, 1), 1, 0.5, 5);
				}
			#/
			continue;
		}
		if(isdefined(dynent.canuse) && !dynent [[dynent.canuse]](self))
		{
			continue;
		}
		if(var_755fcbbd > bestdot)
		{
			bestdot = var_755fcbbd;
			var_c61b7280 = dynent;
		}
	}
	if(!isdefined(var_c61b7280))
	{
		self.var_8a022726 triggerenable(0);
		return;
	}
	trigger = self.var_8a022726;
	state = function_ffdbe8c2(var_c61b7280);
	if(trigger.var_a9309589 === var_c61b7280 && trigger.var_9680a0e4 === state)
	{
		trigger triggerenable(1);
		return;
	}
	trigger.var_a9309589 = var_c61b7280;
	trigger.var_9680a0e4 = state;
	bundle = function_489009c1(var_c61b7280);
	loc_00000C66:
	loc_00000C86:
	v_offset = ((isdefined(bundle.var_aa0fba03) ? bundle.var_aa0fba03 : 0), (isdefined(bundle.var_f8525687) ? bundle.var_f8525687 : 0), (isdefined(bundle.var_54b28eee) ? bundle.var_54b28eee : 0));
	v_offset = rotatepoint(v_offset, var_c61b7280.angles);
	trigger.origin = var_c61b7280.origin + v_offset;
	trigger.usetime = (isdefined(bundle.use_time) ? bundle.use_time : 0);
	trigger function_836af3b3(bundle, state);
	trigger triggerenable(1);
}

/*
	Name: function_836af3b3
	Namespace: namespace_b6ee49c3
	Checksum: 0x40171696
	Offset: 0xD58
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_836af3b3(bundle, state)
{
	hintstring = #"";
	if(isdefined(bundle) && isdefined(bundle.var_c14aa186) && isdefined(bundle.var_c14aa186[state]) && isdefined(bundle.var_c14aa186[state].hintstring))
	{
		hintstring = bundle.var_c14aa186[state].hintstring;
	}
	self sethintstring(hintstring);
}

/*
	Name: function_46502841
	Namespace: namespace_b6ee49c3
	Checksum: 0x3358FD97
	Offset: 0xE18
	Size: 0x132
	Parameters: 1
	Flags: Linked, Private
*/
function private function_46502841(trigger_struct)
{
	if(isdefined(level.gameended) && level.gameended)
	{
		return;
	}
	activator = trigger_struct.activator;
	dynent = self.var_a9309589;
	success = activator function_2b9e2224(self);
	while(success && isdefined(dynent) && self.var_a9309589 === dynent && (isdefined(dynent.var_e7823894) && dynent.var_e7823894))
	{
		if(isdefined(dynent.canuse) && !dynent [[dynent.canuse]](activator))
		{
			break;
		}
		self triggerenable(1);
		success = activator function_2b9e2224(self);
	}
}

/*
	Name: function_2b9e2224
	Namespace: namespace_b6ee49c3
	Checksum: 0x158B1256
	Offset: 0xF58
	Size: 0x358
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2b9e2224(trigger)
{
	self endon(#"disconnect");
	dynent = trigger.var_a9309589;
	if(isdefined(dynent))
	{
		begintime = gettime();
		usetime = int(trigger.usetime * 1000);
		endtime = begintime + usetime;
		if(isdefined(dynent.onbeginuse))
		{
			dynent thread [[dynent.onbeginuse]](self);
		}
		if(isdefined(dynent.var_263c4ded))
		{
			var_36c3259 = trigger.usetime;
			usetime = int(dynent thread [[dynent.var_263c4ded]](self) * 1000);
			endtime = begintime + usetime;
		}
		success = 0;
		while(isalive(self) && !self inlaststand() && self usebuttonpressed() && trigger istriggerenabled() && self istouching(trigger) && isdefined(dynent) && trigger.var_a9309589 === dynent)
		{
			if(isdefined(level.gameended) && level.gameended)
			{
				trigger triggerenable(0);
				break;
			}
			if(gettime() >= endtime)
			{
				success = 1;
				var_a852a7dd = trigger function_bf7b8a27(dynent, self);
				dynent.var_a548ec11 = gettime() + (var_a852a7dd * 1000);
				trigger triggerenable(0);
				break;
			}
			if(usetime > 0)
			{
				progress = (gettime() - begintime) / usetime;
				progress = max(progress, 0.01);
				self clientfield::set_player_uimodel("hudItems.dynentUseHoldProgress", progress);
			}
			waitframe(1);
		}
		if(isdefined(dynent.var_45f1d6af) && !success)
		{
			dynent thread [[dynent.var_45f1d6af]](self);
		}
	}
	self clientfield::set_player_uimodel("hudItems.dynentUseHoldProgress", 0);
	self thread function_e882de59(trigger);
	return success;
}

/*
	Name: function_e882de59
	Namespace: namespace_b6ee49c3
	Checksum: 0xC13247C2
	Offset: 0x12B8
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e882de59(trigger)
{
	if(isdefined(level.gameended) && level.gameended)
	{
		return;
	}
	self notify("1fefc20570ca81a2");
	self endon("1fefc20570ca81a2");
	level endon(#"game_ended");
	self endon(#"death", #"disconnect");
	while(self usebuttonpressed())
	{
		waitframe(1);
	}
	trigger callback::function_a04381e0(&function_46502841);
}

/*
	Name: function_7f2040e8
	Namespace: namespace_b6ee49c3
	Checksum: 0x5C8E07E0
	Offset: 0x1388
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_7f2040e8()
{
	if(!isdefined(self.var_8a022726))
	{
		return;
	}
	self.var_8a022726 callback::function_3507ed1f(&function_46502841);
	self thread function_e882de59(self.var_8a022726);
}

/*
	Name: function_bf7b8a27
	Namespace: namespace_b6ee49c3
	Checksum: 0x225709EE
	Offset: 0x13F0
	Size: 0x288
	Parameters: 2
	Flags: Linked
*/
function function_bf7b8a27(dynent, activator)
{
	stateindex = function_ffdbe8c2(dynent);
	bundle = function_489009c1(dynent);
	var_9bdcfcd8 = undefined;
	if(isdefined(bundle) && isdefined(bundle.var_c14aa186) && isdefined(bundle.var_c14aa186[stateindex]))
	{
		state = bundle.var_c14aa186[stateindex];
		var_9bdcfcd8 = (isdefined(state.var_8a7fcb87) ? state.var_8a7fcb87 : 0);
		if(isdefined(activator))
		{
			var_b4b3af4c = anglestoforward(dynent.angles);
			playerdir = self.origin - activator.origin;
			dot = vectordot(var_b4b3af4c, playerdir);
			if(dot > 0)
			{
				var_9bdcfcd8 = (isdefined(state.var_8a7fcb87) ? state.var_8a7fcb87 : 0);
			}
			else
			{
				var_9bdcfcd8 = (isdefined(state.var_afc94db1) ? state.var_afc94db1 : 0);
			}
		}
		if(isplayer(activator) && isdefined(state.var_20630681))
		{
			activator gestures::function_56e00fbf(state.var_20630681, undefined, 0);
		}
		if(isdefined(dynent.onuse))
		{
			succeeded = dynent thread [[dynent.onuse]](activator, stateindex, var_9bdcfcd8);
		}
		if(!isdefined(succeeded) || succeeded == 1)
		{
			function_e2a06860(dynent, var_9bdcfcd8);
		}
		return true;
	}
	return false;
}

/*
	Name: function_3981d015
	Namespace: namespace_b6ee49c3
	Checksum: 0x83F25AF7
	Offset: 0x1680
	Size: 0x55C
	Parameters: 1
	Flags: Private, Event
*/
event private function_3981d015(eventstruct)
{
	dynent = eventstruct.ent;
	var_16a4afdc = eventstruct.state;
	bundle = function_489009c1(dynent);
	if(isdefined(bundle) && isdefined(bundle.var_c14aa186) && isdefined(bundle.var_c14aa186[var_16a4afdc]))
	{
		newstate = bundle.var_c14aa186[var_16a4afdc];
		teleport = eventstruct.teleport;
		if(!(isdefined(bundle.var_f710132b) && bundle.var_f710132b))
		{
			loc_000017D6:
			loc_000017F6:
			pos = ((isdefined(newstate.pos_x) ? newstate.pos_x : 0), (isdefined(newstate.pos_y) ? newstate.pos_y : 0), (isdefined(newstate.pos_z) ? newstate.pos_z : 0));
			pos = rotatepoint(pos, dynent.var_c286a1ae);
			neworigin = dynent.var_718063b0 + pos;
			pitch = dynent.var_c286a1ae[0] + (isdefined(newstate.var_9d1a4684) ? newstate.var_9d1a4684 : 0);
			yaw = dynent.var_c286a1ae[1] + (isdefined(newstate.var_d81008de) ? newstate.var_d81008de : 0);
			roll = dynent.var_c286a1ae[2] + (isdefined(newstate.var_774f5d57) ? newstate.var_774f5d57 : 0);
			newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
			var_a852a7dd = (isdefined(bundle.var_a852a7dd) ? bundle.var_a852a7dd : 0);
			if(!teleport && var_a852a7dd > 0)
			{
				dynent function_49ed8678(neworigin, var_a852a7dd);
				dynent function_7622f013(newangles, var_a852a7dd);
			}
			else
			{
				dynent.origin = neworigin;
				dynent.angles = newangles;
			}
		}
		if(isdefined(newstate.var_c7ae60e8))
		{
			function_b562a1b4(dynent, newstate.var_c7ae60e8);
		}
		if(isdefined(newstate.var_879eb2ff))
		{
			starttime = 0;
			rate = (isdefined(newstate.animrate) ? newstate.animrate : 0);
			if(isdefined(newstate.var_8725802) && newstate.var_8725802)
			{
				gametime = gettime();
				if(isdefined(newstate.var_e23400ad) && newstate.var_e23400ad)
				{
					gametime = gametime + (abs((dynent.origin[0] + dynent.origin[1]) + dynent.origin[2]));
				}
				animlength = int(getanimlength(newstate.var_879eb2ff) * 1000);
				starttime = gametime / (animlength / rate);
				starttime = starttime - int(starttime);
			}
			else if(teleport && !isanimlooping(newstate.var_879eb2ff))
			{
				starttime = 1;
			}
			function_1e23c01f(dynent, newstate.var_879eb2ff, starttime, rate);
		}
		else
		{
			function_27b5ddff(dynent);
		}
		setdynentenabled(dynent, isdefined(newstate.enable) && newstate.enable);
	}
}

/*
	Name: function_ff8b3908
	Namespace: namespace_b6ee49c3
	Checksum: 0xBFEB6D4
	Offset: 0x1BE8
	Size: 0x10C
	Parameters: 1
	Flags: Private, Event
*/
event private function_ff8b3908(eventstruct)
{
	dynent = eventstruct.ent;
	bundle = function_489009c1(dynent);
	var_1a5e0c43 = isdefined(eventstruct.clientside) && eventstruct.clientside;
	if(isdefined(bundle) && isdefined(bundle.var_c14aa186))
	{
		stateindex = (var_1a5e0c43 ? (isdefined(bundle.vehicledestroyed) ? bundle.vehicledestroyed : 0) : (isdefined(bundle.destroyed) ? bundle.destroyed : 0));
		if(isdefined(bundle.var_c14aa186[stateindex]))
		{
			function_e2a06860(dynent, stateindex);
		}
	}
}

/*
	Name: function_209450ae
	Namespace: namespace_b6ee49c3
	Checksum: 0xFDFFB4F1
	Offset: 0x1D00
	Size: 0x48
	Parameters: 1
	Flags: Event
*/
event function_209450ae(eventstruct)
{
	dynent = eventstruct.ent;
	if(isdefined(dynent.ondamaged))
	{
		[[dynent.ondamaged]](eventstruct);
	}
}

/*
	Name: function_5f747d5a
	Namespace: namespace_b6ee49c3
	Checksum: 0x7AECB662
	Offset: 0x1D50
	Size: 0x176
	Parameters: 0
	Flags: Private
*/
function private function_5f747d5a()
{
	/#
		level endon(#"game_ended");
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			wait(0.25);
			dvarstr = getdvarstring(#"hash_40f9f26f308dd924", "");
			if(dvarstr == "")
			{
				continue;
			}
			setdvar(#"hash_40f9f26f308dd924", "");
			args = strtok(dvarstr, "");
			switch(args[0])
			{
				case "reset":
				{
					function_3ca3c6e4();
					break;
				}
			}
		}
	#/
}

/*
	Name: function_6b66543a
	Namespace: namespace_b6ee49c3
	Checksum: 0x4E860E39
	Offset: 0x1ED0
	Size: 0x290
	Parameters: 0
	Flags: Private
*/
function private function_6b66543a()
{
	/#
		self endon(#"disconnect");
		while(true)
		{
			waitframe(1);
			waittillframeend();
			if(!getdvarint(#"hash_23e7101285284738", 0))
			{
				continue;
			}
			trigger = self.var_8a022726;
			if(isdefined(trigger))
			{
				dynent = trigger.var_a9309589;
				if(isdefined(dynent))
				{
					sphere(function_c5689a6a(dynent), 8, (0, 1, 1));
					sphere(dynent.origin, 7, (1, 0.5, 0));
					print3d(dynent.origin, function_ffdbe8c2(dynent), (1, 1, 1), 1, 0.5);
				}
				color = (trigger istriggerenabled() ? (1, 0, 1) : (1, 0, 0));
				maxs = trigger getmaxs();
				mins = trigger getmins();
				origin = trigger.origin;
				top = origin + (0, 0, maxs[2]);
				bottom = origin + (0, 0, mins[2]);
				line(bottom, top, color);
				sphere(origin, 2, color);
				circle(bottom, maxs[0], color, 0, 1);
				circle(top, maxs[0], color, 0, 1);
			}
		}
	#/
}

