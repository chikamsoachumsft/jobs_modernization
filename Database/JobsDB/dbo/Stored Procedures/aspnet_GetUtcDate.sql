
CREATE PROCEDURE [dbo].aspnet_GetUtcDate
    @TimeZoneAdjustment INT,
    @DateNow            DATETIME OUTPUT
AS
BEGIN
    SELECT @DateNow = GETUTCDATE()
END
                                                                                                                                                                                                                                                 