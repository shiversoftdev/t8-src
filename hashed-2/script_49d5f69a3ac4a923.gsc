// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_45decd627aedfc09;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_300327a7;

/*
	Name: init
	Namespace: namespace_300327a7
	Checksum: 0xE17986C
	Offset: 0x90
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function init()
{
	ai_state::function_e9b061a8(2, &function_b05ed2fa, &function_5c1be07d, undefined, &function_5d31deb6, &function_4af1ff64, &function_a78474f2);
}

/*
	Name: function_f9c30a79
	Namespace: namespace_300327a7
	Checksum: 0xE75B7443
	Offset: 0x100
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_f9c30a79(var_edc20efd)
{
	/#
		assert(isdefined(self.ai));
	#/
	self.ai.leave = {#hash_edc20efd:var_edc20efd, #state:0};
}

/*
	Name: function_4af1ff64
	Namespace: namespace_300327a7
	Checksum: 0x3B795903
	Offset: 0x170
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_4af1ff64()
{
	return self.ai.leave.var_edc20efd;
}

/*
	Name: function_a78474f2
	Namespace: namespace_300327a7
	Checksum: 0x8AB9C960
	Offset: 0x198
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function function_a78474f2()
{
	return self.origin;
}

/*
	Name: function_5d31deb6
	Namespace: namespace_300327a7
	Checksum: 0x7EF68A30
	Offset: 0x1B0
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_5d31deb6()
{
	if(isdefined(self.ai.hasseenfavoriteenemy) && self.ai.hasseenfavoriteenemy)
	{
		self.ai.leave.state = 2;
		return;
	}
	if(self.ai.leave.state != 1)
	{
		self thread function_b05ed2fa();
	}
}

/*
	Name: function_5c1be07d
	Namespace: namespace_300327a7
	Checksum: 0x80F724D1
	Offset: 0x238
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_5c1be07d()
{
}

/*
	Name: function_e35eee4d
	Namespace: namespace_300327a7
	Checksum: 0x9BD71F2D
	Offset: 0x248
	Size: 0x130
	Parameters: 0
	Flags: None
*/
function function_e35eee4d()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		players = getplayers();
		var_2282e309 = 0;
		foreach(player in players)
		{
			if(sighttracepassed(self geteye(), player geteye(), 0, undefined))
			{
				var_2282e309 = 1;
				break;
			}
		}
		if(!var_2282e309)
		{
			self delete();
		}
		wait(0.5);
	}
}

/*
	Name: function_b05ed2fa
	Namespace: namespace_300327a7
	Checksum: 0x11ACBD19
	Offset: 0x380
	Size: 0x164
	Parameters: 0
	Flags: None
*/
function function_b05ed2fa()
{
	self endon(#"death");
	self notify(#"hash_7b9527a0182f9b4f");
	self endon(#"hash_7b9527a0182f9b4f");
	self callback::callback(#"hash_c3f225c9fa3cb25");
	self.ai.leave.state = 1;
	if(!isdefined(self.exit_spawn))
	{
		util::wait_network_frame(2);
		self delete();
	}
	self thread function_e35eee4d();
	self function_d4c687c9();
	self pathmode("move allowed");
	self setgoal(self.exit_spawn.origin, 0, 32);
	self waittilltimeout(10, #"goal");
	waittillframeend();
	self delete();
}

/*
	Name: function_233ddd28
	Namespace: namespace_300327a7
	Checksum: 0xC710DF17
	Offset: 0x4F0
	Size: 0xFA
	Parameters: 2
	Flags: None
*/
function function_233ddd28(origin, team)
{
	spawns = level.spawn_start[team];
	closest = undefined;
	closest_dist = 10000000;
	foreach(spawn in spawns)
	{
		dist = distancesquared(spawn.origin, origin);
		if(dist < closest_dist)
		{
			closest_dist = dist;
			closest = spawn;
		}
	}
	return closest;
}

