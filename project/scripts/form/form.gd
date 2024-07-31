@tool
extends Node3D


var dims := Vector3i(10, 10, 10)
var noise: int = 1
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
	
	# matrix test output block
	
	var pad := 2
	var mult := 0.01
	var delim := " "
	
	for x in range(caster.dims.x):
		var plane: String
		for y in range(caster.dims.y):
			for z in range(caster.dims.z):
				plane += str(snappedf(caster.mtx_field.getV(Vector3i(x, y, z)), mult)).pad_decimals(pad) + delim
			plane += '\n'
		print(plane + '\n')
