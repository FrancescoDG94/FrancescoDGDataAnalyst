SELECT
ProductAlternateKey,
EnglishProductName,
Color,
FinishedGoodsFlag
FROM adw.dimproduct
WHERE FinishedGoodsFlag = 1;

SELECT 
ProductAlternateKey,
dp.ProductSubcategoryKey
Color,
ProductCategoryKey
FROM dimproduct as dp INNER JOIN dimproductsubcategory as dps;

SELECT 
a.ProductKey,
a.EnglishProductName,
b.EnglishProductSubcategoryName,
c.EnglishProductCategoryName
FROM dimproduct as a INNER JOIN dimproductsubcategory as b
ON a.ProductSubcategoryKey= b.ProductSubcategoryKey
INNER JOIN dimproductcategory as c 
ON b.ProductCategoryKey = c.ProductCategoryKey;

SELECT distinct 
a.EnglishProductName,
b.ProductKey
FROM dimproduct AS a INNER JOIN factresellersales AS b
ON a.ProductKey = b.ProductKey;

SELECT distinct
a.EnglishProductName,
b.ProductKey
FROM dimproduct AS a LEFT OUTER JOIN factresellersales AS b
ON a.ProductKey = b.ProductKey
WHERE FinishedGoodsFlag = 1 AND b.ProductKey is null;

SELECT *
FROM factresellersales AS SALES INNER JOIN dimproduct as PRODUCT
ON SALES.ProductKey = PRODUCT.ProductKey;
