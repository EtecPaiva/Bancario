DELIMITER ;

USE sistema_bancario;

DROP PROCEDURE IF EXISTS clientePF_cadastrar;
DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS clientePF_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @last_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PF (cliente_id, cpf, data_nascimento)
    VALUES (@last_id, p_cpf, p_data_nascimento);

    COMMIT;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_cadastrar;
DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS clientePJ_cadastrar
(
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cnpj VARCHAR(14),
    IN p_razao_social DATE
)

BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    INSERT INTO Clientes_PJ (cliente_id, cnpj, razao_social)
    VALUES (LAST_INSERT_ID(), p_cnpj, p_razao_social);

    COMMIT;
END $$

DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_alterar;
DELIMITER $$

CREATE PROCEDURE clientePF_alterar (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_cpf VARCHAR(14),
    IN p_data_nascimento DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
    SET nome = p_nome,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;

    UPDATE Clientes_PF
    SET cpf = p_cpf,
        data_nascimento = p_data_nascimento
    WHERE cliente_id = p_id;

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_deletar;
DELIMITER $$

CREATE PROCEDURE clientePF_deletar (IN p_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Clientes_PF WHERE cliente_id = p_id;
    DELETE FROM Clientes WHERE id = p_id;

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_consultarTodos;
DELIMITER $$

CREATE PROCEDURE clientePF_consultarTodos (IN p_nome VARCHAR(100))
BEGIN
    SELECT c.*, pf.cpf, pf.data_nascimento
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON pf.cliente_id = c.id
    WHERE c.nome LIKE CONCAT('%', p_nome, '%');
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_consultarPorCPF;
DELIMITER $$

CREATE PROCEDURE clientePF_consultarPorCPF (IN p_cpf VARCHAR(14))
BEGIN
    SELECT c.*, pf.*
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON pf.cliente_id = c.id
    WHERE pf.cpf = p_cpf;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_consultarPorId;
DELIMITER $$

CREATE PROCEDURE clientePF_consultarPorId (IN p_id INT)
BEGIN
    SELECT c.*, pf.*
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON pf.cliente_id = c.id
    WHERE c.id = p_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePF_consultarPorEmail;
DELIMITER $$

CREATE PROCEDURE clientePF_consultarPorEmail (IN p_email VARCHAR(100))
BEGIN
    SELECT c.*, pf.*
    FROM Clientes c
    INNER JOIN Clientes_PF pf ON pf.cliente_id = c.id
    WHERE c.email = p_email;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_cadastrar;
DELIMITER $$

CREATE PROCEDURE clientePJ_cadastrar (
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_razao_social VARCHAR(150),
    IN p_cnpj VARCHAR(18)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    INSERT INTO Clientes (nome, email, telefone, endereco, username, password)
    VALUES (p_nome, p_email, p_telefone, p_endereco, p_username, p_password);

    SET @last_id = LAST_INSERT_ID();

    INSERT INTO Clientes_PJ (cliente_id, razao_social, cnpj)
    VALUES (@last_id, p_razao_social, p_cnpj);

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_alterar;
DELIMITER $$

CREATE PROCEDURE clientePJ_alterar (
    IN p_id INT,
    IN p_nome VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_telefone VARCHAR(15),
    IN p_endereco VARCHAR(255),
    IN p_username VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_razao_social VARCHAR(150),
    IN p_cnpj VARCHAR(18)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    UPDATE Clientes
    SET nome = p_nome,
        email = p_email,
        telefone = p_telefone,
        endereco = p_endereco,
        username = p_username,
        password = p_password
    WHERE id = p_id;

    UPDATE Clientes_PJ
    SET razao_social = p_razao_social,
        cnpj = p_cnpj
    WHERE cliente_id = p_id;

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_deletar;
DELIMITER $$

CREATE PROCEDURE clientePJ_deletar (IN p_id INT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    DELETE FROM Clientes_PJ WHERE cliente_id = p_id;
    DELETE FROM Clientes WHERE id = p_id;

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_consultarTodos;
DELIMITER $$

CREATE PROCEDURE clientePJ_consultarTodos (IN p_filtro VARCHAR(100))
BEGIN
    SELECT c.*, pj.razao_social, pj.cnpj
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON pj.cliente_id = c.id
    WHERE c.nome LIKE CONCAT('%', p_filtro, '%')
       OR pj.razao_social LIKE CONCAT('%', p_filtro, '%');
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_consultarPorCNPJ;
DELIMITER $$

CREATE PROCEDURE clientePJ_consultarPorCNPJ (IN p_cnpj VARCHAR(18))
BEGIN
    SELECT c.*, pj.*
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON pj.cliente_id = c.id
    WHERE pj.cnpj = p_cnpj;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_consultarPorId;
DELIMITER $$

CREATE PROCEDURE clientePJ_consultarPorId (IN p_id INT)
BEGIN
    SELECT c.*, pj.*
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON pj.cliente_id = c.id
    WHERE c.id = p_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS clientePJ_consultarPorEmail;
DELIMITER $$

CREATE PROCEDURE clientePJ_consultarPorEmail (IN p_email VARCHAR(100))
BEGIN
    SELECT c.*, pj.*
    FROM Clientes c
    INNER JOIN Clientes_PJ pj ON pj.cliente_id = c.id
    WHERE c.email = p_email;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_cadastrar;
DELIMITER $$

CREATE PROCEDURE contas_cadastrar (
    IN p_cliente_id INT,
    IN p_numero_conta VARCHAR(20),
    IN p_saldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO Contas (cliente_id, numero_conta, saldo)
    VALUES (p_cliente_id, p_numero_conta, p_saldo);
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_alterar;
DELIMITER $$

CREATE PROCEDURE contas_alterar (
    IN p_id INT,
    IN p_numero_conta VARCHAR(20),
    IN p_saldo DECIMAL(10,2)
)
BEGIN
    UPDATE Contas
    SET numero_conta = p_numero_conta,
        saldo = p_saldo
    WHERE id = p_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_deletar;
DELIMITER $$

CREATE PROCEDURE contas_deletar (IN p_id INT)
BEGIN
    DELETE FROM Contas WHERE id = p_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_consultarPorId;
DELIMITER $$

CREATE PROCEDURE contas_consultarPorId (IN p_id INT)
BEGIN
    SELECT * FROM Contas WHERE id = p_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_consultarPorCliente;
DELIMITER $$

CREATE PROCEDURE contas_consultarPorCliente (IN p_cliente_id INT)
BEGIN
    SELECT * FROM Contas WHERE cliente_id = p_cliente_id;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_depositar;
DELIMITER $$

CREATE PROCEDURE contas_depositar (
    IN p_conta_id INT,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    START TRANSACTION;

    UPDATE Contas
    SET saldo = saldo + p_valor
    WHERE id = p_conta_id;

    INSERT INTO Transacoes (conta_origem, conta_destino, valor, tipo, data_transacao)
    VALUES (NULL, p_conta_id, p_valor, 'DEPÓSITO', NOW());

    COMMIT;
END $$
DELIMITER ;

DROP PROCEDURE IF EXISTS contas_transferir;
DELIMITER $$

CREATE PROCEDURE contas_transferir (
    IN p_conta_origem INT,
    IN p_conta_destino INT,
    IN p_valor DECIMAL(10,2)
)
BEGIN
    DECLARE v_saldo DECIMAL(10,2);

    SELECT saldo INTO v_saldo FROM Contas WHERE id = p_conta_origem;

    IF v_saldo < p_valor THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Saldo insuficiente';
    ELSE
        START TRANSACTION;

        UPDATE Contas
        SET saldo = saldo - p_valor
        WHERE id = p_conta_origem;

        UPDATE Contas
        SET saldo = saldo + p_valor
        WHERE id = p_conta_destino;

        INSERT INTO Transacoes (conta_origem, conta_destino, valor, tipo, data_transacao)
        VALUES (p_conta_origem, p_conta_destino, p_valor, 'TRANSFERÊNCIA', NOW());

        COMMIT;
    END IF;
END $$
DELIMITER ;
