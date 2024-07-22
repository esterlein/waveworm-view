class_name SimField
extends RefCounted


var dims: Vector3i
var size: int

var noise: int
var strength: int

var probe_density_perc: int
var probe_sparsity_elem: int

var mtx_field: Mtx3Dv
var mtx_probe: Mtx3Dv
var mtx_inter: Mtx3Dv


func _init(dims: Vector3i, noise: int, strength: int, probe_density: int, probe_sparsity: int):
	self.dims = dims
	self.noise = noise
	self.strength = strength
	self.probe_density_perc = probe_density
	self.probe_sparsity_elem = probe_sparsity
	
	self.size = dims.x * dims.y * dims.z


func assert_parameters() -> bool:
	if self.dims == mtx_field.dims() && self.dims == mtx_probe.dims() && self.dims == mtx_inter.dims():
		return true
	printerr("sim field parameters mismatch")
	return false
