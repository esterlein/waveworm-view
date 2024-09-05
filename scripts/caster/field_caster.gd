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


func _init(dims: Vector3i, noise: int, strength: int, probe_density: float, probe_sparsity: int):
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
