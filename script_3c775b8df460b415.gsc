// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_defend_area.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace namespace_9b24ce43;

/*
	Name: __init__system__
	Namespace: namespace_9b24ce43
	Checksum: 0x4330B1FD
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_678d56e299d40621", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9b24ce43
	Checksum: 0x2BC8BCC1
	Offset: 0xF0
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
	zm_trial::register_challenge(#"hash_32cdfeca4a793d78", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_9b24ce43
	Checksum: 0xBF1FD746
	Offset: 0x158
	Size: 0x80
	Parameters: 0
	Flags: Private
*/
function private on_begin()
{
	foreach(player in getplayers())
	{
		player thread movement_watcher();
	}
}

/*
	Name: on_end
	Namespace: namespace_9b24ce43
	Checksum: 0x31B048E0
	Offset: 0x1E0
	Size: 0x8C
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		player notify(#"hash_17c41292130032eb");
	}
}

/*
	Name: is_active
	Namespace: namespace_9b24ce43
	Checksum: 0xFC2224F2
	Offset: 0x278
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_32cdfeca4a793d78");
	return isdefined(challenge);
}

/*
	Name: movement_watcher
	Namespace: namespace_9b24ce43
	Checksum: 0xC63B42DB
	Offset: 0x2B8
	Size: 0x2C2
	Parameters: 0
	Flags: Private
*/
function private movement_watcher()
{
	self endon(#"disconnect", #"hash_17c41292130032eb");
	wait(zm_round_logic::get_delay_between_rounds() - 2);
	while(true)
	{
		var_89276ce9 = 0;
		var_197c85d1 = self getvelocity();
		n_speed = length(var_197c85d1);
		var_f77522bb = self getnormalizedmovement();
		if(isalive(self) && !self laststand::player_is_in_laststand() && n_speed > 0 && !self zm_utility::is_jumping() && var_f77522bb != (0, 0, 0))
		{
			if(isdefined(self.armor) && self.armor > 0)
			{
				if(!zm_trial_defend_area::is_active() || (zm_trial_defend_area::is_active() && (isdefined(self.var_ccee13fc) && self.var_ccee13fc)))
				{
					self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
					self dodamage(11, self.origin);
					var_89276ce9 = 1;
				}
			}
			else if(!zm_trial_defend_area::is_active() || (zm_trial_defend_area::is_active() && (isdefined(self.var_ccee13fc) && self.var_ccee13fc)))
			{
				self playsoundtoplayer(#"hash_6df374d848ba6a60", self);
				self dodamage(6, self.origin);
				var_89276ce9 = 1;
			}
		}
		if(var_89276ce9)
		{
			if(zm_trial_defend_area::is_active() && (isdefined(self.var_ccee13fc) && self.var_ccee13fc))
			{
				wait(1);
			}
			else
			{
				wait(0.2);
			}
		}
		else
		{
			waitframe(1);
		}
	}
}

