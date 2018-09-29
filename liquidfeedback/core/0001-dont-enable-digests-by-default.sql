BEGIN;

-- don't enable digests by default
ALTER TABLE "member" ALTER "notification_hour" DROP DEFAULT;

COMMIT;
