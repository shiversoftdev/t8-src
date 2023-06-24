// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_force_archetypes;

/*
	Name: __init__system__
	Namespace: zm_trial_force_archetypes
	Checksum: 0xDCE73886
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_force_archetypes", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_force_archetypes
	Checksum: 0x80D17FF8
	Offset: 0xC8
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
	zm_trial::register_challenge(#"force_archetypes", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_force_archetypes
	Checksum: 0x2A92B1FD
	Offset: 0x130
	Size: 0xE6
	Parameters: 4
	Flags: Linked, Private
*/
function private on_begin(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c)
{
	archetypes = array::remove_undefined(array(var_34259a50, var_1d00ec07, var_10cad39b, var_f9ab255c), 0);
	self.var_c54c0d81 = [];
	foreach(archetype in archetypes)
	{
		self.var_c54c0d81[archetype] = 1;
	}
}

/*
	Name: on_end
	Namespace: zm_trial_force_archetypes
	Checksum: 0x6F532B18
	Offset: 0x220
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	self.var_c54c0d81 = undefined;
}

/*
	Name: function_ff2a74e7
	Namespace: zm_trial_force_archetypes
	Checksum: 0x11D91DE
	Offset: 0x240
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function function_ff2a74e7(archetype)
{
	challenge = zm_trial::function_a36e8c38(#"force_archetypes");
	if(!isdefined(challenge))
	{
		return 0;
	}
	return isdefined(challenge.var_c54c0d81[archetype]);
}

