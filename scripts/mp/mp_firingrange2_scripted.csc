// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace mp_firingrange2_scripted;

/*
	Name: __init__system__
	Namespace: mp_firingrange2_scripted
	Checksum: 0x2210500F
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"mp_firingrange2_scripted", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: mp_firingrange2_scripted
	Checksum: 0xEF6EA471
	Offset: 0xC0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localclient_connect(&on_localclient_connect);
	callback::on_gameplay_started(&on_gameplay_started);
}

/*
	Name: on_localclient_connect
	Namespace: mp_firingrange2_scripted
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
	Name: on_gameplay_started
	Namespace: mp_firingrange2_scripted
	Checksum: 0xBB9246B6
	Offset: 0x148
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_gameplay_started(localclientnum)
{
	waitframe(1);
	setpbgactivebank(localclientnum, 1);
}

