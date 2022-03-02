// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_88af4af0;

/*
	Name: function_89f2df9
	Namespace: namespace_88af4af0
	Checksum: 0x5C6B5B5A
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4445e928cf1b07c0", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_88af4af0
	Checksum: 0x76483871
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"no_sprint", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_88af4af0
	Checksum: 0x22315CBD
	Offset: 0x150
	Size: 0xE0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d1de6a85()
{
	callback::on_spawned(&function_dc856fd8);
	foreach(player in getplayers())
	{
		player allowsprint(0);
		player._allow_sprint = 0;
		player thread function_dc856fd8();
		player thread function_31f500f();
	}
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_88af4af0
	Checksum: 0xCBA2E833
	Offset: 0x238
	Size: 0xD0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9e7b3f4d(round_reset)
{
	callback::remove_on_spawned(&function_dc856fd8);
	foreach(player in getplayers())
	{
		player notify(#"allow_sprint");
		player._allow_sprint = undefined;
		player allowsprint(1);
	}
}

/*
	Name: function_dc856fd8
	Namespace: namespace_88af4af0
	Checksum: 0xB45ACB64
	Offset: 0x310
	Size: 0xC0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_dc856fd8()
{
	self notify("374b3a40e7866d07");
	self endon("374b3a40e7866d07");
	self endon(#"disconnect", #"allow_sprint");
	self allowsprint(0);
	while(true)
	{
		self waittill(#"hash_7fd32c9551894e64", #"hash_424834e6dee13bc3", #"bgb_update");
		if(isalive(self))
		{
			self allowsprint(0);
		}
	}
}

/*
	Name: function_31f500f
	Namespace: namespace_88af4af0
	Checksum: 0xB52101C0
	Offset: 0x3D8
	Size: 0xA2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_31f500f()
{
	self endon(#"disconnect", #"allow_sprint");
	while(true)
	{
		if(isalive(self) && self sprintbuttonpressed())
		{
			self namespace_b22c99a5::function_97444b02();
			while(self sprintbuttonpressed())
			{
				waitframe(1);
			}
		}
		waitframe(1);
	}
}

