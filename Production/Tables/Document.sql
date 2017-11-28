CREATE TABLE [Production].[Document] 
(
  [DocumentNode]    [sys].[hierarchyid] NOT NULL,
  [DocumentLevel]   AS                  ([DocumentNode].[GetLevel]()),
  [Title]           NVARCHAR (50)       NOT NULL,
  [Owner]           INT                 NOT NULL,
  [FolderFlag]      BIT                 CONSTRAINT [DF_Document_FolderFlag] DEFAULT ((0)) NOT NULL,
  [FileName]        NVARCHAR (400)      NOT NULL,
  [FileExtension]   NVARCHAR (8)        NOT NULL,
  [Revision]        NCHAR (5)           NOT NULL,
  [ChangeNumber]    INT                 CONSTRAINT [DF_Document_ChangeNumber] DEFAULT ((0)) NOT NULL,
  [Status]          TINYINT             NOT NULL,
  [DocumentSummary] NVARCHAR (MAX)      NULL,
  [Document]        VARBINARY (MAX)     NULL,
  [rowguid]         UNIQUEIDENTIFIER    CONSTRAINT [DF_Document_rowguid] DEFAULT (NEWID()) ROWGUIDCOL NOT NULL,
  [RowStatus]       TINYINT             NOT NULL,
  [CreatedBy]       UNIQUEIDENTIFIER    NOT NULL,
  [ModifiedBy]      UNIQUEIDENTIFIER    NOT NULL,
  [CreatedDate]     DATETIME            NOT NULL,
  [ModifiedDate]    DATETIME            NOT NULL,
  [Uuid]            UNIQUEIDENTIFIER    NOT NULL,
  CONSTRAINT [PK_Document_DocumentNode] PRIMARY KEY CLUSTERED ([DocumentNode] ASC),
  CONSTRAINT [CK_Document_Status] CHECK ([Status]>=(1) AND [Status]<=(3)),
  CONSTRAINT [FK_Document_Employee_Owner] FOREIGN KEY ([Owner]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID]),
  UNIQUE NONCLUSTERED ([rowguid] ASC)
);
GO

/* Defaults */
ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[Document] ADD CONSTRAINT [DF__Document__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

/* Indexes */
CREATE NONCLUSTERED INDEX [IX_Document_FileName_Revision]
    ON [Production].[Document]([FileName] ASC, [Revision] ASC);
GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_rowguid]
    ON [Production].[Document]([rowguid] ASC);
GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_Document_DocumentLevel_DocumentNode]
    ON [Production].[Document]([DocumentLevel] ASC, [DocumentNode] ASC);
GO

/* Descriptions */
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'INDEX', @level2name = N'IX_Document_FileName_Revision';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index. Used to support FileStream.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'INDEX', @level2name = N'AK_Document_rowguid';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'INDEX', @level2name = N'AK_Document_DocumentLevel_DocumentNode';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Check constraint [Status] BETWEEN (1) AND (3)', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'CK_Document_Status';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'DF__Document__ModifiedDate';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of NEWID()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'DF_Document_rowguid';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of 0', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'DF_Document_ChangeNumber';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key constraint referencing Employee.BusinessEntityID.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'FK_Document_Employee_Owner';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'CONSTRAINT', @level2name = N'PK_Document_DocumentNode';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'ModifiedDate';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ROWGUIDCOL number uniquely identifying the record. Required for FileStream.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'rowguid';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Complete document.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'Document';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Document abstract.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'DocumentSummary';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'1 = Pending approval, 2 = Approved, 3 = Obsolete', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'Status';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Engineering change approval number.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'ChangeNumber';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Revision number of the document. ', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'Revision';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'File extension indicating the document type. For example, .doc or .txt.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'FileExtension';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'File name of the document', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'FileName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 = This is a folder, 1 = This is a document.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'FolderFlag';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employee who controls the document.  Foreign key to Employee.BusinessEntityID', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'Owner';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Title of the document.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'Title';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Depth in the document hierarchy.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'DocumentLevel';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for Document records.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document', @level2type = N'COLUMN', @level2name = N'DocumentNode';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Product maintenance documents.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Document';
GO
