# frozen_string_literal: true

require 'dotenv/load'
require 'fast_jsonapi'
require 'logger'
require 'require_all'
require 'xmlhasher'
require 'bunny'
require 'redis'
require 'debug'

require_all 'services/**/*.rb'
