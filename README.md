# 🐾 PetVida API

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue)
![Node.js](https://img.shields.io/badge/Node.js-Express-green)
![Express](https://img.shields.io/badge/API-REST-black)

## 📖 Sobre o projeto

O PetVida é um sistema desenvolvido para gerenciar uma clínica veterinária. O projeto permite cadastrar tutores, animais, veterinários, consultas e pagamentos, oferecendo uma estrutura organizada para o controle das informações.

Além do gerenciamento das consultas, o sistema utiliza recursos avançados do MySQL, como Views, Stored Procedures, Functions, Triggers e controle de permissões, integrados a uma API REST desenvolvida em Node.js com Express.

---

## DER

![DER](docs/der.png)

---

## Tecnologias

- Node.js
- Express
- MySQL
- mysql2
- dotenv
- cors

---

## Instalação

Clone o repositório:

```bash
git clone <url-do-repositorio>
```

Instale as dependências:

```bash
npm install
```

Configure o arquivo `.env`:

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=sua_senha
DB_NAME=petvida
DB_PORT=3306

PORT=3001
```

Execute:

```bash
node server.js
```

---

## Endpoints

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | /api/veterinarios | Lista veterinários |
| GET | /api/animais | Lista animais |
| GET | /api/consultas/agenda/:data | Agenda por data |
| POST | /api/consultas | Agenda consulta |
| PUT | /api/consultas/:id/concluir | Conclui consulta |
| POST | /api/pagamentos/:consulta_id | Registra pagamento |
| GET | /api/relatorios/dashboard | Dashboard financeiro |
| GET | /api/relatorios/inadimplentes | Lista inadimplentes |

---

## Estrutura do projeto

```
petvida/

database/

backups/

docs/

src/
    config/
    controllers/
    routes/

server.js

package.json
```

---

## Desenvolvedor

Felipe Santos Leal