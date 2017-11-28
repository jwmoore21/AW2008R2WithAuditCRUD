CREATE TABLE [Audit].[AuditProduct]
(
   [AuditId]              UNIQUEIDENTIFIER       NOT NULL ROWGUIDCOL
  ,[AuditStatus]         TINYINT                NOT NULL
  ,[AuditAppUser]        UNIQUEIDENTIFIER       NOT NULL
  ,[AuditSqlUser]        VARCHAR(256)           NOT NULL
  ,[AuditDate]           DATETIME               NOT NULL
  ,[AuditBatchId]          VARCHAR(64)            NOT NULL
  ,[AuditOperation]        VARCHAR(255)           NOT NULL
  ,[ProductID]             INT               NULL
  ,[Name]                  [dbo].[Name]      NULL
  ,[ProductNumber]         NVARCHAR(25)      NULL
  ,[MakeFlag]              [dbo].[Flag]      NULL
  ,[FinishedGoodsFlag]     [dbo].[Flag]      NULL
  ,[Color]                 NVARCHAR(15)      NULL
  ,[SafetyStockLevel]      SMALLINT          NULL
  ,[ReorderPoint]          SMALLINT          NULL
  ,[StandardCost]          MONEY             NULL
  ,[ListPrice]             MONEY             NULL
  ,[Size]                  NVARCHAR(5)       NULL
  ,[SizeUnitMeasureCode]   NCHAR(3)          NULL
  ,[WeightUnitMeasureCode] NCHAR(3)          NULL
  ,[Weight]                DECIMAL(8,2)      NULL
  ,[DaysToManufacture]     INT               NULL
  ,[ProductLine]           NCHAR(2)          NULL
  ,[Class]                 NCHAR(2)          NULL
  ,[Style]                 NCHAR(2)          NULL
  ,[ProductSubcategoryID]  INT               NULL
  ,[ProductModelID]        INT               NULL
  ,[SellStartDate]         DATETIME          NULL
  ,[SellEndDate]           DATETIME          NULL
  ,[DiscontinuedDate]      DATETIME          NULL
  ,[rowguid]               UNIQUEIDENTIFIER  NULL
  ,[RowStatus]             TINYINT           NULL
  ,[CreatedBy]             UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]            UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]           DATETIME          NULL
  ,[ModifiedDate]          DATETIME          NULL
  ,[Uuid]                  UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditProduct] ADD CONSTRAINT [DF__AuditProduct__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditProduct] ADD CONSTRAINT [DF__AuditProduct__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditProduct] ADD CONSTRAINT [DF__AuditProduct__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditProduct] ADD CONSTRAINT [DF__AuditProduct__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditProduct] ADD CONSTRAINT [DF__AuditProduct__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Production.Product',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditProduct'
GO