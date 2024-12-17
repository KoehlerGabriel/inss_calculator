# Calculadora INSS

O projeto é um sistema desenvolvido em Ruby on Rails, com o objetivo de gerenciar o cadastro de proponentes e realizar o cálculo do desconto de INSS de acordo com as faixas salariais. A aplicação também possui um dashboard interativo que permite visualizar os proponentes agrupados por faixa salarial, facilitando a análise dos dados.

## Funcionalidades Principais

### 1. Cadastro de Proponentes
O sistema permite o cadastro completo dos proponentes, com informações como:

- Nome
- CPF
- Salário
- Outros dados pessoais (Contatos e Endereços)

### 2. Cálculo do Desconto de INSS
O sistema realiza automaticamente o cálculo do desconto do INSS de cada proponente com base em sua faixa salarial. O desconto é calculado conforme as alíquotas e limites estabelecidos pela legislação vigente.

O cálculo do desconto leva em consideração a tabela progressiva do INSS, adaptando-se às faixas salariais.

### 3. Dashboard Interativo
O sistema oferece um dashboard que agrupa os proponentes por faixa salarial. Com isso, é possível visualizar a quantidade de proponentes em cada faixa salarial.

# Requisitos

- Docker
- Docker Compose

Certifique-se de ter o [Docker](https://www.docker.com/get-started) e o [Docker Compose](https://docs.docker.com/compose/install/) instalados na sua máquina.

# Setup com Docker

Para configurar o ambiente de desenvolvimento com Docker, siga os seguintes passos:

## 1. Clone o repositório

```bash
git clone https://github.com/KoehlerGabriel/inss_calculator.git
cd inss_calculator
```
## 2. Buildar e subir o projeto

```bash
docker-compose up --build
```

## 3. Criação do Banco, Migrations e Seeds

```bash
docker-compose run --rm app rails db:create
docker-compose run --rm app rails db:migrate
docker-compose run --rm app rails db:seed
```

## 4. Execução dos testes com Rspec

```bash
docker-compose run --rm app rspec
```
