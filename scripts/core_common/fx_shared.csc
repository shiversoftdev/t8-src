// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\sound_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace fx;

/*
	Name: function_89f2df9
	Namespace: fx
	Checksum: 0x4F193E39
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"fx", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: fx
	Checksum: 0xE6D7F20B
	Offset: 0x138
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localclient_connect(&player_init);
}

/*
	Name: player_init
	Namespace: fx
	Checksum: 0x287A3A1F
	Offset: 0x168
	Size: 0x2B2
	Parameters: 1
	Flags: Linked
*/
function player_init(clientnum)
{
	if(!isdefined(level.createfxent))
	{
		return;
	}
	creatingexploderarray = 0;
	if(!isdefined(level.createfxexploders))
	{
		creatingexploderarray = 1;
		level.createfxexploders = [];
	}
	for(i = 0; i < level.createfxent.size; i++)
	{
		ent = level.createfxent[i];
		if(!isdefined(level._createfxforwardandupset))
		{
			if(!isdefined(level._createfxforwardandupset))
			{
				ent set_forward_and_up_vectors();
			}
		}
		if(ent.v[#"type"] == "loopfx")
		{
			ent thread loop_thread(clientnum);
		}
		if(ent.v[#"type"] == "oneshotfx")
		{
			ent thread oneshot_thread(clientnum);
		}
		if(ent.v[#"type"] == "soundfx")
		{
			ent thread loop_sound(clientnum);
		}
		if(creatingexploderarray && ent.v[#"type"] == "exploder")
		{
			if(!isdefined(level.createfxexploders[ent.v[#"exploder"]]))
			{
				level.createfxexploders[ent.v[#"exploder"]] = [];
			}
			ent.v[#"exploder_id"] = exploder::getexploderid(ent);
			level.createfxexploders[ent.v[#"exploder"]][level.createfxexploders[ent.v[#"exploder"]].size] = ent;
		}
	}
	level._createfxforwardandupset = 1;
}

/*
	Name: validate
	Namespace: fx
	Checksum: 0x91F36924
	Offset: 0x428
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function validate(fxid, origin)
{
	/#
		if(!isdefined(level._effect[fxid]))
		{
			/#
				assertmsg("" + fxid + "" + origin);
			#/
		}
	#/
}

/*
	Name: create_loop_sound
	Namespace: fx
	Checksum: 0x8D4F4657
	Offset: 0x490
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function create_loop_sound()
{
	ent = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}
	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v[#"type"] = "soundfx";
	ent.v[#"fxid"] = "No FX";
	ent.v[#"soundalias"] = "nil";
	ent.v[#"angles"] = (0, 0, 0);
	ent.v[#"origin"] = (0, 0, 0);
	ent.drawn = 1;
	return ent;
}

/*
	Name: create_effect
	Namespace: fx
	Checksum: 0x90644B95
	Offset: 0x5C8
	Size: 0x106
	Parameters: 2
	Flags: Linked
*/
function create_effect(type, fxid)
{
	ent = spawnstruct();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}
	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v[#"type"] = type;
	ent.v[#"fxid"] = fxid;
	ent.v[#"angles"] = (0, 0, 0);
	ent.v[#"origin"] = (0, 0, 0);
	ent.drawn = 1;
	return ent;
}

/*
	Name: create_oneshot_effect
	Namespace: fx
	Checksum: 0xF59AD201
	Offset: 0x6D8
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function create_oneshot_effect(fxid)
{
	ent = create_effect("oneshotfx", fxid);
	ent.v[#"delay"] = -15;
	return ent;
}

/*
	Name: create_loop_effect
	Namespace: fx
	Checksum: 0x49F0A5A5
	Offset: 0x738
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function create_loop_effect(fxid)
{
	ent = create_effect("loopfx", fxid);
	ent.v[#"delay"] = 0.5;
	return ent;
}

/*
	Name: set_forward_and_up_vectors
	Namespace: fx
	Checksum: 0x1D3FE65D
	Offset: 0x798
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function set_forward_and_up_vectors()
{
	self.v[#"up"] = anglestoup(self.v[#"angles"]);
	self.v[#"forward"] = anglestoforward(self.v[#"angles"]);
}

/*
	Name: oneshot_thread
	Namespace: fx
	Checksum: 0x23BAE28E
	Offset: 0x828
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function oneshot_thread(clientnum)
{
	if(self.v[#"delay"] > 0)
	{
		wait(self.v[#"delay"]);
	}
	create_trigger(clientnum);
}

/*
	Name: report_num_effects
	Namespace: fx
	Checksum: 0x82B22D5D
	Offset: 0x890
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function report_num_effects()
{
	/#
	#/
}

/*
	Name: loop_sound
	Namespace: fx
	Checksum: 0xCE9444A3
	Offset: 0x8A0
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function loop_sound(clientnum)
{
	if(clientnum != 0)
	{
		return;
	}
	self notify(#"stop_loop");
	if(isdefined(self.v[#"soundalias"]) && self.v[#"soundalias"] != "nil")
	{
		if(isdefined(self.v[#"stopable"]) && self.v[#"stopable"])
		{
			thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"], "stop_loop");
		}
		else
		{
			thread sound::loop_fx_sound(clientnum, self.v[#"soundalias"], self.v[#"origin"]);
		}
	}
}

/*
	Name: lightning
	Namespace: fx
	Checksum: 0x83746F1E
	Offset: 0xA00
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function lightning(normalfunc, flashfunc)
{
	[[flashfunc]]();
	wait(randomfloatrange(0.05, 0.1));
	[[normalfunc]]();
}

/*
	Name: loop_thread
	Namespace: fx
	Checksum: 0x699F5327
	Offset: 0xA50
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function loop_thread(clientnum)
{
	if(isdefined(self.fxstart))
	{
		level waittill("start fx" + self.fxstart);
	}
	while(true)
	{
		create_looper(clientnum);
		if(isdefined(self.timeout))
		{
			thread loop_stop(clientnum, self.timeout);
		}
		if(isdefined(self.fxstop))
		{
			level waittill("stop fx" + self.fxstop);
		}
		else
		{
			return;
		}
		if(isdefined(self.looperfx))
		{
			deletefx(clientnum, self.looperfx);
		}
		if(isdefined(self.fxstart))
		{
			level waittill("start fx" + self.fxstart);
		}
		else
		{
			return;
		}
	}
}

/*
	Name: loop_stop
	Namespace: fx
	Checksum: 0x90809520
	Offset: 0xB58
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function loop_stop(clientnum, timeout)
{
	self endon(#"death");
	wait(timeout);
	if(isdefined(self.looper))
	{
		deletefx(clientnum, self.looper);
	}
}

/*
	Name: create_looper
	Namespace: fx
	Checksum: 0x914D0738
	Offset: 0xBC0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function create_looper(clientnum)
{
	self thread loop(clientnum);
	loop_sound(clientnum);
}

/*
	Name: loop
	Namespace: fx
	Checksum: 0xB57D46C3
	Offset: 0xC08
	Size: 0x246
	Parameters: 1
	Flags: Linked
*/
function loop(clientnum)
{
	validate(self.v[#"fxid"], self.v[#"origin"]);
	self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
	while(true)
	{
		if(isdefined(self.v[#"delay"]))
		{
			wait(self.v[#"delay"]);
		}
		while(isfxplaying(clientnum, self.looperfx))
		{
			wait(0.25);
		}
		self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], 0, self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
	}
}

/*
	Name: create_trigger
	Namespace: fx
	Checksum: 0x379F6710
	Offset: 0xE58
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function create_trigger(clientnum)
{
	validate(self.v[#"fxid"], self.v[#"origin"]);
	/#
		if(getdvarint(#"debug_fx", 0) > 0)
		{
			println("" + self.v[#"fxid"]);
		}
	#/
	self.looperfx = playfx(clientnum, level._effect[self.v[#"fxid"]], self.v[#"origin"], self.v[#"forward"], self.v[#"up"], self.v[#"delay"], self.v[#"primlightfrac"], self.v[#"lightoriginoffs"]);
	loop_sound(clientnum);
}

/*
	Name: function_3539a829
	Namespace: fx
	Checksum: 0x30B15157
	Offset: 0xFF0
	Size: 0x7A
	Parameters: 4
	Flags: Linked
*/
function function_3539a829(local_client_num, friendly_fx, enemy_fx, tag)
{
	if(self function_4e0ca360())
	{
		return util::playfxontag(local_client_num, friendly_fx, self, tag);
	}
	return util::playfxontag(local_client_num, enemy_fx, self, tag);
}

/*
	Name: function_94d3d1d
	Namespace: fx
	Checksum: 0x8F3312AD
	Offset: 0x1078
	Size: 0x7A
	Parameters: 4
	Flags: None
*/
function function_94d3d1d(local_client_num, friendly_fx, enemy_fx, origin)
{
	if(self function_4e0ca360())
	{
		return playfx(local_client_num, friendly_fx, origin);
	}
	return playfx(local_client_num, enemy_fx, origin);
}

/*
	Name: blinky_light
	Namespace: fx
	Checksum: 0x76F4D79B
	Offset: 0x1100
	Size: 0x110
	Parameters: 4
	Flags: None
*/
function blinky_light(localclientnum, tagname, friendlyfx, enemyfx)
{
	self endon(#"death");
	self endon(#"stop_blinky_light");
	self.lighttagname = tagname;
	self util::waittill_dobj(localclientnum);
	self thread blinky_emp_wait(localclientnum);
	while(true)
	{
		if(isdefined(self.stunned) && self.stunned)
		{
			wait(0.1);
			continue;
		}
		if(isdefined(self))
		{
			self function_3539a829(localclientnum, friendlyfx, enemyfx, self.lighttagname);
		}
		util::server_wait(localclientnum, 0.5, 0.016);
	}
}

/*
	Name: stop_blinky_light
	Namespace: fx
	Checksum: 0xE9347995
	Offset: 0x1218
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function stop_blinky_light(localclientnum)
{
	self notify(#"stop_blinky_light");
	if(!isdefined(self.blinkylightfx))
	{
		return;
	}
	stopfx(localclientnum, self.blinkylightfx);
	self.blinkylightfx = undefined;
}

/*
	Name: blinky_emp_wait
	Namespace: fx
	Checksum: 0xCC6971B7
	Offset: 0x1278
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function blinky_emp_wait(localclientnum)
{
	self endon(#"death");
	self endon(#"stop_blinky_light");
	self waittill(#"emp");
	self stop_blinky_light(localclientnum);
}

