extends MeshInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	print('generating mesh')
	
	var st = SurfaceTool.new()

	st.begin(Mesh.PRIMITIVE_LINE_STRIP)
	
	for x in range(0, 22, 2):
		for y in range(21):
			st.add_vertex(Vector3(-10.0 + x, 0, -10.0 + y))
			st.add_color(Color(1, 0, 0))
		if x == 20:
			break
		for y in range(21):
			st.add_vertex(Vector3(-10.0 + x + 1.0, 0, 10.0 - y))
			st.add_color(Color(1, 0, 0))
			
	for y in range(0, 22, 2):
		for x in range(21):
			st.add_vertex(Vector3(-10.0 + x, 0, 10.0 - y))
			st.add_color(Color(1, 1, 0))
		if y == 20:
			break
		for x in range(21):
			st.add_vertex(Vector3(10.0 - x, 0, 10.0 - y - 1.0))
			st.add_color(Color(1, 1, 0))
	
	# Create indices, indices are optional.
	st.index()
	
	# Commit to a mesh.
	set_mesh(st.commit())

# TODO(lucasw) this is supposed to be faster, but don't see anything
func _make_mesh_array():
	var arrays = []
	arrays.resize(Mesh.ARRAY_MAX)
	
	var normal_array = []
	var uv_array = []
	var vertex_array = []
	var index_array = []
	var color_array = []
	
	normal_array.resize(4)
	uv_array.resize(4)
	vertex_array.resize(4)
	color_array.resize(len(vertex_array))
	index_array.resize(6)
	
	normal_array[0] = Vector3(0, 0, 1)
	uv_array[0] = Vector2(0, 0)
	vertex_array[0] = Vector3(-1, -1, 0)
	
	normal_array[1] = Vector3(0, 0, 1)
	uv_array[1] = Vector2(0,1)
	vertex_array[1] = Vector3(-1, 1, 0)
	
	normal_array[2] = Vector3(0, 0, 1)
	uv_array[2] = Vector2(1, 1)
	vertex_array[2] = Vector3(1, 1, 0)
	
	normal_array[3] = Vector3(0, 0, 1)
	uv_array[3] = Vector2(1, 0)
	vertex_array[3] = Vector3(1, -1, 0)
	
	for i in range(len(vertex_array)):
		vertex_array[i] *= 2.0
		color_array[i] = Vector3(0, 1.0, 0)
	
	# Indices are optional in Godot, but if they exist they are used.
	index_array[0] = 0
	index_array[1] = 1
	index_array[2] = 2
	
	index_array[3] = 2
	index_array[4] = 3
	index_array[5] = 0
	
	arrays[Mesh.ARRAY_VERTEX] = vertex_array
	arrays[Mesh.ARRAY_COLOR] = color_array
	arrays[Mesh.ARRAY_NORMAL] = normal_array
	arrays[Mesh.ARRAY_TEX_UV] = uv_array
	arrays[Mesh.ARRAY_INDEX] = index_array
	
	var nmesh = ArrayMesh.new()
	nmesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
	set_mesh(nmesh)
	print(nmesh.surface_get_format(0))
	print(nmesh.surface_get_array_len(0))
	print(mesh.get_surface_count())
	ResourceSaver.save("res://test.tres", mesh, 32)
