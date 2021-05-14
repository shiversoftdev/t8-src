// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_48288470fe0b53d;
#using script_5bb072c3abf4652c;
#using script_db06eb511bd9b36;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_red_zones.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_159b5b5b;

/*
	Name: init
	Namespace: namespace_159b5b5b
	Checksum: 0xFAC4A453
	Offset: 0x178
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("toplayer", "zm_red_timer", 16000, getminbitcountfornum(120), "int");
	level.var_d0d80ff8 = zm_red_challenges_hud::register("zm_red_challenges_hud");
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_a3a07623();
	}
	level._effect[#"barrier_impact"] = #"hash_573f7a396c8ea0c1";
}

/*
	Name: barrier_impact
	Namespace: namespace_159b5b5b
	Checksum: 0x95F5D50F
	Offset: 0x248
	Size: 0x138
	Parameters: 0
	Flags: Linked
*/
function barrier_impact()
{
	self endon(#"death");
	self val::set("power_event", "takedamage", 1);
	self.health = 99999;
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"damage");
		if(isdefined(s_result.amount))
		{
			self.health = self.health + s_result.amount;
		}
		if(isdefined(s_result.position) && isdefined(s_result.attacker))
		{
			playfx(level._effect[#"barrier_impact"], s_result.position, anglestoforward(s_result.attacker.angles) * -1);
			wait(0.25);
		}
	}
}

/*
	Name: function_6f5a2cb2
	Namespace: namespace_159b5b5b
	Checksum: 0xFAE71D42
	Offset: 0x388
	Size: 0xF0
	Parameters: 4
	Flags: None
*/
function function_6f5a2cb2(text, n_display_time = 0, str_waittill = undefined, var_3de28ed8 = 1)
{
	a_players = util::get_active_players();
	foreach(player in a_players)
	{
		player thread show_text(text, n_display_time, str_waittill, var_3de28ed8);
	}
}

/*
	Name: function_207cca50
	Namespace: namespace_159b5b5b
	Checksum: 0x6AFDEC4A
	Offset: 0x480
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_207cca50()
{
	if(!level.var_d0d80ff8 zm_red_challenges_hud::is_open(self))
	{
		level.var_d0d80ff8 zm_red_challenges_hud::open(self);
	}
}

/*
	Name: function_18bb0d0d
	Namespace: namespace_159b5b5b
	Checksum: 0x222EC418
	Offset: 0x4D0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_18bb0d0d()
{
	if(level.var_d0d80ff8 zm_red_challenges_hud::is_open(self))
	{
		level.var_d0d80ff8 zm_red_challenges_hud::close(self);
	}
}

/*
	Name: function_b4759cf8
	Namespace: namespace_159b5b5b
	Checksum: 0xD9F48CC4
	Offset: 0x520
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_b4759cf8()
{
	self function_207cca50();
	if(zm_utility::is_trials())
	{
		level.var_d0d80ff8 zm_red_challenges_hud::set_state(self, #"trials");
	}
	else
	{
		level.var_d0d80ff8 zm_red_challenges_hud::set_state(self, #"visible");
	}
}

/*
	Name: function_7e30f24c
	Namespace: namespace_159b5b5b
	Checksum: 0x9BA96C22
	Offset: 0x5B0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_7e30f24c()
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::set_state(self, #"defaultstate");
}

/*
	Name: function_7e617e33
	Namespace: namespace_159b5b5b
	Checksum: 0x5A38BF7D
	Offset: 0x600
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_7e617e33(var_9eb6bb80 = 1)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_3fdd9da7(self, (var_9eb6bb80 ? 0 : 1));
}

/*
	Name: function_9ab191d3
	Namespace: namespace_159b5b5b
	Checksum: 0xF9B86EDE
	Offset: 0x670
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_9ab191d3(var_447e014a = 1)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_c6703876(self, (var_447e014a ? 1 : 0));
}

/*
	Name: function_7a344bdf
	Namespace: namespace_159b5b5b
	Checksum: 0xCE71FA2A
	Offset: 0x6E0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_7a344bdf(text)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_1c836e71(self, text);
}

/*
	Name: function_f0d355fc
	Namespace: namespace_159b5b5b
	Checksum: 0xD7AFAC97
	Offset: 0x730
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_f0d355fc(text)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_2dde4d6c(self, text);
}

/*
	Name: function_76f2fea0
	Namespace: namespace_159b5b5b
	Checksum: 0xB4795570
	Offset: 0x780
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_76f2fea0(var_3f4d60e3 = 1)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_ad9c4f0(self, (var_3f4d60e3 ? 1 : 0));
}

/*
	Name: function_a6d4b55e
	Namespace: namespace_159b5b5b
	Checksum: 0xFAF4BFE2
	Offset: 0x7F0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_a6d4b55e(var_e2fdd04c)
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_ac67ad85(self, var_e2fdd04c);
}

/*
	Name: function_34a533b1
	Namespace: namespace_159b5b5b
	Checksum: 0x547D559E
	Offset: 0x840
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_34a533b1()
{
	self function_207cca50();
	level.var_d0d80ff8 zm_red_challenges_hud::function_96972b9c(self);
}

/*
	Name: show_text
	Namespace: namespace_159b5b5b
	Checksum: 0xBEE73795
	Offset: 0x888
	Size: 0x15C
	Parameters: 4
	Flags: Linked
*/
function show_text(text, n_display_time = 0, str_waittill = undefined, var_3de28ed8 = 1)
{
	self endon(#"death");
	if(var_3de28ed8)
	{
		self function_7a344bdf(text);
		self function_b4759cf8();
	}
	else
	{
		self function_f0d355fc(text);
		self function_b4759cf8();
	}
	if(n_display_time)
	{
		self waittill_timeout(n_display_time, #"death", #"disconnect", str_waittill);
	}
	else
	{
		self waittill(#"death", #"disconnect", str_waittill);
	}
	if(isdefined(self))
	{
		if(level.var_d0d80ff8 zm_red_challenges_hud::is_open(self))
		{
			self function_b952264e(var_3de28ed8);
		}
	}
}

/*
	Name: function_b952264e
	Namespace: namespace_159b5b5b
	Checksum: 0x1558E3E1
	Offset: 0x9F0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_b952264e(var_3de28ed8 = 1)
{
	if(var_3de28ed8)
	{
		self function_7a344bdf(#"");
	}
	else
	{
		self function_f0d355fc(#"");
	}
}

/*
	Name: can_see
	Namespace: namespace_159b5b5b
	Checksum: 0xBEB091BB
	Offset: 0xA68
	Size: 0x116
	Parameters: 3
	Flags: Linked
*/
function can_see(v_pos, var_7b20e52b, n_dot = 0.7)
{
	v_forward = anglestoforward(self.angles);
	v_dir = vectornormalize(v_pos - self.origin);
	dp = vectordot(v_forward, v_dir);
	if(dp > n_dot)
	{
		if(isdefined(var_7b20e52b) && var_7b20e52b)
		{
			trace = bullettrace(v_pos, self.origin + vectorscale((0, 0, 1), 40), 0, undefined);
			if(trace[#"fraction"] < 1)
			{
				return 0;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: start_timer
	Namespace: namespace_159b5b5b
	Checksum: 0xB3DA70B8
	Offset: 0xB88
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function start_timer(n_time_seconds)
{
	foreach(player in level.players)
	{
		player clientfield::set_to_player("zm_red_timer", n_time_seconds);
	}
}

/*
	Name: stop_timer
	Namespace: namespace_159b5b5b
	Checksum: 0x8AC45C4
	Offset: 0xC20
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function stop_timer()
{
	foreach(player in level.players)
	{
		player clientfield::set_to_player("zm_red_timer", 0);
	}
}

/*
	Name: function_dd9dd1cd
	Namespace: namespace_159b5b5b
	Checksum: 0x3097F338
	Offset: 0xCB0
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function function_dd9dd1cd()
{
	var_90c5736d = [];
	foreach(zone in level.zones)
	{
		if(isdefined(zone) && zone.is_enabled)
		{
			var_a24af036 = namespace_a409d261::function_27028b8e(zone.name);
			array::add(var_90c5736d, var_a24af036, 0);
		}
	}
	return var_90c5736d;
}

/*
	Name: function_9dcee9e4
	Namespace: namespace_159b5b5b
	Checksum: 0x3A4F0BF
	Offset: 0xD90
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function function_9dcee9e4(vol_area)
{
	a_players = getplayers();
	var_2a4957b4 = function_f17015c8(a_players, vol_area);
	return var_2a4957b4;
}

/*
	Name: function_797ac3b0
	Namespace: namespace_159b5b5b
	Checksum: 0xE279D30F
	Offset: 0xDE8
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_797ac3b0(vol_area)
{
	a_zombies = getaiteamarray(level.zombie_team);
	var_2a4957b4 = function_f17015c8(a_zombies, vol_area);
	return var_2a4957b4;
}

/*
	Name: function_f17015c8
	Namespace: namespace_159b5b5b
	Checksum: 0x8DC730B7
	Offset: 0xE48
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_f17015c8(a_ents, vol_area)
{
	var_2a4957b4 = 0;
	foreach(ent in a_ents)
	{
		if(ent istouching(vol_area))
		{
			var_2a4957b4++;
		}
	}
	return var_2a4957b4;
}

/*
	Name: function_a3a07623
	Namespace: namespace_159b5b5b
	Checksum: 0xBD1B89D
	Offset: 0xEF8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_a3a07623()
{
	var_1a83e85e = struct::get_array("collectibles_pos", "targetname");
	array::thread_all(var_1a83e85e, &function_ee58ddd4);
	var_551e1d09 = struct::get_array("scrolls_pos", "targetname");
	array::thread_all(var_551e1d09, &function_ee58ddd4, 1);
}

/*
	Name: function_ee58ddd4
	Namespace: namespace_159b5b5b
	Checksum: 0xC01EF4F5
	Offset: 0xFA0
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ee58ddd4(is_scroll = 0)
{
	n_radius = 64;
	if(isdefined(self.radius))
	{
		n_radius = self.radius;
	}
	if(isdefined(self.model))
	{
		var_e23b0237 = util::spawn_model(self.model, self.origin, self.angles, 0, 1);
	}
	var_64c09f7f = self zm_unitrigger::function_fac87205("", n_radius);
	if(isplayer(var_64c09f7f))
	{
		if(is_scroll)
		{
			var_64c09f7f thread function_eb6f144(self.script_string, var_e23b0237);
		}
		else
		{
			var_64c09f7f thread function_8916aa62(self.script_string);
		}
	}
}

/*
	Name: function_a94baf7b
	Namespace: namespace_159b5b5b
	Checksum: 0x1A0F73EA
	Offset: 0x10B8
	Size: 0x1B8
	Parameters: 0
	Flags: None
*/
function function_a94baf7b()
{
	/#
		var_1a83e85e = struct::get_array("", "");
		foreach(s_collectibles in var_1a83e85e)
		{
			sphere(s_collectibles.origin + vectorscale((0, 0, 1), 60), 12, (0, 1, 1), 0.7, 0, 16, 10000);
		}
		var_551e1d09 = struct::get_array("", "");
		foreach(s_scrolls in var_551e1d09)
		{
			sphere(s_scrolls.origin + vectorscale((0, 0, 1), 60), 12, (1, 0.5, 0), 0.7, 0, 16, 10000);
		}
	#/
}

/*
	Name: function_8916aa62
	Namespace: namespace_159b5b5b
	Checksum: 0xD9DB8149
	Offset: 0x1278
	Size: 0x47E
	Parameters: 1
	Flags: Linked
*/
function function_8916aa62(str_line)
{
	switch(str_line)
	{
		case "hash_61b0d833df7fb2c3":
		{
			str_vo_line = #"hash_1afab8875f1342bc";
			break;
		}
		case "hash_13833567991bf57f":
		{
			str_vo_line = #"hash_6602f6ff55aea604";
			break;
		}
		case "hash_408fb94f739c906a":
		{
			str_vo_line = #"hash_1afd1c392812ecf3";
			break;
		}
		case "hash_3cfaf80bf0ef01e3":
		{
			str_vo_line = #"hash_45da578907c2942c";
			break;
		}
		case "hash_42bda6a5dfbf11a1":
		{
			str_vo_line = #"hash_19881d774c4bb8ae";
			break;
		}
		case "hash_77a4e6aa7a36c06":
		{
			str_vo_line = #"hash_60a1b31d1e49dfef";
			break;
		}
		case "hash_2bfb4eb3328f4aec":
		{
			str_vo_line = #"hash_33c6fcca57aca8d";
			break;
		}
		case "hash_5e5b1ca453e6f455":
		{
			str_vo_line = #"hash_497d4298ff17357a";
			break;
		}
		case "hash_30574e66f25be5e4":
		{
			str_vo_line = #"hash_6ef7ae2fd8250179";
			break;
		}
		case "hash_50e280aeaa829e6c":
		{
			str_vo_line = #"hash_62abf8f91f119ead";
			break;
		}
		case "hash_29f246efb660b3f0":
		{
			str_vo_line = #"hash_3a5e26183d8b51c1";
			break;
		}
		case "hash_e2cf00499808431":
		{
			str_vo_line = #"hash_499d5f58bb808122";
			break;
		}
		case "hash_495032b77ee384a6":
		{
			str_vo_line = #"hash_48e9f010df79bf6b";
			break;
		}
		case "hash_7004febf4258ee7c":
		{
			str_vo_line = #"hash_4ca81ffc1793c4fd";
			break;
		}
		case "hash_4439679b1d9196dc":
		{
			str_vo_line = #"hash_390aa4c8a2db661d";
			break;
		}
		case "hash_156a2e99360d81da":
		{
			str_vo_line = #"hash_26935699e93f1db7";
			break;
		}
		case "hash_6fdd85df000603d4":
		{
			str_vo_line = #"hash_13ae4ec246717759";
			break;
		}
		case "hash_4d78ef43b2835e3b":
		{
			str_vo_line = #"hash_4125f996df00a018";
			break;
		}
		case "hash_1a07eae6ed334037":
		{
			str_vo_line = #"hash_10cbb1b8573a0040";
			break;
		}
		case "hash_5eff508aba7e72bf":
		{
			str_vo_line = #"hash_3675fc89d07c4c0c";
			break;
		}
		case "hash_59cedc66fd5105d2":
		{
			str_vo_line = #"hash_1ca7575800b7ff57";
			break;
		}
		case "hash_26990fb3fc664144":
		{
			str_vo_line = #"hash_5e56b7fe2e124bbd";
			break;
		}
		case "hash_4ea1d73b4539f362":
		{
			str_vo_line = #"hash_42068e9344b63c57";
			break;
		}
		case "hash_7d5051b5c30af3ff":
		{
			str_vo_line = #"hash_3c592afca5126028";
			break;
		}
		case "hash_48f3eb6c6c2d5cea":
		{
			str_vo_line = #"hash_3d675b5319c334b7";
			break;
		}
		case "hash_1822f9abde6c45e":
		{
			str_vo_line = #"hash_60fc5081c4fd6b7";
			break;
		}
		default:
		{
			return;
		}
	}
	b_say = self zm_vo::function_8e0f4696(str_vo_line, 0, 1, 9999, 1, 1, 1);
}

/*
	Name: function_eb6f144
	Namespace: namespace_159b5b5b
	Checksum: 0xA8C4134B
	Offset: 0x1700
	Size: 0x384
	Parameters: 2
	Flags: Linked
*/
function function_eb6f144(str_line, var_e23b0237)
{
	switch(str_line)
	{
		case "hash_3cdee5e460e84228":
		{
			str_vo_line = #"hash_53d277c8b1114728";
			var_bfdd8441 = #"hash_c7f396aed80374b";
			break;
		}
		case "hash_3cdee8e460e84741":
		{
			str_vo_line = #"hash_e3e70858f5614e3";
			var_bfdd8441 = #"hash_c7f396aed80374b";
			break;
		}
		case "hash_3cdee7e460e8458e":
		{
			str_vo_line = #"hash_748ebfa215a02be6";
			var_bfdd8441 = #"hash_3d24b9655233513d";
			break;
		}
		case "hash_3cdeeae460e84aa7":
		{
			str_vo_line = #"hash_52c2f244c43714a9";
			var_bfdd8441 = #"hash_29c7b1f9e28de2ee";
			break;
		}
		case "hash_3cdee9e460e848f4":
		{
			str_vo_line = #"hash_2d2ebb39be31994c";
			var_bfdd8441 = #"hash_22dbce472ee3015b";
			break;
		}
		case "hash_3cdeece460e84e0d":
		{
			str_vo_line = #"hash_7cd8582798401757";
			var_bfdd8441 = #"hash_29c7b0f9e28de13b";
			break;
		}
		case "hash_3cdeebe460e84c5a":
		{
			str_vo_line = #"hash_4081f86f16c90f9a";
			var_bfdd8441 = #"hash_29c7aff9e28ddf88";
			break;
		}
		case "scroll_8":
		{
			str_vo_line = #"hash_e902c086e6a174d";
			var_bfdd8441 = #"hash_73ae4e30dfdf732d";
			break;
		}
		case "hash_3cdedde460e83490":
		{
			str_vo_line = "";
			var_bfdd8441 = "";
			break;
		}
		default:
		{
			return;
		}
	}
	var_e23b0237 playsound(#"hash_764458163b3f25f1");
	wait(1.2);
	var_e23b0237 playsound(str_vo_line);
	var_e23b0237 playloopsound(var_bfdd8441);
	if(str_line != "scroll_8")
	{
		function_d24a0f09(str_vo_line, 0.6);
		var_e23b0237 stoploopsound();
		var_e23b0237 playsound(#"hash_13881a5ef6463c90");
		wait(1);
	}
	else
	{
		wait(26.5);
		var_e23b0237 stoploopsound();
		var_e23b0237 playsound(#"hash_6af2fc9b90813082");
		wait(18.1);
		var_e23b0237 playsound(#"hash_13881a5ef6463c90");
		wait(1);
	}
	if(isdefined(var_e23b0237))
	{
		var_e23b0237 delete();
	}
}

/*
	Name: function_d24a0f09
	Namespace: namespace_159b5b5b
	Checksum: 0x23185496
	Offset: 0x1A90
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function function_d24a0f09(str_vo_line, var_e688ce8f = 0)
{
	n_duration = soundgetplaybacktime(str_vo_line);
	n_duration = float(n_duration) / 1000;
	n_duration = n_duration - var_e688ce8f;
	if(n_duration > 0)
	{
		wait(n_duration);
	}
}

/*
	Name: function_f0ed2a66
	Namespace: namespace_159b5b5b
	Checksum: 0x52CC99A1
	Offset: 0x1B18
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function function_f0ed2a66(v_pos)
{
	vol_stands = getent("stands_vol", "script_noteworthy");
	if(istouching(v_pos, vol_stands))
	{
		return 0;
	}
	return 1;
}

/*
	Name: cleanup_zombie
	Namespace: namespace_159b5b5b
	Checksum: 0x42F21F9B
	Offset: 0x1B78
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function cleanup_zombie()
{
	if(zm_utility::is_trials())
	{
		self zm_cleanup::function_23621259(0);
	}
	else
	{
		self zm_cleanup::function_23621259(1);
	}
	self zombie_utility::reset_attack_spot();
	self.var_c39323b5 = 1;
	self.var_e700d5e2 = 1;
	self.allowdeath = 1;
	self kill();
	waitframe(1);
	if(isdefined(self))
	{
		/#
			debugstar(self.origin, 1000, (1, 1, 1));
		#/
		self delete();
	}
}

/*
	Name: function_643916c9
	Namespace: namespace_159b5b5b
	Checksum: 0xAEA13BCC
	Offset: 0x1C68
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_643916c9()
{
	self endon(#"death");
	self.ignore_poi = [];
	while(true)
	{
		if(isdefined(level.zombie_poi_array) && level.zombie_poi_array.size)
		{
			self.ignore_poi = level.zombie_poi_array;
		}
		wait(0.1);
	}
}

