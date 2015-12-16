require 'spec_helper'

describe Search do

  it 'simple search with spaces' do
    search = Search.new '    '
    search.process

    expect(search.results).to eq(nil)
  end

  it 'simple search witout results' do
    search = Search.new 'simple search'
    search.process

    expect(search.results.size).to eq(0)
  end

  it 'simple search common case' do
    search = Search.new 'Lisp Common'
    search.process

    expect(search.results.size).to eq(1)
  end

  it 'simple search with match on diferent fields' do
    search = Search.new 'Scripting Microsoft'
    search.process
    expect(search.results.size).to eq(3)
  end

  it 'simple search without camelcase' do
    search = Search.new 'scripting microsoft'
    search.process
    expect(search.results.size).to eq(3)
  end

  it 'Exact search' do
    search = Search.new 'Interpreted "Thomas Eugene"'
    search.process

    expect(search.results.size).to eq(1)

  end

  it 'Negative search' do
    search = Search.new 'john -array'
    search.process
    expect(search.results.size).to eq(4)
  end

  it 'Negative search camelcase' do
    search = Search.new 'John -Array'
    search.process
    expect(search.results.size).to eq(4)
  end
end

