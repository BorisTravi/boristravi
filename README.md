# DevOps Challenge

Prueba diseñada para ver tus habilidades en el mundo DevOps. Se evaluará las herramientas fundamentales que utilizamos tales como docker, Nomad/Consul, CI/CD y Terraform. 

¡Te deseamos mucho éxito!


## Tareas
* Dockerizar la aplicacion node
* Crear un pipleine para construir la imagen.
* Crear un Nomad job para desplegar la imagen en Nomad
* Crear un archivo Terraform para lanzar una instancia en EC2 con estas caracteristicas: 
  * Instancia **t3a.nano**
  * Disco con **20GB**
  * Acceso SSH a la IP **11.22.33.44**
  * Imagen base **Amazon Linux 2**
* Documentar las acciones realizadas 
  
**Importante**    
> Documentar correctamente el proceso es muy importante para asegurar que el equipo pueda continuar con las tareas de ser necesario. 

# Documentacion:
* Crear un archivo Dockerfile dentro de la raiz.
* En la primera Linea del archivo Dockerfile escribir siguiente codigo para crear la imagen:

  - FROM node.  -- > crear la imagen NODE
  - WORKDIR /usr/src/app ---> ubicacion en donde se va ejecutar
  - COPY package.json .  ---> copia el archivo json
  - RUN npm install. --> instala node

  - COPY . . ----> copia 

  - EXPOSE 8060  ---> se numera el puerto
  - CMD [ "npm", "start" ]

* docker build -t <prefijo o usuario>/node-web-app .
* docker images
* docker run -p 80:8060 -d <usuario>/node-web-app
* curl -i 80:8060
 
 
* Se crea un archivo jenkinsfile con el siguente codigo para crear un pipeline con una imagen Docker

pipeline {
agent {
        docker { image 'node:16.13.1-alpine' }
}
stages {
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}

* Se creo un archivo main con extension terraform para EC2
 
 provider "aws" {
  region = "us-west-2"
}



module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"

  ami                    = "ami-ebd02392"
  instance_type          = "t3a.nano"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = ["sg-12345678"]
  subnet_id              = "11.22.33.44"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
 

