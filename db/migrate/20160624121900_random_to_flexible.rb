class RandomToFlexible < ActiveRecord::Migration
  def up
    Question.where(regularity: 'random').update_all(regularity: 'flexible')
  end

  def down
    Question.where(regularity: 'flexible').update_all(regularity: 'random')
  end
end
