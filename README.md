## Users Crud API

## Introdução

Esse projeto é um simples crud de usuários com autorização e testes automatizados.
Gems utilizadas no projeto:

- [Discart](https://github.com/jhawthorn/discard) - Usada para fazer soft-delete
- [ffaker](https://github.com/ffaker/ffaker) - Usada para criar dados aleátorios em cada teste realizado
- [database_cleaner](https://github.com/DatabaseCleaner/database_cleaner) - Usada para limpar a base de dados a cada teste realizado
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails) - Usada para automatizar a criação de usuários nos testes
- [capybara](https://github.com/teamcapybara/capybara) - Disponibiliza uma série de comandos para usar durante o desenvolvimento dos testes
- [rspec-json_expectations](https://www.google.com/search?client=ubuntu&channel=fs&q=rspec-json_expectations&ie=utf-8&oe=utf-8) - Disponibiliza comandos utéis para respostas em JSON

---

Para usar a API, utilize o endereço:

`https://todo/[command]`

Onde [command] pode ser um dos serviços listados abaixo:

---

### Criar usuário

Comando: POST `auth`

Body Type: JSON

```
{
  "first_name": "João",
  "last_name": "da Silva",
  "email": "joao@email.com",
  "password": "12345678",
  "password_confirmation": "12345678"
}

```

**Retorno**: Um JSON com as informações do usuário cadastrado.

---

### Se autenticar com um usuário

Comando: POST `auth/sign_in`

Body Type: JSON

```
{
  "email": "joao@email.com",
  "password": "12345678"
}
```

**Retorno**: JSON com as informações do usuário auntenticado.

---

**Guarde os seguintes campos do Header para usar nas próximas requisições**

`Content-Type`, `access-token`, `token-type`, `client`, `expiry`, `uid`

---

### Listar Usuários

Comando: GET `users`

**Headers**: `Content-Type`, `access-token`, `token-type`, `client`, `expiry`, `uid`

**Permissão necessária**: Usuário autenticado deve ser administrador.

**Retorno**: Um JSON com a lista de Usuários cadastrados.

---

### Mostrar perfil de um usuário

Comando GET `users/:id`

**Headers**: `Content-Type`, `access-token`, `token-type`, `client`, `expiry`, `uid`

**Permissão necessária**: Usuário autenticado deve ser administrador ou dono do perfil acessado.

**Retorno**: Um JSON com as informações do usuário selecionado.

---

### Editar um usuário

Comando: PUT `users/:id`

**Headers**: `Content-Type`, `access-token`, `token-type`, `client`, `expiry`, `uid`

**Permissão necessária**: Usuário autenticado deve ser administrador ou dono do perfil acessado.

Escolha quais campos do usuário você quer atualizar:
`first_name`, `last_name`, `email`, `password`, `role`

Exemplo:

```
{
  "last_name": "da Silva Santos"
}
```

**Retorno**: Um JSON com os novos valores do usuário

---

### Deletar um usuário

Comando: DELETE `users/:id`

**Headers**: `Content-Type`, `access-token`, `token-type`, `client`, `expiry`, `uid`

**Permissão necessária**: Usuário autenticado deve ser administrador ou dono do perfil acessado.

**Retorno**: Nenhum retorno
