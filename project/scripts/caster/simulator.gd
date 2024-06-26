class_name Simulator
extends Object


var _size: int = 10
var _noise: int = 2
var _strength: int = 10

var _probe_density_perc: int = 10
var _probe_sparsity_elem: int = 1


func _init():
	pass


func get_gradient_sphere() -> Array[float]:
	var mtx_field: Array[float]
	mtx_field.resize(_size ** 3)
	mtx_field.fill(0)
	
	var center_x: float = _size / 2.
	var center_y: float = center_x
	var center_z: float = center_x
	
	for x in range(_size):
		for y in range(_size):
			for z in range(_size):
				mtx_field[x + y * 10 + z * 100] = float(_strength - sqrt(abs(center_x - x) ** 2 +
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
		
		if _backtrack(Vector3i(x, y, z), _probe_sparsity_elem) == false:
			continue
		
		mtx_probe[index] = mtx_field[index]
		num_p += 1
	
	return mtx_probe


func _backtrack(coords: Vector3i, depth: int, memo: Dictionary = {}) -> bool:
	if coords in memo:
		return false
	
	return false
