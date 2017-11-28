CREATE SCHEMA [eventLogs]
AUTHORIZATION [dbo];
GO

EXECUTE sp_addextendedproperty 
  @name = N'MS_Description', 
  @value = N'Contains SQL errors and / or any other trapped data.', 
  @level0type = N'SCHEMA', 
  @level0name = N'eventLogs'
GO

