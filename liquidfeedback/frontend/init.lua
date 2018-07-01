-- ========================================================================
-- DO NOT CHANGE ANYTHING IN THIS FILE
-- (except when you really know what you are doing!)
-- ========================================================================

if not config.database then
  config.database = { engine='postgresql', dbname='liquid_feedback' }
end

config.port = 2812

config.localhost = false

execute.config("config")
