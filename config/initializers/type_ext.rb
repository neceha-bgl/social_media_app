module TypeExt
  if instance_methods.include?(:to_bool)
    raise "Method :to_bool exits, Social Media App will not override!"
  end
 
  def to_bool
    raise ArgumentError.new("to_bool must be implemented in #{self.class.name} Class")
  end
end

class String
  include TypeExt 
 
  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end
end

class NilClass
  include TypeExt 

  def to_bool
    return false
  end
end
