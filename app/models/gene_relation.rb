class GeneRelation < ActiveRecord::Base
  belongs_to :gene
  belongs_to :interaction

  private
    def self.populateGeneRelation
      Interaction.all.each do |interaction| 
        gene1, gene2 = interaction.name.split("_")
        g1 = Gene.find_or_create_by(name: gene1)
        g2 = Gene.find_or_create_by(name: gene2)

        GeneRelation.create(gene_id: g1.id, interaction_id: interaction.id)
        GeneRelation.create(gene_id: g2.id, interaction_id: interaction.id)
      end      
    end

end
