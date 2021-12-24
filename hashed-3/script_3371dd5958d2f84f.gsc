// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_2dc48f46bfeac894;
#using script_6c8abe14025b47c4;
#using script_702b73ee97d18efe;
#using script_788472602edbe3b9;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\loadout_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\mp_common\armor.gsc;
#using scripts\mp_common\gametypes\menus.gsc;
#using scripts\mp_common\perks.gsc;
#using scripts\mp_common\pickup_health.gsc;

#namespace namespace_8fdcbe8b;

/*
	Name: function_89f2df9
	Namespace: namespace_8fdcbe8b
	Checksum: 0xEE5AF6E0
	Offset: 0x4B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_50251e63e4a703b5", &__init__, undefined, #"weapons");
}

/*
	Name: __init__
	Namespace: namespace_8fdcbe8b
	Checksum: 0xA6C35431
	Offset: 0x500
	Size: 0x12C
	Parameters: 0
	Flags: Private
*/
private function __init__()
{
	callback::on_connect(&onconnect);
	level.givecustomloadout = &function_738575c4;
	level.var_67f4fd41 = &function_485e3421;
	level.var_a9f35be1 = getscriptbundlelist("bounty_hunter_package_list");
	registerclientfields();
	level.var_968635ea = bountyhunterbuy::register("BountyHunterLoadout");
	for(i = 1; i < 38; i++)
	{
		if(i == 23)
		{
			continue;
		}
		ability_player::register_gadget_activation_callbacks(i, undefined, &function_597cbfb8);
	}
	callback::on_player_killed_with_params(&onplayerkilled);
}

/*
	Name: function_597cbfb8
	Namespace: namespace_8fdcbe8b
	Checksum: 0x1ABD1EF5
	Offset: 0x638
	Size: 0x15C
	Parameters: 3
	Flags: Private
*/
private function function_597cbfb8(slot, weapon, force = 0)
{
	if(!force)
	{
		if(!isalive(self) || game.state != "playing")
		{
			return;
		}
		wait(1);
		if(self gadgetisready(slot))
		{
			return;
		}
	}
	var_fc7876fd = self.pers[#"hash_50251e63e4a703b5"].weapons[2];
	take = 1;
	if(isdefined(var_fc7876fd))
	{
		if(var_fc7876fd.ammo > 1)
		{
			var_fc7876fd.ammo--;
			take = 0;
		}
	}
	if(take)
	{
		self.pers[#"hash_50251e63e4a703b5"].weapons[2] = undefined;
		function_ff8ef46b(2, "luielement.BountyHunterLoadout.equipment", 0);
		self function_9ede386f(slot);
	}
}

/*
	Name: onplayerkilled
	Namespace: namespace_8fdcbe8b
	Checksum: 0x5EBF07C9
	Offset: 0x7A0
	Size: 0xB4
	Parameters: 1
	Flags: Private
*/
private function onplayerkilled(params)
{
	function_cea5cbc5();
	if(!isdefined(params.eattacker) || params.eattacker != self)
	{
		return;
	}
	if(params.weapon.name == #"frag_grenade")
	{
		function_597cbfb8(self gadgetgetslot(params.weapon), params.weapon, 1);
	}
}

/*
	Name: function_9ede386f
	Namespace: namespace_8fdcbe8b
	Checksum: 0x915D2F04
	Offset: 0x860
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
private function function_9ede386f(slot)
{
	wait(0.1);
	self gadgetpowerset(slot, 0);
	self function_19ed70ca(slot, 1);
}

/*
	Name: registerclientfields
	Namespace: namespace_8fdcbe8b
	Checksum: 0xE6168F97
	Offset: 0x8B8
	Size: 0x40C
	Parameters: 0
	Flags: Private
*/
private function registerclientfields()
{
	if(isdefined(level.var_a9f35be1))
	{
		var_2b5b08bd = int(ceil(function_53f6489c(level.var_a9f35be1.size + 1)));
		var_ff35ecd8 = getgametypesetting(#"bountybagomoneymoney");
		var_19302641 = getgametypesetting(#"hash_63f8d60d122e755b");
		if(var_19302641 > 0)
		{
			var_bfbe32b4 = int(ceil(function_53f6489c(var_ff35ecd8 / var_19302641)));
			clientfield::register("toplayer", "bountyBagMoney", 1, var_bfbe32b4, "int");
		}
		else
		{
			clientfield::register("toplayer", "bountyBagMoney", 1, 1, "int");
		}
		clientfield::register("toplayer", "bountyMoney", 1, 14, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primary", 1, var_2b5b08bd, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondary", 1, var_2b5b08bd, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.armor", 1, var_2b5b08bd, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.reconTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.assaultTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.supportTrack.tierPurchased", 1, 2, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.scorestreak", 1, var_2b5b08bd, "int");
		clientfield::register("clientuimodel", "luielement.BountyHunterLoadout.equipment", 1, var_2b5b08bd, "int");
		clientfield::register("worlduimodel", "BountyHunterLoadout.timeRemaining", 1, 5, "int");
		clientfield::register("clientuimodel", "hudItems.BountyCarryingBag", 1, 1, "int");
	}
}

/*
	Name: onconnect
	Namespace: namespace_8fdcbe8b
	Checksum: 0x33A2D796
	Offset: 0xCD0
	Size: 0x1A8
	Parameters: 0
	Flags: Private
*/
private function onconnect()
{
	if(!isdefined(self.pers[#"hash_50251e63e4a703b5"]))
	{
		self.pers[#"hash_50251e63e4a703b5"] = spawnstruct();
		self.pers[#"hash_50251e63e4a703b5"].weapons = [];
		self.pers[#"hash_50251e63e4a703b5"].talents = [];
		self.pers[#"hash_50251e63e4a703b5"].armor = undefined;
		self.pers[#"hash_50251e63e4a703b5"].scorestreak = undefined;
		self.pers[#"hash_50251e63e4a703b5"].clientfields = [];
	}
	self function_c6de6bdd();
	foreach(var_387a4eaf in self.pers[#"hash_50251e63e4a703b5"].clientfields)
	{
		self clientfield::set_player_uimodel(var_387a4eaf.clientfield, var_387a4eaf.val);
	}
}

/*
	Name: function_485e3421
	Namespace: namespace_8fdcbe8b
	Checksum: 0xC017A4A1
	Offset: 0xE80
	Size: 0xA4
	Parameters: 0
	Flags: Private
*/
private function function_485e3421()
{
	if(isdefined(self.pers[#"hash_50251e63e4a703b5"].armor))
	{
		self function_51a2c3b3(self.pers[#"hash_50251e63e4a703b5"].armor);
		self function_2b71fd3(self.pers[#"hash_50251e63e4a703b5"].armor);
	}
	self function_22096d8e();
}

/*
	Name: function_22096d8e
	Namespace: namespace_8fdcbe8b
	Checksum: 0xE71BD587
	Offset: 0xF30
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_22096d8e()
{
	self.pers[#"hash_50251e63e4a703b5"].armor = undefined;
	self function_ff8ef46b(5, "luielement.BountyHunterLoadout.armor", 0);
}

/*
	Name: function_c6de6bdd
	Namespace: namespace_8fdcbe8b
	Checksum: 0x1A13E7FE
	Offset: 0xF88
	Size: 0x54
	Parameters: 0
	Flags: Private
*/
private function function_c6de6bdd()
{
	self menus::register_menu_response_callback("BountyHunterBuy", &function_40eb02fc);
	self menus::register_menu_response_callback("BountyHunterPackageSelect", &function_40eb02fc);
}

/*
	Name: function_40eb02fc
	Namespace: namespace_8fdcbe8b
	Checksum: 0xC57D2BC1
	Offset: 0xFE8
	Size: 0x58C
	Parameters: 2
	Flags: Private
*/
private function function_40eb02fc(response, intpayload)
{
	if(!isdefined(intpayload))
	{
		return;
	}
	clientfield = undefined;
	slot = undefined;
	isammo = 0;
	var_e120a933 = undefined;
	var_eb3ffe17 = 0;
	if(response == "undo_last_purchase")
	{
		return;
	}
	package = struct::get_script_bundle("bountyhunterpackage", level.var_a9f35be1[intpayload - 1]);
	switch(response)
	{
		case "hash_28554ae159269915":
		{
			clientfield = "luielement.BountyHunterLoadout.primary";
			slot = 0;
			break;
		}
		case "hash_c785a629253dcd5":
		{
			clientfield = "luielement.BountyHunterLoadout.secondary";
			slot = 1;
			break;
		}
		case "hash_390a1acd2edcd5b7":
		{
			var_e120a933 = 1;
			clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
			slot = 11;
			break;
		}
		case "hash_390a1bcd2edcd76a":
		{
			var_e120a933 = 2;
			clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
			slot = 11;
			break;
		}
		case "hash_390a1ccd2edcd91d":
		{
			var_e120a933 = 3;
			clientfield = "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased";
			slot = 11;
			break;
		}
		case "hash_2acbda1102e614f7":
		{
			var_e120a933 = 1;
			clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
			slot = 12;
			break;
		}
		case "hash_2acbdb1102e616aa":
		{
			var_e120a933 = 2;
			clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
			slot = 12;
			break;
		}
		case "hash_2acbdc1102e6185d":
		{
			var_e120a933 = 3;
			clientfield = "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased";
			slot = 12;
			break;
		}
		case "hash_7760a837c6f81098":
		{
			clientfield = "luielement.BountyHunterLoadout.armor";
			slot = 5;
			break;
		}
		case "hash_46637ad5c1dd8390":
		{
			clientfield = "luielement.BountyHunterLoadout.mobilityTrack.tierPurchased";
			slot = 6;
			break;
		}
		case "hash_603babb2a7c35420":
		{
			clientfield = "luielement.BountyHunterLoadout.reconTrack.tierPurchased";
			slot = 7;
			break;
		}
		case "hash_5792934483949728":
		{
			clientfield = "luielement.BountyHunterLoadout.assaultTrack.tierPurchased";
			slot = 8;
			break;
		}
		case "hash_265c0500ba88a4a4":
		{
			clientfield = "luielement.BountyHunterLoadout.supportTrack.tierPurchased";
			slot = 9;
			break;
		}
		case "hash_7b3685fb5a146b83":
		{
			isammo = 1;
			if(function_2b402d5d(package))
			{
				slot = 100;
			}
			else
			{
				slot = 101;
			}
			break;
		}
		case "hash_6e8d37dc2b55eb07":
		{
			var_eb3ffe17 = 1;
			clientfield = "luielement.BountyHunterLoadout.scorestreak";
			slot = 10;
			break;
		}
		case "hash_45dc798feb538f7b":
		{
			clientfield = "luielement.BountyHunterLoadout.equipment";
			slot = 2;
			break;
		}
	}
	if(!self function_5b8256ca(package, isammo, var_e120a933, var_eb3ffe17))
	{
		return;
	}
	if(slot < 4)
	{
		self function_a3d739c6(slot, package);
	}
	else if(slot == 5)
	{
		self function_e6fa90be(package);
	}
	else if(slot <= 9)
	{
		self function_14e4d700(slot, package);
		intpayload = package.var_220eaf2;
	}
	else if(slot == 10)
	{
		self function_1875e2a9(package);
	}
	else if(slot <= 12)
	{
		self function_7a836986(slot - 11, package, var_e120a933);
		intpayload = var_e120a933;
	}
	else if(slot <= 101)
	{
		self addammo(slot - 100, package);
	}
	if(isdefined(clientfield))
	{
		self function_ff8ef46b(slot, clientfield, intpayload);
		if(clientfield == "luielement.BountyHunterLoadout.primary")
		{
			self function_ff8ef46b(11, "luielement.BountyHunterLoadout.primaryAttachmentTrack.tierPurchased", 0);
		}
		else if(clientfield == "luielement.BountyHunterLoadout.secondary")
		{
			self function_ff8ef46b(12, "luielement.BountyHunterLoadout.secondaryAttachmentTrack.tierPurchased", 0);
		}
	}
	self function_738575c4(1, 0);
}

/*
	Name: function_5b8256ca
	Namespace: namespace_8fdcbe8b
	Checksum: 0x448E9E4C
	Offset: 0x1580
	Size: 0x222
	Parameters: 4
	Flags: Private
*/
private function function_5b8256ca(package, isammo = 0, var_e120a933 = undefined, var_eb3ffe17 = 0)
{
	money = self.pers[#"money"];
	registerend_prestige_imp = (var_eb3ffe17 ? 1 : (isdefined(getgametypesetting(#"hash_1b34b26470f4368")) ? getgametypesetting(#"hash_1b34b26470f4368") : 1));
	cost = package.purchasecost * registerend_prestige_imp;
	if(isdefined(isammo) && isammo)
	{
		cost = package.var_847b7691 * (isdefined(getgametypesetting(#"hash_71b2b43696e16252")) ? getgametypesetting(#"hash_71b2b43696e16252") : 1);
	}
	else if(isdefined(var_e120a933))
	{
		cost = (package.var_95c30fc5[var_e120a933 - 1].purchasecost) * registerend_prestige_imp;
	}
	cost = int(cost);
	if(!isdefined(cost))
	{
		return 0;
	}
	if(money < cost)
	{
		return 0;
	}
	money = money - cost;
	self clientfield::set_to_player("bountyMoney", money);
	self.pers[#"money"] = money;
	return 1;
}

/*
	Name: function_a3d739c6
	Namespace: namespace_8fdcbe8b
	Checksum: 0xF61B4F76
	Offset: 0x17B0
	Size: 0x126
	Parameters: 2
	Flags: Private
*/
private function function_a3d739c6(slot, package)
{
	self.pers[#"hash_50251e63e4a703b5"].weapons[slot] = spawnstruct();
	self.pers[#"hash_50251e63e4a703b5"].weapons[slot].name = package.var_60f86f10[0].item;
	self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments = [];
	self.pers[#"hash_50251e63e4a703b5"].weapons[slot].ammo = -1;
	self.pers[#"hash_50251e63e4a703b5"].weapons[slot].startammo = package.startammo;
}

/*
	Name: function_e6fa90be
	Namespace: namespace_8fdcbe8b
	Checksum: 0x4314BF0
	Offset: 0x18E0
	Size: 0x1DA
	Parameters: 1
	Flags: Private
*/
private function function_e6fa90be(package)
{
	self.pers[#"hash_50251e63e4a703b5"].armor = {};
	self.pers[#"hash_50251e63e4a703b5"].armor.name = package.var_60f86f10[0].item;
	self.pers[#"hash_50251e63e4a703b5"].armor.armor = package.armor;
	self.pers[#"hash_50251e63e4a703b5"].armor.var_782dbf79 = (isdefined(package.var_782dbf79) ? package.var_782dbf79 : 0);
	self.pers[#"hash_50251e63e4a703b5"].armor.var_767b7337 = (isdefined(package.var_767b7337) ? package.var_767b7337 : 0);
	self.pers[#"hash_50251e63e4a703b5"].armor.var_741010b5 = (isdefined(package.var_741010b5) ? package.var_741010b5 : 0);
	self.pers[#"hash_50251e63e4a703b5"].armor.var_673a16ad = (isdefined(package.var_673a16ad) ? package.var_673a16ad : 0);
}

/*
	Name: function_14e4d700
	Namespace: namespace_8fdcbe8b
	Checksum: 0x69190035
	Offset: 0x1AC8
	Size: 0x19E
	Parameters: 2
	Flags: Private
*/
private function function_14e4d700(slot, package)
{
	foreach(talent in package.var_60f86f10)
	{
		if(!isdefined(self.pers[#"hash_50251e63e4a703b5"].talents))
		{
			self.pers[#"hash_50251e63e4a703b5"].talents = [];
		}
		else if(!isarray(self.pers[#"hash_50251e63e4a703b5"].talents))
		{
			self.pers[#"hash_50251e63e4a703b5"].talents = array(self.pers[#"hash_50251e63e4a703b5"].talents);
		}
		self.pers[#"hash_50251e63e4a703b5"].talents[self.pers[#"hash_50251e63e4a703b5"].talents.size] = talent.item;
	}
}

/*
	Name: function_ff8ef46b
	Namespace: namespace_8fdcbe8b
	Checksum: 0x5993A01E
	Offset: 0x1C70
	Size: 0xF6
	Parameters: 3
	Flags: None
*/
function function_ff8ef46b(slot, clientfield, newval)
{
	self clientfield::set_player_uimodel(clientfield, newval);
	if(!isdefined(self.pers[#"hash_50251e63e4a703b5"].clientfields[slot]))
	{
		self.pers[#"hash_50251e63e4a703b5"].clientfields[slot] = spawnstruct();
		self.pers[#"hash_50251e63e4a703b5"].clientfields[slot].clientfield = clientfield;
	}
	self.pers[#"hash_50251e63e4a703b5"].clientfields[slot].val = newval;
}

/*
	Name: function_2b402d5d
	Namespace: namespace_8fdcbe8b
	Checksum: 0x21820A82
	Offset: 0x1D70
	Size: 0x84
	Parameters: 1
	Flags: Private
*/
private function function_2b402d5d(package)
{
	primary = self.pers[#"hash_50251e63e4a703b5"].weapons[0];
	if(!isdefined(primary))
	{
		return 0;
	}
	if(!isdefined(primary.name))
	{
		return 0;
	}
	if(primary.name == package.var_60f86f10[0].item)
	{
		return 1;
	}
	return 0;
}

/*
	Name: addammo
	Namespace: namespace_8fdcbe8b
	Checksum: 0x4F0F7838
	Offset: 0x1E00
	Size: 0x136
	Parameters: 2
	Flags: Private
*/
private function addammo(slot, package)
{
	if(isdefined(package.refillammo) && package.refillammo > 0)
	{
		self.pers[#"hash_50251e63e4a703b5"].weapons[slot].ammo = package.refillammo;
	}
	else
	{
		var_5eb7db94 = self.pers[#"hash_50251e63e4a703b5"].weapons[slot];
		weapon = getweapon(var_5eb7db94.name, var_5eb7db94.attachments);
		if(!isdefined(weapon.clipsize) || weapon.clipsize <= 0)
		{
			var_5eb7db94.ammo = 1;
		}
		else
		{
			var_5eb7db94.ammo = (weapon.maxammo / weapon.clipsize) + 1;
		}
	}
}

/*
	Name: function_1875e2a9
	Namespace: namespace_8fdcbe8b
	Checksum: 0x89B5B11
	Offset: 0x1F40
	Size: 0x46
	Parameters: 1
	Flags: Private
*/
private function function_1875e2a9(package)
{
	self.pers[#"hash_50251e63e4a703b5"].scorestreak = package.var_60f86f10[0].item;
}

/*
	Name: function_7a836986
	Namespace: namespace_8fdcbe8b
	Checksum: 0xD13EF69F
	Offset: 0x1F90
	Size: 0x26E
	Parameters: 3
	Flags: Private
*/
private function function_7a836986(slot, package, var_e120a933)
{
	var_51cc2fc9 = package.var_95c30fc5[var_e120a933 - 1].attachmentlist;
	var_db6dac44 = strtok(var_51cc2fc9, "+");
	foreach(attach in var_db6dac44)
	{
		if(!isdefined(self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments))
		{
			self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments = [];
		}
		else if(!isarray(self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments))
		{
			self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments = array(self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments);
		}
		if(!isinarray(self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments, attach))
		{
			self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments[self.pers[#"hash_50251e63e4a703b5"].weapons[slot].attachments.size] = attach;
		}
	}
}

/*
	Name: function_738575c4
	Namespace: namespace_8fdcbe8b
	Checksum: 0x597C3DD3
	Offset: 0x2208
	Size: 0x1D4
	Parameters: 2
	Flags: Private
*/
private function function_738575c4(takeoldweapon, var_86bf0b36 = 1)
{
	self loadout::init_player(1);
	weapons = self getweaponslist();
	foreach(weapon in weapons)
	{
		self takeweapon(weapon);
	}
	killstreaks::function_2ea0382e();
	self function_f14e5ee3();
	self function_422164cd();
	self function_6a829089();
	if(var_86bf0b36)
	{
		self function_8d5ede64();
	}
	self function_d2f0197a();
	current_weapon = self getcurrentweapon();
	self thread loadout::initweaponattachments(current_weapon);
	self thread pickup_health::function_3fbb0e22();
	self setactionslot(3, "flourish_callouts");
}

/*
	Name: function_d2f0197a
	Namespace: namespace_8fdcbe8b
	Checksum: 0xD3333AEB
	Offset: 0x23E8
	Size: 0x104
	Parameters: 0
	Flags: Private
*/
private function function_d2f0197a()
{
	if(isdefined(self.pers[#"hash_50251e63e4a703b5"].armor))
	{
		self function_b5feff95(#"hash_6be738527a4213aa");
		armor = self.pers[#"hash_50251e63e4a703b5"].armor;
		self function_52630bb(armor);
		self armor::set_armor(armor.armor, armor.armor, 0, armor.var_767b7337, armor.var_782dbf79, armor.var_673a16ad, armor.var_741010b5, 1, 1, 1);
	}
}

/*
	Name: function_659633d8
	Namespace: namespace_8fdcbe8b
	Checksum: 0x5192167F
	Offset: 0x24F8
	Size: 0x82
	Parameters: 1
	Flags: Private
*/
private function function_659633d8(var_31e314e8)
{
	switch(var_31e314e8.name)
	{
		case "hash_16cfc7f70dbd8712":
		{
			return #"specialty_armor_tier_two";
		}
		case "hash_39045b0020cc3e00":
		{
			return #"specialty_armor_tier_three";
		}
		default:
		{
			return #"specialty_armor";
		}
	}
}

/*
	Name: function_51a2c3b3
	Namespace: namespace_8fdcbe8b
	Checksum: 0x83D1A519
	Offset: 0x2588
	Size: 0xDA
	Parameters: 1
	Flags: Private
*/
private function function_51a2c3b3(var_31e314e8)
{
	if(!isdefined(var_31e314e8))
	{
		return;
	}
	switch(var_31e314e8.name)
	{
		case "hash_16cfc7f70dbd8712":
		{
			playfxontag(#"hash_56c8182de62c1c6", self, "j_spineupper");
		}
		case "hash_39045b0020cc3e00":
		{
			playfxontag(#"hash_3c6a01bd4394d4f3", self, "j_spineupper");
		}
		default:
		{
			playfxontag(#"hash_4a955131370a3720", self, "j_spineupper");
		}
	}
}

/*
	Name: function_52630bb
	Namespace: namespace_8fdcbe8b
	Checksum: 0x2E21DAC
	Offset: 0x2670
	Size: 0x44
	Parameters: 1
	Flags: Private
*/
private function function_52630bb(var_31e314e8)
{
	var_f740a469 = function_659633d8(var_31e314e8);
	self setperk(var_f740a469);
}

/*
	Name: function_2b71fd3
	Namespace: namespace_8fdcbe8b
	Checksum: 0xBD644381
	Offset: 0x26C0
	Size: 0x44
	Parameters: 1
	Flags: Private
*/
private function function_2b71fd3(var_31e314e8)
{
	var_f740a469 = function_659633d8(var_31e314e8);
	self unsetperk(var_f740a469);
}

/*
	Name: function_f14e5ee3
	Namespace: namespace_8fdcbe8b
	Checksum: 0xA5BD70DB
	Offset: 0x2710
	Size: 0x424
	Parameters: 0
	Flags: Private
*/
private function function_f14e5ee3()
{
	var_7d27f2d6 = self.pers[#"hash_50251e63e4a703b5"].weapons[0];
	if(isdefined(var_7d27f2d6))
	{
		primary = getweapon(var_7d27f2d6.name, var_7d27f2d6.attachments);
		self giveweapon(primary);
		self function_c1932ad3(primary, var_7d27f2d6);
		self switchtoweapon(primary, 1);
		self loadout::function_442539("primary", primary);
		self setspawnweapon(primary);
	}
	else
	{
		var_43d69af6 = function_898839b4();
		self giveweapon(var_43d69af6);
		self setweaponammoclip(var_43d69af6, 0);
		self loadout::function_442539("primary", var_43d69af6);
	}
	var_23218f5e = self.pers[#"hash_50251e63e4a703b5"].weapons[1];
	if(isdefined(var_23218f5e))
	{
		secondary = getweapon(var_23218f5e.name, var_23218f5e.attachments);
		self giveweapon(secondary);
		self function_c1932ad3(secondary, var_23218f5e);
		self loadout::function_442539("secondary", secondary);
		if(!isdefined(var_7d27f2d6))
		{
			self switchtoweapon(secondary, 1);
			self setspawnweapon(secondary);
		}
	}
	else
	{
		var_b5867a38 = getweapon(#"none");
		self giveweapon(var_b5867a38);
		self setweaponammoclip(var_b5867a38, 0);
		self loadout::function_442539("secondary", var_b5867a38);
	}
	var_c27e9e89 = self.pers[#"hash_50251e63e4a703b5"].weapons[2];
	if(isdefined(var_c27e9e89))
	{
		equipment = getweapon(var_c27e9e89.name);
		self giveweapon(equipment);
		self setweaponammoclip(equipment, var_c27e9e89.ammo);
		slot = self gadgetgetslot(equipment);
		self gadgetpowerset(slot, equipment.gadget_powermax);
	}
	else
	{
		var_30b5b5af = getweapon(#"null_offhand_primary");
		self giveweapon(var_30b5b5af);
		self loadout::function_442539("primarygrenade", var_30b5b5af);
	}
	self seteverhadweaponall(1);
}

/*
	Name: function_898839b4
	Namespace: namespace_8fdcbe8b
	Checksum: 0xE77DF24B
	Offset: 0x2B40
	Size: 0xEA
	Parameters: 0
	Flags: Private
*/
private function function_898839b4()
{
	var_81b9af1a = self.pers[#"hash_50251e63e4a703b5"].talents;
	foreach(item in var_81b9af1a)
	{
		if(item == #"hash_7932008294f0d876")
		{
			return getweapon(#"hash_7932008294f0d876");
		}
	}
	return getweapon(#"hash_1773b576c62a506");
}

/*
	Name: function_c1932ad3
	Namespace: namespace_8fdcbe8b
	Checksum: 0xE9D4CAD2
	Offset: 0x2C38
	Size: 0x104
	Parameters: 2
	Flags: Private
*/
private function function_c1932ad3(weap, data)
{
	if(data.ammo > 0)
	{
		self setweaponammostock(weap, (int(data.ammo * weap.clipsize)) - weap.clipsize);
	}
	else
	{
		self setweaponammostock(weap, (int(data.startammo * weap.clipsize)) - weap.clipsize);
	}
	if(self getweaponammoclip(weap) <= 0)
	{
		self setweaponammostock(weap, weap.clipsize);
	}
}

/*
	Name: function_6a829089
	Namespace: namespace_8fdcbe8b
	Checksum: 0x6BE68CEC
	Offset: 0x2D48
	Size: 0xA4
	Parameters: 0
	Flags: Private
*/
private function function_6a829089()
{
	var_2b15e2fe = getweapon(#"hash_76d1218de27081f6");
	if(isdefined(self.var_c7e6d7c7) && self.var_c7e6d7c7)
	{
		var_2b15e2fe = getweapon(#"gadget_medicalinjectiongun");
	}
	self giveweapon(var_2b15e2fe);
	self loadout::function_442539("specialgrenade", var_2b15e2fe);
}

/*
	Name: function_422164cd
	Namespace: namespace_8fdcbe8b
	Checksum: 0xE47923CF
	Offset: 0x2DF8
	Size: 0x1B4
	Parameters: 0
	Flags: Private
*/
private function function_422164cd()
{
	self function_e6f9e3cd();
	self clearperks();
	foreach(talent in self.pers[#"hash_50251e63e4a703b5"].talents)
	{
		if(talent == #"hash_7932008294f0d876")
		{
			continue;
		}
		self function_b5feff95(talent + level.game_mode_suffix);
		if(talent == #"gear_medicalinjectiongun")
		{
			self.var_c7e6d7c7 = 1;
		}
	}
	perks = self getloadoutperks(0);
	foreach(perk in perks)
	{
		self setperk(perk);
	}
	self thread perks::monitorgpsjammer();
}

/*
	Name: function_8d5ede64
	Namespace: namespace_8fdcbe8b
	Checksum: 0x6177C290
	Offset: 0x2FB8
	Size: 0x5C
	Parameters: 0
	Flags: Private
*/
private function function_8d5ede64()
{
	if(isdefined(self.pers[#"hash_50251e63e4a703b5"].scorestreak))
	{
		self killstreaks::give(self.pers[#"hash_50251e63e4a703b5"].scorestreak);
	}
}

/*
	Name: function_cea5cbc5
	Namespace: namespace_8fdcbe8b
	Checksum: 0x28DC6928
	Offset: 0x3020
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_cea5cbc5()
{
	scorestreak = self.pers[#"hash_50251e63e4a703b5"].scorestreak;
	if(isdefined(scorestreak) && (!self killstreaks::has_killstreak(scorestreak) || (isdefined(self.var_a8c5fe4e) && self.var_a8c5fe4e)))
	{
		self.pers[#"hash_50251e63e4a703b5"].scorestreak = undefined;
		self function_ff8ef46b(10, "luielement.BountyHunterLoadout.scorestreak", 0);
	}
}

