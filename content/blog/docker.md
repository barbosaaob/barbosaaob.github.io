title: Docker cheat sheet
tags: comp
category: blog
date: 2020-10-08 09:26
modified: 2020-10-08 09:26
status: draft

# instalação
Siga as instruções do [guia de instalação do
Docker](https://docs.docker.com/get-docker/).

O comando abaixo garantirá que a instalação foi bem sucedida:

	# docker run hello-world

	Hello from Docker!
	This message shows that your installation appears to be working correctly.
	...

Os comandos podem ser experimentados sem a necessidade de instalação no
[Katacoda](https://www.katacoda.com/courses/docker).

# cheat sheet
### Procurando um container:

	docker search NOME_DO_CONTAINER

### Rodando um container no background:

	docker run -d NOME_DO_CONTAINER
	docker run -d --name NOME_PERSONALIZADO_DO_CONTAINER NOME_DO_CONTAINER

### Listando containers em execução e finalizados:

	docker ps     # apenas em execução
	docker ps -a  # inclui os containers finalizados

### Abrindo portas:

	docker run -d -p 80:80 nginx        # porta 80 do host mapeada na porta 80 do container
	docker run -d -p 192.168.1.1:80:80  # acesso ao container apenas pelo ip especificado
	docker run -d -p 80 nginx           # porta aleatória do host mapeada na porta 80 do container
	docker run -d -P nginx              # mapeia todas as portas expostas do container
	docker port CONTAINER 80            # lista mapeamento da porta 80 do CONTAINER

### Persistência de dados (volumes):

	docker run -d -v DIR_DO_HOST:DIR_DO_CONTAINER CONTAINER
	docker run -d -v DIR_DO_HOST:DIR_DO_CONTAINER:ro CONTAINER  # somente leitura
	docker run -d -v $PWD:DIR_DO_CONTAINER CONTAINER            # aceita variáveis de ambiente

### Executar um comando num container:

	docker run -it CONTAINER COMANDO   # inicia o container e executa o comando
	docker exec -it CONTAINER COMANDO  # executa o comando num container em execução
	docker run -it ubuntu bash         # inicia o container ubuntu e executa o bash

### Dockerfile

	$ cat > index.html << EOF
	<h1>Ola mundo!</h1>
	EOF

	$ cat > Dockerfile << EOF
	FROM httpd:latest
	COPY index.html /usr/local/apache2/htdocs/
	EOF
	
	$ docker build -t my-apache .
	Sending build context to Docker daemon  24.58kB
	Step 1/2 : FROM httpd:latest
	latest: Pulling from library/httpd
	d121f8d1c412: Pull complete 
	9cd35c2006cf: Pull complete 
	b6b9dec6e0f8: Pull complete 
	fc3f9b55fcc2: Pull complete 
	802357647f64: Pull complete 
	Digest: sha256:5ce7c20e45b407607f30b8f8ba435671c2ff80440d12645527be670eb8ce1961
	Status: Downloaded newer image for httpd:latest
	 ---> 417af7dc28bc
	Step 2/2 : COPY index.html /usr/local/apache2/htdocs/
	 ---> 50720feb4c98
	Successfully built 50720feb4c98
	Successfully tagged my-apache:latest

	
	$ docker images
	REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
	my-apache           latest              b33254ea14ad        About a minute ago   138MB
	httpd               latest              417af7dc28bc        3 weeks ago          138MB
	hello-world         latest              bf756fb1ae65        9 months ago         13.3kB
	
	# testando
	$ docker run -d -p 80:80 my-apache
	0df9706783418349e9727131ce6b669a7b776fba36766f41b6baf3c8d98a549f
	$ curl 127.0.0.1:80
	<h1>Ola mundo!</h1>

### Reaproveitando imagens (onbuild):

	$ cat > Dockerfile << EOF
	FROM httpd:latest
	ONBUILD COPY index.html /usr/local/apache2/htdocs/
	EOF
	$ docker build -t my-apache:onbuild .
	
	$ mkdir server1 server2
	
	$ cat > server1/index.html << EOF
	<h1>server 1</h1>
	EOF
	$ cat > server1/Dockerfile << EOF
	FROM my-apache:onbuild
	EXPOSE 80
	EOF
	
	$ cat > server2/index.html << EOF
	<h1>server 2</h1>
	EOF
	$ cat > server2/Dockerfile << EOF
	FROM my-apache:onbuild
	EXPOSE 80
	EOF
	
	$ cd server1; docker build -t server1 .; cd -
	$ cd server2; docker build -t server2 .; cd -
	
	$ docker run -d -p 8081:80 server1
	$ docker run -d -p 8082:80 server2
	
	$ curl 127.0.0.1:8081
	<h1>server 1</h1>
	$ curl 127.0.0.1:8082
	<h1>server 2</h1>

### .dockerignore

Arquivos e diretórios listados no arquivo .dockerignore são ignorados durante a
build da imagem.

### 
