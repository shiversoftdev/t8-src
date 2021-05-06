// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace tracking;

/*
	Name: function_605bb988
	Namespace: tracking
	Checksum: 0x43C96A07
	Offset: 0x68
	Size: 0x26
	Parameters: 0
	Flags: Private
*/
private function function_605bb988()
{
	if(!isalive(self))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8240e8b4
	Namespace: tracking
	Checksum: 0xDB568DBC
	Offset: 0x98
	Size: 0xDE
	Parameters: 0
	Flags: Private
*/
private function function_8240e8b4()
{
	if(function_605bb988())
	{
		if(level.time >= self.tracking.breadcrumbs[self.tracking.current_crumb].time + self.tracking.time_step)
		{
			return;
		}
		self.tracking.current_crumb = self.tracking.current_crumb + 1 % 20;
		self.tracking.breadcrumbs[self.tracking.current_crumb] = {#time:level.time, #point:self.origin};
	}
}

/*
	Name: function_b8d4946e
	Namespace: tracking
	Checksum: 0x45119AA8
	Offset: 0x180
	Size: 0x192
	Parameters: 1
	Flags: None
*/
function function_b8d4946e(window)
{
	self.tracking = {#time_step:int(window * 1000) / 20, #window:window, #speed:0, #velocity:(0, 0, 0), #hash_712fc53e:0, #current_crumb:0, #breadcrumbs:[]};
	crumb = {#time:level.time, #point:self.origin};
	if(!isdefined(self.tracking.breadcrumbs))
	{
		self.tracking.breadcrumbs = [];
	}
	else if(!isarray(self.tracking.breadcrumbs))
	{
		self.tracking.breadcrumbs = array(self.tracking.breadcrumbs);
	}
	self.tracking.breadcrumbs[self.tracking.breadcrumbs.size] = crumb;
}

/*
	Name: function_c9f765ff
	Namespace: tracking
	Checksum: 0x61CAE7C9
	Offset: 0x320
	Size: 0x3E
	Parameters: 0
	Flags: Private
*/
private function function_c9f765ff()
{
	self endon(#"disconnect");
	while(true)
	{
		self function_8240e8b4();
		waitframe(1);
	}
}

/*
	Name: track
	Namespace: tracking
	Checksum: 0xD84C5C22
	Offset: 0x368
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function track(window)
{
	if(isdefined(self.tracking))
	{
		return;
	}
	self function_b8d4946e(window);
	self thread function_c9f765ff();
}

/*
	Name: get_velocity
	Namespace: tracking
	Checksum: 0xFD774A12
	Offset: 0x3C0
	Size: 0x236
	Parameters: 0
	Flags: None
*/
function get_velocity()
{
	if(level.time == self.tracking.var_712fc53e)
	{
		return self.tracking.velocity;
	}
	crumb_index = self.tracking.current_crumb % 20;
	crumb = self.tracking.breadcrumbs[crumb_index];
	last_point = crumb.point;
	last_time = crumb.time;
	travel = (0, 0, 0);
	total_time = 0;
	breadcrumb_count = self.tracking.breadcrumbs.size;
	for(index = breadcrumb_count - 2; index >= 0; index--)
	{
		crumb_index--;
		if(crumb_index < 0)
		{
			crumb_index = crumb_index + breadcrumb_count;
		}
		crumb = self.tracking.breadcrumbs[crumb_index];
		travel = travel + last_point - crumb.point;
		total_time = total_time + last_time - crumb.time;
		last_point = crumb.point;
		last_time = crumb.time;
	}
	if(total_time > 0)
	{
		self.tracking.velocity = travel / float(total_time) / 1000;
		self.tracking.speed = length(travel) / float(total_time) / 1000;
	}
	self.tracking.var_712fc53e = level.time;
	return self.tracking.velocity;
}

/*
	Name: function_ef4b25ba
	Namespace: tracking
	Checksum: 0x578D03C3
	Offset: 0x600
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_ef4b25ba()
{
	/#
		self endon(#"disconnect");
		while(true)
		{
			if(function_605bb988())
			{
				velocity = self get_velocity();
				sphere(self.origin + velocity, 10, (1, 0, 0), 1, 0);
			}
			waitframe(1);
		}
	#/
}

