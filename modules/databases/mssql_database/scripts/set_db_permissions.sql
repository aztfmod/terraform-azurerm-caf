:on error exit

DECLARE @dbusernames VARCHAR(300), @username VARCHAR(100), @create_user_cmd VARCHAR(200), @check_user_cmd VARCHAR(200)
DECLARE @dbroles VARCHAR(100), @dbrolename VARCHAR(100), @alter_role_cmd VARCHAR(100)

-- to be passed from sqlcmd -v
SET @dbusernames = $(DBUSERNAMES)

  WHILE len(@dbusernames) > 0
  BEGIN
    SET @username = left(@dbusernames, charindex(',', @dbusernames+',')-1)

    SET @create_user_cmd='CREATE USER [' + @username + '] FROM EXTERNAL PROVIDER'

    -- User creation
    IF NOT EXISTS (SELECT NAME FROM sys.database_principals WHERE NAME = @username)
      BEGIN
        EXEC(@create_user_cmd);
        PRINT 'User ' + @username + ' created.';
      END
    ELSE
      PRINT 'User ' + @username + ' already exist.';

    -- Role assignment
    SET @dbroles = $(DBROLES)
    WHILE len(@dbroles) > 0
      BEGIN
        SET @dbrolename = left(@dbroles, charindex(',', @dbroles + ',')-1)
        SET @alter_role_cmd = 'ALTER ROLE ' + @dbrolename + ' ADD MEMBER [' + @username + ']'

        EXEC(@alter_role_cmd)
        PRINT 'Added role ' +@dbrolename + ' to user ' + @username
        SET @dbroles = stuff(@dbroles, 1, charindex(',', @dbroles+','), '')

      END

    SET @dbusernames = stuff(@dbusernames, 1, charindex(',', @dbusernames+','), '')
  END

