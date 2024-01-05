// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_mansion_sound;

/*
	Name: main
	Namespace: zm_mansion_sound
	Checksum: 0x9A54727D
	Offset: 0xC0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function main()
{
	thread startzmbspawnersoundloops();
}

/*
	Name: startzmbspawnersoundloops
	Namespace: zm_mansion_sound
	Checksum: 0x973614A4
	Offset: 0xE0
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function startzmbspawnersoundloops()
{
	loopers = struct::get_array("spawn_location", "script_noteworthy");
	if(isdefined(loopers) && loopers.size > 0)
	{
		delay = 0;
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println(("" + loopers.size) + "");
			}
		#/
		for(i = 0; i < loopers.size; i++)
		{
			loopers[i] thread soundloopthink();
			delay = delay + 1;
			if((delay % 20) == 0)
			{
				waitframe(1);
			}
		}
	}
	else
	{
		/#
			println("");
		#/
		if(getdvarint(#"debug_audio", 0) > 0)
		{
		}
	}
}

/*
	Name: soundloopthink
	Namespace: zm_mansion_sound
	Checksum: 0x2BD61AD5
	Offset: 0x248
	Size: 0x18A
	Parameters: 0
	Flags: Linked
*/
function soundloopthink()
{
	if(!isdefined(self.origin))
	{
		return;
	}
	if(!isdefined(self.script_sound))
	{
		self.script_sound = "zmb_spawn_walla";
	}
	notifyname = "";
	/#
		assert(isdefined(notifyname));
	#/
	if(isdefined(self.script_string))
	{
		notifyname = self.script_string;
	}
	/#
		assert(isdefined(notifyname));
	#/
	started = 1;
	if(isdefined(self.script_int))
	{
		started = self.script_int != 0;
	}
	if(started)
	{
		soundloopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
	}
	if(notifyname != "")
	{
		for(;;)
		{
			level waittill(notifyname);
			if(started)
			{
				soundstoploopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
			}
			else
			{
				soundloopemitter(self.script_sound, self.origin + vectorscale((0, 0, 1), 60));
			}
			started = !started;
		}
	}
}

