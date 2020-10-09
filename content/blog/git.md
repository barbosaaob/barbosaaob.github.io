title: Git cheat sheet
tags: comp
category: blog
date: 2020-10-08 21:10
modified: 2020-10-08 21:10

[Aprendendo Git no Katacoda.](https://www.katacoda.com/courses/git)

### Inicializando um repositório a partir do diretório atual na sua máquina:

	git init

### Clonando um repositório para sua máquina:

	git clone ENREDEÇO_DO_REPOSITÓRIO

### Verificando o estado do repositório:

	git status

### Adicionando arquivos à área de staging:

	git add ARQUIVO

### Executando um commit:

	git commit -m "MENSAGEM"

### Verificando alterações nos arquivos:

	git diff                  # todos os arquivos
	git diff ARQUIVO          # um arquivo específico
	git diff HASH_DO_COMMIT   # compara com um commit
	git diff COMMIT1 COMMIT2  # compara dois commits

### Log de ações:

	git log                                    # formato padrão
	git log --pretty=format:"%h %an %ar - %s"  # especifica um formato de saída
	git log --grep="abc"                       # busca commits com a string "abc"
	git log --oneline                          # log resumido
	git log --since="1 week"                   # commits de até uma semana
	git log --help                             # para mais informações

### Visualizando modificações:

	git show                 # exibe o diff do último commit
	git show HASH_DO_COMMIT  # exibe o diff de um commit específico

### Listar branches:

	git branch     # branches locais
	git branch -r  # branches remotos
	git branch -a  # branches locais e remotos

### Criando, alterando e deletando branch de trabalho:

	git branch BRANCH                # cria um novo branch
	git checkout BRANCH              # altera o branch de trabalho
	git checkout -b BRANCH           # cria e muda para o novo branch
	git branch -d BRANCH             # deleta um branch localmente
	git push REMOTE --delete BRANCH  # deleta um branch remoto

### Repositórios remotos:

	git remote -v                 # exibe os repositórios remotos
	git remote add NOME ENDEREÇO  # adiciona um repositório remoto
	git remote rm NOME            # remove o repositório remoto

### Sincronizando repositório local e remoto:

	git push NOME BRANCH   # envia os commits locais para o repositório NOME no branch BRANCH
	git pull NOME BRANCH   # baixa os commits do repositório remoto
	git fetch NOME BRANCH  # baixa informações do repositório remoto sem alterar o branch local

### Desfazendo mudanças:

	git checkout -- ARQUIVO     # descarta mudanças no ARQUIVO
	git checkout .              # descarta mudanças em todos os arquivo do diretório atual
	git reset ARQUIVO           # retira o ARQUIVO da área de staging
	git reset                   # retira todos os arquivos da área de staging
	git reset --hard ARQUIVO    # retira da área de staging e reverte as mudanças no ARQUIVO
	git reset --hard COMMIT     # limpa a área de staging e reverte as mudanças para o COMMIT
	git reset --hard HEAD       # limpa a área de staging e reverte as mudanças para o último commit

### Revertendo commits:

	git revert COMMIT             # desfaz as mudanças feitas no COMMIT
	git revert HEAD               # desfaz as mudanças feitas último commit
	git revert COMMIT1...COMMIT2  # desfaz as mudanças entre os commits
	
### Merge de branches:

	git merge BRANCH

Quando mudanças num arquivo local e sua versão remota geram diffs diferentes
para um mesmo conjunto de linhas, tem-se um conflito e o merge automático não é
possível. Nesses casos, o arquivo local apresentará os marcadores abaixo
separando as mudanças no arquivo remoto e no arquivo local

	<<<<<<< HEAD
	# mudanças feitas no arquivo local
	=======
	# mudanças feitas no arquivo remoto
	>>>>>>> HASH_DO_COMMIT

Para resolver o conflito, é possível preservar apenas uma das versões (local ou remota)

	git checkout --ours ARQUIVO    # mantem as mudanças feitas localmente
	git checkout --theirs ARQUIVO  # mantem as mudanças feitas remotamente

Entretanto, quando ambas as mudanças precisam ser incorporadas a versão final,
o arquivo precisa ser editado manualmente removendo as marcações e deixando-o
na sua versão final considerando as ambas as mudanças.

Exemplo do merge de branchs:

	$ git checkout master
	$ git log --oneline
	7a4d5f7 (HEAD -> master) D
	906d0f4 C
	16d27f9 B
	68140e0 A
	
	$ git checkout dev
	$ git log --oneline
	225f507 (HEAD -> dev) G
	1006597 F
	152da18 E
	16d27f9 B
	68140e0 A
	
	$ git checkout master
	$ git merge dev
	$ git log --oneline
	932d94a (HEAD -> master) Merge branch 'dev'
	225f507 (dev) G
	7a4d5f7 D
	1006597 F
	906d0f4 C
	152da18 E
	16d27f9 B
	68140e0 A

Ilustração do exemplo:

	      E---F---G    dev
	     /         \
	A---B---C---D---M  master

### Rebase:

	git rebase BRANCH

Fazer um `rebase` significa refazer o ponto de partida (base) do branch. No
exemplo abaixo, o branch dev foi iniciado no commit B.

	      E---F---G  dev
	     /
	A---B---C---D    master

Ao executar um `rebase` no branch dev, aplicamos os commits B, C e D ao branch
dev e reaplicamos os commits E, F e G. Observe que pode haver conflitos de modo
semelhante ao `merge` ao executar o `rebase`.

	              E'---F'---G'  dev
	             /
	A---B---C---D    master

Exemplo do rebase de branchs:

	$ git checkout master
	$ git log --oneline
	7a4d5f7 (HEAD -> master) D
	906d0f4 C
	16d27f9 B
	68140e0 A
	
	$ git checkout dev
	$ git log --oneline
	225f507 (HEAD -> dev) G
	1006597 F
	152da18 E
	16d27f9 B
	68140e0 A

	$ git rebase master
	$ git log --oneline
	55bdc65 (HEAD -> dev) G
	8a0ee8a F
	aa99277 E
	7a4d5f7 (master) D
	906d0f4 C
	16d27f9 B
	68140e0 A

Observe que o hash dos commits E, F e G mudou após o `rebase`. Existem outros
[cuidados que precisam ser considerados ao utilizar o
rebase](https://git-scm.com/book/ch3-6.html#The-Perils-of-Rebasing).

### Merge ou rebase?

Dada a situação abaixo

	      E---F---G  dev
	     /
	A---B---C---D    master

execute um `rebase` no branch dev e resolva eventuais conflitos:

	              E'---F'---G'  dev
	             /
	A---B---C---D    master

Observe que apenas o branch dev foi afetado até momento. Em seguida, execute o
`merge` no branch master:

	              E'---F'---G'   dev
	             /           \
	A---B---C---D-------------M  master

### Bisseção (procurando bugs):

	git bisect start            # inicia o modo de bisseção
	git bisect bad COMMIT_RUIM  # marca o commit como ruim
	git bisect good COMMIT_BOM  # marca o commit que se sabe não ter o bug
	# marca-se cada commit dado pelo git como bom ou ruim
	git bisect good             # se o commit não apresenta o bug
	git bisect bad              # se o commit apresenta o bug
	# ao final das iterações o git identifica o commit que introduziu o bug
	git bisect reset            # finaliza a bisseção
	# você pode analisar e corrigir o problema

A busca por bisseção evita que todos os commits entre `COMMIT_BOM` e
`COMMIT_RUIM` precisem ser analisados.

### Identificando os responsáveis (blame):

	git blame ARQUIVO          # mostra a última pessoa a alterar cada linha do ARQUIVO
	git blame -L 5,11 ARQUIVO  # mostra a última pessoa a alterar as linhas de 5 a 11 do ARQUIVO 

### Escolhendo as mudanças (cherry picking):

	git cherry-pick COMMIT      # aplica o COMMIT de um outro branch ao branch atual
	git cherry-pick --abort     # cancela o cherry picking em caso de conflito, por exemplo
	git cherry-pick --continue  # continua o cherry picking após resolver o conflito

### Alterando commits:

	git commit --amend               # permite alterar o último commit
	git rebase --interactive HEAD~5  # permite alterar os últimos 5 commits
	git rebase --interactive --root  # permite alterar todos os commits
