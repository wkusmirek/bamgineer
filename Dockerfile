FROM biodatageeks/bdg-sequila:0.5.2

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y \
            wget \
            bzip2 \
            gcc \
            g++ \
            make \
            zlib1g-dev \
            libncurses5-dev \
            git \
            python \
            python-pip \
            vim \
            openjdk-8-jre \
            nano

RUN cd /

# samtools/1.2
RUN wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2 && \
  tar xjf samtools-1.2.tar.bz2 && \
  cd samtools-1.2 && make
ENV PATH=$PATH:/samtools-1.2

# bedtools/2.26.0
RUN apt-get install bedtools

# vcftools/0.1.15
RUN apt-get install -y vcftools

# bamUtil/1.0.14
RUN wget https://github.com/statgen/bamUtil/archive/master.tar.gz && \
  tar -xzf master.tar.gz && \
  cd bamUtil-master && \
  make cloneLib && \
  make && \
  make install INSTALLDIR=/bamUtil-install

# sambamba/0.5.4
RUN wget https://github.com/biod/sambamba/releases/download/v0.5.4/sambamba_v0.5.4_linux.tar.bz2 && \
  tar xjf sambamba_v0.5.4_linux.tar.bz2
RUN chmod 777 sambamba_v0.5.4

# beagle 
RUN wget https://faculty.washington.edu/browning/beagle/beagle.09Nov15.d2a.jar

# python packages
RUN pip install pysam==0.8.4
RUN pip install pybedtools
RUN pip install PyVCF==0.6.7
RUN pip install pathos
RUN pip install pandas

# R packages
RUN Rscript -e "install.packages(c('data.table', 'reshape', 'dplyr'), lib='/usr/local/lib/R/site-library')"

# bamgineer
RUN git clone --single-branch --branch sequila https://github.com/wkusmirek/bamgineer.git

