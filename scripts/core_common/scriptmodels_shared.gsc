// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace scriptmodels;

/*
	Name: function_89f2df9
	Namespace: scriptmodels
	Checksum: 0x151079A9
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"scriptmodels", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: scriptmodels
	Checksum: 0x330CF53
	Offset: 0xF0
	Size: 0x98
	Parameters: 0
	Flags: None
*/
function __init__()
{
	a_script_models = getentarraybytype(6);
	foreach(model in a_script_models)
	{
		function_9abee270(model);
	}
}

/*
	Name: function_9abee270
	Namespace: scriptmodels
	Checksum: 0x4FDC61CA
	Offset: 0x190
	Size: 0x13C
	Parameters: 1
	Flags: Private
*/
private function function_9abee270(model)
{
	/#
		assert(isdefined(model));
	#/
	if(model.classname != "script_model" && model.classname != "script_brushmodel")
	{
		return;
	}
	if(isdefined(model.script_health))
	{
		model.health = model.script_health;
		model.maxhealth = model.script_health;
		model.takedamage = 1;
	}
	if(isdefined(model.var_3ee8e0e2) && model.var_3ee8e0e2)
	{
		model util::function_c596f193();
	}
	if(isdefined(model.script_team) && model.script_team != "none")
	{
		model.team = model.script_team;
		model setteam(model.script_team);
	}
}

