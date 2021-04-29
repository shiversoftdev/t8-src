// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace aimappingtableutility;

/*
	Name: setmappingtableforteam
	Namespace: aimappingtableutility
	Checksum: 0xE06B5ACA
	Offset: 0xA0
	Size: 0x46
	Parameters: 2
	Flags: None
*/
function setmappingtableforteam(str_team, aimappingtable)
{
	str_team = util::get_team_mapping(str_team);
	level.aimapppingtable[str_team] = aimappingtable;
}

/*
	Name: getspawnerforai
	Namespace: aimappingtableutility
	Checksum: 0xCA29A120
	Offset: 0xF0
	Size: 0x108
	Parameters: 3
	Flags: None
*/
function getspawnerforai(ai, team, str_mapping_table_override)
{
	if(!isdefined(ai))
	{
		return undefined;
	}
	aimappingtable = undefined;
	if(isdefined(str_mapping_table_override))
	{
		aimappingtable = str_mapping_table_override;
	}
	else if(isdefined(level.aimapppingtable) && isdefined(level.aimapppingtable[team]))
	{
		aimappingtable = level.aimapppingtable[team];
	}
	if(!isdefined(aimappingtable))
	{
		return undefined;
	}
	aimappingtablebundle = struct::get_script_bundle("aimappingtable", aimappingtable);
	if(!isdefined(aimappingtablebundle))
	{
		return undefined;
	}
	aitype = aimappingtablebundle.("aitype_" + ai);
	if(isdefined(aitype))
	{
		return aitype;
	}
	return aimappingtablebundle.("vehicle_" + ai);
}

