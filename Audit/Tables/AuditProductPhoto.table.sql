CREATE TABLE [Audit].[AuditProductPhoto]
(
   [AuditId]               UNIQUEIDENTIFIER        NOT NULL ROWGUIDCOL
  ,[AuditStatus]          TINYINT                 NOT NULL
  ,[AuditAppUser]         UNIQUEIDENTIFIER        NOT NULL
  ,[AuditSqlUser]         VARCHAR(256)            NOT NULL
  ,[AuditDate]            DATETIME                NOT NULL
  ,[AuditBatchId]           VARCHAR(64)             NOT NULL
  ,[AuditOperation]         VARCHAR(255)            NOT NULL
  ,[ProductPhotoID]         INT               NULL
  ,[ThumbNailPhoto]         VARBINARY(MAX)    NULL
  ,[ThumbnailPhotoFileName] NVARCHAR(50)      NULL
  ,[LargePhoto]             VARBINARY(MAX)    NULL
  ,[LargePhotoFileName]     NVARCHAR(50)      NULL
  ,[RowStatus]              TINYINT           NULL
  ,[CreatedBy]              UNIQUEIDENTIFIER  NULL
  ,[ModifiedBy]             UNIQUEIDENTIFIER  NULL
  ,[CreatedDate]            DATETIME          NULL
  ,[ModifiedDate]           DATETIME          NULL
  ,[Uuid]                   UNIQUEIDENTIFIER  NULL
)
GO

ALTER TABLE [Audit].[AuditProductPhoto] ADD CONSTRAINT [DF__AuditProductPhoto__AuditId] DEFAULT (NEWID()) FOR [AuditId]
GO

ALTER TABLE [Audit].[AuditProductPhoto] ADD CONSTRAINT [DF__AuditProductPhoto__AuditStatus] DEFAULT ((1)) FOR [AuditStatus]
GO

ALTER TABLE [Audit].[AuditProductPhoto] ADD CONSTRAINT [DF__AuditProductPhoto__AuditAppUser] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [AuditAppUser]
GO

ALTER TABLE [Audit].[AuditProductPhoto] ADD CONSTRAINT [DF__AuditProductPhoto__AuditSqlUser] DEFAULT (suser_sname()) FOR [AuditSqlUser]
GO

ALTER TABLE [Audit].[AuditProductPhoto] ADD CONSTRAINT [DF__AuditProductPhoto__AuditDate] DEFAULT (GETUTCDATE()) FOR [AuditDate]
GO

EXEC sys.sp_addextendedproperty 
  @name=N'MS_Description',
  @value=N'Transactional audit table.  Source is Production.ProductPhoto',
  @level0type=N'SCHEMA',
  @level0name=N'Audit',
  @level1type=N'TABLE',
  @level1name=N'AuditProductPhoto'
GO