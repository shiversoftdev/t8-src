// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_trial_double_damage;

/*
	Name: __init__system__
	Namespace: zm_trial_double_damage
	Checksum: 0x9C7532D0
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_double_damage", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_double_damage
	Checksum: 0x1A56212D
	Offset: 0xE0
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
	zm_trial::register_challenge(#"double_damage", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_double_damage
	Checksum: 0xC2663EF1
	Offset: 0x148
	Size: 0xA6
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	self.var_42fe565a = level.var_c739ead9;
	self.var_8271882d = level.var_4d7e8b66;
	self.var_ecdf7fbe = level.var_1bb1a2fb;
	self.var_103c25d7 = level.var_5db2341c;
	self.var_97881ccb = level.var_53c7ca1d;
	level.var_c739ead9 = 2;
	level.var_4d7e8b66 = 2;
	level.var_1bb1a2fb = 2;
	level.var_5db2341c = 2;
	level.var_53c7ca1d = 2;
}

/*
	Name: on_end
	Namespace: zm_trial_double_damage
	Checksum: 0xA552D361
	Offset: 0x1F8
	Size: 0x6E
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level.var_c739ead9 = self.var_42fe565a;
	level.var_4d7e8b66 = self.var_8271882d;
	level.var_1bb1a2fb = self.var_ecdf7fbe;
	level.var_5db2341c = self.var_103c25d7;
	level.var_53c7ca1d = self.var_97881ccb;
}

/*
	Name: is_active
	Namespace: zm_trial_double_damage
	Checksum: 0x2F9E6846
	Offset: 0x270
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"double_damage");
	return isdefined(challenge);
}

