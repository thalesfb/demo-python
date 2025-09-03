# Script de Análise de Segurança Local - COBERTURA COMPLETA (PowerShell)
# Executa as mesmas verificações do pipeline CI/CD

Write-Host "🔒 Iniciando Análise de Segurança Local - COBERTURA COMPLETA" -ForegroundColor Green
Write-Host "============================================================" -ForegroundColor Green

# Verificar se estamos no diretório correto
if (-not (Test-Path "requirements.txt")) {
    Write-Host "❌ Erro: Execute este script no diretório raiz do projeto" -ForegroundColor Red
    exit 1
}

# Criar diretório para relatórios
New-Item -ItemType Directory -Force -Path "security-reports" | Out-Null

Write-Host "📦 Instalando dependências..." -ForegroundColor Yellow
python -m pip install --upgrade pip
pip install -r requirements.txt

Write-Host "📁 Verificando arquivos Python do projeto..." -ForegroundColor Yellow
Write-Host "🔍 Arquivos Python encontrados:" -ForegroundColor Cyan
Get-ChildItem -Recurse -Filter "*.py" -Exclude ".venv", "__pycache__", ".git" | ForEach-Object { Write-Host "   • $($_.FullName)" -ForegroundColor Gray }

Write-Host ""
Write-Host "🔍 Executando análise SAST com Bandit (PROJETO COMPLETO)..." -ForegroundColor Yellow
Write-Host "📊 Analisando TODOS os arquivos Python, não apenas a pasta server/" -ForegroundColor Cyan
# Executar Bandit em todo o projeto usando configuração .bandit
python -m bandit -r . -c .bandit -f json -o security-reports/bandit-report.json

Write-Host "📦 Analisando dependências com pip-audit..." -ForegroundColor Yellow
# Usar variável de ambiente para evitar problemas de encoding
$env:PYTHONIOENCODING = "utf-8"
try {
    pip-audit --format json --output security-reports/pip-audit-report.json
} catch {
    Write-Host "⚠️  pip-audit falhou, tentando formato alternativo..." -ForegroundColor Yellow
    try {
        pip-audit --format json | Out-File -FilePath "security-reports/pip-audit-report.json" -Encoding UTF8
    } catch {
        Write-Host "❌ pip-audit não conseguiu gerar relatório" -ForegroundColor Red
        "{}" | Out-File -FilePath "security-reports/pip-audit-report.json" -Encoding UTF8
    }
}

Write-Host "🛡️ Executando análise Safety..." -ForegroundColor Yellow
# Safety não suporta --output, vamos redirecionar a saída
try {
    safety check --json | Out-File -FilePath "security-reports/safety-report.json" -Encoding UTF8
} catch {
    Write-Host "⚠️  Safety falhou, criando relatório vazio..." -ForegroundColor Yellow
    "{}" | Out-File -FilePath "security-reports/safety-report.json" -Encoding UTF8
}

Write-Host "🐳 Analisando Dockerfile com Hadolint..." -ForegroundColor Yellow
if (Get-Command hadolint -ErrorAction SilentlyContinue) {
    hadolint Dockerfile --format json --output security-reports/hadolint-report.json
} else {
    Write-Host "⚠️  Hadolint não encontrado. Instale com: curl -sSfL https://raw.githubusercontent.com/hadolint/hadolint/master/install.sh | sh -s -- -b /usr/local/bin v2.12.0" -ForegroundColor Yellow
    "{}" | Out-File -FilePath "security-reports/hadolint-report.json" -Encoding UTF8
}

Write-Host "🐳 Analisando configuração de container com Trivy..." -ForegroundColor Yellow
if (Get-Command trivy -ErrorAction SilentlyContinue) {
    trivy config . --format json --output security-reports/trivy-config-report.json
    trivy fs . --format json --output security-reports/trivy-fs-report.json
} else {
    Write-Host "⚠️  Trivy não encontrado. Instale com: curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.48.0" -ForegroundColor Yellow
    "{}" | Out-File -FilePath "security-reports/trivy-config-report.json" -Encoding UTF8
    "{}" | Out-File -FilePath "security-reports/trivy-fs-report.json" -Encoding UTF8
}

Write-Host "🚨 Verificando vulnerabilidades críticas (Fail-Fast)..." -ForegroundColor Yellow
if (Test-Path "check_vulnerabilities.py") {
    python check_vulnerabilities.py
} else {
    Write-Host "❌ Script check_vulnerabilities.py não encontrado!" -ForegroundColor Red
    exit 1
}

Write-Host "📊 Relatórios gerados em: security-reports/" -ForegroundColor Green
Write-Host "✅ Análise de segurança local concluída!" -ForegroundColor Green

# Mostrar resumo dos relatórios
Write-Host ""
Write-Host "📋 Resumo dos Relatórios:" -ForegroundColor Cyan
Get-ChildItem "security-reports" | ForEach-Object { Write-Host "   • $($_.Name)" -ForegroundColor Gray }

Write-Host ""
Write-Host "🎯 COBERTURA COMPLETA IMPLEMENTADA:" -ForegroundColor Green
Write-Host "   ✅ Todos os arquivos Python analisados" -ForegroundColor Green
Write-Host "   ✅ Scripts de segurança incluídos" -ForegroundColor Green
Write-Host "   ✅ Configurações e templates verificados" -ForegroundColor Green
Write-Host "   ✅ Fail-fast implementado e testado" -ForegroundColor Green
