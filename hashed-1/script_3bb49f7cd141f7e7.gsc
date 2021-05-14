// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\bgbs\zm_bgb_anywhere_but_here.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_5c493a54;

/*
	Name: function_89f2df9
	Namespace: namespace_5c493a54
	Checksum: 0xB3CF4C35
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_23b914dca866a297", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5c493a54
	Checksum: 0xD56CDB6D
	Offset: 0xE8
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
	zm_trial::register_challenge(#"hash_b7f913776f85df2", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_5c493a54
	Checksum: 0x4A2E8EB4
	Offset: 0x150
	Size: 0x108
	Parameters: 3
	Flags: Private
*/
private function function_d1de6a85(var_2e5ed433, var_1532dab3, var_94d24883)
{
	level.var_2e5ed433 = zm_trial::function_5769f26a(var_2e5ed433) * 1000;
	if(isdefined(var_1532dab3))
	{
		var_1532dab3 = zm_trial::function_5769f26a(var_1532dab3);
	}
	if(isdefined(var_94d24883))
	{
		var_94d24883 = zm_trial::function_5769f26a(var_94d24883);
	}
	foreach(player in getplayers())
	{
		player thread point_watcher(var_1532dab3, var_94d24883);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_5c493a54
	Checksum: 0xC0711C14
	Offset: 0x260
	Size: 0x28
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_2e5ed433 = undefined;
	level notify(#"hash_2669c6e7b1eb2e4b");
}

/*
	Name: is_active
	Namespace: namespace_5c493a54
	Checksum: 0x614DF3E5
	Offset: 0x290
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_b7f913776f85df2");
	return isdefined(challenge);
}

/*
	Name: point_watcher
	Namespace: namespace_5c493a54
	Checksum: 0x36039051
	Offset: 0x2D0
	Size: 0x11C
	Parameters: 2
	Flags: Private
*/
private function point_watcher(var_1532dab3 = 1, var_94d24883 = 0.9)
{
	level endon(#"hash_2669c6e7b1eb2e4b", #"end_game", #"hash_7646638df88a3656");
	self endon(#"disconnect");
	wait(15);
	while(true)
	{
		if(isalive(self) && !self laststand::player_is_in_laststand() && isdefined(self.score) && self.score > level.var_2e5ed433)
		{
			self dodamage(var_1532dab3, self.origin);
			wait(var_94d24883);
		}
		waitframe(1);
	}
}

