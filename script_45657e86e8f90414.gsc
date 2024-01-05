// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.csc;
#using scripts\zm_common\zm_trial.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_fcd611c3;

/*
	Name: __init__system__
	Namespace: namespace_fcd611c3
	Checksum: 0xE11F5AFB
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_281322718ac3cd88", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_fcd611c3
	Checksum: 0xC6F92F2F
	Offset: 0xF8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_64d77357e69aee75", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_fcd611c3
	Checksum: 0x8A779047
	Offset: 0x160
	Size: 0x42
	Parameters: 2
	Flags: Private
*/
function private on_begin(localclientnum, a_params)
{
	level.var_e91491fb = (isdefined(a_params[0]) ? a_params[0] : "movement");
}

/*
	Name: on_end
	Namespace: namespace_fcd611c3
	Checksum: 0xFA366148
	Offset: 0x1B0
	Size: 0x16
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	level.var_e91491fb = undefined;
}

/*
	Name: is_active
	Namespace: namespace_fcd611c3
	Checksum: 0x9040C5FB
	Offset: 0x1D0
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	s_challenge = zm_trial::function_a36e8c38(#"hash_64d77357e69aee75");
	return isdefined(s_challenge);
}

/*
	Name: function_26f124d8
	Namespace: namespace_fcd611c3
	Checksum: 0x9DFFCC14
	Offset: 0x210
	Size: 0x1DC
	Parameters: 0
	Flags: None
*/
function function_26f124d8()
{
	if(!isdefined(level.var_e91491fb))
	{
		return true;
	}
	switch(level.var_e91491fb)
	{
		case "ads":
		{
			if(self isplayerads())
			{
				return true;
			}
			return false;
		}
		case "jump":
		{
			if(self isplayerjumping())
			{
				return true;
			}
			return false;
		}
		case "slide":
		{
			if(self isplayersliding())
			{
				return true;
			}
			return false;
		}
		case "hash_6c6c8f6b349b8751":
		{
			if(self isplayerjumping() || self isplayersliding())
			{
				return true;
			}
			return false;
		}
		case "crouch":
		{
			if(self getstance() === "crouch")
			{
				return true;
			}
			return false;
		}
		case "prone":
		{
			if(self getstance() === "prone")
			{
				return true;
			}
			return false;
		}
		case "movement":
		default:
		{
			v_velocity = self getvelocity();
			if(length(v_velocity) != 0)
			{
				return true;
			}
			return false;
		}
	}
	return false;
}

