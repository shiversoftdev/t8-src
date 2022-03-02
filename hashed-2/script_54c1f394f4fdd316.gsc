// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f65948f90646f7c;
#using script_47fb62300ac0bd60;
#using script_64ab2b950d85b8ad;
#using script_6b7c77b107c81e62;
#using script_8abfb58852911dd;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace namespace_e79e59a0;

/*
	Name: function_89f2df9
	Namespace: namespace_e79e59a0
	Checksum: 0xB6738D81
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_3434169163ecaa3e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e79e59a0
	Checksum: 0x6C69A485
	Offset: 0x140
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_a6a3e12a = [];
	clientfield::function_a8bbc967("hudItems.depositing", 13000, 1, "int", 0);
	if(getdvarint(#"hash_7074ed0f04816b75", 0))
	{
		clientfield::register("allplayers", "wz_cash_carrying", 13000, 1, "int");
	}
	level thread function_be29b8d2();
	callback::on_player_killed(&on_player_killed);
	/#
		callback::function_98a0917d(&function_a6eac3b7);
	#/
}

/*
	Name: on_player_killed
	Namespace: namespace_e79e59a0
	Checksum: 0x94C24666
	Offset: 0x238
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_killed()
{
	self clientfield::set_player_uimodel("hudItems.depositing", 0);
}

/*
	Name: function_ed66923
	Namespace: namespace_e79e59a0
	Checksum: 0x8E398162
	Offset: 0x268
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function function_ed66923(targetname, count)
{
	if(isdefined(level.var_a6a3e12a[targetname]))
	{
		return;
	}
	level.var_a6a3e12a[targetname] = count;
}

/*
	Name: function_be29b8d2
	Namespace: namespace_e79e59a0
	Checksum: 0x1BB4B824
	Offset: 0x2B8
	Size: 0x1D8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_be29b8d2()
{
	item_world::function_1b11e73c();
	foreach(targetname, count in level.var_a6a3e12a)
	{
		function_189f45d2(targetname);
	}
	item_world::function_4de3ca98();
	if(getdvarint(#"hash_7074ed0f04816b75", 0))
	{
		item_drop::function_f3f9788a(#"hash_c4258356b038138", 1);
		level.var_590e0497 = [];
		foreach(targetname, count in level.var_a6a3e12a)
		{
			function_af4c6c9b(targetname, count);
		}
		level thread function_fb346efb();
	}
	else
	{
		foreach(targetname, count in level.var_a6a3e12a)
		{
			function_189f45d2(targetname);
		}
	}
}

/*
	Name: function_189f45d2
	Namespace: namespace_e79e59a0
	Checksum: 0x9E121652
	Offset: 0x498
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_189f45d2(targetname)
{
	var_fd5a4651 = getdynentarray(targetname);
	foreach(safe in var_fd5a4651)
	{
		function_e2a06860(safe, 1);
	}
}

/*
	Name: function_af4c6c9b
	Namespace: namespace_e79e59a0
	Checksum: 0x6673F2E
	Offset: 0x548
	Size: 0x110
	Parameters: 2
	Flags: Linked, Private
*/
function private function_af4c6c9b(targetname, count)
{
	var_fd5a4651 = getdynentarray(targetname);
	while(var_fd5a4651.size > count)
	{
		i = randomint(var_fd5a4651.size);
		var_fd5a4651[i] function_ec834c4d();
		arrayremoveindex(var_fd5a4651, i);
	}
	foreach(safe in var_fd5a4651)
	{
		safe function_fcf5be67();
	}
}

/*
	Name: function_fb346efb
	Namespace: namespace_e79e59a0
	Checksum: 0xE48EBFEC
	Offset: 0x660
	Size: 0x118
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fb346efb()
{
	level flagsys::wait_till(#"hash_405e46788e83af41");
	var_c88d9756 = level.var_fb91af8.size - 1;
	while(level.var_52b56362 < var_c88d9756)
	{
		wait(1);
	}
	var_8e3c3c5b = level.var_fb91af8[level.var_52b56362];
	level.var_590e0497 = [];
	foreach(targetname, count in level.var_a6a3e12a)
	{
		function_3387f756(targetname, var_8e3c3c5b.origin, var_8e3c3c5b.radius);
	}
}

/*
	Name: function_3387f756
	Namespace: namespace_e79e59a0
	Checksum: 0x7974CDD2
	Offset: 0x780
	Size: 0x108
	Parameters: 3
	Flags: Linked, Private
*/
function private function_3387f756(targetname, origin, radius)
{
	var_fd5a4651 = getdynentarray(targetname);
	radiussq = radius * radius;
	foreach(safe in var_fd5a4651)
	{
		if(distance2dsquared(origin, safe.origin) <= radiussq)
		{
			safe function_fcf5be67();
			continue;
		}
		safe function_ec834c4d();
	}
}

/*
	Name: function_fcf5be67
	Namespace: namespace_e79e59a0
	Checksum: 0x6775EEF4
	Offset: 0x890
	Size: 0xBE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fcf5be67()
{
	function_e2a06860(self, 0);
	self.var_e7823894 = 1;
	self.canuse = &function_c92a5584;
	self.onbeginuse = &function_97eb71f0;
	self.var_263c4ded = &function_3d49217f;
	self.onuse = &function_7c5a1e82;
	self.var_45f1d6af = &function_368adf4f;
	level.var_590e0497[level.var_590e0497.size] = self;
}

/*
	Name: function_ec834c4d
	Namespace: namespace_e79e59a0
	Checksum: 0xC2ACD134
	Offset: 0x958
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ec834c4d()
{
	function_e2a06860(self, 2);
}

/*
	Name: function_c92a5584
	Namespace: namespace_e79e59a0
	Checksum: 0xAF1A90B9
	Offset: 0x980
	Size: 0x132
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c92a5584(activator)
{
	if(!isdefined(activator) || !isstruct(activator.inventory) || !isarray(activator.inventory.items))
	{
		return false;
	}
	foreach(item in activator.inventory.items)
	{
		if(!isdefined(item) || !isstruct(item.var_a6762160) || item.var_a6762160.itemtype !== #"cash")
		{
			continue;
		}
		return true;
	}
	return false;
}

/*
	Name: function_97eb71f0
	Namespace: namespace_e79e59a0
	Checksum: 0xA8092469
	Offset: 0xAC0
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_97eb71f0(activator)
{
	if(isdefined(activator.var_8a022726))
	{
		activator.var_8a022726 sethintstring(#"");
	}
	activator clientfield::set_player_uimodel("hudItems.depositing", 1);
}

/*
	Name: function_3d49217f
	Namespace: namespace_e79e59a0
	Checksum: 0xF4F30F60
	Offset: 0xB30
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3d49217f(activator)
{
	var_22aec194 = activator function_2cef7d98();
	if(isdefined(var_22aec194))
	{
		return var_22aec194.var_a6762160.casttime;
	}
	return undefined;
}

/*
	Name: function_7c5a1e82
	Namespace: namespace_e79e59a0
	Checksum: 0x20643C8
	Offset: 0xB88
	Size: 0x1EC
	Parameters: 3
	Flags: Linked, Private
*/
function private function_7c5a1e82(activator, stateindex, var_9bdcfcd8)
{
	self function_651e50d9(activator);
	if(!isdefined(activator) || !isstruct(activator.inventory) || !isarray(activator.inventory.items))
	{
		return false;
	}
	var_22aec194 = activator function_2cef7d98();
	if(isdefined(var_22aec194))
	{
		scoreamount = var_22aec194.var_a6762160.amount;
		var_3e67196f = var_22aec194.count;
		activator namespace_b376ff3f::function_6e376bb1(var_22aec194.var_bd027dd9, 1);
		if(var_22aec194.count < var_3e67196f)
		{
			[[level._setteamscore]](activator.team, [[level._getteamscore]](activator.team) + scoreamount);
			playsoundatposition(#"hash_2b58f77dbea4ade1", self.origin);
			globallogic_score::function_889ed975(activator, scoreamount, 0, 0);
			activator stats::function_bb7eedf0(#"score", scoreamount);
			activator stats::function_b7f80d87(#"score", scoreamount);
			return true;
		}
	}
	return false;
}

/*
	Name: function_2cef7d98
	Namespace: namespace_e79e59a0
	Checksum: 0x18F0CBED
	Offset: 0xD80
	Size: 0x116
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2cef7d98()
{
	var_22aec194 = undefined;
	foreach(item in self.inventory.items)
	{
		if(!isdefined(item) || !isstruct(item.var_a6762160) || item.var_a6762160.itemtype !== #"cash")
		{
			continue;
		}
		if(!isdefined(var_22aec194) || var_22aec194.var_a6762160.amount < item.var_a6762160.amount)
		{
			var_22aec194 = item;
		}
	}
	return var_22aec194;
}

/*
	Name: function_368adf4f
	Namespace: namespace_e79e59a0
	Checksum: 0x7301096B
	Offset: 0xEA0
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_368adf4f(activator)
{
	self function_651e50d9(activator);
}

/*
	Name: function_651e50d9
	Namespace: namespace_e79e59a0
	Checksum: 0xE3BF264
	Offset: 0xED0
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private function_651e50d9(activator)
{
	bundle = function_489009c1(self);
	state = function_ffdbe8c2(self);
	activator.var_8a022726 namespace_b6ee49c3::function_836af3b3(bundle, state);
	activator clientfield::set_player_uimodel("hudItems.depositing", 0);
}

/*
	Name: function_a6eac3b7
	Namespace: namespace_e79e59a0
	Checksum: 0xB4EFDF0B
	Offset: 0xF70
	Size: 0x168
	Parameters: 0
	Flags: Private
*/
function private function_a6eac3b7()
{
	/#
		while(true)
		{
			wait(0.25);
			dvarstr = getdvarstring(#"scr_give_player_score", "");
			if(dvarstr == "")
			{
				continue;
			}
			setdvar(#"hash_2ffb520615032eca", "");
			args = strtok(dvarstr, "");
			if(args.size == 2)
			{
				player = getentbynum(int(args[0]));
				if(isplayer(player))
				{
					[[level._setteamscore]](player.team, [[level._getteamscore]](player.team) + int(args[1]));
				}
			}
		}
	#/
}

