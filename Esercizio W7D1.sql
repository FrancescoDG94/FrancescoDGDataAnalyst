-- Scrivi una query per verificare che il campo ProductKey nella tabella DimProduct sia una chiave primaria. Quali considerazioni/ragionamenti è necessario che tu faccia?

SELECT EnglishProductName, COUNT(*) AS "Conteggio"
FROM adw.dimproduct
GROUP BY EnglishProductName
HAVING COUNT(*) > 1;

-- Scrivi una query per verificare che la combinazione dei campi SalesOrderNumber e SalesOrderLineNumber sia una PK.

SELECT 
SalesOrderNumber,
SalesOrderLineNumber
FROM factresellersales
GROUP BY SalesOrderNumber, SalesOrderLineNumber
HAVING COUNT(*) >1;

-- Conta il numero transazioni SalesOrderLineNumber) realizzate ogni giorno a partire dal 1 Gennaio 2020.

SELECT 
OrderDate, COUNT(SalesOrderLineNumber)
FROM factresellersales
WHERE OrderDate >= 2020/01/01
GROUP BY OrderDate;

-- Calcola il fatturato totale FactResellerSales.SalesAmount), la quantità totale venduta FactResellerSales.OrderQuantity) e il prezzo medio di vendita FactResellerSales.UnitPrice) per prodotto DimProduct) a partire dal 1 Gennaio 2020. Il result set deve esporre pertanto il nome del prodotto, il fatturato totale, la quantità totale venduta e il prezzo medio di vendita. I campi in output devono essere parlanti!

SELECT 
OrderDate,
EnglishProductName,
SUM(Fact.SalesAmount) AS Fatturato,
SUM(Fact.OrderQuantity) AS Ordini_Venduti,
AVG(Fact.UnitPrice) AS Media
FROM factresellersales AS Fact INNER JOIN dimproduct AS Dim
ON Dim.ProductKey = Fact.ProductKey
WHERE OrderDate >= 2020/01/01
GROUP BY OrderDate, EnglishProductName;

-- Calcola il fatturato totale (FactResellerSales.SalesAmount) e la quantità totale venduta FactResellerSales.OrderQuantity) per Categoria prodotto DimProductCategory). Il result set deve esporre pertanto il nome della categoria prodotto, il fatturato totale e la quantità totale venduta. I campi in output devono essere parlanti!

SELECT 
EnglishProductCategoryName,
SUM(Fact.SalesAmount) AS Fatturato,
SUM(Fact.OrderQuantity) AS Quantità_Venduta
FROM factresellersales AS Fact INNER JOIN dimproduct AS Dim
ON Fact.ProductKey = Dim.ProductKey
INNER JOIN dimproductsubcategory AS Sub
ON Dim.ProductSubcategoryKey = Sub.ProductSubcategoryKey
INNER JOIN dimproductcategory AS Cat
ON Sub.ProductCategoryKey = Cat.ProductCategoryKey
GROUP BY EnglishProductCategoryName;

-- Calcola il fatturato totale per area città (DimGeography.City) realizzato a partire dal 1 Gennaio 2020. Il result set deve esporre lʼelenco delle città con fatturato realizzato superiore a 60K.

SELECT 
geo.City,
SUM(Fact.SalesAmount) AS Totale
FROM dimgeography AS Geo INNER JOIN dimsalesterritory AS Ter
ON Geo.SalesTerritoryKey = Ter.SalesTerritoryKey
INNER JOIN factresellersales AS Fact
ON Ter.SalesTerritoryKey = Fact.SalesTerritoryKey
WHERE Fact.OrderDate >= 2020/01/01 
GROUP BY geo.City
HAVING SUM(fact.SalesAmount) >= 60.000
ORDER BY Totale;