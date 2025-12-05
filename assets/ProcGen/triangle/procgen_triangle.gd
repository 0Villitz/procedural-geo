@tool
extends MeshInstance3D

# add checkbox to allow for manual rebuilding in editor
@export var rebuild: bool:
	set(value):
		rebuild = false # immediately reset checkbox so user can click again
		if Engine.is_editor_hint():
			_build_mesh()

func _enter_tree() -> void:
	# runs in editor too
	_build_mesh()

func _ready() -> void:
	# runs at game time
	_build_mesh()

func _build_mesh() -> void:
	var st: SurfaceTool = SurfaceTool.new()
	st.begin(Mesh.PRIMITIVE_TRIANGLES)
	
	st.set_color(Color(1, 0, 0))
	st.set_normal(Vector3(0, 0, 1))
	st.add_vertex(Vector3(-1, -1, 0))
	
	st.set_color(Color(0, 1, 0))
	st.set_normal(Vector3(0, 0, 1))
	st.add_vertex(Vector3(-1, 1, 0))
	
	st.set_color(Color(0, 0, 1))
	st.set_normal(Vector3(0, 0, 1))
	st.add_vertex(Vector3(1, 1, 0))

	var m: ArrayMesh = st.commit()

	mesh = m

	# make sure it has a material and is visible
	var mat: StandardMaterial3D = StandardMaterial3D.new()
	mat.vertex_color_use_as_albedo = true
	material_override = mat
