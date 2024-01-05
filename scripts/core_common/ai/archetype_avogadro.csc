// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\ai_shared.csc;

#namespace archetype_avogadro;

/*
	Name: __init__system__
	Namespace: archetype_avogadro
	Checksum: 0x340907DE
	Offset: 0x160
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"archetype_avogadro", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: archetype_avogadro
	Checksum: 0x9BADC01
	Offset: 0x1B0
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_699d5bb1a9339a93", 16000, 1, "int", &function_9452b8f1, 0, 0);
	clientfield::register("actor", "" + #"hash_4466de6137f54b59", 16000, 1, "int", &function_1d2d070c, 0, 0);
	clientfield::register("actor", "" + #"hash_2eec8fc21495a18c", 16000, 2, "int", &function_ae4cd3d4, 0, 0);
	ai::add_archetype_spawn_function(#"avogadro", &initavogadro);
}

/*
	Name: __main__
	Namespace: archetype_avogadro
	Checksum: 0x80F724D1
	Offset: 0x2F8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: initavogadro
	Namespace: archetype_avogadro
	Checksum: 0x52E111C6
	Offset: 0x308
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function initavogadro(localclientnum)
{
	util::waittill_dobj(localclientnum);
	self callback::on_shutdown(&on_entity_shutdown);
}

/*
	Name: on_entity_shutdown
	Namespace: archetype_avogadro
	Checksum: 0x8B4AFAEB
	Offset: 0x358
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_entity_shutdown(localclientnum)
{
	if(isdefined(self) && isdefined(self.jammer_interface))
	{
		self.jammer_interface delete();
	}
}

/*
	Name: function_9452b8f1
	Namespace: archetype_avogadro
	Checksum: 0x9472E539
	Offset: 0x3A0
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_9452b8f1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self.boltfx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_projectile", self, "tag_origin");
	}
	else if(isdefined(self.boltfx))
	{
		stopfx(localclientnum, self.boltfx);
		self.boltfx = undefined;
	}
}

/*
	Name: function_1d2d070c
	Namespace: archetype_avogadro
	Checksum: 0x4F108A1D
	Offset: 0x478
	Size: 0xCE
	Parameters: 7
	Flags: Linked
*/
function function_1d2d070c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(newval)
	{
		self.phase_fx = function_239993de(localclientnum, "zm_ai/fx8_cata_elec_aura", self, "j_spine4");
	}
	else if(isdefined(self.phase_fx))
	{
		stopfx(localclientnum, self.phase_fx);
		self.phase_fx = undefined;
	}
}

/*
	Name: function_ae4cd3d4
	Namespace: archetype_avogadro
	Checksum: 0x38D9FA96
	Offset: 0x550
	Size: 0x1DA
	Parameters: 7
	Flags: Linked, Private
*/
function private function_ae4cd3d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::waittill_dobj(localclientnum);
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.jammer_interface))
	{
		self.jammer_interface = util::spawn_model(localclientnum, "tag_origin");
		self.jammer_interface linkto(self, "j_spine4");
	}
	if(isdefined(self.health_fx))
	{
		stopfx(localclientnum, self.health_fx);
	}
	switch(newval)
	{
		case 3:
		{
			self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_aura_main", self.jammer_interface, "j_spine4");
			break;
		}
		case 2:
		{
			self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_cata_water_aura", self.jammer_interface, "j_spine4");
			break;
		}
		case 1:
		{
			self.health_fx = function_239993de(localclientnum, "zm_ai/fx8_avo_elec_aura_weakened", self.jammer_interface, "j_spine4");
			break;
		}
		default:
		{
			break;
		}
	}
}

