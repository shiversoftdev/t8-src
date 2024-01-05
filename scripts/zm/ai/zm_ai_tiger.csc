// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_ai_tiger;

/*
	Name: __init__system__
	Namespace: zm_ai_tiger
	Checksum: 0x21B73A15
	Offset: 0x168
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_tiger", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_tiger
	Checksum: 0x8CA4C4EF
	Offset: 0x1B0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_14c746e550d9f3ca", 1, 2, "counter", &function_76110e92, 0, 0);
	ai::add_archetype_spawn_function(#"tiger", &function_6d7e1f79);
}

/*
	Name: function_6d7e1f79
	Namespace: zm_ai_tiger
	Checksum: 0xF8D6DB05
	Offset: 0x248
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_6d7e1f79(localclientnum)
{
	self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"hash_76a36b718ab9858d");
	self.var_4703d488 = &function_3be6531a;
	self callback::on_shutdown(&on_entity_shutdown);
}

/*
	Name: function_76110e92
	Namespace: zm_ai_tiger
	Checksum: 0xDAE7DDA4
	Offset: 0x2C8
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function function_76110e92(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if((abs(newval - oldval)) == 1)
	{
		self postfx::playpostfxbundle("pstfx_tiger_slash");
	}
	else
	{
		self postfx::playpostfxbundle("pstfx_tiger_slash_r_to_l");
	}
	self playsound(localclientnum, #"hash_53d906ab01cb30a1");
}

/*
	Name: function_3be6531a
	Namespace: zm_ai_tiger
	Checksum: 0xE6224459
	Offset: 0x398
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_3be6531a(localclientnum, turned)
{
	if(turned)
	{
		self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_green", #"hash_5ed7e32b7fd9a111");
	}
	else
	{
		self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_red", #"hash_76a36b718ab9858d");
	}
}

/*
	Name: on_entity_shutdown
	Namespace: zm_ai_tiger
	Checksum: 0xF78BEE22
	Offset: 0x428
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function on_entity_shutdown(localclientnum)
{
	if(isdefined(self))
	{
		self zm_utility::good_barricade_damaged(localclientnum);
		origin = self gettagorigin("j_spine2");
		angles = self gettagangles("j_spine2");
		if(!isdefined(origin))
		{
			origin = self.origin;
		}
		if(!isdefined(angles))
		{
			angles = self.angles;
		}
		playfx(localclientnum, "zm_ai/fx8_zombie_tiger_death_exp", origin, anglestoforward(angles));
		playsound(0, #"hash_5f574d847a1ca1f0", self.origin);
	}
}

