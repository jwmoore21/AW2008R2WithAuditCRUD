CREATE TABLE [Audit].[AuditDatabaseLog]
(
   [AuditId]      UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL
  ,[AuditStatus] TINYINT        NOT NULL
  ,[AuditAppUser] UNIQUEIDENTIFIER NOT NULL
  ,[AuditSqlUser] VARCHAR(256)   NOT NULL
  ,[AuditDate]   DATETIME2       NOT NULL
  ,[AuditBatchId]  VARCHAR(64)    NOT NULL
  ,[AuditOperation] VARCHAR(255)   NOT NULL
  ,[DatabaseLogID] INT           NULL
  ,[PostTime]      DATETIME      NULL
  ,[DatabaseUser]  ** UNKNOWN SQL DATATYPE IN GetSqlDataType() ** SYSNAME/SYSNAME  NULL
  ,[Event]         ** UNKNOWN SQL DATATYPE IN GetSqlDataType() ** SYSNAME/SYSNAME  NULL
  ,[Schema]        ** UNKNOWN SQL DATATYPE IN GetSqlDataType() ** SYSNAME/SYSNAME  NULL
  ,[Object]        ** UNKNOWN SQL DATATYPE IN GetSqlDataType() ** SYSNAME/SYSNAME  NULL
  ,[TSQL]          NVARCHAR( MAX )  NULL
  ,[XmlEvent]      XML           NULL
)
GO

ALTER TABLE [Audit].[AuditDatabaseLog] ADD CONSTRAINT [DF__AuditDatabaseLog__AuditId] DEFAULT ([dbo].[ufn_CombGuid]()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditDatabaseLog] ADD CONSTRAINT [DF__AuditDatabaseLog__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditDatabaseLog] ADD CONSTRAINT [DF__AuditDatabaseLog__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditDatabaseLog] ADD CONSTRAINT [DF__AuditDatabaseLog__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditDatabaseLog] ADD CONSTRAINT [DF__AuditDatabaseLog__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is dbo.DatabaseLog',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditDatabaseLog'
GO