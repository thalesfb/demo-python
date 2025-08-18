# Script PowerShell para configurar ambiente virtual e instalar dependências
Write-Host "🔧 Configurando ambiente de desenvolvimento seguro..." -ForegroundColor Green

# Criar ambiente virtual
Write-Host "📦 Criando ambiente virtual..." -ForegroundColor Yellow
python -m venv ../.venv

# Ativar ambiente virtual
Write-Host "🚀 Ativando ambiente virtual..." -ForegroundColor Yellow
.\..\..venv\Scripts\Activate.ps1

# Atualizar pip
Write-Host "⬆️ Atualizando pip..." -ForegroundColor Yellow
python -m pip install --upgrade pip

# Instalar dependências
Write-Host "📚 Instalando dependências..." -ForegroundColor Yellow
pip install -r ../requirements.txt

Write-Host "✅ Ambiente configurado com sucesso!" -ForegroundColor Green
Write-Host "💡 Para ativar o ambiente: ..\.venv\Scripts\Activate.ps1" -ForegroundColor Cyan
