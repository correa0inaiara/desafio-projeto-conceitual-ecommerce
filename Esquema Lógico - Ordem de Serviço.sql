-- Esquema Lógico da Modelagem Conceitual da Ordem de Serviço

CREATE DATABASE ordemDeServico;
USE ordemDeServico;

CREATE TABLE cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL,
	cpf CHAR(11) NOT NULL,
    contato VARCHAR(30),
	CONSTRAINT unique_cpf UNIQUE(cpf)
);

CREATE TABLE responsavel(
	idResponsavel INT AUTO_INCREMENT PRIMARY KEY,
    nivel ENUM('Nível 1', 'Nível 2', 'Nível 3') DEFAULT 'Nível 1' NOT NULL,
    nome VARCHAR(45) NOT NULL,
    departamento VARCHAR(45) DEFAULT 'Help Desk' NOT NULL
);

CREATE TABLE pedido(
	idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
	servico VARCHAR(45) NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    dataSolicitacao DATETIME NOT NULL DEFAULT NOW(),
    liberado BOOL NOT NULL DEFAULT FALSE,
    CONSTRAINT fk_pedido_cliente FOREIGN KEY (idCliente) REFERENCES cliente (idCliente)
);

CREATE TABLE analisePedido(
	idResponsavel INT,
	idPedido INT,
    CONSTRAINT fk_analisePedido_responsavel FOREIGN KEY (idResponsavel) REFERENCES responsavel (idResponsavel),
    CONSTRAINT fk_analisePedido_pedido FOREIGN KEY (idPedido) REFERENCES pedido (idPedido)
);

CREATE TABLE ordemDeServico(
	idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,
	idPedido INT,
    statusOS ENUM('Recebido', 'Atribuído', 'Analisando', 'Resolvendo', 'Resolvido', 'Retornado', 'Cancelado') DEFAULT 'Recebido' NOT NULL,
    CONSTRAINT fk_ordemDeServico_pedido FOREIGN KEY (idPedido) REFERENCES pedido (idPedido)
);