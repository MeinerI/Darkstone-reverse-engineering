meta:
  id: brm
  file-extension: brm
  endian: le

seq:
  - id: count
    type: u4
  - id: blocks
    type: block
    repeat: expr
    repeat-expr: count

types:
  block:
    seq:
      - id: ins
        type: str
        encoding: ASCII
        size: 4
      - id: zero4
        type: u4
      - id: name
        type: str
        encoding: ASCII
        size: 60 # много доп инфы
      - id: float3
        type: f4
        repeat: expr
        repeat-expr: 3
      - id: block_end
        type: u4
