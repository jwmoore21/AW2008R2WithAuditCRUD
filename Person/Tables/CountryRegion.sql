CREATE TABLE [Person].[CountryRegion] 
(
  [CountryRegionCode] NVARCHAR (3) NOT NULL,
  [Name]              [dbo].[Name] NOT NULL,
  [RowStatus]         TINYINT          NOT NULL,
  [CreatedBy]         UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]        UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]       DATETIME         NOT NULL,
  [ModifiedDate]      DATETIME         NOT NULL,
  [Uuid]              UNIQUEIDENTIFIER NOT NULL,
  CONSTRAINT [PK_CountryRegion_CountryRegionCode] PRIMARY KEY CLUSTERED ([CountryRegionCode] ASC)
);
GO

/* Defaults */
ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[CountryRegion] ADD CONSTRAINT [DF__CountryRegion__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

CREATE UNIQUE NONCLUSTERED INDEX [AK_CountryRegion_Name]
    ON [Person].[CountryRegion]([Name] ASC);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Unique nonclustered index.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'INDEX', @level2name = N'AK_CountryRegion_Name';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'CONSTRAINT', @level2name = N'DF__CountryRegion__ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'CONSTRAINT', @level2name = N'PK_CountryRegion_CountryRegionCode';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'COLUMN', @level2name = N'ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Country or region name.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'COLUMN', @level2name = N'Name';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ISO standard code for countries and regions.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion', @level2type = N'COLUMN', @level2name = N'CountryRegionCode';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Lookup table containing the ISO standard codes for countries and regions.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'CountryRegion';
GO
