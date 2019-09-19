--Q1
SELECT * FROM departament;

--Q2
SELECT * FROM dependent;

--Q3
SELECT * FROM dept_locations;

--Q4
SELECT * FROM employee;

--Q5
SELECT * FROM project;

--Q6
SELECT * FROM works_on;

--Q7
SELECT fname, lname FROM employee WHERE sex LIKE'M';

--Q8
SELECT fname FROM employee WHERE sex='M' AND superssn is null;

--Q9
SELECT e.fname, s.fname FROM employee AS e, employee AS s WHERE e.superssn is not null AND e.superssn = s.ssn;

--Q10
SELECT e.fname FROM employee AS e, employee AS s WHERE s.fname LIKE 'Franklin' AND e.superssn = s.ssn;

--Q11
SELECT d.dname, dl.dlocation FROM department AS d, dept_locations AS dl WHERE d.dnumber = dl.dnumber;

--Q12
SELECT d.dname FROM department AS d, dept_locations AS dl WHERE d.dnumber = dl.dnumber AND dl.dlocation LIKE '%S%';

--Q13
SELECT e.fname, e.lname, de.dependent_name FROM dependent AS de, employee AS e WHERE de.essn = e.ssn; 

--Q14
SELECT e.fname || ' ' || e.lname AS full_name, e.salary FROM employee AS e WHERE e.salary > 50000.00; 

--Q15
SELECT p.pname, d.dname FROM project AS p, department AS d WHERE d.dnumber = p.dnum ;

--Q16
SELECT p.pname, e.fname FROM project AS p, employee AS e, department AS d WHERE p.pnumber > 30 AND p.dnum = d.dnumber AND e.ssn = d.mgrssn;

--Q17      
SELECT p.pname, e.fname FROM project AS p, employee AS e, works_on AS w WHERE p.pnumber = w.pno AND w.essn = e.ssn;

--Q18
SELECT e.fname, de.dependent_name, de.relationship FROM dependent AS de, employee AS e, works_on AS w WHERE w.pno = 91 AND w.essn = e.ssn AND e.ssn = de.essn;
