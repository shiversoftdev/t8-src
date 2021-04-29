// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_grappler;

/*
	Name: function_89f2df9
	Namespace: zm_grappler
	Checksum: 0xCEE7CE95
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_grappler", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_grappler
	Checksum: 0xADED894E
	Offset: 0x170
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &function_3adb9228, 1, 0);
	clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &function_7e79839e, 1, 0);
	if(!isdefined(level.var_7e79839e))
	{
		level.var_7e79839e = "zod_beast_grapple_beam";
	}
}

/*
	Name: function_3adb9228
	Namespace: zm_grappler
	Checksum: 0x13D83088
	Offset: 0x250
	Size: 0xAE
	Parameters: 7
	Flags: Linked
*/
function function_3adb9228(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_da8e7aa4))
	{
		level.var_da8e7aa4 = [];
	}
	/#
		assert(!isdefined(level.var_da8e7aa4[newval]));
	#/
	level.var_da8e7aa4[newval] = self;
	level notify("grapple_id_" + newval);
}

/*
	Name: function_7e79839e
	Namespace: zm_grappler
	Checksum: 0x5387DE38
	Offset: 0x308
	Size: 0x136
	Parameters: 7
	Flags: Linked
*/
function function_7e79839e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!isdefined(level.var_da8e7aa4))
	{
		level.var_da8e7aa4 = [];
	}
	if(!isdefined(level.var_da8e7aa4[newval]))
	{
		level waittill_timeout(1, "grapple_id_" + newval);
	}
	/#
		assert(isdefined(level.var_da8e7aa4[newval]));
	#/
	pivot = level.var_da8e7aa4[newval];
	if(!isdefined(pivot))
	{
		return;
	}
	if(newval)
	{
		thread function_34e3f163(self, "tag_origin", pivot, 0.05);
	}
	else
	{
		self notify(#"hash_1550b3a3e9b816f3");
	}
}

/*
	Name: function_34e3f163
	Namespace: zm_grappler
	Checksum: 0x47FA6F3B
	Offset: 0x448
	Size: 0x84
	Parameters: 4
	Flags: Linked
*/
function function_34e3f163(player, tag, pivot, delay)
{
	player endon(#"hash_1550b3a3e9b816f3", #"death");
	pivot endon(#"death");
	wait(delay);
	thread grapple_beam(player, tag, pivot);
}

/*
	Name: function_f4b9c325
	Namespace: zm_grappler
	Checksum: 0x2C23D45
	Offset: 0x4D8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_f4b9c325(notifyhash)
{
	level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.var_7e79839e);
}

/*
	Name: grapple_beam
	Namespace: zm_grappler
	Checksum: 0x84828955
	Offset: 0x530
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function grapple_beam(player, tag, pivot)
{
	self endon_callback(&function_f4b9c325, #"death");
	self.player = player;
	self.tag = tag;
	self.pivot = pivot;
	level beam::launch(player, tag, pivot, "tag_origin", level.var_7e79839e, 1);
	player waittill(#"hash_1550b3a3e9b816f3");
	level beam::kill(player, tag, pivot, "tag_origin", level.var_7e79839e);
}

