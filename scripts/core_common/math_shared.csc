// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace math;

/*
	Name: clamp
	Namespace: math
	Checksum: 0xF6960D70
	Offset: 0x68
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function clamp(val, val_min, val_max)
{
	if(val < val_min)
	{
		val = val_min;
	}
	else if(val > val_max)
	{
		val = val_max;
	}
	return val;
}

/*
	Name: linear_map
	Namespace: math
	Checksum: 0x91A6DCF8
	Offset: 0xC0
	Size: 0x6A
	Parameters: 5
	Flags: None
*/
function linear_map(num, min_a, max_a, min_b, max_b)
{
	return clamp(num - min_a / max_a - min_a * max_b - min_b + min_b, min_b, max_b);
}

/*
	Name: lag
	Namespace: math
	Checksum: 0xE8C56373
	Offset: 0x138
	Size: 0x9E
	Parameters: 4
	Flags: None
*/
function lag(desired, curr, k, dt)
{
	r = 0;
	if(k * dt >= 1 || k <= 0)
	{
		r = desired;
	}
	else
	{
		err = desired - curr;
		r = curr + k * err * dt;
	}
	return r;
}

/*
	Name: array_average
	Namespace: math
	Checksum: 0xD4F5BD49
	Offset: 0x1E0
	Size: 0xA8
	Parameters: 1
	Flags: None
*/
function array_average(array)
{
	/#
		assert(isarray(array));
	#/
	/#
		assert(array.size > 0);
	#/
	total = 0;
	for(i = 0; i < array.size; i++)
	{
		total = total + array[i];
	}
	return total / array.size;
}

/*
	Name: array_std_deviation
	Namespace: math
	Checksum: 0x581256E6
	Offset: 0x290
	Size: 0x11A
	Parameters: 2
	Flags: None
*/
function array_std_deviation(array, mean)
{
	/#
		assert(isarray(array));
	#/
	/#
		assert(array.size > 0);
	#/
	tmp = [];
	for(i = 0; i < array.size; i++)
	{
		tmp[i] = array[i] - mean * array[i] - mean;
	}
	total = 0;
	for(i = 0; i < tmp.size; i++)
	{
		total = total + tmp[i];
	}
	return sqrt(total / array.size);
}

/*
	Name: vector_compare
	Namespace: math
	Checksum: 0x93354B86
	Offset: 0x3B8
	Size: 0xB6
	Parameters: 2
	Flags: None
*/
function vector_compare(vec1, vec2)
{
	return abs(vec1[0] - vec2[0]) < 0.001 && abs(vec1[1] - vec2[1]) < 0.001 && abs(vec1[2] - vec2[2]) < 0.001;
}

/*
	Name: random_vector
	Namespace: math
	Checksum: 0x244B3811
	Offset: 0x478
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function random_vector(max_length)
{
	return (randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length), randomfloatrange(-1 * max_length, max_length));
}

/*
	Name: angle_dif
	Namespace: math
	Checksum: 0x5A463285
	Offset: 0x4F0
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function angle_dif(oldangle, newangle)
{
	outvalue = oldangle - newangle % 360;
	if(outvalue < 0)
	{
		outvalue = outvalue + 360;
	}
	if(outvalue > 180)
	{
		outvalue = outvalue - 360 * -1;
	}
	return outvalue;
}

/*
	Name: sign
	Namespace: math
	Checksum: 0x133CB12C
	Offset: 0x568
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function sign(x)
{
	if(x >= 0)
	{
		return 1;
	}
	return -1;
}

/*
	Name: cointoss
	Namespace: math
	Checksum: 0x4209AB5E
	Offset: 0x598
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function cointoss(n_chance = 50)
{
	return function_21a3a673(1, 100) <= n_chance;
}

