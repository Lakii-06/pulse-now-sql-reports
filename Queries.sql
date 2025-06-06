USE PatientHealthDB;
GO


SELECT 
    p.FullName,
    pk.PackageName,
    r.DateIssued
FROM Patient p
JOIN Receipt r ON p.PatientID = r.PatientID
JOIN Package pk ON r.PackageID = pk.PackageID;


SELECT 
    p.FullName,
    t.TestName,
    rt.Results
FROM Patient p
JOIN Receipt r ON p.PatientID = r.PatientID
JOIN Report rep ON r.ReceiptID = rep.ReceiptID
JOIN ReportTest rt ON rep.ReportID = rt.ReportID
JOIN Test t ON rt.TestID = t.TestID
WHERE rep.Status = 'Fit';


SELECT 
    pk.PackageName,
    r.ReceiptID,
    r.DateIssued
FROM Package pk
LEFT JOIN Receipt r ON pk.PackageID = r.PackageID;


SELECT 
    pk.PackageName,
    COUNT(r.ReceiptID) AS TotalReceipts
FROM Package pk
JOIN Receipt r ON pk.PackageID = r.PackageID
GROUP BY pk.PackageName;


SELECT 
    p.FullName,
    rep.Status,
    rep.CollectionDate
FROM Patient p
JOIN Receipt r ON p.PatientID = r.PatientID
JOIN Report rep ON r.ReceiptID = rep.ReceiptID
WHERE rep.Status = 'Unfit';
