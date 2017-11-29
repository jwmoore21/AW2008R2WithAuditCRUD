/*
IF EXISTS (SELECT 1 FROM [sys].[objects] WHERE object_id = OBJECT_ID(N'[Sales].[uspDel_SalesTerritoryHistory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Sales].[uspDel_SalesTerritoryHistory]
GO
*/

CREATE PROCEDURE [Sales].[uspDel_SalesTerritoryHistory]
  @BusinessEntityID INT,
  @TerritoryID INT,
  @StartDate DATETIME,
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
Schema:      Sales
Object:      uspDel_SalesTerritoryHistory

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
       [BusinessEntityID] INT               NOT NULL
      ,[TerritoryID]      INT               NOT NULL
      ,[StartDate]        DATETIME          NOT NULL
      ,[EndDate]          DATETIME          NULL
      ,[rowguid]          UNIQUEIDENTIFIER  NOT NULL
      ,[RowStatus]        TINYINT           NOT NULL
      ,[CreatedBy]        UNIQUEIDENTIFIER  NOT NULL
      ,[ModifiedBy]       UNIQUEIDENTIFIER  NOT NULL
      ,[CreatedDate]      DATETIME          NOT NULL
      ,[ModifiedDate]     DATETIME          NOT NULL
      ,[Uuid]             UNIQUEIDENTIFIER  NOT NULL
    );

    /* ------------------------------------------------------------------------- */
    /* Table Primary Key(s) */
    DECLARE @_BusinessEntityID  INT;
    DECLARE @_TerritoryID  INT;
    DECLARE @_StartDate  DATETIME;
    SET @_BusinessEntityID = @BusinessEntityID;
    SET @_TerritoryID = @TerritoryID;
    SET @_StartDate = @StartDate;

    /* ------------------------------------------------------------------------- */
    /* Delete Operation */
    DELETE FROM [Sales].[SalesTerritoryHistory]

    OUTPUT
      [DELETED].[BusinessEntityID],
      [DELETED].[TerritoryID],
      [DELETED].[StartDate],
      [DELETED].[EndDate],
      [DELETED].[rowguid],
      [DELETED].[RowStatus],
      [DELETED].[CreatedBy],
      [DELETED].[ModifiedBy],
      [DELETED].[CreatedDate],
      [DELETED].[ModifiedDate],
      [DELETED].[Uuid]

    INTO
      @OutputTableVar

    WHERE
        [SalesTerritoryHistory].[BusinessEntityID] = @_BusinessEntityID
        AND [SalesTerritoryHistory].[TerritoryID] = @_TerritoryID
        AND [SalesTerritoryHistory].[StartDate] = @_StartDate
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
           [OutputTableVar].[BusinessEntityID]
          ,[OutputTableVar].[TerritoryID]
          ,[OutputTableVar].[StartDate]
          ,[OutputTableVar].[EndDate]
          ,[OutputTableVar].[rowguid]
          ,[OutputTableVar].[RowStatus]
          ,[OutputTableVar].[CreatedBy]
          ,[OutputTableVar].[ModifiedBy]
          ,[OutputTableVar].[CreatedDate]
          ,[OutputTableVar].[ModifiedDate]
          ,[OutputTableVar].[Uuid]
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
                 [OutputTableVar].[BusinessEntityID]
                ,[OutputTableVar].[TerritoryID]
                ,[OutputTableVar].[StartDate]
                ,[OutputTableVar].[EndDate]
                ,[OutputTableVar].[rowguid]
                ,[OutputTableVar].[RowStatus]
                ,[OutputTableVar].[CreatedBy]
                ,[OutputTableVar].[ModifiedBy]
                ,[OutputTableVar].[CreatedDate]
                ,[OutputTableVar].[ModifiedDate]
                ,[OutputTableVar].[Uuid]
              FROM
                @OutputTableVar AS [OutputTableVar]
              FOR XML PATH ('SalesTerritoryHistory'), ROOT ('DeletedRecords'), ELEMENTS XSINIL
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
DECLARE @BusinessEntityID INT;
SET @BusinessEntityID = FILL IN;
DECLARE @TerritoryID INT;
SET @TerritoryID = FILL IN;
DECLARE @StartDate DATETIME;
SET @StartDate = FILL IN;

EXEC Sales.uspDel_SalesTerritoryHistory
  @BusinessEntityID = @BusinessEntityID,
  @TerritoryID = @TerritoryID,
  @StartDate = @StartDate,
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
  @value = N'Delete a single record from the table. No auditing is performed, however triggers are handled with a proper OUTPUT for information.',
  @level0type = N'SCHEMA',
  @level0name = N'Sales',
  @level1type = N'PROCEDURE',
  @level1name = N'uspDel_SalesTerritoryHistory';
GO