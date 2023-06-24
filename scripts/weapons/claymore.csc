// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace claymore;

/*
	Name: __init__system__
	Namespace: claymore
	Checksum: 0xA6984B87
	Offset: 0x90
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"claymore", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: claymore
	Checksum: 0x98325144
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::add_weapon_type(#"claymore", &claymore_spawned);
}

/*
	Name: claymore_spawned
	Namespace: claymore
	Checksum: 0x8422A343
	Offset: 0x118
	Size: 0xC8
	Parameters: 1
	Flags: None
*/
function claymore_spawned(localclientnum)
{
	self endon(#"death");
	self util::waittill_dobj(localclientnum);
	while(true)
	{
		if(isdefined(self.stunned) && self.stunned)
		{
			wait(0.1);
			continue;
		}
		self.claymorelaserfxid = util::playfxontag(localclientnum, #"_t6/weapon/claymore/fx_claymore_laser", self, "tag_fx");
		self waittill(#"stunned");
		stopfx(localclientnum, self.claymorelaserfxid);
	}
}

