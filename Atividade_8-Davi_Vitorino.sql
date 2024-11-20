--- 1
CREATE VIEW FuncFpolis AS
	SELECT codf, nome, cpf, idade
	FROM funcionarios
	WHERE cidade = 'Florianopolis';

--- 2
SELECT * FROM FuncFpolis;

--- 3
UPDATE FuncFpolis SET idade = idade + 1 WHERE 1=1;

--- 4
SELECT * FROM FuncFpolis; -- Sim, funcionou

--- 5
INSERT INTO FuncFpolis (codf, nome, cpf, idade) VALUES (10, 'Rodrigo', 22200022233, 41);

--- 6
SELECT * FROM FuncFpolis;
SELECT * FROM funcionarios;
 -- O funcionário não está no FuncFpolis, mas está presente na tabela original de funcionários

--- 7
CREATE RULE InsertFuncFpolis
AS ON INSERT TO FuncFpolis
DO INSTEAD
	INSERT INTO funcionarios (codf, nome, cpf, idade, cidade)
	VALUES (NEW.codf, NEW.nome, NEW.cpf, NEW.idade, 'Florianopolis');

--- 8
INSERT INTO FuncFpolis (codf, nome, cpf, idade) VALUES (11, 'Raul', 44400044433, 53);

--- 9
SELECT * FROM FuncFpolis;
SELECT * FROM funcionarios;
--- Sim, inseriu corretamente e está aparecendo em ambos os selects

--- 10
CREATE VIEW MedSupDois AS
	SELECT codm, nome, idade, cpf, nroa
	FROM medicos
	WHERE nroa >= 2
	WITH CHECK OPTION;

--- 11
SELECT * FROM MedSupDois;

--- 12
INSERT INTO MedSupDois (codm, nome, idade, cpf, nroa)
VALUES (7, 'Soraia', 47, 55500055533, 2);

--- 13
SELECT * FROM MedSupDois; -- Sim, funcionou

--- 14
INSERT INTO MedSupDois (codm, nome, idade, cpf, nroa)
VALUES (8, 'Saulo', 52, 66600066633, 1);
--- A inserção falhou

