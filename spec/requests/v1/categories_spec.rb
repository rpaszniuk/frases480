require 'rails_helper'

RSpec.describe 'v1/categories', type: :request do
  path '/v1/categories' do
    get('List all Categories') do
      tags 'Categories'
      security [ApiKeyAuth: []]
      produces 'application/json'
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { type: :array, items: { '$ref' => '#/components/schemas/Category' } }
        }
        run_test!
      end
    end
  end

  path '/v1/categories/{id}' do
    get('List all phrases for the given category') do
      tags 'Categories'
      security [ApiKeyAuth: []]
      produces 'application/json'
      parameter name: :id, in: :path, schema: {
        id: { type: :integer, description: 'The id of the category' }
      }
      response(200, 'successful') do
        schema type: :object, properties: {
          data: { type: :array, items: { '$ref' => '#/components/schemas/Phrase' } }
        }
        run_test!
      end
    end
  end
end
