# frozen_string_literal: true

require 'dotenv/load'
require 'fast_jsonapi'
require 'logger'
require 'require_all'
require 'xmlhasher'
require 'bunny'

require_all 'helpers/**/*.rb'
require_all 'models/**/*.rb'
require_all 'serializers/**/*.rb'
require_all 'services/**/*.rb'
