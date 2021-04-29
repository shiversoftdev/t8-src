// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace flagsys;

/*
	Name: set
	Namespace: flagsys
	Checksum: 0xF2FCA391
	Offset: 0x98
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function set(str_flag)
{
	if(!isdefined(self.flag))
	{
		self.flag = [];
	}
	self.flag[str_flag] = 1;
	self notify(str_flag);
}

/*
	Name: set_for_time
	Namespace: flagsys
	Checksum: 0x3201CF69
	Offset: 0xE0
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
	Namespace: flagsys
	Checksum: 0xF22C6980
	Offset: 0x150
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function clear(str_flag)
{
	if(isdefined(self) && isdefined(self.flag) && (isdefined(self.flag[str_flag]) && self.flag[str_flag]))
	{
		self.flag[str_flag] = undefined;
		self notify(str_flag);
	}
}

/*
	Name: set_val
	Namespace: flagsys
	Checksum: 0xE45CB388
	Offset: 0x1C0
	Size: 0x6C
	Parameters: 2
	Flags: Linked
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
	Name: toggle
	Namespace: flagsys
	Checksum: 0x39409572
	Offset: 0x238
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function toggle(str_flag)
{
	set_val(str_flag, !get(str_flag));
}

/*
	Name: get
	Namespace: flagsys
	Checksum: 0x3321AD21
	Offset: 0x280
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function get(str_flag)
{
	return isdefined(self.flag) && (isdefined(self.flag[str_flag]) && self.flag[str_flag]);
}

/*
	Name: wait_till
	Namespace: flagsys
	Checksum: 0x85BA0CAB
	Offset: 0x2C8
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
	Namespace: flagsys
	Checksum: 0xC2B42D7A
	Offset: 0x318
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
	Namespace: flagsys
	Checksum: 0xECCB8265
	Offset: 0x3A8
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
	Namespace: flagsys
	Checksum: 0xF0687552
	Offset: 0x438
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
	Namespace: flagsys
	Checksum: 0x171F3F0C
	Offset: 0x4C8
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
	Namespace: flagsys
	Checksum: 0xE38560C0
	Offset: 0x578
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
	Namespace: flagsys
	Checksum: 0xD9B64FCA
	Offset: 0x608
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
	Namespace: flagsys
	Checksum: 0x64CE8B3E
	Offset: 0x658
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
	Namespace: flagsys
	Checksum: 0xCA317C70
	Offset: 0x6E8
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
	Namespace: flagsys
	Checksum: 0x2959F759
	Offset: 0x778
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
	Namespace: flagsys
	Checksum: 0x33B500F7
	Offset: 0x808
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
	Namespace: flagsys
	Checksum: 0x9C55A437
	Offset: 0x8C0
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
	Namespace: flagsys
	Checksum: 0xB58D2165
	Offset: 0x950
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function delete(str_flag)
{
	clear(str_flag);
}

