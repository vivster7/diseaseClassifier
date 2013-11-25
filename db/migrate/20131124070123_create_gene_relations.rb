class CreateGeneRelations < ActiveRecord::Migration
  def change
    create_table :gene_relations do |t|
      t.integer :gene_id
      t.integer :interaction_id

      t.timestamps
    end
    add_index :gene_relations, :gene_id
    add_index :gene_relations, :interaction_id
  end
end
