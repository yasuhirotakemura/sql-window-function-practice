SELECT department, employee_id, salary, dense_rank() OVER (PARTITION BY department ORDER BY salary DESC) AS salary_rank
FROM employees ORDER BY department, salary_rank, employee_id;
