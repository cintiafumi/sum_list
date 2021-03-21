# SumList

### Criando um projeto

Quando possuímos elixir instalado, temos tanto o `iex` como o `mix`, que é o CLI do exilir para gerenciar projetos e rodar determinadas tasks.

Para criar um projeto novo usando [mix new](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html#our-first-project):

```bash
mix new sum_list
```

O projeto vai ter uma estrutura básica contendo: a pasta `lib` com o módulo principal `SumList` com o nome do projeto, uma pasta `test` desse módulo, um arquivo `mix.exs` com as configurações do projeto, e o arquivo `.formatter.exs` que é o formatador que segue a guideline da comunidade.

No terminal, rodamos todos os testes do projeto pelo comando:

```bash
mix test
```

E o comando para compilar o projeto:

```bash
mix compile
```

E o comando para formatar o projeto:

```bash
mix format
```

Dentro do módulo principal, temos `@moduledoc` e `@doc` que fazem parte da documentação. Por enquanto, vamos ignorar.

Para rodar o projeto dentro do `iex`, basta rodar o comando:

```bash
iex -S mix
```

Esse comando já compila e carrega o projeto para ser usado no `iex`, podendo usar então o módulo `SumList`:

```elixir
SumList.hello
#+> :world
```

A definição de uma função tem a notação:

```elixir
def hello do
  :world
end
```
