-- ========================================================================
-- MANDATORY (MUST BE CAREFULLY CHECKED AND PROPERLY SET!)
-- ========================================================================

-- Name of this instance, defaults to name of config file
-- ------------------------------------------------------------------------
config.instance_name = "Instance name"


-- Information about service provider (HTML)
-- ------------------------------------------------------------------------
config.app_service_provider = "Snake Oil<br/>10000 Berlin<br/>Germany"


-- A HTML formatted text the user has to accept while registering
-- ------------------------------------------------------------------------
config.use_terms = "<h1>Terms of Use</h1><p>Insert terms here</p>"


-- Absolute base url of application
-- ------------------------------------------------------------------------
config.absolute_base_url = "http://localhost:2812/"


-- Connection information for the LiquidFeedback database
-- ------------------------------------------------------------------------
config.database = { engine='postgresql', host='postgres', user='liquid_feedback', password='liquid_feedback', dbname='liquid_feedback' }


-- Location of the rocketwiki binaries
-- ------------------------------------------------------------------------
config.enforce_formatting_engine = "markdown2"
config.formatting_engines = {
  { id = "markdown2",
    name = "python-markdown2",
    executable = "markdown2",
    args = {'-s', 'escape', '-x', 'nofollow,wiki-tables'},
    remove_images = true
  },
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


-- Trace debug
-- ------------------------------------------------------------------------
-- uncomment the following line to enable debug trace
-- ------------------------------------------------------------------------
config.enable_debug_trace = true
