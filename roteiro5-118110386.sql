--Q1
SELECT COUNT(e.ssn) FROM employee AS e WHERE e.sex = 'F';

--Q2
SELECT AVG(e.salary) FROM employee AS e WHERE e.sex = 'M' AND e.address LIKE '%TX%';

--Q3
SELECT superssn, COUNT(ssn) FROM employee GROUP BY(superssn) ORDER BY(COUNT(ssn));

--Q4
SELECT s.fname AS nome_supervisor, COUNT(e.superssn) AS qtd_supervisionados FROM (employee AS s JOIN employee AS e ON (s.ssn = e.superssn)) GROUP BY (s.ssn) ORDER BY COUNT(e.superssn);

--Q5
SELECT s.fname, COUNT(*) FROM (employee AS s RIGHT OUTER JOIN employee AS e ON (s.ssn = e.superssn)) GROUP BY (s.ssn) ORDER BY COUNT(*);

--Q6
SELECT MIN(qtd) FROM (SELECT count(*) AS qtd FROM works_on AS w GROUP BY w.pno) AS foo;

--Q7 +-
SELECT MIN(num_projeto), MIN(qtd_func) FROM (SELECT p.pnumber AS num_projeto, count(*) AS qtd_func FROM works_on AS w JOIN project AS p ON (p.pnumber = w.pno)GROUP BY p.pnumber) AS foo;

--Q8
SELECT p.pnumber AS num_proj, AVG(e.salary) AS media_sal FROM project AS p, works_on AS w, employee AS e WHERE (p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

--Q9
SELECT p.pnumber AS num_proj, p.pname AS proj_nome, AVG(e.salary) AS media_sal FROM project AS p, works_on AS w, employee AS e WHERE (p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

