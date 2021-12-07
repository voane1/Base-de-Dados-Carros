--INSERINDO CHAVES ESTRANGEIRAS
Use ProjetoCarros
ALTER TABLE Peca WITH CHECK
ADD CONSTRAINT FK_Peca
FOREIGN KEY (id_familia) REFERENCES familia (id_familia);

ALTER TABLE Caracteristica WITH CHECK
ADD CONSTRAINT FK_Caracteristica
FOREIGN KEY (id_tamanho) REFERENCES Tamanho (id_tamanho),
FOREIGN KEY (id_aro) REFERENCES Aro (id_aro),
FOREIGN KEY (id_cor) REFERENCES Cor (id_cor),
FOREIGN KEY (id_potencia) REFERENCES Potencia (id_potencia),
FOREIGN KEY (id_voltagem) REFERENCES Voltagem (id_voltagem),
FOREIGN KEY (id_cilindrada) REFERENCES Cilindrada (id_cilindrada),
FOREIGN KEY (id_marca_peca) REFERENCES Marca_peca (id_marca_peca),
FOREIGN KEY (id_indice) REFERENCES indice (id_indice),
FOREIGN KEY (id_sitio) REFERENCES Sitio (id_sitio),
FOREIGN KEY (id_serie) REFERENCES Serie (id_serie),
FOREIGN KEY (id_velocidade) REFERENCES Velocidade (id_velocidade),
FOREIGN KEY (id_tipo) REFERENCES Tipo (id_tipo);


ALTER TABLE Fabrica_Peca_Fatura WITH CHECK
ADD CONSTRAINT FK_Fabrica_Peca_Fatura
FOREIGN KEY (id_fabrica) REFERENCES Fabrica (id_fabrica),
FOREIGN KEY (id_Peca) REFERENCES Peca (id_peca),
FOREIGN KEY (id_factura) REFERENCES Factura (id_factura);


ALTER TABLE Fornecedor_Peca_Fatura WITH CHECK
ADD CONSTRAINT FK_Fornecedor_Peca_Fatura
FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor (id_fornecedor),
FOREIGN KEY (id_Peca) REFERENCES Peca (id_peca),
FOREIGN KEY (id_factura) REFERENCES Factura (id_factura);

ALTER TABLE Peca_Submodelo_Caracteristica WITH CHECK
ADD CONSTRAINT FK_Peca_Submodelo_Caracteristica
FOREIGN KEY (id_peca) REFERENCES Peca (id_peca),
FOREIGN KEY (id_submodelo) REFERENCES Submodelo (id_submodelo),
FOREIGN KEY (id_caracteristica) REFERENCES Caracteristica (id_caracteristica);
