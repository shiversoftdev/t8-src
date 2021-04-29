// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_56e9194e;

/*
	Name: function_89f2df9
	Namespace: namespace_56e9194e
	Checksum: 0xC5144699
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"tesla_gun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_56e9194e
	Checksum: 0xACB759A6
	Offset: 0xF8
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_669e5aa1 = getweapon(#"hash_491ff8e9d1af03a8");
	level._effect[#"tesla_viewmodel_rail"] = #"zombie/fx_tesla_rail_view_zmb";
	level._effect[#"tesla_viewmodel_tube"] = #"zombie/fx_tesla_tube_view_zmb";
	level._effect[#"tesla_viewmodel_tube2"] = #"zombie/fx_tesla_tube_view2_zmb";
	level._effect[#"tesla_viewmodel_tube3"] = #"zombie/fx_tesla_tube_view3_zmb";
	level._effect[#"tesla_viewmodel_rail_upgraded"] = #"zombie/fx_tesla_rail_view_ug_zmb";
	level._effect[#"tesla_viewmodel_tube_upgraded"] = #"zombie/fx_tesla_tube_view_ug_zmb";
	level._effect[#"tesla_viewmodel_tube2_upgraded"] = #"zombie/fx_tesla_tube_view2_ug_zmb";
	level._effect[#"tesla_viewmodel_tube3_upgraded"] = #"zombie/fx_tesla_tube_view3_ug_zmb";
	clientfield::register("toplayer", "" + #"hash_611f27e5d51d036f", 28000, 1, "int", &function_4dfaa84c, 0, 0);
}

/*
	Name: function_4dfaa84c
	Namespace: namespace_56e9194e
	Checksum: 0xB0AC28F9
	Offset: 0x300
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_4dfaa84c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread tesla_fx_rail(localclientnum);
		self thread tesla_fx_tube(localclientnum);
	}
	else
	{
		self notify(#"hash_319d2bba47dac2c4");
		self clear_tesla_tube_effect(localclientnum);
	}
}

/*
	Name: tesla_fx_rail
	Namespace: namespace_56e9194e
	Checksum: 0xFAAAB8F7
	Offset: 0x3B0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function tesla_fx_rail(localclientnum)
{
	self endon(#"death", #"hash_319d2bba47dac2c4");
	w_current = getcurrentweapon(localclientnum);
	wait(randomfloatrange(0, 12));
	while(true)
	{
		wait(randomfloatrange(8, 12));
		if(getweaponammoclip(localclientnum, w_current) > 0 && !ismeleeing(localclientnum))
		{
			str_fx = level._effect[#"tesla_viewmodel_rail"];
			if(w_current == level.var_669e5aa1)
			{
				str_fx = level._effect[#"tesla_viewmodel_rail_upgraded"];
			}
			playviewmodelfx(localclientnum, str_fx, "tag_flash");
			playsound(localclientnum, #"wpn_tesla_effects", (0, 0, 0));
		}
	}
}

/*
	Name: tesla_fx_tube
	Namespace: namespace_56e9194e
	Checksum: 0xF814E4BB
	Offset: 0x518
	Size: 0x320
	Parameters: 1
	Flags: Linked
*/
function tesla_fx_tube(localclientnum)
{
	self endon(#"death", #"hash_319d2bba47dac2c4");
	w_current = getcurrentweapon(localclientnum);
	while(true)
	{
		wait(0.1);
		n_ammo = getweaponammoclip(localclientnum, w_current);
		if(n_ammo <= 0)
		{
			self clear_tesla_tube_effect(localclientnum);
			continue;
		}
		str_fx = level._effect[#"tesla_viewmodel_tube"];
		if(w_current == level.var_669e5aa1)
		{
			switch(n_ammo)
			{
				case 1:
				case 2:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube3_upgraded"];
					n_tint = 2;
					break;
				}
				case 3:
				case 4:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube2_upgraded"];
					n_tint = 1;
					break;
				}
				default:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube_upgraded"];
					n_tint = 0;
					break;
				}
			}
		}
		else
		{
			switch(n_ammo)
			{
				case 1:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube3"];
					n_tint = 2;
					break;
				}
				case 2:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube2"];
					n_tint = 1;
					break;
				}
				default:
				{
					str_fx = level._effect[#"tesla_viewmodel_tube"];
					n_tint = 0;
					break;
				}
			}
		}
		if(self.str_tesla_current_tube_effect !== str_fx && !ismeleeing(localclientnum))
		{
			if(isdefined(self.n_tesla_tube_fx_id))
			{
				deletefx(localclientnum, self.n_tesla_tube_fx_id, 1);
			}
			self.str_tesla_current_tube_effect = str_fx;
			self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, n_tint, 0);
		}
	}
}

/*
	Name: clear_tesla_tube_effect
	Namespace: namespace_56e9194e
	Checksum: 0x2B7CF2D2
	Offset: 0x840
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function clear_tesla_tube_effect(localclientnum)
{
	if(isdefined(self.n_tesla_tube_fx_id))
	{
		deletefx(localclientnum, self.n_tesla_tube_fx_id, 1);
		self.n_tesla_tube_fx_id = undefined;
	}
	self.str_tesla_current_tube_effect = undefined;
	self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 1, 3, 0);
}

