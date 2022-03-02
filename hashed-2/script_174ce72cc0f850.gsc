// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3e5ec44cfab7a201;
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_bd74bbd2;

/*
	Name: register
	Namespace: namespace_bd74bbd2
	Checksum: 0x944ADE8B
	Offset: 0xB8
	Size: 0x116
	Parameters: 5
	Flags: Linked
*/
function register(id, version, script_noteworthy, func_success, func_fail)
{
	namespace_617a54f4::function_d8383812(id, version, script_noteworthy, &function_8598f0d4, &function_3bdbb583, 1);
	s_sc = struct::get(script_noteworthy, "script_noteworthy");
	s_sc.var_f929d531 = getent(s_sc.player_area, "targetname");
	s_sc.var_f929d531.id = id;
	s_sc.func_success = func_success;
	s_sc.func_fail = func_fail;
	level.var_345df07[id] = s_sc;
}

/*
	Name: start
	Namespace: namespace_bd74bbd2
	Checksum: 0x7D6BD70C
	Offset: 0x1D8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function start(id)
{
	if(level.var_d2540500[id].active !== 1)
	{
		s_sc = level.var_345df07[id];
		s_sc.var_7944be4a = 0;
		exploder::exploder(s_sc.fx_exp);
		namespace_617a54f4::function_3f808d3d(id);
		s_sc.var_f929d531 thread function_fab8c488();
	}
}

/*
	Name: end
	Namespace: namespace_bd74bbd2
	Checksum: 0x85982695
	Offset: 0x288
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function end(id)
{
	if(level.var_d2540500[id].active === 1)
	{
		s_sc = level.var_345df07[id];
		exploder::stop_exploder(s_sc.fx_exp);
		namespace_617a54f4::function_2a94055d(id);
		s_sc.var_f929d531 notify(#"hash_63acd5ff4da933c5");
	}
}

/*
	Name: function_8598f0d4
	Namespace: namespace_bd74bbd2
	Checksum: 0xDE189D4F
	Offset: 0x328
	Size: 0xF0
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8598f0d4(var_88206a50, ent)
{
	if(isdefined(ent))
	{
		b_killed_by_player = 0;
		if(isdefined(ent.attacker) && isplayer(ent.attacker))
		{
			e_player = ent.attacker;
			b_killed_by_player = 1;
		}
		else if(isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor))
		{
			e_player = ent.damageinflictor;
			b_killed_by_player = 1;
		}
		if(b_killed_by_player && e_player istouching(var_88206a50.var_f929d531))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_3bdbb583
	Namespace: namespace_bd74bbd2
	Checksum: 0x99A80DE
	Offset: 0x420
	Size: 0xD8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3bdbb583(var_f0e6c7a2, ent)
{
	n_souls_required = 12;
	if(getplayers().size > 2)
	{
		n_souls_required = 24;
	}
	else if(getplayers().size > 1)
	{
		n_souls_required = 18;
	}
	var_f0e6c7a2.var_7944be4a++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			var_f0e6c7a2.var_7944be4a = n_souls_required;
		}
	#/
	if(var_f0e6c7a2.var_7944be4a >= n_souls_required)
	{
		var_f0e6c7a2 thread [[var_f0e6c7a2.func_success]]();
	}
}

/*
	Name: function_fab8c488
	Namespace: namespace_bd74bbd2
	Checksum: 0x2B8F053B
	Offset: 0x500
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fab8c488()
{
	self endon(#"death", #"hash_63acd5ff4da933c5");
	while(self namespace_509a75d1::function_b8a27acc())
	{
		wait(0.1);
	}
	self thread player_enter_watcher();
	self thread function_b1e6482f();
}

/*
	Name: player_enter_watcher
	Namespace: namespace_bd74bbd2
	Checksum: 0xD9F028A6
	Offset: 0x588
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private player_enter_watcher()
{
	self endon(#"death", #"hash_63acd5ff4da933c5");
	while(!self namespace_509a75d1::function_b8a27acc())
	{
		wait(0.1);
	}
	self notify(#"player_enter");
	self thread function_fab8c488();
}

/*
	Name: function_b1e6482f
	Namespace: namespace_bd74bbd2
	Checksum: 0x8E642D1B
	Offset: 0x608
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b1e6482f()
{
	self endon(#"death", #"player_enter", #"hash_63acd5ff4da933c5");
	wait(5);
	level thread [[level.var_345df07[self.id].func_fail]]();
	end(self.id);
}

