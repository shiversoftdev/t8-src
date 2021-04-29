// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_32192f7;

/*
	Name: function_89f2df9
	Namespace: namespace_32192f7
	Checksum: 0xA09F2837
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_48e0e8f7de7eaf3c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_32192f7
	Checksum: 0x631C87A2
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_79a710e660651843", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_32192f7
	Checksum: 0x10078C50
	Offset: 0x150
	Size: 0x1B4
	Parameters: 5
	Flags: Linked, Private
*/
private function function_d1de6a85(enemy_type, var_6b96eb7b, var_46cce0c5, var_6ad4e7c6, var_44445188)
{
	if(getplayers().size > 1)
	{
		self.enemy_count = namespace_f551babc::function_5769f26a(var_46cce0c5);
	}
	else
	{
		self.enemy_count = namespace_f551babc::function_5769f26a(var_6b96eb7b);
	}
	level.var_9a0fbcb9 = 0;
	self.enemy_type = enemy_type;
	self.enemies_killed = 0;
	level.zombie_total = self.enemy_count;
	level.var_efbb07e = level.var_ef1a71b3;
	level.var_ef1a71b3 = &get_zombie_count_for_round;
	level.var_dc22f98 = level.fn_custom_round_ai_spawn;
	level.fn_custom_round_ai_spawn = &spawn_enemy;
	level.var_692420f3 = level.var_ab84adee;
	level.var_ab84adee = 1;
	level.var_44445188 = var_44445188;
	callback::on_ai_killed(&on_ai_killed);
	if(isdefined(var_6ad4e7c6))
	{
		level.var_d0be33a6 = 1;
		namespace_b22c99a5::function_2976fa44(self.enemy_count);
		namespace_b22c99a5::function_dace284(self.enemies_killed);
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_32192f7
	Checksum: 0x60FD0DA7
	Offset: 0x310
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_9a0fbcb9 = undefined;
	level.var_44445188 = undefined;
	level.var_d0be33a6 = undefined;
	level.var_ef1a71b3 = level.var_efbb07e;
	level.fn_custom_round_ai_spawn = level.var_dc22f98;
	level.var_ab84adee = level.var_692420f3;
	namespace_b22c99a5::function_f3dbeda7();
	callback::remove_on_ai_killed(&on_ai_killed);
}

/*
	Name: on_ai_killed
	Namespace: namespace_32192f7
	Checksum: 0x693AD098
	Offset: 0x3B8
	Size: 0x184
	Parameters: 1
	Flags: Linked, Private
*/
private function on_ai_killed(params)
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_79a710e660651843");
	/#
		assert(isdefined(challenge), "");
	#/
	if(challenge.enemy_type !== self.archetype)
	{
		return;
	}
	if(isdefined(self.var_e700d5e2) && self.var_e700d5e2)
	{
		return;
	}
	if(level.var_44445188 === #"hash_6a1ae478973ee12" && isplayer(params.eattacker) && zm_utility::is_headshot(params.weapon, params.shitloc, params.smeansofdeath))
	{
		namespace_f551babc::fail(#"hash_11e532a4f9c3e482", array(params.eattacker));
		return;
	}
	challenge.enemies_killed++;
	if(isdefined(level.var_d0be33a6) && level.var_d0be33a6)
	{
		namespace_b22c99a5::function_dace284(challenge.enemies_killed);
	}
}

/*
	Name: get_zombie_count_for_round
	Namespace: namespace_32192f7
	Checksum: 0x579651A9
	Offset: 0x548
	Size: 0x1E
	Parameters: 2
	Flags: Linked, Private
*/
private function get_zombie_count_for_round(round_number, player_count)
{
	return level.zombie_total;
}

/*
	Name: spawn_enemy
	Namespace: namespace_32192f7
	Checksum: 0x90578105
	Offset: 0x570
	Size: 0x224
	Parameters: 0
	Flags: Linked, Private
*/
private function spawn_enemy()
{
	var_f63f3454 = namespace_f551babc::function_a36e8c38(#"hash_a0e875894ebc5ff");
	if(isdefined(var_f63f3454))
	{
		var_47ab7d31 = util::get_active_players().size;
		var_f55dd0ac = 0;
		foreach(player in util::get_active_players())
		{
			if(isdefined(player.var_4cb0b91f) && player.var_4cb0b91f)
			{
				var_f55dd0ac++;
			}
		}
		if(var_f55dd0ac < var_47ab7d31)
		{
			return 1;
		}
	}
	challenge = namespace_f551babc::function_a36e8c38(#"hash_79a710e660651843");
	/#
		assert(isdefined(challenge));
	#/
	/#
		/#
			assert(isdefined(level.var_1cc18005));
		#/
		/#
			assert(isdefined(level.var_1cc18005[challenge.enemy_type]), "" + function_9e72a96(challenge.enemy_type));
		#/
	#/
	var_cdcbbb56 = level.var_1cc18005[challenge.enemy_type];
	var_6e7e6c5e = [[var_cdcbbb56]]();
	if(isdefined(var_6e7e6c5e) && var_6e7e6c5e)
	{
		level.zombie_total--;
	}
	return 1;
}

/*
	Name: function_95c1dd81
	Namespace: namespace_32192f7
	Checksum: 0xB10AB0B3
	Offset: 0x7A0
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function function_95c1dd81(name, var_cdcbbb56)
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	if(!isdefined(level.var_1cc18005))
	{
		level.var_1cc18005 = [];
	}
	/#
		assert(!isdefined(level.var_1cc18005[name]), "" + name);
	#/
	level.var_1cc18005[name] = var_cdcbbb56;
}

/*
	Name: is_active
	Namespace: namespace_32192f7
	Checksum: 0x19169BAF
	Offset: 0x840
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_79a710e660651843");
	return isdefined(challenge);
}

