-- Criando o banco de dados chamado LojaDB
drop database lojadb;
CREATE DATABASE LojaDB;

-- Usando o banco de dados LojaDB para as próximas operações
USE LojaDB;
-- Criando a tabela Clientes que armazena os dados dos clientes
create TABLE Clientes (
    ClienteID INT PRIMARY KEY,  -- ClienteID é a chave primária, ou seja, identifica unicamente cada cliente
    NomeCliente VARCHAR(100),   -- Nome do cliente
    Cidade VARCHAR(50)          -- Cidade onde o cliente mora
);
-- Criando a tabela Categorias que armazena as categorias dos produtos
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY,  -- CategoriaID é a chave primária
    NomeCategoria VARCHAR(100)    -- Nome da categoria
);
-- Criando a tabela Produtos que armazena os dados dos produtos disponíveis
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY,  -- ProdutoID é a chave primária
    NomeProduto VARCHAR(100),   -- Nome do produto
    CategoriaID INT,            -- CategoriaID é uma chave estrangeira
    Preco DECIMAL(10, 2),       -- Preço do produto
   
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);
-- Criando a tabela Pedidos que armazena os pedidos feitos pelos clientes
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,   -- PedidoID é a chave primária
    ClienteID INT,              -- ClienteID é uma chave estrangeira
    DataPedido DATE,            -- Data do pedido
   
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);
-- Criando a tabela DetalhesPedidos que armazena os produtos de cada pedido
CREATE TABLE DetalhesPedidos (
    DetalheID INT PRIMARY KEY AUTO_INCREMENT,  -- Identificador único para cada item do pedido
    PedidoID INT,                              -- Relaciona com a tabela Pedidos
    ProdutoID INT,                             -- Relaciona com a tabela Produtos
    Quantidade INT,                            -- Quantidade comprada do produto
   
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);
-- Inserindo clientes na tabela Clientes
INSERT INTO Clientes (ClienteID, NomeCliente, Cidade) VALUES
(1, 'Maria Silva', 'São Paulo'),
(2, 'João Santos', 'Rio de Janeiro'),
(3, 'Ana Costa', 'Belo Horizonte');

-- Inserindo categorias na tabela Categorias
INSERT INTO Categorias (CategoriaID, NomeCategoria) VALUES
(1, 'Eletrônicos'),
(2, 'Vestuário');

-- Inserindo produtos na tabela Produtos
INSERT INTO Produtos (ProdutoID, NomeProduto, CategoriaID, Preco) VALUES
(1, 'Celular', 1, 1500.00),
(2, 'Televisão', 1, 3000.00),
(3, 'Camiseta', 2, 50.00);

-- Inserindo pedidos na tabela Pedidos
INSERT INTO Pedidos (PedidoID, ClienteID, DataPedido) VALUES
(1, 1, '2024-01-15'),
(2, 2, '2024-01-20'),
(3, 1, '2024-02-10');

-- Inserindo detalhes dos pedidos
INSERT INTO DetalhesPedidos (PedidoID, ProdutoID, Quantidade) VALUES
(1, 1, 2), -- Pedido 1 contém 2 unidades do Produto 1
(1, 2, 1), -- Pedido 1 contém 1 unidade do Produto 2
(2, 3, 5), -- Pedido 2 contém 5 unidades do Produto 3
(3, 2, 2); -- Pedido 3 contém 2 unidades do Produto 2

-- Exibindo o nome dos clientes e as datas dos pedidos que eles fizeram
-- exercicio 01
-- Objetivo: Exibir o nome de todos os clientes que fizeram pedidos, mostrando também o ID e a data do pedido.
SELECT
    Clientes.NomeCliente,
    Pedidos.PedidoID,
    Pedidos.DataPedido
FROM Clientes
inner JOIN Pedidos
    ON Pedidos.ClienteID = Clientes.ClienteID;
    -- exercicio 02
    -- Objetivo: Listar todos os clientes, mesmo aqueles que ainda não fizeram pedidos, e exibir o número do pedido, se houver.
    SELECT
    Clientes.NomeCliente,
    Clientes.Cidade,
    Pedidos.DataPedido
FROM Clientes
LEFT JOIN Pedidos
    ON Pedidos.ClienteID = Clientes.ClienteID;
   
    -- exercicio 03
   -- Objetivo: Exibir o nome dos clientes, os produtos comprados, a quantidade de cada produto e a data do pedido.
    SELECT
    Clientes.NomeCliente,
    Pedidos.PedidoID,
    DetalhesPedidos. Quantidade,
    DetalhesPedidos.ProdutoID,
    Pedidos.DataPedido
FROM Clientes
inner JOIN Pedidos
    ON Pedidos.ClienteID = Clientes.ClienteID
inner JOIN DetalhesPedidos
    ON  DetalhesPedidos.PedidoID = Pedidos.PedidoID;
   
    -- exercicio 04
    -- Objetivo: Mostrar quantos pedidos cada cliente fez.
    SELECT
   datapedido,
   count(pedidoID) as "total pedido "
   
   from pedidos
   group by datapedido;
   
   -- exercicio 05
   -- Objetivo: Mostrar a quantidade total de itens comprados por cada cliente.
    SELECT
    Clientes.NomeCliente as "nome clientes",
   sum(  DetalhesPedidos.Quantidade) as "total pedido "
   from clientes
   INNER JOIN Pedidos
	on Clientes.clienteid = pedidos.ClienteID
    inner join   DetalhesPedidos
    on  Pedidos.pedidoid =  DetalhesPedidos.pedidoid
   group by Clientes.NomeCliente;
   
   -- exercicio 06
   -- Objetivo: Mostrar o valor total gasto por cada cliente.
   select
    Clientes.NomeCliente as "nome clientes",
   SUM(DetalhesPedidos.Quantidade * Produtos.Preco) as "total gasto"
from Clientes
inner join Pedidos
    on Clientes.ClienteID = Pedidos.ClienteID
inner join DetalhesPedidos
    on Pedidos.PedidoID = DetalhesPedidos.PedidoID
inner join Produtos
    on Produtos.ProdutoID = DetalhesPedidos.ProdutoID
group by Clientes.NomeCliente;

 -- exercicio 07
 -- Objetivo: Exibir os produtos mais vendidos com base no total de quantidades vendidas.
 SELECT
    Produtos.NomeProduto,
    SUM(DetalhesPedidos.Quantidade) AS QuantidadeVendida
FROM Produtos

INNER JOIN DetalhesPedidos
    ON Produtos.ProdutoID = DetalhesPedidos.ProdutoID
    
GROUP BY Produtos.ProdutoID, Produtos.NomeProduto;

-- exercicio 08
-- Objetivo: Exibir o total faturado em cada data de pedido.
create view vw_FaturamentoPorData as
SELECT
    Pedidos.DataPedido,
    COUNT(Pedidos.PedidoID) AS "total pedido",
    SUM(DetalhesPedidos.Quantidade * Produtos.Preco) AS "total gasto"
FROM Pedidos
inner join DetalhesPedidos
    ON Pedidos.PedidoID = DetalhesPedidos.PedidoID
inner join Produtos
    ON Produtos.ProdutoID = DetalhesPedidos.ProdutoID
GROUP BY Pedidos.DataPedido;
-- exercicio 09
-- Objetivo: Criar uma VIEW que mostre o valor total vendido por categoria de produto
CREATE VIEW vw_VendasPorCategoria AS
SELECT
    c.NomeCategoria AS "nome da categoria",
    SUM(dp.Quantidade * p.Preco) AS "total"
FROM Pedidos ped
INNER JOIN DetalhesPedidos dp
    ON ped.PedidoID = dp.PedidoID
INNER JOIN Produtos p
    ON p.ProdutoID = dp.ProdutoID
INNER JOIN Categorias c
    ON c.CategoriaID = p.CategoriaID
GROUP BY c.NomeCategoria;
