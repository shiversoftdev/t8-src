// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_crawl_space;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_crawl_space
	Checksum: 0x86B89F07
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_crawl_space", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_crawl_space
	Checksum: 0xD7D0FA96
	Offset: 0xE0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_crawl_space", "activated", 1, undefined, undefined, undefined, &activation);
}

/*
	Name: activation
	Namespace: zm_bgb_crawl_space
	Checksum: 0xBB617B33
	Offset: 0x150
	Size: 0x116
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	a_ai = getaiarray();
	for(i = 0; i < a_ai.size; i++)
	{
		if(isdefined(a_ai[i]) && isalive(a_ai[i]) && a_ai[i].archetype === #"zombie" && isdefined(a_ai[i].gibdef))
		{
			var_aa4b65bc = distancesquared(self.origin, a_ai[i].origin);
			if(var_aa4b65bc < 360000)
			{
				a_ai[i] zombie_utility::makezombiecrawler();
			}
		}
	}
}

