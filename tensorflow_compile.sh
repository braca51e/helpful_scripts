#compile sum_graph
bazel build tensorflow/tools/graph_transforms:summarize_graph
#compile freeze_gr
bazel build tensorflow/python/tools:freeze_graph
