// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a71af4de;

/*
	Name: init
	Namespace: namespace_a71af4de
	Checksum: 0xFD38C07E
	Offset: 0xD8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	if(!zm_utility::function_3bff983f())
	{
		level thread nuked_population_sign_think();
	}
}

/*
	Name: nuked_population_sign_think
	Namespace: namespace_a71af4de
	Checksum: 0x12D3DA4C
	Offset: 0x110
	Size: 0x348
	Parameters: 0
	Flags: Linked
*/
function nuked_population_sign_think()
{
	level flag::init(#"hash_35762ecd1ee8f3c1");
	level endon(#"end_game", #"hash_5aa1c9627e8626e0");
	var_50f6b3f4 = getent("counter_tens", "targetname");
	var_d02e9cd = getent("counter_ones", "targetname");
	n_step = 36;
	var_6e8a9999 = 0;
	var_71c11c96 = 0;
	var_aa6e55d3 = 0;
	var_50f6b3f4 rotateroll(n_step, 0.05);
	var_d02e9cd rotateroll(n_step, 0.05);
	level.population_count = 0;
	while(true)
	{
		if(var_aa6e55d3 < level.total_zombies_killed - level.zombie_total_subtract)
		{
			var_6e8a9999--;
			n_time = set_dvar_float_if_unset("scr_dial_rotate_time", "0.5");
			if(var_6e8a9999 < 0)
			{
				var_6e8a9999 = 9;
				var_50f6b3f4 rotateroll(0 - n_step, n_time);
				var_50f6b3f4 playsound("zmb_counter_flip");
				var_71c11c96--;
			}
			if(var_71c11c96 < 0)
			{
				var_71c11c96 = 9;
			}
			var_d02e9cd rotateroll(0 - n_step, n_time);
			var_d02e9cd playsound("zmb_counter_flip");
			var_d02e9cd waittill(#"rotatedone");
			level.population_count = var_6e8a9999 + var_71c11c96 * 10;
			if(level.population_count == 0 || level.population_count == 33 || level.population_count == 66 || level.population_count == 99)
			{
				level notify(#"update_doomsday_clock");
			}
			var_aa6e55d3++;
		}
		if(level.population_count == 15 || level.var_20cc3d90 === level.population_count)
		{
			level flag::set(#"hash_35762ecd1ee8f3c1");
		}
		else
		{
			level flag::clear(#"hash_35762ecd1ee8f3c1");
		}
		wait(0.05);
	}
}

/*
	Name: set_dvar_float_if_unset
	Namespace: namespace_a71af4de
	Checksum: 0x2CC14AEB
	Offset: 0x460
	Size: 0x82
	Parameters: 3
	Flags: Linked
*/
function set_dvar_float_if_unset(dvar, value, reset = 0)
{
	if(reset || getdvarstring(dvar) == "")
	{
		setdvar(dvar, value);
	}
	return getdvarfloat(dvar, 0);
}

/*
	Name: function_3134b684
	Namespace: namespace_a71af4de
	Checksum: 0x34DF3F52
	Offset: 0x4F0
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function function_3134b684()
{
	level.var_20cc3d90 = level.population_count;
	level flag::set(#"hash_35762ecd1ee8f3c1");
}

