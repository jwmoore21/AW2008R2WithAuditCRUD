CREATE SCHEMA [Audit]
AUTHORIZATION [dbo];
GO

EXECUTE sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'Contains transactional audit history of all the tables.', 
  @level0type = N'SCHEMA', 
  @level0name = N'Audit';
GO

