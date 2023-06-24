// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial.csc;
#using scripts\zm\perk\zm_perk_death_perception.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm.csc;

#namespace zm_trial_disable_hud;

/*
	Name: __init__system__
	Namespace: zm_trial_disable_hud
	Checksum: 0xF7B74A4
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_disable_hud", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_disable_hud
	Checksum: 0x60F54E8E
	Offset: 0xD0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"disable_hud", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_disable_hud
	Checksum: 0x2FA80FF9
	Offset: 0x138
	Size: 0x2C
	Parameters: 2
	Flags: Private
*/
function private on_begin(local_client_num, params)
{
	level thread function_40349f7c();
}

/*
	Name: function_40349f7c
	Namespace: zm_trial_disable_hud
	Checksum: 0xB04260E7
	Offset: 0x170
	Size: 0x1A2
	Parameters: 1
	Flags: None
*/
function function_40349f7c(localclientnum)
{
	level endon(#"hash_38932f8deb28b470", #"end_game");
	wait(12);
	level.var_dc60105c = 1;
	maxclients = getmaxlocalclients();
	for(localclientnum = 0; localclientnum < maxclients; localclientnum++)
	{
		if(isdefined(function_5c10bd79(localclientnum)))
		{
			foreach(player in getplayers(localclientnum))
			{
				player zm::function_92f0c63(localclientnum);
			}
			foreach(player in getplayers(localclientnum))
			{
				player zm_perk_death_perception::function_25410869(localclientnum);
			}
		}
	}
}

/*
	Name: on_end
	Namespace: zm_trial_disable_hud
	Checksum: 0xF81C5BDC
	Offset: 0x320
	Size: 0x18A
	Parameters: 1
	Flags: Private
*/
function private on_end(local_client_num)
{
	level notify(#"hash_38932f8deb28b470");
	level.var_dc60105c = undefined;
	maxclients = getmaxlocalclients();
	for(localclientnum = 0; localclientnum < maxclients; localclientnum++)
	{
		if(isdefined(function_5c10bd79(localclientnum)))
		{
			foreach(player in getplayers(localclientnum))
			{
				player zm::function_92f0c63(localclientnum);
			}
			foreach(player in getplayers(localclientnum))
			{
				player zm_perk_death_perception::function_25410869(localclientnum);
			}
		}
	}
}

