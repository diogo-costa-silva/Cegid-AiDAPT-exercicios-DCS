-- ============================================
-- Exercicio 1 - Criacao de Tabelas
-- AiDAPT - Cegid Academy
-- ============================================
-- Conceitos: CREATE TABLE, PRIMARY KEY, FOREIGN KEY, IDENTITY, DEFAULT
-- Base de dados: ExerciciosDB
-- ============================================

USE ExerciciosDB;
GO

-- ============================================
-- 1.1 Tabela Customers (Clientes)
-- ============================================

CREATE TABLE dbo.Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- ============================================
-- 1.2 Tabela Products (Produtos)
-- ============================================

CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Active BIT DEFAULT 1
);
GO

-- ============================================
-- 1.3 Tabela Orders (Pedidos)
-- ============================================

CREATE TABLE dbo.Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES dbo.Customers(CustomerID)
);
GO

-- ============================================
-- 1.4 Tabela OrderItems (Itens do Pedido)
-- ============================================

CREATE TABLE dbo.OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES dbo.Products(ProductID)
);
GO

-- ============================================
-- 1.5 Tabela Payments (Pagamentos)
-- ============================================

CREATE TABLE dbo.Payments (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT NOT NULL,
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Method NVARCHAR(20) NOT NULL,
    Status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Payments_Orders
        FOREIGN KEY (OrderID)
        REFERENCES dbo.Orders(OrderID)
);
GO

-- ============================================
-- Notas:
-- - IDENTITY(1,1): Auto-incremento comecando em 1
-- - FOREIGN KEY: Garante integridade referencial
-- - DEFAULT GETDATE(): Data/hora actual automatica
-- - BIT: Tipo booleano (0 ou 1)
-- ============================================
