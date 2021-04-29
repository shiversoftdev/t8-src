// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;

#namespace namespace_fd46b4a7;

/*
	Name: function_89f2df9
	Namespace: namespace_fd46b4a7
	Checksum: 0x2ADDAD88
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_39376ab9d627e38a", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_fd46b4a7
	Checksum: 0x253644D3
	Offset: 0xF0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_39376ab9d627e38a", "activated", 1, undefined, undefined, &validation, &activation);
}

/*
	Name: activation
	Namespace: namespace_fd46b4a7
	Checksum: 0x6049C46B
	Offset: 0x170
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	foreach(player in getplayers())
	{
		if(player util::function_bf5a8f5c())
		{
			player thread zm_player::spectator_respawn_player();
		}
		can_revive = 0;
		if(isdefined(level.var_a538e6dc) && self [[level.var_a538e6dc]](player, 1, 1))
		{
			can_revive = 1;
		}
		else if(self zm_laststand::can_revive(player, 1, 1))
		{
			can_revive = 1;
		}
		if(can_revive)
		{
			player thread bgb::function_da81178e();
			player zm_laststand::auto_revive(self);
		}
	}
}

/*
	Name: validation
	Namespace: namespace_fd46b4a7
	Checksum: 0xB7A9DFBB
	Offset: 0x2C0
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	foreach(player in getplayers())
	{
		if(player util::function_bf5a8f5c())
		{
			return 1;
		}
		if(isdefined(player.var_bdeb0f02) && player.var_bdeb0f02)
		{
			continue;
			continue;
		}
		if(isdefined(level.var_a538e6dc) && self [[level.var_a538e6dc]](player, 1, 1))
		{
			return 1;
		}
		if(self zm_laststand::can_revive(player, 1, 1))
		{
			return 1;
		}
	}
	return 0;
}

