// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_444bc5b4fa0fe14f;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_b3c73836;

/*
	Name: __init__system__
	Namespace: namespace_b3c73836
	Checksum: 0x128FE37C
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_5dd690a72d32d36f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b3c73836
	Checksum: 0x4936859E
	Offset: 0xD8
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
	zm_trial::register_challenge(#"hash_6fd9fed5c664bc96", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_b3c73836
	Checksum: 0x79625D33
	Offset: 0x140
	Size: 0x6E
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	level.var_43fb4347 = "super_sprint";
	level.var_102b1301 = "super_sprint";
	level.var_153e9058 = 1;
	level.var_fe2bb2ac = 1;
	if(!namespace_c56530a8::is_active())
	{
		level.var_5e45f817 = 1;
	}
}

/*
	Name: on_end
	Namespace: namespace_b3c73836
	Checksum: 0x75BB9B12
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

