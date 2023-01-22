### 환경구축

```
vagrant/virtualbox/ansible
brew install hashicorp/tap/hashicorp-vagrant
brew install --cask virtualbox
brew install ansible   

버전 확인 
VBoxManage -v       
7.0.6r155176

vagrant -v          
Vagrant 2.3.4

ansible --version
ansible [core 2.14.1]

mkdir 작업디렉토리
cd 작업디렉토리

vagrant box list
centos/7 (virtualbox, 1905.1)

vagrant init centos/7
주석을 제거
26행: config.vm.network "forwarded_port", guest: 80, host: 8080
35행: config.vm.network "private_network", ip: "192.168.33.10"

실행 완료
vagrant up
vagrant ssh
```
