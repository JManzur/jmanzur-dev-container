FROM ubuntu:latest
LABEL maintainer="@JManzur - https://jmanzur.com"

# Update and security fix:
RUN apt-get update

# Install basic tools:
RUN apt-get install -y openssl git wget gnupg software-properties-common curl vim unzip htop tree jq telnet

# Install Terraform:
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update &&  apt-get install terraform -y

# Install oh-my-bash:
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended

# Install AWS CLI:
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN bash ./aws/install

# Create a Working Directory:
RUN mkdir /workspace
WORKDIR /workspace