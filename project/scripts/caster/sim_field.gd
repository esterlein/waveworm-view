class_name SimField
extends RefCounted


var dim: Vector3i
var size: int

var noise: int
var strength: int

var probe_density_perc: int
var probe_sparsity_elem: int

var mtx_field: Mtx3Dv
var mtx_probe: Mtx3Dv
var mtx_inter: Mtx3Dv


func _init(dim: Vector3i, noise: int, strength: int, probe_density: int, probe_sparsity: int):
	self.dim = dim
	self.noise = noise
	self.strength = strength
	self.probe_density_perc = probe_density
	self.probe_sparsity_elem = probe_sparsity
	
	self.size = dim.x * dim.y * dim.z

func assert_parameters() -> bool:
	if self.dim == mtx_field.dim() && self.dim == mtx_probe.dim() && self.dim == mtx_inter.dim():
		return true
	printerr("sim field parameters mismatch")
	return false
