# https://patilshekhar900.medium.com/how-to-create-has-many-belongs-to-association-for-existing-models-b3f5232798c7
class AddUserToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :user
  end
end
