class Array
  unless self.instance_methods.include?(:sum)
    def sum
      inject(0, &:+)
    end
  end
end
