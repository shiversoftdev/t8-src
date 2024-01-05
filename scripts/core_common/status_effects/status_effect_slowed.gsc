// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace status_effect_slowed;

/*
	Name: __init__system__
	Namespace: status_effect_slowed
	Checksum: 0x71CE94B1
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_slowed", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_slowed
	Checksum: 0x712371F0
	Offset: 0xD0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::register_status_effect_callback_apply(2, &slowed_apply);
	status_effect::function_5bae5120(2, &function_6fe78d40);
	status_effect::function_6f4eaf88(getstatuseffect("slowed"));
}

/*
	Name: slowed_apply
	Namespace: status_effect_slowed
	Checksum: 0xE6F9BAD5
	Offset: 0x148
	Size: 0x9E
	Parameters: 3
	Flags: Linked
*/
function slowed_apply(var_756fda07, weapon, applicant)
{
	self.owner.var_a010bd8f = applicant;
	self.owner.var_9060b065 = weapon;
	if(self.owner == applicant)
	{
		return;
	}
	var_c94d654b = applicant getentitynumber();
	if(!isdefined(self.owner.var_a4332cab))
	{
		self.owner.var_a4332cab = [];
	}
}

/*
	Name: function_6fe78d40
	Namespace: status_effect_slowed
	Checksum: 0xE3AF41B7
	Offset: 0x1F0
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_6fe78d40()
{
	if(isdefined(self.owner) && isdefined(self.owner.var_a010bd8f) && isdefined(self.owner.var_a010bd8f.var_9d19aa30))
	{
		self.owner.var_a010bd8f.var_9d19aa30 = 0;
	}
}

