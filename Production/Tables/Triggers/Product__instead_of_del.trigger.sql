/*
IF EXISTS ( SELECT 1 FROM sys.triggers WHERE object_id = object_id(N'[Production].[TRG__Product__instead_of_del]'))
DROP TRIGGER [Production].[TRG__Product__instead_of_del]
GO
*/
CREATE TRIGGER [Production].[TRG__Product__instead_of_del] ON [Production].[Product]
  INSTEAD OF DELETE
AS

/*******************************************************************************
Schema:      Production
Object:      TRG__Product__instead_of_del

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
    SET @_AuditOperation = 'Autosave by: INSTEAD OF DELETE Trigger : TRG__Product__instead_of_del';

    /* ========================================================================= */
    /* Create a temp table to hold our updates */
    DECLARE @AuditRecordsToSave TABLE
    (
       [ProductID]             INT               NOT NULL
      ,[Name]                  [dbo].[Name]      NOT NULL
      ,[ProductNumber]         NVARCHAR(25)      NOT NULL
      ,[MakeFlag]              [dbo].[Flag]      NOT NULL
      ,[FinishedGoodsFlag]     [dbo].[Flag]      NOT NULL
      ,[Color]                 NVARCHAR(15)      NULL
      ,[SafetyStockLevel]      SMALLINT          NOT NULL
      ,[ReorderPoint]          SMALLINT          NOT NULL
      ,[StandardCost]          MONEY             NOT NULL
      ,[ListPrice]             MONEY             NOT NULL
      ,[Size]                  NVARCHAR(5)       NULL
      ,[SizeUnitMeasureCode]   NCHAR(3)          NULL
      ,[WeightUnitMeasureCode] NCHAR(3)          NULL
      ,[Weight]                DECIMAL(8,2)      NULL
      ,[DaysToManufacture]     INT               NOT NULL
      ,[ProductLine]           NCHAR(2)          NULL
      ,[Class]                 NCHAR(2)          NULL
      ,[Style]                 NCHAR(2)          NULL
      ,[ProductSubcategoryID]  INT               NULL
      ,[ProductModelID]        INT               NULL
      ,[SellStartDate]         DATETIME          NOT NULL
      ,[SellEndDate]           DATETIME          NULL
      ,[DiscontinuedDate]      DATETIME          NULL
      ,[rowguid]               UNIQUEIDENTIFIER  NOT NULL
      ,[RowStatus]             TINYINT           NOT NULL
      ,[CreatedBy]             UNIQUEIDENTIFIER  NOT NULL
      ,[ModifiedBy]            UNIQUEIDENTIFIER  NOT NULL
      ,[CreatedDate]           DATETIME          NOT NULL
      ,[ModifiedDate]          DATETIME          NOT NULL
      ,[Uuid]                  UNIQUEIDENTIFIER  NOT NULL
    );

    /* Insert into a TEMP table, all of our deleted values */
    INSERT INTO @AuditRecordsToSave
    (
       [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[rowguid]
      ,[RowStatus]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Uuid]
    )
    SELECT
       [ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
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
    INSERT INTO [Audit].[AuditProduct]
    (
       [AuditStatus]
      ,[AuditAppUser]
      ,[AuditSqlUser]
      ,[AuditDate]
      ,[AuditBatchId]
      ,[AuditOperation]
      ,[ProductID]
      ,[Name]
      ,[ProductNumber]
      ,[MakeFlag]
      ,[FinishedGoodsFlag]
      ,[Color]
      ,[SafetyStockLevel]
      ,[ReorderPoint]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[SizeUnitMeasureCode]
      ,[WeightUnitMeasureCode]
      ,[Weight]
      ,[DaysToManufacture]
      ,[ProductLine]
      ,[Class]
      ,[Style]
      ,[ProductSubcategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
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
      ,[AuditRecordsToSave].[ProductID]
      ,[AuditRecordsToSave].[Name]
      ,[AuditRecordsToSave].[ProductNumber]
      ,[AuditRecordsToSave].[MakeFlag]
      ,[AuditRecordsToSave].[FinishedGoodsFlag]
      ,[AuditRecordsToSave].[Color]
      ,[AuditRecordsToSave].[SafetyStockLevel]
      ,[AuditRecordsToSave].[ReorderPoint]
      ,[AuditRecordsToSave].[StandardCost]
      ,[AuditRecordsToSave].[ListPrice]
      ,[AuditRecordsToSave].[Size]
      ,[AuditRecordsToSave].[SizeUnitMeasureCode]
      ,[AuditRecordsToSave].[WeightUnitMeasureCode]
      ,[AuditRecordsToSave].[Weight]
      ,[AuditRecordsToSave].[DaysToManufacture]
      ,[AuditRecordsToSave].[ProductLine]
      ,[AuditRecordsToSave].[Class]
      ,[AuditRecordsToSave].[Style]
      ,[AuditRecordsToSave].[ProductSubcategoryID]
      ,[AuditRecordsToSave].[ProductModelID]
      ,[AuditRecordsToSave].[SellStartDate]
      ,[AuditRecordsToSave].[SellEndDate]
      ,[AuditRecordsToSave].[DiscontinuedDate]
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
    FROM [Production].[Product] AS recordsToErase
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