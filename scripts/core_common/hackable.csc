// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\duplicaterender_mgr.csc;
#using scripts\core_common\system_shared.csc;

#namespace hackable;

/*
	Name: __init__system__
	Namespace: hackable
	Checksum: 0xC09CE515
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hackable", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: hackable
	Checksum: 0xCC5D58A8
	Offset: 0x100
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function init()
{
	callback::on_localclient_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: hackable
	Checksum: 0xAAD347E8
	Offset: 0x130
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function on_player_connect(localclientnum)
{
	duplicate_render::set_dr_filter_offscreen("hacking", 75, "being_hacked", undefined, 2, "mc/hud_keyline_orange", 1);
}

/*
	Name: set_hacked_ent
	Namespace: hackable
	Checksum: 0x4C61D571
	Offset: 0x180
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function set_hacked_ent(local_client_num, ent)
{
	if(!ent === self.hacked_ent)
	{
		if(isdefined(self.hacked_ent))
		{
			self.hacked_ent duplicate_render::change_dr_flags(local_client_num, undefined, "being_hacked");
		}
		self.hacked_ent = ent;
		if(isdefined(self.hacked_ent))
		{
			self.hacked_ent duplicate_render::change_dr_flags(local_client_num, "being_hacked", undefined);
		}
	}
}

