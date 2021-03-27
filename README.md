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
#=> :world
```

A definição de uma função tem a notação:

```elixir
def hello do
  :world
end
```

### Somando todos elementos de uma lista recursivamente

Vamos criar uma função chamada `sum` que recebe como argumentos uma lista e um acumulador. Com o pattern matching, vamos definir qual função rodar. Vou primeiro criar uma função que recebe uma lista vazia `[]` e um acumulador `acc`.

```elixir
defmodule SumList do
  def sum([], acc) do
    0
  end
end
```

No `iex`, rodar a função passando como argumentos uma lista vazia `[]` e um número qualquer `0`.

```elixir
SumList.sum([], 0)
#=> 0
```

Mas se passarmos uma lista contendo números

```elixir
SumList.sum([1,2,3], 0)
#=> ** (FunctionClauseError) no function clause matching in SumList.sum/2
```

Vai retornar um erro de pattern matching, pois a função espera receber uma lista fazia.

Vamos criar uma outra função com o mesmo nome `sum`, mas agora vou receber uma lista com elementos

```elixir
def sum([head | tail], acc) do
  head
end
```

Vendo no `iex`

```elixir
SumList.sum([1,2,3], 0)
#=> 1
```

Ou podemos atribuir o pattern matching a uma variável

```elixir
def sum([head | tail] = list, acc) do
  list
end
```

Vendo no `iex`

```elixir
SumList.sum([5,2,3], 0)
#=> [5, 2, 3]
```

Fazendo a função

```elixir
defmodule SumList do
  def sum([], acc) do
    acc
  end

  def sum([head | tail], acc) do
    acc = acc + head
    sum(tail, acc)
  end
end
```

O teste de mesa seria:
Ao chamar a função `sum([1,2,3], 0)`, a recursão será:

- 1a execução: [1,2,3] hd: 1, tl: [2,3], 0 -> acc = 0 + 1, sum([2,3], 1)
- 2a execução: [2,3] hd: 1, tl: [3], 1 -> acc = 1 + 2, sum([3], 3)
- 3a execução: [3] hd: 3, tl: [], 3 -> acc = 3 + 3, sum([], 3)
- 4a execução: [] acc = 6

E para não dar errado quando passar um número qualquer de `acc` quando passar uma lista vazia, vamos deixar ambas funções `sum` privadas e criar uma função `call` pública que vai acessar essas funções dentro do próprio módulo.

```elixir
defmodule SumList do
  def call(list), do: sum(list, 0)

  defp sum([], acc), do: acc

  defp sum([head | tail], acc) do
    acc = acc + head
    sum(tail, acc)
  end
end
```

Então, se tentar chamar o método `sum`, já não vai dar mais certo

```elixir
SumList.sum([5,2,3])
#=> ** (UndefinedFunctionError) function SumList.sum/1 is undefined or private
#=>    (sum_list 0.1.0) SumList.sum([5, 2, 3])
```

E rodando a função:

```elixir
SumList.call([5,2,3])
#=> 10
```

### Tail Call Optimization

[Tail Call Optimization](https://www.notion.so/Recursividade-e-Tail-Call-Optimization-79f2a8103b174d6db58d8bea19546c0d) seria uma recursão mais otimizada. Na nossa função, na verdade não precisaria do `acc`. Seria só retornar a `head` somada com a chamada da próxima recursão.

```elixir
defmodule SumList do
  def call(list), do: sum(list)

  defp sum([]), do: 0

  defp sum([head | tail]) do
    head + sum(tail)
  end
end
```
