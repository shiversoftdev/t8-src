// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\util.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_trial_util.csc;
#using scripts\zm_common\zm_trial.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace namespace_841de7df;

/*
	Name: __init__system__
	Namespace: namespace_841de7df
	Checksum: 0xDCE5876C
	Offset: 0x108
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_4ef9c479ac8da304", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_841de7df
	Checksum: 0xFAE2A981
	Offset: 0x150
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	clientfield::register("zbarrier", "" + #"hash_100f180bf5d2a517", 14000, 1, "int", &function_b245db69, 0, 0);
	level._effect[#"hash_1d15a2dad558ac8c"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
	level._effect[#"hash_1d15a5dad558b1a5"] = "zombie/fx8_packapunch_zmb_red_gauntlet";
	zm_trial::register_challenge(#"hash_28d1b9857e2ca681", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_841de7df
	Checksum: 0x4FB3E590
	Offset: 0x258
	Size: 0x14
	Parameters: 2
	Flags: Private
*/
function private on_begin(localclientnum, a_params)
{
}

/*
	Name: on_end
	Namespace: namespace_841de7df
	Checksum: 0x90276D0F
	Offset: 0x278
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
function private on_end(localclientnum)
{
}

/*
	Name: is_active
	Namespace: namespace_841de7df
	Checksum: 0x3BFD374D
	Offset: 0x290
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_28d1b9857e2ca681");
	return isdefined(challenge);
}

/*
	Name: function_b245db69
	Namespace: namespace_841de7df
	Checksum: 0x20F9042F
	Offset: 0x2D0
	Size: 0x224
	Parameters: 7
	Flags: Private
*/
function private function_b245db69(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_18f8b30b))
		{
			self.var_18f8b30b delete();
		}
		if(isdefined(self.var_3b071bba))
		{
			deletefx(localclientnum, self.var_3b071bba);
			self.var_3b071bba = undefined;
		}
		if(zm_utility::get_story() == 1)
		{
			self.var_18f8b30b = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
			self.var_3b071bba = util::playfxontag(localclientnum, level._effect[#"hash_1d15a2dad558ac8c"], self.var_18f8b30b, "tag_origin");
		}
		else
		{
			self.var_18f8b30b = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
			self.var_3b071bba = util::playfxontag(localclientnum, level._effect[#"hash_1d15a5dad558b1a5"], self.var_18f8b30b, "tag_origin");
		}
	}
	else
	{
		if(isdefined(self.var_3b071bba))
		{
			deletefx(localclientnum, self.var_3b071bba);
			self.var_3b071bba = undefined;
		}
		if(isdefined(self.var_18f8b30b))
		{
			self.var_18f8b30b delete();
		}
	}
}

