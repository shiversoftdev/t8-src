// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_office_teleporters.gsc;
#using scripts\zm\zm_office_elevators.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_aa2f0fe;

/*
	Name: __init__system__
	Namespace: namespace_aa2f0fe
	Checksum: 0x51CE9365
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_2fe76bf0f69f1761", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_aa2f0fe
	Checksum: 0xF32E3D41
	Offset: 0xF8
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
	zm_trial::register_challenge(#"disable_teleporters_elevators", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_aa2f0fe
	Checksum: 0x9F80C16C
	Offset: 0x160
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	self function_3b7e62cf();
	self function_28dce407();
}

/*
	Name: on_end
	Namespace: namespace_aa2f0fe
	Checksum: 0xB6E1960D
	Offset: 0x1A0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	self function_72c09628();
	self function_8209b7a5();
}

/*
	Name: function_3b7e62cf
	Namespace: namespace_aa2f0fe
	Checksum: 0x762FC8D4
	Offset: 0x1E8
	Size: 0x84
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3b7e62cf()
{
	elevator1 = getent("elevator1", "targetname");
	elevator2 = getent("elevator2", "targetname");
	elevator1 thread function_98c1b6be();
	elevator2 thread function_98c1b6be();
}

/*
	Name: function_98c1b6be
	Namespace: namespace_aa2f0fe
	Checksum: 0xF513335D
	Offset: 0x278
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
function private function_98c1b6be()
{
	if(self.active === 1)
	{
		self waittill(#"hash_26d932820f7f5373");
	}
	self zm_office_elevators::disable_callboxes();
	self zm_office_elevators::disable_elevator_buys();
}

/*
	Name: function_28dce407
	Namespace: namespace_aa2f0fe
	Checksum: 0x4E8CF223
	Offset: 0x2D8
	Size: 0x14
	Parameters: 0
	Flags: Linked, Private
*/
function private function_28dce407()
{
	zm_office_teleporters::function_a6bb56f6();
}

/*
	Name: function_72c09628
	Namespace: namespace_aa2f0fe
	Checksum: 0x58AA33F6
	Offset: 0x2F8
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_72c09628()
{
	elevator1 = getent("elevator1", "targetname");
	elevator2 = getent("elevator2", "targetname");
	elevator1 zm_office_elevators::enable_callboxes();
	elevator1 zm_office_elevators::enable_elevator_buys();
	elevator2 zm_office_elevators::enable_callboxes();
	elevator2 zm_office_elevators::enable_elevator_buys();
}

/*
	Name: function_8209b7a5
	Namespace: namespace_aa2f0fe
	Checksum: 0x4DDDF11F
	Offset: 0x3B8
	Size: 0x14
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8209b7a5()
{
	zm_office_teleporters::function_cc9b97b0();
}

