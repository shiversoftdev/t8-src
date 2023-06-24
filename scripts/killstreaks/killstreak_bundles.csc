// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4daa124bc391e7ed;
#using scripts\killstreaks\killstreak_detect.csc;
#using scripts\core_common\renderoverridebundle.csc;

#namespace killstreak_bundles;

/*
	Name: spawned
	Namespace: killstreak_bundles
	Checksum: 0xCFEC28F8
	Offset: 0x80
	Size: 0x12C
	Parameters: 2
	Flags: None
*/
function spawned(local_client_num, bundle)
{
	self.var_22a05c26 = bundle;
	if(isdefined(bundle.var_7249d50f) && bundle.var_7249d50f > 0)
	{
		self enablevisioncircle(local_client_num, bundle.var_7249d50f);
	}
	if(bundle.var_101cf227 === 1)
	{
		self enableonradar();
	}
	if(bundle.var_101cf227 === 1)
	{
		self enableonradar();
	}
	if(bundle.var_bea37bdc === 1)
	{
		self namespace_9bcd7d72::function_bdda909b();
	}
	killstreak_detect::function_8ac48939(bundle);
	renderoverridebundle::function_c8d97b8e(local_client_num, #"friendly", #"hash_ebb37dab2ee0ae3");
}

/*
	Name: function_48e9536e
	Namespace: killstreak_bundles
	Checksum: 0x1ECE7746
	Offset: 0x1B8
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function function_48e9536e()
{
	return self.var_22a05c26;
}

