// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_b9aee0cd : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_b9aee0cd
		Checksum: 0xBE2B6734
		Offset: 0x840
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_b9aee0cd
		Checksum: 0xB5C15FDC
		Offset: 0xAD0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_28ccc05d
		Namespace: namespace_b9aee0cd
		Checksum: 0x8BBB9C26
		Offset: 0xA88
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_28ccc05d(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "title", value);
	}

	/*
		Name: function_21eb67aa
		Namespace: namespace_b9aee0cd
		Checksum: 0x34526399
		Offset: 0xA40
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_21eb67aa(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "minutes", value);
	}

	/*
		Name: function_c48569e7
		Namespace: namespace_b9aee0cd
		Checksum: 0xCD47130B
		Offset: 0x9F8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_c48569e7(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "seconds", value);
	}

	/*
		Name: function_7954feaf
		Namespace: namespace_b9aee0cd
		Checksum: 0xBD19B725
		Offset: 0x9B0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_7954feaf(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "showzero", value);
	}

	/*
		Name: close
		Namespace: namespace_b9aee0cd
		Checksum: 0x872D923B
		Offset: 0x980
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_b9aee0cd
		Checksum: 0xE8579891
		Offset: 0x930
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_arcade_timer", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_b9aee0cd
		Checksum: 0xC65AFF21
		Offset: 0x860
		Size: 0xC4
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("showzero", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("seconds", 1, 6, "int");
		namespace_6aaccc24::function_da693cbe("minutes", 1, 4, "int");
		namespace_6aaccc24::function_dcb34c80("string", "title", 1);
	}

}

#namespace zm_arcade_timer;

/*
	Name: set_timer
	Namespace: zm_arcade_timer
	Checksum: 0xA3C38329
	Offset: 0xF0
	Size: 0x134
	Parameters: 3
	Flags: Linked
*/
function set_timer(player, var_c895e25d, var_b1100790)
{
	self function_bbba5164(player);
	n_minutes = int(floor(var_c895e25d / 60));
	n_seconds = int(var_c895e25d - (n_minutes * 60));
	self function_21eb67aa(player, n_minutes);
	self function_c48569e7(player, n_seconds);
	if(n_seconds < 10)
	{
		self function_7954feaf(player, 1);
	}
	else
	{
		self function_7954feaf(player, 0);
	}
	if(isdefined(var_b1100790))
	{
		self function_28ccc05d(player, var_b1100790);
	}
}

/*
	Name: function_e7a1c8a4
	Namespace: zm_arcade_timer
	Checksum: 0xECB9EE29
	Offset: 0x230
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_e7a1c8a4(str_notify)
{
	foreach(player in level.players)
	{
		if(isdefined(level.var_f5682bb8) && level.var_f5682bb8 is_open(player))
		{
			level.var_f5682bb8 close(player);
		}
	}
}

/*
	Name: function_88df772a
	Namespace: zm_arcade_timer
	Checksum: 0x3464498C
	Offset: 0x2F8
	Size: 0x19C
	Parameters: 4
	Flags: None
*/
function function_88df772a(player, var_c895e25d, var_b1100790, var_f0996295 = 0)
{
	player endon(#"disconnect", #"hash_660dedc4af5b4336");
	level endoncallback(&function_e7a1c8a4, #"end_game");
	if(!var_f0996295)
	{
		player endoncallback(&function_57490fd5, #"hash_2a4a6c3c411261d8");
	}
	self function_ecffd525(player);
	if(var_f0996295 || !isdefined(player.var_26b0547b))
	{
		player.var_26b0547b = var_b1100790;
	}
	while(var_c895e25d >= 0)
	{
		if(player.var_26b0547b === var_b1100790)
		{
			self set_timer(player, var_c895e25d, var_b1100790);
		}
		wait(1);
		var_c895e25d--;
		if(!isdefined(player.var_26b0547b))
		{
			player.var_26b0547b = var_b1100790;
		}
	}
	if(player.var_26b0547b === var_b1100790)
	{
		player.var_26b0547b = undefined;
	}
	self function_9bab3960(player, 0, var_b1100790);
}

/*
	Name: function_57490fd5
	Namespace: zm_arcade_timer
	Checksum: 0x386DE5
	Offset: 0x4A0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_57490fd5(str_notify)
{
	if(!isdefined(self.var_e325b124))
	{
		self.var_e325b124 = 0;
	}
	if(self.var_e325b124 > 0)
	{
		self.var_e325b124--;
	}
}

/*
	Name: function_ecffd525
	Namespace: zm_arcade_timer
	Checksum: 0xD5044AE
	Offset: 0x4E8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_ecffd525(player)
{
	if(!isdefined(player.var_e325b124))
	{
		player.var_e325b124 = 0;
	}
	player.var_e325b124++;
	self function_bbba5164(player);
}

/*
	Name: function_bbba5164
	Namespace: zm_arcade_timer
	Checksum: 0xA228A17D
	Offset: 0x540
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_bbba5164(player)
{
	if(!self is_open(player))
	{
		self open(player, 1);
	}
}

/*
	Name: function_9bab3960
	Namespace: zm_arcade_timer
	Checksum: 0x188A17F1
	Offset: 0x590
	Size: 0x110
	Parameters: 3
	Flags: Linked
*/
function function_9bab3960(player, var_d5710e87 = 0, var_b1100790)
{
	if(!isdefined(player.var_e325b124))
	{
		player.var_e325b124 = 0;
	}
	player.var_e325b124--;
	if(player.var_26b0547b === var_b1100790)
	{
		player.var_26b0547b = undefined;
	}
	if(self is_open(player) && (player.var_e325b124 <= 0 || var_d5710e87))
	{
		player.var_e325b124 = 0;
		self close(player);
		player notify(#"hash_2a4a6c3c411261d8");
		player.var_26b0547b = undefined;
		if(var_d5710e87)
		{
			player notify(#"hash_660dedc4af5b4336");
		}
	}
}

/*
	Name: register
	Namespace: zm_arcade_timer
	Checksum: 0x5717F973
	Offset: 0x6A8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_b9aee0cd();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_arcade_timer
	Checksum: 0xCB6369EF
	Offset: 0x6F0
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_arcade_timer
	Checksum: 0xF4887803
	Offset: 0x730
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_arcade_timer
	Checksum: 0x28D2AC
	Offset: 0x758
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_7954feaf
	Namespace: zm_arcade_timer
	Checksum: 0xD29CF038
	Offset: 0x780
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_7954feaf(player, value)
{
	[[ self ]]->function_7954feaf(player, value);
}

/*
	Name: function_c48569e7
	Namespace: zm_arcade_timer
	Checksum: 0x3A57678A
	Offset: 0x7B0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_c48569e7(player, value)
{
	[[ self ]]->function_c48569e7(player, value);
}

/*
	Name: function_21eb67aa
	Namespace: zm_arcade_timer
	Checksum: 0x69818F45
	Offset: 0x7E0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_21eb67aa(player, value)
{
	[[ self ]]->function_21eb67aa(player, value);
}

/*
	Name: function_28ccc05d
	Namespace: zm_arcade_timer
	Checksum: 0xD188F9C8
	Offset: 0x810
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_28ccc05d(player, value)
{
	[[ self ]]->function_28ccc05d(player, value);
}

