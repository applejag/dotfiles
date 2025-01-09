; extends

((comment) @injection.content
  (#set! injection.language "comment"))

; GitHub Actions workflows
(block_mapping_pair
  key: (flow_node) @_run_bash
  (#any-of? @_run_bash "run")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "bash")))

(block_mapping_pair
  key: (flow_node) @_run_bash
  (#any-of? @_run_bash "run")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "bash")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_run_bash
  (#any-of? @_run_bash "run")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "bash")))))

(block_mapping_pair
  key: (flow_node) @_run_bash
  (#any-of? @_run_bash "run")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "bash")
          (#offset! @injection.content 0 1 0 0))))))

; GitHub Action: actions/github-script
(block_mapping_pair
  key: (flow_node) @_script_js
  (#any-of? @_script_js "script")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "javascript")))

(block_mapping_pair
  key: (flow_node) @_script_js
  (#any-of? @_script_js "script")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "javascript")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_script_js
  (#any-of? @_script_js "script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "javascript")))))

(block_mapping_pair
  key: (flow_node) @_script_js
  (#any-of? @_script_js "script")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "javascript")
          (#offset! @injection.content 0 1 0 0))))))

; Prometheus alert rules
(block_mapping_pair
  key: (flow_node) @_expr_promql
  (#any-of? @_expr_promql "expr" "series")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "promql")))

(block_mapping_pair
  key: (flow_node) @_expr_promql
  (#any-of? @_expr_promql "expr" "series")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "promql")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_expr_promql
  (#any-of? @_expr_promql "expr" "series")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "promql")))))

(block_mapping_pair
  key: (flow_node) @_expr_promql
  (#any-of? @_expr_promql "expr" "series")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "promql")
          (#offset! @injection.content 0 1 0 0))))))

(block_mapping_pair
  key: (flow_node) @_expr_promql
  (#any-of? @_expr_promql "expr" "series")
  value: (flow_node
    (single_quote_scalar) @injection.content
    (#set! injection.language "promql")
    (#offset! @injection.content 0 1 0 0)))

; Elastic Filebeat hints
(block_mapping_pair
  key: (flow_node) @_hints_raw
  (#match? @_hints_raw "^co\\.elastic\\.logs(\\.\\w+)?/raw$")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "json")))

(block_mapping_pair
  key: (flow_node) @_hints_raw
  (#match? @_hints_raw "^co\\.elastic\\.logs(\\.\\w+)?/raw$")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "json")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_hints_raw
  (#match? @_hints_raw "^co\\.elastic\\.logs(\\.\\w+)?/raw$")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "json")))))

(block_mapping_pair
  key: (flow_node) @_hints_raw
  (#match? @_hints_raw "^co\\.elastic\\.logs(\\.\\w+)?/raw$")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "json")
          (#offset! @injection.content 0 1 0 0))))))

; Elastic Logstash config
(block_mapping_pair
  key: (flow_node) @_extrafilters_ruby
  (#any-of? @_extrafilters_ruby "extraFilters")
  value: (flow_node
    (plain_scalar
      (string_scalar) @injection.content)
    (#set! injection.language "ruby")))

(block_mapping_pair
  key: (flow_node) @_extrafilters_ruby
  (#any-of? @_extrafilters_ruby "extraFilters")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "ruby")
    (#offset! @injection.content 0 1 0 0)))

(block_mapping_pair
  key: (flow_node) @_extrafilters_ruby
  (#any-of? @_extrafilters_ruby "extraFilters")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (flow_node
          (plain_scalar
            (string_scalar) @injection.content))
        (#set! injection.language "ruby")))))

(block_mapping_pair
  key: (flow_node) @_extrafilters_ruby
  (#any-of? @_extrafilters_ruby "extraFilters")
  value: (block_node
    (block_sequence
      (block_sequence_item
        (block_node
          (block_scalar) @injection.content
          (#set! injection.language "ruby")
          (#offset! @injection.content 0 1 0 0))))))
