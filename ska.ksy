meta:
  id: ska
  file-extension: ska
  endian: le
#############################################
seq:
  - id: one
    type: u2
  - id: block_count # количество блоков
    type: u4
  - id: blocks 
    type: block
    repeat: expr
    repeat-expr: block_count
#############################################
types:
#############################################
  block:
    seq:
    - id: short_value
      type: u2
    - id: string_not
      type: string64x66
      repeat: expr
      repeat-expr: 66
#############################################
  string64x66:
    seq:
      - id: str
        type: str
        size: 4
        encoding: ASCII
      - id: floats8
        type: f4
        repeat: expr
        repeat-expr: 8
      - id: four
        size: 4
      - id: shorts3
        type: u2
        repeat: expr
        repeat-expr: 3
      - id: hz
        type: u2
      - id: bytes
        size: 4
        repeat: expr
        repeat-expr: 4
