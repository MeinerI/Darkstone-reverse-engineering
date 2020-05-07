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
    - id: string64x66
      type: str
      size: 64
      encoding: ASCII
      repeat: expr
      repeat-expr: 66
#############################################
