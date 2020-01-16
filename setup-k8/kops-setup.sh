#!/bin/bash
 
install_kops () {

    #https://github.com/kubernetes/kops/issues/2428

    # check if cluster exist, create if not, replace otherwise
    if [[ ! $(kops get cluster  --state=s3://kops.helm2.devopsinuse.com) ]]; then
        #kops create -f cluster.yaml --name "${CLUSTER_NAME}" -v 10
  
        echo "trying to create KOPS cluster"

        kops_create


   
     else
         echo "============================================="
         echo "trying to replace KOPS cluster by deleting first then creating"
         echo  "============================================="

         #kops replace -f cluster.yaml --name "${CLUSTER_NAME}" -v 10

          kops delete cluster kops.azuka.ga --state=s3://kops.helm2.devopsinuse.com  --yes


          kops_create

     fi

 
}






kops_create () {

 kops create cluster \
          --name=kops.azuka.ga \
          --state=s3://kops.helm2.devopsinuse.com \
          --authorization RBAC \
          --zones=eu-west-1a \
          --node-count=1 \
          --node-size=t2.medium \
          --master-size=t2.micro \
          --master-count=1 \
          --dns-zone=kops.azuka.ga \
          --out=azuka_helm_terraform \
          --target=terraform \
          --ssh-public-key=~/.ssh/udemy_devopsinuse.pub


}

install_kops


