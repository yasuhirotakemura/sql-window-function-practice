SELECT region, employee_id, salary, rank() OVER (PARTITION BY region ORDER BY salary DESC) AS salary_rank
FROM employees ORDER BY region, salary_rank, employee_id;
