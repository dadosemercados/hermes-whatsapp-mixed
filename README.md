# 🤖 Hermes Agent - Modo Misto Híbrido (WhatsApp)

Este repositório contém os arquivos de configuração, templates e scripts necessários para implantar o **Hermes Agent** em modo híbrido (Dual-Mode) via **Portainer**. 

Esse modo permite que seu agente desempenhe duas funções ao mesmo tempo:
1. **Assistente Pessoal do Dono:** Quando você fala com o robô no chat privado (ou envia mensagens para si mesmo no WhatsApp/Telegram), ele age como seu assistente técnico e de infraestrutura com permissões para rodar comandos do terminal.
2. **Chatbot Comercial de Suporte:** Quando clientes ou outras pessoas entram em contato, ele atua como o atendente comercial dos seus produtos, consultando suas regras de negócio e sem parecer um robô chato.
3. **Controle por Comandos:** Você pode pausar ou retomar o atendimento a clientes enviando `stop_bot` ou `start_bot` na sua conversa privada!

---

## 📂 O que está incluído neste repositório:
* 🐋 **`docker-compose.yml`**: Arquivo otimizado para implantação rápida como Stack no Portainer.
* ⚡ **`setup.sh`**: Script de configuração de 1 clique que baixa todas as regras, chaves, persona e aplica o patch.
* 🐍 **`patch_whatsapp.py`**: Script de automação universal que reconfigura a ponte do WhatsApp (filtro de assinaturas inteligente e novos comandos).
* ⚙️ **`config.yaml.example`**: Configuração pré-otimizada para alta performance, ativação de memória persistente e prevenção de spam em grupos de WhatsApp.
* 🔑 **`.env.example`**: Modelo organizado de variáveis de ambiente e chaves de API necessárias.
* 🔒 **`Caddyfile.example`**: Configuração de Proxy Reverso de 1 clique usando o Caddy para expor seu Web Dashboard/Terminal com SSL grátis e automático.
* 👤 **`SOUL.md`**: Persona pré-configurada para o funcionamento do Modo Duplo (Dono vs Clientes).
* 📖 **`support_rules.md`**: Modelo estruturado de base de conhecimento separando as diretrizes de e-mail e WhatsApp.

---

## 🚀 Como Implantar pelo Portainer (Passo a Passo)

### Passo 1: Criar a Stack no Portainer

1. Abra o painel do seu **Portainer**.
2. Vá em **Stacks** -> **Add stack**.
3. Dê um nome à stack (ex: `hermes-agent`).
4. No campo **Web editor**, cole o conteúdo do arquivo `docker-compose.yml` deste repositório.
5. Clique em **Deploy the stack** no final da página.

---

### Passo 2: Configuração e Instalação de 1 Clique ⚡

Uma vez que o container esteja rodando no Portainer, você não precisa configurar nada manualmente! 

1. Clique na stack do `hermes-agent` no Portainer.
2. Vá em **Containers** e clique no ícone de **Console** (`>_`) do container `hermes-agent`.
3. Clique em **Connect** para abrir o terminal integrado.
4. Cole o comando abaixo e aperte Enter:

```bash
curl -sSL https://raw.githubusercontent.com/empreendedorserial/hermes-whatsapp-mixed/main/setup.sh | bash
```

**O que este comando faz automaticamente por você:**
* Baixa e configura o arquivo de persona adaptativa (`SOUL.md`).
* Cria o modelo de regras de suporte (`support_rules.md`).
* Configura as otimizações corretas no seu `config.yaml`.
* Cria o modelo de arquivo de chaves de API (`.env`).
* Executa o patch corretivo e de novos recursos para o WhatsApp (`patch_whatsapp.py`).

---

### Passo 3: Colocar suas Chaves de API e Regras de Suporte

Acesse os arquivos diretamente na pasta de volume persistente do seu servidor (ex: `/opt/data/`) ou através de um editor de arquivos:

1. **Chaves de API:** Abra o arquivo `/opt/data/.hermes/.env` e insira sua chave (como `OPENROUTER_API_KEY`).
2. **Suporte e Vendas:** Abra o arquivo `/opt/data/support_rules.md` e preencha com as regras do seu negócio, preços e links de checkout.

---

## 💾 Persistência de Dados e Caminhos no Portainer

Como o Hermes Agent roda containerizado, qualquer arquivo criado fora dos caminhos mapeados no seu volume persistente (`/opt/data`) **será perdido permanentemente** toda vez que o container for atualizado, reiniciado ou recriado.

### 📍 Caminhos Persistentes (SEMPRE SALVE AQUI):
* **Configurações e Chaves:** `HERMES_HOME=/opt/data/.hermes`
* **Área de Trabalho:** `WORKSPACE=/opt/data/workspace`
* **Scripts e Automações:** `/opt/data/scripts`
* **Projetos de Código:** `/opt/data/projects`
* **Arquivos e Bancos:** `/opt/data/files`

---

## 🔒 Passo Extra: Acesso Web com SSL Automático via Caddy

Se você quer acessar o Web Dashboard e o console interativo do Hermes com HTTPS (`https://seu-dominio.com`), nós incluímos o arquivo `Caddyfile.example`.

Basta subir um container do Caddy na mesma rede do seu Hermes Agent e usar a seguinte configuração no seu `Caddyfile`:

```caddy
hermes.seu-dominio.com {
    reverse_proxy hermes-agent:9119 {
        header_up Host {host}
        header_up X-Real-IP {remote_host}
    }
}
```
*O Caddy se encarrega de gerar, renovar e configurar os certificados SSL da Let's Encrypt de forma 100% automática!*

---

## 🕹️ Como Usar os Comandos no WhatsApp

Depois de parear o seu WhatsApp no Hermes Agent, você pode controlá-lo enviando mensagens na sua própria conversa de **Self-Chat (você com você mesmo)**:

* **Para desativar temporariamente o atendimento a clientes:** envie `stop_bot`. O robô entrará em modo de pausa apenas para terceiros.
* **Para reativar o atendimento comercial a clientes:** envie `start_bot`. Ele voltará a responder de forma automática.
* **Seu assistente técnico pessoal continuará funcionando o tempo todo!**

---

### 🔄 Como Forçar o Reinício da Ponte
Sempre que fizer alterações no código do robô ou aplicar o patch pela primeira vez, execute o seguinte comando no console para recarregar o robô do WhatsApp:

```bash
docker exec -it hermes-agent pkill -f bridge.js
```

---
*Desenvolvido e disponibilizado pela Comunidade Empreendedor Serial (André Alencar).*
