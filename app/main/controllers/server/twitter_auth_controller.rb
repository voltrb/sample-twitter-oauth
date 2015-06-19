module Main
  class TwitterAuthController < Volt::HttpController
    def index
      # Login into Twitter, copy in name, image, uid
      uid = auth_hash['uid']
      info = auth_hash['info']

      store.users.where(twitter_id: uid).first.then do |user|
        props = {name: info['name'], image_url: info['image']}
        if user
          # update user
          Volt.as_user(user) do
            user.assign_attributes(props)
          end
        else
          # no user found, create one
          user = store.users.create({twitter_id: uid}.merge(props))
        end

        # Pass user
        user
      end.then do |user|
        # update the user

        # Set the user_id cookie to the login signature
        cookies._user_id = {
          value: Volt.user_login_signature(user),
          expires: Time.at(Time.now.to_i + (60*60*24*365))
        }
      end.sync

      redirect_to '/'
    end

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
