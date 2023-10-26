require 'rails_helper'

RSpec.describe Survey, type: :model do
  it { is_expected.to have_db_column(:score).of_type(:integer) }
  it { is_expected.to have_db_column(:session_id).of_type(:string) }
end
