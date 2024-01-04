![alt text](rh_logo_small.jpg)
# Railhead Keycloak Project
This repository contains the code and configuration instructions to deploy Apache Guacamole via podman to integrate MFA to Microsoft Active Directory User. For additional details, please email at [christopher.sargent@sargentwalker.io](mailto:christopher.sargent@sargentwalker.io).

# Prerequisites
* [Download Windows Server 2022](https://go.microsoft.com/fwlink/p/?LinkID=2195167&clcid=0x409&culture=en-us&country=US)
* [Install Windows Server 2022 Instructions](https://medium.com/@yasithkumara/creating-a-virtual-windows-server-in-windows-10-with-hyper-v-9f3bd58c0ba)
* [Active Directory Install Instructions](https://medium.com/@yasithkumara/how-to-create-a-domain-and-a-domain-controller-in-a-windows-server-2019-virtual-machine-e70587e2fbe2)
# [Ubuntu 20.04 STIG Hardened FIPS Enabled](https://docs.google.com/document/d/1nEIavbELGl8xjHjZX4p22q5m32HCLkLH/edit#heading=h.gjdgxs)
* Take post set up snapshot on all servers 
* Create cas.local domain 

# Test VMs
* 172.18.0.138 AD server running ida.local domain
* 172.18.0.242 guacamole01.ida.local
* 172.10.0.120 bmax01.cas.local 

# Add DNS entry for guacamole01.ida.local

# Install Podman [podman](https://docs.podman.io/en/stable/Introduction.html)
* Note podman is in the default Ubuntu 22.04 repos but not Ubuntu 20.04
1. ssh cas@172.18.0.242
2. sudo -i 
3. apt install software-properties-common uidmap
4. sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_20.04/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
5. apt update 
6. apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4D64390375060AA4
```
Executing: /tmp/apt-key-gpghome.NKPCfh5qZD/gpg.1.sh --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4D64390375060AA4
gpg: out of core handler ignored in FIPS mode
gpg: key 4D64390375060AA4: public key "devel:kubic OBS Project <devel:kubic@build.opensuse.org>" imported
gpg: Total number processed: 1
gpg:               imported: 1
gpg: out of core handler ignored in FIPS mode

```
7. apt update 
8. apt install podman -y 
9. podman version
```
Version:      3.4.2
API Version:  3.4.2
Go Version:   go1.15.2
Built:        Thu Jan  1 00:00:00 1970
OS/Arch:      linux/amd64
```
10. apt install python3-pip -y 
11. pip3 install podman-compose
# Run Guacamole via Podman Compose
* Edit guacamole-compose.yml to add LDAP and either copy over offical certs or use self signed certs generated from script below.
1. ssh cas@172.18.0.242
2. sudo -i
3. Clone this repo
4. cd guacamole 
1. Edit setup.sh to update self signed certificate details
2. ./setup.sh
3. podman-compose -f guacamole-compose.yml up -d
4. https://IP:8443
