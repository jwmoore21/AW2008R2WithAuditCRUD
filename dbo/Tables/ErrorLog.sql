/*
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ErrorLog]') AND type in (N'U'))
DROP TABLE [dbo].[ErrorLog]
GO
*/

CREATE TABLE [dbo].[ErrorLog]
(
   [ErrorLogID]     INT       NOT NULL IDENTITY(1,1)
  ,[ErrorTime]      DATETIME  NULL
  ,[UserName]       SYSNAME   NULL
  ,[ErrorNumber]    INT       NULL
  ,[ErrorSeverity]  INT       NULL
  ,[ErrorState]     INT       NULL
  ,[ErrorProcedure] NVARCHAR(126) NULL
  ,[ErrorLine]      INT       NULL
  ,[ErrorMessage]   NVARCHAR(4000) NULL
  CONSTRAINT[PK__ErrorLog] PRIMARY KEY CLUSTERED
  (
    [ErrorLogID] ASC
  ) WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
 ) ON [PRIMARY]
)
GO

/* Foreign Key Constraints */

/* Default Column Contraints */

ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [DF__ErrorLog__ErrorTime] DEFAULT ( (getdate()) ) FOR [ErrorTime]
GO

/* Column Descriptions */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Primary key for ErrorLog records.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorLogID'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The date and time at which the error occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorTime'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The user who executed the batch in which the error occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'UserName'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The error number of the error that occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorNumber'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The severity of the error that occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorSeverity'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The state number of the error that occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorState'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The name of the stored procedure or trigger where the error occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorProcedure'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The line number at which the error occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorLine'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'The message text of the error that occurred.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog',
  @level2type=N'COLUMN',
  @level2name=N'ErrorMessage'
GO

/* Table Description */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional table.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'ErrorLog'
GO