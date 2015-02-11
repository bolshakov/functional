include Functional

RSpec.describe Success do
  let(:value) { 42 }

  subject(:success) { Success(value) }

  specify '#get returns value' do
    val = success.get
    expect(val).to eq value
  end

  specify '#get_or_else returns value' do
    default = 13
    val = success.get_or_else(default)

    expect(val).to eq value
  end

  specify '#or_else returns success' do
    default = Try { 13 }
    val = success.or_else(default)

    expect(val).to eq success
  end

  specify '#to_option returns Some' do
    option = success.to_option
    expect(option).to eq Some(value)
  end

  specify '#each applies given block' do
    expect do |block|
      success.each(&block)
    end.to yield_with_args(value)
  end
end
