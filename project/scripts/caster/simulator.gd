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
	self.mtx_field.resize(self._size ** 3)
	self.mtx_probe.resize(self._size ** 3)

func set_gradient_sphere() -> void:
	pass
