SELECT department,employee_id,salary,
(salary-avg(salary) OVER w)/nullif(stddev_pop(salary) OVER w,0) AS z_score
FROM employees WINDOW w AS (PARTITION BY department) ORDER BY department,employee_id;
