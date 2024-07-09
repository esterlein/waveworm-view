class_name Mtx3Df
extends Object


var _dim: Vector3i
var _size: int = 0
var _storage: Array[float]

var mtx1: float:
	get: return _get_by_index()
	set(value): _set_by_index(value)
	
var mtx3:
	get: return _get_by_xyz()
	set(value): _set_by_xyz(value)


func _init(dim: Vector3i, value: float = .0):
	self._dim = dim
	self._size = dim.x * dim.y * dim.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func xyz(index: int) -> Vector3i:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return Vector3i()
	
	var x: int = index % self._dim.x
	var y: int = ((index - x) / self._dim.x) % self._dim.y
	var z: int = (index - x - self._dim.x * y)/(self._dim.x * self._dim.y)
	
	return Vector3i(x, y, z)

func index(x: int, y: int, z: int) -> int:
	return x + self._dim.x * (y + self._dim.y * z)

func _get_by_index(index: int = 0) -> float:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return .0
	return _storage[index]

func _set_by_index(index: int, value: float = .0):
	pass

func _get_by_xyz(xyz: Vector3i = Vector3i()) -> float:
	return .0

func _set_by_xyz(xyz: Vector3i = Vector3i(), value: float = .0):
	pass
