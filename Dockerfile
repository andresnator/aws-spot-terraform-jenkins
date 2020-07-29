FROM ubuntu:16.04 

# Install Packages
RUN apt-get update -qq  && apt-get install -y \
    unzip \
    wget \
    git



RUN mkdir ~/bin    
RUN wget https://releases.hashicorp.com/terraform/0.12.28/terraform_0.12.28_linux_amd64.zip  \
    && unzip terraform_0.12.28_linux_amd64.zip \
    && mv terraform /usr/local/bin \
    && rm /terraform_0.12.28_linux_amd64.zip
   