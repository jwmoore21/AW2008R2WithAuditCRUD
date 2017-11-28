CREATE TABLE [Audit].[AuditSalesPerson]
(
   [AuditId]         UNIQUEIDENTIFIER  NOT NULL ROWGUIDCOL
  ,[AuditStatus]    TINYINT           NOT NULL
  ,[AuditAppUser]   UNIQUEIDENTIFIER  NOT NULL
  ,[AuditSqlUser]   VARCHAR(256)      NOT NULL
  ,[AuditDate]      DATETIME          NOT NULL
  ,[AuditBatchId]     VARCHAR(64)       NOT NULL
  ,[AuditOperation]   VARCHAR(255)      NOT NULL
  ,[BusinessEntityID] INT               NULL
  ,[TerritoryID]      INT               NULL
  ,[SalesQuota]       MONEY             NULL
  ,[Bonus]            MONEY             NULL
  ,[CommissionPct]    SMALLMONEY        NULL
  ,[SalesYTD]         MONEY             NULL
  ,[SalesLastYear]    MONEY             NULL
  ,[rowguid]          UNIQUEIDENTIFIER  NULL
  ,[RowStatus]        TINYINT           NULL
  ,[CreatedBy]        UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]       UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]      DATETIME          NULL
  ,[ModifiedDate]     DATETIME          NULL
  ,[Uuid]             UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditSalesPerson] ADD CONSTRAINT [DF__AuditSalesPerson__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditSalesPerson] ADD CONSTRAINT [DF__AuditSalesPerson__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditSalesPerson] ADD CONSTRAINT [DF__AuditSalesPerson__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditSalesPerson] ADD CONSTRAINT [DF__AuditSalesPerson__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditSalesPerson] ADD CONSTRAINT [DF__AuditSalesPerson__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Sales.SalesPerson',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditSalesPerson'
GO