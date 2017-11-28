CREATE TABLE [Person].[PhoneNumberType] 
(
  [PhoneNumberTypeID] INT              IDENTITY (1, 1) NOT NULL,
  [Name]              [dbo].[Name]     NOT NULL,
  [RowStatus]         TINYINT          NOT NULL,
  [CreatedBy]         UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]        UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]       DATETIME         NOT NULL,
  [ModifiedDate]      DATETIME         NOT NULL,
  [Uuid]              UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,
  CONSTRAINT [PK_PhoneNumberType_PhoneNumberTypeID] PRIMARY KEY CLUSTERED ([PhoneNumberTypeID] ASC)
);
GO

/* Defaults */
ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [Person].[PhoneNumberType] ADD CONSTRAINT [DF__PhoneNumberType__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType', @level2type = N'CONSTRAINT', @level2name = N'DF__PhoneNumberType__ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType', @level2type = N'CONSTRAINT', @level2name = N'PK_PhoneNumberType_PhoneNumberTypeID';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType', @level2type = N'COLUMN', @level2name = N'ModifiedDate';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the telephone number type', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType', @level2type = N'COLUMN', @level2name = N'Name';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for telephone number type records.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType', @level2type = N'COLUMN', @level2name = N'PhoneNumberTypeID';
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of phone number of a person.', @level0type = N'SCHEMA', @level0name = N'Person', @level1type = N'TABLE', @level1name = N'PhoneNumberType';
GO