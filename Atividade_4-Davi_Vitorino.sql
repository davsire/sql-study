SELECT m.nome, m.CPF
FROM Medicos m
JOIN Pacientes p ON m.CPF = p.CPF;

SELECT f.nome AS funcionario, m.nome AS medico
FROM Funcionarios f
JOIN Medicos m ON f.cidade = m.cidade;

SELECT m.nome, m.idade
FROM Medicos m
JOIN Consultas c ON c.codm = m.codm
JOIN Pacientes p ON p.codp = c.codp
WHERE p.nome = 'Ana';

SELECT a.nroa
FROM Ambulatorios a
JOIN Ambulatorios a5 ON a.andar = a5.andar
WHERE a5.nroa = 5 AND a.nroa != 5;

SELECT DISTINCT codp, nome
FROM Pacientes
NATURAL JOIN Consultas
WHERE hora > '14:00';

SELECT nroa, andar
FROM Ambulatorios
NATURAL JOIN Medicos
NATURAL JOIN Consultas
WHERE data = '2020-10-12';

SELECT a.*, m.codm, m.nome
FROM Ambulatorios a
LEFT JOIN Medicos m ON a.nroa = m.nroa;

SELECT m.CPF, m.nome, p.nome, c.data
FROM Consultas c
JOIN Pacientes p ON p.codp = c.codp
RIGHT JOIN Medicos m ON m.codm = c.codm;
