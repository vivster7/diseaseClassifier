class Gene < ActiveRecord::Base
  has_many :gene_relations
  has_many :interactions, through: :gene_relations
  
  private

    #gene_class is a string or symbol
    def self.findNewGenes(gene_class, cutoff)
      assoc_gene_list = self.findAssociatedGenes(gene_class)
      new_gene_list = self.filterAssociatedGenes(assoc_gene_list, gene_class)
      return self.filterNewGenes(new_gene_list, cutoff)
    end

    def self.findAssociatedGenes(gene_class)
      assoc_gene_list = []
      gene_class = gene_class.to_sym
      self.where(gene_class => 1.0).each do |bone_gene|
        bone_gene.interactions.each do |interaction|
          interaction.genes.each do |assoc_gene|
            assoc_gene_list << assoc_gene
          end
        end
      end
      return assoc_gene_list
    end

    def self.filterAssociatedGenes(assoc_gene_list, gene_class)
      gene_class = gene_class.to_s
      new_gene_list = assoc_gene_list.select { |gene| gene[gene_class].nil? }
      return new_gene_list
    end

    #TODO: Optimize
    #Param: cuttoff is an int
    def self.filterNewGenes(new_gene_list, cutoff)
      '''This method will only return genes that occur in new_gene_list
      more than "cutoff" times. Its intended to find the most signifigant genes.'''
      filtered_new_gene_dict = {}
      new_gene_list.each do |gene|
        filtered_new_gene_dict[gene.name] = filtered_new_gene_dict[gene.name].to_i.succ
      end
      
      filtered_new_gene_dict.keys().each do |gene_name|
        filtered_new_gene_dict.delete(gene_name) if filtered_new_gene_dict[gene_name].to_i < cutoff
      end
      return filtered_new_gene_dict
    end

    def self.initFromExcel(pathToExcelSheet)
      s = Roo::Excelx.new(pathToExcelSheet)
      first_col, last_col, first_row, last_row = s.first_column, s.last_column, s.first_row, s.last_row
      gene_symbol_column = 3
      class_column = 6

      (first_row+1..last_row).each do |row|
        genes = s.cell(row, gene_symbol_column)
        if genes
          genes = genes.strip().split(', ')
          gene_class = s.cell(row, class_column) || 'not_a_method'
          gene_class = gene_class.downcase.to_sym

          gene_name = genes[0]
          g = Gene.find_or_create_by(name: gene_name) 
          if Gene.method_defined? (gene_class)
            g.update_attribute(gene_class, 1)
          end

        end
      end
    end

end
