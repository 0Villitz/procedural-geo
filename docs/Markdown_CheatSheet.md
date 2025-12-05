
# Markdown Cheat Sheet (VS Code–Friendly)

*Formatted to match the Procedural Geometry Learning Roadmap style*

This cheat sheet provides the Markdown formatting patterns used in the Roadmap and Notes. All examples are compatible with GitHub, VS Code, and exported documentation.

---

# **Headings**

```md
# H1 Heading
## H2 Heading
### H3 Heading
#### H4 Heading
```

---

# **Bold / Italic**

```md
**Bold text**
*Italic text*
***Bold italic***
```

---

# **Line Breaks**

Add **two spaces** at the end of a line to force a line break.

Example:

```md
Before starting this phase:  
\- Review Mesh system  
\- Review GDScript syntax  
```

---

# **Bulleted Lists**

```md
• Bullet point  
- Dash bullet
* Asterisk bullet
```

(You may type the • symbol directly for consistency with the Roadmap.)

---

# **Numbered Lists**

```md
1. First item
2. Second item
3. Third item
```

---

# **Blockquotes**

Used for “Assignment Notes”.

```md
> Assignment Notes:
> Additional explanation here.
```

Nested quotes:

```md
>> Nested quote
```

---

# **Inline & Multi-line Code**

**Inline code:**

```md
`add_surface_from_arrays()`
`ArrayMesh`
```

**Code blocks:**

<pre>
```gdscript
var mesh = ArrayMesh.new()
mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arrays)
```
</pre>

---

# **Links**

```md
[Godot Documentation](https://docs.godotengine.org)
```

---

# **Images**

Relative path (recommended):

```md
![Wireframe example](../Notes/Images/phase01_wireframe.png)
```

Resize via HTML:

```html
<img src="../Notes/Images/phase01_wireframe.png" width="400">
```

---

# **Horizontal Rule**

```md
---
```

---

# **Tables**

```md
| Column 1 | Column 2 |
|----------|----------|
| Value A  | Value B  |
| Value C  | Value D  |
```

---

# **Checklists**

```md
- [ ] Incomplete task
- [x] Completed task
```

---

# **Escaping Characters**

Use backslashes to write literal Markdown characters:

```md
\*escaped asterisk\*
\_escaped underscore\_
\`escaped backtick\`
```

---

# **Phase Template (Matching Roadmap Format)**

You may copy this template into each new Phase file inside `/Notes`.

```md
# Phase X - Title Here

**Goal**

Describe the core objective of this phase.

**Pre-flight Knowledge**

Before beginning:  
\- Topic 1  
\- Topic 2  
\- Topic 3  

**Methodology**

Explain the conceptual and practical approach for this phase.

**Assignments**

• Task 1  
> Assignment Notes:

• Task 2  
> Assignment Notes:

• Task 3  
> Assignment Notes:

**Success Criteria**

• Criterion 1  
• Criterion 2  
• Criterion 3  

**Failsafe Readiness Checklist**

• Checklist item 1  
• Checklist item 2  
• Checklist item 3  

**Reflection**

• Prompt 1  
• Prompt 2  

**Suggested Reading & Research Topics**

• Resource 1  
• Resource 2  
• Resource 3  
```

---

# **VS Code Tips**

**Open Markdown Preview:**

```
Ctrl+Shift+V
```

**Side-by-side Preview:**

```
Ctrl+K V
```

**Move list items:**

```
Alt+Up / Alt+Down
```

**Duplicate a line:**

```
Shift+Alt+Down
```

**Paste Image to file automatically (requires extension “Paste Image”):**

* Copy an image
* Press **Ctrl+Alt+V**
* VS Code saves the image to a configured folder (e.g., Notes/Images)
* Inserts the Markdown automatically

---

# End of Document

If you'd like, I can also create:

* A ready-to-use `/Docs` and `/Notes` folder scaffold
* A README explaining your repo structure
* Templates for all 12 phases of your Procedural Geometry Roadmap
