--CARACTERISTICA DO PNEU DE ACORDO COM A MARCA/MODELO/SUBMODELO DE UM CARRO
SELECT Peca.id_peca, Peca.nome_peca, Submodelo.id_submodelo, Marca.nome_marca ,Modelo.nome_modelo, Submodelo.nome_submodelo, Caracteristica.id_caracteristica,Tamanho.nome_tamanho,
indice.nome_indice, Serie.nome_serie, Marca_peca.nome_marca_peca, Aro.nome_aro
FROM Peca, Submodelo, Peca_Submodelo_Caracteristica, Caracteristica, Tamanho, indice, Serie, Modelo, Marca, Marca_peca, Aro
WHERE Caracteristica.id_caracteristica = Peca_Submodelo_Caracteristica.id_caracteristica
and Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca and 
Peca.id_peca = (SELECT DISTINCT Peca.id_peca FROM Peca WHERE Peca.nome_peca='pneu') 
and Caracteristica.id_tamanho= Tamanho.id_tamanho and Caracteristica.id_indice = indice.id_indice 
and Caracteristica.id_serie = Serie.id_serie and Peca_Submodelo_Caracteristica.id_submodelo = Submodelo.id_submodelo
and Submodelo.id_modelo = Modelo.id_modelo and Modelo.id_marca = Marca.id_marca
AND Caracteristica.id_marca_peca = Marca_peca.id_marca_peca And Caracteristica.id_aro = Aro.id_aro

--SELECIONAR UM SUBMODELO E A PESQUISA RETORNA AS PEÇAS QUE SÃO UTILIZADAS PARA SUA FABRICAÇÃO
SELECT DISTINCT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo, Peca.nome_peca, Caracteristica.id_caracteristica
FROM Marca INNER JOIN Modelo
ON Marca.id_marca = Modelo.id_marca
JOIN Submodelo 
ON Modelo.id_marca = Submodelo.id_modelo
JOIN Peca_Submodelo_Caracteristica
ON Submodelo.id_submodelo = Peca_Submodelo_Caracteristica.id_submodelo
JOIN Peca
ON Peca_Submodelo_Caracteristica.id_peca = Peca.id_peca
JOIN Caracteristica
ON Peca_Submodelo_Caracteristica.id_caracteristica = Caracteristica.id_caracteristica
WHERE Submodelo.id_submodelo = (SELECT Submodelo.id_submodelo FROM Submodelo WHERE Submodelo.nome_submodelo LIKE 'variant%')

--VERIFICAR QUANTOS CARROS UTILIZAM EXACTAMENTE DETERMINADA PEÇA

SELECT Peca.id_peca, Peca.nome_peca, Marca.nome_marca ,Modelo.nome_modelo, Submodelo.nome_submodelo
FROM Peca, Submodelo, Marca, Modelo, Peca_Submodelo_Caracteristica
WHERE Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca and 
Peca_Submodelo_Caracteristica.id_submodelo = Submodelo.id_submodelo
and Submodelo.id_modelo = Modelo.id_modelo and Modelo.id_marca = Marca.id_marca and
Peca.id_peca = (SELECT DISTINCT Peca.id_peca FROM Peca WHERE Peca.nome_peca = 'MOTOR ELÉTRICO') 

--SELECIONAR SUBMODELO APARTIR DA MARCA
SELECT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo
FROM Modelo INNER JOIN MARCA 
ON Modelo.id_marca = Marca.id_marca
JOIN Submodelo
ON Modelo.id_modelo = Submodelo.id_modelo
WHERE Marca.id_marca = (SELECT Marca.id_marca FROM Marca WHERE Marca.nome_marca= 'toyota')

--CONTROELE ESTOQUE PARA COMPRA : MOSTRAR PEÇAS EM ESTOQUE(No dia) DE ACORDO COM UMA QUANTIDADE MÍNIMA 
SELECT Peca.id_peca, Peca.nome_peca, Peca.quantidade,  CONVERT (date, SYSDATETIME()) AS Data_Atual --GETDATE()
FROM Peca
WHERE Peca.quantidade < 50

--CONSULTAR QUAIS AS FACTURAS DE FORNECEDOR FORAM RECEBIDAS EM X DIA
SELECT Factura.id_factura, COUNT(Fornecedor_Peca_Fatura.id_peca) as Quant_Pecas
FROM Factura, Fornecedor_Peca_Fatura, Fornecedor
WHERE Factura.id_factura=Fornecedor_Peca_Fatura.id_factura and Fornecedor_Peca_Fatura.id_fornecedor=Fornecedor.id_fornecedor
and Fornecedor_Peca_Fatura.data_entrada='2021-06-04'
GROUP by Factura.id_factura
ORDER BY Factura.id_factura ASC

--EM QUE FAMILIA ESTA UMA PECA
SELECT Peca.nome_peca, Familia.nome_familia, Grupo.nome_grupo
FROM Peca, Familia, Grupo
WHERE Familia.id_grupo = Grupo.id_grupo AND Peca.id_familia = Familia.ID_familia AND Peca.nome_peca = 'Jante'

--ASSOCIAR UMA PECA AOS FORNECEDORES, PRAZOS DE ENTREGA E CUSTOS
SELECT Peca.nome_peca, Fornecedor.nome_fornecedor, Factura.id_factura, Factura.data_emissao,
       Factura.prazo_entrega, Factura.total_factura
FROM Peca, Fornecedor, Fornecedor_Peca_Fatura, Factura
WHERE Peca.id_peca = Fornecedor_Peca_Fatura.id_peca AND Fornecedor.id_fornecedor = Fornecedor_Peca_Fatura.id_fornecedor AND
      Factura.id_factura = Fornecedor_Peca_Fatura.id_factura AND Peca.nome_peca = 'BUCHA'

--PECAS DIREITA OU ESQUERDA
SELECT DISTINCT Peca.nome_peca, Sitio.nome_sitio
FROM Peca JOIN Peca_Submodelo_Caracteristica
on Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca
JOIN Caracteristica
on Caracteristica.id_caracteristica = Peca_Submodelo_Caracteristica.id_caracteristica
JOIN Sitio
on Caracteristica.id_sitio = Sitio.id_sitio
WHERE Peca.nome_peca = 'vidro esquerdo'

--QUAIS AS PECAS CONTIDAS NUMA DETERMINADA FACTURA DA FABRICA
SELECT Peca.nome_peca, Fabrica.nome_fabrica, Fabrica_Peca_Fatura.quantidade
FROM Peca, Factura, Fabrica_Peca_Fatura, Fabrica
WHERE Peca.id_peca = Fabrica_Peca_Fatura.id_peca AND Fabrica.id_fabrica = Fabrica_Peca_Fatura.id_fabrica AND
      Factura.id_factura = Fabrica_Peca_Fatura.id_factura AND Factura.id_factura = 254

--QUAIS AS PECAS CONTIDAS NUMA DETERMINADA FACTURA DO FORNECEDOR
SELECT Peca.nome_peca, Fornecedor.nome_fornecedor, Fornecedor_Peca_Fatura.quantidade
FROM Peca, Fornecedor, Fornecedor_Peca_Fatura, Factura
WHERE Peca.id_peca = Fornecedor_Peca_Fatura.id_peca AND Fornecedor.id_fornecedor = Fornecedor_Peca_Fatura.id_fornecedor AND
      Factura.id_factura = Fornecedor_Peca_Fatura.id_factura AND Fornecedor_Peca_Fatura.id_factura = 7142

--ENCONTRAR OS DIFERENTES MODELOS DE CARRO DE UMA DETERMINADA MARCA
SELECT Marca.nome_marca, Modelo.nome_modelo
FROM Marca, Modelo
WHERE Modelo.id_marca = Marca.id_marca AND nome_marca = 'Mercedes'

--ENCONTRAR OS DIFERENTES SUBMODELOS DE UM DOS MODELOS DE UM CARRO DE UMA DETERMINADA MARCA
SELECT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo
FROM Marca, Modelo, Submodelo
WHERE Modelo.id_marca = Marca.id_marca AND Submodelo.id_modelo = Modelo.id_modelo AND nome_marca = 'Mercedes' AND Modelo.nome_modelo = 'classe b'

--ENCONTRAR OS SUBMODELOS DE CARRO QUE TENHAM A PALAVRA GASOLINA NO NOME
SELECT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo
FROM Marca, Modelo, Submodelo
WHERE Modelo.id_marca = Marca.id_marca AND Submodelo.id_modelo = Modelo.id_modelo AND Submodelo.nome_submodelo like '%gasolina%'


--ENCONTRAR AS PECAS FORNECIDAS PELO FORNECEDOR DE NOME VALEO
SELECT Fornecedor.id_fornecedor, Fornecedor.nome_fornecedor, Peca.nome_peca, Factura.id_factura, Factura.data_emissao, Factura.prazo_entrega
FROM Peca, Fornecedor, Fornecedor_Peca_Fatura, Factura
WHERE Fornecedor.id_fornecedor = Fornecedor_Peca_Fatura.id_fornecedor AND Peca.id_peca = Fornecedor_Peca_Fatura.id_peca AND
      Factura.id_factura = Fornecedor_Peca_Fatura.id_factura AND Fornecedor.nome_fornecedor = 'VALEO'

--VER EM QUE SITIO UMA PECA E USADA
SELECT DISTINCT Peca.id_peca, Peca.nome_peca, Sitio.nome_sitio
FROM Peca, Caracteristica, Peca_Submodelo_Caracteristica, Sitio
WHERE Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca AND
      Caracteristica.id_caracteristica = Peca_Submodelo_Caracteristica.id_caracteristica AND
      Caracteristica.id_sitio = Sitio.id_sitio
ORDER BY Peca.nome_peca
 

--PECAS PARA MONTAGEM DE UM SUBMODELO DE UM CARRO DE ACORDO COM O MODELO E A MARCA
SELECT DISTINCT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo, Peca.nome_peca
FROM Marca, Modelo, Peca, Peca_Submodelo_Caracteristica, Submodelo, Caracteristica
WHERE Modelo.id_marca = Marca.id_marca AND Submodelo.id_modelo = Modelo.id_modelo AND
      Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca AND Submodelo.id_submodelo = Peca_Submodelo_Caracteristica.id_submodelo AND
      Caracteristica.id_caracteristica = Peca_Submodelo_Caracteristica.id_caracteristica AND Submodelo.nome_submodelo = 'variant 2.0'
ORDER BY Peca.nome_peca

--QUANTOS CARROS UTILIZAM DETERMINADA PECA
SELECT DISTINCT Marca.nome_marca, Modelo.nome_modelo, Submodelo.nome_submodelo, Peca.nome_peca
FROM Marca, Modelo, Peca, Peca_Submodelo_Caracteristica, Submodelo, Caracteristica
WHERE Modelo.id_marca = Marca.id_marca AND Submodelo.id_modelo = Modelo.id_modelo AND
      Peca.id_peca = Peca_Submodelo_Caracteristica.id_peca AND Submodelo.id_submodelo = Peca_Submodelo_Caracteristica.id_submodelo AND
      Caracteristica.id_caracteristica = Peca_Submodelo_Caracteristica.id_caracteristica AND Peca.nome_peca = 'tampa'
ORDER BY Marca.nome_marca

