# Turistando API 


## Mapeamento de endpoints

### login

- POST /login\
    `{email*, password*}`

### users

- POST /users\
    `{name*, email*, phone*, password*, profile_picture}`
- GET /users/{user_id}
- PATCH /users/{user_id}\
    `{name, email, phone, password, profile_picture}`

### locations

- GET /locations\
    `(city)`
- GET /locations/{location_id}
- POST /locations/{location_id}/review\
    `{rate*}`

### tours

- GET /tours\
    `(user_id, city)`
- POST /tours\
    `{name*, locations*}`
- GET /tours/{tour_id}
- POST /tours/{tour_id}/review\
    `{rate*}`

***

## Algumas pendências
- [ ] Upload/atualização de foto de perfil?
- [ ] Avaliação de tour?
- [ ] Seleção de imagem principal de tour?
- [ ] Seleção de imagem principal de location?
