// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\ct_ai_blight_father.csc;
#using scripts\mp_common\gametypes\ct_ai_zombie.csc;
#using script_4293197b43dc9fef;
#using script_6d7c7d238494d395;
#using scripts\mp_common\gametypes\ct_core.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace ct_recon;

/*
	Name: main
	Namespace: ct_recon
	Checksum: 0xF685E6C9
	Offset: 0x118
	Size: 0xB6
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	ct_core::function_46e95cc7();
	ct_core::function_fa03fc55();
	clientfield::register("scriptmover", "blood_splat", 1, 1, "int", &function_8bca10ba, 0, 0);
	level.ct_recon_enemy_reinforcement = ct_recon_enemy_reinforcement::register("ct_recon_enemy_reinforcement");
	level.ct_recon_melee_vip = ct_recon_melee_vip::register("ct_recon_melee_vip");
}

/*
	Name: function_8bca10ba
	Namespace: ct_recon
	Checksum: 0x7DE9111
	Offset: 0x1D8
	Size: 0x80
	Parameters: 7
	Flags: None
*/
function function_8bca10ba(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(true)
	{
		fx = playfx(localclientnum, "blood/fx8_blood_cam_impact_spray_zm", self.origin);
		wait(2);
	}
}

