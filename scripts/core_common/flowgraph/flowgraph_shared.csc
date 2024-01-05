// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flowgraph\flowgraph_core.csc;

#namespace flowgraph_logic;

/*
	Name: iffunc
	Namespace: flowgraph_logic
	Checksum: 0x2C342EDE
	Offset: 0x70
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function iffunc(x, b)
{
	return array(b, !b);
}

/*
	Name: orfunc
	Namespace: flowgraph_logic
	Checksum: 0xB4E595C3
	Offset: 0xA8
	Size: 0x4A
	Parameters: 3
	Flags: None
*/
function orfunc(x, b_a, b_b)
{
	return array(b_a || b_b, !(b_a || b_b));
}

/*
	Name: andfunc
	Namespace: flowgraph_logic
	Checksum: 0x8CB4CA75
	Offset: 0x100
	Size: 0x4A
	Parameters: 3
	Flags: None
*/
function andfunc(x, b_a, b_b)
{
	return array(b_a && b_b, !(b_a && b_b));
}

/*
	Name: notfunc
	Namespace: flowgraph_logic
	Checksum: 0xC340AD2D
	Offset: 0x158
	Size: 0x12
	Parameters: 1
	Flags: None
*/
function notfunc(b_value)
{
	return !b_value;
}

/*
	Name: lessthan
	Namespace: flowgraph_logic
	Checksum: 0x2B4CAAD2
	Offset: 0x178
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function lessthan(var_8b1a2ec6, var_d2073c9f)
{
	return var_8b1a2ec6 < var_d2073c9f;
}

/*
	Name: function_b457969e
	Namespace: flowgraph_logic
	Checksum: 0x3B1700EE
	Offset: 0x1A0
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function function_b457969e(var_8b1a2ec6, var_d2073c9f)
{
	return var_8b1a2ec6 <= var_d2073c9f;
}

/*
	Name: greaterthan
	Namespace: flowgraph_logic
	Checksum: 0x90703674
	Offset: 0x1C8
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function greaterthan(var_8b1a2ec6, var_d2073c9f)
{
	return var_8b1a2ec6 > var_d2073c9f;
}

/*
	Name: function_3743e19e
	Namespace: flowgraph_logic
	Checksum: 0xDB786BE8
	Offset: 0x1F0
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function function_3743e19e(var_8b1a2ec6, var_d2073c9f)
{
	return var_8b1a2ec6 >= var_d2073c9f;
}

/*
	Name: equal
	Namespace: flowgraph_logic
	Checksum: 0xFF19725A
	Offset: 0x218
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function equal(var_8b1a2ec6, var_d2073c9f)
{
	return var_8b1a2ec6 == var_d2073c9f;
}

/*
	Name: function_5cb6d7c8
	Namespace: flowgraph_logic
	Checksum: 0xBA4B6669
	Offset: 0x240
	Size: 0xA4
	Parameters: 3
	Flags: None
*/
function function_5cb6d7c8(x, b_1, b_2)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0), 1);
	}
	else if(isdefined(b_2) && b_2)
	{
		self flowgraph::kick(array(undefined, 0, 1), 1);
	}
}

/*
	Name: function_4902305f
	Namespace: flowgraph_logic
	Checksum: 0x913D2ECC
	Offset: 0x2F0
	Size: 0xFC
	Parameters: 4
	Flags: None
*/
function function_4902305f(x, b_1, b_2, b_3)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0), 1);
		}
		else if(isdefined(b_3) && b_3)
		{
			self flowgraph::kick(array(undefined, 0, 0, 1), 1);
		}
	}
}

/*
	Name: function_3b225c4
	Namespace: flowgraph_logic
	Checksum: 0x1A8510DB
	Offset: 0x3F8
	Size: 0x14C
	Parameters: 5
	Flags: None
*/
function function_3b225c4(x, b_1, b_2, b_3, b_4)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0, 0), 1);
		}
		else
		{
			if(isdefined(b_3) && b_3)
			{
				self flowgraph::kick(array(undefined, 0, 0, 1, 0), 1);
			}
			else if(isdefined(b_4) && b_4)
			{
				self flowgraph::kick(array(undefined, 0, 0, 0, 1), 1);
			}
		}
	}
}

/*
	Name: function_f82f0ebe
	Namespace: flowgraph_logic
	Checksum: 0x8DEEB39A
	Offset: 0x550
	Size: 0x1BC
	Parameters: 6
	Flags: None
*/
function function_f82f0ebe(x, b_1, b_2, b_3, b_4, b_5)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0), 1);
		}
		else
		{
			if(isdefined(b_3) && b_3)
			{
				self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0), 1);
			}
			else
			{
				if(isdefined(b_4) && b_4)
				{
					self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0), 1);
				}
				else if(isdefined(b_5) && b_5)
				{
					self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1), 1);
				}
			}
		}
	}
}

/*
	Name: function_3f431ce5
	Namespace: flowgraph_logic
	Checksum: 0xE3BEA50D
	Offset: 0x718
	Size: 0x214
	Parameters: 7
	Flags: None
*/
function function_3f431ce5(x, b_1, b_2, b_3, b_4, b_5, b_6)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0), 1);
		}
		else
		{
			if(isdefined(b_3) && b_3)
			{
				self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0), 1);
			}
			else
			{
				if(isdefined(b_4) && b_4)
				{
					self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0), 1);
				}
				else
				{
					if(isdefined(b_5) && b_5)
					{
						self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0), 1);
					}
					else if(isdefined(b_6) && b_6)
					{
						self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1), 1);
					}
				}
			}
		}
	}
}

/*
	Name: function_2d817962
	Namespace: flowgraph_logic
	Checksum: 0x8C4D92B8
	Offset: 0x938
	Size: 0x274
	Parameters: 8
	Flags: None
*/
function function_2d817962(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0), 1);
		}
		else
		{
			if(isdefined(b_3) && b_3)
			{
				self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0), 1);
			}
			else
			{
				if(isdefined(b_4) && b_4)
				{
					self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0), 1);
				}
				else
				{
					if(isdefined(b_5) && b_5)
					{
						self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0), 1);
					}
					else
					{
						if(isdefined(b_6) && b_6)
						{
							self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0), 1);
						}
						else if(isdefined(b_7) && b_7)
						{
							self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1), 1);
						}
					}
				}
			}
		}
	}
}

/*
	Name: function_c8fcb052
	Namespace: flowgraph_logic
	Checksum: 0x87A820C2
	Offset: 0xBB8
	Size: 0x2CC
	Parameters: 9
	Flags: None
*/
function function_c8fcb052(x, b_1, b_2, b_3, b_4, b_5, b_6, b_7, b_8)
{
	if(isdefined(b_1) && b_1)
	{
		self flowgraph::kick(array(undefined, 1, 0, 0, 0, 0, 0, 0, 0), 1);
	}
	else
	{
		if(isdefined(b_2) && b_2)
		{
			self flowgraph::kick(array(undefined, 0, 1, 0, 0, 0, 0, 0, 0), 1);
		}
		else
		{
			if(isdefined(b_3) && b_3)
			{
				self flowgraph::kick(array(undefined, 0, 0, 1, 0, 0, 0, 0, 0), 1);
			}
			else
			{
				if(isdefined(b_4) && b_4)
				{
					self flowgraph::kick(array(undefined, 0, 0, 0, 1, 0, 0, 0, 0), 1);
				}
				else
				{
					if(isdefined(b_5) && b_5)
					{
						self flowgraph::kick(array(undefined, 0, 0, 0, 0, 1, 0, 0, 0), 1);
					}
					else
					{
						if(isdefined(b_6) && b_6)
						{
							self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 1, 0, 0), 1);
						}
						else
						{
							if(isdefined(b_7) && b_7)
							{
								self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 1, 0), 1);
							}
							else if(isdefined(b_8) && b_8)
							{
								self flowgraph::kick(array(undefined, 0, 0, 0, 0, 0, 0, 0, 1), 1);
							}
						}
					}
				}
			}
		}
	}
}

#namespace flowgraph_loops;

/*
	Name: forloop
	Namespace: flowgraph_loops
	Checksum: 0x411F429B
	Offset: 0xE90
	Size: 0x9E
	Parameters: 3
	Flags: None
*/
function forloop(x, i_begin, i_end)
{
	i_step = 1;
	if(i_end < i_begin)
	{
		i_step = -1;
	}
	i = i_begin;
	while(i != i_end)
	{
		self flowgraph::kick(array(1, i), 1);
		i = i + i_step;
	}
}

/*
	Name: foreachloop
	Namespace: flowgraph_loops
	Checksum: 0x5914FC50
	Offset: 0xF38
	Size: 0xA0
	Parameters: 2
	Flags: None
*/
function foreachloop(x, a_items)
{
	foreach(item in a_items)
	{
		self flowgraph::kick(array(1, item), 1);
	}
}

/*
	Name: whileloop
	Namespace: flowgraph_loops
	Checksum: 0xA7824D6D
	Offset: 0xFE0
	Size: 0x70
	Parameters: 2
	Flags: None
*/
function whileloop(x, b_condition)
{
	while(b_condition)
	{
		self flowgraph::kick(1, 1);
		inputs = self flowgraph::collect_inputs();
		b_condition = inputs[1];
	}
}

#namespace flowgraph_sequence;

/*
	Name: sequence2
	Namespace: flowgraph_sequence
	Checksum: 0x970F8C0F
	Offset: 0x1058
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function sequence2(x)
{
	self flowgraph::kick(array(1, 0), 1);
	self flowgraph::kick(array(0, 1), 1);
}

/*
	Name: sequence3
	Namespace: flowgraph_sequence
	Checksum: 0xEE506965
	Offset: 0x10D0
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function sequence3(x)
{
	self flowgraph::kick(array(1, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 1), 1);
}

/*
	Name: sequence4
	Namespace: flowgraph_sequence
	Checksum: 0x87CF5492
	Offset: 0x1178
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function sequence4(x)
{
	self flowgraph::kick(array(1, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 1), 1);
}

/*
	Name: sequence5
	Namespace: flowgraph_sequence
	Checksum: 0xA69B56D4
	Offset: 0x1250
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function sequence5(x)
{
	self flowgraph::kick(array(1, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 1, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 1), 1);
}

/*
	Name: sequence6
	Namespace: flowgraph_sequence
	Checksum: 0x241C8235
	Offset: 0x1380
	Size: 0x15C
	Parameters: 1
	Flags: None
*/
function sequence6(x)
{
	self flowgraph::kick(array(1, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 1, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 1, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 1), 1);
}

/*
	Name: sequence7
	Namespace: flowgraph_sequence
	Checksum: 0xE486625C
	Offset: 0x14E8
	Size: 0x194
	Parameters: 1
	Flags: None
*/
function sequence7(x)
{
	self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1), 1);
}

/*
	Name: sequence8
	Namespace: flowgraph_sequence
	Checksum: 0x3703391D
	Offset: 0x1688
	Size: 0x1CC
	Parameters: 1
	Flags: None
*/
function sequence8(x)
{
	self flowgraph::kick(array(1, 0, 0, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 1, 0, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 1, 0, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 1, 0, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 1, 0, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 1, 0, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 1, 0), 1);
	self flowgraph::kick(array(0, 0, 0, 0, 0, 0, 0, 1), 1);
}

#namespace flowgraph_util;

/*
	Name: onflowgraphrun
	Namespace: flowgraph_util
	Checksum: 0x7232357A
	Offset: 0x1860
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function onflowgraphrun()
{
	self.owner waittill(#"flowgraph_run");
	return true;
}

/*
	Name: waitfunc
	Namespace: flowgraph_util
	Checksum: 0xAAABDBFC
	Offset: 0x1890
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function waitfunc(x, f_seconds)
{
	wait(f_seconds);
	return true;
}

/*
	Name: createthread
	Namespace: flowgraph_util
	Checksum: 0x244E7E3A
	Offset: 0x18B8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function createthread(x)
{
	return true;
}

#namespace flowgraph_random;

/*
	Name: randomfloatinrangefunc
	Namespace: flowgraph_random
	Checksum: 0xB3B1C3B8
	Offset: 0x18D0
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function randomfloatinrangefunc(f_min, f_max)
{
	return randomfloatrange(f_min, f_max);
}

/*
	Name: randomunitvector
	Namespace: flowgraph_random
	Checksum: 0xFE78589A
	Offset: 0x1908
	Size: 0x5A
	Parameters: 0
	Flags: None
*/
function randomunitvector()
{
	return vectornormalize((randomfloat(1), randomfloat(1), randomfloat(1)));
}

#namespace flowgraph_math;

/*
	Name: multiply
	Namespace: flowgraph_math
	Checksum: 0x780E360F
	Offset: 0x1970
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function multiply(var_d895ca40, var_3029f96f)
{
	return var_d895ca40 * var_d895ca40;
}

/*
	Name: divide
	Namespace: flowgraph_math
	Checksum: 0x9A70EE6
	Offset: 0x1998
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function divide(var_d895ca40, var_3029f96f)
{
	return var_d895ca40 / var_3029f96f;
}

/*
	Name: add
	Namespace: flowgraph_math
	Checksum: 0xFA678C11
	Offset: 0x19C0
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function add(var_d895ca40, var_3029f96f)
{
	return var_d895ca40 + var_3029f96f;
}

/*
	Name: subtract
	Namespace: flowgraph_math
	Checksum: 0xDB786A7C
	Offset: 0x19E8
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function subtract(var_d895ca40, var_3029f96f)
{
	return var_d895ca40 - var_3029f96f;
}

/*
	Name: negate
	Namespace: flowgraph_math
	Checksum: 0x82A385E3
	Offset: 0x1A10
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function negate(v)
{
	return v * -1;
}

/*
	Name: vectordotfunc
	Namespace: flowgraph_math
	Checksum: 0x86AEB7C3
	Offset: 0x1A30
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function vectordotfunc(v_1, v_2)
{
	return vectordot(v_1, v_2);
}

#namespace flowgraph_lighting;

/*
	Name: getlightingstatefunc
	Namespace: flowgraph_lighting
	Checksum: 0xE6DB1724
	Offset: 0x1A68
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function getlightingstatefunc()
{
	return getlightingstate();
}

#namespace flowgraph_level;

/*
	Name: function_35dc468d
	Namespace: flowgraph_level
	Checksum: 0x8B585807
	Offset: 0x1A88
	Size: 0x18
	Parameters: 1
	Flags: None
*/
function function_35dc468d(str_field)
{
	return level.(str_field);
}

/*
	Name: function_f9d5c4b0
	Namespace: flowgraph_level
	Checksum: 0x782CFFD9
	Offset: 0x1AA8
	Size: 0x32
	Parameters: 3
	Flags: None
*/
function function_f9d5c4b0(x, str_field, var_b8003601)
{
	level.(str_field) = var_b8003601;
	return true;
}

#namespace namespace_22752a75;

/*
	Name: function_8892c7a6
	Namespace: namespace_22752a75
	Checksum: 0xBFEFBC26
	Offset: 0x1AE8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_8892c7a6(i_value)
{
	return i_value;
}

/*
	Name: function_28c4ae67
	Namespace: namespace_22752a75
	Checksum: 0x5F390463
	Offset: 0x1B00
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_28c4ae67(var_2eb63fd3)
{
	return var_2eb63fd3;
}

/*
	Name: function_36bf9c6c
	Namespace: namespace_22752a75
	Checksum: 0xE1DBB817
	Offset: 0x1B18
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_36bf9c6c(b_value)
{
	return b_value;
}

/*
	Name: function_fe4cf085
	Namespace: namespace_22752a75
	Checksum: 0xECA19849
	Offset: 0x1B30
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_fe4cf085(str_value)
{
	return str_value;
}

/*
	Name: function_3ece9d7e
	Namespace: namespace_22752a75
	Checksum: 0x1B79FEA8
	Offset: 0x1B48
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_3ece9d7e(var_4cb0cd3c)
{
	return var_4cb0cd3c;
}

/*
	Name: function_68a5d644
	Namespace: namespace_22752a75
	Checksum: 0xBBF65583
	Offset: 0x1B60
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_68a5d644(var_30e9e231)
{
	return var_30e9e231;
}

/*
	Name: function_4e718879
	Namespace: namespace_22752a75
	Checksum: 0xE79173B2
	Offset: 0x1B78
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_4e718879(v_value)
{
	return v_value;
}

/*
	Name: pathnodeconstant
	Namespace: namespace_22752a75
	Checksum: 0x40E0C1B1
	Offset: 0x1B90
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function pathnodeconstant(var_f4af12cc)
{
	return var_f4af12cc;
}

/*
	Name: function_9ef80b8b
	Namespace: namespace_22752a75
	Checksum: 0x11045DF2
	Offset: 0x1BA8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_9ef80b8b(e_value)
{
	return e_value;
}

/*
	Name: introduction_minigun
	Namespace: namespace_22752a75
	Checksum: 0xF7450190
	Offset: 0x1BC0
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function introduction_minigun(ai_value)
{
	return ai_value;
}

/*
	Name: function_513da14e
	Namespace: namespace_22752a75
	Checksum: 0x7FE80736
	Offset: 0x1BD8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_513da14e(var_162b6305)
{
	return var_162b6305;
}

/*
	Name: function_7cbb60c3
	Namespace: namespace_22752a75
	Checksum: 0x4F0EF050
	Offset: 0x1BF0
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_7cbb60c3(var_e7355b57)
{
	return var_e7355b57;
}

/*
	Name: function_f2357a4d
	Namespace: namespace_22752a75
	Checksum: 0xB21E2110
	Offset: 0x1C08
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_f2357a4d(var_52d6c2bd)
{
	return var_52d6c2bd;
}

/*
	Name: function_79f7d941
	Namespace: namespace_22752a75
	Checksum: 0x5D1A1D6E
	Offset: 0x1C20
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_79f7d941(var_b8003601)
{
	return var_b8003601;
}

/*
	Name: function_fdafe394
	Namespace: namespace_22752a75
	Checksum: 0xDE6BA660
	Offset: 0x1C38
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_fdafe394(var_e477c3b)
{
	return var_e477c3b;
}

/*
	Name: function_28848a6a
	Namespace: namespace_22752a75
	Checksum: 0xE1BB3362
	Offset: 0x1C50
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_28848a6a(var_6b11d5a)
{
	return var_6b11d5a;
}

/*
	Name: function_8f5a9b3e
	Namespace: namespace_22752a75
	Checksum: 0x44BADFD1
	Offset: 0x1C68
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_8f5a9b3e(fx_value)
{
	return fx_value;
}

/*
	Name: function_a5f771ce
	Namespace: namespace_22752a75
	Checksum: 0x17120A3C
	Offset: 0x1C80
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_a5f771ce(var_e0bddaf5)
{
	return var_e0bddaf5;
}

/*
	Name: function_527fa489
	Namespace: namespace_22752a75
	Checksum: 0xA80FA1EC
	Offset: 0x1C98
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_527fa489(var_5ab747e5)
{
	return var_5ab747e5;
}

