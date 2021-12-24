// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace delete;

/*
	Name: main
	Namespace: delete
	Checksum: 0xF2A653AC
	Offset: 0x68
	Size: 0x10C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	/#
		assert(isdefined(self));
	#/
	waitframe(1);
	if(isdefined(self))
	{
		/#
			if(isdefined(self.classname))
			{
				if(self.classname == "" || self.classname == "" || self.classname == "")
				{
					println("");
					println((("" + self getentitynumber()) + "") + self.origin);
					println("");
				}
			}
		#/
		self delete();
	}
}

