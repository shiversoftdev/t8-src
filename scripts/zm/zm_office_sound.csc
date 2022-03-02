// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace namespace_fada3c80;

/*
	Name: main
	Namespace: namespace_fada3c80
	Checksum: 0x3A83571C
	Offset: 0xC0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level thread function_9290b227();
	level thread function_6e0048f1();
}

/*
	Name: function_9290b227
	Namespace: namespace_fada3c80
	Checksum: 0xDA192BD2
	Offset: 0x100
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_9290b227()
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
	Namespace: namespace_fada3c80
	Checksum: 0x5DFE1345
	Offset: 0x268
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

/*
	Name: function_6e0048f1
	Namespace: namespace_fada3c80
	Checksum: 0xE1BE1901
	Offset: 0x400
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_6e0048f1()
{
	wait(0.1);
	level waittill(#"poa");
	audio::playloopat(#"hash_441952a4718e4f31", (-720, 3949, -608));
	audio::playloopat(#"hash_441952a4718e4f31", (-729, 5238, -608));
	audio::playloopat(#"hash_441952a4718e4f31", (-1616, 5252, -562));
	audio::playloopat(#"hash_441952a4718e4f31", (-1602, 3860, -608));
}

