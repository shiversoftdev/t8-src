// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace footsteps;

/*
	Name: missing_ai_footstep_callback
	Namespace: footsteps
	Checksum: 0x3CF6D2CA
	Offset: 0x68
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function missing_ai_footstep_callback()
{
	/#
		type = self.archetype;
		if(!isdefined(type))
		{
			type = "";
		}
		println(((("" + type) + "") + self._aitype) + "");
	#/
}

/*
	Name: registeraitypefootstepcb
	Namespace: footsteps
	Checksum: 0x1CA85FDF
	Offset: 0xD8
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function registeraitypefootstepcb(archetype, callback)
{
	if(!isdefined(level._footstepcbfuncs))
	{
		level._footstepcbfuncs = [];
	}
	/#
		assert(!isdefined(level._footstepcbfuncs[archetype]), ("" + archetype) + "");
	#/
	level._footstepcbfuncs[archetype] = callback;
}

/*
	Name: playaifootstep
	Namespace: footsteps
	Checksum: 0x4D61E290
	Offset: 0x170
	Size: 0xE2
	Parameters: 5
	Flags: Linked
*/
function playaifootstep(client_num, pos, surface, notetrack, bone)
{
	if(!isdefined(self.archetype))
	{
		/#
			println("");
		#/
		footstepdoeverything();
		return;
	}
	if(!isdefined(level._footstepcbfuncs) || !isdefined(level._footstepcbfuncs[self.archetype]))
	{
		self missing_ai_footstep_callback();
		footstepdoeverything();
		return;
	}
	[[level._footstepcbfuncs[self.archetype]]](client_num, pos, surface, notetrack, bone);
}

