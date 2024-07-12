class_name Mtx3Df
extends Object


var _dim: Vector3i
var _size: int = 0
var _storage: Array[float]

var mtx1: float:
	get: return _get_by_index()
	set(value): _set_by_index(value)
	
var mtx3:
	get: return _get_by_vec()
	set(value): _set_by_vec(value)


func _init(dim: Vector3i, value: float = .0):
	self._dim = dim
	self._size = dim.x * dim.y * dim.z
	self._storage.resize(self._size)
	self._storage.fill(value)

func get_xyz(index: int) -> Vector3i:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return Vector3i()
	
	var x: int = index % self._dim.x
	var y: int = ((index - x) / self._dim.x) % self._dim.y
	var z: int = (index - x - self._dim.x * y)/(self._dim.x * self._dim.y)
	
	return Vector3i(x, y, z)

func get_index(vec: Vector3i) -> int:
	return vec.x + self._dim.x * (vec.y + self._dim.y * vec.z)
	
func _index_assert(index: int) -> bool:
	if index >= self._size || index < 0:
		printerr("mtx3df index {index} out of bounds".format({"index": index}))
		return false
	return true

func _get_by_index(index: int = 0) -> float:
	if _index_assert(index):
		return _storage[index]
	return -1.0

func _set_by_index(value: float, index: int = 0):
	if _index_assert(index):
		_storage[index] = value

func _get_by_vec(vec: Vector3i = Vector3i()) -> float:
	return _get_by_index(get_index(vec))

func _set_by_vec(vec: Vector3i = Vector3i(), value: float = .0):
	_set_by_index(value, get_index(vec))
