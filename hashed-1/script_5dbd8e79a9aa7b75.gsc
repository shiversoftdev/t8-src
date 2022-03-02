// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f04092ce1e7b07d;
#using script_522aeb6ae906391e;
#using script_59f07c660e6710a5;
#using scripts\core_common\spawner_shared.gsc;

#namespace namespace_1db7ec0e;

/*
	Name: init
	Namespace: namespace_1db7ec0e
	Checksum: 0x31908C24
	Offset: 0x88
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init()
{
	namespace_70571b3::registernovacrawlerinterfaceattributes();
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"nova_crawler", &function_ea4610a7);
}

/*
	Name: function_32107b12
	Namespace: namespace_1db7ec0e
	Checksum: 0xEDAB19B3
	Offset: 0xE8
	Size: 0x24
	Parameters: 0
	Flags: Private
*/
function private function_32107b12()
{
	/#
		assert(isdefined(self.ai));
	#/
}

/*
	Name: function_ea4610a7
	Namespace: namespace_1db7ec0e
	Checksum: 0x28B8C8EC
	Offset: 0x118
	Size: 0x62
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ea4610a7()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_80f18700;
	self.___archetypeonbehavecallback = &function_b11c2bcd;
}

/*
	Name: function_b11c2bcd
	Namespace: namespace_1db7ec0e
	Checksum: 0xC0325B70
	Offset: 0x188
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b11c2bcd(entity)
{
}

/*
	Name: function_80f18700
	Namespace: namespace_1db7ec0e
	Checksum: 0x559853C3
	Offset: 0x1A0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_80f18700(entity)
{
	self.__blackboard = undefined;
	self function_ea4610a7();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_1db7ec0e
	Checksum: 0x80F724D1
	Offset: 0x1D8
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
}

/*
	Name: function_3d50e4d0
	Namespace: namespace_1db7ec0e
	Checksum: 0xDB541C6A
	Offset: 0x1E8
	Size: 0x54
	Parameters: 1
	Flags: Private
*/
function private function_3d50e4d0(message)
{
	/#
		if(getdvarint(#"hash_35bebcc5f50d2641", 0))
		{
			println("" + message);
		}
	#/
}

