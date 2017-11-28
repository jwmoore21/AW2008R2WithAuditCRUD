CREATE TABLE [Audit].[AuditPerson]
(
   [AuditId]              UNIQUEIDENTIFIER       NOT NULL ROWGUIDCOL
  ,[AuditStatus]         TINYINT                NOT NULL
  ,[AuditAppUser]        UNIQUEIDENTIFIER       NOT NULL
  ,[AuditSqlUser]        VARCHAR(256)           NOT NULL
  ,[AuditDate]           DATETIME               NOT NULL
  ,[AuditBatchId]          VARCHAR(64)            NOT NULL
  ,[AuditOperation]        VARCHAR(255)           NOT NULL
  ,[BusinessEntityID]      INT               NULL
  ,[PersonType]            NCHAR(2)          NULL
  ,[NameStyle]             [dbo].[NameStyle]  NULL
  ,[Title]                 NVARCHAR(8)       NULL
  ,[FirstName]             [dbo].[Name]      NULL
  ,[MiddleName]            [dbo].[Name]      NULL
  ,[LastName]              [dbo].[Name]      NULL
  ,[Suffix]                NVARCHAR(10)      NULL
  ,[EmailPromotion]        INT               NULL
  ,[AdditionalContactInfo] XML               NULL
  ,[Demographics]          XML               NULL
  ,[rowguid]               UNIQUEIDENTIFIER  NULL
  ,[RowStatus]             TINYINT           NULL
  ,[CreatedBy]             UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]            UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]           DATETIME          NULL
  ,[ModifiedDate]          DATETIME          NULL
  ,[Uuid]                  UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditPerson] ADD CONSTRAINT [DF__AuditPerson__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditPerson] ADD CONSTRAINT [DF__AuditPerson__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditPerson] ADD CONSTRAINT [DF__AuditPerson__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditPerson] ADD CONSTRAINT [DF__AuditPerson__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditPerson] ADD CONSTRAINT [DF__AuditPerson__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Person.Person',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditPerson'
GO