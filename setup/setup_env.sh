#!/bin/bash

# Script para configurar ambiente virtual e instalar dependências
echo "🔧 Configurando ambiente de desenvolvimento seguro..."

# Criar ambiente virtual
echo "📦 Criando ambiente virtual..."
python -m venv ../.venv

# Ativar ambiente virtual
echo "🚀 Ativando ambiente virtual..."
source ../.venv/Scripts/activate

# Atualizar pip
echo "⬆️ Atualizando pip..."
pip install --upgrade pip

# Instalar dependências
echo "📚 Instalando dependências..."
pip install -r ../requirements.txt

echo "✅ Ambiente configurado com sucesso!"
echo "💡 Para ativar o ambiente: source ../.venv/Scripts/activate"
