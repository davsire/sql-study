--- Criação da DB
DO $$
	BEGIN	
		CREATE TABLE autores (
			codigo INT,
			nome VARCHAR(40),
			nacionalidade VARCHAR(40),
			PRIMARY KEY (codigo)
		);
		
		CREATE TABLE saloes (
			numero INT,
			andar INT,
			area INT,
			PRIMARY KEY (numero)
		);
		
		CREATE TABLE funcionarios (
			CPF NUMERIC(11),
			nome VARCHAR(40),
			salario NUMERIC(10),
			turno CHAR(1),
			funcao VARCHAR(40),
			PRIMARY KEY (CPF)
		);
	
		CREATE TABLE lotacoes (
			CPF NUMERIC(11),
			numero INT,
			horaEntrada TIME,
			horaSaida TIME,
			PRIMARY KEY (CPF, numero, horaEntrada),
			FOREIGN KEY (CPF) REFERENCES funcionarios ON UPDATE CASCADE ON DELETE CASCADE,
			FOREIGN KEY (numero) REFERENCES saloes ON UPDATE CASCADE ON DELETE CASCADE,
		);
	
		CREATE TABLE obras (
			codigo INT,
			titulo VARCHAR(40),
			ano INT,
			autor INT,
			salao INT,
			PRIMARY KEY (codigo),
			FOREIGN KEY (autor) REFERENCES autores,
			FOREIGN KEY (salao) REFERENCES saloes
		);
	
		CREATE TABLE pinturas (
			codigo INT,
			estilo VARCHAR(40),
			area VARCHAR(40),
			PRIMARY KEY (codigo),
			FOREIGN KEY (codigo) REFERENCES obras
		);
	
		CREATE TABLE esculturas (
			codigo INT,
			altura NUMERIC,
			peso NUMERIC,
			material VARCHAR(40),
			PRIMARY KEY (codigo),
			FOREIGN KEY (codigo) REFERENCES obras
		);
	END
$$;
--- Fim da criação

--- Inserção dos dados
DO $$
	BEGIN
		INSERT INTO autores (codigo, nome, nacionalidade) VALUES
		(1, 'Pablo Picasso', 'Espanhola'),
		(2, 'Claude Monet', 'Francesa'),
		(3, 'Banksy', 'Britânica'),
		(4, 'Auguste Rodin', 'Francesa');
		
		INSERT INTO saloes (numero, andar, area) VALUES
		(25, 1, 3000),
		(36, 1, 2700),
		(101, 3, 1300),
		(201, 2, 1600),
		(301, 3, 700),
		(401, 4, 2000),
		(402, 4, 500);

		INSERT INTO funcionarios (CPF, nome, salario, turno, funcao) VALUES
		(11111111111, 'João da Silva', 3200.00, 'N', 'segurança'),
		(22222222222, 'Pedro Souza', 3100.00, 'N', 'segurança'),
		(33333333333, 'Carlos Santos', 2950.00, 'N', 'segurança'),
		(44444444444, 'José Pereira', 2800.00, 'M', 'segurança'),
		(55555555555, 'Ana Ferreira', 2500.00, 'T', 'segurança'),
		(66666666666, 'Mariana Lima', 1800.00, 'M', 'faxineiro'),
		(77777777777, 'Lucas Rocha', 1900.00, 'M', 'faxineiro');

		INSERT INTO lotacoes (CPF, numero, horaEntrada, horaSaida) VALUES
		(11111111111, 25, '22:00', '06:00'),
		(22222222222, 25, '22:00', '06:00'),
		(33333333333, 25, '22:00', '06:00'),
		(44444444444, 36, '08:00', '12:00'),
		(44444444444, 201, '08:00', '12:00'),
		(55555555555, 36, '12:00', '22:00'),
		(66666666666, 401, '08:00', '12:00'),
		(66666666666, 402, '12:00', '22:00'),
		(77777777777, 402, '12:00', '22:00');

		INSERT INTO obras (codigo, titulo, ano, autor, salao) VALUES
		(1, 'Les Demoiselles d’Avignon', 1907, 1, 101),
		(2, 'Guernica', 1937, 1, 101),
		(3, 'Girl with Balloon', 2002, 3, 36),
		(4, 'O Pensador', 1904, 4, 201),
		(5, 'The Flower Thrower', 2003, 3, 36),
		(6, 'Impression, soleil levant', 1872, 2, 101);

		INSERT INTO pinturas (codigo, estilo, area) VALUES
		(1, 'Cubismo', 'Figura Humana'),
		(2, 'Impressionismo', 'Paisagem'),
		(3, 'Muralismo' 'Figura Humana');
		
		INSERT INTO esculturas (codigo, altura, peso, material) VALUES
		(4, 1.90, 300, 'Bronze'),
		(5, 1.50, 100, 'Argila');
	END
$$;
--- Fim da inserção

SELECT codigo, titulo
FROM obras
WHERE ano >= 1995 AND ano <= 2015
AND salao = 36
ORDER BY titulo;

SELECT nome, f.CPF
FROM funcionarios f
JOIN lotacoes l ON f.CPF = l.CPF
WHERE f.turno = 'N' AND l.numero = 25;

SELECT o.codigo, o.titulo
FROM obras o
JOIN autores a ON o.autor = a.codigo
JOIN saloes s ON s.numero = o.salao 
WHERE a.nome = 'Pablo Picasso' AND s.andar = 3;

SELECT o.codigo, o.titulo 
FROM obras o 
LEFT JOIN pinturas p ON o.codigo = p.codigo 
LEFT JOIN esculturas e ON o.codigo = e.codigo
WHERE p.estilo = 'Impressionismo' OR e.material = 'Argila';

SELECT a.nome, a.nacionalidade 
FROM autores a
WHERE EXISTS (SELECT 1 FROM obras NATURAL JOIN pinturas WHERE autor = a.codigo)
AND EXISTS (SELECT 1 FROM obras NATURAL JOIN esculturas WHERE autor = a.codigo);

SELECT f1.nome, f2.nome
FROM (SELECT nome, CPF, numero, horaEntrada, horaSaida FROM funcionarios NATURAL JOIN lotacoes) f1
JOIN (SELECT nome, CPF, numero, horaEntrada, horaSaida FROM funcionarios NATURAL JOIN lotacoes) f2
ON f1.CPF > f2.CPF
AND f1.numero = f2.numero
AND f1.horaEntrada = f2.horaEntrada
AND f1.horaSaida = f2.horaSaida;

SELECT numero
FROM saloes s
WHERE numero IN (SELECT salao FROM obras NATURAL JOIN esculturas)
AND numero NOT IN (SELECT salao FROM obras NATURAL JOIN pinturas);

SELECT f.nome, f.CPF
FROM funcionarios f
WHERE f.funcao = 'faxineiro'
AND NOT EXISTS (
	SELECT 1
	FROM saloes s
	WHERE s.andar = 4
	AND NOT EXISTS (
		SELECT 1
		FROM lotacoes l
		WHERE l.numero = s.numero AND l.cpf = f.cpf
	)
);

SELECT numero
FROM saloes s
WHERE area = (
	SELECT max(area)
	FROM saloes
);

SELECT f.nome, f.cpf, f.salario
FROM funcionarios f
NATURAL JOIN lotacoes l
WHERE f.funcao = 'segurança'
AND turno IN ('M', 'T')
GROUP BY f.cpf
HAVING count(*) > 1;

SELECT codigo, titulo
FROM obras
WHERE ano < ALL (
	SELECT ano
	FROM obras o
	JOIN autores a ON o.autor = a.codigo
	WHERE a.nome = 'Claude Monet'
);

UPDATE funcionarios 
SET salario = salario * 1.15
WHERE cpf IN (
	SELECT l.cpf
	FROM lotacoes l
	NATURAL JOIN saloes s
	WHERE s.area > 500
);

DELETE FROM autores a
WHERE (SELECT count(*) FROM obras WHERE autor = a.codigo) = 1;


