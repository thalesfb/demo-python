# Script de Análise de Segurança Local para Windows
# Executa as mesmas verificações do pipeline CI/CD

Write-Host "🔒 Iniciando Análise de Segurança Local..." -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

# Verificar se estamos no diretório correto
if (-not (Test-Path "requirements.txt")) {
    Write-Host "❌ Erro: Execute este script no diretório raiz do projeto" -ForegroundColor Red
    exit 1
}

# Criar diretório para relatórios
if (-not (Test-Path "security-reports")) {
    New-Item -ItemType Directory -Name "security-reports" | Out-Null
}

Write-Host "📦 Instalando dependências..." -ForegroundColor Yellow
python -m pip install --upgrade pip
pip install -r requirements.txt

Write-Host "🔍 Executando análise SAST com Bandit..." -ForegroundColor Yellow
python -m bandit -r . -f json -o security-reports/bandit-report.json -c .bandit

Write-Host "📦 Analisando dependências com pip-audit..." -ForegroundColor Yellow
pip-audit --format json --output security-reports/pip-audit-report.json

Write-Host "🛡️ Executando análise Safety..." -ForegroundColor Yellow
safety check --json --output security-reports/safety-report.json

Write-Host "🐳 Analisando Dockerfile com Hadolint..." -ForegroundColor Yellow
try {
    hadolint Dockerfile --format json --output security-reports/hadolint-report.json
} catch {
    Write-Host "⚠️  Hadolint não encontrado. Instale com: choco install hadolint" -ForegroundColor Yellow
}

Write-Host "🐳 Analisando configuração de container com Trivy..." -ForegroundColor Yellow
try {
    trivy config . --format json --output security-reports/trivy-config-report.json
    trivy fs . --format json --output security-reports/trivy-fs-report.json
} catch {
    Write-Host "⚠️  Trivy não encontrado. Instale com: choco install trivy" -ForegroundColor Yellow
}

Write-Host "🚨 Verificando vulnerabilidades críticas..." -ForegroundColor Yellow
if (Test-Path "check_vulnerabilities.py") {
    python check_vulnerabilities.py
}

Write-Host "📊 Relatórios gerados em: security-reports/" -ForegroundColor Green
Write-Host "✅ Análise de segurança local concluída!" -ForegroundColor Green

# Mostrar resumo dos relatórios
Write-Host ""
Write-Host "📋 Resumo dos Relatórios:" -ForegroundColor Cyan
Get-ChildItem "security-reports" | Format-Table Name, Length, LastWriteTime
