// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_utils.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace player;

/*
	Name: __init__
	Namespace: player
	Checksum: 0x322027AC
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__()
{
	callback::on_spawned(&on_player_spawned);
	callback::function_98a0917d(&function_98a0917d);
}

/*
	Name: spectate_player_watcher
	Namespace: player
	Checksum: 0x55FB28CF
	Offset: 0x140
	Size: 0x33C
	Parameters: 0
	Flags: Linked
*/
function spectate_player_watcher()
{
	self endon(#"disconnect");
	/#
		if(!level.splitscreen && !level.hardcoremode && getdvarint(#"scr_showperksonspawn", 0) == 1 && !gamestate::is_game_over() && !isdefined(self.perkhudelem))
		{
			if(level.perksenabled == 1)
			{
				self hud::showperks();
			}
		}
	#/
	self.watchingactiveclient = 1;
	while(true)
	{
		if(self.pers[#"team"] != #"spectator" || level.gameended)
		{
			if(!(isdefined(level.inprematchperiod) && level.inprematchperiod))
			{
				self val::reset(#"spectate", "freezecontrols");
				self val::reset(#"spectate", "disablegadgets");
			}
			self.watchingactiveclient = 0;
			break;
		}
		else
		{
			count = 0;
			for(i = 0; i < level.players.size; i++)
			{
				if(level.players[i].team != #"spectator")
				{
					count++;
					break;
				}
			}
			if(count > 0)
			{
				if(!self.watchingactiveclient)
				{
					self val::reset(#"spectate", "freezecontrols");
					self val::reset(#"spectate", "disablegadgets");
					self luinotifyevent(#"player_spawned", 0);
				}
				self.watchingactiveclient = 1;
			}
			else
			{
				if(self.watchingactiveclient)
				{
					[[level.onspawnspectator]]();
					self val::set(#"spectate", "freezecontrols", 1);
					self val::set(#"spectate", "disablegadgets", 1);
				}
				self.watchingactiveclient = 0;
			}
			wait(0.5);
		}
	}
}

/*
	Name: reset_doublexp_timer
	Namespace: player
	Checksum: 0x8304591C
	Offset: 0x488
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function reset_doublexp_timer()
{
	self notify(#"reset_doublexp_timer");
	self thread doublexp_timer();
}

/*
	Name: doublexp_timer
	Namespace: player
	Checksum: 0x28C2BEFE
	Offset: 0x4C0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function doublexp_timer()
{
	self notify(#"doublexp_timer");
	self endon(#"doublexp_timer", #"reset_doublexp_timer", #"end_game");
	level flagsys::wait_till("game_start_doublexp");
	if(!level.onlinegame)
	{
		return;
	}
	wait(60);
	if(level.onlinegame)
	{
		if(!isdefined(self))
		{
			return;
		}
		self doublexptimerfired();
	}
	self thread reset_doublexp_timer();
}

/*
	Name: on_player_spawned
	Namespace: player
	Checksum: 0x875FCEAC
	Offset: 0x588
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self thread doublexp_timer();
	if(util::is_frontend_map())
	{
		return;
	}
	self thread last_valid_position();
	if(function_8b1a219a())
	{
		self allowjump(0);
		wait(0.5);
		if(!isdefined(self))
		{
			return;
		}
		self allowjump(1);
	}
}

/*
	Name: function_98a0917d
	Namespace: player
	Checksum: 0xC032B4DB
	Offset: 0x638
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_98a0917d()
{
	level flagsys::set("game_start_doublexp");
}

/*
	Name: function_490dc3d3
	Namespace: player
	Checksum: 0xDE476740
	Offset: 0x668
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_490dc3d3()
{
	return self isinvehicle() && !self isremotecontrolling() && self function_a867284b() && self playerads() >= 1;
}

/*
	Name: function_c3eed624
	Namespace: player
	Checksum: 0xCDE62AF7
	Offset: 0x6E0
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_c3eed624()
{
	origin = self.origin;
	if(self function_490dc3d3())
	{
		forward = anglestoforward(self.angles);
		origin = origin + (forward * self function_85d25868());
		origin = origin - (0, 0, (isdefined(self.var_2d23ee07) ? self.var_2d23ee07 : 0));
	}
	return origin;
}

/*
	Name: last_valid_position
	Namespace: player
	Checksum: 0x1F945675
	Offset: 0x788
	Size: 0x290
	Parameters: 0
	Flags: Linked
*/
function last_valid_position()
{
	self endon(#"disconnect");
	self notify(#"stop_last_valid_position");
	self endon(#"stop_last_valid_position");
	while(!isdefined(self.last_valid_position) && isdefined(self))
	{
		origin = self function_c3eed624();
		self.last_valid_position = getclosestpointonnavmesh(origin, 2048, 0);
		wait(0.1);
	}
	while(isdefined(self))
	{
		origin = self function_c3eed624();
		if(getdvarint(#"hash_1a597b008cc91bd8", 0) > 0)
		{
			wait(1);
			continue;
		}
		playerradius = self getpathfindingradius();
		if(distance2dsquared(origin, self.last_valid_position) < (playerradius * playerradius) && (origin[2] - self.last_valid_position[2]) * (origin[2] - self.last_valid_position[2]) < (16 * 16))
		{
			wait(0.1);
			continue;
		}
		if(ispointonnavmesh(origin, self))
		{
			self.last_valid_position = origin;
		}
		else
		{
			if(!ispointonnavmesh(origin, self) && ispointonnavmesh(self.last_valid_position, self) && distance2dsquared(origin, self.last_valid_position) < (32 * 32))
			{
				wait(0.1);
				continue;
			}
			else
			{
				position = getclosestpointonnavmesh(origin, 100, playerradius);
				if(isdefined(position))
				{
					self.last_valid_position = position;
				}
			}
		}
		wait(0.1);
	}
}

