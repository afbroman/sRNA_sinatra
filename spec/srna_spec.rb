require File.dirname(__FILE__) + '/../lib/srna.rb'

describe 'Load Genomes' do
  
  it 'should load the genomes sorted from external file' do
    actual_genomes = SRNA.load_genomes

    actual_genomes[0][0].should eq("NC_014248")
    actual_genomes[-1][0].should eq("NC_015716")
  end

end

describe 'Look up soi_size' do
  
  it 'should look up the soi_size from external ORF file' do
    actual_soi_size = SRNA.find_soi_size("NC_014248")
    actual_soi_size.should eq("5354700")
  end

end