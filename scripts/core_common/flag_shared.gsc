// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace flag;

/*
	Name: init
	Namespace: flag
	Checksum: 0x7C31E01F
	Offset: 0xA0
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function init(str_flag, b_val = 0)
{
	if(!isdefined(self.flag))
	{
		self.flag = [];
	}
	if(!isdefined(self.flag_count))
	{
		self.flag_count = [];
	}
	/#
		if(!isdefined(level.first_frame))
		{
			/#
				assert(!isdefined(self.flag[str_flag]), "" + str_flag + "");
			#/
		}
	#/
	self.flag[str_flag] = b_val;
	self.flag_count[str_flag] = 0;
}

/*
	Name: exists
	Namespace: flag
	Checksum: 0xB974578B
	Offset: 0x178
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function exists(str_flag)
{
	return isdefined(self.flag) && isdefined(self.flag[str_flag]);
}

/*
	Name: set
	Namespace: flag
	Checksum: 0x1AA586A6
	Offset: 0x1A8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function set(str_flag)
{
	/#
		/#
			assert(exists(str_flag), "" + function_9e72a96(str_flag) + "");
		#/
	#/
	self.flag[str_flag] = 1;
	self notify(str_flag);
	trigger::set_flag_permissions(str_flag);
}

/*
	Name: increment
	Namespace: flag
	Checksum: 0x302929BD
	Offset: 0x248
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function increment(str_flag)
{
	/#
		/#
			assert(exists(str_flag), "" + function_9e72a96(str_flag) + "");
		#/
	#/
	self.flag_count[str_flag]++;
	set(str_flag);
}

/*
	Name: decrement
	Namespace: flag
	Checksum: 0x8549BA34
	Offset: 0x2E0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function decrement(str_flag)
{
	/#
		/#
			assert(exists(str_flag), "" + function_9e72a96(str_flag) + "");
		#/
	#/
	/#
		assert(self.flag_count[str_flag] > 0, "");
	#/
	self.flag_count[str_flag]--;
	if(self.flag_count[str_flag] == 0)
	{
		clear(str_flag);
	}
}

/*
	Name: delay_set
	Namespace: flag
	Checksum: 0x95E7A0E5
	Offset: 0x3C0
	Size: 0x3C
	Parameters: 3
	Flags: None
*/
function delay_set(n_delay, str_flag, str_cancel)
{
	self thread _delay_set(n_delay, str_flag, str_cancel);
}

/*
	Name: _delay_set
	Namespace: flag
	Checksum: 0xC2CE69B3
	Offset: 0x408
	Size: 0x5C
	Parameters: 3
	Flags: Linked
*/
function _delay_set(n_delay, str_flag, str_cancel)
{
	if(isdefined(str_cancel))
	{
		self endon(str_cancel);
	}
	self endon(#"death");
	wait(n_delay);
	set(str_flag);
}

/*
	Name: set_val
	Namespace: flag
	Checksum: 0x544E2E12
	Offset: 0x470
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function set_val(str_flag, b_val)
{
	/#
		assert(isdefined(b_val), "");
	#/
	if(b_val)
	{
		set(str_flag);
	}
	else
	{
		clear(str_flag);
	}
}

/*
	Name: set_for_time
	Namespace: flag
	Checksum: 0x4B912FFE
	Offset: 0x4E8
	Size: 0x64
	Parameters: 2
	Flags: None
*/
function set_for_time(n_time, str_flag)
{
	self notify("__flag::set_for_time__" + str_flag);
	self endon("__flag::set_for_time__" + str_flag);
	set(str_flag);
	wait(n_time);
	clear(str_flag);
}

/*
	Name: clear
	Namespace: flag
	Checksum: 0x654B3639
	Offset: 0x558
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function clear(str_flag)
{
	/#
		assert(exists(str_flag), "" + str_flag + "");
	#/
	if(self.flag[str_flag])
	{
		self.flag[str_flag] = 0;
		self notify(str_flag);
		trigger::set_flag_permissions(str_flag);
	}
}

/*
	Name: toggle
	Namespace: flag
	Checksum: 0xCE83372
	Offset: 0x5F0
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function toggle(str_flag)
{
	if(get(str_flag))
	{
		clear(str_flag);
	}
	else
	{
		set(str_flag);
	}
}

/*
	Name: get
	Namespace: flag
	Checksum: 0xA18869C3
	Offset: 0x650
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function get(str_flag)
{
	/#
		assert(exists(str_flag), "" + str_flag + "");
	#/
	return self.flag[str_flag];
}

/*
	Name: get_any
	Namespace: flag
	Checksum: 0x7792FB45
	Offset: 0x6B0
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function get_any(array)
{
	foreach(str_flag in array)
	{
		if(get(str_flag))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: get_all
	Namespace: flag
	Checksum: 0xF6A742BD
	Offset: 0x748
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function get_all(array)
{
	foreach(str_flag in array)
	{
		if(!get(str_flag))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: wait_till
	Namespace: flag
	Checksum: 0x1ECAECB1
	Offset: 0x7E0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function wait_till(str_flag)
{
	self endon(#"death");
	while(!get(str_flag))
	{
		self waittill(str_flag);
	}
}

/*
	Name: wait_till_timeout
	Namespace: flag
	Checksum: 0x9AF68855
	Offset: 0x830
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function wait_till_timeout(n_timeout, str_flag)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till(str_flag);
}

/*
	Name: wait_till_all
	Namespace: flag
	Checksum: 0xD750B1DE
	Offset: 0x8C0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function wait_till_all(a_flags)
{
	self endon(#"death");
	for(i = 0; i < a_flags.size; i++)
	{
		str_flag = a_flags[i];
		if(!get(str_flag))
		{
			self waittill(str_flag);
			i = -1;
		}
	}
}

/*
	Name: wait_till_all_timeout
	Namespace: flag
	Checksum: 0x6798ED8B
	Offset: 0x950
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function wait_till_all_timeout(n_timeout, a_flags)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till_all(a_flags);
}

/*
	Name: wait_till_any
	Namespace: flag
	Checksum: 0x6F719FA8
	Offset: 0x9E0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function wait_till_any(a_flags)
{
	self endon(#"death");
	foreach(flag in a_flags)
	{
		if(get(flag))
		{
			return {#_notify:flag};
		}
	}
	return self waittill(a_flags);
}

/*
	Name: wait_till_any_timeout
	Namespace: flag
	Checksum: 0x553AF8B1
	Offset: 0xAA0
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function wait_till_any_timeout(n_timeout, a_flags)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till_any(a_flags);
}

/*
	Name: wait_till_clear
	Namespace: flag
	Checksum: 0xA71D2EDE
	Offset: 0xB30
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function wait_till_clear(str_flag)
{
	self endon(#"death");
	while(get(str_flag))
	{
		self waittill(str_flag);
	}
}

/*
	Name: wait_till_clear_timeout
	Namespace: flag
	Checksum: 0xB432B1AD
	Offset: 0xB80
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function wait_till_clear_timeout(n_timeout, str_flag)
{
	self endon(#"death");
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till_clear(str_flag);
}

/*
	Name: wait_till_clear_all
	Namespace: flag
	Checksum: 0x9C143B3B
	Offset: 0xC28
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function wait_till_clear_all(a_flags)
{
	self endon(#"death");
	for(i = 0; i < a_flags.size; i++)
	{
		str_flag = a_flags[i];
		if(get(str_flag))
		{
			self waittill(str_flag);
			i = -1;
		}
	}
}

/*
	Name: function_5f02becb
	Namespace: flag
	Checksum: 0x21E3FB34
	Offset: 0xCB8
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_5f02becb(n_timeout)
{
	if(isdefined(n_timeout) && n_timeout > 0)
	{
		if(isdefined(n_timeout))
		{
			__s = spawnstruct();
			__s endon(#"timeout");
			__s util::delay_notify(n_timeout, "timeout");
		}
	}
	if(isdefined(self.script_flag_true))
	{
		var_ed5ed076 = util::create_flags_and_return_tokens(self.script_flag_true);
		level wait_till_all(var_ed5ed076);
	}
	if(isdefined(self.script_flag_false))
	{
		var_b1418b4 = util::create_flags_and_return_tokens(self.script_flag_false);
		level wait_till_clear_all(var_b1418b4);
	}
}

/*
	Name: wait_till_clear_all_timeout
	Namespace: flag
	Checksum: 0xDB9C9D24
	Offset: 0xDD0
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function wait_till_clear_all_timeout(n_timeout, a_flags)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till_clear_all(a_flags);
}

/*
	Name: wait_till_clear_any
	Namespace: flag
	Checksum: 0xB326169D
	Offset: 0xE60
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function wait_till_clear_any(a_flags)
{
	self endon(#"death");
	while(true)
	{
		foreach(flag in a_flags)
		{
			if(!get(flag))
			{
				return flag;
			}
		}
		self waittill(a_flags);
	}
}

/*
	Name: wait_till_clear_any_timeout
	Namespace: flag
	Checksum: 0x5BC2F98
	Offset: 0xF18
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function wait_till_clear_any_timeout(n_timeout, a_flags)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	wait_till_clear_any(a_flags);
}

/*
	Name: delete
	Namespace: flag
	Checksum: 0x22AC3A30
	Offset: 0xFA8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function delete(str_flag)
{
	if(isdefined(self.flag[str_flag]))
	{
		self.flag[str_flag] = undefined;
	}
	println("" + str_flag);
}

/*
	Name: script_flag_wait
	Namespace: flag
	Checksum: 0x95C7B48F
	Offset: 0x1008
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function script_flag_wait()
{
	if(isdefined(self.script_flag_wait))
	{
		self wait_till(self.script_flag_wait);
		return 1;
	}
	return 0;
}

