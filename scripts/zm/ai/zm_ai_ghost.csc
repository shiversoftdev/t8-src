// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace zm_ai_ghost;

/*
	Name: __init__system__
	Namespace: zm_ai_ghost
	Checksum: 0x82E053CB
	Offset: 0x80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_ghost", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_ghost
	Checksum: 0xBF2F079C
	Offset: 0xC8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	ai::add_archetype_spawn_function(#"ghost", &function_e7d2a256);
}

/*
	Name: function_e7d2a256
	Namespace: zm_ai_ghost
	Checksum: 0x7A0585E
	Offset: 0x108
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e7d2a256(localclientnum)
{
	self thread function_20705e4c(localclientnum);
}

/*
	Name: function_20705e4c
	Namespace: zm_ai_ghost
	Checksum: 0x678FB026
	Offset: 0x138
	Size: 0x106
	Parameters: 1
	Flags: Linked, Private
*/
function private function_20705e4c(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"set_invisible", #"set_visible", #"hash_6ab654a4c018818c");
		switch(waitresult._notify)
		{
			case "set_invisible":
			{
				self fxclientutils::function_ae92446(localclientnum, self, self.fxdef);
				break;
			}
			case "set_visible":
			case "hash_6ab654a4c018818c":
			{
				self fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
				break;
			}
		}
	}
}

