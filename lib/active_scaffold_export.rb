# Make sure that ActiveScaffold has already been included
ActiveScaffold rescue throw "should have included ActiveScaffold plug in first.  Please make sure that this plug-in comes alphabetically after the ActiveScaffold plug-in"

# Load our overrides
require "#{File.dirname(__FILE__)}/active_scaffold_export/config/core.rb"
require "#{File.dirname(__FILE__)}/active_scaffold/config/export.rb"
require "#{File.dirname(__FILE__)}/active_scaffold/actions/export.rb"
require "#{File.dirname(__FILE__)}/active_scaffold/helpers/view_helpers_override.rb"
require "#{File.dirname(__FILE__)}/active_scaffold/helpers/export_helpers.rb"

##
## Run the install script, too, just to make sure
## But at least rescue the action in production
##
Rails::Application.initializer("active_scaffold_export_install_assets") do
  begin
    require File.dirname(__FILE__) + '/../install'
  rescue
    raise $! unless Rails.env == 'production'
  end
end

# Register our helper methods
ActionView::Base.send(:include, ActiveScaffold::Helpers::ExportHelpers)