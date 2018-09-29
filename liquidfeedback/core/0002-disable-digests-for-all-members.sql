BEGIN;

-- disable digests for all members
UPDATE "member" SET
"notification_dow" = NULL,
"notification_hour" = NULL;

COMMIT;
