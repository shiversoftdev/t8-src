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
	Name: __init__system__
	Namespace: zm_grappler
	Checksum: 0xCEE7CE95
	Offset: 0x128
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int", &grappler_source, 1, 0);
	clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int", &grappler_beam, 1, 0);
	if(!isdefined(level.grappler_beam))
	{
		level.grappler_beam = "zod_beast_grapple_beam";
	}
}

/*
	Name: grappler_source
	Namespace: zm_grappler
	Checksum: 0x13D83088
	Offset: 0x250
	Size: 0xAE
	Parameters: 7
	Flags: Linked
*/
function grappler_source(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.grappler_sources))
	{
		level.grappler_sources = [];
	}
	/#
		assert(!isdefined(level.grappler_sources[newval]));
	#/
	level.grappler_sources[newval] = self;
	level notify("grapple_id_" + newval);
}

/*
	Name: grappler_beam
	Namespace: zm_grappler
	Checksum: 0x5387DE38
	Offset: 0x308
	Size: 0x136
	Parameters: 7
	Flags: Linked
*/
function grappler_beam(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!isdefined(level.grappler_sources))
	{
		level.grappler_sources = [];
	}
	if(!isdefined(level.grappler_sources[newval]))
	{
		level waittilltimeout(1, "grapple_id_" + newval);
	}
	/#
		assert(isdefined(level.grappler_sources[newval]));
	#/
	pivot = level.grappler_sources[newval];
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
		self notify(#"grappler_done");
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
	player endon(#"grappler_done", #"death");
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
	level beam::kill(self.player, self.tag, self.pivot, "tag_origin", level.grappler_beam);
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
	self endoncallback(&function_f4b9c325, #"death");
	self.player = player;
	self.tag = tag;
	self.pivot = pivot;
	level beam::launch(player, tag, pivot, "tag_origin", level.grappler_beam, 1);
	player waittill(#"grappler_done");
	level beam::kill(player, tag, pivot, "tag_origin", level.grappler_beam);
}

