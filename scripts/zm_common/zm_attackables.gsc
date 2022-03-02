// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\table_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_attackables;

/*
	Name: function_89f2df9
	Namespace: zm_attackables
	Checksum: 0x65C5C234
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_attackables", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_attackables
	Checksum: 0x9F977D83
	Offset: 0x1C8
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.attackablecallback = &attackable_callback;
	level.attackables = struct::get_array("scriptbundle_attackables", "classname");
	foreach(attackable in level.attackables)
	{
		attackable.bundle = struct::get_script_bundle("attackables", attackable.scriptbundlename);
		if(isdefined(attackable.target))
		{
			attackable.slot = struct::get_array(attackable.target, "targetname");
		}
		attackable.is_active = 0;
		attackable.health = attackable.bundle.max_health;
		if(getdvarint(#"zm_attackables", 0) > 0)
		{
			attackable.is_active = 1;
			attackable.health = 1000;
		}
	}
}

/*
	Name: __main__
	Namespace: zm_attackables
	Checksum: 0x80F724D1
	Offset: 0x358
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: get_attackable
	Namespace: zm_attackables
	Checksum: 0x61C4BDA8
	Offset: 0x368
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function get_attackable()
{
	foreach(attackable in level.attackables)
	{
		if(!(isdefined(attackable.is_active) && attackable.is_active))
		{
			continue;
		}
		dist = distance(self.origin, attackable.origin);
		if(dist < attackable.bundle.aggro_distance)
		{
			if(attackable get_attackable_slot(self))
			{
				return attackable;
			}
		}
		/#
			if(getdvarint(#"zm_attackables", 0) > 1)
			{
				if(attackable get_attackable_slot(self))
				{
					return attackable;
				}
			}
		#/
	}
	return undefined;
}

/*
	Name: get_attackable_slot
	Namespace: zm_attackables
	Checksum: 0xA982620C
	Offset: 0x4C0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function get_attackable_slot(entity)
{
	self clear_slots();
	foreach(slot in self.slot)
	{
		if(!isdefined(slot.entity))
		{
			slot.entity = entity;
			entity.attackable_slot = slot;
			return true;
		}
	}
	return false;
}

/*
	Name: clear_slots
	Namespace: zm_attackables
	Checksum: 0xE1844804
	Offset: 0x588
	Size: 0xCE
	Parameters: 0
	Flags: Linked, Private
*/
function private clear_slots()
{
	foreach(slot in self.slot)
	{
		if(!isalive(slot.entity))
		{
			slot.entity = undefined;
			continue;
		}
		if(isdefined(slot.entity.missinglegs) && slot.entity.missinglegs)
		{
			slot.entity = undefined;
		}
	}
}

/*
	Name: activate
	Namespace: zm_attackables
	Checksum: 0xDBE61687
	Offset: 0x660
	Size: 0x3A
	Parameters: 0
	Flags: None
*/
function activate()
{
	self.is_active = 1;
	if(self.health <= 0)
	{
		self.health = self.bundle.max_health;
	}
}

/*
	Name: deactivate
	Namespace: zm_attackables
	Checksum: 0x217B9038
	Offset: 0x6A8
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function deactivate()
{
	self.is_active = 0;
}

/*
	Name: do_damage
	Namespace: zm_attackables
	Checksum: 0x32C03B94
	Offset: 0x6C0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function do_damage(damage)
{
	self.health = self.health - damage;
	self notify(#"attackable_damaged");
	if(self.health <= 0)
	{
		self notify(#"attackable_deactivated");
		if(!(isdefined(self.b_deferred_deactivation) && self.b_deferred_deactivation))
		{
			self deactivate();
		}
	}
}

/*
	Name: attackable_callback
	Namespace: zm_attackables
	Checksum: 0xD4837605
	Offset: 0x750
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function attackable_callback(entity)
{
	if(entity.archetype === "thrasher" && (self.scriptbundlename === "zm_island_trap_plant_attackable" || self.scriptbundlename === "zm_island_trap_plant_upgraded_attackable"))
	{
		self do_damage(self.health);
	}
	else
	{
		self do_damage(entity.meleeweapon.meleedamage);
	}
}

