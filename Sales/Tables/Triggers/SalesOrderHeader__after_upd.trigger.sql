/*
IF EXISTS ( SELECT 1 FROM sys.triggers WHERE object_id = object_id(N'[Sales].[TRG__SalesOrderHeader__after_upd]'))
DROP TRIGGER [Sales].[TRG__SalesOrderHeader__after_upd]
GO
*/
CREATE TRIGGER [Sales].[TRG__SalesOrderHeader__after_upd] ON [Sales].[SalesOrderHeader]
  AFTER UPDATE
AS

/*******************************************************************************
Schema:      Sales
Object:      TRG__SalesOrderHeader__after_upd

Description: AFTER UPDATE trigger. Automatically ensures that any data
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

    /* Update */
    SET @_AuditStatus    = 1; 
    SET @_AuditAppUser   = CAST( '4E3A7D6D-8351-8494-FDB7-39E2A3A2E972' AS UNIQUEIDENTIFIER ); /* we do not have a web user at this point, assign one */
    SET @_AuditSqlUser   = SYSTEM_USER;
    SET @_AuditDate      = GETUTCDATE();
    SET @_AuditBatchId   = CAST( [dbo].[ufn_CombGuid]() AS VARCHAR(64) );
    SET @_AuditOperation = 'Autosave by: AFTER UPDATE Trigger : TRG__SalesOrderHeader__after_upd';
    /* ========================================================================= */
    /* Create a temp table to hold our updates */
    DECLARE @AuditRecordsToSave TABLE
    (
       [SalesOrderID]           INT               NOT NULL
      ,[RevisionNumber]         TINYINT           NOT NULL
      ,[OrderDate]              DATETIME          NOT NULL
      ,[DueDate]                DATETIME          NOT NULL
      ,[ShipDate]               DATETIME          NULL
      ,[Status]                 TINYINT           NOT NULL
      ,[OnlineOrderFlag]        [dbo].[Flag]      NOT NULL
      ,[SalesOrderNumber]       NVARCHAR(25)      NOT NULL
      ,[PurchaseOrderNumber]    [dbo].[OrderNumber]  NULL
      ,[AccountNumber]          [dbo].[AccountNumber]  NULL
      ,[CustomerID]             INT               NOT NULL
      ,[SalesPersonID]          INT               NULL
      ,[TerritoryID]            INT               NULL
      ,[BillToAddressID]        INT               NOT NULL
      ,[ShipToAddressID]        INT               NOT NULL
      ,[ShipMethodID]           INT               NOT NULL
      ,[CreditCardID]           INT               NULL
      ,[CreditCardApprovalCode] VARCHAR(15)       NULL
      ,[CurrencyRateID]         INT               NULL
      ,[SubTotal]               MONEY             NOT NULL
      ,[TaxAmt]                 MONEY             NOT NULL
      ,[Freight]                MONEY             NOT NULL
      ,[TotalDue]               MONEY             NOT NULL
      ,[Comment]                NVARCHAR(128)     NULL
      ,[rowguid]                UNIQUEIDENTIFIER  NOT NULL
      ,[RowStatus]              TINYINT           NOT NULL
      ,[CreatedBy]              UNIQUEIDENTIFIER  NOT NULL
      ,[ModifiedBy]             UNIQUEIDENTIFIER  NOT NULL
      ,[CreatedDate]            DATETIME          NOT NULL
      ,[ModifiedDate]           DATETIME          NOT NULL
      ,[Uuid]                   UNIQUEIDENTIFIER  NOT NULL
    );

    /* Insert into a TEMP table, all of our deleted values */
    INSERT INTO @AuditRecordsToSave
    (
       [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[RowStatus]
      ,[CreatedBy]
      ,[ModifiedBy]
      ,[CreatedDate]
      ,[ModifiedDate]
      ,[Uuid]
    )
    SELECT
       [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
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
    INSERT INTO [Audit].[AuditSalesOrderHeader]
    (
       [AuditStatus]
      ,[AuditAppUser]
      ,[AuditSqlUser]
      ,[AuditDate]
      ,[AuditBatchId]
      ,[AuditOperation]
      ,[SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
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
      ,[AuditRecordsToSave].[SalesOrderID]
      ,[AuditRecordsToSave].[RevisionNumber]
      ,[AuditRecordsToSave].[OrderDate]
      ,[AuditRecordsToSave].[DueDate]
      ,[AuditRecordsToSave].[ShipDate]
      ,[AuditRecordsToSave].[Status]
      ,[AuditRecordsToSave].[OnlineOrderFlag]
      ,[AuditRecordsToSave].[SalesOrderNumber]
      ,[AuditRecordsToSave].[PurchaseOrderNumber]
      ,[AuditRecordsToSave].[AccountNumber]
      ,[AuditRecordsToSave].[CustomerID]
      ,[AuditRecordsToSave].[SalesPersonID]
      ,[AuditRecordsToSave].[TerritoryID]
      ,[AuditRecordsToSave].[BillToAddressID]
      ,[AuditRecordsToSave].[ShipToAddressID]
      ,[AuditRecordsToSave].[ShipMethodID]
      ,[AuditRecordsToSave].[CreditCardID]
      ,[AuditRecordsToSave].[CreditCardApprovalCode]
      ,[AuditRecordsToSave].[CurrencyRateID]
      ,[AuditRecordsToSave].[SubTotal]
      ,[AuditRecordsToSave].[TaxAmt]
      ,[AuditRecordsToSave].[Freight]
      ,[AuditRecordsToSave].[TotalDue]
      ,[AuditRecordsToSave].[Comment]
      ,[AuditRecordsToSave].[rowguid]
      ,[AuditRecordsToSave].[RowStatus]
      ,[AuditRecordsToSave].[CreatedBy]
      ,[AuditRecordsToSave].[ModifiedBy]
      ,[AuditRecordsToSave].[CreatedDate]
      ,[AuditRecordsToSave].[ModifiedDate]
      ,[AuditRecordsToSave].[Uuid]
    FROM
      @AuditRecordsToSave AS AuditRecordsToSave

      /* Update modified date value in the parent table */
      UPDATE Sales.SalesOrderHeader
        SET
          SalesOrderHeader.ModifiedDate = GETUTCDATE()
      FROM Sales.SalesOrderHeader AS SalesOrderHeader
        INNER JOIN @AuditRecordsToSave AS AuditRecordsToSave
        ON AuditRecordsToSave.[Uuid] = SalesOrderHeader.[Uuid]
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

END;

GO