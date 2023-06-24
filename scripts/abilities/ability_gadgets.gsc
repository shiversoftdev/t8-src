// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_player.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace ability_gadgets;

/*
	Name: __init__system__
	Namespace: ability_gadgets
	Checksum: 0xB535C90C
	Offset: 0x160
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"ability_gadgets", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: ability_gadgets
	Checksum: 0x321175B6
	Offset: 0x1A8
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	callback::on_spawned(&on_player_spawned);
	clientfield::register("clientuimodel", "huditems.abilityHoldToActivate", 1, 2, "int");
	clientfield::register("clientuimodel", "huditems.abilityDelayProgress", 1, 5, "float");
	clientfield::register("clientuimodel", "hudItems.abilityHintIndex", 1, 3, "int");
}

/*
	Name: gadgets_print
	Namespace: ability_gadgets
	Checksum: 0x3C97DE0
	Offset: 0x288
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function gadgets_print(str)
{
	/#
		if(getdvarint(#"scr_debug_gadgets", 0))
		{
			toprint = str;
			println(((self.playername + "") + "") + toprint);
		}
	#/
}

/*
	Name: on_player_connect
	Namespace: ability_gadgets
	Checksum: 0x80F724D1
	Offset: 0x308
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
}

/*
	Name: setflickering
	Namespace: ability_gadgets
	Checksum: 0x3B9B083B
	Offset: 0x318
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function setflickering(slot, length = 0)
{
	self gadgetflickering(slot, 1, length);
}

/*
	Name: on_player_spawned
	Namespace: ability_gadgets
	Checksum: 0x80F724D1
	Offset: 0x368
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
}

/*
	Name: gadget_give_callback
	Namespace: ability_gadgets
	Checksum: 0xDE1B292C
	Offset: 0x378
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event gadget_give_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::give_gadget(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_take_callback
	Namespace: ability_gadgets
	Checksum: 0x24E85D8E
	Offset: 0x400
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event gadget_take_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::take_gadget(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_primed_callback
	Namespace: ability_gadgets
	Checksum: 0x9074F374
	Offset: 0x488
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event gadget_primed_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::gadget_primed(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_ready_callback
	Namespace: ability_gadgets
	Checksum: 0x5FDD03A7
	Offset: 0x510
	Size: 0xEC
	Parameters: 1
	Flags: Event
*/
event gadget_ready_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	if(level flag::get("all_players_spawned"))
	{
		params = {#slot:eventstruct.slot};
		voiceevent("specialist_equipment_ready", eventstruct.entity, params);
	}
	eventstruct.entity ability_player::gadget_ready(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_on_callback
	Namespace: ability_gadgets
	Checksum: 0x55782023
	Offset: 0x608
	Size: 0xEC
	Parameters: 1
	Flags: Event
*/
event gadget_on_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	if(level flag::get("all_players_spawned"))
	{
		params = {#slot:eventstruct.slot};
		voiceevent("specialist_equipment_using", eventstruct.entity, params);
	}
	eventstruct.entity ability_player::turn_gadget_on(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_off_callback
	Namespace: ability_gadgets
	Checksum: 0xB45B88EE
	Offset: 0x700
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event gadget_off_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::turn_gadget_off(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: function_40d8d1ec
	Namespace: ability_gadgets
	Checksum: 0x3F5DF80B
	Offset: 0x788
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event function_40d8d1ec(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::function_50557027(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: function_15061ae6
	Namespace: ability_gadgets
	Checksum: 0x723A280E
	Offset: 0x810
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event function_15061ae6(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::function_d5260ebe(eventstruct.slot, eventstruct.weapon);
}

/*
	Name: gadget_flicker_callback
	Namespace: ability_gadgets
	Checksum: 0x645B3FE5
	Offset: 0x898
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event gadget_flicker_callback(eventstruct)
{
	/#
		eventstruct.entity gadgets_print(("" + eventstruct.slot) + "");
	#/
	eventstruct.entity ability_player::gadget_flicker(eventstruct.slot, eventstruct.weapon);
}

