SELECT *
FROM funcionarios
ORDER BY salario DESC, idade
LIMIT 3;

SELECT nome, a.nroa, andar
FROM medicos m
LEFT JOIN ambulatorios a ON m.nroa = a.nroa
ORDER BY a.nroa;

SELECT andar, sum(capacidade)
FROM ambulatorios
GROUP BY andar;

SELECT andar
FROM ambulatorios
GROUP BY andar
HAVING avg(capacidade) >= 40;

SELECT nome
FROM medicos m
JOIN consultas c ON m.codm = c.codm
GROUP BY nome
HAVING count(*) > 1;

DELETE FROM ambulatorios a 
WHERE NOT EXISTS (
	SELECT 1
	FROM medicos
	WHERE nroa = a.nroa
); 

UPDATE medicos
SET cidade = (SELECT cidade FROM pacientes WHERE nome = 'Paulo'),
idade = (SELECT 2 * idade FROM pacientes WHERE nome = 'Ana')
WHERE nome = 'Pedro';

INSERT INTO medicos (codm, nome, idade, cidade, cpf, especialidade, nroa)
SELECT 6, f.nome, f.idade, f.cidade, f.cpf, m.especialidade, m.nroa
FROM funcionarios f
JOIN medicos m ON f.codf = 3 AND m.codm = 2;
