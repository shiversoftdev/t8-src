// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_weap_cymbal_monkey;

/*
	Name: __init__system__
	Namespace: zm_weap_cymbal_monkey
	Checksum: 0xCBC24B2C
	Offset: 0x110
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_cymbal_monkey", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_cymbal_monkey
	Checksum: 0x54971771
	Offset: 0x158
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_60a7e5b79e8064a5", 1, 1, "int", &monkey_spawns, 0, 0);
	if(isdefined(level.legacy_cymbal_monkey) && level.legacy_cymbal_monkey)
	{
		level.cymbal_monkey_model = "weapon_zombie_monkey_bomb";
	}
	else
	{
		level.cymbal_monkey_model = "wpn_t7_zmb_monkey_bomb_world";
	}
	if(!zm_weapons::is_weapon_included(getweapon(#"cymbal_monkey")))
	{
		return;
	}
}

/*
	Name: monkey_spawns
	Namespace: zm_weap_cymbal_monkey
	Checksum: 0x1903746A
	Offset: 0x240
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function monkey_spawns(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		waitframe(1);
		v_up = vectorscale((1, 0, 0), 360);
		v_forward = vectorscale((0, 0, 1), 360);
		if(isdefined(self))
		{
			playfx(localclientnum, "maps/zm_white/fx8_monkey_bomb_reveal", self.origin, v_forward, v_up);
			self playsound(localclientnum, #"hash_21206f1b7fb27f81");
		}
	}
}

