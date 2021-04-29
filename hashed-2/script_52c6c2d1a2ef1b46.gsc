// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1a82674d68f69c23;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_6747c550;

/*
	Name: function_89f2df9
	Namespace: namespace_6747c550
	Checksum: 0xB64764D9
	Offset: 0xF0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_23b05089013ba630", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_6747c550
	Checksum: 0x1EA63BF7
	Offset: 0x138
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connecting(&onconnect);
	clientfield::function_78175813("clientuimodel", "string", "hudItems.zmFeatureDescription", 1, 1);
	namespace_a6669267::function_c7c05a13();
	var_b9b9b499 = [];
	foreach(mapping in level.var_a16c38d9)
	{
		if(!isdefined(var_b9b9b499[mapping.var_cd35dfb2]))
		{
			var_b9b9b499[mapping.var_cd35dfb2] = 1;
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
	Namespace: namespace_6747c550
	Checksum: 0x117C19A9
	Offset: 0x2A8
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function onconnect()
{
	self thread function_13ad9a60();
}

/*
	Name: function_13ad9a60
	Namespace: namespace_6747c550
	Checksum: 0x121D6F49
	Offset: 0x2D0
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
private function function_13ad9a60()
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
	Namespace: namespace_6747c550
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
	Namespace: namespace_6747c550
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

