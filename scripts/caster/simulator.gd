class_name Simulator
extends RefCounted


static func get_gradient_sphere(dims: Vector3i, strength: int, noise: float) -> Mtx3Dv:
	var mtx_field := Mtx3Dv.new(dims)
	
	var center_x: float = dims.x / 2.0
	var center_y: float = dims.y / 2.0
	var center_z: float = dims.z / 2.0
	
	for x in range(dims.x):
		for y in range(dims.y):
			for z in range(dims.z):
				var value := float(strength - sqrt(abs(center_x - x) ** 2 +
				abs(center_y - y) ** 2 + abs(center_z - z) ** 2)) + randfn(.0, noise)
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


static func get_probe(caster: FieldCaster) -> Mtx3Dv:
	var mtx_probe := Mtx3Dv.new(caster.dims)
	
	var perc_probe: int = caster.probe_density_perc
	var free_range: int = caster.probe_sparsity_elem
	if not (perc_probe > 0 && free_range >= 0):
		printerr("wrong field parameters {dens, spar}".format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var chunk_size: int = (free_range * 2 + 1) ** WWDef.vec3_size
	if caster.size / chunk_size <= perc_probe:
		printerr("required percent of field or volume required for probing distance is too large {dens, spar}" \
		.format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var num_probes: int = caster.size * perc_probe / 100
	
	var cnt_probe: int = 0
	var coords_map: Dictionary = {}
	
	coords_map[mtx_probe.toV(randi_range(0, caster.size - 1))] = true # utilize bool value
	
	while cnt_probe < num_probes:
		var index: int = randi_range(0, caster.size - 1)
		var coords = mtx_probe.toV(index)
		
		if coords_map.has(coords):
			continue
		
		for entry in coords_map:
			var vec_diff: Vector3i = abs(entry - coords)
			for axis_diff in vec_diff:
				if axis_diff > free_range * 2:
					mtx_probe.setI(index, caster.mtx_field.getI(index))
					coords_map[coords] = true # utilize bool value
					cnt_probe += 1
					break
	
	return mtx_probe
