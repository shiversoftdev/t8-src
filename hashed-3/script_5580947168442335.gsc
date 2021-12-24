// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_7ca3324ffa5389e4;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\explode.csc;
#using scripts\core_common\math_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_4b76712;

/*
	Name: function_89f2df9
	Namespace: namespace_4b76712
	Checksum: 0xDE2270ED
	Offset: 0x1C0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_698dcdb18ce4f995", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4b76712
	Checksum: 0x49A6984B
	Offset: 0x208
	Size: 0x13E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_2d7e36f50e763c4a"] = #"hash_3cb3a6fc9eb00337";
	level._effect[#"hash_71f4fac26bef1997"] = #"hash_3919b64dc762cab2";
	callback::add_callback(#"freefall", &function_c9a18304);
	callback::add_callback(#"parachute", &function_26d46af3);
	animation::add_notetrack_func("player_free_fall::parachute_detach", &function_a7ab6689);
	level.var_4a2e0494 = isdefined(getgametypesetting(#"hash_6cf5f53d1fbb1066")) && getgametypesetting(#"hash_6cf5f53d1fbb1066");
}

/*
	Name: function_6aac1790
	Namespace: namespace_4b76712
	Checksum: 0xD54F748A
	Offset: 0x350
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6aac1790(var_dbb94a)
{
	if(isdefined(var_dbb94a) && !self isattached(var_dbb94a, "tag_weapon_right"))
	{
		self attach(var_dbb94a, "tag_weapon_right", 1);
	}
}

/*
	Name: function_a43054a8
	Namespace: namespace_4b76712
	Checksum: 0x77C0DEB1
	Offset: 0x3B8
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a43054a8()
{
	parachute = self namespace_eb06e24d::function_fc6b6f3b();
	var_dbb94a = parachute.("parachuteLit");
	if(isdefined(var_dbb94a))
	{
		self util::lock_model(var_dbb94a);
	}
}

/*
	Name: function_1c10540b
	Namespace: namespace_4b76712
	Checksum: 0x5B9F0711
	Offset: 0x428
	Size: 0x64
	Parameters: 0
	Flags: Private
*/
private function function_1c10540b()
{
	parachute = self namespace_eb06e24d::function_fc6b6f3b();
	var_dbb94a = parachute.("parachuteLit");
	if(isdefined(var_dbb94a))
	{
		self util::unlock_model(var_dbb94a);
	}
}

/*
	Name: function_40635b9a
	Namespace: namespace_4b76712
	Checksum: 0xA7D7D57E
	Offset: 0x498
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_40635b9a(var_dbb94a)
{
	if(isdefined(var_dbb94a) && self isattached(var_dbb94a, "tag_weapon_right"))
	{
		self detach(var_dbb94a, "tag_weapon_right");
		self util::unlock_model(var_dbb94a);
	}
}

/*
	Name: function_26d46af3
	Namespace: namespace_4b76712
	Checksum: 0xEB1722F5
	Offset: 0x518
	Size: 0x32C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_26d46af3(eventstruct)
{
	if(!(isplayer(self) || self isplayercorpse()))
	{
		return;
	}
	/#
		println((self.name + "") + eventstruct.parachute);
	#/
	parachute = self namespace_eb06e24d::function_fc6b6f3b();
	var_dbb94a = parachute.("parachuteLit");
	if(eventstruct.parachute)
	{
		parachute_weapon = parachute.("parachute");
		if(isdefined(self.currentweapon))
		{
			if(self.currentweapon === parachute_weapon)
			{
				self function_bf9d3071(#"hash_336cece53ae2342f");
			}
		}
		function_6aac1790(var_dbb94a);
	}
	else
	{
		self function_5d482e78(#"hash_336cece53ae2342f");
		self function_40635b9a(var_dbb94a);
	}
	if(self function_21c0fa55())
	{
		self function_57738ae7(eventstruct.localclientnum, eventstruct.parachute);
		if(eventstruct.parachute)
		{
			self callback::add_entity_callback(#"oob", &function_1eeb50a5);
		}
		else
		{
			function_6564e987(eventstruct.localclientnum);
			self callback::function_52ac9652(#"oob", &function_1eeb50a5);
		}
	}
	if(eventstruct.parachute)
	{
		/#
			println(self.name + "");
		#/
		self callback::add_entity_callback(#"death", &function_5d6b77ae);
		self function_fb8d00bf();
	}
	else
	{
		/#
			println(self.name + "");
		#/
		self callback::function_52ac9652(#"death", &function_5d6b77ae);
	}
}

/*
	Name: function_c9a18304
	Namespace: namespace_4b76712
	Checksum: 0x474947F5
	Offset: 0x850
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c9a18304(eventstruct)
{
	if(!(isplayer(self) || self isplayercorpse()))
	{
		return;
	}
	/#
		println((self.name + "") + eventstruct.freefall);
	#/
	if(eventstruct.freefall)
	{
		if(eventstruct.var_695a7111)
		{
			self function_a43054a8();
		}
		self function_ec3388e3(eventstruct.localclientnum, eventstruct.var_695a7111);
	}
	else
	{
		self function_a097fe21(eventstruct.localclientnum);
	}
}

/*
	Name: function_3f6dfc34
	Namespace: namespace_4b76712
	Checksum: 0xA093F4F
	Offset: 0x948
	Size: 0x1C0
	Parameters: 1
	Flags: Linked
*/
function function_3f6dfc34(localclientnum)
{
	self notify("62720c265d658b90");
	self endon("62720c265d658b90");
	self endon(#"death", #"disconnect", #"hash_36dd69a696f827af");
	while(true)
	{
		waitframe(1);
		if(!self postfx::function_556665f2("pstfx_speedblur_wz"))
		{
			self postfx::playpostfxbundle("pstfx_speedblur_wz");
		}
		blur = function_e81eebd5(localclientnum);
		self function_116b95e5("pstfx_speedblur_wz", #"blur", blur.blur);
		self function_116b95e5("pstfx_speedblur_wz", #"hash_77259d33b3998de9", blur.innermask);
		self function_116b95e5("pstfx_speedblur_wz", #"hash_1a3ba6e8a0732aac", blur.outermask);
		self function_116b95e5("pstfx_speedblur_wz", #"hash_76234e080252eaea", blur.xoffset);
		self function_116b95e5("pstfx_speedblur_wz", #"hash_13914e9a081eb747", blur.yoffset);
	}
}

/*
	Name: function_cc5ed6ff
	Namespace: namespace_4b76712
	Checksum: 0x79B91A83
	Offset: 0xB10
	Size: 0x4E
	Parameters: 5
	Flags: None
*/
function function_cc5ed6ff(pitch, min_pitch, max_pitch, var_2ff50798, var_9988e8ec)
{
	return ((var_9988e8ec - var_2ff50798) / (max_pitch - min_pitch) * pitch) + var_2ff50798;
}

/*
	Name: function_9a3dbe71
	Namespace: namespace_4b76712
	Checksum: 0x24059925
	Offset: 0xB68
	Size: 0xBE
	Parameters: 1
	Flags: None
*/
function function_9a3dbe71(var_80943462)
{
	/#
		self endon(#"death", #"disconnect", #"hash_36dd69a696f827af");
		while(true)
		{
			vel = self getvelocity();
			speed = length(vel);
			iprintlnbold((("" + speed) + "") + var_80943462);
			wait(1);
		}
	#/
}

/*
	Name: function_ec3388e3
	Namespace: namespace_4b76712
	Checksum: 0xC11D4EDE
	Offset: 0xC30
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_ec3388e3(localclientnum, var_695a7111)
{
	if(self function_21c0fa55())
	{
		self callback::add_entity_callback(#"oob", &function_1eeb50a5);
		self thread function_3f6dfc34(localclientnum);
		self thread function_3a56fe1b(localclientnum);
		self thread function_2bdd64a4(localclientnum);
	}
	/#
		println((self.name + "") + var_695a7111);
	#/
	self callback::add_entity_callback(#"death", &function_5d6b77ae);
	self thread function_e8a9e948(localclientnum, var_695a7111);
	self function_975ebf4d(localclientnum, var_695a7111);
}

/*
	Name: function_5d6b77ae
	Namespace: namespace_4b76712
	Checksum: 0xEABC98CF
	Offset: 0xD70
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_5d6b77ae(params)
{
	function_1c6573a4();
	function_f404a4cc();
	self callback::function_52ac9652(#"death", &function_5d6b77ae);
}

/*
	Name: function_1eeb50a5
	Namespace: namespace_4b76712
	Checksum: 0x694B46DE
	Offset: 0xDD8
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_1eeb50a5(local_client_num, params)
{
	if(params.old_val > 0 && params.new_val > 0)
	{
		return;
	}
	if(params.old_val == 0 && params.new_val == 0)
	{
		return;
	}
	if(params.old_val > 0)
	{
		function_6564e987(local_client_num);
	}
	if(params.new_val > 0)
	{
		function_be621383(local_client_num, getmapcenter());
	}
}

/*
	Name: function_7c653916
	Namespace: namespace_4b76712
	Checksum: 0x93E218F3
	Offset: 0xEB0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_7c653916(timesec)
{
	self endon(#"death");
	wait(timesec);
	self delete();
}

/*
	Name: function_e8a9e948
	Namespace: namespace_4b76712
	Checksum: 0x408323C2
	Offset: 0xEF8
	Size: 0x3B4
	Parameters: 2
	Flags: Linked
*/
function function_e8a9e948(localclientnum, var_695a7111)
{
	if(self function_21c0fa55())
	{
		self endon_callback(&function_1c6573a4, #"death", #"hash_36dd69a696f827af");
		while(true)
		{
			vel = self getvelocity();
			speed = length(vel);
			angles = self getcamangles();
			var_80943462 = 0;
			if(isdefined(angles))
			{
				var_80943462 = angles[0];
				if(var_80943462 > 180)
				{
					var_80943462 = var_80943462 - 360;
				}
			}
			if(speed < 2552)
			{
				if(isdefined(self.var_ba907ef1))
				{
					stopfx(localclientnum, self.var_ba907ef1);
					self.var_ba907ef1 = undefined;
				}
				if(isdefined(self.var_890b1c43))
				{
					stopfx(localclientnum, self.var_890b1c43);
					self.var_890b1c43 = undefined;
				}
				if(isdefined(self.var_9b4d40c7))
				{
					stopfx(localclientnum, self.var_9b4d40c7);
					self.var_9b4d40c7 = undefined;
				}
				if(isdefined(self.var_e47e532c))
				{
					stopfx(localclientnum, self.var_e47e532c);
					self.var_e47e532c = undefined;
				}
				waitframe(1);
				continue;
			}
			var_3ffff5d7 = namespace_eb06e24d::function_2328db2c();
			if(isdefined(self.var_ba907ef1) && self.angles[2] < -20)
			{
				stopfx(localclientnum, self.var_ba907ef1);
				self.var_ba907ef1 = undefined;
			}
			else if(!isdefined(self.var_ba907ef1) && self.angles[2] > -20 && isdefined(var_3ffff5d7.("contrails")))
			{
				self.var_ba907ef1 = self play_fx_on_tag(localclientnum, var_3ffff5d7.("contrails"), var_3ffff5d7.var_ccb00fe4);
			}
			if(isdefined(self.var_890b1c43) && self.angles[2] > 20)
			{
				stopfx(localclientnum, self.var_890b1c43);
				self.var_890b1c43 = undefined;
			}
			else if(!isdefined(self.var_890b1c43) && self.angles[2] < 20 && isdefined(var_3ffff5d7.("contrails")))
			{
				self.var_890b1c43 = self play_fx_on_tag(localclientnum, var_3ffff5d7.("contrails"), var_3ffff5d7.var_6a36c78c);
			}
			waitframe(1);
		}
	}
}

/*
	Name: play_fx_on_tag
	Namespace: namespace_4b76712
	Checksum: 0x404FBDA1
	Offset: 0x12B8
	Size: 0x4A
	Parameters: 3
	Flags: Linked
*/
function play_fx_on_tag(localclientnum, fx, tag = "tag_origin")
{
	return self util::playfxontag(localclientnum, fx, self, tag);
}

/*
	Name: function_a993866
	Namespace: namespace_4b76712
	Checksum: 0xFD9116D6
	Offset: 0x1310
	Size: 0x18A
	Parameters: 2
	Flags: Linked
*/
function function_a993866(localclientnum, var_9a17b15c)
{
	if(!level.var_4a2e0494)
	{
		return;
	}
	if(var_9a17b15c > 0)
	{
		self endon(#"death", #"hash_36dd69a696f827af", #"disconnect");
		wait(var_9a17b15c);
	}
	/#
		println((self.name + "") + var_9a17b15c);
	#/
	trail_fx = namespace_eb06e24d::function_2328db2c();
	if(self function_21c0fa55())
	{
		if(isdefined(trail_fx.("body_trail")))
		{
			self.var_636d5543 = self play_fx_on_tag(localclientnum, trail_fx.("body_trail"), trail_fx.var_82aadb9b);
		}
	}
	else if(!isdefined(self.var_d7cbaf63))
	{
		if(isdefined(trail_fx.("body_trail_3p")))
		{
			tag = trail_fx.var_82aadb9b;
			self.var_d7cbaf63 = self play_fx_on_tag(localclientnum, trail_fx.("body_trail_3p"), trail_fx.var_82aadb9b);
		}
	}
}

/*
	Name: function_975ebf4d
	Namespace: namespace_4b76712
	Checksum: 0xCCB5329D
	Offset: 0x14A8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_975ebf4d(localclientnum, var_695a7111)
{
	if(var_695a7111)
	{
		var_9a17b15c = getdvarfloat(#"hash_2ff67a1af0e1deec", 1);
		self thread function_a993866(localclientnum, var_9a17b15c);
	}
}

/*
	Name: function_1c6573a4
	Namespace: namespace_4b76712
	Checksum: 0xCA6F5A1E
	Offset: 0x1520
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_1c6573a4(notifyhash)
{
	if(self function_21c0fa55())
	{
		if(isdefined(self.var_ba907ef1))
		{
			stopfx(self.localclientnum, self.var_ba907ef1);
			self.var_ba907ef1 = undefined;
		}
		if(isdefined(self.var_890b1c43))
		{
			stopfx(self.localclientnum, self.var_890b1c43);
			self.var_890b1c43 = undefined;
		}
		if(isdefined(self.var_9b4d40c7))
		{
			stopfx(self.localclientnum, self.var_9b4d40c7);
			self.var_9b4d40c7 = undefined;
		}
		if(isdefined(self.var_e47e532c))
		{
			stopfx(self.localclientnum, self.var_e47e532c);
			self.var_e47e532c = undefined;
		}
	}
}

/*
	Name: function_ba7365ff
	Namespace: namespace_4b76712
	Checksum: 0x769D9771
	Offset: 0x1630
	Size: 0x80
	Parameters: 3
	Flags: Linked
*/
function function_ba7365ff(localclientnum, height, fxid)
{
	self endon(#"death", #"hash_36dd69a696f827af");
	while(true)
	{
		if(self.origin[2] < height)
		{
			self thread function_ada640c5(localclientnum, fxid);
			return;
		}
		wait(1);
	}
}

/*
	Name: function_3a56fe1b
	Namespace: namespace_4b76712
	Checksum: 0x8C911F77
	Offset: 0x16B8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_3a56fe1b(localclientnum)
{
	if(!isdefined(self.var_1c0f821e))
	{
		self.var_1c0f821e = play_fx_on_tag(localclientnum, level._effect[#"hash_2d7e36f50e763c4a"], "tag_origin");
		self thread function_ba7365ff(localclientnum, 6000, self.var_1c0f821e);
	}
	if(!isdefined(self.var_3e64d3fb))
	{
		self.var_3e64d3fb = play_fx_on_tag(localclientnum, level._effect[#"hash_71f4fac26bef1997"], "tag_origin");
		self thread function_ba7365ff(localclientnum, 25000, self.var_3e64d3fb);
	}
}

/*
	Name: function_ada640c5
	Namespace: namespace_4b76712
	Checksum: 0xD1229BFE
	Offset: 0x17B0
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_ada640c5(localclientnum, fxid)
{
	if(isdefined(fxid))
	{
		stopfx(localclientnum, fxid);
	}
}

/*
	Name: function_fe726f7
	Namespace: namespace_4b76712
	Checksum: 0xC8A23ECF
	Offset: 0x17F0
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_fe726f7(localclientnum)
{
	function_ada640c5(localclientnum, self.var_1c0f821e);
	function_ada640c5(localclientnum, self.var_3e64d3fb);
	self.var_1c0f821e = undefined;
	self.var_3e64d3fb = undefined;
}

/*
	Name: function_2bdd64a4
	Namespace: namespace_4b76712
	Checksum: 0x46FCA4F2
	Offset: 0x1858
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_2bdd64a4(localclientnum)
{
	if(isdefined(self.var_b7756d91))
	{
		self stoploopsound(self.var_b7756d91, 0);
		self.var_b7756d91 = undefined;
	}
	self.var_b7756d91 = self playloopsound("evt_skydive_wind_heavy", 1);
	if(self.origin[2] > 30000)
	{
		self playsound(localclientnum, #"hash_214da797e3f63ec5");
	}
}

/*
	Name: function_577c7bd0
	Namespace: namespace_4b76712
	Checksum: 0x87F6F667
	Offset: 0x1908
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_577c7bd0(localclientnum)
{
	if(isdefined(self.var_b7756d91))
	{
		self stoploopsound(self.var_b7756d91, 0);
		self.var_b7756d91 = undefined;
	}
}

/*
	Name: function_a097fe21
	Namespace: namespace_4b76712
	Checksum: 0x1ECAF860
	Offset: 0x1950
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_a097fe21(localclientnum)
{
	self notify(#"hash_36dd69a696f827af");
	/#
		println(self.name + "");
	#/
	self callback::function_52ac9652(#"death", &function_5d6b77ae);
	function_f404a4cc();
	if(self function_21c0fa55())
	{
		function_6564e987(localclientnum);
		self callback::function_52ac9652(#"oob", &function_1eeb50a5);
		self thread function_fe726f7(localclientnum);
		if(self postfx::function_556665f2("pstfx_speedblur_wz"))
		{
			self postfx::exitpostfxbundle("pstfx_speedblur_wz");
		}
		self thread audio::dorattle(self.origin, 200, 700);
		self playrumbleonentity(localclientnum, "damage_heavy");
		self thread function_577c7bd0(localclientnum);
	}
}

/*
	Name: function_57738ae7
	Namespace: namespace_4b76712
	Checksum: 0x5BDEB0C0
	Offset: 0x1AF8
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function function_57738ae7(localclientnum, parachute)
{
	if(isdefined(parachute) && parachute)
	{
		self.var_fcfda7c4 = self playloopsound("evt_skydive_wind_light", 1);
	}
	else if(isdefined(self.var_fcfda7c4))
	{
		self stoploopsound(self.var_fcfda7c4, 0);
		self.var_fcfda7c4 = undefined;
	}
	if(isdefined(self.var_b7756d91))
	{
		self stoploopsound(self.var_b7756d91, 0);
		self.var_b7756d91 = undefined;
	}
}

/*
	Name: ground_trace
	Namespace: namespace_4b76712
	Checksum: 0x49447F0E
	Offset: 0x1BC0
	Size: 0x6A
	Parameters: 2
	Flags: None
*/
function ground_trace(startpos, owner)
{
	trace_height = 50;
	trace_depth = 100;
	return bullettrace(startpos + (0, 0, trace_height), startpos - (0, 0, trace_depth), 0, owner);
}

/*
	Name: function_5789287a
	Namespace: namespace_4b76712
	Checksum: 0xB9C7D2A1
	Offset: 0x1C38
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_5789287a()
{
	self endon(#"death");
	wait(1.75);
	self function_5d482e78(#"hash_336cece53ae2342f");
}

/*
	Name: function_fb8d00bf
	Namespace: namespace_4b76712
	Checksum: 0x2563DED8
	Offset: 0x1C88
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_fb8d00bf()
{
	local_client_num = self.localclientnum;
	if(level.var_4a2e0494)
	{
		trail_fx = self namespace_eb06e24d::function_2328db2c();
		if(isdefined(trail_fx.("dropoff")))
		{
			playfx(local_client_num, trail_fx.("dropoff"), self.origin);
		}
	}
}

/*
	Name: function_a7ab6689
	Namespace: namespace_4b76712
	Checksum: 0xDDACE2EC
	Offset: 0x1D18
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function function_a7ab6689()
{
	local_client_num = self.localclientnum;
	chute = self namespace_eb06e24d::function_fc6b6f3b();
	parachute = util::spawn_model(local_client_num, chute.parachutelit, self.origin, self.angles);
	if(isdefined(parachute))
	{
		parachute linkto(self);
		parachute useanimtree("generic");
		parachute function_bf9d3071(#"hash_336cece53ae2342f");
		parachute thread function_5789287a();
		parachute animation::play(#"p8_fxanim_wz_parachute_player_anim", self.origin, self.angles);
		wait(1);
		parachute delete();
	}
}

/*
	Name: function_f404a4cc
	Namespace: namespace_4b76712
	Checksum: 0xC7AC6DC3
	Offset: 0x1E58
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function function_f404a4cc()
{
	if(isdefined(self.var_d7cbaf63))
	{
		/#
			println(self.name + "");
		#/
		stopfx(self.localclientnum, self.var_d7cbaf63);
		self.var_d7cbaf63 = undefined;
	}
	if(isdefined(self.var_636d5543))
	{
		/#
			println(self.name + "");
		#/
		stopfx(self.localclientnum, self.var_636d5543);
		self.var_636d5543 = undefined;
	}
}

