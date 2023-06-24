// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_inventory.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_ui_inventory;

/*
	Name: __init__system__
	Namespace: zm_ui_inventory
	Checksum: 0x14F7B00D
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ui_inventory
	Checksum: 0xBB6D8B9A
	Offset: 0x128
	Size: 0x150
	Parameters: 0
	Flags: Linked, Private
*/
function private __init__()
{
	clientfield::function_78175813("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, undefined, 0, 0);
	zm_inventory::function_c7c05a13();
	registeredfields = [];
	foreach(mapping in level.var_a16c38d9)
	{
		if(!isdefined(registeredfields[mapping.var_cd35dfb2]))
		{
			registeredfields[mapping.var_cd35dfb2] = 1;
			var_9cf9ba9 = "worlduimodel";
			if(isdefined(mapping.var_7f12f171))
			{
				var_9cf9ba9 = "clientuimodel";
			}
			clientfield::register(var_9cf9ba9, mapping.var_cd35dfb2, 1, mapping.numbits, "int", undefined, 0, 0);
		}
	}
}

