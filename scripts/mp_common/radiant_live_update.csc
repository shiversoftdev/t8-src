// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;

#namespace radiant_live_update;

/*
	Name: __init__system__
	Namespace: radiant_live_update
	Checksum: 0xBF11FA24
	Offset: 0x70
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	/#
		system::register(#"radiant_live_update", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: radiant_live_update
	Checksum: 0x15CE09B
	Offset: 0xB8
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
	Namespace: radiant_live_update
	Checksum: 0x620B9086
	Offset: 0xE0
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
	Namespace: radiant_live_update
	Checksum: 0x142567DF
	Offset: 0x170
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function render_struct(selected_struct)
{
	/#
		self endon(#"stop_struct_render");
		if(!isdefined(selected_struct.origin))
		{
			return;
		}
		while(isdefined(selected_struct))
		{
			box(selected_struct.origin, vectorscale((-1, -1, -1), 16), vectorscale((1, 1, 1), 16), 0, (1, 0.4, 0.4));
			waitframe(1);
		}
	#/
}

