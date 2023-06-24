// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_6c76c1da;

/*
	Name: __init__system__
	Namespace: namespace_6c76c1da
	Checksum: 0xA5E1122E
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_escape_forge_magmagat", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6c76c1da
	Checksum: 0x8D3C4E98
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"forge_magmagat", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_6c76c1da
	Checksum: 0xD6A8D76B
	Offset: 0x148
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	level.var_e60b8c3a = undefined;
	level thread function_a543a954();
}

/*
	Name: on_end
	Namespace: namespace_6c76c1da
	Checksum: 0xE9E23EC0
	Offset: 0x178
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	if(!round_reset && (!(isdefined(level.var_e60b8c3a) && level.var_e60b8c3a)))
	{
		zm_trial::fail(#"hash_12f3fd15a168901");
	}
	level.var_e60b8c3a = undefined;
}

/*
	Name: function_a543a954
	Namespace: namespace_6c76c1da
	Checksum: 0x6D8B50C2
	Offset: 0x1F8
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a543a954()
{
	level endon(#"hash_7646638df88a3656");
	level waittill(#"hash_5dc448a84a24492", #"hash_38c04d24b5213b00");
	level.var_e60b8c3a = 1;
	zm_trial_util::function_7d32b7d0(1);
}

