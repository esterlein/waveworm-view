class_name Simulator
extends Object


var _size: int = 10
var _noise: int = 2
var _strength: int = 10

var _probe_density_perc: int = 10
var _probe_sparsity_elem: int = 1


func _init():
	pass


func get_gradient_sphere(dim: Vector3i) -> Mtx3Df:
	var mtx_field := Mtx3Df.new(dim)
	
	var center_x: float = dim.x / 2.0
	var center_y: float = dim.y / 2.0
	var center_z: float = dim.z / 2.0
	
	for x in range(dim.x):
		for y in range(dim.y):
			for z in range(dim.z):
				var value: float = mtx_field.mtx1(0)
				mtx_field.mtx1(0) = float(_strength - sqrt(abs(center_x - x) ** 2 +
				abs(center_y - y) ** 2 + abs(center_z - z) ** 2)) + randfn(.0, 1.)
				
	return mtx_field


func scalar_offset_normalize(mtx: Array[float], size: int = _size) -> Array[float]:
	var min_val: float = 0
	
	for x in range(size):
		for y in range(size):
			for z in range(size):
				min_val = min(min_val, mtx[x + y * 10 + z * 100])
	
	for x in range(size):
		for y in range(size):
			for z in range(size):
				mtx[x + y * 10 + z * 100] += -min_val
				
	return mtx


func get_probe(mtx_field: Array[float], perc: int = _probe_density_perc) -> Array[float]:
	var size: int = mtx_field.size()
	var mtx_probe: Array[float]
	mtx_probe.resize(size)
	mtx_probe.fill(NAN)
	
	var num_probes := int(size * perc / 100)
	
	var num_p: int = 0
	while num_p < num_probes:
		var index: int = randi_range(0, size)
		
		var x := int(index / size ** 2)
		var y := int(index / x)
		var z := int(index % x)
		
		if _backtrack(mtx_probe, Vector3i(x, y, z), _probe_sparsity_elem) == false:
			continue
		
		mtx_probe[index] = mtx_field[index]
		num_p += 1
	
	return mtx_probe


func _backtrack(mtx: Array[float], coords: Vector3i, depth: int, memo: Dictionary = {}) -> bool:
	if coords.x < 0 or coords.y < 0 or coords.z < 0:
		return false
	if coords in memo:
		return false
	#if is_nan(mtx[])
	
	return false
