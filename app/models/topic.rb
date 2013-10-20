class Topic 
  include MotionModel::Model
  include MotionModel::ArrayModelAdapter  

  columns :name => :string
end