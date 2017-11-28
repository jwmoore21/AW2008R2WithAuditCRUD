CREATE TABLE [Person].[BusinessEntity] 
(
  [BusinessEntityID] INT              IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
  [rowguid]          UNIQUEIDENTIFIER CONSTRAINT [DF_BusinessEntity_rowguid] DEFAULT (NEWID()) ROWGUIDCOL NOT NULL,
  [RowStatus]        TINYINT          NOT NULL,
  [CreatedBy]        UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]       UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]      DATETIME         NOT NULL,
  [ModifiedDate]     DATETIME         NOT NULL,
  [Uuid]             UNIQUEIDENTIFIER NOT NULL,
  CONSTRAINT [PK_BusinessEntity_BusinessEntityID] PRIMARY KEY CLUSTERED ([BusinessEntityID] ASC)
);
GO

/* Defaults */
ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[BusinessEntity] ADD CONSTRAINT [DF__BusinessEntity__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_BusinessEntity_rowguid]
   ON [Person].[BusinessEntity]([rowguid] ASC);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index. Used to support replication samples.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'INDEX', @level2name = N'AK_BusinessEntity_rowguid';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'CONSTRAINT', @level2name = N'DF__BusinessEntity__ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of NEWID()', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'CONSTRAINT', @level2name = N'DF_BusinessEntity_rowguid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'CONSTRAINT', @level2name = N'PK_BusinessEntity_BusinessEntityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'COLUMN', @level2name = N'ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'COLUMN', @level2name = N'rowguid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for all customers, vendors, and employees.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity', @level2type = N'COLUMN', @level2name = N'BusinessEntityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Source of the ID that connects vendors, customers, and employees with address and contact information.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'BusinessEntity';

