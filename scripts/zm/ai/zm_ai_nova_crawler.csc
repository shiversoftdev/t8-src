// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_ai_nova_crawler;

/*
	Name: __init__system__
	Namespace: zm_ai_nova_crawler
	Checksum: 0xAD7805E7
	Offset: 0x158
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_nova_crawler", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_nova_crawler
	Checksum: 0x76255E0A
	Offset: 0x1A0
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "nova_crawler_burst_clientfield", 1, 1, "int", &function_d8505ab6, 0, 0);
	clientfield::register("toplayer", "nova_crawler_burst_postfx_clientfield", 1, 1, "int", &function_c81db9a1, 0, 0);
	clientfield::register("toplayer", "nova_crawler_gas_cloud_postfx_clientfield", 1, 1, "int", &function_f8947dfe, 0, 0);
	ai::add_archetype_spawn_function(#"nova_crawler", &function_1d34f2b6);
}

/*
	Name: function_1d34f2b6
	Namespace: zm_ai_nova_crawler
	Checksum: 0xE72A07F2
	Offset: 0x2B8
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1d34f2b6(localclientnum)
{
	if(!isdefined(self._effect))
	{
		self._effect = [];
		self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_gas_release";
	}
}

/*
	Name: function_d8505ab6
	Namespace: zm_ai_nova_crawler
	Checksum: 0x8AF857D6
	Offset: 0x308
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_d8505ab6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1 && isdefined(self._effect) && isdefined(self._effect[#"hash_219e13e8868d7af4"]))
	{
		playfx(localclientnum, self._effect[#"hash_219e13e8868d7af4"], self.origin);
	}
}

/*
	Name: function_c81db9a1
	Namespace: zm_ai_nova_crawler
	Checksum: 0x2FD795FD
	Offset: 0x3C8
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_c81db9a1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread postfx::playpostfxbundle(#"hash_2083fc2cc0fee308");
	}
	else
	{
		self postfx::exitpostfxbundle(#"hash_2083fc2cc0fee308");
	}
}

/*
	Name: function_f8947dfe
	Namespace: zm_ai_nova_crawler
	Checksum: 0x8DF106F3
	Offset: 0x468
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_f8947dfe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread function_4b3c6d28();
	}
	else
	{
		self postfx::exitpostfxbundle(#"hash_78fa24e9920e1e07");
	}
}

/*
	Name: function_4b3c6d28
	Namespace: zm_ai_nova_crawler
	Checksum: 0x5F306C6E
	Offset: 0x4F8
	Size: 0xA0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4b3c6d28()
{
	self notify("4d967cb582990a00");
	self endon("4d967cb582990a00");
	level endon(#"game_ended");
	self endoncallback(&function_fa939efb, #"death");
	self thread postfx::playpostfxbundle(#"hash_78fa24e9920e1e07");
	while(isalive(self))
	{
		waitframe(1);
	}
}

/*
	Name: function_fa939efb
	Namespace: zm_ai_nova_crawler
	Checksum: 0xC89F7DEE
	Offset: 0x5A0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_fa939efb(str_notify)
{
	if(isdefined(self))
	{
		self thread postfx::exitpostfxbundle(#"hash_78fa24e9920e1e07");
	}
}

