class CreateGenes < ActiveRecord::Migration
  def change
    create_table :genes do |t|
      t.string :name, uniq: true
      t.float :bone
      t.float :cancer
      t.float :cardiovascular
      t.float :connective_tissue
      t.float :dermatological
      t.float :ear_nose_throat
      t.float :endocrine
      t.float :gastrointestinal
      t.float :hematological
      t.float :immunological
      t.float :metabolic
      t.float :muscular
      t.float :neurological
      t.float :nutritional
      t.float :ophthamological
      t.float :psychiatric
      t.float :renal
      t.float :respiratory
      t.float :skeletal
      
      t.timestamps
    end
  end
end
