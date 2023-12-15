type path = int arc list





let max_flow graph source sink =
  let list_paths = all_paths_from_source_to_sink graph source sink in
  List.iter (sub_label min_label i) list_paths