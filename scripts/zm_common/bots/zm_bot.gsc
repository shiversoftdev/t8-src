// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\bots\zm_bot_position.gsc;
#using scripts\zm_common\bots\zm_bot_action.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\ai_shared.gsc;

#namespace zm_bot;

/*
	Name: __init__system__
	Namespace: zm_bot
	Checksum: 0xA97B3094
	Offset: 0x1A0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_bot
	Checksum: 0x30C771FB
	Offset: 0x1E8
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	callback::on_player_killed(&on_player_killed);
	callback::on_disconnect(&on_player_disconnect);
	callback::on_laststand(&on_player_laststand);
	callback::on_revived(&on_player_revived);
	callback::on_start_gametype(&init);
	level.var_df0a0911 = "bot_tacstate_zm_default";
	level.var_258cdebb = "bot_tacstate_zm_laststand";
	level.onbotconnect = &on_bot_connect;
	level.onbotspawned = &on_bot_spawned;
	level.var_34eb792d = &handleplayerfasttravel;
	level.zm_bots_scale = getdvarint(#"zm_bots_scale", 1);
}

/*
	Name: init
	Namespace: zm_bot
	Checksum: 0x9EA4605C
	Offset: 0x378
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level endon(#"game_ended");
	botsoak = isdedicated() && getdvarint(#"sv_botsoak", 0);
	if(!botsoak)
	{
		level flag::wait_till("all_players_connected");
	}
	level thread bot::populate_bots();
}

/*
	Name: on_bot_connect
	Namespace: zm_bot
	Checksum: 0x80F724D1
	Offset: 0x420
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_bot_connect()
{
}

/*
	Name: on_bot_spawned
	Namespace: zm_bot
	Checksum: 0xA296AD7F
	Offset: 0x430
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function on_bot_spawned()
{
	self.bot.var_b2b8f0b6 = 150;
	self.bot.var_e8c941d6 = 300;
}

/*
	Name: on_player_connect
	Namespace: zm_bot
	Checksum: 0x7C267BB6
	Offset: 0x468
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(isbot(self))
	{
		self botclassadditem(0, "perk_electric_cherry");
		self botclassadditem(0, "perk_staminup");
		self botclassadditem(0, "perk_quick_revive");
		self botclassadditem(0, "perk_dead_shot");
		self botclassadditem(0, "hero_chakram_lv1");
	}
}

/*
	Name: on_player_spawned
	Namespace: zm_bot
	Checksum: 0x92282D82
	Offset: 0x530
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	level bot::function_301f229d(self.team);
	self thread function_69745ea0();
	self function_70e42260();
}

/*
	Name: function_70e42260
	Namespace: zm_bot
	Checksum: 0xADADA31C
	Offset: 0x590
	Size: 0x62
	Parameters: 0
	Flags: Linked, Private
*/
function private function_70e42260()
{
	if(isprofilebuild())
	{
		if(getdvarint(#"scr_botsoaktest", 0))
		{
			if(isbot(self))
			{
				self.allowdeath = 0;
			}
		}
	}
}

/*
	Name: on_player_killed
	Namespace: zm_bot
	Checksum: 0x74C98BA6
	Offset: 0x600
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function on_player_killed()
{
	if(isbot(self))
	{
		self bot::clear_revive_target();
	}
	level bot::function_301f229d(self.team);
}

/*
	Name: on_player_disconnect
	Namespace: zm_bot
	Checksum: 0x899F96DC
	Offset: 0x660
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	level bot::function_301f229d(self.team);
}

/*
	Name: on_player_laststand
	Namespace: zm_bot
	Checksum: 0xA63624F2
	Offset: 0x690
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function on_player_laststand()
{
	if(isbot(self))
	{
		self bot::clear_revive_target();
	}
	waitframe(1);
	if(!isdefined(self))
	{
		return;
	}
	level bot::function_301f229d(self.team);
}

/*
	Name: on_player_revived
	Namespace: zm_bot
	Checksum: 0xE935900C
	Offset: 0x700
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_player_revived(params)
{
	level bot::function_301f229d(self.team);
}

/*
	Name: function_9b83de0f
	Namespace: zm_bot
	Checksum: 0xA2D404A
	Offset: 0x738
	Size: 0x104
	Parameters: 0
	Flags: Event
*/
event function_9b83de0f()
{
	/#
		if(getdvarint(#"zm_bot_orders", 0) == 0)
		{
			return;
		}
		players = getplayers();
		players = arraysort(players, self.origin);
		foreach(player in players)
		{
			if(!isbot(player))
			{
				continue;
			}
			self order_bot(player);
			break;
		}
	#/
}

/*
	Name: order_bot
	Namespace: zm_bot
	Checksum: 0x8F8CEBC4
	Offset: 0x848
	Size: 0x336
	Parameters: 1
	Flags: None
*/
function order_bot(bot)
{
	target = undefined;
	targetdistsq = undefined;
	targetdot = undefined;
	foreach(wallbuy in level._spawned_wallbuys)
	{
		distsq = distancesquared(self.origin, wallbuy.origin);
		if(distsq > 262144)
		{
			continue;
		}
		dot = self bot::fwd_dot(wallbuy.origin);
		if(dot < 0.985)
		{
			continue;
		}
		if(!isdefined(target) || dot > targetdot)
		{
			target = wallbuy;
			targetdistsq = distsq;
			targetdot = dot;
		}
	}
	if(isdefined(target))
	{
		/#
			iprintlnbold((bot.name + "") + target.zombie_weapon_upgrade);
		#/
		bot bot::set_interact(target);
		return;
	}
	doors = getentarray("zombie_door", "targetname");
	targetdistsq = undefined;
	targetdot = undefined;
	foreach(door in doors)
	{
		if(door._door_open)
		{
			continue;
		}
		distsq = distancesquared(self.origin, door.origin);
		if(distsq > 262144)
		{
			continue;
		}
		dot = self bot::fwd_dot(door.origin);
		if(dot < 0.985)
		{
			continue;
		}
		if(!isdefined(target) || dot > targetdot)
		{
			target = door;
			targetdistsq = distsq;
			targetdot = dot;
		}
	}
	if(isdefined(target))
	{
		/#
			iprintlnbold(bot.name + "");
		#/
		bot bot::set_interact(target);
		return;
	}
}

/*
	Name: function_69745ea0
	Namespace: zm_bot
	Checksum: 0x36FCB5C0
	Offset: 0xB88
	Size: 0x230
	Parameters: 0
	Flags: Linked
*/
function function_69745ea0()
{
	self endon(#"death", #"disconnect");
	self notify(#"hash_6b46933396f9db04");
	self endon(#"hash_6b46933396f9db04");
	while(isdefined(self))
	{
		if(isbot(self))
		{
			maxsightdist = sqrt(self.maxsightdistsqrd);
			allenemies = self getenemiesinradius(self.origin, maxsightdist);
			allenemies = arraysortclosest(allenemies, self.origin);
			visibleenemy = allenemies[0];
			foreach(enemy in allenemies)
			{
				if(self cansee(enemy, 2500))
				{
					visibleenemy = enemy;
					break;
				}
			}
			if(isdefined(visibleenemy) && isdefined(self.favoriteenemy) && self cansee(self.favoriteenemy, 2500))
			{
				if(distance(self.origin, visibleenemy.origin) < distance(self.origin, self.favoriteenemy.origin) * 0.9)
				{
					self.favoriteenemy = visibleenemy;
				}
			}
			else
			{
				self.favoriteenemy = visibleenemy;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_e16b5033
	Namespace: zm_bot
	Checksum: 0xBF1C416E
	Offset: 0xDC0
	Size: 0x2CC
	Parameters: 1
	Flags: Linked
*/
function function_e16b5033(actor)
{
	if(!isdefined(level.var_faf67c27))
	{
		level.var_faf67c27 = [];
	}
	if(!isdefined(level.var_faf67c27[actor.archetype]))
	{
		level.var_faf67c27[actor.archetype] = spawnstruct();
		level.var_faf67c27[actor.archetype].round_number = -1;
		min_health = 100;
		var_6109b81d = 0;
		if(isdefined(actor ai::function_9139c839()))
		{
			min_health = actor ai::function_9139c839().minhealth;
			var_6109b81d = actor ai::function_9139c839().var_854eebd;
		}
		level.var_faf67c27[actor.archetype].min_health = min_health;
		level.var_faf67c27[actor.archetype].var_6109b81d = var_6109b81d;
	}
	if(level.var_faf67c27[actor.archetype].round_number != level.round_number)
	{
		override_round_num = undefined;
		if(isdefined(actor._starting_round_number))
		{
			override_round_num = actor._starting_round_number;
		}
		if(actor.archetype == #"zombie")
		{
			max_health = float(level.zombie_health);
		}
		else
		{
			max_health = float(actor zm_ai_utility::function_8d44707e(level.var_faf67c27[actor.archetype].var_6109b81d, override_round_num));
		}
		level.var_faf67c27[actor.archetype].scale = max_health / level.var_faf67c27[actor.archetype].min_health;
		level.var_faf67c27[actor.archetype].round_number = level.round_number;
	}
	return level.var_faf67c27[actor.archetype].scale * 1;
}

/*
	Name: function_1f9de69d
	Namespace: zm_bot
	Checksum: 0x54C7551C
	Offset: 0x1098
	Size: 0xE0
	Parameters: 1
	Flags: Linked
*/
function function_1f9de69d(var_40b86c4b)
{
	if(!isdefined(var_40b86c4b))
	{
		return false;
	}
	players = getplayers();
	foreach(player in players)
	{
		if(isbot(player))
		{
			continue;
		}
		currentzone = player zm_utility::get_current_zone();
		if(currentzone === var_40b86c4b)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: handleplayerfasttravel
	Namespace: zm_bot
	Checksum: 0x47C5A149
	Offset: 0x1180
	Size: 0x200
	Parameters: 2
	Flags: Linked
*/
function handleplayerfasttravel(player, var_12230d08)
{
	player endon(#"death");
	level notify(#"handleplayerfasttravel");
	level endon(#"handleplayerfasttravel");
	if(!isdefined(var_12230d08))
	{
		return;
	}
	wait(3);
	currentzone = player zm_utility::get_current_zone();
	currentorigin = player.origin;
	if(!isdefined(currentzone))
	{
		return;
	}
	players = getplayers();
	foreach(player in players)
	{
		if(!isbot(player))
		{
			continue;
		}
		var_40b86c4b = player zm_utility::get_current_zone();
		if(var_40b86c4b === currentzone)
		{
			continue;
		}
		if(function_1f9de69d(var_40b86c4b))
		{
			continue;
		}
		if(isdefined(level.var_1dbf5163) && ![[level.var_1dbf5163]](player))
		{
			continue;
		}
		if(isdefined(level.var_3c84697b))
		{
			player thread [[level.var_3c84697b]](var_12230d08);
			continue;
		}
		player setorigin(currentorigin);
		player dontinterpolate();
	}
}

