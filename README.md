# ModelPack - Playing Cards - YoloV7

This projects includes a new dataset configuration file that enables training on yolov7.
The new file is named `dataset-yolov7.yaml` and includes the dataset description

# Training

To train yolov7 on this dataset we need to run the following steps:

`git clone https://github.com/WongKinYiu/yolov7.git`

Once the source code is in out PC, we need to open a new terminal in yolov7 folder and clone playing cards dataset

`git clone https://github.com/DeepViewML/playingcards.git`

After cloning the dataset it is needed to checkout the right branch: `git checkout yolov7-dataset` and run `dvc pull` to retrieve dataset files
The final directory structure should look like this:

```bash
.
├── LICENSE.md
├── README.md
├── __pycache__
├── cfg
├── data
├── deploy
├── detect.py
├── export.py
├── figure
├── hubconf.py
├── inference
├── models
├── paper
├── playingcards  # see playingcards project in here
├── requirements.txt
├── runs
├── scripts
├── test.py
├── tools
├── train.py
├── train_aux.py
├── utils
└── yolov7.pt
```

For training the model, just run

`python train.py --data playingcards\dataset-yolov7.yaml --cfg cfg\training\yolov7-tiny.yaml --weights yolov7.pt`  

## Requirements

- ModelPack License, contact info@au-zone.com to request a trial license.
- Environment variable HOSTID configured according to the license requirements.
- DVC installed into system or virtual environment.
- Docker.

## Instructions

Our example ModelPack training pipelines are built using DVC to manage datasets and parameters.  Stages are provided for training, validation, and optimization to a quantized DeepViewRT model ready for deployment to the embedded edge device.

To reproduce the pipeline from the current commit you can run the `dvc repro` command.  If you wish to experiment with parameters then `dvc exp run` is what you're looking for.  Please refer to the DVC User Manual for further details.

# License

This project is licensed under the AGPL-3.0 or under the terms of the DeepView AI Middleware Commercial License.

# Support

Commercial Support is provided by Au-Zone Technologies through our support site https://support.deepviewml.com.

