#
# Cloud Worldskils 2020
# CI - Terraform CI Container
# 

        
FROM alpine:3.12
    
RUN apk update && apk add bash
ENV TF_VERSION=0.12.29
RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip \
    && unzip terraform_${TF_VERSION}_linux_amd64.zip && rm terraform_${TF_VERSION}_linux_amd64.zip \
    && mv terraform /usr/bin/terraform

RUN wget "$(wget -O- https://api.github.com/repos/terraform-linters/tflint/releases/latest | grep -o -E "https://.+?_linux_amd64.zip")" -O tflint.zip \
    && unzip tflint.zip && rm tflint.zip \
    && mv tflint /usr/bin/tflint

ENTRYPOINT bash
