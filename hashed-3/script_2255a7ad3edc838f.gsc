// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_366ff0bb9cb7adb1;
#using script_3f27a7b2232674db;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using script_6158278c8647d8a9;
#using script_71b469e2f5031723;
#using script_ee56e8b680377b6;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace bot;

/*
	Name: function_89f2df9
	Namespace: bot
	Checksum: 0xD73825AA
	Offset: 0x260
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"bot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bot
	Checksum: 0xA2CC84A3
	Offset: 0x2A8
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	callback::on_player_damage(&on_player_damage);
	callback::on_player_killed(&on_player_killed);
	callback::on_disconnect(&on_player_disconnect);
	level.var_fa5cacde = getgametypesetting(#"hash_77b7734750cd75e9");
	setdvar(#"bot_maxmantleheight", 200);
	/#
		level thread devgui_bot_loop();
		level thread bot_joinleave_loop();
	#/
	namespace_13f469d::registerbotinterfaceattributes();
}

/*
	Name: is_bot_ranked_match
	Namespace: bot
	Checksum: 0x23A38C27
	Offset: 0x3E8
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function is_bot_ranked_match()
{
	return 0;
}

/*
	Name: add_bot
	Namespace: bot
	Checksum: 0xD8515869
	Offset: 0x3F8
	Size: 0x182
	Parameters: 3
	Flags: Linked
*/
function add_bot(team, name = undefined, clanabbrev = undefined)
{
	bot = addtestclient(name, clanabbrev);
	if(!isdefined(bot))
	{
		return undefined;
	}
	bot init_bot();
	bot.goalradius = 512;
	if(isdefined(level.disableclassselection) && level.disableclassselection)
	{
		bot.pers[#"class"] = level.defaultclass;
		bot.curclass = level.defaultclass;
	}
	if(level.teambased && isdefined(team) && isdefined(level.teams[team]))
	{
		bot.botteam = team;
	}
	else if(isdefined(team) && team == #"spectator")
	{
		bot.botteam = #"spectator";
	}
	else
	{
		bot.botteam = "autoassign";
	}
	return bot;
}

/*
	Name: add_bots
	Namespace: bot
	Checksum: 0xE7C8EA5A
	Offset: 0x588
	Size: 0x90
	Parameters: 2
	Flags: Linked
*/
function add_bots(count = 1, team)
{
	level endon(#"game_ended");
	for(i = 0; i < count; i++)
	{
		bot = add_bot(team);
		if(!isdefined(bot))
		{
			return;
		}
		waitframe(1);
	}
}

/*
	Name: add_fixed_spawn_bot
	Namespace: bot
	Checksum: 0xB32B69DE
	Offset: 0x620
	Size: 0xE8
	Parameters: 4
	Flags: Linked
*/
function add_fixed_spawn_bot(team, origin, yaw, var_f11eb5f2 = undefined)
{
	bot = add_bot(team);
	if(isdefined(bot))
	{
		if(isdefined(var_f11eb5f2) && var_f11eb5f2 >= 0)
		{
			bot.var_29b433bd = int(var_f11eb5f2);
		}
		bot function_6650e201(0);
		node = bot get_nearest_node(origin);
		bot thread fixed_spawn_override(origin, yaw, node);
	}
	return bot;
}

/*
	Name: add_balanced_bot
	Namespace: bot
	Checksum: 0xDFC7DE07
	Offset: 0x710
	Size: 0xCA
	Parameters: 4
	Flags: Linked
*/
function add_balanced_bot(allies, maxallies, axis, maxaxis)
{
	bot = undefined;
	if(allies.size < maxallies && (allies.size <= axis.size || axis.size >= maxaxis))
	{
		bot = add_bot(#"allies");
	}
	else if(axis.size < maxaxis)
	{
		bot = add_bot(#"axis");
	}
	return isdefined(bot);
}

/*
	Name: fixed_spawn_override
	Namespace: bot
	Checksum: 0x6B134F9E
	Offset: 0x7E8
	Size: 0x158
	Parameters: 4
	Flags: Linked
*/
function fixed_spawn_override(origin, yaw, node = undefined, force = 1)
{
	self endon(#"disconnect");
	angles = (0, yaw, 0);
	while(isdefined(self.bot))
	{
		self waittill(#"spawned_player");
		if(isdefined(node))
		{
			self setorigin(node.origin);
			self setplayerangles(node.angles);
			self setgoal(node, force);
		}
		else
		{
			self setorigin(origin);
			self setplayerangles(angles);
			self setgoal(origin, force);
		}
		self dontinterpolate();
	}
}

/*
	Name: function_7dc6049e
	Namespace: bot
	Checksum: 0x2C7731D4
	Offset: 0x948
	Size: 0x16E
	Parameters: 2
	Flags: Linked
*/
function function_7dc6049e(vehicle, seatindex = undefined)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	while(isdefined(vehicle))
	{
		self waittill(#"spawned_player");
		if(isdefined(vehicle) && isdefined(seatindex) && !vehicle isvehicleseatoccupied(seatindex))
		{
			vehicle usevehicle(self, seatindex);
		}
		else
		{
			for(i = 0; i < 11; i++)
			{
				if(vehicle function_dcef0ba1(i))
				{
					var_3693c73b = vehicle function_defc91b2(i);
					if(isdefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i))
					{
						vehicle usevehicle(self, i);
						break;
					}
				}
			}
		}
	}
}

/*
	Name: remove_bots
	Namespace: bot
	Checksum: 0x9E94787A
	Offset: 0xAC0
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function remove_bots(team)
{
	players = getplayers();
	foreach(player in players)
	{
		if(!player istestclient())
		{
			continue;
		}
		if(isdefined(team) && player.team != team)
		{
			continue;
		}
		remove_bot(player);
	}
}

/*
	Name: remove_random_bot
	Namespace: bot
	Checksum: 0x4B674AF7
	Offset: 0xBA0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function remove_random_bot()
{
	bots = get_bots();
	if(!bots.size)
	{
		return;
	}
	bot = bots[randomint(bots.size)];
	remove_bot(bot);
}

/*
	Name: remove_bot
	Namespace: bot
	Checksum: 0xCCB4B0FA
	Offset: 0xC18
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function remove_bot(bot)
{
	if(!bot istestclient())
	{
		return;
	}
	if(isdefined(level.onbotremove))
	{
		bot [[level.onbotremove]]();
	}
	bot botdropclient();
}

/*
	Name: get_bots
	Namespace: bot
	Checksum: 0x66760ED4
	Offset: 0xC88
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function get_bots()
{
	players = getplayers();
	return filter_bots(players);
}

/*
	Name: filter_bots
	Namespace: bot
	Checksum: 0xFF414CBD
	Offset: 0xCC8
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function filter_bots(players)
{
	bots = [];
	foreach(player in players)
	{
		if(isbot(player))
		{
			bots[bots.size] = player;
		}
	}
	return bots;
}

/*
	Name: get_friendly_bots
	Namespace: bot
	Checksum: 0x299DFD0
	Offset: 0xD78
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function get_friendly_bots()
{
	players = getplayers(self.team);
	bots = [];
	foreach(player in players)
	{
		if(!isbot(player))
		{
			continue;
		}
		bots[bots.size] = player;
	}
	return bots;
}

/*
	Name: get_enemy_bots
	Namespace: bot
	Checksum: 0x7DCF7D67
	Offset: 0xE48
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function get_enemy_bots()
{
	players = getplayers();
	bots = [];
	foreach(player in players)
	{
		if(!isbot(player))
		{
			continue;
		}
		if(util::function_fbce7263(player.team, self.team))
		{
			bots[bots.size] = player;
		}
	}
	return bots;
}

/*
	Name: function_a0f5b7f5
	Namespace: bot
	Checksum: 0x30D5AC2F
	Offset: 0xF30
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_a0f5b7f5(team)
{
	players = getplayers(team);
	bots = [];
	foreach(player in players)
	{
		if(!isbot(player))
		{
			continue;
		}
		bots[bots.size] = player;
	}
	return bots;
}

/*
	Name: get_bot_by_entity_number
	Namespace: bot
	Checksum: 0x53818C07
	Offset: 0x1008
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function get_bot_by_entity_number(entnum)
{
	players = getplayers();
	foreach(player in players)
	{
		if(!isbot(player))
		{
			continue;
		}
		if(player getentitynumber() == entnum)
		{
			return player;
		}
	}
	return undefined;
}

/*
	Name: bot_count
	Namespace: bot
	Checksum: 0x46DAD34
	Offset: 0x10D0
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function bot_count()
{
	count = 0;
	foreach(player in level.players)
	{
		if(player istestclient())
		{
			count++;
		}
	}
	return count;
}

/*
	Name: on_player_connect
	Namespace: bot
	Checksum: 0x87DC5E15
	Offset: 0x1170
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(!self istestclient())
	{
		return;
	}
	self endon(#"disconnect");
	/#
		self thread add_bot_devgui_menu();
	#/
	if(!self initialized())
	{
		self init_bot();
	}
	waitframe(1);
	if(isdefined(level.onbotconnect))
	{
		self thread [[level.onbotconnect]]();
	}
	if(isdefined(self.var_29b433bd) && player_role::is_valid(self.var_29b433bd))
	{
		player_role::set(self.var_29b433bd);
		self.var_29b433bd = undefined;
	}
}

/*
	Name: on_player_spawned
	Namespace: bot
	Checksum: 0xE029AEFF
	Offset: 0x1270
	Size: 0x27A
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	if(!isbot(self))
	{
		return;
	}
	/#
		weapon = undefined;
		if(getdvarstring(#"bot_spawn_weapon", "") != "")
		{
			weapon = util::get_weapon_by_name(getdvarstring(#"bot_spawn_weapon"), getdvarstring(#"hash_c6e51858c88a5ee"));
			if(isdefined(weapon))
			{
				self function_35e77034(weapon);
			}
		}
	#/
	self.var_2925fedc = undefined;
	if(self bot_chain::function_58b429fb())
	{
		self bot_chain::function_34a84039();
	}
	else if(ai::getaiattribute(self, "control") === "autonomous" && isdefined(self.bot.var_bd883a25))
	{
		self setgoal(self.bot.var_bd883a25, self.bot.var_4e3a654);
	}
	else
	{
		self setgoal(self.origin);
	}
	self function_acc4267f();
	if(isdefined(level.onbotspawned))
	{
		self thread [[level.onbotspawned]]();
	}
	self thread update_loop();
	if(getdvarint(#"bots_invulnerable", 0))
	{
		self val::set(#"devgui", "takedamage", 0);
	}
	self.bot.var_f9954cf6 = undefined;
	self.bot.var_44114a0e = undefined;
	self.bot.currentflag = undefined;
}

/*
	Name: on_player_damage
	Namespace: bot
	Checksum: 0x401A9D9B
	Offset: 0x14F8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	if(!isbot(self))
	{
		return;
	}
	if(function_ffa5b184(self.enemy))
	{
		self clearentitytarget();
		self.bot.var_2a98e9ea = 0;
	}
}

/*
	Name: on_player_killed
	Namespace: bot
	Checksum: 0xED5FD305
	Offset: 0x1570
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(!isbot(self))
	{
		return;
	}
	self function_6c280dfe();
	self clear_revive_target();
	if(isdefined(level.onbotkilled))
	{
		self thread [[level.onbotkilled]]();
	}
	self clearentitytarget();
	self.bot.var_2a98e9ea = 0;
	self botreleasemanualcontrol();
}

/*
	Name: on_player_disconnect
	Namespace: bot
	Checksum: 0x67817D38
	Offset: 0x1628
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(!self istestclient())
	{
		return;
	}
	/#
		self clear_bot_devgui_menu();
	#/
}

/*
	Name: function_c6e29bdf
	Namespace: bot
	Checksum: 0x5F8D6FDE
	Offset: 0x1670
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_c6e29bdf()
{
	/#
		self thread add_bot_devgui_menu();
	#/
	if(!self initialized())
	{
		self init_bot();
	}
	self.goalradius = 512;
	self thread update_loop();
	if(isdefined(level.onbotspawned))
	{
		self thread [[level.onbotspawned]]();
	}
}

/*
	Name: function_3d575aa3
	Namespace: bot
	Checksum: 0x9B00DC40
	Offset: 0x1708
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_3d575aa3()
{
	/#
		self clear_bot_devgui_menu();
	#/
	self notify(#"hash_a729d7d4c6847f6");
	self.bot = undefined;
}

/*
	Name: update_loop
	Namespace: bot
	Checksum: 0xAC23186
	Offset: 0x1748
	Size: 0x556
	Parameters: 0
	Flags: Linked
*/
function update_loop()
{
	/#
		if(getdvarint(#"hash_40d23c5b73e8bad4", 0))
		{
			waitframe(1);
			self bottakemanualcontrol();
			return;
		}
	#/
	self endon(#"death", #"bled_out");
	level endon(#"game_ended");
	if(isdefined(level.var_fa5cacde) && level.var_fa5cacde)
	{
		waitframe(1);
		self bottakemanualcontrol();
		return;
	}
	self bot_action::start();
	self namespace_b20b4885::start();
	self namespace_9c817acd::start();
	while(isdefined(self.bot))
	{
		if(!isbot(self) || !self initialized())
		{
			self bot_action::stop();
			self namespace_b20b4885::stop();
			self namespace_9c817acd::stop();
			return;
		}
		tacbundle = self function_d473f7de();
		/#
			if(!isdefined(tacbundle))
			{
				record3dtext("", self.origin, (1, 0, 0), "", self, 0.5);
				waitframe(1);
				continue;
			}
			record3dtext(("" + tacbundle.name) + "", self.origin, (1, 1, 1), "", self, 0.5);
			if(isdefined(self get_revive_target()))
			{
				target = self get_revive_target().origin;
				recordline(self.origin, target, (0, 1, 1), "", self);
				recordcircle(target, 32, (0, 1, 1), "", self);
			}
			if(self should_record(#"hash_16eb77415dcf6054"))
			{
				self function_d45e8714();
			}
		#/
		self function_ec403901();
		self function_23c46f6e();
		self function_92b0ec6b();
		if(!self isplayinganimscripted() && !self arecontrolsfrozen() && !self function_5972c3cf() && !self isinvehicle() && !self util::isflashed() && isdefined(self.sessionstate) && self.sessionstate == "playing")
		{
			self bot_action::update();
			self thread namespace_b20b4885::update(tacbundle);
			self namespace_9c817acd::update(tacbundle);
			self update_swim();
		}
		else
		{
			self bot_action::reset();
			self namespace_b20b4885::reset();
			self namespace_9c817acd::reset();
			if(self function_dd750ead())
			{
				gameobject = self function_f47bf51d();
				if(isdefined(gameobject.inuse) && gameobject.inuse && isdefined(gameobject.trigger) && self.claimtrigger === gameobject.trigger)
				{
					self bottapbutton(3);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_23c46f6e
	Namespace: bot
	Checksum: 0x2F54362E
	Offset: 0x1CA8
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_23c46f6e()
{
	if(self function_dd750ead())
	{
		gameobject = self function_f47bf51d();
		if(!isdefined(gameobject.trigger) || !gameobject.trigger istriggerenabled() || !gameobject gameobjects::can_interact_with(self))
		{
			self function_6c280dfe();
		}
		else if(isdefined(gameobject.inuse) && gameobject.inuse && self.claimtrigger !== gameobject.trigger)
		{
			self function_6c280dfe();
		}
	}
	else if(self function_914feddd())
	{
	}
	else if(self function_43a720c7())
	{
	}
	else if(self function_6b107944())
	{
		/#
			self botprinterror("");
		#/
		self function_6c280dfe();
	}
}

/*
	Name: function_92b0ec6b
	Namespace: bot
	Checksum: 0x5B5A2466
	Offset: 0x1E28
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function function_92b0ec6b()
{
	if(!has_visible_enemy())
	{
		self.bot.var_ea5b64df = (isdefined(self.bot.tacbundle.inaccuracy) ? self.bot.tacbundle.inaccuracy : 0);
		self.bot.aimoffset = (0, 0, 0);
		self.bot.var_9492fdcb = (0, 0, 0);
		self.bot.var_67b4ea54 = undefined;
	}
	if(self playerads() < 1)
	{
		self.bot.var_ddc0e12b = undefined;
		self.bot.var_f2b47a08 = undefined;
	}
}

/*
	Name: function_ec403901
	Namespace: bot
	Checksum: 0x26226B8B
	Offset: 0x1F08
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_ec403901()
{
	if(isdefined(self.revivetrigger))
	{
		if(isstring(level.var_258cdebb) && self.bot.tacbundle.name != level.var_258cdebb)
		{
			self function_678e7c0(level.var_258cdebb);
		}
		return;
	}
	if(isdefined(self.var_81c43c))
	{
		self function_678e7c0(self.var_81c43c);
		return;
	}
	self function_acc4267f();
}

/*
	Name: function_ffbfd83b
	Namespace: bot
	Checksum: 0xEE441E2
	Offset: 0x1FD0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_ffbfd83b()
{
	if(isdefined(self.bot.var_2a98e9ea) && self.bot.var_2a98e9ea && !function_ffa5b184(self.enemy))
	{
		self.bot.var_2a98e9ea = 0;
		self clearentitytarget();
		return;
	}
	if(!isdefined(self.enemy) || !function_ffa5b184(self.enemy))
	{
		return;
	}
	if(self.ignoreall || (isdefined(self.enemy.var_becd4d91) && self.enemy.var_becd4d91) || self.enemy ai::function_41b04632())
	{
		self clearentitytarget();
		return;
	}
	targetpoint = (isdefined(self.enemy.var_88f8feeb) ? self.enemy.var_88f8feeb : self.enemy getcentroid());
	if(!sighttracepassed(self geteye(), targetpoint, 0, self.enemy))
	{
		self clearentitytarget();
	}
}

/*
	Name: update_swim
	Namespace: bot
	Checksum: 0xFEBAA879
	Offset: 0x2178
	Size: 0x2E4
	Parameters: 0
	Flags: Linked
*/
function update_swim()
{
	if(!self isplayerswimming())
	{
		self.bot.resurfacetime = undefined;
		return;
	}
	if(isdefined(self.drownstage) && self.drownstage != 0)
	{
		self bottapbutton(67);
		return;
	}
	if(self isplayerunderwater())
	{
		if(!isdefined(self.bot.resurfacetime))
		{
			self.bot.resurfacetime = gettime() + (int((self.playerrole.swimtime - 1) * 1000));
		}
	}
	else if(isdefined(self.bot.resurfacetime) && (gettime() - self.bot.resurfacetime) < (int(2 * 1000)))
	{
		self bottapbutton(67);
		return;
	}
	self.bot.resurfacetime = undefined;
	if(self botundermanualcontrol())
	{
		return;
	}
	goalposition = self.goalpos;
	if(distance2dsquared(goalposition, self.origin) <= 16384 && getwaterheight(goalposition) > 0)
	{
		self bottapbutton(68);
		return;
	}
	if(isdefined(self.bot.resurfacetime) && self.bot.resurfacetime <= gettime())
	{
		self bottapbutton(67);
		return;
	}
	bottomtrace = groundtrace(self.origin, self.origin + (vectorscale((0, 0, -1), 1000)), 0, self, 1);
	swimheight = self.origin[2] - bottomtrace[#"position"][2];
	if(swimheight < 25)
	{
		self bottapbutton(67);
	}
	else if(swimheight > 45)
	{
		self bottapbutton(68);
	}
}

/*
	Name: init_bot
	Namespace: bot
	Checksum: 0x6FEE2BDE
	Offset: 0x2468
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function init_bot()
{
	self.bot = spawnstruct();
	ai::createinterfaceforentity(self);
	self function_acc4267f();
	self.bot.var_b2b8f0b6 = 300;
	self.bot.var_e8c941d6 = 470;
	self.bot.var_51cee2ad = 0;
	self.bot.var_af11e334 = 0;
	self.bot.var_bdbba2cd = 0;
	self.bot.var_18fa994c = 0;
	self.bot.var_857c5ea8 = 0;
	blackboard::createblackboardforentity(self);
	self function_eaf7ef38(#"hash_1b029888c4965031", #"hash_41b1340b7efb3261");
}

/*
	Name: initialized
	Namespace: bot
	Checksum: 0x94F8FFB1
	Offset: 0x2570
	Size: 0xC
	Parameters: 0
	Flags: Linked
*/
function initialized()
{
	return isdefined(self.bot);
}

/*
	Name: function_acc4267f
	Namespace: bot
	Checksum: 0xAA03328F
	Offset: 0x2588
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_acc4267f()
{
	self function_678e7c0((isdefined(level.var_df0a0911) ? level.var_df0a0911 : "bot_tacstate_default"));
}

/*
	Name: function_678e7c0
	Namespace: bot
	Checksum: 0xF8F3C092
	Offset: 0x25D0
	Size: 0x32E
	Parameters: 1
	Flags: Linked
*/
function function_678e7c0(bundlename)
{
	tacbundle = getscriptbundle(bundlename);
	if(!isdefined(tacbundle))
	{
		/#
			self botprinterror("" + bundlename);
		#/
		return;
	}
	if(self.bot.tacbundle === tacbundle)
	{
		return;
	}
	maxsightdist = (isdefined(tacbundle.maxsightdist) ? tacbundle.maxsightdist : 0);
	self.maxsightdistsqrd = maxsightdist * maxsightdist;
	self.highlyawareradius = (isdefined(tacbundle.highlyawareradius) ? tacbundle.highlyawareradius : 0);
	self.fovcosine = fov_angle_to_cosine(tacbundle.fov);
	self.fovcosinebusy = fov_angle_to_cosine(tacbundle.fovbusy);
	self.perfectaim = (isdefined(tacbundle.perfectaim) ? tacbundle.perfectaim : 0);
	self.accuracy = (isdefined(tacbundle.accuracy) ? tacbundle.accuracy : 0);
	self.pacifist = (isdefined(tacbundle.pacifist) ? tacbundle.pacifist : 0);
	self.pacifistwait = (isdefined(tacbundle.pacifistwait) ? tacbundle.pacifistwait : 0);
	loc_000027CA:
	self botsetlooksensitivity((isdefined(tacbundle.pitchsensitivity) ? tacbundle.pitchsensitivity : 0), (isdefined(tacbundle.yawsensitivity) ? tacbundle.yawsensitivity : 0));
	loc_0000281A:
	self function_4f0b9564((isdefined(tacbundle.var_17ee500f) ? tacbundle.var_17ee500f : 0), (isdefined(tacbundle.var_18e471dc) ? tacbundle.var_18e471dc : 0));
	loc_0000286A:
	self function_a6b577cd((isdefined(tacbundle.var_2b02e26a) ? tacbundle.var_2b02e26a : 0), (isdefined(tacbundle.var_69610dbe) ? tacbundle.var_69610dbe : 0));
	loc_000028BA:
	self function_400c9c63((isdefined(tacbundle.var_4333f343) ? tacbundle.var_4333f343 : 0), (isdefined(tacbundle.var_b392418) ? tacbundle.var_b392418 : 0));
	self.bot.tacbundle = tacbundle;
}

/*
	Name: fov_angle_to_cosine
	Namespace: bot
	Checksum: 0x39F1DEB0
	Offset: 0x2908
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function fov_angle_to_cosine(fovangle = 0)
{
	if(fovangle >= 180)
	{
		return 0;
	}
	return cos(fovangle / 2);
}

/*
	Name: function_d473f7de
	Namespace: bot
	Checksum: 0xFB1F0F10
	Offset: 0x2958
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_d473f7de()
{
	return self.bot.tacbundle;
}

/*
	Name: function_7a6eea9c
	Namespace: bot
	Checksum: 0xAC3C2021
	Offset: 0x2978
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_7a6eea9c(interact)
{
	self.bot.interact = interact;
}

/*
	Name: function_6c280dfe
	Namespace: bot
	Checksum: 0xFA3D73BF
	Offset: 0x29A0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_6c280dfe()
{
	self.bot.interact = undefined;
}

/*
	Name: function_f47bf51d
	Namespace: bot
	Checksum: 0x2CFA3D3B
	Offset: 0x29C0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_f47bf51d()
{
	return self.bot.interact;
}

/*
	Name: function_6b107944
	Namespace: bot
	Checksum: 0xDA4370EC
	Offset: 0x29E0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function function_6b107944()
{
	return isdefined(self.bot.interact);
}

/*
	Name: function_dd750ead
	Namespace: bot
	Checksum: 0x27CFC214
	Offset: 0x2A00
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_dd750ead()
{
	return isdefined(self.bot.interact) && isdefined(self.bot.interact.trigger) && self.bot.interact.triggertype === "use";
}

/*
	Name: function_914feddd
	Namespace: bot
	Checksum: 0xB72802C0
	Offset: 0x2A68
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_914feddd()
{
	return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_weapon_upgrade);
}

/*
	Name: function_e8a17817
	Namespace: bot
	Checksum: 0xA2FCF993
	Offset: 0x2AA8
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_e8a17817()
{
	return isdefined(self.bot.interact) && isdefined(self.bot.interact.zombie_cost) && self.bot.interact._door_open !== 1;
}

/*
	Name: function_2d99e476
	Namespace: bot
	Checksum: 0xA91962D7
	Offset: 0x2B08
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_2d99e476()
{
	return isdefined(self.bot.interact) && self.bot.interact.objectid === "magicbox_struct" && self.bot.interact.hidden !== 1;
}

/*
	Name: function_4e55eb5d
	Namespace: bot
	Checksum: 0x40344F49
	Offset: 0x2B70
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_4e55eb5d()
{
	return isdefined(self.bot.interact) && self.bot.interact.targetname === "use_elec_switch";
}

/*
	Name: function_ca9fb875
	Namespace: bot
	Checksum: 0x1EA96B45
	Offset: 0x2BB8
	Size: 0x3A
	Parameters: 0
	Flags: Linked
*/
function function_ca9fb875()
{
	return isdefined(self.bot.interact) && self.bot.interact.script_unitrigger_type === "unitrigger_box_use";
}

/*
	Name: function_43a720c7
	Namespace: bot
	Checksum: 0xB635E87C
	Offset: 0x2C00
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_43a720c7()
{
	return function_e8a17817() || function_2d99e476() || function_4e55eb5d() || function_ca9fb875();
}

/*
	Name: function_bba89736
	Namespace: bot
	Checksum: 0x44625ED6
	Offset: 0x2C68
	Size: 0x19C
	Parameters: 0
	Flags: None
*/
function function_bba89736()
{
	if(!self function_6b107944())
	{
		return undefined;
	}
	interact = self function_f47bf51d();
	if(self function_dd750ead())
	{
		return interact.trigger;
	}
	if(self function_914feddd() || self function_43a720c7())
	{
		if(isentity(interact))
		{
			return interact;
		}
		if(isdefined(interact.trigger_stub) && isdefined(interact.trigger_stub.playertrigger))
		{
			return interact.trigger_stub.playertrigger[self getentitynumber()];
		}
		if(isdefined(interact.unitrigger_stub) && isdefined(interact.unitrigger_stub.playertrigger))
		{
			return interact.unitrigger_stub.playertrigger[self getentitynumber()];
		}
		if(isdefined(interact.playertrigger))
		{
			return interact.playertrigger[self getentitynumber()];
		}
	}
	return undefined;
}

/*
	Name: get_revive_target
	Namespace: bot
	Checksum: 0x19491280
	Offset: 0x2E10
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_revive_target()
{
	return self.bot.revivetarget;
}

/*
	Name: set_revive_target
	Namespace: bot
	Checksum: 0xF2015D70
	Offset: 0x2E30
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function set_revive_target(target)
{
	self.bot.revivetarget = target;
}

/*
	Name: clear_revive_target
	Namespace: bot
	Checksum: 0x7D1C27E
	Offset: 0x2E58
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function clear_revive_target()
{
	self set_revive_target(undefined);
}

/*
	Name: menu_cancel
	Namespace: bot
	Checksum: 0x41C8131F
	Offset: 0x2E80
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function menu_cancel(menukey)
{
	self notify(#"menuresponse", {#intpayload:0, #response:"cancel", #menu:game.menu[menukey]});
}

/*
	Name: has_visible_enemy
	Namespace: bot
	Checksum: 0xCD535D9B
	Offset: 0x2EF8
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function has_visible_enemy()
{
	if(self in_combat())
	{
		return isalive(self.enemy) && self cansee(self.enemy);
	}
	return 0;
}

/*
	Name: in_combat
	Namespace: bot
	Checksum: 0x659E418B
	Offset: 0x2F58
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function in_combat()
{
	if(!isdefined(self.enemy))
	{
		return 0;
	}
	switch(self.combatstate)
	{
		case "hash_13ae5523119f0e4d":
		case "combat_state_in_combat":
		case "combat_state_has_visible_enemy":
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: fwd_dot
	Namespace: bot
	Checksum: 0x7511F9A8
	Offset: 0x2FC8
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function fwd_dot(point)
{
	angles = self getplayerangles();
	fwd = anglestoforward(angles);
	eye = self geteye();
	dir = point - eye;
	dir = vectornormalize(dir);
	dot = vectordot(fwd, dir);
	return dot;
}

/*
	Name: function_7aeb27f1
	Namespace: bot
	Checksum: 0x889B737F
	Offset: 0x3098
	Size: 0x36
	Parameters: 2
	Flags: Linked
*/
function function_7aeb27f1(smin, smax)
{
	return gettime() + (1000 * randomfloatrange(smin, smax));
}

/*
	Name: eye_trace
	Namespace: bot
	Checksum: 0x85519224
	Offset: 0x30D8
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function eye_trace(hitents = 0)
{
	direction = self getplayerangles();
	direction_vec = anglestoforward(direction);
	eye = self geteye();
	scale = 8000;
	direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
	return bullettrace(eye, eye + direction_vec, hitents, self);
}

/*
	Name: function_343d7ef4
	Namespace: bot
	Checksum: 0xFE0C65DD
	Offset: 0x31C8
	Size: 0xB6
	Parameters: 0
	Flags: Linked
*/
function function_343d7ef4()
{
	if(!isbot(self))
	{
		return 0;
	}
	if(self isinvehicle())
	{
		vehicle = self getvehicleoccupied();
		if(isdefined(vehicle.goalforced) && vehicle.goalforced || (isdefined(vehicle.ignoreall) && vehicle.ignoreall))
		{
			return 0;
		}
	}
	else if(self.ignoreall)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_b5dd2fd2
	Namespace: bot
	Checksum: 0xC021A5E5
	Offset: 0x3288
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_b5dd2fd2(entity, attribute, oldvalue, value)
{
}

/*
	Name: get_nearest_node
	Namespace: bot
	Checksum: 0x227A77DE
	Offset: 0x32B8
	Size: 0x11E
	Parameters: 4
	Flags: Linked
*/
function get_nearest_node(pos, maxradius = 24, minradius = 0, height = 64)
{
	nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Scripted");
	if(nodes.size > 0)
	{
		return nodes[0];
	}
	nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Cover");
	if(nodes.size > 0)
	{
		return nodes[0];
	}
	nodes = getnodesinradiussorted(pos, maxradius, minradius, height, "Path");
	if(nodes.size > 0)
	{
		return nodes[0];
	}
	return undefined;
}

/*
	Name: get_position_node
	Namespace: bot
	Checksum: 0x46F5715B
	Offset: 0x33E0
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function get_position_node()
{
	if(isdefined(self.node))
	{
		return self.node;
	}
	if(!isdefined(self.overridegoalpos) && isdefined(self.goalnode))
	{
		return self.goalnode;
	}
	return undefined;
}

/*
	Name: function_6650e201
	Namespace: bot
	Checksum: 0x3BAB689
	Offset: 0x3430
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_6650e201(allow)
{
	self.ignoreall = !allow;
	self ai::set_behavior_attribute("allowprimaryoffhand", allow);
	self ai::set_behavior_attribute("allowsecondaryoffhand", allow);
	self ai::set_behavior_attribute("allowspecialoffhand", allow);
	self ai::set_behavior_attribute("allowscorestreak", allow);
	if(allow)
	{
		self ai::set_behavior_attribute("control", "commander");
		self clearforcedgoal();
	}
	else
	{
		self ai::set_behavior_attribute("control", "autonomous");
		self setgoal(self.origin, 1);
	}
}

/*
	Name: function_f0c35734
	Namespace: bot
	Checksum: 0x1292514A
	Offset: 0x3568
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_f0c35734(trigger)
{
	/#
		assert(isbot(self));
	#/
	/#
		assert(isdefined(trigger));
	#/
	radius = self getpathfindingradius();
	height = self function_6a9ae71();
	heightoffset = (0, 0, (height * -1) / 2);
	var_e790dc87 = (radius, radius, height / 2);
	var_75ae35a4 = ai::function_470c0597(trigger.origin + heightoffset, trigger.maxs + var_e790dc87, trigger.angles);
	return var_75ae35a4;
}

/*
	Name: function_52947b70
	Namespace: bot
	Checksum: 0x89CA3795
	Offset: 0x3690
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function function_52947b70(trigger)
{
	/#
		assert(isbot(self));
	#/
	/#
		assert(isstruct(trigger));
	#/
	radius = self getpathfindingradius();
	height = self function_6a9ae71();
	heightoffset = (0, 0, (height * -1) / 2);
	var_e790dc87 = (radius, radius, height / 2);
	maxs = (trigger.script_width, trigger.script_length, trigger.script_height);
	var_75ae35a4 = ai::function_470c0597(trigger.origin + heightoffset, maxs + var_e790dc87, trigger.angles);
	return var_75ae35a4;
}

/*
	Name: function_e0aceb0c
	Namespace: bot
	Checksum: 0x7B5C1DCF
	Offset: 0x37F0
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_e0aceb0c(tacbundle, dvarstr)
{
	healthratio = self.health / self.maxhealth;
	if(healthratio <= tacbundle.var_ac1c818f)
	{
		/#
			self record_text("", (1, 0, 0), dvarstr);
		#/
		return 0;
	}
	if(self isreloading())
	{
		/#
			self record_text("", (1, 0, 0), dvarstr);
		#/
		return 0;
	}
	weapon = self getcurrentweapon();
	if(weapon != level.weaponnone && self getweaponammoclip(weapon) <= 0)
	{
		/#
			self record_text("", (1, 0, 0), dvarstr);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_b78e1ebf
	Namespace: bot
	Checksum: 0x97EE327
	Offset: 0x3928
	Size: 0x12A
	Parameters: 1
	Flags: Linked
*/
function function_b78e1ebf(lefthand = 0)
{
	weapon = self get_current_weapon(lefthand);
	var_71f9ccb1 = (lefthand ? 24 : 0);
	self bottapbutton(var_71f9ccb1);
	if(isdefined(level.var_32ae304))
	{
		self [[level.var_32ae304]](lefthand);
	}
	else if(weapon function_7f23578e())
	{
		var_51cee2ad = gettime() + randomintrange(self.bot.var_b2b8f0b6, self.bot.var_e8c941d6);
		if(lefthand)
		{
			self.bot.var_af11e334 = var_51cee2ad;
		}
		else
		{
			self.bot.var_51cee2ad = var_51cee2ad;
		}
	}
}

/*
	Name: function_e2c892a5
	Namespace: bot
	Checksum: 0x87741F51
	Offset: 0x3A60
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_e2c892a5(lefthand = 0)
{
	if(function_a7106162(lefthand))
	{
		function_b78e1ebf(lefthand);
		return 1;
	}
	return 0;
}

/*
	Name: function_a7106162
	Namespace: bot
	Checksum: 0x685F09AA
	Offset: 0x3AB8
	Size: 0x162
	Parameters: 1
	Flags: Linked
*/
function function_a7106162(lefthand = 0)
{
	weapon = get_current_weapon(lefthand);
	if(weapon == level.weaponnone)
	{
		return 0;
	}
	if(self getweaponammoclip(weapon) <= 0)
	{
		return 0;
	}
	if(isdefined(level.var_bddfddcf))
	{
		return self [[level.var_bddfddcf]](lefthand);
	}
	if(weapon function_7f23578e())
	{
		if(self function_a39f313c(lefthand) || self isplayerswimming())
		{
			return gettime() > (lefthand ? self.bot.var_af11e334 : self.bot.var_51cee2ad);
		}
		return 0;
	}
	if(weapon function_903ea2a5())
	{
		return self function_a39f313c(lefthand) || self isplayerswimming();
	}
	return 1;
}

/*
	Name: get_current_weapon
	Namespace: bot
	Checksum: 0x27512A3B
	Offset: 0x3C28
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function get_current_weapon(lefthand = 0)
{
	weapon = self getcurrentweapon();
	if(lefthand)
	{
		return weapon.dualwieldweapon;
	}
	return weapon;
}

/*
	Name: function_828da7a9
	Namespace: bot
	Checksum: 0xE08646E1
	Offset: 0x3C80
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_828da7a9(weapon)
{
	return self getweaponammoclip(weapon) > 0 || self getweaponammoclip(weapon.dualwieldweapon) > 0;
}

/*
	Name: function_7f23578e
	Namespace: bot
	Checksum: 0xC7422E33
	Offset: 0x3CD8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function function_7f23578e()
{
	return self.firetype == "Single Shot";
}

/*
	Name: function_903ea2a5
	Namespace: bot
	Checksum: 0x5EA81388
	Offset: 0x3CF8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function function_903ea2a5()
{
	return self.firetype == "Burst";
}

/*
	Name: devgui_bot_loop
	Namespace: bot
	Checksum: 0x11AD72B5
	Offset: 0x3D18
	Size: 0x828
	Parameters: 0
	Flags: None
*/
function devgui_bot_loop()
{
	/#
		sessionmode = currentsessionmode();
		if(sessionmode != 4)
		{
			var_48c9cde3 = getallcharacterbodies(sessionmode);
			foreach(index in var_48c9cde3)
			{
				if(index == 0)
				{
					continue;
				}
				displayname = makelocalizedstring(getcharacterdisplayname(index, sessionmode));
				assetname = function_9e72a96(getcharacterassetname(index, sessionmode));
				name = ((displayname + "") + assetname) + "";
				cmd = ((((("" + name) + "") + index) + "") + index) + "";
				adddebugcommand(cmd);
				cmd = ((((("" + name) + "") + index) + "") + index) + "";
				adddebugcommand(cmd);
			}
		}
		while(true)
		{
			wait(0.25);
			dvarstr = getdvarstring(#"devgui_bot", "");
			if(dvarstr == "")
			{
				continue;
			}
			args = strtok(dvarstr, "");
			host = util::gethostplayerforbots();
			switch(args[0])
			{
				case "add":
				{
					level devgui_add_bots(host, args[1], int(args[2]));
					break;
				}
				case "spawn_enemy":
				{
					level devgui_add_bots(host, #"enemy", 1);
					break;
				}
				case "remove":
				{
					level devgui_remove_bots(host, args[1]);
					break;
				}
				case "kill":
				{
					level devgui_kill_bots(host, args[1]);
					break;
				}
				case "invulnerable":
				{
					level devgui_invulnerable(host, args[1], args[2]);
					break;
				}
				case "ignoreall":
				{
					level function_7f17c614(host, args[1], int(args[2]));
					break;
				}
				case "primaryoffhand":
				{
					level function_c96c865c(host, "", args[1], int(args[2]));
					break;
				}
				case "secondaryoffhand":
				{
					level function_c96c865c(host, "", args[1], int(args[2]));
					break;
				}
				case "specialoffhand":
				{
					level function_c96c865c(host, "", args[1], int(args[2]));
					break;
				}
				case "scorestreak":
				{
					level function_c96c865c(host, "", args[1], int(args[2]));
					break;
				}
				case "hash_13fac3b0e66afef0":
				{
					level function_62c047e4(host, args[1], int(args[2]));
					break;
				}
				case "usekillstreak":
				{
					level function_8042b78a(host, args[1]);
					break;
				}
				case "tpose":
				{
					level function_41f90224(host, args[1]);
					break;
				}
			}
			if(isdefined(host))
			{
				switch(args[0])
				{
					case "add_fixed_spawn":
					{
						host devgui_add_fixed_spawn_bots(args[1], args[2], args[3]);
						break;
					}
					case "set_target":
					{
						host function_f3b40e82(args[1], args[2]);
						break;
					}
					case "goal":
					{
						host devgui_goal(args[1], args[2]);
						break;
					}
					case "companion":
					{
						host function_5524bfd5(args[1]);
						break;
					}
					case "hash_7d471b297adb925d":
					{
						host function_263ca697();
						break;
					}
				}
			}
			level notify(#"devgui_bot", {#args:args, #host:host});
			setdvar(#"devgui_bot", "");
		}
	#/
}

/*
	Name: add_bot_devgui_menu
	Namespace: bot
	Checksum: 0x56E27836
	Offset: 0x4548
	Size: 0x492
	Parameters: 0
	Flags: None
*/
function add_bot_devgui_menu()
{
	/#
		entnum = self getentitynumber();
		if(level.var_fa5cacde && entnum > 12)
		{
			return;
		}
		i = 0;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 2, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 0, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 1, "", "");
		self add_bot_devgui_cmd(entnum, ("" + i) + "", 2, "", "");
		i++;
		self add_bot_devgui_cmd(entnum, "", i, "");
		i++;
		self add_bot_devgui_cmd(entnum, "", i, "");
		i++;
		self add_bot_devgui_cmd(entnum, "", i, "");
		i++;
		self add_bot_devgui_cmd(entnum, "", i, "");
		i++;
	#/
}

/*
	Name: add_bot_devgui_cmd
	Namespace: bot
	Checksum: 0xF444D8DD
	Offset: 0x49E8
	Size: 0xEC
	Parameters: 5
	Flags: None
*/
function add_bot_devgui_cmd(entnum, path, sortkey, devguiarg, cmdargs)
{
	/#
		if(!isdefined(cmdargs))
		{
			cmdargs = "";
		}
		cmd = ((((((((((((((("" + entnum) + "") + self.name) + "") + entnum) + "") + path) + "") + sortkey) + "") + devguiarg) + "") + entnum) + "") + cmdargs) + "";
		util::function_345e5b9a(cmd);
	#/
}

/*
	Name: clear_bot_devgui_menu
	Namespace: bot
	Checksum: 0xA08F7A33
	Offset: 0x4AE0
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function clear_bot_devgui_menu()
{
	/#
		entnum = self getentitynumber();
		if(level.var_fa5cacde && entnum > 12)
		{
			return;
		}
		cmd = ((("" + entnum) + "") + self.name) + "";
		util::function_345e5b9a(cmd);
	#/
}

/*
	Name: devgui_add_bots
	Namespace: bot
	Checksum: 0x67EE064
	Offset: 0x4B78
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function devgui_add_bots(host, botarg, count)
{
	team = devgui_relative_team(host, botarg);
	level thread add_bots(count, team);
}

/*
	Name: function_2d5436be
	Namespace: bot
	Checksum: 0xE4AA6169
	Offset: 0x4BE0
	Size: 0x248
	Parameters: 2
	Flags: Linked
*/
function function_2d5436be(origin, spiral)
{
	spacing = getdvarint(#"hash_6053b2f7b8096ff5", 75);
	a = getdvarint(#"hash_451261221fa2d2d7", 14);
	b = getdvarint(#"hash_451262221fa2d48a", 35);
	c = getdvarfloat(#"hash_451263221fa2d63d", 1);
	min = getdvarfloat(#"hash_6eab9c95ab563fcb", 50);
	radius = max(spiral.radius, min);
	degrees = (spacing * 360) / (6.283185 * radius);
	spiral.angle = spiral.angle + degrees;
	spiral.radius = math::function_b1820790(a, b, c, spiral.angle);
	var_17e94d83 = rotatepointaroundaxis((spiral.radius, 0, 0), (0, 0, 1), spiral.angle + spiral.var_2b9d3922);
	spawn_point = var_17e94d83 + origin;
	trace = bullettrace(spawn_point + vectorscale((0, 0, 1), 100), spawn_point, 0, self);
	return trace[#"position"];
}

/*
	Name: devgui_add_fixed_spawn_bots
	Namespace: bot
	Checksum: 0x160D609A
	Offset: 0x4E30
	Size: 0x520
	Parameters: 3
	Flags: None
*/
function devgui_add_fixed_spawn_bots(botarg, var_b27e53da, var_8baa0e51)
{
	team = devgui_relative_team(self, botarg);
	trace = self eye_trace();
	spawndir = self.origin - trace[#"position"];
	spawnangles = vectortoangles(spawndir);
	if(!isdefined(var_8baa0e51))
	{
		var_8baa0e51 = 1;
	}
	count = max(int(var_8baa0e51), 1);
	bots = [];
	offset = vectorscale((0, 0, 1), 5);
	origin = trace[#"position"] + offset;
	if(!isdefined(bots))
	{
		bots = [];
	}
	else if(!isarray(bots))
	{
		bots = array(bots);
	}
	bots[bots.size] = self add_fixed_spawn_bot(team, origin, spawnangles[1], var_b27e53da);
	spiral = {#radius:100, #angle:0, #hash_2b9d3922:spawnangles[1]};
	spiral.angle = getdvarint(#"hash_6d616a1ec2c5b8f0", 0);
	spiral.radius = getdvarint(#"hash_64cb6c7e56b66cab", 0);
	for(i = 0; i < count - 1; i++)
	{
		origin = function_2d5436be(trace[#"position"] + offset, spiral);
		if(!isdefined(bots))
		{
			bots = [];
		}
		else if(!isarray(bots))
		{
			bots = array(bots);
		}
		bots[bots.size] = self add_fixed_spawn_bot(team, origin, spiral.angle + spiral.var_2b9d3922, var_b27e53da);
	}
	if(isvehicle(trace[#"entity"]))
	{
		foreach(bot in bots)
		{
			if(isdefined(bot))
			{
				vehicle = trace[#"entity"];
				pos = trace[#"position"];
				seatindex = undefined;
				var_d64c5caf = undefined;
				for(i = 0; i < 11; i++)
				{
					if(vehicle function_dcef0ba1(i))
					{
						var_3693c73b = vehicle function_defc91b2(i);
						if(isdefined(var_3693c73b) && var_3693c73b >= 0 && !vehicle isvehicleseatoccupied(i))
						{
							dist = distance(pos, vehicle function_5051cc0c(i));
							if(!isdefined(seatindex) || var_d64c5caf > dist)
							{
								seatindex = i;
								var_d64c5caf = dist;
							}
						}
					}
				}
				bot thread function_7dc6049e(vehicle, seatindex);
			}
		}
	}
}

/*
	Name: devgui_relative_team
	Namespace: bot
	Checksum: 0x9B61216B
	Offset: 0x5358
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function devgui_relative_team(host, botarg)
{
	if(isdefined(host))
	{
		team = (host.team != #"spectator" ? host.team : #"allies");
		if(botarg == "enemy")
		{
			team = (team == #"allies" ? #"axis" : #"allies");
		}
		return team;
	}
	if(botarg == "friendly")
	{
		return #"allies";
	}
	return #"axis";
}

/*
	Name: devgui_remove_bots
	Namespace: bot
	Checksum: 0x2624ABC1
	Offset: 0x5440
	Size: 0xC8
	Parameters: 2
	Flags: None
*/
function devgui_remove_bots(host, botarg)
{
	level notify(#"hash_d3e36871aa6829f");
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		level thread remove_bot(bot);
	}
}

/*
	Name: function_7f17c614
	Namespace: bot
	Checksum: 0xA5F0999C
	Offset: 0x5510
	Size: 0xB8
	Parameters: 3
	Flags: None
*/
function function_7f17c614(host, botarg, cmdarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		bot function_6650e201(cmdarg);
	}
}

/*
	Name: function_c96c865c
	Namespace: bot
	Checksum: 0x358F53E1
	Offset: 0x55D0
	Size: 0x114
	Parameters: 4
	Flags: None
*/
function function_c96c865c(host, attribute, botarg, cmdarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		foreach(bot in bots)
		{
			bot ai::set_behavior_attribute(attribute, cmdarg);
		}
	}
}

/*
	Name: function_62c047e4
	Namespace: bot
	Checksum: 0x1D47A057
	Offset: 0x56F0
	Size: 0xB8
	Parameters: 3
	Flags: None
*/
function function_62c047e4(host, botarg, cmdarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		bot bot_action::function_ee2eaccc(cmdarg);
	}
}

/*
	Name: function_8042b78a
	Namespace: bot
	Checksum: 0xBEC3A2CF
	Offset: 0x57B0
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function function_8042b78a(host, botarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		bot bot_action::function_4a53ae1f();
	}
}

/*
	Name: function_41f90224
	Namespace: bot
	Checksum: 0x50A9CAD0
	Offset: 0x5860
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function function_41f90224(host, botarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		setdvar(#"hash_6028c4687677bbc9", 1);
		bot function_c6775cf9("dev_boast_tpose");
	}
}

/*
	Name: devgui_kill_bots
	Namespace: bot
	Checksum: 0x60923093
	Offset: 0x5940
	Size: 0x130
	Parameters: 2
	Flags: None
*/
function devgui_kill_bots(host, botarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		if(!isalive(bot))
		{
			continue;
		}
		bot val::set(#"devgui_kill", "takedamage", 1);
		bot dodamage(bot.health + 1000, bot.origin);
		bot val::reset(#"devgui_kill", "takedamage");
	}
}

/*
	Name: devgui_invulnerable
	Namespace: bot
	Checksum: 0x96B2832E
	Offset: 0x5A78
	Size: 0x108
	Parameters: 3
	Flags: None
*/
function devgui_invulnerable(host, botarg, cmdarg)
{
	bots = devgui_get_bots(host, botarg);
	foreach(bot in bots)
	{
		if(cmdarg == "on")
		{
			bot val::set(#"devgui", "takedamage", 0);
			continue;
		}
		bot val::reset(#"devgui", "takedamage");
	}
}

/*
	Name: function_f3b40e82
	Namespace: bot
	Checksum: 0x9501804D
	Offset: 0x5B88
	Size: 0x168
	Parameters: 2
	Flags: None
*/
function function_f3b40e82(botarg, cmdarg)
{
	target = undefined;
	switch(cmdarg)
	{
		case "crosshair":
		{
			target = self function_7090aa98();
			break;
		}
		case "me":
		{
			target = self;
			break;
		}
		case "clear":
		{
			break;
		}
		default:
		{
			return;
		}
	}
	bots = devgui_get_bots(self, botarg);
	foreach(bot in bots)
	{
		if(isdefined(target))
		{
			if(target != bot)
			{
				bot setentitytarget(target);
			}
			continue;
		}
		bot clearentitytarget();
	}
}

/*
	Name: devgui_goal
	Namespace: bot
	Checksum: 0x9818AEE
	Offset: 0x5CF8
	Size: 0xDA
	Parameters: 2
	Flags: None
*/
function devgui_goal(botarg, cmdarg)
{
	switch(cmdarg)
	{
		case "set":
		{
			self function_bbc3f17e(botarg, 0);
			return;
		}
		case "me":
		{
			self devgui_goal_me(botarg);
			return;
		}
		case "force":
		{
			self function_bbc3f17e(botarg, 1);
			return;
		}
		case "clear":
		{
			self devgui_goal_clear(botarg);
			return;
		}
	}
}

/*
	Name: function_bbc3f17e
	Namespace: bot
	Checksum: 0xA56D2452
	Offset: 0x5DE0
	Size: 0x158
	Parameters: 2
	Flags: Linked
*/
function function_bbc3f17e(botarg, force = 0)
{
	trace = self eye_trace(1);
	bots = devgui_get_bots(self, botarg);
	pos = trace[#"position"];
	node = self get_nearest_node(pos);
	if(isdefined(node))
	{
		pos = node;
	}
	foreach(bot in bots)
	{
		bot ai::set_behavior_attribute("control", "autonomous");
		bot setgoal(pos, force);
	}
}

/*
	Name: devgui_goal_clear
	Namespace: bot
	Checksum: 0x4EB8067D
	Offset: 0x5F40
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function devgui_goal_clear(botarg)
{
	bots = devgui_get_bots(self, botarg);
	foreach(bot in bots)
	{
		bot ai::set_behavior_attribute("control", "commander");
		bot clearforcedgoal();
	}
}

/*
	Name: devgui_goal_me
	Namespace: bot
	Checksum: 0x5C75ACC1
	Offset: 0x6010
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function devgui_goal_me(botarg)
{
	bots = devgui_get_bots(self, botarg);
	foreach(bot in bots)
	{
		bot ai::set_behavior_attribute("control", "autonomous");
		bot setgoal(self);
	}
}

/*
	Name: devgui_get_bots
	Namespace: bot
	Checksum: 0x802BCE4D
	Offset: 0x60E0
	Size: 0x15A
	Parameters: 2
	Flags: Linked
*/
function devgui_get_bots(host, botarg)
{
	if(strisnumber(botarg))
	{
		bots = [];
		bot = get_bot_by_entity_number(int(botarg));
		if(isdefined(bot))
		{
			bots[0] = bot;
		}
		return bots;
	}
	if(isdefined(host))
	{
		if(botarg == "friendly")
		{
			return host get_friendly_bots();
		}
		if(botarg == "enemy")
		{
			return host get_enemy_bots();
		}
	}
	else if(level.teambased)
	{
		if(botarg == "friendly")
		{
			return function_a0f5b7f5(#"allies");
		}
		return function_a0f5b7f5(#"axis");
	}
	return get_bots();
}

/*
	Name: function_7090aa98
	Namespace: bot
	Checksum: 0x710ED5CD
	Offset: 0x6248
	Size: 0x1B2
	Parameters: 0
	Flags: Linked
*/
function function_7090aa98()
{
	targetentity = undefined;
	targetdot = undefined;
	players = getplayers();
	foreach(player in players)
	{
		if(!isalive(player))
		{
			continue;
		}
		dot = self fwd_dot(player.origin);
		if(dot < 0.997)
		{
			continue;
		}
		if(!self cansee(player))
		{
			continue;
		}
		if(!isdefined(targetentity) || dot > targetdot)
		{
			targetentity = player;
			targetdot = dot;
		}
	}
	if(!isdefined(targetentity))
	{
		trace = self eye_trace(1);
		targetentity = trace[#"entity"];
	}
	if(isdefined(targetentity) && !isalive(targetentity))
	{
		return undefined;
	}
	return targetentity;
}

/*
	Name: function_5524bfd5
	Namespace: bot
	Checksum: 0x82F9879B
	Offset: 0x6408
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_5524bfd5(companionname)
{
	setdvar(#"companion", companionname);
}

/*
	Name: function_263ca697
	Namespace: bot
	Checksum: 0xF210F6EB
	Offset: 0x6440
	Size: 0x130
	Parameters: 0
	Flags: None
*/
function function_263ca697()
{
	/#
		weapon = self getcurrentweapon();
		setdvar(#"bot_spawn_weapon", function_a16a090d(weapon.rootweapon));
		setdvar(#"hash_c6e51858c88a5ee", util::function_2146bd83(weapon));
		bots = get_bots();
		foreach(bot in bots)
		{
			bot function_35e77034(weapon);
		}
	#/
}

/*
	Name: function_35e77034
	Namespace: bot
	Checksum: 0xF6080BB4
	Offset: 0x6578
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_35e77034(weapon)
{
	if(!isdefined(weapon) || weapon == level.weaponnone)
	{
		return;
	}
	self function_85e7342b();
	self giveweapon(weapon);
	self givemaxammo(weapon);
	self switchtoweaponimmediate(weapon);
	self setspawnweapon(weapon);
}

/*
	Name: function_85e7342b
	Namespace: bot
	Checksum: 0x5FE5A91F
	Offset: 0x6628
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_85e7342b()
{
	weapons = self getweaponslistprimaries();
	foreach(weapon in weapons)
	{
		self takeweapon(weapon);
	}
}

/*
	Name: should_record
	Namespace: bot
	Checksum: 0xE6358BEF
	Offset: 0x66C8
	Size: 0xB8
	Parameters: 1
	Flags: None
*/
function should_record(dvarstr)
{
	/#
		if(getdvarint(dvarstr, 0) <= 0)
		{
			return 0;
		}
		if(self == level)
		{
			return 1;
		}
		botnum = getdvarint(#"hash_457b3d0b71e0fd8a", 0);
		if(botnum < 0)
		{
			return 1;
		}
		ent = getentbynum(botnum);
		return isdefined(ent) && ent == self;
	#/
}

/*
	Name: record_text
	Namespace: bot
	Checksum: 0xE568615
	Offset: 0x6790
	Size: 0x64
	Parameters: 3
	Flags: None
*/
function record_text(text, textcolor, dvarstr)
{
	/#
		if(self should_record(dvarstr))
		{
			record3dtext(text, self.origin, textcolor, "", self, 0.5);
		}
	#/
}

/*
	Name: function_d45e8714
	Namespace: bot
	Checksum: 0xB774F98F
	Offset: 0x6800
	Size: 0x214
	Parameters: 0
	Flags: None
*/
function function_d45e8714()
{
	/#
		if(!self function_6b107944())
		{
			return;
		}
		interact = self function_f47bf51d();
		var_dda174e9 = self function_bba89736();
		origin = interact.origin;
		desc = "";
		if(self function_dd750ead())
		{
			desc = "";
		}
		else if(self function_914feddd())
		{
			desc = "";
		}
		else if(self function_e8a17817())
		{
			desc = "";
		}
		else if(self function_ca9fb875())
		{
			desc = "";
		}
		if(isdefined(var_dda174e9))
		{
			self function_1744d303(var_dda174e9, (0, 1, 0), "");
		}
		if(!isvec(origin))
		{
			if(isdefined(var_dda174e9))
			{
				origin = var_dda174e9.origin;
			}
			else
			{
				origin = self.origin;
			}
		}
		recordline(self.origin, origin, (0, 1, 0), "", self);
		recordsphere(origin, 8, (0, 1, 0), "", self);
		record3dtext(desc, origin, (1, 1, 1), "", undefined, 0.5);
	#/
}

/*
	Name: function_1744d303
	Namespace: bot
	Checksum: 0x44FE3581
	Offset: 0x6A20
	Size: 0x1BC
	Parameters: 3
	Flags: None
*/
function function_1744d303(trigger, color, channel)
{
	/#
		maxs = trigger getmaxs();
		mins = trigger getmins();
		if(issubstr(trigger.classname, ""))
		{
			radius = max(maxs[0], maxs[1]);
			top = trigger.origin + (0, 0, maxs[2]);
			bottom = trigger.origin + (0, 0, mins[2]);
			recordcircle(bottom, radius, color, channel, self);
			recordcircle(top, radius, color, channel, self);
			recordline(bottom, top, color, channel, self);
		}
		else
		{
			function_af72dbc5(trigger.origin, mins, maxs, trigger.angles[0], color, channel, self);
		}
	#/
}

/*
	Name: bot_joinleave_loop
	Namespace: bot
	Checksum: 0xD404E147
	Offset: 0x6BE8
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function bot_joinleave_loop()
{
	/#
		active = 0;
		while(true)
		{
			wait(1);
			joinleavecount = getdvarint(#"debug_bot_joinleave", 0);
			if(!joinleavecount)
			{
				if(active)
				{
					active = 0;
					remove_bots();
				}
				continue;
			}
			if(!active)
			{
				adddebugcommand("");
				active = 1;
			}
			botcount = bot_count();
			if(botcount > 0 && randomint(100) < 30)
			{
				remove_random_bot();
				wait(2);
			}
			else if(botcount < joinleavecount)
			{
				add_bot();
				wait(2);
			}
			wait(randomintrange(1, 3));
		}
	#/
}

/*
	Name: function_301f229d
	Namespace: bot
	Checksum: 0xDCACCBF
	Offset: 0x6D40
	Size: 0x640
	Parameters: 1
	Flags: Linked
*/
function function_301f229d(team)
{
	var_9e7013f = [];
	var_52e61055 = [];
	players = getplayers(team);
	foreach(player in players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(isdefined(player.revivetrigger))
		{
			if(!(isdefined(player.revivetrigger.beingrevived) && player.revivetrigger.beingrevived))
			{
				var_9e7013f[var_9e7013f.size] = player;
			}
			continue;
		}
		if(isbot(player))
		{
			if(!(isdefined(player.is_reviving_any) && player.is_reviving_any) && player ai::get_behavior_attribute("revive"))
			{
				var_52e61055[var_52e61055.size] = player;
			}
		}
	}
	assignments = [];
	foreach(bot in var_52e61055)
	{
		radius = bot getpathfindingradius();
		foreach(player in var_9e7013f)
		{
			distance = undefined;
			navmeshpoint = getclosestpointonnavmesh(player.origin, 64, radius);
			if(!isdefined(navmeshpoint))
			{
				continue;
			}
			if(tracepassedonnavmesh(bot.origin, navmeshpoint, 15))
			{
				distance = distance2d(bot.origin, navmeshpoint);
			}
			else
			{
				var_65c8979b = getclosestpointonnavmesh(bot.origin, 64, radius);
				if(!isdefined(var_65c8979b))
				{
					continue;
				}
				path = generatenavmeshpath(var_65c8979b, navmeshpoint, bot);
				if(!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0)
				{
					continue;
				}
				distance = path.pathdistance;
			}
			if(distance > 2000)
			{
				continue;
			}
			for(i = 0; i < assignments.size; i++)
			{
				if(distance < assignments[i].distance)
				{
					break;
				}
			}
			arrayinsert(assignments, {#distance:distance, #target:player, #bot:bot}, i);
		}
	}
	for(i = 0; i < assignments.size; i++)
	{
		assignment = assignments[i];
		if(assignment.bot get_revive_target() !== assignment.target)
		{
			assignment.bot set_revive_target(assignment.target);
			assignment.bot namespace_b20b4885::reset();
		}
		arrayremovevalue(var_52e61055, assignment.bot);
		j = i + 1;
		while(j < assignments.size)
		{
			var_ecf75b21 = assignments[j];
			if(var_ecf75b21.bot == assignment.bot || var_ecf75b21.target == assignment.target)
			{
				arrayremoveindex(assignments, j);
				continue;
			}
			j++;
		}
	}
	foreach(bot in var_52e61055)
	{
		if(isdefined(bot get_revive_target()))
		{
			bot clear_revive_target();
			bot namespace_b20b4885::reset();
		}
	}
}

/*
	Name: populate_bots
	Namespace: bot
	Checksum: 0x921FD392
	Offset: 0x7388
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function populate_bots()
{
	level endon(#"game_ended", #"hash_d3e36871aa6829f");
	var_c93ad421 = getdvarint(#"hash_688c3ba84e378e53", 0);
	if(var_c93ad421 > 0)
	{
		for(i = 0; i < var_c93ad421; i++)
		{
			bot = add_bot();
			if(!isdefined(bot))
			{
				return;
			}
			wait(0.5);
		}
		return;
	}
	if(level.teambased)
	{
		maxallies = getdvarint(#"bot_maxallies", 0);
		maxaxis = getdvarint(#"bot_maxaxis", 0);
		level thread monitor_bot_team_population(maxallies, maxaxis);
	}
	else
	{
		maxfree = getdvarint(#"bot_maxfree", 0);
		level thread monitor_bot_population(maxfree);
	}
}

/*
	Name: monitor_bot_team_population
	Namespace: bot
	Checksum: 0x9C0D9387
	Offset: 0x7518
	Size: 0x170
	Parameters: 2
	Flags: Linked
*/
function monitor_bot_team_population(maxallies, maxaxis)
{
	level endon(#"game_ended", #"hash_d3e36871aa6829f");
	if(!maxallies && !maxaxis)
	{
		return;
	}
	fill_balanced_teams(maxallies, maxaxis);
	while(true)
	{
		wait(3);
		allies = getplayers(#"allies");
		axis = getplayers(#"axis");
		if(allies.size > maxallies && remove_best_bot(allies))
		{
			continue;
		}
		if(axis.size > maxaxis && remove_best_bot(axis))
		{
			continue;
		}
		if(allies.size < maxallies || axis.size < maxaxis)
		{
			add_balanced_bot(allies, maxallies, axis, maxaxis);
		}
	}
}

/*
	Name: fill_balanced_teams
	Namespace: bot
	Checksum: 0xE10C1FFD
	Offset: 0x7690
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function fill_balanced_teams(maxallies, maxaxis)
{
	allies = getplayers(#"allies");
	axis = getplayers(#"axis");
	while(allies.size < maxallies || axis.size < maxaxis && add_balanced_bot(allies, maxallies, axis, maxaxis))
	{
		waitframe(1);
		allies = getplayers(#"allies");
		axis = getplayers(#"axis");
	}
}

/*
	Name: monitor_bot_population
	Namespace: bot
	Checksum: 0xF65DA7B2
	Offset: 0x7798
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function monitor_bot_population(maxfree)
{
	level endon(#"game_ended", #"hash_d3e36871aa6829f");
	if(!maxfree)
	{
		return;
	}
	players = getplayers();
	while(players.size < maxfree)
	{
		add_bot();
		waitframe(1);
		players = getplayers();
	}
	while(true)
	{
		wait(3);
		players = getplayers();
		if(players.size < maxfree)
		{
			add_bot();
		}
		else if(players.size > maxfree)
		{
			remove_best_bot(players);
		}
	}
}

/*
	Name: remove_best_bot
	Namespace: bot
	Checksum: 0x863F42C
	Offset: 0x78A0
	Size: 0x168
	Parameters: 1
	Flags: Linked
*/
function remove_best_bot(players)
{
	bots = filter_bots(players);
	if(!bots.size)
	{
		return 0;
	}
	bestbots = [];
	foreach(bot in bots)
	{
		if(bot.sessionstate == "spectator")
		{
			continue;
		}
		if(bot.sessionstate == "dead")
		{
			bestbots[bestbots.size] = bot;
		}
	}
	if(bestbots.size)
	{
		remove_bot(bestbots[randomint(bestbots.size)]);
	}
	else
	{
		remove_bot(bots[randomint(bots.size)]);
	}
	return 1;
}

