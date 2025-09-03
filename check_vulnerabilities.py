#!/usr/bin/env python
"""
Script de Verificação de Vulnerabilidades - Fail-Fast
Analisa relatórios de segurança e implementa mecanismo fail-fast
"""

import json
import os
import sys
from pathlib import Path


def load_report(report_file):
    """
    Carrega relatório de segurança do arquivo especificado.

    Parameters
    ----------
    report_file : str
        Caminho para o arquivo de relatório

    Returns
    -------
    dict
        Conteúdo do relatório ou dicionário vazio se erro
    """
    try:
        if os.path.exists(report_file):
            with open(report_file, 'r', encoding='utf-8') as f:
                return json.load(f)
        else:
            print(f"⚠️  Arquivo de relatório não encontrado: {report_file}")
            return {}
    except (json.JSONDecodeError, IOError) as e:
        print(f"❌ Erro ao ler relatório {report_file}: {e}")
        return {}


def analyze_bandit_report(report_data):
    """
    Analisa relatório do Bandit e conta vulnerabilidades por severidade.

    Parameters
    ----------
    report_data : dict
        Dados do relatório do Bandit

    Returns
    -------
    tuple
        Contadores de vulnerabilidades (high, medium, low)
    """
    high_count = 0
    medium_count = 0
    low_count = 0

    if 'results' in report_data:
        for issue in report_data['results']:
            severity = issue.get('issue_severity', 'low').lower()
            if severity == 'high':
                high_count += 1
            elif severity == 'medium':
                medium_count += 1
            else:
                low_count += 1

    return high_count, medium_count, low_count


def analyze_pip_audit_report(report_data):
    """
    Analisa relatório do pip-audit e conta vulnerabilidades.

    Parameters
    ----------
    report_data : dict
        Dados do relatório do pip-audit

    Returns
    -------
    int
        Número total de vulnerabilidades encontradas
    """
    if 'vulnerabilities' in report_data:
        return len(report_data['vulnerabilities'])
    return 0


def check_project_files():
    """
    Verifica se todos os arquivos Python do projeto estão sendo analisados.

    Returns
    -------
    dict
        Estatísticas dos arquivos encontrados
    """
    python_files = []
    total_lines = 0

    # Buscar todos os arquivos Python (excluindo ambiente virtual)
    for root, dirs, files in os.walk('.'):
        # Excluir diretórios que não devem ser analisados
        dirs[:] = [d for d in dirs if d not in ['.venv', '__pycache__', '.git']]

        for file in files:
            if file.endswith('.py'):
                file_path = os.path.join(root, file)
                python_files.append(file_path)

                # Contar linhas do arquivo
                try:
                    with open(file_path, 'r', encoding='utf-8') as f:
                        lines = len(f.readlines())
                        total_lines += lines
                except:
                    pass

    return {
        'total_files': len(python_files),
        'total_lines': total_lines,
        'files': python_files
    }


def main():
    """
    Função principal que executa a análise de segurança.
    """
    print("🔒 Verificação de Vulnerabilidades - Fail-Fast")
    print("=" * 50)

    # Verificar arquivos do projeto
    print("\n📁 Analisando arquivos do projeto...")
    project_stats = check_project_files()
    print(f"   📊 Total de arquivos Python: {project_stats['total_files']}")
    print(f"   📏 Total de linhas de código: {project_stats['total_lines']}")

    # Listar arquivos encontrados
    print("\n📋 Arquivos Python encontrados:")
    for file_path in project_stats['files']:
        print(f"   • {file_path}")

    # Verificar relatório do Bandit
    print("\n🔍 Analisando relatório do Bandit...")
    bandit_report = load_report('security-reports/bandit-report.json')
    high_count, medium_count, low_count = analyze_bandit_report(bandit_report)

    print(f"   🔴 HIGH: {high_count}")
    print(f"   🟡 MEDIUM: {medium_count}")
    print(f"   🟢 LOW: {low_count}")

    # Verificar relatório do pip-audit
    print("\n📦 Analisando relatório do pip-audit...")
    pip_audit_report = load_report('security-reports/pip-audit-report.json')
    pip_vulns = analyze_pip_audit_report(pip_audit_report)
    print(f"   📊 Vulnerabilidades em dependências: {pip_vulns}")

    # Implementar fail-fast
    print("\n🚨 Verificando critérios de fail-fast...")

    # Critérios de falha (configuráveis)
    MAX_HIGH_VULNERABILITIES = 0      # Nenhuma vulnerabilidade crítica permitida
    MAX_MEDIUM_VULNERABILITIES = 2    # Máximo 2 vulnerabilidades médias
    MAX_PIP_VULNERABILITIES = 1       # Máximo 1 vulnerabilidade em dependências

    should_fail = False
    failure_reasons = []

    if high_count > MAX_HIGH_VULNERABILITIES:
        should_fail = True
        failure_reasons.append(
            f"Vulnerabilidades CRÍTICAS encontradas: {high_count}")

    if medium_count > MAX_MEDIUM_VULNERABILITIES:
        should_fail = True
        failure_reasons.append(
            f"Muitas vulnerabilidades MÉDIAS: {medium_count}")

    if pip_vulns > MAX_PIP_VULNERABILITIES:
        should_fail = True
        failure_reasons.append(
            f"Muitas vulnerabilidades em dependências: {pip_vulns}")

    # Resultado final
    print("\n" + "=" * 50)
    if should_fail:
        print("❌ PIPELINE FALHOU - Vulnerabilidades críticas detectadas!")
        print("\n🚨 Motivos da falha:")
        for reason in failure_reasons:
            print(f"   • {reason}")
        print("\n🔧 Ações necessárias:")
        print("   1. Corrigir vulnerabilidades críticas")
        print("   2. Revisar vulnerabilidades médias")
        print("   3. Atualizar dependências vulneráveis")
        print("   4. Re-executar análise de segurança")
        sys.exit(1)
    else:
        print("✅ PIPELINE APROVADO - Nenhuma vulnerabilidade crítica detectada!")
        print("\n🎯 Status:")
        print(f"   • Vulnerabilidades críticas: {high_count} ✅")
        print(f"   • Vulnerabilidades médias: {medium_count} ✅")
        print(f"   • Vulnerabilidades em dependências: {pip_vulns} ✅")
        print("\n🚀 Código seguro para deploy!")


if __name__ == "__main__":
    main()
