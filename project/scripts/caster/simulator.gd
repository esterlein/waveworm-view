class_name Simulator
extends RefCounted


static func get_gradient_sphere(dim: Vector3i, strength: int) -> Mtx3Dv:
	var mtx_field := Mtx3Dv.new(dim)
	
	var center_x: float = dim.x / 2.0
	var center_y: float = dim.y / 2.0
	var center_z: float = dim.z / 2.0
	
	for x in range(dim.x):
		for y in range(dim.y):
			for z in range(dim.z):
				var value := float(strength - sqrt(abs(center_x - x) ** 2 +
				abs(center_y - y) ** 2 + abs(center_z - z) ** 2)) + randfn(.0, 1.)
				mtx_field.setV(Vector3i(x, y, z), value)
	
	return mtx_field


static func scalar_offset_normalize(mtx: Mtx3Dv) -> Mtx3Dv:
	var size := mtx.size()
	var min_val: float = 0.
	
	for x in range(size):
		for y in range(size):
			for z in range(size):
				min_val = min(min_val, mtx.getV(Vector3i(x, y, z)))
	
	for x in range(size):
		for y in range(size):
			for z in range(size):
				mtx.addV(Vector3i(x, y, z), -min_val)
	
	return mtx


static func get_probe(field: FieldCaster) -> Mtx3Dv:
	var mtx_probe := Mtx3Dv.new(field.dims)
	
	var perc_probe: int = field.probe_density_perc
	var free_range: int = field.probe_sparsity_elem
	if not (perc_probe > 0 && free_range >= 0):
		printerr("wrong field parameters {dens, spar}".format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var chunk_size: int = (free_range * 2 + 1) ** 3
	if field.size / chunk_size <= perc_probe:
		printerr("required percent of field or volume required for probing distance is too large {dens, spar}" \
		.format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var num_probes: int = field.size * perc_probe / 100
	
	var cnt_probe: int = 0
	var coords_map: Dictionary = {}
	
	while cnt_probe < num_probes:
		var index: int = randi_range(0, field.size)
		var coords = mtx_probe.toV(index)
		
		for entry in coords_map:
			var diff: Vector3i = abs(entry - coords)
			for d in diff:
				if d > free_range * 2:
					mtx_probe.setI(index, field.mtx_field.getI(index))
					cnt_probe += 1
					break
	
	return mtx_probe
