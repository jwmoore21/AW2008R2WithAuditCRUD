CREATE TABLE [Audit].[AuditErrorLog]
(
   [AuditId]       UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL
  ,[AuditStatus]  TINYINT         NOT NULL
  ,[AuditAppUser] UNIQUEIDENTIFIER NOT NULL
  ,[AuditSqlUser] VARCHAR(256)    NOT NULL
  ,[AuditDate]    DATETIME2        NOT NULL
  ,[AuditBatchId]   VARCHAR(64)     NOT NULL
  ,[AuditOperation] VARCHAR(255)    NOT NULL
  ,[ErrorLogID]     INT           NULL
  ,[ErrorTime]      DATETIME      NULL
  ,[UserName]       ** UNKNOWN SQL DATATYPE IN GetSqlDataType() ** SYSNAME/SYSNAME  NULL
  ,[ErrorNumber]    INT           NULL
  ,[ErrorSeverity]  INT           NULL
  ,[ErrorState]     INT           NULL
  ,[ErrorProcedure] NVARCHAR(126)  NULL
  ,[ErrorLine]      INT           NULL
  ,[ErrorMessage]   NVARCHAR(4000)  NULL
)
GO

ALTER TABLE [Audit].[AuditErrorLog] ADD CONSTRAINT [DF__AuditErrorLog__AuditId] DEFAULT ([dbo].[ufn_CombGuid]()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditErrorLog] ADD CONSTRAINT [DF__AuditErrorLog__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditErrorLog] ADD CONSTRAINT [DF__AuditErrorLog__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditErrorLog] ADD CONSTRAINT [DF__AuditErrorLog__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditErrorLog] ADD CONSTRAINT [DF__AuditErrorLog__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is dbo.ErrorLog',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditErrorLog'
GO