// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;

#namespace multi_extracam;

/*
	Name: extracam_reset_index
	Namespace: multi_extracam
	Checksum: 0x16DE8A63
	Offset: 0x90
	Size: 0xC2
	Parameters: 2
	Flags: Linked
*/
function extracam_reset_index(localclientnum, index)
{
	if(!isdefined(level.camera_ents) || !isdefined(level.camera_ents[localclientnum]))
	{
		return;
	}
	if(isdefined(level.camera_ents[localclientnum][index]))
	{
		level.camera_ents[localclientnum][index] clearextracam();
		level.camera_ents[localclientnum][index] delete();
		level.camera_ents[localclientnum][index] = undefined;
	}
}

/*
	Name: extracam_init_index
	Namespace: multi_extracam
	Checksum: 0x6345D5D
	Offset: 0x160
	Size: 0x62
	Parameters: 3
	Flags: Linked
*/
function extracam_init_index(localclientnum, target, index)
{
	camerastruct = struct::get(target, "targetname");
	return extracam_init_item(localclientnum, camerastruct, index);
}

/*
	Name: extracam_init_item
	Namespace: multi_extracam
	Checksum: 0x95484785
	Offset: 0x1D0
	Size: 0x196
	Parameters: 3
	Flags: Linked
*/
function extracam_init_item(localclientnum, copy_ent, index)
{
	if(!isdefined(level.camera_ents))
	{
		level.camera_ents = [];
	}
	if(!isdefined(level.camera_ents[localclientnum]))
	{
		level.camera_ents[localclientnum] = [];
	}
	if(isdefined(level.camera_ents[localclientnum][index]))
	{
		level.camera_ents[localclientnum][index] clearextracam();
		level.camera_ents[localclientnum][index] delete();
		level.camera_ents[localclientnum][index] = undefined;
	}
	if(isdefined(copy_ent))
	{
		level.camera_ents[localclientnum][index] = spawn(localclientnum, copy_ent.origin, "script_origin");
		level.camera_ents[localclientnum][index].angles = copy_ent.angles;
		level.camera_ents[localclientnum][index] setextracam(index);
		return level.camera_ents[localclientnum][index];
	}
	return undefined;
}

