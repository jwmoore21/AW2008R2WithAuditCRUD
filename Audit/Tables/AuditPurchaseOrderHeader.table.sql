CREATE TABLE [Audit].[AuditPurchaseOrderHeader]
(
   [AuditId]        UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL
  ,[AuditStatus]   TINYINT          NOT NULL
  ,[AuditAppUser]  UNIQUEIDENTIFIER NOT NULL
  ,[AuditSqlUser]  VARCHAR(256)     NOT NULL
  ,[AuditDate]     DATETIME         NOT NULL
  ,[AuditBatchId]    VARCHAR(64)      NOT NULL
  ,[AuditOperation]  VARCHAR(255)     NOT NULL
  ,[PurchaseOrderID] INT               NULL
  ,[RevisionNumber]  TINYINT           NULL
  ,[Status]          TINYINT           NULL
  ,[EmployeeID]      INT               NULL
  ,[VendorID]        INT               NULL
  ,[ShipMethodID]    INT               NULL
  ,[OrderDate]       DATETIME          NULL
  ,[ShipDate]        DATETIME          NULL
  ,[SubTotal]        MONEY             NULL
  ,[TaxAmt]          MONEY             NULL
  ,[Freight]         MONEY             NULL
  ,[TotalDue]        MONEY             NULL
  ,[RowStatus]       TINYINT           NULL
  ,[CreatedBy]       UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]      UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]     DATETIME          NULL
  ,[ModifiedDate]    DATETIME          NULL
  ,[Uuid]            UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditPurchaseOrderHeader] ADD CONSTRAINT [DF__AuditPurchaseOrderHeader__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditPurchaseOrderHeader] ADD CONSTRAINT [DF__AuditPurchaseOrderHeader__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditPurchaseOrderHeader] ADD CONSTRAINT [DF__AuditPurchaseOrderHeader__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditPurchaseOrderHeader] ADD CONSTRAINT [DF__AuditPurchaseOrderHeader__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditPurchaseOrderHeader] ADD CONSTRAINT [DF__AuditPurchaseOrderHeader__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Purchasing.PurchaseOrderHeader',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditPurchaseOrderHeader'
GO