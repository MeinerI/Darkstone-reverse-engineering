meta:
  id: b3d
  file-extension: b3d
  endian: le

#############################################

seq:
  - id: block_count # сабмешей
    type: u4

  - id: blocks 
    type: block
    repeat: expr
    repeat-expr: block_count

#############################################

types:

  block:
    seq:

    - id: one
      type: u4

    - id: str3df
      type: str
      size: 8
      encoding: ASCII

    - id: string48s
      type: str
      size: 48
      encoding: ASCII
    
    - id: floats6 # boundingBox ?
      type: f4
      repeat: expr
      repeat-expr: 6

    - id: vertex_count # вершин
      type: u4

    - id: face_count # граней
      type: u4

    - id: face_count_2
      type: u4

    - id: vertex_count_2
      type: u4

    - id: coords
      type: vector
      repeat: expr
      repeat-expr: vertex_count

    - id: polygon
      type: float8
      repeat: expr
      repeat-expr: face_count

#############################################

  vector:
    seq:
      - id: x
        type: f4
      - id: y
        type: f4
      - id: z
        type: f4

#############################################

  float8:
    seq:
      - id: color # цвет ? (как в o3d)
        type: u1
        repeat: expr
        repeat-expr: 4

      - id: texture_coord # для 6 для tri, 8 для quad ? (как в o3d)
        type: f4
        repeat: expr
        repeat-expr: 8

      - id: face3or4 # tri (65535) or quad
        type: u2
        repeat: expr
        repeat-expr: 4

      - id: hz_array # 6 байт окончания / в конце может текстура, как в o3d ?
        type: u2
        repeat: expr
        repeat-expr: 3

#############################################
