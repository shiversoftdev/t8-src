// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using script_27c22e1d8df4d852;
#using script_3b7405881c081f6;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_115c602a;

/*
	Name: function_89f2df9
	Namespace: namespace_115c602a
	Checksum: 0xC37884C3
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_348dc8e90e89ef9c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_115c602a
	Checksum: 0xC73FD716
	Offset: 0x170
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_a0e875894ebc5ff", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_115c602a
	Checksum: 0x1628AD88
	Offset: 0x1D8
	Size: 0x35C
	Parameters: 8
	Flags: Private
*/
private function function_d1de6a85(var_7720abf7, var_2d5ebf67, var_530e040f, zone1, zone2, zone3, zone4, zone5)
{
	callback::add_callback(#"hash_137b937fd26992be", &function_ff66b979);
	zones = array::remove_undefined(array(zone1, zone2, zone3, zone4, zone5), 0);
	level.var_c8b84806 = [];
	foreach(zone in zones)
	{
		level.var_c8b84806[zone] = 1;
	}
	self.var_df62490a = zm_utility::function_d7db256e(var_7720abf7, #"hash_28d5f57c2309090", 0);
	self.var_f7f308cd = var_7720abf7;
	self thread function_492f4c79();
	var_144cd915 = 0;
	foreach(str_zone in zones)
	{
		if(zm_zonemgr::zone_is_enabled(str_zone))
		{
			var_144cd915 = 1;
			break;
		}
	}
	if(var_144cd915)
	{
		self thread function_5a68cb9f();
	}
	foreach(player in getplayers())
	{
		player thread zone_watcher(self, var_2d5ebf67, var_530e040f);
		if(isdefined(level.var_b691023c))
		{
			player thread damage_watcher(level.var_b691023c);
		}
		else
		{
			player thread damage_watcher(1);
		}
		if(isbot(player))
		{
			player thread function_dae80de6();
		}
	}
	if(isdefined(level.var_adca35c8))
	{
		self [[level.var_adca35c8]]();
	}
}

/*
	Name: function_5a68cb9f
	Namespace: namespace_115c602a
	Checksum: 0x65AB54E2
	Offset: 0x540
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function function_5a68cb9f()
{
	level flag::clear("spawn_zombies");
	level.disable_nuke_delay_spawning = 1;
	level notify(#"disable_nuke_delay_spawning");
	level waittill(#"hash_7646638df88a3656", #"hash_715188521b564b16", #"end_game");
	level flag::set("spawn_zombies");
	level.disable_nuke_delay_spawning = undefined;
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_115c602a
	Checksum: 0x2997D0BA
	Offset: 0x5F0
	Size: 0x198
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	zm_utility::function_b1f3be5c(self.var_df62490a, self.var_f7f308cd);
	callback::remove_callback(#"hash_137b937fd26992be", &function_ff66b979);
	if(isdefined(level.var_a975ca2c))
	{
		self [[level.var_a975ca2c]]();
	}
	foreach(player in getplayers())
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
			player namespace_b22c99a5::stop_timer();
		}
		player clientfield::set_to_player("zm_zone_out_of_bounds", 0);
		player.var_e5cde66 = undefined;
		if(isbot(player))
		{
			player namespace_87f62ea8::function_33834a13();
		}
	}
}

/*
	Name: function_492f4c79
	Namespace: namespace_115c602a
	Checksum: 0x6CBA7FF6
	Offset: 0x790
	Size: 0x3C
	Parameters: 0
	Flags: Private
*/
private function function_492f4c79()
{
	level endon(#"hash_7646638df88a3656");
	wait(12);
	zm_utility::function_75fd65f9(self.var_f7f308cd, 1);
}

/*
	Name: start_timer
	Namespace: namespace_115c602a
	Checksum: 0xC208F400
	Offset: 0x7D8
	Size: 0xAC
	Parameters: 2
	Flags: Private
*/
private function start_timer(timeout, var_530e040f)
{
	if(!level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::open(self);
		level.var_f995ece6 zm_trial_timer::function_8ede8e82(self, var_530e040f);
		level.var_f995ece6 zm_trial_timer::function_6ad54036(self, 1);
		self namespace_b22c99a5::start_timer(timeout);
	}
}

/*
	Name: stop_timer
	Namespace: namespace_115c602a
	Checksum: 0x1C4A27E0
	Offset: 0x890
	Size: 0x5C
	Parameters: 0
	Flags: Private
*/
private function stop_timer()
{
	if(level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::close(self);
		self namespace_b22c99a5::stop_timer();
	}
}

/*
	Name: function_2191cc5d
	Namespace: namespace_115c602a
	Checksum: 0xFBFCE0E5
	Offset: 0x8F8
	Size: 0x68
	Parameters: 0
	Flags: Private
*/
private function function_2191cc5d()
{
	zone = self zm_zonemgr::get_player_zone();
	/#
		assert(isdefined(level.var_c8b84806));
	#/
	return isdefined(zone) && isdefined(level.var_c8b84806[zone]);
}

/*
	Name: function_1802ad1e
	Namespace: namespace_115c602a
	Checksum: 0x139520BA
	Offset: 0x968
	Size: 0x30E
	Parameters: 4
	Flags: Private
*/
private function function_1802ad1e(challenge, var_2d5ebf67, var_530e040f, timeout)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656", #"host_migration_begin");
	self.var_e5cde66 = {#hash_530e040f:var_530e040f, #hash_2d5ebf67:var_2d5ebf67, #challenge:challenge, #timeout:timeout, #start_time:level.time};
	self start_timer(timeout, var_2d5ebf67);
	var_2bf2b5dd = level.time + (timeout * 1000);
	while(true)
	{
		var_a5096cb5 = self function_2191cc5d();
		if(var_a5096cb5)
		{
			level notify(#"hash_715188521b564b16", {#player:self});
			self.var_4cb0b91f = 1;
			self.var_ccee13fc = 1;
			self stop_timer();
			self zm_utility::function_ba39d198(challenge.var_df62490a, 0);
			var_2bf2b5dd = level.time + 0;
		}
		else if(level.time > var_2bf2b5dd)
		{
			self stop_timer();
		}
		else if(!level.var_f995ece6 zm_trial_timer::is_open(self))
		{
			self start_timer(0, var_530e040f);
			self zm_utility::function_ba39d198(challenge.var_df62490a, 1);
		}
		if(isdefined(self.var_4cb0b91f) && self.var_4cb0b91f && !var_a5096cb5 && isalive(self) && !self laststand::player_is_in_laststand() && (!(isdefined(level.intermission) && level.intermission)))
		{
			self clientfield::set_to_player("zm_zone_out_of_bounds", 1);
			self.var_ccee13fc = undefined;
		}
		else
		{
			self clientfield::set_to_player("zm_zone_out_of_bounds", 0);
		}
		waitframe(1);
	}
}

/*
	Name: zone_watcher
	Namespace: namespace_115c602a
	Checksum: 0xB776D65
	Offset: 0xC80
	Size: 0x124
	Parameters: 3
	Flags: Private
*/
private function zone_watcher(challenge, var_2d5ebf67, var_530e040f)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	self.var_4cb0b91f = 0;
	self zm_utility::function_ba39d198(challenge.var_df62490a, 0);
	wait(12);
	self zm_utility::function_ba39d198(challenge.var_df62490a, 1);
	if(getgametypesetting("zmTrialsVariant") && level.round_number > 20)
	{
		var_d4862226 = 90;
	}
	else if(isdefined(level.var_b691023c))
	{
		var_d4862226 = 0;
	}
	else
	{
		var_d4862226 = 45;
	}
	self thread function_1802ad1e(challenge, var_2d5ebf67, var_530e040f, var_d4862226);
}

/*
	Name: damage_watcher
	Namespace: namespace_115c602a
	Checksum: 0x661304B9
	Offset: 0xDB0
	Size: 0x23E
	Parameters: 1
	Flags: Private
*/
private function damage_watcher(var_a4a28ac7)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656", #"host_migration_begin");
	if(isdefined(var_a4a28ac7) && var_a4a28ac7)
	{
		wait(12);
	}
	while(true)
	{
		/#
			if(isgodmode(self) || self isinmovemode("", ""))
			{
				waitframe(1);
				continue;
			}
		#/
		if(!self function_2191cc5d() && !level.var_f995ece6 zm_trial_timer::is_open(self) && self.sessionstate != "spectator" && !self laststand::player_is_in_laststand() && (!(isdefined(self.var_eb319d10) && self.var_eb319d10)) && (!(isdefined(level.intermission) && level.intermission)) && (!(isdefined(self.var_16735873) && self.var_16735873)))
		{
			var_16e6b8ea = self zm_utility::function_7618c8ef(0.0667);
			if(self.health <= var_16e6b8ea)
			{
				if(zm_utility::is_magic_bullet_shield_enabled(self))
				{
					self util::stop_magic_bullet_shield();
				}
				self dodamage(self.health + 1000, self.origin);
			}
			else
			{
				self dodamage(var_16e6b8ea, self.origin);
			}
		}
		wait(1);
	}
}

/*
	Name: function_ff66b979
	Namespace: namespace_115c602a
	Checksum: 0xDA6A4D2A
	Offset: 0xFF8
	Size: 0x248
	Parameters: 0
	Flags: Private
*/
private function function_ff66b979()
{
	level endon(#"end_of_round");
	foreach(player in getplayers())
	{
		if(!isdefined(player.var_e5cde66))
		{
			continue;
		}
		player stop_timer();
	}
	var_a0328dd5 = gettime();
	wait(5);
	foreach(player in getplayers())
	{
		if(!isdefined(player.var_e5cde66))
		{
			player thread damage_watcher(0);
			continue;
		}
		var_d1659cdf = var_a0328dd5 - player.var_e5cde66.start_time;
		timeout = int(max(player.var_e5cde66.timeout - (float(var_d1659cdf) / 1000), 0));
		player thread function_1802ad1e(player.var_e5cde66.challenge, player.var_e5cde66.var_2d5ebf67, player.var_e5cde66.var_530e040f, timeout);
		player thread damage_watcher(0);
	}
}

/*
	Name: function_dae80de6
	Namespace: namespace_115c602a
	Checksum: 0xB397D0C5
	Offset: 0x1248
	Size: 0x368
	Parameters: 0
	Flags: Private
*/
private function function_dae80de6()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	wait(5);
	s_challenge = zm_trial::function_a36e8c38(#"hash_a0e875894ebc5ff");
	s_defend_area = struct::get(s_challenge.var_f7f308cd);
	s_result = positionquery_source_navigation(s_defend_area.origin, 64, 1500, 100, 32);
	a_str_zones = getarraykeys(level.var_c8b84806);
	zm_zonemgr::function_8caa21df(a_str_zones);
	var_3dbf02b9 = [];
	s_result.data = array::randomize(s_result.data);
	foreach(var_c310df8c in s_result.data)
	{
		foreach(str_zone in a_str_zones)
		{
			if(zm_zonemgr::function_adc70eee(var_c310df8c.origin, str_zone))
			{
				if(!isdefined(var_3dbf02b9))
				{
					var_3dbf02b9 = [];
				}
				else if(!isarray(var_3dbf02b9))
				{
					var_3dbf02b9 = array(var_3dbf02b9);
				}
				var_3dbf02b9[var_3dbf02b9.size] = var_c310df8c.origin;
			}
		}
		if(var_3dbf02b9.size >= 10)
		{
			break;
		}
	}
	while(var_3dbf02b9.size)
	{
		if(!function_e1378d07())
		{
			self namespace_87f62ea8::function_33834a13();
			wait(1);
			continue;
		}
		v_position = array::random(var_3dbf02b9);
		self namespace_87f62ea8::function_23cbc6c1(v_position, 1);
		self waittill_timeout(10, #"goal");
		if(!function_e1378d07())
		{
			self namespace_87f62ea8::function_33834a13();
		}
		wait(randomintrange(5, 10));
	}
}

/*
	Name: function_e1378d07
	Namespace: namespace_115c602a
	Checksum: 0x981FB889
	Offset: 0x15B8
	Size: 0xBE
	Parameters: 0
	Flags: Private
*/
private function function_e1378d07()
{
	foreach(player in getplayers())
	{
		if(isalive(player) && !isbot(player) && !player laststand::player_is_in_laststand())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: is_active
	Namespace: namespace_115c602a
	Checksum: 0xAB0E0DDF
	Offset: 0x1680
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_a0e875894ebc5ff");
	return isdefined(s_challenge);
}

