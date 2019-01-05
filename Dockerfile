FROM python:3.6-jessie

# install packages
RUN apt-get update && -y apt-get install vim

# install conda
# do not use conda if there are image size concerns.
# if size is a concern install via pip or with package instructions.
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p ./miniconda
ENV PATH="/miniconda/bin:$PATH"

# add channels
# do not change this order
RUN conda config --add channels defaults
RUN conda config --add channels bioconda
RUN conda config --add channels conda-forge

# install some bioinformatics tools
RUN conda install -y samtools

# install pytest for testing
RUN conda install -y pytest

# set up working directory
COPY . /mytool
WORKDIR /mytool

CMD /bin/bash
