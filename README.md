[![Latest Release](https://img.shields.io/github/release/portabilis/i-diario.svg?label=latest%20release)](https://github.com/portabilis/i-diario/releases)
[![Maintainability](https://api.codeclimate.com/v1/badges/92cee0c65548b4b4653b/maintainability)](https://codeclimate.com/github/portabilis/i-diario/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/92cee0c65548b4b4653b/test_coverage)](https://codeclimate.com/github/portabilis/i-diario/test_coverage)

# i-Diário

Portal do professor integrado com o software livre [i-Educar](https://github.com/portabilis/i-educar)

## Comunicação

Acreditamos que o sucesso do projeto depende diretamente da interação clara e
objetiva entre os membros da Comunidade. Por isso, estamos definindo algumas
políticas para que estas interações nos ajudem a crescer juntos! Você pode
consultar algumas destas boas práticas em nosso [código de
conduta](https://github.com/portabilis/i-diario/blob/master/CODE_OF_CONDUCT.md).

Além disso, gostamos de meios de comunicação assíncrona, onde não há necessidade de
respostas em tempo real. Isso facilita a produtividade individual dos
colaboradores do projeto.

| Canal de comunicação | Objetivos |
|----------------------|-----------|
| [Fórum](https://forum.ieducar.org) | - Tirar dúvidas <br>- Discussões de como instalar a plataforma<br> - Discussões de como usar funcionalidades<br> - Suporte entre membros de comunidade<br> - FAQ da comunidade (sobre o produto e funcionalidades) |
| [Issues do Github](https://github.com/portabilis/i-diario/issues/new/choose) | - Sugestão de novas funcionalidades<br> - Reportar bugs<br> - Discussões técnicas |
| [Telegram](https://t.me/ieducar ) | - Comunicar novidades sobre o projeto<br> - Movimentar a comunidade<br>  - Falar tópicos que **não** demandem discussões profundas |

Qualquer outro grupo de discussão não é reconhecido oficialmente pela
comunidade i-Educar e não terá suporte da Portabilis - mantenedora do projeto.

## Instalação

- Baixar o i-Diário:

```bash
$ git clone https://github.com/portabilis/i-diario.git
$ cd i-diario
```

- Copiar o exemplo de configurações de banco de dados e configurar:

```bash
$  cp config/database.sample.yml config/database.yml
```

### Com Docker

No `config/database.yml` mudar o `host` para `host: postgres`.

- Rode `docker-compose up`.

Por baixo dos panos, será feito:
- setup do `secret_key_base`;
- setup do banco;
- setup das páginas de erro.

Pule para o [**Configuração da Aplicação**](#Configuração-da-Aplicação).

### Sem Docker

- Instalar o Ruby 2.2.6 (Recomendamos uso de um gerenciador de versões como [Rbenv](https://github.com/rbenv/rbenv) ou [Rvm](https://rvm.io/))
- Instalar a gem Bundler:

```bash
$ gem install bundler -v '1.17.3'
```

- Instalar as gems:

```bash
$ bundle install
```

- Criar e configurar o arquivo `config/secrets.yml` conforme o exemplo:

```yaml
development:
  secret_key_base: CHAVE_SECRETA
```

_Nota: Você pode gerar uma chave secreta usando o comando `bundle exec rake secret`_


- Criar o banco de dados:

```bash
$ bundle exec rake db:create
$ bundle exec rake db:migrate
```

- Criar páginas de erro simples para desenvolvimento:

```bash
$ cp public/404.html.sample public/404.html
$ cp public/500.html.sample public/500.html
```

- Iniciar o servidor:

```bash
$ bundle exec rails server
```

## Configuração da Aplicação

- Criar uma entidade:

```bash
$ bundle exec rake entity:setup NAME=prefeitura DOMAIN=localhost DATABASE=prefeitura_diario
```

- Criar um usuário administrador:

Abra o `rails console`.

Sem docker:

```bash
$ bundle exec rails console
```

Com docker:

```bash
$ docker exec -it idiario bundle exec rails console
```

Crie um usuário administrador.

```ruby
Entity.last.using_connection {
  User.create!(
    email: 'admin@domain.com.br',
    password: '123456789',
    password_confirmation: '123456789',
    status: 'actived',
    kind: 'employee',
    admin:  true
  )
}
```

Para acessar o sistema, use a URL http://localhost:3000

## Sincronização com i-Educar

- Acessar Configurações > Api de Integraçao e configurar os dados do sincronismo
- Acessar Configurações > Unidades e clicar em **Sincronizar**
- Acessar Calendário letivo, clicar em **Sincronizar** e configurar os calendários
- Acessar Configurações > Api de Integração e clicar no botão de sincronizar

_Nota: Após esses primeiros passos, recomendamos que a sincronização rode pelo menos diariamente para manter o i-Diário atualizado com o i-Educar_

## Rodar os testes

```bash
$ RAILS_ENV=test bundle exec rake db:create
$ RAILS_ENV=test bundle exec rake db:migrate
```

```bash
$ bin/rspec spec
```

## Desenvolvimento

### Atualizar assets

no arquivo ```/config/enviroments/development``` mudar a linha ```config.assets.debug``` para ```true``

```bash
$ bundle exec rake assets:clean
```
