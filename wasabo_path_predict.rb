Plugin.define do
  name "wasabo_path_predict"
  authors [
    "Beichen Xie <beichen@chalmers.se>" # v0.1
  ]
  version "0.1"
  description "WASABO-style path prediction to detect hidden admin/login routes."
  website "http://localhost:8080/"

  require 'json'

  passive do
    m = []
    begin
      output = `python path_predictor.py "#{@base_uri}" 2>/dev/null`

      # More robustly extract the JSON line
      json_str = output.lines.find { |line| line.strip.start_with?('{') && line.strip.end_with?('}') }
      data = JSON.parse(json_str) rescue nil

      if data && data["found_paths"] && !data["found_paths"].empty?
        m << {
          :name => "WASABO Path Predictor",
          :string => "Hidden paths: #{data["found_paths"].join(', ')}",
          :certainty => 100
        }
      else
        m << {
          :name => "WASABO Path Predictor",
          :string => "No hidden paths found",
          :certainty => 75
        }
      end
    rescue => e
      m << {
        :name => "WASABO Path Predictor",
        :error => "Plugin error: #{e.message}"
      }
    end
    m
  end
end
