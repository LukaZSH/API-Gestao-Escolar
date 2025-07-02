# 1. Usar uma imagem base oficial do Python
# A imagem alpine é leve, o que é ótimo para produção.
FROM python:3.13.4-alpine3.22

# 2. Definir variáveis de ambiente
# Impede o Python de gerar arquivos .pyc e mantém os logs sem buffer.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# 3. Definir o diretório de trabalho no contêiner
WORKDIR /app

# 4. Copiar o arquivo de dependências e instalá-las
# Copiamos o requirements.txt primeiro para aproveitar o cache de camadas do Docker.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copiar o restante do código da aplicação
COPY . .

# 6. Expor a porta em que a aplicação será executada
EXPOSE 8000

# 7. Definir o comando para iniciar a aplicação
# Usamos --host 0.0.0.0 para tornar a API acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]