// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace namespace_980ebe0;

/*
	Name: __init__system__
	Namespace: namespace_980ebe0
	Checksum: 0x792C508B
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_503c1b9ec21992cc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_980ebe0
	Checksum: 0x6BD4A7F8
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_3493e071de24d8a1", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_980ebe0
	Checksum: 0x39F0BA5C
	Offset: 0x160
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(var_53c7b205 = #"1")
{
	level.var_53c7b205 = zm_trial::function_5769f26a(var_53c7b205);
	foreach(player in getplayers())
	{
		player thread function_13db986c(level.var_53c7b205);
	}
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_end
	Namespace: namespace_980ebe0
	Checksum: 0xA6FEC0EA
	Offset: 0x260
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::remove_on_spawned(&on_player_spawned);
	level.var_53c7b205 = undefined;
}

/*
	Name: on_player_spawned
	Namespace: namespace_980ebe0
	Checksum: 0xC0896B0E
	Offset: 0x2A0
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_spawned()
{
	self thread function_13db986c(level.var_53c7b205);
}

/*
	Name: function_13db986c
	Namespace: namespace_980ebe0
	Checksum: 0xF75248D9
	Offset: 0x2D0
	Size: 0xD6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_13db986c(var_53c7b205)
{
	self notify("48c46c9de397db92");
	self endon("48c46c9de397db92");
	self endon(#"death");
	level endon(#"hash_7646638df88a3656", #"end_game");
	self waittill(#"hash_7a32b2af2eef5415");
	while(true)
	{
		if(isalive(self) && !self laststand::player_is_in_laststand())
		{
			self dodamage(var_53c7b205, self.origin);
		}
		wait(1);
	}
}

