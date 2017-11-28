/*
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AWBuildVersion]') AND type in (N'U'))
DROP TABLE [dbo].[AWBuildVersion]
GO
*/

CREATE TABLE [dbo].[AWBuildVersion]
(
   [SystemInformationID] TINYINT        NOT NULL IDENTITY(1,1)
  ,[Database Version]    NVARCHAR(25)   NULL
  ,[VersionDate]         DATETIME       NULL
  ,[ModifiedDate]        DATETIME       NULL
  CONSTRAINT[PK__AWBuildVersion] PRIMARY KEY CLUSTERED
  (
    [SystemInformationID] ASC
  ) WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
 ) ON [PRIMARY]
)
GO

/* Foreign Key Constraints */

/* Default Column Contraints */

ALTER TABLE [dbo].[AWBuildVersion] ADD CONSTRAINT [DF__AWBuildVersion__ModifiedDate] DEFAULT ( (getdate()) ) FOR [ModifiedDate]
GO

/* Column Descriptions */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Primary key for AWBuildVersion records.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'AWBuildVersion',
  @level2type=N'COLUMN',
  @level2name=N'SystemInformationID'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Version number of the database in 9.yy.mm.dd.00 format.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'AWBuildVersion',
  @level2type=N'COLUMN',
  @level2name=N'Database Version'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Date and time the record was last updated.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'AWBuildVersion',
  @level2type=N'COLUMN',
  @level2name=N'VersionDate'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Date and time the record was last updated.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'AWBuildVersion',
  @level2type=N'COLUMN',
  @level2name=N'ModifiedDate'
GO

/* Table Description */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional table.',
  @level0type=N'SCHEMA',
  @level0name=N'dbo',
  @level1type=N'TABLE',
  @level1name=N'AWBuildVersion'
GO