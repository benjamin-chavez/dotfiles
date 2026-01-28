# qmk/keychron_k2_he/Dockerfile

FROM qmkfm/qmk_cli:latest

ARG QMK_REPO=https://github.com/Keychron/qmk_firmware.git
ARG QMK_BRANCH=hall_effect_playground

RUN git clone -b ${QMK_BRANCH} --depth 1 ${QMK_REPO} /qmk_firmware

WORKDIR /qmk_firmware

RUN git submodule update --init --recursive --depth 1
RUN pip install -r requirements.txt