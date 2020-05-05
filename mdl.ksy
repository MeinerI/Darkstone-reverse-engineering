#############################################
# в sub_block содержится какая то инфа
#############################################

meta:
  id: mdl
  file-extension: mdl
  endian: le

#############################################

seq:
  - id: one # 01 
    type: u2

  - id: count
    type: u4

  - id: blocks
    type: block
    repeat: expr
    repeat-expr: count

#############################################

types:

#############################################

  block:
    seq:
      - id: oneb
        type: u2
      - id: count
        type: u4      
      - id: string_f
        type: str
        size: 64
        encoding: ASCII

      - id: sub_blocks
        type: sub_block
        repeat: expr
        repeat-expr: count

#############################################

  sub_block:
    seq:
      - id: oneb
        type: u2
      - id: strings
        type: str
        size: 64
        encoding: ASCII
        repeat: expr
        repeat-expr: 10

#############################################
