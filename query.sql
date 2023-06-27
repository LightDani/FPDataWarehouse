CREATE TABLE DimCustomer(
	CustomerId INT PRIMARY KEY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	CustomerName VARCHAR(50) NOT NULL,
	Age INT NOT NULL,
	Gender VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
	NoHP VARCHAR(50) NOT NULL
);

CREATE TABLE DimProduct(
	ProductId INT PRIMARY KEY,
	ProductName VARCHAR(255) NOT NULL,
	ProductCategory VARCHAR(255) NOT NULL,
	ProductUnitPrice INT
);

CREATE TABLE DimStatusOrder(
	StatusId INT PRIMARY KEY,
	StatusOrder VARCHAR(50) NOT NULL,
	StatusOrderDesc VARCHAR(50) NOT NULL
);

CREATE TABLE FactSalesOrder(
	OrderId INT PRIMARY KEY,
	CustomerId INT,
	ProductId INT,
	Quantity INT NOT NULL,
	Amount INT NOT NULL,
	StatusId INT,
	OrderDate date NOT NULL,
	FOREIGN KEY(CustomerId) REFERENCES DimCustomer(CustomerId),
	FOREIGN KEY(ProductId) REFERENCES DimProduct(ProductId),
	FOREIGN KEY(StatusId) REFERENCES DimStatusOrder(StatusId)
);


CREATE PROCEDURE GetSalesOrdersByStatus
	@StatusId INT
AS
BEGIN
	SELECT
		f.OrderId,
		c.CustomerName,
		p.ProductName,
		f.Quantity,
		s.StatusOrder
	FROM FactSalesOrder f
	JOIN DimCustomer c ON f.CustomerId = c.CustomerId
	JOIN DimProduct p ON f.ProductId = p.ProductId
	JOIN DimStatusOrder s ON f.StatusId = s.StatusId
	WHERE s.StatusId = @StatusId;
END;

EXEC GetSalesOrdersByStatus @StatusId = 3;