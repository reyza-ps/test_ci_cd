class CreateOcpiDisplayTexts < ActiveRecord::Migration[7.0]
  def change
    create_table :ocpi_display_texts, id: :uuid do |t|
      t.string :language
      t.text :text
      t.uuid :displaytextable_id
      t.string :displaytextable_type

      t.timestamps
    end
  end
end