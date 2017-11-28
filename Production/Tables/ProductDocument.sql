CREATE TABLE [Production].[ProductDocument] 
(
  [ProductID]    INT                 NOT NULL,
  [DocumentNode] [sys].[hierarchyid] NOT NULL,
  [RowStatus]    TINYINT          NOT NULL,
  [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]   UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]  DATETIME         NOT NULL,
  [ModifiedDate] DATETIME         NOT NULL,
  [Uuid]         UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_ProductDocument_ProductID_DocumentNode] PRIMARY KEY CLUSTERED ([ProductID] ASC, [DocumentNode] ASC),
  CONSTRAINT [FK_ProductDocument_Document_DocumentNode] FOREIGN KEY ([DocumentNode]) REFERENCES [Production].[Document] ([DocumentNode]),
  CONSTRAINT [FK_ProductDocument_Product_ProductID] FOREIGN KEY ([ProductID]) REFERENCES [Production].[Product] ([ProductID])
);
GO

/* Defaults */
ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductDocument] ADD CONSTRAINT [DF__ProductDocument__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'CONSTRAINT', @level2name = N'DF__ProductDocument__ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key constraint referencing Document.DocumentNode.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'CONSTRAINT', @level2name = N'FK_ProductDocument_Document_DocumentNode';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key constraint referencing Product.ProductID.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'CONSTRAINT', @level2name = N'FK_ProductDocument_Product_ProductID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'CONSTRAINT', @level2name = N'PK_ProductDocument_ProductID_DocumentNode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'COLUMN', @level2name = N'ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Document identification number. Foreign key to Document.DocumentNode.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'COLUMN', @level2name = N'DocumentNode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Product identification number. Foreign key to Product.ProductID.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument', @level2type = N'COLUMN', @level2name = N'ProductID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Cross-reference table mapping products to related product documents.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductDocument';

