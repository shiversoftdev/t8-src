// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_inventory.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace zm_ui_inventory;

/*
	Name: __init__system__
	Namespace: zm_ui_inventory
	Checksum: 0xB64764D9
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ui_inventory", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ui_inventory
	Checksum: 0x1EA63BF7
	Offset: 0x138
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connecting(&onconnect);
	clientfield::register_bgcache("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, 1);
	zm_inventory::function_c7c05a13();
	registeredfields = [];
	foreach(mapping in level.var_a16c38d9)
	{
		if(!isdefined(registeredfields[mapping.var_cd35dfb2]))
		{
			registeredfields[mapping.var_cd35dfb2] = 1;
			var_9cf9ba9 = "worlduimodel";
			if(isdefined(mapping.var_7f12f171))
			{
				var_9cf9ba9 = "clientuimodel";
			}
			clientfield::register(var_9cf9ba9, mapping.var_cd35dfb2, 1, mapping.numbits, "int");
		}
	}
}

/*
	Name: onconnect
	Namespace: zm_ui_inventory
	Checksum: 0x117C19A9
	Offset: 0x2A8
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private onconnect()
{
	self thread function_13ad9a60();
}

/*
	Name: function_13ad9a60
	Namespace: zm_ui_inventory
	Checksum: 0x121D6F49
	Offset: 0x2D0
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
function private function_13ad9a60()
{
	self endon(#"disconnect");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"menuresponse");
		response = waitresult.response;
		if(response == "zm_inventory_opened")
		{
			self notify(#"zm_inventory_menu_opened");
		}
	}
}

/*
	Name: function_7df6bb60
	Namespace: zm_ui_inventory
	Checksum: 0x22B9A766
	Offset: 0x360
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function function_7df6bb60(fieldname, value, player)
{
	var_d5423fb8 = level.var_a16c38d9[fieldname];
	if(!(isdefined(var_d5423fb8) && (isdefined(var_d5423fb8.var_7f12f171) && var_d5423fb8.var_7f12f171)))
	{
		self clientfield::set_world_uimodel(var_d5423fb8.var_cd35dfb2, value);
	}
	else
	{
		/#
			assert(isplayer(player));
		#/
		if(!isdefined(player))
		{
			return;
		}
		player clientfield::set_player_uimodel(var_d5423fb8.var_cd35dfb2, value);
	}
}

/*
	Name: function_d8f1d200
	Namespace: zm_ui_inventory
	Checksum: 0xC0A32493
	Offset: 0x450
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d8f1d200(var_ee9637ec)
{
	self clientfield::set_player_uimodel("hudItems.zmFeatureDescription", var_ee9637ec);
}

