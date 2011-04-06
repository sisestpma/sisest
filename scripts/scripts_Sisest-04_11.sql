CREATE TABLE Funcionalidade (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  menu VARCHAR(20) NOT NULL,
  PRIMARY KEY(id)
)
TYPE=InnoDB;

CREATE TABLE Usuario (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  login VARCHAR(10) NOT NULL,
  senha VARCHAR(10) NOT NULL,
  ativo CHAR(1) NOT NULL,
  PRIMARY KEY(id)
)
TYPE=InnoDB;

CREATE TABLE Fornecedor (
  id INTEGER UNSIGNED NOT NULL,
  razao_social VARCHAR(50) NOT NULL,
  nome_fantasia VARCHAR(50) NULL,
  cnpj_cpf VARCHAR(14) NOT NULL,
  ie_rg VARCHAR(20) NOT NULL,
  endereco VARCHAR(50) NOT NULL,
  telefone_comercial VARCHAR(11) NULL,
  telefone_residencial VARCHAR(11) NULL,
  tipo_pessoa CHAR(1) NOT NULL,
  cidade VARCHAR(20) NOT NULL,
  PRIMARY KEY(id)
)
TYPE=InnoDB;

CREATE TABLE Categoria (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(30) NOT NULL,
  PRIMARY KEY(id)
)
TYPE=InnoDB;

CREATE TABLE Departamento (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  descricao VARCHAR(30) NOT NULL,
  PRIMARY KEY(id)
)
TYPE=InnoDB;

CREATE TABLE Usuario_Funcionalidade (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Usuario_id INTEGER UNSIGNED NOT NULL,
  Funcionalidade_id INTEGER UNSIGNED NOT NULL,
  inclusao BOOL NOT NULL,
  exclusao BOOL NOT NULL,
  atualizacao BOOL NOT NULL,
  PRIMARY KEY(id),
  INDEX Usuario_Funcionalidade_FKIndex1(Funcionalidade_id),
  INDEX Usuario_Funcionalidade_FKIndex2(Usuario_id),
  FOREIGN KEY(Funcionalidade_id)
    REFERENCES Funcionalidade(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;

CREATE TABLE Movimento (
  id INTEGER UNSIGNED NOT NULL,
  num_doc INTEGER UNSIGNED NOT NULL,
  Usuario_id INTEGER UNSIGNED NOT NULL,
  Fornecedor_id INTEGER UNSIGNED NOT NULL,
  data_mov TIMESTAMP NULL,
  tipo_mov CHAR(1) NULL,
  PRIMARY KEY(id),
  INDEX Movimento_FKIndex1(Fornecedor_id),
  INDEX Movimento_FKIndex2(Usuario_id),
  FOREIGN KEY(Fornecedor_id)
    REFERENCES Fornecedor(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Usuario_id)
    REFERENCES Usuario(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;

CREATE TABLE Marca (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Fornecedor_id INTEGER UNSIGNED NOT NULL,
  descricao VARCHAR(30) NULL,
  PRIMARY KEY(id, Fornecedor_id),
  INDEX Marca_FKIndex1(Fornecedor_id),
  FOREIGN KEY(Fornecedor_id)
    REFERENCES Fornecedor(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Fornecedor_id)
    REFERENCES Fornecedor(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
);

CREATE TABLE Produto (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Fornecedor_id INTEGER UNSIGNED NOT NULL,
  Categoria_id INTEGER UNSIGNED NOT NULL,
  Departamento_id INTEGER UNSIGNED NOT NULL,
  cod_barras VARCHAR(12) NOT NULL,
  descricao VARCHAR(50) NOT NULL,
  custo DOUBLE(16,6) NOT NULL,
  estoque_atual DOUBLE(16,6) NOT NULL,
  estoque_minimo DOUBLE(16,6) NOT NULL,
  estoque_maximo DOUBLE(16,6) NOT NULL,
  data_cancel TIMESTAMP NOT NULL,
  data_cadastro TIMESTAMP NOT NULL,
  status_2 CHAR(1) NOT NULL,
  embalagem VARCHAR(10) NULL,
  PRIMARY KEY(id),
  INDEX Produto_FKIndex1(Departamento_id),
  INDEX Produto_FKIndex2(Categoria_id),
  INDEX Produto_FKIndex3(Fornecedor_id),
  FOREIGN KEY(Departamento_id)
    REFERENCES Departamento(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Categoria_id)
    REFERENCES Categoria(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Fornecedor_id)
    REFERENCES Fornecedor(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;

CREATE TABLE Item_Movimentado (
  id INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  Produto_id INTEGER UNSIGNED NOT NULL,
  Movimento_id INTEGER UNSIGNED NOT NULL,
  vlr_unit DOUBLE(16,6) NULL,
  qtde DOUBLE(16,6) NULL,
  vlr_total DOUBLE(16,6) NULL,
  divergencia_estoque_anterior DOUBLE(16,6) NULL,
  PRIMARY KEY(id, Produto_id),
  INDEX Item_Movimento_FKIndex1(Movimento_id),
  INDEX Item_Movimento_FKIndex2(Produto_id),
  FOREIGN KEY(Movimento_id)
    REFERENCES Movimento(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY(Produto_id)
    REFERENCES Produto(id)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)
TYPE=InnoDB;


