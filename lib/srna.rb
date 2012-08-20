require "sinatra/base"

class SRNA < Sinatra::Base

  before '/result' do
    content_type :txt
  end

  get '/' do
    @genomes = SRNA.load_genomes
    erb :index
  end
  
  post '/result' do
    # erb :result
    # attachment 'sRNAPredict.in'
    build_output_file params[:genome]

    # Construct config file
    # Offer config file as attachment (see sinatra book p 44)
  end

  def self.load_genomes
    genomes = Array.new  
    File.open(File.dirname(__FILE__) + '/db/genomes.txt').each do |row|  
      genomes << row.chomp.split('#')
    end  

    # Remove the first three metadata lines and sort by name (second item in each internal array)
    genomes.drop(3).sort do |a, b|
      comp = a[1].downcase <=> b[1].downcase
      comp.zero? ? (a[2].downcase <=> b[2].downcase) : comp
    end
  end  

  def self.find_soi_size(soi_num)
    
    line = File.open(File.dirname(__FILE__) + "/db/ORF/Out_ORF_#{soi_num}", &:readline)
    if (line =~ /\-\.\.(.*)$/)
      Regexp.last_match(1)
    end

  end


  def build_output_file(genome)
    output_file = ""

    output_file << "Accession number: \t\t\t #{genome}\n"
    output_file << "Genome file: \t\t\t #{genome}.fna\n"
    output_file << "FFN file: \t\t\t #{genome}.ffn\n"
    output_file << "BLAST: \t\t\t BLAST_sorted.out\n"

    output_file << "MinScore: \t\t\t #{params[:MIN_SCORE]}\n"
    output_file << "MaxE: \t\t\t #{params[:MAX_E]}\n"
    output_file << "MinPid: \t\t\t #{params[:MIN_PID]}\n"
    output_file << "Include Partners: \t\t\t none\n"
    output_file << "Exclude Partners: \t\t\t none\n"

    output_file << "QRNA: \t\t\t #{genome}_QRNA.txt.all.CUTOFF0.ID[100:0].GC[100:0].gff\n"
    output_file << "QRFs('.ptt'): \t\t\t Out_ORF_#{genome}\n"
    output_file << "QRFs(non-'.ptt'): \t\t\t none\n"

    output_file << "t/r sRNAs: \t\t\t none\n"
    output_file << "RNAMotif: \t\t\t rnamotif.out\n"
    output_file << "TransTerm: \t\t\t transterm.out\n"
    output_file << "TermFinder: \t\t\t #{genome}_term_candidates_nonredund\n"
    output_file << "TFBS matrix file: \t\t\t none\n"

    output_file << "known sRNAs: \t\t\t All_known_sRNAs.txt\n"
    output_file << "Output File Name: \t\t\t #{genome}_sRNA.out\n"

    output_file << "chromosome size: \t\t\t $soi_size\n"
    output_file << "Term. from ORF Stop (sense) (1a): \t\t\t #{params[:ORF_STOP_SENSE]}\n"
    output_file << "Term. from ORF Stop (antisense) (1b): \t\t\t -50\n" # hardcoded ORF_STOP_ANTISENSE
    output_file << "Term. from ORF Start (sense): \t\t\t #{params[:ORF_START_SENSE]}\n"
    output_file << "Term. from ORF Start (antisense): \t\t\t -40\n" # hardcoded ORF_START_ANTISENSE
    output_file << "Prom./TF from QRF Start (2): \t\t\t #{params[:TF_FROM_ORF_START]}\n"
    output_file << "Terminator from Conservation End (3): \t\t\t #{params[:TERM_FROM_CONV_END]}\n"
    output_file << "Prom./TFBS from Conservation Start (4): \t\t\t 0\n" # hardcoded TFBS_FROM_CONV_START
    output_file << "sRNA from ORF Start (5): \t\t\t #{params[:SRNA_FROM_ORF_START]}\n"
    output_file << "sRNA from ORF End (6): \t\t\t #{params[:SRNA_FROM_ORF_END]}\n"
    output_file << "minimum length (7): \t\t\t #{params[:MIN_LEN]}\n"
    output_file << "maximum length (7): \t\t\t #{params[:MAX_LEN]}\n"
    output_file << "minimum TT confidence (8): \t\t\t #{params[:MIN_TT]}\n"
    output_file << "maximum RNAMotif score (9): \t\t\t #{params[:MAX_RNAM]}\n"
    output_file << "maximum FindTerm score (10): \t\t\t #{params[:MAX_FT]}\n"
    output_file << "max HSP length (11): \t\t\t #{params[:MAX_HSP]}\n"
    output_file << "minimum cons-term pcnt (12): \t\t\t #{params[:MIN_CONSTTERM]}\n"

    output_file


  end

end