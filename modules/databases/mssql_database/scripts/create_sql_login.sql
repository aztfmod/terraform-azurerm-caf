:on error exit

DECLARE @dbusernames VARCHAR(300)
DECLARE @dbuserpwds VARCHAR(300)
DECLARE @username VARCHAR(100)
DECLARE @userpwd VARCHAR(MAX)
DECLARE @create_login_cmd NVARCHAR(MAX)

SET @dbusernames = '$(DBUSERNAMES)'
SET @dbuserpwds = '$(DBUSERPASSWORDS)'

WHILE len(@dbusernames) > 0 AND len(@dbuserpwds) > 0
BEGIN
    SET @username = left(@dbusernames, charindex(',', @dbusernames+',')-1)
    SET @userpwd = left(@dbuserpwds, charindex(',', @dbuserpwds+',')-1)
    
    IF NOT EXISTS (SELECT NAME FROM sys.sql_logins WHERE name = @username)
    BEGIN
        SET @create_login_cmd = N'CREATE LOGIN [' + @username + '] WITH PASSWORD = ''' + @userpwd + ''''
        EXEC sp_executesql @create_login_cmd
        PRINT 'Login created: ' + @username
    END
    ELSE
    BEGIN
        PRINT 'Login already exists: ' + @username
    END
    
    SET @dbusernames = stuff(@dbusernames, 1, charindex(',', @dbusernames+','), '')
    SET @dbuserpwds = stuff(@dbuserpwds, 1, charindex(',', @dbuserpwds+','), '')
END

IF len(@dbusernames) > 0 OR len(@dbuserpwds) > 0
BEGIN
    PRINT 'Warning: Mismatch in number of usernames and passwords'
END
