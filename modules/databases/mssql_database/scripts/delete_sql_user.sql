:on error exit

DECLARE @dbusernames VARCHAR(300)
DECLARE @username VARCHAR(100)
DECLARE @delete_user_cmd NVARCHAR(MAX)

SET @dbusernames = '$(DBUSERNAMES)'                  

  WHILE len(@dbusernames) > 0
  BEGIN
    SET @username = left(@dbusernames, charindex(',', @dbusernames+',')-1)
    IF EXISTS (SELECT NAME FROM sys.database_principals WHERE name = @username)
    BEGIN
        SET @delete_user_cmd = N'DROP USER [' + @username + '];'
        EXEC sp_executesql @delete_user_cmd
        PRINT 'User deleted: ' + @username
    END
    ELSE
    BEGIN
        PRINT 'User already deleted: ' + @username
    END
    SET @dbusernames = stuff(@dbusernames, 1, charindex(',', @dbusernames+','), '')
  END