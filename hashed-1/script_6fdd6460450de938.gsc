// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\infection.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace infection;

/*
	Name: function_89f2df9
	Namespace: infection
	Checksum: 0x4234027A
	Offset: 0xF0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_31f83f7a18d98ab2", &__init__, undefined, #"infection");
}

/*
	Name: __init__
	Namespace: infection
	Checksum: 0xCE12B6B1
	Offset: 0x140
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	if(!function_74650d7())
	{
		return;
	}
	clientfield::register("toplayer", "infected", 21000, 1, "int", &function_a564e332, 0, 0);
	callback::on_localclient_connect(&on_localclient_connect);
	level._effect[#"rise_burst"] = #"zombie/fx_spawn_dirt_hand_burst_zmb";
	level._effect[#"rise_billow"] = #"zombie/fx_spawn_dirt_body_billowing_zmb";
}

/*
	Name: on_localclient_connect
	Namespace: infection
	Checksum: 0xEF6275D9
	Offset: 0x228
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	if(util::function_5df4294() == "warzone_pandemic_quad")
	{
		level thread function_667d34b7(localclientnum);
	}
}

/*
	Name: function_667d34b7
	Namespace: infection
	Checksum: 0x3A1F3B86
	Offset: 0x278
	Size: 0xFE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_667d34b7(localclientnum)
{
	var_d5823792 = 0;
	while(true)
	{
		local_player = function_5c10bd79(localclientnum);
		if(isdefined(local_player))
		{
			infected = local_player clientfield::get_to_player("infected");
			if(infected === 1 && !var_d5823792)
			{
				var_d5823792 = 1;
				function_a837926b(localclientnum, #"hash_29b452119475ca86");
			}
			else if(infected === 0 && var_d5823792)
			{
				var_d5823792 = 0;
				function_24cd4cfb(localclientnum, #"hash_29b452119475ca86");
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_a564e332
	Namespace: infection
	Checksum: 0xC5CD0F77
	Offset: 0x380
	Size: 0x114
	Parameters: 7
	Flags: Linked, Private
*/
private function function_a564e332(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_325e85a2(localclientnum);
		playsound(0, #"zmb_zombie_spawn", self.origin);
		burst_fx = level._effect[#"rise_burst"];
		billow_fx = level._effect[#"rise_billow"];
		self thread rise_dust_fx(localclientnum, billow_fx, burst_fx);
	}
	else
	{
		self notify(#"hash_4f90e54d76985430");
		self thread function_e5f3924e(localclientnum);
	}
}

/*
	Name: function_e5f3924e
	Namespace: infection
	Checksum: 0xA9C02EA6
	Offset: 0x4A0
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e5f3924e(localclientnum)
{
	players = getplayers(localclientnum);
	foreach(player in players)
	{
		player function_5d482e78("rob_wz_zombievision");
	}
}

/*
	Name: function_325e85a2
	Namespace: infection
	Checksum: 0x25F58A0C
	Offset: 0x550
	Size: 0x1BC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_325e85a2(localclientnum)
{
	self endon(#"hash_4f90e54d76985430");
	while(true)
	{
		players = getplayers(localclientnum);
		foreach(player in players)
		{
			corpse = player getplayercorpse();
			if(isdefined(corpse) && iscorpse(corpse) && corpse function_d2503806("rob_wz_zombievision"))
			{
				corpse function_5d482e78("rob_wz_zombievision");
			}
			if(!isalive(player) || player function_83973173())
			{
				if(player function_d2503806("rob_wz_zombievision"))
				{
					player function_5d482e78("rob_wz_zombievision");
				}
				continue;
			}
			player function_bf9d3071("rob_wz_zombievision");
		}
		wait(0.25);
	}
}

/*
	Name: rise_dust_fx
	Namespace: infection
	Checksum: 0x301F253E
	Offset: 0x718
	Size: 0x10C
	Parameters: 3
	Flags: Linked
*/
function rise_dust_fx(clientnum, billow_fx, burst_fx)
{
	self endon(#"death");
	dust_tag = "J_SpineUpper";
	if(isdefined(burst_fx))
	{
		playfx(clientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
	}
	wait(0.25);
	if(isdefined(billow_fx))
	{
		playfx(clientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
	}
}

