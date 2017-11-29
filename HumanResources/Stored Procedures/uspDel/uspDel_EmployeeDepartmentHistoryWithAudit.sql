/*
IF EXISTS (SELECT 1 FROM [sys].[objects] WHERE object_id = OBJECT_ID(N'[HumanResources].[uspDel_EmployeeDepartmentHistoryWithAudit]') AND type in (N'P', N'PC'))
DROP PROCEDURE [HumanResources].[uspDel_EmployeeDepartmentHistoryWithAudit]
GO
*/

CREATE PROCEDURE [HumanResources].[uspDel_EmployeeDepartmentHistoryWithAudit]
  @BusinessEntityID INT,
  @DepartmentID SMALLINT,
  @ShiftID TINYINT,
  @StartDate DATE,
  @ModifiedBy    UNIQUEIDENTIFIER = NULL,
  -- Auditing Info
  @AuditBatchId   VARCHAR(64) = NULL,
  @AuditOperation VARCHAR(255) = NULL,
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
Schema:      HumanResources
Object:      uspDel_EmployeeDepartmentHistoryWithAudit

Description: Delete a record(s) from the given table. Check for the existance of
             a table INSTEAD OF DELETE trigger, if found, let the table trigger
             handle the audting of the deleted record(s), otherwise, this proc
             with save the audit trail.

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
    /* Auditing Info */
    DECLARE @_AuditStatus    TINYINT;
    DECLARE @_AuditAppUser   UNIQUEIDENTIFIER;
    DECLARE @_AuditSqlUser   VARCHAR(256);
    DECLARE @_AuditDate      DATETIME;
    DECLARE @_AuditBatchId   VARCHAR(64);
    DECLARE @_AuditOperation VARCHAR(255);

    SET @_AuditStatus    = 2; /* Delete */
    SET @_AuditAppUser   = COALESCE( @ModifiedBy, CONVERT(VARCHAR(64), '4E3A7D6D-8351-8494-FDB7-39E2A3A2E972') );
    SET @_AuditSqlUser   = SYSTEM_USER;
    SET @_AuditDate      = GETDATE();
    SET @_AuditBatchId   = COALESCE( @AuditBatchId, CONVERT(VARCHAR(64),NEWID()) );
    SET @_AuditOperation = COALESCE( @AuditOperation, 'Delete proc ran: uspDel_EmployeeDepartmentHistoryWithAudit' );

    /* ------------------------------------------------------------------------- */
    /* Table Primary Key(s) */
    DECLARE @_BusinessEntityID  INT;
    DECLARE @_DepartmentID  SMALLINT;
    DECLARE @_ShiftID  TINYINT;
    DECLARE @_StartDate  DATE;
    SET @_BusinessEntityID = @BusinessEntityID;
    SET @_DepartmentID = @DepartmentID;
    SET @_ShiftID = @ShiftID;
    SET @_StartDate = @StartDate;

    /* ------------------------------------------------------------------------- */
    /* Delete our record(s) */
    IF
    (
      SELECT
        COALESCE( COUNT(1), 0 ) AS HasInsteadOfDeleteTrigger
      FROM
        sysobjects AS [so]
        INNER JOIN sysobjects AS so2
        ON so.parent_obj = so2.id
      WHERE
        [so].[type] = 'TR'
      AND USER_NAME([so2].[uid]) = 'HumanResources'
      AND OBJECT_NAME([so].[parent_obj]) = 'EmployeeDepartmentHistory'
      AND OBJECTPROPERTY( [so].[id], N'ExecIsDeleteTrigger') = 1
      AND OBJECTPROPERTY( [so].[id], N'ExecIsInsteadOfTrigger') = 1
      AND OBJECTPROPERTY([so].[id], N'ExecIsTriggerDisabled') = 0
      AND
      (
        SELECT
          COALESCE( COUNT(1), 0 ) AS HasAuditTable
        FROM
          [sys].[tables] AS [tables]
        WHERE
          SCHEMA_NAME([tables].[schema_id]) = 'Audit'
        AND [tables].[name] = 'AuditEmployeeDepartmentHistory'
      ) = 1
    ) = 1
    BEGIN

      /* Parent table has an update trigger enabled, and the audit table
         exists in the local audit schema, let the trigger handle
         the auditing */
      DELETE FROM [HumanResources].[EmployeeDepartmentHistory]

      WHERE
        [EmployeeDepartmentHistory].[BusinessEntityID] = @_BusinessEntityID
        AND [EmployeeDepartmentHistory].[DepartmentID] = @_DepartmentID
        AND [EmployeeDepartmentHistory].[ShiftID] = @_ShiftID
        AND [EmployeeDepartmentHistory].[StartDate] = @_StartDate
      ;

    END; /* HasInsteadOfDeleteTrigger */
    ELSE
    BEGIN

      IF
      (
        SELECT
          COALESCE( COUNT(1), 0 )  AS HasAuditTable
        FROM
          [sys].[tables] AS [tables]
        WHERE
          SCHEMA_NAME([tables].[schema_id]) = 'Audit'
        AND [tables].[name] = 'AuditEmployeeDepartmentHistory'
      ) = 1
      BEGIN

        /* No update trigger found on the parent table, however, we did find
           the audit table in our audit schema, save the audit data */
        DELETE FROM [HumanResources].[EmployeeDepartmentHistory]

        OUTPUT
          CAST(CAST(NEWID() AS BINARY(10)) + CAST(GETDATE() AS BINARY(6)) AS UNIQUEIDENTIFIER),
          @_AuditStatus,
          @_AuditAppUser,
          @_AuditSqlUser,
          @_AuditDate,
          @_AuditBatchId,
          @_AuditOperation,
          [DELETED].[BusinessEntityID],
          [DELETED].[DepartmentID],
          [DELETED].[ShiftID],
          [DELETED].[StartDate],
          [DELETED].[EndDate],
          [DELETED].[RowStatus],
          [DELETED].[CreatedBy],
          [DELETED].[ModifiedBy],
          [DELETED].[CreatedDate],
          [DELETED].[ModifiedDate],
          [DELETED].[Uuid]

        INTO
          [Audit].[AuditEmployeeDepartmentHistory]

        WHERE
          [EmployeeDepartmentHistory].[BusinessEntityID] = @_BusinessEntityID
          AND [EmployeeDepartmentHistory].[DepartmentID] = @_DepartmentID
          AND [EmployeeDepartmentHistory].[ShiftID] = @_ShiftID
          AND [EmployeeDepartmentHistory].[StartDate] = @_StartDate
        ;

      END; /* HasAuditTable */
      ELSE
      BEGIN

        /* Prevent the delete from executing, we are missing the audit table, and / or trigger */
        RAISERROR ( 'Unable to delete the requested record(s).  The audit table and / or trigger is missing for this table.', 16, 1 );
        RETURN;

      END;

    END; /* audit trigger and table check */

    SELECT @RowsAffected = COALESCE( COUNT(1), 0 )
    FROM
      [Audit].[AuditEmployeeDepartmentHistory] AS [AuditEmployeeDepartmentHistory] WITH(NOLOCK)
    WHERE
      [AuditEmployeeDepartmentHistory].[AuditBatchId] = @_AuditBatchId;

    /* Send all of the altered data back to the caller, if they want it */
    IF @_ReturnOutput = 1
    BEGIN

      /* Return the number of rows affected to allow for Optimistic Concurrency checks in the calling C sharp code, if desired. */
      IF @_ReturnAsTable = 1
      BEGIN

        SELECT
           [AuditEmployeeDepartmentHistory].[BusinessEntityID]
          ,[AuditEmployeeDepartmentHistory].[DepartmentID]
          ,[AuditEmployeeDepartmentHistory].[ShiftID]
          ,[AuditEmployeeDepartmentHistory].[StartDate]
          ,[AuditEmployeeDepartmentHistory].[EndDate]
          ,[AuditEmployeeDepartmentHistory].[RowStatus]
          ,[AuditEmployeeDepartmentHistory].[CreatedBy]
          ,[AuditEmployeeDepartmentHistory].[ModifiedBy]
          ,[AuditEmployeeDepartmentHistory].[CreatedDate]
          ,[AuditEmployeeDepartmentHistory].[ModifiedDate]
          ,[AuditEmployeeDepartmentHistory].[Uuid]
        FROM
          [Audit].[AuditEmployeeDepartmentHistory] AS [AuditEmployeeDepartmentHistory] WITH(NOLOCK)
        WHERE
          [AuditEmployeeDepartmentHistory].[AuditBatchId] = @_AuditBatchId;

      END;

      IF @_ReturnAsXml = 1
      BEGIN

        BEGIN TRY
          SELECT
            @XmlResults =
            (
              SELECT
                 [AuditEmployeeDepartmentHistory].[BusinessEntityID]
                ,[AuditEmployeeDepartmentHistory].[DepartmentID]
                ,[AuditEmployeeDepartmentHistory].[ShiftID]
                ,[AuditEmployeeDepartmentHistory].[StartDate]
                ,[AuditEmployeeDepartmentHistory].[EndDate]
                ,[AuditEmployeeDepartmentHistory].[RowStatus]
                ,[AuditEmployeeDepartmentHistory].[CreatedBy]
                ,[AuditEmployeeDepartmentHistory].[ModifiedBy]
                ,[AuditEmployeeDepartmentHistory].[CreatedDate]
                ,[AuditEmployeeDepartmentHistory].[ModifiedDate]
                ,[AuditEmployeeDepartmentHistory].[Uuid]
              FROM
                [Audit].[AuditEmployeeDepartmentHistory] AS [AuditEmployeeDepartmentHistory] WITH(NOLOCK)
              WHERE
                [AuditEmployeeDepartmentHistory].[AuditBatchId] = @_AuditBatchId
              FOR XML PATH ('EmployeeDepartmentHistory'), ROOT ('DeletedRecords'), ELEMENTS XSINIL
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

DECLARE @AuditBatchId UNIQUEIDENTIFIER;
SET @AuditBatchId = NEWID();

DECLARE @RowsAffected INT;
DECLARE @XmlResults XML;
DECLARE @BusinessEntityID INT;
SET @BusinessEntityID = FILL IN;
DECLARE @DepartmentID SMALLINT;
SET @DepartmentID = FILL IN;
DECLARE @ShiftID TINYINT;
SET @ShiftID = FILL IN;
DECLARE @StartDate DATE;
SET @StartDate = FILL IN;

EXEC HumanResources.uspDel_EmployeeDepartmentHistoryWithAudit
  @BusinessEntityID = @BusinessEntityID,
  @DepartmentID = @DepartmentID,
  @ShiftID = @ShiftID,
  @StartDate = @StartDate,
  @AuditBatchId    = @AuditBatchId,
  @ModifiedBy   = '4E3A7D6D-8351-8494-FDB7-39E2A3A2E972',
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

SELECT AuditEmployeeDepartmentHistory.*
FROM   Audit.AuditEmployeeDepartmentHistory AS AuditEmployeeDepartmentHistory WITH(NOLOCK)
WHERE
  AuditEmployeeDepartmentHistory.AuditBatchId = @AuditBatchId
;

*/
GO


EXECUTE sp_addextendedproperty
  @name = N'MS_Description',
  @value = N'Updates a single record from the table if a coresponding audit table or trigger exists. Otherwise, aborts.',
  @level0type = N'SCHEMA',
  @level0name = N'HumanResources',
  @level1type = N'PROCEDURE',
  @level1name = N'uspDel_EmployeeDepartmentHistoryWithAudit';
GO