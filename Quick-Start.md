# Quick Start to install IBM MQ using Ansible

## Install Ansible

1. Get a Red Hat Linux machine

1. Install pip first
    ```
    dnf install pip -y
    ```

1. Install pipx, assuming python3 is already installed
    ```
    python3 -m pip install --user pipx
    pipx ensurepath --global
    ```

    If upgrade is needed
    ```
    python3 -m pip install --user --upgrade pipx
    ```

1. Install Ansible
    ```
    pipx install --include-deps ansible
    ```

## Setup MQ Ansible

1. Clone MQ ansible
    ```
    git clone https://github.com/khongks/mq-ansible.git
    cd mq-ansible
    ```

1. Install requirements `ansible`, `ansible-lint` and `passlib`.
    ```
    pip install -r requirements.txt
    ```

1. Skip this if you have the public SSH key (`~/.ssh/id_rsa.pub`). If not, generate one.
    ```
    cd ~/.ssh
    ssh-keygen
    ```

1. Copy the public SSH key to all the target RHEL servers
    ```
    ssh-copy-id -i ~/.ssh/id_rsa.pub [user]@[hostname]
    ```

    ```
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@mqnha-svr1.dev.fyre.ibm.com
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@mqnha-svr2.dev.fyre.ibm.com
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@mqnha-svr3.dev.fyre.ibm.com
    ```

## Install MQ

1. Configure `inventory.ini` file
    ```
    cd playbooks
    vi inventory.ini
    ```
    `inventory.ini` file
    ```
    [servers]
    YOUR_HOST_ALIAS ansible_host=YOUR_HOSTNAME ansible_ssh_user=YOUR_SSH_USER
    YOUR_HOST_ALIAS ansible_host=YOUR_HOSTNAME ansible_ssh_user=YOUR_SSH_USER
    ```

1. Export modules path
    ```
    export ANSIBLE_LIBRARY=${ANSIBLE_LIBRARY}:/${YOURFOLDER}/mq-ansible/plugins/modules
    
    ensure ${YOURFOLDER}/mq-ansible/playbooks
    ```

1. Run installation playbook with inventory
    ```
    ansible-playbook ./ibmmq.yml -i inventory.ini -e 'ibmMqLicence=accept'
    ```