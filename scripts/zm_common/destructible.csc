// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace destructible;

/*
	Name: function_89f2df9
	Namespace: destructible
	Checksum: 0x34C588DF
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"destructible", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: destructible
	Checksum: 0x4356C90B
	Offset: 0x108
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "start_destructible_explosion", 1, 10, "int", &doexplosion, 0, 0);
}

/*
	Name: playgrenaderumble
	Namespace: destructible
	Checksum: 0xC943E15F
	Offset: 0x160
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function playgrenaderumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
	earthquake(localclientnum, 0.5, 0.5, self.origin, 800);
}

/*
	Name: doexplosion
	Namespace: destructible
	Checksum: 0x1FF2EBC8
	Offset: 0x200
	Size: 0x104
	Parameters: 7
	Flags: Linked
*/
function doexplosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		return;
	}
	physics_explosion = 0;
	if(newval & (1 << 9))
	{
		physics_explosion = 1;
		newval = newval - (1 << 9);
	}
	physics_force = 0.3;
	if(physics_explosion && newval > 0)
	{
		physicsexplosionsphere(localclientnum, self.origin, newval, newval - 1, physics_force, 25, 400);
	}
	playgrenaderumble(localclientnum, self.origin);
}

