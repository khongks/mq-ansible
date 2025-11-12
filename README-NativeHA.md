# Instruction on how to setup Native HA

1. Go to playbooks folder.

1. Create an inventory file called `nativeha-inventory.ini`.
    ```
    [mqservers]
    mqnha-svr1 ansible_host=mqnha-svr1.example.com nativeha_instance=alpha
    mqnha-svr2 ansible_host=mqnha-svr2.example.com nativeha_instance=beta
    mqnha-svr3 ansible_host=mqnha-svr3.example.com nativeha_instance=gamma

    [mqservers:vars]
    nativeha_primary=mqnha-svr1
    ```

1. Install MQ binaries.
    ```
    ansible-playbook mq-setupnativeha.yml -i nativeha-inventory.ini
    ```

1. Create a vault, specify your vault password in the prompt.
    ```
    ansible-vault create vars/secrets.yml
    New Vault password: 
    Confirm New Vault password:
    ```

1. Then specific the field and the password in the secrets.yml before you save using `:wq`.
    ```
    keystore_passwd: *****
    ```

1. Create a password file `.vault-file.txt` that contains the password to the vault. Chmod the file to protect the file against read from other users.
    ```
    chmod 600 ~/.vault_pass.txt
    ```

1. Setup Native HA.
    ```
    ansible-playbook mq-setupnativeha.yml -i nativeha-inventory.ini --vault-password-file .vault_pass.txt
    ```

1. Verify setup
    ```
    $ dspmq -o nativeha -x
    QMNAME(NATIVEHAQM)                                        ROLE(Active) INSTANCE(alpha) INSYNC(yes) QUORUM(3/3) GRPLSN(<0:0:28:64618>) GRPNAME() GRPROLE(Live)
    INSTANCE(alpha) ROLE(Active) REPLADDR(mqnha-svr1.dev.fyre.ibm.com) CONNACTV(yes) INSYNC(yes) BACKLOG(0) CONNINST(yes) ACKLSN(<0:0:28:64618>) HASTATUS(Normal) SYNCTIME(2025-11-12T04:43:12.500008Z) ALTDATE(2025-11-11) ALTTIME(23.43.12)
    INSTANCE(beta) ROLE(Replica) REPLADDR(mqnha-svr2.dev.fyre.ibm.com) CONNACTV(yes) INSYNC(yes) BACKLOG(0) CONNINST(yes) ACKLSN(<0:0:28:64618>) HASTATUS(Normal) SYNCTIME(2025-11-12T04:43:12.304303Z) ALTDATE(2025-11-11) ALTTIME(23.43.12)
    INSTANCE(gamma) ROLE(Replica) REPLADDR(mqnha-svr3.dev.fyre.ibm.com) CONNACTV(yes) INSYNC(yes) BACKLOG(0) CONNINST(yes) ACKLSN(<0:0:28:64618>) HASTATUS(Normal) SYNCTIME(2025-11-12T04:43:12.304303Z) ALTDATE(2025-11-11) ALTTIME(23.43.12)
    ```
