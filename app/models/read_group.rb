class ReadGroup < ActiveRecord::Base
  belongs_to :run
  belongs_to :project

  has_many :gc_biases, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :insert_sizes, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :base_biases, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :coverage_depths, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :bed_coverages, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :duplicate_reads, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :duplicate_groups, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :alignment_metrics, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy
  has_many :library_complexities, inverse_of: :read_group, foreign_key: [:rg_id], dependent: :destroy

  validates_presence_of :library
  validates_presence_of :barcode
  validates_presence_of :sample

  after_destroy :check_if_run_has_read_groups

  def association_meta_data
    ReadGroup.reflect_on_all_associations(:has_many).map do |reflection|
      {
        class_name: reflection.plural_name,
        count: self.send(reflection.plural_name).size,
        button_text: "Delete #{reflection.plural_name.gsub('_', ' ').split.map(&:capitalize).join(' ')}"
      }
    end
  end

  def check_if_run_has_read_groups
    if run && run.read_groups.count == 1
      run.destroy
    end
  end

  def self.update_project_name(old_name, new_name)
    ReadGroup.where('project = ?', old_name).update_all(project: new_name)
  end

  def self.destroy_all_associations(params_id)
    read_group = ReadGroup.find(params_id)
    ReadGroup.reflect_on_all_associations(:has_many).map(&:name).each do |association|
      read_group.send(association).delete_all
    end
  end
end