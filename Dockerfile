FROM python:3.13-alpine

WORKDIR /app

COPY . .

# Install required packages (if needed, e.g. gcc, musl-dev for compiling some pip packages)
RUN pip install --no-cache-dir fastapi uvicorn

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
