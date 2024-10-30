FROM continuumio/miniconda3

# install dependencies 1
RUN conda install -y python=3.8 numpy && \
    conda install -y -c conda-forge ete3 && \
    conda clean -afy

# install dependencies 2
RUN apt-get update && \
    apt-get install -y gsl-bin libgsl0-dev libgslcblas0 libgsl-dev && \
    rm -rf /var/lib/apt/lists/*

# copy the binaries into the container
COPY Binaries/* /usr/local/bin/

# & make them executable and added to the path
RUN chmod +x /usr/local/bin/* && \
    export PATH="/usr/local/bin:$PATH"

# make SimPan globally available
COPY scr/SimPan.py /usr/local/bin/SimPan.py
RUN chmod +x /usr/local/bin/SimPan.py

# copy the sb.sh script (-> needed for singularity to "find" simpan)
COPY sb.sh /usr/local/bin/sb
RUN chmod +x /usr/local/bin/sb

WORKDIR /app

ENTRYPOINT ["bash"]
