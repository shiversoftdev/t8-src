// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_5660bae5b402a1eb;
#using script_6ce38ab036223e6e;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_3f3f1a00;

/*
	Name: function_89f2df9
	Namespace: namespace_3f3f1a00
	Checksum: 0x39B7929B
	Offset: 0x138
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_d57f57fb8d115ff", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3f3f1a00
	Checksum: 0x6586FDBF
	Offset: 0x188
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_finalize_initialization(&init);
}

/*
	Name: __main__
	Namespace: namespace_3f3f1a00
	Checksum: 0x80F724D1
	Offset: 0x1B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_3f3f1a00
	Checksum: 0xE4EFEC
	Offset: 0x1C8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_2e4bdecf = getentarray("mdl_trap_button", "targetname");
	foreach(mdl_trap_button in level.var_2e4bdecf)
	{
		mdl_trap_button thread function_63be76e0();
	}
	level thread function_eac89317();
}

/*
	Name: function_bb013f42
	Namespace: namespace_3f3f1a00
	Checksum: 0x7672173C
	Offset: 0x290
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_bb013f42(str_id)
{
	foreach(mdl_trap_button in level.var_2e4bdecf)
	{
		if(mdl_trap_button.script_string === str_id)
		{
			mdl_trap_button thread function_8724b9c4();
		}
	}
}

/*
	Name: function_75046566
	Namespace: namespace_3f3f1a00
	Checksum: 0x20F8DA0E
	Offset: 0x330
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_75046566(str_id)
{
	foreach(mdl_trap_button in level.var_2e4bdecf)
	{
		if(mdl_trap_button.script_string === str_id)
		{
			mdl_trap_button thread function_a82eb7c1();
		}
	}
}

/*
	Name: function_eac89317
	Namespace: namespace_3f3f1a00
	Checksum: 0x1F65E01A
	Offset: 0x3D0
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function function_eac89317()
{
	level endon(#"game_ended");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = level waittill(#"traps_activated", #"traps_available");
		if(isdefined(var_385703b7.var_be3f58a))
		{
			if(var_385703b7._notify === "traps_activated")
			{
				function_bb013f42(var_385703b7.var_be3f58a);
			}
			else if(var_385703b7._notify === "traps_available")
			{
				function_75046566(var_385703b7.var_be3f58a);
			}
		}
	}
}

/*
	Name: function_63be76e0
	Namespace: namespace_3f3f1a00
	Checksum: 0x2196F89D
	Offset: 0x4B0
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_63be76e0()
{
	self.v_up = self.origin;
	var_a8f6c586 = struct::get(self.target, "targetname");
	self.v_down = var_a8f6c586.origin;
}

/*
	Name: function_8724b9c4
	Namespace: namespace_3f3f1a00
	Checksum: 0x7AEF87F4
	Offset: 0x510
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_8724b9c4()
{
	self moveto(self.v_down, 0.5);
}

/*
	Name: function_a82eb7c1
	Namespace: namespace_3f3f1a00
	Checksum: 0x7764448C
	Offset: 0x548
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_a82eb7c1()
{
	self moveto(self.v_up, 0.5);
}

