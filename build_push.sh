docker build -t plaquette/simpan:dev .

# start an interactive session inside the container
docker run -it plaquette/simpan:dev


docker push plaquette/simpan:dev 
