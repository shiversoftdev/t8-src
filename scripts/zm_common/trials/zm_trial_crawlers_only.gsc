// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_crawlers_only;

/*
	Name: __init__system__
	Namespace: zm_trial_crawlers_only
	Checksum: 0x2F16565F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_crawlers_only", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_crawlers_only
	Checksum: 0x570C7E90
	Offset: 0xC0
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
	zm_trial::register_challenge(#"crawlers_only", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_crawlers_only
	Checksum: 0xDB340493
	Offset: 0x128
	Size: 0x62
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	level.var_6d8a8e47 = 1;
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	level.var_5e45f817 = 1;
	level.var_d1b3ec4e = level.var_9b91564e;
	level.var_9b91564e = undefined;
}

/*
	Name: on_end
	Namespace: zm_trial_crawlers_only
	Checksum: 0xC91FE998
	Offset: 0x198
	Size: 0x5E
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level.var_6d8a8e47 = 0;
	level.var_153e9058 = 0;
	level.var_fe2bb2ac = 0;
	level.var_5e45f817 = 0;
	level.var_9b91564e = level.var_d1b3ec4e;
	level.var_d1b3ec4e = undefined;
}

