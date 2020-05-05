meta:
  id: mbr
  file-extension: mbr
  endian: le

#############################################

seq:
  - id: one
    type: u2
  - id: block_count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: block_count

#############################################

types:

  block:
    seq:

    - id: str_count # 02 00
      type: u2
    - id: string48s
      type: str
      size: 48
      encoding: ASCII
      repeat: expr
      repeat-expr: str_count

    - id: floats_q
      type: f4
      repeat: expr
      repeat-expr: 27

    - id: count_triplet
      type: u4

    - id: count_quadrat
      type: u4

    - id: triplets
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
      - id: bytes4
        type: u1
        repeat: expr
        repeat-expr: 4

      - id: floats8
        type: f4
        repeat: expr
        repeat-expr: 8

      - id: weight4 # где то похоже на грани 
        type: u2
        repeat: expr
        repeat-expr: 4
       
      - id: short_array # a5_20_00_00_0f_00
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
