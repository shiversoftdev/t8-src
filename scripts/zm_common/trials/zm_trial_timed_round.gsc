// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2595527427ea71eb;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace orange_fastt_zm;

/*
	Name: __init__system__
	Namespace: orange_fastt_zm
	Checksum: 0x41F6EDE2
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_timed_round", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: orange_fastt_zm
	Checksum: 0x8491F0A7
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"timed_round", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: orange_fastt_zm
	Checksum: 0x439D3F64
	Offset: 0x170
	Size: 0x11C
	Parameters: 3
	Flags: Linked, Private
*/
function private on_begin(var_6325d314, var_52b8b3a2, n_time)
{
	n_time_limit = zm_trial::function_5769f26a(n_time);
	n_grace = zm_trial::function_5769f26a(var_52b8b3a2);
	level thread function_8b87e57c(var_6325d314, n_grace, n_time_limit);
	level flag::set(#"infinite_round_spawning");
	level flag::set(#"pause_round_timeout");
	level.var_382a24b0 = 1;
	callback::on_spawned(&function_31f197c2);
	callback::add_callback(#"hash_137b937fd26992be", &function_ff66b979);
}

/*
	Name: on_end
	Namespace: orange_fastt_zm
	Checksum: 0xC2A5C96B
	Offset: 0x298
	Size: 0x164
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	foreach(player in getplayers())
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
			player zm_trial_util::stop_timer();
		}
	}
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.var_382a24b0 = undefined;
	callback::remove_on_spawned(&function_31f197c2);
	callback::remove_callback(#"hash_137b937fd26992be", &function_ff66b979);
}

/*
	Name: function_8b87e57c
	Namespace: orange_fastt_zm
	Checksum: 0x63756787
	Offset: 0x408
	Size: 0x2B8
	Parameters: 3
	Flags: Linked, Private
*/
function private function_8b87e57c(var_6325d314, n_grace, n_time_limit)
{
	level endon(#"end_of_round", #"host_migration_begin");
	wait(n_grace);
	level thread function_14a98a41(var_6325d314, n_time_limit);
	foreach(player in getplayers())
	{
		if(!level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::open(player);
			level.var_f995ece6 zm_trial_timer::set_timer_text(player, var_6325d314);
			level.var_f995ece6 zm_trial_timer::set_under_round_rules(player, 1);
		}
		player zm_trial_util::start_timer(n_time_limit);
	}
	wait(n_time_limit);
	foreach(player in getplayers())
	{
		if(level.var_f995ece6 zm_trial_timer::is_open(player))
		{
			level.var_f995ece6 zm_trial_timer::close(player);
			player zm_trial_util::stop_timer();
		}
	}
	level flag::clear(#"infinite_round_spawning");
	level flag::clear(#"pause_round_timeout");
	level.zombie_total = 0;
	level thread zm_utility::function_9ad5aeb1(0, 1);
	level notify(#"kill_round");
	level notify(#"kill_round_wait");
}

/*
	Name: function_31f197c2
	Namespace: orange_fastt_zm
	Checksum: 0x37CDCA79
	Offset: 0x6C8
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_31f197c2()
{
	level endon(#"hash_7646638df88a3656");
	self endon(#"disconnect");
	wait(0.5);
	var_9a703be9 = level.var_869f4c31;
	while(var_9a703be9 == level.var_869f4c31)
	{
		waitframe(1);
	}
	if(!level.var_f995ece6 zm_trial_timer::is_open(self))
	{
		level.var_f995ece6 zm_trial_timer::open(self);
		level.var_f995ece6 zm_trial_timer::set_timer_text(self, level.var_489d6aa2);
		level.var_f995ece6 zm_trial_timer::set_under_round_rules(self, 1);
		self zm_trial_util::start_timer(level.var_869f4c31);
	}
}

/*
	Name: function_14a98a41
	Namespace: orange_fastt_zm
	Checksum: 0x934F7B75
	Offset: 0x7E0
	Size: 0x90
	Parameters: 2
	Flags: Linked, Private
*/
function private function_14a98a41(str_label, n_time_limit)
{
	self notify("6b2c93b0788dd738");
	self endon("6b2c93b0788dd738");
	level endon(#"end_of_round", #"host_migration_begin");
	level.var_489d6aa2 = str_label;
	level.var_869f4c31 = n_time_limit;
	while(true)
	{
		wait(1);
		level.var_869f4c31--;
	}
}

/*
	Name: function_ff66b979
	Namespace: orange_fastt_zm
	Checksum: 0x4C90B67E
	Offset: 0x878
	Size: 0xF4
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
	}
	wait(5);
	level thread function_8b87e57c(level.var_489d6aa2, 0, level.var_869f4c31);
}

