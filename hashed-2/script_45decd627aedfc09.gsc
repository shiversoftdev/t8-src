// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace ai_state;

/*
	Name: function_e9b061a8
	Namespace: ai_state
	Checksum: 0x4E4A54C7
	Offset: 0x68
	Size: 0xD6
	Parameters: 8
	Flags: None
*/
function function_e9b061a8(state, start, var_2ae5a795, end, var_5d31deb6, var_edc20efd, var_ff716a93, var_a1891b01)
{
	level.extra_screen_electricity_.functions[state] = {#hash_a1891b01:var_a1891b01, #hash_ff716a93:var_ff716a93, #hash_edc20efd:var_edc20efd, #hash_5d31deb6:var_5d31deb6, #end:end, #hash_2ae5a795:var_2ae5a795, #start:start};
}

/*
	Name: function_7c534b09
	Namespace: ai_state
	Checksum: 0xD21C5E2
	Offset: 0x148
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_7c534b09()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].start))
	{
		self thread [[level.extra_screen_electricity_.functions[self.ai.state].start]]();
	}
}

/*
	Name: function_4e845c24
	Namespace: ai_state
	Checksum: 0x7C71AC12
	Offset: 0x1C8
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_4e845c24()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].end))
	{
		self thread [[level.extra_screen_electricity_.functions[self.ai.state].end]]();
	}
}

/*
	Name: function_e8e7cf45
	Namespace: ai_state
	Checksum: 0x640E2FBE
	Offset: 0x248
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_e8e7cf45()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_2ae5a795))
	{
		self [[level.extra_screen_electricity_.functions[self.ai.state].var_2ae5a795]]();
	}
}

/*
	Name: function_e0e1a7fc
	Namespace: ai_state
	Checksum: 0xB6BA6199
	Offset: 0x2C8
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_e0e1a7fc()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_5d31deb6))
	{
		self [[level.extra_screen_electricity_.functions[self.ai.state].var_5d31deb6]]();
	}
}

/*
	Name: function_4af1ff64
	Namespace: ai_state
	Checksum: 0xDC992AC6
	Offset: 0x348
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function function_4af1ff64()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd))
	{
		return self [[level.extra_screen_electricity_.functions[self.ai.state].var_edc20efd]]();
	}
	return 0;
}

/*
	Name: function_a78474f2
	Namespace: ai_state
	Checksum: 0x7A3C12D2
	Offset: 0x3D0
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function function_a78474f2()
{
	if(isdefined(self.ai.state) && isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_ff716a93))
	{
		return self [[level.extra_screen_electricity_.functions[self.ai.state].var_ff716a93]]();
	}
	return undefined;
}

/*
	Name: set_state
	Namespace: ai_state
	Checksum: 0xF46FE181
	Offset: 0x458
	Size: 0xE4
	Parameters: 1
	Flags: None
*/
function set_state(state)
{
	if(!isdefined(self.ai))
	{
		self.ai = {#state:undefined};
	}
	if(!isdefined(self.ai.state) || self.ai.state != state)
	{
		if(isdefined(self.ai.state))
		{
			function_4e845c24();
		}
		self.ai.state = state;
		function_7c534b09();
		self notify(#"state_changed", state);
		/#
			self thread function_3a57bb58();
		#/
	}
}

/*
	Name: is_state
	Namespace: ai_state
	Checksum: 0x30877981
	Offset: 0x548
	Size: 0x20
	Parameters: 1
	Flags: None
*/
function is_state(state)
{
	return self.ai.state == state;
}

/*
	Name: function_c1d2ede8
	Namespace: ai_state
	Checksum: 0x2E0CB2F
	Offset: 0x570
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_c1d2ede8()
{
	/#
		if(isdefined(level.extra_screen_electricity_.functions[self.ai.state].var_a1891b01))
		{
			self [[level.extra_screen_electricity_.functions[self.ai.state].var_a1891b01]]();
		}
	#/
}

/*
	Name: function_3a57bb58
	Namespace: ai_state
	Checksum: 0x2CA2E3BA
	Offset: 0x5E0
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_3a57bb58()
{
	/#
		self notify("");
		self endon("");
		self endon(#"death");
		while(true)
		{
			self function_c1d2ede8();
			waitframe(1);
		}
	#/
}

