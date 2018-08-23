-- Name of this instance, defaults to name of config file
-- ------------------------------------------------------------------------
config.instance_name = "Instance name"


-- Information about service provider (HTML)
-- ------------------------------------------------------------------------
config.app_service_provider = "Snake Oil<br/>10000 Berlin<br/>Germany"


-- A HTML formatted text the user has to accept while registering
-- ------------------------------------------------------------------------
config.use_terms = "<h1>Terms of Use</h1><p>Insert terms here</p>"


-- Checkbox(es) the user has to accept while registering
-- ------------------------------------------------------------------------
--[[
config.use_terms_checkboxes = {
  {
    name = "terms_of_use_v1",
    html = "I accept the terms of use.",
    not_accepted_error = "You have to accept the terms of use to be able to register."
  },
  {
    name = "extra_terms_of_use_v1",
    html = "I accept the extra terms of use.",
    not_accepted_error = "You have to accept the extra terms of use to be able to register."
  }
}
--]]


-- Absolute base url of application
-- ------------------------------------------------------------------------
config.absolute_base_url = "http://localhost:2812/"


-- Location of the rocketwiki binaries
-- ------------------------------------------------------------------------
config.formatting_engines = {
  { id = "markdown2",
    name = "Markdown",
    executable = "markdown2",
    args = {'-s', 'escape', '-x', 'nofollow,wiki-tables'},
    remove_images = true
  },
  { id = "rocketwiki",
    name = "RocketWiki",
    executable = "/opt/rocketwiki-lqfb/rocketwiki-lqfb"
  },
  { id = "compat",
    name = "Traditional WIKI syntax",
    executable = "/opt/rocketwiki-lqfb/rocketwiki-lqfb-compat"
  }
}


-- Public access level
-- ------------------------------------------------------------------------
-- Available options:
-- "none" 
--     -> Closed user group, no public access at all
--        (except login/registration/password reset)
-- "anonymous"
--     -> Shows only initiative/suggestions texts and aggregated
--        supporter/voter counts
-- "authors_pseudonymous" 
--     -> Like anonymous, but shows screen names of authors
-- "all_pseudonymous" 
--     -> Show everything a member can see, except profile pages
-- "everything"
--     -> Show everything a member can see, including profile pages
-- ------------------------------------------------------------------------
config.public_access = "none"



-- ========================================================================
-- OPTIONAL
-- Remove leading -- to use a option
-- ========================================================================

-- Disable registration
-- ------------------------------------------------------------------------
-- Available options:
-- false: registration is enabled (default)
-- true: registration is disabled
-- ------------------------------------------------------------------------
-- config.disable_registration = true


-- List of enabled languages, defaults to available languages
-- ------------------------------------------------------------------------
-- config.enabled_languages = { 'en', 'de', 'eo', 'el', 'hu', 'it', 'ka', 'nl', 'zh-Hans', 'zh-TW' }


-- Default language, defaults to "en"
-- ------------------------------------------------------------------------
-- config.default_lang = "en"


-- after how long is a user considered inactive and the trustee will see warning,
-- notation is according to postgresql intervals, default: no warning at all
-- ------------------------------------------------------------------------
-- config.delegation_warning_time = '6 months'


-- after which time a user is advised (_soft) or forced (_hard) to check
-- unit and area delegations. default: no check at all
-- ------------------------------------------------------------------------
-- config.check_delegations_interval_hard = "6 months"
-- config.check_delegations_interval_soft = "3 months"


-- default option when checking delegations
-- available options: "confirm", "revoke" and "none", default: "confirm"
-- ------------------------------------------------------------------------
-- config.check_delegations_default = "confirm"


-- Prefix of all automatic mails, defaults to "[Liquid Feedback] "
-- ------------------------------------------------------------------------
-- config.mail_subject_prefix = "[LiquidFeedback] "


-- Sender of all automatic mails, defaults to system defaults
-- ------------------------------------------------------------------------
-- config.mail_envelope_from = "liquidfeedback@example.com"
-- config.mail_from = { name = "LiquidFeedback", address = "liquidfeedback@example.com" }
-- config.mail_reply_to = { name = "Support", address = "support@example.com" }


-- Template for digest emails
-- #{name} will be replaced by member screen name
-- #{digest} will be replaced with the digest content
-- ------------------------------------------------------------------------
-- config.notification_digest_template = [[
-- Hello #{name},
-- 
-- this is your personal digest.
-- 
-- #{digest}
-- ]]


-- Configuration of password hashing algorithm (defaults to "crypt_sha512")
-- ------------------------------------------------------------------------
-- config.password_hash_algorithm = "crypt_sha512"
-- config.password_hash_algorithm = "crypt_sha256"
-- config.password_hash_algorithm = "crypt_md5"


-- Number of rounds for crypt_sha* algorithms, minimum and maximum
-- (defaults to minimum 10000 and maximum 20000)
-- ------------------------------------------------------------------------
-- config.password_hash_min_rounds = 10000
-- config.password_hash_max_rounds = 20000


-- Supply custom url for avatar/photo delivery
-- ------------------------------------------------------------------------
-- config.fastpath_url_func = nil


-- Local directory for database dumps offered for download
-- ------------------------------------------------------------------------
-- config.download_dir = nil


-- Special use terms for database dump download
-- ------------------------------------------------------------------------
-- config.download_use_terms = "=== Download use terms ===\n"


-- Use custom image conversion, defaults to ImageMagick's convert
-- ------------------------------------------------------------------------
--config.member_image_content_type = "image/jpeg"
--config.member_image_convert_func = {
--  avatar = function(data) return extos.pfilter(data, "convert", "jpeg:-", "-thumbnail",   "48x48", "jpeg:-") end,
--  photo =  function(data) return extos.pfilter(data, "convert", "jpeg:-", "-thumbnail", "240x240", "jpeg:-") end
--}


-- Display a html formatted public message of the day
-- ------------------------------------------------------------------------
-- config.motd_public = "<h1>Message of the day (public)</h1><p>The MOTD is formatted with HTML</p>"


-- Display a html formatted internal message of the day
-- ------------------------------------------------------------------------
-- config.motd_intern = "<h1>Message of the day (intern)</h1><p>The MOTD is formatted with HTML</p>"


-- Integration of Etherpad, disabled by default
-- ------------------------------------------------------------------------
--config.etherpad = {
--  base_url = "http://example.com:9001/",
--  api_base = "http://localhost:9001/",
--  api_key = "mysecretapikey",
--  group_id = "mygroupname",
--  cookie_path = "/"
--}


-- Free timings
-- ------------------------------------------------------------------------
-- This example expects a date string entered in the free timing field
-- by the user creating a poll, interpreting it as target date for then
-- poll and splits the remaining time at the ratio of 4:1:2
-- Please note, polling policies never have an admission phase
-- The available_func is optional, if not set any target date is allowed

--[[
config.free_timing = {
  calculate_func = function(policy, timing_string)
    local function interval_by_seconds(secs)
      local secs_per_day = 60 * 60 * 24
      local days
      days = math.floor(secs / secs_per_day)
      secs = secs - days * secs_per_day
      return days .. " days " .. secs .. " seconds"
    end
    local target_date = parse.date(timing_string, atom.date)
    if not target_date then
      return false
    end
    local target_timestamp = target_date.midday
    local now = atom.timestamp:get_current()
    trace.debug(target_timestamp, now)
    local duration = target_timestamp - now
    if duration < 0 then
      return false
    end
    return {
      discussion = interval_by_seconds(duration / 7 * 4),
      verification = interval_by_seconds(duration / 7 * 1),
      voting = interval_by_seconds(duration / 7 * 2)
    }
  end,
  available_func = function(policy)
    return { 
      { name = "End of 2013", id = '2013-12-31' },
      { name = "End of 2014", id = '2014-12-31' },
      { name = "End of 2015", id = '2015-12-31' }
    }
  end
}
--]]


-- External references
-- ------------------------------------------------------------------------
-- Rendering of external references

--[[
config.render_external_reference = {
  draft = function(draft, wrapper)
    wrapper(function()
      ui.tag{ content = draft.external_reference)
    end)
  end,
  initiative = function(initiative, wrapper)
    wrapper(function()
      ui.tag{ content = initiative.external_reference)
    end)
  end
end
--]]


-- Admin logger
-- ------------------------------------------------------------------------
-- Logging administrative activities
-- disabled by default

--[[
config.admin_logger = function(params)

  local adminid = app.session.member_id
  local adminname = app.session.member.name
  local url = params._webmcp_path
  
  -- do something (e.g. calling 'logger' via extos.pfilter)

end
--]]


-- Application server fork configuration
-- ------------------------------------------------------------------------
-- config.fork = {
--   pre = 2,            -- desired number of spare (idle) processes
--   min = 4,            -- minimum number of processes
--   max = 128,          -- maximum number of processes (hard limit)
--   delay = 0.125,      -- delay (seconds) between creation of spare processes
--   error_delay = 2,    -- delay (seconds) before retry of failed process creation
--   exit_delay = 2,     -- delay (seconds) between destruction of excessive spare processes
--   idle_timeout = 900, -- idle time (seconds) after a fork gets terminated (0 for no timeout)
--   memory_limit = 0,   -- maximum memory consumption (bytes) before process gets terminated
--   min_requests = 50,  -- minimum count of requests handled before fork is terminated
--   max_requests = 100  -- maximum count of requests handled before fork is terminated
-- }


-- HTTP server options
-- ------------------------------------------------------------------------
-- http_options = {
--   static_headers            = {}            -- string or table of static headers to be returned with every request
--   request_header_size_limit = 1024*1024,    -- maximum size of request body sent by client
--   request_body_size_limit   = 64*1024*1024, -- maximum size of request body sent by client
--   idle_timeout              = 65,           -- maximum time until receiving the first byte of the request headera
--   stall_timeout             = 60,           -- maximum time a client connection may be stalled
--   request_header_timeout    = 120,          -- maximum time until receiving the remaining bytes of the request header
--   response_timeout          = 3600,         -- time in which request body and response must be sent
--   maximum_input_chunk_size  = 16384         -- tweaks behavior of request-body parser
--   minimum_output_chunk_size = 1024          -- chunk size for chunked-transfer-encoding
-- }


-- Trace debug
-- ------------------------------------------------------------------------
-- uncomment the following line to enable debug trace
-- ------------------------------------------------------------------------
-- config.enable_debug_trace = true
