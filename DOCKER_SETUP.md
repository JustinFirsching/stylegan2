Perform the below steps in order.

## 1. INSTALL DOCKER

DOCS: https://docs.docker.com/engine/install/ubuntu/ 

``` bash
sudo apt-get remove docker docker-engine docker.io containerd runc (NOTE: None of these were installed)
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
"deb [arch=amd64] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) \
stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

<hr><br>

## 2. INSTALL DOCKER NVIDIA CONTAINER RUNTIME
DOCS: https://docs.docker.com/config/containers/resource_constraints/#gpu 
<br>
DOCS: https://nvidia.github.io/nvidia-container-runtime/

``` bash
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
systemctl restart docker
```

<hr><br>

## 3. ADD USER TO docker GROUP (The remaining users should be added)
(user may need to log out and back in for change to take effect)
``` bash
sudo usermod -aG docker bakerdp   
```

<hr><br>

## 4. CLONE THE CONTAINER IMAGE INPUTS
    git clone https://github.com/derek-baker/stylegan2.git . 

<hr><br>

## 5. BUILD THE CONTAINER IMAGE 
(This should pull several of the layers from local cache rather than downloading)
``` bash
cd <DIR_CONTAINING_CLONED_REPO>
docker build --tag sg2:1.0 .
```

<hr><br>

## 6. RUN THE CONTAINER INTERACTIVELY 
DOCS: https://docs.docker.com/engine/reference/commandline/run/
<br>
(Omit the '--gpus all' if you don't have a GPU)
``` bash
# Run the container with a volume mounted with a two-way bind, 
# and a mounted volume containing a readonly dataset. 
docker run -it --rm --gpus all -v $(pwd):/src -v /{path}/{to}/{data}:/data:ro sg2:1.0 bash

# To smoke test the setup (from inside the stylegan2 dir [the container work dir])
nvcc test_nvcc.cu -o test_nvcc -run

# Assuming the smoke test looks good, you can now edit Python source code on 
# the host machine, and those changes will be reflected in the container 
# (where you have an interactive session capable of running said code).

# When you're ready to exit the container
exit
```
    





    
    

