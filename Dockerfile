# Dockerfile com práticas de segurança para container hardening
# Baseado nas recomendações do CIS Benchmarks e OWASP

# Usar imagem base oficial e específica
FROM python:3.11-slim

# Definir usuário não-root
RUN groupadd -r appuser && useradd -r -g appuser appuser

# Definir diretório de trabalho
WORKDIR /app

# Instalar dependências do sistema com versões específicas
RUN apt-get update && apt-get install -y \
  --no-install-recommends \
  curl \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean

# Copiar arquivos de dependências primeiro (otimização de cache)
COPY requirements.txt .

# Instalar dependências Python
RUN pip install --no-cache-dir --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

# Copiar código da aplicação
COPY . .

# Remover arquivos desnecessários
RUN rm -rf .git tests/ __pycache__/ .pytest_cache/ \
  && find . -name "*.pyc" -delete \
  && find . -name "*.pyo" -delete

# Configurar permissões de segurança
RUN chown -R appuser:appuser /app \
  && chmod -R 755 /app \
  && chmod 644 /app/*.py

# Mudar para usuário não-root
USER appuser

# Expor porta (se necessário)
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:8000/health || exit 1

# Comando de inicialização
CMD ["python", "server/app.py"]
