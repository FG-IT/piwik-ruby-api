require 'spec_helper'
describe 'Piwik::UsersFlow' do
  before {
    stub_api_calls
  }

  # TODO: Specify required params
  let(:params) { {:idSite => 1, :period => 'day', :date => 'yesterday'} }
  subject { Piwik::UsersFlow }

  describe "#get_users_flow_pretty" do
    assert_data_integrity(:get_users_flow_pretty)
  end

  describe "#get_users_flow" do
    assert_data_integrity(:get_users_flow)
  end

  describe "#get_interaction_actions" do
    assert_data_integrity(:get_interaction_actions)
  end

  describe "#get_available_data_sources" do
    assert_data_integrity(:get_available_data_sources)
  end
end
