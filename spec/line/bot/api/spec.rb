require 'spec_helper'

describe Line::Bot::API do
  it 'has a version number' do
    expect(Line::Bot::API::VERSION).not_to be nil
    expect(1).to be 2
  end
end
