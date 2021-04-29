// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;

#namespace bb;

/*
	Name: init_shared
	Namespace: bb
	Checksum: 0xFB638F6B
	Offset: 0x70
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	callback::on_start_gametype(&init);
	callback::on_joined_team(&function_a061f5b);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: init
	Namespace: bb
	Checksum: 0x80F724D1
	Offset: 0xE0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: on_player_spawned
	Namespace: bb
	Checksum: 0xEACE06C7
	Offset: 0xF0
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self._bbdata = [];
	self._bbdata[#"score"] = 0;
	self._bbdata[#"momentum"] = 0;
	self._bbdata[#"spawntime"] = gettime();
	self._bbdata[#"shots"] = 0;
	self._bbdata[#"hits"] = 0;
}

/*
	Name: commit_weapon_data
	Namespace: bb
	Checksum: 0xC0F9C291
	Offset: 0x180
	Size: 0x236
	Parameters: 3
	Flags: Linked
*/
function commit_weapon_data(spawnid, currentweapon, time0)
{
	if(isbot(self))
	{
		return;
	}
	/#
		/#
			assert(isdefined(self._bbdata));
		#/
	#/
	if(!isdefined(self._bbdata))
	{
		return;
	}
	time1 = gettime();
	blackboxeventname = #"mpweapons";
	eventname = #"hash_41cc1afc10e99541";
	if(sessionmodeiscampaigngame())
	{
		blackboxeventname = #"cpweapons";
		eventname = #"hash_474292d3118817ab";
	}
	else if(sessionmodeiszombiesgame())
	{
		blackboxeventname = #"zmweapons";
		eventname = #"hash_67140d84a7660909";
	}
	else if(function_f99d2668())
	{
		blackboxeventname = #"hash_205db9f882d276a1";
		eventname = #"hash_63ec5305e1ef1335";
	}
	var_aba8a4d5 = {#hits:self._bbdata[#"hits"], #shots:self._bbdata[#"shots"], #duration:time1 - time0, #name:currentweapon.name, #spawnid:spawnid};
	function_92d1707f(eventname, blackboxeventname, var_aba8a4d5);
	self._bbdata[#"shots"] = 0;
	self._bbdata[#"hits"] = 0;
}

/*
	Name: add_to_stat
	Namespace: bb
	Checksum: 0x8D35305B
	Offset: 0x3C0
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function add_to_stat(statname, delta)
{
	if(isbot(self))
	{
		return;
	}
	if(isdefined(self._bbdata) && isdefined(self._bbdata[statname]))
	{
		self._bbdata[statname] = self._bbdata[statname] + delta;
	}
}

/*
	Name: function_a7ba460f
	Namespace: bb
	Checksum: 0x9C71DB45
	Offset: 0x440
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_a7ba460f(reason)
{
	function_92d1707f(#"hash_28b295eb3b8e189", {#reason:reason});
}

/*
	Name: function_afcc007d
	Namespace: bb
	Checksum: 0x4078B50B
	Offset: 0x490
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_afcc007d(name, clientnum, xuid)
{
	var_bd8c7087 = int(xuid);
	function_92d1707f(#"hash_3e5070f3289e386c", {#xuid:var_bd8c7087, #clientnum:clientnum, #name:name});
}

/*
	Name: function_e0dfa262
	Namespace: bb
	Checksum: 0x785D6C9B
	Offset: 0x530
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_e0dfa262(name, clientnum, xuid)
{
	var_bd8c7087 = int(xuid);
	function_92d1707f(#"hash_557aae9aaddeac22", {#xuid:var_bd8c7087, #clientnum:clientnum, #name:name});
}

/*
	Name: function_a061f5b
	Namespace: bb
	Checksum: 0xD37B290
	Offset: 0x5D0
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function function_a061f5b(params)
{
	if(!isdefined(self.team) || isdefined(self.startingteam))
	{
		return;
	}
	self.startingteam = self.team;
}

