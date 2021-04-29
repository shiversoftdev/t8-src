// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace namespace_64be5677;

/*
	Name: main
	Namespace: namespace_64be5677
	Checksum: 0x3DE38D16
	Offset: 0x118
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level thread function_9290b227();
	level thread function_9466dec0();
}

/*
	Name: function_9290b227
	Namespace: namespace_64be5677
	Checksum: 0x4CD73F6C
	Offset: 0x158
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
				println("" + loopers.size + "");
			}
		#/
		for(i = 0; i < loopers.size; i++)
		{
			loopers[i] thread soundloopthink();
			delay = delay + 1;
			if(delay % 20 == 0)
			{
				waitframe(1);
			}
		}
	}
	println("");
}

/*
	Name: soundloopthink
	Namespace: namespace_64be5677
	Checksum: 0xA348C19
	Offset: 0x2C0
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
	Name: function_a6e35dcd
	Namespace: namespace_64be5677
	Checksum: 0xF413FE2
	Offset: 0x458
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_a6e35dcd()
{
	wait(3);
	audio::playloopat("amb_iceberg_cracking_loop", (-863, 5324, 1451));
}

/*
	Name: function_9466dec0
	Namespace: namespace_64be5677
	Checksum: 0x20B9E932
	Offset: 0x498
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function function_9466dec0()
{
	var_7a522422 = struct::get_array("sndWoodRattles", "targetname");
	var_c5cacee = struct::get_array("sndPipeRattles", "targetname");
	var_61bc8796 = struct::get_array("sndWoodStress", "targetname");
	level waittill(#"hash_1fc99aa6e862afbd");
	playsound(0, #"hash_36a95d08ed4998f6", (20, -5248, 1196));
	foreach(rattle in var_7a522422)
	{
		playsound(0, #"hash_565a94625021a254", rattle.origin);
		waitframe(1);
	}
	foreach(rattle in var_c5cacee)
	{
		playsound(0, #"hash_2dbe3a174b1c934c", rattle.origin);
		waitframe(1);
	}
	foreach(rattle in var_61bc8796)
	{
		playsound(0, #"hash_3d14ed72726a475a", rattle.origin);
		waitframe(1);
	}
}

