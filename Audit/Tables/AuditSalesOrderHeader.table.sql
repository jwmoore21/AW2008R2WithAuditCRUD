CREATE TABLE [Audit].[AuditSalesOrderHeader]
(
   [AuditId]               UNIQUEIDENTIFIER        NOT NULL ROWGUIDCOL
  ,[AuditStatus]          TINYINT                 NOT NULL
  ,[AuditAppUser]         UNIQUEIDENTIFIER        NOT NULL
  ,[AuditSqlUser]         VARCHAR(256)            NOT NULL
  ,[AuditDate]            DATETIME                NOT NULL
  ,[AuditBatchId]           VARCHAR(64)             NOT NULL
  ,[AuditOperation]         VARCHAR(255)            NOT NULL
  ,[SalesOrderID]           INT               NULL
  ,[RevisionNumber]         TINYINT           NULL
  ,[OrderDate]              DATETIME          NULL
  ,[DueDate]                DATETIME          NULL
  ,[ShipDate]               DATETIME          NULL
  ,[Status]                 TINYINT           NULL
  ,[OnlineOrderFlag]        [dbo].[Flag]      NULL
  ,[SalesOrderNumber]       NVARCHAR(25)      NULL
  ,[PurchaseOrderNumber]    [dbo].[OrderNumber]  NULL
  ,[AccountNumber]          [dbo].[AccountNumber]  NULL
  ,[CustomerID]             INT               NULL
  ,[SalesPersonID]          INT               NULL
  ,[TerritoryID]            INT               NULL
  ,[BillToAddressID]        INT               NULL
  ,[ShipToAddressID]        INT               NULL
  ,[ShipMethodID]           INT               NULL
  ,[CreditCardID]           INT               NULL
  ,[CreditCardApprovalCode] VARCHAR(15)       NULL
  ,[CurrencyRateID]         INT               NULL
  ,[SubTotal]               MONEY             NULL
  ,[TaxAmt]                 MONEY             NULL
  ,[Freight]                MONEY             NULL
  ,[TotalDue]               MONEY             NULL
  ,[Comment]                NVARCHAR(128)     NULL
  ,[rowguid]                UNIQUEIDENTIFIER  NULL
  ,[RowStatus]              TINYINT           NULL
  ,[CreatedBy]              UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]             UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]            DATETIME          NULL
  ,[ModifiedDate]           DATETIME          NULL
  ,[Uuid]                   UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditSalesOrderHeader] ADD CONSTRAINT [DF__AuditSalesOrderHeader__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditSalesOrderHeader] ADD CONSTRAINT [DF__AuditSalesOrderHeader__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditSalesOrderHeader] ADD CONSTRAINT [DF__AuditSalesOrderHeader__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditSalesOrderHeader] ADD CONSTRAINT [DF__AuditSalesOrderHeader__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditSalesOrderHeader] ADD CONSTRAINT [DF__AuditSalesOrderHeader__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Sales.SalesOrderHeader',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditSalesOrderHeader'
GO