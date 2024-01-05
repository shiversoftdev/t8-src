// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flowgraph\flowgraph_core.gsc;

#namespace flowgraph_entity;

/*
	Name: isentitydefinedfunc
	Namespace: flowgraph_entity
	Checksum: 0xCF5A4C86
	Offset: 0x70
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function isentitydefinedfunc(e_entity)
{
	return isdefined(e_entity);
}

/*
	Name: getentityorigin
	Namespace: flowgraph_entity
	Checksum: 0xA28719B6
	Offset: 0x88
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function getentityorigin(e_entity)
{
	return e_entity.origin;
}

/*
	Name: getentityangles
	Namespace: flowgraph_entity
	Checksum: 0xEF7CA499
	Offset: 0xA8
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function getentityangles(e_entity)
{
	return e_entity.angles;
}

/*
	Name: onentityspawned
	Namespace: flowgraph_entity
	Checksum: 0x4D5FF0EA
	Offset: 0xC8
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function onentityspawned(e_entity)
{
	e_entity waittill(#"spawned");
	return true;
}

/*
	Name: onentitydamaged
	Namespace: flowgraph_entity
	Checksum: 0x107D174C
	Offset: 0xF8
	Size: 0xF8
	Parameters: 2
	Flags: None
*/
function onentitydamaged(x, e_entity)
{
	e_entity endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = e_entity waittill(#"damage");
		self flowgraph::kick(array(1, e_entity, waitresult.amount, waitresult.attacker, waitresult.direction, waitresult.position, waitresult.mod, waitresult.model_name, waitresult.tag_name, waitresult.part_name, waitresult.weapon, waitresult.flags));
	}
}

/*
	Name: function_fd19ef53
	Namespace: flowgraph_entity
	Checksum: 0x1A6B4856
	Offset: 0x1F8
	Size: 0x20
	Parameters: 2
	Flags: None
*/
function function_fd19ef53(e_entity, str_field)
{
	return e_entity.(str_field);
}

/*
	Name: function_7e40ae2d
	Namespace: flowgraph_entity
	Checksum: 0x34888D09
	Offset: 0x220
	Size: 0x3A
	Parameters: 4
	Flags: None
*/
function function_7e40ae2d(x, e_entity, str_field, var_b8003601)
{
	e_entity.(str_field) = var_b8003601;
	return true;
}

