/*
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[eventLogs].[DatabaseErrorLog]') AND type in (N'U'))
DROP TABLE [eventLogs].[DatabaseErrorLog]
GO
*/

CREATE TABLE [eventLogs].[DatabaseErrorLog]
(
   [ErrorLogId]     INT       NOT NULL IDENTITY(1,1)
  ,[RowStatus]      TINYINT   NULL
  ,[CreatedBy]      INT       NULL
  ,[CreatedDate]    DATETIME  NULL
  ,[Uuid]           UNIQUEIDENTIFIER NULL ROWGUIDCOL
  ,[DbName]         NVARCHAR(128) NULL
  ,[ErrorNumber]    INT       NULL
  ,[ErrorSeverity]  INT       NULL
  ,[ErrorState]     INT       NULL
  ,[ErrorLine]      INT       NULL
  ,[ErrorProcedure] NVARCHAR(128) NULL
  ,[ErrorMessage]   NVARCHAR(2048) NULL
  CONSTRAINT[PK__DatabaseErrorLog] PRIMARY KEY CLUSTERED
  (
    [ErrorLogId] ASC
  ) WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
 ) ON [PRIMARY]
)
GO

/* Foreign Key Constraints */

/* Default Column Contraints */

ALTER TABLE [eventLogs].[DatabaseErrorLog] ADD CONSTRAINT [DF__DatabaseErrorLog__RowStatus] DEFAULT ( ((1)) ) FOR [RowStatus]
GO

ALTER TABLE [eventLogs].[DatabaseErrorLog] ADD CONSTRAINT [DF__DatabaseErrorLog__CreatedBy] DEFAULT ( ((1)) ) FOR [CreatedBy]
GO

ALTER TABLE [eventLogs].[DatabaseErrorLog] ADD CONSTRAINT [DF__DatabaseErrorLog__CreatedDate] DEFAULT ( (getutcdate()) ) FOR [CreatedDate]
GO

ALTER TABLE [eventLogs].[DatabaseErrorLog] ADD CONSTRAINT [DF__DatabaseErrorLog__Uuid] DEFAULT ( (NEWID()) ) FOR [Uuid]
GO

ALTER TABLE [eventLogs].[DatabaseErrorLog] ADD CONSTRAINT [DF__DatabaseErrorLog__DbName] DEFAULT ( (db_name()) ) FOR [DbName]
GO

/* Column Descriptions */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorLogId'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'RowStatus'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'CreatedBy'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'CreatedDate'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'Uuid'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'DbName'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'SQL Error number',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorNumber'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'SQL Error Severity',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorSeverity'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorState'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorLine'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorProcedure'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorMessage'
GO

/* Table Description */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional table.',
  @level0type=N'SCHEMA',
  @level0name=N'eventLogs',
  @level1type=N'TABLE',
  @level1name=N'DatabaseErrorLog'
GO