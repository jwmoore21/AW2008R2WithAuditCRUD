CREATE TABLE [Production].[ProductPhoto] 
(
  [ProductPhotoID]         INT             IDENTITY (1, 1) NOT NULL,
  [ThumbNailPhoto]         VARBINARY (MAX) NULL,
  [ThumbnailPhotoFileName] NVARCHAR (50)   NULL,
  [LargePhoto]             VARBINARY (MAX) NULL,
  [LargePhotoFileName]     NVARCHAR (50)   NULL,
  [RowStatus]    TINYINT          NOT NULL,
  [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]   UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]  DATETIME         NOT NULL,
  [ModifiedDate] DATETIME         NOT NULL,
  [Uuid]         UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_ProductPhoto_ProductPhotoID] PRIMARY KEY CLUSTERED ([ProductPhotoID] ASC)
);
GO

/* Defaults */
ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[ProductPhoto] ADD CONSTRAINT [DF__ProductPhoto__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'CONSTRAINT', @level2name = N'DF__ProductPhoto__ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'CONSTRAINT', @level2name = N'PK_ProductPhoto_ProductPhotoID';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Large image file name.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'LargePhotoFileName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Large image of the product.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'LargePhoto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Small image file name.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'ThumbnailPhotoFileName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Small image of the product.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'ThumbNailPhoto';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for ProductPhoto records.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto', @level2type = N'COLUMN', @level2name = N'ProductPhotoID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Product images.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'ProductPhoto';

