use bando_de_dados_ecommerce;

/* Questão 1 - Quais os nomes dos produtos não têm nenhuma venda?
	a) Responder com Exists.
	b) Responder com All.
	c) Responder com Join.
*/

-- Letra a
SELECT p.nome, p.codProduto FROM 
	produto p WHERE NOT EXISTS (
	SELECT v.codProduto 
    FROM venda AS v 
    WHERE v.codProduto = p.codProduto
);

-- Letra b

SELECT p.nome, p.codProduto FROM 
	produto p where p.codProduto != ALL (
	SELECT v.codProduto FROM venda v
);

-- Letra c

SELECT p.nome 
FROM produto AS p 
LEFT JOIN venda AS v ON p.codProduto = v.codProduto 
WHERE v.codProduto IS NULL;

-- Questão 2 - Qual o produto vendido que teve mais troca em 2016? Informar além do código e do nome do produto, a quantidade de troca do produto.

SELECT codProdutoVenda, produto.nome, SUM(quantidade) AS QuantidadeTroca 
FROM trocaproduto
INNER JOIN produto ON trocaproduto.codProdutoVenda = produto.codProduto	
WHERE YEAR(trocaproduto.dataTroca) = 2016 
GROUP BY codProdutoVenda
HAVING QuantidadeTroca = (
	SELECT MAX(total)
	FROM (
		SELECT codProdutoVenda, SUM(quantidade) AS total 
		FROM trocaproduto 
		GROUP BY codProdutoVenda
	) AS MaisTrocados
);

-- Questão 3 - Qual o percentual de produto vendido foi trocado? Mostrar o percentual com somente duas casas decimais. 
-- OBS: Considerar um produto vendido como a relação de venda de um produto em um determinado pedido.
-- Qual o percentual de vendas resultou em trocas?

SELECT TRUNCATE(
	100 * (SELECT COUNT(*) AS quantidadeTotalTrocados FROM trocaproduto) / (SELECT COUNT(*) AS quantidadeTotalVendas FROM venda)
, 2) AS PercentualPedProdVendido;


/* Questão 4 - Quais produtos vendidos têm pelo menos uma troca? Informar o código e o nome do produto.
	a) Responder com Exists.
	b) Responder com Any.
*/
-- Letra a)
SELECT p.nome, p.codProduto
FROM produto AS p
WHERE EXISTS (
	SELECT * 
	FROM trocaproduto AS t 
	WHERE p.codProduto = t.codProdutoVenda
);

-- Letra b)
SELECT p.nome, p.codProduto
FROM produto AS p
	WHERE p.codProduto = ANY (
		SELECT t.codProdutoVenda 
		FROM trocaproduto AS t 
        WHERE p.codProduto = t.codProdutoVenda
);

/* Questão 5 - Quais produtos vendidos têm pelo menos duas trocas? Informar o código, o nome do produto e a quantidade de troca. */
SELECT 
    p.codProduto, 
    p.nome,
    COUNT(t.codProdutoTrocado) AS QuantidadeTroca
FROM 
    trocaproduto AS t
JOIN 
    produto AS p ON t.codProdutoVenda = p.codProduto
GROUP BY 
    p.codProduto
HAVING 
    COUNT(t.codProdutoVenda) >= 2;
    
/* Questão 6. Qual é o produto mais vendido entre fevereiro e novembro de 2016? Informar além do código e do
nome do produto, a quantidade vendida. */

SELECT 
    trocaproduto.codProdutoVenda, 
    produto.nome,
    trocaproduto.dataTroca,
    SUM(venda.quantidade) AS resultado
FROM 
    trocaproduto
INNER JOIN 
    produto ON trocaproduto.codProdutoVenda = produto.codProduto
INNER JOIN 
    venda ON produto.codProduto = venda.codProduto
WHERE 
    MONTH(trocaproduto.dataTroca) BETWEEN 2 AND 11
GROUP BY 
    trocaproduto.codProdutoVenda, produto.nome, trocaproduto.dataTroca
HAVING SUM(venda.quantidade) = (
    SELECT MAX(total_vendas) 
    FROM (
        SELECT SUM(quantidade) AS total_vendas
        FROM venda
        GROUP BY codProduto
    ) AS vendas_por_produto
);

/* Questão 7 - Qual o total de pedidos de cada forma de pagamento entre 2015 e 2016? */

SELECT formaPagamento, COUNT(*) AS totalPedidos
FROM pedido
WHERE YEAR(data) BETWEEN 2015 AND 2016
GROUP BY formaPagamento;

/* Questão 8 - Qual cliente mais comprou produto entre 2016 e 2017? Informar o código e o nome do cliente, o tipo
do cliente (física ou jurídica) e a quantidade que comprou. */

SELECT 
    c.codCliente, 
    c.nome, 
    c.tipoCliente, 
    SUM(v.quantidade) AS quantidadeComprada
FROM 
    venda AS v
INNER JOIN 
    pedido AS p ON v.codPedido = p.codPedido
INNER JOIN 
    cliente AS c ON p.codCliente = c.codCliente
WHERE 
    YEAR(p.data) BETWEEN 2016 AND 2017
GROUP BY 
    c.codCliente, c.nome, c.tipoCliente
HAVING SUM(v.quantidade) = (
        SELECT MAX(totalCompras)
        FROM (
            SELECT SUM(v2.quantidade) AS totalCompras
            FROM venda v2
            INNER JOIN pedido p2 ON v2.codPedido = p2.codPedido
            WHERE YEAR(p2.data) BETWEEN 2016 AND 2017
            GROUP BY p2.codCliente
        ) AS resultado
);

/* Questão 9 - Quais os pedidos não têm nenhuma venda realizada? Mostrar o código, o ano e o status do pedido e
também o nome e o tipo do cliente. */

SELECT pedido.codPedido, YEAR(pedido.data) AS Ano, pedido.status, cliente.nome, cliente.tipoCliente 
FROM PEDIDO
INNER JOIN cliente ON pedido.codCliente = cliente.codCliente
WHERE status = 'negado' OR status = 'em andamento'
GROUP BY pedido.codPedido, pedido.data, pedido.status, cliente.nome, cliente.tipoCliente;

/* Questão 10 - Qual a quantidade de pedidos aprovados por tipo de cliente (pessoa física e jurídica)? */

SELECT 
    c.tipoCliente, 
    COUNT(p.codPedido) AS QtdPedidos
FROM 
    pedido p
INNER JOIN 
    cliente c ON p.codCliente = c.codCliente
WHERE 
    p.status = 'aprovado'
GROUP BY 
    c.tipoCliente;