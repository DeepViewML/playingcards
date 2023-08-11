MODEL = last
VERSION = 2.0.13
REGISTRY = deepview
MODELPACK = ${REGISTRY}/modelpack:${VERSION}
CONVERTER = deepview/converter:2.5.22
SESSION = out
UID = $(shell id -u)
GID = $(shell id -g)

INPUT_SHAPE ?= "1,$(shell docker run --rm -it -v ${CURDIR}:/workdir mikefarah/yq -r .shape params.yaml)"

all: help

help:
	@echo "usage: make <pull | train | deploy>"
	@echo "  pull:      pull latest images for ${MODELPACK} and ${CONVERTER}"
	@echo "  train:     runs the training pipeline producing the keras checkpoint"
	@echo "  deploy:    deploys the model to an optimized deepviewrt model"

pull:
	docker pull ${MODELPACK}
	docker pull ${CONVERTER}

train:
	docker run --rm -it --gpus=all \
		-u ${UID}:${GID} \
		--mac-address ${HOSTID} \
		-e DEEPVIEW_LICENSES=/work \
		-v ${CURDIR}:/work \
		${MODELPACK} \
		--load=params.yaml \
		--checkpoints=. \
		--logs=. \
		--dataset=dataset.yaml \
		--session-name=${SESSION}

deploy:
	docker run --rm -it \
		-u ${UID}:${GID} \
		-v ${CURDIR}:/work \
		${CONVERTER} \
		--default_shape ${INPUT_SHAPE} \
		--quantize \
		--quant-tensor \
		--quant_normalization unsigned \
		--samples dataset/images/quant \
		--input_type uint8 \
		--output-type int8 \
		${SESSION}/${MODEL}.h5 ${SESSION}/${MODEL}.rtm

manifest:
	docker inspect ${CONVERTER} > out/converter.manifest
	docker inspect ${MODELPACK} > out/modelpack.manifest
