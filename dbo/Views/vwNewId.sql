/*
IF EXISTS(SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID('[dbo].[vwNewId]'))
BEGIN
  DROP VIEW [dbo].[vwNewId]
END
GO
*/

CREATE VIEW vwNewId
AS
  /*
  This view is for use inside of a function that needs access to the NEWID() 
  SQL function.  You can not access the NEWID() directly, if you do you will 
  get an error : 
  
  Msg 443, Level 16, State 1, Procedure Something, Line X
  Invalid use of a side-effecting operator ‘newid’ within a function.
  */
  
  SELECT NEWID() AS NextNewId;
GO