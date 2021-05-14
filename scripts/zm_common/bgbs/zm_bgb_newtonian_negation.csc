// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_bgb.csc;

#namespace zm_bgb_newtonian_negation;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0x30FC0894
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0x56D6119C
	Offset: 0x108
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("world", "newtonian_negation", 1, 1, "int", &function_8622e664, 0, 0);
	bgb::register(#"zm_bgb_newtonian_negation", "time");
}

/*
	Name: function_8622e664
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xDFAFC148
	Offset: 0x1A8
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_8622e664(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		setdvar(#"phys_gravity_dir", (0, 0, -1));
		self notify(#"hash_747b48d62f4fbad1");
	}
	else
	{
		setdvar(#"phys_gravity_dir", (0, 0, 1));
		self thread function_e752a980(localclientnum);
	}
}

/*
	Name: function_e752a980
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0x518281D8
	Offset: 0x270
	Size: 0x190
	Parameters: 1
	Flags: Linked
*/
function function_e752a980(localclientnum)
{
	self endon(#"hash_747b48d62f4fbad1", #"disconnect");
	var_f42481ac = 0;
	a_dynents = getdynentarray();
	a_corpses = getentarraybytype(localclientnum, 17);
	var_f74f1323 = arraycombine(a_dynents, a_corpses, 1, 0);
	var_f74f1323 = array::randomize(var_f74f1323);
	foreach(var_863ce745 in var_f74f1323)
	{
		if(!isdefined(var_863ce745))
		{
			continue;
		}
		physicsexplosionsphere(localclientnum, var_863ce745.origin, 2, 0, 5, undefined, undefined, 1, 1, 1);
		var_f42481ac++;
		if(var_f42481ac >= 5)
		{
			waitframe(1);
			var_f42481ac = 0;
		}
	}
}

