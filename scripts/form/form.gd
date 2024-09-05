@tool
extends Node3D


var dims := Vector3i(10, 10, 5)
var noise: float = 1.0
var strength: int = 10
var density: int = 10
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
	caster.mtx_field = Simulator.get_gradient_sphere(caster.dims, caster.strength, caster.noise)
	caster.mtx_field = Simulator.scalar_offset_normalize(caster.mtx_field)
	#caster.mtx_field = Simulator.minmax_scale_normalize(caster.mtx_field)
	caster.mtx_scale = Simulator.get_minmax_scaled(caster.mtx_field)
	caster.mtx_probe = Simulator.get_probe(caster)
	
	print("*** FIELD MTX TEST OUT ***\n")
	matrix_test_output(caster.mtx_field)
	print("*** SCALE MTX TEST OUT ***\n")
	matrix_test_output(caster.mtx_scale)
	print("*** PROBE MTX TEST OUT ***\n")
	matrix_test_output(caster.mtx_probe)
	
	var fcube := FCube.new(.0)
	add_child(fcube)


func matrix_test_output(mtx: Mtx3Dv):
	var pad := 2
	var mult := 0.01
	var delim := " "
	
	for x in range(mtx.dims().x):
		var plane: String
		for y in range(mtx.dims().y):
			for z in range(mtx.dims().z):
				var value := float(mtx.getV(Vector3i(x, y, z)))
				if not is_nan(value):
					plane += str(snappedf(value, mult)).pad_decimals(pad) + delim
				else:
					var nan_str := str(value)
					for s in range(pad + 1):
						nan_str += delim
					plane += nan_str
			plane += '\n'
		print(plane + '\n')
