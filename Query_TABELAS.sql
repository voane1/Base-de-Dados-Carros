--Criação da base de dados
CREATE DATABASE ProjetoCarros

--Criação das tabelas sem chaves estrangeiras
USE ProjetoCarros
CREATE TABLE Peca(
 id_peca INT PRIMARY KEY NOT NULL,
 nome_peca VARCHAR(60) NOT NULL,
 quantidade INT NOT NULL,
 referencia VARCHAR(20),
 id_familia INT NOT NULL
 );

 CREATE TABLE Caracteristica(
 id_caracteristica INT PRIMARY KEY NOT NULL,
 id_tamanho INT NULL,
 id_aro INT NULL,
 id_cor INT NULL,
 id_potencia INT NULL,
 id_voltagem INT NULL,
 id_cilindrada INT NULL,
 id_marca_peca INT NULL,
 id_indice INT NULL,
 id_sitio INT NULL,
 id_serie INT NULL,
 id_velocidade INT NULL,
 id_tipo INT NULL
 );

 CREATE TABLE Fabrica_Peca_Fatura(
 id_fabrica INT NOT NULL,
 id_peca INT NOT NULL,
 id_factura INT NOT NULL,
 quantidade INT,
 custo DECIMAL 
 );

 CREATE TABLE Fornecedor_Peca_Fatura(
 id_fornecedor INT NOT NULL,
 id_peca INT NOT NULL,
 id_fatura INT NOT NULL,
 quantidade INT NOT NULL,
 custo DECIMAL NOT NULL 
 );

 CREATE TABLE Peca_Submodelo_Caracteristica(
 id_peca INT NOT NULL, 
 id_submodelo INT NOT NULL,
 id_caracteristica INT NOT NULL,
 );

 --Criação das tabelas com chaves estrangeiras

USE ProjetoCarros
CREATE TABLE Grupo(
id_grupo INT PRIMARY KEY NOT NULL,
nome_grupo VARCHAR(20) NOT NULL,
);

CREATE TABLE Familia(
ID_familia INT PRIMARY KEY NOT NULL,
nome_familia VARCHAR(20),
id_grupo INT,
FOREIGN KEY(id_grupo)
REFERENCES Grupo(id_grupo)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE Marca(
id_marca INT PRIMARY KEY NOT NULL,
nome_marca VARCHAR(20)
);

CREATE TABLE Modelo(
id_modelo INT PRIMARY KEY NOT NULL,
nome_modelo VARCHAR(30),
id_marca INT,
FOREIGN KEY(id_marca)
REFERENCES Marca(id_marca)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE Submodelo(
id_submodelo INT PRIMARY KEY NOT NULL,
nome_submodelo VARCHAR(50),
id_modelo INT,
FOREIGN KEY(id_modelo)
REFERENCES Modelo(id_modelo)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE Fabrica(
id_fabrica INT PRIMARY KEY NOT NULL,
nome_fabrica VARCHAR(20),
morada_fabrica VARCHAR(30),
pais VARCHAR(20),
);

CREATE TABLE Fornecedor(
id_fornecedor INT PRIMARY KEY NOT NULL,
nome_fornecedor VARCHAR(20),
morada_fornecedor VARCHAR(30),
pais VARCHAR(20),
);

CREATE TABLE Factura(
id_factura INT PRIMARY KEY NOT NULL,
total_factura DECIMAL,
data_emissao DATE,
prazo_entrega DATE,
);



CREATE TABLE Aro(
id_aro INT PRIMARY KEY NOT NULL,
nome_aro VARCHAR(20)
);

CREATE TABLE Cor(
id_cor INT PRIMARY KEY NOT NULL,
nome_cor VARCHAR(20)
);

CREATE TABLE Potencia(
id_potencia INT PRIMARY KEY NOT NULL,
nome_potencia VARCHAR(20)
);

CREATE TABLE Voltagem(
id_voltagem INT PRIMARY KEY NOT NULL,
nome_voltagem VARCHAR(20)
);

CREATE TABLE Tipo(
id_tipo INT PRIMARY KEY NOT NULL,
nome_tipo VARCHAR(20)
);

CREATE TABLE Velocidade(
id_velocidade INT PRIMARY KEY NOT NULL,
nome_velocidade VARCHAR(20)
);

CREATE TABLE Tamanho(
id_tamanho INT PRIMARY KEY NOT NULL,
nome_tamanho VARCHAR(20),
);

CREATE TABLE Serie(
id_serie INT PRIMARY KEY NOT NULL,
nome_serie VARCHAR(20)
);

CREATE TABLE Sitio(
id_sitio INT PRIMARY KEY NOT NULL,
nome_sitio VARCHAR(20)
);

CREATE TABLE Indice(
id_indice INT PRIMARY KEY NOT NULL,
nome_indice VARCHAR(20)
);

CREATE TABLE Marca_peca(
id_marca_peca INT PRIMARY KEY NOT NULL,
nome_marca_peca VARCHAR(20)
);

CREATE TABLE Cilindrada(
id_cilindrada INT PRIMARY KEY NOT NULL,
nome_cilindrada VARCHAR(20)
);

