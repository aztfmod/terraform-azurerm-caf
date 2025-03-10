:on error exit

DECLARE @dbusernames VARCHAR(300)
DECLARE @username VARCHAR(100)
DECLARE @delete_login_cmd NVARCHAR(MAX)

SET @dbusernames = '$(DBUSERNAMES)'

PRINT 'Logins: ' + @dbusernames

WHILE len(@dbusernames) > 0
BEGIN
    SET @username = left(@dbusernames, charindex(',', @dbusernames+',')-1)  
    
    IF EXISTS (SELECT NAME FROM sys.sql_logins WHERE name = @username)
    BEGIN
        SET @delete_login_cmd = N'DROP LOGIN [' + @username + ']'
        EXEC sp_executesql @delete_login_cmd
        PRINT 'Login deleted: ' + @username
    END
    ELSE
    BEGIN
        PRINT 'Login already deleted: ' + @username
    END
    
    SET @dbusernames = stuff(@dbusernames, 1, charindex(',', @dbusernames+','), '')    
END

