class ChangeStatusTypeInTasks < ActiveRecord::Migration[7.0]
  def change
    change_table :tasks do |t|
      t.change :status, :integer
    end
  end
end
