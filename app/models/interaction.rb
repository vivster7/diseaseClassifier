class Interaction < ActiveRecord::Base
  has_many :gene_relations
  has_many :genes, through: :gene_relations
  private
    def self.initInteractionDB
      Gene.all.each do |gene|
        url = 'http://webservice.thebiogrid.org/interactions?searchNames=true&searchSynonyms=true&interSpeciesExcluded=true&throughputTag=all&selfInteractionsExcluded=true&includeInteractors=true&includeInteractorInteractions=false&taxId=9606&accesskey=58f21b520918a4ea4a69d6df0c745523&format=JSON&geneList='
        url = url + gene.name
        response = JSON.parse(Curl.get(url).body_str)

        unless response == '[]'
          keys = response.collect { |i| i[0] }
          keys.each do |key|
            gene1 = response[key]['OFFICIAL_SYMBOL_A']
            gene2 = response[key]['OFFICIAL_SYMBOL_B']
            name = [gene1, gene2].sort().join("_")
            i = Interaction.find_or_create_by(name: name)
            i.update_attribute(:count, i.count.to_i.succ)
          end
        end

      end
    end

end
