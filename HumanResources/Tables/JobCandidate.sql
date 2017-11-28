CREATE TABLE [HumanResources].[JobCandidate] 
(
  [JobCandidateID]   INT                                                      IDENTITY (1, 1) NOT NULL,
  [BusinessEntityID] INT                                                      NULL,
  [Resume]           XML(CONTENT [HumanResources].[HRResumeSchemaCollection]) NULL,
  [RowStatus]        TINYINT          NOT NULL,
  [CreatedBy]        UNIQUEIDENTIFIER NOT NULL,
  [ModifiedBy]       UNIQUEIDENTIFIER NOT NULL,
  [CreatedDate]      DATETIME         NOT NULL,
  [ModifiedDate]     DATETIME         NOT NULL,
  [Uuid]             UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL,                                          
  CONSTRAINT [PK_JobCandidate_JobCandidateID] PRIMARY KEY CLUSTERED ([JobCandidateID] ASC),
  CONSTRAINT [FK_JobCandidate_Employee_BusinessEntityID] FOREIGN KEY ([BusinessEntityID]) REFERENCES [HumanResources].[Employee] ([BusinessEntityID])
);
GO

/* Defaults */
ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__RowStatus] DEFAULT ((1)) FOR [RowStatus]
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__CreatedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [CreatedBy]
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__ModifiedBy] DEFAULT ('4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') FOR [ModifiedBy]
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__CreatedDate] DEFAULT (GETUTCDATE()) FOR [CreatedDate]
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__ModifiedDate] DEFAULT (GETUTCDATE()) FOR [ModifiedDate]
GO

ALTER TABLE [HumanResources].[JobCandidate] ADD CONSTRAINT [DF__JobCandidate__Uuid] DEFAULT (NEWID()) FOR [Uuid]
GO

CREATE NONCLUSTERED INDEX [IX_JobCandidate_BusinessEntityID]
    ON [HumanResources].[JobCandidate]([BusinessEntityID] ASC);
GO

EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Nonclustered index.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'INDEX', @level2name = N'IX_JobCandidate_BusinessEntityID';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default constraint value of GETDATE()', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'CONSTRAINT', @level2name = N'DF__JobCandidate__ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key constraint referencing Employee.EmployeeID.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'CONSTRAINT', @level2name = N'FK_JobCandidate_Employee_BusinessEntityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key (clustered) constraint', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'CONSTRAINT', @level2name = N'PK_JobCandidate_JobCandidateID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the record was last updated.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'COLUMN', @level2name = N'ModifiedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Résumé in XML format.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'COLUMN', @level2name = N'Resume';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Employee identification number if applicant was hired. Foreign key to Employee.BusinessEntityID.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'COLUMN', @level2name = N'BusinessEntityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary key for JobCandidate records.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate', @level2type = N'COLUMN', @level2name = N'JobCandidateID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Résumés submitted to Human Resources by job applicants.', @level0type = N'SCHEMA', @level0name = N'HumanResources', @level1type = N'TABLE', @level1name = N'JobCandidate';

