// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace wz_ai_zombie;

/*
	Name: __init__system__
	Namespace: wz_ai_zombie
	Checksum: 0x710AC486
	Offset: 0x198
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_ai_zombie", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_ai_zombie
	Checksum: 0xE8E356B3
	Offset: 0x1E0
	Size: 0x242
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 1, 1);
	clientfield::register("actor", "zombie_has_eyes_col", 13000, 2, "int", &zombie_eyes_clientfield_cb, 0, 0);
	clientfield::register("actor", "zombie_has_microwave", 1, 1, "int", &function_bee29da4, 0, 0);
	clientfield::register("toplayer", "zombie_vehicle_shake", 19000, 1, "counter", &function_3acc8ce4, 0, 0);
	level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
	level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
	level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
	level._effect[#"eye_glow_blue"] = #"wz/fx8_zombie_eye_glow_blue_wz";
	level._effect[#"eye_glow_green"] = #"wz/fx8_zombie_eye_glow_green_wz";
	level._effect[#"microwave_attack"] = #"hash_6b67cc3e876119c1";
}

/*
	Name: handle_zombie_risers
	Namespace: wz_ai_zombie
	Checksum: 0x76A326F3
	Offset: 0x430
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		localplayers = level.localplayers;
		playsound(0, #"zmb_zombie_spawn", self.origin);
		burst_fx = level._effect[#"rise_burst"];
		billow_fx = level._effect[#"rise_billow"];
		for(i = 0; i < localplayers.size; i++)
		{
			self thread rise_dust_fx(localclientnum, billow_fx, burst_fx);
		}
	}
}

/*
	Name: rise_dust_fx
	Namespace: wz_ai_zombie
	Checksum: 0x7F35CC64
	Offset: 0x558
	Size: 0x10C
	Parameters: 3
	Flags: Linked
*/
function rise_dust_fx(clientnum, billow_fx, burst_fx)
{
	self endon(#"death");
	dust_tag = "J_SpineUpper";
	if(isdefined(burst_fx))
	{
		playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
	}
	wait(0.25);
	if(isdefined(billow_fx))
	{
		playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
	}
}

/*
	Name: zombie_eyes_clientfield_cb
	Namespace: wz_ai_zombie
	Checksum: 0xC8815EB2
	Offset: 0x670
	Size: 0x194
	Parameters: 7
	Flags: Linked
*/
function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_ea20345f))
	{
		self stoprenderoverridebundle(self.var_ea20345f, "j_head");
	}
	if(isdefined(self.var_3231a850))
	{
		stopfx(localclientnum, self.var_3231a850);
		self.var_3231a850 = undefined;
	}
	if(newval > 0)
	{
		if(newval == 2)
		{
			self.var_ea20345f = "rob_zm_eyes_blue";
			var_d40cd873 = "eye_glow_blue";
		}
		else
		{
			if(newval == 3)
			{
				self.var_ea20345f = "rob_zm_eyes_green";
				var_d40cd873 = "eye_glow_green";
			}
			else
			{
				self.var_ea20345f = "rob_zm_eyes_red";
				var_d40cd873 = "eye_glow";
				self playrenderoverridebundle(self.var_ea20345f, "j_head");
			}
		}
		self.var_3231a850 = util::playfxontag(localclientnum, level._effect[var_d40cd873], self, "j_eyeball_le");
		self enableonradar();
	}
}

/*
	Name: function_bee29da4
	Namespace: wz_ai_zombie
	Checksum: 0x64C98AD8
	Offset: 0x810
	Size: 0xB2
	Parameters: 7
	Flags: Linked
*/
function function_bee29da4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_165c58d7))
	{
		stopfx(localclientnum, self.var_165c58d7);
		self.var_165c58d7 = undefined;
	}
	if(newval)
	{
		self.var_165c58d7 = util::playfxontag(localclientnum, level._effect[#"microwave_attack"], self, "j_head");
	}
}

/*
	Name: function_3acc8ce4
	Namespace: wz_ai_zombie
	Checksum: 0x6F994D0
	Offset: 0x8D0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_3acc8ce4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	id = earthquake(localclientnum, 0.3, 1, self.origin, 1000);
	playrumbleonposition(localclientnum, "grenade_rumble", self.origin);
}

