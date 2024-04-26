#   # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
#   # # Defines the root path route ("/")
#   # # root "articles#index"
#                                  Prefix Verb   URI Pattern                                                                                       Controller#Action
#                         new_user_session GET    /users/sign_in(.:format)                                                                          devise/sessions#new
#                             user_session POST   /users/sign_in(.:format)                                                                          devise/sessions#create
#                     destroy_user_session DELETE /users/sign_out(.:format)                                                                         devise/sessions#destroy
#                        new_user_password GET    /users/password/new(.:format)                                                                     devise/passwords#new
#                       edit_user_password GET    /users/password/edit(.:format)                                                                    devise/passwords#edit
#                            user_password PATCH  /users/password(.:format)                                                                         devise/passwords#update
#                                          PUT    /users/password(.:format)                                                                         devise/passwords#update
#                                          POST   /users/password(.:format)                                                                         devise/passwords#create
#                 cancel_user_registration GET    /users/cancel(.:format)                                                                           devise/registrations#cancel
#                    new_user_registration GET    /users/sign_up(.:format)                                                                          devise/registrations#new
#                   edit_user_registration GET    /users/edit(.:format)                                                                             devise/registrations#edit
#                        user_registration PATCH  /users(.:format)                                                                                  devise/registrations#update
#                                          PUT    /users(.:format)                                                                                  devise/registrations#update
#                                          DELETE /users(.:format)                                                                                  devise/registrations#destroy
#                                          POST   /users(.:format)                                                                                  devise/registrations#create
#                     new_api_user_session GET    /api/auth/sign_in(.:format)                                                                       devise_token_auth/sessions#new
#                         api_user_session POST   /api/auth/sign_in(.:format)                                                                       devise_token_auth/sessions#create
#                 destroy_api_user_session DELETE /api/auth/sign_out(.:format)                                                                      devise_token_auth/sessions#destroy
#                    new_api_user_password GET    /api/auth/password/new(.:format)                                                                  devise_token_auth/passwords#new
#                   edit_api_user_password GET    /api/auth/password/edit(.:format)                                                                 devise_token_auth/passwords#edit
#                        api_user_password PATCH  /api/auth/password(.:format)                                                                      devise_token_auth/passwords#update
#                                          PUT    /api/auth/password(.:format)                                                                      devise_token_auth/passwords#update
#                                          POST   /api/auth/password(.:format)                                                                      devise_token_auth/passwords#create
#             cancel_api_user_registration GET    /api/auth/cancel(.:format)                                                                        devise_token_auth/registrations#cancel
#                new_api_user_registration GET    /api/auth/sign_up(.:format)                                                                       devise_token_auth/registrations#new
#               edit_api_user_registration GET    /api/auth/edit(.:format)                                                                          devise_token_auth/registrations#edit
#                    api_user_registration PATCH  /api/auth(.:format)                                                                               devise_token_auth/registrations#update
#                                          PUT    /api/auth(.:format)                                                                               devise_token_auth/registrations#update
#                                          DELETE /api/auth(.:format)                                                                               devise_token_auth/registrations#destroy
#                                          POST   /api/auth(.:format)                                                                               devise_token_auth/registrations#create
#                  api_auth_validate_token GET    /api/auth/validate_token(.:format)                                                                devise_token_auth/token_validations#validate_token
#                   own_posts_api_v1_posts GET    /api/v1/posts/own_posts(.:format)                                                                 api/v1/posts#own_posts
#                 liked_posts_api_v1_posts GET    /api/v1/posts/liked_posts(.:format)                                                               api/v1/posts#liked_posts
#            list_posts_by_tag_api_v1_post GET    /api/v1/posts/:id/list_posts_by_tag(.:format)                                                     api/v1/posts#list_posts_by_tag
#                      search_api_v1_posts GET    /api/v1/posts/search(.:format)                                                                    api/v1/posts#search
#                             api_v1_posts GET    /api/v1/posts(.:format)                                                                           api/v1/posts#index
#                                          POST   /api/v1/posts(.:format)                                                                           api/v1/posts#create
#                              api_v1_post GET    /api/v1/posts/:id(.:format)                                                                       api/v1/posts#show
#                                          PATCH  /api/v1/posts/:id(.:format)                                                                       api/v1/posts#update
#                                          PUT    /api/v1/posts/:id(.:format)                                                                       api/v1/posts#update
#                                          DELETE /api/v1/posts/:id(.:format)                                                                       api/v1/posts#destroy
#           show_current_user_api_v1_users GET    /api/v1/users/show_current_user(.:format)                                                         api/v1/users#show_current_user
#                              api_v1_user PATCH  /api/v1/users/:id(.:format)                                                                       api/v1/users#update
#                                          PUT    /api/v1/users/:id(.:format)                                                                       api/v1/users#update
#                             api_v1_likes POST   /api/v1/likes(.:format)                                                                           api/v1/likes#create
#                              api_v1_like DELETE /api/v1/likes/:id(.:format)                                                                       api/v1/likes#destroy
#            rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
#               rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
#            rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
#      rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
#            rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
#             rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
#           rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
#                                          POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
#            rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
#                                          PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#update
#                                          DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#destroy
# new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
#    rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
#    rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
# rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
#                       rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
#                 rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
#                                          GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
#                rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
#          rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
#                                          GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
#                       rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
#                update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
#                     rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create

Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :posts do
        get 'own_posts', on: :collection
        get 'liked_posts', on: :collection     
        get 'search', on: :collection
        get 'list_posts_by_tag', on: :member
      end
      resources :users, only: [:update] do
        get 'show_current_user', on: :collection     
      end
      resources :likes, only: [:create, :destroy] do
      end
    end
  end
end
