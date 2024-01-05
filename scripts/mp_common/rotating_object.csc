// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\array_shared.csc;

#namespace rotating_object;

/*
	Name: __init__system__
	Namespace: rotating_object
	Checksum: 0x4FF8BCB0
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"rotating_object", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: rotating_object
	Checksum: 0x647E233B
	Offset: 0xF8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_localclient_connect(&init);
}

/*
	Name: init
	Namespace: rotating_object
	Checksum: 0xD1B7A9
	Offset: 0x128
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function init(localclientnum)
{
	rotating_objects = getentarray(localclientnum, "rotating_object", "targetname");
	array::thread_all(rotating_objects, &rotating_object_think);
}

/*
	Name: rotating_object_think
	Namespace: rotating_object
	Checksum: 0x98A39874
	Offset: 0x190
	Size: 0x212
	Parameters: 0
	Flags: Linked
*/
function rotating_object_think()
{
	self endon(#"death");
	util::waitforallclients();
	util::function_89a98f85();
	axis = "yaw";
	direction = 360;
	revolutions = 100;
	rotate_time = 12;
	if(isdefined(self.script_noteworthy))
	{
		axis = self.script_noteworthy;
	}
	if(isdefined(self.script_float))
	{
		rotate_time = self.script_float;
	}
	if(rotate_time == 0)
	{
		rotate_time = 12;
	}
	if(rotate_time < 0)
	{
		direction = direction * -1;
		rotate_time = rotate_time * -1;
	}
	if(isdefined(self.angles))
	{
		angles = self.angles;
	}
	else
	{
		angles = (0, 0, 0);
	}
	while(true)
	{
		switch(axis)
		{
			case "roll":
			{
				self rotateroll(direction * revolutions, rotate_time * revolutions);
				break;
			}
			case "pitch":
			{
				self rotatepitch(direction * revolutions, rotate_time * revolutions);
				break;
			}
			case "yaw":
			default:
			{
				self rotateyaw(direction * revolutions, rotate_time * revolutions);
				break;
			}
		}
		self waittill(#"rotatedone");
		self.angles = angles;
	}
}

