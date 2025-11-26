meta:
  id: op1
  file-extension: mb
  endian: le
seq:
  - id: header
    type: header
  - id: offsets
    type: u8
    repeat: expr
    repeat-expr: header.num_blocks + 1
  - id: blocks
    type: compressed_block(_index)
    repeat: expr
    repeat-expr: header.num_blocks
types:
  header:
    seq:
      - id: unused
        type: u1
        repeat: expr
        repeat-expr: 16
      - id: basename
        type: str
        size: 16
        encoding: ASCII
      - id: num_elements
        type: u8
      - id: kk_index
        type: u4
      - id: max_dtc
        type: u4
      - id: block_size
        type: u4
      - id: num_blocks
        type: u4
      - id: nrows
        type: u1
      - id: ncols
        type: u1
      - id: side
        type: u1
        enum: side
        doc: side to move
      - id: metric
        type: u1
      - id: compression
        type: u1
        enum: compression
      - id: index_size
        type: u1
      - id: format_type
        type: u1
        doc: unused / reserved
      - id: list_element_size
        type: u1
  compressed_block:
    params:
      - id: idx
        type: u4
    seq:
      - id: data
        size: _root.offsets[idx + 1] - _root.offsets[idx]
        process: zstd
enums:
  compression:
    0: none
    2: zstd
  side:
    0: white
    1: black
  metric_type:
    1: dtc
