class_name FieldCaster
extends RefCounted


var dims: Vector3i
var size: int

var noise: float
var strength: int

var probe_density_perc: int
var probe_sparsity_elem: int

var mtx_field: Mtx3Dv
var mtx_scale: Mtx3Dv
var mtx_probe: Mtx3Dv
var mtx_inter: Mtx3Dv


func _init(dims: Vector3i, noise: int, strength: int, probe_density: float, probe_sparsity: int) -> void:
	if assert_parameters(dims, probe_sparsity):
		self.dims = dims
		self.noise = noise
		self.strength = strength
		self.probe_density_perc = probe_density
		self.probe_sparsity_elem = probe_sparsity
		
		self.size = dims.x * dims.y * dims.z
	else:
		assert(false, "unable to initialize caster")
	
	return


func cast_simulation() -> void:
	self.mtx_field = Simulator.get_gradient_sphere(self.dims, self.strength, self.noise)
	self.mtx_field = Simulator.scalar_offset_normalize(self.mtx_field)
	
	self.mtx_scale = Simulator.get_minmax_scaled(self.mtx_field)
	
	self.mtx_probe = Simulator.get_probe(self)



func assert_parameters(dims: Vector3i, probe_sparsity: int) -> bool:
	for component in range(WWDef.VEC3_SIZE):
		if dims[component] < probe_sparsity * 2 + 1:
			printerr("mtx3dv dimension is lower than required by sparcity value")
			return false
	
	return true


func _assert_internal():
	if self.dims != mtx_field.dims() || self.dims != mtx_scale.dims() || \
	self.dims != mtx_probe.dims() || self.dims != mtx_inter.dims():
		printerr("caster mtx3dv dimensions mismatch")
		return false


func print_mtx_test(mtx: Mtx3Dv):
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


func print_full_test() -> void:
	print("********** FIELD MTX **********\n")
	print_mtx_test(self.mtx_field)
	print("********** SCALE MTX **********\n")
	print_mtx_test(self.mtx_scale)
	print("********** PROBE MTX **********\n")
	print_mtx_test(self.mtx_probe)
