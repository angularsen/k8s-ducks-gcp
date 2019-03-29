# Managing Kubernetes on GCP with Terraform
This is a small test project to play with how to get started with Kubernetes on Google Cloud Platform using Terraform to configure and deploy the Kubernetes cluster.

This was setup on Windows 10 using WSL (Windows Subsystem for Linux) with the Ubuntu distro.
For shits and giggles I decided to also use the fancy [Fish shell](https://fishshell.com/), so some commands had to be altered to work with this shell, such using `()` instead of `$()`.

## Install Fish shell (totally unrelated, but totally cool)
```sh
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt-get update
sudo apt-get install fish
fish
```

### Make fish the default shell
Make sure `/usr/bin/fish` is added to file `/etc/shells`.
```sh
chsh -s to /usr/bin/fish
```

## Setup Google Cloud project
- [GCP - Create project](https://console.cloud.google.com/projectcreate)
- [GCP - APIs & Services](https://console.developers.google.com/apis) - enable `Compute Engine API` and `Kubernetes Engine API`

## Install Google Cloud SDK
Src: [https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu](https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu)
```sh
# Create environment variable for correct distribution
export CLOUD_SDK_REPO="cloud-sdk-"(lsb_release -c -s)

# Add the Cloud SDK distribution URI as a package source
# NOTE: This failed with "setpgid: Operation not permitted and still be successful" for me (might be WSL or the Fish shell?),
# so you can alternatively edit `/etc/apt/sources.list.d/google-cloud-sdk.list`
# and add the line being echoed, for me that line was `deb http://packages.cloud.google.com/apt cloud-sdk-xenial main`
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

### Initialize
If you set up Compute Engine API ealier, you will also be asked to select default region as part of this step.

```sh
gcloud init
```

## Terraform
### Install terraform on Windows WSL or Linux
Src: [https://askubuntu.com/a/983352/294618](https://console.cloud.google.com/projectcreate)
```
sudo apt-get install unzip
wget https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip
unzip terraform_0.11.13_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform --version
```

### Example: Kubernetes Cluster on GCE Example with NAT Gateway
Src: [Kubernetes Cluster on GCE Example with NAT Gateway](https://github.com/GoogleCloudPlatform/terraform-google-k8s-gce/tree/master/examples/k8s-gce-nat-kubenet)
Init gcloud
```sh
gcloud auth application-default login
export GOOGLE_PROJECT=(gcloud config get-value project)
```

Clone example repo
```sh
mkdir /mnt/c/dev/_k8s
cd /mnt/c/dev/_k8s
git clone https://github.com/GoogleCloudPlatform/terraform-google-k8s-gce.git
cd terraform-google-k8s-gce/examples/k8s-gce-kubenet
```

List all kubernetes versions
Should use a version supported by [GCE Kubernetes Release Notes](https://cloud.google.com/kubernetes-engine/docs/release-notes).

```sh
sudo vim /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
sudo apt-get update

apt-cache madison kubelet
```

Run terraform
```sh
terraform init
terraform plan
terraform apply
```
