// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_woods_fixup.gsc;
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_woods;

/*
	Name: __init__system__
	Namespace: character_unlock_woods
	Checksum: 0xB3670D4A
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_woods", &__init__, undefined, #"character_unlock_woods_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_woods
	Checksum: 0xA06EFE1B
	Offset: 0x108
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"woods_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_woods
	Checksum: 0x669B767
	Offset: 0x148
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"on_last_alive", &function_4ac25840);
		level.var_e1b226fb = 1;
		level thread function_6cba9a1a();
	}
}

/*
	Name: function_6cba9a1a
	Namespace: character_unlock_woods
	Checksum: 0x7D44386D
	Offset: 0x1F0
	Size: 0x1A8
	Parameters: 0
	Flags: Linked
*/
function function_6cba9a1a()
{
	item_world::function_4de3ca98();
	var_e32947b9 = function_91b29d2a(#"hash_18f7994e33f22f6d");
	if(!isdefined(var_e32947b9[0]))
	{
		return;
	}
	var_f93e4ee2 = 0;
	vehicles = getvehiclearray();
	foreach(vehicle in vehicles)
	{
		if(isairborne(vehicle))
		{
			if(distance2d(vehicle.origin, var_e32947b9[0].origin) < 800)
			{
				var_f93e4ee2 = 1;
				break;
			}
		}
	}
	if(!var_f93e4ee2)
	{
		foreach(item in var_e32947b9)
		{
			item_world::consume_item(item);
		}
	}
}

/*
	Name: function_ca9b286c
	Namespace: character_unlock_woods
	Checksum: 0x30BE582C
	Offset: 0x3A0
	Size: 0xD4
	Parameters: 1
	Flags: Event
*/
event function_ca9b286c(eventstruct)
{
	if(!(isdefined(level.var_e1b226fb) && level.var_e1b226fb))
	{
		return;
	}
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	seatindex = eventstruct.seat_index;
	if(isairborne(vehicle) && seatindex === 0 && character_unlock::function_f0406288(#"woods_unlock"))
	{
		self thread function_6a61388f(vehicle);
	}
}

/*
	Name: function_2aa4e6cf
	Namespace: character_unlock_woods
	Checksum: 0x231FEA23
	Offset: 0x480
	Size: 0xD4
	Parameters: 1
	Flags: Event
*/
event function_2aa4e6cf(eventstruct)
{
	if(!(isdefined(level.var_e1b226fb) && level.var_e1b226fb))
	{
		return;
	}
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	seatindex = eventstruct.seat_index;
	if(isairborne(vehicle) && seatindex === 0 && character_unlock::function_f0406288(#"woods_unlock"))
	{
		self thread function_6a61388f(vehicle);
	}
}

/*
	Name: function_6a61388f
	Namespace: character_unlock_woods
	Checksum: 0xAF17390E
	Offset: 0x560
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function function_6a61388f(vehicle)
{
	self notify("3609f878877561c6");
	self endon("3609f878877561c6");
	self endon(#"death", #"disconnect", #"exit_vehicle", #"change_seat");
	vehicle endon(#"death");
	if(!isdefined(self.var_1e8d9480))
	{
		self.var_1e8d9480 = 0;
	}
	while(true)
	{
		if(self.var_1e8d9480 >= 60 && self character_unlock::function_f0406288(#"woods_unlock"))
		{
			self character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4baf5ec553be7", 1);
			return;
		}
		self.var_1e8d9480 = self.var_1e8d9480 + 0.5;
		wait(0.5);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_woods
	Checksum: 0x9ADC1D09
	Offset: 0x6A8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(var_a6762160.name === #"cu22_item")
	{
		if(self character_unlock::function_f0406288(#"woods_unlock") && (self.deaths !== 0 || self.suicides !== 0))
		{
			self character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4bbf5ec553d9a", 2);
		}
	}
}

/*
	Name: function_4ac25840
	Namespace: character_unlock_woods
	Checksum: 0xB2F22D94
	Offset: 0x770
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_4ac25840(params)
{
	foreach(team in params.teams_alive)
	{
		players = getplayers(team);
		foreach(player in players)
		{
			if(isalive(player) && player character_unlock::function_f0406288(#"woods_unlock") && player.deaths === 0 && player.suicides === 0)
			{
				player character_unlock::function_c8beca5e(#"woods_unlock", #"hash_17a4bbf5ec553d9a", 1);
			}
		}
	}
}

