CREATE TABLE [Audit].[AuditEmployee]
(
   [AuditId]          UNIQUEIDENTIFIER   NOT NULL ROWGUIDCOL
  ,[AuditStatus]     TINYINT            NOT NULL
  ,[AuditAppUser]    UNIQUEIDENTIFIER   NOT NULL
  ,[AuditSqlUser]    VARCHAR(256)       NOT NULL
  ,[AuditDate]       DATETIME           NOT NULL
  ,[AuditBatchId]      VARCHAR(64)        NOT NULL
  ,[AuditOperation]    VARCHAR(255)       NOT NULL
  ,[BusinessEntityID]  INT               NULL
  ,[NationalIDNumber]  NVARCHAR(15)      NULL
  ,[LoginID]           NVARCHAR(256)     NULL
  ,[OrganizationNode]  HIERARCHYID       NULL
  ,[OrganizationLevel] SMALLINT          NULL
  ,[JobTitle]          NVARCHAR(50)      NULL
  ,[BirthDate]         DATE              NULL
  ,[MaritalStatus]     NCHAR(1)          NULL
  ,[Gender]            NCHAR(1)          NULL
  ,[HireDate]          DATE              NULL
  ,[SalariedFlag]      [dbo].[Flag]      NULL
  ,[VacationHours]     SMALLINT          NULL
  ,[SickLeaveHours]    SMALLINT          NULL
  ,[CurrentFlag]       [dbo].[Flag]      NULL
  ,[rowguid]           UNIQUEIDENTIFIER  NULL
  ,[RowStatus]         TINYINT           NULL
  ,[CreatedBy]         UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]        UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]       DATETIME          NULL
  ,[ModifiedDate]      DATETIME          NULL
  ,[Uuid]              UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditEmployee] ADD CONSTRAINT [DF__AuditEmployee__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditEmployee] ADD CONSTRAINT [DF__AuditEmployee__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditEmployee] ADD CONSTRAINT [DF__AuditEmployee__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditEmployee] ADD CONSTRAINT [DF__AuditEmployee__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditEmployee] ADD CONSTRAINT [DF__AuditEmployee__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is HumanResources.Employee',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditEmployee'
GO