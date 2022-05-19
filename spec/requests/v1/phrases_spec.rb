require 'rails_helper'

RSpec.describe 'v1/phrases', type: :request do
  path '/v1/phrases' do
    get('List all Phrases') do
      tags 'Phrases'
      security [ApiKeyAuth: []]
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { type: :array, items: { '$ref' => '#/components/schemas/Phrase' } }
        }
        run_test!
      end
    end
  end

  path '/v1/phrases/{id}' do
    get('Get phrase by id') do
      tags 'Phrases'
      security [ApiKeyAuth: []]
      produces 'application/json'
      parameter name: :id, in: :path, schema: {
        id: { type: :integer, description: 'The id of the category' }
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
