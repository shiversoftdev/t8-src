// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_use_magicbox;

/*
	Name: __init__system__
	Namespace: zm_trial_use_magicbox
	Checksum: 0x5B4008D8
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_use_magicbox", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_use_magicbox
	Checksum: 0xAB5E244B
	Offset: 0xD8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"use_magicbox", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_use_magicbox
	Checksum: 0x5F350258
	Offset: 0x140
	Size: 0x108
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_519131bc = 1)
{
	callback::function_b3c9adb7(&function_b3c9adb7);
	if(ishash(var_519131bc))
	{
		level.var_519131bc = zm_trial::function_5769f26a(var_519131bc);
	}
	else
	{
		level.var_519131bc = var_519131bc;
	}
	foreach(player in getplayers())
	{
		player thread function_1685cc9b();
	}
}

/*
	Name: on_end
	Namespace: zm_trial_use_magicbox
	Checksum: 0x2C4F4973
	Offset: 0x250
	Size: 0x1D4
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player zm_trial_util::function_f3aacffb();
	}
	if(!round_reset)
	{
		var_57807cdc = [];
		foreach(player in getplayers())
		{
			if(player.var_8f30dd57 < level.var_519131bc)
			{
				array::add(var_57807cdc, player, 0);
			}
			player.var_8f30dd57 = undefined;
		}
		if(var_57807cdc.size == 1)
		{
			zm_trial::fail(#"hash_9c83a93f783b8e4", var_57807cdc);
		}
		else if(var_57807cdc.size > 1)
		{
			zm_trial::fail(#"hash_484dffbaa43c048d", var_57807cdc);
		}
	}
	level.var_519131bc = undefined;
	callback::function_342b2f6(&function_b3c9adb7);
}

/*
	Name: function_1685cc9b
	Namespace: zm_trial_use_magicbox
	Checksum: 0xFF313791
	Offset: 0x430
	Size: 0x110
	Parameters: 0
	Flags: Private
*/
function private function_1685cc9b()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	var_fa5d7ea0 = 0;
	self.var_8f30dd57 = 0;
	var_6bec3070 = 0;
	self zm_trial_util::function_2190356a(self.var_8f30dd57);
	self zm_trial_util::function_c2cd0cba(level.var_519131bc);
	while(true)
	{
		self waittill(#"hash_b0cc77b1ab98c08");
		if(self.var_8f30dd57 == level.var_519131bc)
		{
			self zm_trial_util::function_63060af4(1);
		}
		else if(self.var_8f30dd57 < level.var_519131bc)
		{
			self zm_trial_util::function_2190356a(self.var_8f30dd57);
		}
	}
}

/*
	Name: function_b3c9adb7
	Namespace: zm_trial_use_magicbox
	Checksum: 0x11A7102B
	Offset: 0x548
	Size: 0x3E
	Parameters: 1
	Flags: Private
*/
function private function_b3c9adb7(weapon)
{
	self.var_8f30dd57++;
	self notify(#"hash_b0cc77b1ab98c08", {#weapon:weapon});
}

