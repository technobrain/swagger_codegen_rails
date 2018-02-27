module SwaggerCodegenRails
  class Parameter < Struct.new(:name,
                               :in,
                               :type,
                               :required)

    def map_params(str)
      params = devide(str)
      self.each_with_index do |_v, i|
        self[i] = params[i].blank? ? "TODO" : params[i]
      end
    rescue IndexError => e
      logger.error e
      logger.error e.backtrace.join("\n")
      return nil
    end

    def devide(arg_str)
      arg_str.split(":", 4)
    end
  end
end
