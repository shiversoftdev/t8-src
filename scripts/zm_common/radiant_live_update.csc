// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace radiant_live_udpate;

/*
	Name: function_89f2df9
	Namespace: radiant_live_udpate
	Checksum: 0x2A01D53B
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	/#
		system::register(#"radiant_live_udpate", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: radiant_live_udpate
	Checksum: 0xE4F88D1
	Offset: 0xC0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		thread scriptstruct_debug_render();
	#/
}

/*
	Name: scriptstruct_debug_render
	Namespace: radiant_live_udpate
	Checksum: 0x2CF1CA0E
	Offset: 0xE8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function scriptstruct_debug_render()
{
	/#
		while(true)
		{
			waitresult = undefined;
			waitresult = level waittill(#"liveupdate");
			if(isdefined(waitresult.selected_struct))
			{
				level thread render_struct(waitresult.selected_struct);
			}
			else
			{
				level notify(#"stop_struct_render");
			}
		}
	#/
}

/*
	Name: render_struct
	Namespace: radiant_live_udpate
	Checksum: 0x30960D02
	Offset: 0x178
	Size: 0x90
	Parameters: 1
	Flags: None
*/
function render_struct(selected_struct)
{
	/#
		self endon(#"stop_struct_render");
		while(isdefined(selected_struct) && isdefined(selected_struct.origin))
		{
			box(selected_struct.origin, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), 0, (1, 0.4, 0.4));
			wait(0.01);
		}
	#/
}

