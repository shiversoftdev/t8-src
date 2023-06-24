// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_1261609;

/*
	Name: __init__system__
	Namespace: namespace_1261609
	Checksum: 0x2210500F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_33946b9507c6ec22", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1261609
	Checksum: 0xEF6EA471
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localclient_connect(&on_localclient_connect);
	callback::function_d46d9315(&function_d46d9315);
}

/*
	Name: on_localclient_connect
	Namespace: namespace_1261609
	Checksum: 0xC2B78308
	Offset: 0x110
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	waitframe(1);
	setpbgactivebank(localclientnum, 8);
}

/*
	Name: function_d46d9315
	Namespace: namespace_1261609
	Checksum: 0xBB9246B6
	Offset: 0x148
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_d46d9315(localclientnum)
{
	waitframe(1);
	setpbgactivebank(localclientnum, 1);
}

