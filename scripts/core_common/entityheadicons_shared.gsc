// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace entityheadicons;

/*
	Name: init_shared
	Namespace: entityheadicons
	Checksum: 0xF4EA57E0
	Offset: 0x90
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	callback::on_start_gametype(&start_gametype);
}

/*
	Name: start_gametype
	Namespace: entityheadicons
	Checksum: 0xBBF840F2
	Offset: 0xC0
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function start_gametype()
{
	if(!level.teambased)
	{
		return;
	}
	if(!isdefined(level.setentityheadicon))
	{
		level.setentityheadicon = &setentityheadicon;
	}
}

/*
	Name: setentityheadicon
	Namespace: entityheadicons
	Checksum: 0x1E430EF8
	Offset: 0x108
	Size: 0x204
	Parameters: 3
	Flags: Linked
*/
function setentityheadicon(team, owner, objective)
{
	if(!level.teambased && !isdefined(owner))
	{
		return;
	}
	if(!isdefined(self.entityheadiconteam))
	{
		self.entityheadiconteam = #"none";
		self.entityheadobjectives = [];
	}
	if(level.teambased && !isdefined(owner))
	{
		if(team == self.entityheadiconteam)
		{
			return;
		}
		self.entityheadiconteam = team;
	}
	destroyentityheadicons();
	self.entityheadobjectives = [];
	self notify(#"kill_entity_headicon_thread");
	if(isdefined(objective))
	{
		if(isdefined(owner) && !level.teambased)
		{
			if(!isplayer(owner))
			{
				/#
					assert(isdefined(owner.owner), "");
				#/
				owner = owner.owner;
			}
			if(isdefined(objective))
			{
				if(team !== #"none")
				{
					owner updateentityheadteamobjective(self, team, objective);
				}
				else
				{
					owner updateentityheadclientobjective(self, objective);
				}
			}
		}
		else if(isdefined(owner) && team != #"none")
		{
			if(isdefined(objective))
			{
				owner updateentityheadteamobjective(self, team, objective);
			}
		}
	}
	self thread destroyheadiconsondeath();
}

/*
	Name: updateentityheadteamobjective
	Namespace: entityheadicons
	Checksum: 0x4AB53817
	Offset: 0x318
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function updateentityheadteamobjective(entity, team, objective)
{
	headiconobjectiveid = gameobjects::get_next_obj_id();
	objective_add(headiconobjectiveid, "active", entity, objective);
	objective_setteam(headiconobjectiveid, team);
	function_3ae6fa3(headiconobjectiveid, team, 1);
	entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

/*
	Name: updateentityheadclientobjective
	Namespace: entityheadicons
	Checksum: 0xF894FD9B
	Offset: 0x3D8
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function updateentityheadclientobjective(entity, objective)
{
	headiconobjectiveid = gameobjects::get_next_obj_id();
	objective_add(headiconobjectiveid, "active", entity, objective);
	objective_setinvisibletoall(headiconobjectiveid);
	objective_setvisibletoplayer(headiconobjectiveid, self);
	entity.entityheadobjectives[entity.entityheadobjectives.size] = headiconobjectiveid;
}

/*
	Name: destroyheadiconsondeath
	Namespace: entityheadicons
	Checksum: 0xB74DA665
	Offset: 0x488
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function destroyheadiconsondeath()
{
	self notify(#"destroyheadiconsondeath_singleton");
	self endon(#"destroyheadiconsondeath_singleton");
	self waittill(#"death", #"hacked");
	destroyentityheadicons();
}

/*
	Name: destroyentityheadicons
	Namespace: entityheadicons
	Checksum: 0xEC6FAA5D
	Offset: 0x4F0
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function destroyentityheadicons()
{
	if(isdefined(self.entityheadobjectives))
	{
		for(i = 0; i < self.entityheadobjectives.size; i++)
		{
			if(isdefined(self.entityheadobjectives[i]))
			{
				gameobjects::release_obj_id(self.entityheadobjectives[i]);
				objective_delete(self.entityheadobjectives[i]);
			}
		}
	}
	if(isdefined(self))
	{
		self.entityheadobjectives = [];
	}
}

