// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\array_shared.csc;

#namespace namespace_9ff9f642;

/*
	Name: __init__system__
	Namespace: namespace_9ff9f642
	Checksum: 0xF924FC1E
	Offset: 0x120
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_308dff40d53a7287", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_9ff9f642
	Checksum: 0x3F70200A
	Offset: 0x168
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "" + #"hash_419c1c8da4dc53a9", 1, 1, "int", &function_f4515ba8, 0, 0);
}

/*
	Name: function_f4515ba8
	Namespace: namespace_9ff9f642
	Checksum: 0x55F4B52
	Offset: 0x1D0
	Size: 0x1EA
	Parameters: 7
	Flags: Linked
*/
function function_f4515ba8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		str_tag = "j_spinelower";
		if(!isdefined(self gettagorigin(str_tag)))
		{
			str_tag = "tag_origin";
		}
		if(isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"]))
		{
			self.var_62f2a054 = util::playfxontag(localclientnum, level._effect[#"character_fire_death_torso"], self, str_tag);
		}
		self thread function_8847b8aa(localclientnum);
		self.var_2be01485 = undefined;
	}
	else
	{
		self notify(#"hash_395dfda1274cd506");
		if(isdefined(self.var_62f2a054))
		{
			stopfx(localclientnum, self.var_62f2a054);
			self.var_62f2a054 = undefined;
		}
		if(isdefined(self.var_803e161e))
		{
			foreach(n_fx_id in self.var_803e161e)
			{
				stopfx(localclientnum, n_fx_id);
			}
			self.var_803e161e = undefined;
		}
	}
}

/*
	Name: function_8847b8aa
	Namespace: namespace_9ff9f642
	Checksum: 0x8C75EECD
	Offset: 0x3C8
	Size: 0x20A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8847b8aa(localclientnum)
{
	self endon(#"death", #"hash_395dfda1274cd506");
	wait(1);
	a_str_tags = [];
	a_str_tags[0] = "j_elbow_le";
	a_str_tags[1] = "j_elbow_ri";
	a_str_tags[2] = "j_knee_ri";
	a_str_tags[3] = "j_knee_le";
	a_str_tags = array::randomize(a_str_tags);
	self.var_803e161e = [];
	self.var_803e161e[0] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
	wait(1);
	a_str_tags[0] = "j_wrist_ri";
	a_str_tags[1] = "j_wrist_le";
	if(!(isdefined(self.missinglegs) && self.missinglegs))
	{
		a_str_tags[2] = "j_ankle_ri";
		a_str_tags[3] = "j_ankle_le";
	}
	a_str_tags = array::randomize(a_str_tags);
	self.var_803e161e[1] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[0]);
	self.var_803e161e[2] = util::playfxontag(localclientnum, level._effect[#"character_fire_death_sm"], self, a_str_tags[1]);
}

