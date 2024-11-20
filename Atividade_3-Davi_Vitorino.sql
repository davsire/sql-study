SELECT * FROM Medicos WHERE idade < 40 OR especialidade != 'traumatologia';

SELECT nome, idade FROM Pacientes WHERE cidade != 'Florianopolis';

SELECT nome, (idade * 12) AS idade_meses FROM Pacientes; 

SELECT MAX(hora) AS ultima_consulta FROM Consultas WHERE data = '2020-10-13';

SELECT AVG(idade) AS media, COUNT(DISTINCT nroa) AS total_ambulatorios FROM Medicos;

SELECT codf, nome, (salario * 0.8) AS salario_liquido FROM Funcionarios;

SELECT nome FROM Funcionarios WHERE nome LIKE '%a';

SELECT nome, especialidade FROM Medicos WHERE nome LIKE '_o%o';

SELECT codp, nome FROM Pacientes WHERE idade > 25 AND doenca IN ('tendinite', 'fratura', 'gripe', 'sarampo');

SELECT CPF, nome, idade
FROM (
	SELECT CPF, nome, idade, cidade FROM Medicos
  	UNION
  	SELECT CPF, nome, idade, cidade FROM Pacientes
  	UNION
  	SELECT CPF, nome, idade, cidade FROM Funcionarios
)
WHERE cidade = 'Florianopolis';
