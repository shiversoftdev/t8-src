// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_score.gsc;

#namespace namespace_d9876c98;

/*
	Name: function_89f2df9
	Namespace: namespace_d9876c98
	Checksum: 0xE7FCAF6E
	Offset: 0x118
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2fd8f0866dbeda28", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: namespace_d9876c98
	Checksum: 0xF0D592A0
	Offset: 0x168
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("allplayers", "" + #"hash_11a25fb3db96fc2d", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_31b61c511ced94d7", 1, 1, "int");
	bgb::register(#"hash_2fd8f0866dbeda28", "time", 300, &enable, &disable, undefined, undefined);
	bgb::function_c2721e81(#"hash_2fd8f0866dbeda28", &add_to_player_score_override, 1);
}

/*
	Name: enable
	Namespace: namespace_d9876c98
	Checksum: 0x77B94F1
	Offset: 0x2A0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	self thread bgb::function_f51e3503(720, &function_db295169, &function_cbaf1f69);
	self thread function_5cf91552();
}

/*
	Name: disable
	Namespace: namespace_d9876c98
	Checksum: 0x80F724D1
	Offset: 0x338
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

/*
	Name: function_5cf91552
	Namespace: namespace_d9876c98
	Checksum: 0xAC899938
	Offset: 0x348
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_5cf91552()
{
	self endon(#"disconnect");
	self clientfield::set("" + #"hash_11a25fb3db96fc2d", 1);
	self util::waittill_either("bled_out", "bgb_update");
	self clientfield::set("" + #"hash_11a25fb3db96fc2d", 0);
	self notify(#"dividend_yield_complete");
}

/*
	Name: add_to_player_score_override
	Namespace: namespace_d9876c98
	Checksum: 0xB80B9D48
	Offset: 0x3F8
	Size: 0x218
	Parameters: 3
	Flags: Linked
*/
function add_to_player_score_override(n_points, str_awarded_by, var_b43eb4dc)
{
	if(str_awarded_by == #"hash_2fd8f0866dbeda28" || n_points == 0)
	{
		return n_points;
	}
	switch(str_awarded_by)
	{
		case "reviver":
		case "bonus_points_powerup_shared":
		case "magicbox_bear":
		{
			return n_points;
		}
		default:
		{
			break;
		}
	}
	if(var_b43eb4dc)
	{
		var_bed6c5f = int(n_points / 20);
		var_15fc340f = var_bed6c5f * 10;
		if(var_15fc340f == 0)
		{
			return n_points;
		}
		if(!isdefined(self.var_9c42f3fe))
		{
			self.var_9c42f3fe = [];
		}
		else if(!isarray(self.var_9c42f3fe))
		{
			self.var_9c42f3fe = array(self.var_9c42f3fe);
		}
		foreach(e_player in self.var_9c42f3fe)
		{
			if(isdefined(e_player))
			{
				e_player thread zm_score::add_to_player_score(var_15fc340f, 1, #"hash_2fd8f0866dbeda28");
			}
		}
		self thread zm_score::add_to_player_score(var_15fc340f, 1, #"hash_2fd8f0866dbeda28");
	}
	return n_points;
}

/*
	Name: function_db295169
	Namespace: namespace_d9876c98
	Checksum: 0xEFFBAB32
	Offset: 0x618
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_db295169(e_player)
{
	self function_51e0947e();
	e_player function_51e0947e();
	str_notify = "dividend_yield_fx_stop_" + self getentitynumber();
	level util::waittill_any_ents(e_player, "disconnect", e_player, str_notify, self, "disconnect", self, "dividend_yield_complete");
	if(isdefined(self))
	{
		self function_68790c5a();
	}
	if(isdefined(e_player))
	{
		e_player function_68790c5a();
	}
}

/*
	Name: function_cbaf1f69
	Namespace: namespace_d9876c98
	Checksum: 0x960E4DEB
	Offset: 0x700
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_cbaf1f69(e_player)
{
	str_notify = "dividend_yield_fx_stop_" + self getentitynumber();
	e_player notify(str_notify);
}

/*
	Name: function_51e0947e
	Namespace: namespace_d9876c98
	Checksum: 0x244B3D99
	Offset: 0x748
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_51e0947e()
{
	if(!isdefined(self.var_836ebde0) || self.var_836ebde0 == 0)
	{
		self.var_836ebde0 = 1;
		self clientfield::set_to_player("" + #"hash_31b61c511ced94d7", 1);
	}
	else
	{
		self.var_836ebde0++;
	}
}

/*
	Name: function_68790c5a
	Namespace: namespace_d9876c98
	Checksum: 0xF9786AF0
	Offset: 0x7C0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_68790c5a()
{
	self.var_836ebde0--;
	if(self.var_836ebde0 == 0)
	{
		self clientfield::set_to_player("" + #"hash_31b61c511ced94d7", 0);
	}
}

