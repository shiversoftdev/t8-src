// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_490759cf62a1abc8;
#using script_5b092d41f1ecae8a;
#using script_61826ca279ffa0;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\round.gsc;

#namespace namespace_738d4870;

/*
	Name: function_6889bb61
	Namespace: namespace_738d4870
	Checksum: 0x5414EE99
	Offset: 0x168
	Size: 0x3EC
	Parameters: 1
	Flags: None
*/
function function_6889bb61(var_74d544ba)
{
	self endon(#"death");
	self thread namespace_73e1c3e3::function_f03da80a();
	if(!level flag::exists("desc_fillup_gadgets"))
	{
		level flag::init("desc_fillup_gadgets");
	}
	if(!level flag::exists("desc_countdown_start"))
	{
		level flag::init("desc_countdown_start");
	}
	if(!level flag::exists("desc_countdown_done"))
	{
		level flag::init("desc_countdown_done");
	}
	level flag::clear("desc_fillup_gadgets");
	level flag::clear("desc_countdown_start");
	level flag::clear("desc_countdown_done");
	if(isdefined(var_74d544ba) && var_74d544ba)
	{
		level waittill(#"hash_4c62fe02843b1a98");
	}
	self clientfield::set_to_player("screen_blur", 1);
	if(isdefined(level.var_e92a00d3))
	{
		self [[level.var_e92a00d3]]();
	}
	self namespace_d82263d5::function_d77271ae();
	if(isdefined(level.var_aae00bf))
	{
		self [[level.var_aae00bf]](#"hash_2ac3b79c708dcfd5");
	}
	self disableweapons();
	self val::set(#"hash_784a49b49cc8c292", "freezecontrols", 1);
	wait(0.5);
	self function_c7106205();
	self clientfield::set_to_player("screen_blur", 0);
	wait(1);
	level flag::set("desc_countdown_start");
	wait(3);
	namespace_73e1c3e3::function_9aca2fa0("ct_spawn");
	level notify(#"hash_44623efd9f4d41a4");
	if(self.sessionstate == "playing")
	{
		self enableweapons();
		self val::reset(#"hash_784a49b49cc8c292", "freezecontrols");
		self val::reset(#"spawn_player", "disablegadgets");
	}
	level notify(#"hash_3779df13251ba6f7");
	level flag::set("desc_countdown_done");
	wait(0.95);
	if(isdefined(level.var_c3af52cc))
	{
		self [[level.var_c3af52cc]]();
		self thread namespace_73e1c3e3::function_d3fd7ef7();
	}
	level flag::set("desc_fillup_gadgets");
}

/*
	Name: function_c7106205
	Namespace: namespace_738d4870
	Checksum: 0x4C4BCA56
	Offset: 0x560
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function function_c7106205()
{
	self endon(#"death");
	level endon(#"hash_3779df13251ba6f7");
	level.var_d0c7d280 = 0;
	if(isdefined(level.var_c01b7f8b))
	{
		self [[level.var_c01b7f8b]](level.var_d0c7d280);
	}
	if(isdefined(level.var_ae120f18))
	{
		level thread namespace_8c007aa6::function_831e0584(level.var_ae120f18, 1);
		level.var_ae120f18 = undefined;
	}
	if(isdefined(level.var_aae00bf))
	{
		level thread function_4b4ca178();
		self [[level.var_aae00bf]](#"hash_3319eaa2c590a2ac");
	}
}

/*
	Name: function_4b4ca178
	Namespace: namespace_738d4870
	Checksum: 0x753009E4
	Offset: 0x650
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_4b4ca178()
{
	e_player = namespace_73e1c3e3::get_player();
	wait(0.5);
	e_player playsound("uin_timer_1");
	wait(1.5);
	e_player playsound("uin_timer_1");
	wait(1);
	e_player playsound("uin_timer_1");
}

/*
	Name: function_fa910e34
	Namespace: namespace_738d4870
	Checksum: 0x1BAB4170
	Offset: 0x6E8
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function function_fa910e34(b_success, var_cd803a6b)
{
}

/*
	Name: function_c86db7f5
	Namespace: namespace_738d4870
	Checksum: 0x8BB09887
	Offset: 0x708
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_c86db7f5(var_cd803a6b)
{
}

/*
	Name: function_963c30ff
	Namespace: namespace_738d4870
	Checksum: 0xB74C51FB
	Offset: 0x720
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_963c30ff(var_cd803a6b)
{
}

/*
	Name: function_1ae56656
	Namespace: namespace_738d4870
	Checksum: 0xC058CCB2
	Offset: 0x738
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function function_1ae56656(b_success)
{
	self endon(#"death");
	level endon(#"hash_516a722471891710");
	while(!self actionbuttonpressed())
	{
		waitframe(1);
	}
	level flag::set("btn_play_again");
}

/*
	Name: function_f667701c
	Namespace: namespace_738d4870
	Checksum: 0xD3DBED01
	Offset: 0x7B0
	Size: 0xD2
	Parameters: 0
	Flags: None
*/
function function_f667701c()
{
	self endon(#"death");
	level endon(#"hash_516a722471891710");
	while(true)
	{
		while(!self stancebuttonpressed())
		{
			waitframe(1);
		}
		for(n_count = 0; self stancebuttonpressed() && n_count < 30; n_count++)
		{
			waitframe(1);
		}
		if(n_count >= 30)
		{
			level flag::set("btn_return_to_menu");
			return;
		}
	}
}

/*
	Name: function_d10b39de
	Namespace: namespace_738d4870
	Checksum: 0x8FEC105A
	Offset: 0x890
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_d10b39de(b_success)
{
	if(b_success)
	{
		if(isdefined(level.var_ac397acd))
		{
			self [[level.var_ac397acd]](#"hash_9eb93e70b62ebd");
		}
	}
	else if(isdefined(level.var_ac397acd))
	{
		self [[level.var_ac397acd]](#"hash_718c7e5495bf7124");
	}
	wait(4);
}

