<div align="center">
  <h1 align="center">
    <img src="./resources/assets/rar-ripper.svg" alt="Ripper" />
  </h1>

  <p align="center">
      Rar Ripper: cracking mots de passe (avec des listes de mots) de fichiers cryptés
    « .rar », via Batch Script.<br/> Idéal pour les oubliés 
    Extrêmement utile pour les mots de passe courts et simples.
  </p>
</div>

<div align="center">
  <img alt="GitHub top language" src="https://img.shields.io/github/languages/top/lucasbernardol/rar-ripper?color=5D8BF4">

  <img alt="GitHub" src="https://img.shields.io/github/license/lucasbernardol/rar-ripper?color=5D8BF4">

  <img alt="GitHub language count" src="https://img.shields.io/github/languages/count/lucasbernardol/rar-ripper?color=5D8BF4">

  <img src="https://img.shields.io/badge/author-Jos%C3%A9%20Lucas-5D8BF4" alt="Author" />
</div>

<p align="center">
  <small>
    Build with ❤️ by: <a href="https://github.com/lucasbernardol">José Lucas</a>
   traduit by: <a href="https://github.com/lucasbernardol">Luxuse</a>
  </small>
</p>
## 💻 le traducteur 
voila petite traduction pas parfaite mais paratique

## 💻 Batch Script e o ambiente Windows

Lot dans une traduction libre signifie beaucoup (quelque chose qui est divisé, qui est divisé), ou
C’est-à-dire un ensemble ou un groupe d’instructions à exécuter (séquentiellement) par l’ordinateur sans intervention de l’utilisateur. En général, le script batch ou le fichier
batch contient des lignes de commande/commandes qui peuvent être exécutées par
Interpréteur Windows, le fameux **cmd.exe** ou Invite de commandes.

> Notes: Batch est un « langage » extrêmement lent et faible, mais il peut
> être utilisé pour automatiser les tâches et résoudre les problèmes dans l’environnement Windows.

## :wrench : Comment fonctionner dans l'environnement local ?

### Guide d'installation

1. Cloner le dépôt via Git (système de versionnement de code).

   1.2 Si vous n'avez pas installé cet outil sur votre machine,
   ne vous inquiétez pas, car il existe d'autres alternatives. Je vous recommande de cliquer
   sur le bouton "code" et de télécharger le dépôt au format Zip, il suffit d'extraire les fichiers et d'accéder au répertoire par CMD.
   fichiers et d'accéder au répertoire par CMD. Utilisez la commande `cd` pour changer de répertoire ou de dossier.
   répertoires/dossiers.
```batch
$ git clone https://github.com/lucasbernardol/rar-ripper.git

$ cd rar-ripper/
```

2.  Pour exécuter un fichier batch avec l'extension `.bat` ou `.cmd`,
   il est nécessaire d'ouvrir une instance CMD dans le même dossier/répertoire que le fichier
   `Ripper.bat` et suivre les instructions ci-dessous. Vous pouvez également opter pour l'interface
   et `explore.exe`, il suffit de double-cliquer sur le fichier .bat.


```batch
:: Excutar o script para qubrar senhas de arquivos ".rar".
:: OBS: naveque até o local do arquivo batch.
.\Ripper.bat "clear-logs"

:: A opção "clear-logs" irá desativar e excluir os logs existentes,
:: o padrão é (logs on), ou seja, basta omitir esse argumento para ativar
:: os logs (histório de intruções que foram executas na máquina).

REM LOGS ON - defualt
.\Ripper.bat

:: Diretório dos logs:
::  %userprofile%\documents\ripper-logs
::  %userprofile% => c:\users\%username%
:: Caminho completo:
::  c:\users\%username%\documents\ripper-logs

:: Você é livre para omitir: (".\")
Ripper.bat

REM Observações: o arquivo "personal-config.bat" adiciona as minhas configurações
REM pessoais no registro do Windows, isto é, o script altera o resgistro/chave
REM "Autorun" com instruções iniciais como CLS, COLOR, TITLE, entre outos.
REM (Não possui riscos).

:: Use "import" para adicionar as configurações
.\personal-config.bat "import"

:: Use a flag "revert" para reverter (utilização do arquivo de Backup).
.\personal-config.bat "revert"

:: O arquivo "command.processor.reg" (de Backup) está localizado na
:: Área de Trabalho, porém, é oculto.
```

Si vous êtes arrivé jusqu'ici, je pense que ce guide d'installation vous a aidé, félicitations.
Merci d'avoir essayé mon petit programme, n'hésitez pas à contribuer ou même à me donner une étoile.
même me donner une étoile. A bientôt 👋👋.

## :boy: Autor et traducteur

<table class="traducteur">
  <tr>
    <td align="center">
      <a href="https://github.com/Luxuse">
        <img src="https://avatars.githubusercontent.com/u/137567329?s=400&u=51286bbea1c5a95e9a7917fe240c5cf75afd7f31&v=4" 
        width="100px;" alt="Mathéo luxuse"/>
        <br/>
        <sub>
          <b>luxuse matheo simard</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

<table class="author">
  <tr>
    <td align="center">
      <a href="https://github.com/lucasbernardol">
        <img src="https://avatars.githubusercontent.com/u/82418341?v=4" 
        width="100px;" alt="José Lucas"/>
        <br/>
        <sub>
          <b>José Lucas</b>
        </sub>
      </a>
    </td>
  </tr>
</table>

## 📝 Licença

O projeto o possui a licença _MIT_, veja o arquivo [LICENÇA](LICENSE) para
mais informações.
