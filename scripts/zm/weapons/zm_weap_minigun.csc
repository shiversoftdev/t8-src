// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_weap_minigun;

/*
	Name: __init__system__
	Namespace: zm_weap_minigun
	Checksum: 0x24AED5F9
	Offset: 0x168
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_minigun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_minigun
	Checksum: 0x13B656FA
	Offset: 0x1B0
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "hero_minigun_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
	clientfield::register("allplayers", "minigun_launcher_muzzle_fx", 1, 1, "counter", &minigun_launcher_muzzle_fx, 0, 0);
	clientfield::register("missile", "minigun_nuke_rob", 1, 1, "int", &minigun_nuke_rob, 0, 0);
	clientfield::register("toplayer", "minigun_nuke_rumble", 1, 1, "counter", &minigun_nuke_rumble, 0, 0);
	level._effect[#"hash_319b0ab74b8b1f3c"] = #"hash_296e81a6f8cea122";
	level._effect[#"hash_31a216b74b91524e"] = #"hash_296775a6f8c86e10";
}

/*
	Name: function_d05553c6
	Namespace: zm_weap_minigun
	Checksum: 0x83C638AF
	Offset: 0x340
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue && !namespace_a6aea2c6::is_active(#"silent_film"))
	{
		self thread postfx::playpostfxbundle(#"hash_1663ca7cc81f9b17");
	}
}

/*
	Name: minigun_nuke_rob
	Namespace: zm_weap_minigun
	Checksum: 0xC767DC94
	Offset: 0x3D8
	Size: 0x84
	Parameters: 7
	Flags: Linked, Private
*/
function private minigun_nuke_rob(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue == 1)
	{
		self playrenderoverridebundle("rob_zm_going_nuclear");
	}
	else
	{
		self stoprenderoverridebundle("rob_zm_going_nuclear");
	}
}

/*
	Name: minigun_nuke_rumble
	Namespace: zm_weap_minigun
	Checksum: 0x9738F114
	Offset: 0x468
	Size: 0xE4
	Parameters: 7
	Flags: Linked, Private
*/
function private minigun_nuke_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	self playrumbleonentity(localclientnum, "damage_heavy");
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	self thread postfx::playpostfxbundle(#"pstfx_slowed");
	self waittilltimeout(1, #"death");
	if(isdefined(self))
	{
		self thread postfx::exitpostfxbundle(#"pstfx_slowed");
	}
}

/*
	Name: minigun_launcher_muzzle_fx
	Namespace: zm_weap_minigun
	Checksum: 0x4CB9F937
	Offset: 0x558
	Size: 0x102
	Parameters: 7
	Flags: Linked
*/
function minigun_launcher_muzzle_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_83a410ad))
	{
		deletefx(localclientnum, self.var_83a410ad, 1);
	}
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		self.var_83a410ad = playviewmodelfx(localclientnum, level._effect[#"hash_319b0ab74b8b1f3c"], "tag_flash2");
	}
	else
	{
		self.var_83a410ad = util::playfxontag(localclientnum, level._effect[#"hash_31a216b74b91524e"], self, "tag_flash2");
	}
}

