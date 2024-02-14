# Object Detection with ModelPack 3.0

ModelPack 3.0 has been released with the following features:

    - New Dataset Readers:  Dataset readers are now taken from `deepview-datasets`. This library offers support for multiple formats, 
                            including `daraknet` and `arrow`. This last one has been incorporated by using Polars library
    - New API: ModelPack API has been refactored to be used in standard keras way. Models train using the standard `model.fit()` 
                        and takes advantages of it. Losses are incorporated throughout the `model.compile()` function and DVC library
                        has been integrated to control MLOps pipeline, focused on automation and reproducibility
    - Training Speed:  This new release is about 10 times faster than previous releases while training a model and does 
                        use the GPU in a more efficient way

In this tutorial we are going to show you how to train ModelPack for object detection.

## Installation

For this demonstration we are going to use `playingcards` dataset. This dataset was collected in our facilities and even when it is not a production dataset
it plays a very important role when testing models locally. With this dataset you will be able to train a model in order to detect `cards`.  The first thing you should do is to clone this repository by calling:

```shell
git clone https://github.com/DeepViewML/playingcards.git
```

install `dvc` package by calling:

```shell
pip install dvc dvclive
```
 
## Downloading the Dataset

To download the dataset we should open a `console` or `terminal` in the `playingcards` folder. Once we are at that location, we should run the following command:

```shell
dvc pull
```

The command will download the dataset files from an S3 bucket along with previously trained models. 
Once dataset is stored in our side we are ready to start playing with experiments and saved metrics

## Reproduce Experiments

To reproduce the experiments we just need to run:

```shell
dvc repro
```

The command above will start a new training if only if any modeification was made to `detection.yaml` file. If no modification was made,
the command will exit and print the current state. To see stored experiments just type:

```shell
dvc exp show
```

or 

```shell
dvc metrics show
```



## Train ModelPack from basic configuration

## Deploy ModelPack on Maivin-2

## Train ModelPack with custom parameters

## Parameters Search with ModelPack and DVC

## Bring your own Dataset


