// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;

#namespace namespace_3b9dec72;

/*
	Name: __init__system__
	Namespace: namespace_3b9dec72
	Checksum: 0x87E32590
	Offset: 0x120
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_56850a719f90825a", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3b9dec72
	Checksum: 0x913066D5
	Offset: 0x170
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	spawner::add_archetype_spawn_function(#"civilian", &function_e5ba4473);
	/#
		assert(isscriptfunctionptr(&function_b4b7cd20));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"ispablo", &function_b4b7cd20);
	/#
		zm_devgui::function_c7dd7a17("");
		adddebugcommand("");
		adddebugcommand("");
	#/
	level thread function_2165e851();
}

/*
	Name: __main__
	Namespace: namespace_3b9dec72
	Checksum: 0x80F724D1
	Offset: 0x280
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_4d231aa
	Namespace: namespace_3b9dec72
	Checksum: 0xCA040DD4
	Offset: 0x290
	Size: 0xA0
	Parameters: 0
	Flags: Private
*/
function private function_4d231aa()
{
	self endon(#"death");
	while(true)
	{
		wait(3);
		self setblackboardattribute("_stance", "crouch");
		wait(3);
		self setblackboardattribute("_stance", "stand");
		wait(3);
		self setblackboardattribute("_stance", "swim");
	}
}

/*
	Name: function_e5ba4473
	Namespace: namespace_3b9dec72
	Checksum: 0xA61393CE
	Offset: 0x338
	Size: 0x12C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e5ba4473()
{
	self.goalradius = 15;
	self.pushable = 0;
	self collidewithactors(0);
	self setavoidancemask("avoid none");
	if(self.aitype == "spawner_zm_pablo")
	{
		self.is_pablo = 1;
	}
	else
	{
		if(!isdefined(level.var_8a8728c6))
		{
			level.var_8a8728c6 = [];
		}
		level.var_8a8728c6[level.var_8a8728c6.size] = self;
		if(self.aitype == "spawner_zm_samantha")
		{
			self setblackboardattribute("_stance", "stand");
		}
		else
		{
			self setblackboardattribute("_stance", "crouch");
		}
	}
	/#
		self thread function_b7f08e2d();
	#/
}

/*
	Name: function_1c989dc4
	Namespace: namespace_3b9dec72
	Checksum: 0x12F5C737
	Offset: 0x470
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_1c989dc4()
{
	if(isdefined(level.var_8a8728c6) && level.var_8a8728c6.size >= 2)
	{
		samantha = level.var_8a8728c6[0];
		eddie = level.var_8a8728c6[1];
		samantha.pushable = 0;
		eddie.pushable = 0;
		var_e625df22 = anglestoforward(samantha.angles);
		samantha_right = vectorcross((0, 0, 1), var_e625df22) * -1;
		eddie forceteleport(samantha.origin + (samantha_right * 25), samantha.angles);
	}
}

/*
	Name: function_b7f08e2d
	Namespace: namespace_3b9dec72
	Checksum: 0x7AB27E91
	Offset: 0x578
	Size: 0xF0
	Parameters: 0
	Flags: Private
*/
function private function_b7f08e2d()
{
	self endon(#"death");
	while(true)
	{
		waitframe(1);
		enabled = getdvarint(#"hash_6ba94f3ad6709984", 0);
		if(enabled)
		{
			end = self getcentroid();
			var_1f2328d0 = self function_4794d6a3();
			if(isdefined(var_1f2328d0.goalpos))
			{
				/#
					sphere(var_1f2328d0.goalpos, 5, (0, 1, 0), 0.5, 0, 8, 1);
				#/
			}
		}
	}
}

/*
	Name: function_dca53f1f
	Namespace: namespace_3b9dec72
	Checksum: 0xF5619027
	Offset: 0x670
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dca53f1f(player_index)
{
	var_9a149315 = (0, 0, 0);
	if(isdefined(level.var_8a8728c6))
	{
		samantha = level.var_8a8728c6[0];
		var_b8e7e5da = (-100, -12.5, 0) + ((vectorscale((-1, 0, 0), 5)) * player_index);
		var_9a149315 = samantha.origin + rotatepointaroundaxis(var_b8e7e5da, (0, 0, 1), samantha.angles[1]);
	}
	return var_9a149315;
}

/*
	Name: function_303ab700
	Namespace: namespace_3b9dec72
	Checksum: 0x56EFAFB3
	Offset: 0x730
	Size: 0x256
	Parameters: 0
	Flags: Linked
*/
function function_303ab700()
{
	players = getplayers();
	player_index = 0;
	if(players.size > 0 && isdefined(level.var_8a8728c6) && isdefined(level.var_8a8728c6[0]))
	{
		foreach(player in players)
		{
			if(isdefined(player))
			{
				var_16a2c824 = player function_dca53f1f(player_index);
				samantha = level.var_8a8728c6[0];
				/#
					println("");
				#/
				player.var_fa2d1151 = spawn("script_model", var_16a2c824);
				player.var_fa2d1151.angles = samantha.angles;
				wait(1);
				if(isdefined(player) && isdefined(player.var_fa2d1151))
				{
					player dontinterpolate();
					player setorigin(var_16a2c824);
					player setplayerangles(samantha.angles);
					waitframe(1);
					/#
						println(("" + player.name) + "");
					#/
					function_8e56bb21(player, player.var_fa2d1151, var_16a2c824, samantha.angles);
					wait(1);
				}
				player_index++;
			}
		}
		level.var_41c80f7d = 1;
	}
}

/*
	Name: function_8e56bb21
	Namespace: namespace_3b9dec72
	Checksum: 0x32BFD2B5
	Offset: 0x990
	Size: 0x84
	Parameters: 4
	Flags: Linked
*/
function function_8e56bb21(player, script_model, origin, angles)
{
	player setorigin(origin);
	player setplayerangles(angles);
	player playerlinktodelta(script_model, undefined, 0, 30, 30, 15, 15);
}

/*
	Name: function_10add6a8
	Namespace: namespace_3b9dec72
	Checksum: 0x77B3CE52
	Offset: 0xA20
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_10add6a8()
{
	level.var_41c80f7d = 0;
}

/*
	Name: function_ddbe2dbb
	Namespace: namespace_3b9dec72
	Checksum: 0x6B454820
	Offset: 0xA40
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_ddbe2dbb(distance)
{
	foreach(npc in level.var_8a8728c6)
	{
		var_a04c5e3b = anglestoforward(npc.angles);
		npc.var_9a149315 = npc.origin + (anglestoforward(npc.angles) * distance);
		npc setgoal(npc.var_9a149315);
	}
}

/*
	Name: function_ae4d6b1b
	Namespace: namespace_3b9dec72
	Checksum: 0x1807DE97
	Offset: 0xB30
	Size: 0x9E
	Parameters: 0
	Flags: Private
*/
function private function_ae4d6b1b()
{
	players = getplayers();
	foreach(player in players)
	{
		player unlink();
	}
	level.var_41c80f7d = 0;
}

/*
	Name: function_2165e851
	Namespace: namespace_3b9dec72
	Checksum: 0xD30CD59C
	Offset: 0xBD8
	Size: 0x302
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2165e851()
{
	level endon(#"end_game");
	while(true)
	{
		waitframe(1);
		players = getplayers();
		if(players.size > 0 && isdefined(level.var_8a8728c6) && (isdefined(level.var_41c80f7d) && level.var_41c80f7d))
		{
			var_2e35e6c1 = 0;
			foreach(player in players)
			{
				v_movement = player getnormalizedmovement();
				if(v_movement[0] > 0.5)
				{
					var_2e35e6c1 = 1;
					break;
				}
			}
			foreach(npc in level.var_8a8728c6)
			{
				if(var_2e35e6c1)
				{
					var_a04c5e3b = anglestoforward(npc.angles);
					npc.var_9a149315 = npc.origin + (anglestoforward(npc.angles) * 100);
					npc setgoal(npc.var_9a149315);
					continue;
				}
				npc setgoal(npc.origin);
			}
			player_index = 0;
			foreach(player in players)
			{
				if(isdefined(player.var_fa2d1151))
				{
					var_9a149315 = player function_dca53f1f(player_index);
					player.var_fa2d1151 moveto(var_9a149315, 0.15);
				}
				player_index++;
			}
		}
	}
}

/*
	Name: function_b4b7cd20
	Namespace: namespace_3b9dec72
	Checksum: 0xD7E88E29
	Offset: 0xEE8
	Size: 0x48
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b4b7cd20(entity)
{
	result = 0;
	if(isdefined(entity.is_pablo) && entity.is_pablo)
	{
		result = 1;
	}
	return result;
}

