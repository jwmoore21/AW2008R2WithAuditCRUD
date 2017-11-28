CREATE TABLE [Production].[UnitMeasure] 
(
  [UnitMeasureCode] NCHAR (3)    NOT NULL,
  [Name]            [dbo].[Name] NOT NULL,
  [RowStatus]    TINYINT          NOT NULL,
  [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]   UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]  DATETIME         NOT NULL,
  [ModifiedDate] DATETIME         NOT NULL,
  [Uuid]         UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_UnitMeasure_UnitMeasureCode] PRIMARY KEY CLUSTERED ([UnitMeasureCode] ASC)
);
GO

/* Defaults */
ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Production].[UnitMeasure] ADD CONSTRAINT [DF__UnitMeasure__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_UnitMeasure_Name]
    ON [Production].[UnitMeasure]([Name] ASC);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'INDEX', @level2name = N'AK_UnitMeasure_Name';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'CONSTRAINT', @level2name = N'DF__UnitMeasure__ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'CONSTRAINT', @level2name = N'PK_UnitMeasure_UnitMeasureCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'COLUMN', @level2name = N'ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unit of measure description.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure', @level2type = N'COLUMN', @level2name = N'UnitMeasureCode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unit of measure lookup table.', @level0type = N'SCHEMA', @level0name = N'Production', @level1type = N'TABLE', @level1name = N'UnitMeasure';

