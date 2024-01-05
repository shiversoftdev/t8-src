// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_d30b9d9b;

/*
	Name: __init__system__
	Namespace: namespace_d30b9d9b
	Checksum: 0x2962C3C8
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_2dccaaff9ebe6851", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d30b9d9b
	Checksum: 0x2A647536
	Offset: 0xC8
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
	zm_trial::register_challenge(#"hash_3a3072e83c70889c", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_d30b9d9b
	Checksum: 0xDD0B9891
	Offset: 0x130
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(var_ff22cb62)
{
	self.var_ff22cb62 = zm_trial::function_5769f26a(var_ff22cb62);
	self.var_6a7521e3 = 0;
	self thread function_53627246();
}

/*
	Name: on_end
	Namespace: namespace_d30b9d9b
	Checksum: 0xE791F91
	Offset: 0x188
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	foreach(s_portal in level.a_s_portals)
	{
		s_portal.var_5b12474a = undefined;
	}
	if(isdefined(level.s_cage_portal))
	{
		level.s_cage_portal.var_5b12474a = undefined;
	}
	if(!round_reset)
	{
		if(self.var_6a7521e3 < self.var_ff22cb62)
		{
			zm_trial::fail(#"hash_6a1df2dbfb66a948");
		}
	}
}

/*
	Name: function_53627246
	Namespace: namespace_d30b9d9b
	Checksum: 0x86FFB166
	Offset: 0x278
	Size: 0x12C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_53627246()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	zm_trial_util::function_2976fa44(self.var_ff22cb62);
	zm_trial_util::function_dace284(self.var_6a7521e3);
	while(true)
	{
		s_waitresult = undefined;
		s_waitresult = level waittill(#"portal_used");
		if(!(isdefined(s_waitresult.s_portal.var_5b12474a) && s_waitresult.s_portal.var_5b12474a))
		{
			s_waitresult.s_portal.var_5b12474a = 1;
			self.var_6a7521e3++;
			zm_trial_util::function_dace284(self.var_6a7521e3);
		}
		if(self.var_6a7521e3 == self.var_ff22cb62)
		{
			zm_trial_util::function_7d32b7d0(1);
			break;
		}
	}
}

