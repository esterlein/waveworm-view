class_name Caster
extends RefCounted


var dims := Vector3i(10, 10, 10)
var noise: int = 2
var strength: int = 10
var density: int = 10
var sparsity: int = 1


func _init():
	pass

func create_fields():
	var field := SimField.new(dims, noise, strength, density, sparsity)
	field.mtx_field = Simulator.get_gradient_sphere(field.dims, field.strength)
	field.mtx_probe = Simulator.get_probe(field)
