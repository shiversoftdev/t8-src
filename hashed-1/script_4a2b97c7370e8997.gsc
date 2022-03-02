// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14e569dd391faf67;
#using script_56a07ed451084ca5;
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_aa2f0fe;

/*
	Name: function_89f2df9
	Namespace: namespace_aa2f0fe
	Checksum: 0x51CE9365
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
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
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_13a41fe1a6435995", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_aa2f0fe
	Checksum: 0x9F80C16C
	Offset: 0x160
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1de6a85()
{
	self function_3b7e62cf();
	self function_28dce407();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_aa2f0fe
	Checksum: 0xB6E1960D
	Offset: 0x1A0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
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
	self namespace_ccdea9b1::disable_callboxes();
	self namespace_ccdea9b1::disable_elevator_buys();
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
	namespace_a701220b::function_a6bb56f6();
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
	elevator1 namespace_ccdea9b1::enable_callboxes();
	elevator1 namespace_ccdea9b1::enable_elevator_buys();
	elevator2 namespace_ccdea9b1::enable_callboxes();
	elevator2 namespace_ccdea9b1::enable_elevator_buys();
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
	namespace_a701220b::function_cc9b97b0();
}

