## This include gatk and samtools
FROM broadinstitute/gatk:4.2.6.0

## Update the cloud key??? 
##https://stackoverflow.com/questions/77385641/cli-gcloud-the-following-signatures-could-not-be-verified-because-their-public
RUN curl -O https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    && apt-key add apt-key.gpg 

## install git to clone t1k zlib needs to be updated for t1k 
RUN apt-get update && apt-get install -y git zlib1g-dev parallel

## Remember that you should use && to run multiple lines wihtout spinning up multple docker RUN
## instaling bowtie2 
RUN mkdir ~/bin && cd ~/bin/ && wget https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.4.2/bowtie2-2.4.2-sra-linux-x86_64.zip/download && unzip download

ENV PATH="${HOME}/bin/bowtie2-2.4.2-sra-linux-x86_64:${PATH}"

## now install bwa
RUN cd ~/bin/ && wget https://github.com/lh3/bwa/archive/refs/tags/v0.7.18.tar.gz && tar -xzf v0.7.18.tar.gz && cd bwa-0.7.18 && make 

ENV PATH="${HOME}/bin/bwa-0.7.18/:${PATH}"


## Now clone the github repo with the indexed reference fasta
RUN cd ~/bin/ && git clone https://github.com/Jacobog02/pathogen_reference.git && cd ~/bin/pathogen_reference/ref/ && bash index_stuff.sh
