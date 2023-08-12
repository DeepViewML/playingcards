MODELPACK ?= deepview/modelpack:2.0.14
CONVERTER ?= deepview/converter:2.5.22
UID ?= $(shell id -u)
GID ?= $(shell id -g)

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

train: manifest
	docker run --rm -it --gpus=all \
		-u ${UID}:${GID} \
		--mac-address ${HOSTID} \
		-v ${CURDIR}:/work \
		-v ${HOME}/.gitconfig:/etc/gitconfig \
		-v /etc/passwd:/etc/passwd \
		${MODELPACK} \
		--license=modelpack.lic \
		--load=params.yaml \
		--dataset=dataset.yaml \
		--dvclive=dvclive

deploy: out/last.rtm out/best.rtm

%.rtm: %.h5
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
		$< $@

manifest:
	mkdir -p out
	docker inspect ${CONVERTER} > out/converter.manifest
	docker inspect ${MODELPACK} > out/modelpack.manifest
