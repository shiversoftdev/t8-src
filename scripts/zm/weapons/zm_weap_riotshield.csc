// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_equip_shield;

/*
	Name: __init__system__
	Namespace: zm_equip_shield
	Checksum: 0xC80286DB
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_equip_shield", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_equip_shield
	Checksum: 0x4BC4FA83
	Offset: 0x190
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&player_on_spawned);
	clientfield::register("toplayer", "zm_shield_damage_rumble", 1, 1, "counter", &zm_shield_damage_rumble, 0, 0);
	clientfield::register("toplayer", "zm_shield_break_rumble", 1, 1, "counter", &zm_shield_break_rumble, 0, 0);
	clientfield::register("clientuimodel", "ZMInventoryPersonal.shield_health", 1, 4, "float", undefined, 0, 0);
}

/*
	Name: player_on_spawned
	Namespace: zm_equip_shield
	Checksum: 0x2D788C22
	Offset: 0x288
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function player_on_spawned(localclientnum)
{
	self thread watch_weapon_changes(localclientnum);
}

/*
	Name: watch_weapon_changes
	Namespace: zm_equip_shield
	Checksum: 0x4573531D
	Offset: 0x2B8
	Size: 0x132
	Parameters: 1
	Flags: Linked
*/
function watch_weapon_changes(localclientnum)
{
	self endon(#"death");
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_change");
		w_current = waitresult.weapon;
		w_previous = waitresult.last_weapon;
		if(w_current.isriotshield)
		{
			for(i = 0; i < w_current.var_21329beb.size; i++)
			{
				util::lock_model(w_current.var_21329beb[i]);
			}
		}
		else if(w_previous.isriotshield)
		{
			for(i = 0; i < w_previous.var_21329beb.size; i++)
			{
				util::unlock_model(w_previous.var_21329beb[i]);
			}
		}
	}
}

/*
	Name: zm_shield_damage_rumble
	Namespace: zm_equip_shield
	Checksum: 0xADE65F5D
	Offset: 0x3F8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function zm_shield_damage_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "zm_shield_damage");
	}
}

/*
	Name: zm_shield_break_rumble
	Namespace: zm_equip_shield
	Checksum: 0x490EB02E
	Offset: 0x468
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function zm_shield_break_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self playrumbleonentity(localclientnum, "zm_shield_break");
	}
}

