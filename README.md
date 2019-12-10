#### Referencias:
 - https://www.server-world.info/en/note?os=CentOS_7&p=openshift311&f=1
 - https://docs.okd.io/latest/install/example_inventories.html

# CONFIGs
#### /etc/hosts
 - 10.1.14.110 okd01h
 - 10.1.14.225 okd02h
 - 10.1.14.233 okd03h
 - 10.1.14.237 okd04h
 - 10.1.14.238 okd05h

#### /etc/ansible/hosts

[okd]
 - okd01h
 - okd02h
 - okd03h
 - okd04h
 - okd05h

# Comandos de instalação
ansible -m hostname -a "name=okd01h.example.com" okd01h
ansible -m hostname -a "name=okd02h.example.com" okd02h
ansible -m hostname -a "name=okd03h.example.com" okd03h
ansible -m hostname -a "name=okd04h.example.com" okd04h
ansible -m hostname -a "name=okd05h.example.com" okd05h

#### CONFIG SERVICES
ansible -m systemd -a "name=firewalld enabled=no state=stopped" okd

#### CONFIG USER
ansible-playbook origin_user.yaml

#### INSTALL PACKAGES
ansible-playbook package_install_basic.yml 

#### CONFIG SERVICES
ansible -m systemd -a "name=docker enabled=yes state=restarted" okd

#### CHECK ACCESS
ssh -p2222 -i files/origin.priv origin@origin01h
ssh -p2222 -i id_rsa origin@origin01h

copy inventory to master node
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/prerequisites.yml
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/deploy_cluster.yml
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/openshift-master/config.yml 

pip install ansible==2.6

# Comandos de administração

#### testando cluster
oc get nodes
oc get pods --all-namespaces

#### criando cluster admin
sudo htpasswd /etc/origin/master/htpasswd admin
oc create clusterrolebinding registry-controller --clusterrole=cluster-admin --user=admin

#### testanto
oc login https://okd01h.example.com:8443
oc get identity

#### nova aplicação
oc new-project meuprojeto
oc tag --source=docker openshift/deployment-example:v2 deployment-example:latest 
oc new-app deployment-example 
oc status
oc get all
curl 172.30.46.237:8080 
oc get pods
oc get svc
### criando rotas
oc expose service deployment-example 
oc get route

