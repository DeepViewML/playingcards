# ModelPack - Playing Cards

This project demonstrates a ModelPack end-to-end training pipeline using the Playing Cards dataset and producing a quantized DeepViewRT model for performing card detection and classification using VisionPack on an embedded edge device.

The produced DeepViewRT model can be run on the embedded edge device using the VisionPack detection samples, they come in a variety of flavours depending on the input source and result output options.

- detectimg is used for running detection on the command-line using images.
- detectgl is used for running detection with a live camera and display with overlays.

# Pre-Trained

We provide pre-trained model as releases to this project.  Releases are fully traceable through DVC to review versions of software, datasets, and parameters used for training.

# Training

We provide all the configurations and datasets to re-train this model, simply follow the instructions below or review the project's GitHub Actions configuration.

## Requirements

- ModelPack License, contact info@au-zone.com to request a trial license.
- Environment variable HOSTID configured according to the license requirements.
- Conda or compatible environment, we suggest mamba or micromamba.

## Installation

ModelPack can be installed through pip but we recommend doing so within a Conda environment to manage the dependencies around TensorFlow and CUDA as it can otherwise be challenging to get the correct CUDA environment configured.  A `conda.lock` file is provided to recreate our known good environment.  If you wish to create your own environment refer to the bottom of this readme for instructions on re-creating from scratch.

Once the environment is created it should be activated and then the requirements.txt installed with pip, this installs the packages not provided by conda.

```shell
conda create --name playingcards --file conda.lock
conda activate playingcards
pip install -r requirements.txt
```

## Instructions

Our example ModelPack training pipelines are built using DVC to manage datasets and parameters.  Stages are provided for training, validation, and optimization to a quantized DeepViewRT model ready for deployment to the embedded edge device.

To reproduce the pipeline from the current commit you can run the `dvc repro` command.  If you wish to experiment with parameters then `dvc exp run` is what you're looking for.  Please refer to the DVC User Manual for further details.

## Custom Environment

The conda/mamba environment was initially created the following command.  Once created you must activate the environment and install the packages from requirements.txt as noted above.

```shell
mamba create --name playingcards python=3.11 tensorflow=2.15.0 matplotlib-base scipy scikit-learn scikit-image keras "networkx<3" path h5py cryptography pathlib psutil pycryptodome jq dvc dvc-s3 dvclive albumentations=1.3.1 tensorflow-hub tf-keras
```

# License

This project is licensed under the AGPL-3.0 or under the terms of the DeepView AI Middleware Commercial License.

# Support

Commercial Support is provided by Au-Zone Technologies through our support site https://support.deepviewml.com.

