SELECT department,employee_id,salary,rank() OVER (PARTITION BY department ORDER BY salary DESC) AS rnk
FROM employees
QUALIFY rnk<=3 ORDER BY department,rnk,employee_id;
