# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      validatorUrl: 'none',
      openapi: '3.0.1',
      info: {
        title: 'Frases480 API',
        version: 'v1',
        description: 'Frases480\'s API - V1'
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: Newfrases480::Application.credentials.api_host
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          BearerAuth: {
            type: :http,
            scheme: :bearer
          },
          ApiKeyAuth: {
            type: :apiKey,
            name: 'X-Application-Secret',
            in: :header
          }
        },
        schemas: {
          ModelErrors: {
            type: :object,
            properties: {
              errors: {
                type: :object,
                properties: {
                  base: { type: :array, items: { type: :string } }
                }
              }
            }
          },
          User: {
            type: :object,
            properties: {
              id: { type: :integer },
              email: { type: :string },
              password: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string },
              status: { type: :string, description: 'User status', enum: %w[active blocked deleted] }
            },
            required: %w[email password first_name last_name]
          },
          Category: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              slug: { type: :string, description: "Category's slug" },
              status: { type: :string, description: 'Category status', enum: %w[active inactive deleted] }
            },
            required: %w[name description slug]
          },
          Phrase: {
            type: :object,
            properties: {
              id: { type: :integer },
              phrase: { type: :string },
              slug: { type: :string, description: "Phrase's slug" },
              category: { '$ref' => '#/components/schemas/Category' },
              user: { '$ref' => '#/components/schemas/User' },
              status: { type: :string, description: 'Phrase status', enum: %w[active pending rejected deleted] }
            },
            required: %w[phrase slug]
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
