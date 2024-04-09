---
- name: ansible playbook to setup tomcat
  hosts: all
  become: true
  tasks:  
  - name: install java on Amazon linux and Redhat server
    yum:
      name: java
      state: installed
    when: ansible_os_family == "RedHat"
 
  - name: install java on Ubuntu server
    apt:
      name: default-jdk
      state: present
    when: ansible_os_family == "Debian"

  - name: download tomcat package
    get_url:
      url: https://downloads.apache.org/tomcat/tomcat-9/v9.0.87/bin/apache-tomcat-9.0.87.tar.gz
      dest: /opt

  - name: untar the package
    unarchive:
      src: /opt/apache-tomcat-9.0.87.tar.gz
      dest: /opt
      remote_src: yes

  - name: add execution permission to startup.sh
    file:
      path: /opt/apache-tomcat-9.0.87/bin/startup.sh
      mode: 0777

  - name: start tomcat services
    shell: nohup ./startup.sh
    args:
      chdir: /opt/apache-tomcat-9.0.87/bin

