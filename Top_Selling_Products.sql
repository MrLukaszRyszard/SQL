-- Top_Selling_Products SQL Query

WITH Sales_CTE AS (
    SELECT
        s.order_date,
        p.product_name,
        s.quantity,
        s.unit_price,
        (s.quantity * s.unit_price) AS revenue
    FROM
        sales AS s
    JOIN products AS p ON s.product_id = p.product_id
    WHERE
        s.order_date BETWEEN '2023-01-01' AND '2023-12-31'
),

Monthly_Avg_Revenue AS (
    SELECT
        EXTRACT(MONTH FROM order_date) AS month,
        AVG(revenue) AS avg_monthly_revenue
    FROM
        Sales_CTE
    GROUP BY
        month
),

Top_Selling_Products AS (
    SELECT
        product_name,
        SUM(quantity) AS total_quantity_sold
    FROM
        Sales_CTE
    GROUP BY
        product_name
    ORDER BY
        total_quantity_sold DESC
    LIMIT 5
)

SELECT
    MA.month,
    MA.avg_monthly_revenue,
    TSP.product_name,
    TSP.total_quantity_sold
FROM
    Monthly_Avg_Revenue AS MA
LEFT JOIN
    Top_Selling_Products AS TSP ON EXTRACT(MONTH FROM TSP.order_date) = MA.month
ORDER BY
    MA.month;
