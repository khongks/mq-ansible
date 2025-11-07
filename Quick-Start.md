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

## Configure MQ Ansible

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