// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace recon_wz;

/*
	Name: __init__system__
	Namespace: recon_wz
	Checksum: 0xDB1A8669
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register("recon_wz", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: recon_wz
	Checksum: 0xA19D1B41
	Offset: 0x130
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "recon_out_of_circle", 1, 5, "int", &function_a94aaca4, 0, 0);
	clientfield::register("toplayer", "recon_static_postfx", 1, 1, "int", &function_b53c3ad2, 0, 0);
	vehicle::add_vehicletype_callback("recon_wz", &_setup_);
}

/*
	Name: _setup_
	Namespace: recon_wz
	Checksum: 0x117526F8
	Offset: 0x1F8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function _setup_(localclientnum)
{
	self thread vehicle::boost_think(localclientnum);
}

/*
	Name: function_a94aaca4
	Namespace: recon_wz
	Checksum: 0x6D06AAD
	Offset: 0x228
	Size: 0x7E
	Parameters: 7
	Flags: Linked
*/
function function_a94aaca4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		if(isdefined(self.var_2d39c392) && self.var_2d39c392)
		{
			filter::disable_filter_vehicle_hijack_oor(self, 0);
			self.var_2d39c392 = undefined;
		}
	}
}

/*
	Name: function_b53c3ad2
	Namespace: recon_wz
	Checksum: 0xE0AFB92E
	Offset: 0x2B0
	Size: 0xAE
	Parameters: 7
	Flags: Linked
*/
function function_b53c3ad2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_d765daa4(localclientnum);
	}
	else
	{
		self notify(#"hash_16c59bda348653cd");
		if(isdefined(self.var_2d39c392) && self.var_2d39c392)
		{
			filter::disable_filter_vehicle_hijack_oor(self, 0);
			self.var_2d39c392 = undefined;
		}
	}
}

/*
	Name: function_d765daa4
	Namespace: recon_wz
	Checksum: 0x92E329F4
	Offset: 0x368
	Size: 0x226
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d765daa4(localclientnum)
{
	self notify("214105bf7d36e37f");
	self endon("214105bf7d36e37f");
	self endon(#"death");
	self endon(#"exit_vehicle");
	self endon(#"hash_16c59bda348653cd");
	while(true)
	{
		vehicle = getplayervehicle(self);
		if(isdefined(vehicle))
		{
			break;
		}
		waitframe(1);
	}
	vehicle endon(#"death");
	filter::init_filter_vehicle_hijack_oor(self);
	while(true)
	{
		var_e96a9222 = self clientfield::get_to_player("recon_out_of_circle") / 31;
		var_2a1bc201 = distance(self.origin, vehicle.origin);
		if(var_2a1bc201 < 7000 && var_e96a9222 <= 0)
		{
			if(isdefined(self.var_2d39c392) && self.var_2d39c392)
			{
				filter::disable_filter_vehicle_hijack_oor(self, 0);
				self.var_2d39c392 = undefined;
			}
		}
		else
		{
			staticamount = mapfloat(7000, 8000, 0, 1, var_2a1bc201);
			staticamount = max(staticamount, var_e96a9222);
			if(!(isdefined(self.var_2d39c392) && self.var_2d39c392))
			{
				filter::enable_filter_vehicle_hijack_oor(self, 0);
				self.var_2d39c392 = 1;
			}
			filter::set_filter_vehicle_hijack_oor_amount(self, 0, staticamount);
		}
		waitframe(1);
	}
}

