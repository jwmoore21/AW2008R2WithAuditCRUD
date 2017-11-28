/*
IF  EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ufn_CombGuid]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[ufn_CombGuid]
GO
*/

CREATE FUNCTION NEWID()
RETURNS UNIQUEIDENTIFIER
AS
BEGIN
  /*
  Created an Ordered, or COMBined GUID
  http://www.informit.com/articles/article.aspx?p=25862&seqNum=7
  */

  DECLARE @NextNewId UNIQUEIDENTIFIER
  SELECT @NextNewId = vwNewId.NextNewId FROM dbo.vwNewId AS vwNewId;
  
  RETURN ( CAST(CAST( @NextNewId AS BINARY(10)) + CAST(GETDATE() AS BINARY(6)) AS UNIQUEIDENTIFIER) )

END
GO 
