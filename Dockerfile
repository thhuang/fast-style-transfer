FROM tensorflow/tensorflow:0.11.0

# install packages
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    git wget && \
    apt-get autoclean && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/*

# install python moviepy
ENV PYTHON_VERSION 2.7
RUN pip2 install \
    numpy==1.11.2 \
    Pillow==3.4.2 \
    scipy==0.18.1 \
    moviepy==1.0.2

# setup working directory
WORKDIR /app

# clone the repository and setup python path
RUN git clone https://github.com/thhuang/fast-style-transfer.git && \
    cd fast-style-transfer && \
    git reset --hard 57d473706d92759a68543f6392bb7cfcb0a9a35b
ENV PYTHONPATH /app/fast-style-transfer/src

# default command
CMD python fast-style-transfer/evaluate.py --checkpoint input/udnie.ckpt --in-path input/stata.jpg --out-path output/stata-udnie.png
