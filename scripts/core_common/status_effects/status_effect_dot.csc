// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace status_effect_dot;

/*
	Name: __init__system__
	Namespace: status_effect_dot
	Checksum: 0x9F7BFDA7
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_dot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_dot
	Checksum: 0xBF9246B2
	Offset: 0xF8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "dot_splatter", 1, 1, "counter", &on_dot_splatter, 0, 0);
	clientfield::register("toplayer", "dot_no_splatter", 1, 1, "counter", &on_dot_no_splatter, 0, 0);
}

/*
	Name: on_dot_splatter
	Namespace: status_effect_dot
	Checksum: 0x93FC09BD
	Offset: 0x198
	Size: 0x4A
	Parameters: 7
	Flags: Linked
*/
function on_dot_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.dot_damaged = 1;
}

/*
	Name: on_dot_no_splatter
	Namespace: status_effect_dot
	Checksum: 0xFD0AABB7
	Offset: 0x1F0
	Size: 0x4A
	Parameters: 7
	Flags: Linked
*/
function on_dot_no_splatter(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.dot_no_splatter = 1;
}

