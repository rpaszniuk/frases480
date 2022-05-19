require 'rails_helper'

RSpec.describe 'v1/me/phrases', type: :request do
  path '/v1/me/phrases' do
    get('List all user phrases') do
      tags 'Phrases'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { type: :array, items: { '$ref' => '#/components/schemas/Phrase' } }
        }
        run_test!
      end
    end
  end

  # delete a phrase
  path '/v1/me/phrases/{id}' do
    delete('Delete a user phrase') do
      tags 'Phrases'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, schema: {
        id: { type: :integer, description: 'The id of the phrase' }
      }
      response(204, 'no content') do
        run_test!
      end
    end
  end

  # create a phrase
  path '/v1/me/phrases' do
    post('Create a user phrase') do
      tags 'Phrases'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { '$ref' => '#/components/schemas/Phrase' }
        }
        run_test!
      end
    end
  end

  # update a phrase
  path '/v1/me/phrases/{id}' do
    put('Update a user phrase') do
      tags 'Phrases'
      security [{ ApiKeyAuth: [], BearerAuth: [] }]
      produces 'application/json'
      parameter name: :id, in: :path, schema: {
        id: { type: :integer, description: 'The id of the phrase' }
      }
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { '$ref' => '#/components/schemas/Phrase' }
        }
        run_test!
      end
    end
  end
end
