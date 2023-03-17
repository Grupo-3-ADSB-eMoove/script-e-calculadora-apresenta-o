CREATE DATABASE emoove;

USE emoove;


CREATE TABLE tbUsuario(
cpfUsuario VARCHAR(14) PRIMARY KEY NOT NULL,
nomeUsuario VARCHAR(50) NOT NULL,
emailUsuario VARCHAR(100) NOT NULL,
senhaUsuario VARCHAR(50) NOT NULL, 
situacaoUsuario VARCHAR(15) constraint chkSituacao check (situacaoUsuario IN ('comum','contratante')),
telefoneUsuario VARCHAR(14)
);

CREATE TABLE tbEstabelecimento(
idEstabelecimento INT PRIMARY KEY auto_increment,
enderecoEstabelecimento VARCHAR(100),
cepEstabelecimento VARCHAR(10),
numeroEstabelecimento int
);

CREATE TABLE tbCompraUsuario(
idCompraUsuario INT PRIMARY KEY AUTO_INCREMENT,
dataCompra DATE,
valorCompra DECIMAL(10,2),
qtdSensor INT,
fk_cpfUsuario  CHAR(14),
FOREIGN KEY (fk_cpfUsuario) REFERENCES tbUsuario(cpfUsuario),
fk_idEstabelecimento INT,
FOREIGN KEY (fk_idEstabelecimento) REFERENCES tbEstabelecimento(idEstabelecimento)
);

CREATE TABLE tbSensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
tipoSensor VARCHAR(20) CONSTRAINT chkSensor CHECK (tipoSensor IN ('sensor_caixa','sensor_entrada')),
fk_compraUsuario INT,
FOREIGN KEY (fk_compraUsuario) REFERENCES tbCompraUSuario(idCompraUsuario)
);



CREATE TABLE tbSensorEntrada(

idSensorEntrada INT PRIMARY KEY AUTO_INCREMENT,
contagem_entrada TINYINT,   
dtHora  DATETIME DEFAULT current_timestamp,
fk_idSensor INT,
FOREIGN KEY (fk_idSensor) REFERENCES tbSensor(idSensor)
);

CREATE TABLE tbSensorCaixa(
idSensorCaixa INT PRIMARY KEY AUTO_INCREMENT,
contagem_caixa TINYINT,   
dtHora  DATETIME DEFAULT current_timestamp,
fk_idSensor INT,
FOREIGN KEY (fk_idSensor) REFERENCES tbSensor(idSensor)
);



-- INSERTS ////////////////////////////////////////////////

DESC tbUsuario;
INSERT INTO tbUsuario VALUES 
		('491.474.878-95','Leonardo Bento','leonardo.bsilva@sptech.school','senhaForte@134','comum','11961707443'),
		('123.456.789-10','Luiz Paulo ','luiz.frutuoso@sptech.school','senhaForteDoLuiz@trello','comum','11923571423'),
		('443.416.732-80','Matheus Lima','matehus.lima@sptech.school','senhaForteDoMatheus','comum','11923571423');
        

DESC tbEstabelecimento;        
INSERT INTO tbEstabelecimento VALUES
		(null,'Rua Manuel Marques de Sousa','0285110',93),
		(null,'Rua Haddock Lobo','1414001',595);
       
DESC tbCompraUsuario;       
INSERT INTO tbCompraUsuario VALUES
(null,'2023-03-14',6000,5,'491.474.878-95',1);
        

        
 DESC tbSensor;       
INSERT INTO tbSensor VALUES
		(null,'sensor_caixa',1),
        (null,'sensor_entrada',1),
        (null,'sensor_entrada',1),
        (null,'sensor_entrada',1),
        (null,'sensor_entrada',1);
        


 DESC tbSensorCaixa;
INSERT INTO tbSensorCaixa (contagem_caixa, fk_idSensor)VALUES 
		(1,1),
		(1,1),
		(1,1),
		(1,1),
		(1,1),
		(1,1),
		(1,1);
		
		
        
        
INSERT INTO tbSensorEntrada (contagem_entrada, fk_idSensor) VALUES 
			(1,2),
			(1,2),
			(1,2),
			(1,3),
			(1,3),
			(1,2),
			(1,4),
			(1,5),
			(1,3),
			(1,4),
			(1,4),
			(1,2);
            
 -- SEÇÃO SELECTS  ///////////////////////////////////////////////////
 
 SELECT * FROM  tbUsuario;
 SELECT * FROM  tbEstabelecimento;
 SELECT * FROM  tbCompraUsuario;
 SELECT * FROM  tbSensor;
 SELECT * FROM  tbSensorEntrada;
 SELECT * FROM  tbSensorCaixa;
            
SELECT idSensor,tipoSensor,dataCompra,valorCompra,idCompraUsuario AS 'idCompra', nomeUsuario as 'Contratante' FROM tbSensor JOIN tbCompraUsuario ON fk_compraUsuario = idCompraUsuario 
JOIN tbUsuario ON  fk_cpfUsuario = cpfUsuario where idCompraUsuario = 1;

SELECT * FROM tbSensor JOIN tbSensorEntrada ON tbSensorEntrada.fk_idSensor = idSensor WHERE idSensor BETWEEN 1 AND 5;

SELECT * from tbCompraUsuario JOIN tbUsuario ON  fk_cpfUsuario = tbUsuario.cpfUsuario JOIN tbEstabelecimento ON fk_idEstabelecimento = idEstabelecimento;

SELECT idCompraUsuario, nomeUsuario ,enderecoEstabelecimento  from tbCompraUsuario  
JOIN tbUsuario ON  fk_cpfUsuario = tbUsuario.cpfUsuario 
JOIN tbEstabelecimento ON fk_idEstabelecimento = idEstabelecimento where idCompraUsuario =1;
	

SELECT nomeUsuario as 'Contratante',enderecoEstabelecimento as 'Endereço do Estabelecimento',idSensor as 'Numero do sensor',idCompraUsuario as 'Compra Vinculada' from tbSensor JOIN tbCompraUsuario ON fk_compraUsuario = idCompraUsuario JOIN tbUsuario ON  fk_cpfUsuario = tbUsuario.cpfUsuario 
JOIN tbEstabelecimento ON fk_idEstabelecimento = idEstabelecimento where idCompraUsuario =1;	

