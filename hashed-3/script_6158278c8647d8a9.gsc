// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_b20b4885;

/*
	Name: function_89f2df9
	Namespace: namespace_b20b4885
	Checksum: 0xEAC506B6
	Offset: 0x138
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_76b4661cdc0efae0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b20b4885
	Checksum: 0x50E74CE4
	Offset: 0x180
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
	level.var_a4527012 = [];
	level.var_ce8d80ba = [];
	function_e9e03d6f(#"default", &function_51cc7d9a);
	function_e9e03d6f(#"in_combat", &function_567289f);
	function_e9e03d6f(#"hash_156be21f04d01350", &function_d2161ccd);
	function_e9e03d6f(#"hash_c0bcf7fa0d58e5", &function_b94f5770);
	function_e9e03d6f(#"revive_player", &function_8adaa75f);
	function_e9e03d6f(#"hash_d6dff7ae81e65db", &function_daab6847);
	function_e9e03d6f(#"hash_797d652ff338b7d4", &function_90ff35fc);
	function_e9e03d6f(#"visible_enemy", &function_a0da5bb);
	function_e9e03d6f(#"hash_608fe62234892b49", &function_7ed3ada6);
	function_aa8c6854(#"goal", &get_goal_center);
	function_aa8c6854(#"hash_d6dff7ae81e65db", &function_4fa26afe);
	function_aa8c6854(#"revive_target", &function_f94e1790);
	function_aa8c6854(#"self", &function_eeca1b53);
	if(!isdefined(level.var_d1a4558d))
	{
		level.var_d1a4558d = new throttle();
		[[ level.var_d1a4558d ]]->initialize(1, float(function_60d95f53()) / 1000);
	}
}

/*
	Name: on_player_spawned
	Namespace: namespace_b20b4885
	Checksum: 0x90622EE9
	Offset: 0x4A8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(!isbot(self))
	{
		return;
	}
	self reset();
	self set_position(self.origin);
}

/*
	Name: start
	Namespace: namespace_b20b4885
	Checksum: 0x5A6937E6
	Offset: 0x508
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function start()
{
	self thread function_66667f8e();
	self thread handle_goal_changed();
	self thread handle_path_success();
	self thread handle_path_failed();
	self thread function_2bcdf566();
	self thread function_ba7966f8();
	self.bot.var_87f1dd0b = undefined;
	self.bot.var_211ab18e = 1;
}

/*
	Name: stop
	Namespace: namespace_b20b4885
	Checksum: 0xBD27FFB4
	Offset: 0x5C8
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function stop()
{
	self notify(#"hash_6cefc75b9a427c7d");
	self function_e027100a();
	if(isdefined(self.bot))
	{
		self.bot.var_211ab18e = 0;
	}
}

/*
	Name: reset
	Namespace: namespace_b20b4885
	Checksum: 0x4F6EE663
	Offset: 0x620
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function reset()
{
	self.bot.var_18fa994c = 0;
	self function_e027100a();
}

/*
	Name: update
	Namespace: namespace_b20b4885
	Checksum: 0x61336DC
	Offset: 0x658
	Size: 0x2C2
	Parameters: 1
	Flags: Linked
*/
function update(tacbundle)
{
	if(!(isdefined(self.bot.var_211ab18e) && self.bot.var_211ab18e))
	{
		return;
	}
	if(!self.goalforced && self function_2ea7762a(tacbundle))
	{
		self.attackeraccuracy = 1;
		self set_position(self.origin);
		self function_e027100a();
		return;
	}
	if(self.bot.var_18fa994c > gettime())
	{
		return;
	}
	/#
		self bot::record_text("", (0, 1, 1), "");
	#/
	self.attackeraccuracy = 1;
	if(self.goalforced)
	{
		/#
			self bot::record_text("", (1, 1, 1), "");
		#/
		if(isdefined(self.node))
		{
			var_8e2d9611 = self function_f29e63ea(self.node);
			if(isdefined(var_8e2d9611))
			{
				/#
					self bot::record_text("", (0, 1, 1), "");
				#/
				self function_a57c34b7(var_8e2d9611);
			}
		}
		else
		{
			self function_d4c687c9();
		}
		self function_e027100a();
	}
	else
	{
		if([[ level.var_d1a4558d ]]->wm_ht_posidlestart(self))
		{
			return;
		}
		self function_7beea81f(tacbundle);
	}
	if(isdefined(self.bot.var_2ee077ff))
	{
		self.bot.var_18fa994c = self.bot.var_2ee077ff;
		self.bot.var_2ee077ff = undefined;
	}
	else
	{
		self.bot.var_18fa994c = bot::function_7aeb27f1(self.bot.tacbundle.var_1f8a6a2, self.bot.tacbundle.var_2fc77943);
	}
}

/*
	Name: function_e027100a
	Namespace: namespace_b20b4885
	Checksum: 0xDA8AAA6E
	Offset: 0x928
	Size: 0x2C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e027100a()
{
	self notify(#"hash_2747b8ce1136a8ae");
	[[ level.var_d1a4558d ]]->function_5ef47bb4(self);
}

/*
	Name: function_66667f8e
	Namespace: namespace_b20b4885
	Checksum: 0x843EB9CE
	Offset: 0x960
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_66667f8e()
{
	self endon(#"death", #"hash_6cefc75b9a427c7d");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		self waittill(#"goal");
		/#
			self bot::record_text("", (0, 1, 1), "");
		#/
		waitframe(1);
	}
}

/*
	Name: handle_goal_changed
	Namespace: namespace_b20b4885
	Checksum: 0x101378F6
	Offset: 0xA00
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function handle_goal_changed()
{
	self endon(#"death", #"hash_6cefc75b9a427c7d");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		self waittill(#"goal_changed");
		var_1f2328d0 = self function_4794d6a3();
		if(self.goalforced)
		{
			self usecovernode(var_1f2328d0.node);
		}
		else if(!var_1f2328d0.isatgoal)
		{
			self usecovernode(undefined);
		}
		if(!self isingoal(self.origin))
		{
			self reset();
		}
		waitframe(1);
	}
}

/*
	Name: handle_path_success
	Namespace: namespace_b20b4885
	Checksum: 0x11DF3B24
	Offset: 0xB18
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function handle_path_success()
{
	self endon(#"death", #"hash_6cefc75b9a427c7d");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		params = undefined;
		params = self waittill(#"bot_path_success");
		self bot_action::reset();
		waitframe(1);
	}
}

/*
	Name: handle_path_failed
	Namespace: namespace_b20b4885
	Checksum: 0x6D703A77
	Offset: 0xBB0
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function handle_path_failed()
{
	self endon(#"death", #"hash_6cefc75b9a427c7d");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		params = undefined;
		params = self waittill(#"bot_path_failed");
		switch(params.reason)
		{
			case 1:
			case 2:
			case 3:
			{
				self function_6ee03a5f(params.count);
				break;
			}
			case 4:
			case 5:
			case 6:
			{
				break;
			}
			case 7:
			case 8:
			{
				break;
			}
			default:
			{
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_6ee03a5f
	Namespace: namespace_b20b4885
	Checksum: 0xA293BC72
	Offset: 0xD08
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_6ee03a5f(failurecount)
{
	startpos = self.origin;
	if(self function_96f55844())
	{
		/#
			self botprintwarning((("" + startpos) + "") + self.origin);
		#/
	}
	else
	{
		/#
			self botprinterror("" + startpos);
		#/
	}
}

/*
	Name: function_96f55844
	Namespace: namespace_b20b4885
	Checksum: 0x5F116451
	Offset: 0xDA8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_96f55844()
{
	radius = self getpathfindingradius();
	navmeshpoint = getclosestpointonnavmesh(self.origin, 64, radius);
	if(isdefined(navmeshpoint))
	{
		self setorigin(navmeshpoint);
		return true;
	}
	return false;
}

/*
	Name: function_e336d9
	Namespace: namespace_b20b4885
	Checksum: 0x7F4F6C4B
	Offset: 0xE28
	Size: 0x104
	Parameters: 0
	Flags: None
*/
function function_e336d9()
{
	results = positionquery_source_navigation(self.origin, 0, 100, 100, 12, self);
	if(isdefined(results) && results.data.size > 0)
	{
		pos = results.data[randomint(results.data.size)];
		radius = self getpathfindingradius();
		navmeshpoint = getclosestpointonnavmesh(pos.origin, 64, radius);
		if(isdefined(navmeshpoint))
		{
			self setorigin(navmeshpoint);
			return true;
		}
	}
	return false;
}

/*
	Name: function_6afa53fe
	Namespace: namespace_b20b4885
	Checksum: 0xD43414A8
	Offset: 0xF38
	Size: 0x1BC
	Parameters: 0
	Flags: None
*/
function function_6afa53fe()
{
	players = [];
	foreach(player in getplayers())
	{
		if(isbot(player))
		{
			continue;
		}
		if(isalive(player) && !player cansee(self) && isdefined(player.sessionstate) && player.sessionstate == "playing" && !player isinvehicle() && self.team == player.team)
		{
			players[players.size] = player;
		}
	}
	if(players.size <= 0)
	{
		return;
	}
	player = players[randomint(players.size)];
	var_28054200 = self function_28d02a32(player, 250, 500);
	if(isdefined(var_28054200))
	{
		self setorigin(var_28054200);
		return true;
	}
	return false;
}

/*
	Name: can_teleport
	Namespace: namespace_b20b4885
	Checksum: 0x7CF7ED3
	Offset: 0x1100
	Size: 0x122
	Parameters: 0
	Flags: None
*/
function can_teleport()
{
	foreach(player in getplayers())
	{
		if(isbot(player))
		{
			continue;
		}
		fwd = anglestoforward(player.angles);
		if(self.team == player.team && (vectordot(fwd, self.origin - player.origin)) > 0)
		{
			return false;
		}
		if(player cansee(self))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_2bcdf566
	Namespace: namespace_b20b4885
	Checksum: 0x1C4A4F77
	Offset: 0x1230
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_2bcdf566()
{
	self endon(#"death", #"hash_6cefc75b9a427c7d");
	level endon(#"game_ended");
	while(isdefined(self.bot))
	{
		params = undefined;
		params = self waittill(#"hash_70bb20cec150f744");
		if(isdefined(params.projectile) && util::function_fbce7263(params.projectile.team, self.team))
		{
			self reset();
		}
		waitframe(1);
	}
}

/*
	Name: function_ba7966f8
	Namespace: namespace_b20b4885
	Checksum: 0xDD13A169
	Offset: 0x1308
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_ba7966f8()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(currentsessionmode() != 0)
	{
		return;
	}
	while(isdefined(self.bot))
	{
		currentweapon = self getcurrentweapon();
		if(isdefined(currentweapon) && currentweapon.name != "none")
		{
			var_4cdb8c05 = currentweapon;
			ammo = self getammocount(currentweapon);
			if(ammo <= 0)
			{
				wait(randomintrange(4, 5));
				currentweapon = self getcurrentweapon();
				if(currentweapon == var_4cdb8c05)
				{
					ammo = self getammocount(currentweapon);
					if(ammo <= 0)
					{
						self givemaxammo(currentweapon);
					}
				}
			}
		}
		wait(randomintrange(2, 4));
	}
}

/*
	Name: function_e9e03d6f
	Namespace: namespace_b20b4885
	Checksum: 0xB3C72C19
	Offset: 0x1480
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_e9e03d6f(name, func)
{
	level.var_a4527012[name] = func;
}

/*
	Name: function_aa8c6854
	Namespace: namespace_b20b4885
	Checksum: 0x69B2704D
	Offset: 0x14B8
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function function_aa8c6854(name, func)
{
	level.var_ce8d80ba[name] = func;
}

/*
	Name: function_7beea81f
	Namespace: namespace_b20b4885
	Checksum: 0x9966E0A1
	Offset: 0x14F0
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function function_7beea81f(tacbundle)
{
	self endoncallback(&function_7f65a721, #"death", #"hash_2747b8ce1136a8ae");
	if(!isdefined(tacbundle.var_dd394d4e))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return;
	}
	handled = 0;
	foreach(params in tacbundle.var_dd394d4e)
	{
		if(isdefined(self function_22d4d2d(params, tacbundle)) && self function_22d4d2d(params, tacbundle))
		{
			self.bot.var_87f1dd0b = params.name;
			handled = 1;
			break;
		}
	}
}

/*
	Name: function_22d4d2d
	Namespace: namespace_b20b4885
	Checksum: 0x1406216F
	Offset: 0x1650
	Size: 0xD6
	Parameters: 2
	Flags: Linked
*/
function function_22d4d2d(params, tacbundle)
{
	if(!isdefined(params))
	{
		return 0;
	}
	func = level.var_a4527012[params.name];
	if(!isdefined(func))
	{
		/#
			self botprinterror("" + params.name);
		#/
		return 0;
	}
	/#
		self bot::record_text(function_9e72a96(params.name), (1, 1, 1), "");
	#/
	handled = self [[func]](params, tacbundle);
	return handled;
}

/*
	Name: function_795a469
	Namespace: namespace_b20b4885
	Checksum: 0x1AC4835B
	Offset: 0x1730
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_795a469(name)
{
	func = level.var_ce8d80ba[name];
	if(!isdefined(func))
	{
		/#
			self botprinterror("" + function_9e72a96(name));
		#/
		return undefined;
	}
	return self [[func]]();
}

/*
	Name: function_7f65a721
	Namespace: namespace_b20b4885
	Checksum: 0x3665EB0F
	Offset: 0x17B0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_7f65a721(notifyhash)
{
	[[ level.var_d1a4558d ]]->function_5ef47bb4(self);
}

/*
	Name: function_51cc7d9a
	Namespace: namespace_b20b4885
	Checksum: 0xAA6E2A9E
	Offset: 0x17E0
	Size: 0x2B0
	Parameters: 2
	Flags: Linked
*/
function function_51cc7d9a(params, tacbundle)
{
	center = self function_795a469(params.center);
	if(!isdefined(center))
	{
		/#
			self bot::record_text("" + function_9e72a96(params.center), (1, 0, 0), "");
		#/
		return 0;
	}
	if(isint(center))
	{
		/#
			self bot::record_text("" + center, (0, 1, 1), "");
		#/
		if(self function_ad687b7f(center))
		{
			return 1;
		}
		return function_d0cf287b(params, tacbundle);
	}
	if(isentity(center) && center getentitytype() == 20)
	{
		return function_356f5b61(center);
	}
	query = positionquery_source_navigation(center.origin, 0, center.radius, center.halfheight, 12, self);
	position = undefined;
	if(query.data.size <= 0)
	{
		if(query.centeronnav)
		{
			position = center.origin;
		}
		else
		{
			/#
				self bot::record_text("" + function_9e72a96(params.center), (1, 0, 0), "");
				self botprinterror((function_9e72a96(params.name) + "") + params.center);
			#/
			return 0;
		}
	}
	else
	{
		position = query.data[0].origin;
	}
	self set_position(position);
	return 1;
}

/*
	Name: function_8adaa75f
	Namespace: namespace_b20b4885
	Checksum: 0x95D04E56
	Offset: 0x1A98
	Size: 0x1B2
	Parameters: 2
	Flags: Linked
*/
function function_8adaa75f(params, tacbundle)
{
	if(!self ai::get_behavior_attribute("revive"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return 0;
	}
	revivetarget = self bot::get_revive_target();
	if(!isdefined(revivetarget))
	{
		return 0;
	}
	if(!isdefined(revivetarget.revivetrigger))
	{
		self bot::clear_revive_target();
		return 0;
	}
	handled = 1;
	minradius = 30;
	if(distance2dsquared(self.origin, revivetarget.revivetrigger.origin) > (minradius * minradius) && self istouching(revivetarget.revivetrigger))
	{
		self set_position(self.origin);
		handled = 1;
	}
	else if(self function_b2dbe6b0(revivetarget.revivetrigger, minradius))
	{
		handled = 1;
	}
	if(handled)
	{
		self.attackeraccuracy = 0.01;
	}
	return handled;
}

/*
	Name: function_90ff35fc
	Namespace: namespace_b20b4885
	Checksum: 0x991E248C
	Offset: 0x1C58
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function function_90ff35fc(params, tacbundle)
{
	if(!self bot::function_dd750ead())
	{
		return 0;
	}
	gameobject = self bot::function_f47bf51d();
	vehicle = gameobject.e_object;
	if(!isdefined(vehicle) || !isvehicle(vehicle))
	{
		return 0;
	}
	trigger = gameobject.trigger;
	if(!isdefined(trigger))
	{
		return 0;
	}
	if(self istouching(trigger))
	{
		self set_position(self.origin);
		return 1;
	}
	return self function_b2dbe6b0(trigger);
}

/*
	Name: function_a0da5bb
	Namespace: namespace_b20b4885
	Checksum: 0x2BA71007
	Offset: 0x1D70
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_a0da5bb(params, tacbundle)
{
	if(!self bot::has_visible_enemy())
	{
		return 0;
	}
	return function_d0cf287b(params, tacbundle);
}

/*
	Name: function_567289f
	Namespace: namespace_b20b4885
	Checksum: 0xDB4A2431
	Offset: 0x1DC8
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_567289f(params, tacbundle)
{
	if(!self bot::in_combat())
	{
		return 0;
	}
	return function_d0cf287b(params, tacbundle);
}

/*
	Name: function_d2161ccd
	Namespace: namespace_b20b4885
	Checksum: 0x20F9C55
	Offset: 0x1E20
	Size: 0xAA
	Parameters: 2
	Flags: Linked
*/
function function_d2161ccd(params, tacbundle)
{
	var_1f2328d0 = self function_4794d6a3();
	if(!isplayer(var_1f2328d0.goalentity))
	{
		return 0;
	}
	if(distancesquared(self.origin, var_1f2328d0.goalentity.origin) < 2048 * 2048)
	{
		return 0;
	}
	return function_d0cf287b(params, tacbundle);
}

/*
	Name: function_b94f5770
	Namespace: namespace_b20b4885
	Checksum: 0x9F87E5
	Offset: 0x1ED8
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_b94f5770(params, tacbundle)
{
	if(self bot::in_combat())
	{
		return 0;
	}
	return function_d0cf287b(params, tacbundle);
}

/*
	Name: function_7ed3ada6
	Namespace: namespace_b20b4885
	Checksum: 0x3167EE8C
	Offset: 0x1F30
	Size: 0x1B8
	Parameters: 2
	Flags: Linked
*/
function function_7ed3ada6(params, tacbundle)
{
	var_4db4630 = (isdefined(self.enemy) ? self.enemy.origin : self.likelyenemyposition);
	nodes = function_74251581(self.goalpos, self.goalradius, self.goalheight, self.team, var_4db4630);
	/#
		if(self bot::should_record(""))
		{
			recordsphere(var_4db4630, 8, (0, 1, 1), "", self);
			foreach(node in nodes)
			{
				function_af72dbc5(node.origin, vectorscale((-1, -1, 0), 16), vectorscale((1, 1, 1), 16), node.angles[0], (0, 1, 1), "", self);
			}
		}
	#/
	if(nodes.size <= 0)
	{
		return false;
	}
	self function_a57c34b7(nodes[0]);
	return true;
}

/*
	Name: function_daab6847
	Namespace: namespace_b20b4885
	Checksum: 0xDF137D4F
	Offset: 0x20F0
	Size: 0xCA
	Parameters: 2
	Flags: Linked
*/
function function_daab6847(params, tacbundle)
{
	if(!self bot::function_dd750ead())
	{
		return 0;
	}
	gameobject = self bot::function_f47bf51d();
	trigger = gameobject.trigger;
	if(!isdefined(trigger))
	{
		return 0;
	}
	if(self istouching(trigger))
	{
		self set_position(self.origin);
		return 1;
	}
	return self function_b2dbe6b0(trigger);
}

/*
	Name: function_356f5b61
	Namespace: namespace_b20b4885
	Checksum: 0x80733CA9
	Offset: 0x21C8
	Size: 0x460
	Parameters: 1
	Flags: Linked
*/
function function_356f5b61(trigger)
{
	if(!isdefined(trigger))
	{
		return 0;
	}
	if(!isdefined(trigger.tacpoints))
	{
		trigger.tacpoints = tacticalquery("stratcom_tacquery_trigger_all", trigger);
		var_c36ae55a = function_ad6356f5(trigger.origin);
		if(isdefined(var_c36ae55a))
		{
			var_3ffc9821 = array(var_c36ae55a);
			neighbors = function_9086d9a4(var_c36ae55a);
			foreach(point in neighbors)
			{
				if(!isdefined(var_3ffc9821))
				{
					var_3ffc9821 = [];
				}
				else if(!isarray(var_3ffc9821))
				{
					var_3ffc9821 = array(var_3ffc9821);
				}
				var_3ffc9821[var_3ffc9821.size] = point;
			}
			var_55704eac = [];
			foreach(point in var_3ffc9821)
			{
				if(!array::contains(trigger.tacpoints, point))
				{
					if(!isdefined(var_55704eac))
					{
						var_55704eac = [];
					}
					else if(!isarray(var_55704eac))
					{
						var_55704eac = array(var_55704eac);
					}
					var_55704eac[var_55704eac.size] = point;
				}
			}
			foreach(point in var_55704eac)
			{
				if(trigger istouching(point.origin + vectorscale((0, 0, 1), 50)))
				{
					if(!isdefined(trigger.tacpoints))
					{
						trigger.tacpoints = [];
					}
					else if(!isarray(trigger.tacpoints))
					{
						trigger.tacpoints = array(trigger.tacpoints);
					}
					trigger.tacpoints[trigger.tacpoints.size] = point;
				}
			}
		}
	}
	if(!isdefined(trigger.tacpoints) || trigger.tacpoints.size == 0)
	{
		return self function_b2dbe6b0(trigger);
	}
	var_f34dd95d = !isdefined(self.var_7aaea35d) || (gettime() - self.var_7aaea35d) > 3000;
	if(!self istouching(trigger))
	{
		var_f34dd95d = 1;
	}
	if(var_f34dd95d)
	{
		self.var_7aaea35d = gettime();
		if(isdefined(trigger.tacpoints) && trigger.tacpoints.size > 0)
		{
			var_bd62801f = array::random(trigger.tacpoints);
			self set_position(var_bd62801f.origin);
		}
	}
	return 1;
}

/*
	Name: function_ad687b7f
	Namespace: namespace_b20b4885
	Checksum: 0xD912CDC9
	Offset: 0x2630
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function function_ad687b7f(region)
{
	if(!isdefined(region))
	{
		return false;
	}
	var_8cc7a4e = function_b507a336(region);
	if(!isdefined(var_8cc7a4e))
	{
		return false;
	}
	tacpoints = tacticalquery("stratcom_tacquery_region", region);
	if(!isdefined(tacpoints) || tacpoints.size == 0)
	{
		return false;
	}
	var_f34dd95d = !isdefined(self.var_d494450c) || (gettime() - self.var_d494450c) > 3000;
	if(var_f34dd95d)
	{
		self.var_d494450c = gettime();
		if(isdefined(tacpoints) && tacpoints.size > 0)
		{
			var_bd62801f = array::random(tacpoints);
			self set_position(var_bd62801f.origin);
		}
	}
	return true;
}

/*
	Name: get_goal_center
	Namespace: namespace_b20b4885
	Checksum: 0x5860D6DC
	Offset: 0x2750
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function get_goal_center()
{
	info = self function_4794d6a3();
	if(isdefined(info.goalvolume))
	{
		return info.goalvolume;
	}
	if(isdefined(info.var_151c9dda))
	{
		return info.var_151c9dda;
	}
	return ai::t_cylinder(info.goalpos, info.goalradius, info.goalheight);
}

/*
	Name: function_4fa26afe
	Namespace: namespace_b20b4885
	Checksum: 0x13BE47E5
	Offset: 0x27F0
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_4fa26afe()
{
	if(!self bot::function_dd750ead())
	{
		return undefined;
	}
	return bot::function_f47bf51d().trigger;
}

/*
	Name: function_f94e1790
	Namespace: namespace_b20b4885
	Checksum: 0xB062DC9D
	Offset: 0x2838
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_f94e1790()
{
	revivetarget = self bot::get_revive_target();
	if(!isdefined(revivetarget) || !isdefined(revivetarget.revivetrigger))
	{
		return undefined;
	}
	return revivetarget.revivetrigger;
}

/*
	Name: function_eeca1b53
	Namespace: namespace_b20b4885
	Checksum: 0x3EB6E74F
	Offset: 0x2898
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_eeca1b53()
{
	return self;
}

/*
	Name: function_b2dbe6b0
	Namespace: namespace_b20b4885
	Checksum: 0x207BFB43
	Offset: 0x28A8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function function_b2dbe6b0(trigger, minradius = 0)
{
	triggerradius = min(trigger.maxs[0], trigger.maxs[1]);
	results = positionquery_source_navigation(trigger.origin, minradius, triggerradius, trigger.maxs[2], 12, self);
	if(isdefined(results) && results.data.size > 0)
	{
		/#
			if(self bot::should_record(""))
			{
				foreach(pos in results.data)
				{
					recordstar(pos.origin, (0, 1, 1), "", self);
				}
			}
		#/
		self set_position(results.data[0].origin);
		return true;
	}
	return false;
}

/*
	Name: function_d0cf287b
	Namespace: namespace_b20b4885
	Checksum: 0x96E270C7
	Offset: 0x2A68
	Size: 0x260
	Parameters: 2
	Flags: Linked
*/
function function_d0cf287b(params, tacbundle)
{
	center = self function_795a469(params.center);
	if(!isdefined(center))
	{
		/#
			self bot::record_text("" + function_9e72a96(params.center), (1, 0, 0), "");
		#/
		return false;
	}
	if(isint(center))
	{
		/#
			self bot::record_text("" + center, (0, 1, 1), "");
		#/
	}
	enemy = self.likelyenemyposition;
	if(self bot::in_combat())
	{
		enemy = self.enemy;
	}
	position = function_b33e4e67(center, self.origin, enemy, params.var_470022ca);
	if(!isdefined(position))
	{
		/#
			self bot::record_text("" + function_9e72a96(params.center), (1, 0, 0), "");
			self botprinterror((function_9e72a96(params.name) + "") + params.center);
		#/
		return false;
	}
	var_fa686307 = undefined;
	if(ispathnode(position))
	{
		var_8e2d9611 = function_f29e63ea(position);
		if(isdefined(var_8e2d9611))
		{
			var_fa686307 = position;
			position = var_8e2d9611;
		}
	}
	self set_position(position, var_fa686307);
	return true;
}

/*
	Name: function_b33e4e67
	Namespace: namespace_b20b4885
	Checksum: 0xF2C0F343
	Offset: 0x2CD0
	Size: 0x8F6
	Parameters: 4
	Flags: Linked
*/
function function_b33e4e67(center, fillpos, enemy, var_470022ca)
{
	centerpos = self function_de626503(center);
	var_65c3e15e = undefined;
	/#
		if(self bot::should_record(""))
		{
			if(isstruct(center) && isdefined(center.origin) && isdefined(center.radius) && isdefined(center.halfheight))
			{
				recordcircle(center.origin - (0, 0, center.halfheight), center.radius, (0, 1, 1), "", self);
				recordcircle(center.origin + (0, 0, center.halfheight), center.radius, (0, 1, 1), "", self);
				recordline(center.origin - (0, 0, center.halfheight), center.origin + (0, 0, center.halfheight), (0, 1, 1), "", self);
			}
			else
			{
				if(isstruct(center) && center.type == 2)
				{
					function_af72dbc5(center.center, center.halfsize * -1, center.halfsize, center.angles[0], (0, 1, 1), "", self);
				}
				else if(isentity(center))
				{
					maxs = center getmaxs();
					mins = center getmins();
					if(issubstr(center.classname, ""))
					{
						radius = max(maxs[0], maxs[1]);
						top = center.origin + (0, 0, maxs[2]);
						bottom = center.origin + (0, 0, mins[2]);
						recordcircle(bottom, radius, (0, 1, 1), "", self);
						recordcircle(top, radius, (0, 1, 1), "", self);
						recordline(bottom, top, (0, 1, 1), "", self);
					}
					else
					{
						function_af72dbc5(center.origin, mins, maxs, center.angles[0], (0, 1, 1), "", self);
					}
				}
			}
			if(isdefined(enemy))
			{
				enemypos = (isentity(enemy) ? enemy.origin : enemy);
				recordline(centerpos, enemypos, (1, 0, 0), "", self);
				recordstar(enemypos, (1, 0, 0), "", self);
			}
		}
	#/
	forward = anglestoforward(self.angles);
	forwardpos = self.origin + (forward * 100);
	lastenemypos = (isentity(enemy) ? enemy.origin : enemy);
	foreach(query in var_470022ca)
	{
		[[ level.var_d1a4558d ]]->waitinqueue(self);
		/#
			self bot::record_text("" + function_9e72a96(query.name), (1, 1, 1), "");
		#/
		if(!isdefined(enemy) || function_3132f113(enemy))
		{
			enemy = lastenemypos;
		}
		else if(isentity(enemy))
		{
			lastenemypos = enemy.origin;
		}
		pixbeginevent(#"bot_get_tactical_position");
		aiprofile_beginentry("bot_get_tactical_position");
		tacpoints = tacticalquery(query.name, center, fillpos, centerpos, enemy, self, forward, forwardpos);
		pixendevent();
		aiprofile_endentry();
		if(tacpoints.size <= 0)
		{
			/#
				self bot::record_text("", (1, 0, 0), "");
			#/
			continue;
		}
		/#
			self bot::record_text(("" + tacpoints.size) + "", (0, 1, 1), "");
			if(self bot::should_record(""))
			{
				foreach(point in tacpoints)
				{
					recordcircle(point.origin, 15, (0, 1, 1), "", self);
				}
			}
		#/
		var_65c3e15e = tacpoints[0];
		break;
	}
	if(!isdefined(var_65c3e15e))
	{
		return undefined;
	}
	if(isdefined(var_65c3e15e.node))
	{
		distsq = distance2dsquared(var_65c3e15e.origin, var_65c3e15e.node.origin);
		if(distsq > 900)
		{
			/#
				self botprinterror(("" + sqrt(distsq)) + "");
			#/
			return var_65c3e15e.origin;
		}
		return var_65c3e15e.node;
	}
	return var_65c3e15e.origin;
}

/*
	Name: function_f29e63ea
	Namespace: namespace_b20b4885
	Checksum: 0xEFFBAAFD
	Offset: 0x35D0
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function function_f29e63ea(node)
{
	if(!function_9ccb67a3(node))
	{
		return undefined;
	}
	var_208965cf = node.spawnflags & 262144;
	var_a26a51ba = node.spawnflags & 524288;
	if(!var_208965cf && !var_a26a51ba)
	{
		return undefined;
	}
	var_831c15e5 = anglestoright(node.angles);
	offsetdir = var_831c15e5;
	if(var_208965cf && var_a26a51ba)
	{
		if(isdefined(self.enemylastseenpos))
		{
			if(vectordot(var_831c15e5, self.enemylastseenpos - self.origin) < 0)
			{
				offsetdir = (0, 0, 0) - offsetdir;
			}
		}
		else if(randomint(2) > 0)
		{
			offsetdir = (0, 0, 0) - offsetdir;
		}
	}
	else if(var_208965cf)
	{
		offsetdir = (0, 0, 0) - offsetdir;
	}
	return checknavmeshdirection(node.origin, offsetdir, 18, 0);
}

/*
	Name: function_2ea7762a
	Namespace: namespace_b20b4885
	Checksum: 0x7E429649
	Offset: 0x3760
	Size: 0x238
	Parameters: 1
	Flags: Linked
*/
function function_2ea7762a(tacbundle)
{
	/#
		self bot::record_text("", (0, 1, 1), "");
	#/
	if(!isdefined(tacbundle.pathenemyfightdist) || tacbundle.pathenemyfightdist <= 0)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return false;
	}
	if(self ai::get_behavior_attribute("ignorepathenemyfightdist"))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return false;
	}
	if(!isdefined(self.enemy))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return false;
	}
	if(!self cansee(self.enemy))
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return false;
	}
	distsq = tacbundle.pathenemyfightdist * tacbundle.pathenemyfightdist;
	if(distance2dsquared(self.origin, self.enemy.origin) > distsq)
	{
		/#
			self bot::record_text("", (1, 0, 0), "");
		#/
		return false;
	}
	/#
		self bot::record_text("", (0, 1, 1), "");
	#/
	return true;
}

/*
	Name: set_position
	Namespace: namespace_b20b4885
	Checksum: 0xFF2775D
	Offset: 0x39A0
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function set_position(position, var_fa686307 = undefined)
{
	radius = self getpathfindingradius();
	if(ispathnode(position))
	{
		if(!ispointonnavmesh(position.origin, radius))
		{
			position = position.origin;
		}
	}
	if(isvec(position))
	{
		self usecovernode(var_fa686307);
		navmeshpoint = getclosestpointonnavmesh(position, 64, radius);
		if(isdefined(navmeshpoint))
		{
			self function_a57c34b7(navmeshpoint);
			return;
		}
		/#
			self botprinterror("" + position);
		#/
	}
	self function_a57c34b7(position);
}

/*
	Name: function_de626503
	Namespace: namespace_b20b4885
	Checksum: 0xD9676182
	Offset: 0x3AE8
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function function_de626503(center)
{
	if(isvec(center))
	{
		return center;
	}
	if(isentity(center))
	{
		return center.origin;
	}
	if(isstruct(center) && isdefined(center.origin))
	{
		return center.origin;
	}
	if(isstruct(center) && isdefined(center.center))
	{
		return center.center;
	}
	if(isint(center))
	{
		return self.goalpos;
	}
	return undefined;
}

/*
	Name: function_52aa1fd5
	Namespace: namespace_b20b4885
	Checksum: 0x9AA48CC0
	Offset: 0x3BE0
	Size: 0xE0
	Parameters: 2
	Flags: None
*/
function function_52aa1fd5(center, var_f181b86b)
{
	if(!isdefined(var_f181b86b))
	{
		return undefined;
	}
	tacpoints = tacticalquery(var_f181b86b, center);
	if(tacpoints.size == 0)
	{
		return undefined;
	}
	seeds = [];
	foreach(tacpoint in tacpoints)
	{
		seeds[seeds.size] = tacpoint.origin;
	}
	return seeds;
}

/*
	Name: get_pathable_point
	Namespace: namespace_b20b4885
	Checksum: 0xB8857EA5
	Offset: 0x3CC8
	Size: 0x168
	Parameters: 1
	Flags: None
*/
function get_pathable_point(points)
{
	if(!isdefined(points) || points.size == 0)
	{
		return undefined;
	}
	radius = self getpathfindingradius();
	navmeshpoint = getclosestpointonnavmesh(self.origin, 64, radius);
	if(!isdefined(navmeshpoint))
	{
		/#
			self botprinterror("" + self.origin);
		#/
		return undefined;
	}
	path = generatenavmeshpath(navmeshpoint, points, self);
	if(!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0)
	{
		return undefined;
	}
	origin = path.pathpoints[path.pathpoints.size - 1];
	tacpoint = function_ad6356f5(origin);
	if(isdefined(tacpoint))
	{
		return tacpoint.origin;
	}
	return origin;
}

