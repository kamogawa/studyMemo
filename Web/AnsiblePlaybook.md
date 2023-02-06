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

다른 패키지의 의존 관계 때문에 java8 설정되어 우선이 되어버림
alternatives로 java8버전을 내리고 --auto java(이름) 으로 최우선 버전이 사용되도록 함
https://ytyaru.hatenablog.com/entry/2020/05/24/000000
