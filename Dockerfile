FROM debian:buster
RUN apt-get -y update
RUN apt-get -y install curl git openssh-client rsync unzip jq amazon-ecr-credential-helper && \
	rm -rf /var/lib/apt/lists/*
RUN curl -s -o docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-"`curl -s https://api.github.com/repos/docker/docker-ce/releases/latest | jq -r .name`".tgz" && \
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	curl -s -L "https://github.com/docker/compose/releases/download/"`curl -s https://api.github.com/repos/docker/compose/releases/latest | jq -r .name`"/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
	chmod +x /usr/local/bin/docker-compose; \
	\
	dockerd --version; \
	docker --version; \
	docker-compose --version
# Installs AWSCLI
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
	unzip awscliv2.zip && \
	./aws/install && \
	rm -rf awscliv2.zip ./aws
