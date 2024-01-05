// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_trial_no_sprint;

/*
	Name: __init__system__
	Namespace: zm_trial_no_sprint
	Checksum: 0x5C6B5B5A
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_no_sprint", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_no_sprint
	Checksum: 0x76483871
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"no_sprint", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_no_sprint
	Checksum: 0x22315CBD
	Offset: 0x150
	Size: 0xE0
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	callback::on_spawned(&function_dc856fd8);
	foreach(player in getplayers())
	{
		player allowsprint(0);
		player._allow_sprint = 0;
		player thread function_dc856fd8();
		player thread function_31f500f();
	}
}

/*
	Name: on_end
	Namespace: zm_trial_no_sprint
	Checksum: 0xCBA2E833
	Offset: 0x238
	Size: 0xD0
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::remove_on_spawned(&function_dc856fd8);
	foreach(player in getplayers())
	{
		player notify(#"allow_sprint");
		player._allow_sprint = undefined;
		player allowsprint(1);
	}
}

/*
	Name: function_dc856fd8
	Namespace: zm_trial_no_sprint
	Checksum: 0xB45ACB64
	Offset: 0x310
	Size: 0xC0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_dc856fd8()
{
	self notify("374b3a40e7866d07");
	self endon("374b3a40e7866d07");
	self endon(#"disconnect", #"allow_sprint");
	self allowsprint(0);
	while(true)
	{
		self waittill(#"crafting_fail", #"crafting_success", #"bgb_update");
		if(isalive(self))
		{
			self allowsprint(0);
		}
	}
}

/*
	Name: function_31f500f
	Namespace: zm_trial_no_sprint
	Checksum: 0xB52101C0
	Offset: 0x3D8
	Size: 0xA2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_31f500f()
{
	self endon(#"disconnect", #"allow_sprint");
	while(true)
	{
		if(isalive(self) && self sprintbuttonpressed())
		{
			self zm_trial_util::function_97444b02();
			while(self sprintbuttonpressed())
			{
				waitframe(1);
			}
		}
		waitframe(1);
	}
}

