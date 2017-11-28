CREATE TABLE [Audit].[AuditLocation]
(
   [AuditId]     UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL
  ,[AuditStatus] TINYINT       NOT NULL
  ,[AuditAppUser] UNIQUEIDENTIFIER NOT NULL
  ,[AuditSqlUser] VARCHAR(256)  NOT NULL
  ,[AuditDate]  DATETIME      NOT NULL
  ,[AuditBatchId] VARCHAR(64)   NOT NULL
  ,[AuditOperation] VARCHAR(255)  NOT NULL
  ,[LocationID]   SMALLINT          NULL
  ,[Name]         [dbo].[Name]      NULL
  ,[CostRate]     SMALLMONEY        NULL
  ,[Availability] DECIMAL(8,2)      NULL
  ,[RowStatus]    TINYINT           NULL
  ,[CreatedBy]    UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]   UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]  DATETIME          NULL
  ,[ModifiedDate] DATETIME          NULL
  ,[Uuid]         UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditLocation] ADD CONSTRAINT [DF__AuditLocation__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditLocation] ADD CONSTRAINT [DF__AuditLocation__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditLocation] ADD CONSTRAINT [DF__AuditLocation__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditLocation] ADD CONSTRAINT [DF__AuditLocation__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditLocation] ADD CONSTRAINT [DF__AuditLocation__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Production.Location',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditLocation'
GO