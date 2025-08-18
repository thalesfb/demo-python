#!/bin/bash

# Script para configurar ambiente virtual e instalar dependências
echo "🔧 Configurando ambiente de desenvolvimento seguro..."

# Caminhos do venv para Windows (Git Bash) e Linux/Mac
WIN_VENV_PY=".venv/Scripts/python.exe"
WIN_ACTIVATE=".venv/Scripts/activate"
POSIX_VENV_PY=".venv/bin/python"
POSIX_ACTIVATE=".venv/bin/activate"

# Criar ambiente virtual (se não existir ou se flag de recriação for passada)
echo "📦 Criando ambiente virtual..."
python -m venv .venv

# Descobrir caminho do Python dentro do venv
if [ -f "$WIN_VENV_PY" ]; then
	VENV_PY="$WIN_VENV_PY"
	ACTIVATE="$WIN_ACTIVATE"
else
	VENV_PY="$POSIX_VENV_PY"
	ACTIVATE="$POSIX_ACTIVATE"
fi

# Ativar ambiente virtual se o script de ativação existir (opcional)
if [ -f "$ACTIVATE" ]; then
	echo "🚀 Ativando ambiente virtual..."
	# shellcheck disable=SC1090
	source "$ACTIVATE"
else
	echo "⚠️  Script de ativação não encontrado. Prosseguindo sem ativar (usando $VENV_PY)."
fi

# Atualizar pip usando o Python do venv
echo "⬆️ Atualizando pip..."
"$VENV_PY" -m pip install --upgrade pip

# Instalar dependências usando o Python do venv
echo "📚 Instalando dependências..."
"$VENV_PY" -m pip install -r requirements.txt

echo "✅ Ambiente configurado com sucesso!"
echo "💡 Para ativar o ambiente (Git Bash): source $WIN_ACTIVATE"
echo "💡 Para ativar o ambiente (PowerShell): .\.venv\Scripts\Activate.ps1"
