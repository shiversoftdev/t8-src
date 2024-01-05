// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace multi_extracam;

/*
	Name: __init__system__
	Namespace: multi_extracam
	Checksum: 0x5A6A1F93
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"multi_extracam", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: multi_extracam
	Checksum: 0x83A5C634
	Offset: 0x108
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localclient_connect(&multi_extracam_init);
}

/*
	Name: multi_extracam_init
	Namespace: multi_extracam
	Checksum: 0x51E5382B
	Offset: 0x138
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function multi_extracam_init(localclientnum)
{
	triggers = getentarray(localclientnum, "multicam_enable", "targetname");
	for(i = 1; i <= 4; i++)
	{
		camerastruct = struct::get("extracam" + i, "targetname");
		if(isdefined(camerastruct))
		{
			camera_ent = spawn(localclientnum, camerastruct.origin, "script_origin");
			camera_ent.angles = camerastruct.angles;
			width = (isdefined(camerastruct.extracam_width) ? camerastruct.extracam_width : -1);
			height = (isdefined(camerastruct.extracam_height) ? camerastruct.extracam_height : -1);
			camera_ent setextracam(i - 1, width, height);
		}
	}
}

