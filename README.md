# 🛒 Banco de Dados: LojaDB

> Estrutura de banco de dados e consultas SQL para um sistema de gerenciamento de loja (clientes, produtos, pedidos e categorias).

Este repositório contém um script SQL completo para a criação e manipulação do banco de dados `LojaDB`. Ele foi desenvolvido como um exercício prático para treinar a criação de tabelas, relacionamentos (chaves primárias e estrangeiras), inserção de dados e consultas avançadas utilizando `JOINs`, funções de agregação e criação de `VIEWs`.

---

## 🗄️ Estrutura do Banco de Dados

O banco de dados é composto por 5 tabelas interligadas:

* **Clientes:** Armazena as informações dos clientes (`ClienteID`, `NomeCliente`, `Cidade`).
* **Categorias:** Contém os tipos de categorias dos produtos (`CategoriaID`, `NomeCategoria`).
* **Produtos:** Registra os itens à venda, vinculando-os a uma categoria (`ProdutoID`, `NomeProduto`, `CategoriaID`, `Preco`).
* **Pedidos:** Guarda as informações das compras feitas, ligando-as aos clientes (`PedidoID`, `ClienteID`, `DataPedido`).
* **DetalhesPedidos:** Relaciona os pedidos aos produtos, armazenando a quantidade comprada (`DetalheID`, `PedidoID`, `ProdutoID`, `Quantidade`).

### 📊 Diagrama de Relacionamento (Resumo)
* `Pedidos` pertence a um `Cliente`.
* `Produtos` pertence a uma `Categoria`.
* `DetalhesPedidos` faz a ponte (N:M) entre `Pedidos` e `Produtos`.

---

## 📝 Exercícios Resolvidos no Script

O script inclui 9 consultas (queries) que resolvem problemas de negócio comuns:

1. **Clientes com Pedidos:** Lista clientes que já fizeram compras, junto com o ID e data do pedido (`INNER JOIN`).
2. **Todos os Clientes:** Lista todos os clientes da base, independentemente de terem feito pedidos ou não (`LEFT JOIN`).
3. **Detalhes das Compras:** Mostra o nome do cliente, os produtos comprados, a quantidade e a data (`Múltiplos JOINs`).
4. **Contagem de Pedidos por Data:** Exibe o total de pedidos realizados em cada data (`COUNT` e `GROUP BY`).
5. **Total de Itens por Cliente:** Calcula a quantidade total de itens (produtos físicos) comprados por cada cliente (`SUM`).
6. **Valor Gasto por Cliente:** Calcula o total financeiro (R$) gasto por cliente, multiplicando preço por quantidade.
7. **Produtos Mais Vendidos:** Ranking de produtos baseado na quantidade total vendida.
8. **Faturamento Diário:** Criação de uma `VIEW` (`vw_FaturamentoPorData`) para visualizar o total faturado por dia.
9. **Faturamento por Categoria:** Criação de uma `VIEW` (`vw_VendasPorCategoria`) para mostrar o valor total vendido em cada categoria (ex: Eletrônicos, Vestuário).

---

## ⚙️ Como executar

1. Instale um gerenciador de banco de dados relacional que suporte a sintaxe SQL padrão (como MySQL, MariaDB, SQL Server, etc.). Recomendação: **MySQL Workbench** ou **DBeaver**.
2. Copie o conteúdo do script `.sql`.
3. Cole no seu console/editor de queries.
4. Execute o script inteiro de uma vez (ou linha a linha) para criar o banco, popular os dados e testar as consultas.

---
**Aviso:** O script inicial contém um comando `DROP DATABASE lojadb;`. Tenha cuidado ao executá-lo caso já possua um banco de dados importante com esse mesmo nome no seu ambiente local.
