MODELPACK ?= deepview/modelpack:2.0.14
CONVERTER ?= deepview/converter:2.5.23
UID ?= $(shell id -u)
GID ?= $(shell id -g)

INPUT_SHAPE ?= "1,$(shell docker run --rm -i -v ${CURDIR}:/workdir mikefarah/yq -r .shape params.yaml)"
DOCKER_LABELS := docker run --rm -i imega/jq .[0].Config.Labels

all: help

help:
	@echo "usage: make <train | deploy>"
	@echo "  train:     runs the training pipeline producing the keras checkpoint"
	@echo "  deploy:    deploys the model to an optimized deepviewrt model"

train: manifest .passwd
	docker run --rm -i --gpus=all \
		-u ${UID}:${GID} \
		--mac-address ${HOSTID} \
		-v ${CURDIR}:/work \
		-v ${HOME}/.gitconfig:/etc/gitconfig \
		-v ${CURDIR}/.passwd:/etc/passwd \
		${MODELPACK} \
		--license=modelpack.lic \
		--load=params.yaml \
		--dataset=dataset.yaml \
		--dvclive=dvclive

deploy: out/last.rtm out/best.rtm

%.rtm: %.h5 converter
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

modelpack: out
	@docker pull ${MODELPACK}
	@docker inspect ${MODELPACK} | ${DOCKER_LABELS} > dvclive/modelpack.json

converter: out
	@docker pull ${CONVERTER}
	@docker inspect ${CONVERTER} | ${DOCKER_LABELS} > dvclive/converter.json

manifest: modelpack converter

out:
	@mkdir -p out

.passwd:
	@getent passwd `whoami` > .passwd

