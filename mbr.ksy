meta:
  id: mbr
  file-extension: mbr
  endian: le

#############################################

seq:
  - id: one
    type: u2
  - id: block_count # количество саб-мешей
    type: u4
  - id: blocks 
    type: block
    repeat: expr
    repeat-expr: block_count

#############################################

types:

  block:
    seq:

    - id: str_count # 01 00 или 02 00
      type: u2

    - id: string48s
      type: str
      size: 48
      encoding: ASCII
      repeat: expr
      repeat-expr: 2

    - id: floats_q
      type: f4
      repeat: expr
      repeat-expr: 27

    - id: count_triplet # количество вершин
      type: u4

    - id: count_quadrat
      type: u4

    - id: triplets # xyz 
      type: triplet
      repeat: expr
      repeat-expr: count_triplet

    - id: quadrats
      type: float8
      repeat: expr
      repeat-expr: count_quadrat

    # не проверял, потому что у меня нет игры 
    - id: triplet_int # ссылки на текстуры для полигонов ?
      type: u4
      repeat: expr
      repeat-expr: count_triplet

    - id: count_float
      type: u4
      if: str_count == 2

    - id: float_8
      type: float8
      repeat: expr
      repeat-expr: count_float
      if: count_float > 0

    - id: short_5
      type: short5
      repeat: expr
      repeat-expr: count_float
      if: count_float > 0

    - id: float_6
      type: f4
      repeat: expr
      repeat-expr: 6

#############################################

  triplet:
    seq:
      - id: vector
        type: f4
        repeat: expr
        repeat-expr: 3

#############################################

  float8:
    seq:
      - id: bytes4 # цвет ?  (как в o3d)
        type: u1
        repeat: expr
        repeat-expr: 4

      - id: floats8 # текстурные координаты = для 6 для tri, 8 для quad ? (как в o3d)
        type: f4
        repeat: expr
        repeat-expr: 8

      - id: polygon4 # tri or quad (где то да, а где то 65535) теперь больше похоже на грани, хотя бывает и по одному не 65535 значению
        type: u2
        repeat: expr
        repeat-expr: 4

      - id: short_array # 6 байт окончания / в конце может текстура, как в o3d ?
        type: u2
        repeat: expr
        repeat-expr: 3

#############################################

  short5:
    seq:
      - id: shorts
        type: u2
        repeat: expr
        repeat-expr: 5

#############################################
