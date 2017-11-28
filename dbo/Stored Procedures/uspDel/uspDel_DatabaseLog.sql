/*
IF EXISTS (SELECT 1 FROM [sys].[objects] WHERE object_id = OBJECT_ID(N'[dbo].[uspDel_databaselog]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[uspDel_databaselog]
GO
*/

CREATE PROCEDURE [dbo].[uspDel_databaselog]
  @DatabaseLogID INT,
  -- Return output options
  @ReturnOutput   BIT = 0,
  @ReturnAsTable  BIT = 0,
  @ReturnAsXml    BIT = 0,
  @RowsAffected   INT = 0 OUTPUT,
  @XmlResults     XML = NULL OUTPUT

WITH EXECUTE AS SELF
AS

/*******************************************************************************
WARNING: THIS IS A GENERATED CODE FILE! PLEASE DO NOT ALTER!
================================================================================
Schema:      dbo
Object:      uspDel_databaselog

Description: Delete a record(s) from the given table.

Returns:     If successful, returns one result set; if not successful, returns
             information about the error that occurred during processing.

Written by:  John W. Moore

*******************************************************************************/
BEGIN
  SET NOCOUNT ON;
  /* MS Data Rule SR0013 */
  SET @XmlResults = NULL;

  /* Render the transaction uncommittable when the constraint violation occurs. */
  SET XACT_ABORT ON;

  BEGIN TRY
    BEGIN TRANSACTION;

    /* ------------------------------------------------------------------------- */
    /* Output Controls */
    DECLARE @_ReturnOutput   BIT;
    DECLARE @_ReturnAsTable  BIT;
    DECLARE @_ReturnAsXml    BIT;

    SET @_ReturnOutput  = @ReturnOutput;
    SET @_ReturnAsTable = @ReturnAsTable;
    SET @_ReturnAsXml   = @ReturnAsXml;

    /* ------------------------------------------------------------------------- */
    /* Create a temp table to hold our updates */
    DECLARE @OutputTableVar TABLE
    (
       [DatabaseLogID] INT           NOT NULL
      ,[PostTime]      DATETIME      NULL
      ,[DatabaseUser]  SYSNAME       NULL
      ,[Event]         SYSNAME       NULL
      ,[Schema]        SYSNAME       NULL
      ,[Object]        SYSNAME       NULL
      ,[XmlEvent]      XML           NULL
    );

    /* ------------------------------------------------------------------------- */
    /* Table Primary Key(s) */
    DECLARE @_DatabaseLogID  INT;
    SET @_DatabaseLogID = @DatabaseLogID;

    /* ------------------------------------------------------------------------- */
    /* Delete Operation */
    DELETE FROM [dbo].[DatabaseLog]

    OUTPUT
      [DELETED].[DatabaseLogID],
      [DELETED].[PostTime],
      [DELETED].[DatabaseUser],
      [DELETED].[Event],
      [DELETED].[Schema],
      [DELETED].[Object],
      [DELETED].[TSQL],
      [DELETED].[XmlEvent]

    INTO
      @OutputTableVar

    WHERE
        [DatabaseLog].[DatabaseLogID] = @_DatabaseLogID
    ;

    /* ------------------------------------------------------------------------- */
    SELECT @RowsAffected = COALESCE( COUNT(1), 0 )
    FROM
      @OutputTableVar AS [OutputTableVar]

    /* Send all of the altered data back to the caller, if they want it */
    IF @_ReturnOutput = 1
    BEGIN

      /* Return the number of rows affected to allow for Optimistic Concurrency checks in the calling C sharp code, if desired. */
      IF @_ReturnAsTable = 1
      BEGIN

        SELECT
           [OutputTableVar].[DatabaseLogID]
          ,[OutputTableVar].[PostTime]
          ,[OutputTableVar].[DatabaseUser]
          ,[OutputTableVar].[Event]
          ,[OutputTableVar].[Schema]
          ,[OutputTableVar].[Object]
          ,[OutputTableVar].[TSQL]
          ,[OutputTableVar].[XmlEvent]
        FROM
          @OutputTableVar AS [OutputTableVar]

      END;

      IF @_ReturnAsXml = 1
      BEGIN

        BEGIN TRY
          SELECT
            @XmlResults =
            (
              SELECT
                 [OutputTableVar].[DatabaseLogID]
                ,[OutputTableVar].[PostTime]
                ,[OutputTableVar].[DatabaseUser]
                ,[OutputTableVar].[Event]
                ,[OutputTableVar].[Schema]
                ,[OutputTableVar].[Object]
                ,[OutputTableVar].[TSQL]
                ,[OutputTableVar].[XmlEvent]
              FROM
                @OutputTableVar AS [OutputTableVar]
              FOR XML PATH ('DatabaseLog'), ROOT ('DeletedRecords'), ELEMENTS XSINIL
            );

        END TRY

        BEGIN CATCH
          SELECT CONVERT(XML, '<xmlError>Unable to properly parse data into xml</xmlerror>', 1);
        END CATCH;

      END;

    END;
    ELSE
    BEGIN
      /* MS Data Rule SR0013 */
      SET @XmlResults   = NULL;
      SET @RowsAffected = 0;
    END; /* end return output */

    /* No error or issues, commit the transaction */
    COMMIT TRANSACTION;

  END TRY

    BEGIN CATCH

      /* This rollback affects the whole transaction stack, decrements @@TRANCOUNT to 0 */
      IF XACT_STATE() <> 0
        ROLLBACK TRANSACTION;

      DECLARE
        @DbName         NVARCHAR(128),
        @ErrorMessage   NVARCHAR(2048),
        @ErrorSeverity  TINYINT,
        @ErrorState     TINYINT,
        @ErrorNumber    INT,
        @ErrorProcedure SYSNAME,
        @ErrorLine      INT;

      SELECT
        @DbName         = DB_NAME(),
        @ErrorNumber    = ERROR_NUMBER(),
        @ErrorSeverity  = ERROR_SEVERITY(),
        @ErrorState     = ERROR_STATE(),
        @ErrorProcedure = ERROR_PROCEDURE(),
        @ErrorLine      = ERROR_LINE(),
        @ErrorMessage   = ERROR_MESSAGE();

      /* Raise the error */
      RAISERROR
      (
        @ErrorMessage,
        @ErrorSeverity,
        @ErrorState
      );

      /* Save the error */
      EXECUTE [eventLogs].[DatabaseErrorHandler]
        @DbName         = @DbName,
        @ErrorNumber    = @ErrorNumber,
        @ErrorSeverity  = @ErrorSeverity,
        @ErrorState     = @ErrorState,
        @ErrorProcedure = @ErrorProcedure,
        @ErrorLine      = @ErrorLine,
        @ErrorMessage   = @ErrorMessage;

    END CATCH;

END;

/*
Example usage:

DECLARE @RowsAffected INT;
DECLARE @XmlResults XML;
DECLARE @DatabaseLogID INT;
SET @DatabaseLogID = FILL IN;

EXEC dbo.uspDel_databaselog
  @DatabaseLogID = @DatabaseLogID,
  @ReturnOutput   = 1,
  @ReturnAsTable  = 1,
  @ReturnAsXml    = 1,
  @RowsAffected   = @RowsAffected OUTPUT,
  @XmlResults     = @XmlResults OUTPUT
;

SELECT
  @RowsAffected AS RowsAffected,
  @XmlResults AS XmlResults
;

*/
GO

EXECUTE sp_addextendedproperty
  @name = N'MS_Description',
  @value = N'Delete a single record from the table. Not auditing is performed, however triggers are handled with a proper OUTPUT for information.',
  @level0type = N'SCHEMA',
  @level0name = N'dbo',
  @level1type = N'PROCEDURE',
  @level1name = N'uspDel_databaselog';
GO