# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload' do
  watch(%r{source/.+\.(erb|haml|slim)})

  watch(%r{source/javascripts/\w+(.+\.(coffee|js)).*}) { |m| "/javascripts/all.js" }

  watch(%r{source/stylesheets/\w+(.+\.(css|sass)).*}) { |m| "/stylesheets/all.css" }
end
