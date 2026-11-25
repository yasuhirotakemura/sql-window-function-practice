SELECT employee_id, salary, avg(salary) OVER (PARTITION BY department) AS dept_avg, salary-dept_avg AS diff
FROM employees ORDER BY employee_id;
