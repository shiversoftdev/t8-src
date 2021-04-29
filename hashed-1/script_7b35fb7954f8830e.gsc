// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace music_box;

/*
	Name: function_89f2df9
	Namespace: music_box
	Checksum: 0x5FE15137
	Offset: 0x190
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"music_box", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: music_box
	Checksum: 0x56AB8783
	Offset: 0x1D8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_136e9d44e7e2e888", 24000, 1, "int", &function_67fa988c, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_77a1a7cd8eb3e86c", 1, 1, "int", &function_9c964ccc, 0, 0);
	clientfield::register("actor", "" + #"hash_4881cb6bc59fdc49", 24000, 1, "int", &function_e722a4fd, 0, 0);
}

/*
	Name: function_3224694
	Namespace: music_box
	Checksum: 0xB66B7FB4
	Offset: 0x2F0
	Size: 0x17E
	Parameters: 7
	Flags: None
*/
function function_3224694(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		if(newval == 1)
		{
			self.fx_handle = playfx(localclientnum, "maps/zm_orange/fx8_samantha_ground_portal", self.origin);
			if(!isdefined(self.var_30b8668))
			{
				self playsound(localclientnum, #"hash_1780eaf4c052b271");
				self.var_30b8668 = self playloopsound(#"hash_13b5daba3191a299");
			}
		}
		else if(newval == 0)
		{
			if(isdefined(self.fx_handle))
			{
				deletefx(localclientnum, self.fx_handle);
				self.fx_handle = undefined;
			}
			if(isdefined(self.var_30b8668))
			{
				self playsound(localclientnum, #"hash_63bbef4e60ff503b");
				self stoploopsound(self.var_30b8668);
				self.var_30b8668 = undefined;
			}
		}
	}
}

/*
	Name: function_7ee98254
	Namespace: music_box
	Checksum: 0x122CBFC5
	Offset: 0x478
	Size: 0x6C
	Parameters: 7
	Flags: None
*/
function function_7ee98254(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		playfx(localclientnum, "maps/zm_orange/fx8_samantha_ground_portal_blast", self.origin);
	}
}

/*
	Name: function_67fa988c
	Namespace: music_box
	Checksum: 0x55884B70
	Offset: 0x4F0
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_67fa988c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		if(newval == 1)
		{
			self.fx_handle = util::playfxontag(localclientnum, "zm_weapons/fx8_music_box_open_world", self, "tag_origin");
		}
		else if(newval == 0)
		{
			if(isdefined(self.fx_handle))
			{
				deletefx(localclientnum, self.fx_handle);
				self.fx_handle = undefined;
			}
		}
	}
}

/*
	Name: function_9c964ccc
	Namespace: music_box
	Checksum: 0x8CA37175
	Offset: 0x5B8
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_9c964ccc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		waitframe(1);
		v_up = vectorscale((1, 0, 0), 360);
		v_forward = vectorscale((0, 0, 1), 360);
		if(isdefined(self))
		{
			playfx(localclientnum, "maps/zm_white/fx8_monkey_bomb_reveal", self.origin, v_forward, v_up);
			self playsound(localclientnum, #"hash_21206f1b7fb27f81");
		}
	}
}

/*
	Name: function_e722a4fd
	Namespace: music_box
	Checksum: 0xE1C370D
	Offset: 0x698
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_e722a4fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self))
	{
		if(newval == 1)
		{
			self.fx_id = util::playfxontag(localclientnum, "zm_weapons/fx8_music_box_zombie_flame_trail", self, "j_spine4");
		}
		else if(newval == 0)
		{
			if(isdefined(self.fx_id))
			{
				deletefx(localclientnum, self.fx_id);
				self.fx_id = undefined;
			}
		}
	}
}

