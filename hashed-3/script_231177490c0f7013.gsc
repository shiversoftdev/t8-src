// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d2e98050575ce0b;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\util.gsc;

#namespace gadget_radiation_field;

/*
	Name: function_89f2df9
	Namespace: gadget_radiation_field
	Checksum: 0x54B7FBA7
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"gadget_radiation_field", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: gadget_radiation_field
	Checksum: 0xCFAA3683
	Offset: 0xE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_shared();
	function_6ca75924(&function_4a9c8bba);
}

/*
	Name: function_4a9c8bba
	Namespace: gadget_radiation_field
	Checksum: 0x5BAC26AB
	Offset: 0x128
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_4a9c8bba(var_d90c942a)
{
	self battlechatter::function_bd715920(var_d90c942a, undefined, self geteye(), self);
}

