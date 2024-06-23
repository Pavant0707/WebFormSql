CREATE DATABASE STUDENTWEBFORM
CREATE TABLE STUDENT
(
STUDENTID INT PRIMARY KEY NOT NULL,
NAME VARCHAR(100) NOT NULL,
EMAIL VARCHAR(30) NOT NULL,
PHONENUMBER VARCHAR(15) NOT NULL,
COLLAGE VARCHAR(MAX) NOT NULL,
BRANCHE VARCHAR(100)NOT NULL,
);


CREATE OR ALTER PROCEDURE STUDENTREGISTER (
@STUDENTID INT,
    @NAME VARCHAR(100),
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @COLLAGE VARCHAR(MAX),
    @BRANCHE VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @STUDENTID IS NULL OR @NAME IS NULL OR
           @EMAIL IS NULL OR
           @PHONENUMBER IS NULL OR
           @COLLAGE IS NULL OR
           @BRANCHE IS NULL
        BEGIN
            PRINT 'PROVIDE ALL PARAMETERS';
            RETURN;
        END

        INSERT INTO STUDENT (STUDENTID,NAME, EMAIL, PHONENUMBER, COLLAGE, BRANCHE)
        VALUES (@STUDENTID,@NAME, @EMAIL, @PHONENUMBER, @COLLAGE, @BRANCHE);
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
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @COLLAGE VARCHAR(MAX),
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
        IF @STUDENTID IS NULL OR @NAME IS NULL AND
           @EMAIL IS NULL AND
           @PHONENUMBER IS NULL AND
           @COLLAGE IS NULL AND
           @BRANCHE IS NULL
        BEGIN
            RAISERROR('PROVIDE AT LEAST ONE COLUMN TO UPDATE',16,1);
            RETURN;
        END
        UPDATE STUDENT
        SET 
            NAME = @NAME,
            EMAIL = @EMAIL,
            PHONENUMBER = @PHONENUMBER,
            COLLAGE = @COLLAGE,
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
take input of name and if that data exist, edit the details.


CREATE OR ALTER PROCEDURE Update_procedure
(
    @STUDENTID INT,
    @NAME VARCHAR(100),
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @COLLAGE VARCHAR(MAX),
    @BRANCHE VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @NAME IS NULL
        BEGIN
            RAISERROR('NAME IS REQUIRED', 16, 1);
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM STUDENT WHERE NAME = @NAME)
        BEGIN
            UPDATE STUDENT
            SET 
                STUDENTID = @STUDENTID,
                EMAIL = @EMAIL,
                PHONENUMBER = @PHONENUMBER,
                COLLAGE = @COLLAGE,
                BRANCHE = @BRANCHE
            WHERE NAME = @NAME;
            SELECT * FROM STUDENT WHERE NAME = @NAME;
        END
        ELSE
        BEGIN
            RAISERROR('STUDENT RECORD NOT FOUND', 16, 1);
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
EXEC  Update_procedure
    @STUDENTID = 12,
    @NAME = 'RaM',
    @EMAIL = 'ram@gmail.com',
    @PHONENUMBER = '12345',
    @COLLAGE = 'RV',
    @BRANCHE = 'CS';
select * from  Student;





















CREATE OR ALTER PROCEDURE Update_by_name
(
    @NAME VARCHAR(100),
    @EMAIL VARCHAR(30),
    @PHONENUMBER VARCHAR(15),
    @COLLAGE VARCHAR(MAX),
    @BRANCHE VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @NAME IS NULL
        BEGIN
            RAISERROR('NAME IS REQUIRED', 16, 1);
            RETURN;
        END
        IF EXISTS (SELECT 1 FROM STUDENT WHERE NAME = @NAME)
        BEGIN
            UPDATE STUDENT
            SET 
                EMAIL = @EMAIL,
                PHONENUMBER = @PHONENUMBER,
                COLLAGE = @COLLAGE,
                BRANCHE = @BRANCHE
            WHERE NAME = @NAME;
            SELECT * FROM STUDENT WHERE NAME = @NAME;
        END
        ELSE
        BEGIN
            RAISERROR('STUDENT RECORD NOT FOUND', 16, 1);
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


CREATE TABLE College
(
CollegeID INT PRIMARY KEY NOT NULL,
STUDENTID INT FOREIGN  KEY REFERENCES STUDENT(STUDENTID),
CollegeNAME VARCHAR(100) NOT NULL,

);



CREATE OR ALTER PROCEDURE AddCollegeDetails
(
    @CollegeID INT,
    @STUDENTID INT,
    @CollegeNAME VARCHAR(100)
)
AS
BEGIN
    BEGIN TRY
        IF @CollegeID IS NULL OR @STUDENTID IS NULL OR @CollegeNAME IS NULL
        BEGIN
            RAISERROR('All parameters must be provided', 16, 1);
            RETURN;
        END
        IF NOT EXISTS (SELECT 1 FROM STUDENT WHERE STUDENTID = @STUDENTID)
        BEGIN
            RAISERROR('Student does not exist', 16, 1);
            RETURN;
        END
        INSERT INTO College (CollegeID, STUDENTID, CollegeNAME)
        VALUES (@CollegeID, @STUDENTID, @CollegeNAME);

        PRINT 'College details added successfully.';
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






CREATE OR ALTER PROCEDURE GetStudentWithCollege
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT s.STUDENTID, s.NAME, s.EMAIL, s.PHONENUMBER, s.COLLAGE, s.BRANCHE, c.CollegeNAME
        FROM STUDENT s
        INNER JOIN College c ON s.STUDENTID = c.STUDENTID;

    END TRY
    BEGIN CATCH
        -- Handle errors
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY(),
            @ErrorState = ERROR_STATE();

        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH;

    SET NOCOUNT OFF;
END;
exec GetStudentWithCollege





CREATE OR ALTER PROCEDURE GETALLCollege
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM College)
        BEGIN
            SELECT * FROM College;
        END
        ELSE
        BEGIN
          RAISERROR('No records found in the College table.',16,1);
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

check a detail using id, if exist edit or add new data.
