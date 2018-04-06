# Odoo Docker

Este repositório traz informações para se executar o Odoo e a localização em conjunto. Foi criado um `DockerFile` novo para o Odoo que traz novas libs e packages. Pode ser usado individualmente e também no `docker-compose` (recomendando).

## Baixando os arquivos
Seguem os passos:
1. Crie um pasta de trabalho e acesse o terminal a partir desta pasta.
```
mkdir minha-pasta
cd minha-pasta
```

2. Clonar o repositório para a pasta de trabalho:
```
git clone https://github.com/BradooTech/odoo-docker.git
```
3. Entre na pasta que foi baixada
```
cd odoo-docker
```
4. Execute o comando abaixo para baixar as libs complementares:
```
./clone.sh
```

## Utilização do Docker Compose

Após a instalação do Docker (que se encontra abaixo), clona-se este diretório e dentro dele está o ambiente do docker-compose. Alguns comandos para gerenciar seu docker:

Para a primeria utilização é necessário compilar as modificações no Odoo (feita via `DockerFile`), esta operação pode demorar alguns instantes dependendo da sua conexão.

	docker-compose build

Para subir a instâcia do docker compose executa-se o comando abaixo (ela criará um container com odoo e um com postgres):

	docker-compose up

O comando abaixo derruba todos os containers que foram criados para o esse compose:

	docker-compose down

O mesmo comando acima mas ele remove os volumes pertencentes aos containers:

	docker-compose down -v


### Addons

Para a utilização de addons externos (localização, customização, etc), recomenda-se mapear a pasta da seguinte forma:

- Caso seja uma coleção de módulos criar uma pasta na raiz, ao lado de config, addons, e mapeá-la no `docker-compose.yml`. Conforme árvore abaixo:

```
	.
	├── addons
	├── config
	└── odoo-brasil
```
- Modulos únicos (a pasta em si já traz o módulo), coloca-se na pasta `addons`. Exemplo:

```
	.
	├── addons
	│   └── bradoo
	├── config
	└── odoo-brasil
```

O arquivo no qual será mapeado é o `docker-compose.yml` ficando como no trecho abaixo:

```
	volumes:
	  - odoo-web-data:/var/lib/odoo
	  - ./config:/etc/odoo
	  - ./addons:/mnt/extra-addons:ro,Z
	  - ./odoo-brasil:/mnt/odoo-brasil:ro,Z
```

Todos devem apontar para o diretório `/mnt/`. No caso acima ficou `/mnt/odoo-brasil`, caso fosse uma pasta chamada odoo-oca, ficaria `/mnt/odoo-oca`.



## Instalação Docker (Ubuntu)

Recomenda-se seguir o tutorial oficial do docker-ce para sua instalação, mas pode-se usar o código abaixo:

### Docker CE

Atualize o sistema:

	sudo apt-get update

Instale os pacotes necessários:

	sudo apt-get install apt-transport-https ca-certificates curl software-properties-common

Adicione a key do docker no sistema:

	sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

Adicione o repositório:

	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs) stable"

Atualizae os repositórios:

	sudo apt-get update

Instale o docker-ce:

	sudo apt-get install docker-ce

Verifique se o docker foi instalado corretamente:

	sudo docker -v

Adicione o usuario docker:

	sudo groupadd docker

Adicione o usuario no grupo de root:

    sudo usermod -aG docker $USER

Deslogue do usuario e logue novamente, execute o comando abaixo:

	docker -v

Caso o comando tenha sido bem sucedido você não precisará mais usar o sudo para executar comandos docker.



### Docker Compose

Faça o download do binário do docker-compose e adiciona no bin do ubuntu:

	sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

Da permissão para execução:

	chmod +x /usr/local/bin/docker-compose

Verifique se funciona corretamente:

	docker-compose -v
