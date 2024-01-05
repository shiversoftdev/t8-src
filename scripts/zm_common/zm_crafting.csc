// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_progress.csc;
#using scripts\zm_common\zm_items.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace zm_crafting;

/*
	Name: __init__system__
	Namespace: zm_crafting
	Checksum: 0xBA45476A
	Offset: 0xD0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_crafting", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_crafting
	Checksum: 0x7AA1E174
	Offset: 0x120
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_5df2581a = [];
	level.crafting_components = [];
}

/*
	Name: __main__
	Namespace: zm_crafting
	Checksum: 0xEDA5E7A6
	Offset: 0x148
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	function_60a6c623();
}

/*
	Name: function_60a6c623
	Namespace: zm_crafting
	Checksum: 0x3C4DB8B9
	Offset: 0x168
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_60a6c623()
{
	foundries = getscriptbundles("craftfoundry");
	foreach(foundry in foundries)
	{
		setup_craftfoundry(foundry);
	}
}

/*
	Name: setup_craftfoundry
	Namespace: zm_crafting
	Checksum: 0xCFCEF004
	Offset: 0x208
	Size: 0x262
	Parameters: 1
	Flags: Linked
*/
function setup_craftfoundry(craftfoundry)
{
	if(isdefined(craftfoundry))
	{
		if(!(isdefined(craftfoundry.loaded) && craftfoundry.loaded))
		{
			craftfoundry.loaded = 1;
			craftfoundry.blueprints = [];
			switch(craftfoundry.var_2a2adea3)
			{
				case 8:
				{
					craftfoundry.blueprints[7] = function_b18074d0(craftfoundry.var_b81b4995);
				}
				case 7:
				{
					craftfoundry.blueprints[6] = function_b18074d0(craftfoundry.var_5e039567);
				}
				case 6:
				{
					craftfoundry.blueprints[5] = function_b18074d0(craftfoundry.var_b84049db);
				}
				case 5:
				{
					craftfoundry.blueprints[4] = function_b18074d0(craftfoundry.var_5dee9539);
				}
				case 4:
				{
					craftfoundry.blueprints[3] = function_b18074d0(craftfoundry.var_93b280c0);
				}
				case 3:
				{
					craftfoundry.blueprints[2] = function_b18074d0(craftfoundry.var_a980ac5c);
				}
				case 2:
				{
					craftfoundry.blueprints[1] = function_b18074d0(craftfoundry.var_339dfcd);
				}
				case 1:
				{
					craftfoundry.blueprints[0] = function_b18074d0(craftfoundry.var_110b7b70);
				}
			}
		}
	}
}

/*
	Name: function_b18074d0
	Namespace: zm_crafting
	Checksum: 0x27C0D754
	Offset: 0x478
	Size: 0x328
	Parameters: 1
	Flags: Linked
*/
function function_b18074d0(name)
{
	blueprint = getscriptbundle(name);
	if(isdefined(blueprint))
	{
		if(!(isdefined(blueprint.loaded) && blueprint.loaded))
		{
			blueprint.loaded = 1;
			blueprint.name = name;
			blueprint.components = [];
			switch(blueprint.var_f4a82731)
			{
				case 8:
				{
					blueprint.components[7] = get_component(blueprint.var_f4d434cb);
				}
				case 7:
				{
					blueprint.components[6] = get_component(blueprint.var_e71f1961);
				}
				case 6:
				{
					blueprint.components[5] = get_component(blueprint.registerperk_packa_seepainterminate);
				}
				case 5:
				{
					blueprint.components[4] = get_component(blueprint.var_4282502a);
				}
				case 4:
				{
					blueprint.components[3] = get_component(blueprint.var_7b8e4241);
				}
				case 3:
				{
					blueprint.components[2] = get_component(blueprint.var_2e0a273a);
				}
				case 2:
				{
					blueprint.components[1] = get_component(blueprint.var_670f9944);
				}
				case 1:
				{
					blueprint.components[0] = get_component(blueprint.var_99577dd3);
				}
			}
			blueprint.var_54a97edd = get_component(blueprint.result);
			level.var_5df2581a[name] = blueprint;
			if(!isdefined(blueprint.var_4dbc4aee))
			{
				blueprint.var_4dbc4aee = "ERROR: Missing Prompt String";
			}
		}
	}
	else
	{
		/#
			assertmsg("" + name);
		#/
	}
	return blueprint;
}

/*
	Name: get_component
	Namespace: zm_crafting
	Checksum: 0xD23D3877
	Offset: 0x7A8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function get_component(component)
{
	if(!isdefined(level.crafting_components[component.name]))
	{
		level.crafting_components[component.name] = component;
	}
	return level.crafting_components[component.name];
}

