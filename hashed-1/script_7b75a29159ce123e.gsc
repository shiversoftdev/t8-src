// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_55f8626e;

/*
	Name: init
	Namespace: namespace_55f8626e
	Checksum: 0x4BCCBB33
	Offset: 0x1D8
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&on_player_connect);
	callback::on_ai_killed(&function_8addaa01);
	callback::on_laststand(&on_player_last_stand);
	callback::on_ai_killed(&function_60f79e9c);
	level.var_49f54c9e = 0;
	callback::on_ai_killed(&function_7fe4eb1d);
	callback::function_74872db6(&function_60193f7d);
	callback::function_74872db6(&function_dab4588);
	callback::function_189f87c1(&function_d62a70b4);
}

/*
	Name: on_player_connect
	Namespace: namespace_55f8626e
	Checksum: 0x2FD07513
	Offset: 0x2F8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self thread function_b091b039();
	self.var_e9f787ee = 0;
	self.var_5a15be2a = &function_ea30554a;
	self.var_d67976f1 = 0;
	self.var_32ab02ea = 0;
	self thread function_260d850a();
}

/*
	Name: function_b091b039
	Namespace: namespace_55f8626e
	Checksum: 0x155A5768
	Offset: 0x368
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_b091b039()
{
	self endon(#"disconnect");
	self waittill(#"hash_5a48f79b359c304");
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_office_cold_war", 0);
}

/*
	Name: function_ea30554a
	Namespace: namespace_55f8626e
	Checksum: 0x5052797A
	Offset: 0x3E8
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function function_ea30554a()
{
	self.var_e9f787ee++;
	/#
		iprintln("" + self.var_e9f787ee);
	#/
	if(self.var_e9f787ee > 114)
	{
		/#
			iprintlnbold("" + "");
		#/
		self zm_utility::giveachievement_wrapper("zm_office_ice", 0);
		self.var_5a15be2a = undefined;
	}
}

/*
	Name: function_7fe4eb1d
	Namespace: namespace_55f8626e
	Checksum: 0x9B37A16F
	Offset: 0x490
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_7fe4eb1d(s_params)
{
	e_attacker = s_params.eattacker;
	if(!isdefined(e_attacker) || !isdefined(e_attacker._trap_type) || e_attacker._trap_type != "electric")
	{
		return;
	}
	level.var_49f54c9e++;
	/#
		iprintln("" + level.var_49f54c9e);
	#/
	if(level.var_49f54c9e > 114)
	{
		/#
			iprintlnbold("" + "");
		#/
		zm_utility::giveachievement_wrapper("zm_office_shock", 1);
		callback::remove_on_ai_killed(&function_7fe4eb1d);
	}
}

/*
	Name: function_60193f7d
	Namespace: namespace_55f8626e
	Checksum: 0x5989F554
	Offset: 0x5A8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_60193f7d()
{
	if(level flag::get("power_on"))
	{
		callback::function_50fdac80(&function_60193f7d);
		return;
	}
	if(level.round_number > 19)
	{
		/#
			iprintlnbold("" + "");
		#/
		zm_utility::giveachievement_wrapper("zm_office_power", 1);
		callback::function_50fdac80(&function_60193f7d);
	}
}

/*
	Name: function_8addaa01
	Namespace: namespace_55f8626e
	Checksum: 0xFC110D03
	Offset: 0x670
	Size: 0x126
	Parameters: 1
	Flags: Linked
*/
function function_8addaa01(params)
{
	e_attacker = params.eattacker;
	if(!isdefined(e_attacker.var_d67976f1))
	{
		return;
	}
	if(self.archetype != #"nova_crawler" || params.smeansofdeath == "MOD_PISTOL_BULLET" || params.smeansofdeath == "MOD_RIFLE_BULLET")
	{
		return;
	}
	e_attacker.var_d67976f1++;
	/#
		iprintln("" + e_attacker.var_d67976f1);
	#/
	if(e_attacker.var_d67976f1 > 49)
	{
		/#
			iprintlnbold("" + "");
		#/
		e_attacker zm_utility::giveachievement_wrapper("zm_office_strike", 0);
		e_attacker.var_d67976f1 = undefined;
	}
}

/*
	Name: function_dab4588
	Namespace: namespace_55f8626e
	Checksum: 0x7417580
	Offset: 0x7A0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_dab4588()
{
	if(zm_zonemgr::zone_is_enabled("war_room_zone_top"))
	{
		callback::function_50fdac80(&function_dab4588);
		return;
	}
	if(level.round_number > 19)
	{
		/#
			iprintlnbold("" + "");
		#/
		zm_utility::giveachievement_wrapper("zm_office_office", 1);
		callback::function_50fdac80(&function_dab4588);
	}
}

/*
	Name: on_player_last_stand
	Namespace: namespace_55f8626e
	Checksum: 0xF35B642
	Offset: 0x860
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_last_stand()
{
	self thread function_edf1b266();
}

/*
	Name: function_edf1b266
	Namespace: namespace_55f8626e
	Checksum: 0x7A61F06D
	Offset: 0x888
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_edf1b266()
{
	self endon(#"death", #"disconnect", #"player_revived");
	self waittill(#"teleporting");
	self thread function_1ac7a037();
}

/*
	Name: function_1ac7a037
	Namespace: namespace_55f8626e
	Checksum: 0xEA3FC5A0
	Offset: 0x8F0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_1ac7a037()
{
	self endon(#"death", #"disconnect");
	self waittill(#"player_revived");
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_office_crawl", 0);
}

/*
	Name: function_60f79e9c
	Namespace: namespace_55f8626e
	Checksum: 0x3ED0E658
	Offset: 0x980
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function function_60f79e9c(params)
{
	e_attacker = params.eattacker;
	if(!isdefined(e_attacker) || !isdefined(e_attacker.var_32ab02ea) || !isplayer(e_attacker))
	{
		return;
	}
	if(!e_attacker clientfield::get_to_player("nova_crawler_gas_cloud_postfx_clientfield"))
	{
		return;
	}
	e_attacker.var_32ab02ea++;
	/#
		iprintln("" + e_attacker.var_32ab02ea);
	#/
	if(e_attacker.var_32ab02ea > 49)
	{
		/#
			iprintlnbold("" + "");
		#/
		e_attacker zm_utility::giveachievement_wrapper("zm_office_gas", 0);
		e_attacker.var_32ab02ea = undefined;
	}
}

/*
	Name: function_1cc0b38a
	Namespace: namespace_55f8626e
	Checksum: 0xA22BF87A
	Offset: 0xAA8
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_1cc0b38a()
{
	foreach(e_player in level.activeplayers)
	{
		if(zm_utility::is_player_valid(e_player, 0, 1) && !e_player istouching(level.var_83225f64[0]))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_d62a70b4
	Namespace: namespace_55f8626e
	Checksum: 0x6EF8B3D8
	Offset: 0xB70
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_d62a70b4()
{
	if(isdefined(level.var_2ae5b6fb))
	{
		level.var_2ae5b6fb++;
		/#
			iprintln("" + level.var_2ae5b6fb);
		#/
		if(level.var_2ae5b6fb > 4)
		{
			/#
				iprintlnbold("" + "");
			#/
			zm_utility::giveachievement_wrapper("zm_office_pentupagon", 1);
			level notify(#"hash_40475441c5bdca82");
			callback::function_ec6dfc37(&function_d62a70b4);
		}
	}
	else if(function_1cc0b38a())
	{
		level.var_2ae5b6fb = 1;
		/#
			iprintln("" + level.var_2ae5b6fb);
		#/
		level thread function_98390b60();
	}
}

/*
	Name: function_98390b60
	Namespace: namespace_55f8626e
	Checksum: 0xC0D4E08F
	Offset: 0xCC0
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_98390b60()
{
	level endon(#"hash_40475441c5bdca82");
	while(function_1cc0b38a())
	{
		wait(1);
	}
	level.var_2ae5b6fb = undefined;
}

/*
	Name: function_3db52483
	Namespace: namespace_55f8626e
	Checksum: 0xFE755743
	Offset: 0xD10
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_3db52483()
{
	n_time = gettime();
	if(!isdefined(self.var_23688a5e))
	{
		self.var_23688a5e = [];
	}
	else if(!isarray(self.var_23688a5e))
	{
		self.var_23688a5e = array(self.var_23688a5e);
	}
	self.var_23688a5e[self.var_23688a5e.size] = n_time;
	while(n_time > self.var_23688a5e[0] + 60000)
	{
		arrayremoveindex(self.var_23688a5e, 0);
	}
}

/*
	Name: function_260d850a
	Namespace: namespace_55f8626e
	Checksum: 0x6BEE8D45
	Offset: 0xDD0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_260d850a()
{
	self endon(#"disconnect");
	if(!isdefined(self.var_23688a5e))
	{
		self.var_23688a5e = [];
	}
	else if(!isarray(self.var_23688a5e))
	{
		self.var_23688a5e = array(self.var_23688a5e);
	}
	while(self.var_23688a5e.size < 7)
	{
		self waittill(#"teleporting");
		self function_3db52483();
		/#
			iprintln("" + self.var_23688a5e.size);
		#/
	}
	/#
		iprintlnbold("" + "");
	#/
	self zm_utility::giveachievement_wrapper("zm_office_everywhere", 0);
}

