def add_margin_bbox(bbox, img_size, margin_percent_x=0.01, margin_percent_y=0.05):
    margin_x = margin_percent_x*bbox[1]
    margin_y = margin_percent_y*bbox[0]
    bbox[0] = int(np.maximum(bbox[0]-margin_x, 0))
    bbox[1] = int(np.maximum(bbox[1]-margin_y, 0))
    bbox[2] = int(np.minimum(bbox[2]+margin_x, img_size[1]))
    bbox[3] = int(np.minimum(bbox[3]+margin_y, img_size[0]))
