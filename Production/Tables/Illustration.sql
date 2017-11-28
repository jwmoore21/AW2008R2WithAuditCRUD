CREATE TABLE [Production].[Illustration] 
(
  [IllustrationID] INT              NOT NULL IDENTITY (1, 1),
  [Diagram]        XML              NULL,
  [RowStatus]      TINYINT          NOT NULL,
  [CreatedBy]      UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]     UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]    DATETIME         NOT NULL,
  [ModifiedDate]   DATETIME         NOT NULL,
  [Uuid]           UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_Illustration_IllustrationID] PRIMARY KEY CLUSTERED ([IllustrationID] ASC)
);
GO

/* Defaults */
ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[Illustration] ADD CONSTRAINT [DF__Illustration__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

/* Descriptions */
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration', @level2type = N'CONSTRAINT', @level2name = N'DF__Illustration__ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration', @level2type = N'CONSTRAINT', @level2name = N'PK_Illustration_IllustrationID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration', @level2type = N'COLUMN', @level2name = N'ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Illustrations used in manufacturing instructions. Stored as XML.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration', @level2type = N'COLUMN', @level2name = N'Diagram';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for Illustration records.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration', @level2type = N'COLUMN', @level2name = N'IllustrationID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Bicycle assembly diagrams.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'Illustration';

