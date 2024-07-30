@tool
extends Node3D


var dims := Vector3i(10, 10, 10)
var noise: int = 2
var strength: int = 10
var density: int = 5
var sparsity: int = 1


var random_seed: int = 0
var caster: FieldCaster


func _ready():
	generate()


func _process(_delta):
	pass
	
	
func generate() -> void:
	seed(random_seed)
	
	caster = FieldCaster.new(dims, noise, strength, density, sparsity)
	caster.mtx_field = Simulator.get_gradient_sphere(caster.dims, caster.strength)
	caster.mtx_probe = Simulator.get_probe(caster)
