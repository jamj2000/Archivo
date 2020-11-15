# Como compilar Veyon usando contenedores Docker

## Compilar para Ubuntu 20.04

```console
git clone --recursive https://github.com/veyon/veyon.git && cd veyon
# git submodule update --init --recursive

docker run -it -v `pwd`:/veyon \ 
           veyon/ci.linux.ubuntu.focal \
           /veyon/.ci/linux.ubuntu.focal/script.sh /veyon /build
```

Al finalizar aparecerá en nuestro directorio actual un archivo `veyon_x.y.z-ubuntu-focal_amd64.deb`, siendo x.y.z la versión de veyon.


