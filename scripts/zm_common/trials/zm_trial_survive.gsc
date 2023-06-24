// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_survive;

/*
	Name: __init__system__
	Namespace: zm_trial_survive
	Checksum: 0x85A5D5A7
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_survive", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_survive
	Checksum: 0x4CF7F062
	Offset: 0xC0
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
	zm_trial::register_challenge(#"survive", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_survive
	Checksum: 0x80F724D1
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
}

/*
	Name: on_end
	Namespace: zm_trial_survive
	Checksum: 0x7A8F865E
	Offset: 0x138
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
}

