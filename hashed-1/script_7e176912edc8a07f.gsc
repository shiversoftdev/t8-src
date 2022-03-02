// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;

#namespace namespace_5b53bc56;

/*
	Name: function_89f2df9
	Namespace: namespace_5b53bc56
	Checksum: 0x976DEC1D
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6450253dfc9fec43", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_5b53bc56
	Checksum: 0x132EB3F5
	Offset: 0x160
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level thread function_3d4e24ea();
	level flag::init("start_exploder");
	level flag::init("stop_exploder");
	level thread function_2bdf9f35();
}

/*
	Name: function_2bdf9f35
	Namespace: namespace_5b53bc56
	Checksum: 0xC93828D
	Offset: 0x1E0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_2bdf9f35()
{
	level thread function_c51c8e3("start_exploder");
}

/*
	Name: function_3d4e24ea
	Namespace: namespace_5b53bc56
	Checksum: 0x78EC8B89
	Offset: 0x210
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_3d4e24ea()
{
	level._effect[#"hash_5ee980374efab771"] = #"hash_964810cc067cb78";
}

/*
	Name: function_c51c8e3
	Namespace: namespace_5b53bc56
	Checksum: 0xDFCC6880
	Offset: 0x250
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_c51c8e3(var_edf4d25)
{
	self flag::wait_till(var_edf4d25);
	if(var_edf4d25 == "start_exploder")
	{
		function_b6657c42();
		var_27a8909d = "stop_exploder";
	}
	else if(var_edf4d25 == "stop_exploder")
	{
		function_40dfe103();
		var_27a8909d = "start_exploder";
	}
	self flag::clear("start_exploder");
	self flag::clear("stop_exploder");
	self function_c51c8e3(var_27a8909d);
}

/*
	Name: function_b6657c42
	Namespace: namespace_5b53bc56
	Checksum: 0xCAB15698
	Offset: 0x338
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_b6657c42()
{
	iprintlnbold("Start Exploder!");
	exploder::exploder("exploder_test");
	exploder::exploder("fxexp_disco_lgt");
}

/*
	Name: function_40dfe103
	Namespace: namespace_5b53bc56
	Checksum: 0x83B42895
	Offset: 0x390
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_40dfe103()
{
	iprintlnbold("Stop Exploder!");
	exploder::stop_exploder("exploder_test");
	exploder::stop_exploder("fxexp_disco_lgt");
}

/*
	Name: function_829b14de
	Namespace: namespace_5b53bc56
	Checksum: 0xFA96BCBC
	Offset: 0x3E8
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function function_829b14de()
{
	while(true)
	{
		self movez(100, 5);
		wait(5);
		self movez(-100, 5);
		wait(5);
	}
}

