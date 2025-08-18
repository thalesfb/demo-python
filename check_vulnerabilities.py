#!/usr/bin/env python3
"""
Script para verificar vulnerabilidades encontradas pelo Bandit.
Usado no pipeline DevSecOps para implementar fail-fast.
"""

import json
import sys
from pathlib import Path


def check_bandit_vulnerabilities(report_file: str = "security-reports/bandit-report.json") -> int:
    """
    Verifica vulnerabilidades no relatório do Bandit.

    Política de Fail-Fast:
    - HIGH: Pipeline falha (crítico)
    - MEDIUM: Pipeline continua (aviso)
    - LOW: Pipeline continua (informação)

    Parameters
    ----------
    report_file : str
        Caminho para o arquivo de relatório do Bandit.

    Returns
    -------
    int
        0 se não houver vulnerabilidades HIGH, 1 caso contrário.
    """
    try:
        if not Path(report_file).exists():
            print(f"❌ Arquivo de relatório não encontrado: {report_file}")
            return 1

        with open(report_file, 'r') as f:
            data = json.load(f)

        # Contar vulnerabilidades por severidade
        high_count = sum(1 for issue in data.get('results', [])
                         if issue.get('issue_severity') == 'HIGH')
        medium_count = sum(1 for issue in data.get('results', [])
                           if issue.get('issue_severity') == 'MEDIUM')
        low_count = sum(1 for issue in data.get('results', [])
                        if issue.get('issue_severity') == 'LOW')

        print(f"📊 Resumo de Vulnerabilidades:")
        print(f"   🔴 HIGH: {high_count}")
        print(f"   🟡 MEDIUM: {medium_count}")
        print(f"   🟢 LOW: {low_count}")

        # Pipeline falha APENAS se houver vulnerabilidades HIGH
        if high_count > 0:
            print(
                f"❌ Pipeline falhou - {high_count} vulnerabilidades HIGH encontradas")
            print("🚨 Implementando fail-fast para vulnerabilidades críticas")
            return 1
        else:
            if medium_count > 0 or low_count > 0:
                print(
                    f"⚠️  {medium_count} MEDIUM + {low_count} LOW vulnerabilidades encontradas")
                print(
                    "✅ Pipeline pode prosseguir (apenas vulnerabilidades não-críticas)")
            else:
                print("✅ Nenhuma vulnerabilidade encontrada")
            print("🚀 Pipeline pode prosseguir")
            return 0

    except Exception as e:
        print(f"❌ Erro ao analisar relatório: {e}")
        return 1


if __name__ == "__main__":
    exit_code = check_bandit_vulnerabilities()
    sys.exit(exit_code)
