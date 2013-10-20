module Core
  def Core.included(mod)
    def development?
      RUBYMOTION_ENV == "development"
    end

    def release?
      !development?
    end  
  end
end