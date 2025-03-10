:on error exit

DECLARE @dbusernames VARCHAR(300)
DECLARE @username VARCHAR(100)
DECLARE @create_user_cmd NVARCHAR(MAX)
DECLARE @dbroles VARCHAR(100)
DECLARE @add_role_cmd NVARCHAR(MAX)

SET @dbusernames = '$(DBUSERNAMES)'
SET @dbroles = '$(DBROLES)'
                    
  WHILE len(@dbusernames) > 0
  BEGIN
    SET @username = left(@dbusernames, charindex(',', @dbusernames+',')-1)
    IF NOT EXISTS (SELECT NAME FROM sys.database_principals WHERE name = @username)
    BEGIN
        SET @create_user_cmd = N'CREATE USER [' + @username + '] FROM LOGIN [' + @username + '];'
        EXEC sp_executesql @create_user_cmd
        PRINT 'User created: ' + @username

        -- Add user to the specified role
        SET @add_role_cmd = N'ALTER ROLE [' + @dbroles + '] ADD MEMBER [' + @username + '];'
        EXEC sp_executesql @add_role_cmd
        PRINT 'User ' + @username + ' added to role: ' + @dbroles        
    END
    ELSE
    BEGIN
        PRINT 'User already exists: ' + @username
    END
    SET @dbusernames = stuff(@dbusernames, 1, charindex(',', @dbusernames+','), '')    
  END