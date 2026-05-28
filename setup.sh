#!/bin/bash
set -e

echo "=========================================================="
echo "🤖 CONFIGURADOR DE MODO MISTO DO EMPREENDEDOR SERIAL 🤖"
echo "=========================================================="

# Define o caminho base do Hermes dentro do container
BASE_DIR="/root/.hermes"
mkdir -p "$BASE_DIR"
mkdir -p "/opt/data"

# URL Base para os arquivos do GitHub
RAW_URL="https://raw.githubusercontent.com/empreendedorserial/hermes-whatsapp-mixed/main"

echo "⏳ 1. Baixando arquivos de configuração e personas..."

# Baixa o arquivo de persona (SOUL.md) para a pasta persistente e linka no Hermes
curl -sSL "$RAW_URL/SOUL.md" -o "/opt/data/SOUL.md"
cp "/opt/data/SOUL.md" "$BASE_DIR/SOUL.md"
echo "  ✓ Persona SOUL.md configurada em /opt/data/SOUL.md"

# Baixa a base de conhecimento de suporte (support_rules.md) se ela não existir
if [ ! -f "/opt/data/support_rules.md" ]; then
    curl -sSL "$RAW_URL/support_rules.md" -o "/opt/data/support_rules.md"
    echo "  ✓ Modelo de support_rules.md criado em /opt/data/support_rules.md"
else
    echo "  - support_rules.md já existe em /opt/data, pulando para não sobrescrever."
fi

# Baixa o modelo de config.yaml se ele não existir
if [ ! -f "$BASE_DIR/config.yaml" ]; then
    curl -sSL "$RAW_URL/config.yaml.example" -o "$BASE_DIR/config.yaml"
    echo "  ✓ config.yaml inicial configurado."
else
    echo "  - config.yaml já existe, pulando."
fi

# Baixa o modelo de chaves de API (.env) se ele não existir
if [ ! -f "$BASE_DIR/.env" ]; then
    curl -sSL "$RAW_URL/.env.example" -o "$BASE_DIR/.env"
    echo "  ✓ Arquivo de chaves .env inicial criado."
    echo "  ⚠️ ATENÇÃO: Edite o arquivo /opt/data/.hermes/.env e coloque suas chaves de API!"
else
    echo "  - Arquivo .env já existe, pulando."
fi

echo "⏳ 2. Baixando e aplicando o Patch do WhatsApp..."
# Baixa e executa o patch da ponte do WhatsApp
curl -sSL "$RAW_URL/patch_whatsapp.py" -o "/tmp/patch_whatsapp.py"
python3 /tmp/patch_whatsapp.py

echo "=========================================================="
echo "🎉 CONFIGURAÇÃO CONCLUÍDA COM SUCESSO!"
echo "=========================================================="
echo "Para deixar seu Hermes 100% operacional:"
echo "1. Edite as chaves de API em: /opt/data/.hermes/.env"
echo "2. Edite as regras do seu negócio em: /opt/data/support_rules.md"
echo "3. Abra o console do Portainer e digite 'hermes' para iniciar!"
echo "=========================================================="
