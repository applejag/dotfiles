; extends

(block_mapping_pair
  key: (flow_node) @_run
  (#any-of? @_run "script")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "javascript")))

(block_mapping_pair
  key: (flow_node) @_run
  (#any-of? @_run "script")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "javascript")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_run
  (#any-of? @_run "script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "javascript")))))

(block_mapping_pair
  key: (flow_node) @_run
  (#any-of? @_run "script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "javascript")
          (#offset! @injection.content 0 1 0 0))))))

