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
	pass
