require 'spec_helper'
describe 'Piwik::Actions' do
  before {
    stub_api_calls
  }

  # TODO: Specify required params
  let(:params) { {:idSite => 1, :period => 'day', :date => 'yesterday'} }
  subject { Piwik::Actions }

  assert_data_integrity(:get, :size => 8)
  assert_data_integrity(:getDownloads, :size => 2)
  assert_data_integrity(:getPageTitles, :size => 8)
  assert_data_integrity(:getPageUrls, :size => 9)
  assert_data_integrity(:getEntryPageTitles, :size => 5)
  assert_data_integrity(:getEntryPageUrls, :size => 5)
  assert_data_integrity(:getExitPageTitles, :size => 5)
  assert_data_integrity(:getExitPageUrls, :size => 5)
end
