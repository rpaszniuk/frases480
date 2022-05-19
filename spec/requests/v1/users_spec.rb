require 'swagger_helper'

RSpec.describe 'v1/users', type: :request do
  # create account
  path '/v1/users' do
    post('Create Account') do
      tags 'Users'
      security [ApiKeyAuth: []]
      produces 'application/json'
      parameter name: :user, in: :formData, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: 'Email for new account' },
          first_name: { type: :string, description: 'First Name for new account' },
          last_name: { type: :string, description: 'Last Name for new account' },
          password: { type: :string, description: 'Password for new account' }
        },
        required: ['email password']
      }
      response(200, 'successful') do
        schema type: :object, properties: {
          token: { type: :string },
          user: { '$ref' => '#/components/schemas/User' }
        }
        run_test!
      end
    end
  end

  # sign in
  path '/v1/users/sign-in' do
    post('Sign In') do
      tags 'Users'
      description 'Signins existing users to app'
      # summary 'Users in the app'
      security [ApiKeyAuth: []]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: 'The account email address' },
          password: { type: :string, description: 'The account password' }
        },
        required: %w[email password]
      }
      response(200, 'successful') do
        schema type: :object, properties: {
          token: { type: :string },
          user: { '$ref' => '#/components/schemas/User' }
        }
        run_test!
      end
      response(422, 'unprocessable entity') do
        schema type: :object, properties: {
          errors: {
            type: :object,
            properties: {
              base: { type: :string }
            }
          }
        }
        run_test!
      end
    end
  end

  # update profile
  path '/v1/me' do
    put('Update profile') do
      tags 'Users'
      description 'Update existing users to app'
      # summary 'Users in the app'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string, description: 'Email' },
          first_name: { type: :string, description: 'First Name' },
          last_name: { type: :string, description: 'Last Name' },
          password: { type: :string, description: 'Password' }

        },
        required: %w[email password]
      }
      response(200, 'successful') do
        schema type: :object, properties: {
          token: { type: :string },
          user: { '$ref' => '#/components/schemas/User' }
        }
        run_test!
      end
      response(422, 'unprocessable entity') do
        schema type: :object, properties: {
          errors: {
            type: :object,
            properties: {
              base: { type: :string }
            }
          }
        }
        run_test!
      end
    end
  end

  # view profile
  path '/v1/me' do
    get('View profile') do
      tags 'Users'
      description 'View logged in user'
      # summary 'Users in the app'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object, properties: {
          token: { type: :string },
          user: { '$ref' => '#/components/schemas/User' }
        }
        run_test!
      end
      response(422, 'unprocessable entity') do
        schema type: :object, properties: {
          errors: {
            type: :object,
            properties: {
              base: { type: :string }
            }
          }
        }
        run_test!
      end
    end
  end
end
