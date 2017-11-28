/*
IF EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[HumanResources].[Department]') AND type in (N'U'))
DROP TABLE [HumanResources].[Department]
GO
*/

CREATE TABLE [HumanResources].[Department]
(
   [DepartmentID] SMALLINT NOT NULL IDENTITY(1,1)
  ,[Name]         [dbo].[Name] NULL
  ,[GroupName]    [dbo].[Name] NULL
  ,[RowStatus]    TINYINT NULL
  ,[CreatedBy]    UNIQUEIDENTIFIER NULL
  ,[ModifiedBy]   UNIQUEIDENTIFIER NULL
  ,[CreatedDate]  DATETIME NULL
  ,[ModifiedDate] DATETIME NULL
  ,[Uuid]         UNIQUEIDENTIFIER NULL ROWGUIDCOL
  CONSTRAINT[PK__Department] PRIMARY KEY CLUSTERED
  (
    [DepartmentID] ASC
  ) WITH ( PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON
 ) ON [PRIMARY]
)
GO

/* Foreign Key Constraints */

/* Default Column Contraints */

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__RowStatus] DEFAULT ( ((1)) ) FOR [RowStatus]
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__CreatedBy] DEFAULT ( ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') ) FOR [CreatedBy]
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__ModifiedBy] DEFAULT ( ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') ) FOR [ModifiedBy]
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__CreatedDate] DEFAULT ( (getutcdate()) ) FOR [CreatedDate]
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__ModifiedDate] DEFAULT ( (getutcdate()) ) FOR [ModifiedDate]
GO

ALTER TABLE [HumanResources].[Department] ADD CONSTRAINT [DF__Department__Uuid] DEFAULT ( (NEWID()) ) FOR [Uuid]
GO

/* Indexes */
CREATE UNIQUE NONCLUSTERED INDEX [AK_Department_Name]
    ON [HumanResources].[Department]([Name] ASC);
GO

/* Column Descriptions */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Primary key for Department records.',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'DepartmentID'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Name of the department.',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'Name'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Name of the group to which the department belongs.',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'GroupName'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'RowStatus'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'CreatedBy'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'ModifiedBy'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'CreatedDate'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Date and time the record was last updated.',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'ModifiedDate'
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department',
  @level2type=N'COLUMN',
  @level2name=N'Uuid'
GO

/* Table Description */
EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional table.',
  @level0type=N'SCHEMA',
  @level0name=N'HumanResources',
  @level1type=N'TABLE',
  @level1name=N'Department'
GO