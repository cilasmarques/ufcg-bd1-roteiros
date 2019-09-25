--Q1
SELECT count(ssn) AS countssn
  FROM employee 
 WHERE sex = 'F'; 

--Q2
SELECT avg(salary) AS avgsalary
  FROM employee 
 WHERE address LIKE '%TX' 
   AND sex = 'M'; 

--Q3
SELECT superssn   AS superssn,
       count(ssn) AS countssn
  FROM employee 
GROUP BY (superssn) 
ORDER BY (count(ssn)); 

--Q4
SELECT s.fname       AS fname,
       count(e.ssn)  AS ssn
  FROM employee AS e join employee AS s 
    ON (s.ssn = e.superssn) 
GROUP BY s.fname 
ORDER BY count(e.ssn); 

--Q5
SELECT s.fname       AS fname,
       count(e.ssn)  AS ssn
  FROM employee AS e left outer join employee AS s 
    ON (s.ssn = e.superssn) 
GROUP BY s.fname 
ORDER BY count(e.ssn); 

--Q6
SELECT min(p.qtdFuncs) AS qtdFuncs 
  FROM (select pno,
       count(pno)      AS qtdFuncs 
  FROM works_on 
GROUP BY pno)   AS p;  

--Q7
SELECT *                                       
  FROM (select w1.pno,
       count(w1.pno) AS qtdFuncs1 
  FROM works_on AS w1 
GROUP BY w1.pno) AS p1 
 WHERE p1.qtdFuncs1 in (select min(p.qtdFuncs) AS qtdFuncs 
  FROM (select pno,
       count(pno) AS qtdFuncs 
  FROM works_on 
GROUP BY pno) AS p) ;  

--Q8
SELECT p.pnumber     AS num_proj,
       AVG(e.salary) AS media_sal 
  FROM project  AS p,
       works_on      AS w,
       employee      AS e 
 WHERE (p.pnumber = w.pno 
   AND w.essn = e.ssn) 
GROUP BY p.pnumber; 

--Q9
SELECT p.pnumber     AS num_proj,
       p.pname       AS proj_nome,
       AVG(e.salary) AS media_sal 
  FROM project  AS p,
       works_on      AS w,
       employee      AS e 
 WHERE (p.pnumber = w.pno 
   AND w.essn = e.ssn) 
GROUP BY p.pnumber; 

--Q10
SELECT em.fname             AS fname,
       em.salary            AS salary
  FROM (SELECT MAX(e.salary) AS s 
  FROM employee        AS e JOIN works_on AS w 
    ON (w.pno = 92 
       AND w.essn = e.ssn)) AS salary92,
       employee             AS em 
 WHERE salary92.s < em.salary; 

--Q11
SELECT e.ssn,
       COUNT(w.essn) AS essn
  FROM employee AS e FULL OUTER JOIN works_on AS w 
    ON (w.essn = e.ssn) GROUP BY(e.ssn) ORDER BY(COUNT(w.essn)); 

--Q12
SELECT *               
  FROM (SELECT w.pno    AS num_proj,
       COUNT(e.ssn)    AS qtd_func 
  FROM (employee  AS e FULL OUTER JOIN works_on AS w 
    ON (w.essn = e.ssn)) 
GROUP BY w.pno) AS ew 
 WHERE ew.qtd_func < 5; 

--Q13
SELECT DISTINCT      
       s.fname       AS fname
  FROM employee AS s,
       dependent     AS d,
       works_on      AS w,
       project       AS p 
 WHERE (p.plocation LIKE '%Sugarland%' 
   AND p.pnumber = w.pno 
   AND w.essn = s.ssn 
   AND s.ssn = d.essn); 


--miniteste 6
SELECT e.salary      AS salary
  FROM employee AS e,
       works_on      AS w 
 WHERE e.ssn = w.essn 
   AND e.salary > (select min(salary) 
  FROM employee) 
   AND e.salary < (select max(salary) 
  FROM employee) 
GROUP BY e.salary; 
