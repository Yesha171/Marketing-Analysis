SELECT * FROM dbo.customers
SELECT * FROM dbo.geography

-- SQL satement to join Dim_Customers with Dim_Geography to combine customer data with geographic informatiom

SELECT 
	c.CustomerID, -- Selects the unique ID for each customer
	c.CustomerName, -- Selects the name of each customer
	c.Email, -- Selects the email of each customer
	c.Gender, -- Selects the gender of each customer
	c.Age, -- Selects the age of each customer
	g.Country, -- Selects the country from thr geography table to combine customer data
	g.City -- Selects the city from thr geography table to combine customer data
FROM dbo.customers AS c -- specifies the alis 'c' for the dbo.customers table
LEFT JOIN
	dbo.geography g -- Specifies the alias 'g' for the dbo.geography table
ON
	c.GeographyID = g.GeographyID; -- Join the two tables on the GeographyID field to match customers with their geographic information
	



