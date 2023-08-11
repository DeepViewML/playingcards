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
- DVC installed into system or virtual environment.
- Docker.

## Instructions

Our example ModelPack training pipelines are built using DVC to manage datasets and parameters.  Stages are provided for training, validation, and optimization to a quantized DeepViewRT model ready for deployment to the embedded edge device.

To reproduce the pipeline from the current commit you can run the `dvc repro` command.  If you wish to experiment with parameters then `dvc exp run` is what you're looking for.  Please refer to the DVC User Manual for further details.

# License

This project is licensed under the AGPL-3.0 or under the terms of the DeepView AI Middleware Commercial License.

# Support

Commercial Support is provided by Au-Zone Technologies through our support site https://support.deepviewml.com.

