--ssh -o ServerAliveInterval=30 cilas@150.165.15.11 -p 45600

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
SELECT MIN(qtd) FROM (SELECT COUNT(*) AS qtd FROM works_on AS w GROUP BY w.pno) AS foo;

--Q7 +-
SELECT MIN(num_projeto), MIN(qtd_func) FROM (SELECT p.pnumber AS num_projeto, COUNT(*) AS qtd_func FROM works_on AS w JOIN project AS p ON (p.pnumber = w.pno)GROUP BY p.pnumber) AS foo;

--Q8
SELECT p.pnumber AS num_proj, AVG(e.salary) AS media_sal FROM project AS p, works_on AS w, employee AS e WHERE (p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

--Q9
SELECT p.pnumber AS num_proj, p.pname AS proj_nome, AVG(e.salary) AS media_sal FROM project AS p, works_on AS w, employee AS e WHERE (p.pnumber = w.pno AND w.essn = e.ssn) GROUP BY p.pnumber;

--Q10
SELECT em.fname, em.salary FROM (SELECT MAX(e.salary) AS s FROM employee AS e JOIN works_on AS w ON (w.pno = 92 AND w.essn = e.ssn)) AS salary92, employee AS em WHERE salary92.s < em.salary;

--Q11
SELECT e.ssn, COUNT(w.essn) FROM employee AS e FULL OUTER JOIN works_on AS w ON (w.essn = e.ssn) GROUP BY(e.ssn) ORDER BY(COUNT(w.essn));

--Q12
SELECT * FROM (SELECT w.pno AS num_proj, COUNT(e.ssn) AS qtd_func FROM (employee AS e FULL OUTER JOIN works_on AS w ON (w.essn = e.ssn)) GROUP BY w.pno) AS ew WHERE ew.qtd_func < 5;

--Q13
SELECT DISTINCT s.fname FROM employee AS s, dependent AS d, works_on AS w, project AS p WHERE (p.plocation LIKE '%Sugarland%' AND p.pnumber = w.pno AND w.essn = s.ssn AND s.ssn = d.essn);

--Q15 INCOMPLETA
--SELECT DISTINCT e.fname, e.lname FROM (SELECT * FROM works_on AS w WHERE w.essn = '123456789') AS p, works_on AS ww, employee AS e WHERE p.pno = ww.pno AND ww.essn = e.ssn AND e.ssn != '123456789';
