CREATE TABLE [Audit].[AuditDatabaseErrorLog]
(
   [AuditId]       UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL
  ,[AuditStatus]  TINYINT         NOT NULL
  ,[AuditAppUser] UNIQUEIDENTIFIER NOT NULL
  ,[AuditSqlUser] VARCHAR(256)    NOT NULL
  ,[AuditDate]    DATETIME        NOT NULL
  ,[AuditBatchId]   VARCHAR(64)     NOT NULL
  ,[AuditOperation] VARCHAR(255)    NOT NULL
  ,[ErrorLogId]     INT               NULL
  ,[RowStatus]      TINYINT           NULL
  ,[CreatedBy]      INT               NULL
  ,[CreatedDate]    DATETIME          NULL
  ,[Uuid]           UNIQUEIDENTIFIER  NULL
  ,[ErrorNumber]    INT               NULL
  ,[ErrorSeverity]  INT               NULL
  ,[ErrorState]     INT               NULL
  ,[ErrorLine]      INT               NULL
  ,[ErrorProcedure] NVARCHAR(128)     NULL
  ,[ErrorMessage]   NVARCHAR(2048)    NULL
)
GO

ALTER TABLE [Audit].[AuditDatabaseErrorLog] ADD CONSTRAINT [DF__AuditDatabaseErrorLog__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditDatabaseErrorLog] ADD CONSTRAINT [DF__AuditDatabaseErrorLog__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditDatabaseErrorLog] ADD CONSTRAINT [DF__AuditDatabaseErrorLog__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditDatabaseErrorLog] ADD CONSTRAINT [DF__AuditDatabaseErrorLog__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditDatabaseErrorLog] ADD CONSTRAINT [DF__AuditDatabaseErrorLog__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is eventLogs.DatabaseErrorLog',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditDatabaseErrorLog'
GO