// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace flagsys;

/*
	Name: function_89f2df9
	Namespace: flagsys
	Checksum: 0x256D21C
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"flagsys", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: flagsys
	Checksum: 0xED35AEC
	Offset: 0xE8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread update_flag_dvars();
}

/*
	Name: update_flag_dvars
	Namespace: flagsys
	Checksum: 0xA9FC5D8D
	Offset: 0x110
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function update_flag_dvars()
{
	while(true)
	{
		if(isdefined(level.flag_dvars))
		{
			foreach(str_dvar in level.flag_dvars)
			{
				set_val(str_dvar, getdvarint(str_dvar, 0));
			}
		}
		wait(randomfloatrange(0.6666666, 1.333333));
	}
}

/*
	Name: init_dvar
	Namespace: flagsys
	Checksum: 0xD280BAE
	Offset: 0x1E8
	Size: 0xB2
	Parameters: 1
	Flags: None
*/
function init_dvar(str_dvar)
{
	if(!isdefined(level.flag_dvars))
	{
		level.flag_dvars = [];
	}
	else if(!isarray(level.flag_dvars))
	{
		level.flag_dvars = array(level.flag_dvars);
	}
	if(!isinarray(level.flag_dvars, str_dvar))
	{
		level.flag_dvars[level.flag_dvars.size] = str_dvar;
	}
}

/*
	Name: set
	Namespace: flagsys
	Checksum: 0x7B83D3B6
	Offset: 0x2A8
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
	Name: increment
	Namespace: flagsys
	Checksum: 0xF0887D4C
	Offset: 0x2F0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function increment(str_flag)
{
	if(!isdefined(self.flag_count))
	{
		self.flag_count = [];
	}
	if(!isdefined(self.flag_count[str_flag]))
	{
		self.flag_count[str_flag] = 0;
	}
	self.flag_count[str_flag]++;
	set(str_flag);
}

/*
	Name: decrement
	Namespace: flagsys
	Checksum: 0x3A1D7796
	Offset: 0x368
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function decrement(str_flag)
{
	/#
		assert(isdefined(self.flag_count) && isdefined(self.flag_count[str_flag]) && self.flag_count[str_flag] > 0, "");
	#/
	self.flag_count[str_flag]--;
	if(self.flag_count[str_flag] == 0)
	{
		clear(str_flag);
	}
}

/*
	Name: set_for_time
	Namespace: flagsys
	Checksum: 0x33E273C4
	Offset: 0x410
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
	Checksum: 0x4411C3B1
	Offset: 0x480
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
	Checksum: 0x332772C8
	Offset: 0x4F0
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
	Checksum: 0xB8ED2ADB
	Offset: 0x568
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
	Checksum: 0x13A93454
	Offset: 0x5B0
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
	Checksum: 0xA4D87F59
	Offset: 0x5F8
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
	Checksum: 0x31F7E990
	Offset: 0x648
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
	Checksum: 0x61355A1D
	Offset: 0x6D8
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
	Checksum: 0xB0B96F4D
	Offset: 0x768
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
	Checksum: 0x2A78F8E5
	Offset: 0x7F8
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
	Checksum: 0x1CCA9027
	Offset: 0x8A8
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
	Checksum: 0x3F4725FB
	Offset: 0x938
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
	Checksum: 0xB94262E2
	Offset: 0x988
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
	Checksum: 0x2B79DCFF
	Offset: 0xA18
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
	Checksum: 0x78EFA4AD
	Offset: 0xAA8
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
	Checksum: 0xDE17A66D
	Offset: 0xB38
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
	Checksum: 0xA506F601
	Offset: 0xBF0
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
	Checksum: 0x98BE8961
	Offset: 0xC80
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function delete(str_flag)
{
	clear(str_flag);
}

/*
	Name: script_flag_wait
	Namespace: flagsys
	Checksum: 0x95C40981
	Offset: 0xCB0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function script_flag_wait()
{
	if(isdefined(self.script_flag_wait))
	{
		self wait_till(self.script_flag_wait);
		return true;
	}
	return false;
}

