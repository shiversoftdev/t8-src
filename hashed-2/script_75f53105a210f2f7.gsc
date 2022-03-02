// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_901adecc;

/*
	Name: function_89f2df9
	Namespace: namespace_901adecc
	Checksum: 0xC9EC024B
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5e733914ebbc17f7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_901adecc
	Checksum: 0x470FD6FE
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
	zm_trial::register_challenge(#"hash_293a2fd65ffe0222", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_901adecc
	Checksum: 0xB71B3757
	Offset: 0x138
	Size: 0x90
	Parameters: 0
	Flags: Private
*/
function private function_d1de6a85()
{
	foreach(player in getplayers())
	{
		player callback::on_player_damage(&on_player_damage);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_901adecc
	Checksum: 0x6033BA9A
	Offset: 0x1D0
	Size: 0x98
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	foreach(player in getplayers())
	{
		player callback::remove_on_player_damage(&on_player_damage);
	}
}

/*
	Name: on_player_damage
	Namespace: namespace_901adecc
	Checksum: 0xD1F5E8A8
	Offset: 0x270
	Size: 0xC4
	Parameters: 1
	Flags: Private
*/
function private on_player_damage(params)
{
	if(isai(params.eattacker) || isai(params.einflictor) && (params.idamage > 0 || (isdefined(self.armor) && self.armor > 0)))
	{
		var_57807cdc = [];
		array::add(var_57807cdc, self, 0);
		zm_trial::fail(#"hash_41122a695bc6065d", var_57807cdc);
	}
}

