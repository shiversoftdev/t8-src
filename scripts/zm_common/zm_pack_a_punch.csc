// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using script_158d50d476435605;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_pack_a_punch;

/*
	Name: function_89f2df9
	Namespace: zm_pack_a_punch
	Checksum: 0x194624D8
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_pack_a_punch", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_pack_a_punch
	Checksum: 0x224997E3
	Offset: 0x190
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_2ab769386115d75c"] = #"hash_669f8d1e3151a677";
	clientfield::register("zbarrier", "pap_working_fx", 1, 1, "int", &pap_working_fx_handler, 0, 0);
	clientfield::register("zbarrier", "pap_idle_fx", 1, 1, "int", &function_2a80c24d, 0, 0);
	clientfield::register("world", "pap_force_stream", 1, 1, "int", &pap_force_stream, 0, 0);
	callback::on_localplayer_spawned(&on_localplayer_spawned);
	callback::add_callback(#"hash_6900f4ea0ff32c3e", &function_5c574877);
}

/*
	Name: function_5c574877
	Namespace: zm_pack_a_punch
	Checksum: 0x48839AA7
	Offset: 0x2F0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_5c574877(params)
{
	if(isdefined(params.piece) && isdefined(params.piece.weapon))
	{
		params.piece activecamo::function_cbfd8fd6(params.localclientnum);
	}
}

/*
	Name: on_localplayer_spawned
	Namespace: zm_pack_a_punch
	Checksum: 0x57A6C992
	Offset: 0x358
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	n_story = zm_utility::function_166646a6();
	if(isdefined(level.var_59d3631c))
	{
		forcestreamxmodel(level.var_59d3631c, 1, 0);
	}
	else
	{
		if(n_story == 1)
		{
			forcestreamxmodel(#"p7_zm_vending_packapunch_on", 1, 0);
		}
		else if(n_story == 2)
		{
			forcestreamxmodel(#"hash_4efdd19dfd268f23", 1, 0);
		}
	}
}

/*
	Name: pap_force_stream
	Namespace: zm_pack_a_punch
	Checksum: 0xF85C0E1C
	Offset: 0x428
	Size: 0x174
	Parameters: 7
	Flags: Linked
*/
function pap_force_stream(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	n_story = zm_utility::function_166646a6();
	if(newval)
	{
		if(isdefined(level.var_59d3631c))
		{
			forcestreamxmodel(level.var_59d3631c);
		}
		else
		{
			if(n_story == 1)
			{
				forcestreamxmodel(#"p7_zm_vending_packapunch_on");
			}
			else if(n_story == 2)
			{
				forcestreamxmodel(#"hash_4efdd19dfd268f23");
			}
		}
	}
	else
	{
		if(isdefined(level.var_59d3631c))
		{
			stopforcestreamingxmodel(level.var_59d3631c);
		}
		else
		{
			if(n_story == 1)
			{
				stopforcestreamingxmodel(#"p7_zm_vending_packapunch_on");
			}
			else if(n_story == 2)
			{
				stopforcestreamingxmodel(#"hash_4efdd19dfd268f23");
			}
		}
	}
}

/*
	Name: function_2a80c24d
	Namespace: zm_pack_a_punch
	Checksum: 0x9CF0AC27
	Offset: 0x5A8
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_2a80c24d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_f74ad2c1(localclientnum, 4, "fx_tag_mid_jnt");
	}
	else
	{
		if(isdefined(self.n_pap_idle_fx))
		{
			stopfx(localclientnum, self.n_pap_idle_fx);
			self.n_pap_idle_fx = undefined;
		}
		wait(1);
		if(isdefined(self.var_4d7e8438))
		{
			self.var_4d7e8438 delete();
		}
	}
}

/*
	Name: function_f74ad2c1
	Namespace: zm_pack_a_punch
	Checksum: 0x444D54C0
	Offset: 0x688
	Size: 0x152
	Parameters: 3
	Flags: Linked, Private
*/
function private function_f74ad2c1(localclientnum, n_piece_index, str_tag)
{
	mdl_piece = self zbarriergetpiece(n_piece_index);
	if(isdefined(self.var_4d7e8438))
	{
		self.var_4d7e8438 delete();
	}
	if(isdefined(self.n_pap_idle_fx))
	{
		deletefx(localclientnum, self.n_pap_idle_fx);
		self.var_8513edc0 = undefined;
	}
	self.var_4d7e8438 = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
	self.var_4d7e8438 linkto(mdl_piece, str_tag);
	self.n_pap_idle_fx = util::playfxontag(localclientnum, level._effect[#"hash_2ab769386115d75c"], self.var_4d7e8438, "tag_origin");
}

/*
	Name: pap_working_fx_handler
	Namespace: zm_pack_a_punch
	Checksum: 0x603D79D7
	Offset: 0x7E8
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function pap_working_fx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		pap_play_fx(localclientnum, 0, "base_jnt");
	}
	else
	{
		if(isdefined(self.n_pap_fx))
		{
			stopfx(localclientnum, self.n_pap_fx);
			self.n_pap_fx = undefined;
		}
		wait(1);
		if(isdefined(self.mdl_fx))
		{
			self.mdl_fx delete();
		}
	}
}

/*
	Name: pap_play_fx
	Namespace: zm_pack_a_punch
	Checksum: 0xD45384FE
	Offset: 0x8C8
	Size: 0x152
	Parameters: 3
	Flags: Linked, Private
*/
function private pap_play_fx(localclientnum, n_piece_index, str_tag)
{
	mdl_piece = self zbarriergetpiece(n_piece_index);
	if(isdefined(self.mdl_fx))
	{
		self.mdl_fx delete();
	}
	if(isdefined(self.n_pap_fx))
	{
		deletefx(localclientnum, self.n_pap_fx);
		self.n_pap_fx = undefined;
	}
	self.mdl_fx = util::spawn_model(localclientnum, "tag_origin", mdl_piece gettagorigin(str_tag), mdl_piece gettagangles(str_tag));
	self.mdl_fx linkto(mdl_piece, str_tag);
	self.n_pap_fx = util::playfxontag(localclientnum, level._effect[#"pap_working_fx"], self.mdl_fx, "tag_origin");
}

