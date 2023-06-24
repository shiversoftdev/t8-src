// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace wz_supply_stash;

/*
	Name: __init__system__
	Namespace: wz_supply_stash
	Checksum: 0x61612CB2
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_supply_stash", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_supply_stash
	Checksum: 0x1308362F
	Offset: 0x160
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_cee10b49 = [];
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: on_localclient_connect
	Namespace: wz_supply_stash
	Checksum: 0x2BDE5EB2
	Offset: 0x1A0
	Size: 0x124
	Parameters: 1
	Flags: Linked, Private
*/
function private on_localclient_connect(localclientnum)
{
	if(isdefined(getgametypesetting(#"wzenablebountyhuntervehicles")) && getgametypesetting(#"wzenablebountyhuntervehicles") || (isdefined(getgametypesetting(#"hash_23e09b48546a7e3b")) && getgametypesetting(#"hash_23e09b48546a7e3b")))
	{
		level thread function_53d906fd(localclientnum);
	}
	else if(isdefined(getgametypesetting("infectionMode")) && getgametypesetting("infectionMode"))
	{
		level thread function_fd3f6235(localclientnum);
	}
}

/*
	Name: function_53d906fd
	Namespace: wz_supply_stash
	Checksum: 0x6C428957
	Offset: 0x2D0
	Size: 0x2BC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_53d906fd(localclientnum)
{
	while(true)
	{
		player = function_5c10bd79(localclientnum);
		playfx = 0;
		if(isdefined(player) && isalive(player))
		{
			vehicle = getplayervehicle(player);
			playfx = isdefined(vehicle) && vehicle.scriptvehicletype === "player_muscle";
		}
		foreach(stash in level.var_5862f2ce)
		{
			if(function_8a8a409b(stash))
			{
				if(stash.var_aa9f8f87 === #"hash_4bfbb656e63b17ae" || stash.var_aa9f8f87 === #"supply_stash_parent")
				{
					stash update_fx(localclientnum, playfx, function_ffdbe8c2(stash));
				}
			}
		}
		foreach(drop in level.var_624588d5)
		{
			if(isdefined(drop) && (isdefined(drop.var_3a55f5cf) && drop.var_3a55f5cf))
			{
				state = 0;
				if(drop getanimtime("p8_fxanim_wz_supply_stash_04_used_anim") > 0)
				{
					state = 2;
				}
				else if(drop getanimtime("p8_fxanim_wz_supply_stash_04_open_anim") > 0)
				{
					state = 1;
				}
				drop update_fx(localclientnum, playfx, state);
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_fd3f6235
	Namespace: wz_supply_stash
	Checksum: 0x24D5C1C7
	Offset: 0x598
	Size: 0x19C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fd3f6235(localclientnum)
{
	while(true)
	{
		player = function_5c10bd79(localclientnum);
		playfx = 0;
		if(player clientfield::get_to_player("infected") != 1)
		{
			playfx = 1;
		}
		foreach(drop in level.var_624588d5)
		{
			if(isdefined(drop) && (isdefined(drop.var_3a55f5cf) && drop.var_3a55f5cf))
			{
				state = 0;
				if(drop getanimtime("p8_fxanim_wz_supply_stash_04_used_anim") > 0)
				{
					state = 2;
				}
				else if(drop getanimtime("p8_fxanim_wz_supply_stash_04_open_anim") > 0)
				{
					state = 1;
				}
				drop update_fx(localclientnum, playfx, state);
			}
		}
		wait(0.2);
	}
}

/*
	Name: update_fx
	Namespace: wz_supply_stash
	Checksum: 0x31E3E982
	Offset: 0x740
	Size: 0xAE
	Parameters: 3
	Flags: Linked
*/
function update_fx(localclientnum, playfx, state)
{
	if(playfx && state == 0)
	{
		if(!isdefined(self.var_d3d42148))
		{
			self.var_d3d42148 = playfx(localclientnum, #"hash_6bcc939010112ea", self.origin);
		}
	}
	else if(isdefined(self.var_d3d42148))
	{
		stopfx(localclientnum, self.var_d3d42148);
		self.var_d3d42148 = undefined;
	}
}

