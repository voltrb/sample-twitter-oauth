# Place any code you want to run when the component is included on the client
# or server.

# To include code only on the client use:
# if RUBY_PLATFORM == 'opal'
#
# To include code only on the server, use:
# unless RUBY_PLATFORM == 'opal'
# ^^ this will not send compile in code in the conditional to the client.
# ^^ this include code required in the conditional.

if RUBY_PLATFORM != 'opal'
  Volt.current_app.middleware.use OmniAuth::Builder do
    provider :twitter, "bOCaxfsEW7D9tQ7WtfxRpNZBd", "kOwm3HSbjFPJQC4MYf8mId7gRCrlqWadT4ZQFTLg7VwwYy0rWQ"
  end
end