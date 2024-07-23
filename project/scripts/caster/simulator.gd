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


static func get_probe(field: SimField) -> Mtx3Dv:
	var size := field.size
	var mtx_probe := Mtx3Dv.new(field.dims)
	
	var perc_probe: int = field.probe_density_perc
	var free_range: int = field.probe_sparsity_elem
	if not (perc_probe > 0 && free_range >= 0):
		printerr("wrong field parameters {dens, spar}".format({"dens": perc_probe, "spar": free_range}))
		return null
	
	var num_probes := int(size * perc_probe / 100)
	
	var probe: int = 0
	var probes_coords: Dictionary = {}
	while probe < num_probes:
		var index: int = randi_range(0, size)
		var coords = mtx_probe.toV(index)
		
		// var diff: Vector3i = abs()
		
		if not _bfs(mtx_probe, coords, free_range):
			continue
		
		mtx_probe.setI(index, field.mtx_field.getI(index))
		probe += 1
	
	return mtx_probe


static func _bfs(mtx: Mtx3Dv, coords: Vector3i, range: int, memo: Dictionary = {}) -> bool:
	if coords.x < 0 or coords.y < 0 or coords.z:
		return false
	if coords in memo:
		return false
	if not is_nan(mtx.getV(coords)):
		return false
	else:
		memo[coords] = true # use this for something
	
	
	
	var queue: Array[Vector3i]
	queue.resize(3 ** (range + 1))
	queue[0] = coords
	
	
	
	while not queue.is_empty():
		var curr: Vector3i = queue.pop_front()
	
	return false
