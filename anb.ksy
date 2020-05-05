meta:
  id: anb
  file-extension: anb
  endian: le

seq:
  - id: one
    type: u2
  - id: block_count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: block_count

types:

  block:
    seq:

    - id: str_count # 03 00
      type: u2
    - id: string64s
      type: str
      size: 64
      encoding: ASCII
      repeat: expr
      repeat-expr: str_count

    - id: count4
      type: u4
      repeat: expr
      repeat-expr: 4

    - id: short_count
      type: u4
    - id: short_value
      type: u2
      repeat: expr
      repeat-expr: short_count
    - id: str_values
      type: str
      size: 64
      encoding: ASCII
      repeat: expr
      repeat-expr: short_count
    
    - id: value_count
      type: u4
    - id: bytes
      type: bytes
      repeat: expr
      repeat-expr: value_count

    - id: delimetr
      type: u1
      repeat: expr
      repeat-expr: 16

  bytes:
    seq:
      - id: number
        type: u4
      - id: short_value # 01 00
        type: u2
      - id: flag # םא סאלמל הוכו םו פכאד :)
        type: u4

      - id: bytes
        type: f4
        repeat: expr
        repeat-expr: (flag+2)*3
