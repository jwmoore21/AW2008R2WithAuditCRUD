/*
IF EXISTS ( SELECT 1 FROM sys.triggers WHERE object_id = object_id(N'[Sales].[TRG__SalesTerritory__instead_of_del]'))
DROP TRIGGER [Sales].[TRG__SalesTerritory__instead_of_del]
GO
*/
CREATE TRIGGER [Sales].[TRG__SalesTerritory__instead_of_del] ON [Sales].[SalesTerritory]
  INSTEAD OF DELETE
AS

/*******************************************************************************
Schema:      Sales
Object:      TRG__SalesTerritory__instead_of_del

Description: INSTEAD OF DELETE trigger. Automatically ensures that any data
             deleted from our database is tracked in our auditing tables.
             
Returns:     Nothing

Written by:  John W. Moore

*******************************************************************************/
BEGIN

  /* SET NOCOUNT ON added to prevent extra result sets from interfering with SELECT statements. */
  SET NOCOUNT ON;

  /* Triggers are supposed have this implicitly turned, but let's be sure, render the transaction uncommittable when the constraint violation occurs. */
  SET XACT_ABORT ON;

  BEGIN TRY
    BEGIN TRANSACTION;

    /* ========================================================================= */
    /* Auditing Info */
    DECLARE @_AuditStatus    TINYINT;
    DECLARE @_AuditAppUser   UNIQUEIDENTIFIER;
    DECLARE @_AuditSqlUser   VARCHAR(256);
    DECLARE @_AuditDate      DATETIME;
    DECLARE @_AuditBatchId   VARCHAR(64);
    DECLARE @_AuditOperation VARCHAR(255);

    /* Delete */
    SET @_AuditStatus    = 2; 
    SET @_AuditAppUser   = CAST( '4E3A7D6D-8351-8494-FDB7-39E2A3A2E972' AS UNIQUEIDENTIFIER ); /* we do not have a web user at this point, assign one */
    SET @_AuditSqlUser   = SYSTEM_USER;
    SET @_AuditDate      = GETUTCDATE();
    SET @_AuditBatchId   = CAST( NEWID() AS VARCHAR(64) );
    SET @_AuditOperation = 'Autosave by: INSTEAD OF DELETE Trigger : TRG__SalesTerritory__instead_of_del';

    /* ========================================================================= */
    /* Create a temp table to hold our updates */
    DECLARE @AuditRecordsToSave TABLE
    (
       [TerritoryID]       INT               NOT NULL
      ,[Name]              [dbo].[Name]      NOT NULL
      ,[CountryRegionCode] NVARCHAR(3)       NOT NULL
      ,[Group]             NVARCHAR(50)      NOT NULL
      ,[SalesYTD]          MONEY             NOT NULL
      ,[SalesLastYear]     MONEY             NOT NULL
      ,[CostYTD]           MONEY             NOT NULL
      ,[CostLastYear]      MONEY             NOT NULL
      ,[rowguid]           UNIQUEIDENTIFIER  NOT NULL
      ,[RowStatus]         TINYINT           NOT NULL
      ,[CreatedBy]         UNIQUEIDENTIFIER  NOT NULL
      ,[ModifiedBy]        UNIQUEIDENTIFIER  NOT NULL
      ,[CreatedDate]       DATETIME          NOT NULL
      ,[ModifiedDate]      DATETIME          NOT NULL
      ,[Uuid]              UNIQUEIDENTIFIER  NOT NULL
    );

    /* Insert into a TEMP table, all of our deleted values */
    INSERT INTO @AuditRecordsToSave
    (
       [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[RowStatus]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Uuid]
    )
    SELECT
       [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[RowStatus]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Uuid]
    FROM
      deleted

    /* Insert into a TEMP table, all of our deleted values */
    INSERT INTO [Audit].[AuditSalesTerritory]
    (
       [AuditStatus]
      ,[AuditAppUser]
      ,[AuditSqlUser]
      ,[AuditDate]
      ,[AuditBatchId]
      ,[AuditOperation]
      ,[TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[RowStatus]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Uuid]
    )
    SELECT
       @_AuditStatus
      ,@_AuditAppUser
      ,@_AuditSqlUser
      ,@_AuditDate
      ,@_AuditBatchId
      ,@_AuditOperation
      ,[AuditRecordsToSave].[TerritoryID]
      ,[AuditRecordsToSave].[Name]
      ,[AuditRecordsToSave].[CountryRegionCode]
      ,[AuditRecordsToSave].[Group]
      ,[AuditRecordsToSave].[SalesYTD]
      ,[AuditRecordsToSave].[SalesLastYear]
      ,[AuditRecordsToSave].[CostYTD]
      ,[AuditRecordsToSave].[CostLastYear]
      ,[AuditRecordsToSave].[rowguid]
      ,[AuditRecordsToSave].[RowStatus]
      ,[AuditRecordsToSave].[CreatedBy]
      ,[AuditRecordsToSave].[ModifiedBy]
      ,[AuditRecordsToSave].[CreatedDate]
      ,[AuditRecordsToSave].[ModifiedDate]
      ,[AuditRecordsToSave].[Uuid]
    FROM
      @AuditRecordsToSave AS AuditRecordsToSave

    /* Now we can perform the actual delete */
    DELETE recordsToErase
    FROM [Sales].[SalesTerritory] AS recordsToErase
    INNER JOIN @AuditRecordsToSave AS AuditRecordsToSave
    ON AuditRecordsToSave.[Uuid] = recordsToErase.[Uuid]
    ;

    /* No error or issues, commit the transaction */
    IF @@TRANCOUNT > 0 
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

END

GO