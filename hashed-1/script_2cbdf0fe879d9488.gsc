// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_1419f4a9;

/*
	Name: function_89f2df9
	Namespace: namespace_1419f4a9
	Checksum: 0x6C6FDFCC
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_40e5fe122d652dc4", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_1419f4a9
	Checksum: 0x704E8D67
	Offset: 0x118
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_d126cef79ee236d", &function_d1de6a85, &function_9e7b3f4d);
	namespace_9ff9f642::register_slowdown(#"hash_40e5fe122d652dc4", 1.5);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_1419f4a9
	Checksum: 0x8FD89E3B
	Offset: 0x1A8
	Size: 0x3C
	Parameters: 0
	Flags: Private
*/
private function function_d1de6a85()
{
	level thread function_4458377c();
	level thread zm_utility::play_sound_2d("zmb_trial_horror_round_start");
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_1419f4a9
	Checksum: 0xC525636
	Offset: 0x1F0
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
}

/*
	Name: function_4458377c
	Namespace: namespace_1419f4a9
	Checksum: 0xE2D41D44
	Offset: 0x208
	Size: 0x220
	Parameters: 0
	Flags: Private
*/
private function function_4458377c()
{
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		a_ai_zombies = getaiteamarray(level.zombie_team);
		foreach(ai in a_ai_zombies)
		{
			if(!isalive(ai) || (isdefined(ai.var_cda2fa8) && ai.var_cda2fa8))
			{
				continue;
			}
			e_player = arraygetclosest(ai.origin, getplayers());
			if(isplayer(e_player) && distance(ai.origin, e_player.origin) > 100)
			{
				ai thread function_fe65f5a6(randomfloatrange(1.25, 1.5), e_player);
			}
			else if(math::cointoss(20))
			{
				ai thread function_fe65f5a6(randomfloatrange(1.1, 1.25), e_player);
			}
			waitframe(1);
		}
		n_wait_time = randomfloatrange(1, 2);
		wait(n_wait_time);
	}
}

/*
	Name: function_fe65f5a6
	Namespace: namespace_1419f4a9
	Checksum: 0x8FD19A22
	Offset: 0x430
	Size: 0x28E
	Parameters: 3
	Flags: None
*/
function function_fe65f5a6(var_b7358df3, e_player, n_timeout = 1)
{
	self endon(#"death");
	self.var_cda2fa8 = 1;
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area) && self.archetype !== #"zombie_dog")
	{
		self waittill(#"completed_emerging_into_playable_area");
	}
	self thread namespace_9ff9f642::slowdown(#"hash_40e5fe122d652dc4", 0.75);
	n_delay_time = randomfloatrange(2, 5);
	wait(n_delay_time);
	self thread namespace_9ff9f642::slowdown(#"hash_40e5fe122d652dc4", var_b7358df3);
	self playsound(#"hash_46661e1d0062f53b");
	if(math::cointoss(20))
	{
		if(isdefined(e_player) && isalive(e_player))
		{
			if(e_player islookingat(self))
			{
				self playsoundtoplayer(#"hash_69671b54d86128ce", e_player);
			}
		}
	}
	while(n_timer < n_timeout)
	{
		if(isalive(e_player) && distance(e_player.origin, self.origin) < 100)
		{
			break;
		}
		n_timer = n_timer + float(function_60d95f53()) / 1000;
		waitframe(1);
	}
	self thread namespace_9ff9f642::slowdown(#"hash_40e5fe122d652dc4", 0.75);
	self.var_cda2fa8 = undefined;
}

/*
	Name: is_active
	Namespace: namespace_1419f4a9
	Checksum: 0x2DC0CB10
	Offset: 0x6C8
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = namespace_f551babc::function_a36e8c38(#"hash_d126cef79ee236d");
	return isdefined(challenge);
}

