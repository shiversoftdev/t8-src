// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace trigger;

/*
	Name: function_521edc64
	Namespace: trigger
	Checksum: 0x46EBE4FD
	Offset: 0x78
	Size: 0x11C
	Parameters: 3
	Flags: Linked
*/
function function_521edc64(ent, on_enter_payload, on_exit_payload)
{
	ent endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_f911c758 = self getentitynumber();
	if(ent ent_already_in(var_f911c758))
	{
		return;
	}
	add_to_ent(ent, var_f911c758);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && isdefined(self) && ent istouching(self))
	{
		waitframe(1);
	}
	if(isdefined(ent))
	{
		if(isdefined(on_exit_payload))
		{
			[[on_exit_payload]](ent);
		}
		remove_from_ent(ent, var_f911c758);
	}
}

/*
	Name: ent_already_in
	Namespace: trigger
	Checksum: 0x95B2CF1
	Offset: 0x1A0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function ent_already_in(var_d35ff8d8)
{
	if(!isdefined(self._triggers))
	{
		return false;
	}
	if(!isdefined(self._triggers[var_d35ff8d8]))
	{
		return false;
	}
	if(!self._triggers[var_d35ff8d8])
	{
		return false;
	}
	return true;
}

/*
	Name: add_to_ent
	Namespace: trigger
	Checksum: 0x6AE6433D
	Offset: 0x1F8
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function add_to_ent(ent, var_d35ff8d8)
{
	if(!isdefined(ent._triggers))
	{
		ent._triggers = [];
	}
	ent._triggers[var_d35ff8d8] = 1;
}

/*
	Name: remove_from_ent
	Namespace: trigger
	Checksum: 0xF34B89C6
	Offset: 0x250
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function remove_from_ent(ent, var_d35ff8d8)
{
	if(!isdefined(ent._triggers))
	{
		return;
	}
	if(!isdefined(ent._triggers[var_d35ff8d8]))
	{
		return;
	}
	ent._triggers[var_d35ff8d8] = 0;
}

/*
	Name: death_monitor
	Namespace: trigger
	Checksum: 0x3629D895
	Offset: 0x2B0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function death_monitor(ent, ender)
{
	ent waittill(#"death");
	self endon(ender);
	self remove_from_ent(ent);
}

/*
	Name: trigger_wait
	Namespace: trigger
	Checksum: 0x5FA06046
	Offset: 0x308
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function trigger_wait(n_clientnum)
{
	self endon(#"trigger");
	if(isdefined(self.targetname))
	{
		trig = getent(n_clientnum, self.targetname, "target");
		if(isdefined(trig))
		{
			trig waittill(#"trigger");
		}
	}
}

