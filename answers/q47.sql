WITH actual AS (
 SELECT employee_id,month_start,sum(amount) AS actual_amount FROM sales GROUP BY 1,2
), base AS (
 SELECT t.employee_id,t.month_start,t.target_amount,coalesce(a.actual_amount,0) AS actual_amount,
 coalesce(a.actual_amount,0)::DOUBLE/nullif(t.target_amount,0) AS rate
 FROM sales_targets t LEFT JOIN actual a USING(employee_id,month_start)
)
SELECT *,CASE WHEN rate IS NOT NULL THEN rank() OVER (PARTITION BY month_start ORDER BY rate DESC NULLS LAST) END AS rnk
FROM base ORDER BY month_start,rnk NULLS LAST,employee_id;
