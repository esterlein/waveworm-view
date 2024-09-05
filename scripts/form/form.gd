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
	
	for x in range(self.dims.x):
		for y in range(self.dims.y):
			for z in range(self.dims.z):
				var pos := Vector3i(x, y, z)
				var fcube := FCube.new(caster.mtx_scale.getV(pos))
				fcube.position = pos
				add_child(fcube)
