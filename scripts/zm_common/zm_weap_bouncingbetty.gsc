// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_placeable_mine.gsc;
#using scripts\zm_common\util.gsc;
#using scripts\weapons\weaponobjects.gsc;
#using scripts\weapons\bouncingbetty.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace bouncingbetty;

/*
	Name: __init__system__
	Namespace: bouncingbetty
	Checksum: 0xD351979F
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"bouncingbetty", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: bouncingbetty
	Checksum: 0xF46F800B
	Offset: 0x100
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level._proximityweaponobjectdetonation_override = &proximityweaponobjectdetonation_override;
	init_shared();
	zm_placeable_mine::add_mine_type("bouncingbetty", #"hash_613df6d5f8eddffd");
	level.bettyjumpheight = 55;
	level.bettydamagemax = 1000;
	level.bettydamagemin = 800;
	level.bettydamageheight = level.bettyjumpheight;
	/#
		setdvar(#"betty_damage_max", level.bettydamagemax);
		setdvar(#"betty_damage_min", level.bettydamagemin);
		setdvar(#"betty_jump_height_onground", level.bettyjumpheight);
	#/
}

/*
	Name: proximityweaponobjectdetonation_override
	Namespace: bouncingbetty
	Checksum: 0xCC7A5C69
	Offset: 0x228
	Size: 0x170
	Parameters: 1
	Flags: None
*/
function proximityweaponobjectdetonation_override(watcher)
{
	self endon(#"death", #"hacked", #"kill_target_detection");
	weaponobjects::proximityweaponobject_activationdelay(watcher);
	damagearea = weaponobjects::proximityweaponobject_createdamagearea(watcher);
	up = anglestoup(self.angles);
	traceorigin = self.origin + up;
	while(true)
	{
		waitresult = undefined;
		waitresult = damagearea waittill(#"trigger");
		ent = waitresult.activator;
		if(!weaponobjects::proximityweaponobject_validtriggerentity(watcher, ent))
		{
			continue;
		}
		if(weaponobjects::proximityweaponobject_isspawnprotected(watcher, ent))
		{
			continue;
		}
		if(ent damageconetrace(traceorigin, self) > 0)
		{
			thread weaponobjects::proximityweaponobject_dodetonation(watcher, ent, traceorigin);
		}
	}
}

