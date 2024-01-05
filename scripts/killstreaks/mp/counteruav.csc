// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace counteruav;

/*
	Name: __init__system__
	Namespace: counteruav
	Checksum: 0x532A54B4
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"counteruav", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: counteruav
	Checksum: 0x4CBAF8A5
	Offset: 0xF8
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("toplayer", "counteruav", 1, 1, "int", &counteruavchanged, 0, 1);
	level.var_8c4291cb = [];
}

/*
	Name: counteruavchanged
	Namespace: counteruav
	Checksum: 0x95C1F610
	Offset: 0x160
	Size: 0x11E
	Parameters: 7
	Flags: None
*/
function counteruavchanged(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_5c10bd79(localclientnum);
	/#
		assert(isdefined(player));
	#/
	player setenemyglobalscrambler(newval);
	if(isdefined(level.var_8c4291cb[localclientnum]))
	{
		function_d48752e(localclientnum, level.var_8c4291cb[localclientnum], 1);
		level.var_8c4291cb[localclientnum] = undefined;
	}
	if(newval)
	{
		level.var_8c4291cb[localclientnum] = function_604c9983(localclientnum, "mpl_cuav_static");
	}
}

