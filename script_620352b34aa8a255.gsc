// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace namespace_c401fb8b;

/*
	Name: __init__system__
	Namespace: namespace_c401fb8b
	Checksum: 0xE8E9DA10
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_262f628396f811df", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c401fb8b
	Checksum: 0xD34D2BD7
	Offset: 0x100
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
	zm_trial::register_challenge(#"teleporter_timeout", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_c401fb8b
	Checksum: 0x8A8123DC
	Offset: 0x168
	Size: 0x108
	Parameters: 2
	Flags: Linked, Private
*/
function private on_begin(timeout_time, var_b2c60867)
{
	callback::add_callback(#"on_host_migration_end", &function_ff66b979);
	self.timeout_time = zm_trial::function_5769f26a(timeout_time);
	foreach(player in getplayers())
	{
		player thread function_ad32d69(var_b2c60867, self.timeout_time, 0, 1);
		player thread damage_monitor(1);
	}
}

/*
	Name: on_end
	Namespace: namespace_c401fb8b
	Checksum: 0xAE4DAD0D
	Offset: 0x278
	Size: 0x108
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::remove_callback(#"on_host_migration_end", &function_ff66b979);
	foreach(player in getplayers())
	{
		player.var_b2c60867 = undefined;
		player.var_e14296de = undefined;
		player.n_timeout_time = undefined;
		player.var_60fa6139 = undefined;
		player zm_trial_util::stop_timer();
		level.var_f995ece6 zm_trial_timer::close(player);
	}
}

/*
	Name: function_ad32d69
	Namespace: namespace_c401fb8b
	Checksum: 0x553EF01A
	Offset: 0x388
	Size: 0x248
	Parameters: 4
	Flags: Linked, Private
*/
function private function_ad32d69(var_b2c60867, timeout, var_ca735ce8, var_a4a28ac7)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656", #"host_migration_begin");
	if(isdefined(var_a4a28ac7) && var_a4a28ac7)
	{
		wait(12);
	}
	self.var_b2c60867 = var_b2c60867;
	self.var_e14296de = level.time;
	self.n_timeout_time = timeout;
	self.var_60fa6139 = (level.time + (timeout * 1000)) - (var_ca735ce8 * 1000);
	self.b_teleporting = 0;
	level.var_f995ece6 zm_trial_timer::open(self);
	level.var_f995ece6 zm_trial_timer::set_timer_text(self, var_b2c60867);
	self zm_trial_util::start_timer(timeout - var_ca735ce8);
	while(true)
	{
		self waittill(#"teleporting");
		self.b_teleporting = 1;
		if(level.var_f995ece6 zm_trial_timer::is_open(self))
		{
			level.var_f995ece6 zm_trial_timer::close(self);
		}
		self zm_trial_util::stop_timer();
		wait(3.75);
		self zm_trial_util::start_timer(timeout);
		self.var_e14296de = level.time;
		self.var_60fa6139 = level.time + (timeout * 1000);
		self.b_teleporting = 0;
		if(!level.var_f995ece6 zm_trial_timer::is_open(self))
		{
			level.var_f995ece6 zm_trial_timer::open(self);
		}
	}
}

/*
	Name: damage_monitor
	Namespace: namespace_c401fb8b
	Checksum: 0x65B4A0AA
	Offset: 0x5D8
	Size: 0x1F0
	Parameters: 1
	Flags: Linked, Private
*/
function private damage_monitor(var_a4a28ac7)
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656", #"host_migration_begin");
	if(isdefined(var_a4a28ac7) && var_a4a28ac7)
	{
		wait(12);
	}
	while(true)
	{
		if(self.var_60fa6139 < level.time && self.b_teleporting === 0 && self.sessionstate != "spectator" && !self laststand::player_is_in_laststand() && (!(isdefined(self.var_eb319d10) && self.var_eb319d10)))
		{
			if(level.var_f995ece6 zm_trial_timer::is_open(self))
			{
				level.var_f995ece6 zm_trial_timer::close(self);
			}
			var_16e6b8ea = int(self.maxhealth * 0.0667);
			if(self.health <= var_16e6b8ea)
			{
				if(zm_utility::is_magic_bullet_shield_enabled(self))
				{
					self util::stop_magic_bullet_shield();
				}
				self dodamage(self.health + 1000, self.origin);
				waitframe(1);
			}
			else
			{
				self dodamage(var_16e6b8ea, self.origin);
				wait(1);
			}
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: function_ff66b979
	Namespace: namespace_c401fb8b
	Checksum: 0x75766ABB
	Offset: 0x7D0
	Size: 0x1D8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ff66b979()
{
	level endon(#"end_of_round");
	foreach(player in getplayers())
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
		}
		player zm_trial_util::stop_timer();
	}
	var_a0328dd5 = gettime();
	wait(5);
	foreach(player in getplayers())
	{
		timer_delta = var_a0328dd5 - player.var_e14296de;
		player thread function_ad32d69(player.var_b2c60867, player.n_timeout_time, int(float(timer_delta) / 1000), 0);
		player thread damage_monitor(0);
	}
}

