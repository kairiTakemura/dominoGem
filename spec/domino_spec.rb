#require 'spec_helper'
require 'Domino'

describe Domino do
  context 'copy' do
    it {
      expect(Domino.hello).to eq(File.open("copy.jpg", "r"))
    }
  end
end

