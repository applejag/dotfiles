; extends

((comment) @injection.content
  (#set! injection.language "comment"))

; GitHub Actions workflows
(block_mapping_pair
  key: (flow_node) @_script
  (#any-of? @_script "run")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "bash")))

(block_mapping_pair
  key: (flow_node) @_script
  (#any-of? @_script "run")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_script
  (#any-of? @_script "run")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "bash")))))

(block_mapping_pair
  key: (flow_node) @_script
  (#any-of? @_script "run")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "bash")
          (#offset! @injection.content 0 1 0 0))))))

; GitHub Action: actions/github-script
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

; Prometheus alert rules
(block_mapping_pair
  key: (flow_node) @_expr
  (#any-of? @_expr "expr")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "promql")))

(block_mapping_pair
  key: (flow_node) @_expr
  (#any-of? @_expr "expr")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "promql")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_expr
  (#any-of? @_expr "expr")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "promql")))))

(block_mapping_pair
  key: (flow_node) @_expr
  (#any-of? @_expr "expr")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "promql")
          (#offset! @injection.content 0 1 0 0))))))
