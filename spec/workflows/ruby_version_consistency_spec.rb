require 'yaml'

RSpec.describe "GitHub Actions workflow Ruby version consistency" do
  let(:workflows_dir) { File.expand_path('../../.github/workflows', __dir__) }

  let(:latest_matrix_version) do
    pr_workflow = YAML.safe_load(
      File.read(File.join(workflows_dir, 'pull_request.yml')),
      permitted_classes: [Symbol]
    )
    versions = pr_workflow.dig('jobs', 'build', 'strategy', 'matrix', 'ruby')
    expect(versions).not_to be_nil, "No ruby matrix found in pull_request.yml"
    versions.map(&:to_s).max_by { |v| Gem::Version.new(v) }
  end

  let(:hardcoded_ruby_versions) do
    versions = {}

    Dir[File.join(workflows_dir, '*.yml')].each do |file|
      workflow = YAML.safe_load(File.read(file), permitted_classes: [Symbol])
      basename = File.basename(file)

      next unless workflow['jobs']

      workflow['jobs'].each do |job_name, job|
        steps = job['steps'] || []
        steps.each do |step|
          next unless step.is_a?(Hash) && step.dig('with', 'ruby-version')

          ruby_version = step['with']['ruby-version'].to_s
          next if ruby_version.include?('${{')

          versions["#{basename} -> #{job_name}"] = ruby_version
        end
      end
    end

    versions
  end

  it "uses the same Ruby version as the latest in pull_request.yml matrix" do
    expect(hardcoded_ruby_versions).not_to(
      be_empty, "No hardcoded ruby-version found in workflows"
    )

    mismatched = hardcoded_ruby_versions.reject { |_, v| v == latest_matrix_version }
    expect(mismatched).to(
      be_empty,
      "Expected all hardcoded ruby-version to be '#{latest_matrix_version}' " \
      "(latest in pull_request.yml matrix), but found:\n" \
      "#{mismatched.map { |k, v| "  #{k}: #{v}" }.join("\n")}"
    )
  end
end
