Plugin.define do
  name "wasabo_detect_wordpress"
  authors [
    "Beichen Xie <beichen@chalmers.se>" # v0.1 # 2024-05-27
  ]
  version "0.1"
  description "Uses Puppeteer to inspect final rendered DOM and detect WordPress-specific patterns."
  website "http://localhost/"

  require 'json'

  passive do
    m = []

    begin
      output = `node /Users/xiebeichen/Downloads/TDA602/WhatWeb/detect-wordpress.js "#{@base_uri}" 2>/dev/null`
      matches = output.scan(/❗ Found indicator: (.+)/)

      if matches.any?
        indicators = matches.flatten
        m << { :string => "WASABO WP DOM Indicators: #{indicators.join(', ')}" }
      else
        m << { :string => "WASABO WP DOM Scan: No obvious indicators found" }
      end
    rescue => e
      m << { :error => "WASABO detect_wordpress error: #{e.message}" }
    end

    m
  end
end