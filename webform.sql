CREATE DATABASE WEBFORMS

CREATE TABLE STUDENT
(
STUDENTID INT PRIMARY KEY IDENTITY(1,1),
NAME VARCHAR(100) NOT NULL,
GENDER VARCHAR(10) NOT NULL,
EMAIL VARCHAR(30) NOT NULL,
PHONENUMBER VARCHAR(15) NOT NULL,
ADDRESS VARCHAR(MAX) NOT NULL,
JOININGDATE DATE NOT NULL,
BRANCHE VARCHAR(100)NOT NULL);

CREATE OR ALTER PROCEDURE STUDENTREGISTER (
    @NAME VARCHAR(100),
    @GENDER VARCHAR(100),
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @ADDRESS VARCHAR(MAX),
    @JOININGDATE DATE,
    @BRANCHE VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @NAME IS NULL OR
           @GENDER IS NULL OR
           @EMAIL IS NULL OR
           @PHONENUMBER IS NULL OR
           @ADDRESS IS NULL OR
           @JOININGDATE IS NULL OR
           @BRANCHE IS NULL
        BEGIN
            PRINT 'PROVIDE ALL PARAMETERS';
            RETURN;
        END

        INSERT INTO STUDENT (NAME, GENDER, EMAIL, PHONENUMBER, ADDRESS, JOININGDATE, BRANCHE)
        VALUES (@NAME, @GENDER, @EMAIL, @PHONENUMBER, @ADDRESS, @JOININGDATE, @BRANCHE);
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

CREATE OR ALTER PROCEDURE UPDATESTUDENTBYID (
    @STUDENTID INT,
    @NAME VARCHAR(100),
    @GENDER VARCHAR(10),
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @ADDRESS VARCHAR(MAX),
    @JOININGDATE DATE,
    @BRANCHE VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @STUDENTID IS NULL
        BEGIN
            PRINT 'STUDENTID IS REQUIRED';
            RETURN;
        END
        IF @NAME IS NULL AND
           @GENDER IS NULL AND
           @EMAIL IS NULL AND
           @PHONENUMBER IS NULL AND
           @ADDRESS IS NULL AND
           @JOININGDATE IS NULL AND
           @BRANCHE IS NULL
        BEGIN
            RAISERROR('PROVIDE AT LEAST ONE COLUMN TO UPDATE',16,1);
            RETURN;
        END
        UPDATE STUDENT
        SET 
            NAME = @NAME,
            GENDER = @GENDER,
            EMAIL = @EMAIL,
            PHONENUMBER = @PHONENUMBER,
            ADDRESS = @ADDRESS,
            JOININGDATE =@JOININGDATE,
            BRANCHE =@BRANCHE
        WHERE STUDENTID = @STUDENTID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

CREATE OR ALTER PROCEDURE GETALLSTUDENTS
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM STUDENT)
        BEGIN
            SELECT * FROM STUDENT;
        END
        ELSE
        BEGIN
          RAISERROR('No records found in the STUDENT table.',16,1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

CREATE OR ALTER PROCEDURE GETSTUDENTBYID
(
    @STUDENTID INT
)
AS
BEGIN
    BEGIN TRY
        IF @STUDENTID IS NULL
        BEGIN
            RAISERROR('STUDENTID IS REQUIRED', 16, 1);
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM STUDENT WHERE STUDENTID = @STUDENTID)
        BEGIN
            SELECT * FROM STUDENT WHERE STUDENTID = @STUDENTID;
        END
        ELSE
        BEGIN
            RAISERROR('No record found for the given STUDENTID', 16, 1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;

CREATE OR ALTER PROCEDURE DELETESTUDENTBYID
(
    @STUDENTID INT
)
AS
BEGIN
    BEGIN TRY
        IF @STUDENTID IS NULL
        BEGIN
            RAISERROR('STUDENTID IS REQUIRED', 16, 1);
            RETURN;
        END

        IF EXISTS (SELECT 1 FROM STUDENT WHERE STUDENTID = @STUDENTID)
        BEGIN
            DELETE FROM STUDENT WHERE STUDENTID = @STUDENTID;
            PRINT 'Record deleted successfully';
        END
        ELSE
        BEGIN
            RAISERROR('No record found for the given STUDENTID', 16, 1);
        END
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
select * from student