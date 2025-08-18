<#
 Script PowerShell para configurar ambiente virtual e instalar dependências
 - Cria o venv em .venv
 - Usa o Python do venv para atualizar pip e instalar dependências (sem depender de ativação)
#>

Write-Host "🔧 Configurando ambiente de desenvolvimento seguro..." -ForegroundColor Green

# Criar ambiente virtual
Write-Host "📦 Criando ambiente virtual..." -ForegroundColor Yellow
python -m venv .venv

# Caminhos do Python dentro do venv
$VenvPythonWin = ".venv\Scripts\python.exe"
$ActivatePs1 = ".venv\Scripts\Activate.ps1"

# Atualizar pip usando Python do venv
Write-Host "⬆️ Atualizando pip..." -ForegroundColor Yellow
& $VenvPythonWin -m pip install --upgrade pip

# Instalar dependências
Write-Host "📚 Instalando dependências..." -ForegroundColor Yellow
& $VenvPythonWin -m pip install -r requirements.txt

Write-Host "✅ Ambiente configurado com sucesso!" -ForegroundColor Green
Write-Host "💡 Para ativar o ambiente (PowerShell): $ActivatePs1" -ForegroundColor Cyan
