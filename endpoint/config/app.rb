# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'dotenv/load'
require 'fast_jsonapi'
require 'logger'
require 'require_all'

require_all 'controllers/**/*.rb'
# require_all 'helpers/**/*.rb'
# require_all 'models/**/*.rb'
# require_all 'serializers/**/*.rb'
# require_all 'services/**/*.rb'
