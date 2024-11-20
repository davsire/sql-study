SELECT nome, CPF
FROM medicos m
WHERE EXISTS (
	SELECT 1
	FROM pacientes p
	WHERE p.CPF = m.CPF
);

SELECT nome, CPF, data
FROM medicos m
JOIN consultas c ON m.codm = c.codm
WHERE m.especialidade = 'ortopedia'
AND EXISTS (
	SELECT 1
	FROM pacientes p
	WHERE p.codp = c.codp AND p.nome = 'Ana'
);

SELECT nome, CPF
FROM medicos m
WHERE NOT EXISTS (
	SELECT 1
	FROM pacientes p
	WHERE NOT EXISTS (
		SELECT 1
		FROM consultas c
		WHERE c.codp = p.codp
		AND c.codm = m.codm
	)
);

SELECT nome, CPF
FROM medicos m
WHERE especialidade = 'ortopedia'
AND NOT EXISTS (
	SELECT 1
	FROM pacientes p
	WHERE cidade = 'Florianopolis'
	AND NOT EXISTS (
		SELECT 1
		FROM consultas c
		WHERE c.codp = p.codp
		AND c.codm = m.codm
	)
);

SELECT data, hora
FROM (SELECT data, hora, codm FROM consultas) AS c
JOIN (SELECT codm FROM medicos WHERE nome = 'Maria') AS m ON c.codm = m.codm;

SELECT DISTINCT nome, cidade
FROM (SELECT nome, cidade, codp FROM pacientes) AS p
JOIN (SELECT codp, codm FROM consultas) AS c ON p.codp = c.codp
JOIN (SELECT codm FROM medicos WHERE especialidade = 'ortopedia') AS m ON m.codm = c.codm;

SELECT nome, CPF
FROM (SELECT nome, CPF, nroa FROM medicos WHERE nome != 'Pedro') AS m
JOIN (SELECT nroa FROM medicos WHERE nome = 'Pedro') AS ambPedro ON m.nroa = ambPedro.nroa;

