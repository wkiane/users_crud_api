## Users Crud API

Esse projeto é um simples crud de usuários com autorização e testes automatizados.

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
