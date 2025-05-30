Plugin.define do
  name "wasabo_cache_buster"
  authors [
    "Beichen Xie <beichen@chalmers.se>" # v0.1 # 2025-05-18
  ]
  version "0.1"
  description "Attempts cache-busting on suspected static resources to detect responsive assets and uncover potential fingerprinting vectors."
  website "http://localhost/"

  require 'json'

  passive do
    m = []

    begin
      output = `python cache_buster.py "#{@base_uri}" 2>/dev/null`
      lines = output.lines.select { |line| line.strip.start_with?("[") }

      if lines.any?
        summary = lines.map(&:strip).join("; ")
        m << { :string => "WASABO Cache Buster: #{summary}" }
      else
        m << { :string => "WASABO Cache Buster: No responsive assets detected" }
      end
    rescue => e
      m << { :error => "WASABO cache_buster error: #{e.message}" }
    end

    m
  end
end
