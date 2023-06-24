// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_weap_ray_gun;

/*
	Name: __init__system__
	Namespace: zm_weap_ray_gun
	Checksum: 0x751E06C0
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"ray_gun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_ray_gun
	Checksum: 0xF5300071
	Offset: 0x140
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_64dc4c79d9035fca"] = #"hash_73bf7604340dd645";
	level._effect[#"hash_41c6282937fa564d"] = #"zombie/fx_powerup_on_green_zmb";
	level._effect[#"hash_537eedf1dffba786"] = #"zombie/fx_powerup_grab_green_zmb";
	clientfield::register("actor", "raygun_disintegrate", 20000, 1, "counter", &function_2602ff58, 0, 0);
}

/*
	Name: function_2602ff58
	Namespace: zm_weap_ray_gun
	Checksum: 0x1DFABD97
	Offset: 0x220
	Size: 0x274
	Parameters: 7
	Flags: Linked
*/
function function_2602ff58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	self endon(#"death");
	self playrenderoverridebundle(#"hash_1d387211bf187bab");
	util::playfxontag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_spinelower");
	wait(0.55);
	util::playfxontag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_spinelower");
	util::playfxontag(localclientnum, level._effect[#"hash_537eedf1dffba786"], self, "j_spinelower");
	util::playfxontag(localclientnum, level._effect[#"hash_41c6282937fa564d"], self, "j_head");
	util::playfxontag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_head");
	util::playfxontag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_shoulder_le");
	util::playfxontag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_elbow_le");
	util::playfxontag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_hip_ri");
	util::playfxontag(localclientnum, level._effect[#"hash_64dc4c79d9035fca"], self, "j_knee_le");
}

