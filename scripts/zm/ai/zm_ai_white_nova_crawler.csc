// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\ai_shared.csc;

#namespace zm_ai_white_nova_crawler;

/*
	Name: __init__system__
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xFD247509
	Offset: 0x2D0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_white_nova_crawler", &__init__, undefined, #"zm_ai_nova_crawler");
}

/*
	Name: __init__
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xE57F2DA8
	Offset: 0x320
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"fx8_nova_crawler_zombie_buff"] = "zm_ai/fx8_nova_crawler_zombie_buff";
	level._effect[#"hash_fa591e70e810d4a"] = "zm_ai/fx8_nova_crawler_gas_cloud_lg";
	clientfield::register("actor", "nova_buff_aura_clientfield", 8000, 1, "int", &function_be621cc7, 0, 0);
	clientfield::register("actor", "white_nova_crawler_phase_end_clientfield", 8000, 1, "counter", &function_18c564d0, 0, 0);
	clientfield::register("actor", "nova_gas_cloud_fx_clientfield", 8000, 1, "counter", &function_c9ef107f, 0, 0);
	clientfield::register("actor", "white_nova_crawler_spore_impact_clientfield", 8000, 1, "counter", &function_2a92d45, 0, 0);
	clientfield::register("scriptmover", "white_nova_crawler_spore_clientfield", 16000, 1, "int", &function_9ed375e1, 0, 0);
	ai::add_archetype_spawn_function(#"nova_crawler", &function_582a3075);
}

/*
	Name: function_582a3075
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xDD0C08A1
	Offset: 0x510
	Size: 0xEE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_582a3075(localclientnum)
{
	if(!isdefined(self._effect))
	{
		self._effect = [];
	}
	self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_explode";
	if(isdefined(self.var_9fde8624))
	{
		if(self.var_9fde8624 == #"blue_nova_crawler")
		{
			self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_mq_explode";
		}
		else if(self.var_9fde8624 == #"ranged_nova_crawler")
		{
			self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_elec_explode";
			self._effect[#"nova_crawler_phase_teleport_end_fx"] = "zm_ai/fx8_nova_crawler_elec_teleport_appear";
		}
	}
}

/*
	Name: function_be621cc7
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x56A28960
	Offset: 0x608
	Size: 0xC6
	Parameters: 7
	Flags: Linked, Private
*/
function private function_be621cc7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newval === 1)
	{
		self.var_f09d143c = util::playfxontag(localclientnum, level._effect[#"fx8_nova_crawler_zombie_buff"], self, "j_spine4");
	}
	else if(isdefined(self.var_f09d143c))
	{
		stopfx(localclientnum, self.var_f09d143c);
		self.var_f09d143c = undefined;
	}
}

/*
	Name: function_18c564d0
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA5A78595
	Offset: 0x6D8
	Size: 0x9C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_18c564d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(isdefined(self._effect) && isdefined(self._effect[#"nova_crawler_phase_teleport_end_fx"]))
	{
		util::playfxontag(localclientnum, self._effect[#"nova_crawler_phase_teleport_end_fx"], self, "j_spine4");
	}
}

/*
	Name: function_c9ef107f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xDEEA54F3
	Offset: 0x780
	Size: 0xA4
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c9ef107f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump)
{
	fx_location = self gettagorigin("j_mainroot");
	if(isdefined(fx_location))
	{
		playfx(localclientnum, level._effect[#"hash_fa591e70e810d4a"], fx_location);
	}
}

/*
	Name: function_2a92d45
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x44237E3E
	Offset: 0x830
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_2a92d45(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(isdefined(self) && newval)
	{
		function_239993de(localclientnum, "zm_ai/fx8_nova_crawler_gas_projectile_impact", self, "j_spine4");
	}
}

/*
	Name: function_9ed375e1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x295CDDA8
	Offset: 0x8C8
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_9ed375e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self.spore_fx = function_239993de(localclientnum, "zm_ai/fx8_nova_crawler_gas_projectile", self, "tag_origin");
	}
	else if(isdefined(self.spore_fx))
	{
		stopfx(localclientnum, self.spore_fx);
		self.spore_fx = undefined;
	}
}

