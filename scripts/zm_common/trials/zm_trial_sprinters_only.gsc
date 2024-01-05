// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_444bc5b4fa0fe14f;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_10ecac2c;

/*
	Name: __init__system__
	Namespace: namespace_10ecac2c
	Checksum: 0x1B3A55CB
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_6850ba7908370033", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_10ecac2c
	Checksum: 0x8BA725E7
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
	zm_trial::register_challenge(#"sprinters_only", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_10ecac2c
	Checksum: 0xA103F0AF
	Offset: 0x140
	Size: 0x6E
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	level.var_43fb4347 = "sprint";
	level.var_102b1301 = "sprint";
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	if(!namespace_c56530a8::is_active())
	{
		level.var_5e45f817 = 1;
	}
}

/*
	Name: on_end
	Namespace: namespace_10ecac2c
	Checksum: 0xB558038C
	Offset: 0x1B8
	Size: 0x46
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level.var_43fb4347 = undefined;
	level.var_102b1301 = undefined;
	level.var_153e9058 = 0;
	level.var_fe2bb2ac = 0;
	level.var_5e45f817 = 0;
}

