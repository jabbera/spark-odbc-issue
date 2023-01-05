FROM ubuntu:jammy

COPY sparkodbc.zip /tmp/

# Install base utilities
RUN apt-get update && \
    apt-get install -y build-essential wget unixodbc unzip libsasl2-modules-gssapi-mit valgrind

RUN unzip /tmp/sparkodbc.zip -d /tmp && \
    dpkg -i /tmp/simba*.deb && \
    echo "[Simba Spark ODBC Driver]" >> /etc/odbcinst.ini && \
    echo "Driver=/opt/simba/spark/lib/64/libsparkodbc_sb64.so" >> /etc/odbcinst.ini

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda && \
     sed -i '1s/^/[ODBC]\nPooling = Yes\n/' /etc/odbcinst.ini

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

COPY create-env.sh /tmp/

RUN /tmp/create-env.sh

COPY pyodbc_bug.py /tmp/

ENTRYPOINT [ "valgrind", "python", "/tmp/pyodbc_bug.py" ]