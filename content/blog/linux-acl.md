title: Linux ACL cheat sheet
tags: comp
category: blog
date: 2022-07-12 10:21
modified: 2022-07-10 10:53

# ACL - Access Control List

Verificando se tem suporte:

    # tune2fs -l /dev/sdX
    ...
    Default mount options:    user_xattr acl
    ...

Montando um dispositivo com suporte a ACL:

    # mount -o acl /dev/sdX /mnt/dispositivo

# cheat sheet

Verificar ACL de um arquivo

    getfacl arquivo

Definir ACL a um arquivo

    setfacl -Rdm ugo:nome:perm arquivo1 arquivo2

onde

    -R: recursivo
    -d: default ACL
    -m: modificar
    u: usuário
    g: grupo
    o: outros
    nome: nome do usuário/grupo
    perm: permissões r, w e/ou x

Exemplos:

1. Permitir que alice tenha permissão de leitura num arquivo:

    $ ls -l arquivo 
    -rw-r----- 1 adriano adriano 2 jul 12 10:33 arquivo
    $ setfacl -m u:alice:r arquivo
    $ ls -l arquivo 
    -rw-r-----+ 1 adriano adriano 2 jul 12 10:33 arquivo  # note o + nas permissões
    $ getfacl arquivo
    # file: arquivo
    # owner: adriano
    # group: adriano
    user::rw-
    user:alice:r--
    group::r--
    mask::r--
    other::---

2. Permitir leitura e escrita num diretório para um grupo:

    $ setfacl -m g:amigos:rwx dir
    $ getfacl dir
    # file: dir
    # owner: adriano
    # group: adriano
    user::rwx
    group::r-x
    group:amigos:rwx
    mask::rwx
    other::---

3. Remover uma regra ACL:

    $ setfacl -x u:alice arquivo

4. Remover todas as regras ACL:

    $ setfacl -b arquivo

5. Permitir leitura e escrita aos arquivo de um diretório por padrão (default):

    $ setfacl -d -m g:melhoresamigos:rwx dir
    # file: dir
    # owner: adriano
    # group: adriano
    user::rwx
    group::r-x
    group:amigos:rwx
    mask::rwx
    other::---
    default:user::rwx
    default:group::r-x
    default:group:melhoresamigos:rwx
    default:mask::rwx
    default:other::---
    $ touch dir/arquivo_do_melhor_amigo
    $ getfacl dir/arquivo_do_melhor_amigo
    # file: dir/arquivo_do_melhor_amigo
    # owner: adriano
    # group: adriano
    user::rw-
    group::r-x          #effective:r--
    group:melhoresamigos:rwx       #effective:rw-
    mask::rw-
    other::---

Fonte:
[http://www.bosontreinamentos.com.br/linux/acl-access-control-list-ajustando-permissoes-avancadas-no-linux/](http://www.bosontreinamentos.com.br/linux/acl-access-control-list-ajustando-permissoes-avancadas-no-linux/)
