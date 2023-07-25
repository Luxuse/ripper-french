<div align="center">
  <h1 align="center">
    <img src="./resources/assets/rar-ripper.svg" alt="Ripper" />
  </h1>

  <p align="center">
    Rar Ripper: quebrando senhas (com wordlists) de arquivos criptografados
    ".rar", através do Batch Script.<br/> Ideal para os esquecidos de 
    plantão, extremamente útil para senhas curtas e simples.
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
  </small>
</p>
## 💻 le traducteur 
voila petite traduction pas parfaite mais paratique

## 💻 Batch Script e o ambiente Windows

Batch em uma tradução livre significa lotes (algo que se reparte, que é divido), ou
seja, um conjunto ou grupo de intruções a serem executadas (sequencialmente) pelo computador sem a intervenção do usuário. Em geral, o Batch Script ou arquivo
batch (lotes) contém linhas de comandos/comandos que podem ser executados pelo
interpretador do Windows, o famoso **cmd.exe** ou Command Prompt.

> Observações: o Batch é uma "linguagem" extremamente lenta e fraca, porém, pode
> ser usada para automatizar tarefas e resolver problemas no ambiente Windows.

## :wrench: Como executar no ambiente local?

### Guia de instalação

1. Faça o clone do repositório através do Git (sistema de versionamento de código).

   1.2 Se você não realizou a intalação dessa ferramenta na sua máquina,
   não se preocupe, porque existem outras alternativas. Minha recomendação é clicar
   no botão "code" e fazer do download do reposirório como Zip, basta extrair os
   arquivos e acessar o diretório pelo CMD. Use o comando `cd` para nevegar ou alterar
   diretórios/pastas.

```batch
$ git clone https://github.com/lucasbernardol/rar-ripper.git

$ cd rar-ripper/
```

2. Para executar um arquivo de lotes (batch) como a extensão `.bat` ou `.cmd`,
   é necessário abrir uma instância do CMD na mesma pasta/diretório do arquivo
   `Ripper.bat` e seguir as intruções abaixo. Você tembém pode optar pela interface
   gráfia e o "explorar.exe", basta dá um duplo click no arquivo .bat.

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

Se você chegou até aqui, acredito que esse guia de instalação de ajudou, parabéns.
Obrigado por testar o meu programinha, fique à vontade para contribuir ou até
mesmo me dá um estrelinha. Até mais 👋👋.

## :boy: Autor

<table class="traducteur">
  <tr>
    <td align="center">
      <a href="https://github.com/Luxuse">
        <img src="https://avatars.githubusercontent.com/u/82418341?v=4" 
        width="100px;" alt="Mathéo simard"/>
        <br/>
        <sub>
          <b>José Lucas</b>
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
