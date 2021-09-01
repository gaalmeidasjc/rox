CREATE DATABASE rox_test

USE rox_test

CREATE TABLE PERSON(
	BusinessEntityID INT PRIMARY KEY,
	PersonType VARCHAR(2),
	NameStyle INT,
	Title VARCHAR(255),
	FirstName VARCHAR(50),
	MiddleName VARCHAR(50),
	LastName VARCHAR(50),
	Suffix VARCHAR(20),
	EmailPromotion INT,
	AdditionalContactInfo VARCHAR(255),
	Demographics VARCHAR(255),
	rowguid VARCHAR(40),
	ModifiedDate DATETIME
)

CREATE TABLE PRODUCT(
	ProductID INT PRIMARY KEY,
	Name VARCHAR(50),
	ProductNumber VARCHAR(10),
	MakeFlag INT,
	FinishedGoodsFlag INT,
	Color VARCHAR(20),
	SafetyStockLevel INT,
	ReorderPoint INT,
	StandardCost DECIMAL(12,4),
	ListPrice DECIMAL(12,4),
	Size VARCHAR(10),
	SizeUnitMeasureCode VARCHAR(5),
	WeightUnitMeasureCode VARCHAR(5),
	Weight DECIMAL(12,4),
	DaysToManufacture INT,
	ProductLine VARCHAR(10),
	Class VARCHAR(10),
	Style VARCHAR(10),
	ProductSubcategoryID INT,
	ProductModelID INT,
	SellStartDate DATETIME,
	SellEndDate DATETIME,
	DiscontinuedDate DATETIME,
	rowguid VARCHAR(40),
	ModifiedDate DATETIME
)

CREATE TABLE CUSTOMER(
	CustomerID INT PRIMARY KEY,
	PersonID INT,
	StoreID INT,
	TerritoryID INT,
	AccountNumber VARCHAR(10),
	rowguid VARCHAR(40),
	ModifiedDate DATETIME
)

CREATE TABLE SalesOrderDetail(
	SalesOrderID INT,
	SalesOrderDetailID INT,
	CarrierTrackingNumber VARCHAR(12),
	OrderQty INT,
	ProductID INT,
	SpecialOfferID INT,
	UnitPrice DECIMAL(12,4),
	UnitPriceDiscount DECIMAL(12,4),
	LineTotal BIGINT,
	rowguid VARCHAR(40),
	ModifiedDate DATETIME,
	PRIMARY KEY (SalesOrderDetailID, SalesOrderID)
)

CREATE TABLE SalesOrderHeader(
	SalesOrderID INT PRIMARY KEY,
	RevisionNumber INT,
	OrderDate DATETIME,
	DueDate DATETIME,
	ShipDate DATETIME,
	Status INT,
	OnlineOrderFlag INT,
	SalesOrderNumber VARCHAR(10),
	PurchaseOrderNumber VARCHAR(15),
	AccountNumber VARCHAR(10),
	CustomerID INT,
	SalesPersonID INT,
	TerritoryID INT,
	BillToAddressID INT,
	ShipToAddressID INT,
	ShipMethodID INT,
	CreditCardID INT,
	CreditCardApprovalCode VARCHAR(15),
	CurrencyRateID INT,
	SubTotal DECIMAL(12,4),
	TaxAmt DECIMAL(12,4),
	Freight DECIMAL(12,4),
	TotalDue DECIMAL(12,4),
	Comment VARCHAR(255),
	rowguid VARCHAR(40),
	ModifiedDate DATETIME
)

CREATE TABLE SpecialOfferProduct(
	SpecialOfferID INT,
	ProductID INT,
	rowguid VARCHAR(40),
	ModifiedDate DATETIME,
	PRIMARY KEY (SpecialOfferID, ProductID)
)

ALTER TABLE CUSTOMER
ADD CONSTRAINT FK_Customer_Person_PersonID FOREIGN KEY (PersonID) REFERENCES Person(BusinessEntityID)

ALTER TABLE SalesOrderHeader
ADD CONSTRAINT FK_SalesOrderHeader_Customer_CustomerID FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

ALTER TABLE SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID FOREIGN KEY (SalesOrderID) REFERENCES SalesOrderHeader(SalesOrderID)

ALTER TABLE SalesOrderDetail
ADD CONSTRAINT FK_SalesOrderDetail_SpecialOfferProduct_SpecialOfferIDProductID FOREIGN KEY (SpecialOfferID,ProductID) REFERENCES SpecialOfferProduct(SpecialOfferID,ProductID)

ALTER TABLE SpecialOfferProduct
ADD CONSTRAINT FK_SpecialOfferProduct_Product_ProductID FOREIGN KEY (ProductID) REFERENCES PRODUCT(ProductID)
