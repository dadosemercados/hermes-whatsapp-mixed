# 📋 Guia Passo a Passo - Configuração do Hermes Agent (Modo Misto)

Este guia prático foi criado para guiar você, aluno da **Comunidade Empreendedor Serial**, na configuração completa do seu robô do zero até ele estar atendendo seus clientes com o Gemini 3.5 Flash e atuando como seu assistente pessoal!

Siga os **6 passos simples** abaixo:

---

## 🛠️ PASSO 1: Subir a Stack no Portainer

1. Acesse o painel do seu **Portainer**.
2. Vá no menu lateral em **Stacks** e clique em **Add stack**.
3. Escolha um nome para a stack (ex: `hermes-agent`).
4. Cole o conteúdo do arquivo `docker-compose.yml` (disponível no repositório) no editor de texto.
5. Clique no botão azul **Deploy the stack** na parte inferior da tela.
6. Aguarde alguns segundos até que o container fique no status `running`.

---

## ⚡ PASSO 2: Rodar a Instalação Automatizada (1 Clique)

1. No painel do Portainer, clique em **Containers** e encontre o container `hermes-agent`.
2. Clique no ícone de **Console** (`>_`) correspondente a ele.
3. Deixe as opções padrão e clique em **Connect** para abrir o terminal integrado.
4. Cole o comando abaixo e aperte **Enter**:

```bash
curl -sSL https://raw.githubusercontent.com/empreendedorserial/hermes-whatsapp-mixed/main/setup.sh | bash
```

> **O que aconteceu aqui?** O script automatizado configurou toda a estrutura de pastas do seu volume persistente (`/opt/data`), baixou os modelos corretos de personalidade (`SOUL.md`), regras de negócio (`support_rules.md`), configurou o `config.yaml` otimizado para o Gemini 3.5 e corrigiu a ponte do WhatsApp!

---

## 🔑 PASSO 3: Configurar as Chaves de API (.env)

O Hermes precisa de uma chave de API para pensar. Usaremos o **Gemini da Google** (que possui um excelente custo-benefício e velocidade extrema!).

1. Acesse os arquivos do seu servidor (pelo gerenciador de arquivos do seu Portainer, VS Code, ou terminal).
2. Abra o arquivo localizado em:
   👉 `/opt/data/.hermes/.env`
3. Adicione sua chave do Gemini na linha correspondente:
   `GOOGLE_API_KEY=sua_chave_do_gemini_aqui`
4. Se for usar outros canais como Gmail ou Telegram, preencha as variáveis correspondentes que estão listadas como exemplo no arquivo. Salve e feche.

---

## 📖 PASSO 4: Customizar as Regras do seu Negócio

Agora vamos ensinar o robô como funciona a sua empresa para que ele nunca invente respostas.

1. Abra o arquivo localizado na raiz da sua pasta persistente:
   👉 `/opt/data/support_rules.md`
2. Edite as informações com os dados do **seu negócio**:
   * Preços dos seus produtos.
   * Seus links de checkout (Kiwify, Hotmart, Stripe, etc.).
   * Seus horários de atendimento.
   * Respostas para dúvidas frequentes (FAQ).
3. Salve o arquivo. Toda vez que você atualizar este arquivo, o robô aprenderá as regras novas instantaneamente!

---

## 📲 PASSO 5: Conectar o WhatsApp e Ativar

1. Volte ao **Console** do container `hermes-agent` no Portainer.
2. Digite o comando abaixo para iniciar o Hermes e gerar o QR Code de pareamento:
   ```bash
   hermes
   ```
3. Um **QR Code** será exibido na tela do terminal. 
4. Abra o WhatsApp no seu celular, vá em **Aparelhos conectados** -> **Conectar um aparelho** e escaneie o código da tela.
5. Assim que a conexão for concluída, você poderá fechar o terminal interativo digitando `/exit`.
6. Para garantir que as novas regras de limpeza de assinaturas e os comandos estão ativos na ponte, execute este comando de reinício rápido no console:
   ```bash
   pkill -f bridge.js
   ```

---

## 🧪 PASSO 6: O Diagnóstico de Sucesso!

Abra a conversa do seu WhatsApp com **você mesmo (Self-Chat)** e envie a seguinte mensagem para testar a integridade do robô:

> *"Hermes, faça um teste de diagnóstico do meu sistema. Verifique se a minha persona SOUL.md e as regras do support_rules.md foram carregadas, me diga qual modelo de IA você está usando e liste os nossos caminhos persistentes."*

### ✅ Resposta Esperada de Sucesso:
* Ele deve se apresentar como o *Hermes Agent - Edição Especial Empreendedor Serial*.
* Confirmar que está rodando com o **Gemini 3.5 Flash**.
* Confirmar que encontrou e leu seu arquivo `/opt/data/support_rules.md`.
* Listar seus caminhos sob `/opt/data/`.

---

## 🕹️ Comandos de Controle (WhatsApp)

Você agora tem superpoderes! Diretamente do seu chat privado, envie os seguintes comandos para o robô para controlar o atendimento comercial de clientes:

* 🚫 **`stop_bot`** - Pausa imediatamente o chatbot comercial para clientes (enquanto você continua podendo usar o assistente pessoal normalmente).
* 🟢 **`start_bot`** - Reativa o chatbot comercial para responder seus clientes no piloto automático.

---
*Bons negócios e automações!*  
*Comunidade Empreendedor Serial (André Alencar).*
