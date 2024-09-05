@tool
extends Node3D


@export var dims := Vector3i(10, 10, 5)
@export var noise: float = 1.0
@export var strength: int = 10
@export var density: int = 10
@export var sparsity: int = 1


var random_seed: int = 0
var caster: FieldCaster


func _ready():
	generate()


func _process(_delta):
	pass


func generate() -> void:
	seed(random_seed)
	
	caster = FieldCaster.new(dims, noise, strength, density, sparsity)
	
	
	var fcube := FCube.new(.0)
	add_child(fcube)
