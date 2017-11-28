CREATE TABLE [Sales].[SalesReason] 
(
  [SalesReasonID] INT          IDENTITY (1, 1) NOT NULL,
  [Name]          [dbo].[Name] NOT NULL,
  [ReasonType]    [dbo].[Name] NOT NULL,
  [RowStatus]    TINYINT          NOT NULL,
  [CreatedBy]    UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]   UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]  DATETIME         NOT NULL,
  [ModifiedDate] DATETIME         NOT NULL,
  [Uuid]         UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_SalesReason_SalesReasonID] PRIMARY KEY CLUSTERED ([SalesReasonID] ASC)
);
GO

/* Defaults */
ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Sales].[SalesReason] ADD CONSTRAINT [DF__SalesReason__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'CONSTRAINT', @level2name = N'DF__SalesReason__ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'CONSTRAINT', @level2name = N'PK_SalesReason_SalesReasonID';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'COLUMN', @level2name = N'ModifiedDate';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Category the sales reason belongs to.', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'COLUMN', @level2name = N'ReasonType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Sales reason description.', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for SalesReason records.', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason', @level2type = N'COLUMN', @level2name = N'SalesReasonID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup table of customer purchase reasons.', @level0type = N'SCHEMA', @level0name = N'Sales', @level1type = N'TABLE', @level1name = N'SalesReason';

