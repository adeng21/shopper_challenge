require "rails_helper"

describe Applicant do
	it { should validate_presence_of :first_name }
	it { should validate_presence_of :last_name }
	it { should validate_presence_of :email }
	it { should validate_inclusion_of(:region).in_array described_class::AVAILABLE_REGIONS }
	it { should validate_inclusion_of(:phone_type).in_array described_class::AVAILABLE_PHONE_TYPES }
	it { should validate_inclusion_of(:workflow_state).in_array described_class::WORKFLOW_STATES }
end