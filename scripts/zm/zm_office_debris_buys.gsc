// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\clientfield_shared.gsc;

#namespace zm_office_debris_buys;

/*
	Name: __init__system__
	Namespace: zm_office_debris_buys
	Checksum: 0xA3E49E1A
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_debris_buys", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: zm_office_debris_buys
	Checksum: 0xA5D7FAA8
	Offset: 0x108
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("zbarrier", "" + #"hash_7e15d8abc4d6c79a", 1, 1, "int");
	level thread function_ffef72a();
}

/*
	Name: function_ffef72a
	Namespace: zm_office_debris_buys
	Checksum: 0x229D5408
	Offset: 0x170
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_ffef72a()
{
	var_98415589 = getentarray("zombie_debris", "targetname");
	foreach(trigger in var_98415589)
	{
		trigger thread function_31a1d10f();
	}
}

/*
	Name: function_31a1d10f
	Namespace: zm_office_debris_buys
	Checksum: 0x8216E49D
	Offset: 0x218
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function function_31a1d10f()
{
	var_6a20a57a = struct::get_array(self.target + "_struct", "targetname");
	if(isdefined(var_6a20a57a[0]))
	{
		if(!isdefined(self.a_e_zbarriers))
		{
			self.a_e_zbarriers = [];
		}
		else if(!isarray(self.a_e_zbarriers))
		{
			self.a_e_zbarriers = array(self.a_e_zbarriers);
		}
		var_1151d2f8 = getentarray(var_6a20a57a[0].target, "targetname");
		foreach(e_debris in var_1151d2f8)
		{
			if(e_debris iszbarrier())
			{
				if(!isdefined(self.a_e_zbarriers))
				{
					self.a_e_zbarriers = [];
				}
				else if(!isarray(self.a_e_zbarriers))
				{
					self.a_e_zbarriers = array(self.a_e_zbarriers);
				}
				self.a_e_zbarriers[self.a_e_zbarriers.size] = e_debris;
			}
		}
		self waittill(#"kill_debris_prompt_thread");
		foreach(e_zbarrier in self.a_e_zbarriers)
		{
			e_zbarrier playsound(#"hash_144408a3c1139f01");
			e_zbarrier clientfield::set("" + #"hash_7e15d8abc4d6c79a", 1);
		}
	}
}

