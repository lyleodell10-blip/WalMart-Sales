SELECT COUNT(*) AS Total_Row
FROM walmart_sales;

SELECT *
FROM walmart_sales
WHERE Temperature IS NULL;

UPDATE walmart_sales
SET Temperature =
(
    SELECT AVG(Temperature)
    FROM walmart_sales
)
WHERE Temperature IS NULL;

SELECT COUNT(*) AS TotalRows
FROM walmart_sales;

SELECT COUNT(*) AS MissingTemps
FROM walmart_sales
WHERE Temperature IS NULL;

SELECT TOP 10 *
FROM walmart_sales;

SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT Store) AS TotalStores,
    SUM(Weekly_Sales) AS TotalSales,
    AVG(Weekly_Sales) AS AvgWeeklySales
FROM walmart_sales;

SELECT TOP 10
    Store,
    SUM(Weekly_Sales) AS TotalSales,
    AVG(Weekly_Sales) AS AvgWeeklySales
FROM walmart_sales
GROUP BY Store
ORDER BY TotalSales DESC;

SELECT TOP 10
    Store,
    SUM(Weekly_Sales) AS TotalSales,
    AVG(Weekly_Sales) AS AvgWeeklySales
FROM walmart_sales
GROUP BY Store
ORDER BY TotalSales ASC;

SELECT
    Holiday_Flag,
    AVG(Weekly_Sales) AS AvgWeeklySales
FROM walmart_sales
GROUP BY Holiday_Flag;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
),
Top10Revenue AS
(
    SELECT TOP 10
        TotalSales
    FROM StoreRevenue
    ORDER BY TotalSales DESC
)

SELECT
    (SELECT SUM(TotalSales) FROM Top10Revenue) AS Top10Sales,
    (SELECT SUM(TotalSales) FROM StoreRevenue) AS CompanySales;

SELECT
    Store,
    SUM(Weekly_Sales) AS TotalSales,
    RANK() OVER (
        ORDER BY SUM(Weekly_Sales) DESC
    ) AS SalesRank
FROM walmart_sales
GROUP BY Store
ORDER BY SalesRank;

SELECT
    Store,
    AVG(CASE
            WHEN Holiday_Flag = 0
            THEN Weekly_Sales
        END) AS NonHolidaySales,

    AVG(CASE
            WHEN Holiday_Flag = 1
            THEN Weekly_Sales
        END) AS HolidaySales
FROM walmart_sales
GROUP BY Store;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
)
SELECT
    SUM(TotalSales) AS CompanyRevenue
FROM StoreRevenue;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
)
SELECT TOP 10
    Store,
    TotalSales
FROM StoreRevenue
ORDER BY TotalSales DESC;

SELECT
    Store,
    SUM(Weekly_Sales) AS TotalSales,
    AVG(Weekly_Sales) AS AvgWeeklySales,
    MIN(Weekly_Sales) AS LowestWeek,
    MAX(Weekly_Sales) AS HighestWeek
FROM walmart_sales
GROUP BY Store
ORDER BY AvgWeeklySales DESC;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
)
SELECT
    SUM(TotalSales) AS CompanyRevenue
FROM StoreRevenue;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
)
SELECT
    SUM(TotalSales) AS Top10Revenue
FROM
(
    SELECT TOP 10 TotalSales
    FROM StoreRevenue
    ORDER BY TotalSales DESC
) t;

WITH StoreRevenue AS
(
    SELECT
        Store,
        SUM(Weekly_Sales) AS TotalSales
    FROM walmart_sales
    GROUP BY Store
),
Top10Revenue AS
(
    SELECT TOP 10
        TotalSales
    FROM StoreRevenue
    ORDER BY TotalSales DESC
)
SELECT
    CAST(
        (SELECT SUM(TotalSales) FROM Top10Revenue) * 100.0 /
        (SELECT SUM(TotalSales) FROM StoreRevenue)
    AS DECIMAL(10,2)) AS RevenueSharePercent;

    SELECT
    Store,
    AVG(Weekly_Sales) AS AvgWeeklySales,
    STDEV(Weekly_Sales) AS SalesVolatility,
    MIN(Weekly_Sales) AS LowestWeek,
    MAX(Weekly_Sales) AS HighestWeek
FROM walmart_sales
GROUP BY Store
ORDER BY AvgWeeklySales DESC;