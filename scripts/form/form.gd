@tool
extends Node3D


@export var dims := Vector3i(10, 10, 10)
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
	
	var gradient_data: Dictionary = {
		0.0: Color.RED,
		0.5: Color.GREEN,
		0.75: Color.VIOLET,
		1.0: Color.BLUE
	}
	
	var gradient := Gradient.new()
	gradient.offsets = gradient_data.keys()
	gradient.colors = gradient_data.values()
	
	caster = FieldCaster.new(dims, noise, strength, density, sparsity)
	var mtx: Mtx3Dv = caster.mtx_probe
	
	for x in range(self.dims.x):
		for y in range(self.dims.y):
			for z in range(self.dims.z):
				var pos := Vector3i(x, y, z)
				var val: Variant = mtx.getV(pos)
				
				if is_nan(val):
					continue
				
				var fcube := FCube.new(val, gradient.sample(val))
				var offset := Vector3(mtx.dims().x / 2.0, mtx.dims().y / 2.0, mtx.dims().z / 2.0)
				fcube.position = Vector3(pos) - offset
				
				add_child(fcube)
