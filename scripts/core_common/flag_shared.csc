// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace flag;

/*
	Name: init
	Namespace: flag
	Checksum: 0xBC82A342
	Offset: 0x98
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function init(str_flag, b_val = 0, b_is_trigger = 0)
{
	if(!isdefined(self.flag))
	{
		self.flag = [];
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
}

/*
	Name: exists
	Namespace: flag
	Checksum: 0x4EF6855B
	Offset: 0x158
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
	Checksum: 0x8D3F413F
	Offset: 0x188
	Size: 0x82
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
}

/*
	Name: delay_set
	Namespace: flag
	Checksum: 0x5F98E0
	Offset: 0x218
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
	Checksum: 0x668E81B4
	Offset: 0x260
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
	Name: set_for_time
	Namespace: flag
	Checksum: 0x74DAF04C
	Offset: 0x2C8
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
	Checksum: 0x81D702B8
	Offset: 0x338
	Size: 0x76
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
	}
}

/*
	Name: toggle
	Namespace: flag
	Checksum: 0x89CF1BE1
	Offset: 0x3B8
	Size: 0x54
	Parameters: 1
	Flags: Linked
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
	Checksum: 0xDD02BECE
	Offset: 0x418
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
	Name: wait_till
	Namespace: flag
	Checksum: 0x411F40F3
	Offset: 0x478
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
	Checksum: 0x43ADC6BC
	Offset: 0x4C8
	Size: 0x84
	Parameters: 2
	Flags: None
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
	Checksum: 0x105B4A61
	Offset: 0x558
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
	Checksum: 0xCC12E536
	Offset: 0x5E8
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
	Checksum: 0x7F17E06C
	Offset: 0x678
	Size: 0xA4
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
			return flag;
		}
	}
	self waittill(a_flags);
}

/*
	Name: wait_till_any_timeout
	Namespace: flag
	Checksum: 0x63DD37CE
	Offset: 0x728
	Size: 0x84
	Parameters: 2
	Flags: None
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
	Checksum: 0xFD25E8C8
	Offset: 0x7B8
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
	Checksum: 0x8941AEE1
	Offset: 0x808
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function wait_till_clear_timeout(n_timeout, str_flag)
{
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
	Checksum: 0x4EDDF903
	Offset: 0x898
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
	Name: wait_till_clear_all_timeout
	Namespace: flag
	Checksum: 0x4B402FF7
	Offset: 0x928
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
	Checksum: 0x5D6C95A9
	Offset: 0x9B8
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
	Checksum: 0x4266045A
	Offset: 0xA70
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
	Checksum: 0x5C179019
	Offset: 0xB00
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

