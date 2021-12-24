// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace userspawnselection;

/*
	Name: function_89f2df9
	Namespace: userspawnselection
	Checksum: 0x6A25B83D
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"userspawnselection", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: userspawnselection
	Checksum: 0xF1A83948
	Offset: 0x1E0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.next_spawngroup_index = 0;
	level.spawngroups = [];
	level.useteamspecificforwardspawns = getgametypesetting(#"forwardspawnteamspecificspawns");
	callback::on_finalize_initialization(&setupspawngroups);
	setupuimodels();
	setupclientfields();
}

/*
	Name: getdatamodelprefix
	Namespace: userspawnselection
	Checksum: 0x7DB20E46
	Offset: 0x270
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
private function getdatamodelprefix(id)
{
	return ("spawngroupStatus." + id) + ".";
}

/*
	Name: setupclientfields
	Namespace: userspawnselection
	Checksum: 0x126C3471
	Offset: 0x298
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function setupclientfields()
{
	for(index = 0; index < 20; index++)
	{
		basename = getdatamodelprefix(index);
		clientfield::register("worlduimodel", basename + "visStatus", 1, 1, "int", undefined, 0, 1);
		clientfield::register("worlduimodel", basename + "useStatus", 1, 1, "int", undefined, 0, 1);
		clientfield::register("worlduimodel", basename + "team", 1, 2, "int", undefined, 0, 1);
	}
	clientfield::register("clientuimodel", "hudItems.showSpawnSelect", 1, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.killcamActive", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hideautospawnoption", 1, 1, "int", undefined, 0, 0);
}

/*
	Name: setupuimodels
	Namespace: userspawnselection
	Checksum: 0xDAC280D
	Offset: 0x450
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function setupuimodels()
{
	for(index = 0; index < 20; index++)
	{
		spawngroupprefix = getdatamodelprefix(index);
		createuimodel(getglobaluimodel(), spawngroupprefix + "regionName");
		createuimodel(getglobaluimodel(), spawngroupprefix + "origin.x");
		createuimodel(getglobaluimodel(), spawngroupprefix + "origin.y");
		createuimodel(getglobaluimodel(), spawngroupprefix + "origin.z");
		createuimodel(getglobaluimodel(), spawngroupprefix + "team");
	}
}

/*
	Name: setupstaticmodelfieldsforspawngroup
	Namespace: userspawnselection
	Checksum: 0xD24364F6
	Offset: 0x590
	Size: 0x22C
	Parameters: 1
	Flags: Linked, Private
*/
private function setupstaticmodelfieldsforspawngroup(spawngroup)
{
	basename = getdatamodelprefix(spawngroup.uiindex);
	namemodel = getuimodel(getglobaluimodel(), basename + "regionName");
	spawngroupname = "";
	if(isdefined(spawngroup.ui_label))
	{
		spawngroupname = spawngroup.ui_label;
	}
	setuimodelvalue(namemodel, spawngroupname);
	teammodel = getuimodel(getglobaluimodel(), basename + "team");
	setuimodelvalue(teammodel, spawngroup.script_team);
	xmodel = getuimodel(getglobaluimodel(), basename + "origin.x");
	setuimodelvalue(xmodel, spawngroup.origin[0]);
	ymodel = getuimodel(getglobaluimodel(), basename + "origin.y");
	setuimodelvalue(ymodel, spawngroup.origin[1]);
	zmodel = getuimodel(getglobaluimodel(), basename + "origin.z");
	setuimodelvalue(zmodel, spawngroup.origin[2]);
}

/*
	Name: function_bc7ec9a1
	Namespace: userspawnselection
	Checksum: 0x7C2944FA
	Offset: 0x7C8
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_bc7ec9a1(spawngroup)
{
	spawns = struct::get_array(spawngroup.target, "groupname");
	var_164af2a6 = 0;
	var_98dd92c = 0;
	var_fbc43d99 = 0;
	var_4f210458 = 0;
	foreach(spawn in spawns)
	{
		var_164af2a6 = var_164af2a6 + spawn.origin.x;
		var_98dd92c = var_98dd92c + spawn.origin.y;
		var_fbc43d99 = var_fbc43d99 + spawn.origin.z;
	}
	return var_98dd92c;
}

/*
	Name: setupspawngroup
	Namespace: userspawnselection
	Checksum: 0xBE0C6A6E
	Offset: 0x900
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function setupspawngroup(spawngroup)
{
	spawngroup.uiindex = level.next_spawngroup_index;
	level.next_spawngroup_index++;
	level.spawngroups[spawngroup.uiindex] = spawngroup;
	function_bc7ec9a1(spawngroup);
	setupstaticmodelfieldsforspawngroup(spawngroup);
}

/*
	Name: setupspawngroups
	Namespace: userspawnselection
	Checksum: 0x76FB5B83
	Offset: 0x988
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function setupspawngroups(localclientnum)
{
	spawngroups = struct::get_array("spawn_group_marker", "targetname");
	if(!isdefined(spawngroups))
	{
		return;
	}
	spawngroupssorted = array::get_all_closest((0, 0, 0), spawngroups);
	foreach(spawngroup in spawngroupssorted)
	{
		setupspawngroup(spawngroup);
	}
}

