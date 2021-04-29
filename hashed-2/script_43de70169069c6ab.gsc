// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_9d58c1cd;

/*
	Name: init
	Namespace: namespace_9d58c1cd
	Checksum: 0x80F724D1
	Offset: 0x230
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_9d58c1cd
	Checksum: 0xB53ED20D
	Offset: 0x240
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "sp_ar_pi", 1, 1, "int", &function_69a31ba8, 0, 0);
	clientfield::register("scriptmover", "elevator_rumble", 1, 1, "counter", &function_e9808c9d, 0, 0);
	clientfield::register("world", "p_w_o_num_01", 1, getminbitcountfornum(10), "int", &function_d38f33fb, 0, 0);
	clientfield::register("world", "p_w_o_num_02", 1, getminbitcountfornum(10), "int", &function_c5199710, 0, 0);
	clientfield::register("world", "p_w_o_num_03", 1, getminbitcountfornum(10), "int", &function_68a0de20, 0, 0);
}

/*
	Name: main
	Namespace: namespace_9d58c1cd
	Checksum: 0x80F724D1
	Offset: 0x3E8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function main()
{
}

/*
	Name: function_d38f33fb
	Namespace: namespace_9d58c1cd
	Checksum: 0x6887082
	Offset: 0x3F8
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_d38f33fb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_7a6fd40 = struct::get("n_c_w_p_01");
	var_7a6fd40 function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

/*
	Name: function_c5199710
	Namespace: namespace_9d58c1cd
	Checksum: 0xC4149931
	Offset: 0x490
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_c5199710(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_7a6fd40 = struct::get("n_c_w_p_02");
	var_7a6fd40 function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

/*
	Name: function_68a0de20
	Namespace: namespace_9d58c1cd
	Checksum: 0xD5D89043
	Offset: 0x528
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_68a0de20(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	var_7a6fd40 = struct::get("n_c_w_p_03");
	var_7a6fd40 function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump);
}

/*
	Name: function_ba8cd0cf
	Namespace: namespace_9d58c1cd
	Checksum: 0x9DE7415D
	Offset: 0x5C0
	Size: 0x35E
	Parameters: 7
	Flags: Linked
*/
function function_ba8cd0cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		if(isdefined(self.var_2ef4fed9))
		{
			self.var_2ef4fed9.script_int = newval;
			self.var_2ef4fed9.var_e9e6d25a = 1;
			self.var_2ef4fed9 function_386b1e70(localclientnum);
		}
		else
		{
			self.var_2ef4fed9 = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
			self.var_2ef4fed9.script_int = newval;
			self.var_2ef4fed9.var_e9e6d25a = 1;
			self.var_2ef4fed9.var_922c0c5c = &function_43c140b4;
			self.var_2ef4fed9.var_ffeecdb6 = &function_386b1e70;
			self.var_2ef4fed9 function_386b1e70(localclientnum);
			if(!isdefined(level.var_22a393d4))
			{
				level.var_22a393d4 = [];
			}
			else if(!isarray(level.var_22a393d4))
			{
				level.var_22a393d4 = array(level.var_22a393d4);
			}
			level.var_22a393d4[level.var_22a393d4.size] = self.var_2ef4fed9;
		}
	}
	else if(isdefined(self.var_2ef4fed9))
	{
		if(isdefined(self.var_2ef4fed9.var_e9e6d25a) && self.var_2ef4fed9.var_e9e6d25a)
		{
			self.var_2ef4fed9.var_e9e6d25a = undefined;
		}
		self.var_2ef4fed9.script_int = newval;
	}
	else
	{
		self.var_2ef4fed9 = util::spawn_model(localclientnum, self.model, self.origin, self.angles);
		self.var_2ef4fed9.script_int = newval;
		self.var_2ef4fed9.var_922c0c5c = &function_43c140b4;
		self.var_2ef4fed9.var_ffeecdb6 = &function_386b1e70;
		self.var_2ef4fed9 function_386b1e70(localclientnum);
		if(!isdefined(level.var_22a393d4))
		{
			level.var_22a393d4 = [];
		}
		else if(!isarray(level.var_22a393d4))
		{
			level.var_22a393d4 = array(level.var_22a393d4);
		}
		level.var_22a393d4[level.var_22a393d4.size] = self.var_2ef4fed9;
	}
}

/*
	Name: function_386b1e70
	Namespace: namespace_9d58c1cd
	Checksum: 0xBE9D5075
	Offset: 0x928
	Size: 0x2F4
	Parameters: 1
	Flags: Linked
*/
function function_386b1e70(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(self haspart(localclientnum, "tag_paper_on_1"))
	{
		self hidepart(localclientnum, "tag_paper_on_1");
	}
	if(self haspart(localclientnum, "tag_paper_on_2"))
	{
		self hidepart(localclientnum, "tag_paper_on_2");
	}
	if(self haspart(localclientnum, "tag_paper_on_3"))
	{
		self hidepart(localclientnum, "tag_paper_on_3");
	}
	if(self haspart(localclientnum, "tag_paper_on_4"))
	{
		self hidepart(localclientnum, "tag_paper_on_4");
	}
	if(self haspart(localclientnum, "tag_paper_on_5"))
	{
		self hidepart(localclientnum, "tag_paper_on_5");
	}
	if(self haspart(localclientnum, "tag_paper_on_6"))
	{
		self hidepart(localclientnum, "tag_paper_on_6");
	}
	if(self haspart(localclientnum, "tag_paper_on_7"))
	{
		self hidepart(localclientnum, "tag_paper_on_7");
	}
	if(self haspart(localclientnum, "tag_paper_on_8"))
	{
		self hidepart(localclientnum, "tag_paper_on_8");
	}
	if(self haspart(localclientnum, "tag_paper_on_9"))
	{
		self hidepart(localclientnum, "tag_paper_on_9");
	}
	if(self haspart(localclientnum, "tag_paper_on_0"))
	{
		self hidepart(localclientnum, "tag_paper_on_0");
	}
	if(self haspart(localclientnum, "tag_paper_off"))
	{
		self showpart(localclientnum, "tag_paper_off");
	}
}

/*
	Name: function_43c140b4
	Namespace: namespace_9d58c1cd
	Checksum: 0x77328F3A
	Offset: 0xC28
	Size: 0x3C4
	Parameters: 1
	Flags: Linked
*/
function function_43c140b4(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	if(self haspart(localclientnum, "tag_paper_on_1"))
	{
		self hidepart(localclientnum, "tag_paper_on_1");
	}
	if(self haspart(localclientnum, "tag_paper_on_2"))
	{
		self hidepart(localclientnum, "tag_paper_on_2");
	}
	if(self haspart(localclientnum, "tag_paper_on_3"))
	{
		self hidepart(localclientnum, "tag_paper_on_3");
	}
	if(self haspart(localclientnum, "tag_paper_on_4"))
	{
		self hidepart(localclientnum, "tag_paper_on_4");
	}
	if(self haspart(localclientnum, "tag_paper_on_5"))
	{
		self hidepart(localclientnum, "tag_paper_on_5");
	}
	if(self haspart(localclientnum, "tag_paper_on_6"))
	{
		self hidepart(localclientnum, "tag_paper_on_6");
	}
	if(self haspart(localclientnum, "tag_paper_on_7"))
	{
		self hidepart(localclientnum, "tag_paper_on_7");
	}
	if(self haspart(localclientnum, "tag_paper_on_8"))
	{
		self hidepart(localclientnum, "tag_paper_on_8");
	}
	if(self haspart(localclientnum, "tag_paper_on_9"))
	{
		self hidepart(localclientnum, "tag_paper_on_9");
	}
	if(self haspart(localclientnum, "tag_paper_on_0"))
	{
		self hidepart(localclientnum, "tag_paper_on_0");
	}
	if(self haspart(localclientnum, "tag_paper_off"))
	{
		self hidepart(localclientnum, "tag_paper_off");
	}
	if(isdefined(self.var_e9e6d25a) && self.var_e9e6d25a)
	{
		return;
	}
	if(isdefined(self.script_int))
	{
		if(self.script_int == 10)
		{
			if(self haspart(localclientnum, "tag_paper_on_0"))
			{
				self showpart(localclientnum, "tag_paper_on_0");
			}
		}
		else if(self haspart(localclientnum, "tag_paper_on_" + self.script_int))
		{
			self showpart(localclientnum, "tag_paper_on_" + self.script_int);
		}
	}
}

/*
	Name: function_e9808c9d
	Namespace: namespace_9d58c1cd
	Checksum: 0x912BF96A
	Offset: 0xFF8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_e9808c9d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self playrumbleonentity(localclientnum, #"hash_64b33287bc9d79f5");
}

/*
	Name: function_69a31ba8
	Namespace: namespace_9d58c1cd
	Checksum: 0xCB12775D
	Offset: 0x1068
	Size: 0x364
	Parameters: 7
	Flags: Linked
*/
function function_69a31ba8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_7d33d419))
	{
		level.var_7d33d419 = [];
	}
	if(!isdefined(level.var_7d33d419[localclientnum]))
	{
		var_5980d6d5 = struct::get("s_cr_sp_pi");
		level.var_7d33d419[localclientnum] = util::spawn_model(localclientnum, #"hash_66161656c8ef4b2d", var_5980d6d5.origin, var_5980d6d5.angles);
	}
	level.var_7d33d419[localclientnum] endon(#"death");
	level.var_7d33d419[localclientnum] util::waittill_dobj(localclientnum);
	if(newval)
	{
		if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_elbow_r"))
		{
			level.var_7d33d419[localclientnum] showpart(localclientnum, "tag_elbow_r");
		}
		if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_wrist_r"))
		{
			level.var_7d33d419[localclientnum] showpart(localclientnum, "tag_wrist_r");
		}
		if(level.var_7d33d419[localclientnum] haspart(localclientnum, "TAG_SPOON"))
		{
			level.var_7d33d419[localclientnum] showpart(localclientnum, "TAG_SPOON");
		}
	}
	else if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_elbow_r"))
	{
		level.var_7d33d419[localclientnum] hidepart(localclientnum, "tag_elbow_r");
	}
	if(level.var_7d33d419[localclientnum] haspart(localclientnum, "tag_wrist_r"))
	{
		level.var_7d33d419[localclientnum] hidepart(localclientnum, "tag_wrist_r");
	}
	if(level.var_7d33d419[localclientnum] haspart(localclientnum, "TAG_SPOON"))
	{
		level.var_7d33d419[localclientnum] hidepart(localclientnum, "TAG_SPOON");
	}
}

