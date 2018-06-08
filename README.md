# CI/CD Hygieia + Terraform + Docker Swarm on AWS EC2.

Installation and configuration of Hygieia dashboard on AWS using Terraform with docker CE. This is a for from https://github.com/capitalone/Hygieia

These creates and contains: 

*Jenkins node 
*Docker Swarm cluster of 1 master and 2 slaves
* CI/CD Jenkins scripted pipeline to deploy the app upon a change.

## Getting Started

Hygieia is a single, configurable, easy-to-use dashboard to visualize near real-time status of the entire delivery pipeline. The health of the continuous delivery pipeline, from code commit to production deployment, with all the necessary information around health and quality of the software, is essential for any DevOps Organization.

### Prerequisites

-Create and AWS account.

AWS account and a "Small tier" for Jenkins (Free tier will ran out of resources at the build process) 

https:aws.amazon.com/free

- Create a docker hub and docker cloud free accounts 

We will use this to publish our images from our scripted pipeline and trigger a deploy to swarm upon a change in the repo.

https://hub.docker.com/
https://cloud.docker.com

Clone or Fork this repo to your localhost.

```git clone https://github.com/jzuniga184/Hygieia-1.git```

### Installing

Here are the steps you need to follow to install your development enviroment, note this steps are for a mac running version 10.13.2

From localhost (mac)

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install terraform
sudo easy_install pip
sudo pip install ansible
sudo pip install boto
sudo pip install six
curl -o /usr/local/bin/ec2.py https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py
curl -o /usr/local/bin/ec2.ini https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
```

From AWS

Create security credentials Go To https://console.aws.amazon.com/iam/home?#/security_credential under "Access keys (access key ID and secret access key" and create a pair of keys. Note your Access key ID and your Secret Access Key.

From the EC2 dashboard launch a new from Amazon Machine Image (AMI) and note down the AMI number we will need this for Terraform.

Once you do that export these variables to your LOCALHOST.

```
export AWS_ACCESS_KEY_ID=''
export AWS_SECRET_ACCESS_KEY=''
export ANSIBLE_HOSTS=PATH
export EC2_INI_PATH=PATH
export DOCKER_ID_USER="<your-docker-ID-NOT-email"
```

## Creating Terraform instances on AWS

From your localhost on $LOCALHOST/terraform/0.11.7/bin/ Do:

```ec2.py --list```

```terraform init```

```terraform play```

```terraform apply```

```./docker-swarm-cluster/playbook.yml -i ec2.py -u centos  --private-key=$PATH/clusterkp.pem```

These will a docker swarm instance of 1 master and 2 slaves on AWS free tier.


## Installing dependencies for Jenkins on AWS

From your localhost on $LOCALHOST/ansible/jenkinsinstall/main.yml run:

```ansible-playbook /usr/local/bin/playbooks/jenkinsinstall/main.yml -i ec2.py -u centos --private-key=/Users/jzuniga/Documents/AWS/<your-key-here>.pem```

These will install Jenkins on a AWS EC2 "Small tier"


## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


