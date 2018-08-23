-- ========================================================================
-- DO NOT CHANGE ANYTHING IN THIS FILE
-- It will be overwritten on next startup!
-- ========================================================================

execute.config("custom_config")

config.database = {
  engine='postgresql',
  host='__POSTGRES_HOST__',
  user='__POSTGRES_USER__',
  password='__POSTGRES_PASSWORD__',
  dbname='__POSTGRES_DB__'
}

config.port = 2812
config.localhost = false
