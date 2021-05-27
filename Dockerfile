FROM continuumio/miniconda:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        cmake \
        build-essential \
        gcc \
        g++ \
        git

# ARG CONDA_DIR=/opt/conda
# ENV PATH $CONDA_DIR/bin:$PATH

# RUN curl -sL https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o conda.sh && \
#     /bin/bash conda.sh -f -b -p $CONDA_DIR && \
#     export PATH="$CONDA_DIR/bin:$PATH" && \
#     conda config --set always_yes yes --set changeps1 no
RUN conda install python=3.7

RUN conda install -q -y numpy scipy scikit-learn pandas

RUN pip install -U pytest

RUN git clone --recursive --branch stable --depth 1 https://github.com/Microsoft/LightGBM

RUN apt-get autoremove -y && apt-get clean && \
    conda clean -a -y && \
    rm -rf /var/lib/apt/lists/*
