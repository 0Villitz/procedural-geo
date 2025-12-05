# Phase 0 - Foundation: MeshData & Builder

**Goal**

Establish a data-driven procedural geometry foundation by separating raw mesh data from engine-specific mesh objects.

**Pre-flight Knowledge**

Before starting this phase, review:  
- Godot's Mesh system: ArrayMesh, SurfaceTool, and MeshInstance3D  
- GDScript syntax for arrays and dictionaries  
- The @tool keyword and how scripts run inside the Godot editor

**Methodology**

Follow a data-oriented design approach similar to professional game engines. Separate geometry data structures from rendering objects. Build a minimal, reusable MeshData type containing attributes like positions, normals, tangents, uvs, colors, and indices. Implement a MeshBuilder to convert MeshData to an ArrayMesh using add_surface_from_arrays().

**Assignments**

- Define a MeshData struct/class containing PackedVector arrays for positions, normals, tangents, uvs, colors, and indices.

- Implement a MeshBuilder.build(mesh_data) function that creates an ArrayMesh surface via add_surface_from_arrays().

- Refactor your existing procedural plane script to populate MeshData and pass it through MeshBuilder.build().

- Create a small test scene to validate MeshData → ArrayMesh → MeshInstance3D rendering in both runtime and editor.

**Success Criteria**

- The plane renders successfully in both editor and game modes.

- Swapping between different geometry datasets (e.g., triangle vs plane) requires no builder modification.

- All MeshData attributes correctly populate ArrayMesh surfaces (visible in the debugger).

**Failsafe Readiness Checklist**

- Can you describe what each MeshData attribute represents and when it's required?

- Can you rebuild the plane mesh from scratch without referencing the tutorial?

- Have you verified correct mesh behavior with and without normals?

- Can you explain the relationship between MeshData and ArrayMesh?

- Have you tested rebuilds in both runtime and editor mode?

**Reflection**

- Why is separating mesh data from the builder beneficial?

- How does this pattern appear in professional engines like Unity or Unreal?

**Suggested Reading & Research Topics**

- Godot Docs - Procedural Geometry tutorial

- Game Engine Architecture (Jason Gregory) - Geometry and Rendering chapter

- Data-Oriented Design principles in geometry processing

- Godot Engine source: ArrayMesh.add_surface_from_arrays() implementation


## Preview of next lesson: "Phase 1 - Topology, Indices, and Hard Edges"

**Goal:** 
Develop a working understanding of indexed geometry, triangle winding order, and the treatment of hard edges through vertex duplication.

**Methodology:**
Indexed geometry allows vertex reuse between triangles, reducing memory and improving performance. However, for flat-shaded meshes, each face must have unique vertices with identical normals. The winding order of triangles determines whether they face toward or away from the camera. Following standard CCW winding ensures consistent normal direction and predictable backface culling.

**Pre-flight Knowledge:**

- Review vector cross products and how to compute surface normals.  
- Understand counter-clockwise (CCW) winding and backface culling in 3D rendering.  
- Review how to visualize mesh normals using ImmediateMesh or debug lines.  
- Refresh vector and matrix math fundamentals if needed.

**Assignments**

- Implement a cube generator with 24 unique vertices (4 per face) using indices for 12 triangles.
- Compute per-face normals using the cross product: (B - A) × (C - A). Assign these normals to all four vertices of each face.
- Add a toggle for backface culling and wireframe rendering for debugging purposes.
- Visualize face normals in-scene using ImmediateMesh or line gizmos to verify outward direction.
- Test an intentionally flipped winding order on one cube face to see how backface culling behaves.
- Log vertex and triangle counts to confirm 24 vertices and 12 triangles.
- Save this cube generator for reuse in future phases (UV mapping and shading).