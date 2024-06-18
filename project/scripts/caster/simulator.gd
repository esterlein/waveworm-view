class_name Simulator
extends Object


var _size: int = 10
var _noise: int = 2
var _strength: int = 10

var _probe_density: int = 10
var _probe_sparsity: int = 1

var mtx_field: Array[float]
var mtx_probe: Array[float]


func _init():
	var size: int = _size ** 3
	mtx_field.resize(size)
	mtx_probe.resize(size)
	mtx_field.fill(0)
	mtx_probe.fill(0)


func set_gradient_sphere() -> void:
	var center_x = _size / 2
	var center_y = center_x
	var center_z = center_x
	
	for x in range(_size):
		for y in range(_size):
			for z in range(_size):
				mtx_field[x + y * 10 + z * 100] = float(_strength - sqrt(abs(center_x - x) ** 2 +
				abs(center_y - y) ** 2 + abs(center_z - z) ** 2))
