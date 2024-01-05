// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace namespace_32623e1c;

/*
	Name: __init__system__
	Namespace: namespace_32623e1c
	Checksum: 0x221B3701
	Offset: 0x98
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_7b354b317eaf8341", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_32623e1c
	Checksum: 0x75CF35FE
	Offset: 0xE0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"damage_drains_points", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_32623e1c
	Checksum: 0x105EC22C
	Offset: 0x148
	Size: 0xBA
	Parameters: 2
	Flags: Linked, Private
*/
function private on_begin(var_66fe7443, var_ec90b685)
{
	if(isdefined(var_ec90b685))
	{
		self.var_ec90b685 = 1;
		callback::on_ai_killed(&function_8e0401ab);
		level.var_a58dc99e = zm_trial::function_5769f26a(var_66fe7443);
	}
	else
	{
		var_620e7dea = zm_trial::function_5769f26a(var_66fe7443) / 100;
		level.var_baf7ae7f = level.var_a2d8b7eb;
		level.var_a2d8b7eb = var_620e7dea;
	}
}

/*
	Name: on_end
	Namespace: namespace_32623e1c
	Checksum: 0x9AD735
	Offset: 0x210
	Size: 0x7A
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	if(isdefined(self.var_ec90b685) && self.var_ec90b685)
	{
		callback::remove_on_ai_killed(&function_8e0401ab);
		level.var_a58dc99e = undefined;
		self.var_ec90b685 = undefined;
	}
	else
	{
		level.var_a2d8b7eb = level.var_baf7ae7f;
		level.var_baf7ae7f = undefined;
	}
}

/*
	Name: is_active
	Namespace: namespace_32623e1c
	Checksum: 0x3B4F273
	Offset: 0x298
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function is_active(var_a32bbdd = 0)
{
	s_challenge = zm_trial::function_a36e8c38(#"damage_drains_points");
	if(var_a32bbdd)
	{
		if(isdefined(s_challenge) && (isdefined(s_challenge.var_ec90b685) && s_challenge.var_ec90b685))
		{
			return 1;
		}
		return 0;
	}
	return isdefined(s_challenge);
}

/*
	Name: function_8e0401ab
	Namespace: namespace_32623e1c
	Checksum: 0xCAB3B737
	Offset: 0x328
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8e0401ab(params)
{
	if(isdefined(self.nuked) && self.nuked)
	{
		a_players = util::get_active_players();
		var_fc97ca4d = array::random(a_players);
		if(isplayer(var_fc97ca4d))
		{
			var_fc97ca4d zm_score::minus_to_player_score(level.var_a58dc99e, 1);
		}
	}
	else if(isplayer(params.eattacker))
	{
		params.eattacker zm_score::minus_to_player_score(level.var_a58dc99e, 1);
	}
}

