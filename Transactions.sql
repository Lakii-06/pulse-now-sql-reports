USE PatientHealthDB;
GO


BEGIN TRANSACTION;

BEGIN TRY
    -- Insert a new report
    INSERT INTO Report (ReportID, ReceiptID, CollectionDate, Notes, Status)
    VALUES (411, 103, '2025-06-08', 'Repeat checkup', 'Unfit');

    -- Insert test results linked to the report
    INSERT INTO ReportTest (ReportID, TestID, Results)
    VALUES 
        (411, 301, '135/85'),
        (411, 302, 'High');

    COMMIT TRANSACTION;
    PRINT 'Transaction committed successfully.';
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed and rolled back.';
    PRINT ERROR_MESSAGE();
END CATCH


SELECT * FROM Report WHERE ReportID = 411;

SELECT * FROM ReportTest WHERE ReportID = 411;
