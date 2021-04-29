// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_629725b7;

/*
	Name: function_89f2df9
	Namespace: namespace_629725b7
	Checksum: 0x9F735110
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_34f1ac5824b8f875", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_629725b7
	Checksum: 0xACCB983C
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_5065d3f7d21bf9d4", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_629725b7
	Checksum: 0x32E39B0D
	Offset: 0x148
	Size: 0xD4
	Parameters: 2
	Flags: Private
*/
private function function_d1de6a85(var_85af3be4, var_752d90ad)
{
	if(getplayers().size == 1)
	{
		level.var_b529249b = namespace_f551babc::function_5769f26a(var_752d90ad);
	}
	else
	{
		level.var_b529249b = namespace_f551babc::function_5769f26a(var_85af3be4);
	}
	level.var_4b9163d5 = 0;
	namespace_b22c99a5::function_2976fa44(level.var_b529249b);
	namespace_b22c99a5::function_dace284(level.var_b529249b, 1);
	callback::on_player_damage(&on_player_damage);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_629725b7
	Checksum: 0xE57531A3
	Offset: 0x228
	Size: 0x54
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	level.var_b529249b = undefined;
	level.var_4b9163d5 = undefined;
	callback::remove_on_player_damage(&on_player_damage);
}

/*
	Name: is_active
	Namespace: namespace_629725b7
	Checksum: 0xB8AA7329
	Offset: 0x288
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_5065d3f7d21bf9d4");
	return isdefined(challenge);
}

/*
	Name: on_player_damage
	Namespace: namespace_629725b7
	Checksum: 0x880A4432
	Offset: 0x2C8
	Size: 0xA4
	Parameters: 1
	Flags: Private
*/
private function on_player_damage(params)
{
	if(params.idamage >= 0)
	{
		level.var_4b9163d5++;
		namespace_b22c99a5::function_dace284(level.var_b529249b - level.var_4b9163d5);
		if(level.var_4b9163d5 >= level.var_b529249b)
		{
			namespace_f551babc::fail(#"hash_404865fbf8dd5cc2", array(self));
		}
	}
}

