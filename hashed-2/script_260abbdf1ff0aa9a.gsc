// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_transform;

/*
	Name: function_89f2df9
	Namespace: zm_transform
	Checksum: 0xF5131257
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_transform", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_transform
	Checksum: 0xDC142A64
	Offset: 0x118
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "transformation_spawn", 1, 1, "int", &function_201c2cb7, 0, 0);
	clientfield::register("actor", "transformation_stream_split", 1, 1, "int", &function_341e5a97, 0, 0);
}

/*
	Name: function_201c2cb7
	Namespace: zm_transform
	Checksum: 0x7043FD0A
	Offset: 0x1B8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_201c2cb7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_bf9d3071((isdefined(self.var_fab3cf78) ? self.var_fab3cf78 : #"hash_435832b390f73dff"));
}

/*
	Name: function_341e5a97
	Namespace: zm_transform
	Checksum: 0x225D298C
	Offset: 0x238
	Size: 0x156
	Parameters: 7
	Flags: Linked
*/
function function_341e5a97(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		var_51d5c26f = self ai::function_9139c839();
		if(isdefined(var_51d5c26f) && isdefined(var_51d5c26f.var_d354164e))
		{
			foreach(var_127d3a7a in var_51d5c26f.var_d354164e)
			{
				if(self.model === var_127d3a7a.var_a3c9023c)
				{
					util::lock_model(var_127d3a7a.var_cdf1f53d);
					self thread function_8a817bd6(var_127d3a7a.var_cdf1f53d);
					break;
				}
			}
		}
	}
	else
	{
		self notify(#"unlock_model");
	}
}

/*
	Name: function_8a817bd6
	Namespace: zm_transform
	Checksum: 0xC5C64C4C
	Offset: 0x398
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_8a817bd6(model)
{
	self waittill_timeout(60, #"death", #"unlock_model");
	util::unlock_model(model);
}

