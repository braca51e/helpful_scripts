#Export inference graph to the pb-file
cd <SLIM_DIR>/slim
python3 export_inference_graph.py \
    --alsologtostderr \
    --model_name=inception_v1 \
    --output_file=/tmp/inception_v1_inf_graph.pb
    
#Freeze inference graph
cd <TF_HOME>
bazel build tensorflow/python/tools:freeze_graph
bazel-bin/tensorflow/python/tools/freeze_graph \
    --input_graph=/tmp/inception_v1_inf_graph.pb \
    --input_checkpoint=<CKPT_DIR>/inception_v1.ckpt \
    --input_binary=true \
    --output_graph=/tmp/frozen_inception_v1.pb \
    --output_node_names=InceptionV1/Logits/Predictions/Reshape_1
    
#Summarize graph
cd <TF_HOME>
bazel build tensorflow/tools/graph_transforms:summarize_graph
bazel-bin/tensorflow/tools/graph_transforms/summarize_graph --in_graph=/tmp/inception_v1_inf_graph.pb
#Run in a frozen model
bazel-bin/tensorflow/tools/graph_transforms/summarize_graph --in_graph=/tmp/frozen_inception_v1.pb
